----------------------------
-- MECHANICAL VENTILATION --
----------------------------
-- https://www.openanesthesia.org

-- VOLUME MODES
-- -- Assist-Control Ventilation (ACV)
-- -- Continuous mandatory ventilation (CMV)
-- -- Synchronized Intermittent-Mandatory Ventilation (SIMV)

-- PRESSURE MODES
-- -- Pressure-Controlled Ventilation (PCV)
-- -- Pressure Support Ventilation (PSV)
-- -- Pressure Controlled Inverse Ratio Ventilation (PCIRV)
-- -- Airway Pressure Release Ventilation (APRV)

-- DUAL MODES
-- -- Pressure Regulated Volume Control (PRVC)

-- INTERACTIVE MODES
-- -- Proportional Assist Ventilation (PAV)

-- ADDITIONAL MODES
-- -- Inverse Ratio Ventilation (IRV)
-- -- Adaptive Support Ventilation (ASV)
-- -- High Frequency Oscillatory Ventilation (HFOV)
-- -- High Frequency Percussive Ventilation (HFPV)


SELECT itemid, label
FROM d_items
WHERE label ILIKE
    ANY (
        ARRAY [
            '%vent%', 
            '%mech%',
            '%mode%',
            '%invasive%',
            '%wean%',
            '%cpp%',
            '%ppv%',
            '%pap%',
            '%fio2%',
            '%insp%',
            '%pressure%', 
            '%peep%', 
            '%pip%',
            '%tidal%',
            '%volume%', 
            '%plateau%',  
            -- '%int%'
            '%mandatory%',
            '%adapt%', 
            '%sync%', 
            '%support%',
            '%assist%',
            '%c%tr%l%',
            '%a/c%'
            '%cv%',
            '%asv%',
            '%imv%',
            '%ilv%',
            '%hfv%',
            '%hfp%',
            '%irv%',
            '%prv%',
            '%pav%'
        ]
    )
ORDER BY itemid
