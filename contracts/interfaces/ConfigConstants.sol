// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

library ConfigConstants {
    uint constant INTEREST_RATE_DIVISOR = 10000;
    uint constant FEE_DIVISOR = 100000;
    uint constant FUNDING_RATE_DIVISOR_EXP = 7;
    int constant FUNDING_RATE_DIVISOR = int256(10**FUNDING_RATE_DIVISOR_EXP);
    int constant MAX_FUNDING_RATE_CHANGE = 500;
    int constant MAX_FUNDING_RATE = 30000;
    uint16 constant DURATION_OF_BORROW_DAYS = 10; // ten days
    uint16 constant DURATION_OF_BORROW_HOURS = DURATION_OF_BORROW_DAYS*24; // ten days in hours
    uint16 constant MIN_DURATION_OF_BORROW_HOURS = 8;
    uint constant LENDER_HAIRCUT = 980; // use 1000 divisor, this is a 2% haircut
    uint32 constant LIQUIDATION_ESCROW_TIME = 24*60; // 1 day, in minutes
    uint32 constant BASE_TOKEN_ID = 1;
}
