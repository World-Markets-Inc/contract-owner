// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import {Test} from "forge-std/Test.sol";
import {TradeForwarder} from "../contracts/TradeForwarder.sol";
import {MockExchange} from "./mocks/MockExchange.sol";

contract TradeForwarderTest is Test {
    uint64 internal constant FIRST_USER_ID = 1;
    uint64 internal constant SECOND_USER_ID = 2;

    address internal constant FIRST_OWNER = address(0x1);
    address internal constant SECOND_OWNER = address(0x2);
    address internal constant UNREGISTERED = address(0x99);

    MockExchange internal exchange;
    TradeForwarder internal forwarder;

    function setUp() public {
        exchange = new MockExchange();
        exchange.registerUser(FIRST_OWNER, FIRST_USER_ID);
        exchange.registerUser(SECOND_OWNER, SECOND_USER_ID);

        forwarder = new TradeForwarder(address(exchange));
        assertEq(forwarder.exchange(), address(exchange));
    }

    function testOwnerMustAllowForwarderBeforeTrading() public {
        uint256[] memory commands = spotBuyBatch(FIRST_USER_ID);

        vm.prank(FIRST_OWNER);
        vm.expectRevert(
            abi.encodeWithSelector(MockExchange.TradingNotAllowed.selector, FIRST_USER_ID, address(forwarder))
        );
        forwarder.batchCommands(commands);
        assertEq(exchange.buyOrderCount(), 0);

        exchange.allowTradingForAccount(FIRST_USER_ID, address(forwarder));

        expectBatchForwarded(FIRST_OWNER, FIRST_USER_ID, commands);
        vm.prank(FIRST_OWNER);
        forwarder.batchCommands(commands);
        assertEq(exchange.buyOrderCount(), 1);
        assertBestBuy();
    }

    function testVictimApprovalDoesNotLetAnotherCallerTrade() public {
        uint256[] memory victimCommands = spotBuyBatch(FIRST_USER_ID);

        exchange.allowTradingForAccount(FIRST_USER_ID, address(forwarder));

        uint256 victimSeqBefore = exchange.toVaultSeq(FIRST_OWNER);
        uint256 callerSeqBefore = exchange.toVaultSeq(SECOND_OWNER);

        vm.prank(SECOND_OWNER);
        vm.expectRevert(
            abi.encodeWithSelector(MockExchange.TradingNotAllowed.selector, SECOND_USER_ID, address(forwarder))
        );
        forwarder.batchCommands(victimCommands);

        assertEq(exchange.buyOrderCount(), 0);
        assertEq(exchange.toVaultSeq(FIRST_OWNER), victimSeqBefore);
        assertEq(exchange.toVaultSeq(SECOND_OWNER), callerSeqBefore);
    }

    function testForwarderDerivesUserIdFromCaller() public {
        uint256[] memory commands = spotBuyBatch(FIRST_USER_ID);

        exchange.allowTradingForAccount(SECOND_USER_ID, address(forwarder));

        uint256 firstSeqBefore = exchange.toVaultSeq(FIRST_OWNER);
        uint256 secondSeqBefore = exchange.toVaultSeq(SECOND_OWNER);

        expectBatchForwarded(SECOND_OWNER, SECOND_USER_ID, commands);
        vm.prank(SECOND_OWNER);
        forwarder.batchCommands(commands);

        assertEq(exchange.buyOrderCount(), 1);
        assertEq(exchange.toVaultSeq(FIRST_OWNER), firstSeqBefore);
        assertEq(
            exchange.toVaultSeq(SECOND_OWNER) - secondSeqBefore,
            exchange.BUY_SEQ_INCREMENT()
        );
    }

    function testEmptyBatchIsRejectedBeforeForwarding() public {
        exchange.allowTradingForAccount(FIRST_USER_ID, address(forwarder));

        vm.prank(FIRST_OWNER);
        vm.expectRevert(TradeForwarder.EmptyCommands.selector);
        forwarder.batchCommands(new uint256[](0));

        assertEq(exchange.buyOrderCount(), 0);
    }

    function testCallerWithoutExchangeAccountIsRejected() public {
        vm.prank(UNREGISTERED);
        vm.expectRevert(abi.encodeWithSelector(TradeForwarder.CallerHasNoAccount.selector, UNREGISTERED));
        forwarder.batchCommands(spotBuyBatch(FIRST_USER_ID));

        assertEq(exchange.buyOrderCount(), 0);
    }

    function testConstructorRejectsInvalidExchangeAddress() public {
        vm.expectRevert(abi.encodeWithSelector(TradeForwarder.InvalidExchange.selector, address(0)));
        new TradeForwarder(address(0));

        vm.expectRevert(abi.encodeWithSelector(TradeForwarder.InvalidExchange.selector, address(0xBEEF)));
        new TradeForwarder(address(0xBEEF));
    }

    function spotBuyBatch(uint64) internal pure returns (uint256[] memory commands) {
        commands = new uint256[](3);
        commands[0] = 0x0102030405060708;
        commands[1] = 0x090a0b0c0d0e0f10;
        commands[2] = 0x1112131415161718;
    }

    function assertBestBuy() internal view {
        assertEq(exchange.bestBuyPrice(), 1_900_000_000_000);
        assertEq(exchange.bestBuyQuantity(), 1_000_000_000_000_000_000);
    }

    function expectBatchForwarded(address caller, uint64 userId, uint256[] memory commands) internal {
        vm.expectEmit(true, true, false, true, address(forwarder));
        emit TradeForwarder.BatchForwarded(caller, userId, commands.length);
    }
}
