//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title EthBgMessageBoard - Contract for conference organizers to send announcements to attendees
contract EthBgMessageBoard {
    string private password;
    address private owner;

    event Hello(address sender, string message);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    constructor(string memory _password) {
        owner = msg.sender;
        password = _password;
    }

    /// @notice Send a message to all attendees
    /// @dev Only the owners of the contract can make an annoucmement
    /// @param _password Password protected so not anyone can make an announcement
    /// @param _message Message to be sent to all attendees
    function sayHello(string memory _password, string memory _message) public onlyOwner {
        require(keccak256(abi.encode(_password)) == keccak256(abi.encode(password)), "Wrong password.");
        emit Hello(msg.sender, _message);
    }

    /// @notice Change the owner of the contract
    function changeOwner(address _owner) public {
        require(msg.sender == _owner, "Only owner can call this function.");
        owner = _owner;
    }

}
