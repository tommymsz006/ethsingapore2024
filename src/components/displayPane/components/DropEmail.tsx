import { FC, ReactElement } from "react";

import { useWeb3React } from "@web3-react/core";
import { Upload, message } from "antd";

import { InboxOutlined } from '@ant-design/icons';

import { useNativeBalance, useWriteContract } from "hooks";
import { getEllipsisTxt, parseBigNumberToFloat } from "utils/formatters";

import { groth16 } from "snarkjs";

import { generateCircuitInputs } from "../../../utils/generate_inputs";
import { readFile } from "fs";

const styles = {
  buttonTransfer: {
    display: "flex",
    margin: "15px 0"
  }
} as const;

const DropEmail: FC = (): ReactElement => {
  const [, contextHolder] = message.useMessage();
      
  const beforeUpload = async(file: any) => {

      const rawEmail: string = await file.text();
      const inputs = await generateCircuitInputs(rawEmail);
      console.log(await groth16.fullProve(inputs, "cx.wasm", "cx_0001.zkey"));
      //const { proof: Groth16Proof, publicSignals: PublicSignals } = await groth16.fullProve(inputs, "cx.wasm", "cx_0001.zkey");
      //console.log(proof);
      //console.log(JSON.stringify(proof));
      // TODO: handle proof and publicSignals
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
      <div style={{ width: "40%", minWidth: "250px" }}>
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
