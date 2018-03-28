# Tub

```
contract Tub = {
  version: 1.0
  lib: makerdao/sai
  address: {
    kovan:   0xa6bfc88aa5a5981a958f9bcb885fcb3db0bf941e
    mainnet: 0x448a5065aebb8e423f0896e6c5d525c040f59af3
  }
  description: "Dai 1.0 Tub"
}

type CupAction {
  id:      Int index
  lad:     Address index
  ink:     Float
  art:     Float
  ire:     Float
  act:     Act
  arg:     String
  bag:     Float
  ratio:   Float
  block:   Int
  time:    Datetime
  tx:      String
  deleted: Boolean
  bag:     Func(Price::pip * Price::per * CupAct::ink)
  ratio:   Func(CupAct::bag / CupAct::art)
}

type CupInterval {
  tick: Datetime
  minPip: Float
  maxPip: Float
  minBag: Float
  maxBag: Float
  minRatio: Float
  maxRatio: Float
  act: Act
  arg: String
  ink: Float
  art: Float
  time: Datetime
}

type Cup implements CupAction {
  actions: [CupAction]
  history: [CupInterval]
}

type Price {
  pep: Float
  pip: Float
  per: Float
  block: Int
  time: Datetime
  tx: String
}

enum Act {
  open
  join
  exit
  lock
  free
  draw
  wipe
  shut
  bite
}

event NewBlock {
  Price.create {
    pip:   Tub.pip
    pep:   Tub.pep
    per:   Tub.per
    block: event.blockNumber
    tx:    event.transactionHash
  }
}

event LogNewCup {
  CupAction.create {
    id:    event.cup
    lad:   event.lad
    art:   0
    ink:   0
    act:   'open'
    arg:   null
    block: event.blockNumber
    tx:    event.transactionHash
  }
}

event LogNote([
  sig: "give(bytes32,address)", sig: "lock(bytes32,uint256)",
  sig: "free(bytes32,uint256)", sig: "draw(bytes32,uint256)",
  sig: "wipe(bytes32,uint256)", sig: "bite(bytes32)"
]) {
  state cup = Tub.call cups[event.foo]
  CupAction.create {
    id: event.foo
    lad: cup.lad
    art: cup.art
    ink: cup.ink
    ire: cup.ire
    block: event.blockNumber
}

event LogNote(sig: "shut(bytes32)") {
  CupAction(id: event.foo).set {
    deleted: true
  }
}

type Query {
  Query: {
    CupActions(args): [CupAction] {
      CupAction.select(args)
    },

    Cups(args): [Cup] {
      CupAction.distinct(:id)
    },

    Cup(args) {
      CupAction.distinct(:id).select(id: args.id)
    },
  },
  Cup: {
    history(cup): CupInterval {
      SQL
    }
    actions(cup): CupAction {
      SQL
    }
  }
}
```
