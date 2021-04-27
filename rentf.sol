// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract Rent1 {
    struct owner1{
        uint amount;
        uint time;
        bool paid;
    }
    mapping(address => owner1) public owners;
    address public admin;
    
    constructor() {
        admin = msg.sender;
    }
    
    function addOwner(address owner, uint renttime) external payable{
        require(msg.sender == admin, 'only admin');
        require(owners[msg.sender].amount == 0, 'already exist');
        owners[owner] = owner1(msg.value, block.timestamp + renttime, false);
    }
    
    function withdraw_rent() external {
        owner1 storage owner = owners[msg.sender];
        require(owner.time <= block.timestamp, 'too early');
        require(owner.amount > 0, 'only owner can withdraw rent');
        require(owner.paid == false, 'rent paid already');
        owner.paid = true;
        payable(msg.sender).transfer(owner.amount);
    }
}