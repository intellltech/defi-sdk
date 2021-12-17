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

pragma solidity 0.8.10;

import { ActionType, AmountType, PermitType, SwapType } from "./Enums.sol";
import { Fee } from "./Structs.sol";

error BadAbsoluteInputAmount(uint256 absoluteInputAmount, uint256 requiredAbsoluteInputAmount);
error BadAccount(address account, address msgSender);
error BadAccountSignature();
error BadAmountType(AmountType amountType, AmountType requiredAmountType);
error BadFee(Fee fee, Fee baseProtocolFee);
error BadFeeAmount(uint256 actualFeeAmount, uint256 expectedFeeAmount);
error BadFeeSignature();
error BadFeeShare(uint256 protocolFeeShare, uint256 baseProtocolFeeShare);
error BadFeeBeneficiary(address protocolFeeBanaficiary, address baseProtocolFeeBeneficiary);
error BadHash(bytes32 hash);
error BadLength(uint256 length, uint256 requiredLength);
error BadMsgSender(address msgSender, address requiredMsgSender);
error BadProtocolAdapterName(bytes32 protocolAdapterName);
error ExceedingDelimiterAmount(uint256 amount);
error ExceedingLimitFee(uint256 feeShare, uint256 feeLimit);
error FailedEtherTransfer(address to);
error HighInputBalanceChange(uint256 inputBalanceChange, uint256 requiredInputBalanceChange);
error InconsistentPairsAndDirectionsLengths(uint256 pairsLength, uint256 directionsLength);
error InputSlippage(uint256 amount, uint256 requiredAmount);
error InsufficientAllowance(uint256 allowance, uint256 requiredAllowance);
error InsufficientMsgValue(uint256 msgValue, uint256 requiredMsgValue);
error LowOutputBalanceChange(uint256 outputBalanceChange, uint256 requiredOutputBalanceChange);
error LowLiquidity(uint256 reserve, uint256 requiredReserve);
error NoneActionType();
error NoneAmountType();
error NonePermitType();
error NoneSwapType();
error PassedDeadline(uint256 timestamp, uint256 deadline);
error TooLowBaseFeeShare(uint256 baseProtocolFeeShare, uint256 baseProtocolFeeShareLimit);
error ZeroAmountIn();
error ZeroAmountOut();
error ZeroFeeBeneficiary();
error ZeroLength();
error ZeroProtocolAdapterRegistry();
error ZeroReceiver();
error ZeroSigner();
error ZeroSwapPath();
