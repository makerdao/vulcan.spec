-- TODO
-- Computed columns
CREATE VIEW public.urn AS
  SELECT (
    ilk,
    guy,
    ink,
    art,
    block,
    time,
    tx
  )
  FROM dai.urn
  LEFT JOIN ilk on ilk.id = urn.ilk
  ORDER BY block DESC;

-- TODO
-- Computed columns
CREATE VIEW public.urn_history AS
  SELECT (
    ilk,
    guy,
    ink,
    art,
    block,
    time,
    tx
  )
  FROM dai.urn
  LEFT JOIN ilk on ilk.id = urn.ilk
  ORDER BY block DESC;

CREATE OR REPLACE FUNCTION get_urn(id integer) RETURNS urn as $$
  SELECT *
  FROM urn
  WHERE cup.id = $1
  LIMIT 1
$$ LANGUAGE SQL stable;
