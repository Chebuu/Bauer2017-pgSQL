DROP MATERIALIZED VIEW IF EXISTS comorbidities CASCADE;
CREATE MATERIALIZED VIEW comorbidities AS

SELECT cht.icustay_id 
    ,dxi.hadm_id
    ,max(
        CASE 
            WHEN dxi.icd9_code IN (
                '4910' -- Simple chr bronchitis
                ,'4911'  -- Mucopurul chr bronchitis
                ,'4912'  -- Obstructive chronic bronchitis
                ,'49120' -- Obst chr bronc w/o exac
                ,'49121' -- Obst chr bronc w(ac) exac
                ,'49122' -- Obst chr bronc w ac bronc
                ,'4918'  -- Chronic bronchitis NEC
                ,'4919'  -- Chronic bronchitis NOS
                ,'4920'  -- Emphysematous bleb
                ,'4928'  -- Emphysema NEC
                ,'4932'  -- Chronic obstructive asthma
                ,'49320' -- Chronic obst asthma NOS
                ,'49321' -- Ch ob asthma w stat asth
                ,'49322' -- Ch obst asth w (ac) exac
            ) THEN 1 ELSE 0 
        END
    ) AS copd
    , max(
        CASE 
            WHEN dxi.icd9_code BETWEEN '140' AND '239' 
                OR dxi.icd9_code IN (
                    '28522'  -- Anemia in neoplastic dis
                    ,'2853'  -- Anemia d/t antineo chemo
                    ,'3383'  -- Neoplasm related pain
                    ,'4570'  -- Postmastect lymphedema
                    ,'V580'  -- Radiotherapy encounter
                    ,'V510'  -- Brst reconst fol mastect
                    ,'V580'  -- Radiotherapy encounter
                    ,'V5811' -- Antineoplastic chemo enc
                    ,'V5812' -- Immunotherapy encounter
                    ,'V5842' -- Aftercare neoplasm surg
                    ,'V661'  -- Radiotherapy convalescen
                    ,'V662'  -- Chemotherapy convalescen
                )
            THEN 1 ELSE 0 
        END
    ) AS cancer
FROM diagnoses_icd dxi
RIGHT JOIN cohort cht
    ON cht.subject_id = dxi.subject_id
    AND cht.hadm_id = dxi.hadm_id
WHERE dxi.icd9_code IS NOT NULL
GROUP BY dxi.hadm_id, cht.icustay_id
