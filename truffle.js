require('@babel/register');
require('core-js');
require('regenerator-runtime/runtime');
require('dotenv').config();

const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*',
      networkCheckTimeout: 20000,
    },
    coverage: {
      host: '127.0.0.1',
      network_id: '*',
      port: 8555,
      gas: 0xfffffffffff,
      gasPrice: 1,
    },
    mainnet: {
      provider: () => new HDWalletProvider(process.env.MNEMONIC, `https://mainnet.infura.io/v3/${process.env.INFURA_API_KEY}`, 0),
      network_id: 1,
      gas: 1000000,
      gasPrice: 4000000000,
      timeoutBlocks: 200,
    },
  },
  compilers: {
    solc: {
      version: '0.6.0',
      settings: {
        optimizer: {
          enabled: true,
          runs: 200,
        },
      },
    },
  },
};
