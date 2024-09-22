import { useWeb3React } from "@web3-react/core";
import { useState } from "react";
import { Divider, Typography } from "antd";
const { Title } = Typography;

import { useWindowSize } from "hooks";

import { Button, message, Steps, theme } from 'antd';

import { Infos, SignMessage, Status, TransferEth, Verify, DropEmail } from "./components";


const stepItems = [
  { key: 'drop-email', title: 'Drop Email' },
  { key: 'verify-details', title: 'Verify Details' },
  { key: 'prove-personhood', title: 'Prove Personhood' },
  { key: 'claim-mileage', title: 'Claim Mileage' },
  { key: 'reimburse', title: 'Reimburse Travel Expense' },
];

const styles = {
  container: {
    width: "80%",
    minWidth: "330px",
    maxWidth: "900px",
    textAlign: "center",
    margin: "auto",
    padding: "20px 0",
    borderRadius: "10px",
    boxShadow: "0px 0px 30px 30px rgba(30, 136, 229, 0.2)"
  },
  content: {
    width: "85%",
    margin: "auto",
    fontSize: "17px"
  },
  action: {
    display: "inline-flex",
    flexWrap: "wrap",
    justifyContent: "center",
    gap: "20px"
  }
} as const;

type DisplayPaneProps = {
  isDarkMode: boolean;
};

const DisplayPane: React.FC<DisplayPaneProps> = ({ isDarkMode }) => {
  const { chainId, isActivating, isActive } = useWeb3React();
  const { isTablet } = useWindowSize();
  
  const [current, setCurrent] = useState(0);
  
  const nextStep = () => {
    setCurrent(current + 1);
  };

  const prevStep = () => {
    setCurrent(current - 1);
  };

  return (
    <div
      style={{
        ...styles.container,
        border: isDarkMode ? "1px solid rgba(152, 161, 192, 0.24)" : "none",
        width: isTablet ? "90%" : "80%"
      }}
    >
      <Steps current={current} items={stepItems} />
      <Divider />

        {current === 0 && (
          <>
            <DropEmail />
            <Verify />
          </>
        )}
        {current > 0 && (
          <Button style={{ margin: '0 8px' }} onClick={() => prevStep()}>
            ◀️ Previous
          </Button>
        )}
        <span></span>
        {current < stepItems.length - 1 && (
          <Button type="primary" onClick={() => nextStep()}>
            Next ▶️
          </Button>
        )}
        <span></span>
        {current === stepItems.length - 1 && (
          <Button type="primary" onClick={() => message.success('Processing complete!')}>
            ✅ Done
          </Button>
        )}
    </div>
  );
};

export default DisplayPane;
