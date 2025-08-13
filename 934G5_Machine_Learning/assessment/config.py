"""
Configuration file for Data Processing Pipeline
Centralized parameter management
"""

# Data paths
DATA_RAW_DIR = "data/raw"
DATA_INTERIM_DIR = "data/interim"
DATA_PROCESSED_DIR = "data/processed"
LOGS_DIR = "logs"

# Processing parameters
CHUNK_SIZE = 1000  # Number of location-date combinations per chunk
SAMPLE_SIZE = 5     # Number of files to sample for validation

# Split strategy
SPLIT_STRATEGY = "interleaved_monthly"
TRAIN_RATIO = 0.833  # 10/12 months
TEST_RATIO = 0.083   # 1/12 months
VALIDATION_RATIO = 0.083  # 1/12 months

# Memory optimization (M1 Pro specific)
MAX_MEMORY_GB = 12  # Leave 4GB for system
TARGET_MEMORY_GB = 10  # Target memory usage

# Data types
OPTIMIZED_DTYPES = {
    'longitude': 'float32',
    'latitude': 'float32',
    'year': 'int16',
    'month': 'int8',
    'day': 'int8',
    'hour': 'int8'
}

# Weather parameters (for aggregation decisions)
SUM_PARAMETERS = ['Rainf_tavg', 'SnowDepth_inst', 'CanopInt_inst']
AVERAGE_PARAMETERS = ['Tair_f_inst', 'AvgSurfT_inst', 'Psurf_f_inst', 
                      'Qair_f_inst', 'Wind_f_inst']
DECIDE_PARAMETERS = ['LWdown_f_tavg', 'SWdown_f_tavg', 'TVeg_tavg']

# Validation thresholds
MIN_READINGS_PER_DAY = 6  # Minimum 3-hourly readings for valid daily aggregation
MAX_MISSING_THRESHOLD = 0.25  # Maximum 25% missing data allowed 