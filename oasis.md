# Oasis

```
contract Oasis = {
  version: 1.0,
  lib: makerdao/maker-otc
  address: {
    mainnet: 0x14fbca95be7e99c15cc2996c6c9d841e54b79425
  },
  description: "Oasis"
}

type Offer {
  id: Int
  pair: Pair index
  amt: Int
  gem: Address
  quoteAmount: Float
  quoteGem: Address
  lad: Address index
  cancelled: Boolan index
  block: Int
  time: Datetime
  tx: String
}

type Trade {
  id: Int
  pair: Pair index
  maker: Address index
  makerAmt: Float
  makerGem: Address
  taker: Address index
  takerAmount: Float
  takerGem: Address
  block: Int
  time: Datetime
  tx: String
}

event LogMake {
  Offer.create {
    id: event.id
    pair: event.pair
    amt: event.pay_amt
    gem: event.pay_gem
    quoteAmount: event.buy_amt
    quoteGem: event.buy_gem
    lad: event.maker
    cancelled: false
    block: event.blockNumber
    time: event.timestamp
    tx: event.transactionHash
  }
}

event LogTake {
  Trade.create {
    id: event.id
    pair: Dict.pairs(event.pair)
    maker: event.maker
    makerAmt: event.give_amt
    makerGem: event.pay_gem
    taker: event.taker
    takerAmount: event.take_amt
    takerGem: event.buy_gem
    block: Int
    time: Datetime
    tx: String
  }
}

event LogKill {
  Trade(id: event.id).set {
    cancelled: true
  }
}

type Dict {
  pairs: {
    0x1: 'MKR/WETH',
    0x2: 'MKR/DAI'
  }
}

type Query {
  allOrders(...): [Order]
  allTrades(...): [Trade]
}
```
