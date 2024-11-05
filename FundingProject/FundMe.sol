//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./PriceConverter.sol";

error NotOwner();
contract Funding{
    using PriceConverter for uint256;
    mapping(address=>uint256) addressToAmount;

    address[] public funders;

    address immutable owner;

    constructor(){
        owner = msg.sender;
    }

    uint256 public MINIMUM_USD = 50*10**18;

    function fund()public payable{
       require(msg.value.getConversionRate()>=MINIMUM_USD, "Please Donate MOREEEEE");
       addressToAmount[msg.sender] += msg.value;
    funders.push(msg.sender);
    }
    modifier onlyOwner {
        // require(msg.sender == owner);
        if (msg.sender != owner) revert NotOwner();
        _;
    }

        function withdraw() public onlyOwner {
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmount[funder] = 0;
        }
        funders = new address[](0);
        // // transfer
        // payable(msg.sender).transfer(address(this).balance);
        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
} 
