## The identifiers/ directory
Text files in each subdirectory are unstructured data used to locate samples in MIMIC-III pertaining to the Bauer et al. 2017 dataset.

**NOTE: The presence/absence of an ID/datum/query in a given text file does not necessarily mean that ID/datum/query was used/omitted to construct the dataset.**

Most files contain one or more of:

- ICD-9 codes
- D_ITEMS.ITEMID's
- D_ITEMS.LABEL's
- Drug codes (NDC/GSN/ATC)
- Literature references

Some files contain search terms used to match text-encoded features in MIMIC-III.

Some files contain example SQL queries against MIMIC-III.

Most (not all) billable ICD-9 codes have descriptions with abbreviations e.g. "196.1 Mal neo lymph-intrathor". No attempt was made to standadize this pattern, so the association between billable codes and abbreviations is not consistent within or across files.
