INSERT INTO dai.urn (
  ilk,
  guy,
  ink,
  art,
  block,
  time,
  tx,
)
VALUES (
  ${event.ilk},
  ${event.guy},
  ${event.ink},
  ${event.art},
  ${event.blockNumber},
  to_timestamp(${event.timestamp}),
  ${event.transactionHash}
)
ON CONFLICT (ilk guy tx)
DO NOTHING
