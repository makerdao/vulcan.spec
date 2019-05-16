# Sin

Sin is bad debt which has been confiscated from Cdps and awaiting auction. Debt
is queued by the block timestamp at which it was siezed (via `Cat.bite`) and
can be released for auction once the alloted period (`Vow.wait`) has expired.

```graphql
type QueuedSin {
  era:     Integer           # e.era - bite timestamp
  tab:     Float             # bad debt amount
  events:  [SinQueueEvent]   # fess & flog events
  flogged: Boolean           # true if flogged (tab = 0)
  created: Datetime
  updated: Datetime
}
```

## State change triggers

Sin is pushed to the queue via `Vow.fess` and popped from the queue via `Vow.flog`:

| Call           | Log Event | State change           | Vulcanize Event |
| -------------- | --------- | ---------------------- | --------------- |
| Vow.fess       | DSNote    | Vow.sin[tx.timestamp]  | SinQueueEvent        |
| Vow.flog       | DSNote    | Vow.sin[e.era]         | SinQueueEvent        |

## SinQueueEvent

A `SinQueueEvent` is created when `Vat.fess` or `Vow.flog` is executed.

```graphql
type SinQueueEvent {
  era:    Integer  # block timestamp
  act:    SinAct   # action
  tx:     Tx       # transaction meta
}

enum SinAct {
  FLOG
  FESS
}
```

## Sin Query

Basic `Sin` retrieval with postgraphile-style collection filtering:

```graphql
type Query {

   allQueuedSin(
     first:     Int,
     last:      Int,
     offset:    Int,
     before:    Cursor,
     after:     Cursor,
     orderBy:   QueuedSinOrderBy,
     condition: QueuedSinCondition,
     filter:    QueuedSinFilter
   ): [Sin]

   getQueuedSin(
     era: Integer!
   ): Sin

   allSinQueueEvents(
     first:     Int,
     last:      Int,
     offset:    Int,
     before:    Cursor,
     after:     Cursor,
     orderBy:   SinQueueEventOrderBy,
     condition: SinQueueEventCondition,
     filter:    SinQueueEventFilter
   ): [SinQueueEvent]

}
```
