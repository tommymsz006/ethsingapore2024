import { FC, ReactElement } from "react";

import { Button, message } from "antd";

import { useWeb3React } from "@web3-react/core";
import { useSignerOrProvider, useCXTicketVerifier } from "hooks";

import { IDKitWidget, ISuccessResult } from '@worldcoin/idkit';

import worldcoin_Logo from "assets/svg/worldcoin_Logo.svg";

const styles = {
  buttonVerify: {
    margin: "15px auto"
  }
} as const;

const Verify: FC = (): ReactElement => {
  const [, contextHolder] = message.useMessage();
  const { account } = useWeb3React();
  return (
    <>
      {contextHolder}
      <div style={{ width: "40%", minWidth: "250px" }}>
        <IDKitWidget
            app_id={process.env.REACT_APP_WORLDCOIN_APP_ID as unknown as `app_${string}` || 'app_'} // must be an app set to on-chain in Developer Portal
            action={process.env.REACT_APP_WORLDCOIN_ACTION_CLAIM_MILEAGE || ''}
            signal={account} // proof will only verify if the signal is unchanged, this prevents tampering
            //handleVerify={handleVerify} // use handleVerify before showing success screen / widget being closed
            onSuccess={onSuccess} // use onSuccess to call your smart contract
            // no use for handleVerify, so it is removed
            // use default verification_level (orb-only), as device credentials are not supported on-chain
        >
            
            {({ open }) => 
              <Button type="primary" shape="round" style={styles.buttonVerify} onClick={open}>
                <img src={worldcoin_Logo} width={32} height={32} alt="worldcoin" />
                Verify with World ID
              </Button>
            }
            
        </IDKitWidget>
      </div>
    </>
  );
};

/*
const handleVerify = async(successResult: ISuccessResult) => {
  try {
    // send request to backend and wait for the response
    const backendUrl: string = process.env.REACT_APP_BACKEND || '';
    const response = await fetch(`backendUrl/api/verify`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(successResult)
    })
    if (!response.ok){
        // server returned a status code other than 200-299 --> something went wrong
    }
  } catch (error) {
      // an error occured
  }
}
*/

const onSuccess = async(result: ISuccessResult) => {
  const { provider, signer } = useSignerOrProvider();
  const { loading, verifyProofAndExecute } = useCXTicketVerifier();
  const { success } = await verifyProofAndExecute(result);

  console.log('Success');
};

export default Verify;