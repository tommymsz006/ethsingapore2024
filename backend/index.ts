import express, { Express, Request, Response } from "express";
import asyncHandler from "express-async-handler";
import dotenv from "dotenv";
import { verifyCloudProof, IVerifyResponse } from "@worldcoin/idkit";
import("@worldcoin/idkit");

dotenv.config();

const app: Express = express();
const port = process.env.PORT || 4000;

app.get("/", (req: Request, res: Response) => {
  res.send("Express + TypeScript Server");
});

app.use(express.json());

app.post('/api/verify', asyncHandler(async (req, res, next) => {
  let verifyRes: IVerifyResponse = { success: false };
  if (req.body) {
      const { proof, signal } = req.body.json();
      const appId: `app_${string}` = (process.env.WORLDCOIN_APP_ID as unknown || 'app_') as `app_${string}`;
      const action: string = process.env.WORLDCOIN_ACTION_CLAIM_MILEAGE || '';
      verifyRes = (await verifyCloudProof(proof, appId, action, signal)) as IVerifyResponse;

  }
  if (verifyRes.success) {
    res.status(200).send(verifyRes);
  } else {
    res.status(400).send(verifyRes);
  }
}))

app.listen(port, () => {
  console.log(`[server]: Server is running at http://localhost:${port}`);
});
