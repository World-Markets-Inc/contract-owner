// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;
import "./PublicStruct.sol";

// all functions here must map to 0xffffffxx
interface IConcordProtocolBulk {
    // reads all token configs\
    // The array encode 3 pieces of information for each token: VaultTokenConfig, symbol, name\
    // each array slot is one of these (in order), so for each token 3 slots are used\
    // symbol and name are encoded as a single uint256 each\
    // the lowest byte of the unit256 is the length of the string, which may be up to 31\
    // symbol and name will be truncated if the actual length is bigger than 31\
    // to indicate truncation, the lowest byte is set to 0xFF\
    // The end of the array may contain zero entries that should be discarded\
    // @dev maps to 0xffffff01
    function bulkReadTokenConfigs_3423260018() external view returns (uint[] memory);

    // reads all the lending aggregate positions for the user (for all tokens)\
    // @dev maps to 0xffffff14
    function bulkReadLendingAgg_9676672908(uint64 userId, uint32 tokenId) external view returns (BulkLendAggPosition);

    // @dev maps to 0xffffff20
    function bulkReadMaxUserId_5445644137() external view returns (uint64);

    /// returns the funding rate history for the given time period\
    /// endTime is inclusive\
    /// if endTime is in the future, the current funding rate is simply repeated\
    /// it should be obvious that any funding rates for future cannot be relied upon\
    /// the zeroth array position is the funding rate for startTime and each value thereafter
    /// for 8 hours later
    // @dev maps to 0xffffff3b
    function readFundingRateHistory_4648699482(uint64 startTime, uint64 endTime, uint32 tokenId) external view returns(int16[] memory);

    /// change the admin address\
    /// only callable by super admin
    // @dev maps to 0xffffff42
    function changeAdmin_4970362591(address admin) external;

    /// return a list of traders for this account
    /// @dev maps to 0xffffff5a
    function bulkTraders_5523718714(uint64 userId) external view returns (address[] memory);

    /// cancel a bunch of trades in a lend orderbook
    /// @dev maps to 0xffffff68
//    function bulkAdminCancel_5611655951(address orderBook, uint[] calldata userAndPrice, bool sellSide) external;

    /// cancels up to maxCount trades in lendbook, then switches books.
    /// ensures no orders are left behind
    /// @dev maps to 0xffffff78
//    function bulkAdminSwitchLendBook_3070019509(address oldBookAddr, address newBookAddr, uint maxCount, uint32 tokenId) external;

    // cancels up to maxCount trades in lendbook, switches books, then inserts the specified new orders
    // @dev maps to 0xffffff76
    function bulkAdminSwitchLendBook_5162910367(address oldBookAddr, address newBookAddr, uint maxCount, uint32 tokenId, LendOrder[] calldata buySide, LendOrder[] calldata sellSide) external;

    // @dev maps to 0xffffff88
    function setTokenConfig_7367129508(uint32 tokenId, uint8 riskPricePercent, uint8 riskSlippagePercentx10) external;

    // @dev maps to 0xffffff97
    function switchTokenAddress_1740783989(uint32 tokenId, address newAddress, uint64[] calldata users) external;

    // @dev maps to 0xffffffa1
    function liqSwap_7381398119(uint64 userToLiquidate, LiqSwapTrade offer, uint64 pastDueLendingId) external;

//    /// @dev maps to 0xffffffb6
//    function makeWhole_6935298843(uint64 fromUser, uint64 toUser, uint128 amount, uint32 tokenId) external;
}
