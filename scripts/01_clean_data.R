# 01_clean_data.R
# Purpose: Load the plot data, check it, and prepare it for analysis
# Input:   data/sample_data.csv
# Output:  A clean data frame with age classes in ecological order

# Load the tidyverse package (gives us read_csv, group_by, summarise, etc.)
library(tidyverse)

# Read in the plot-level data
dat <- read_csv("data/sample_data.csv", show_col_types = FALSE)

# Quick look at the structure: how many rows, what columns, what types
print(str(dat))

#--- Check for missing values ---------------------------------------------
# Any NA means something went wrong in the field or during data entry
print(colSums(is.na(dat)))

#--- Set age classes in ecological order -----------------------------------
# By default R sorts alphabetically, which puts "Control" before "Farmbush".
# We want them ordered from youngest to oldest, because that is the
# recovery sequence we are studying.

dat$age_class <- factor(
  dat$age_class,
  levels = c("farmbush", "young_secondary", "old_secondary", "control"),
  labels = c("Farmbush", "Young Secondary", "Old Secondary", "Control")
)

# Confirm the counts per class
print(table(dat$age_class))

#--- Quick summary to see if the numbers make sense ------------------------
dat %>%
  group_by(age_class) %>%
  summarise(
    n        = n(),
    mean_agc = round(mean(agc_mg_ha), 2),
    sd_agc   = round(sd(agc_mg_ha), 2),
    .groups  = "drop"
  ) %>%
  print()

# Save the cleaned version
write_csv(dat, "data/cleaned_data.csv")
print("Cleaned data saved.")
