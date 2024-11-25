#### Preamble ####
# Purpose: Tests the structure and validity of the simulated dataset
# Author: Kevin Roe
# Date: 24 November 2024 
# Contact: kevin.roe@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `traffic_collisions` rproj


#### Workspace setup ####
library(tidyverse)

test_data <- read_csv("data/00-simulated_data/simulated_data.csv")

#### Test data ####

# Check column class 
class(test_data$month) == "character"
class(test_data$date_of_week) == "character"
class(test_data$year) == "number"
class(test_data$hour) == "number"
class(test_data$police_division) == "character"
class(test_data$fatalities) == "number"
class(test_data$fail_to_remain_collision) == "number"
class(test_data$property_damage_collision) == "number"
class(test_data$automobile) == "number"
class(test_data$motorcycle) == "number"
class(test_data$passenger) == "number"
class(test_data$bicycle) == "number"
class(test_data$pedestrian) == "number"

# Test that the Dataset has 15 columns
test_that("dataset has 15 columns", {
  expect_equal(ncol(test_data), 16)
})

# Test that 'month' column contains valid months 
valid_months <- c("January", "February", "March", "April", "May", "June", 
                  "July", "August", "September", "October", "November", 
                  "December", NA
)

# Test that 'date_of_week' column contains valid days of the week or NaN
valid_date_of_week <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", 
                        "Saturday", "Sunday", NA)

test_that("'date_of_week' contains valid days of the week or NaN", {
  expect_true(all(is.na(test_data$date_of_week) | 
                    test_data$date_of_week %in% valid_date_of_week))
})

test_that("'month' contains valid month names or NaN", {
  expect_true(all(is.na(test_data$month) | test_data$month %in% valid_months))
})

# Test that 'hours' column contains valid hours
valid_hours <- 1:24

test_that("'hour' contains valid hours (1-24)", {
  expect_true(all(is.na(test_data$hour) | test_data$hour %in% valid_hours))
})

# Test that 'fatalities' is binary (0 or 1)
test_that("'fatalities' is binary", {
  expect_true(all(test_data$fatalities %in% c(0, 1)))
})

# Test that 'fail_to_remain_collision' is binary (0 or 1)
test_that("'fail_to_remain_collision' is binary", {
  expect_true(all(test_data$fail_to_remain_collision %in% c(0, 1)))
})

# Test that 'property_damage_collision' is binary (0 or 1)
test_that("'property_damage_collision' is binary", {
  expect_true(all(test_data$property_damage_collision %in% c(0, 1)))
})

# Test that 'automobile' is binary (0 or 1)
test_that("'automobile' is binary", {
  expect_true(all(test_data$automobile %in% c(0, 1)))
})

# Test that 'motorcycle' is binary (0 or 1)
test_that("'motorcycle' is binary", {
  expect_true(all(test_data$motorcycle %in% c(0, 1)))
})

# Test that 'passenger' is binary (0 or 1)
test_that("'passenger' is binary", {
  expect_true(all(test_data$passenger %in% c(0, 1)))
})

# Test that 'bicycle' is binary (0 or 1)
test_that("'bicycle' is binary", {
  expect_true(all(test_data$bicycle %in% c(0, 1)))
})

# Test that 'pedestrian' is binary (0 or 1)
test_that("'pedestrian' is binary", {
  expect_true(all(test_data$pedestrian %in% c(0, 1)))
})

# No missing values in critical columns
test_that("no missing values in critical columns", {
  expect_true(all(!is.na(test_data$fatalities)))
  expect_true(all(!is.na(test_data$fail_to_remain_collision)))
  expect_true(all(!is.na(test_data$property_damage_collision)))
  expect_true(all(!is.na(test_data$automobile)))
})

# Check for balanced data to ensure both 0 and 1 exist
test_that("binary columns are reasonably balanced", {
  expect_true(all(table(test_data$fatalities) > 0))  
})

# Check for Duplicates
test_that("no duplicate rows", {
  expect_equal(nrow(test_data), nrow(distinct(test_data)))
})

# Test for unique identifier in id column
test_that("identifier is unique", {
  expect_equal(nrow(test_data), length(unique(test_data$id)))
})
