// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable{

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender){}

    event TransferT(address indexed from, address indexed to, uint256 value);
    event TokensRedeemed(address indexed player, uint256 amount, uint256 tokensRedeemed);

    uint256 private total_Supply;

    struct RedeemedItem { //structure to keep track of redeemed items
        uint256 amount;
        uint256 tokensRedeemed;
    }

    // Mapping to store redeemed items by account
    mapping(address => RedeemedItem[]) private redeemedItems;

    // variable to set the cost of each item in terms of DGN tokens
    uint256 public tokenCost = 1; // For example, 1 DGN token per item

    function totalSupply() public view override returns (uint256) {
        return total_Supply;
    }
    function mintToken(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Invalid: Zero address");
        _mint(to, amount);
        total_Supply += amount;
        emit TransferT(address(0), to, amount);
    }

    function burnToken(address from, uint256 amount) public {
        require(from != address(0), "Invalid: Zero Address");
        _burn(from, amount);
        total_Supply -= amount;
        emit TransferT(from, address(0), amount);
    }

    function transferToken(address sender, address recipient, uint256 amount) public returns (bool) {
        require(sender != address(0), "Invalid sender address");
        require(recipient != address(0), "Invalid recipient address");
        _transfer(sender, recipient, amount);
        emit TransferT(sender, recipient, amount);
        return true;
    }

    function checkBalance(address account) public view returns (uint256) { //returns the token balance of a specified address.
        require(account != address(0), "Invalid: Zero address");
        return balanceOf(account);
    }
    
    function redeem(uint256 amount) public {
        require(amount > 0, "Redeem amount must be greater than zero");
        uint256 cost = amount * tokenCost; //total cost in tokens to redeem the given amount of items
        require(balanceOf(_msgSender()) >= cost, "Insufficient token balance"); //checks if the sender has enough tokens to cover the cost

        _burn(_msgSender(), cost); //burns the required amount of tokens from the sender's balance

        redeemedItems[_msgSender()].push(RedeemedItem({ //This records the redemption by adding a new RedeemedItem struct to the sender's redeemedItems array
            amount: amount, //the amount of items redeemed
            tokensRedeemed: cost //the number of tokens spent
        }));

        emit TokensRedeemed(_msgSender(), amount, cost);
    }

    function getRedeemedItems(address account) public view returns (RedeemedItem[] memory) {
        require(account != address(0), "Invalid: zero address");
        return redeemedItems[account]; //returns the array of RedeemedItem structs associated with the specified account
    }

    function printRedeemedTokens(address account) public view returns (string memory) {
        require(account != address(0), "Invalid: zero address");
        RedeemedItem[] memory items = redeemedItems[account]; //retrieves the array of RedeemedItem structs associated with the specified account
        require(items.length > 0, "No redeemed tokens found");
        //For each item, it concatenates information about the redemption number, the amount, and the tokens redeemed.
        string memory result = "";
        for (uint i = 0; i < items.length; i++) {
            result = string(abi.encodePacked(
                result,
                "Redemption ", uintToString(i + 1), ": ",
                "Amount: ", uintToString(items[i].amount),
                " Tokens Redeemed: ", uintToString(items[i].tokensRedeemed),
                "\n"
            ));
        }
        return result;
    }

    function uintToString(uint256 v) internal pure returns (string memory) {
        if (v == 0) {
            return "0";
        }
        uint256 digits;
        uint256 temp = v;
        //This loop counts the number of digits in the input value by repeatedly dividing the value by 10 until it becomes zero
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        //This loop fills the buffer array with the ASCII characters representing each digit of the input value
        while (v != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(v % 10)));
            v /= 10;
        }
        return string(buffer); //the function converts the buffer array to a string and returns it
    }
}
