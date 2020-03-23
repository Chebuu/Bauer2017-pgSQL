DROP MATERIALIZED VIEW IF EXISTS comorbidities CASCADE;
CREATE MATERIALIZED VIEW comorbidities AS

SELECT cht.icustay_id 
    ,dxi.hadm_id
    ,max(
        CASE 
            WHEN dxi.icd9_code IN (
                '4910'   -- Simple chr bronchitis
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
            WHEN dxi.icd9_code BETWEEN '140' AND '239' -- Malignant neoplasias
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
    , max(
        CASE 
            WHEN dxi.icd9_code BETWEEN '196' AND '198' -- Secondary malignant neoplasias
                OR dxi.icd9_code = '1990' -- Disseminated secondary neoplasia
            THEN 1 ELSE 0 
        END
    ) AS metcancer
    , max(
        CASE 
            WHEN dxi.icd9_code BETWEEN '200' AND '208' -- Lymphatic and hematologic cancers
            THEN 1 ELSE 0 
        END
    ) AS hemcancer
    , max(
        CASE 
            WHEN dxi.icd9_code BETWEEN '25001' AND '25093' -- DM type 1
            THEN 1 ELSE 0 
        END
    ) AS insulindm
    , max(
        CASE 
            WHEN dxi.icd9_code BETWEEN '4280' AND '4289' -- Heart failure
            THEN 1 ELSE 0 
        END
    ) AS heartfailure
    , max(
        CASE 
            WHEN dxi.icd9_code BETWEEN '5851' AND '5859' -- CKD including CDK NOS (585.9)
            THEN 1 ELSE 0 
        END
    ) AS ckd
    , max(
        CASE 
            WHEN dxi.icd9_code IN ('049', '07953') -- CKD including CDK NOS (585.9)
            THEN 1 ELSE 0 
        END
    ) AS hiv
    , max(
        CASE 
            WHEN dxi.icd9_code IN (
                '5712'  -- Alcohol cirrhosis liver
                ,'5715' -- Cirrhosis of liver NOS
                ,'5716' -- Biliary cirrhosis
            ) THEN 1 ELSE 0 
        END
    ) AS cirrhosis
    , max(
        CASE 
            WHEN dxi.icd9_code BETWEEN '2790' AND '2793' -- Immunodeficiencies
                OR dxi.icd9_code IN (
                    '28411'  -- Antin chemo indcd pancyt
                    ,'28412' -- Oth drg indcd pancytopna
                    ,'28419' -- Other pancytopenia
                    ,'28800' -- Neutropenia NOS
                    ,'28801' -- Congenital neutropenia
                    ,'28802' -- Cyclic neutropenia
                    ,'28803' -- Drug induced neutropenia
                    ,'28804' -- Neutropenia d/t infectn
                    ,'28809' -- Neutropenia NEC
                    ,'28850' -- Leukocytopenia NOS
                    ,'28851' -- Lymphocytopenia
                    ,'28859' -- Decreased WBC count NEC
                )
            THEN 1 ELSE 0
        END
    ) AS immunosupp
    , max(
        CASE 
            WHEN dxi.icd9_code IN (
                '9620'   -- Pois-corticosteroids
                ,'9923'  -- Injection of steroid
                ,'3653'  -- Corticosteroid-induced glaucoma
                ,'V8744' -- Hx inhaled steroid thrpy
                ,'V8745' -- Hx systemc steroid thrpy
            ) THEN 1 ELSE 0
        END
    ) AS steroid
    , max(
        CASE 
            WHEN dxi.icd9_code IN (
                '9925'   -- Inj or inf of cancer chemotherapeutic substance
                ,'28411' -- Antineo chemo indcd pancyt
                ,'2853'  -- Anemia d/t antineo chemo
                ,'99981' -- Extravstn vesicant chemo
                ,'V5811' -- Antineoplastic chemo enc
                ,'V662'  -- Chemotherapy convalescen
                ,'V672'  -- Chemotherapy follow-up
                ,'V0731' -- Prophylac fluoride admin
                ,'V0739' -- Other prophylac chemothr
            ) THEN 1 ELSE 0
        END
    ) AS chemo
FROM diagnoses_icd dxi
RIGHT JOIN cohort cht
    ON cht.subject_id = dxi.subject_id
    AND cht.hadm_id = dxi.hadm_id
WHERE dxi.icd9_code IS NOT NULL
GROUP BY dxi.hadm_id, cht.icustay_id
