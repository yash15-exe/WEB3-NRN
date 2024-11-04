//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory{
    SimpleStorage[] public simpleStorageFactory;

    function createSimpleStorage() public{
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageFactory.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        simpleStorageFactory[_simpleStorageIndex].store(_simpleStorageNumber);

    }


function sfRetrieve(uint256 _simpleStorageIndex)public view returns(uint256){
    return simpleStorageFactory[_simpleStorageIndex].retrieve();
}
}