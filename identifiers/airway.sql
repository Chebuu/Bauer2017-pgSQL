------------
-- AIRWAY --
------------
SELECT itemid, label
FROM d_items
WHERE label ILIKE '%airway%'
ORDER BY itemid

-- 38	     Airway
-- 39	     Airway Size
-- 40	     Airway Type
-- 141	     Cuff Pressure-Airway
-- 444	     Mean Airway Pressure
-- 1209	   HFO mean airway Pres
-- 1864	   HFO-Max mean airway
-- 1865	   HFO-Min mean airway
-- 223836	 Airway Type
-- 224697	 Mean Airway Pressure
-- 226815	 Airway problems
-- 227567	 Airway Location
-- 227568	 Airway Size (mm)
