#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Kevin Roe
# Date: 24 November 2024
# Contact: kevin.roe@mail.utoronto.ca 
# License: MIT
# Pre-requisites: Install necessary packages

#### Workspace setup ####
# install.packages("opendatatoronto")
# install.packages("tidyverse")
library(opendatatoronto)
library(tidyverse)

#### Download data ####
# Code adapted from OpenDataToronto
# Get package
package <- show_package("ec53f7b2-769b-4914-91fe-a37ee27a90b3")

# Get all resources for this package
resources <- list_package_resources("ec53f7b2-769b-4914-91fe-a37ee27a90b3")

# Identify datastore resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# Load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()

#### Save data ####
write_csv(data, "data/01-raw_data/raw_data.csv") 

         
