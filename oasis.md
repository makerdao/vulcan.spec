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
  pair: Pair
  amt: Int
  gem: Address
  quoteAmount: Float
  quoteGem: Address
  lad: Address
  cancelled: Boolan
  block: Int
  time: Datetime
  tx: String
}

type Trade {
  id: Int
  pair: Pair
  maker: Address
  makerAmt: Float
  makerGem: Address
  taker: Address
  takerAmount: Float
  takerGem: Address
  block: Int
  time: Datetime
  tx: String
}

On event LogMake => log
  insert Offer {
    id: log.id
    pair: log.pair
    amt: log.pay_amt
    gem: log.pay_gem
    quoteAmount: log.buy_amt
    quoteGem: log.buy_gem
    lad: log.maker
    cancelled: false
    block: log.blockNumber
    time: log.timestamp
    tx: log.transactionHash
  }

On event LogTake => log
  insert Trade {
    id: log.id
    pair: log.pair
    maker: log.maker
    makerAmt: log.give_amt
    makerGem: log.pay_gem
    taker: log.taker
    takerAmount: log.take_amt
    takerGem: log.buy_gem
    block: Int
    time: Datetime
    tx: String
  }

On event LogKill => log
  update Trade(id: log.id) {
    cancelled: true
  }

dict pairs {
  0x1: 'MKR/ETH'
}

```
