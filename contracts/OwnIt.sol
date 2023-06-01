// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title OwnIt - Contract which you must solve
/// @dev To solve this challenge you will need to change the owner of this contract to 0x000000000000000000000000000000000000dEaD
contract OwnIt {

    address public owner;
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function.");
        _;
    }

    /// @notice Change the owner of the contract to msg.sender
    /// @dev can only be called by an EOA
    function changeOwner() public {
        require(isNotContract(msg.sender));
        (bool success, ) = msg.sender.call{ value: address(this).balance }("");
        require(success);
        owner = msg.sender;
    }

    /// @notice Change the owner of the contract to a specific address
    /// @dev can only be called by the current owner which is smart contract
    function changeOwner(address _owner) public onlyOwner {
        require(!isNotContract(msg.sender));
        owner = _owner;
    }
    /// @notice helper function to check if the address is a contract or not
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