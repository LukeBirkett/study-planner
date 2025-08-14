# This script is used to aggregate the raw data into daily data.

import pandas as pd
from pathlib import Path

def read_csv(filename: str) -> pd.DataFrame:
    """Read a CSV file and return a pandas DataFrame."""
    file_path = Path('data/raw') / filename
    return pd.read_csv(file_path)

PARAMS = [
    'AvgSurfT_inst',
    'CanopInt_inst',
    'LWdown_f_tavg',
    'Psurf_f_inst',
    'Qair_f_inst',
    'SnowDepth_inst',
    'SWdown_f_tavg',
    'Tair_f_inst',
    'TVeg_tavg',
    'Wind_f_inst',
    'Rainf_tavg'
]   

AGGREGATION = {
        'Rainf_tavg': 'sum',        # Rain accumulates over time
        'SnowDepth_inst': 'sum',    # Snow accumulation over time  
        'CanopInt_inst': 'sum',     # Water accumulation over time
        'Tair_f_inst': 'mean',      # Daily average temperature
        'AvgSurfT_inst': 'mean',    # Daily average surface temperature
        'Psurf_f_inst': 'mean',     # Daily average pressure
        'Qair_f_inst': 'mean',      # Daily average humidity
        'Wind_f_inst': 'mean',      # Daily average wind speed
        'LWdown_f_tavg': 'mean',    # Daily average longwave radiation
        'SWdown_f_tavg': 'mean',    # Daily average shortwave radiation
        'TVeg_tavg': 'mean'         # Daily average transpiration
    }

DATES = [
    '2024_March',
    '2024_April',
    '2024_May',
    '2024_June',
    '2024_July',
    '2024_Aug',
    '2024_Sept',
    '2024_Oct',
    '2024_Nov',
    '2024_Dec',
    '2025_Jan',
    '2025_Feb',
]

LABEL = 'Rainf_tavg'
INTERIM_DIR = 'data/interim'

for parameter in PARAMS:

    print("-" * 50)
    print(f'Parameter: {parameter}')
    print("-" * 50)

    monthly_daily_dfs = []
    
    for date in DATES:

        print(f'date: {date}')
        file = parameter + '_data_' + date + '.csv'
        print("file: " + file)
        
        try:
            df = read_csv(file)
            print(f"Successfully loaded {file}")
            print(f"Shape: {df.shape}")
            print(f"Columns: {list(df.columns)}")
        except Exception as e:
            print(f"Error: {e}")
        
        # Check missing values in final column
        final_col = df.columns[-1]
        missing_count = df[final_col].isna().sum()
        print(f"Missing values in '{final_col}': {missing_count}")

        # Print ranges of longitude and latitude
        lon_range = (df['longitude'].min(), df['longitude'].max())
        lat_range = (df['latitude'].min(), df['latitude'].max())
        print(f"Longitude range: {lon_range}")
        print(f"Latitude range: {lat_range}")

        # Aggregate 3-hourly data to daily
        daily_df = df.groupby(['longitude', 'latitude', 'year', 'month', 'day']).agg({
            final_col: AGGREGATION.get(parameter, 'mean')
        }).reset_index()

        # TODO: A check should be made that all aggregations had the same number of inputs
    
        print(f"Original shape: {df.shape}")
        print(f"Daily aggregated shape: {daily_df.shape}")

        monthly_daily_dfs.append(daily_df)
        
        print("-" * 50)
    
    if monthly_daily_dfs:

        consolidated_df = pd.concat(monthly_daily_dfs, ignore_index=True)
        print(f"Shape: {consolidated_df.shape}")
        print(f"Columns: {list(consolidated_df.columns)}")

        output_path = f"{INTERIM_DIR}/{parameter}.csv"
        consolidated_df.to_csv(output_path, index=False)
        print(f"{parameter}: {consolidated_df.shape} -> {output_path}")
