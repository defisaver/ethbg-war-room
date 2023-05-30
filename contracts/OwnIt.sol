// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OwnIt {

    address owner;
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function.");
        _;
    }

    constructor(){
    }

    function changeOwner() public {
        (bool success, ) = msg.sender.call{ value: address(this).balance }("");
        require(success);
        owner = msg.sender;
    }

    function changeOwner(address _owner) public onlyOwner {
        require(!isNotContract(msg.sender));
        owner = _owner;
    }

    function isNotContract(address testAddress) public view returns (bool) {
        uint256 codeSize;
        assembly {
            codeSize := extcodesize(testAddress)
        }
        return codeSize == 0;
    }

    function isSolved() public view returns (bool) {
        return owner == 0x000000000000000000000000000000000000dEaD;
    }

}