# Tx

Transaction metatada is available for any type which represents an Ethereum
transaction. The block timestamp is represented both as seconds since the epoch
and ISO date time for convenience.

```graphql
type Tx {
  transactionHash:  String
  transactionIndex: Integer
  blockHash:        String
  blockNumber:      Integer
  blockTimestamp:   Era
  src:              Address
  dst:              Address
}

type Era {
  int: Integer  # seconds since the epoch
  iso: Datetime # ISO 8601 UTC
}
```

## Tx Query

TODO
