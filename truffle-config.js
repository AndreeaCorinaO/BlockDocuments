;

module.exports = {
  networks: {
    ganache: {
      host:"127.0.0.1",
      port: 7545,
      network_id: "*" ,//Any network id
      gas: 4700000
    },
    blockchain: {
      host: "localhost",
      port: 8545,
      network_id: "4224",
      gas: 4700000

    }
  },

    
  compilers: {
    solc: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    
    }
  }
}
