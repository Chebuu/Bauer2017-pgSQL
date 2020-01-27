CREATE OR REPLACE FUNCTION fuzzy_label_id (tab text, fuzz text[], ilike boolean default yes) 
RETURNS int[] AS $idmatch$
DECLARE
  matches int[];
BEGIN
  SELECT DISTINCT ON (itemid) itemid, label
  INTO matches
  FROM format(' %s WHERE label %s ANY(fuzz)', tab, IIF(ilike, 'ilike', 'like'))
  RETURN { matches }
END; 
-- LANGUAGE plpgsql;