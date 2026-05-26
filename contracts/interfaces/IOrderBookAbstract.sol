// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./PublicStruct.sol";

interface IOrderBookAbstract {
    /// @return The minimum order quantity this orderbook will accept.
    /// Perpetual future orderbooks require quantities that are also a multiple of this.
    function readMinOrderQuantity() external view returns (uint64);
    function isHalted() external view returns (bool);

    // admin functions:
    function haltTrading(bool halt) external;
    function setMinOrderQuantity(uint64 minOrderQuantity) external;

    // these functions are for use by PriceHelper. Other contracts should not call these (will error out)
    function computeBuyMarketOrderSpecifyOut(MarketOrderPrice orderData) external returns (MarketOrderPriceResult);
    function computeSellMarketOrderSpecifyIn(MarketOrderPrice orderData) external returns (MarketOrderPriceResult);
    function computeBuyMarketOrderSpecifyIn(MarketOrderPrice orderData) external returns (MarketOrderPriceResult);
    function computeSellMarketOrderSpecifyOut(MarketOrderPrice orderData) external returns (MarketOrderPriceResult);

    /// the count functions should only be used in testing
    /// they consume a lot of gas for large orderbooks
    function countSellOrders() external view returns (uint);
    function countBuyOrders() external view returns (uint);

    /// these restricted count functions will limit gas usage
    /// 1000 should be reasonable safe for maxCount
    /// if maxCount is returned, the orderbook may contain more orders
    function countSellOrdersUpTo(uint32 maxCount) external view returns (uint);
    function countBuyOrdersUpTo(uint32 maxCount) external view returns (uint);
}
