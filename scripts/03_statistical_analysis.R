# 03_statistical_analysis.R
# Purpose: Test whether AGC differs across fallow age classes
#          and model the recovery rate over time
#
# Two main questions:
#   1. Do the four age classes have different mean AGC? (ANOVA)
#   2. How fast does carbon accumulate per year? (regression)

library(tidyverse)

dat <- read_csv("data/cleaned_data.csv", show_col_types = FALSE)

dat$age_class <- factor(
  dat$age_class,
  levels = c("Farmbush", "Young Secondary", "Old Secondary", "Control")
)

#--- Question 1: Do age classes differ in AGC? -----------------------------

# One-way ANOVA tests whether at least one group mean differs from the rest.
# H0: all four means are equal
# H1: at least one mean is different

aov_model <- aov(agc_mg_ha ~ age_class, data = dat)
print(summary(aov_model))

# Tukey HSD tells us WHICH pairs differ.
# Every pair should be significant if recovery is real.
print(TukeyHSD(aov_model))

# Kruskal-Wallis is the non-parametric alternative.
# We report it alongside ANOVA because AGC distributions
# are often skewed, especially in the control class
# where a few large trees hold most of the carbon.
print(kruskal.test(agc_mg_ha ~ age_class, data = dat))

#--- Question 2: How fast does carbon recover? -----------------------------

# Linear regression of AGC on fallow years.
# We exclude the control plots here because we want the SLOPE
# of the recovery curve through the disturbed classes only.

dat_recovery <- dat %>% filter(age_class != "Control")

lm_model <- lm(agc_mg_ha ~ fallow_years, data = dat_recovery)
print(summary(lm_model))

# The slope tells us how many Mg C per hectare accumulate each year.
slope <- round(coef(lm_model)["fallow_years"], 2)
print(paste("Recovery rate:", slope, "Mg C per ha per year"))

#--- How long until secondary forest matches old growth? -------------------

control_mean <- mean(dat$agc_mg_ha[dat$age_class == "Control"])
years_to_parity <- round(control_mean / slope, 0)
print(paste("Estimated years to reach control levels:", years_to_parity))

#--- Basal area as a predictor of AGC --------------------------------------

# Basal area is quick to measure in the field (just DBH, no height needed).
# If it predicts AGC well, it can serve as a practical monitoring shortcut.

lm_ba <- lm(agc_mg_ha ~ basal_area_m2_ha, data = dat)
print(summary(lm_ba))
print(paste("Basal area R-squared:", round(summary(lm_ba)$r.squared, 3)))
