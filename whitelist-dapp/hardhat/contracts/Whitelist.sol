// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.20;

contract Whitelist{

    uint8 public maxWhitelistAddresses;
    mapping(address => bool) public whitelistAddresses;
    uint8 public numAddressesWhitelisted;

    constructor(uint8 _maxWhitelistAddresses){
        maxWhitelistAddresses = _maxWhitelistAddresses;
    }

    function addAddresstoWhitelist() public{
        require(!whitelistAddresses[msg.sender], "Sender has already been whitelisted");
        require(numAddressesWhitelisted < maxWhitelistAddresses, "Limit has been reached");

        whitelistAddresses[msg.sender] = true;
        numAddressesWhitelisted += 1;
    }
}
