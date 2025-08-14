import pandas as pd
import os
import timeit

# Try to import parquet engines
try:
    import pyarrow
    PARQUET_ENGINE = 'pyarrow'
except ImportError:
    try:
        import fastparquet
        PARQUET_ENGINE = 'fastparquet'
    except ImportError:
        print("Warning: No parquet engine found. Installing pyarrow recommended.")
        print("Run: pip install pyarrow")
        PARQUET_ENGINE = None


def read_csv_from_interim(filename):
    file_path = os.path.join('data', 'interim', filename)
    return pd.read_csv(file_path)


def save_csv_to_processed(df, filename):
    """
    Save DataFrame to CSV in the data/processed/ folder.
    
    Args:
        df: DataFrame to save
        filename: Name of the output CSV file
    """
    output_path = os.path.join('data', 'processed', filename)
    df.to_csv(output_path, index=False)
    print(f"Saved processed data to: {output_path}")
    return output_path


def save_parquet_to_processed(df, filename):
    """
    Save DataFrame to parquet in the data/processed/ folder.
    
    Args:
        df: DataFrame to save
        filename: Name of the output parquet file (without extension)
    """
    if PARQUET_ENGINE is None:
        raise ImportError("No parquet engine available. Please install pyarrow: pip install pyarrow")
    
    output_path = os.path.join('data', 'processed', f"{filename}.parquet")
    df.to_parquet(output_path, index=False, engine=PARQUET_ENGINE)
    print(f"Saved processed data to: {output_path}")
    return output_path


def get_file_size_mb(file_path):
    """Get file size in MB"""
    size_bytes = os.path.getsize(file_path)
    return size_bytes / (1024 * 1024)


def main():
    df = read_csv_from_interim('AvgSurfT_inst.csv')
    print(f"Loaded data with {len(df)} rows")
    
    df_sorted = df.sort_values(['longitude', 'latitude', 'year', 'month', 'day']).reset_index(drop=True)
    
    for lag in range(1, 14):
        df_sorted[f'AvgSurfT_inst_lag{lag}'] = df_sorted.groupby(['longitude', 'latitude'])['AvgSurfT_inst'].shift(lag)
    
    # Print dataset size information
    print(f"\nDataset size information:")
    print(f"Original DataFrame: {df.shape[0]:,} rows × {df.shape[1]} columns")
    print(f"Processed DataFrame: {df_sorted.shape[0]:,} rows × {df_sorted.shape[1]} columns")
    print(f"Memory usage: {df_sorted.memory_usage(deep=True).sum() / 1024**2:.2f} MB")
    
    if df.shape[0] == df_sorted.shape[0]:
        print("✓ Row count matches - data integrity maintained")
        
        # Save in both formats with timing
        print(f"\nSaving files...")
        
        # Time CSV save
        csv_start = timeit.default_timer()
        csv_path = save_csv_to_processed(df_sorted, 'AvgSurfT_inst_with_lags.csv')
        csv_time = timeit.default_timer() - csv_start
        csv_size = get_file_size_mb(csv_path)
        print(f"CSV: {csv_size:.2f} MB, saved in {csv_time:.2f} seconds")
        
        # Time parquet save
        parquet_start = timeit.default_timer()
        parquet_path = save_parquet_to_processed(df_sorted, 'AvgSurfT_inst_with_lags')
        parquet_time = timeit.default_timer() - parquet_start
        parquet_size = get_file_size_mb(parquet_path)
        print(f"Parquet: {parquet_size:.2f} MB, saved in {parquet_time:.2f} seconds")
        
        print(f"Size reduction: {((csv_size - parquet_size) / csv_size * 100):.1f}% smaller with parquet")
        print(f"Speed improvement: {((csv_time - parquet_time) / csv_time * 100):.1f}% faster with parquet")
        
    else:
        print("✗ Row count mismatch - check data processing")
        print(f"Difference: {df.shape[0] - df_sorted.shape[0]} rows")

if __name__ == "__main__":
    time_start = timeit.default_timer()
    main()
    time_end = timeit.default_timer()
    print(f"Time taken: {time_end - time_start} seconds")
