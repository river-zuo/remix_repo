// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyEIP2612Token is ERC20Permit {
    
    constructor() ERC20("MY2612ERC20", "2612ERC") ERC20Permit("MY2612ERC20Permit") {
        _mint(msg.sender, 1e5 * 10 ** decimals());
    }

    function decimals() public view override returns (uint8) {
        return 18;
    }

}
