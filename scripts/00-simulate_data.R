#### Preamble ####
# Purpose: Simulates dataset of Motor Vehicle Collisions in toronto
# Author: Kevin Roe
# Date: 24 November 2024 
# Contact: kevin.roe@mail.utoronto.ca 
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `traffic_collisions` rproj

#### Workspace setup ####
library(tidyverse)
library(arrow)
set.seed(690)

#### Simulate data ####
# Month Names
list_of_months <- c("January", "February", "March", "April", "May", "June", 
                  "July", "August", "September", "October", "November", 
                  "December")

# Date Names
list_of_dates <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", 
                        "Saturday", "Sunday")

# INSERT 

# List of Police Divisions 
list_of_divisions <- c("D23", "D42", "NSA", "D55", "D43", "D12", "D13", "D11", 
                       "D31", "D14", "D53", "D52", "D41", "D33", "D22", "D51",
                       "D32")

simulated_data <- tibble(
  # Use 1 through 1000 to represent unique IDs as the dataset is too large
  id = 1:1000, 
  
  # Randomly Assign Months
  month = sample(list_of_months, size = 1000, replace = TRUE),
  
  # Randomly Assign Day of the Week
  date_of_week = sample(list_of_dates, size = 1000, replace = TRUE),
  
  # Randomly Assign Years
  year = sample(2014:2024, size = 1000, replace = TRUE), 
  
  # Randomly Assign Hours
  hour = sample(0:24, size = 1000, replace = TRUE),
  
  # Randomly Assign Police Divisions
  police_division = sample(list_of_divisions, size = 1000, replace = TRUE),
  
  # Randomly Fatalities Variable
  fatalities = sample(0:1, size = 1000, replace = TRUE),
  
  # Randomly Injury Collision Variable
  injury_collision = sample(0:1, size = 1000, replace = TRUE),
  
  # Randomly fail_to_remain_collision Variable
  fail_to_remain_collision = sample(0:1, size = 1000, replace = TRUE),
  
  # Randomly property damage collision Variable
  property_damage_collision = sample(0:1, size = 1000, replace = TRUE),
  
  # Randomly automobile Variable
  automobile = sample(0:1, size = 1000, replace = TRUE),
  
  # Randomly motorcycle Variable
  motorcycle = sample(0:1, size = 1000, replace = TRUE),
  
  # Randomly passenger Variable
  passenger = sample(0:1, size = 1000, replace = TRUE),

  # Randomly bicycle Variable
  bicycle = sample(0:1, size = 1000, replace = TRUE),  
  
  # Randomly pedestrian Variable
  pedestrian = sample(0:1, size = 1000, replace = TRUE)
  
)

#### Save data ####
write_parquet(simulated_data, "data/00-simulated_data/simulated_data.parquet") 
