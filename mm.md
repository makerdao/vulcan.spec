```
contract tub = 0x01

type Cup {
  id:  "int"
  lad: "address",
  ink: "wad",
  art: "wad",
  ire: "wad"
}

type Gov {
  mat: "decimal"
}

collection cups [Cup]

collection gov [Gov]

On event LogNewCup => log
  cups append {
    id: log.cup
    lad: log.lad
    art: 0
    ink: 0
    block: log.blockNumber
  }

On event [LogNote(sig), LogNote(sig)]
  event { block, time, foo, bar }
  lookup cup = cups[event.foo]
  state { cup.lad, cup.ink, cup.art, cup.ire }
  append cups event.time :: event.block :: event.bar as arg :: state

On event LogNote('mold')
  event { block, time, foo, bar }
  state { tub.mat, tub.tax, tub.gat, tub.fee }
  insert gov event << state

def view SQL
```

```
def contract oasis = 0x14fbca95be7e99c15cc2996c6c9d841e54b79425

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

collection offers [Offer]
collection trades [Trade]


On event LogMake => log
  insert offers {
    id: log.id
    pair: log.pair
    ...
  }

On event LogTake => log
  insert trades {
    id: log.id
    pair: log.pair
    ...
  }

On event LogKill => log
  update trades(id: log.id) {
    deleted: true
  }

```
