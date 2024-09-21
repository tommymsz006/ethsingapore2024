#!/bin/bash

# exit when any command fails
set -e

for CIRCOM_FILE in "$@"; do

  CIRCOM_BASE_FILE="$(basename "$CIRCOM_FILE")"
  MAIN="${CIRCOM_BASE_FILE%.*}"
  TARGET="./build_${MAIN}"
  PARAMS='--max-old-space-size=1536000 --initial-old-space-size=1536000 --no-global-gc-scheduling --no-incremental-marking --max-semi-space-size=1024 --initial-heap-size=1536000'
  SNARKJS=`which snarkjs`
  USERNAME=`id -F`
  INCLUDE_FOLDER='./node_modules'
  INPUT="./inputs/input_${MAIN}.json"
  POT_FILE="./pot/powersOfTau28_hez_final_22.ptau"
  PROVING_SYSTEM="groth16"

  echo "**** 1. Recreating build directory (${TARGET})..."
  rm -fr "$TARGET"
  mkdir -p "$TARGET"

  echo "**** 2. Compiling circom circuit (${MAIN})..."
  circom "$CIRCOM_FILE" -l "$INCLUDE_FOLDER" --verbose --r1cs --wasm --output "$TARGET"

  echo "**** 3. Setting up ${PROVING_SYSTEM} and generating ${MAIN}_0000.zkey..."
  node ${PARAMS} "$SNARKJS" "${PROVING_SYSTEM}" setup --verbose "$TARGET/$MAIN.r1cs" "$POT_FILE" "$TARGET/${MAIN}_0000.zkey"

  if [[ "$PROVING_SYSTEM" = "groth16" ]]; then
    echo "**** 3a. Contributing for second phase (${MAIN}_0001.zkey)..."
    node ${PARAMS} "$SNARKJS" zkey contribute --verbose "$TARGET/${MAIN}_0000.zkey" "$TARGET/${MAIN}_0001.zkey" --name="$USERNAME" --entropy=`openssl rand -base64 24`
    rm -f  "$TARGET/${MAIN}_0000.zkey"
  else
    mv "$TARGET/${MAIN}_0000.zkey" "$TARGET/${MAIN}_0001.zkey"
  fi

  echo "**** 4. Exporting verification keys based on the second phase (${MAIN}_0001.zkey)..."
  node ${PARAMS} "$SNARKJS" zkey export verificationkey --verbose "$TARGET/${MAIN}_0001.zkey" "$TARGET/verification_key.json"

  echo "**** 5. Validating the compiled circuit..."
  if [ -f "$INPUT" ]; then
    echo "----**** 5.1. Computing witness based on inputs (${INPUT})..."
    node ${PARAMS} "$TARGET/${MAIN}_js/generate_witness.js" "$TARGET/${MAIN}_js/$MAIN.wasm" "$INPUT" "$TARGET/witness.wtns"

    echo "----**** 5.2. Generating proof based on the witness..."
    node ${PARAMS} "$SNARKJS" "$PROVING_SYSTEM" prove --verbose "$TARGET/${MAIN}_0001.zkey" "$TARGET/witness.wtns" "$TARGET/proof.json" "$TARGET/public.json"

    echo "----**** 5.3. Verifying the given proof..."
    node ${PARAMS} "$SNARKJS" "$PROVING_SYSTEM" verify --verbose "$TARGET/verification_key.json" "$TARGET/public.json" "$TARGET/proof.json" 

    echo "----**** 5.4. Exporting solidity contract..."
    node ${PARAMS} "$SNARKJS" zkey export solidityverifier --verbose "$TARGET/${MAIN}_0001.zkey"  "$TARGET/verifier.sol"

    echo "----**** 5.5. Generating call for remix..."
    node ${PARAMS} "$SNARKJS" generatecall "$TARGET/public.json" "$TARGET/proof.json"
  fi

done
