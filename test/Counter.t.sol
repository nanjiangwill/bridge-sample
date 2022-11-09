// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";
import "../src/AMB.sol";

contract CounterTest is Test {
    Counter public sendingCounter;
    AMB public sendingAMB;
    Counter public receivingCounter;
    AMB public receivingAMB;

    address public relayer = address(0x1);

    function setUp() public {
        sendingAMB = new AMB(relayer);
        sendingCounter = new Counter(address(sendingAMB));
        receivingAMB = new AMB(relayer);
        receivingCounter = new Counter(address(receivingAMB));
        vm.startPrank(relayer);

        sendingAMB.setRecipientAMB(address(receivingAMB));
        receivingAMB.setRecipientAMB(address(sendingAMB));
        sendingCounter.setReceivingCounter(address(receivingCounter));
        receivingCounter.setReceivingCounter(address(sendingCounter));
    }

    function testSend() public {
        bytes memory sendingResult1 = sendingCounter.send();
        bytes memory sendingResult2 = sendingAMB.send(address(receivingCounter), abi.encodeWithSignature("increment()"));
        assertEq(sendingResult1, sendingResult2);
    }

    function testReceive() public {
        bytes memory sendingResult = sendingCounter.send();
        receivingAMB.receive(sendingResult);
        assertEq(receivingCounter.counter(), 1);
    }
}
