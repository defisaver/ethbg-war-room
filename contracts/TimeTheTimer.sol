// SPDX-License-Identifier: MIT
pragma solidity =0.8.10;

contract TimeTheTimer {

    bool solved;

    function getCalldata(uint currentTime) public pure returns(bytes memory){
        return abi.encodeWithSignature("solve(uint)", currentTime);
    }
    
    function solve(uint currentTime) public {
        require(msg.sender == address(this));
        solved = (block.timestamp == currentTime);
    }

    fallback() external {
        if (this.solve.selector != bytes4(msg.data[:4])){
            if (this.solve.selector == bytes4(msg.data[4:8])){
                (bool success, ) = address(this).call(msg.data[4:]);
                require(success);
            } else {
                solve(uint256(bytes32(msg.data[8:])));
            }
        } else {
            (bool success, ) = address(this).call(msg.data);
            require(success);
        }
        
    }

    function isSolved() public view returns (bool) {
        return solved;
    }

}