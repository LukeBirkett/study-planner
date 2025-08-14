import pandas as pd
from pathlib import Path
from datetime import timedelta
import numpy as np
import time

def read_reference_table() -> pd.DataFrame:
    """Read the reference table CSV and return a pandas DataFrame."""
    file_path = Path('data/processed/reference_table.csv')
    return pd.read_csv(file_path)

def main():

    # ===============================

    # Read the reference table
    ref_table = read_reference_table()
    print(f"Reference table loaded: {ref_table.shape}")
    
    # Convert year, month, day to integers to avoid float formatting issues
    ref_table['year'] = ref_table['year'].astype(int)
    ref_table['month'] = ref_table['month'].astype(int)
    ref_table['day'] = ref_table['day'].astype(int)
    
    # Extract specific instance: longitude=-179.5, latitude=68.5, year=2024, month=11, day=1
    target_instance = ref_table[
        (ref_table['longitude'] == -179.5) & 
        (ref_table['latitude'] == 68.5) & 
        (ref_table['year'] == 2024) & 
        (ref_table['month'] == 11) & 
        (ref_table['day'] == 1)
    ].copy()

    print(f"target instance:")
    print(target_instance)

    # ===============================
    
    # Read in AvgSurfT data from interim folder
    print(f"Loading AvgSurfT data...")
    avgsurft_file = Path('data/interim/AvgSurfT_inst.csv')
    
    avgsurft_df = pd.read_csv(avgsurft_file)
    print(f"AvgSurfT data loaded: {avgsurft_df.shape}")
    print(f"Columns: {list(avgsurft_df.columns)}")
    
    # ===============================

    


if __name__ == "__main__":
    main()
