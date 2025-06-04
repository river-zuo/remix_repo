// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NumberCalc {


    struct AA {
        uint256 nounce;
        uint256 age;
    }

    mapping (address => AA) public pa;

    function calc0(uint256 amount) public pure returns(uint256){
        uint256 num = amount * 99 / 100;
        return num;
    }

    function change_memory(uint256 _age) public view {
        AA memory aa = pa[msg.sender];
        aa.age = _age;
    }

    function change_storage(uint256 _age) public  {
        AA storage aa = pa[msg.sender];
        aa.age = _age;
    }

    function viewOnSender() public view returns (AA memory) {
        return pa[msg.sender];
    }


}
