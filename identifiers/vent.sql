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

-- Unambiguous invasive mechanical ventilation
469	O2 Delivery Mode
502	PCV Insp Vt (Obser)
503	PCV Set Insp. Press
631	Sensitivity-Vent
651	Spon RR (Mech.)
652	Spon. Vt (L) (Mech.)
654	Spont. Tidal Volume
670	TCPCV Insp. Pressure
671	TCPCV Insp. Time
683	Tidal Volume (Set)
684	Tidal Volume (Spont)
720	Ventilator Mode
721	Ventilator No.
722	Ventilator Type
724	Vision - EPAP
725	Vision - IPAP
726	Vision - Mode
727	Vision FiO2
732	Waveform-Vent
1558	APRV P HIGH
1559	APRV P LOW
1560	APRV T HIGH
1561	APRV T LOW
1581	APRV
3121	himv
3180	APRV P-HI
3181	APRV P-LOW
3182	APRV T-HI
3183	APRV T-LOW
3509	Mode
3605	Respiratory Support
3681	Ventilator Number
3689	Vt [Ventilator]
5593	MMV tidal volume
5824	HiMV
5865	APRV Pressure High
5866	APRV Pressure Low
5867	APRV Time High
5868	APRV Time low
6292	APRV HIGH
6293	APRV LOW
6336	PCV driving pressure
6669	APRV Phi
6670	APRV Plo
6671	APRV T hi
6672	APRV T lo
7020	P-HI (APRV)
7021	P-LO (APRV)
7022	T-HI (APRV)
7023	T-LO (APRV)
3083	spont Tidal volumes
7403	Volume/SIMV with PSV
7524	aprv phigh
7607	Tranpul. Insp Hold
7647	set min. vent
220292	Minute Volume Alarm - Low
220293	Minute Volume Alarm - High


-- Below items not filtered 


449	Minute Volume (Set)
450	Minute Volume(Obser)
459	Neg Insp Force(>-25)

491	PAP Mean
492	PAP [Systolic]


505	PEEP
506	PEEP Set
507	PIP



535	Peak Insp. Pressure
543	Plateau Pressure
544	Plateau Time (7200)
545	Plateau-Off
578	Pressure Support
606	Rec. Breath Pressure
639	Sigh Tidal Volume
681	Tidal Volume
682	Tidal Volume (Obser)
686	Total PEEP Level
1003	cuff pressure
1096	Auto-PEEP level
1211	Insp Time %
1227	autopeep
1340	high minute volume
1486	High Minute Volume
1487	hi min vent
1488	HIGH MIN. VENTIL.
1496	HIGH MIN. VENT.
1497	High Vent Alarm
1504	High min. volume
1514	Hi Tidal Vol
1562	High Minute Ventil.
1570	HI TIDAL VOL
1577	high minute vent
1580	HI/Minute/Volume
1599	HIGH MINUTE VENT.
1600	HIGH MINUTE VOLUME
1618	high tidal vol
1621	High/Min/Vent
1631	High/MIN/VENT
1633	HIGH/MIN/VENT
1641	high min. volume
1651	High Tidal Volume
1655	Insp. Time
1658	driving pressure
1659	high min vent
1660	High Tidal volume
1679	high min. vent.
1683	Low minute volume
1686	Hi insp. pressure
1705	Vent Sens Thresh mV
1718	High Minute Vent.
1726	HIGH MIN VENT
1729	Hi Min Vent
1736	hi/min/vent
1738	high/min/vent
1976	hi min vent.
1990	High minute vent.
2000	Inspiratory Time
2006	high min volume
2018	High min volume
2025	High pressure
2027	Low pressure
2034	High min. vent.
2043	Tidal Vol (P High)
2044	Tidal Vol (P Low)
2049	HI TIDAL VOLUME
2059	Driving pressure
2065	HIGH TIDAL VOLUME
2069	hi tidal volume
2072	Pinsp
2103	High minute volume
2105	hi minute volume
2107	pinsp
2124	high mn vent
2129	Driving Pressure
2281	VENT DRAIN
2314	cpp
2400	tidal volumes
2402	sp tidal volumes
2408	tidal vol
2420	TIDAL VOLUME
2534	tidal volume

2922	P-insp
2949	HIGH MIN.VOLUME
2990	High Tidal Vol
3003	SPNIOT TIDAL VOLUMES
3009	Insp.Time
3046	HIGH MINUTE VENT. N
3050	spont tidal volumes
3068	High Pressure Limit
3077	Migh Min Volume
3079	high volume
3082	HIGH TIDAL VOL
3101	High Minute volume
3114	PCV Driving Pressure
3115	PCV Total Pressure
3143	low insp pressure
3161	Hi Minute Volume
3195	P insp
3200	High Minute Volume m
3204	Pinsp.
3210	pressure high
3236	HI MINUTE VOLUME
3253	Sigh Breath/Pressure
3254	High minute Vent.
3260	high minnute volume
3268	INSP TIME
3271	insp time
3420	FIO2
3421	FIO2 Alarm [Low]
3422	FIO2 [Meas]
3459	High Pressure Relief
3555	PEEP Alarm
3556	PIP Alarm
5563	HIGH MINUTE VOLUMER

5630	DRIVING PRESSURE
5668	CUFF PRESSURE
5782	High Minute Ventilan
5786	high pressure
5818	PAP Alarm [Low]
5850	Home Bipap Unit
5870	HOME VENT
5874	High min. vent
5964	Autopeep
6047	Hi insp press
6060	Bipap mask
6063	P insp.
6065	High minute Volume
6098	Bacitracin topical
6105	High PIP
6107	Low Pressure
6112	left vent drain
6115	high/min /vent
6130	Hi min vent
6185	Hi Min vent
6236	high pip
6259	Tank Pressure (NO)
6280	flovent
6283	Nitric Tank Pressure
6291	NITRIC TANK PRESSURE


6315	Insp time

6339	PRESSURE SUPPORT
6342	P Insp
6346	Cuff Pressure
6349	AUTOPeeP
6350	total PeeP
6384	PINSP
6417	low pressure
6439	Nitric tank pressure
6489	auto-peep
6540	IntraABd pressure
6552	low insp press
6601	Auto PeeP
6612	flowvent MDI
6631	pressure low




6729	Act CPP
6768	tank pressure
6859	Insp press mius PEEP
6864	Low insp pressure

6889	PEEP Sigh level
6924	MEASURED PEEP
6935	insp. vt
6943	LOW PEEP
6944	LOW PRESSURE
6985	Sigh PEEP level
7018	ecmo fio2




7026	PTPinsp
7041	vapotherm fio2
7092	Tinsp
7111	papaperine
7112	PAPAVERINE MG/HR
7124	Low pressure Alarm
7128	He tank pressure
7133	abd pressure
7176	low insp. pressure
7332	pressure support
7337	Insp. time
7352	DRIVING PRESSURE

7423	Flovent Puffs
7504	Driv pressure

7534	Intrinsic peep
7540	expir pressure
7541	insp pressure e
7570	FIO2 SET
7574	lumbar pressure
7579	rotation mode on d

7632	NO Tank Pressure
7638	Driving Pressure:
7645	Central line SVO2

7778	Ptp Insp.
7787	RLEcomp.pressure
7790	combivent puffs
7802	high peep
7803	low peep
7841	Combivent Puff
7967	vacuum assist
8053	SIGH PEEP LEVEL
8107	Mammary Support Bra
8212	mammo support
8301	Recruitment pressure
8345	Sigh peep level
8357	Sigh Peep
8361	Trans pul insp
8448	PAP [Diastolic]
8449	Patient controlled analgesia (PCA) [Attempt]
8457	Pressure Sore #1 [Heal]
8458	Pressure Sore #2 [Heal]
8459	Pressure Sore #3 [Heal]
8460	Pressure Sore #1 [Amount]
8461	Pressure Sore #2 [Amount]
8462	Pressure Sore #3 [Amount]
8463	Pressure Sore #1 [Length]
8464	Pressure Sore #2 [Length]
8465	Pressure Sore #3 [Length]
8482	Ventricular Pacemaker [Capture]
8483	Ventricular Pacemaker Threshold [Value]
8484	Ventricular Pacemaker [Sensitivity]
8495	Ventricular Pacemaker Sense [mA]
8517	FIO2 Alarm [High]
8552	PAP Alarm [High]
40058	Cerebral Drain R Ventricular Drain
40097	Cerebral Drain L Ventricular Drain
40953	intake from paper
41739	TOTAL IN FROM PAPERT
41741	TOTAL IN ON PAPER CT
41747	i&o by paper
41751	TOTAL OUT ON PAPER T
41753	TOTAL OUT FROM PAPET
41989	VENTRICULAR DRAIN
42193	CONTRAST CATH LAB
42574	INTERVENTIONAL RADIY
42735	Intra-abd. Pressure
43444	GT vent
43744	NS bladder pressure
43859	vent. drain
43896	vent drain
44344	BLADDER PRESSURE FLD
44723	PAPAVERINE
44862	BLADDER PRESSURE
44996	PD Volume Out.
45327	Ventricular Drain
45630	#11 vent cap/#14 sx
45640	#11 Vent cap/ #16
45682	bladder pressure in
45822	Vent drain
46553	catrh lab ivf
46603	Sodium Citrate ml/hr
46715	Citrate - dialysis
46780	Bladdar pressure
80025	CITROBACTER AMALONATICUS
80106	CANDIDA TROPICALIS
80139	CLOSTRIDIUM DIFFICILE
80177	RESPIRATORY SYNCYTIAL VIRUS (RSV)
80190	SYNCEPHALASTRUM SPECIES
80248	CITROBACTER FREUNDII COMPLEX
80250	MODERATE BLASTOCYSTIS HOMINIS
90021	PIPERACILLIN
90026	PIPERACILLIN/TAZO
220050	Arterial Blood Pressure systolic
220051	Arterial Blood Pressure diastolic
220052	Arterial Blood Pressure mean
220056	Arterial Blood Pressure Alarm - Low
220058	Arterial Blood Pressure Alarm - High
220059	Pulmonary Artery Pressure systolic
220060	Pulmonary Artery Pressure diastolic
220061	Pulmonary Artery Pressure mean
220063	Pulmonary Artery Pressure Alarm - High
220066	Pulmonary Artery Pressure Alarm - Low
220069	Left Artrial Pressure
220072	Central Venous Pressure Alarm - High
220073	Central Venous Pressure Alarm - Low
220074	Central Venous Pressure
220125	Left Ventricular Assit Device Flow
220128	Right Ventricular Assist Device Flow
220179	Non Invasive Blood Pressure systolic
220180	Non Invasive Blood Pressure diastolic
220181	Non Invasive Blood Pressure mean
220224	Arterial O2 pressure
220235	Arterial CO2 Pressure


220339	PEEP set
220765	Intra Cranial Pressure
220971	ESDEP (Solvent / Detergent Virus-Inactivated Plasma)
221005	Vamin 14 Electrolyte free
221006	Vamin 18 Electrolyte free
221007	Vamin 14 Plus electrolytes
223751	Non-Invasive Blood Pressure Alarm - High
223752	Non-Invasive Blood Pressure Alarm - Low
223763	Bladder Pressure
223767	Intra Cranial Pressure Alarm - High
223768	Intra Cranial Pressure Alarm - Low
223835	Inspired O2 Fraction
223848	Ventilator Type
223849	Ventilator Mode
223870	Wean
223872	Inspired Gas Temp.
223956	Temporary Pacemaker Mode
223958	Temporary Venticular Sens Threshold mV
223960	Temporary Venticular Stim Threshold mA
223962	Temporary Pacemaker Wires Venticular
224023	Support Systems
224025	Spiritual Support
224085	Assistance Device
224088	Pressure Reducing Device
224091	Continuous Pressure Machine Status
224149	Access Pressure
224150	Filter Pressure
224151	Effluent Pressure
224152	Return Pressure
224167	Manual Blood Pressure Systolic Left
224178	Small Volume Neb Dose #2
224181	Small Volume Neb Drug #1
224309	Assisted Systole
224404	ART Lumen Volume
224406	VEN Lumen Volume
224417	Cuff Pressure
224418	Cuff Volume (mL)