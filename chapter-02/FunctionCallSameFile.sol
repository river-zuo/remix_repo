// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Callee {
    uint256 x;

    function setX(uint _x) public {
        x = _x;
        
    }
}

contract Caller {
    
}