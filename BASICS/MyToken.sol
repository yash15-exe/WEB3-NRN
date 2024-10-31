// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken{

    string public name = "Yash Ka Token";
    string public symbol = "YKT";
    uint8 public decimals = 10;
    uint256 public totalSupply;

    mapping(address=> uint256) public balanceOf;
    mapping(address => mapping(address=>uint256)) allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

   constructor(uint256 initialSupply) {
        totalSupply = initialSupply * 10 ** uint256(decimals);  // Adjust supply for decimals
        balanceOf[msg.sender] = totalSupply;  // Assign all tokens to deployer
        emit Transfer(address(0), msg.sender, totalSupply);  // Log the initial transfer (from zero address)
    }

     function transfer(address to, uint256 value) public returns (bool success) {
        require(to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);  // Emit Transfer event
        return true;
    }
    function approve(address spender, uint256 value) public returns (bool success) {
        require(spender != address(0), "Invalid address");

        allowance[msg.sender][spender] = value;  // Set allowance
        emit Approval(msg.sender, spender, value);  // Emit Approval event
        return true;
    }
 function transferFrom(address from, address to, uint256 value) public returns (bool success) {
        require(to != address(0), "Invalid address");
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Allowance exceeded");

        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;  // Decrease the allowance
        emit Transfer(from, to, value);  // Emit Transfer event
        return true;
    }

     function mint(uint256 value) public returns (bool success) {
        require(value > 0, "Mint amount should be greater than 0");

        totalSupply += value;
        balanceOf[msg.sender] += value;
        emit Transfer(address(0), msg.sender, value);  // Log minting (from zero address)
        return true;
    }

      function burn(uint256 value) public returns (bool success) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        balanceOf[msg.sender] -= value;
        totalSupply -= value;
        emit Transfer(msg.sender, address(0), value);  // Log burning (to zero address)
        return true;
    }
}