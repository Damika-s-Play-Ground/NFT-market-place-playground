// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Metadata.sol';
import './ERC721Enumerable.sol';
contract ERC721Connector is ERC721Metadata, ERC721Enumerable {

    // we deploy the connector right away
    // we pass the metadata (name and symbol) to the ERC721Metadata constructor
    constructor(string memory name, string memory symbol) ERC721Metadata(name, symbol) {
    }
}