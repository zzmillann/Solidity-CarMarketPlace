# Cars Smart Contract

## Overview
`Cars` is a Solidity smart contract designed for basic car management and Ether payments. It allows users to register cars, assign license plates, send funds, and enables the contract owner to withdraw collected funds securely.

The contract is written in Solidity and follows common best practices for clarity, simplicity, and security.

---

## Features

- Register cars with custom attributes (ID, wheels, brand)
- Assign license plates to registered cars
- Track Ether sent by each address
- Allow users to fund the contract
- Secure withdrawal mechanism restricted to the contract owner
- Public getters for transparency

---

## Smart Contract Details

### Data Structures

```solidity
struct Car {
    uint id;
    uint wheels;
    string brand;
}
```

### State Variables

| Variable | Type | Description |
|--------|------|-------------|
| `owner` | `address` | Contract owner |
| `cars` | `Car[]` | Array of registered cars |
| `carPlate` | `mapping(uint => string)` | Maps car ID to license plate |
| `fundsSpent` | `mapping(address => uint)` | Tracks Ether sent by each address |

---

## Functions

### `createCar(uint _id, uint _wheels, string memory _brand)`
Registers a new car and stores it in the contract.

- **Parameters:**
  - `_id`: Unique car identifier
  - `_wheels`: Number of wheels
  - `_brand`: Brand name

---

### `assignPlate(uint _id, string memory _plate)`
Assigns a license plate to a car using its ID.

- **Parameters:**
  - `_id`: Car ID
  - `_plate`: License plate string

---

### `fundCar()` *(payable)*
Allows users to send Ether to the contract. The sent amount is tracked per address.

---

### `getUserFunds() → uint`
Returns the total Ether sent by the caller.

---

### `withdraw()` *(onlyOwner)*
Allows the contract owner to withdraw their recorded funds.

- Uses the **checks-effects-interactions** pattern
- Prevents reentrancy by resetting state before transfer

---

### `totalCars() → uint`
Returns the total number of registered cars.

---

## Security Considerations

- Owner-restricted withdrawal using a modifier
- State reset before Ether transfer to prevent reentrancy
- Uses Solidity `>=0.7.0 <0.9.0`

---

## Requirements

- Solidity `0.8.x`
- Compatible with Hardhat, Foundry, or Remix
- Chainlink interface imported (not yet used)

---

## Deployment

Example using Remix:

1. Copy the contract into Remix IDE
2. Select Solidity compiler `0.8.x`
3. Deploy using an EVM-compatible network

---

## License

This project is licensed under the **MIT License**.

```text
SPDX-License-Identifier: MIT
```

---

## Author

**zzmillann**

Smart contract development and experimentation with Solidity.

