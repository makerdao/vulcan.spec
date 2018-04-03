## Fuss auctions

Collateral Auction - pie for gem

```
contract Flap = {
  version: 1.0
  lib: rainbreak/fuss
  address: {
    mainnet: ???
    kovan: ???
  }
  desc: "Flap(WETH,DAI)"
}

type Bid {
  id:  Int
  gal: Address     // gem receiver
  lot: Decimal     // pie for sale
  guy: Address     // high bidder (msg.sender)
  bid: Decimal     // gems paid
  tic: Datetime    // time of last bid
  end: Datetime    // max auction duration
  block: Int
  time: Datetime
  tx: String
}

kick
  - create bid
  - pull lot amount of pie from sender
tend
  - pull higher bid of gem
  - push previous bid of gem
deal
  - push pie
  - delete auction
```

Buy & Burn Auction
Sell gems up to a given amount of pie

```
contract Flip = {
  version: 1.0
  lib: rainbreak/fuss
  address: {
    mainnet: ???
    kovan: ???
  }
  desc: "Flip(0x01, MKR:WETH)"
}

type Bid {
  id:  Int
  gal: Address     // pie receiver
  lot: Decimal     // gem for sale
  guy: Address     // high bidder (msg.sender)
  bid: Decimal     // pie paid
  tab: Decimal     // total pie wanted
  tic: Datetime    // time of last bid
  end: Datetime    // max auction duration
  lad: Address     // forgone gem receiver
  block: Int
  time: Datetime
  tx: String
}

kick
  - create bid
  - pull lot amount of gem from sender
tend
  - pull higher bid of pie
  - push previous bid of pie
dent
  - move bid of pie from msg.sender to bid.guy
  - push remaining pie to lad
deal
  - push gem
  - delete auction
```
