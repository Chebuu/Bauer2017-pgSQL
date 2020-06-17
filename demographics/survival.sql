DROP MATERIALIZED VIEW IF EXISTS survival;
-- CREATE MATERIALIZED VIEW survival AS

-- SELECT
-- 	cht.*
--     ,adm.subject_id
--     ,adm.hadm_id
--     ,adm.admittime
--     ,adm.dischtime
--     ,adm.deathtime
-- FROM cohort cht 
-- INNER JOIN admissions adm
-- ON cht.subject_id = adm.subject_id 
--     AND cht.hadm_id = adm.hadm_id 
-- LIMIT 100