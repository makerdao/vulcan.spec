# Poke

The Spotter contract supplies collateral prices to the system via`poke`. When
`poke` is executed, the latest price is retrieved from the relevant price feed
contract and submitted to the Vat.

```graphql
type PokeEvent {
  ilk:   Ilk     # ilk object
  val:   Float   # medianized price
  spot:  Spot    # medianized price with safety margin
  tx:    Tx      # transaction meta
}
```

## Event triggers

`PokeEvents` are created when `Spotter.poke` is successfully executed.

| Call           | Log Event | State change           | Vulcanize Event |
| -------------- | --------- | ---------------------- | --------------- |
| Spotter.poke   | Poke      | -                      | PokeEvent       |

## Poke Query

Retrieve PokeEvents with postgraphile-style collection filtering:

```graphql
type Query {

   allPokeEvents(
     first:     Int,
     last:      Int,
     offset:    Int,
     before:    Cursor,
     after:     Cursor,
     orderBy:   PokeEventOrderBy,
     condition: PokeEventCondition,
     filter:    PokeEventFilter
   ): [PokeEvent]

}
```
