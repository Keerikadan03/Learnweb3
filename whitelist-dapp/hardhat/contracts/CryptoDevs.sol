//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Whitelist.sol";

contract CryptoDevs is ERC721Enumerable, Ownable{
    uint256 constant public price = 0.01 ether;
    uint256 constant public maxTokenIds = 20;
    
    uint256 public reservedTokens;
    uint256 public reservedTokenClaimed = 0;

    Whitelist whitelist;

    constructor (address whitelistContract) ERC721('CryptoDevs', 'CD') Ownable(msg.sender){
        whitelist = Whitelist(whitelistContract);
        reservedTokens = whitelist.maxWhitelistAddresses();
    }

    function mint() public payable{
        require(totalSupply() + reservedTokens - reservedTokenClaimed > 0, "MAX_LIMIT_EXCEEDED");

        if(whitelist.whitelistAddresses(msg.sender) && msg.value < price){
            require(balanceOf(msg.sender) == 0, "ALREADY_OWNED");
            reservedTokenClaimed +=1;
        }
        else{
            require(msg.value >= price, "NOT_ENOUGH_ETHER");
        }

        uint256 tokenId = totalSupply();
        _safeMint(msg.sender, tokenId);
    }

    function withdraw() public onlyOwner{
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent,) = _owner.call{value: amount}("");
        require(sent, "Failed to send ether");
    }
}