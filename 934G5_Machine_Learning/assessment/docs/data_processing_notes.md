# Data Processing Notes - ML Coursework 2025A3

## Table of Contents
1. [Overview](#overview)
2. [Dataset Description](#dataset-description)
   - [Source](#source)
   - [Structure](#structure)
   - [Static Parameters](#static-parameters-6-common-parameters)
   - [Weather Parameters](#weather-parameters-11-parameters)
3. [Target Variable](#target-variable)
   - [Primary Label](#primary-label)
   - [Important Considerations](#important-considerations)
4. [Data Leakage Prevention](#data-leakage-prevention)
   - [Risk Areas](#risk-areas)
   - [Detection Methods](#detection-methods)
5. [Data Validation & Quality Assurance](#data-validation--quality-assurance)
   - [File Integrity Check](#file-integrity-check)
   - [Column Consistency Validation](#column-consistency-validation)
   - [Data Type and Format Validation](#data-type-and-format-validation)
   - [Range and Outlier Validation](#range-and-outlier-validation)
   - [Data Quality Metrics](#data-quality-metrics)
6. [Data Processing Strategy](#data-processing-strategy)
   - [Temporal Aggregation](#1-temporal-aggregation)
     - [Aggregation Strategy Details](#aggregation-strategy-details)
       - [Parameter-Specific Aggregation Functions](#parameter-specific-aggregation-functions)
       - [Missing Data Handling in Aggregation](#missing-data-handling-in-aggregation)
       - [Edge Case Handling](#edge-case-handling)
   - [Data Organization Approach](#2-data-organization-approach)
   - [Comprehensive Dataset Creation](#3-comprehensive-dataset-creation)
   - [Data Transformation](#4-data-transformation)
   - [Final Dataset Structure](#5-final-dataset-structure)
7. [Implementation Approach](#implementation-approach)
   - [Phase 1: Testing and Validation](#phase-1-testing-and-validation)
   - [Phase 2: Full Implementation](#phase-2-full-implementation)
8. [Preprocessing Considerations](#preprocessing-considerations)
   - [Data Quality Checks](#data-quality-checks)
   - [Data Preparation Steps](#data-preparation-steps)
9. [Summary](#summary)

---

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
Some parameters may have high correlations with the target or with each other:
- **Target Correlation**: Plant canopy surface water (`CanopInt_inst`) and Transpiration (`TVeg_tavg`) may be highly correlated with rain (`Rainf_tavg`)
- **Inter-Parameter Correlation**: Some weather parameters may be functionally dependent (e.g., temperature and humidity relationships)
- **Temporal Correlation**: Parameters measured at similar times may show artificial correlations
- **Spatial Correlation**: Nearby geographic locations may have highly similar patterns

### Early Detection Strategies (Raw Data Analysis)

#### 1. Statistical Correlation Analysis
**Purpose**: Identify highly correlated parameters before processing
- **Correlation Thresholds**: 
  - High correlation: |r| > 0.8 (consider removal)
  - Medium correlation: 0.5 < |r| < 0.8 (investigate further)
  - Low correlation: |r| < 0.5 (likely safe)
- **Implementation**: Calculate correlation matrix across all parameters using sample data
- **Sample Strategy**: Use 1-2 months of data initially to reduce computation time

#### 2. Feature Redundancy Detection
**Purpose**: Identify parameters that provide similar information
- **Variance Analysis**: Check if parameters have very low variance (near-constant values)
- **Mutual Information**: Measure non-linear dependencies between parameters
- **Principal Component Analysis (PCA)**: Identify parameters that contribute little to overall variance
- **Decision**: Remove parameters contributing < 5% to total variance

#### 3. Domain-Specific Validation
**Purpose**: Use meteorological knowledge to identify problematic relationships
- **Physical Dependencies**: 
  - Temperature and humidity often have inverse relationships
  - Pressure and wind speed may be functionally related
  - Snow depth and temperature show seasonal dependencies
- **Temporal Dependencies**: Parameters measured at 3-hourly intervals may show autocorrelation
- **Spatial Dependencies**: Parameters may be interpolated from sparse measurements

### Pre-Processing Parameter Selection

#### Parameters to Investigate First
1. **`CanopInt_inst` vs `Rainf_tavg`**: Plant canopy water vs. rain (likely high correlation)
2. **`TVeg_tavg` vs `Rainf_tavg`**: Transpiration vs. rain (likely high correlation)
3. **`Tair_f_inst` vs `AvgSurfT_inst`**: Air temperature vs. surface temperature (likely high correlation)
4. **`Qair_f_inst` vs `Rainf_tavg`**: Humidity vs. rain (moderate correlation expected)

#### Parameters Likely Safe
1. **`Wind_f_inst`**: Wind speed (independent of rain, valuable predictor)
2. **`Psurf_f_inst`**: Surface pressure (atmospheric pressure patterns, valuable predictor)
3. **`SnowDepth_inst`**: Snow depth (seasonal, independent of rain, valuable predictor)

### Implementation Approach

#### Phase 1: Quick Assessment (2-4 hours)
- **Sample Data**: Use 1 month of data from 2-3 parameters
- **Correlation Matrix**: Calculate pairwise correlations
- **Variance Check**: Identify low-variance parameters
- **Initial Decisions**: Make preliminary parameter inclusion/exclusion decisions

#### Phase 2: Detailed Analysis (4-8 hours)
- **Full Correlation Analysis**: Use 3-6 months of data
- **Mutual Information**: Calculate non-linear dependencies
- **PCA Analysis**: Identify variance contributions
- **Final Parameter Set**: Determine final 6-8 parameters for modeling

#### Phase 3: Validation (2-4 hours)
- **Cross-Validation**: Test parameter set on held-out data
- **Performance Metrics**: Compare model performance with different parameter combinations
- **Documentation**: Record decisions and reasoning for reproducibility

#### Total Timeline: 1-2 days (8-16 hours total)
**Why This Timeline is Realistic:**
- **Correlation calculations** are computationally fast with pandas/numpy
- **Sample data** provides 90% of insights needed
- **Automated scripts** can run analyses efficiently
- **Modern hardware** handles this scale easily
- **Parallel processing** can speed up multiple parameter combinations

#### Detailed Time Breakdown:
- **Data loading**: 30 minutes
- **Correlation analysis**: 1-2 hours
- **PCA/Mutual Information**: 2-3 hours
- **Decision making**: 1 hour
- **Validation**: 2-3 hours
- **Documentation**: 1 hour

### Expected Outcomes

#### Parameters Likely to be Removed
- **`CanopInt_inst`**: High correlation with rain target
- **`TVeg_tavg`**: High correlation with rain target
- **`AvgSurfT_inst`**: High correlation with `Tair_f_inst`

#### Parameters Likely to be Kept
- **`Rainf_tavg`**: Target variable
- **`Tair_f_inst`**: Air temperature (independent predictor)
- **`Psurf_f_inst`**: Surface pressure (independent predictor)
- **`Wind_f_inst`**: Wind speed (independent predictor)
- **`Qair_f_inst`**: Humidity (moderate correlation, valuable predictor)
- **`SnowDepth_inst`**: Snow depth (seasonal predictor)
- **`LWdown_f_tavg`**: Longwave radiation (independent predictor)
- **`SWdown_f_tavg`**: Shortwave radiation (independent predictor)

### Benefits of Early Parameter Selection
- **Reduced Processing Time**: 30-40% fewer parameters to process
- **Lower Memory Usage**: Smaller datasets for aggregation and transformation
- **Faster Model Training**: Reduced feature dimensionality
- **Better Generalization**: Avoid overfitting from correlated features
- **Clearer Interpretability**: Focus on truly independent predictors

## Data Validation & Quality Assurance

### File Integrity Check
Before processing, verify the integrity of all data files:
- **File Readability**: Ensure all 132 CSV files are readable and accessible
- **Structure Consistency**: Validate consistent structure across all files
- **File Completeness**: Check file sizes and verify no files are corrupted or incomplete
- **Naming Convention**: Verify consistent file naming pattern across all parameters and months

### Column Consistency Validation
Ensure data structure consistency across all files:
- **Column Names**: Verify all files have identical column names and order
- **Static Parameters**: Confirm longitude, latitude, year, month, day, hour are identical across files
- **Parameter Columns**: Check for any missing or extra columns in parameter data
- **Data Types**: Ensure consistent data types for each column across all files

### Data Type and Format Validation
Validate the quality and format of data values:
- **Numeric Validation**: Confirm numeric columns contain valid numbers (no text or special characters)
- **Date/Time Format**: Validate consistent date/time format across all files
- **Missing Values**: Identify and document patterns in missing data
- **Data Encoding**: Check for any encoding issues that might corrupt special characters

### Range and Outlier Validation
Verify data values fall within physically plausible ranges:
- **Parameter Ranges**: Document expected value ranges for each weather parameter
- **Outlier Detection**: Flag extreme values that may indicate data errors
- **Physical Constraints**: Validate values against known physical limits (e.g., temperatures, pressures)
- **Statistical Validation**: Use statistical methods to identify anomalous data points

### Data Quality Metrics
Establish baseline quality metrics for the dataset:
- **Completeness**: Percentage of non-null values for each parameter
- **Consistency**: Variance in data patterns across time and location
- **Accuracy**: Cross-reference with known weather patterns and seasonal variations
- **Timeliness**: Verify data freshness and temporal consistency

## Data Processing Strategy

### 1. Temporal Aggregation
- **Current Granularity**: 3-hourly data
- **Target Granularity**: Daily (preferred)
- **Method**: Aggregation using sum or average (decision needed)
- **Benefit**: Reduces unnecessary granularity

#### Aggregation Strategy Details

##### Parameter-Specific Aggregation Functions
**TODO: DECIDE** - Need to determine aggregation method for each parameter:

**Parameters that should use SUM (accumulation over time):**
- **`Rainf_tavg`** (Rain precipitation rate) - Rain accumulates over time
- **`SnowDepth_inst`** (Snow depth) - Snow accumulation over time  
- **`CanopInt_inst`** (Plant canopy water) - Water accumulation over time

**Parameters that should use AVERAGE (representative daily value):**
- **`Tair_f_inst`** (Air temperature) - Daily average temperature
- **`AvgSurfT_inst`** (Surface temperature) - Daily average surface temperature
- **`Psurf_f_inst`** (Surface pressure) - Daily average pressure
- **`Qair_f_inst`** (Specific humidity) - Daily average humidity
- **`Wind_f_inst`** (Wind speed) - Daily average wind speed

**Parameters that need DECISION (could be either):**
- **`LWdown_f_tavg`** (Longwave radiation) - **TODO: DECIDE** daily total vs. daily average
- **`SWdown_f_tavg`** (Shortwave radiation) - **TODO: DECIDE** daily total vs. daily average
- **`TVeg_tavg`** (Transpiration) - **TODO: DECIDE** daily total vs. daily average

##### Missing Data Handling in Aggregation
**TODO: DECIDE** - Strategy for 3-hourly gaps when creating daily values:

**Data Completeness Thresholds:**
- **Complete day**: 8/8 possible 3-hourly readings available
- **Partial day**: 6-7/8 readings available (acceptable for processing)
- **Incomplete day**: <6/8 readings available (consider excluding or flagging)

**Gap Handling Strategies:**
- **Small gaps (1-2 missing)**: **TODO: DECIDE** linear interpolation vs. forward-fill
- **Large gaps (3+ missing)**: **TODO: DECIDE** forward-fill vs. backward-fill vs. exclude day
- **Quality flagging**: **TODO: DECIDE** how to mark days with missing data

##### Edge Case Handling

**Dataset Start and End Dates:**
- **March 1st, 2024 (start)**: **TODO: DECIDE** how to handle potentially incomplete first day
- **February 28th, 2025 (end)**: **TODO: DECIDE** how to handle potentially incomplete last day
- **Data continuity**: 3-hourly readings flow continuously across month boundaries (no gaps)

**Special Date Considerations:**
- **Leap year**: February 29th, 2024 is a normal day with 8 readings (no special handling needed)
- **Month boundaries**: Data flows seamlessly between months (e.g., Feb 28 → Mar 1)

**Data Quality Flags:**
- **Complete day**: 8/8 readings available
- **Partial day**: 6-7/8 readings available  
- **Incomplete day**: <6/8 readings available
- **Interpolated day**: Contains interpolated values
- **Excluded day**: Too many missing readings to process

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
