// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract BalanceManage {

    mapping(address => uint256) public balanceOf;

    string public  name = "MYDO";
    string public  symbol = "$";
    uint8 public decimals = 4;
    
    constructor(uint totalBalance) {
        // msg.sender;
        // address sender = msg.sender;
        // balanceOf[sender] = totalBalance;
        balanceOf[msg.sender] = totalBalance;
    }

    function transfer(address to, uint256 amount) public {
        address sender = msg.sender;
        uint256 fb = balanceOf[sender];
        uint256 tb = balanceOf[to];
        require(fb >= amount, "AAA... from account do not have enough money!");
        fb -= amount;
        tb += amount;
        balanceOf[sender] = fb;
        balanceOf[to] = tb;
    }

    // 0x84E1498ac712391714b4166eee3f73E2347410f1
    
    // 0x4B00CFDf085Acfa95aAd17F1d0d9c6B035d09205


    // 0x91017635425839F400fbe817Fc36549f3e6E4A37

}
