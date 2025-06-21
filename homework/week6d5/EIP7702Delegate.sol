// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EIP7702Delegate {

    event triggle_ink(address sender, address addr_this, address[] targets, uint8 code);
    event record_status(uint8 status);

    function multiExec(address[] calldata targets, bytes[] calldata invokeData) public returns (bytes[] memory results) {
        emit record_status(2);
        require(targets.length == invokeData.length, "len error");
        // emit triggle_ink(msg.sender, address(this), targets, 0);
        emit record_status(0);
        results = new bytes[](targets.length);
        for (uint len = 0; len < targets.length; len ++) {
            address addr = targets[len];
            bytes calldata ink_data = invokeData[len];
            (bool succ, bytes memory result) = addr.call(ink_data);
            require(succ, "contract invoke failure");
            results[len] = result;
        }
        emit record_status(1);
        // emit triggle_ink(msg.sender, address(this), targets, 1);
    }

    function multiExecSingle(address target, bytes calldata invokeData) public returns (bytes memory resultV) {
        emit record_status(2);
        // require(targets.length == invokeData.length, "len error");
        // emit triggle_ink(msg.sender, address(this), targets, 10);
        emit record_status(0);
        (bool succ, bytes memory result) = target.call(invokeData);
        resultV = result;
        require(succ, "invoke data failure..");
        emit record_status(1);
        // emit triggle_ink(msg.sender, address(this), targets, 11);
    }

    function testEvent(bool status) public {
        emit record_status(100);
        require(status, "status is false..");
        emit record_status(101);
    }

}
