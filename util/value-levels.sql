CREATE OR REPLACE FUNCTION value_levels (tab text, ids int[])
RETURNS text[] AS $idmatch$
DECLARE levels text[];
BEGIN
  SELECT DISTINCT ON (a.value)
    a.value, a.itemid, b.label
  INTO levels
  FROM tab a
  INNER JOIN d_items b 
    ON b.itemid = a.itemid
  WHERE a.itemid IN ids
  RETURN { levels }
END; 
-- LANGUAGE plpgsql;