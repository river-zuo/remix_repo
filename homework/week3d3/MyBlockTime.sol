// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BlockTime {
    function getBlockTimestamp() public view returns (uint256) {
        return block.timestamp; // 返回当前区块的时间戳
    }
}