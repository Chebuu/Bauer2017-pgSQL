-- https://www.sahealth.sa.gov.au/wps/wcm/connect/82b5bd80407461c6995cbfa05d853418/CIWA-AR.pdf?MOD=AJPERES&amp;CACHEID=ROOTWORKSPACE-82b5bd80407461c6995cbfa05d853418-n5hzsbm

-- 1358	"ciwa"
-- 1407	"CIWA SCALE"
-- 1424	"CIWA Sum Total"
-- 1847	"CIWA scale"
-- 1869	"CIWA Scale"
-- 1931	"Total CIWA scale"
-- 1941	"Total CIWA"
-- 223805	"Nausea and Vomiting (CIWA)"
-- 223806	"Tremor (CIWA)"


-- CASE 
--         WHEN ce.value IN (
--              'Cannot do additions and is uncertain of date'	-- "1"
--             ,'Disoriented by date for < 2 days'	-- "2"
--             ,'Disoriented by date for > 2 days'	-- "3"
--             ,'Disoriented for place and/or person'	-- "4"
--             ,'Oriented and can do serial conditions'	-- "0"
--         ) THEN MAX(valuenum) 
--         ELSE NULL 
--     END AS AS CIWA_Ar