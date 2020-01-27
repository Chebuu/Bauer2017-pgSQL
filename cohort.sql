-- TODO::
-- -- Filter out pediatric patients
-- -- Exclude rows marked as error
-- -- Group events to count each start/stop duration as a single event
-- -- -- -- Example: A patient may be intubated/extubated multiple times
-- -- -- -- during a single ICU stay. Each of these intubation/extubation
-- -- -- -- pairs (i.e. duration of intubation) should be counted as a 
-- -- -- -- single intubation event.

DROP MATERIALIZED VIEW IF EXISTS cohort CASCADE;
CREATE MATERIALIZED VIEW cohort AS

-----------------------------------------
-- ENDOTRACHEAL INTUBATION IDENTIFIERS --
-----------------------------------------
-- D_ICD_PROCEDURES
-- -- icd9_code = '9604' / long_title = 'Insertion of endotracheal tube'
-- -- icd9_code = '9605' / long_title = 'Other intubation of respiratory tract'
-- -- icd9_code = '9390' / long_title = 'Non-invasive mechanical ventilation'

-- D_ITEMS
-- -- [PROCEDUREEVENTS_MV] itemid = '225792' / label = 'Invasive Ventilation'
-- -- [PROCEDUREEVENTS_MV] itemid = '225794' / label = 'Non-invasive Ventilation'
-- -- [PROCEDUREEVENTS_MV] itemid = '224385' / label = 'Intubation'
-- -- [PROCEDUREEVENTS_MV] itemid = '225468' / label = 'Unplanned Extubation (patient-initiated)'
-- -- [PROCEDUREEVENTS_MV] itemid = '225477' / label = 'Unplanned Extubation (non-patient initiated)'
-- -- [PROCEDUREEVENTS_MV] itemid = '227194' / label = 'Extubation'
-- -- [CHARTEVENTS] itemid = '226732' / label = 'O2 Delivery Device(s)'
-- -- [CHARTEVENTS] itemid = '40'     / label = 'Airway Type'
-- -- [CHARTEVENTS] itemid = '223836' / label = 'Airway Type'
-- -- [CHARTEVENTS] itemid = '227567' / label = 'Airway Location'
-- -- [CHARTEVENTS] itemid = '227021' / label = 'Intubated_ApacheIV'
-- -- [CHARTEVENTS] itemid = '226758' / label = 'GCSVerbalApacheIIValue'
-- -- [CHARTEVENTS] itemid = '223059' / label = 'Intubation - Details'
-- -- [CHARTEVENTS] itemid = '157'    / label = 'ETT [Mark]'
-- -- [CHARTEVENTS] itemid = '224832' / label = 'ETT Type'
-- -- [CHARTEVENTS] itemid = '224415' / label = 'ETT Mark (cm)'
-- -- [CHARTEVENTS] itemid = '224391' / label = 'ETT Mark (location)'
-- -- [CHARTEVENTS] itemid = '8382'   / label = 'ETT [Location]'
-- -- [CHARTEVENTS] itemid = '3404'   / label = 'ETT Taped at (cm)'
-- -- [CHARTEVENTS] itemid = '227061' / label = 'Ventilated at any time during ICU Day 1'
-- -- [OUTPUTEVENTS] itemid = '43851' / label = 'ETT out'
-- -- [NOT FOUND] itemid = '226260' / label = 'Mechanically Ventilated'
-- -- [NOT FOUND] itemid = '227014' / label = 'GCSVerbal_ApacheIV'
-- -- [NOT FOUND] itemid = '228112' / label = 'GCSVerbalApacheIIValue (intubated)'
-- -- [NOT FOUND] itemid = '226166' / label = 'No Complications (Intubation)'
-- -- [NOT FOUND] itemid = '225267' / label = 'Difficult to Intubate'
-- -- [NOT FOUND] itemid = '226188' / label = 'Timeout Performed by (Intubation)'
-- -- [NOT FOUND] itemid = '226189' / label = 'Patient identified correctly by 2 means (Intubation)'
-- -- [NOT FOUND] itemid = '225588' / label = 'Tube Secured (Intubation)'
-- -- [NOT FOUND] itemid = '225278' / label = 'ETT Route'
-- -- [NOT FOUND] itemid = '225277' /   label = 'ETT Position (cm at teeth)'
-- -- [NOT FOUND] itemid = '226429' /   label = 'ETT Type (Intubation)'
-- -- [NOT FOUND] itemid = '226430' /   label = 'Complications (Intubation)'
-- -- [NOT FOUND] itemid = '226431' /   label = 'Verification of (Intubation)'
-- -- [NOT FOUND] itemid = '226432' /   label = 'Drugs (Intubation)'
-- -- [NOT FOUND] itemid = '228069' /   label = 'Tube Secured (Intubation)'
-- -- [NOT FOUND] itemid = '225301' /   label = 'RSI (Intubation)'
-- -- [NOT FOUND] itemid = '225307' /   label = 'Oral ETT'

-- Earliest recorded intubation in ICU
WITH int_cev AS (
    SELECT icustay_id
        , MIN(charttime) as min_chart
        , MIN(storetime) as min_store
    FROM chartevents cev
    WHERE  (cev.itemid = 223059 AND cev.value IS NOT NULL) -- D_ITEMS.label = 'Intubation - Details'
        -- OR (cev.itemid =  AND cev.value = '') -- D_ITEMS.label = 
    GROUP BY cev.icustay_id
)
, int_pev AS (
    -- TODO:: Need to group intubation events to count each start/stop pair as a single intubation event
    SELECT icustay_id
        , MIN(starttime) as min_start
        -- , endtime
    FROM procedureevents_mv pev
    WHERE  (pev.itemid = 224385 AND pev.value = 1.0 ) -- D_ITEMS.label = 'Intubation'
        -- OR (pev.itemid =  AND pev.value = ) -- D_ITEMS.label = 
    GROUP BY pev.icustay_id
)
-- Earliest recorded ETT presence in ICU
, ett_cev AS (
    SELECT icustay_id
        , MIN(charttime) as min_chart
        , MIN(storetime) as min_store
    FROM chartevents cev
    WHERE  (cev.itemid = 226732 AND cev.value = 'Endotracheal tube') -- D_ITEMS.label = 'O2 Delivery Device(s)'
        OR (cev.itemid = 223900 AND cev.value = 'No Response-ETT')
        OR (cev.itemid = 723 and cev.value = '1.0 ET/Trach')
        OR (cev.itemid = 40 AND cev.value = 'Endotracheal') -- D_ITEMS.label = 'Airway Type'
        OR (cev.itemid = 227021 AND cev.value = '1') -- D_ITEMS.label = 'Intubated_ApacheIV'
    GROUP BY cev.icustay_id
)
-- Earliest recorded ETT absence in ICU
, ntt_cev AS (
    SELECT icustay_id
        , MIN(charttime) as min_chart
        , MIN(storetime) as min_store
    FROM chartevents cev
    WHERE cev.itemid IN (40, 223836, 226732) -- D_ITEMS.label = ['Airway Type', 'Airway Type', 'O2 Delivery Device(s)']
        AND cev.value NOT ILIKE 
            ANY(ARRAY ['%trach%', '%ett%'])
        AND cev.value IS NOT NULL
    GROUP BY cev.icustay_id
)

-- , ntt_pev AS (
--     SELECT icustay_id
--         , MIN(starttime) as min_start
--         -- , endtime
--     FROM procedureevents_mv pev
--     WHERE pev.itemid IN (225794) -- D_ITEMS.label = ['Non-invasive Ventilation']
--         AND pev.value NOT ILIKE 
--             ANY(ARRAY ['%trach%', '%ett%']) -- These are not text, theyre doubles of unknown significance
--         AND pev.value IS NOT NULL
--     GROUP BY pev.icustay_id
-- )

-- Inclusion if not intubated on admission
, cohort AS (
    SELECT * FROM (
        SELECT sty.icustay_id
            , LEAST (
                ipv.min_start
                , icv.min_chart
                , icv.min_store
                , ecv.min_chart
                , ecv.min_store
            ) AS min_int
            , LEAST (
                ncv.min_chart
                , ncv.min_store
                -- , npv.min_start
            ) AS min_ext
        FROM icustays sty
        LEFT JOIN ntt_cev ncv
            ON  ncv.icustay_id = sty.icustay_id
        -- LEFT JOIN ntt_pev npv
        --     ON  npv.icustay_id = sty.icustay_id
        LEFT JOIN int_cev icv
            ON  icv.icustay_id = sty.icustay_id
        LEFT JOIN int_pev ipv
            ON ipv.icustay_id = sty.icustay_id
        LEFT JOIN ett_cev ecv
            ON ecv.icustay_id = sty.icustay_id
    ) ett
    WHERE ett.min_ext < ett.min_int
)

-- Flag treatment groups
SELECT DISTINCT sty.subject_id, sty.icustay_id
    , CASE  
        WHEN cht.min_int < (sty.intime + INTERVAL '2 days')
        THEN 0 ELSE 1
    END AS tx_group
FROM icustays sty
RIGHT JOIN cohort cht ON sty.icustay_id = cht.icustay_id
