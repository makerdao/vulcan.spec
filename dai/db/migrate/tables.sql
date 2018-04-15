--
-- Ilk State
--
CREATE TABLE dai.ilk (
  id     integer primary key,   -- ilk id
  gem    character varying(66), -- gem address
  spot   decimal,
  rate   decimal,
  line   decimal,
  art    decimal defaut 0,
  flip   character varying(66), -- flipper address
  act    character(4)           -- form | fuss | file
  block  integer not null,
  time   timestamptz not null,
  tx     character varying(66) UNIQUE not null
);

--
-- Ilk History
--
CREATE TABLE dai.ilk_history (
  id     integer not null,
  gem    character varying(66),
  spot   decimal,
  rate   decimal,
  line   decimal,
  art    decimal,
  flip   character varying(66),
  act    character(4)
  block  integer not null,
  time   timestamptz not null,
  tx     character varying(66) UNIQUE not null
);

CREATE INDEX dai_ilk_id_idx ON dai.ilk(id);
CREATE UNIQUE INDEX dai_ilk_id_tx_idx ON dai.ilk(id tx);

--
-- Ilk History Trigger
--
CREATE TRIGGER ilk_history_trigger
BEFORE UPDATE ON dai.ilk
   FOR EACH ROW EXECUTE PROCEDURE ilk_modified_func();

CREATE OR REPLACE FUNCTION ilk_modified_func() RETURNS TRIGGER AS $body$
BEGIN
  INSERT into dai.ilk_history(id, gem, spot, rate, line, art, flip, act, block, time, tx)
  VALUES(OLD.id, OLD.gem, OLD.spot, OLD,rate, OLD.line, OLD.art, OLD.flip, OLD.act, OLD.block, OLD.time, OLD.tx)
END;
$body$
LANGUAGE plpgsql


--
-- Urn State
--
CREATE TABLE dai.urn (
  ilk    integer not null,      -- ilk id
  guy    character varying(66), -- cdp owner
  ink    decimal,
  art    decimal,
  block  integer not null,
  time   timestamptz not null,
  tx     character varying(66) not null
);

CREATE INDEX dai_urn_ilk_idx ON dai.urn(ilk);
CREATE INDEX dai_urn_guy_idx ON dai.urn(guy);
CREATE UNIQUE INDEX dai_urn_ilk_guy_idx ON dai.ilk(ilk guy);

--
-- Urn History
--
CREATE TABLE dai.urn_history (
  ilk    integer not null,
  guy    character varying(66),
  ink    decimal,
  art    decimal,
  block  integer not null,
  time   timestamptz not null,
  tx     character varying(66) not null
);

CREATE INDEX dai_urn_ilk_idx ON dai.urn(ilk);

--
-- Urn History Trigger
--
CREATE TRIGGER urn_history_trigger
BEFORE INSERT OR UPDATE ON dai.urn
   FOR EACH ROW EXECUTE PROCEDURE urn_modified_func();

CREATE OR REPLACE FUNCTION urn_modified_func() RETURNS TRIGGER AS $body$
BEGIN
  INSERT into dai.urn_history(ilk, guy, ink, art, block, time, tx)
  VALUES(OLD.ilk, OLD.guy, OLD.ink, OLD.art, OLD.block, OLD.time, OLD.tx)
END;
$body$
LANGUAGE plpgsql
