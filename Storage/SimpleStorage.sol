//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage{
    uint256 favouriteNumber;

    struct User{
        uint256 favouriteNumber;
        string name;
    }

    User[] public users;

    mapping(string => uint256) public nameToFavouriteNumber;

    function store(uint256 _favouriteNumber) public virtual{
        favouriteNumber = _favouriteNumber;

    }
    function retrieve() public view returns(uint256){
        return favouriteNumber;
    }

    function addUser(string memory _name, uint256 _favouriteNumber) public{
        User memory newUser  = User({
            name:_name,
            favouriteNumber:_favouriteNumber
        });
        users.push(newUser);
    }

    function addToMapping(uint256 number, string memory name)public{
        nameToFavouriteNumber[name] = number;
    }
}