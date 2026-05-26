// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "./PublicStruct.sol";

/// functions for user account creation, trading permissions, and deposit/withdraw
interface IConcordProtocolUser {
    event NewUser(address indexed userAddress, uint64 userId); //userId is actually 44 bits
    event Erc20Deposit(address indexed user, address erc20, uint amount);
    event Erc20Withdraw(address indexed user, address erc20, uint amount);
    /// if allowTradingForAccount is called, permissioned is true.\
    /// if revokeTradingForAccount is called, permissioned is false.
    event TraderPermission(uint64 indexed user, address indexed trader, bool permissioned);

    /// creates an account for msg.sender.\
    /// msg.sender is the owner of this account and may deposit/withdraw and trade.
    /// @return the exchange account id that must be in all trading calls
    function createAccount() external returns (uint64);
    /// combination of createAccount and depositErc20
    function createAccountAndDeposit(address erc20, uint256 amount) external returns (uint64);
    /// allows delegating trading rights (but not deposit/withdraw) to another ethereum address
    /// the trading address does NOT need to call createAccount
    function allowTradingForAccount(uint64 accountId, address tradingAddress) external;
    /// revokes trading rights.
    function revokeTradingForAccount(uint64 accountId, address tradingAddress) external;
    /// deposits an ERC20 token into the exchange.
    /// @param erc20 must be one supported by the exchange
    /// @param amount in native erc20 decimals
    function depositErc20(address erc20, uint256 amount) external;
    /// withdraws an ERC20 token into the exchange. withdraws are subject to checks against
    /// portfolio value and live outstanding orders
    /// @param erc20 must be one supported by the exchange
    /// @param amount in native erc20 decimals
    function withdrawErc20(address erc20, uint256 amount) external;
    //below not implemented
}

