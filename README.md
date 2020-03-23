# Bauer2017-pgSQL

## About
This repo is intended to serve as a sub-module and central resource for PL/pgSQL queries against the MIMIC-III v1.4 database that can be used to replicate the dataset from:    

[Bauer PR, Gajic O, Nanchal R, Kashyap R, Martin-Loeches I, Sakr Y, et al. *Association between timing of intubation and outcome in critically ill patients: A secondary analysis of the ICON audit.* Journal of Critical Care. 2017;42: 1–5. doi:10.1016/j.jcrc.2017.06.010](http://doi.org/10.1016/j.jcrc.2017.06.010)

## Build Instructions
Included is a Makefile with targets to build the dataset using GNU Make. 

All build targets require that the following Bash environment variables be set:

```bash
export PGHOST=127.0.0.1
export PGPORT=5432
export PGOPTIONS=--search_path=mimiciii
```
To build and export the dataset run the following target. The resulting .csv files are saved in the **data/cohort-build** directory:

```bash
make all
```

The *all* target creates several intermediate materialized views that are required to build the dataset (see the **lib/** directory), however they are not exported to .csv files. The cohort subset is then built and exported as .csv (see **cohort.sql**). Patient IDs from the cohort subset are then used to build the features subsets (see the **clinical-features/**, **demographics/**, and **severity-scores/** directories).

## Dependent repos
The following repositories depend on this repository as a sub-module:  
- [Bauer2017](https://github.com/chebuu/Bauer2017)
- [Timing-Intubation](https://github.com/chebuu/Timing-Intubation)

## Experimental design
The following excerpt describes the cohort selection criteria and experimental design of Bauer et al. 2017.

> *We used Kaplan-Meier curves and the two-stage procedure test by Qiu and 
> Sheng to compare ICU and hospital survival rates in the two groups of 
> patients who underwent intubation. We performed a sensitivity analysis by 
> varying the timing of intubation from 2 to 1 calendar days in the whole 
> population. [...] The propensity score, that is the probability of 
> undergoing intubation early, was calculated by multiple logistic 
> regression using age, sex, Simplified Acute Physiology Score (SAPS) II and 
> Sequential Organ Failure Assessment (SOFA) subscores, excluding the 
> respiratory subscore, on admission to the ICU, hospital length of stay 
> prior to ICU admission, type and sources of admission, the need for renal 
> replacement therapy (RRT) on admission to the ICU, comorbidities, and the 
> presence of sepsis on admission (see Supplemental Table 1).*

## Directory tree
Directory and file names are meant to roughly correspond to the sections and sub-sections of Table 1 in Bauer et al. 2017 with some obvious exceptions.

#### **Table 1.** Bauer et al. 2017
- [x] Age, year, mean ± SD  
- [ ] Sex, male (%)  
- [ ] SAPS II score, mean ± SD  
- [ ] SOFA score on admission, mean ± SD   
- [ ] LOS before ICU, day, median [IQR]   
- [ ] Type of admission, n (%)  
    - [ ] Surgical (non-trauma)  
    - [ ] Medical  
    - [ ] Trauma  
    - [ ] Other  
- [ ] Source of admission, n (%)   
    - [ ] Other hospital  
    - [ ] ER/ambulance  
    - [ ] OR/recovery room  
    - [ ] Hospital floor  
- [ ] Comorbidities, n (%)  
    - [x] COPD  
    - [x] Cancer  
    - [x] Metastatic cancer  
    - [x] Hematologic cancer  
    - [ ] Insulin-requiring diabetes mellitus  
    - [ ] Heart failure (NYHA III/IV)  
    - [x] Chronic renal failure  
    - [x] HIV infection  
    - [x] Cirrhosis  
    - [x] Immunosuppression  
    - [x] Steroid therapy  
    - [x] Chemotherapy  
    - [ ] Renal replacement therapy on admission  
    - [ ] Sepsis on admission  
- [ ] Type of organ dysfunction, n (%) (alone or in combination)  
    - [ ] Respiratory  
    - [ ] Coagulation  
    - [ ] Hepatic  
    - [ ] CNS  
    - [ ] Renal Cardiovascular  
- [ ] No. of organ dysfunctions, n (%)   
    - [ ] 0 organ  
    - [ ] 1 organs  
    - [ ] 2 organs  
    - [ ] 3 organs  
    - [ ] >3 organs  
- [ ] ICU LOS, day, median [IQR]   
- [ ] Hospital LOS, day, median [IQR]   
- [ ] ICU mortality, n (%)  
- [ ] Hospital mortality, n (%) 
