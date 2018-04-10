CREATE VIEW public.cup_act AS
  SELECT
    act,
    arg,
    art,
    block,
    deleted,
    id,
    ink,
    ire,
    lad,
    pip,
    per,
    (pip * per * ink) / NULLIF(art,0) * 100 AS ratio,
    (pip * per * ink) AS tab,
    time,
    tx
  FROM private.cup_action
  LEFT JOIN block on block.n = private.cup_action.block
  ORDER BY block DESC;

comment on view cup_act is 'A CDP action';
comment on column cup_act.act is 'The action name';
comment on column cup_act.arg is 'Data associated with the act';
comment on column cup_act.art is 'Outstanding debt DAI at block';
comment on column cup_act.block is 'Tx block number';
comment on column cup_act.deleted is 'True if the cup has been deleted (shut)';
comment on column cup_act.id is 'The Cup ID';
comment on column cup_act.ink is 'Locked collateral PETH at block';
comment on column cup_act.ire is 'Outstanding debt DAI after fee at block';
comment on column cup_act.lad is 'The Cup owner';
comment on column cup_act.pip is 'USD/ETH price at block';
comment on column cup_act.per is 'ETH/PETH price at block';
comment on column cup_act.ratio is 'Collateralization ratio at block';
comment on column cup_act.tab is 'USD value of locked collateral at block';
comment on column cup_act.time is 'Tx timestamp';
comment on column cup_act.tx is 'Transaction hash';

CREATE VIEW public.cup AS
  SELECT
    act,
    art,
    block,
    deleted,
    id,
    ink,
    ire,
    lad,
    pip,
    per,
    (pip * per * ink) / NULLIF(art,0) * 100 AS ratio,
    (pip * per * ink) AS tab,
    time
  FROM (
    SELECT DISTINCT ON (cup_action.id)
      act,
      art,
      block,
      deleted,
      id,
      ink,
      ire,
      lad,
      (SELECT pip FROM block ORDER BY n DESC LIMIT 1),
      (SELECt per FROM block ORDER BY n DESC LIMIT 1) AS per,
      (SELECT time FROM block WHERE block.n = private.cup_action.block)
    FROM private.cup_action
    ORDER BY private.cup_action.id DESC, private.cup_action.block DESC
  )
c;

comment on view cup is 'A CDP record';
comment on column cup.act is 'The most recent act';
comment on column cup.art is 'Outstanding debt DAI';
comment on column cup.block is 'Block number at last update';
comment on column cup_act.deleted is 'True if the cup has been deleted (shut)';
comment on column cup.id is 'The Cup ID';
comment on column cup.ink is 'Locked collateral PETH';
comment on column cup.ire is 'Outstanding debt DAI after fee';
comment on column cup.lad is 'The Cup owner';
comment on column cup.pip is 'USD/ETH price';
comment on column cup_act.per is 'ETH/PETH price';
comment on column cup.ratio is 'Collateralization ratio';
comment on column cup.tab is 'USD value of locked collateral';
comment on column cup.time is 'Timestamp at last update';

CREATE OR REPLACE FUNCTION cup_actions(cup cup) RETURNS setof cup_act as $$
  SELECT *
  FROM cup_act
  WHERE cup_act.id = cup.id
  ORDER BY cup_act.block DESC
$$ LANGUAGE SQL stable;

CREATE OR REPLACE FUNCTION get_cup(id integer) RETURNS cup as $$
  SELECT *
  FROM cup
  WHERE cup.id = $1
  ORDER BY id DESC
  LIMIT 1
$$ LANGUAGE SQL stable;


CREATE TYPE tick_interval AS enum (
  'minute',
  'hour',
  'day',
  'week',
  'month',
  'quarter'
);

CREATE TYPE cup_state AS (
  tick       timestamptz,
  min_pip    numeric,
  max_pip    numeric,
  min_tab    numeric,
  max_tab    numeric,
  min_ratio  numeric,
  max_ratio  numeric,
  act        act,
  arg        varchar,
  ink        numeric,
  art        numeric,
  time       timestamptz
);

CREATE OR REPLACE FUNCTION cup_history(cup cup,tick tick_interval)
RETURNS SETOF cup_state as $$
  WITH acts AS (
    SELECT
      act,
      arg,
      ink,
      art,
      time AS _time,
      LEAD(time) OVER (ORDER BY time ASC) AS next_time
    FROM private.cup_action
    LEFT JOIN block on block.n = private.cup_action.block
    WHERE private.cup_action.id = cup.id
  ), ticks AS (
    SELECT
      date_trunc($2::char, time) AS tick,
      min(pip) AS min_pip,
      max(pip) AS max_pip,
      avg(per) AS per
    FROM block
    WHERE time <= (SELECT max(_time) FROM acts)
    AND time >= (SELECT min(_time) FROM acts)
    GROUP BY tick
    ORDER BY tick DESC
  )

  SELECT
    tick,
    min_pip,
    max_pip,
    (min_pip * per * ink) AS min_tab,
    (max_pip * per * ink) AS max_tab,
    (min_pip * per * ink) / NULLIF(art,0) * 100 AS min_ratio,
    (max_pip * per * ink) / NULLIF(art,0) * 100 AS max_ratio,
    (CASE WHEN (date_trunc($2::char, _time) = tick) THEN act ELSE NULL END) AS act,
    (CASE WHEN (date_trunc($2::char, _time) = tick) THEN arg ELSE NULL END) AS arg,
    ink,
    art,
    (CASE WHEN (date_trunc($2::char, _time) = tick) THEN _time ELSE NULL END) AS time
  FROM (
    SELECT * FROM ticks
    LEFT OUTER JOIN (SELECT * FROM acts) as actions
    ON ticks.tick = date_trunc($2::char, actions._time)
    OR (
      ticks.tick < date_trunc($2::char, actions.next_time)
      AND ticks.tick > date_trunc($2::char, actions._time)
    )
    ORDER BY tick DESC, _time DESC
  ) AS ticks_actions;
$$ LANGUAGE SQL stable;
