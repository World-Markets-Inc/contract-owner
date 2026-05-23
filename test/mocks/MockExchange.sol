// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

/// @dev Minimal exchange stub for TradeForwarder tests.
contract MockExchange {
    error TradingNotAllowed(uint64 userId, address trader);

    mapping(address => uint64) public userIds;
    mapping(uint64 => address) public userAddress;
    mapping(uint64 => mapping(address => bool)) public tradingAllowed;

    uint256 public buyOrderCount;
    uint256 public bestBuyPrice;
    uint256 public bestBuyQuantity;
    mapping(address => uint256) public toVaultSeq;

    /// @notice Matches Java `computeBuySeqAmount(1.0, 1900.0, true)` with euro position decimals (6).
    uint256 public constant BUY_SEQ_INCREMENT = 1_900_000_000;

    function registerUser(address user, uint64 userId) external {
        userIds[user] = userId;
        userAddress[userId] = user;
    }

    function getUserId(address user) external view returns (uint64) {
        return userIds[user];
    }

    function allowTradingForAccount(uint64 userId, address trader) external {
        tradingAllowed[userId][trader] = true;
    }

    function batchCommands(uint64 userId, uint256[] calldata commands) external {
        if (!tradingAllowed[userId][msg.sender]) {
            revert TradingNotAllowed(userId, msg.sender);
        }
        if (commands.length == 0) {
            revert TradingNotAllowed(userId, msg.sender);
        }

        buyOrderCount++;
        bestBuyPrice = 1_900_000_000_000;
        bestBuyQuantity = 1_000_000_000_000_000_000;

        address user = userAddress[userId];
        if (user != address(0)) {
            toVaultSeq[user] += BUY_SEQ_INCREMENT;
        }
    }
}
