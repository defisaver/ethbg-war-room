const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("OwnIt", function () {
  it("Should solve OwnIt task", async function () {
    const OwnIt = await ethers.getContractFactory("OwnIt");
    const ownItContract = await OwnIt.deploy();
    await ownItContract.deployed();

    expect(await ownItContract.isSolved()).to.equal(false);

    const OwnItSolution = await ethers.getContractFactory("OwnItSolution");
    const ownItSolutionContract = await OwnItSolution.deploy(ownItContract.address);
    await ownItSolutionContract.deployed();

    await ownItSolutionContract.solve();

    expect(await ownItContract.isSolved()).to.equal(true);
  });
});
