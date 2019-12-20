# Auctions

There are three auction types - the collateral auction `Flip`, the debt auction
`Flop` and the surplus auction `Flap`. `Flap` and `Flop` auctions are initiated
by the `Vow`. Collateral auctions are initiated by the `Cat`.

Bids are unique by `id` and `lad` - the action contract address.

```graphql
interface BidLike {
  id(lad: Address = LAD): Integer # auction contract bid identifier
  guy: Address                    # highest bidder
  tic: Era                        # bid expiry
  end: Era                        # auction expiry
  lot: Float                      # lot amount
  bid: Float                      # bid amount
  gal: Address                    # receives auction proceeds
  dealt: Boolean                  # true if auction has been settled
  events: [BidEvent]              # bid state change events
  created: Datetime
  updated: Datetime
}

type Flip implements BidLike {
  lot:     Float      # GEM amount
  bid:     Float      # DAI amount
  urn:     Urn        # urn object
  ilk:     Ilk        # ilk object
  tab:     Integer    # amount of Dai to raise - (tend/dent phase switch)
}

type Flap implements BidLike {
  lot:     Float      # DAI amount
  bid:     Float      # MKR amount
}

type Flop implements BidLike {
  lot:     Float      # MKR amount
  bid:     Float      # DAI amount
}
```

## BidEvent

```graphql
type BidEvent {
  bid:   Bid     # bid object
  lot:   Float   # e.lot - lot amount
  bid:   Float   # e.bid - bid amount
  act:   BidAct  # bid action
  tx:    Tx      # transaction meta
}

union Bid = Flip | Flap | Flop

enum BidAct {
  KICK
  TICK
  TEND
  DENT
  DEAL
  YANK
}
```

## State change triggers

Bids are created on `kick` and updated with every subsequent bid event.

| Call           | Log Event | State change        | Vulcanize Event |
| -------------- | --------- | ------------------- | --------------- |
| Flipper.kick   | Kick      | Flipper.bids[e.id]  | BidEvent        |
| Flipper.tick   | DSNote    | Flipper.bids[e.id]  | BidEvent        |
| Flipper.tend   | DSNote    | Flipper.bids[e.id]  | BidEvent        |
| Flipper.dent   | DSNote    | Flipper.bids[e.id]  | BidEvent        |
| Flipper.deal   | DSNote    | Flipper.bids[e.id]  | BidEvent        |
| Flipper.yank   | DSNote    | Flipper.bids[e.id]  | BidEvent        |
| Flopper.kick   | Kick      | Flopper.bids[e.id]  | BidEvent        |
| Flopper.tick   | DSNote    | Flopper.bids[e.id]  | BidEvent        |
| Flopper.tend   | DSNote    | Flopper.bids[e.id]  | BidEvent        |
| Flopper.deal   | DSNote    | Flopper.bids[e.id]  | BidEvent        |
| Flopper.yank   | DSNote    | Flopper.bids[e.id]  | BidEvent        |
| Flapper.kick   | Kick      | Flapper.bids[e.id]  | BidEvent        |
| Flapper.tick   | DSNote    | Flapper.bids[e.id]  | BidEvent        |
| Flapper.tend   | DSNote    | Flapper.bids[e.id]  | BidEvent        |
| Flapper.deal   | DSNote    | Flapper.bids[e.id]  | BidEvent        |
| Flapper.yank   | DSNote    | Flapper.bids[e.id]  | BidEvent        |


## Bid Query

Retrieve Bids with postgraphile-style collection filtering.  _Active_ auctions are defined as those in which a `deal` 
transaction has not occurred. 

```graphql
type Query {

   allFlips(
     first:     Int,
     last:      Int,
     offset:    Int,
     before:    Cursor,
     after:     Cursor,
     orderBy:   BidOrderBy,
     condition: BidCondition,
     filter:    BidFilter
   ): [Flip]

   activeFlips(
     first:     Int,
     last:      Int,
     offset:    Int,
     before:    Cursor,
     after:     Cursor,
     orderBy:   BidOrderBy,
     condition: BidCondition,
     filter:    BidFilter
   ): [Flip]

   getFlip(
     id:          Int!
     ilk:         String!
     blockNumber: Int
   ): Flip

   allFlaps(
     first:     Int,
     last:      Int,
     offset:    Int,
     before:    Cursor,
     after:     Cursor,
     orderBy:   BidOrderBy,
     condition: BidCondition,
     filter:    BidFilter
   ): [Flap]

   activeFlaps(
     first:     Int,
     last:      Int,
     offset:    Int,
     before:    Cursor,
     after:     Cursor,
     orderBy:   BidOrderBy,
     condition: BidCondition,
     filter:    BidFilter
   ): [Flap]

   getFlap(
     id:          Int!
     blockNumber: Int
   ): Flap

   allFlops(
     first:     Int,
     last:      Int,
     offset:    Int,
     before:    Cursor,
     after:     Cursor,
     orderBy:   BidOrderBy,
     condition: BidCondition,
     filter:    BidFilter
   ): [Flop]

   activeFlops(
     first:     Int,
     last:      Int,
     offset:    Int,
     before:    Cursor,
     after:     Cursor,
     orderBy:   BidOrderBy,
     condition: BidCondition,
     filter:    BidFilter
   ): [Flop]

   getFlop(
     id:          Int!
     blockNumber: Int
   ): Flop

   allBidEvents(
     first:     Int,
     last:      Int,
     offset:    Int,
     before:    Cursor,
     after:     Cursor,
     orderBy:   BidEventOrderBy,
     condition: BidEventCondition,
     filter:    BidEventFilter
   ): [BidEvent]

}
```
