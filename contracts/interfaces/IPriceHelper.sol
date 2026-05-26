// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

interface IPriceHelper {
    // the input batch is PriceAddressSpec followed by MarketOrderPrice in alternating slots\
    // the output is MarketOrderPrice for every order in the input.\
    // the array must not contain multiple orders to the same book/side\
    // doing so will result in incorrect outcomes.\
    // the amountIn/Out is reduced from what was input, it's because there is not enough liquidity\
    // The function cannot be called multiple times in the same transaction\
    // this is implemented without the "view" in the implementation, but that shouldn't make a difference
    function estimatePrices(address exchangeAddress, uint256[] calldata batch) external view returns (uint256[] memory);

    function clear() external view;

    error WrongPriceType(); // 0x58b844c3
}
