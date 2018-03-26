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

On event LogNewCup => log
  insert Cup {
    id: log.cup
    lad: log.lad
    art: 0
    ink: 0
    block: log.blockNumber
  }

On event [LogNote(sig), LogNote(sig)]
  state cup = cups[event.foo]
  insert Cup {
    id: log.foo
    lad: cup.lad
    art: cup.art
    ink: cup.ink
    ire: cup.ire
    block: log.blockNumber
  }

On event LogNote('mold')
  insert Gov {
    mat: tub.mat
    tax: tub.tax
    fee: tub.fee
    block: log.blockNumber
  }

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

On event LogMake => log
  insert Offer {
    id: log.id
    pair: log.pair
    ...
  }

On event LogTake => log
  insert Trade {
    id: log.id
    pair: log.pair
    ...
  }

On event LogKill => log
  update Trade(id: log.id) {
    deleted: true
  }

```
