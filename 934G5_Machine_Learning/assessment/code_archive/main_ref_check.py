import pandas as pd
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

def read_reference_table() -> pd.DataFrame:
    """Read the reference table CSV and return a pandas DataFrame."""
    file_path = Path('data/processed/reference_table.csv')
    return pd.read_csv(file_path)

def main():
    # Read the reference table
    ref_table = read_reference_table()
    
    # Get file size
    file_path = Path('data/processed/reference_table.csv')
    file_size_mb = file_path.stat().st_size / (1024 * 1024)
    
    # Print shape
    print(f"Reference table shape: {ref_table.shape}")
    print(f"Rows: {ref_table.shape[0]}, Columns: {ref_table.shape[1]}")
    
    # Print file size
    print(f"File size: {file_size_mb:.2f} MB")
    
    # Print column names
    print(f"\nColumn names: {list(ref_table.columns)}")
    
    # Create date field
    ref_table['date'] = pd.to_datetime(ref_table[['year', 'month', 'day']])
    
    # Print date range
    print(f"\nDate range:")
    print(f"Min date: {ref_table['date'].min().strftime('%Y-%m-%d')}")
    print(f"Max date: {ref_table['date'].max().strftime('%Y-%m-%d')}")
    
    # Count instances per month
    print(f"\nInstances per month:")
    monthly_counts = ref_table.groupby(['year', 'month']).size().reset_index(name='count')
    
    # Format month names for better readability
    month_names = {
        1: 'Jan', 2: 'Feb', 3: 'Mar', 4: 'Apr', 5: 'May', 6: 'Jun',
        7: 'Jul', 8: 'Aug', 9: 'Sep', 10: 'Oct', 11: 'Nov', 12: 'Dec'
    }
    
    for _, row in monthly_counts.iterrows():
        month_name = month_names[row['month']]
        print(f"  {row['year']}-{month_name}: {row['count']:,} instances")
    
    # Check date continuity
    print(f"\nDate continuity check:")
    date_range = pd.date_range(start=ref_table['date'].min(), end=ref_table['date'].max(), freq='D')
    missing_dates = date_range.difference(ref_table['date'])
    
    if len(missing_dates) == 0:
        print(f"Complete date coverage: {len(date_range)} consecutive days")
    else:
        print(f"Missing dates: {len(missing_dates)} gaps found")
        print(f"First few missing: {missing_dates[:5]}")
    
    # Print coordinate ranges
    print(f"\nGeographic coordinate ranges:")
    print(f"Latitude: -90° to +90° (South Pole to North Pole)")
    print(f"Longitude: -180° to +180° (West to East from Prime Meridian)")

    # Check coordinate validity
    valid_lat = (-90 <= ref_table['latitude'].min()) and (ref_table['latitude'].max() <= 90)
    valid_lon = (-180 <= ref_table['longitude'].min()) and (ref_table['longitude'].max() <= 180)
    
    print(f"\nCoordinate validity check:")
    print(f"Latitude valid: {valid_lat}")
    print(f"Longitude valid: {valid_lon}")
    
    # Print actual min/max values
    print(f"\nActual coordinate ranges in data:")
    print(f"Latitude: {ref_table['latitude'].min():.2f}° to {ref_table['latitude'].max():.2f}°")
    print(f"Longitude: {ref_table['longitude'].min():.2f}° to {ref_table['longitude'].max():.2f}°")
    
    # Count unique longitude-latitude pairs
    print(f"\nUnique location pairs:")
    unique_locations = ref_table[['longitude', 'latitude']].drop_duplicates()
    print(f"Unique longitude-latitude pairs: {len(unique_locations)}")
    
    # Calculate expected counts based on 0.5° resolution
    lon_range = ref_table['longitude'].max() - ref_table['longitude'].min()
    lat_range = ref_table['latitude'].max() - ref_table['latitude'].min()

    expected_lon_count = int(lon_range / 0.5) + 1
    expected_lat_count = int(lat_range / 0.5) + 1
    theoretical_max_resolution = expected_lon_count * expected_lat_count

    print(f"Maximum possible pairs (0.5° resolution): {expected_lon_count} longitudes × {expected_lat_count} latitudes = {theoretical_max_resolution}")

    # Create location grid visualization
    print(f"\nCreating location grid visualization...")
    
    try:
        # Get unique coordinates
        unique_lons = sorted(ref_table['longitude'].unique())
        unique_lats = sorted(ref_table['latitude'].unique())
        
        # Create a grid (0 = no data, 1 = has data)
        grid = np.zeros((len(unique_lats), len(unique_lons)))
        
        # Mark locations that have data
        for _, row in ref_table[['longitude', 'latitude']].drop_duplicates().iterrows():
            lon_idx = unique_lons.index(row['longitude'])
            lat_idx = unique_lats.index(row['latitude'])
            grid[lat_idx, lon_idx] = 1
        
        # Plot the grid
        plt.figure(figsize=(12, 8))
        plt.imshow(grid, cmap='Blues', aspect='auto', 
                   extent=[min(unique_lons), max(unique_lons), min(unique_lats), max(unique_lats)])
        plt.colorbar(label='Data Present (1) or Missing (0)')
        plt.xlabel('Longitude')
        plt.ylabel('Latitude')
        plt.title('Geographic Coverage Grid')
        plt.grid(True, alpha=0.3)
        
        # Save the plot
        plt.savefig('data/processed/coverage_grid.png', dpi=300, bbox_inches='tight')
        plt.show()
        
        print(f"Coverage grid saved to: data/processed/coverage_grid.png")

        # Explain the coverage difference
        print(f"\nCoverage explanation:")
        print(f"Theoretical maximum ({theoretical_max_resolution:,}) includes ALL possible longitude-latitude combinations globally.")
        print(f"Actual coverage ({len(unique_locations):,}) represents only LAND-BASED locations.")
        print(f"This is expected since the NASA dataset excludes ocean/sea locations.")

        # Add these print statements after your coverage explanation:
        print(f"\nGeographic considerations:")
        print(f"Geographic bias: Data covers latitude -54.5° to 83.5° (Southern Hemisphere to Arctic)")
        print(f"  - Northern Hemisphere heavy coverage")
        print(f"  - Ensure training data represents diverse geographic regions")
        print(f"Scale normalization: Current ranges - Longitude: -179.5° to 179.5°, Latitude: -54.5° to 83.5°")
        print(f"  - Consider scaling to [0,1] or [-1,1] for better network performance")
        print(f"  - This will help the network learn spatial patterns more effectively")
        
    except Exception as e:
        print(f"Error creating visualization: {e}")
        print("Skipping grid visualization...")
    

    # Count instances per location
    print(f"\nDate instances per location:")
    location_counts = ref_table.groupby(['longitude', 'latitude']).size().reset_index(name='date_count')
    
    # Sort by count (descending) to see most frequent locations
    location_counts_sorted = location_counts.sort_values('date_count', ascending=False)
    
    print(f"Total unique locations: {len(location_counts)}")
    print(f"Locations with most date instances:")
    print(location_counts_sorted.head(10).to_string(index=False))
    
    # Summary statistics
    print(f"\nLocation coverage statistics:")
    print(f"Average dates per location: {location_counts['date_count'].mean():.1f}")
    print(f"Median dates per location: {location_counts['date_count'].median():.1f}")
    print(f"Min dates per location: {location_counts['date_count'].min()}")
    print(f"Max dates per location: {location_counts['date_count'].max()}")
    
    # Check for locations with only one date instance
    single_date_locations = location_counts[location_counts['date_count'] == 1]
    print(f"Locations with only 1 date instance: {len(single_date_locations)}")
    
    # Check for locations with many date instances (e.g., >100)
    frequent_locations = location_counts[location_counts['date_count'] > 100]
    print(f"Locations with >100 date instances: {len(frequent_locations)}")

    

if __name__ == "__main__":
    main()