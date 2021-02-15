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
//
// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity 0.7.6;
pragma experimental ABIEncoderV2;

import { ERC20 } from "../../interfaces/ERC20.sol";
import { SafeERC20 } from "../../shared/SafeERC20.sol";
import { TokenAmount } from "../../shared/Structs.sol";
import { ERC20ProtocolAdapter } from "../../adapters/ERC20ProtocolAdapter.sol";
import { InteractiveAdapter } from "../InteractiveAdapter.sol";

/**
 * @title Interactive adapter for 0x exchange.
 * @dev Implementation of InteractiveAdapter abstract contract.
 * @author Igor Sobolev <sobolev@zerion.io>
 */
contract ZeroExInteractiveAdapter is InteractiveAdapter, ERC20ProtocolAdapter {
    using SafeERC20 for ERC20;

    address internal constant ZERO_EX = 0xDef1C0ded9bec7F1a1670819833240f027b25EfF;

    /**
     * @notice Exchanges tokens using OneSplit contract.
     * @param tokenAmounts Array with one element - TokenAmount struct with
     * "from" token address, "from" token amount to be deposited, and amount type.
     * @param data Bytes array with ABI-encoded `toToken` address.
     * @return tokensToBeWithdrawn Array with one element - `toToken` address.
     * @dev Implementation of InteractiveAdapter function.
     */
    function deposit(TokenAmount[] calldata tokenAmounts, bytes calldata data)
        external
        payable
        override
        returns (address[] memory tokensToBeWithdrawn)
    {
        require(tokenAmounts.length == 1, "ZEIA: should be 1 tokenAmount");

        address token = tokenAmounts[0].token;
        uint256 amount = getAbsoluteAmountDeposit(tokenAmounts[0]);

        (address toToken, bytes memory callData) = abi.decode(data, (address, bytes));

        if (token != ETH) {
            ERC20(token).safeApproveMax(ZERO_EX, amount, "ZEIA");
        }

        tokensToBeWithdrawn = new address[](1);
        tokensToBeWithdrawn[0] = toToken;

        (bool success, bytes memory returnData) =
            ZERO_EX.call{ value: address(this).balance }(callData);
        // solhint-disable-previous-line avoid-low-level-calls

        // assembly revert opcode is used here as `returnData`
        // is already bytes array generated by the callee's revert()
        // solhint-disable-next-line no-inline-assembly
        assembly {
            if eq(success, 0) {
                revert(add(returnData, 32), returndatasize())
            }
        }
    }

    /**
     * @notice Withdraw functionality is not supported.
     * @dev Implementation of InteractiveAdapter function.
     */
    function withdraw(TokenAmount[] calldata, bytes calldata)
        external
        payable
        override
        returns (address[] memory)
    {
        revert("ZEIA: no withdraw");
    }
}
