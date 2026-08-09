# Aboveground Carbon Recovery After Swidden Agriculture

## Overview

This project examines how aboveground carbon (AGC) stocks recover across a fallow chronosequence following swidden (slash and burn) agriculture in communities surrounding the Bojene and Kasewe Hills Forest Reserves, Sierra Leone. The work was completed as part of an MSc in Forestry (Forest Biometrics and Remote Sensing) at Njala University.

## Research Question

How does aboveground carbon stock change with time since disturbance across fallow age classes in upland secondary forests?

## Study Design

Seventy plots (40 x 40 m, 0.16 ha each) were established across four land use classes:

| Age Class | Description | Fallow Age Range | No. of Plots |
|-----------|-------------|-----------------|--------------|
| Farmbush | Post-clearance regeneration | 0 to 4 years | 20 |
| Young Secondary | Mid-successional secondary forest | 5 to 9 years | 20 |
| Old Secondary | Late-successional secondary forest | 10 to 16 years | 20 |
| Control | Mature old-growth forest | ~60 years standing | 10 |

The 10 control plots were permanent plots established inside Kasewe Hills Forest Reserve (KHFR). The 60 fallow plots were temporary plots established across 20 surrounding communities: 10 communities in Moyamba District around KHFR and 10 communities in Bo District around Bojene Hills Forest Reserve (BHFR). Each community contributed one plot per fallow age class.

There is no control baseline inside Bojene. The Kasewe control serves as the old-growth reference for both study sites. This is the main design limitation.

All trees with DBH >= 10 cm were measured. Height was measured on a sub-sample of 359 stems, and a Michaelis-Menten model was used to predict missing heights. Aboveground biomass was estimated using the Chave et al. (2014) pantropical allometric equation (Model 4). Carbon stock was calculated using the IPCC default carbon fraction of 0.47.

## Methods

- **Inventory**: Full census of stems >= 10 cm DBH in each plot
- **Allometry**: Chave et al. (2014) Model 4 with locally fitted height-diameter model
- **Wood density**: Global Wood Density Database, prioritising West African regional values
- **Statistics**: One-way ANOVA, Tukey HSD, Kruskal-Wallis test, linear regression
- **Software**: R (tidyverse, ggplot2, BIOMASS package), QGIS

## Key Findings

- **AGC by class**: Farmbush 1.02, Young Secondary 6.39, Old Secondary 18.84, Control 136.70 Mg C ha-1
- **ANOVA**: F(3, 59) = 151.5, P < 0.001; all pairwise comparisons significant (Tukey HSD)
- **Kruskal-Wallis**: H = 36.49, P < 0.001
- **Recovery rate**: 2.41 Mg C ha-1 yr-1 across the fallow chronosequence
- **Basal area model**: R-squared = 0.959, confirming basal area as a strong predictor of carbon stock
- **Stem density model**: R-squared = 0.484
- **Fallow age model**: R-squared = 0.516
- **Time to parity**: Approximately 60 years to reach old-growth carbon levels

## Limitations

Chronosequence studies assume that plots differ primarily in recovery age and that site conditions are broadly comparable. The design substitutes space for time, so observed differences reflect both recovery duration and natural site variation. There is no old-growth baseline inside Bojene, which limits direct comparison between the two forest types (Moist Semi-Deciduous at Kasewe versus Moist Evergreen at Bojene). The study area covers two reserves in one region of Sierra Leone, so extrapolation to other forest types or climatic zones should be done cautiously.

## Repository Structure

```
forest-carbon-recovery/
├── README.md
├── data/
│   ├── README.md                 # Data dictionary
│   └── sample_data.csv           # Simulated dataset (not real field data)
├── scripts/
│   ├── 01_clean_data.R           # Data loading and cleaning
│   ├── 02_calculate_agc.R        # AGC estimation workflow
│   ├── 03_statistical_analysis.R # ANOVA, regression, post hoc tests
│   └── 04_visualizations.R       # Publication-quality figures
├── figures/                       # Output graphs
├── maps/                          # Study area maps
├── report/
│   └── portfolio_summary.md      # One-page project summary
└── LICENSE
```

## Data and Figures Note

The dataset in `data/sample_data.csv` is **simulated** to mirror the structure of the original study. Real field data remain confidential. The simulated data approximate the observed patterns and are provided so the R scripts can run independently.

The figures in `figures/` were produced from the full study dataset as part of the MSc dissertation. They reflect the actual results reported above.

## Skills Demonstrated

- Forest inventory design and permanent sample plot (PSP) methodology
- Aboveground biomass and carbon estimation using pantropical allometrics
- Statistical analysis: ANOVA, non-parametric tests, regression modelling
- R programming for forest biometrics
- Data visualisation (ggplot2) and spatial analysis (QGIS)
- Scientific communication and reproducible research

## References

- Chave, J., et al. (2014). Improved allometric models to estimate the aboveground biomass of tropical trees. *Global Change Biology*, 20(10), 3177-3190.
- IPCC (2006). Guidelines for National Greenhouse Gas Inventories, Volume 4: Agriculture, Forestry and Other Land Use.
- Titenwi, P.N., et al. (2025). Carbon recovery in swidden landscapes of Sierra Leone.

## Citation

Kabba, M.T. (2026). Aboveground Carbon Recovery After Swidden Agriculture.
GitHub repository: https://github.com/Timothy93MK/forest-carbon-recovery

## Licence

This project is licensed under the MIT Licence. See [LICENSE](LICENSE) for details.
