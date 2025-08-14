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


def read_parquet_from_processed(filename):
    """
    Read a parquet file from the data/processed/ folder.
    
    Args:
        filename (str): Name of the parquet file (e.g., 'data.parquet' or 'data')
        
    Returns:
        pd.DataFrame: The loaded parquet data
    """
    if PARQUET_ENGINE is None:
        raise ImportError("No parquet engine available. Please install pyarrow: pip install pyarrow")
    
    # Add .parquet extension if not present
    if not filename.endswith('.parquet'):
        filename = f"{filename}.parquet"
    
    file_path = os.path.join('data', 'processed', filename)
    
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"Parquet file not found: {file_path}")
    
    return pd.read_parquet(file_path, engine=PARQUET_ENGINE)


def main():
    """
    Main function to read and display parquet file information.
    """
    try:
        # Read the parquet file
        df = read_parquet_from_processed('AvgSurfT_inst_with_lags')
        
        print(f"Successfully loaded parquet file!")
        print(f"DataFrame shape: {df.shape[0]:,} rows × {df.shape[1]} columns")
        print(f"Memory usage: {df.memory_usage(deep=True).sum() / 1024**2:.2f} MB")
        print(f"Columns: {list(df.columns)}")
        print(f"\nFirst 10 rows:")
        print(df.head(10))
        
    except Exception as e:
        print(f"Error reading parquet file: {e}")


if __name__ == "__main__":
    time_start = timeit.default_timer()
    main()
    time_end = timeit.default_timer()
    print(f"\nTime taken: {time_end - time_start:.2f} seconds")
