// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ExchangeErrors} from "./IConcordProtocolErrors.sol";
import "./ConfigConstants.sol";

library PublicStruct {

}

uint constant CLIENT_ID_MASK = (~uint(0)) >> (256-44);
uint constant OWED_MASK = (~uint(0)) >> (256-55);
uint constant SIX_BIT_MASK = (~uint(0)) >> (256-6);

uint constant BLANK_BIT_AT_44 = ~(uint(1) << 44);
uint constant BLANK_BIT_AT_160 = ~(uint(1) << 160);
uint constant BLANK_BIT_AT_161 = ~(uint(1) << 161);
uint constant BLANK_BIT_AT_233 = ~(uint(1) << 233);
uint constant BLANK_FOUR_AT_124 = ~(uint(0xf) << 124);
uint constant BLANK_EIGHT_AT_96 = ~(uint(0xff) << 96);
uint constant BLANK_EIGHT_AT_104 = ~(uint(0xff) << 104);
uint constant BLANK_EIGHT_AT_112 = ~(uint(0xff) << 112);
uint constant BLANK_EIGHT_AT_124 = ~(uint(0xff) << 124);
uint constant BLANK_EIGHT_AT_128 = ~(uint(0xff) << 128);
uint constant BLANK_EIGHT_AT_232 = ~(uint(0xff) << 232);
uint constant BLANK_EIGHT_AT_240 = ~(uint(0xff) << 240);
uint constant BLANK_EIGHT_AT_248 = ~(uint(0xff) << 248);
uint constant BLANK_SIXTEEN_AT_128 = ~(((~uint(0)) >> (256-16)) << 128);
uint constant BLANK_SIXTEEN_AT_144 = ~(((~uint(0)) >> (256-16)) << 144);
uint constant BLANK_SIXTEEN_AT_200 = ~(((~uint(0)) >> (256-16)) << 200);
uint constant BLANK_SIXTEEN_AT_216 = ~(((~uint(0)) >> (256-16)) << 216);
uint constant BLANK_THIRTY_TWO_AT_ZERO = ~(((~uint(0)) >> (256-32)));
uint constant BLANK_THIRTY_TWO_AT_32 = ~(((~uint(0)) >> (256-32)) << 32);
uint constant BLANK_THIRTY_TWO_AT_96 = ~(((~uint(0)) >> (256-32)) << 96);
uint constant BLANK_THIRTY_TWO_AT_128 = ~(((~uint(0)) >> (256-32)) << 128);
uint constant BLANK_THIRTY_TWO_AT_160 = ~(((~uint(0)) >> (256-32)) << 160);
uint constant BLANK_THIRTY_TWO_AT_192 = ~(((~uint(0)) >> (256-32)) << 192);
uint constant BLANK_THIRTY_TWO_AT_200 = ~(((~uint(0)) >> (256-32)) << 200);
uint constant BLANK_THIRTY_TWO_AT_224 = ~(((~uint(0)) >> (256-32)) << 224);
uint constant BLANK_FORTY_FOUR_AT_64 = ~(((~uint(0)) >> (256-44)) << 64);
uint constant BLANK_FORTY_FOUR_AT_129 = ~(((~uint(0)) >> (256-44)) << 129);
uint constant BLANK_SIXTY_FOUR_AT_0 = ~((~uint(0)) >> (256-64));
uint constant BLANK_SIXTY_FOUR_AT_16 = ~(((~uint(0)) >> (256-64)) << 16);
uint constant BLANK_SIXTY_FOUR_AT_48 = ~(((~uint(0)) >> (256-64)) << 48);
uint constant BLANK_SIXTY_FOUR_AT_64 = ~(((~uint(0)) >> (256-64)) << 64);
uint constant BLANK_SIXTY_FOUR_AT_128 = ~(((~uint(0)) >> (256-64)) << 128);
uint constant BLANK_SIXTY_FOUR_AT_174 = ~(((~uint(0)) >> (256-64)) << 174);
uint constant BLANK_NINTEY_SIX_AT_128 = ~(((~uint(0)) >> (256-96)) << 128);
uint constant BLANK_FIFTY_FIVE_AT_64 = ~(((~uint(0)) >> (256-55)) << 64);
uint constant BLANK_FIFTY_FIVE_AT_119 = ~(((~uint(0)) >> (256-55)) << 119);
uint constant ONE_SEVENTY_TWO_AT_ZERO = ((~uint(0)) >> (256-172));

uint constant PRICE_EXP_MASK = (~uint(0)) >> (256-5);


// the w functions widen their argument to uint efficiently
function wb(bool v) pure returns(uint) {
    uint r;
    assembly {
        r := v
    }
    return r;
}

function wa(address adr) pure returns(uint) {
    uint r;
    assembly {
        r := adr
    }
    return r;
}

function w8(uint8 v) pure returns(uint) {
    uint r;
    assembly {
        r := v
    }
    return r;
}

function w16(uint16 v) pure returns(uint) {
    uint r;
    assembly {
        r := v
    }
    return r;
}

function w32(uint32 v) pure returns(uint) {
    uint r;
    assembly {
        r := v
    }
    return r;
}

function w64(uint64 v) pure returns(uint) {
    uint r;
    assembly {
        r := v
    }
    return r;
}

function w96(uint96 v) pure returns(uint) {
    uint r;
    assembly {
        r := v
    }
    return r;
}

function w128(uint128 v) pure returns(uint) {
    uint r;
    assembly {
        r := v
    }
    return r;
}

function w160(uint160 v) pure returns(uint) {
    uint r;
    assembly {
        r := v
    }
    return r;
}


/// BitFormat: riskSlippagePercentx10 (8) | riskPricePercent (8) | tokenId  (32) | tokenType (8) | erc20Decimals (8) | vaultDecimals (8) | positionDecimals (8) | sequestrationMultiplier (8) | tokenAddress (160)
type VaultTokenConfig is uint256;

library VaultTokenConfigLib {
    function raw(VaultTokenConfig vtc) internal pure returns(uint256) {
        return VaultTokenConfig.unwrap(vtc);
    }

    function newVaultTokenConfig(address _tokenAddress, uint8 _sequestrationMultiplier, uint8 _erc20Decimals,
        uint8 _vaultDecimals, uint8 _positionDecimals, uint8 _tokenType, uint32 _tokenId,
        uint8 _riskPricePercent, uint8 _riskSlippagePercentx10) internal pure returns (VaultTokenConfig) {
        return VaultTokenConfig.wrap(w160(uint160(_tokenAddress)) | (w8(_sequestrationMultiplier) << 160) |
            (w8(_positionDecimals) << 168) | (w8(_vaultDecimals) << 176) | (w8(_erc20Decimals) << 184) |
            (w8(_tokenType) << 192) | (w32(_tokenId) << 200) | (w8(_riskPricePercent) << 232) | (w8(_riskSlippagePercentx10) << 240));
    }

    function tokenAddress(VaultTokenConfig vtc) internal pure returns(address) {
        return address(uint160(VaultTokenConfig.unwrap(vtc)));
    }

    function withTokenAddress(VaultTokenConfig vtc, address newAddress) internal pure returns (VaultTokenConfig) {
        return VaultTokenConfig.wrap(((VaultTokenConfig.unwrap(vtc) >> 160) << 160) | wa(newAddress));
    }

    function sequestrationMultiplier(VaultTokenConfig vtc) internal pure returns(uint8) {
        return uint8(VaultTokenConfig.unwrap(vtc) >> 160);
    }

    function positionDecimals(VaultTokenConfig vtc) internal pure returns(uint8) {
        return uint8(VaultTokenConfig.unwrap(vtc) >> 168);
    }

    function vaultDecimals(VaultTokenConfig vtc) internal pure returns(uint8) {
        return uint8(VaultTokenConfig.unwrap(vtc) >> 176);
    }

    function erc20Decimals(VaultTokenConfig vtc) internal pure returns(uint8) {
        return uint8(VaultTokenConfig.unwrap(vtc) >> 184);
    }

    function tokenType(VaultTokenConfig vtc) internal pure returns(uint8) {
        return uint8(VaultTokenConfig.unwrap(vtc) >> 192);
    }

    function tokenId(VaultTokenConfig vtc) internal pure returns(uint32) {
        return uint32(VaultTokenConfig.unwrap(vtc) >> 200);
    }

    /// this is a uint8, but we do math with it and it can easily overflow, so uint16 is returned
    function riskPricePercent(VaultTokenConfig vtc) internal pure returns(uint16) {
        return uint16(uint8(VaultTokenConfig.unwrap(vtc) >> 232));
    }

    function withRiskPricePercent(VaultTokenConfig vtc, uint8 _riskPricePercent) internal pure returns(VaultTokenConfig) {
        return VaultTokenConfig.wrap((VaultTokenConfig.unwrap(vtc) & BLANK_EIGHT_AT_232) | (w8(_riskPricePercent) << 232));
    }

    /// this is a uint8, but we do math with it and it can easily overflow, so uint16 is returned
    function riskSlippagePercentx10(VaultTokenConfig vtc) internal pure returns(uint16) {
        return uint16(uint8(VaultTokenConfig.unwrap(vtc) >> 240));
    }

    function withRiskSlippagePercentx10(VaultTokenConfig vtc, uint8 _riskSlippagePercentx10) internal pure returns(VaultTokenConfig) {
        return VaultTokenConfig.wrap((VaultTokenConfig.unwrap(vtc) & BLANK_EIGHT_AT_240) | (w8(_riskSlippagePercentx10) << 240));
    }

    function isValid(VaultTokenConfig vtc) internal pure returns(bool) {
        return VaultTokenConfig.unwrap(vtc) != 0;
    }

    function convertPositionToVault(VaultTokenConfig vtc, uint64 p) internal pure returns(uint128) {
        unchecked {
            return uint128(w64(p) * (10 ** (vtc.vaultDecimals() - vtc.positionDecimals())));
        }
    }

    function convertVaultToErc20(VaultTokenConfig vtc, uint128 p) internal pure returns(uint256) {
        unchecked {
            return w128(p) * (10 ** (vtc.erc20Decimals() - vtc.vaultDecimals()));
        }
    }

    function convertVaultToPosition(VaultTokenConfig vtc, uint128 v) internal pure returns(uint64) {
        unchecked {
            return uint64(v/(10 ** (vtc.vaultDecimals() - vtc.positionDecimals())));
        }
    }

    function perpSequesterAmount(VaultTokenConfig vtc, uint64 amount) internal pure returns(uint256) {
        return w64(amount) * w16(riskSlippagePercentx10(vtc)) * 3 / 1000;
    }
}

using {
VaultTokenConfigLib.tokenAddress,
VaultTokenConfigLib.withTokenAddress,
VaultTokenConfigLib.sequestrationMultiplier,
VaultTokenConfigLib.positionDecimals,
VaultTokenConfigLib.vaultDecimals,
VaultTokenConfigLib.erc20Decimals,
VaultTokenConfigLib.tokenId,
VaultTokenConfigLib.tokenType,
VaultTokenConfigLib.riskPricePercent,
VaultTokenConfigLib.withRiskPricePercent,
VaultTokenConfigLib.riskSlippagePercentx10,
VaultTokenConfigLib.withRiskSlippagePercentx10,
VaultTokenConfigLib.isValid,
VaultTokenConfigLib.convertPositionToVault,
VaultTokenConfigLib.convertVaultToErc20,
VaultTokenConfigLib.convertVaultToPosition,
VaultTokenConfigLib.perpSequesterAmount,
VaultTokenConfigLib.raw
} for VaultTokenConfig global;

/// BitFormat: fromTokenId(32) | toTokenId (32)
type TokenPair is uint64;

library TokenPairLib {
    function raw(TokenPair tp) internal pure returns (uint64) {
        return TokenPair.unwrap(tp);
    }

    function newTokenPair(uint32 _fromTokenId, uint32 _toTokenId) internal pure returns (TokenPair) {
        return TokenPair.wrap((uint64(_fromTokenId) << 32) | uint64(_toTokenId));
    }

    function toTokenId(TokenPair tp) internal pure returns (uint32) {
        return uint32(TokenPair.unwrap(tp));
    }

    function fromTokenId(TokenPair tp) internal pure returns (uint32) {
        return uint32(TokenPair.unwrap(tp) >> 32);
    }
}

using {
TokenPairLib.fromTokenId,
TokenPairLib.toTokenId,
TokenPairLib.raw
} for TokenPair global;

uint8 constant SPOT_BOOK_TYPE = 11;
uint8 constant PERP_BOOK_TYPE = 22;
uint8 constant LEND_BOOK_TYPE = 33;

/// shares bit pattern with TokenPair\
/// ftpd: from to position decimal\
/// for the lending book, the fields are zero except for bookType and toTokenId\
/// BitFormat: bookType (8) | fromMaxFee (64) | toMaxFee (64) | fromVaultMinusPositionDecimals (8) | toVaultMinusPositionDecimals (8) | ftpdDiff (signed 8) | makerFeeBip (16) | takerFeeBip (16) | tokenPair (64)
type OrderBookConfig is uint256;

library OrderBookConfigLib {
    function raw(OrderBookConfig obc) internal pure returns (uint256) {
        return OrderBookConfig.unwrap(obc);
    }

    function forRegistration(uint16 _makerFeeBip, uint16 _takerFeeBip, TokenPair _pair) internal pure returns(OrderBookConfig){
        return OrderBookConfig.wrap((w16(_makerFeeBip) << 80) | (w16(_takerFeeBip) << 64) | w64(_pair.raw()) );
    }

    function pair(OrderBookConfig obc) internal pure returns (TokenPair) {
        return TokenPair.wrap(uint64(OrderBookConfig.unwrap(obc)));
    }

    /// also used for the single lend token
    function toTokenId(OrderBookConfig obc) internal pure returns (uint32) {
        return uint32(OrderBookConfig.unwrap(obc));
    }

    function fromTokenId(OrderBookConfig obc) internal pure returns (uint32) {
        return uint32(OrderBookConfig.unwrap(obc) >> 32);
    }

    function takerFeeBip(OrderBookConfig obc) internal pure returns (uint16) {
        return uint16(OrderBookConfig.unwrap(obc) >> 64);
    }

    function makerFeeBip(OrderBookConfig obc) internal pure returns (uint16) {
        return uint16(OrderBookConfig.unwrap(obc) >> 80);
    }

    function ftpdDiff(OrderBookConfig obc) internal pure returns (int8) {
        return int8(uint8(OrderBookConfig.unwrap(obc) >> 96));
    }

    function withFtpdDiff(OrderBookConfig obc, int8 newValue) internal pure returns (OrderBookConfig) {
        return OrderBookConfig.wrap((OrderBookConfig.unwrap(obc) & BLANK_EIGHT_AT_96) | (w8(uint8(newValue)) << 96));
    }

    function bookType(OrderBookConfig obc) internal pure returns (uint8) {
        return uint8(OrderBookConfig.unwrap(obc) >> 248);
    }

    function withBookType(OrderBookConfig obc, uint8 newValue) internal pure returns (OrderBookConfig) {
        return OrderBookConfig.wrap((OrderBookConfig.unwrap(obc) & BLANK_EIGHT_AT_248) | (w8(newValue) << 248));
    }

    function toVaultMinusPositionDecimals(OrderBookConfig obc) internal pure returns (uint8) {
        return uint8(OrderBookConfig.unwrap(obc) >> 104);
    }

    function withToVaultMinusPositionDecimals(OrderBookConfig obc, uint8 newValue) internal pure returns (OrderBookConfig) {
        return OrderBookConfig.wrap((OrderBookConfig.unwrap(obc) & BLANK_EIGHT_AT_104) | (w8(newValue) << 104));
    }

    function fromVaultMinusPositionDecimals(OrderBookConfig obc) internal pure returns (uint8) {
        return uint8(OrderBookConfig.unwrap(obc) >> 112);
    }

    function withFromVaultMinusPositionDecimals(OrderBookConfig obc, uint8 newValue) internal pure returns (OrderBookConfig) {
        return OrderBookConfig.wrap((OrderBookConfig.unwrap(obc) & BLANK_EIGHT_AT_112) | (w8(newValue) << 112));
    }

    function toMaxFee(OrderBookConfig obc) internal pure returns (uint64) {
        return uint64(OrderBookConfig.unwrap(obc) >> 120);
    }

    function fromMaxFee(OrderBookConfig obc) internal pure returns (uint64) {
        return uint64(OrderBookConfig.unwrap(obc) >> 184);
    }

    function isBlank(OrderBookConfig obc) internal pure returns (bool) {
        return OrderBookConfig.unwrap(obc) == 0;
    }

    function newConfigForLending(uint32 tokenId) internal pure returns(OrderBookConfig) {
        return OrderBookConfig.wrap((w8(LEND_BOOK_TYPE)<< 248) | w32(tokenId));
    }
}

using {
OrderBookConfigLib.toTokenId,
OrderBookConfigLib.fromTokenId,
OrderBookConfigLib.pair,
OrderBookConfigLib.takerFeeBip,
OrderBookConfigLib.makerFeeBip,
OrderBookConfigLib.ftpdDiff,
OrderBookConfigLib.bookType,
OrderBookConfigLib.fromVaultMinusPositionDecimals,
OrderBookConfigLib.toVaultMinusPositionDecimals,
OrderBookConfigLib.toMaxFee,
OrderBookConfigLib.fromMaxFee,
OrderBookConfigLib.isBlank,
OrderBookConfigLib.withFtpdDiff,
OrderBookConfigLib.withBookType,
OrderBookConfigLib.withToVaultMinusPositionDecimals,
OrderBookConfigLib.withFromVaultMinusPositionDecimals,
OrderBookConfigLib.raw
} for OrderBookConfig global;

/// BitFormat: perp sequestered balance (64) | spot/lend sequestered balance (64) | user balance (128)
type VaultLedger is uint256;

library VaultLedgerLib {
    function raw(VaultLedger vl) internal pure returns(uint256) {
        return VaultLedger.unwrap(vl);
    }

    function spotLendSeqBalance(VaultLedger vl) internal pure returns(uint64) {
        return uint64(VaultLedger.unwrap(vl) >> 128);
    }

    function perpSeqBalance(VaultLedger vl) internal pure returns(uint64) {
        return uint64(VaultLedger.unwrap(vl) >> 192);
    }

    function userBalance(VaultLedger vl) internal pure returns(uint128) {
        return uint128(VaultLedger.unwrap(vl));
    }

    function available(VaultLedger vl, VaultTokenConfig config) internal pure returns(uint128) {
        uint128 seq = config.convertPositionToVault(perpSeqBalance(vl) + spotLendSeqBalance(vl));
        uint128 bal = userBalance(vl);
        if (seq > bal) {
            return 0;
        }
        return bal - seq;
    }

    function sumCheck(uint64 a, uint64 b) internal pure returns(uint64) {
        unchecked {
            uint256 newAmount = w64(a) + w64(b);
            if (newAmount >= (1 << 64)) {
                revert ExchangeErrors.TotalLimitOrdersTooLarge();
            }
            return uint64(newAmount);
        }
    }

    function incrementSpotLendSeqBalance(VaultLedger vl, uint64 incAmount) internal pure returns(VaultLedger) {
        return newVaultLedger(userBalance(vl), sumCheck(spotLendSeqBalance(vl), incAmount), perpSeqBalance(vl));
    }

    function incrementPerpSeqBalance(VaultLedger vl, uint64 incAmount) internal pure returns(VaultLedger) {
        return newVaultLedger(userBalance(vl), spotLendSeqBalance(vl), sumCheck(perpSeqBalance(vl), incAmount));
    }

    function decrementSpotLendSeqBalance(VaultLedger vl, uint64 decAmount) internal pure returns(VaultLedger) {
        return newVaultLedger(userBalance(vl), spotLendSeqBalance(vl) - decAmount, perpSeqBalance(vl));
    }

    function decrementPerpSeqBalance(VaultLedger vl, uint64 decAmount) internal pure returns(VaultLedger) {
        return newVaultLedger(userBalance(vl), spotLendSeqBalance(vl), perpSeqBalance(vl) - decAmount);
    }

    function incrementBalance(VaultLedger vl, uint128 incAmount) internal pure returns(VaultLedger) {
        return newVaultLedger(userBalance(vl) + incAmount, spotLendSeqBalance(vl), perpSeqBalance(vl));
    }

    function decrementBalance(VaultLedger vl, uint128 decAmount) internal pure returns(VaultLedger) {
        return newVaultLedger(userBalance(vl) - decAmount, spotLendSeqBalance(vl), perpSeqBalance(vl));
    }

    function newVaultLedger(uint128 _userBalance, uint64 _spotLendSeq, uint64 _perpSeq) internal pure returns(VaultLedger) {
        return VaultLedger.wrap((w64(_perpSeq) << 192) | (w64(_spotLendSeq) << 128) | uint256(_userBalance) );
    }
}

using {
VaultLedgerLib.spotLendSeqBalance,
VaultLedgerLib.perpSeqBalance,
VaultLedgerLib.userBalance,
VaultLedgerLib.available,
VaultLedgerLib.incrementSpotLendSeqBalance,
VaultLedgerLib.incrementPerpSeqBalance,
VaultLedgerLib.incrementBalance,
VaultLedgerLib.decrementSpotLendSeqBalance,
VaultLedgerLib.decrementPerpSeqBalance,
VaultLedgerLib.decrementBalance,
VaultLedgerLib.raw
} for VaultLedger global;

/// price with 59 bits of mantissa, 5 bits of assumed negative pow 10 exponent\
/// BitFormat: mantissa (59) | exponent (5)
type Price59EN5 is uint64;

/// the core math for the spot order book:\
/// the fromToken quantity in decimal form is: fromTokenQ / 10**(fromToken position decimals)\
/// the toToken quantity in decimal form is: toTokenQ / 10**(toToken position decimals)\
/// the following is the core price conversion: fromTokenQ / 10**(fromToken position decimals) * price == toTokenQ / 10**(toToken position decimals)\
/// toTokenQ = fromTokenQ * priceMantissa * 10 ** (price exp + toToken position decimals - fromToken position decimals)\
/// we introduce the signed value: fromToToken position decimal diff (ftpdDiff) = fromToken position decimals - toToken position decimals\
library Price59EN5Lib {
    function newPrice59EN5(uint64 _mantissa, uint8 _scale) internal pure returns(Price59EN5) {
        return Price59EN5.wrap(((_mantissa << 5) | uint64(_scale)));
    }

    /// expo is the implicit exponent of v (effectively, the decimal points).
    /// for example, v=20001, exp=1 translates to 2000.1 (represented as mantissa=20001, scale=1)
    /// v=2001, exp=-3 translates to 2001000 (represented as v=2001000, scale=0)
    function createPrice(uint256 v, int16 expo) internal pure returns(Price59EN5) {
        if (expo < 0) {
            v = v * (10**(uint16(-expo)));
            expo = 0;
        }
        unchecked {
            while (v >= (1 << 59) && expo > 0) {
                v = v/10;
                expo -= 1;
            }
            while(v % 10 == 0 && expo > 0) {
                v = v/10;
                expo -= 1;
            }
        }
        require(v < (1 << 59));
        require(expo < 32);
        return newPrice59EN5(uint64(v), uint8(uint16(expo)));
    }

    function inflateBase1k(Price59EN5 p, uint16 inc) internal pure returns (Price59EN5) {
        uint incPrice = 999 + inc;
        unchecked {
            return Price59EN5Lib.createPrice(p.mantissa() * incPrice, p.unsignedExpInt16() + 3 );
        }
    }

    function deflateBase1k(Price59EN5 p, uint16 dec) internal pure returns (Price59EN5) {
        uint decPrice = 1001 - dec;
        unchecked {
            return Price59EN5Lib.createPrice(p.mantissa() * decPrice, p.unsignedExpInt16() + 3 );
        }
    }

    /// the scaled value is price * 10**31
    function toScaledU256raw(Price59EN5 p) internal pure returns(uint256) {
        unchecked {
            return mantissa(p) * 10**(31 - unsignedExp(p));
        }
    }

    function mantissa(Price59EN5 p) internal pure returns(uint256) {
        return w64(Price59EN5.unwrap(p)) >> 5;
    }

    function unsignedExp(Price59EN5 p) internal pure returns(uint256) {
        return w64(Price59EN5.unwrap(p)) & PRICE_EXP_MASK;
    }

    function unsignedExpInt16(Price59EN5 p) internal pure returns(int16) {
        return int16(uint16(Price59EN5.unwrap(p) & PRICE_EXP_MASK));
    }

    function equals(Price59EN5 p1, Price59EN5 p2) internal pure returns(bool) {
        return Price59EN5.unwrap(p1) == Price59EN5.unwrap(p2);
    }

    function lessThanEquals(Price59EN5 p1, Price59EN5 p2) internal pure returns(bool) {
        return toScaledU256raw(p1) <= toScaledU256raw(p2);
    }

    function greaterThanEquals(Price59EN5 p1, Price59EN5 p2) internal pure returns(bool) {
        return toScaledU256raw(p1) >= toScaledU256raw(p2);
    }

    function greaterThan(Price59EN5 p1, Price59EN5 p2) internal pure returns(bool) {
        return toScaledU256raw(p1) > toScaledU256raw(p2);
    }

    function lessThan(Price59EN5 p1, Price59EN5 p2) internal pure returns(bool) {
        return toScaledU256raw(p1) < toScaledU256raw(p2);
    }

    function isZero(Price59EN5 p) internal pure returns(bool) {
        return Price59EN5.unwrap(p) == 0;
    }

    function raw(Price59EN5 p) internal pure returns(uint64) {
        return Price59EN5.unwrap(p);
    }

    function isNormalized(Price59EN5 p) internal pure returns(bool) {
        return mantissa(p) % 10 != 0 || unsignedExp(p) == 0;
    }

    function convertFromToTo(Price59EN5 p, uint64 fromTokenQuantity, int8 ftpdDiff) internal pure returns(uint64) {
        unchecked {
            uint256 m = convertFromToTo128(p, fromTokenQuantity, ftpdDiff);
            require(m < (1 << 63), ExchangeErrors.QuantityTooHigh());
            return uint64(m);
        }
    }


    function convertFromToTo128(Price59EN5 p, uint128 fromTokenQuantity, int8 ftpdDiff) internal pure returns(uint128) {
        unchecked {
            int256 pow = int256(- ftpdDiff) - int256(unsignedExp(p));
            uint256 m = fromTokenQuantity * mantissa(p);
            if (pow > 0) {
                // the following line is theoretically required, but there are no tokens with 38 decimals
//                require(pow < 38, ExchangeErrors.QuantityTooHigh());
                m = m * 10 ** (uint256(pow));
            } else if (pow < 0) {
                m = m / 10 ** (uint256(- pow));
            }
            require(m < (1 << 127), ExchangeErrors.QuantityTooHigh());
            return uint128(m);
        }
    }

    function signedConvertFromToTo(Price59EN5 p, int128 fromTokenQuantity, int8 ftpdDiff) internal pure returns (int128) {
        unchecked {
            if (fromTokenQuantity < 0) {
                return -int128(p.convertFromToTo128(uint128(-fromTokenQuantity), ftpdDiff));
            }
            return int128(p.convertFromToTo128(uint128(fromTokenQuantity), ftpdDiff));
        }
    }

    function signedMulPow31(Price59EN5 p, int64 quantity) internal pure returns (int256) {
        unchecked {
            int m = int(mantissa(p)) * int(quantity);
            uint pow = 31 - unsignedExp(p);
            return m * int256(10 ** (pow));
        }
    }

    function convertToToFrom(Price59EN5 p, uint64 toTokenQuantity, int8 ftpdDiff) internal pure returns(uint64) {
        unchecked {
            int256 pow = int256(- ftpdDiff) - int256(unsignedExp(p));
            uint256 m = toTokenQuantity;
            if (pow < 0) {
                // the following line is theoretically required, but there are no tokens with 38 decimals
//                require(pow > - 58, ExchangeErrors.QuantityTooHigh());
                m = m * 10 ** (uint256(- pow));
            }
            m = m / mantissa(p);
            if (pow > 0) {
                m = m / 10 ** (uint256(pow));
            }
            require(m < (1 << 63), ExchangeErrors.QuantityTooHigh());
            return uint64(m);
        }
    }

    /// @return numer*2^30/denom
    /// only sensible if numer and denom are somewhat close
    /// returns a value in the range 0 to 2^59/10^-31*2^30 < 2^192
    /// from the context this function is being invoked, the actual range is 0 to 2^59/10^-8*2^30 ~ 2^116
    /// we'll use uint256 because in the end, it's fewer bytes produced by the compiler
    function divScaled30(Price59EN5 numer, Price59EN5 denom) internal pure returns(uint256) {
        int256 pow = int256(denom.unsignedExp()) - int256(numer.unsignedExp());
        uint256 bigNumer = uint256(numer.mantissa()) << 64;
        uint256 ratio = bigNumer/uint256(denom.mantissa());
        unchecked {
            // pow is in the range -31 to 31, ratio < 2^59 * 2^64
            // 2^(59+64+103) = 226
            // the extreme end (pow == 31) is actually impossible in production, because
            // denom is from an oracle and they only have 8 decimals.
            // Nobody quotes prices with more decimals for any asset on the planet.
            // so the real range is actually 2^(59+64+27) = 150
            if (pow < 0) {
                ratio = ratio / 10**(uint256(-pow));
            }
            if (pow > 0) {
                ratio = ratio * 10**(uint256(pow));
            }
        }
        return ratio >> 34;
    }

    function times10(Price59EN5 p) internal  pure returns (Price59EN5) {
        uint exp = p.unsignedExp();
        if (exp == 0) {
            uint v = p.mantissa() * 10;
            require(v < (1 << 59));
            return Price59EN5.wrap(uint64(v) << 5);
        }
        exp -= 1;
        return Price59EN5.wrap(((Price59EN5.unwrap(p) >> 5) << 5) | (uint64(exp)));
    }

    function divide10(Price59EN5 p) internal pure returns (Price59EN5) {
        uint exp = p.unsignedExp();
        if (exp == 31) {
            return newPrice59EN5(uint64(p.mantissa()/10), uint8(p.unsignedExp()));
        } else {
            return newPrice59EN5(uint64(p.mantissa()), uint8(p.unsignedExp() + 1));
        }
    }

    function multiply(Price59EN5 left, Price59EN5 right) internal pure returns (Price59EN5) {
        unchecked {
            uint _mantissa = left.mantissa() * right.mantissa(); // can't overflow, 59*2 bits
            uint _exp = left.unsignedExp() + right.unsignedExp(); // max 10 bits
            return createPrice(_mantissa, int16(uint16(_exp)));
        }
    }

    function flip(Price59EN5 p) internal pure returns (Price59EN5) {
        // the mantissa has up to 59 bits, the largest value being 2^59
        // that's less than 10^18
        // if we compute 10^32/mantissa, we will have at least 18 digits of precision left
        // for simplicity, we can use 10^31:
        // 1/(mantissa * 10^-exp) = 10^31/(mantissa * 10^-exp) * 10^-31
        // = 10^(31 + exp)/mantissa * 10^-31
        // exp is no larger than 31 and 10^62 fits in 2^256
        uint256 newMantissa = 10**(31 + p.unsignedExp())/p.mantissa();
        return createPrice(newMantissa, 31);
    }
}

using {
Price59EN5Lib.raw,
Price59EN5Lib.isZero,
Price59EN5Lib.mantissa,
Price59EN5Lib.unsignedExp,
Price59EN5Lib.unsignedExpInt16,
Price59EN5Lib.lessThan,
Price59EN5Lib.lessThanEquals,
Price59EN5Lib.greaterThan,
Price59EN5Lib.greaterThanEquals,
Price59EN5Lib.signedConvertFromToTo,
Price59EN5Lib.signedMulPow31,
Price59EN5Lib.inflateBase1k,
Price59EN5Lib.deflateBase1k,
Price59EN5Lib.convertFromToTo,
Price59EN5Lib.convertFromToTo128,
Price59EN5Lib.convertToToFrom,
Price59EN5Lib.isNormalized,
Price59EN5Lib.divScaled30,
Price59EN5Lib.toScaledU256raw,
Price59EN5Lib.times10,
Price59EN5Lib.divide10,
Price59EN5Lib.multiply,
Price59EN5Lib.flip,
Price59EN5Lib.equals
} for Price59EN5 global;

/// BitFormat: buyQuantity (64) | buyPrice (64) | sellQuantity (64) | sellPrice (64) |
type BestBidOffer is uint256;

library BestBidOfferLib {
    function sellPrice(BestBidOffer _bbo) internal pure returns (Price59EN5) {
        return Price59EN5.wrap(uint64(BestBidOffer.unwrap(_bbo)));
    }

    function sellQuantity(BestBidOffer _bbo) internal pure returns (uint64) {
        return uint64(BestBidOffer.unwrap(_bbo) >> 64);
    }

    function buyPrice(BestBidOffer _bbo) internal pure returns (Price59EN5) {
        return Price59EN5.wrap(uint64(BestBidOffer.unwrap(_bbo) >> 128));
    }

    function buyQuantity(BestBidOffer _bbo) internal pure returns (uint64) {
        return uint64(BestBidOffer.unwrap(_bbo) >> 192);
    }
}

using {
BestBidOfferLib.sellPrice,
BestBidOfferLib.sellQuantity,
BestBidOfferLib.buyPrice,
BestBidOfferLib.buyQuantity
} for BestBidOffer global;

/// BitFormat: liquidation (8) | insertionHint (64) | orderType (4) | client 44 | quantity 64 | price 64\
/// orderType is one of the [ORDER_TYPE_*](./constants.PublicStruct.html#order_type_limit) values below\
/// liquidation is only used internally. if set externally, it's ignored.
type SpotOrder is uint256;
/// identical to SpotOrder, just typed for clarity
type PerpOrder is uint256;

/// @dev regular limit order. May be filled partially or fully immediately or later.
uint8 constant ORDER_TYPE_LIMIT = 0;
/// @dev if the order cannot be filled immediately, the transaction will revert
uint8 constant ORDER_TYPE_FILL_ALL_OR_REVERT = 2;
/// @dev if the order cannot be filled immediately, whatever is leftover is canceled
uint8 constant ORDER_TYPE_FILL_PARTIAL_KILL_REST = 3;

uint8 constant ORDER_TYPE_MASK = (uint8(1) << 4) - 1;

library SpotOrderLib {
    function newSpotOrder(Price59EN5 _price, uint64 _quantity, uint64 _userId, uint8 _orderType, LiquidationData _liquidation) internal pure returns (SpotOrder) {
        return SpotOrder.wrap(w64(_price.raw()) | (w64(_quantity) << 64) | (w64(_userId) << 128) |
            (w8(_orderType) << 172) | (w8(_liquidation.raw()) << 240));
    }

    function price(SpotOrder orderData) internal pure returns (Price59EN5) {
        return Price59EN5.wrap(uint64(SpotOrder.unwrap(orderData)));
    }

    function quantity(SpotOrder orderData) internal pure returns (uint64) {
        return uint64(SpotOrder.unwrap(orderData) >> 64);
    }

    function client(SpotOrder orderData) internal pure returns (uint64) {
        return uint64((SpotOrder.unwrap(orderData) >> 128) & CLIENT_ID_MASK);
    }

    function withQuantity(SpotOrder orderData, uint64 newQuantity) internal pure returns (SpotOrder) {
        return SpotOrder.wrap((SpotOrder.unwrap(orderData) & BLANK_SIXTY_FOUR_AT_64) | (w64(newQuantity) << 64));
    }

    function isBlank(SpotOrder orderData) internal pure returns (bool) {
        return SpotOrder.unwrap(orderData) == 0;
    }

    function blank() internal pure returns (SpotOrder) {
        return SpotOrder.wrap(0);
    }

    function orderType(SpotOrder orderData) internal pure returns (uint8) {
        return uint8(SpotOrder.unwrap(orderData) >> 172) & ORDER_TYPE_MASK;
    }

    function insertionHint(SpotOrder orderData) internal pure returns (uint64) {
        return uint64(SpotOrder.unwrap(orderData) >> 176);
    }

    function clientQuantityPrice(SpotOrder orderData) internal pure returns (uint) {
        return SpotOrder.unwrap(orderData) & ONE_SEVENTY_TWO_AT_ZERO;
    }

    function clean(SpotOrder orderData) internal pure returns (SpotOrder) {
        return SpotOrder.wrap((SpotOrder.unwrap(orderData) << 16) >> 16);
    }

    function liquidation(SpotOrder order) internal pure returns (LiquidationData) {
        return LiquidationData.wrap(uint8(SpotOrder.unwrap(order) >> 240));
    }
}

using {
    SpotOrderLib.client,
    SpotOrderLib.price,
    SpotOrderLib.withQuantity,
    SpotOrderLib.isBlank,
    SpotOrderLib.orderType,
    SpotOrderLib.insertionHint,
    SpotOrderLib.clientQuantityPrice,
    SpotOrderLib.clean,
    SpotOrderLib.liquidation,
    SpotOrderLib.quantity
} for SpotOrder global;

/// BitFormat: ignore missing (1) | client 44 | orderId 64
type SpotCancelOrderData is uint256;
/// identical to SpotCancelOrderData
type PerpCancelOrderData is uint256;

library SpotCancelOrderDataLib {
    function client(SpotCancelOrderData cancelOrderData) internal pure returns (uint64) {
        return uint64((SpotCancelOrderData.unwrap(cancelOrderData) >> 64) & CLIENT_ID_MASK);
    }

    function orderId(SpotCancelOrderData cancelOrderData) internal pure returns (uint64) {
        return uint64(SpotCancelOrderData.unwrap(cancelOrderData));
    }

    function ignoreMissing(SpotCancelOrderData cancelOrderData) internal pure returns (bool) {
        return (SpotCancelOrderData.unwrap(cancelOrderData) >> 108) == 1;
    }
}

using {
SpotCancelOrderDataLib.client,
SpotCancelOrderDataLib.ignoreMissing,
SpotCancelOrderDataLib.orderId
} for SpotCancelOrderData global;

/// BitFormat: buyerIsMaker (1) | price (64) | buyerOrderId (64) | sellerOrderId (64) | tradeSeq (32)
type SpotMatchData is uint256;

library SpotMatchDataLib {
    function newSpotMatchData(Price59EN5 _price, uint64 _buyerOrderId, uint64 _sellerOrderId, uint32 _tradeSeq, bool buyerIsMaker) internal pure returns(SpotMatchData){
        return SpotMatchData.wrap((wb(buyerIsMaker) << 224) | (w64(_price.raw()) << 160) | (w64(_buyerOrderId) << 96) | (w64(_sellerOrderId) << 32) | w32(_tradeSeq));
    }

    function tradeSeq(SpotMatchData smd) internal pure returns(uint32) {
        return uint32(SpotMatchData.unwrap(smd));
    }

    function sellerOrderId(SpotMatchData smd) internal pure returns(uint64) {
        return uint64(SpotMatchData.unwrap(smd) >> 32);
    }

    function buyerOrderId(SpotMatchData smd) internal pure returns(uint64) {
        return uint64(SpotMatchData.unwrap(smd) >> 96);
    }

    function price(SpotMatchData smd) internal pure returns(Price59EN5) {
        return Price59EN5.wrap(uint64(SpotMatchData.unwrap(smd) >> 160));
    }
}

using {
SpotMatchDataLib.tradeSeq,
SpotMatchDataLib.sellerOrderId,
SpotMatchDataLib.buyerOrderId,
SpotMatchDataLib.price
} for SpotMatchData global;

/// BitFormat: orderType 4 | orderId 64 | quantity 64 | price 64
type SpotOrderData is uint256;

library SpotOrderDataLib {
    function raw(SpotOrderData _sod) internal pure returns (uint256) {
        return SpotOrderData.unwrap(_sod);
    }

    function newAccountId(uint64 accountId) internal pure returns (uint256) {
        return w64(accountId);
    }

    function newSpotOrderData(uint64 quantity, uint64 price, uint64 orderId) internal pure returns (SpotOrderData) {
        return SpotOrderData.wrap((uint256(orderId) << (64*2)) | (uint256(quantity) << 64) | uint256(price));
    }

    function newSpotOrderDataWithType(uint64 quantity, uint64 price, uint64 orderId, uint8 orderType) internal pure returns (SpotOrderData) {
        return SpotOrderData.wrap((uint256(orderType) << 192) | (uint256(orderId) << (64*2)) | (uint256(quantity) << 64) | uint256(price));
    }
}

using {
SpotOrderDataLib.raw
} for SpotOrderData global;

/// everything is in positionDecimals\
/// BitFormat: toQuantity (64) | fromQuantity (64) | toFee(64) | fromFee (64)
type SpotMatchQuantities is uint256;

library SpotMatchQuantitiesLib {
    function newSpotMatchQuantities(uint64 _toQuantity, uint64 _fromQuantity, uint64 _toFee, uint64 _fromFee) internal pure returns (SpotMatchQuantities) {
        return SpotMatchQuantities.wrap((w64(_toQuantity) << 192) | (w64(_fromQuantity) << 128) | (w64(_toFee) << 64) | w64(_fromFee));
    }

    function fromFee(SpotMatchQuantities smr) internal pure returns (uint64) {
        return uint64(SpotMatchQuantities.unwrap(smr));
    }

    function toFee(SpotMatchQuantities smr) internal pure returns (uint64) {
        return uint64(SpotMatchQuantities.unwrap(smr) >> 64);
    }

    function fromQuantity(SpotMatchQuantities smr) internal pure returns (uint64) {
        return uint64(SpotMatchQuantities.unwrap(smr) >> 128);
    }

    function toQuantity(SpotMatchQuantities smr) internal pure returns (uint64) {
        return uint64(SpotMatchQuantities.unwrap(smr) >> 192);
    }
}

using {
SpotMatchQuantitiesLib.toFee,
SpotMatchQuantitiesLib.fromFee,
SpotMatchQuantitiesLib.fromQuantity,
SpotMatchQuantitiesLib.toQuantity
} for SpotMatchQuantities global;

uint8 constant MARK_PRICE_CHAINLINK = 2;
uint8 constant MARK_PRICE_PYTH = 3; //unused, kept for compatibility
uint8 constant MARK_PRICE_WCM = 4;

/// BitFormat: contractAddress (160) | mark price type (8)
type MarkPriceConfig is uint256;

library MarkPriceConfigLib {
    function raw(MarkPriceConfig mpc) internal pure returns(uint256) {
        return MarkPriceConfig.unwrap(mpc);
    }

    function markPriceType(MarkPriceConfig mpc) internal pure returns(uint8) {
        return uint8(MarkPriceConfig.unwrap(mpc));
    }

    function contractAddress(MarkPriceConfig mpc) internal pure returns(address) {
        return address(uint160(MarkPriceConfig.unwrap(mpc) >> 8));
    }
}

using {
    MarkPriceConfigLib.raw,
    MarkPriceConfigLib.markPriceType,
    MarkPriceConfigLib.contractAddress
} for MarkPriceConfig global;


/// contains 3 buckets and total # of buckets in the stream\
/// BitFormat: len (16) | quantity1 (64) | price1 (16) | quantity2 (64) | price2 (16) | quantity3 (64) | price3 (16)\
/// the values are in order (ascending price for sell side, descending for buy side)
type LendBookStreamStart is uint256;

library LendBookStreamStartLib {
    function appendLen(uint256 triplet, uint16 len) internal pure returns (uint256) {
        return triplet | (w16(len) << 240);
    }
}

/// BitFormat: quantity1 (64) | price1 (16) | quantity2 (64) | price2 (16) | quantity3 (64) | price3 (16)
type LendBookStreamTriplet is uint256;

library LendBookStreamTripletLib {
    function blank() internal pure returns(LendBookStreamTriplet) {
        return LendBookStreamTriplet.wrap(0);
    }

    function raw(LendBookStreamTriplet triplet) internal pure returns(uint256) {
        return LendBookStreamTriplet.unwrap(triplet);
    }

    function append(LendBookStreamTriplet triplet, uint64 quantity, uint16 price) internal pure returns(LendBookStreamTriplet) {
        return LendBookStreamTriplet.wrap((LendBookStreamTriplet.unwrap(triplet) << 80) | (w64(quantity) << 16) | w16(price));
    }

    function asEnd(LendBookStreamTriplet triplet, uint16 restart) internal pure returns(LendBookStreamEnd) {
        return LendBookStreamEnd.wrap(LendBookStreamTriplet.unwrap(triplet) | (w16(restart) << 240));
    }
}

using {
LendBookStreamTripletLib.raw,
LendBookStreamTripletLib.append,
LendBookStreamTripletLib.asEnd
} for LendBookStreamTriplet global;

/// BitFormat: restartPosition (16) | quantity1 (64) | price1 (16) | quantity2 (64) | price2 (16) | quantity3 (64) | price3 (16)
type LendBookStreamEnd is uint256;


library LendBookStreamEndLib {
    function appendRestart(uint256 triplet, uint16 _restart) internal pure returns (uint256) {
        return triplet | (w16(_restart) << 240);
    }
}

/// BitFormat: return lender to orderbook (1) | hours paid (16) | lend hours duration (16) | seq id (32) | start time minutes (32) | counter party id (44) | token (32) | quantity (64) | interest rate (16)\
/// start time can be converted to unix time with: 1704067200 + startTime*60\
/// 1704067200 is Jan 1, 2024 00:00:00 UTC
type LendingPosition is uint256;

library LendingPositionLib {

    function raw(LendingPosition _lp) internal pure returns(uint256) {
        return LendingPosition.unwrap(_lp);
    }

    /// position id is just seq id | start time
    function positionId(LendingPosition _lp) internal pure returns(uint64) {
        return uint64(LendingPosition.unwrap(_lp) >> 156);
    }
}

using {
LendingPositionLib.positionId,
LendingPositionLib.raw
} for LendingPosition global;

/// BitFormat: lender account id (44) | borrower account id (44) | token (32) | new quantity (64) |  hours paid (16) | lend hours duration (16)
type LendingEventData is uint256;

library LendingEventDataLib {
    function newLendingEventData(LendMatch _lendMatch, uint16 _hoursPaid) internal pure returns(LendingEventData) {
        return LendingEventData.wrap(w16(_lendMatch.lendHoursDuration()) |
                    (w16(_hoursPaid) << 16) |
                    (((LendMatch.unwrap(_lendMatch) >> 16) << 72) >> 40));
    }
}

/// BitFormat: fees (128 bit) | interest (128 bit)
type InterestPaidData is uint256;

library InterestPaidLib {
    function newInterestPaidData(uint128 _interest, uint128 _fees) internal pure returns(InterestPaidData) {
        return InterestPaidData.wrap(w128(_interest) | ((w128(_fees) << 128)));
    }
}

/// lower bits of this are used in LendingPosition\
/// BitFormat: disallow extension (1) | lender interest rate (16) | return lender to orderbook (1) | buyer is maker (1) | hours paid (16) | lend hours duration (16) | lender account id (44) | borrower account id (44) | token (32) | quantity (64) | interest rate (16)
type LendMatch is uint256;

library LendMatchLib {

    function oneDayDebt(uint64 borrower, uint64 lender, uint64 amt, uint32 _tokenId) internal pure returns (LendMatch) {
        return LendMatch.wrap( (w64(amt) << 16) |
                        (w32(_tokenId) << 80) |
                        (w64(borrower) << 112) |
                        (w64(lender) << 156) |
                        (w8(24) << 200));
    }

    function interestRate(LendMatch lendMatchData) internal pure returns(uint16) {
        return uint16(LendMatch.unwrap(lendMatchData));
    }

    function quantity(LendMatch matchData) internal pure returns (uint64) {
        return uint64(LendMatch.unwrap(matchData) >> 16);
    }

    function tokenId(LendMatch matchData) internal pure returns (uint32) {
        return uint32(LendMatch.unwrap(matchData) >> 80);
    }

    function borrowerAccountId(LendMatch matchData) internal pure returns(uint64) {
        return uint64((LendMatch.unwrap(matchData) >> 112) & CLIENT_ID_MASK);
    }

    function lenderAccountId(LendMatch matchData) internal pure returns(uint64) {
        return uint64((LendMatch.unwrap(matchData) >> 156) & CLIENT_ID_MASK);
    }

    function lendHoursDuration(LendMatch matchData) internal pure returns(uint16) {
        return uint16(LendMatch.unwrap(matchData) >> 200);
    }

    function lendMinutesDuration(LendMatch matchData) internal pure returns(uint32) {
        return uint32(uint16(LendMatch.unwrap(matchData) >> 200)) * 60;
    }

    function hoursUnpaid(LendMatch matchData) internal pure returns(uint16) {
        return lendHoursDuration(matchData) - hoursPaid(matchData);
    }

    function hoursPaid(LendMatch matchData) internal pure returns(uint16) {
        return uint16(LendMatch.unwrap(matchData) >> 216);
    }

    function setLendHoursDuration(LendMatch matchData, uint16 h) internal pure returns(LendMatch) {
        return LendMatch.wrap((LendMatch.unwrap(matchData) & BLANK_SIXTEEN_AT_200) | (w16(h) << 200));
    }

    function buyerIsMaker(LendMatch matchData) internal pure returns(bool) {
        return LendMatch.unwrap(matchData) & (w8(1) << 232) != 0;
    }

    function lenderInterestRate(LendMatch matchData) internal pure returns(uint16) {
        return uint16(LendMatch.unwrap(matchData) >> 234);
    }

    function tQiB(LendMatch matchData) internal pure returns(uint256) {
        return (LendMatch.unwrap(matchData) << 100) >> 100;
    }

    function tQi(LendMatch matchData) internal pure returns(uint256) {
        return (LendMatch.unwrap(matchData) << 144) >> 144;
    }

    function returnLenderToBookAsBit(LendMatch matchData) internal pure returns(uint256) {
        return (LendMatch.unwrap(matchData) >> 233) & 1;
    }

    function disallowExtensionAsBit(LendMatch matchData) internal pure returns(uint256) {
        return (LendMatch.unwrap(matchData) >> 250) & 1;
    }

    function reduceQuantity(LendMatch matchData, uint64 _quantity) internal pure returns(LendMatch) {
        return LendMatch.wrap((LendMatch.unwrap(matchData) & BLANK_SIXTY_FOUR_AT_16) |
                        ((w64(quantity(matchData) - _quantity) << 16)));
    }

    function setQuantity(LendMatch matchData, uint64 _quantity) internal pure returns(LendMatch) {
        return LendMatch.wrap((LendMatch.unwrap(matchData) & BLANK_SIXTY_FOUR_AT_16) |
                        ((w64(_quantity) << 16)));
    }

    function increaseHoursPaid(LendMatch matchData, uint16 _hours) internal pure returns(LendMatch) {
        return LendMatch.wrap((LendMatch.unwrap(matchData) & BLANK_SIXTEEN_AT_216) |
                        ((w16(hoursPaid(matchData) + _hours) << 216)));
    }

    function markAsNonReturnable(LendMatch matchData) internal pure returns(LendMatch) {
        return LendMatch.wrap(LendMatch.unwrap(matchData) & BLANK_BIT_AT_233);
    }

    function raw(LendMatch matchData) internal pure returns(uint256) {
        return LendMatch.unwrap(matchData);
    }

    function isValid(LendMatch _matchData) internal pure returns(bool) {
        return LendMatch.unwrap(_matchData) != 0;
    }

    function isNotExtensible(LendMatch _matchData) internal pure returns(bool) {
        return _matchData.interestRate() == 0 || _matchData.returnLenderToBookAsBit() == 0 || _matchData.disallowExtensionAsBit() == 1;
    }
}

using {
LendMatchLib.raw,
LendMatchLib.isValid,
LendMatchLib.interestRate,
LendMatchLib.quantity,
LendMatchLib.tokenId,
LendMatchLib.buyerIsMaker,
LendMatchLib.borrowerAccountId,
LendMatchLib.lendHoursDuration,
LendMatchLib.lendMinutesDuration,
LendMatchLib.setLendHoursDuration,
LendMatchLib.hoursPaid,
LendMatchLib.hoursUnpaid,
LendMatchLib.isNotExtensible,
LendMatchLib.disallowExtensionAsBit,
LendMatchLib.returnLenderToBookAsBit,
LendMatchLib.lenderInterestRate,
LendMatchLib.tQiB,
LendMatchLib.tQi,
LendMatchLib.reduceQuantity,
LendMatchLib.setQuantity,
LendMatchLib.increaseHoursPaid,
LendMatchLib.markAsNonReturnable,
LendMatchLib.lenderAccountId
} for LendMatch global;

/// fee is calculated by multiplying by feeRate and dividing be FEE_DIVISOR (100K)\
/// max fee is computed by mantissa * 10^exponent, and the result is in vault decimals (128bit)\
/// BitFormat: minOrderQuantity(64) | unused (16) | fee rate (16) | max fee exponent (8) | max fee mantissa (8)\
/// max fee is in vault decimals.
type LendFeeSchedule is uint256;

library LendFeeScheduleLib {
    function raw(LendFeeSchedule _fs) internal pure returns(uint256) {
        return LendFeeSchedule.unwrap(_fs);
    }

    function maxFee(LendFeeSchedule _fs) internal pure returns(uint128) {
        return uint128(uint128(maxFeeMantissa(_fs))*(10**(uint128(maxFeeExponent(_fs)))));
    }

    function maxFeeMantissa(LendFeeSchedule _fs) internal pure returns(uint8) {
        return uint8(LendFeeSchedule.unwrap(_fs));
    }

    function maxFeeExponent(LendFeeSchedule _fs) internal pure returns(uint8) {
        return uint8(LendFeeSchedule.unwrap(_fs) >> 8);
    }

    function feeRate(LendFeeSchedule _fs) internal pure returns(uint16) {
        return uint16(LendFeeSchedule.unwrap(_fs) >> 16);
    }

    function withMinOrderQuantity(LendFeeSchedule _fs, uint64 q) internal pure returns(LendFeeSchedule) {
        return LendFeeSchedule.wrap((LendFeeSchedule.unwrap(_fs) & BLANK_SIXTY_FOUR_AT_48) | (w64(q) << 48));
    }

    function minOrderQuantity(LendFeeSchedule _fs) internal pure returns (uint64) {
        return uint64(LendFeeSchedule.unwrap(_fs) >> 48);
    }
}

using {
LendFeeScheduleLib.maxFee,
LendFeeScheduleLib.feeRate,
LendFeeScheduleLib.withMinOrderQuantity,
LendFeeScheduleLib.minOrderQuantity,
LendFeeScheduleLib.raw
} for LendFeeSchedule global;

/// BitFormat: liquidation(8) | orderType(4) | userId 44 | quantity 64 | interestRate 16\
/// price is an alias for interestRate\
/// liquidation is only used internally. It's ignored if set externally
type LendOrder is uint256;

library LendOrderLib {
    function newLendOrder(uint64 _userId, uint64 _quantity, uint16 _interestRate) internal pure returns(LendOrder) {
        return LendOrder.wrap(
            (w64(_userId) << 80) |
            (w64(_quantity) << 16) |
            w16(_interestRate)
        );
    }

    function blank() internal pure returns (LendOrder) {
        return LendOrder.wrap(0);
    }

    function isBlank(LendOrder _it) internal pure returns (bool) {
        return quantity(_it) == 0;
    }

    /// alias for interestRate
    function price(LendOrder _it) internal pure returns (uint16) {
        return uint16(LendOrder.unwrap(_it));
    }

    function interestRate(LendOrder _it) internal pure returns (uint16) {
        return uint16(LendOrder.unwrap(_it));
    }

    function quantity(LendOrder _it) internal pure returns (uint64) {
        return uint64(LendOrder.unwrap(_it) >> 16);
    }

    function orderType(LendOrder _it) internal pure returns (uint8) {
        return uint8(LendOrder.unwrap(_it) >> 124) & ORDER_TYPE_MASK;
    }

    function withOrderType(LendOrder _it, uint8 _orderType) internal pure returns (LendOrder) {
        return LendOrder.wrap((LendOrder.unwrap(_it) & BLANK_FOUR_AT_124) | (w8(_orderType) << 124));
    }

    function withLiquidation(LendOrder _it) internal pure returns (LendOrder) {
        return LendOrder.wrap((LendOrder.unwrap(_it) & BLANK_EIGHT_AT_128) |
            (w8(LiquidationData.unwrap(LiquidationLib.create(false))) << 128));
    }

    function withQuantity(LendOrder orderData, uint64 newQuantity) internal pure returns (LendOrder) {
        return LendOrder.wrap((LendOrder.unwrap(orderData) & BLANK_SIXTY_FOUR_AT_16) | (w64(newQuantity) << 16));
    }

    function userId(LendOrder _it) internal pure returns (uint64) {
        return uint64((LendOrder.unwrap(_it) >> 80) & CLIENT_ID_MASK);
    }

    function clean(LendOrder _it) internal pure returns (LendOrder) {
        return LendOrder.wrap((LendOrder.unwrap(_it) << 128) >> 128);
    }

    function liquidation(LendOrder order) internal pure returns (LiquidationData) {
        return LiquidationData.wrap(uint8(LendOrder.unwrap(order) >> 128));
    }
}

using {
LendOrderLib.isBlank,
LendOrderLib.price,
LendOrderLib.interestRate,
LendOrderLib.quantity,
LendOrderLib.orderType,
LendOrderLib.withQuantity,
LendOrderLib.withOrderType,
LendOrderLib.withLiquidation,
LendOrderLib.clean,
LendOrderLib.liquidation,
LendOrderLib.userId
} for LendOrder global;

///BitFormat: quantity (64) | interestRate (16) | quantity (64) | interestRate (16) | quantity (64) | interestRate (16)
type LendSearchResult is uint256;

/// start time is in "funding time". It's a relative clock (to Jan 1, 2024) that ticks
/// once every 8 hours.\
/// BitFormat: star time (32) | owedNom (signed 96) | quantity (signed 64) | entry price (64)
type PerpAggPosition is uint256;

library PerpAggPositionLib {

    function firstTrade(uint32 _time, Price59EN5 _price, int64 _quantity) internal pure returns (PerpAggPosition) {
        return PerpAggPosition.wrap((w32(_time) << 224) | (w64(uint64(_quantity)) << 64) | w64(_price.raw()));
    }

    function raw(PerpAggPosition pap) internal pure returns(uint256) {
        return PerpAggPosition.unwrap(pap);
    }

    function price(PerpAggPosition pap) internal pure returns(Price59EN5) {
        return Price59EN5.wrap(uint64(PerpAggPosition.unwrap(pap)));
    }

    function withPrice(PerpAggPosition pap, Price59EN5 newPrice) internal pure returns (PerpAggPosition) {
        return PerpAggPosition.wrap((PerpAggPosition.unwrap(pap) & BLANK_SIXTY_FOUR_AT_0) | w64(newPrice.raw()));
    }

    function withStartTime(PerpAggPosition pap, uint32 _time) internal pure returns (PerpAggPosition) {
        return PerpAggPosition.wrap((PerpAggPosition.unwrap(pap) & BLANK_THIRTY_TWO_AT_224) | (w32(_time) << 224));
    }

    /// divide by ConfigConstants.FUNDING_RATE_DIVISOR_AGG to get position decimals
    /// positive value means the owner of this position will get paid
    function owedNom(PerpAggPosition pap) internal pure returns(int96) {
        return int96(uint96(PerpAggPosition.unwrap(pap) >> 128));
    }

    function incrementOwedNom(PerpAggPosition pap, int96 v) internal pure returns (PerpAggPosition) {
        v += pap.owedNom();
        return PerpAggPosition.wrap((pap.raw() & BLANK_NINTEY_SIX_AT_128) | ((w96(uint96(v))) << 128));
    }

    function quantity(PerpAggPosition pap) internal pure returns(int64) {
        return int64(uint64(PerpAggPosition.unwrap(pap) >> 64));
    }

    function incrementQuantity(PerpAggPosition pap, int64 v) internal pure returns (PerpAggPosition) {
        v += pap.quantity();
        return PerpAggPosition.wrap((pap.raw() & BLANK_SIXTY_FOUR_AT_64) | (w64(uint64(v))  << 64));
    }

    function startTime(PerpAggPosition pap) internal pure returns(uint32) {
        return uint32(PerpAggPosition.unwrap(pap) >> 224);
    }
}

using {
PerpAggPositionLib.raw,
PerpAggPositionLib.price,
PerpAggPositionLib.owedNom,
PerpAggPositionLib.withPrice,
PerpAggPositionLib.withStartTime,
PerpAggPositionLib.quantity,
PerpAggPositionLib.incrementQuantity,
PerpAggPositionLib.incrementOwedNom,
PerpAggPositionLib.startTime
} for PerpAggPosition global;

/// BitFormat: long account id (44) | short account id (44) | startTime (32) | quantity (64) | entry price (64)
/// start time is in funding rate units (start of 8 hours). To get back to utc unix time: startTime * 60 * 8 * 60 + 1704067200
type PerpPosition is uint256;

library PerpPositionLib {
    // long account id (44) | short account id (44) | token (32) | quantity (64) | entry price (64)
    function price(PerpPosition positionData) internal pure returns (uint64) {
        return uint64(PerpPosition.unwrap(positionData));
    }

    function quantity(PerpPosition positionData) internal pure returns (uint64) {
        return uint64(PerpPosition.unwrap(positionData) >> 64);
    }

    function startTime(PerpPosition positionData) internal pure returns (uint32) {
        return uint32(PerpPosition.unwrap(positionData) >> 128);
    }

    function shortAccountId(PerpPosition positionData) internal pure returns(uint32) {
        return uint32((PerpPosition.unwrap(positionData) >> 160) & CLIENT_ID_MASK);
    }

    function longAccountId(PerpPosition positionData) internal pure returns(uint32) {
        return uint32((PerpPosition.unwrap(positionData) >> 204) & CLIENT_ID_MASK);
    }

    function raw(PerpPosition positionData) internal pure returns(uint256) {
        return PerpPosition.unwrap(positionData);
    }
}

using {
PerpPositionLib.price,
PerpPositionLib.quantity,
PerpPositionLib.startTime,
PerpPositionLib.shortAccountId,
PerpPositionLib.longAccountId,
PerpPositionLib.raw
} for PerpPosition global;

/// paymentLongToShort: positive means long paid short, in position decimals\
/// debtIssuedKey: zero if the payment was immediate, otherwise the key to the 24 hour interest free debt\
/// the token id is for the position (not the payment, which is always base)\
/// funding fee that exchanged hands (also included in the payment) in base currency\
/// BitFormat: funding fee (Float27EN4: 32) | trueUpPrice (Price59EN5: 64) | debtIssuedKey (uint64) | tokenId (uint32) | paymentLongToShort (int64)
type PerpTrueUpData is uint256;

library PerpTrueUpDataLib {
    function construct(Price59EN5 _trueUpPrice, uint64 _debtIssuedKey, uint32 _tokenId, int64 _payment, int64 fpayBase) internal pure returns (PerpTrueUpData) {
        return PerpTrueUpData.wrap((w64(Float27E4.unwrap(Float27E4Lib.create(fpayBase))) << 224) | (w64(_trueUpPrice.raw()) << 160) |
        (w64(_debtIssuedKey) << 96) | (w32(_tokenId) << 64) | w64(uint64(_payment)));
    }
}

uint16 constant COMMAND_TYPE_BUY = 1;
uint16 constant COMMAND_TYPE_SELL = 2;
uint16 constant COMMAND_TYPE_PAY_INTEREST = 3;
uint16 constant COMMAND_TYPE_MARK_LEND_NO_RETURN = 4;
uint16 constant COMMAND_TYPE_SWAP_LENDER = 5;
uint16 constant COMMAND_TYPE_BANKRUPT_CLOSE_LOAN = 6;
uint16 constant COMMAND_TYPE_BANKRUPT_CLOSE_PERP = 7;
uint16 constant COMMAND_TYPE_PERP_TRUE_UP = 512;

/// Bitformat: commandType (10) | bookType(6)\
/// the bookType is an enum: 0 -- no book, 11 -- spot, 22 -- perps, 33 -- lending\
/// commandType for books: 1 -- buySide, 2 -- sellSide\
/// commandType for non-books:
/// 3 -- payInterestAndFees\
/// 4 -- mark lend non-returnable\
/// 5 -- Swap lender\
/// 6 -- bankrupt close loan\
/// 7 -- bankrupt close perp\
/// 512 -- perp true up\
type BatchCommandUnionType is uint16;

/// this is a union type\
/// the 16 bit at LSB determine the rest of the format\
/// the unionType itself if defined above\
/// cancel rebook has a second payload (BatchTwoTokenCancelRebook or BatchLendCancelRebook)
/// BitFormat (cancel-rebook): ignoreMissingForCancel (1) | orderType (4) | bookAddress (160) | unionType (16)\
/// BitFormat (pay-interest): batchPayInterest (240) | unionType (16)\
/// BitFormat (mark-lend-non-returnable): batchMarkLendNoReturn (240) | unionType (16)\
/// BitFormat (swap-lender): batchSwapLender (240) | unionType (16)\
/// BitFormat (perp true up): longId (64) | shortId (64) | tokenId (32) | unionType (16)\
/// BitFormat (bankrupt close perp): payment (64) | longId (44) | shortId (44) | tokenId (32) | reserved (28) | unionType (16)\
/// BitFormat (bankrupt close loan): payment (64) | positionId (64) | reserved (28) | unionType (16)\
type BatchCommand is uint256;

library BatchCommandLib {
    function bookType(BatchCommand bc) internal pure returns (uint8) {
        return uint8(BatchCommand.unwrap(bc) & SIX_BIT_MASK);
    }

    function commandType(BatchCommand bc) internal pure returns (uint16) {
        return uint16(BatchCommand.unwrap(bc)) >> 6;
    }

    function bookAddress(BatchCommand bc) internal pure returns (address) {
        return address(uint160(BatchCommand.unwrap(bc) >> 16));
    }

    function orderType(BatchCommand bc) internal pure returns (uint8) {
        return uint8((BatchCommand.unwrap(bc) >> 176) & 0xF);
    }

    function ignoreMissingForCancel(BatchCommand bc) internal pure returns (uint8) {
        return uint8((BatchCommand.unwrap(bc) >> 180) & 1);
    }

    function batchPayInterest(BatchCommand bc, uint64 userId) internal pure returns (BatchPayInterest) {
        return BatchPayInterest.wrap(BatchCommand.unwrap(bc) >> 16).withUserId(userId);
    }

    function batchMarkLendNoReturn(BatchCommand bc, uint64 userId) internal pure returns (BatchMarkLendNoReturn) {
        return BatchMarkLendNoReturn.wrap(BatchCommand.unwrap(bc) >> 16).withUserId(userId);
    }

    function batchSwapLender(BatchCommand bc, uint64 userId) internal pure returns (BatchSwapLender) {
        return BatchSwapLender.wrap(BatchCommand.unwrap(bc) >> 16).withUserId(userId);
    }

    function batchPerpTrueUp(BatchCommand bc) internal pure returns (BatchCommandPerpTrueUp) {
        return BatchCommandPerpTrueUp.wrap(BatchCommand.unwrap(bc));
    }
}

using {
BatchCommandLib.bookType,
BatchCommandLib.commandType,
BatchCommandLib.bookAddress,
BatchCommandLib.orderType,
BatchCommandLib.ignoreMissingForCancel,
BatchCommandLib.batchPayInterest,
BatchCommandLib.batchSwapLender,
BatchCommandLib.batchPerpTrueUp,
BatchCommandLib.batchMarkLendNoReturn
} for BatchCommand global;

/// userId is set automatically and shouldn't be set in the initial command
/// BitFormat: unusable (16) | reserved (67) | userId (44) | positionId (64) | reduceQuantity (64) | extendPeriod (1)
type BatchPayInterest is uint256;

library BatchPayInterestLib {
    function raw(BatchPayInterest bpi) internal pure returns(uint256) {
        return BatchPayInterest.unwrap(bpi);
    }
    function extendPeriod(BatchPayInterest bpi) internal pure returns(bool) {
        return BatchPayInterest.unwrap(bpi) & 1 == 1;
    }

    function reduceQuantity(BatchPayInterest bpi) internal pure returns(uint64) {
        return uint64(BatchPayInterest.unwrap(bpi) >> 1);
    }

    function positionId(BatchPayInterest bpi) internal pure returns(uint64) {
        return uint64(BatchPayInterest.unwrap(bpi) >> 65);
    }

    function userId(BatchPayInterest bpi) internal pure returns(uint64) {
        return uint64((BatchPayInterest.unwrap(bpi) >> 129) & CLIENT_ID_MASK);
    }

    function withUserId(BatchPayInterest bpi, uint64 _userId) internal pure returns (BatchPayInterest) {
        return BatchPayInterest.wrap((BatchPayInterest.unwrap(bpi) & BLANK_FORTY_FOUR_AT_129) | (w64(_userId) << 129));
    }
}

using {
BatchPayInterestLib.raw,
BatchPayInterestLib.extendPeriod,
BatchPayInterestLib.reduceQuantity,
BatchPayInterestLib.userId,
BatchPayInterestLib.withUserId,
BatchPayInterestLib.positionId
} for BatchPayInterest global;

/// only positionId should be specified (userId is set automatically)
/// BitFormat: unusable (16) | reserved (rest) | userId (44) | positionId (64)
type BatchMarkLendNoReturn is uint256;

library BatchMarkLendNoReturnLib {
    function raw(BatchMarkLendNoReturn bpi) internal pure returns(uint256) {
        return BatchMarkLendNoReturn.unwrap(bpi);
    }

    function userId(BatchMarkLendNoReturn bpi) internal pure returns(uint64) {
        return uint64((BatchMarkLendNoReturn.unwrap(bpi) >> 64) & CLIENT_ID_MASK);
    }

    function positionId(BatchMarkLendNoReturn bpi) internal pure returns(uint64) {
        return uint64(BatchMarkLendNoReturn.unwrap(bpi));
    }

    function withUserId(BatchMarkLendNoReturn bpi, uint64 _userId) internal pure returns (BatchMarkLendNoReturn) {
        return BatchMarkLendNoReturn.wrap((BatchMarkLendNoReturn.unwrap(bpi) & BLANK_FORTY_FOUR_AT_64) | (w64(_userId) << 64));
    }

}

using {
BatchMarkLendNoReturnLib.raw,
BatchMarkLendNoReturnLib.userId,
BatchMarkLendNoReturnLib.withUserId,
BatchMarkLendNoReturnLib.positionId
} for BatchMarkLendNoReturn global;

/// only positionId should be specified (userId is set automatically)
/// BitFormat: unusable (16) | reserved (rest) | userId (44) | positionId (64)
type BatchSwapLender is uint256;

library BatchSwapLenderLib {
    function raw(BatchSwapLender bpi) internal pure returns(uint256) {
        return BatchSwapLender.unwrap(bpi);
    }

    function userId(BatchSwapLender bpi) internal pure returns(uint64) {
        return uint64((BatchSwapLender.unwrap(bpi) >> 64) & CLIENT_ID_MASK);
    }

    function positionId(BatchSwapLender bpi) internal pure returns(uint64) {
        return uint64(BatchSwapLender.unwrap(bpi));
    }

    function withUserId(BatchSwapLender bpi, uint64 _userId) internal pure returns (BatchSwapLender) {
        return BatchSwapLender.wrap((BatchSwapLender.unwrap(bpi) & BLANK_FORTY_FOUR_AT_64) | (w64(_userId) << 64));
    }

}

using {
BatchSwapLenderLib.raw,
BatchSwapLenderLib.userId,
BatchSwapLenderLib.withUserId,
BatchSwapLenderLib.positionId
} for BatchSwapLender global;

/// BitFormat: insertionHint (64) | quantity (64) | price (64) | cancelOrderId (64)\
/// if cancelOrderId is zero, no cancellation is performed.\
/// if quantity is zero, no new order is created\
/// cancellation is performed before booking the new order
type BatchTwoTokenCancelRebook is uint256;

library BatchTwoTokenCancelRebookLib {
    function cancelOrderId(BatchTwoTokenCancelRebook bcr) internal pure returns(uint64) {
        return uint64(BatchTwoTokenCancelRebook.unwrap(bcr));
    }

    function quantity(BatchTwoTokenCancelRebook bcr) internal pure returns(uint64) {
        return uint64(BatchTwoTokenCancelRebook.unwrap(bcr) >> 128);
    }

    function asCancelOrderData(BatchTwoTokenCancelRebook bcr, uint64 userId, uint8 ignoreMissing) internal pure returns (SpotCancelOrderData) {
        return SpotCancelOrderData.wrap(w64(bcr.cancelOrderId()) | (w64(userId) << 64) | (w8(ignoreMissing) << 108));
    }

    function asSpotOrder(BatchTwoTokenCancelRebook bcr, uint64 userId, uint8 orderType) internal pure returns (SpotOrder) {
        return SpotOrder.wrap(uint256(uint128(BatchTwoTokenCancelRebook.unwrap(bcr) >> 64)) |
                            (w64(userId) << 128) |
                            (w8(orderType & 0xF) << 172) |
                            ((BatchTwoTokenCancelRebook.unwrap(bcr) >> 192) << 176));
    }
}

using {
BatchTwoTokenCancelRebookLib.cancelOrderId,
BatchTwoTokenCancelRebookLib.quantity,
BatchTwoTokenCancelRebookLib.asCancelOrderData,
BatchTwoTokenCancelRebookLib.asSpotOrder
} for BatchTwoTokenCancelRebook global;

/// if cancelInterestRate is zero, nothing is canceled\
/// if cancelQuantity is zero, the entire order at that price is canceled\
/// otherwise, the order is reduced by that quantity\
/// if quantity is not zero, a new order is placed at the given interestRate\
/// BitFormat: quantity (64) | interestRate (16) | cancelQuantity (64) | cancelInterestRate (16)
type BatchLendCancelRebook is uint256;

library BatchLendCancelRebookLib {
    function cancelInterestRate(BatchLendCancelRebook r) internal pure returns (uint16) {
        return uint16(BatchLendCancelRebook.unwrap(r));
    }

    function quantity(BatchLendCancelRebook r) internal pure returns (uint64) {
        return uint64(BatchLendCancelRebook.unwrap(r) >> 96);
    }

    function asCancelLendOrder(BatchLendCancelRebook r, uint64 userId) internal pure returns (LendOrder) {
        return LendOrder.wrap(w128(uint80(BatchLendCancelRebook.unwrap(r))) | (w64(userId) << 80));
    }

    function asLendOrder(BatchLendCancelRebook r, uint64 userId, uint8 orderType) internal pure returns (LendOrder) {
        return LendOrder.wrap(w128(uint80(BatchLendCancelRebook.unwrap(r) >> 80)) |
                (w64(userId) << 80) | (w8(orderType) << 124));
    }
}

using {
BatchLendCancelRebookLib.cancelInterestRate,
BatchLendCancelRebookLib.quantity,
BatchLendCancelRebookLib.asCancelLendOrder,
BatchLendCancelRebookLib.asLendOrder
} for BatchLendCancelRebook global;

/// BitFormat (perp true up): longId (64) | shortId (64) | tokenId (32) | unionType (16)
type BatchCommandPerpTrueUp is uint256;

library BatchCommandPerpTrueUpLib {
    function tokenId(BatchCommandPerpTrueUp _b) internal pure returns (uint32) {
        return uint32(BatchCommandPerpTrueUp.unwrap((_b)) >> 16);
    }

    function shortId(BatchCommandPerpTrueUp _b) internal pure returns (uint64) {
        return uint64(BatchCommandPerpTrueUp.unwrap((_b)) >> 48);
    }

    function longId(BatchCommandPerpTrueUp _b) internal pure returns (uint64) {
        return uint64(BatchCommandPerpTrueUp.unwrap((_b)) >> 112);
    }
}

using {
BatchCommandPerpTrueUpLib.tokenId,
BatchCommandPerpTrueUpLib.shortId,
BatchCommandPerpTrueUpLib.longId
} for BatchCommandPerpTrueUp global;

/// BitFormat: originalOwnerId (44) | liquidatorId (44) | quantity (128)
type LiquidationPayoff is uint256;

library LiquidationPayoffLib {
    function raw(LiquidationPayoff le) internal pure returns (uint256) {
        return LiquidationPayoff.unwrap(le);
    }

    function newPayoff(uint64 _origOwner, uint64 _liquidatorId, uint128 _quantity) internal pure returns (LiquidationPayoff) {
        return LiquidationPayoff.wrap( w128(_quantity) | (w64(_liquidatorId) << 128)
            | (w64(_origOwner) << 172));
    }

    function quantity(LiquidationPayoff le) internal pure returns (uint128) {
        return uint128(le.raw());
    }

    function liquidatorId(LiquidationPayoff le) internal pure returns (uint64) {
        return uint64((LiquidationPayoff.unwrap(le) >> 128) & CLIENT_ID_MASK);
    }

    function originalOwnerId(LiquidationPayoff le) internal pure returns (uint64) {
        return uint64((LiquidationPayoff.unwrap(le) >> 172) & CLIENT_ID_MASK);
    }
}

using {
LiquidationPayoffLib.raw,
LiquidationPayoffLib.quantity,
LiquidationPayoffLib.liquidatorId,
LiquidationPayoffLib.originalOwnerId
} for LiquidationPayoff global;

/// BitFormat: restartPosition (64) | returnedOrders (32)
type OrderCursor is uint256;

library OrderCursorLib {
    function raw(OrderCursor _oc) internal pure returns (uint256) {
        return OrderCursor.unwrap(_oc);
    }

    function returnedOrders(OrderCursor _oc) internal pure returns (uint32) {
        return uint32(OrderCursor.unwrap(_oc));
    }

    function restartPosition(OrderCursor _oc) internal pure returns (uint64) {
        return uint64(OrderCursor.unwrap(_oc) >> 32);
    }

    function create(uint32 size, uint64 _restartPosition) internal pure returns (OrderCursor) {
        return OrderCursor.wrap(w32(size) | (w64(_restartPosition) << 32));
    }
}

using {
OrderCursorLib.raw,
OrderCursorLib.returnedOrders,
OrderCursorLib.restartPosition
} for OrderCursor global;

/// @dev the lower bits are shared with BulkLendAggPosition
/// BitFormat: soonestDueMinutes (32) | tokenId (32) | highestInterestRate (16) | lender quantity (64) | borrower quantity (64)
type BulkLendAggPosition is uint256;

library BulkLendAggPositionLib {
    function raw(BulkLendAggPosition lap) internal pure returns(uint256) {
        return BulkLendAggPosition.unwrap(lap);
    }

    function borrowerQuantity(BulkLendAggPosition lap) internal pure returns (uint64) {
        return uint64(lap.raw());
    }

    function lenderQuantity(BulkLendAggPosition lap) internal pure returns (uint64) {
        return uint64(lap.raw() >> 64);
    }

    function highestInterestRate(BulkLendAggPosition lap) internal pure returns (uint16) {
        return uint16(lap.raw() >> 128);
    }
}

using {
BulkLendAggPositionLib.borrowerQuantity,
BulkLendAggPositionLib.lenderQuantity,
BulkLendAggPositionLib.highestInterestRate,
BulkLendAggPositionLib.raw
} for BulkLendAggPosition global;

/// BitFormat: bankruptcy (1) | liquidation (1)
type LiquidationData is uint8;

library LiquidationLib {
    function raw(LiquidationData liq) internal pure returns (uint8) {
        return LiquidationData.unwrap(liq);
    }

    function empty() internal pure returns (LiquidationData) {
        return LiquidationData.wrap(0);
    }

    function create(bool bankruptcy) internal pure returns (LiquidationData) {
        return LiquidationData.wrap(1 | (bankruptcy ? 2 : 0));
    }

    function isBankruptcy(LiquidationData liq) internal pure returns (bool) {
        return (LiquidationData.unwrap(liq) >> 1) != 0;
    }

    function isLiquidation(LiquidationData liq) internal pure returns (bool) {
        return LiquidationData.unwrap(liq) != 0;
    }
}

using {
LiquidationLib.raw,
LiquidationLib.isBankruptcy,
LiquidationLib.isLiquidation
} for LiquidationData global;

/// the quantities are the sum of all lending positions\
/// Bitformat: highestInterestRate (16) | lender quantity (64) | borrower quantity (64)
type LendAggPosition is uint256;

library LendAggPositionLib {
    function raw(LendAggPosition lap) internal pure returns(uint256) {
        return LendAggPosition.unwrap(lap);
    }

    function borrowerQuantity(LendAggPosition lap) internal pure returns (uint64) {
        return uint64(lap.raw());
    }

    function borrowerQuantityWithFullInterest(LendAggPosition lap) internal pure returns (uint64) {
        uint256 q = uint64(lap.raw());
        q += q*(lap.highestInterestRate())*ConfigConstants.DURATION_OF_BORROW_DAYS/ConfigConstants.INTEREST_RATE_DIVISOR/365;
        return uint64(q);
    }

    function incrementBorrowerQuantity(LendAggPosition lap, uint64 incQ) internal pure returns(LendAggPosition) {
        uint64 v = lap.borrowerQuantity() + incQ;
        return LendAggPosition.wrap((lap.raw() & BLANK_SIXTY_FOUR_AT_0) | w64(v));
    }

    function decrementBorrowerQuantity(LendAggPosition lap, uint64 decQ) internal pure returns(LendAggPosition) {
        uint64 v = lap.borrowerQuantity() - decQ;
        uint x = (lap.raw() & BLANK_SIXTY_FOUR_AT_0) | w64(v);
        if (v == 0) {
            x = x &  BLANK_SIXTEEN_AT_128; // clear interest rate
        }
        return LendAggPosition.wrap(x);
    }

    function lenderQuantity(LendAggPosition lap) internal pure returns (uint64) {
        return uint64(lap.raw() >> 64);
    }

    function lenderQuantityWithHaircut(LendAggPosition lap) internal pure returns (uint64) {
        return uint64(lap.lenderQuantity() * ConfigConstants.LENDER_HAIRCUT / 1000);
    }

    function incrementLenderQuantity(LendAggPosition lap, uint64 incQ) internal pure returns(LendAggPosition) {
        uint64 v = lap.lenderQuantity() + incQ;
        return LendAggPosition.wrap((lap.raw() & BLANK_SIXTY_FOUR_AT_64) | (w64(v) << 64));
    }

    function decrementLenderQuantity(LendAggPosition lap, uint64 decQ) internal pure returns(LendAggPosition) {
        uint64 v = lap.lenderQuantity() - decQ;
        return LendAggPosition.wrap((lap.raw() & BLANK_SIXTY_FOUR_AT_64) | (w64(v) << 64));
    }

    function highestInterestRate(LendAggPosition lap) internal pure returns (uint16) {
        return uint16(lap.raw() >> 128);
    }

    function setRateIfHigher(LendAggPosition lap, uint16 rate) internal pure returns (LendAggPosition) {
        if (rate > lap.highestInterestRate()) {
            lap = LendAggPosition.wrap((lap.raw() & BLANK_SIXTEEN_AT_128) | ((w16(rate) << 128)));
        }
        return lap;
    }

    function asBulkLendAggPosition(LendAggPosition lap, uint32 tokenId, uint32 soonestDue, uint16 maxInterest) internal pure returns (BulkLendAggPosition) {
        return BulkLendAggPosition.wrap((w32(tokenId) << 144) | (w32(soonestDue) << 176) | ((lap.raw() << 128) >> 128)  | (w16(maxInterest) << 128));
    }
}

using {
LendAggPositionLib.borrowerQuantity,
LendAggPositionLib.borrowerQuantityWithFullInterest,
LendAggPositionLib.lenderQuantity,
LendAggPositionLib.lenderQuantityWithHaircut,
LendAggPositionLib.highestInterestRate,
LendAggPositionLib.incrementBorrowerQuantity,
LendAggPositionLib.decrementBorrowerQuantity,
LendAggPositionLib.incrementLenderQuantity,
LendAggPositionLib.decrementLenderQuantity,
LendAggPositionLib.setRateIfHigher,
LendAggPositionLib.asBulkLendAggPosition,
LendAggPositionLib.raw
} for LendAggPosition global;

// used for input\\
// amounts are in position decimals.\\
// either amountIn or amountOut must be non-zero as input.\\
// price may be zero as input (indicating any price).\\
// amountIn/Out is not always equal to the input parameter.
// if amountIn/Out is less than requested, there is not enough liquidity
// for the specified limit price.\\
// a zero amountIn/Out means there was no match at all.\\
// the returned limitPrice is populated with the last bucket matched in the orderbook.\\
// clientId is only used during liquidation. should be passed as zero otherwise.\\
// isLiquidation is only used internally for liquidation orders. Do not pass externally (doing so will result in incorrect price).\\
// BitFormat: isLiquidation(1) | clientId (44) | amountIn (64) | amountOut (64) | limitPrice (64)
type MarketOrderPrice is uint256;

library MarketOrderPriceLib {
    function raw(MarketOrderPrice mop) internal pure returns (uint256) {
        return MarketOrderPrice.unwrap(mop);
    }

    function empty() internal pure returns (MarketOrderPrice) {
        return MarketOrderPrice.wrap(0);
    }

    function create(uint64 _amountIn, uint64 _amountOut, Price59EN5 _price, bool _isLiquidation) internal pure returns (MarketOrderPrice) {
        return MarketOrderPrice.wrap(w64(_price.raw()) | (w64(_amountOut) << 64) | (w64(_amountIn) << 128) | (wb(_isLiquidation)  << 236));
    }

    function create(uint64 _amountIn, uint64 _amountOut, uint16 _interest, bool _isLiquidation) internal pure returns (MarketOrderPrice) {
        return MarketOrderPrice.wrap(w16(_interest) | (w64(_amountOut) << 64) | (w64(_amountIn) << 128) | (wb(_isLiquidation)  << 236));
    }

    function limitPrice(MarketOrderPrice mop) internal pure returns (Price59EN5) {
        return Price59EN5.wrap(uint64(MarketOrderPrice.unwrap(mop)));
    }

    function limitPriceAsInterest(MarketOrderPrice mop) internal pure returns (uint16) {
        return uint16(MarketOrderPrice.unwrap(mop));
    }

    function amountOut(MarketOrderPrice mop) internal pure returns (uint64) {
        return uint64(MarketOrderPrice.unwrap(mop) >> 64);
    }

    function client(MarketOrderPrice mop) internal pure returns (uint64) {
        return uint64((MarketOrderPrice.unwrap(mop) >> 192) & CLIENT_ID_MASK);
    }

    function amountIn(MarketOrderPrice mop) internal pure returns (uint64) {
        return uint64(MarketOrderPrice.unwrap(mop) >> 128);
    }

    function isLiquidation(MarketOrderPrice mop) internal pure returns (bool) {
        return MarketOrderPrice.unwrap(mop) >> 236 != 0;
    }
}

using {
MarketOrderPriceLib.raw,
MarketOrderPriceLib.limitPrice,
MarketOrderPriceLib.limitPriceAsInterest,
MarketOrderPriceLib.amountOut,
MarketOrderPriceLib.client,
MarketOrderPriceLib.isLiquidation,
MarketOrderPriceLib.amountIn
} for MarketOrderPrice global;

// used for output\\
// amounts are in position decimals.\\
// either amountIn or amountOut must be non-zero as input.\\
// price may be zero as input (indicating any price).\\
// amountIn/Out is not always equal to the input parameter.
// if amountIn/Out is less than requested, there is not enough liquidity
// for the specified limit price.\\
// a zero amountIn/Out means there was no match at all.\\
// the returned limitPrice is populated with the last bucket matched in the orderbook.\\
// orderQuantity is the value to use in the order quantity field to get these in/out values\\
// orderQuantity includes the effects of fees\\
// BitFormat: orderQuantity (64) | amountIn (64) | amountOut (64) | limitPrice (64)
type MarketOrderPriceResult is uint256;

library MarketOrderPriceResultLib {
    function raw(MarketOrderPriceResult mop) internal pure returns (uint256) {
        return MarketOrderPriceResult.unwrap(mop);
    }

    function empty() internal pure returns (MarketOrderPriceResult) {
        return MarketOrderPriceResult.wrap(0);
    }

    function create(uint64 _amountIn, uint64 _amountOut, Price59EN5 _price, uint64 _orderQuantity) internal pure returns (MarketOrderPriceResult) {
        return MarketOrderPriceResult.wrap(w64(_price.raw()) | (w64(_amountOut) << 64) | (w64(_amountIn) << 128) | (w64(_orderQuantity)  << 192));
    }

    function create(uint64 _amountIn, uint64 _amountOut, uint16 _interest, uint64 _orderQuantity) internal pure returns (MarketOrderPriceResult) {
        return MarketOrderPriceResult.wrap(w16(_interest) | (w64(_amountOut) << 64) | (w64(_amountIn) << 128) | (w64(_orderQuantity)  << 192));
    }

    function limitPrice(MarketOrderPriceResult mop) internal pure returns (Price59EN5) {
        return Price59EN5.wrap(uint64(MarketOrderPriceResult.unwrap(mop)));
    }

    function limitPriceAsInterest(MarketOrderPriceResult mop) internal pure returns (uint16) {
        return uint16(MarketOrderPriceResult.unwrap(mop));
    }

    function amountOut(MarketOrderPriceResult mop) internal pure returns (uint64) {
        return uint64(MarketOrderPriceResult.unwrap(mop) >> 64);
    }

    function orderQuantity(MarketOrderPriceResult mop) internal pure returns (uint64) {
        return uint64(MarketOrderPriceResult.unwrap(mop) >> 192);
    }

    function amountIn(MarketOrderPriceResult mop) internal pure returns (uint64) {
        return uint64(MarketOrderPriceResult.unwrap(mop) >> 128);
    }
}

using {
MarketOrderPriceResultLib.raw,
MarketOrderPriceResultLib.limitPrice,
MarketOrderPriceResultLib.limitPriceAsInterest,
MarketOrderPriceResultLib.amountOut,
MarketOrderPriceResultLib.orderQuantity,
MarketOrderPriceResultLib.amountIn
} for MarketOrderPriceResult global;

/// BitFormat: priceType (8) | orderbook address (160)
type PriceAddressSpec is uint256;

uint8 constant PRICE_TYPE_SELL_IN = 1;
uint8 constant PRICE_TYPE_BUY_OUT = 2;
uint8 constant PRICE_TYPE_SELL_OUT = 3;
uint8 constant PRICE_TYPE_BUY_IN = 4;

library PriceAddressSpecLib {
    function raw(PriceAddressSpec _pas) internal pure returns (uint256) {
        return PriceAddressSpec.unwrap(_pas);
    }

    function create(address _orderBookAddress, uint8 _priceType) internal pure returns (PriceAddressSpec) {
        return PriceAddressSpec.wrap(wa(_orderBookAddress) | (w8(_priceType) << 160));
    }

    function orderbook(PriceAddressSpec _pas) internal pure returns (address) {
        return address(uint160(PriceAddressSpec.unwrap(_pas)));
    }

    function priceType(PriceAddressSpec _pas) internal pure returns (uint8) {
        return uint8(PriceAddressSpec.unwrap(_pas) >> 160);
    }
}

using {
PriceAddressSpecLib.raw,
PriceAddressSpecLib.orderbook,
PriceAddressSpecLib.priceType
} for PriceAddressSpec global;

/// BitFormat: startTime(32) | totalQuantity (96) | currentDeltaSum (128)
type FundingRateStats is uint256;

library FundingRateStatsLib {

    function currentDeltaSum(FundingRateStats avr) internal pure returns(uint128) {
        return uint128(FundingRateStats.unwrap(avr));
    }

    function totalQuantity(FundingRateStats avr) internal pure returns(uint96) {
        return uint96((FundingRateStats.unwrap(avr) >> 128));
    }

    function startTime(FundingRateStats avr) internal pure returns(uint32) {
        return uint32(FundingRateStats.unwrap(avr) >> 224);
    }
}

using {
FundingRateStatsLib.currentDeltaSum,
FundingRateStatsLib.totalQuantity,
FundingRateStatsLib.startTime
} for FundingRateStats global;

/// Bitformat: credit (64) | liability (64)
// the values are in base token position decimals
type BankruptcyLoss is uint256;

library BankruptcyLossLib {
    function create(uint64 _credit, uint64 _liability) internal pure returns (BankruptcyLoss) {
        return BankruptcyLoss.wrap((w64(_credit) << 64) | w64(_liability));
    }
}

/// Bitformat: tokenId (32) | quantity owed (64) | quantity paid (64)
/// when a bankruptcy debt is paid, quantity paid is less than owed
type BankruptcyDebtLoss is uint256;

library BankruptcyDebtLossLib {
    function create(uint32 _tokenId, uint64 _quantityOwed, uint64 _quantityPaid) internal pure returns (BankruptcyDebtLoss) {
        return BankruptcyDebtLoss.wrap((w32(_tokenId) << 128) | (w64(_quantityOwed) << 64) | w64(_quantityPaid));
    }
}

/// Bitformat: reserved | type (8-bit)
type UserFeeSchedule is uint256;

uint constant USER_FEE_NORMAL = 0;
uint constant USER_FEE_ZERO = 1;

library UserFeeScheduleLib {
    function raw(UserFeeSchedule ufs) internal pure returns (uint256) {
        return UserFeeSchedule.unwrap(ufs);
    }

    function isZeroFees(UserFeeSchedule ufs) internal pure returns (bool) {
        return UserFeeSchedule.unwrap(ufs) == USER_FEE_ZERO;
    }
}

using {
UserFeeScheduleLib.raw,
UserFeeScheduleLib.isZeroFees
} for UserFeeSchedule global;


/// BitFormat: extended (1) | fee (64) | loanPositionId (64) | userToPay (44)
type RenewLoanData is uint256;

library RenewLoanDataLib {
    function create(uint64 _userToPay, uint64 _loanPositionId, uint64 _fee, bool _extended) internal pure returns (RenewLoanData) {
        return RenewLoanData.wrap(w64(_userToPay) | (w64(_loanPositionId) << 44) | (w64(_fee) << 108) | (wb(_extended) << 172));
    }
}

/// BitFormat: fromPositionQuantity(64) | toPositionQuantity(64) | fromTokenId (32) | toTokenId (32) | offeringUserId (44)
type LiqSwapTrade is uint256;

library LiqSwapTradeLib {
    function create(uint64 _fromQ, uint64 _toQ, uint32 _fromToken, uint32 _toToken, uint64 _offerUserId) internal pure returns (LiqSwapTrade) {
        return LiqSwapTrade.wrap((w64(_offerUserId) & CLIENT_ID_MASK) |
                    (w32(_toToken) << 44) |
                    (w32(_fromToken) << 76) |
                    (w64(_toQ) << 108) |
                    (w64(_fromQ) << 172));
    }

    function offeringUserId(LiqSwapTrade _lst) internal pure returns (uint64) {
        return uint64(LiqSwapTrade.unwrap(_lst) & CLIENT_ID_MASK);
    }

    function toTokenId(LiqSwapTrade _lst) internal pure returns (uint32) {
        return uint32(LiqSwapTrade.unwrap(_lst) >> 44);
    }

    function fromTokenId(LiqSwapTrade _lst) internal pure returns (uint32) {
        return uint32(LiqSwapTrade.unwrap(_lst) >> 76);
    }

    function toPositionQuantity(LiqSwapTrade _lst) internal pure returns (uint64) {
        return uint64(LiqSwapTrade.unwrap(_lst) >> 108);
    }

    function fromPositionQuantity(LiqSwapTrade _lst) internal pure returns (uint64) {
        return uint64(LiqSwapTrade.unwrap(_lst) >> 172);
    }
}

using {
LiqSwapTradeLib.offeringUserId,
LiqSwapTradeLib.toTokenId,
LiqSwapTradeLib.fromTokenId,
LiqSwapTradeLib.toPositionQuantity,
LiqSwapTradeLib.fromPositionQuantity
} for LiqSwapTrade global;

/// represents a floating point number in 32 bits.
/// it's meant to store up to a 2^64 integer in 32 bits, with 27 bits of precision
/// MSB is the sign bit (negative when set)
/// exp is a base 10 power, so the actual value is: mantissa * 10^(exp)
/// it should be obvious that this number is always an integer (no decimal points)
/// Bitformat: sign (1) | mantissa (27) | exp (4)
type Float27E4 is uint32;

library Float27E4Lib {
    function create(int64 v) internal pure returns (Float27E4) {
        unchecked {
            uint sign = 0;
            if (v < 0) {
                v = -v;
                sign = 1;
            }
            uint mantissa = uint(int(v));
            uint maxMantissa = (1 << 27) - 1;
            uint exp = 0;
            // 2^63 < 2^27 * (10)^(15)
            while(mantissa > maxMantissa) {
                mantissa = mantissa / 10;
                exp += 1;
            }
            return Float27E4.wrap(uint32((sign << 31) | (mantissa << 4) | exp));
        }
    }
}
