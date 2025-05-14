// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {

    uint256 private num;

    function increment() public {
        num += 1;
    }

    function number() public view returns(uint256) {
        return num;
    }

}
