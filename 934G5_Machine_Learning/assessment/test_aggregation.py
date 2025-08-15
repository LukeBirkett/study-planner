import numpy as np
import time

def aggregate_3hourly_to_daily_numpy_fast(arr):
    """
    Fast vectorized aggregation using NumPy.
    """
    print(f"Input array shape: {arr.shape}")
    
    # Extract columns
    years = arr[:, 0].astype(int)
    months = arr[:, 1].astype(int)
    days = arr[:, 2].astype(int)
    lons = arr[:, 4]
    lats = arr[:, 5]
    values = arr[:, 6]
    
    print(f"Years range: {years.min()} to {years.max()}")
    print(f"Months range: {months.min()} to {months.max()}")
    print(f"Days range: {days.min()} to {days.max()}")
    print(f"Longitude range: {lons.min():.2f} to {lons.max():.2f}")
    print(f"Latitude range: {lats.min():.2f} to {lats.max():.2f}")
    print(f"Values range: {values.min():.2f} to {values.max():.2f}")
    
    # Create unique identifiers (vectorized)
    print("Creating location keys...")
    location_keys = (lons * 10000 + lats * 100).astype(int)
    print("Creating date keys...")
    date_keys = years * 10000 + months * 100 + days
    print("Combining keys...")
    combined_keys = location_keys + date_keys
    
    print(f"Combined keys range: {combined_keys.min()} to {combined_keys.max()}")
    
    # Find unique combinations (vectorized)
    print("Finding unique combinations...")
    start_time = time.time()
    unique_keys, inverse_indices, counts = np.unique(
        combined_keys, return_inverse=True, return_counts=True
    )
    unique_time = time.time() - start_time
    print(f"Found {len(unique_keys)} unique combinations in {unique_time:.4f} seconds")
    
    # Use bincount for fast aggregation (vectorized)
    print("Aggregating values...")
    start_time = time.time()
    aggregated_values = np.bincount(
        inverse_indices, 
        weights=values, 
        minlength=len(unique_keys)
    ) / np.bincount(inverse_indices, minlength=len(unique_keys))
    bincount_time = time.time() - start_time
    print(f"Aggregated values shape: {aggregated_values.shape} in {bincount_time:.4f} seconds")
    
    # Extract metadata for unique combinations
    print("Extracting metadata...")
    start_time = time.time()
    unique_indices = np.unique(combined_keys, return_index=True)[1]
    metadata_time = time.time() - start_time
    print(f"Metadata extraction took {metadata_time:.4f} seconds")
    
    # Build output array (vectorized)
    print("Building output array...")
    start_time = time.time()
    daily_data = np.column_stack([
        years[unique_indices],      # year
        months[unique_indices],     # month  
        days[unique_indices],       # day
        lons[unique_indices],       # longitude
        lats[unique_indices],       # latitude
        aggregated_values            # aggregated value
    ])
    build_time = time.time() - start_time
    print(f"Output array shape: {daily_data.shape} built in {build_time:.4f} seconds")
    
    return daily_data

# Test with small sample data
print("Creating test data...")
test_arr = np.array([
    [2024, 3, 1, 0, -179.5, 68.5, 15.2],
    [2024, 3, 1, 3, -179.5, 68.5, 16.1],
    [2024, 3, 1, 6, -179.5, 68.5, 17.3],
    [2024, 3, 1, 9, -179.5, 68.5, 18.0],
    [2024, 3, 2, 0, -179.5, 68.5, 19.1],
    [2024, 3, 2, 3, -179.5, 68.5, 20.2],
    [2024, 3, 2, 6, -179.5, 68.5, 21.3],
    [2024, 3, 2, 9, -179.5, 68.5, 22.4],
])

print(f"Test array shape: {test_arr.shape}")
print("Test array:")
print(test_arr)

print("\nTesting aggregation function...")
try:
    result = aggregate_3hourly_to_daily_numpy_fast(test_arr)
    print("\nSuccess! Result:")
    print(result)
except Exception as e:
    print(f"Error: {e}")
    import traceback
    traceback.print_exc()

# Test with larger dataset
print("\n" + "="*50)
print("Testing with larger dataset...")

# Create larger test data (simulating real climate data)
np.random.seed(42)
n_locations = 1000  # 1000 unique locations
n_days = 30         # 30 days
n_hours = 8         # 8 time points per day (3-hourly)

total_rows = n_locations * n_days * n_hours
print(f"Creating {total_rows:,} rows of test data...")

# Generate test data
years = np.full(total_rows, 2024)
months = np.full(total_rows, 3)
days = np.tile(np.repeat(np.arange(1, n_days + 1), n_hours), n_locations)
hours = np.tile(np.arange(0, 24, 3), n_locations * n_days)
lons = np.repeat(np.random.uniform(-180, 180, n_locations), n_days * n_hours)
lats = np.repeat(np.random.uniform(-90, 90, n_locations), n_days * n_hours)
values = np.random.normal(20, 5, total_rows)

large_test_arr = np.column_stack([years, months, days, hours, lons, lats, values])
print(f"Large test array shape: {large_test_arr.shape}")

print("\nTesting large dataset aggregation...")
try:
    start_time = time.time()
    large_result = aggregate_3hourly_to_daily_numpy_fast(large_test_arr)
    total_time = time.time() - start_time
    print(f"\nLarge dataset aggregation completed in {total_time:.4f} seconds")
    print(f"Input: {large_test_arr.shape[0]:,} rows")
    print(f"Output: {large_result.shape[0]:,} rows")
    print(f"Compression: {large_test_arr.shape[0] / large_result.shape[0]:.1f}x")
except Exception as e:
    print(f"Error with large dataset: {e}")
    import traceback
    traceback.print_exc()

# Test with even larger dataset (closer to your real data size)
print("\n" + "="*50)
print("Testing with very large dataset...")

# Create very large test data (closer to real climate data size)
np.random.seed(42)
n_locations = 15000  # 15000 unique locations (closer to your 15325)
n_days = 365         # Full year
n_hours = 8          # 8 time points per day (3-hourly)

total_rows = n_locations * n_days * n_hours
print(f"Creating {total_rows:,} rows of test data...")

# Generate test data - much simpler approach
years = np.full(total_rows, 2024)
months = np.full(total_rows, 3)  # Just use March for simplicity
days = np.tile(np.arange(1, n_days + 1), n_locations * n_hours)
hours = np.tile(np.arange(0, 24, 3), n_locations * n_days)
lons = np.repeat(np.random.uniform(-180, 180, n_locations), n_days * n_hours)
lats = np.repeat(np.random.uniform(-90, 90, n_locations), n_days * n_hours)
values = np.random.normal(20, 5, total_rows)

very_large_test_arr = np.column_stack([years, months, days, hours, lons, lats, values])
print(f"Very large test array shape: {very_large_test_arr.shape}")

print("\nTesting very large dataset aggregation...")
try:
    start_time = time.time()
    very_large_result = aggregate_3hourly_to_daily_numpy_fast(very_large_test_arr)
    total_time = time.time() - start_time
    print(f"\nVery large dataset aggregation completed in {total_time:.4f} seconds")
    print(f"Input: {very_large_test_arr.shape[0]:,} rows")
    print(f"Output: {very_large_result.shape[0]:,} rows")
    print(f"Compression: {very_large_test_arr.shape[0] / very_large_result.shape[0]:.1f}x")
    print(f"Speed: {very_large_test_arr.shape[0] / total_time:,.0f} rows per second")
except Exception as e:
    print(f"Error with very large dataset: {e}")
    import traceback
    traceback.print_exc()
