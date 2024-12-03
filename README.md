# Predicting Likelihood of Fatality in Traffic Collisions

## Overview

This repo contains the data, code, and analysis of predicting the likelihood of fatalities in traffic collisions by Kevin Roe. 

## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains the simulated data
-   `data/01-raw_data` contains the raw data as obtained from OpenDataToronto. Feel free to download the csv [here](https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/ec53f7b2-769b-4914-91fe-a37ee27a90b3/resource/cb890861-ed20-4862-bb75-b1f9ec1e58dd/download/Traffic%20Collisions%20-%204326.csv). The raw data is saved as a parquet due to size issues.
-   `data/02-analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains the fitted model. 
-   `other` contains relevant sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

No aspects of the code was written using LLMs.
