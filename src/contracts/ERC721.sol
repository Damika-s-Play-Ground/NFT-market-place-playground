// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
building out the minting function:
	a. nft to point to an address
	b. keep track of the token ids
	c. keep track of token owner addresses to token ids
	d. keep track of how many tokens an owner address has
	e. create an event that emits a transfer log - contract address where it is being minted to, the id 

Exercise:
1. write a function called _mint that takes two arguments
2. add internal visibility to the signature
3. set the tokenOwner of the tokenId  to the address argument 'to'
4. increase the owner token count by 1 each time the function is called

BONUS
create two requirements - 
5. Require that the mint address isn't  0
6. Require that the token has not already been minted
     */



contract ERC721{
    event Transfer(
        address indexed from, 
        address indexed to,     
        uint256 indexed tokenId
        );
    // mapping in solidity creates a hash table of key pair values

    // Mapping from token id to the owner
    mapping(uint => address) private _tokenOwner;

    // Mapping from  owner to the number of owned tokens
    mapping(address => uint) private _ownedTokensCount;

    
    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) public view returns (uint256) {
        require(_owner != address(0), "ERC721: balance query for the zero address");
        return _ownedTokensCount[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) external view returns (address){
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;}
    
    function _exists(uint256 tokenId) internal view returns (bool) {
        // setting the address of the nft owner to check the mapping
        // of the address from tokenOwner at the tokenId
        address  owner = _tokenOwner[tokenId];
        // returning true if the owner is not 0
        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal virtual {
        // 5. Require that the mint address isn't  0
        require(to != address(0), "ERC721: mint to the zero address");
        // 6. Require that the token has not already been minted
        require(!_exists(tokenId), "ERC721: token already minted");

        // a. nft to point to an address
        _tokenOwner[tokenId] = to;
        // b. keep track of the token ids
        _ownedTokensCount[to] += 1;
        // e. create an event that emits a transfer log - contract address where it is being minted to, the id 
        emit Transfer(address(0), to, tokenId);
    }

}