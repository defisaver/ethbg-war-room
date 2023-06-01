// SPDX-License-Identifier: MIT
pragma solidity =0.8.10;


contract TimeTheTimerSolution {
    address timer;

    constructor (address timerContract){
        timer = timerContract;
    }

    function solve() public {
        bytes memory solutionBytes = abi.encodeWithSignature("solve(uint256)", block.timestamp);
        timer.call(
            bytes.concat(
                bytes4(0xffffffff),
                solutionBytes
            )
        );
    }
}