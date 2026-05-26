// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./PublicStruct.sol";

interface IConcordProtocolTrading {
    // constructor:
    // constructor(address admin)

    event LendPositionClosed(uint64 indexed positionId, LendMatch lendMatch);
    event LendPositionChanged(uint64 indexed positionId, LendingEventData lendMatch);
    event LendMatchNonReturnable(uint64 indexed positionId);
    event InterestPaid(uint64 indexed positionId, InterestPaidData interestAndFees);
    event PerpTrueUp(uint64 indexed longUserId, uint64 indexed shortUserId, PerpTrueUpData data);
    event LenderSwap(uint64 indexed srcPositionId, uint64 indexed destPositionId, uint64 newPositionId, LendMatch newPosition, uint128 paymentInLieuOfInterest);
    /// the lower 32 bits of liquidation id is time in minutes since Jan 1 2024
    event Liquidation(uint64 indexed userId, LiquidationPayoff liquidatoinPayoff);
    event BankruptcyLossEvent(uint64 indexed userId, BankruptcyLoss loss);
    event BankruptcyDebtLossEvent(uint64 indexed lender, uint64 indexed borrower, BankruptcyDebtLoss loss);
    event RenewLoan(uint64 indexed borrowerId, RenewLoanData data);
    event LiqSwap(uint64 indexed userToLiquidate, LiqSwapTrade trade);

    event MadeWhole(uint64 indexed fromUser, uint64 indexed toUser, uint128 amount, uint32 tokenId);
    /// Create a new spot buy order. Order may be matched immediately or inserted into
    /// the orderbook, depending on the order type.
    /// @param orderBook address should be retrieved from the exchange using [getOrderBook](../IConcordProtocolReadOnly.sol/interface.IConcordProtocolReadOnly.html#getorderbook)
    /// @param orderData is [SpotOrder](../PublicStruct.sol/type.SpotOrder.html)
    function newSpotBuyOrder(address orderBook, SpotOrder orderData) external;
    /// crate a new spot sell order.\
    /// see newSpotBuyOrder documentation.
    function newSpotSellOrder(address orderBook, SpotOrder orderData) external;
    /// cancel a spot buy order.
    /// @param orderBook address should be the same as the one used to create the order.
    /// @param cancelOrderData is [SpotCancelOrderData](../PublicStruct.sol/type.SpotCancelOrderData.html)
    function cancelSpotBuyOrder(address orderBook, SpotCancelOrderData cancelOrderData) external;
    /// cancel a spot sell order.
    /// @param orderBook address should be the same as the one used to create the order.
    /// @param cancelOrderData is [SpotCancelOrderData](../PublicStruct.sol/type.SpotCancelOrderData.html)
    function cancelSpotSellOrder(address orderBook, SpotCancelOrderData cancelOrderData) external;

    /// Create a new perpetual future buy order. Order may be matched immediately or inserted into
    /// the orderbook, depending on the order type.
    /// @param orderBook address should be retrieved from the exchange using [getPerpOrderBook](../IConcordProtocolReadOnly.sol/interface.IConcordProtocolReadOnly.html#getperporderbook)
    /// @param orderData is [PerpOrder](../PublicStruct.sol/type.PerpOrder.html)
    function newPerpBuyOrder(address orderBook, PerpOrder orderData) external;
    /// Create a new perpetual future buy order.
    /// see documentation for the buy side.
    function newPerpSellOrder(address orderBook, PerpOrder orderData) external;
    /// cancel a perpetual future buy order.
    /// @param orderBook address should be the same as the one used to create the order.
    /// @param cancelOrderData is [PerpCancelOrderData](../PublicStruct.sol/type.PerpCancelOrderData.html)
    function cancelPerpBuyOrder(address orderBook, PerpCancelOrderData cancelOrderData) external;
    /// cancel a perpetual future sell order.
    /// @param orderBook address should be the same as the one used to create the order.
    /// @param cancelOrderData is [PerpCancelOrderData](../PublicStruct.sol/type.PerpCancelOrderData.html)
    function cancelPerpSellOrder(address orderBook, PerpCancelOrderData cancelOrderData) external;

    /// lending orders don't generate an order id
    /// the order is always identified by the userId + price
    /// creating two orders with the same price adds the two quantities together
    function newBorrowOrder(address orderBook, LendOrder orderData) external;
    function newLendOrder(address orderBook, LendOrder orderData) external;
    /// the quantity specified in the cancel function reduces the original order quantity
    /// it must therefore be less than or equal to the remaining quantity
    /// if the passed in quantity is zero, the entire order is canceled
    function cancelBorrowOrder(address orderBook, LendOrder cancelOrderData) external;
    function cancelLendOrder(address orderBook, LendOrder cancelOrderData) external;


    /// pay the interest and fees due right now. returns new positionId if applicable or zero if closed.\
    /// interest and fees are always due on the full position quantity.\
    /// interest is computed to the end of the next full hour.\
    /// if a non-zero reduceQuantity is specified, any continuation of this position will have a reduced quantity
    /// do one the following to this position based on extendPeriod:\
    /// false ---> continue the position remainder until current expiry (returns a new position id, or zero if reduceQuantity == current quantity).\
    /// true  ---> extend the position remainder expiry for another 10 days (only possible if position is returnable) (returns a new position id)\
    /// zero interest loans may not be extended.\
    /// the new position, if any, starts at the end of the next full hour.\
    /// if this function is called during the last hour of the borrow period, and extendPeriod is false, the position is closed.\
    function payInterestAndFees(uint64 positionId, uint64 reduceQuantity, bool extendPeriod) external;

    /// may only be called by a lender\
    /// when the position is closed, it is no longer returned to the orderbook
    function markLendPositionAsNonReturnable(uint64 positionId) external;

    /// the commands array is a sequence of [BatchCommand](../PublicStruct.sol/type.BatchCommand.html)
    /// and related data:  [BatchCancelRebook](../PublicStruct.sol/type.BatchCancelRebook.html) must
    /// follow a cancel-rebook command.\
    /// this function performs all the actions in a single transaction without checking portfolio liquidation
    /// in the middle. liquidation threshold is only checked at the end.\
    /// Some command may only be called during a call to liquidate, not directly to batchCommands.\
    function batchCommands(uint64 userId, uint[] calldata commands) external;

    /// To use this function:\
    /// 1) A lender must have a lent position with lentPositionId\
    /// 2) The lender must borrow the same token before calling this function\
    /// 3) The lender can then swap in whoever is lending to them as the lender for the lender's lent position\
    /// if there is insufficient quantity to replace the loan, the function does as much as possible.\
    /// That means if the lender forgets to do (2) above, the function does nothing.\
    /// example: Bob has lent Alice 1 BTC.\
    /// Bob needs the BTC back (or Bob is being liquidated, so the position must be expunged).\
    /// Bob goes to the lending book for BTC and borrows 1 BTC, from Joe (0.3) and Jane (0.7).\
    /// Bob then calls this function, passing in the Bob-Alice position id.\
    /// this function will create two positions: Joe-Alice (0.3) and Jane-Alice (0.7)\
    /// the positions are created in LIFO order from Bob's borrows.\
    /// The difference in interest rate for the lifetime of the Bob-Alice position is settled immediately.\
    /// If the interest rate for Bob-Alice is higher, Bob loses what is due and Jane/Joe profit.\
    /// If the interest rate for Bob-Alice is lower, Bob pays Joe/Jane for the difference.\
    /// Therefore, the interest rate on the new Joe-Alice and Jane-Alice positions are the same as
    /// the interest rate of Bob-Alice.\
    function lifoLenderSwap(uint64 lentPositionId) external;

    /// liquidate userToLiquidate\
    /// userToLiquidate's risk adjusted portfolio value must be negative or there must be
    /// a past due lending position (as designated by the pastDueLendPositionId)\
    /// the same portfolio value must be positive after the batch commands\
    /// Up to 1% of the resulting value may be taken as specified by payToken & payAmount
    /// to userToPay.\
    /// generates a Liquidation event\
    function liquidate(uint64 userToLiquidate, uint64 userToPay, uint64 pastDueLendingId) external;

    /// when a user goes bankrupt, OPS role can call this
    /// maxLossRatio has the same units as interest rate (10000 == 1.0)
    function bankruptcy(uint64 userToLiquidate, uint16 maxLossRatio) external;

    /// a loan that is due in 6 hours or less may be renewed by anyone for a small payout
    /// the loan is extended if possible. If not, the current loan is closed and a new loan
    /// is taken out at the same rate (or better). If anything fails, the function reverts.
    /// the fee is 1% of the minimum order size for the loan book
    function renewLoan(uint64 user, uint64 userToPay, uint64 almostDueLendingId) external;

        /// changes the position's price to current mark price and settles any difference\
    /// this is an economically neutral action and not necessary for small price moves\
    /// The side that is owed, however, may choose to do this to have access to liquid funds\
    /// The side that owes will pay immediately, but if they can't, they issue a 24 hour
    /// no-interest debt to the other side. Failure to pay this debt in time will result in
    /// liquidation.
    function requestPerpTrueUp(uint64 longId, uint64 shortId, uint32 tokenId) external;

    /// used to write down the averaged funding rate if the time is past the 7.5 hour mark
    /// normally, this happens as part of trading, but if there are no trades, this can be
    /// used to write the rate.
    function computeFundingRateNow(uint32 tokenId) external;
        // not implemented:

    // spot aggregator api

    // simulate a trade and return user portfolio value (regular and risk adjusted)
}
