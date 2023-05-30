const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("LendingProtocol", function () {
  it("Should solve LendingProtocol task", async function () {
    const LendingProtocol = await ethers.getContractFactory("LendingProtocol");
    const lendingProtocol = await LendingProtocol.deploy();
    await lendingProtocol.deployed();

    const LendingProtocolToken = await ethers.getContractFactory("LendingProtocolToken");
    const lendingProtocolToken = await LendingProtocolToken.deploy(lendingProtocol.address);
    await lendingProtocolToken.deployed();


    const LendingProtocolSolution = await ethers.getContractFactory("LendingProtocolSolution");
    const lendingProtocolSolution = await LendingProtocolSolution.deploy(lendingProtocol.address);
    await lendingProtocolSolution.deployed();

    await lendingProtocolSolution.solveFirstHalf();
    await lendingProtocolSolution.solveSecondHalf();

    expect(await lendingProtocolSolution.isSolved()).to.equal(true);
  });
});
