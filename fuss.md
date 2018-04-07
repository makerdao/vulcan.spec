## Fuss auctions

```
contract Flip|Flap|Flop = {
  version: 1.0
  lib: rainbreak/fuss
  address: {
    mainnet: ???
    kovan: ???
  }
  desc: "Flip(bin, ilk, pie, gem)"
}

Distinct on id order latest

type Bid {
  id:  Int
  gal: Address  // gem seller bin
  tat: Address  // gem token
  bid: Decimal  // gem amount
  guy: Address  // high bidder (msg.sender)
  tit: Address  // pie token
  lot: Decimal  // pie amount
  tab: Decimal  // total pie wanted
  tic: Datetime // time of last bid
  end: Datetime // max auction duration
  lad: Address  // cdp owner
  src: Address  // auction contract
  block: Int
  time: Datetime
  tx: String
}

event Kick {
  Bid.create {
    id:  event.id
    gal: event.gal
    tat: event.gem
    bid: event.bid
    guy: event.guy
    tit: event.pie
    lot: event.lot
    tab: event.tab
    tic: event.tic
    end: event.end
    lad: event.lad
    src: event.src
    block: event.blockNumber
    time: event.timestamp
    tx: event.transactionHash
  }
}

event Tend {
  Bid.create
}

event Dent {
  Bid.create
}

event Deal {
  Bid(id: event.id).set {
    completed: true
  }
}
```
