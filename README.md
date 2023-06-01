# EthBG War room defisaver <> tenderly

## Setup guide

1. Run `npm i` or `yarn` in the project directory
2. `npx hardhat compile` - to compile the smart contracts
3. `npx hardhat run scripts/deploy.js` - specify network in hardhat config and in command to deploy to different network
4. `npx hardhat test ./test/[TEST_NAME]` - to run a specific test

## Challenge guide

There are in total 5 different challenges, they are ordered by their difficulty and each challenge has certain points assoicated with it, the goal is to get all 42 points.

---

### 1. EthBgMessageBoard (Reward - 4 points)

*The challenge is to successfully call the sayHello method on this contract*

> Hint: Nothing is private on Ethereum

Solution: Can be found in the test, the idea is for the hacker to first call `changeOwner()` with his address, and then call the `sayHello()` method with the password which they can find in the contract creation tx or by reading the first memory slot of the contract.

---

### 2. OwnIt ( Reward - 8 points)

*To solve this challenge you will need to change the owner of this contract to 0x000000000000000000000000000000000000dEaD*

> Hint: How do constructors work?

Solution: The solution can be found in `OwnItSolution.sol`, the hacker will need to overcome the `isNotContract` check, by creating a smart contract which will call it in the constructor (when the code size check is still 0). Then the owner will be the smart contract which will be able to call the second `changeOwner(address _owner)` with the `0x000000000000000000000000000000000000dEaD` address.

---

### 3. LendingProtocol ( Reward - 8 points)
* To solve this challenge you will need to drain LendingProtocolToken from this contract*

> Hint: Hey did you remember to return that flashloan?

Solution:
The solution can be found in `LendingProtocolSolution.sol`, the hacker needs to create a smart contract that will take out a flashloan of the whole balance of the contract, on the callback function `onFlashLoan` he would supply that amount back to the protocol to pass the flashloan balance check, after that the user can withdraw the tokens.

---

### 4. TimeTheTimer ( Reward - 10 points)

*To solve this challenge you will need to successfully call the solve method on this contract*

> Hint: Abi.encode can be hard sometimes

Solution: The solution can be found in `TimeTheTimerSolution.sol`, the hacker needs to create a new smart contract that will properly encode the "solve(uint256)" call, the helper function `getCalldata` returns a false value because of using `uint` instead of `uint256`. The hacker needs to figure out the correct path in the `fallback` function where he will format a call such that the first 4 bytes are != this.solve.selector and the next 4 bytes are equal to the call selector.

---

### 5. HoneyProxy ( Reward - 12)
*The challenge is to drain all ether from this contract*

> Hint: We should try TheDAO again what could go wrong this time

Solution: The solution can be found in `HoneyProxySolution.sol`, the hacker needs to create a smart contract that will deposit and then call withdraw. The contract has to have a fallback function implemented, which will call the `changeOwner()` function and set to 1, because of the delegatecall that will overwrite the implementation guard check, and we can use the re-entrancy attack to drain the contract.

---

