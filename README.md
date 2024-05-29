# Newly Calibarated Archive Information and data from Kodaikanal Solar Observatory (KoSO).

## Information

## Data
### Corrected Time of Observation File
This file (CSV: [Download Here](data/KoSO_Cak_corrected_Tobs_v1.0.csv); TXT: [Download Here](data/KoSO_Cak_corrected_Tobs_v1.0.txt)) contains following information
- **Col 1**: Filename as stored in KoSO archive, It may varies from one version to another.
- **Col 2**: Corrected Time of observation (Tobs)
- **Col 3**: Flag, specifying the correctness of Tobs _(Correct 0; Incorrect 1; Unknown -1; Bad 2)_. Here, Bad implies that the data quality is too bad and our algorithm has failed to get the Tobs.
- **Col 4**: Pole angle calculated using the Equation 1 and 2 of the article.

### Butterfly Diagram

### Latitudinal Distribution of Plage and Sunspot File
These files (Plage: [Download Here](data/KoSO_CaK_plage_latitudinal_quantiles.csv); Sunspot: [Download Here](data/KoSO_WL_sunspot_latitudinal_quantiles.csv)))
- **Col 1**: Year of observation over which data is used to calculate latitudinal extent.
- **Col 2**: First Quartile ($Q1$), representing latitude below which 25% plage/sunspot area is covered.  
- **Col 3**: Second Quartile ($Q2$), representing the median latitude of plage/sunspot area distribution for given year. 
- **Col 4**: Thirdt Quartile ($Q3$), representing latitude below which 75% or latitude above which 25% plage/sunspot area is covered.

## Plots
