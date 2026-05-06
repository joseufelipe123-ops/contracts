// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {TokenV2} from "./TokenV2.sol";

contract Deploy {
    function deploy(
        address v2Pool,
        address v3Pool,
        string memory name,
        string memory symbol,
        string memory meta,
        uint256 maxSupply
    ) external returns (address) {
        // 1. deploy da implementação
        TokenV2 impl = new TokenV2();

        // 2. encode do initialize passando msg.sender (sua carteira)
        bytes memory data = abi.encodeWithSelector(
            TokenV2.initialize.selector,
            msg.sender,
            v2Pool,
            v3Pool,
            name,
            symbol,
            meta,
            maxSupply
        );

        // 3. deploy do proxy
        ERC1967Proxy proxy = new ERC1967Proxy(address(impl), data);

        return address(proxy);
    }
}