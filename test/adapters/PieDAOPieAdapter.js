import displayToken from '../helpers/displayToken';
import convertToBytes32 from '../helpers/convertToBytes32';

const PIE_DAO_ASSET_ADAPTER = convertToBytes32('PeiDAO Pie Adapter');
const EMPTY_BYTES32 = '0x0000000000000000000000000000000000000000000000000000000000000000';

const ProtocolAdapterRegistry = artifacts.require('ProtocolAdapterRegistry');
const TokenAdapterRegistry = artifacts.require('TokenAdapterRegistry');
const ProtocolAdapter = artifacts.require('ERC20ProtocolAdapter');
const TokenAdapter = artifacts.require('PieDAOPieTokenAdapter');
const ERC20TokenAdapter = artifacts.require('ERC20TokenAdapter');

contract('PieDAOPieAdapter', () => {
  const BTCPPAddress = '0x0327112423F3A68efdF1fcF402F6c5CB9f7C33fd';
  const USDPPAddress = '0x9A48BD0EC040ea4f1D3147C025cd4076A2e71e3e';
  // Balancer BTC++ / USD++ Pool
  const testAddress = '0x7d2F4bcB767eB190Aed0f10713fe4D9c07079ee8';

  let accounts;
  let protocolAdapterRegistry;
  let tokenAdapterRegistry;
  let protocolAdapterAddress;
  let tokenAdapterAddress;
  let erc20TokenAdapterAddress;

  const wbtc = [
    'Wrapped BTC',
    'WBTC',
    '8',
  ];
  const pbtc = [
    'pTokens BTC',
    'pBTC',
    '18',
  ];
  const imbtc = [
    'The Tokenized Bitcoin',
    'imBTC',
    '8',
  ];
  const sbtc = [
    'Synth sBTC',
    'sBTC',
    '18',
  ];

  beforeEach(async () => {
    accounts = await web3.eth.getAccounts();
    await ProtocolAdapter.new({ from: accounts[0] })
      .then((result) => {
        protocolAdapterAddress = result.address;
      });
    await TokenAdapter.new({ from: accounts[0] })
      .then((result) => {
        tokenAdapterAddress = result.address;
      });
    await ERC20TokenAdapter.new({ from: accounts[0] })
      .then((result) => {
        erc20TokenAdapterAddress = result.address;
      });
    await ProtocolAdapterRegistry.new({ from: accounts[0] })
      .then((result) => {
        protocolAdapterRegistry = result.contract;
      });
    await TokenAdapterRegistry.new({ from: accounts[0] })
      .then((result) => {
        tokenAdapterRegistry = result.contract;
      });
    await protocolAdapterRegistry.methods.addProtocolAdapters(
      [
        PIE_DAO_ASSET_ADAPTER,
      ],
      [
        protocolAdapterAddress,
      ],
      [[
        BTCPPAddress,
        USDPPAddress,
      ]],
    )
      .send({
        from: accounts[0],
        gas: '1000000',
      });
    await tokenAdapterRegistry.methods.addTokenAdapters(
      [EMPTY_BYTES32, convertToBytes32('PieDAO Pie Token')],
      [erc20TokenAdapterAddress, tokenAdapterAddress],
    )
      .send({
        from: accounts[0],
        gas: '1000000',
      });
    await tokenAdapterRegistry.methods.addTokenAdapterNamesByHashes(
      [BTCPPAddress],
      [convertToBytes32('PieDAO Pie Token')],
    )
      .send({
        from: accounts[0],
        gas: '1000000',
      });
  });

  it('should return correct balances', async () => {
    await protocolAdapterRegistry.methods['getBalances(address)'](testAddress)
      .call()
      .then(async (result) => {
        await displayToken(tokenAdapterRegistry, result[0].tokenBalances[0]);
        await displayToken(tokenAdapterRegistry, result[0].tokenBalances[1]);
      });
  });

  it('should return correct underlying tokens', async () => {
    await tokenAdapterRegistry.methods.getFullTokenBalances(
      [
        BTCPPAddress,
      ],
    )
      .call()
      .then((result) => {
        assert.deepEqual(result[0].underlying[0].erc20metadata, wbtc);
        assert.deepEqual(result[0].underlying[1].erc20metadata, pbtc);
        assert.deepEqual(result[0].underlying[2].erc20metadata, imbtc);
        assert.deepEqual(result[0].underlying[3].erc20metadata, sbtc);
      });
  });
});
