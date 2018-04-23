CREATE TABLE feeds.poke (
  guy    character varying(66), -- msg.sender
  val    decimal,               -- feed value
  block  integer not null,
  time   timestamptz not null,
  tx     character varying(66)
);

CREATE INDEX feeds_poke_guy_idx ON feeds.poke(guy);
CREATE INDEX feeds_poke_tx_idx ON feeds.poke(tx);
CREATE UNIQUE INDEX feeds_poke_guy_tx_idx ON feeds.poke(guy tx);
