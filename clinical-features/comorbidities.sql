-- Other Comorbidities, n (%)
--      - [ ] COPD [ICD 490-496]
              490  	 	Bronchitis NOS
              491.0	‑	491.9  	 	491 Chronic bronchitis
              492.0	‑	492.8  	 	492 Emphysema
              493.00	‑	493.92  	 	493 Asthma
              494.0	‑	494.1  	 	494 Bronchiectasis
              495.0	‑	495.9  	 	495 Extrinsic allergic alveolitis
              496	‑	496  	 	496 Chronic airway obstruction, not elsewhere classified
--      - [ ] Cancer
              MALIGNANT NEOPLASM OF DIGESTIVE ORGANS AND PERITONEUM (150-159)
              MALIGNANT NEOPLASM OF RESPIRATORY AND INTRATHORACIC ORGANS (160-165)
              MALIGNANT NEOPLASM OF BONE, CONNECTIVE TISSUE, SKIN, AND BREAST (170-176)
              MALIGNANT NEOPLASM OF GENITOURINARY ORGANS (179-189)
              MALIGNANT NEOPLASM OF OTHER AND UNSPECIFIED SITES (190-199)
              MALIGNANT NEOPLASM OF LYMPHATIC AND HEMATOPOIETIC TISSUE (200-208)
--      - [ ] Metastatic cancer
              https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1480106/
              199.0 - Malig neo disseminated
              Lymph node spread	196*
              Secondary cancer	196*, 197*
--      - [ ] Hematologic cancer
              MALIGNANT NEOPLASM OF LYMPHATIC AND HEMATOPOIETIC TISSUE (200-208)
              Non-specific site	195*, 199*, 238.8, 238.9, 239.8, 239.9
--      - [ ] Insulin-requiring diabetes mellitus
              99.17 - Injection of insulin
              250 Diabetes mellitus
              250.00 -	250.03     250.0 Diabetes mellitus without mention of complication or manifestation classifiable to 250.1-250.9
              250.01 - Diabetes mellitus without mention of complication, type I [juvenile type], not stated as uncontrolled
              250.03 - DMI wo cmp uncntrld
              250.11 - DMI keto nt st uncntrld
              250.13 - DMI ketoacd uncontrold
              250.21 - DMI hprsm nt st uncntrld
              250.23 - DMI hprosmlr uncontrold
              250.31 - DMI o cm nt st uncntrld
              250.33 - DMI oth coma uncontrold
              250.41 - DMI renl nt st uncntrld
              250.43 - DMI renal uncntrld
              250.51 - DMI ophth nt st uncntrld
              250.53 - DMI ophth uncntrld
              250.61 - DMI neuro nt st uncntrld
              250.63 - DMI neuro uncntrld
              250.71 - DMI circ nt st uncntrld
              250.73 - DMI circ uncntrld
              250.81 - DMI oth nt st uncntrld
              250.83 - DMI oth uncntrld
              250.91 - DMI unspf nt st uncntrld
              250.93 - DMI unspf uncntrld

--      - [ ] Heart failure (NYHA III/IV)
              https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6613689/
              428.0 Congestive heart failure, unspecified
              428.1 Left heart failure
              428.2 Systolic heart failure
                  428.20 Unspecified
                  428.21 Acute
                  428.22 Chronic
                  428.23 Acute on chronic
              428.3 Diastolic heart failure
                  428.30 Unspecified
                  428.31 Acute
                  428.32 Chronic
                  428.33 Acute on chronic
              428.4 Combined systolic and diastolic heart failure
                  428.40 Unspecified
                  428.41 Acute
                  428.42 Chronic
                  428.43 Acute on chronic
              428.9 Heart failure, unspecified
--      - [ ] Chronic renal failure
              585 Chronic kidney disease (ckd)
                  585.1 Chronic kidney disease, Stage I
                  585.2 Chronic kidney disease, Stage II (mild)
                  585.3 Chronic kidney disease, Stage III (moderate)
                  585.4 Chronic kidney disease, Stage IV (severe)
                  585.5 Chronic kidney disease, Stage V
                  585.6 End stage renal disease
                  585.9 Chronic kidney disease, unspecified
--      - [ ] HIV infection
              042 Human immunodeficiency virus [HIV] disease
--      - [ ] Cirrhosis
              571 Chronic liver disease and cirrhosis
                  571.0  	 	Alcoholic fatty liver
                  571.1  	 	Ac alcoholic hepatitis
                  571.2  	 	Alcohol cirrhosis liver
                  571.3  	 	Alcohol liver damage NOS
              571.40	‑	571.49  	 	571.4 Chronic hepatitis
                  571.5  	 	Cirrhosis of liver NOS
                  571.6  	 	Biliary cirrhosis
                  571.8  	 	Chronic liver dis NEC
                  571.9  	 	Chronic liver dis NOS
--      - [ ] Immunosuppression
              https://doi.org/10.1007/s10552-005-0502-4
              288.0 Neutropenia
              Immunity deficiency NOS. ICD-9-CM 279.3
              History (personal) of immunosuppression therapy V87.46
              immunosuppression V87.46
--      - [ ] Steroid therapy
              steroid V87.45
                  inhaled V87.44
                  systemic V87.45
--      - [ ] Chemotherapy
              https://doi.org/10.1007/s10552-005-0502-4
              ICD-9 diagnosis codes
                V58.1, V66.2 and V67.2, the ICD-9 
              ICD-9 procedure code 99.25
              DRG code 410 
              HCPCS codes for chemotherapy
                (Q0083–Q0085, J7150, J9000–J9999, 96400, 96408, 96410, 96412, 96414, 96545) as well as
              relevant revenue center codes 
                (0331, 0332, and 0335)
--      - [ ] Renal replacement therapy on admission
              Subset rrt.sql 
--      - [ ] Sepsis on admission
              Subset/augment explicit.sql
              Subset/augment martin.sql
              Subset/augment angus.sql
              Subset/augment sirs.sql
DROP MATERIALIZED VIEW IF EXISTS comorbidities CASCADE;
CREATE MATERIALIZED VIEW comorbidities as

