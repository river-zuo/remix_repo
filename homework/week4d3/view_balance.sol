// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract view_balance {

    function myBalance() public payable returns(uint256)  {
        return msg.value;
    }

}
