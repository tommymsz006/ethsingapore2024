import { FC, ReactElement } from "react";

import { Button, message } from "antd";

import { useWeb3React } from "@web3-react/core";

import { IDKitWidget } from '@worldcoin/idkit';

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
            app_id="app_staging_6b1d1463ef75f0a8e198380169f843e9" // must be an app set to on-chain in Developer Portal
            action="claim-mileage"
            signal={account} // proof will only verify if the signal is unchanged, this prevents tampering
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

const onSuccess = () => {
  // This is where you should perform any actions after the modal is closed
  // Such as redirecting the user to a new page
  //window.location.href = "/success";
  console.log('Success');
};

export default Verify;