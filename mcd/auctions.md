# Auctions

There are three auction types - the collateral auction `Flip`, the debt auction
`Flop` and the surplus auction `Flap`. `Flap` and `Flop` auctions are initiated
by the `Vow`. Collateral auctions are initiated by the `Cat`.

A single `Bid` type is used to represent bids for all auctions. Bids are unique
by `id` and `lad` - the action contract address.

TODO Discuss treatment of bid uniqueness, auction typing.

```graphql
type Bid {
  pk:      Integer    # vulcanize identifier (unique)
  id:      Integer    # bid identifier (non-unique)
  lad:     Address    # auction contract address
  urn:     Address    # urn address (flip only)
  guy:     Address    # highest bidder
  tic:     Era        # bid expiry
  end:     Era        # auction expiry
  lot:     Float      # lot amount
  bid:     Float      # bid amount
  gal:     Address    # receives auction proceeds
  tab:     Address    # amount to raise - (tend/dent phase switch) (flip only)
  dealt:   Boolean    # true if auction has been settled
  market:  Market     # market detail
  type:    BidType    # auction type - flip | flap | flop
  events:  [BidEvent] # bid state change events
  created: Datetime
  updated: Datetime
}

enum BidType {
  FLIP
  FLAP
  FLOP
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
| Flopper.tend   | DSNote    | Flopper.bids[e.id]  | BidEvent        |
| Flopper.deal   | DSNote    | Flopper.bids[e.id]  | BidEvent        |
| Flopper.yank   | DSNote    | Flopper.bids[e.id]  | BidEvent        |
| Flapper.kick   | Kick      | Flapper.bids[e.id]  | BidEvent        |
| Flapper.tend   | DSNote    | Flapper.bids[e.id]  | BidEvent        |
| Flapper.deal   | DSNote    | Flapper.bids[e.id]  | BidEvent        |
| Flapper.yank   | DSNote    | Flapper.bids[e.id]  | BidEvent        |


## Bid Query

Retrieve Bids with postgraphile-style collection filtering:

```graphql
type Query {

   allBids(
     first:     Int,
     last:      Int,
     offset:    Int,
     before:    Cursor,
     after:     Cursor,
     orderBy:   BidOrderBy,
     condition: BidCondition,
     filter:    BidFilter
   ): [Bid]

   getBid(
     pk:          Int!
     blockNumber: Int # optionally retrieve bid state at a given block height
   ): Bid

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
