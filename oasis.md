# Oasis

* Source: [makerdao/maker-otc](https://github.com/makerdao/maker-otc)
* Mainnet: [Dec-18-2017](https://etherscan.io/address/0x14fbca95be7e99c15cc2996c6c9d841e54b79425)

### Watched Events

```solidity
event LogMake(
    bytes32  indexed  id,
    bytes32  indexed  pair,
    address  indexed  maker,
    ERC20             pay_gem,
    ERC20             buy_gem,
    uint128           pay_amt,
    uint128           buy_amt,
    uint64            timestamp
);

Create an Offer

event LogTake(
    bytes32           id,
    bytes32  indexed  pair,
    address  indexed  maker,
    ERC20             pay_gem,
    ERC20             buy_gem,
    address  indexed  taker,
    uint128           take_amt,
    uint128           give_amt,
    uint64            timestamp
);

Create a Trade

event LogKill(
    bytes32  indexed  id,
    bytes32  indexed  pair,
    address  indexed  maker,
    ERC20             pay_gem,
    ERC20             buy_gem,
    uint128           pay_amt,
    uint128           buy_amt,
    uint64            timestamp
);

Delete an offer
```

### Views

* offers
* trades

### Types

```graphql
type Offer {
  id: Int!
  pair: Pair
  amt: BigInt
  gem: Address
  quoteAmount: BigFloat
  quoteGem: Address
  lad: Address
  time: Datetime
  cancelled: Boolan
}

type Trade {
  id: Int!
  pair: Pair
  maker: Address
  makerAmt: BigInt
  makerGem: Address
  taker: Address
  takerAmount: BigFloat
  takerGem: Address
  time: Datetime
}

enum Pair {
  MKR/WETH
}
```
