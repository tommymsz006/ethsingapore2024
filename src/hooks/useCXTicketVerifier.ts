import { BigNumberish, Signer } from "ethers";

import CXTicketVerifierAbi from "data/abi/CXTicketVerifier.json";
import { CXTicketVerifier } from "data/abi/types";
import { CXTicketVerifier__factory } from "data/abi/types/factories";

import { useCallback, useState } from "react";

import { ISuccessResult } from '@worldcoin/idkit';

import { useSignerOrProvider } from "./useSignerOrProvider";

export const useCXTicketVerifier = () => {
  const signer: Signer | undefined = useSignerOrProvider().signer;
  const [loading, setLoading] = useState<boolean>(false);

  // Verify input confirmation email
  const ticketVerifyProof = useCallback(
    async (
      pA: [BigNumberish, BigNumberish],
      pB: [
          [BigNumberish, BigNumberish],
          [BigNumberish, BigNumberish]
      ],
      pC: [BigNumberish, BigNumberish],
      pubSignals: [
          BigNumberish,
          BigNumberish,
          BigNumberish,
          BigNumberish
      ]
    ): Promise<{ success: boolean }> => {
      setLoading(true);
      try {
        console.log(JSON.stringify(signer));
        if (signer) {
          // create a new contract instance with our abi
          const cXTicketVerifier: CXTicketVerifier = CXTicketVerifier__factory.connect(
            process.env.REACT_APP_CX_TICKET_VERIFIER_ADDRESS || '',
            signer
          );
      
          const success: boolean = await cXTicketVerifier.ticketVerifyProof(pA, pB, pC, pubSignals);
          return { success };
        } else {
          return { success: false };
        }
      } catch (error: any) {
        //const message = error.reason ?? error.message ?? error;
        return { success: false };
      } finally {
        setLoading(false);
      }
    },
    [signer]
  );


  // Verify input confirmation email
  const verifyProofAndExecute = useCallback(
    async (
      result: ISuccessResult
    ): Promise<{ success: boolean }> => {
      setLoading(true);
      try {
        console.log(JSON.stringify(signer));
        if (signer) {
          // create a new contract instance with our abi
          const cXTicketVerifier: CXTicketVerifier = CXTicketVerifier__factory.connect(
            process.env.REACT_APP_CX_TICKET_VERIFIER_ADDRESS || '',
            signer
          );
      
          await cXTicketVerifier.verifyProofAndExecute([0,0], [[0,0], [0,0]], [0,0], [0,0,0,0],
            '0', result.merkle_root, result.nullifier_hash, result.proof);
          return { success: true };
        } else {
          return { success: false };
        }
      } catch (error: any) {
        //const message = error.reason ?? error.message ?? error;
        return { success: false };
      } finally {
        setLoading(false);
      }
    },
    [signer]
  );

  return {
    loading,
    ticketVerifyProof,
    verifyProofAndExecute
  };

};
