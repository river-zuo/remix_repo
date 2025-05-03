// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */ 
 // 0xDA0bab807633f07f013f94DD0E6A4F96F8742B53
contract Storage {

    uint256 number;
    string message = "hello, Remix";

    function getMessage() public view returns (string memory) {
        return message;
    }

    function setMessage(string memory msg) public {
        message = msg;
    }

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        return number;
    }
}