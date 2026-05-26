// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "./PublicStruct.sol";

struct ExactInputSingleParams {
    address tokenIn;
    address tokenOut;
    uint24 fee; //ignored
    address recipient; //ignored
    uint256 deadline;
    uint256 amountIn;
    uint256 amountOutMinimum;
    uint160 sqrtPriceLimitX96;
}

struct ExactOutputSingleParams {
    address tokenIn;
    address tokenOut;
    uint24 fee;  //ignored
    address recipient; //ignored
    uint256 deadline;
    uint256 amountOut;
    uint256 amountInMaximum;
    uint160 sqrtPriceLimitX96;
}

/// all amounts are in 64 bit position decimals\\
/// BitFormat: isBuy (1) | tokenId (32) | deadline (64) | amountOutMin (64) | amountIn (64)
type SwapInputAmountIn is uint256;

library SwapInputAmountInLib {
    function create(uint64 _amountIn, uint64 _amountOutMin, uint64 _deadline, uint32 _tokenId, bool _isBuy) internal pure returns (SwapInputAmountIn) {
        return SwapInputAmountIn.wrap(uint(_amountIn) | (uint(_amountOutMin) << 64) |
        (uint(_deadline) << 128) | (uint(_tokenId) << 192) | (uint(_isBuy ? 1 : 0) << 224));
    }

    function amountIn(SwapInputAmountIn _in) internal pure returns (uint64) {
        return uint64(SwapInputAmountIn.unwrap(_in));
    }

    function amountOutMin(SwapInputAmountIn _in) internal pure returns (uint64) {
        return uint64(SwapInputAmountIn.unwrap(_in) >> 64);
    }

    function deadline(SwapInputAmountIn _in) internal pure returns (uint64) {
        return uint64(SwapInputAmountIn.unwrap(_in) >> 128);
    }

    function tokenId(SwapInputAmountIn _in) internal pure returns (uint32) {
        return uint32(SwapInputAmountIn.unwrap(_in) >> 192);
    }

    function isBuy(SwapInputAmountIn _in) internal pure returns (bool) {
        return (SwapInputAmountIn.unwrap(_in) & (1 << 224)) != 0;
    }
}

using {
SwapInputAmountInLib.amountIn,
SwapInputAmountInLib.amountOutMin,
SwapInputAmountInLib.deadline,
SwapInputAmountInLib.tokenId,
SwapInputAmountInLib.isBuy
} for SwapInputAmountIn global;

/// all amounts are in 64 bit position decimals\\
/// BitFormat: isBuy (1) | tokenId (32) | deadline (64) | amountInMax (64) | amountOut (64)
type SwapInputAmountOut is uint256;

library SwapInputAmountOutLib {
    function create(uint64 _amountOut, uint64 _amountInMax, uint64 _deadline, uint32 _tokenId, bool _isBuy) internal pure returns (SwapInputAmountOut) {
        return SwapInputAmountOut.wrap(uint(_amountOut) | (uint(_amountInMax) << 64) |
        (uint(_deadline) << 128) | (uint(_tokenId) << 192) | (uint(_isBuy ? 1 : 0) << 224));
    }

    function amountOut(SwapInputAmountOut _in) internal pure returns (uint64) {
        return uint64(SwapInputAmountOut.unwrap(_in));
    }

    function amountInMax(SwapInputAmountOut _in) internal pure returns (uint64) {
        return uint64(SwapInputAmountOut.unwrap(_in) >> 64);
    }

    function deadline(SwapInputAmountOut _in) internal pure returns (uint64) {
        return uint64(SwapInputAmountOut.unwrap(_in) >> 128);
    }

    function tokenId(SwapInputAmountOut _in) internal pure returns (uint32) {
        return uint32(SwapInputAmountOut.unwrap(_in) >> 192);
    }

    function isBuy(SwapInputAmountOut _in) internal pure returns (bool) {
        return (SwapInputAmountOut.unwrap(_in) & (1 << 224)) != 0;
    }
}

using {
SwapInputAmountOutLib.amountOut,
SwapInputAmountOutLib.amountInMax,
SwapInputAmountOutLib.deadline,
SwapInputAmountOutLib.tokenId,
SwapInputAmountOutLib.isBuy
} for SwapInputAmountOut global;

type SwapInputPriceParams is uint256;

// BitFormat: 
type TradeResult is uint256;

library SwapErrors {
    error CantSwapForAmount(); //0x2256e4c8
    error DeadlinePassed();
    error BadTokenId();
    error Erc20TransferFailed();
    error SqrtPriceNotSupported();
    error NativeCurrencyNotSupported();
}

interface ISwapRouter {
    /// specify amountIn, amountOutMin. price is not specified\
    /// swap is always between a token and base token (nominally usd)\
    /// all amounts are in 64 bit position decimals as defined by the exchange\
    /// if isBuy is true, amountIn represents base token value, otherwise, for a sell, amountIn represents the token being sold\
    /// returns amountOut
    function swapByAmountInViaMinOut(SwapInputAmountIn orderParams) external returns (uint64);

    /// specify amountOut (exact) and restrict amountIn via amountInMax\
    /// if isBuy is true, amountOut represents token value being bought, otherwise, for a sell, amountOut represents the base token (nominally USD)\
    /// swap is always between a token and base token (nominally USD)\
    /// all amounts are in 64 bit position decimals as defined by the exchange\
    /// returns amountIn
    function swapByAmountOutViaMaxIn(SwapInputAmountOut orderParams) external returns (uint64);

    /// specify amountOut (exact) and restrict amountIn via amountInMax\
    /// if isBuy is true, amountOut represents token value being bought, otherwise, for a sell, amountOut represents the base token (nominally USD)\
    /// swap is always between a token and base token (nominally USD)\
    /// all amounts are in 64 bit position decimals as defined by the exchange\
    /// returns the MarketOrderPriceResult, which contains the order quantity and price required to achieve this amountOut\
    /// may return zero or partial amounts, so the values returned should be checked before putting in an order
    function priceByAmountOut(SwapInputAmountOut orderParams) external view returns (MarketOrderPriceResult);

    /// specify amountIn, amountOutMin. price is not specified\
    /// swap is always between a token and base token (nominally usd)\
    /// all amounts are in 64 bit position decimals as defined by the exchange\
    /// if isBuy is true, amountIn represents base token value, otherwise, for a sell, amountIn represents the token being sold\
    /// returns the MarketOrderPriceResult, which contains the order quantity and price required to achieve this amountIn\
    /// may return zero or partial amounts, so the values returned should be checked before putting in an order
    function priceByAmountIn(SwapInputAmountIn orderParams) external view returns (MarketOrderPriceResult);

    /// one of the two tokens must be the exchange's base currency (nominally USD)\
    /// sqrtPriceLimitX96 is not supported and must be zero\
    /// recipient and fee values are ignored\
    function exactInputSingle(ExactInputSingleParams calldata params) external returns (uint256 amountOut);

    /// one of the two tokens must be the exchange's base currency (nominally USD)\
    /// sqrtPriceLimitX96 is not supported and must be zero\
    /// recipient and fee values are ignored\
    /// must not send any eth\
    function exactOutputSingle(ExactOutputSingleParams calldata params) external payable returns (uint256 amountIn);
}
