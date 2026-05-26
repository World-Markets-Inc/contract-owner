// SPDX-License-Identifier: Apache-2.0
// Copyright Eulith Inc.
pragma solidity ^0.8.0;

import {IOrderBookAbstract} from "./IOrderBookAbstract.sol";
import "./PublicStruct.sol";

interface ISpotOrderBook is IOrderBookAbstract {
    // constructor:
    // constructor(address admin, address vault, TokenPair tokenPair, uint64 minOrderQuantity)

    event NewBuyOrder(uint256 indexed accountId, SpotOrderData eventOrderData);
    event CancelBuyOrder(uint256 indexed accountId, SpotOrderData eventOrderData);
    event NewTrade(uint64 indexed buyer, uint64 indexed seller, SpotMatchQuantities spotMatchQuantities, SpotMatchData spotMatchData);

    event NewSellOrder(uint256 indexed accountId, SpotOrderData eventOrderData);
    event CancelSellOrder(uint256 indexed accountId, SpotOrderData eventOrderData);

    function bestBidOffer() external view returns (BestBidOffer);

    /// position 0 of the array has the following information:\
    /// nextRestartPosition (64 bits) + actual returned length (32 bits)\
    /// actual returned length may be lower than maxDepth if we hit the end\
    /// nextRestartPosition can be used to read the rest of the depth chart in the next call\
    /// nextRestartPosition will be zero if the end is reached\
    /// this call aggregates orders at the same price into a "bucket"\
    /// and returns up to maxDepth buckets.\
    /// maxDepth values between 10 (quick/shallow) and 1000 (deep) are recommended\
    /// each array element after position 0 contains two buckets in the form:\
    /// quantity0 (MSB) | price0 | quantity1 | price1 (LSB)\
    /// for the buy chart, price0 is bigger than price1, and values appearing later in the array are\
    /// lower price. This is reversed for the sell chart
    function retrieveBuyDepthChart(uint32 maxDepth, uint64 restartPosition) external view returns (uint[] memory);

    /// see retrieveBuyDepthChart
    function retrieveSellDepthChart(uint32 maxDepth, uint64 restartPosition) external view returns (uint[] memory);

    /// if the price of the order being inserted is very far from the orderbook gap,
    /// the insertion cost will potentially be very high. By using this function and
    /// passing in the given insertion hint in the order, the cost can be reduced significantly.\
    /// minLength is the number of orders beyond the gap that must be present to get a non-zero hint.\
    /// the more active an orderbook, the higher minLength should be set.
    function calcBuyInsertionHint(Price59EN5 buyPrice, uint32 minLength) external view returns (uint64);

    /// see calcBuyInsertionHint
    function calcSellInsertionHint(Price59EN5 buyPrice, uint32 minLength) external view returns (uint64);

    /// retrieve single order data
    function retrieveBuyOrder(uint64 orderId) external view returns (SpotOrder);
    function retrieveSellOrder(uint64 orderId) external view returns (SpotOrder);

    // the returned array should be interpreted like this:\
    // 0th element: [OrderCursor](../PublicStruct.sol/type.OrderCursor.html)\
    // all other elements: [SpotOrderData](../PublicStruct.sol/type.SpotOrderData.html).\
    // entries beyond OrderCursor.size will be zero\
    // maxDepth should be something reasonable (like 1000)\
    // maxOrders should be roughly how many orders you expect back (presumably smaller than maxDepth)\
    // OrderCursor has a restartPosition field that can be used to search further\
    // if OrderCursor.restartPosition = 0xFFFF FFFF FFFF FFFF, the end of the list has been reached.\
    // restartPosition input parameter should be zero on first call\
    // search is performed from the highest price buy order to lowest (and vice versa for sells)\
    function searchBuyOrders(uint64 userId, uint32 maxDepth, uint32 maxOrders, uint64 restartPosition) external view returns (uint[] memory);
    function searchSellOrders(uint64 userId, uint32 maxDepth, uint32 maxOrders, uint64 restartPosition) external view returns (uint[] memory);
}
