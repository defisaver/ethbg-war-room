// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {

  // We get the contract to deploy
  const EthBg = await hre.ethers.getContractFactory("EthBgMessageBoard");
  const EthBgContract = await EthBg.deploy("Hello, Hardhat!");
  await EthBgContract.deployed();

  console.log("EthBgMessageBoard deployed to:", EthBgContract.address);

  // We get the contract to deploy
  const OwnIt = await ethers.getContractFactory("OwnIt");
  const ownItContract = await OwnIt.deploy();
  await ownItContract.deployed();

  console.log("OwnIt deployed to:", ownItContract.address);

  const LendingProtocol = await ethers.getContractFactory("LendingProtocol");
  const lendingProtocol = await LendingProtocol.deploy();
  await lendingProtocol.deployed();

  const LendingProtocolToken = await ethers.getContractFactory("LendingProtocolToken");
  const lendingProtocolToken = await LendingProtocolToken.deploy(lendingProtocol.address);
  await lendingProtocolToken.deployed();

  console.log("LendingProtocol deployed to:", lendingProtocol.address);

  const TimeTheTimer = await ethers.getContractFactory("TimeTheTimer");
  const timeTheTimer = await TimeTheTimer.deploy();
  await timeTheTimer.deployed();

  console.log("TimeTheTimer deployed to:", timeTheTimer.address);

  const Implementation = await ethers.getContractFactory("Implementation");
  const implementationContract = await Implementation.deploy();
  await implementationContract.deployed();
  const HoneyProxy = await ethers.getContractFactory("HoneyProxy");
  const honeyProxyContract = await HoneyProxy.deploy(implementationContract.address, { value: ethers.utils.parseUnits('100')});
  await honeyProxyContract.deployed();

  console.log("HoneyProxy deployed to:", honeyProxy.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
