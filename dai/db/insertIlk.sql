INSERT INTO public.ilks (
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
  ${event.block},
  ${event.time},
  ${event.tx}
)
ON CONFLICT (
  tx
)
DO NOTHING
