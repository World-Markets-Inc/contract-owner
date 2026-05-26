// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// custom errors for Concord Exchange
library ExchangeErrors {
    error NoSuchPosition(); //0xabc24034
    error WrongOrderBook(); //0x73e44a3b
    error UserAlreadyExists(); // 0xc344397e
    error NoOrderBookRegistered(); //0xa8d98440
    error TooManyUsers(); //0xd5931657
    error InvalidTokenId(); //0x3f6cc768
    error TokenNotDefined(); //0x94b1fbfa
    error InvalidErc20Address(); //0x699a269e
    error PositionDecimalsTooLarge(); //0x8075cdef
    error VaultDecimalsTooLarge(); //0xa4bcee54
    error TooManyTokens(); //0x748e67b2
    error FromTokenInvalid(); //0x70802daf
    error ToTokenInvalid(); //0xffd9d17d
    error OrderbookAlreadyRegistered(); //0x1b658c00
    error BalanceTooLow(); //0xa3281672
    error TokenNotErc20(); //0x0bcbb816
    error DustNotAllowed(); //0x884f8896
    error TransferFailed(); //0x90b8ec18
    error CallerNotPermissioned(); //0xaebf6f28
    error CallerIsNotTrader(); //0xd07a9d6b
    error PriceNotNormalized(); //0x140bce5e
    error ZeroPriceNotAllowed(); //0xa2b326dd
    error PriceTooBig(); //0x9bec8e38
    error ReduceQuantityTooLarge(); //0x079ae22d
    error WrongQuantityReduction(); //0xbc2eb0c3
    error QuantityTooLow(); //0x7d92b186
    error ZeroMaxDepth(); //0x0e90ed5f
    error NoSuchOrder(); //0x1e4c1983
    error RestartPointerCorrupt(); //0x98a9acb3
    error StartTooLarge(); //0x8258d890
    error UnableToFillCompletely(); //0xd3ca5fc4
    error InsertionHintStale(); // 0xd7170efd
    error OnlyLimitWithInsertionHint(); //0x6f535270
    error QuantityNotMultipleOfMin(); //0x90ac740b
    error InvalidTimeValues(); //0x2a6a2a83
    error TradeOrWithdrawCausesLiquidation(); //0xc4ffe9f4
    error InvalidBatchCommand(); //0xf445d2a9
    error NoSelfDealing();//0x62afea92
    error PortfolioNotEligibleForLiquidation(); //0xeca34222
    error LoanNotEligibleForRenew(); //0xa0e1b0fd
    error LiquidationNotSuccessful(); //0x62a8087e
    error PaymentTooHigh(); //0xda6a9814
    error EscrowRedeemTooSoon(); //0x4cc4f9fb
    error CallerHasNoAccount(); //0xfb64298d
    error QuantityTooHigh(); //0x949deefe
    error TradingHalted(); // 0x8401291e
    error NoLiquidationLending(); // 0x930de4eb
    error BorrowLiquidationTooHigh(); // 0xb4c598e3
    error BuyLiquidationTooHigh(); // 0x8b6305ec
    error LimitOrderNotAllowedForLiquidation(); // 0xc37aed17
    error LiquidationPriceOutOfRange(); // 0x18909e76
    error LiquidationCloseBorrowBeforeSell(); // 0x5adea9be
    error LiquidationMustReducePerp(); // 0xe5acd72d
    error FundingRateNotInitialized(); // 0x6d9340be
    error TotalLimitOrdersTooLarge();
    error InvalidUserId();
    error LiqSwapOnlyToLowerRisk();
    error LiqSwapHasSpotBook();
    error LiqSwapUnfairPrice();

    // should not happen in normal sdk calls
    error AdminRoleOnly(); //0x10c95c62
    error OpsRoleOnly();
    error ExchangeOnlyCall(); //0x26e41fb0
    error MarkPriceNotConfigured(); //0xe2886e06

    // internal errors. if these trigger, there is a serious bug
    error ZeroAmountSequestered(); //0xd6461b7a
    error WrongSequesterAmount(); //0x1bd1dd8a
    error CantStoreZero(); //0x42c1dde9
    error ListTooLong(); //0x0fa633c4
    error ValueNotFound(); //0x4a366446
    error NoNextElement(); //0x9349665b

    // the following is only used during debugging and will never appear in actual code
    // it produces an error that looks like:
    // revert DebugUint(0x1234):
    // 0xf0ed029e0000000000000000000000000000000000000000000000000000000000001234
    error DebugUint(uint);
    error DebugInt(int256);

}
