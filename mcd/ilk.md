# Ilk

Ilk objects hold configuration paramaters for a particular type of collateral.

```graphql
type Ilk {
  id:    String         # ilk identifier e.g ETH
  pip:   Address        # price feed contract
  mat:   Address        # liquidation ratio
  chop:  Float          # liquidation penalty
  lump:  Float          # flip auction lot size
  flip:  Address        # flipper contract
  rho:   Era            # time of last drip
  duty:  Float          # stability fee
  Art:   Float          # total debt outstanding
  rate:  Float          # debt scaling factor
  spot:  Float          # price feed with margin
  line:  Float          # debt ceiling
  dust:  Float          # debt floor
  files: [IlkFileEvent] # state change events
  bites: [BiteEvent]    # ilk bite events
  frobs: [FrobEvent]    # ilk frob events
  created: Datetime
  updated: Datetime
}
```

## State change triggers

Ilk parameters are changed via these functions:

| Call           | Log Event | State change         | Vulcanize Event |
| -------------- | --------- | -------------------- | --------------- |
| Spot.file(pip) | DSNote    | Spot.ilks[e.ilk].pip | IlkFileEvent |
| Spot.file(mat) | DSNote    | Spot.ilks[e.ilk].mat | IlkFileEvent |
| Cat.file(chop) | DSNote    | Cat.ilks[e.ilk].chop | IlkFileEvent |
| Cat.file(lump) | DSNote    | Cat.ilks[e.ilk].lump | IlkFileEvent |
| Cat.file(flip) | DSNote    | Cat.ilks[e.ilk].flip | IlkFileEvent |
| Jug.file(duty) | DSNote    | Jug.ilks[e.ilk].duty | IlkFileEvent |
| Jug.drip       | DSNote    | Jug.ilks[e.ilk].rho  |              |
| Vat.init       | DSNote    | Vat.ilks[e.ilk].rate |              |
| Vat.fold       | DSNote    | Vat.ilks[e.ilk].rate |              |
| Vat.frob       | DSNote    | Vat.ilks[e.ilk].Art  | FrobEvent    |
| Vat.grab       | DSNote    | Vat.ilks[e.ilk].Art  |              |
| Vat.file(dust) | DSNote    | Vat.ilks[e.ilk].dust | IlkFileEvent |
| Vat.file(line) | DSNote    | Vat.ilks[e.ilk].line | IlkFileEvent |
| Spot.poke      | Poke      | Vat.ilks[e.ilk].spot | PokeEvent    |

## IlkFileEvent

An `IlkFileEvent` is created each time a governance action (`file`) is executed
for a particular Ilk.

```graphql
type IlkFileEvent {
  ilk:   Ilk        # ilk object
  what:  String     # field changed
  data:  String     # parsed data (number or address)
  tx:    Tx         # transaction meta
}
```

## Ilk Query

Basic `Ilk` retrieval with postgraphile-style collection filtering:

TODO: Aggregation. History.

```graphql
type Query {

   allIlks(
     first:     Int,
     last:      Int,
     offset:    Int,
     before:    Cursor,
     after:     Cursor,
     orderBy:   IlkOrderBy,
     condition: IlkCondition,
     filter:    IlkFilter
   ): [Ilk]

   getIlk(
     id: String!
     blockNumber: Int # optionally retrieve ilk state at a given block height
   ): Ilk

   allIlkFileEvents(
     first:     Int,
     last:      Int,
     offset:    Int,
     before:    Cursor,
     after:     Cursor,
     orderBy:   IlkFileEventOrderBy,
     condition: IlkFileEventCondition,
     filter:    IlkFileEventFilter
   ): [IlkFileEvent]

}
```
