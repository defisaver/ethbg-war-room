const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TimeTheTimer", function () {
  it("Should solve TimeTheTimer task", async function () {
    const TimeTheTimer = await ethers.getContractFactory("TimeTheTimer");
    const timeTheTimer = await TimeTheTimer.deploy();
    await timeTheTimer.deployed();

    expect(await timeTheTimer.isSolved()).to.equal(false);

    const TimeTheTimerSolution = await ethers.getContractFactory("TimeTheTimerSolution");
    const timeTheTimerSolution = await TimeTheTimerSolution.deploy(timeTheTimer.address);
    await timeTheTimerSolution.deployed();

    await timeTheTimerSolution.solve();

    expect(await timeTheTimer.isSolved()).to.equal(true);
  });
});
