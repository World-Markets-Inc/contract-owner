// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import {IConcordProtocolReadOnly} from "./IConcordProtocolReadOnly.sol";
import {IConcordProtocolTrading} from "./IConcordProtocolTrading.sol";
import {IConcordProtocolUser} from "./IConcordProtocolUser.sol";
import {IConcordProtocolBulk} from "./IConcordProtocolBulk.sol";

/// public sdk's should code to this interface
interface IConcordProtocolPub is IConcordProtocolReadOnly, IConcordProtocolTrading,
                IConcordProtocolUser, IConcordProtocolBulk {

}
