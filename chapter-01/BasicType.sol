// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0 ;

contract BasicType {
    
    function test() public pure returns(uint) {
        // uint256 u8 = 255;
        uint256 max = type(uint256).max;
        uint8 x = 8;
        uint16 y = 9;
        // y = x;
        // x = y;
        x = uint8(y);
        return max;
    }

    enum OrderState {
        layorder,
        payment
    }

    function enumTest() public pure returns(OrderState) {
        OrderState state = OrderState.layorder;
        return state;
    }

}