import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomiclabs/hardhat-ethers";


const config: HardhatUserConfig = {
  solidity: "0.8.18",
  networks: {
    localhost: {
      url: "http://localhost:8545"
    }
  }
};

export default config;
