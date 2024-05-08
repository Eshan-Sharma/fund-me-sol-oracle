//Get fund from users
//Withdraw funds
//Set a minimum funding value in USD

//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256;
    uint256 public minimumUsd = 5 * 1e18;//Instead of minimum ETH, let's set minimum Usd value
    address[] public funders;
    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable{//1. How do we send ETH to this contract? - Use "payable"
        // Allow users to send $
        // Have a minimum $ sent
        
        require(msg.value.getConversionRate() >= minimumUsd, "didn't send enough ETH");// 1e18 = 1ETH = 1000000000000000000 = 1 * 10 ** 18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        // What is a revert?
        // Undo any actions that have been done, and send the remaining gas back
        // Even if the transaction reverts, since some computation occured. Gas is spent


       
    }

    function withdraw() public{}
    
}