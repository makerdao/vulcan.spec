INSERT INTO dai.ilk (
  id,
  gem,
  act,
  block,
  time,
  tx,
)
VALUES (
  ${event.id},
  ${event.gem},
  'form',
  ${event.blockNumber},
  to_timestamp(${event.timestamp}),
  ${event.transactionHash}
)
ON CONFLICT (id)
DO NOTHING
