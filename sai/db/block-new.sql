INSERT INTO block (
  n,
  time,
  pip,
  pep,
  per
)
VALUES (
  ${n},
  to_timestamp(${time}),
  $(data.pip),
  $(data.pep),
  $(data.per)
)
ON CONFLICT (n)
DO UPDATE
SET
pip = ${data.pip},
pep = ${data.pep},
per = ${data.per}
