const ProtocolAdapterRegistry = artifacts.require('ProtocolAdapterRegistry');

let protocolNames = [];
let erc20metadata = [];
let adapters = [];
let tokens = [];
let tokenAdapters = [];

module.exports = async (deployer, network, accounts) => {
  adapters.push(['']);
  tokens.push([[]]);
  protocolNames.push(web3.utils.toHex('Initial protocol name'));
  erc20metadata.push([
    'Name',
    'Description',
    'WebsiteURL',
    'IconURL',
    '0',
  ]);

  tokenAdapters.push(
    '',
  );

  await ProtocolAdapterRegistry.at('0x06FE76B2f432fdfEcAEf1a7d4f6C3d41B5861672')
    .then(async (registry) => {
      await registry.contract.methods.addProtocolAdapters(
        protocolNames,
        erc20metadata,
        adapters,
        tokens,
      )
        .send({
          from: accounts[0],
          gasLimit: '5000000',
        });
      await registry.contract.methods.addTokenAdapters(
        [
          web3.utils.toHex('Initial token name'),
        ],
        tokenAdapters,
      )
        .send({
          from: accounts[0],
          gasLimit: '5000000',
        });
    });
};
