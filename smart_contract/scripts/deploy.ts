import { ethers } from "hardhat";

async function main() {
  const GroupManagement = await ethers.getContractFactory("GroupManagement");
  const groupManagement = await GroupManagement.deploy();
  await groupManagement.deployed();
  console.log("GroupManagement contract is deployed to: ", groupManagement.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
