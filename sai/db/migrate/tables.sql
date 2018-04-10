CREATE SCHEMA if not exists private;
CREATE SCHEMA if not exists  public;

CREATE TYPE public.act AS enum (
  'open',
  'join',
  'exit',
  'lock',
  'free',
  'draw',
  'wipe',
  'shut',
  'bite'
);

CREATE TABLE public.block (
  n     integer primary key,
  time  timestamptz not null,
  pip   decimal,
  per   decimal,
  pep   decimal
);

CREATE INDEX IF block_time_minute_index ON block(date_trunc('minute', time AT TIME ZONE 'UTC'));
CREATE INDEX IF block_time_hour_index ON block(date_trunc('hour', time AT TIME ZONE 'UTC'));
CREATE INDEX IF block_time_day_index ON block(date_trunc('day', time AT TIME ZONE 'UTC'));

CREATE TABLE private.cup_action (
  id         integer,
  tx         character varying(66) UNIQUE not null,
  act        public.act  not null,
  arg        character varying(66),
  lad        character varying(66) not null,
  guy        character varying(66),
  ink        decimal not null default 0,
  art        decimal not null default 0,
  ire        decimal not null default 0,
  block      integer not null,
  deleted    boolean defailt false
);

CREATE INDEX cup_action_id_index ON private.cup_action(id);
CREATE INDEX cup_action_block_index ON private.cup_action(block);
CREATE INDEX cup_action_tx_index ON private.cup_action(tx);
CREATE INDEX cup_action_deleted_index ON private.cup_action(deleted);
CREATE INDEX cup_action_act_index ON private.cup_action(act);

CREATE OR REPLACE FUNCTION exec_set_deleted() RETURNS trigger AS $shut$
  BEGIN
    UPDATE private.cup_action
    SET deleted = true
    WHERE private.cup_action.id = NEW.id;
    RETURN NULL;
  END;
$shut$ LANGUAGE plpgsql;

CREATE trigger shut
  AFTER INSERT ON private.cup_action
  FOR EACH ROW
  WHEN (NEW.act = 'shut')
  EXECUTE PROCEDURE exec_set_deleted();
