-- Bauer2017 listed comorbidities (Table 1)
--  COPD
--  Cancer
--  Metastatic cancer
--  Hematologic cancer 
--  Insulin-requiring diabetes mellitus 
--  Heart failure (NYHA III/IV) 
--  Chronic renal failure
--  HIV infection
--  Cirrhosis
--  Immunosuppression
--  Steroid therapy
--  Chemotherapy
--  Renal replacement therapy on admission
--  Sepsis on admission

DROP MATERIALIZED VIEW IF EXISTS comorbidities CASCADE;
CREATE MATERIALIZED VIEW comorbidities AS

max(case when icd9_code in
    ,'49121','4918 ','4919 ','4920 ','4928 '
    ,'494  ','4940 ','4941 ','496  ') then 1 else 0 end) as copd