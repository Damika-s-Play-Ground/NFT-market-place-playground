const { assert } = require("chai");

const KryptoBird = artifacts.require("./KryptoBirdz");

require("chai")
  .use(require("chai-as-promised"))
  .should();

contract("KryptoBirdz", (accounts) => {
  let contract;
  // before hook
  before(async () => {
    contract = await KryptoBird.deployed();
  });
  // testing container
  describe("deployment", async () => {
    // testing samples with `it`
    it("deploys successfully", async () => {
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
  // testing minting
  describe("minting", async () => {
    it("creates a new token", async () => {
      const result = await contract.mint("#EC058E");
      const totalSupply = await contract.totalSupply();
      // SUCCESS
      assert.equal(totalSupply.words[0], 1);
      const event = result.logs[0].args;
      assert.equal(
        event._from,
        "0x0000000000000000000000000000000000000000",
        "from is correct"
      );
      assert.equal(
        event._to,
        "0xBE30D59AD712B3e50c4253193b4256b5241e1055",
        "to is correct"
      );
      assert.equal(event._tokenId.words[0], 0, "id is correct");
      // FAILURE: cannot mint same KryptoBird twice
      await contract.mint("#EC058E").should.be.rejected;
    });
  });

  describe("indexing", async () => {
    it("lists KryptoBirds", async () => {
      // Mint 3 more tokens
      await contract.mint("#5386E4");
      await contract.mint("#FFFFFF");
      await contract.mint("#000000");
      const totalSupply = await contract.totalSupply();

      let KryptoBird;
      let result = [];
        console.log(contract.KryptoBirdz);
      for (var i = 1; i <= totalSupply; i++) {
        KryptoBird = await contract.kryptoBirdz(i - 1);
        result.push(KryptoBird);
      }

      let expected = ["#EC058E", "#5386E4", "#FFFFFF", "#000000"];
      assert.equal(result.join(","), expected.join(","));
    });
  });

});
