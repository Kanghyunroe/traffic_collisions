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


#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.csv")

### Model data ####

# Convert variables to factors
analysis_data$month <- factor(analysis_data$month)
analysis_data$police_division <- factor(analysis_data$police_division)

# Model 1 for n = 1000
set.seed(420)

# get the reduced dataset of only 1000 randomly selected data entries
motor_fatality_reduced_data <- 
  analysis_data |> 
  slice_sample(n = 1000)

motor_fatality_prediction_model <-
  stan_glm(
    fatalities ~ hour + injury_collision + date_of_week + month + 
      police_division + fail_to_remain_collision + 
      property_damage_collision + automobile + motorcycle + passenger + 
      bicycle + pedestrian,
    data = motor_fatality_reduced_data,
    family = binomial(link = "probit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = 
      normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 420
  )


#### Save model ####
summary(motor_fatality_prediction_model)
saveRDS(
  motor_fatality_prediction_model,
  file = "models/motor_fatality_prediction_model.rds"
)


