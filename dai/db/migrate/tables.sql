CREATE TABLE dai.ilk (
  id     integer primary key,   -- ilk id
  gem    character varying(66), -- gem address
  spot   decimal,
  rate   decimal,
  line   decimal,
  art    decimal,
  flip   character varying(66), -- flipper address
  act    character(4)           -- form | fuss | file
  block  integer not null,
  time   timestamptz not null,
  tx     character varying(66) UNIQUE not null
);

-- TODO
-- Populate history via update trigger
CREATE TABLE dai.ilk_history (
  id     integer not null,      -- ilk id
  gem    character varying(66), -- gem address
  spot   decimal,
  rate   decimal,
  line   decimal,
  art    decimal,
  flip   character varying(66), -- flipper address
  act    character(4)           -- form | fuss | file
  block  integer not null,
  time   timestamptz not null,
  tx     character varying(66) UNIQUE not null
);

CREATE INDEX dai_ilk_id_idx ON dai.ilk(id);
CREATE UNIQUE INDEX dai_ilk_id_tx_idx ON dai.ilk(id tx);

CREATE TABLE dai.urn_history (
  ilk    integer not null,      -- ilk id
  guy    character varying(66), -- cdp owner
  ink    decimal,
  art    decimal,
  block  integer not null,
  time   timestamptz not null,
  tx     character varying(66) UNIQUE not null
);

CREATE INDEX dai_urn_ilk_idx ON dai.urn(ilk);
