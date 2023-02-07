pragma solidity ^0.8.15;

import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";

contract Item {}

contract ItemTest is Test {
    function _canReceiveETH(address payable receiver) internal returns (bool) {
        uint256 startReceiverBalance = receiver.balance;

        vm.deal(address(this), 1);
        (bool success,) = receiver.call{value: 1}("");

        vm.deal(receiver, startReceiverBalance);
        return success;
    }

    function testForwardETH(address payable target) public {
        vm.assume(_canReceiveETH(target));

        for (uint256 i; i < 50; ++i) {
            Item item = new Item();
            vm.assume(address(item) != address(target));
        }
    }
}
