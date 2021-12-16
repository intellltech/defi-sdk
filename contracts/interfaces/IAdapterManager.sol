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

import { AdapterNameAndAddress } from "../shared/Structs.sol";

/**
 * @title Contract responsible for adapters management.
 * @dev Interface for ProtocolAdapterRegistry and TokenAdaptersRegistry.
 * @author Igor Sobolev <sobolev@zerion.io>
 */
interface IAdapterManager {
    /**
     * @notice Emits old and new adapter addersses.
     * @param adapterName Adapter's name.
     * @param oldAdapterAddress Old adapter's address.
     * @param newAdapterAddress New adapter's address.
     */
    event AdapterSet(
        bytes32 indexed adapterName,
        address indexed oldAdapterAddress,
        address indexed newAdapterAddress
    );

    /**
     * @notice Sets adapters (adds, updates or removes).
     * @param adaptersNamesAndAddresses Array of the new adapters' names and addresses.
     * @dev Can be called only by the owner.
     */
    function setAdapters(AdapterNameAndAddress[] calldata adaptersNamesAndAddresses) external;

    /**
     * @param name Name of the adapter.
     * @return Address of adapter.
     */
    function getAdapterAddress(bytes32 name) external view returns (address);
}
