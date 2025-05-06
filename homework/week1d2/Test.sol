// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Test {

    string baseURI;

    function tokenURI(uint256 tokenId) public view virtual returns (string memory) {
        // _requireOwned(tokenId);

        // string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string.concat(baseURI, "") : "";
    }
}

