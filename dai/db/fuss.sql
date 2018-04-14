UPDATE dai.ilk SET
  flip = ${event.flip},
  act = 'fuss',
  block = ${event.blockNumber},
  time  = to_timestamp(${event.timestamp}),
  tx    = ${event.transactionHash}
WHERE dai.ilk.id = ${event.id}
