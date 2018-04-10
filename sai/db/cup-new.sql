INSERT INTO private.cup_action (
  id,
  lad,
  ink,
  art,
  ire,
  act,
  arg,
  guy,
  block,
  tx,
)
VALUES (
  ${event.id},
  ${event.lad},
  0,
  0,
  0,
  'open'
  NULL,
  ${event.guy},
  ${event.blockNumber},
  ${event.transactionHash},
)
ON CONFLICT (
  tx
)
DO NOTHING
