// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract BytesAndString {

    string name = "nnnnnn";
    bytes name1 = "nnnnnn1";

    // string 不能修改, bytes可以修改

    uint256[] cc;

    function call_data(uint256[] calldata pp) public pure {
        uint256[] calldata ss;
        ss = pp;
    }


}

