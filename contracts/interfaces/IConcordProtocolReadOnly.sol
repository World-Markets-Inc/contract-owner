// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./PublicStruct.sol";

/// decimals:\
/// the exchange keeps track of 3 decimals: 1) The native erc20 decimals 2) the vault ledger decimals 3) order/position decimals\
/// each one is less than or equal to the previous\
/// the vault ledger is 128bit integers, with vault decimals, which may be lower than erc20 decimals\
/// the order/position quantity values are 64bit integers, with order/position decimals, which are usually lower than vault decimals
interface IConcordProtocolReadOnly {
    /// zero return means user is not registered
    function getUserId(address userAddress) external view returns (uint64);
    /// zero means this is not a valid userId
    function getUserAddress(uint64 userId) external view returns (address);
    /// the token configuration contains the decimals used in erc20, vault and order/position
    /// @return [VaultTokenConfig](../PublicStruct.sol/type.VaultTokenConfig.html)
    function readTokenConfig(uint32 tokenId) external view returns (VaultTokenConfig);
    /// @return [VaultTokenConfig](../PublicStruct.sol/type.VaultTokenConfig.html)
    function getDefaultErc20TokenConfig(address erc20) external view returns (VaultTokenConfig);

    /// @return [OrderBookConfig](../PublicStruct.sol/type.OrderBookConfig.html)
    /// returns all zeros if not a registered orderbook
    /// OrderBookConfig.bookType() can be used to get the type of orderbook (spot/perp/lend)
    function readOrderBookConfig(address book) external view returns(OrderBookConfig);

    /// returns the spot order book for the given token pair\
    /// returns all zeros if no such orderbook exists.
    function getSpotOrderBook(uint32 token1, uint32 token2) external view returns (address, uint32 buyToken, uint32 payToken);

    /// returns the user balance and the sequestered amounts.\
    /// first sequestered amount is for lending and spot
    /// second sequestered amount is for perps
    /// when an order is placed in a book, some amount (depending on type of book) is sequestered
    /// the actual balance is not reduced; the sequestered amount is increased instead.
    function getBalance(uint64 user, uint32 tokenId) external view returns (uint128,uint64,uint64);

    /// returns the perpetuals future order book. returns all zeros if no orderbook exists for these tokens
    function getPerpOrderBook(uint32 token1, uint32 token2) external view returns (address, uint32 buyToken, uint32 payToken);

    /// returns the lend/borrow order book. returns zero if no lend/borrow orderbook exists for this token
    function getLendOrderBook(uint32 tokenId) external view returns (address);

    // retrieves the [LendFeeSchedule](../PublicStruct.sol/type.LendFeeSchedule.html) for this token
    function getLendFeeSchedule(uint32 tokenId) external view returns (LendFeeSchedule);

    /// Returns an array of values.\
    /// The zeroth element is special and contains the total list length (regardless of what max or startPosition are).\
    /// All other elements are [LendingPosition](../PublicStruct.sol/type.LendingPosition.html) structs.\
    /// The full list can be retrieved by using zero as the max value and zero for startPosition.\
    /// A partial list can also be retrieved: max limits the number of entries coming back to (max+1) (position 0 is special).\
    /// startPosition dictates where the list should start from\
    /// if the list is empty, an array of length one will return. the zeroth element will contain "0"\
    /// for example, if the list is 17 long, it can be retrieved like this:\
    /// max = 0, startPosition = 0 -> an array of length 18\
    /// or\
    /// max = 10, startPosition = 0 -> an array of length 11, the zeroth element will contain "17"\
    ///                                elements 1 through 10 are LendingPosition structs\
    /// max = 7, startPosition = 10 -> an array of length 8, the zeroth element will contain "17"
    function readLenderPositions(uint64 accountId, uint32 tokenId, uint32 max, uint32 startPosition) external view returns(uint256[] memory);

    /// see documentation for readLenderPositions
    function readBorrowerPositions(uint64 accountId, uint32 tokenId, uint32 max, uint32 startPosition) external view returns(uint256[] memory);

    /// read a lending position.\
    /// @return [LendMatch](../PublicStruct.sol/type.LendMatch.html)
    function readLendingPosition(uint64 positionId) external view returns(LendMatch);

    /// returns the lending aggregate position for this user and token\
    /// @return [LendAggPosition](../PublicStruct.sol/type.LendAggPosition.html)
    function readLendingAggregation(uint64 userId, uint32 tokenId) external view returns (LendAggPosition);

    /// returns the total interest and fees due for this position.\
    /// the return value is in vault decimals
    function calculateInterestAndFeesDue(uint64 positionId) external view returns(uint128);

    /// return the highest token id that's registered.
    function getHighestTokenId() external view returns (uint32);

    /// returns the equivalent aggregated perp position for this user and token
    /// @return [PerpAggPosition](../PublicStruct.sol/type.PerpAggPosition.html)
    function readPerpAggPosition(uint64 userId, uint32 tokenId) external view returns(PerpAggPosition, int256);

    /// see the documentation for readLenderPositions. Instead of LendingPosition,
    /// this function returns [PerpPosition](../PublicStruct.sol/type.PerpPosition.html)
    /// in array position 1 or higher.\
    /// some returned positions may have zero quantity. they should be filtered out client side.
    function readPerpPositions(uint64 accountId, uint32 tokenId, uint32 max, uint32 startPosition) external view returns(uint256[] memory);

    /// returns the funding rate for the given standard unix time
    /// the funding rate has a divisor of 10^7
    function readFundingRate(uint64 time, uint32 tokenId) external view returns(int16);

    /// returns the risk adjusted portfolio value for a user\
    /// may be negative, in which case, the portfolio is eligible for liquidation\
    /// the entire portfolio is valued in the base token, with position decimal accuracy
    function riskAdjustedPortfolioValue(uint64 userId) external view returns (int64);

    /// returns the debt and no-debt first 256bit bitset\
    /// the low 32bits are the max set bit\
    /// the rest of the bits correspond to the tokens, so for example bit 33 is for the base token\
    /// mostly used for testing and optimizing UI portfolio fetches
    function userBits(uint64 userId) external view returns (uint256, uint256);

    /// reads the configured mark price for the token
    function getMarkPrice(uint32 tokenId) external view returns (Price59EN5);

    function getMarkPriceConfig(uint32 tokenId) external view returns (MarkPriceConfig);

    function summedFundingRate(uint32 tokenId, uint32 from, uint32 to) external view returns (int32);

    function readFundingRateStats(uint32 tokenId) external view returns (FundingRateStats);
        // not implemented:
    // get user portfolio value
}
