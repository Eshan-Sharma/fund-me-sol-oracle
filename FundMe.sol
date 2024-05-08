//Get fund from users
//Withdraw funds
//Set a minimum funding value in USD

//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
    uint256 public minimumUsd = 5 * 1e18;//Instead of minimum ETH, let's set minimum Usd value
    address[] public funders;
    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable{//1. How do we send ETH to this contract? - Use "payable"
        // Allow users to send $
        // Have a minimum $ sent
        require(getConversionRate(msg.value) >= minimumUsd, "didn't send enough ETH");// 1e18 = 1ETH = 1000000000000000000 = 1 * 10 ** 18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        // What is a revert?
        // Undo any actions that have been done, and send the remaining gas back
        // Even if the transaction reverts, since some computation occured. Gas is spent


       
    }
    // Using Oracle to get the price of ETH/USD
    function getPrice() public view returns (uint256){
        //Address - 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
         (
            /* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return uint256(price) * 1e10;
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function withdraw() public{}
    
}