// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Connector.sol";

contract kryptoBird is ERC721Connector {

    // array to store our nfts
    string[] public kryptoBirdz;

    mapping(string => bool) public _kryptoBirdzExists;

    function mint(string memory _kryptoBird) public {
        require(!_kryptoBirdzExists[_kryptoBird], "KryptoBird already exists");
        // uint _id = kryptoBirdz.push(_kryptoBird);  <--- this is deprecated, .push no longer returns the length of the array
        //                                                 but the reference to the new element

        // we get the current id, which is the length of the array
        uint _id = kryptoBirdz.length;
        // we add the nft to the array
        kryptoBirdz.push(_kryptoBird);
        // we mint the nft to the sender of the function call
        _mint(msg.sender, _id);

        _kryptoBirdzExists[_kryptoBird] = true;
    }
    constructor() ERC721Connector("KryptoBirdz", "KRBZ") {}
}
