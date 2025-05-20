// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FactoryContract {

    address public _owner;

    constructor() {
        _owner = msg.sender;
    }
    
    modifier only_owner {
        require(msg.sender == _owner, "must be owner.");
        _;
    }

    function changeOwner(address _new_owner) public only_owner {
        _owner = _new_owner;
    }

    event record_deploy_param(address sender, bytes32 salt, bytes init_code);

    function predict_deploy_address(address deployer, uint256 salt, bytes memory init_code_keccak256) view public returns(address) {
        address sender = deployer;
        if (deployer == address(0)) {
            sender = address(this);
        }
        bytes memory packed_code = abi.encodePacked(bytes1(0xff), sender, bytes32(salt), init_code_keccak256);
        bytes32 _addr_bytes32 = keccak256(packed_code);
        uint160 _addr_bytes20 = uint160(uint256(_addr_bytes32));
        address _ret_addr = address(_addr_bytes20);
        return _ret_addr;
    }

    function deploy_with_create2(uint256 salt, bytes memory init_code) external only_owner returns(address) {
        address childAddr;
        bytes32 _salt = bytes32(salt);
        assembly {
            // let ptr := add(init_code, 0x20)
            // let size := mload(init_code)
            // _contract_addr := create2(0, add(0x20, init_code), mload(init_code), _salt)
            childAddr := create2(0, add(0x20, init_code), mload(init_code), salt)
        }
        require(childAddr != address(0), "failed to deploy contract");
        // emit record_deploy_param(address(this), _salt, init_code);
        return childAddr;
    }

    function deploy(bytes memory bytecode, uint256 salt) public returns (address) {
        address addr;
        assembly {
            addr := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }
        // emit Deployed(addr, salt);
        return addr;
    }



}

// 0xc64049cB48800582A9E951b4130D3fae665BB378

// ======= 使用factory部署


// 0xc64049cB48800582A9E951b4130D3fae665BB378


