# Chief

```
contract Chief {
  version: 1.0
  lib: dapphub/ds-chief
  pg: DATABASE_URL
  address: { mainnet: 0x01 }
  description: "DSChief approval voting"
}

type Vote {
  guy: Address
  slate: String
  block: Int
  time: Datetime
  tx: String
}

type Approval {
  guy: Address
  amt: Float
  block: Int
  time: Datetime
  tx: String
}

type Deposit {
  guy: Address
  act: String
  arg: Float
  block: Int
  time: Datetime
  tx: String
}

type Slate {
  id: String
  yays: [Address]
  block: Int
  time: Datetime
  tx: String
}

type Hat {
  guy: Address
  block: Int
  time: Datetime
  tx: String
}

event LogNote(sig: 'lock(uint)') {
  Deposit.create {
    guy:   event.guy
    act:   'lock'
    arg:   event.returnValues.foo
    block: event.blockNumber
    time:  event.timestamp
    tx:    event.transactionHash
  }
}

event LogNote(sig: 'free(uint)') {
  Deposit.create {
    guy:   event.guy
    act:   'free'
    arg:   event.returnValues.foo
    block: event.blockNumber
    time:  event.timestamp
    tx:    event.transactionHash
  }
}

event Etch {
  Slate.create {
    id:   event.slate
    yays: Chief.call yays[log.slate]
  }
}

event LogNote(sig: 'lift(address)') {
  Hat.create {
    guy:   event.foo
    block: event.blockNumber
    time:  event.timestamp
  }
}


event LogNote(sig: 'vote(bytes32)') {
  Vote.create {
    guy:   event.guy
    slate: event.foo
    block: event.blockNumber
    time:  event.timestamp
  }
  // TODO - update approvals via trigger
  Slate(id: event.foo).each(yay) =>
    Approval(guy: yay) {
      weight: Deposit(guy: event.guy).sum
    }
}
```
