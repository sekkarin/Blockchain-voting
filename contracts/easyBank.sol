// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract EasyBank {
    mapping(address => uint256) balances;
    address[] accounts;
    address public owner;
    uint256 rate = 3;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function getblance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 moneyWithdraw) public {
        require(balances[msg.sender] < moneyWithdraw, "invalid");
        balances[msg.sender] -= moneyWithdraw;
        (bool success, ) = msg.sender.call{value: moneyWithdraw}("");
        require(success, "withdraw failed");
    }

    function getSystemBalance() public view onlyOwner returns (uint256) {
        return address(this).balance;
    }

    function calculateInterest(address addressUser)
        public
        view
        onlyOwner
        returns (uint256)
    {
        return (balances[addressUser] * rate) / 100;
        // return (address(this).balance * rate) / 100;
    }
}
