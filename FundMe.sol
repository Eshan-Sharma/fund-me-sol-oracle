//Get fund from users
//Withdraw funds
//Set a minimum funding value in USD

//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

contract FundMe{
    function fund() public payable{//1. How do we send ETH to this contract? - Use "payable"
        // Allow users to send $
        // Have a minimum $ sent
        require(msg.value>1e18, "didn't send enough ETH");// 1e18 = 1ETH = 1000000000000000000 = 1 * 10 ** 18

        // What is a revert?
        // Undo any actions that have been done, and send the remaining gas back
        // Even if the transaction reverts, since some computation occured. Gas is spent
    }

    function withdraw() public{}
}