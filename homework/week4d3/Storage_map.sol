// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Storage_map {

    mapping(uint => User) public users;

    struct User {
        uint256 id;
        address cc;
        string name;
    }
        
    function manipulate_map(uint256 id, string memory name) public {
        User memory uu = User ({
            id: id,
            cc: 0x98FC37bb4e2f5E6DA9Cd9a6151caedDb8bA6DbCC,
            name: name
        });
        users[id] = uu;
    }

    function change_val(uint256 id, string memory name) view public returns (User memory) {
        User memory uu = users[id];
        uu.name = name;
        // users[id] = uu;
        return users[id];
    }

}

