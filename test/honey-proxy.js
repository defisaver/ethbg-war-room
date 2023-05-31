const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("HoneyProxy", function () {
  it("Should solve HoneyProxy task", async function () {
    const Implementation = await ethers.getContractFactory("Implementation");
    const implementationContract = await Implementation.deploy();
    await implementationContract.deployed();

    const HoneyProxy = await ethers.getContractFactory("HoneyProxy");
    const honeyProxyContract = await HoneyProxy.deploy(implementationContract.address, { value: ethers.utils.parseUnits('100')});
    await honeyProxyContract.deployed();

    expect(await ethers.provider.getBalance(honeyProxyContract.address)).to.be.gt(0);

    expect(await honeyProxyContract.isSolved()).to.equal(false);

    const HoneyProxySolution = await ethers.getContractFactory("HoneyProxySolution");
    const honeyProxySolutionContract = await HoneyProxySolution.deploy(honeyProxyContract.address);
    await honeyProxySolutionContract.deployed();

    await honeyProxySolutionContract.solve({ value: ethers.utils.parseUnits('3') });

    expect(await honeyProxyContract.isSolved()).to.equal(true);
  });
});
