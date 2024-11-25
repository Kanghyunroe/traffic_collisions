#### Preamble ####
# Purpose: Cleans the raw collision data from OpenDataToronto
# Author: Kevin Roe
# Date: 24 November 2024 
# Contact: kevin.roe@mail.utoronto.ca 
# License: MIT
# Pre-requisites: Run 02-download_data.R

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/raw_data.csv")


cleaned_data <- 
  raw_data |> 
  
  
  # Only include the columns of interest 
  select("_id", "OCC_MONTH", "OCC_DOW", "OCC_YEAR", "OCC_HOUR", "DIVISION", 
         "FATALITIES", "INJURY_COLLISIONS", "FTR_COLLISIONS", "PD_COLLISIONS",
         "AUTOMOBILE", "MOTORCYCLE", "PASSENGER", "BICYCLE", "PEDESTRIAN") |>
  
  # Rename Variables 
  rename("id" = "_id", 
         "month" = "OCC_MONTH",
         "date_of_week" = "OCC_DOW",
         "year" = "OCC_YEAR",
         "hour" = "OCC_HOUR",
         "police_division" = "DIVISION",
         "fatalities" = "FATALITIES", 
         "injury_collision" = "INJURY_COLLISIONS", 
         "fail_to_remain_collision" = "FTR_COLLISIONS",
         "property_damage_collision" = "PD_COLLISIONS",
         "automobile" = "AUTOMOBILE", 
         "motorcycle" = "MOTORCYCLE", 
         "passenger" = "PASSENGER", 
         "bicycle" = "BICYCLE", 
         "pedestrian" = "PEDESTRIAN", 
  ) |>
  
  # Update Fatalities and Clean Other Variables
  mutate(fatalities = ifelse(is.na(fatalities), 0, fatalities)) |>
  
  mutate(
    injury_collision = case_when(
      injury_collision == "YES" ~ 1,
      injury_collision == "NO" ~ 0,
      injury_collision == "N/R" ~ NA_real_
    ),
    fail_to_remain_collision = case_when(
      fail_to_remain_collision == "YES" ~ 1,
      fail_to_remain_collision == "NO" ~ 0,
      fail_to_remain_collision == "N/R" ~ NA_real_
    ),
    property_damage_collision = case_when(
      property_damage_collision == "YES" ~ 1,
      property_damage_collision == "NO" ~ 0,
      property_damage_collision == "N/R" ~ NA_real_
    ),
    automobile = case_when(
      automobile == "YES" ~ 1,
      automobile == "NO" ~ 0,
      automobile == "N/R" ~ NA_real_
    ),
    motorcycle = case_when(
      motorcycle == "YES" ~ 1,
      motorcycle == "NO" ~ 0,
      motorcycle == "N/R" ~ NA_real_
    ),
    passenger = case_when(
      passenger == "YES" ~ 1,
      passenger == "NO" ~ 0,
      passenger == "N/R" ~ NA_real_
    ),
    pedestrian = case_when(
      pedestrian == "YES" ~ 1,
      pedestrian == "NO" ~ 0,
      pedestrian == "N/R" ~ NA_real_
    )
  ) |>
  
  # Drop Rows with any N/A values 
  drop_na()

#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")

