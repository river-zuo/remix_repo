// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract ComplexValueType {
    
    function testAddress() public view returns(address) {
        address addr = msg.sender;
        return addr;
    }

    function testMyAddress() public view returns(address) {
        address this_addr = address(this);
        return this_addr;
    }

    // Contract type
    function testContract() public view {
        ComplexValueType cvt = this;
        
    }

    

}


// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

// 0x86cA07C6D491Ad7A535c26c5e35442f3e26e8497
// 0x86cA07C6D491Ad7A535c26c5e35442f3e26e8497


