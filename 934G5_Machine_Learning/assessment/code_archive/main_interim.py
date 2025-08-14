# This script is used to create final datasets from the interim datasets.
# This involves the creation of a reference table
# The reference will be checked for incomplete and missing data

import pandas as pd
import os
from pathlib import Path

# Define the parameters and dates (same as in main_raw.py)
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

def read_interim_csv(filename: str) -> pd.DataFrame:
    """Read an interim CSV file and return a pandas DataFrame."""
    file_path = Path('data/interim') / filename
    return pd.read_csv(file_path)

def main():
    print("🔄 Starting instance extraction from interim CSVs...")
    
    # Create processed directory if it doesn't exist
    os.makedirs('data/processed', exist_ok=True)
    
    # Initialize holding DataFrame
    holding_df = pd.DataFrame()
    
    # Loop through each parameter
    for i, param in enumerate(PARAMS):
        filename = f"{param}.csv"
        print(f"\n Processing: {filename}")
        
        try:
            # Read interim CSV
            df = read_interim_csv(filename)
            print(f"Loaded: {df.shape}")
            
            # Extract unique instances (longitude, latitude, year, month, day)
            instances = df[['longitude', 'latitude', 'year', 'month', 'day']].copy()
            print(f"Extracted instances: {instances.shape}")
            
            # Check if instances are unique within this CSV
            unique_count = instances.drop_duplicates().shape[0]
            total_count = instances.shape[0]
            if unique_count != total_count:
                print(f"Warning: {total_count - unique_count} duplicate instances found in {filename}")
            
            # Concatenate to holding DataFrame
            if holding_df.empty:
                holding_df = instances.copy()
                print(f"First CSV: {holding_df.shape}")
            else:
                holding_df = pd.concat([holding_df, instances], ignore_index=True)
                print(f"Concatenated: {holding_df.shape}")
                
                # Deduplicate after each CSV to keep memory usage low
                print(f"Deduplicating the holding table...")
                holding_df = holding_df.drop_duplicates(subset=['longitude', 'latitude', 'year', 'month', 'day'])
                print(f"After deduplication: {holding_df.shape}")
                
        except Exception as e:
            print(f"Error processing {filename}: {e}")
            continue
    
    # Final sort for consistency
    print(f"\nFinal sorting and cleanup...")
    reference_table = holding_df.sort_values(['longitude', 'latitude', 'year', 'month', 'day']).reset_index(drop=True)
    

    # Verify no duplicates remain
    duplicate_check = reference_table.duplicated(subset=['longitude', 'latitude', 'year', 'month', 'day']).sum()
    if duplicate_check == 0:
        print("No duplicate instances remain in reference table")
    else:
        print(f"{duplicate_check} duplicate instances still found")
    
    # Save reference table
    output_path = 'data/processed/reference_table.csv'
    reference_table.to_csv(output_path, index=False)
    print(f"Reference table saved to: {output_path}")
    
    return reference_table

if __name__ == "__main__":
    reference_table = main()






