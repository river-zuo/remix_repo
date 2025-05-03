// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Payable {

    function transferToContract() external payable {
        address payable addr = payable(address(this));
        addr.transfer(msg.value);
    }

}