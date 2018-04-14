INSERT INTO public.ilk (
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
  ${event.id},
  ${event.spot},
  ${event.rate},
  ${event.line},
  ${event.art},
  ${event.gem},
  ${event.flip,
  ${event.blockNumber},
  to_timestamp(${event.timestamp}),
  ${event.transactionHash}
)
ON CONFLICT ( id tx)
DO NOTHING
