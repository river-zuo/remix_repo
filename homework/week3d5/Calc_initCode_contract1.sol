// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleContract.sol";

contract Calc_initCode_contract {

    function contractor_code(uint256 _value) pure public returns (bytes memory) {
        bytes memory _encode =  abi.encode(_value);
        return _encode;
    }

    function calc_init_code(bytes memory _construct_bytes) pure public returns (bytes memory) {
        bytes memory _createCode =  type(SimpleContract).creationCode;
        bytes memory _createCode_and_construct_bytes_packed = abi.encodePacked(_createCode, _construct_bytes);
        return _createCode_and_construct_bytes_packed;
    }

    function calc_keccak256(bytes memory _construct_bytes) pure public returns (bytes32) {
        bytes memory _createCode =  type(SimpleContract).creationCode;
        bytes memory _createCode_and_construct_bytes_packed = abi.encodePacked(_createCode, _construct_bytes);
        bytes32 _k256_hash = keccak256(_createCode_and_construct_bytes_packed);
        return _k256_hash;
    }
}
// 0x9a713f792673287311a8de6a0175082aeeff0d3595f9bfd748e7bafac36bdf90