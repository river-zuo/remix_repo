// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.2 <0.9.0;

contract ConstructStructure {
    
    uint256 public balance;


    event BalanceAdded(uint256 oldValue, uint256 incre);

    constructor(uint256 _bal) {
        balance = _bal;
    }

    modifier IncrementRange(uint256 _incre) {
        // 修饰器是对函数的输入输出条件进行约束的
        
        require(_incre > 100, "too small");
        _; // 执行被修饰函数的逻辑
    }

    function balance1() internal view returns(uint256) {
        return balance;
    }

    function addBalance(uint256 _incre) external IncrementRange(_incre) {
        uint256 oldV = balance;
        balance += _incre;
        emit BalanceAdded(oldV, _incre);
    }

    function pure_add(uint32 x, uint32 y) public pure returns (uint32) {
        return x + y;
    }

}

// 0xD4Fc541236927E2EAf8F27606bD7309C1Fc2cbee

// 0x1c91347f2A44538ce62453BEBd9Aa907C662b4bD

