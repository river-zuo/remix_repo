// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract MappingType {

    // 成员变量都是存储在storage中,  映射只能放在storage中，换句话说 映射只能定义成员变量
    mapping(string => uint8) public  ages;

    mapping(string => mapping(string => uint8)) public ages1;

    // 映射只能放在 storage中

    function getAge(string memory name) public view returns (uint8) {
        // mapping (string => uint8) storage aaa = ages;
        uint8 age = ages[name];
        return age;
    }

    function setAge(string memory name, uint8 age) public {
        ages[name] = age;
    }
    // 参数列表或者返回值的一般规则 public函数 只能memory 或 calldata，interval private可以是 storage(当然包括 memory、 calldata)

    // mapping 只能是 storage
    // => public函数参数或者返回值不可能出现mapping类型
    // 写一个interval或private函数, 传递storage的mapping



}
