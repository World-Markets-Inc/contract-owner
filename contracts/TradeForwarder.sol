// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

interface ITradeForwarderExchange {
    function getUserId(address userAddress) external view returns (uint64);
    function batchCommands(uint64 userId, uint256[] calldata commands) external;
}

/// @notice Attribution wrapper for user-signed exchange batch commands.
/// @dev Users must call allowTradingForAccount(userId, address(this)) on the exchange first.
///      The userId is resolved from msg.sender on the exchange, so approval of this forwarder does not
///      let arbitrary callers trade permissioned accounts.
contract TradeForwarder {
    address public immutable exchange;

    event BatchForwarded(
        address indexed caller,
        uint64 indexed userId,
        uint256 commandCount
    );

    error InvalidExchange(address exchange);
    error EmptyCommands();
    error CallerHasNoAccount(address caller);

    constructor(address exchange_) {
        if (exchange_ == address(0) || exchange_.code.length == 0) {
            revert InvalidExchange(exchange_);
        }
        exchange = exchange_;
    }

    function batchCommands(uint256[] calldata commands) external {
        if (commands.length == 0) {
            revert EmptyCommands();
        }

        ITradeForwarderExchange exch = ITradeForwarderExchange(exchange);
        uint64 userId = exch.getUserId(msg.sender);
        if (userId == 0) {
            revert CallerHasNoAccount(msg.sender);
        }

        exch.batchCommands(userId, commands);

        emit BatchForwarded(msg.sender, userId, commands.length);
    }
}
