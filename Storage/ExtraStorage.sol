//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract ExtraSTorage is SimpleStorage {
    function store(uint256 _favouriteNumber)public override{
        favouriteNumber = _favouriteNumber +1111;
    }
}