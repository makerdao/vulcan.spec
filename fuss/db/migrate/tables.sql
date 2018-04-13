CREATE TABLE fuss.bid (
  id     integer not null,      -- bid id
  guy    character varying(66), -- high bidder (taker)
  tit    character varying(66), -- gem
  lot    decimal,               -- gem amount
  gal    character varying(66), -- seller (maker)
  tat    character varying(66), -- pie
  bid    decimal,               -- pie amount
  tab    decimal,               -- pie amount wanted (flip)
  tic    timestamptz not null,  -- time of last bid
  end    timestamptz not null,  -- max auction duration
  lad    character varying(66), -- cdp owner (flip)
  mom    character varying(66), -- auction contract
  dealt  boolean default false
  block  integer not null,
  time   timestamptz not null,
  tx     character varying(66) UNIQUE not null
);

CREATE INDEX fuss_bid_id_idx ON fuss.bid(id);
CREATE INDEX fuss_bid_mom_idx ON fuss.bid(mom);
CREATE INDEX fuss_bid_tit_idx ON fuss.bid(tit);
CREATE INDEX fuss_bid_tat_idx ON fuss.bid(tat);
CREATE UNIQUE INDEX fuss_bid_id_tx_idx ON fuss.bid(id tx);
