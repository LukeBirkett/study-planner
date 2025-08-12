# Data Processing Notes - ML Coursework 2025A3

## Overview
The task is to predict rain or no rain in 7 days time given data up to a specific date.

## Dataset Description

### Source
The ML Coursework 2025A3 dataset was created for the A3 assessment of the 2025 Machine Learning module. It contains data extracted from the NASA database.

### Structure
- **Total Files**: 132 CSV files
- **Coverage**: March 2024 to February 2025 (12 months)
- **Parameters**: 11 weather parameters
- **Calculation**: 12 months × 11 parameters = 132 files

### Static Parameters (6 common parameters)
Each file contains these 6 static parameters in `var_name/Full Name/Unit/Resolution` format:

| Parameter | Full Name | Unit | Resolution |
|-----------|-----------|------|------------|
| `longitude` | Longitude | Degrees East | 1.0 degree |
| `latitude` | Latitude | Degrees North | 1.0 degree |
| `year` | Year | 1 | 1 year |
| `month` | Month in year | 1 | 1 month |
| `day` | Day in the month | 1 | 1 day |
| `hour` | Hour in the day | 1 | 3 hours |

**Note**: Months 1, 2, 3 always correspond to Jan, Feb, March

### Weather Parameters (11 parameters)
The following parameters are available in `var_name/Full Name/Unit/Resolution` format:

| Parameter | Full Name | Unit | Resolution |
|-----------|-----------|------|------------|
| `AvgSurfT_inst` | Average surface skin temperature | Kelvin | per longitude and latitude pair every three hours |
| `CanopInt_inst` | Plant canopy surface water | Kilogram per metre | per longitude and latitude pair every three hours |
| `LWdown_f_tavg` | Downward longwave radiation flux | Watt per metre | per longitude and latitude pair every three hours |
| `Psurf_f_inst` | Surface pressure | Pascal | per longitude and latitude pair every three hours |
| `Qair_f_inst` | Specific humidity | Kilogram per kilogram | per longitude and latitude pair every three hours |
| `Rainf_tavg` | Rain precipitation rate | Kilogram per squared metre per second | per longitude and latitude pair every three hours |
| `SnowDepth_inst` | Snow depth | Metre | per longitude and latitude pair every three hours |
| `SWdown_f_tavg` | Downward shortwave radiation flux | Watt per squared metre | per longitude and latitude pair every three hours |
| `Tair_f_inst` | Air temperature | Kelvin | per longitude and latitude pair every three hours |
| `TVeg_tavg` | Transpiration | Watt per squared metre | per longitude and latitude pair every three hours |
| `Wind_f_inst` | Wind speed | Metre per second | per longitude and latitude pair every three hours |

## Target Variable

### Primary Label
- **Field**: `Rainf_tavg` (Rain precipitation rate)
- **Remaining Parameters**: 10 (after excluding the target)

### Important Considerations
The target field needs to be well understood for proper utilization:
- May need conversion to categorical or one-hot encoded variables
- Data comes at very granular basis (3-hourly) and needs aggregation to suitable level
- Requires careful handling to avoid data leakage

## Data Leakage Prevention

### Risk Areas
Some parameters may have high correlations with the target:
- Plant canopy surface water (`CanopInt_inst`) and Transpiration (`TVeg_tavg`) may be copies of label data
- This can lead to overfitting and poor generalization

### Detection Methods
1. **Domain Knowledge**: Understanding of weather/climate relationships
2. **Visualization**: Graphical analysis of parameter relationships
3. **Statistical Correlations**: Quantitative correlation analysis
4. **Hypothesis Creation**: Testing assumptions about parameter independence

## Data Processing Strategy

### 1. Temporal Aggregation
- **Current Granularity**: 3-hourly data
- **Target Granularity**: Daily (preferred)
- **Method**: Aggregation using sum or average (decision needed)
- **Benefit**: Reduces unnecessary granularity

### 2. Data Organization Approach
- **Current State**: Separate CSV files per parameter
- **Solution**: Create a base table with all desired date/location combinations
- **Benefits**:
  - Easier to identify missing data (null values from failed joins)
  - Enables index application for train/test/validation splits
  - Facilitates batch processing

### 3. Comprehensive Dataset Creation
Create a tabular dataset starting with the base table and joining all parameter data:

**Example Structure**:
- **Row**: longitude-latitude 10:10 for date 2024-01-01
- **Columns**: 
  - Leftmost: value for 2024-01-01
  - Right columns: subsequent days (N columns, where N is to be determined)
  - **Total Columns**: (N × Number of Parameters) + static parameters

### 4. Data Transformation

#### Transformation 1: Static Data Separation
- Slice off static parameter columns
- Retain as standalone dataset with preserved order
- **Result**: 2D static dataset

#### Transformation 2: Time-Series Restructuring
- Stack remaining dataset per parameter
- **Input**: 2D tabular dataset (Instances × Parameter Columns)
- **Output**: 3D dataset (Instances × N Time Series Joins × Parameters)
- **Purpose**: Compatible with CNN and RNN input formats

### 5. Final Dataset Structure
Three coordinated datasets:
1. **2D Static Dataset**: Static parameters (longitude, latitude, year, month, day, hour)
2. **3D Time-Series Dataset**: Temporal parameter data
3. **1D Rain Labels**: Target variable vector

**Important**: All three datasets maintain the same order for batch/instance access.

## Implementation Approach

### Phase 1: Testing and Validation
- **Scope**: Reduced location/data sample
- **Parameters**: 1-2 parameters initially
- **Time Series**: Lower N value
- **Purpose**: Code inspection and process testing

### Phase 2: Full Implementation
- **Method**: Batch processing capability
- **Reason**: Total data volume is vast
- **Benefit**: Avoids memory issues and improves performance

## Preprocessing Considerations

### Data Quality Checks
- **NULL Values**: Identify and handle missing data
- **Broken Values**: Detect and correct corrupted data
- **Timing**: Perform after train/test/validation split to avoid data leakage

### Data Preparation Steps
- **Normalization**: Scale data appropriately
- **Scaling**: Ensure consistent value ranges
- **Augmentation**: Enhance training data if needed

**Note**: These preprocessing steps should NOT be performed until after data splitting to prevent data leakage.

## Summary

This document focuses on restructuring raw data into the correct format for machine learning models. The process involves:
1. Creating a comprehensive base table
2. Joining parameter data with time-series structure
3. Separating static and temporal data
4. Transforming to 3D format for deep learning models
5. Ensuring proper data organization for batch processing

The approach prioritizes data integrity, prevents leakage, and creates a structure suitable for CNN/RNN architectures while maintaining scalability for large datasets.
