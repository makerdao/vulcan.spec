INSERT INTO fuss.bid (
  id,
  guy,
  tit,
  lot,
  gal,
  tat,
  bid,
  tab,
  tic,
  end,
  lad,
  mom,
  block,
  time,
  tx
)
VALUES (
  ${event.id},
  ${event.guy},
  ${event.tit},
  wad(${event.lot}),
  ${event.gal},
  ${event.tat},
  ${event.tab},                         -- may be null
  to_timestamp(${event.tic}),           -- may be null
  to_timestamp(${event.end}),           -- may be null
  ${event.lad},                         -- may be null
  ${event.mom},
  ${event.blockNumber},
  to_timestamp(${event.timestamp}),
  ${event.transactionHash}
)
ON CONFLICT ( id tx)
DO NOTHING
