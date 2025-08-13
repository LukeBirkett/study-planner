# Project Plan - ML Rainfall Prediction

## Phase 1: Data Processing & Foundation
### Data Loading & Exploration
[x] Create a class to read in CSVs
[x] Function to identify and log CSV dimensions and metadata
[x] Set up a const of all the parameter names
[x] Set up a const of all dates available (for CSV names)
[x] Set up variable to hold label name (Rainf_tavg)
[x] Create full date column

### Data Quality & Validation
[x] Check for missing data and impute if required
[ ] Check for correlations between fields, particularly with target
[x] Check for statistical ranges in parameters
[x] Check for data completeness (location and date)


### Data Processing & Transformation 
[x] Aggregate CSVs from hourly to daily and create interim CSVs
[ ] Create a reference table for joining and splitting
[ ] Join data into correct form for CNN and RNN
[ ] Transform data into format to be used

### Data Splitting 
[ ] Split into train/test/valid

### Normalize, scale and augmentation (after split to avoid data leakage)
