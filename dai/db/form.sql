INSERT INTO dai.ilk (
  id,
  spot,
  rate,
  line,
  art,
  gem,
  flip,
  block,
  time,
  tx,
)
VALUES (
  ${event.ilk},
  NULL,
  NULL,
  NULL,
  0
  ${event.gem},
  NULL,
  ${event.blockNumber},
  to_timestamp(${event.timestamp}),
  ${event.transactionHash}
)
ON CONFLICT ( id tx)
DO NOTHING
