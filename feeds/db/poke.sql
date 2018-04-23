INSERT INTO feeds.poke (
  guy,
  val,
  block,
  time,
  tx
)
VALUES (
  ${event.guy},
  ${event.val},
  ${event.blockNumber},
  to_timestamp(${event.timestamp}),
  ${event.transactionHash}
)
ON CONFLICT (guy tx)
DO NOTHING
