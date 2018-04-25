## Dai Auctions GraphQL

Bid record

```graphql
type Bid {
  id:    Int!      # bid id
  guy:   String!   # high bidder (taker) address
  gem:   Float!    # gem address
  lot:   Float!    # gem amount
  gal:   String!   # seller (maker) address
  pie:   String!   # pie address
  bid:   Float!    # pie amount
  tab:   Float     # pie amount wanted (flip)
  tic:   Datetime  # time of last bid
  end:   Datetime  # max auction duration
  lad:   String    # cdp owner (if mom is flipper)
  mom:   String!   # auction contract address
  dealt: Boolean!  # auction has been settled
  block: Int!      # block number
  time:  Datetime! # block timestamp
  tx:    String!   # transaction hash
}
```

Query API

```graphql
type Query {
  getBid(id: Int): {
    id
    guy
    gem
    lot
    gal
    pie
    bid
    tab
    tic
    end
    lad
    mom
    dealt
    block
    time
    tx
    history [Bid]
  }

  allBids(condition: {}): [Bid]
  allBidsHistory(condition: {}): [Bid]
}
```
