// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FallbackExample{
    uint256 public result;

    // If the calldata is empty and contract is called without specifying function, this is called
    receive() external payable {
        result = 1;
    }

    //If any data is present in the calldata but no function is specified and contract is called, fallback function is triggered
    fallback() external payable { 
        result = 2;
    }

}