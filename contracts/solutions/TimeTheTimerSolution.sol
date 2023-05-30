
contract TimeTheTimerSolution {
    address timer;
    constructor (address timerContract){
        timer = timerContract;
    }

    function solve() public {
        bytes memory solutionBytes = abi.encodeWithSignature("solve(uint256)", block.timestamp);
        timer.call(appendZeroBytes(solutionBytes));
    }

    function appendZeroBytes(bytes memory existingBytes) public pure returns (bytes memory) {
        uint256 existingLength = existingBytes.length;
        bytes memory newBytes = new bytes(existingLength + 4); // Allocate memory for existing bytes + 4 additional bytes

        for (uint256 i = 0; i < 4; i++) {
            newBytes[i] = 0x00;
        }

        for (uint256 j = 4; j < existingLength + 4; j++) {
            newBytes[j] = existingBytes[j-4];
        }

        return newBytes;
    }

}