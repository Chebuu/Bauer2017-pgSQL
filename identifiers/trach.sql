------------------
-- TRACHEOSTOMY --
------------------
SELECT itemid, label
FROM d_items
WHERE label ILIKE '%trach%'
ORDER BY itemid

-- 1120	 trach
-- 1489	 Transtracheal
-- 940	 trach care
-- 2877	 trach collar trial
-- 2993	 trache care
-- 4441	 trach care/site
-- 4459	 trach collar
-- 4588	 trach aspirate
-- 5646	 trach ties
-- 5767	 trach button
-- 7286	 trache
-- 7385	 bivona trach measure
-- 7474	 trach mark
-- 7689	 trach tube mark
-- 8170	 trach postion/stoma
-- 8183	 trach mark location
-- 8287	 trach press
