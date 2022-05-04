<template>
  <div>请忽略此页面</div>
</template>

<script>
import { ethers } from "ethers";
import Web3Modal from "web3modal";
import { marketaddress } from "../../config";
import Market from "../../artifacts/contracts/Market.sol/Market.json";
export default {
  data() {
    return {
      red: "red",
      yellow: "yellow",
      green: "green",
    };
  },
  methods: {
    async initial() {
      const web3Modal = new Web3Modal();
      const connection = await web3Modal.connect();
      const provider = new ethers.providers.Web3Provider(connection);
      const signer = provider.getSigner();
      let marketContract = new ethers.Contract(
        marketaddress,
        Market.abi,
        signer
      );
      let transaction = await marketContract.getBoardInfo(1);
      console.log("transaction");
      console.log(transaction);
    },
  },

  mounted() {
    this.initial();
  },
};
</script>

<style scoped></style>
