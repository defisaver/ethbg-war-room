// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IERC20.sol";
import "./interfaces/IERC3156FlashBorrower.sol";
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract LendingProtocolToken is ERC20 {

    // Define the supply of FunToken: 1,000,000 
    uint256 constant initialSupply = 1000000 * (10**18);

    // Constructor will be called on contract creation
    constructor(address lendingProtocolAddress) ERC20("HackMe", "HAX") {
        _mint(lendingProtocolAddress, initialSupply);
        LendingProtocol(lendingProtocolAddress).init();
    }
}



contract LendingProtocol is ReentrancyGuard{

    address owner;
    address public token;
    bool initialised;

    mapping(address => uint256) public supplied;

    mapping(address => uint256) public borrowed;

    constructor(){
        owner = msg.sender;
    }

    function init() public {
        require(!initialised);
        initialised = true;
        token = msg.sender;
    }

    function supply(uint256 _amount) public nonReentrant {
        require(IERC20(token).transferFrom(msg.sender, address(this), _amount));
        supplied[msg.sender] += _amount;
    }

    function borrow(uint256 _amount) public nonReentrant {
        borrowed[msg.sender] += _amount;
        require(borrowed[msg.sender] * 2 <= supplied[msg.sender]);
        require(IERC20(token).transfer(msg.sender, _amount));
    }

    function withdraw(uint256 _amount) public nonReentrant {
        supplied[msg.sender] -= _amount;
        require(borrowed[msg.sender] * 2 <= supplied[msg.sender]);
        require(IERC20(token).transfer(msg.sender, _amount));
    }
    
    function repay(uint256 _amount) public nonReentrant {
        borrowed[msg.sender] -= _amount;
        require(IERC20(token).transferFrom(msg.sender, address(this), _amount));
    }

    function flashloan(uint256 _amount) public {
        uint256 currBalance = IERC20(token).balanceOf(address(this));
        require(_amount <= currBalance);
        require(IERC20(token).transfer(msg.sender, _amount));
        IERC3156FlashBorrower(msg.sender).onFlashLoan(msg.sender, token, _amount, 0, "");
        uint256 balanceAfterFlashloan = IERC20(token).balanceOf(address(this));
        require (balanceAfterFlashloan == currBalance);
    }

    function isSolved() public view returns (bool) {
        uint256 currContractBalance = IERC20(token).balanceOf(address(this));

        return (currContractBalance == 0);
    }

}