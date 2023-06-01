const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("EthBgMessageBoard", function () {

  const password = "idegas123";

  it("Should solve EthBgMessageBoard task", async function () {

    const MessageBoard = await ethers.getContractFactory("EthBgMessageBoard");
    let messageBoardContract = await MessageBoard.deploy(password);
    await messageBoardContract.deployed();

    let senderAcc2 = (await hre.ethers.getSigners())[1];

    messageBoardContract = messageBoardContract.connect(senderAcc2);

    await messageBoardContract.changeOwner(senderAcc2.address);

    await messageBoardContract.sayHello(password, "Hello World!")

    expect(await messageBoardContract.isSolved()).to.equal(true);

  });

  it("Should fail to solve because owner not set", async function () {
    const MessageBoard = await ethers.getContractFactory("EthBgMessageBoard");
    let messageBoardContract = await MessageBoard.deploy(password);
    await messageBoardContract.deployed();

    let senderAcc2 = (await hre.ethers.getSigners())[1];

    messageBoardContract = messageBoardContract.connect(senderAcc2);

    try {
      await messageBoardContract.sayHello(password, "Hello World!")
    } catch (err) {
    }

    expect(await messageBoardContract.isSolved()).to.equal(false);
  });

  it("Should fail to solve because wrong password", async function () {
    const MessageBoard = await ethers.getContractFactory("EthBgMessageBoard");
    let messageBoardContract = await MessageBoard.deploy(password);
    await messageBoardContract.deployed();

    let senderAcc2 = (await hre.ethers.getSigners())[1];

    messageBoardContract = messageBoardContract.connect(senderAcc2);

    await messageBoardContract.changeOwner(senderAcc2.address);

    try {
      await messageBoardContract.sayHello("neidegas123", "Hello World!")
    } catch (err) {
    }

    expect(await messageBoardContract.isSolved()).to.equal(false);
  });



});
