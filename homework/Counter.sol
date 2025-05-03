// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Counter {

    uint private counter;

    constructor(uint init_counter) {
        counter = init_counter;
    }

    function get() public view returns (uint) {
        return counter;
    }

    function add(uint x) public {
        counter += x;
    }


    receive() external payable { 

    }

    fallback() external payable { 

    }

}

// 0x1a50CE7E1524CC775b3E67C336cCc160012C0A33

