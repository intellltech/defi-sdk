// Copyright (C) 2020 Zerion Inc. <https://zerion.io>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

pragma solidity 0.6.6;
pragma experimental ABIEncoderV2;

import { ERC20 } from "../../ERC20.sol";
import { ProtocolAdapter } from "../ProtocolAdapter.sol";


/**
 * @title Adapter for Uniswap V1 protocol (exchange).
 * @dev Implementation of ProtocolAdapter interface.
 * Base contract for Uniswap V1 exchange adapter.
 * @author Igor Sobolev <sobolev@zerion.io>
 */
contract UniswapV1ExchangeAdapter is ProtocolAdapter {

    bytes32 public constant override adapterType = "Exchange";

    bytes32 public constant override tokenType = "";

    /**
     * @notice This function is unavailable for exchange adapter.
     * @dev Implementation of ProtocolAdapter interface function.
     */
    function getBalance(address, address) public view override returns (uint256) {
        revert("UEA: no balance!");
    }
}
