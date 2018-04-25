## Dai GraphQL

Ilk - CDP type record

```graphql
type Ilk {
  id:    Int      # ilk id
  gem:   String   # gem address
  spot:  Float    # liquidation factor
  rate:  Float    # accumulated rates
  line:  Float    # debt ceiling
  art:   Float    # total debt owed by CDPs of this type
  flip:  String   # liquidator address
  act:   String   # update action, form | fuss | file
  block: Int      # block number
  time:  Datetime # block timestamp
  tx:    String   # transaction hash
}
```

Urn - CDP record

```graphql
type Urn {
  ilk:   Int      # ilk id
  lad:   String   # cdp owner address
  ink:   Float    # locked gem
  art:   Float    # debt
  block: Int      # block number
  time:  Datetime # block timestamp
  tx:    String   # transaction hash
);
```

Query API

```graphql
type Query {
  getIlk(id: Int): {
    id
    gem
    spot
    rate
    line
    art
    flip
    act
    block
    time
    tx
    history [Ilk]
  }

  allIlks(condition: {}): [Ilk]
  allIlksHistory(condition: {}): [Ilk]

  getUrn(id: Int): {
    ilk
    lad
    ink
    art
    block
    time
    tx
    history [Urn]
  }

  allUrns(condition: {}): [Urn]
  allUrnsHistory(condition: {}): [Urn]
}
```
