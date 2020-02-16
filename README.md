# Bauer2017-pgSQL

## About
This repo is intended to serve as a sub-module and central resource for PL/pgSQL queries against the MIMIC-III v1.4 database that can be used to replicate the dataset from:    

Bauer PR, Gajic O, Nanchal R, Kashyap R, Martin-Loeches I, Sakr Y, et al. Association between timing of intubation and outcome in critically ill patients: A secondary analysis of the ICON audit. Journal of Critical Care. 2017;42: 1–5. doi:10.1016/j.jcrc.2017.06.010  

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
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Surgical (non-trauma)  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Medical  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Trauma  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Other  
- [ ] Source of admission, n (%)   
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Other hospital  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] ER/ambulance  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] OR/recovery room  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Hospital floor  
- [ ] Other Comorbidities, n (%)  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] COPD  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Cancer  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Metastatic cancer  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Hematologic cancer  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Insulin-requiring diabetes mellitus  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Heart failure (NYHA III/IV)  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Chronic renal failure  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] HIV infection  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Cirrhosis  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Immunosuppression  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Steroid therapy  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Chemotherapy  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Renal replacement therapy on admission  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Sepsis on admission  
- [ ] Type of organ dysfunction, n (%) (alone or in combination)  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Respiratory  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Coagulation  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Hepatic  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] CNS  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] Renal Cardiovascular  
- [ ] No. of organ dysfunctions, n (%)   
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] 0 organ  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] 1 organs  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] 2 organs  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] 3 organs  
&nbsp;&nbsp;&nbsp;&nbsp; - [ ] >3 organs  
- [ ] ICU LOS, day, median [IQR]   
- [ ] Hospital LOS, day, median [IQR]   
- [ ] ICU mortality, n (%)  
- [ ] Hospital mortality, n (%) 

