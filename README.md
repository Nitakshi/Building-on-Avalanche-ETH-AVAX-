# Project Title

Degen Token (ERC-20)

## Description

DegenToken is an ERC20 token smart contract implemented on Ethereum blockchain using Solidity. It allows minting, burning, transferring tokens, and redeeming tokens for specific items. This contract also maintains a record of redeemed items per user.

### Features

- Token Name: Degen
- Symbol: DGN
- Decimals: 18
- Owner: Deployer of the contract

### Functionality

#### Token Operations

- Minting: Only the contract owner can mint new tokens to designated addresses.
- Burning: Users can burn their tokens, reducing the total supply accordingly.
- Transferring: Standard ERC20 transfer functionality is implemented.
  
#### Redemption 

-Users can redeem items by spending DGN tokens. Each item has a fixed token cost.
-Redeemed items are recorded per user, detailing the amount of items and tokens spent.

#### View Functions

- Check Balance: Allows users to check their token balance.
- View Redeemed Items: Provides a list of items redeemed by a specific user.
- Print Redeemed Tokens: Formats a readable list of redeemed items with specific details.

## Getting Started

### Executing program

To run this program you can use Remix IDE.
- To get started, go to the Remix website at https://remix.ethereum.org/. 
- Click on Create new file and save a file as .sol extension (eg. degenToken.sol). 
- Copy and paste the code provided in the github repository.

### Imports

- Import the ERC20 token standard implementation from OpenZeppelin contracts

 `import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";`

- Import the Ownable contract from OpenZeppelin

 `import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";`


### Compiling and Deploying 

- To compile the contract, click on "Solidity compiler" on the left-hand sidebar. Make sure the "Compiler" option is set ^0.8.19 , and then click on the "Compile degenToken.sol" button or we can simply click Ctrl+S to compile the contract.

- Once it is compiled you can deploy the contract.
  
- Change Environment to Injected Provider - MetaMask and connect it to your MetaMask account.
  
- Deploy the contract to Avalanche Fuji Testnet.
  
- Deploy by clicking on the "Deploy and Run Transactions" tab in the left-hand sidebar.
  
- Click on 'CONFIRM' on your MetaMask.
  
-  Select the "degenToken.sol" contract from the dropdown menu, and then click on the "Deploy" button.

- Within the Deployed/Unpinned Contracts, click on the deployed contract (i.e Token).

- Click on `mintToken` function (only owner can mint tokens), provide account address to which you want to mint tokens and amount of tokens to mint. Click on the "Transact" button and then click 'CONFIRM' on MetaMask.
  
- Click on `redeemToken` function, provide amount to redeem. Click on the "Transact" button, click 'CONFIRM' on MetaMask.

- Copy your Contract address.

- Test on testnet.
  
- Verify the smart-contract on Snowtrace

## Author

Metacrafter Student Nitakshi Azad

## License

This project is licensed under the MIT License.





