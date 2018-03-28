# Chief

```
contract Chief {
  version: 1.0
  lib: dapphub/ds-chief
  pg: DATABASE_URL
  address: { mainnet: 0x01 }
  description: "DSChief approval voting"
}

#
type Vote {
  guy: Address
  slate(id: Address): Slate
  amt: Float
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
  amt: Float
  block: Int
  time: Datetime
  tx: String
}

type Slate {
  id: Keccak256 index
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
  // TODO - update approvals via trigger
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
  // TODO - update approvals via trigger
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
  Slate(id: event.foo).yays.each => yay {
    Approval(guy: yay).set {
      amt: Chief.call approvals[yay]
    }
  }
}

type Query {
  allDeposits(args): [Deposit]
  allSlates(args): [Slate]
  allDeposits(args): [Vote]
  allDeposits(args): [Approval]
}

sql {
  create function approve() returns trigger AS $vote$
  begin
  // TODO
  end;
$vote$ language plpgsql;

create trigger vote
  after insert on vote
  for each row
  execute_procedure approve();
}
```
