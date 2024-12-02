#### Preamble ####
# Purpose: Models for Fatality Rates 
# Author: Kevin Roe
# Date: 24 November 2024 
# Contact: kevin.roe@mail.utoronto.ca 
# License: MIT
# Pre-requisites: Run 02-download_data.R and 03-clean_data to get cleaned dataset

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)
library(bayestestR)


#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

### Model data ####

# Convert variables to factors
analysis_data$hour <- factor(analysis_data$hour)
analysis_data$year <- factor(analysis_data$year)
analysis_data$police_division <- factor(analysis_data$police_division)

# Sample a reduced dataset using Stratified Sampling 
motor_fatality_reduced_data <- analysis_data %>%
  group_by(fatalities) %>%
  slice_sample(n = 2000 / n_distinct(analysis_data$fatalities)) %>%
  ungroup()

set.seed(420)

# Extension Model with Interaction and Fixed Effects

motor_fatality_prediction_model <-
  stan_glm(
    fatalities ~ hour + injury_collision + fail_to_remain_collision + property_damage_collision + automobile + 
      motorcycle + passenger + bicycle + pedestrian + police_division + year,
    data = motor_fatality_reduced_data,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = 
      normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 420,
    iter = 2000,
    init = "0"
  )


#### Save models ####
summary(motor_fatality_prediction_model)

saveRDS(
  motor_fatality_prediction_model,
  file = "models/motor_fatality_prediction_model.rds"
)

#### Posterior Model Checks ####

# Extension Model Checks
posterior_predict(motor_fatality_prediction_model)
pp_check(motor_fatality_prediction_model)

posterior_summary <- describe_posterior(motor_fatality_prediction_model)
print(posterior_summary)

