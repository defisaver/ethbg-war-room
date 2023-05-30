//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/*
contract BaseERC20 {
    constructor() public {}

    function transferWithSig(
        bytes calldata sig,
        uint256 amount,
        bytes32 data,
        uint256 expiration,
        address to
    ) external returns (address from) {
	revert("Disabled feature");
    }

    function balanceOf(address account) external view returns (uint256);
    function _transfer(address sender, address recipient, uint256 amount)
        internal;

    /// @param from Address from where tokens are withdrawn.
    /// @param to Address to where tokens are sent.
    /// @param value Number of tokens to transfer.
    /// @return Returns success of function call.
    function _transferFrom(address from, address to, uint256 value)
        internal
        returns (bool)
    {
        uint256 input1 = this.balanceOf(from);
        uint256 input2 = this.balanceOf(to);
        _transfer(from, to, value);
        return true;
    }
}

contract ETHBG is BaseERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);

    uint256 public currentSupply = 0;
    uint8 private constant DECIMALS = 18;

    function name() public pure returns (string memory) {
        return "ETHBg Token";
    }

    function symbol() public pure returns (string memory) {
        return "ETHBG";
    }

    function decimals() public pure returns (uint8) {
        return DECIMALS;
    }

    function totalSupply() public view returns (uint256) {
        return 10000000000 * 10**uint256(DECIMALS);
    }

    function balanceOf(address account) public view returns (uint256) {
        return account.balance;
    }

    function transfer(address to, uint256 value) public payable returns (bool) {
        if (msg.value != value) {
            return false;
        }
        return _transferFrom(msg.sender, to, value);
    }

    function _transfer(address sender, address recipient, uint256 amount)
        internal
    {
        require(recipient != address(this), "can't send to contract itself");
        address(uint160(recipient)).transfer(amount);
        emit Transfer(sender, recipient, amount);
    }

     function ecrecovery(bytes32 hash, bytes memory sig)
        public
        pure
        returns (address result)
    {
        bytes32 r;
        bytes32 s;
        uint8 v;
        if (sig.length != 65) {
            return address(0x0);
        }
        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := and(mload(add(sig, 65)), 255)
        }
        // https://github.com/ethereum/go-ethereum/issues/2053
        if (v < 27) {
            v += 27;
        }
        if (v != 27 && v != 28) {
            return address(0x0);
        }
        // get address out of hash and signature
        result = ecrecover(hash, v, r, s);
        // ecrecover returns zero on error
        require(result != address(0x0), "Error in ecrecover");
    }
}

contract TokenVault {

}
*/