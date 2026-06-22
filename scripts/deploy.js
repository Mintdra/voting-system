import hre from "hardhat";

async function main() {
  console.log("Deploying Voting contract...");

  // 1. Establish the network connection dynamically (Hardhat 3 standard)
  const connection = await hre.network.create();
  const { ethers } = connection;

  // 2. Retrieve your contract factory from the connection
  const Voting = await ethers.getContractFactory("Voting");
  
  // 3. Deploy the contract
  const voting = await Voting.deploy();

  // 4. Wait for deployment to complete
  await voting.waitForDeployment();

  console.log(`Voting contract successfully deployed to: ${await voting.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});