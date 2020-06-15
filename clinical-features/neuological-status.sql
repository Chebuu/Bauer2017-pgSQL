DROP MATERIALIZED VIEW IF EXISTS neuro_status CASCADE
CREATE MATEIALIZE VIEW neuro_stat AS

with aao AS (
    SELECT 
         icustay
        ,hadm_id
        ,ce.storetime 
        ,ce.charttime 
        ,ce.valuenum 
        ,ce.valueuom 
        ,CASE 
            -- ITEMID = [479, 223898]
            WHEN ce.value = 'Disoriented' THEN 0
            WHEN ce.value IN ('Oriented x 1', 'Oriented x1') THEN 1
            WHEN ce.value IN ('Oriented x 2', 'Oriented x2') THEN 2
            WHEN ce.value IN ('Oriented x 3', 'Oriented x3') THEN 3
            -- -- ITEMID = 1431
            -- WHEN ce.value = 'Disorien per/pla' THEN 1
            -- WHEN ce.value = "No addit/ ? date" THEN 1
            -- WHEN ce.value = "Oriented" THEN 3
            ELSE NULL 
        END AS AAOx3
        ,CASE 
            WHEN ce.value IN (
                'Cannot do additions and is uncertain of date'	-- "1"
                ,'Disoriented by date for < 2 days'	-- "2"
                ,'Disoriented by date for > 2 days'	-- "3"
                ,'Disoriented for place and/or person'	-- "4"
                ,'Oriented and can do serial conditions'	-- "0"
            ) THEN MAX(valuenum) 
            ELSE NULL 
        END AS CIWA_Ar
        ,CASE 
            WHEN ce.itemid = 228394	-- "Orientation to Person"
                AND valuenum IS NOT NULL
                -- "Both"	"2"
                -- "First name"	"1"
                -- "Last name"	"1"
                -- "None"	"0"
            THEN valuenum 
            ELSE NULL
        END AS person
        ,CASE 
            WHEN ce.itemid = 228395	-- "Orientation to Place"
                AND valuenum IS NOT NULL
                -- "BIDMC"	"1" -- (Location) BIDMC = Beth Israel Deaconess Medical Center
                -- "Both"	"2"
                -- "Hospital"	"1"
                -- "None"	"0"
            THEN valuenum 
            ELSE NULL
        END AS place
        ,CASE 
            WHEN ce.itemid = 228396	-- "Orientation to Time"
            AND valuenum IS NOT NULL
                -- "None"	"0"
                -- "Year"	"1"
                -- "Year & month"	"2"
                -- "Year, month, & day"	"3"
            THEN valuenum 
            ELSE NULL
        END AS date
        ,CASE 
            WHEN ce.value = 'Unable to Assess' THEN 1 
            ELSE 0 
        END AS UTA
    FROM chartevents ce 
    WHERE ce.value IS NOT NULL
    AND ce.itemid IN (
         479    -- "Orientation"
        ,1431   -- "Orient/Clouding Sens" 
        ,223821 -- "Orient/Clouding Sensory"
        ,223898 -- "Orientation"
        ,228394 -- "Orientation to Person"
        ,228395 -- "Orientation to Place"
        ,228396 -- "Orientation to Time"
    )
    GROUP BY 
)

, adl AS (
    225092	"Self ADL"
)
, eeg AS (
    3397	"EEG"
    5966	"Continuous EEG q1hr"
    6109	"EEG run"
    6828	"Q1H EEG TRACE"
    6854	"EEG (burst/min)"
    7060	"Cont. EEG"
    7565	"Cont EEG"
    7861	"EEG/Cont"
    221223	"EEG"
)
, ssx AS (
    465	"Neuro Symptoms"
    223921	"Neuro Symptoms"
    228402	"Neurological Symptoms"
)
, pain AS ()
, feed AS ()
, bstem AS (
    -- CN I
    -- CN II
    -- CN III
    -- CN IV
    -- CN V
    -- CN VI
    -- CN VII
    -- CN VIII
    -- CN IX
    -- CN X
    -- CN XI
    -- CN XII

)
, seizu AS ()
, motor AS ()
, visio AS ()
, psych AS ()
, respn AS ()
, speec AS ()


