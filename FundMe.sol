//Get fund from users
//Withdraw funds
//Set a minimum funding value in USD

//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe{
    address public owner;
    constructor(){
        owner = msg.sender;
    }
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

    function withdraw() public onlyOwner{
        for (uint256 funderIndex = 0; funderIndex < funders.length;funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        //withdraw the funds, 3 ways
        //transfer
        //msg.address, type of address
        //payable(msg.address), type of payable address
        // payable(msg.sender).transfer(address(this).balance);

        // //send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        //call
        (bool callSuccess, ) = payable(msg.sender).call{value:address(this).balance}("");
        require(callSuccess,"Call failed");


        
    }

    modifier onlyOwner(){//this is executed first, kinda like middleware in js
        require(msg.sender==owner, "Sender is not owner!");//executed
        _;//goes back to the function definition
        //checks if there is anything else?
        //nope, ends
    }
    
}