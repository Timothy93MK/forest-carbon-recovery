# 02_calculate_agc.R
# Purpose: Explain how aboveground carbon (AGC) was estimated
# 
# In the field, we measured every tree's diameter (DBH) and a sub-sample
# of heights. This script works with the plot-level summaries because
# the individual tree data are confidential. The comments below explain
# each step of the calculation pipeline so anyone reading this understands
# the method, not just the code.

library(tidyverse)

dat <- read_csv("data/cleaned_data.csv", show_col_types = FALSE)

dat$age_class <- factor(
  dat$age_class,
  levels = c("Farmbush", "Young Secondary", "Old Secondary", "Control")
)

#--- The allometric equation -----------------------------------------------
# We used the Chave et al. (2014) pantropical model:
#
#   AGB_tree = 0.0673 x (wood_density x DBH^2 x height)^0.976
#
# This gives aboveground biomass (AGB) in kg for a single tree.
# We then:
#   1. Sum all tree AGB values within each 40x40 m plot
#   2. Multiply the sum by 0.47 to convert biomass to carbon (IPCC default)
#   3. Divide by 0.16 (the plot area in hectares) to get Mg C per hectare
#
# IMPORTANT: Apply steps 2 and 3 only once, at the plot level.
# Applying them at both tree and plot level doubles the scaling
# and inflates the estimate by roughly 2.77 times.

#--- Summarise AGC by age class --------------------------------------------

agc_summary <- dat %>%
  group_by(age_class) %>%
  summarise(
    n_plots  = n(),
    mean_agc = round(mean(agc_mg_ha), 2),
    sd_agc   = round(sd(agc_mg_ha), 2),
    se_agc   = round(sd(agc_mg_ha) / sqrt(n()), 2),
    .groups  = "drop"
  )

print(agc_summary)

#--- How much carbon has each class recovered? -----------------------------
# Express each class as a percentage of the control (mature forest)

control_mean <- agc_summary$mean_agc[agc_summary$age_class == "Control"]

agc_summary <- agc_summary %>%
  mutate(pct_of_control = round((mean_agc / control_mean) * 100, 1))

print(agc_summary)

# Save for use in later scripts
write_csv(agc_summary, "data/agc_summary_by_class.csv")
print("AGC summary saved.")
