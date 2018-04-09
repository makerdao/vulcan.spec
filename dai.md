## Dai bin

```
contract Bin = {
  version: 1.0
  lib: rainbreak/coins
  address: {
    mainnet: ???
    kovan: ???
  }
  desc: "Mult-collateral dai"
}

type Ilk {
  id: Int
  spot: Int
  rate: Int
  line: Float
  art: Float
  gem: Address
  flip: Address
  block: Int
  time: Datetime
  tx: String
}

type Urn {
  ilk: Int { left join ilk on block }
  guy: Address
  ink: Float
  art: Float
  block: Int
  time: Datetime
  tx: String
}

join Urn::Ilk { left join ilk on urn.block = ilk.block }

attribute Urn::tab { art * ilk.rate }

event Form {
  Ilk.create {
    id: event.id
    spot: event.spot
    rate: event.rate
    line: event.line
    art: 0
    gem: event.gem
    flip: event.flip
    block: event.blockNumber
    time: event.timestamp
    tx: event.transactionHash
  }
}

event File|Fuss {
  Ilk.create
}

event Frob {
  Urn.create {
    ilk: event.ilk
    guy: event.guy
    ink: event.ink
    art: event.art
    block: event.blockNumber
    time: event.timestamp
    tx: event.transactionHash
  }
}

event Bump {
  Urn.create
}
```

```
views:
  ilks.sql
```

### Example Queries

Don't mix data & query in definitions

TODO

Convention for retrieving latest object vs entire history of objects.

```

```
