//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {RugResistToken} from "../src/RugResistToken.sol";

contract DeployRugResistToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;
    function run() external returns (RugResistToken) {
        vm.startBroadcast();
        RugResistToken token = new RugResistToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return token;
    }
}
