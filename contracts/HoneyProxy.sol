// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

/// @dev The challenge is to drain all ether from this contract
contract HoneyProxy {
    address public owner;
    address public implementation;

    constructor(address _implementation) payable {
        require(msg.value > 0);
        implementation = _implementation;
        owner = msg.sender;
    }

    function changeOwner(address _owner) external {
        owner = _owner;
    }

    function _fallback() internal {
        (bool success,) = implementation.delegatecall(msg.data);
        require(success);
    }

    fallback() external payable {
        _fallback();
    }

    receive() external payable {
        _fallback();
    }

    function isSolved() external view returns (bool) {
        return address(this).balance == 0;
    }
}

contract Implementation {
    uint256 public guard = 1;

    mapping(address => uint256) public balances;

    modifier nonreentrant() {
        if (guard == 0) revert();
        uint256 oldguard = guard;
        guard = 0;
        _;
        guard = oldguard;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) external nonreentrant {
        require(balances[msg.sender] >= _amount);
        (bool success, ) = msg.sender.call{ value: _amount}("");
        require(success);
        balances[msg.sender] -= _amount;
    }
}
