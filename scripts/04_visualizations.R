# 04_visualizations.R
# Purpose: Produce four figures that tell the carbon recovery story
# Style:   Greyscale, clean axes (theme_classic), 300 dpi PNG
# Output:  Saved to the figures/ folder

library(tidyverse)

dat <- read_csv("data/cleaned_data.csv", show_col_types = FALSE)

dat$age_class <- factor(
  dat$age_class,
  levels = c("Farmbush", "Young Secondary", "Old Secondary", "Control")
)

# We need a summary table for the bar charts
agc_summary <- dat %>%
  group_by(age_class) %>%
  summarise(
    mean_agc = mean(agc_mg_ha),
    se_agc   = sd(agc_mg_ha) / sqrt(n()),
    .groups  = "drop"
  )

#--- Figure 1: Mean AGC by age class with error bars -----------------------

ggplot(agc_summary, aes(x = age_class, y = mean_agc)) +
  geom_col(fill = "grey60", width = 0.6) +
  geom_errorbar(aes(ymin = mean_agc - se_agc,
                     ymax = mean_agc + se_agc), width = 0.2) +
  labs(x = "Fallow Age Class",
       y = expression("Mean AGC (Mg C ha"^{-1}*")")) +
  theme_classic(base_size = 12)

ggsave("figures/agc_by_age_class.png", width = 7, height = 5, dpi = 300)

#--- Figure 2: AGC vs fallow years with regression line --------------------

ggplot(dat, aes(x = fallow_years, y = agc_mg_ha)) +
  geom_point(colour = "grey30", size = 2) +
  geom_smooth(method = "lm", se = TRUE, colour = "black", fill = "grey80") +
  labs(x = "Years Since Disturbance",
       y = expression("AGC (Mg C ha"^{-1}*")")) +
  theme_classic(base_size = 12)

ggsave("figures/agc_vs_fallow_years.png", width = 7, height = 5, dpi = 300)

#--- Figure 3: Recovery as percentage of control ---------------------------

control_mean <- agc_summary$mean_agc[agc_summary$age_class == "Control"]

recovery <- agc_summary %>%
  mutate(pct_recovery = (mean_agc / control_mean) * 100)

ggplot(recovery, aes(x = age_class, y = pct_recovery)) +
  geom_col(fill = "grey50", width = 0.6) +
  geom_hline(yintercept = 100, linetype = "dashed") +
  labs(x = "Fallow Age Class",
       y = "Recovery (% of Control)") +
  theme_classic(base_size = 12)

ggsave("figures/recovery_percentage.png", width = 7, height = 5, dpi = 300)

#--- Figure 4: Basal area vs AGC ------------------------------------------

ggplot(dat, aes(x = basal_area_m2_ha, y = agc_mg_ha)) +
  geom_point(colour = "grey30", size = 2) +
  geom_smooth(method = "lm", se = TRUE, colour = "black", fill = "grey80") +
  labs(x = expression("Basal Area (m"^{2}*" ha"^{-1}*")"),
       y = expression("AGC (Mg C ha"^{-1}*")")) +
  theme_classic(base_size = 12)

ggsave("figures/basal_area_vs_agc.png", width = 7, height = 5, dpi = 300)

print("All four figures saved to figures/")
