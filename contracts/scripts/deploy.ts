import { ethers, network } from "hardhat";

/*
// this is for the latest ethers
async function deployContract(name: string, args?: any[]): Promise<any> {
  console.log(`Deploying ${name}...`);
  const contractInstance = await (args ? ethers.deployContract(name, args) : ethers.deployContract(name));
  await contractInstance.waitForDeployment();
  console.log(`${name} is deployed at ${contractInstance.target} on the network ${network.name}.`);
  return contractInstance;
}
*/
// this is for ethers v5
async function deployContract(name: string, args?: any[]): Promise<any> {
  console.log(`Deploying ${name}...`);
  const contractFactory = await ethers.getContractFactory(name);
  const contractInstance = await (args ? contractFactory.deploy(...args) : contractFactory.deploy());
  await contractInstance.deployed();
  console.log(`${name} is deployed at ${contractInstance.address} on the network ${network.name}.`);
  return contractInstance;
}

async function main() {
  const worldIdAddress = process.env.WORLD_ID_ROUTER_ADDRESS;
  console.log(`WorldID is located at ${worldIdAddress} on the network ${network.name}.`);

  const verifier = await deployContract('CXTicketVerifier', [worldIdAddress, process.env.WORLDCOIN_APP_ID, process.env.WORLDCOIN_ACTION]);

/*
  if (entryPointAddress && verifier) {
    await deployContract('TappifyAccountFactory', [entryPointAddress, '0x72171017db02Fb8F9E2b55819b13E770E3265169', '0x5c311E29A5677e31f79BFBF030A11F4FA7a07Bc3', '0xE4584814F480d9e$
  }
*/
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

