// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract StructType {

    Person pp;

    struct Person {
        string name;
        uint16 age;
        // Person bestFriend;
    }

    function readPerson() public view returns (Person memory) {
        return pp;
    }

    function writePerson(Person memory p) public  {
        pp = p;
    }

    function writePersonName(string memory nn) public  {
        pp.name = nn;
    }

    function testMemoryPerson() public pure returns(Person memory) {
        Person memory p;
        p.name = "in memory";
        p.age = 25;
        return p;
    }

    function testLocationPerson() public view returns (Person memory) {
        Person storage p = pp;
        return p;
    }

}
