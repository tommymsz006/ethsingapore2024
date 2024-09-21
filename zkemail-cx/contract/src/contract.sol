pragma solidity >=0.8.13;

import "@zk-email/contracts/interfaces/IDKIMRegistry.sol";
import "@zk-email/contracts/utils/StringUtils.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./verifier.sol";

contract Contract is Ownable {
    // ============================
    // Dependent Contracts
    // ============================
    IDKIMRegistry public dkimRegistry;
    Groth16Verifier public verifier;

    // ============================
    // Prover Constants (Auto-generated)
    // ============================
    uint16 public constant pack_size = 31;
    uint16 public constant pubkey_hash_len = 1;
    string public constant domain = "cathaypacific.com";

    uint16 public constant bookingRef_len = 3;



    // ============================
    // Nullifier
    // ============================
    // mapping (string => bool) public nullifiers;    

    constructor (IDKIMRegistry r, Groth16Verifier v) Ownable(msg.sender) {
        dkimRegistry = r;
        verifier = v;
    }

    function verify(uint[2] calldata a, uint[2][2] calldata b, uint[2] calldata c, uint[4] calldata signals) external {
        // verify RSA
        bytes32 ph = bytes32(signals[0]);
        require(dkimRegistry.isDKIMPublicKeyHashValid(domain, ph), "RSA public key incorrect");

        // unpack bookingRef
        uint[] memory packed_bookingRef = new uint[](bookingRef_len);
        for (uint i = 0; i < bookingRef_len; i++) {
            packed_bookingRef[i] = signals[1 + i];
        }
        string memory bookingRef_string = StringUtils.convertPackedBytesToString(packed_bookingRef, pack_size * bookingRef_len, pack_size); 




        // require(!nullifiers[handleString], "Unique handle required");

        // verify proof
        require(verifier.verifyProof(a,b,c,signals));
        // nullifiers[handleString] = true;
    }
}