CREATE OR REPLACE FUNCTION n_occurences (tab text, col text, vals int[])
RETURNS TABLE (itemid int, N int) 
AS $$
    SELECT $2 , COUNT($2) as N
    FROM $1 WHERE $2 IN $3
    GROUP BY $2
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION n_itemids (tab text, ids int[])
RETURNS TABLE (itemid int, label text, N int) 
AS $$
  SELECT a.itemid 
      , COUNT(a.itemid) as N
      , b.label
  FROM tab a 
  RIGHT JOIN d_items b USING (itemid)
  WHERE a.itemid IN ids
  GROUP BY ids
$$ LANGUAGE SQL;