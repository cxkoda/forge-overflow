pragma solidity ^0.8.15;

import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";

contract Item {}

contract ItemTest is Test {
    function _canReceiveETH(address payable receiver) internal returns (bool) {
        address sender = makeAddr("sender");
        uint256 startSenderBalance = sender.balance;
        uint256 startReceiverBalance = receiver.balance;

        vm.deal(sender, 1);
        vm.prank(sender);
        (bool success,) = receiver.call{value: 1}("");

        vm.deal(sender, startSenderBalance);
        vm.deal(receiver, startReceiverBalance);
        return success;
    }

    function testForwardETH(address payable target, uint8 num) public {
        vm.assume(_canReceiveETH(target));

        for (uint256 i; i < num; ++i) {
            Item item = new Item();
            vm.assume(address(item) != address(target));
        }
    }
}
