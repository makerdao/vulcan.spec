INSERT INTO dai.ilk (
  id,
  gem,
  art,
  act,
  block,
  time,
  tx,
)
VALUES (
  ${event.ilk},
  ${event.gem},
  0,
  'form',
  ${event.blockNumber},
  to_timestamp(${event.timestamp}),
  ${event.transactionHash}
)
ON CONFLICT ( id tx)
DO NOTHING
