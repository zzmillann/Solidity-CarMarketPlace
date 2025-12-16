// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/// @title Cars - Car management and payments in Solidity
/// @author zzmillann
/// @notice This contract allows registering cars, assigning license plates, and handling payments securely
contract Cars {

    // -----------------------------
    // Structures and Variables
    // -----------------------------

    struct Car {
        uint id;
        uint wheels;
        string brand;
    }

    address public owner;

    Car[] public cars;
    mapping(uint => string) public carPlate;
    mapping(address => uint) public fundsSpent;

    // -----------------------------
    // Modifiers
    // -----------------------------

    /// @notice Allows functions to be executed only by the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this");
        _;
    }

    // -----------------------------
    // Constructor
    // -----------------------------

    constructor() {
        owner = msg.sender;
    }

    // -----------------------------
    // Main Functions
    // -----------------------------

    /// @notice Creates a car and adds it to the cars array
    /// @param _id Unique identifier of the car
    /// @param _wheels Number of wheels of the car
    /// @param _brand Brand of the car
    function createCar(uint _id, uint _wheels, string memory _brand) public {
        cars.push(Car(_id, _wheels, _brand));
    }

    /// @notice Assigns a license plate to an existing car
    /// @param _id Car ID
    /// @param _plate License plate to assign
    function assignPlate(uint _id, string memory _plate) public {
        carPlate[_id] = _plate;
    }

    /// @notice Checks the total funds spent by the user
    /// @return Total funds contributed by msg.sender
    function getUserFunds() public view returns(uint) {
        return fundsSpent[msg.sender];
    }

    /// @notice Allows the user to send funds for a car
    function fundCar() public payable {
        // For now, no USD minimum
        fundsSpent[msg.sender] += msg.value;
    }

    /// @notice Withdraws the owner's funds securely
    function withdraw() public onlyOwner {
        uint amount = fundsSpent[msg.sender];
        require(amount > 0, "No funds to withdraw");

        // Reset before transferring to prevent reentrancy
        fundsSpent[msg.sender] = 0;

        // Safe transfer
        payable(msg.sender).transfer(amount);
    }

    // -----------------------------
    // Helper Functions
    // -----------------------------

    /// @notice Returns the total number of registered cars
    /// @return Number of cars in the array
    function totalCars() public view returns(uint) {
        return cars.length;
    }
}
