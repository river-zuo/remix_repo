// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EIP7702Delegate {

    event triggle_ink(address sender, address addr_this, address[] targets, uint8 code);

    function multiExec(address[] calldata targets, bytes[] calldata invokeData) public returns (bytes[] memory results) {
        require(targets.length == invokeData.length, "len error");
        emit triggle_ink(msg.sender, address(this), targets, 0);
        results = new bytes[](targets.length);
        for (uint len = 0; len < targets.length; len ++) {
            address addr = targets[len];
            bytes calldata ink_data = invokeData[len];
            (bool succ, bytes memory result) = addr.call(ink_data);
            require(succ, "contract invoke failure");
            results[len] = result;
        }
        emit triggle_ink(msg.sender, address(this), targets, 1);
    }

}
