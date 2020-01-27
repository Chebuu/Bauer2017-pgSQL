CREATE OR REPLACE FUNCTION id_label (tab text, id int[])
RETURNS text[] AS $idmatch$
DECLARE labels text[];
BEGIN
  SELECT a.itemid, a.label
  INTO labels
  FROM d_items a
  RIGHT JOIN tab b 
    ON b.itemid = a.itemid
  WHERE b.itemid IN ids
  RETURN { labels }
END;
-- LANGUAGE plpgsql;