--- --- ---
--- --- --- Some helpful queries
-- --- --- 
-- -- https://github.com/MIT-LCP/mimic-code/issues/547
-- -- wait time between hospital admission and icu intime in hours
-- , round((cast(extract(epoch from icu.intime - adm.admittime)/(60*60) as numeric)), 2) as wait_period

-- -- mark the first hospital stay
-- , case
--   when dense_rank() over (partition by pat.subject_id order by adm.admittime) = 1 then true
-- -- include in first_hosp_stay if its been atleast a month since prvious admission. Using lag() as
-- -- shown here: http://bit.ly/2KpJaeg
--   when round((cast(extract(epoch from adm.admittime - lag(adm.admittime, 1) over (partition by
--     pat.subject_id order by adm.admittime) )/(60*60*30) as numeric)), 2) > 30.0 then true
--   else false end as adm_flag

-- -- mark the first icu stay for current hospital admission
-- , case
--   when dense_rank() over (partition by adm.hadm_id order by icu.intime) = 1 then true
--   else false end as icu_flag


DROP MATERIALIZED VIEW IF EXISTS admittype CASCADE;
CREATE MATERIALIZED VIEW admittype AS
