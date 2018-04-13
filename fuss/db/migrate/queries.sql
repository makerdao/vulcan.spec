CREATE VIEW fuss.active_bid AS
  SELECT * FROM (
    SELECT DISTINCT ON (id) *
    FROM fuss.bid
    ORDER BY block DESC;
  ); t

CREATE FUNCTION get_bid(id integer) RETURNS active_bid as $$
  SELECT *
  FROM active_bid
  WHERE bid.id = $1
  ORDER BY id DESC
  LIMIT 1
$$ LANGUAGE SQL stable;
