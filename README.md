
**DeFi SDK** is an open-source system of smart contracts that allows you to execute trades with ERC20 tokens and track balances on different protocols.

![](https://i.ibb.co/RC54SjL/defisdk.png)

## Features

**💸Trade any ERC20 tokens on L2 chains using single Router contract**
> See [How to swap ERC20 tokens using DeFi SDK Router](docs/router.md)

**💥Query user assets and debt deposited in DeFi protocols like *Maker, Aave, dYdX*, etc.**
> How much debt does `0xdead..beef` have on Compound?

**📊Get the underlying components of complex derivative ERC20 tokens**
> How much `cUSDC` vs `ETH` does `ETHMACOAPY` have?

**✨Interact with multiple DeFi protocols in a unified way**
> See [How to interact with DeFi SDK contracts](docs/interacting.md)

## Trading Features

* Trade any ERC20 token
* Two types of amounts: absolute (usual amount) and relative (percentage of balance)
* Three types of `permit()` functions for approving tokens in the same transaction (EIP2612, DAI-like, Yearn-like)
* Two types of swaps: with fixed input amount or fixed output amount
* Two types of fees:
  * **protocol fee** managed by the **Router** contract owner with possibility of one-time discounts requiring signature of an address with the special role
  * **marketplace fee** managed by the transaction creator
* Relayed transactions requiring just an EIP712 signature of the user


## Security Vulnerabilities 🛡

All security vulnerabilities will be promptly addressed.

The project uses [Slither](https://github.com/crytic/slither) for security analysis.
It should be previously installed (e.g. via [pip](https://pypi.org/project/pip/)).

Run `npm run slither` to run security checks.

## Dev Notes

We use [Hardhat](https://github.com/NomicFoundation/hardhat), which runs tests extremely fast!

Also, we use [Truffle Dashboard](https://trufflesuite.com/docs/truffle/getting-started/using-the-truffle-dashboard/) for secure deployment.

### Installation

Run `npm install` to install all the dependencies.

### Deployment

Run `npm run truffle-dashboard` to start the Truffle Dashboard.

Run `npm run deploy:router:truffle-dashboard` to deploy the **Router** contract.
Sign deployment transaction in your browser at `http://localhost:24012/`.

Fill in address of newly deployed contract to `scripts/deployment.js`.

The same instruction applies to the **SimpleCaller** contract with `deploy:sc:truffle-dashboard` command.

After filling in fee beneficiary for the chosen network in `scripts/deployment.js`, `initialize:router:truffle-dashboard` command may be run.

Run `npm run verify` to verify contract on any block explorer.
The respective `<BLOCK_EXPLORER>_API_KEY` filled in `.env` file is required for this step.
See the `hardhat.config.ts` file for the details (`etherscan` field of `config` variable uses these API keys).

### Testing & Coverage

The **Router** contract and its dependencies is fully covered with tests.

Run `npm run test` and `npm run coverage` to run tests or coverage respectively.
`INFURA_API_KEY` filled in `.env` file is required for this step.
`REPORT_GAS` filled in `.env` file enables/disables gas reports during tests.

### Linting

Run `npm run lint` for both JS and Solidity linters.

Run `npm run lint:eslint` and `npm run lint:solhint` to run linter for JS and Solidity separately.

### Serve docs

`npm run docs:serve`

## License

All smart contracts are released under GNU LGPLv3 license.
