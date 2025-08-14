import pandas as pd
from pathlib import Path
from datetime import timedelta
import numpy as np

def read_reference_table() -> pd.DataFrame:
    """Read the reference table CSV and return a pandas DataFrame."""
    file_path = Path('data/processed/reference_table.csv')
    return pd.read_csv(file_path)

def main():

    # Read the reference table
    ref_table = read_reference_table()
    print(f"\nReference table loaded: {ref_table.shape}")

    # batch = ref_table.iloc[0:1000000].copy()
    batch = ref_table.copy()

    print(f"\ntarget batch:")
    print(batch.head())
    print(batch.shape)

    PARAMS = [
    'AvgSurfT_inst',
    # 'CanopInt_inst',
    # 'LWdown_f_tavg',
    # 'Psurf_f_inst',
    # 'Qair_f_inst',
    # 'SnowDepth_inst',
    # 'SWdown_f_tavg',
    # 'Tair_f_inst',
    # 'TVeg_tavg',
    # 'Wind_f_inst',
    # 'Rainf_tavg'
]  
    
    for param in PARAMS:

        # Read in data from interim folder
        print(f"\nLoading {param} data...")
        file = Path(f'data/interim/{param}.parquet')
        
        df = pd.read_parquet(file)
        print(f"{param} data loaded: {df.shape}")
        
        # Join the parameters to the reference table
        print(f"\nJoining parameters to reference table...")
        
        # First, join the param data
        print(f"Joining {param} data...")
        joined_df = batch.merge(
            df, 
            on=['longitude', 'latitude', 'year', 'month', 'day'],
            how='left'
        )
        print(f"After joining {param}: {joined_df.shape}")
        
        # Final data quality check
        print(f"\nFinal joined dataset:")
        print(f"Shape: {joined_df.shape}")
        print(f"Memory usage: {joined_df.memory_usage(deep=True).sum() / 1024 / 1024:.2f} MB")
        
    


if __name__ == "__main__":
    main()
