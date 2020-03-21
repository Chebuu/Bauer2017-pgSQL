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

-- Earliest recorded intubation (all hospital)
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
    SELECT icustay_id
        , MIN(starttime) as min_start
        -- , endtime
    FROM procedureevents_mv pev
    WHERE  (pev.itemid = 224385 AND pev.value = 1.0) -- D_ITEMS.label = 'Intubation'
    GROUP BY pev.icustay_id
)
-- Earliest recorded ETT presence (all hospital)
, ett_cev AS (
    SELECT icustay_id
        , MIN(charttime) as min_chart
        , MIN(storetime) as min_store
    FROM chartevents cev
    WHERE   (cev.itemid = 226732 AND cev.value = 'Endotracheal tube') -- D_ITEMS.label = 'O2 Delivery Device(s)'
        -- OR (469) -- O2 Delivery Mode
        OR  (cev.itemid = 223900 AND cev.value = 'No Response-ETT')
        OR  (cev.itemid = 723 and cev.value = '1.0 ET/Trach')
        OR  (cev.itemid = 40 AND cev.value = 'Endotracheal') -- D_ITEMS.label = 'Airway Type'
        OR  (cev.itemid = 227021 AND cev.value = '1') -- D_ITEMS.label = 'Intubated_ApacheIV'
        OR  (cev.itemid = 224391 AND cev.value = 'Incisor') -- D_ITEMS.label = 'ETT Mark (location)'
        OR  (cev.itemid = 8382 AND cev.value = 'Teeth') -- D_ITEMS.label = 'ETT [Location]'
        OR  (cev.itemid = 224832 AND cev.value = 'Standard') -- D_ITEMS.label = 'ETT Type'
        OR  (cev.itemid IN (227809, 227810) AND cev.value = '1') -- D_ITEMS.label = ['ETT Position Change', 'ETT Re-taped']
        OR  (cev.itemid IN (227809, 227810) AND cev.value = '1') -- D_ITEMS.label = ['ETT Position Change', 'ETT Re-taped']
        OR  (
                cev.itemid IN (157, 3400, 224415, 223837, 223838, 3404, 3401, 3402, 3403, 1852, 158) -- D_ITEMS.label = ['ETT Location', 'ETT [MARK]', 'ETT Mark (cm)', 'ETT Size', 'ETT Location', 'ETT Size (ID)', 'ETT Taped at (cm)', 'ETT Sx Color', 'ETT Sx Quality', 'ETT Sx Quantity', 'ETT Rotation', 'ETT Position Change']
                    AND cev.value IS NOT NULL
                    AND cev.value NOT LIKE ANY(
                        ARRAY['e', 'P', 'Stoma', 'Nasal-L', 'Nasal-R', 'Not applicable'] -- ARRAY(..., 'Comment', 'Other/Remarks')
                    )
                
            ) 
    GROUP BY cev.icustay_id
)
-- Earliest recorded extubation (all hospital)
, xtt_cev AS (
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
, xtt_pev AS (
    SELECT icustay_id
        , MIN(starttime) as min_start
        -- , endtime
    FROM procedureevents_mv pev 
    WHERE pev.value IS NOT NULL AND (
        pev.itemid = 225794 -- D_ITEMS.label = 'Non-invasive Ventilation'
            -- -- Exclusion for short duration of NIV
            -- CASE 
            --     WHEN pev.valueuom = 'day' THEN pev.value * 1440
            --     WHEN pev.valueuom = 'hour' THEN pev.value * 60
            --     ELSE pev.value -- 'min'
            -- END AS value
        OR  (
            pev.itemid IN (83282, 225468, 225477) -- D_ITEMS.label = ['Extubation', 'Unplanned Extubation (patient-initiated)', 'Unplanned Extubation (non-patient initiated)']
            AND pev.value = 1.0
        )
    )     
    GROUP BY pev.icustay_id
)

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
        LEFT JOIN xtt_cev ncv
            ON  ncv.icustay_id = sty.icustay_id
        -- LEFT JOIN xtt_pev npv
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
SELECT DISTINCT sty.subject_id, sty.hadm_id, sty.icustay_id
    , CASE  
        WHEN cht.min_int < (sty.intime + INTERVAL '2 days')
        THEN 0 ELSE 1
    END AS tx_group
FROM icustays sty
RIGHT JOIN cohort cht ON sty.icustay_id = cht.icustay_id
