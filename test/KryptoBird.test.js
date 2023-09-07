const { assert } = require("chai");

const KryptoBird = artifacts.require("./KryptoBirdz");

require("chai")
  .use(require("chai-as-promised"))
  .should();

contract("KryptoBirdz", (accounts) => {
  let contract;

  // testing container
  describe("deployment", async () => {
    // testing samples with `it`
    it("deploys successfully", async () => {
      contract = await KryptoBird.deployed();
      const address = contract.address;
      assert.notEqual(address, 0x0);
      assert.notEqual(address, "");
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
    });

    it("has a name", async () => {
      const name = await contract.name();
      assert.equal(name, "KryptoBirdz");
    });

    it("has a symbol", async () => {
      const symbol = await contract.symbol();
      assert.equal(symbol, "KRBZ");
    });

    it("has a total supply", async () => {
      const totalSupply = await contract.totalSupply();
      assert.equal(totalSupply.words[0], 0);
    });
  });
});
