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
ON CONFLICT (ilk guy)
DO UPDATE
SET (
  ilk,
  guy,
  ink,
  art,
  block,
  time,
  tx,
) = (
  ${event.ilk},
  ${event.guy},
  ${event.ink},
  ${event.art},
  ${event.blockNumber},
  to_timestamp(${event.timestamp}),
  ${event.transactionHash}
)
WHERE urn.ilk = ${event.id} AND urn.guy = ${event.guy};
