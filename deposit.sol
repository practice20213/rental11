// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.8.0;

contract RentalFinal {

    enum Status {Vacant, Rented}
    Status currentStatus;
    
    event Occupy(address _occupant, uint value);
    
    address payable public owner;

    constructor()  {
        owner == msg.sender;
    }
    
    function book() payable public {
        require(msg.value >= 1 ether, "Not enough ether");
        currentStatus = Status.Rented;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }

}