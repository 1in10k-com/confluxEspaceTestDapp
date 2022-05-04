<template>
  <div>
    <div class="board1">
      <p>第一个board</p>
      <p>此board拥有者为：{{ boardOwner[0] }}</p>
      <p>此board广告词为：{{ boardWords[0] }}</p>
      <p>此board出售价为：{{ boardPrice[0] }}</p>
      <button @click="buy1">buy</button>
      <div></div>
      <input
        type="text"
        v-model="desirePrice1"
        placeholder="在此处修改boardPrice"
      />
      <button @click="modifyPrice1">modifyPrice</button>
      <div></div>
      <input
        type="text"
        v-model="desireWords1"
        placeholder="在此处修改boardWords"
      />
      <button @click="modifyWords1">modifyWords</button>
      <p>
        注：当此board拥有者为你的当前账号地址时，你可使用modifyPrice修改报价，使用modifyWords修改广告词。当此board拥有者不是你的当前账号时，你可使用buy按钮付出报价费用并将此board拥有者变更为你的当前账号
      </p>
    </div>
    <div class="board2">
      <p>第二个board</p>
      <p>此board拥有者为：{{ boardOwner[1] }}</p>
      <p>此board广告词为：{{ boardWords[1] }}</p>
      <p>此board出售价为：{{ boardPrice[1] }}</p>
      <p style="font-size: 20px">为简化，暂不做此board的前端</p>
    </div>
    <div class="board3">
      <p>第三个board</p>
      <p>此board拥有者为：{{ boardOwner[2] }}</p>
      <p>此board广告词为：{{ boardWords[2] }}</p>
      <p>此board出售价为：{{ boardPrice[2] }}</p>
      <p style="font-size: 20px">为简化，暂不做此board的前端</p>
    </div>
  </div>
</template>

<script>
import { ethers, utils } from "ethers";
// import { ethers } from "ethers";
import Web3Modal from "web3modal";
// import { marketaddress } from "../../config";
let marketaddress = "0x8991643d7E95728e82E9aa8FF702C06C88b14619";
import Market from "../../artifacts/contracts/Market.sol/Market.json";
export default {
  data() {
    return {
      price1: null,
      price2: null,
      price3: null,
      boardOwner: ["111111", "22222", "33333"],
      boardWords: ["111111", "22222", "33333"],
      boardPrice: ["111111", "22222", "33333"],
      desirePrice1: null,
      desireWords1: null,
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
      let transaction1 = await marketContract.getBoardInfo(1);
      let transaction2 = await marketContract.getBoardInfo(2);
      let transaction3 = await marketContract.getBoardInfo(3);
      this.boardOwner = [transaction1[1], transaction2[1], transaction3[1]];
      this.boardWords = [transaction1[0], transaction2[0], transaction3[0]];
      this.boardPrice = [transaction1[2], transaction2[2], transaction3[2]];
    },
    async buy1() {
      const web3Modal = new Web3Modal();
      const connection = await web3Modal.connect();
      const provider = new ethers.providers.Web3Provider(connection);
      const signer = provider.getSigner();
      let marketContract = new ethers.Contract(
        marketaddress,
        Market.abi,
        signer
      );
      console.log("this.boardPrice[0]");
      console.log(parseInt(this.boardPrice[0], 10));
      let priceString = parseInt(this.boardPrice[0], 10).toString();
      let overrides = {
        value: utils.parseEther(priceString),
      };
      console.log("priceString");
      console.log(priceString);
      await marketContract.modifyBoardOwner(1, overrides);
    },
    async modifyPrice1() {
      const web3Modal = new Web3Modal();
      const connection = await web3Modal.connect();
      const provider = new ethers.providers.Web3Provider(connection);
      const signer = provider.getSigner();
      let marketContract = new ethers.Contract(
        marketaddress,
        Market.abi,
        signer
      );
      await marketContract.modifyPrice(1, parseInt(this.desirePrice1));
    },
    async modifyWords1() {
      const web3Modal = new Web3Modal();
      const connection = await web3Modal.connect();
      const provider = new ethers.providers.Web3Provider(connection);
      const signer = provider.getSigner();
      let marketContract = new ethers.Contract(
        marketaddress,
        Market.abi,
        signer
      );
      await marketContract.modifyWords(1, this.desireWords1);
    },
  },

  created() {
    this.initial();
  },
};
</script>

<style scoped>
.board1 {
  width: 500px;
  height: 220px;
  border: 1px solid red;
  /* display: inline-block; */
  margin-right: 10px;
  font-size: 10px;
  margin-bottom: 20px;
  padding: 20px;
}
.board2 {
  width: 500px;
  height: 220px;
  border: 1px solid red;
  /* display: inline-block; */
  margin-right: 10px;
  font-size: 10px;
  margin-bottom: 20px;
  padding: 20px;
}
.board3 {
  width: 500px;
  height: 220px;
  border: 1px solid red;
  /* display: inline-block; */
  margin-right: 10px;
  font-size: 10px;
  margin-bottom: 20px;
  padding: 20px;
}
</style>
