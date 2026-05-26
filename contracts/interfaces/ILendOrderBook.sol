// SPDX-License-Identifier: Apache-2.0
// Copyright Eulith Inc.
pragma solidity ^0.8.0;

import {IOrderBookAbstract} from "./IOrderBookAbstract.sol";
import "./PublicStruct.sol";

interface ILendOrderBook is IOrderBookAbstract {
    // constructor:
    // constructor(address admin, address vault, uint32 tokenId, uint64 minOrderQuantity)

    event NewBuyOrder(uint256 indexed accountId, LendOrder orderData);
    event CancelBuyOrder(uint256 indexed accountId, LendOrder orderData);
    /// lower 32 bits of positionId is the startTime. See LendingPosition.startTime in PublicStruct.sol
    event NewTrade(uint64 indexed borrower, uint64 indexed lender, LendMatch matchData, uint64 positionId);
    event LendSelfMatchAutoCancel(uint64 indexed userId, uint64 quantity, uint16 interestRate);

    event NewSellOrder(uint256 indexed accountId, LendOrder orderData);
    event CancelSellOrder(uint256 indexed accountId, LendOrder orderData);

    function bestBidOffer() external view returns (BestBidOffer);

    /// position 0 of the array is a LendBookStreamStart, which includes the stream length (total # of quantity/price pairs)\
    /// the last position of the array is a LendBookStreamEnd, which contains a restartPosition (if applicable)\
    /// array values in between are LendBookStreamTriplet (3 quantity/price pairs)\
    /// actual returned length may be lower than maxDepth if we hit the end\
    /// the returned restartPosition in LendBookStreamEnd can be used to read the rest of the depth chart in the next call
    function retrieveBuyDepthChart(uint16 maxDepth, uint16 restartPosition) external view returns (uint[] memory);

    /// same as retrieveBuyDepthChart
    function retrieveSellDepthChart(uint16 maxDepth, uint16 restartPosition) external view returns (uint[] memory);

    /// read the quantity for an order, given a user and interest rate.\
    /// returns 0 if there is no order
    function readLendQuantity(uint64 userId, uint16 interest) external view returns(uint64);
    function readBorrowQuantity(uint64 userId, uint16 interest) external view returns(uint64);

    // the returned array should be interpreted like this:\
    // 0th element: [OrderCursor](../PublicStruct.sol/type.OrderCursor.html)\
    // all other elements: [LendSearchResult](../PublicStruct.sol/type.LendSearchResult.html).\
    // entries beyond OrderCursor.size will be zero\
    // maxOrders should be roughly how many orders you expect back (1000 is reasonable if doing a read only call)\
    // OrderCursor has a restartPosition field that can be used to search further\
    // if OrderCursor.restartPosition = 0xFFFF FFFF FFFF FFFF, the end has been reached.\
    // restartPosition input parameter should be zero on first call\
    // search is performed from the highest price buy order to lowest (and vice versa for sells)\
    // warning: the order of the triplet in LendSearchResult is the reverse of LendBookStreamTriplet\
    function searchBuyOrders(uint64 userId, uint32 maxOrders, uint64 restartPosition) external view returns (uint[] memory);
    function searchSellOrders(uint64 userId, uint32 maxOrders, uint64 restartPosition) external view returns (uint[] memory);

}
