import { FC, ReactElement } from "react";

import { useWeb3React } from "@web3-react/core";
import { Upload, message } from "antd";

import { InboxOutlined } from '@ant-design/icons';

import { useCXTicketVerifier } from "hooks";

import { groth16 } from "snarkjs";

import { generateCircuitInputs } from "../../../utils/generate_inputs";

const styles = {
  buttonTransfer: {
    display: "flex",
    margin: "15px 0"
  }
} as const;

const DropEmail: FC = (): ReactElement => {
  const [, contextHolder] = message.useMessage();
  const { loading, ticketVerifyProof } = useCXTicketVerifier();
      
  const beforeUpload = async(file: any) => {

    console.log("Start loading the given inputs...");
    const rawEmail: string = await file.text();
    console.log("Done. Preparing the circuit inputs from the email...");
    const inputs = await generateCircuitInputs(rawEmail);
    console.log("Completed. Generating proof from DKIM parameters...");
    const { proof, publicSignals } = await groth16.fullProve(inputs, "cx.wasm", "cx_0001.zkey");
    console.log(proof);
    console.log(publicSignals);
    console.log("Completed. Verifying proof on-chain...");
    const { success } = await ticketVerifyProof(
      [proof.pi_a[0], proof.pi_a[1]],
      [[proof.pi_b[0][1], proof.pi_b[0][0]], [proof.pi_b[1][1], proof.pi_b[1][0]]],
      [proof.pi_c[0], proof.pi_c[1]],
      [publicSignals[0], publicSignals[1], publicSignals[2], publicSignals[3]]
    );

    // prevent upload
    return false;
  };

  /*
  const onChange = (info: any) => {
    const { status } = info.file;
    if (status === 'done') {
      //TODO: generate proof
      const inputs =  generateCircuitInputs();
      const { proof, publicSignals } = groth16.fullProve( , "cx.wasm", "cx0001.zkey");

    } else if (status === 'error') {
      message.error(`${info.file.name} file upload failed.`);
    }
  };
*/

  return (
    <>
      {contextHolder}
      <div style={{ width: "90%", minWidth: "600px" }}>
        <Upload beforeUpload={beforeUpload} showUploadList={false}>
            <p className="ant-upload-drag-icon">
                <InboxOutlined />
            </p>
            <p className="ant-upload-text">Drag your email to this area to begin</p>
            <p className="ant-upload-hint">
                Drag the ticket confirmation email from your email software/client
            </p>
        </Upload>
      </div>
    </>
  );
};

export default DropEmail;
