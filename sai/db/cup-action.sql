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
  ${data.ink},
  ${data.art},
  ${data.ire},
  ${event.act},
  ${event.arg},
  ${msg.sender},
  ${event.blockNumber},
  ${event.transactionHash},
)
ON CONFLICT (
  tx
)
DO NOTHING
