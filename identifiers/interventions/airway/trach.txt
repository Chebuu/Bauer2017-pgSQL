------------------
-- TRACHEOSTOMY --
------------------
SELECT itemid, label
FROM d_items
WHERE label ILIKE '%trach%'
ORDER BY itemid

940,  --	 trach care
1120, --	 trach
1489, --	 Transtracheal
2877, --	 trach collar trial
2993, --	 trache care
4441, --	 trach care/site
4459, --	 trach collar
4588, --	 trach aspirate
5646, --	 trach ties
5767, --	 trach button
7286, --	 trache
7385, --	 bivona trach measure
7474, --	 trach mark
7689, --	 trach tube mark
8170, --	 trach postion/stoma
8183, --	 trach mark location
8287  --	 trach press

chartevents.itemid = 223838 
  AND cev.value IN (
      ARRAY('Not applicable', 'Nasal-L', 'Nasal-R')
  )
chartevents.itemid = 224832
  AND cev.value IN (
      ARRAY('Double Lumen', 'Foam Cuffed', 'Nasal-R', 'High/Low Evac', 'Wire Reinforced')
  )
