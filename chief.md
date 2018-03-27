# Chief

```
contract Chief = {
  version: 1.0
  lib: dapphub/ds-chief
  address: { mainnet: 0x01 }
  description: "DSChief approval voting"
}

type Vote {
  guy: Address
  slate: String
}

type Approval {
  guy: Address
  amt: Float
}

type Deposit {
  guy: Address
  act: String
  arg: Float
}

type Slate {
  id: String
  yays: [Address]
}

type Hat {
  guy: Address
}

On event LogNote(sig: 'lock(uint)') => log
  insert Deposit {
    guy:   log.guy
    act:   'lock'
    arg:   log.returnValues.foo
    block: log.blockNumber
    time:  log.timestamp
    tx:    log.transactionHash
  }

On event LogNote(sig: 'free(uint)') => log
  insert Deposit {
    guy:   log.guy
    act:   'free'
    arg:   log.returnValues.foo
    block: log.blockNumber
    time:  log.timestamp
    tx:    log.transactionHash
  }

On event Etch => log
  state yays = Chief.call yays[log.slate]
  insert Slate {
    id:   log.slate
    yays: yays
  }

On event LogNote(sig: 'lift(address)') => log
  insert Hat {
    guy:   log.foo
    block: log.blockNumber
    time:  log.timestamp
  }


// Vote - assign weight to a Slate
On event LogNote(sig: 'vote(bytes32)') => log
  insert Vote {
    guy:   log.guy
    slate: log.foo
    block: log.blockNumber
    time:  log.timestamp
  }
  // TODO - update approvals via trigger
  Slate(id: log.foo).each(yay) =>
    Approval(guy: yay) {
      weight: Deposit(guy: log.guy).sum
    }

```
