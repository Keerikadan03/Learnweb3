// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import './CryptoDevsNFT.sol';
import './FakeNFTMarketplace.sol';

interface IFakeNFTMarketplace{
    function getPrice() external view returns(uint256);
    function available(uint256 _tokenId) external view returns(bool);
    function purchase(uint256 _tokenId) external payable;
}

interface ICryptoDevsNFT{
    function balanceOf(uint256 addressOwner) external view returns(uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns(uint256);
}

contract CryptoDevsDAO is Ownable{
    constructor() Ownable(){}
}