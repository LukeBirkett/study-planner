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
[x] Create a reference table for joining and splitting
[x] Check the ref table for missing data. 
    - Missing dates
    - Dates with incomplete params
    - Missing Locations (Coverage)
[ ] Join data into correct form for CNN and RNN
    - **3D Data Structure Design:**
      - **Rows**: Data instances (15,325 locations × 365 days = 5,593,625 instances)
      - **Columns**: Temporal sequence (30 days: current day + 29 previous days)
      - **Depth**: Parameters (11 weather parameters stacked)
      - **Final Shape**: (5,593,625 instances, 30 days, 11 parameters)
    - **Temporal Window Creation:**
      - Create 30-day rolling windows for each location-date combination
      - Handle month/year boundaries and missing dates
      - Use pandas shift() or rolling windows for efficiency
    - **Parameter Stacking Strategy:**
      - Join parameter values from interim CSVs
      - Stack parameters to create depth dimension
      - Ensure consistent ordering across all dimensions
    - **Memory Management:**
      - Handle ~1.8 billion data points efficiently
      - Implement chunked processing for 16GB M1 Pro
      - Consider parameter-by-parameter or geographic chunking
[ ] Spend some time setting all of the values to correct format
[ ] Transform data into format to be used

### Data Splitting 
[ ] Split into train/test/valid

### Normalize, scale and augmentation (after split to avoid data leakage)
