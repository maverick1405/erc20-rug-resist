//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployRugResistToken} from "../script/DeployRugResistToken.s.sol";
import {RugResistToken} from "../src/RugResistToken.sol";

contract RugResistTokenTest is Test {
    RugResistToken public token;
    DeployRugResistToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployRugResistToken();
        token = deployer.run();

        vm.prank(msg.sender);
        token.transfer(bob, 100 ether);
    }

    function testBobBalance() public {
        assertEq(STARTING_BALANCE, token.balanceOf(bob));
    }

    function testAllowancesWorks() public {
        uint256 initialAllowance = 1000;
        uint256 transferAmount = 500;

        vm.prank(bob);
        token.approve(alice, initialAllowance);

        vm.prank(alice);
        token.transferFrom(bob, alice, transferAmount);

        assertEq(token.balanceOf(alice), transferAmount);
        assertEq(token.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }
}
