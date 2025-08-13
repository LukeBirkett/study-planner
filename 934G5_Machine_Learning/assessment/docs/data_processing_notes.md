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
   - [Geographic Coverage & Resolution Validation](#geographic-coverage--resolution-validation)
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
7. [Data Split Strategy](#data-split-strategy)
   - [Split Strategy Design](#split-strategy-design)
   - [ID System Implementation](#id-system-implementation)
   - [Split Assignment](#split-assignment)
   - [Chunking and Batching Strategy](#chunking-and-batching-strategy)
   - [Limitations and Constraints](#limitations-and-constraints)
8. [Implementation Approach](#implementation-approach)
   - [Phase 1: Testing and Validation](#phase-1-testing-and-validation)
   - [Phase 2: Full Implementation](#phase-2-full-implementation)
9. [Memory & Performance Optimization](#memory--performance-optimization)
   - [Chunk Size Optimization](#chunk-size-optimization)
   - [Data Type Optimization](#data-type-optimization)
   - [Parallel Processing Opportunities](#parallel-processing-opportunities)
10. [Error Handling & Logging](#error-handling--logging)
   - [Processing Error Handling](#processing-error-handling)
   - [Progress Tracking](#progress-tracking)
   - [Data Lineage Tracking](#data-lineage-tracking)
11. [Preprocessing Considerations](#preprocessing-considerations)
   - [Data Quality Checks](#data-quality-checks)
   - [Data Preparation Steps](#data-preparation-steps)
12. [Summary](#summary)

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
- **Geographic Coordinates**: Verify longitude (-180° to +180°) and latitude (-90° to +90°) values are within valid ranges
- **Statistical Validation**: Use statistical methods to identify anomalous data points

### Geographic Coverage & Resolution Validation

#### Purpose
Validate that the NASA dataset provides complete and consistent geographic coverage as expected, ensuring no spatial gaps that could affect model performance.

#### Validation Strategy
- **Grid Coverage Completeness**: Verify all expected longitude/latitude combinations are present
- **Spatial Resolution Consistency**: Confirm 1.0 degree resolution is maintained across all files
- **Geographic Range Validation**: Ensure coordinate ranges are physically reasonable
- **Sample-Based Verification**: Use representative files to validate spatial coverage

#### Implementation Example
```python
import pandas as pd
import numpy as np
from pathlib import Path

def validate_geographic_coverage(csv_directory, sample_size=5):
    """
    Validate geographic coverage and resolution of the NASA dataset
    
    Parameters:
    - csv_directory: Path to directory containing CSV files
    - sample_size: Number of files to sample for validation
    
    Returns:
    - Dictionary with validation results
    """
    
    csv_files = list(Path(csv_directory).glob("*.csv"))
    
    if len(csv_files) == 0:
        return {"error": "No CSV files found"}
    
    # Sample files for validation (don't need to check all 132 files)
    sample_files = np.random.choice(csv_files, 
                                   size=min(sample_size, len(csv_files)), 
                                   replace=False)
    
    validation_results = {
        "files_checked": len(sample_files),
        "coordinate_ranges": {},
        "resolution_validation": {},
        "coverage_completeness": {},
        "issues_found": []
    }
    
    all_longitudes = set()
    all_latitudes = set()
    
    for file_path in sample_files:
        try:
            df = pd.read_csv(file_path)
            
            # Extract unique coordinates
            file_lons = df['longitude'].unique()
            file_lats = df['latitude'].unique()
            
            all_longitudes.update(file_lons)
            all_latitudes.update(file_lats)
            
            # Check coordinate ranges for this file
            lon_range = (df['longitude'].min(), df['longitude'].max())
            lat_range = (df['latitude'].min(), df['latitude'].max())
            
            validation_results["coordinate_ranges"][file_path.name] = {
                "longitude_range": lon_range,
                "latitude_range": lat_range
            }
            
            # Validate coordinate ranges are physically reasonable
            if not (-180 <= lon_range[0] <= lon_range[1] <= 180):
                validation_results["issues_found"].append(
                    f"Invalid longitude range in {file_path.name}: {lon_range}"
                )
            
            if not (-90 <= lat_range[0] <= lat_range[1] <= 90):
                validation_results["issues_found"].append(
                    f"Invalid latitude range in {file_path.name}: {lat_range}"
                )
            
            # Check spatial resolution (should be 1.0 degree)
            lon_diff = np.diff(sorted(file_lons))
            lat_diff = np.diff(sorted(file_lats))
            
            expected_resolution = 1.0
            lon_resolution_ok = np.allclose(lon_diff, expected_resolution, atol=0.01)
            lat_resolution_ok = np.allclose(lat_diff, expected_resolution, atol=0.01)
            
            validation_results["resolution_validation"][file_path.name] = {
                "longitude_resolution_ok": lon_resolution_ok,
                "latitude_resolution_ok": lat_resolution_ok,
                "actual_lon_diff": lon_diff.tolist() if len(lon_diff) > 0 else [],
                "actual_lat_diff": lat_diff.tolist() if len(lat_diff) > 0 else []
            }
            
            if not lon_resolution_ok:
                validation_results["issues_found"].append(
                    f"Inconsistent longitude resolution in {file_path.name}"
                )
            
            if not lat_resolution_ok:
                validation_results["issues_found"].append(
                    f"Inconsistent latitude resolution in {file_path.name}"
                )
                
        except Exception as e:
            validation_results["issues_found"].append(
                f"Error reading {file_path.name}: {str(e)}"
            )
    
    # Overall coverage validation
    if all_longitudes and all_latitudes:
        validation_results["coverage_completeness"] = {
            "total_unique_longitudes": len(all_longitudes),
            "total_unique_latitudes": len(all_latitudes),
            "longitude_range": (min(all_longitudes), max(all_longitudes)),
            "latitude_range": (min(all_latitudes), max(all_latitudes)),
            "expected_grid_size": len(all_longitudes) * len(all_latitudes)
        }
    
    return validation_results

def print_validation_summary(results):
    """Print a human-readable summary of validation results"""
    
    print("🌍 Geographic Coverage & Resolution Validation Results")
    print("=" * 60)
    
    print(f"📁 Files checked: {results['files_checked']}")
    
    if results['coverage_completeness']:
        coverage = results['coverage_completeness']
        print(f"🗺️  Geographic coverage:")
        print(f"   - Longitude range: {coverage['longitude_range']}")
        print(f"   - Latitude range: {coverage['latitude_range']}")
        print(f"   - Unique longitudes: {coverage['total_unique_longitudes']}")
        print(f"   - Unique latitudes: {coverage['total_unique_latitudes']}")
        print(f"   - Expected grid size: {coverage['expected_grid_size']} locations")
    
    print(f"\n🔍 Resolution validation:")
    resolution_issues = sum(1 for file_results in results['resolution_validation'].values() 
                           if not file_results['longitude_resolution_ok'] or 
                              not file_results['latitude_resolution_ok'])
    print(f"   - Files with resolution issues: {resolution_issues}")
    
    print(f"\n⚠️  Issues found: {len(results['issues_found'])}")
    if results['issues_found']:
        for issue in results['issues_found']:
            print(f"   - {issue}")
    else:
        print("   ✅ No geographic coverage issues detected!")
    
    print("=" * 60)

# Usage example
if __name__ == "__main__":
    # Validate geographic coverage
    results = validate_geographic_coverage("data/raw", sample_size=5)
    print_validation_summary(results)
```

#### Expected Outcomes
- **Complete Coverage**: All expected longitude/latitude combinations should be present
- **Consistent Resolution**: 1.0 degree spacing maintained across all files
- **Valid Ranges**: Longitude (-180° to +180°), Latitude (-90° to +90°)
- **No Spatial Gaps**: Continuous coverage across the specified geographic area

#### Benefits for University Project
- **Data Quality Assurance**: Validates assumptions about NASA dataset completeness
- **Early Problem Detection**: Identifies any geographic coverage issues before processing
- **Professional Validation**: Shows thorough approach to data quality assessment
- **Model Performance**: Ensures spatial coverage won't affect rain prediction accuracy

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

## Data Split Strategy

**Purpose**: Design and implement train/test/validation splits before data processing to prevent data leakage and enable efficient ML pipeline development.

### Split Strategy Design

#### Split Type Decision
**DECIDED** - Interleaved Monthly Split Strategy for Limited Temporal Data:

**Selected Approach: Interleaved Monthly Split**
- **Training**: March 2024 - December 2024 (10 months)
- **Testing**: January 2025 (1 month)
- **Validation**: February 2025 (1 month)
- **Rationale**: Ensures all seasons are represented in training data while maintaining temporal order

**Alternative Approaches Considered:**
- **Strict Temporal Split**: Would exclude winter months from training, causing poor seasonal generalization
- **Location-Based Split**: Not suitable for weather prediction due to spatial correlations
- **Hybrid Split**: Overly complex for 12-month dataset
- **Cross-Validation**: Maximum data usage but complex implementation

**Why Interleaved Monthly is Optimal:**
1. **Seasonal Coverage**: Training includes spring, summer, autumn, and early winter
2. **Temporal Integrity**: No future data leakage (validation month comes after training)
3. **Simple Implementation**: Straightforward month-based assignment
4. **Balanced Splits**: 10/1/1 ratio provides sufficient training data

#### Split Ratios
**DECIDED** - Interleaved Monthly Split Ratios:
- **Training**: 83.3% of data (10 months: March-December 2024)
- **Testing**: 8.3% of data (1 month: January 2025)
- **Validation**: 8.3% of data (1 month: February 2025)

**Rationale for 83.3/8.3/8.3 Split:**
- **Limited temporal data**: 12 months total constrains split flexibility
- **Seasonal representation**: Training needs sufficient months to cover all seasons
- **Validation needs**: February validation provides final model assessment
- **Testing balance**: January testing gives intermediate performance check

#### Temporal Boundary Considerations
**Critical for Rain Prediction Task**:
- **7-day prediction requirement**: Training data must not include future information
- **Seasonal patterns**: **RESOLVED** - Interleaved monthly split ensures all seasons represented in training
- **Data continuity**: **RESOLVED** - No overlapping time windows needed; clear month-based boundaries
- **Temporal integrity**: Training ends December 2024, testing January 2025, validation February 2025

### ID System Implementation

#### Location-Date Identifier Creation
**Core Concept**: Use longitude + latitude + date as natural identifiers for efficient data organization.

```python
def create_location_date_ids(df):
    """
    Create unique identifiers for each location-date combination
    
    Parameters:
    - df: DataFrame with longitude, latitude, year, month, day columns
    
    Returns:
    - DataFrame with additional 'location_date_id' column
    """
    # Create location identifier (longitude_latitude)
    df['location_id'] = df['longitude'].astype(str) + '_' + df['latitude'].astype(str)
    
    # Create date identifier (year_month_day)
    df['date_id'] = df['year'].astype(str) + '_' + df['month'].astype(str).str.zfill(2) + '_' + df['day'].astype(str).str.zfill(2)
    
    # Combine for unique location-date identifier
    df['location_date_id'] = df['location_id'] + '_' + df['date_id']
    
    return df

def get_unique_identifiers(csv_directory):
    """
    Extract all unique location-date combinations from raw data
    
    Returns:
    - List of all possible location-date IDs
    - Dictionary mapping IDs to actual values
    """
    all_ids = set()
    id_mapping = {}
    
    # Sample a few files to get all unique combinations
    sample_files = get_sample_files(csv_directory, sample_size=3)
    
    for file_path in sample_files:
        df = pd.read_csv(file_path)
        df_with_ids = create_location_date_ids(df)
        
        for _, row in df_with_ids.iterrows():
            location_date_id = row['location_date_id']
            all_ids.add(location_date_id)
            
            if location_date_id not in id_mapping:
                id_mapping[location_date_id] = {
                    'longitude': row['longitude'],
                    'latitude': row['latitude'],
                    'year': row['year'],
                    'month': row['month'],
                    'day': row['day']
                }
    
    return list(all_ids), id_mapping
```

#### ID System Benefits
- **Efficient indexing**: O(1) lookup for any location-date combination
- **Memory efficient**: Store only unique combinations, not repeated data
- **Split management**: Assign split labels to IDs, not to data
- **Batch processing**: Use ID arrays for efficient data loading

### Split Assignment

#### Split Label Assignment
**Strategy**: Assign split labels to location-date IDs before any data processing.

```python
def assign_splits(location_date_ids, split_strategy='time_based', split_ratios=(0.7, 0.15, 0.15)):
    """
    Assign train/test/validation labels to location-date IDs
    
    Parameters:
    - location_date_ids: List of all location-date IDs
    - split_strategy: 'time_based', 'location_based', or 'hybrid'
    - split_ratios: Tuple of (train_ratio, test_ratio, validation_ratio)
    
    Returns:
    - Dictionary mapping IDs to split labels
    """
    
    if split_strategy == 'time_based':
        return assign_time_based_splits(location_date_ids, split_ratios)
    elif split_strategy == 'location_based':
        return assign_location_based_splits(location_date_ids, split_ratios)
    elif split_strategy == 'hybrid':
        return assign_hybrid_splits(location_date_ids, split_ratios)
    else:
        raise ValueError(f"Unknown split strategy: {split_strategy}")

def assign_interleaved_monthly_splits(location_date_ids):
    """
    Assign splits using interleaved monthly approach for limited temporal data
    
    Training: March-December 2024 (10 months)
    Testing: January 2025 (1 month)
    Validation: February 2025 (1 month)
    """
    
    split_assignments = {}
    
    for id_str in location_date_ids:
        # Extract year and month from ID
        year, month = extract_year_month_from_id(id_str)
        
        if year == 2024:
            # All 2024 data goes to training (March-December)
            split_assignments[id_str] = 'train'
        elif year == 2025:
            if month == 1:
                # January 2025 goes to testing
                split_assignments[id_str] = 'test'
            elif month == 2:
                # February 2025 goes to validation
                split_assignments[id_str] = 'validation'
            else:
                # Any other 2025 months (shouldn't exist in our dataset)
                split_assignments[id_str] = 'train'  # Default fallback
    
    return split_assignments

def assign_time_based_splits(location_date_ids, split_ratios):
    """Assign splits based on time periods (alternative approach)"""
    
    # Extract dates from IDs and sort chronologically
    date_ids = [extract_date_from_id(id_str) for id_str in location_date_ids]
    sorted_dates = sorted(set(date_ids))
    
    # Calculate split boundaries
    total_dates = len(sorted_dates)
    train_end = int(total_dates * split_ratios[0])
    test_end = train_end + int(total_dates * split_ratios[1])
    
    # Assign splits
    split_assignments = {}
    for id_str in location_date_ids:
        date_part = extract_date_from_id(id_str)
        date_index = sorted_dates.index(date_part)
        
        if date_index < train_end:
            split_assignments[id_str] = 'train'
        elif date_index < test_end:
            split_assignments[id_str] = 'test'
        else:
            split_assignments[id_str] = 'validation'
    
    return split_assignments

def extract_date_from_id(location_date_id):
    """Extract date part from location_date_id"""
    # Format: longitude_latitude_year_month_day
    parts = location_date_id.split('_')
    if len(parts) >= 6:  # longitude_latitude_year_month_day
        return f"{parts[2]}_{parts[3]}_{parts[4]}"  # year_month_day
    return None

def extract_year_month_from_id(location_date_id):
    """Extract year and month from location_date_id"""
    # Format: longitude_latitude_year_month_day
    parts = location_date_id.split('_')
    if len(parts) >= 5:  # longitude_latitude_year_month_day
        try:
            year = int(parts[2])
            month = int(parts[3])
            return year, month
        except ValueError:
            return None, None
    return None, None
```

#### Split Validation
**Critical Checks**:
- **No overlap**: Ensure no location-date combination appears in multiple splits
- **Temporal integrity**: **TODO: DECIDE** how to handle edge cases at split boundaries
- **Geographic coverage**: **TODO: DECIDE** if all locations should appear in all splits

### Chunking and Batching Strategy

#### Split-Aware Chunking
**Principle**: Chunk boundaries must respect split boundaries to prevent data leakage.

```python
def create_split_aware_chunks(split_assignments, chunk_size=1000):
    """
    Create chunks that respect split boundaries
    
    Parameters:
    - split_assignments: Dictionary mapping IDs to split labels
    - chunk_size: Number of IDs per chunk
    
    Returns:
    - Dictionary with split-specific chunk lists
    """
    
    # Group IDs by split
    train_ids = [id_str for id_str, split in split_assignments.items() if split == 'train']
    test_ids = [id_str for id_str, split in split_assignments.items() if split == 'test']
    validation_ids = [id_str for id_str, split in split_assignments.items() if split == 'validation']
    
    # Create chunks for each split
    chunks = {
        'train': [train_ids[i:i+chunk_size] for i in range(0, len(train_ids), chunk_size)],
        'test': [test_ids[i:i+chunk_size] for i in range(0, len(test_ids), chunk_size)],
        'validation': [validation_ids[i:i+chunk_size] for i in range(0, len(validation_ids), chunk_size)]
    }
    
    return chunks

def process_batch_by_ids(batch_ids, id_mapping, csv_directory):
    """
    Process a batch of location-date IDs efficiently
    
    Parameters:
    - batch_ids: List of location-date IDs to process
    - id_mapping: Dictionary mapping IDs to actual values
    - csv_directory: Path to raw CSV files
    
    Returns:
    - Processed data for the batch
    """
    
    batch_data = []
    
    for location_date_id in batch_ids:
        # Extract location and date from ID
        location_info = id_mapping[location_date_id]
        
        # Load and process data for this specific location-date
        data = load_location_date_data(location_info, csv_directory)
        if data is not None:
            batch_data.append(data)
    
    return batch_data

def load_location_date_data(location_info, csv_directory):
    """
    Load data for a specific location and date from all parameter files
    
    Parameters:
    - location_info: Dictionary with longitude, latitude, year, month, day
    - csv_directory: Path to raw CSV files
    
    Returns:
    - Dictionary with all parameter values for the location-date
    """
    
    # **TODO: IMPLEMENT** - Load data from all 11 parameter files
    # This function needs to be implemented based on your file naming convention
    
    location_data = {
        'longitude': location_info['longitude'],
        'latitude': location_info['latitude'],
        'year': location_info['year'],
        'month': location_info['month'],
        'day': location_info['day'],
        'parameters': {}
    }
    
    # Load each parameter file and extract the specific location-date
    parameter_files = get_parameter_files(csv_directory)
    
    for param_file in parameter_files:
        try:
            df = pd.read_csv(param_file)
            
            # Filter for specific location and date
            mask = (
                (df['longitude'] == location_info['longitude']) &
                (df['latitude'] == location_info['latitude']) &
                (df['year'] == location_info['year']) &
                (df['month'] == location_info['month']) &
                (df['day'] == location_info['day'])
            )
            
            if mask.any():
                param_name = extract_parameter_name(param_file)
                location_data['parameters'][param_name] = df[mask]['value'].values
                
        except Exception as e:
            print(f"Error loading {param_file}: {e}")
            continue
    
    return location_data
```

#### Batching Benefits
- **Memory efficient**: Process only needed data, not entire files
- **Split integrity**: No risk of data leakage across splits
- **Scalable**: Easy to adjust batch sizes based on available memory
- **Parallelizable**: Different batches can be processed simultaneously

#### Implementation Considerations
**TODO: DECIDE** - Key implementation questions:
1. **Batch size**: How many location-date combinations per batch? (Recommend: 100-1000)
2. **Chunk boundaries**: Should chunks align with natural time periods (months, weeks)?
3. **Memory management**: How to handle batches that exceed memory limits?
4. **Error handling**: What to do if a batch fails to process?

### Limitations and Constraints

**Important**: This section documents the limitations of our approach for inclusion in the final report.

#### Dataset Size Constraints

**Temporal Data Limitations:**
- **Total dataset**: Only 12 months of data (March 2024 - February 2025)
- **Seasonal coverage**: Limited representation of annual weather cycles
- **Split flexibility**: Constrained by small temporal dataset size
- **Validation robustness**: Limited ability to test across multiple years

**Impact on Model Performance:**
- **Seasonal generalization**: Model may struggle with unseen seasonal patterns
- **Long-term trends**: Cannot capture multi-year weather variations
- **Rare events**: Limited exposure to extreme weather conditions
- **Climate patterns**: Insufficient data for climate change analysis

#### Split Strategy Limitations

**Interleaved Monthly Split Constraints:**
- **Training data**: 10 months (March-December 2024) - may not capture full seasonal range
- **Testing data**: 1 month (January 2025) - limited evaluation of winter performance
- **Validation data**: 1 month (February 2025) - final assessment on single month
- **Split imbalance**: 83.3/8.3/8.3 ratio deviates from standard ML practices

**Seasonal Generalization Concerns:**
- **Winter training**: Limited winter data in training set (only December)
- **Spring training**: Good coverage of spring months (March-May)
- **Summer training**: Good coverage of summer months (June-August)
- **Autumn training**: Good coverage of autumn months (September-November)

#### Geographic Coverage Limitations

**Spatial Resolution Constraints:**
- **Grid resolution**: 1.0 degree spacing may miss local weather patterns
- **Geographic scope**: Limited to NASA dataset coverage area
- **Local variations**: May not capture microclimate effects
- **Urban vs. rural**: No distinction between different land use types

#### Data Quality Limitations

**Parameter Coverage:**
- **Weather parameters**: 11 parameters may not capture all relevant factors
- **Missing variables**: No direct measurements of cloud cover, atmospheric pressure gradients
- **Temporal resolution**: 3-hourly data may miss short-term weather events
- **Interpolation effects**: Aggregation to daily values may smooth important variations

#### Model Architecture Limitations

**Deep Learning Constraints:**
- **Data requirements**: Limited data may lead to overfitting
- **Architecture complexity**: Complex models may not generalize well
- **Feature engineering**: Limited temporal data constrains feature creation
- **Regularization**: Heavy regularization needed to prevent overfitting

#### Mitigation Strategies

**Data Augmentation Approaches:**
- **Synthetic data**: Generate additional training samples using domain knowledge
- **Transfer learning**: Pre-train on larger weather datasets
- **Ensemble methods**: Combine multiple models for robustness
- **Cross-validation**: Use k-fold validation within training set

**Model Design Considerations:**
- **Simpler architectures**: Start with basic models before complex ones
- **Regularization**: Heavy dropout, weight decay, early stopping
- **Feature selection**: Focus on most predictive parameters
- **Hyperparameter tuning**: Extensive tuning to prevent overfitting

**Evaluation Strategy:**
- **Multiple metrics**: Use various performance measures beyond accuracy
- **Confidence intervals**: Report uncertainty in model predictions
- **Ablation studies**: Test model components individually
- **Robustness checks**: Validate across different weather conditions

#### Report Documentation Requirements

**Must Include in Final Report:**
1. **Dataset limitations**: Clearly state 12-month constraint and its implications
2. **Split strategy rationale**: Explain why interleaved monthly was chosen
3. **Seasonal bias**: Acknowledge potential winter performance issues
4. **Generalization concerns**: Discuss limitations for real-world deployment
5. **Mitigation approaches**: Document strategies to address limitations
6. **Future improvements**: Suggest how to enhance with more data

**Expected Outcomes:**
- **Realistic expectations**: Model performance will be limited by data constraints
- **Transparent limitations**: Clear documentation of approach constraints
- **Academic rigor**: Honest assessment of methodology limitations
- **Future directions**: Clear path for improvement with additional data

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

## Memory & Performance Optimization

**Target System**: MacBook M1 Pro with 16GB RAM, macOS Sonoma 14.7.4
**Strategy**: Hybrid approach - start conservative, gradually optimize for speed while preventing crashes

### Chunk Size Optimization

#### Memory-Safe Approach for 16GB M1 Pro
- **Initial Strategy**: Start with 2-month chunks (~2-3GB memory usage)
- **Memory Target**: Keep usage under 10-12GB (leaving 4-6GB for system)
- **Progressive Optimization**: 
  - Test with 2 months → 3 months → 4 months
  - Monitor memory usage in Activity Monitor
  - Stop increasing when memory usage approaches 12GB

#### Chunk Size Recommendations
- **Conservative (Crash Prevention)**: 2 months × 11 parameters = ~2-3GB
- **Balanced (Recommended)**: 3 months × 11 parameters = ~4-5GB  
- **Aggressive (Speed Focus)**: 4 months × 11 parameters = ~6-8GB
- **Maximum Safe**: 5 months × 11 parameters = ~8-10GB

#### Implementation Details
- **Chunk by Time**: Process March-April 2024, then May-June 2024, etc.
- **Memory Monitoring**: Use `psutil` library to track memory usage in real-time
- **Fallback Strategy**: If memory pressure detected, automatically reduce chunk size

### Data Type Optimization

#### Precision vs. Memory Trade-offs
- **Float64 → Float32**: 50% memory reduction, minimal precision loss for weather data
- **Int64 → Int32**: 50% memory reduction for year/month/day/hour (sufficient range)
- **Object → Category**: For repeated strings (parameter names, units)

#### Specific Data Type Recommendations
```python
# Static Parameters (6 columns)
longitude: float32    # -180 to +180, 7 decimal places sufficient
latitude: float32     # -90 to +90, 7 decimal places sufficient  
year: int16          # 2024-2025, small range
month: int8          # 1-12, very small range
day: int8            # 1-31, very small range
hour: int8           # 0, 3, 6, 9, 12, 15, 18, 21

# Weather Parameters (11 columns)  
temperature: float32  # Kelvin values, 4 decimal places sufficient
pressure: float32    # Pascal values, 2 decimal places sufficient
humidity: float32    # 0-1 range, 6 decimal places sufficient
# ... etc for all weather parameters
```

#### Memory Savings Calculation
- **Current (Float64)**: ~8 bytes per value
- **Optimized (Float32)**: ~4 bytes per value  
- **Total Savings**: 50% reduction in memory usage
- **Impact**: Can process 2x larger chunks with same memory

### Parallel Processing Opportunities

#### M1 Pro Multi-Core Strategy
- **Available Cores**: 8-core CPU (6 performance + 2 efficiency)
- **Optimal Parallelization**: 4-6 concurrent processes
- **Memory Distribution**: Each process gets ~2-3GB RAM

#### Parallel Processing Approaches

##### Option 1: Parameter-Based Parallelization
- **Strategy**: Process different weather parameters simultaneously
- **Example**: 
  - Process 1: Temperature, Pressure, Humidity (3 parameters)
  - Process 2: Wind, Rain, Snow (3 parameters)  
  - Process 3: Radiation, Canopy, Transpiration (3 parameters)
  - Process 4: Surface temperature (1 parameter)
- **Memory per Process**: ~1-2GB
- **Speed Improvement**: 2-3x faster than sequential

##### Option 2: Time-Based Parallelization  
- **Strategy**: Process different time periods simultaneously
- **Example**:
  - Process 1: March-April 2024
  - Process 2: May-June 2024
  - Process 3: July-August 2024
  - Process 4: September-October 2024
- **Memory per Process**: ~2-3GB
- **Speed Improvement**: 2-4x faster than sequential

##### Option 3: Hybrid Approach (Recommended)
- **Strategy**: Combine parameter and time parallelization
- **Example**:
  - Process 1: Temperature data for March-June
  - Process 2: Pressure data for March-June
  - Process 3: Humidity data for March-June
  - Process 4: Wind data for March-June
- **Memory per Process**: ~1-2GB
- **Speed Improvement**: 3-4x faster than sequential

#### Implementation Tools
- **Multiprocessing**: Python's built-in `multiprocessing` library
- **Dask**: For larger-than-memory datasets
- **Memory Monitoring**: `psutil` for real-time memory tracking
- **Progress Tracking**: `tqdm` for progress bars and ETA

#### Safety Measures
- **Memory Thresholds**: Stop processing if memory usage > 12GB
- **Process Limits**: Maximum 6 concurrent processes
- **Graceful Degradation**: Fall back to sequential processing if needed
- **Error Recovery**: Restart failed processes with smaller chunks

## Error Handling & Logging

**Implementation Time**: ~2 hours total (university project scope)
**Focus**: Demonstrate understanding without over-engineering

### Processing Error Handling

#### Basic Error Handling Strategy
- **File Reading Errors**: Wrap CSV reading in try-catch blocks
- **Data Format Errors**: Validate expected structure before processing
- **Graceful Degradation**: Skip problematic files and continue processing
- **Error Logging**: Log errors to console for debugging

#### Implementation Example
```python
import pandas as pd
import logging

# Simple logging setup
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def process_csv_file(file_path):
    """Process a single CSV file with error handling"""
    try:
        # Attempt to read the file
        df = pd.read_csv(file_path)
        
        # Basic structure validation
        expected_columns = ['longitude', 'latitude', 'year', 'month', 'day', 'hour']
        if not all(col in df.columns for col in expected_columns):
            logger.warning(f"Missing expected columns in {file_path}")
            return None
            
        # Process the data
        processed_df = process_data(df)
        return processed_df
        
    except FileNotFoundError:
        logger.error(f"File not found: {file_path}")
        return None
    except pd.errors.EmptyDataError:
        logger.error(f"Empty file: {file_path}")
        return None
    except Exception as e:
        logger.error(f"Unexpected error processing {file_path}: {e}")
        return None

# Main processing loop with error handling
def process_all_files(file_list):
    """Process all files, skipping those with errors"""
    successful_files = []
    failed_files = []
    
    for file_path in file_list:
        result = process_csv_file(file_path)
        if result is not None:
            successful_files.append(file_path)
        else:
            failed_files.append(file_path)
    
    logger.info(f"Successfully processed {len(successful_files)} files")
    if failed_files:
        logger.warning(f"Failed to process {len(failed_files)} files: {failed_files}")
    
    return successful_files, failed_files
```

### Progress Tracking

#### Simple Progress Monitoring
- **File-Level Progress**: Show which file is currently being processed
- **Overall Progress**: Display completion percentage and time estimates
- **Real-Time Updates**: Use progress bars for visual feedback

#### Implementation Example
```python
from tqdm import tqdm
import time

def process_files_with_progress(file_list):
    """Process files with progress tracking"""
    start_time = time.time()
    
    # Progress bar for file processing
    with tqdm(total=len(file_list), desc="Processing CSV files") as pbar:
        for i, file_path in enumerate(file_list):
            # Update progress bar description
            pbar.set_description(f"Processing: {file_path.split('/')[-1]}")
            
            # Process the file
            start_file_time = time.time()
            result = process_csv_file(file_path)
            file_time = time.time() - start_file_time
            
            # Update progress with file info
            if result is not None:
                pbar.set_postfix({
                    'Status': '✓', 
                    'File Time': f"{file_time:.2f}s",
                    'Success Rate': f"{(i+1)/len(file_list)*100:.1f}%"
                })
            else:
                pbar.set_postfix({
                    'Status': '✗', 
                    'File Time': f"{file_time:.2f}s",
                    'Success Rate': f"{(i+1)/len(file_list)*100:.1f}%"
                })
            
            pbar.update(1)
    
    total_time = time.time() - start_time
    logger.info(f"Total processing time: {total_time:.2f} seconds")
    logger.info(f"Average time per file: {total_time/len(file_list):.2f} seconds")
```

### Data Lineage Tracking

#### Basic Data Lineage
- **Processing Log**: Record which files were processed and when
- **Transformation Tracking**: Log what processing steps were applied
- **Metadata Storage**: Save basic information for reproducibility

#### Implementation Example
```python
import json
from datetime import datetime
import os

class ProcessingLogger:
    """Simple class to track data processing lineage"""
    
    def __init__(self, log_file="processing_log.json"):
        self.log_file = log_file
        self.processing_log = {
            "timestamp": datetime.now().isoformat(),
            "input_files": [],
            "processing_steps": [],
            "output_files": [],
            "parameters": {},
            "system_info": {
                "python_version": "3.x",
                "pandas_version": pd.__version__,
                "platform": "macOS M1 Pro"
            }
        }
    
    def log_file_processed(self, file_path, status, processing_time, file_size_mb):
        """Log information about a processed file"""
        self.processing_log["input_files"].append({
            "filename": os.path.basename(file_path),
            "full_path": file_path,
            "size_mb": file_size_mb,
            "status": status,
            "processing_time_seconds": processing_time,
            "timestamp": datetime.now().isoformat()
        })
    
    def log_processing_step(self, step_name, description, parameters=None):
        """Log a processing step"""
        self.processing_log["processing_steps"].append({
            "step": step_name,
            "description": description,
            "parameters": parameters or {},
            "timestamp": datetime.now().isoformat()
        })
    
    def log_output_file(self, output_path, description):
        """Log an output file"""
        self.processing_log["output_files"].append({
            "path": output_path,
            "description": description,
            "timestamp": datetime.now().isoformat()
        })
    
    def save_log(self):
        """Save the processing log to file"""
        with open(self.log_file, 'w') as f:
            json.dump(self.processing_log, f, indent=2)
        logger.info(f"Processing log saved to {self.log_file}")

# Usage in main processing
def main_processing_pipeline():
    """Main processing pipeline with logging"""
    logger = ProcessingLogger()
    
    # Log processing parameters
    logger.log_processing_step(
        "initialization",
        "Starting data processing pipeline",
        {"chunk_size": "3_months", "parallel_processes": 4}
    )
    
    # Process files with progress tracking
    file_list = get_csv_file_list()
    successful_files, failed_files = process_files_with_progress(file_list)
    
    # Log final results
    logger.log_processing_step(
        "completion",
        "Data processing pipeline completed",
        {"total_files": len(file_list), "successful": len(successful_files), "failed": len(failed_files)}
    )
    
    # Save the complete log
    logger.save_log()
    
    return successful_files, failed_files
```

#### Benefits for University Project
- **Demonstrates Professional Thinking**: Shows understanding of real-world data processing challenges
- **Easier Debugging**: Know exactly which file caused an issue
- **Reproducibility**: Track what processing was done for validation
- **Better Grades**: Shows you've thought beyond basic requirements

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
