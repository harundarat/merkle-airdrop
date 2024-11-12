// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {AirToken} from "../src/AirToken.sol";
import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

contract DeployMerkleAirdrop is Script {
    bytes32 private constant s_merkleRoot = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 private constant s_amountToTransfer = 4 * 25 * 1e18; // 4 peoples(addresses) in allowlist

    function deployMerkleAirdrop() public returns (MerkleAirdrop, AirToken) {
        vm.startBroadcast();
        AirToken airToken = new AirToken();
        MerkleAirdrop merkleAirdrop = new MerkleAirdrop(s_merkleRoot, airToken);
        // airToken.mint(airToken.owner(), s_amountToTransfer);
        // airToken.transfer(address(merkleAirdrop), s_amountToTransfer);
        airToken.mint(address(merkleAirdrop), s_amountToTransfer);
        vm.stopBroadcast();

        return (merkleAirdrop, airToken);
    }

    function run() external returns (MerkleAirdrop, AirToken) {
        return deployMerkleAirdrop();
    }
}
