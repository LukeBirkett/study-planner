"""
Data Loader Module
Enhanced CSV file loading with chunked processing and memory management for NASA weather data
"""

import pandas as pd # Data manipulation
import os # File operations
from pathlib import Path # Path handling
import logging # Logging system
import gc  # Garbage collection
import psutil # Memory monitoring
from typing import Optional, List, Dict, Any
import time # Performance timing

# Set up basic logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class DataLoader:
    """Enhanced CSV file loader with chunked processing for NASA weather data"""
    
    def __init__(self, data_dir="data/raw", default_chunk_size=10000, memory_threshold=80):
        """
        Initialize the DataLoader
        
        Args:
            data_dir (str): Path to directory containing CSV files
            default_chunk_size (int): Default number of rows per chunk
            memory_threshold (int): Memory usage percentage threshold for warnings
        """
        self.data_dir = Path(data_dir)
        self.default_chunk_size = default_chunk_size
        self.memory_threshold = memory_threshold
        self.expected_columns = ['year', 'month', 'day', 'hour', 'longitude', 'latitude']
        
        # Validate data directory exists
        if not self.data_dir.exists():
            raise FileNotFoundError(f"Data directory not found: {self.data_dir}")
        
        logger.info(f"DataLoader initialized with directory: {self.data_dir}")
        logger.info(f"Default chunk size: {self.default_chunk_size}, Memory threshold: {self.memory_threshold}%")
    
    def load_csv_file(self, file_path, chunk_size=None, process_chunks=True, validate_schema=True):
        """
        Enhanced CSV file loading with chunked processing

        This is the main loading function and it uses a lot of sub-functions
        
        Args:
            file_path (str or Path): Path to CSV file to load
            chunk_size (int, optional): Rows per chunk (uses default if None)
            process_chunks (bool): Whether to process chunks individually
            validate_schema (bool): Whether to validate file schema
            
        Returns:
            pd.DataFrame or None: Loaded data or None if loading failed
        """
        if chunk_size is None:
            chunk_size = self.default_chunk_size
            
        try:
            logger.info(f"Loading CSV file: {file_path}")
            
            # Check file size to determine loading strategy
            file_size = os.path.getsize(file_path)
            file_size_mb = file_size / (1024 * 1024)
            
            logger.info(f"File size: {file_size_mb:.2f} MB")
            
            # For small files (< 10MB), load directly
            if file_size_mb < 10:
                logger.info("File is small, loading directly")
                return self._load_small_file(file_path, validate_schema)
            
            # For large files, use chunked processing
            if process_chunks:
                logger.info(f"Using chunked processing with chunk size: {chunk_size}")
                return self._load_and_process_chunks(file_path, chunk_size, validate_schema)
            else:
                logger.info("Chunked processing disabled, loading directly")
                return self._load_small_file(file_path, validate_schema)
                
        except Exception as e:
            logger.error(f"Unexpected error loading {file_path}: {e}")
            return None
    
    def _load_small_file(self, file_path, validate_schema=True):
        """Load small files directly into memory"""
        try:
            df = pd.read_csv(file_path)
            
            if df.empty:
                logger.warning(f"File is empty: {file_path}")
                return None
            
            if validate_schema:
                if not self._validate_schema(df):
                    return None
            
            logger.info(f"Successfully loaded {file_path}: {df.shape[0]} rows, {df.shape[1]} columns")
            return df
            
        except Exception as e:
            logger.error(f"Error loading small file {file_path}: {e}")
            return None
    
    def _load_and_process_chunks(self, file_path, chunk_size, validate_schema=True):
        """Process large CSV files in memory-efficient chunks"""
        chunks = []
        total_rows = 0
        chunk_count = 0
        start_time = time.time()
        
        try:
            # Get total file size for progress tracking
            file_size = os.path.getsize(file_path)
            
            # Process file chunk by chunk
            for chunk_num, chunk in enumerate(pd.read_csv(file_path, chunksize=chunk_size)):
                chunk_count += 1
                
                # Validate chunk schema if needed
                if validate_schema and chunk_num == 0:  # Only validate first chunk
                    if not self._validate_schema(chunk):
                        logger.error(f"Schema validation failed for {file_path}")
                        return None
                
                # Process chunk (basic validation and cleaning)
                processed_chunk = self._process_chunk(chunk)
                if processed_chunk is not None:
                    chunks.append(processed_chunk)
                    total_rows += len(processed_chunk)
                    
                    # Memory management every 5 chunks
                    if chunk_count % 5 == 0:
                        self._check_memory_usage()
                        
                    # Progress logging
                    elapsed_time = time.time() - start_time
                    if chunk_count % 10 == 0:  # Log every 10 chunks
                        logger.info(f"Processed {chunk_count} chunks, {total_rows} rows, elapsed: {elapsed_time:.1f}s")
                        
                else:
                    logger.warning(f"Chunk {chunk_num + 1} failed processing")
                    
        except Exception as e:
            logger.error(f"Error processing chunks: {e}")
            # Return what we have so far
            if chunks:
                logger.info(f"Returning {len(chunks)} successfully processed chunks")
                return pd.concat(chunks, ignore_index=True)
            return None
        
        # Combine all chunks efficiently
        if chunks:
            final_df = pd.concat(chunks, ignore_index=True)
            total_time = time.time() - start_time
            
            logger.info(f"Successfully loaded {file_path}: {final_df.shape}")
            logger.info(f"Total processing time: {total_time:.1f}s, {total_rows/total_time:.0f} rows/second")
            
            # Clear chunks from memory
            chunks.clear()
            gc.collect()
            
            return final_df
        
        return None
    
    def _process_chunk(self, chunk):
        """Process individual chunk with basic validation and cleaning"""
        try:
            # Basic validation - check if chunk has data
            if chunk.empty:
                return None
            
            # Check for required columns (should be validated in first chunk)
            missing_columns = set(self.expected_columns) - set(chunk.columns)
            if missing_columns:
                logger.error(f"Missing required columns in chunk: {missing_columns}")
                return None
            
            # Basic data cleaning
            processed_chunk = chunk.copy()
            original_rows = len(processed_chunk)
            
            # Remove completely empty rows
            before_empty_removal = len(processed_chunk)
            processed_chunk = processed_chunk.dropna(how='all')
            after_empty_removal = len(processed_chunk)
            
            if before_empty_removal != after_empty_removal:
                removed_empty = before_empty_removal - after_empty_removal
                logger.warning(f"⚠️ Removed {removed_empty} completely empty rows from chunk (all columns NaN)")
            
            # Basic data type validation
            for col in ['longitude', 'latitude']:
                if col in processed_chunk.columns:
                    # Convert to numeric, coerce errors to NaN
                    processed_chunk[col] = pd.to_numeric(processed_chunk[col], errors='coerce')
            
            # Remove rows with invalid coordinates
            if 'longitude' in processed_chunk.columns and 'latitude' in processed_chunk.columns:
                before_coord_validation = len(processed_chunk)
                
                # Create mask for valid coordinates
                valid_coords_mask = (
                    (processed_chunk['longitude'] >= -180) & (processed_chunk['longitude'] <= 180) &
                    (processed_chunk['latitude'] >= -90) & (processed_chunk['latitude'] <= 90)
                )
                
                # Count invalid coordinates for logging
                invalid_coords_count = (~valid_coords_mask).sum()
                
                if invalid_coords_count > 0:
                    logger.warning(f"⚠️ Found {invalid_coords_count} rows with invalid coordinates:")
                    
                    # Log some examples of invalid coordinates
                    invalid_rows = processed_chunk[~valid_coords_mask]
                    sample_invalid = invalid_rows[['longitude', 'latitude']].head(3)
                    
                    for idx, row in sample_invalid.iterrows():
                        lon, lat = row['longitude'], row['latitude']
                        lon_status = "OK" if -180 <= lon <= 180 else f"OUT OF RANGE ({lon})"
                        lat_status = "OK" if -90 <= lat <= 90 else f"OUT OF RANGE ({lat})"
                        logger.warning(f"     Row {idx}: lon={lon} ({lon_status}), lat={lat} ({lat_status})")
                    
                    if len(invalid_rows) > 3:
                        logger.warning(f"     ... and {len(invalid_rows) - 3} more invalid coordinate rows")
                
                # Apply the mask to keep only valid coordinates
                processed_chunk = processed_chunk[valid_coords_mask]
                after_coord_validation = len(processed_chunk)
                
                if before_coord_validation != after_coord_validation:
                    removed_coords = before_coord_validation - after_coord_validation
                    logger.info(f"📍 Coordinate validation: {before_coord_validation} → {after_coord_validation} rows (removed {removed_coords})")
            
            # Log final cleaning summary for this chunk
            final_rows = len(processed_chunk)
            if final_rows != original_rows:
                total_removed = original_rows - final_rows
                logger.info(f"🧹 Chunk cleaning summary: {original_rows} → {final_rows} rows (removed {total_removed} problematic rows)")
            
            return processed_chunk
            
        except Exception as e:
            logger.error(f"Error processing chunk: {e}")
            return None
    
    def _validate_schema(self, df):
        """Validate that DataFrame has expected schema"""
        try:
            # Check if file has data
            if df.empty:
                logger.error("File is empty")
                return False
            
            # Check expected columns exist
            missing_columns = set(self.expected_columns) - set(df.columns)
            if missing_columns:
                logger.error(f"Missing expected columns: {missing_columns}")
                return False
            
            # Check data types for key columns
            for col in ['longitude', 'latitude']:
                if col in df.columns:
                    if not pd.api.types.is_numeric_dtype(df[col]):
                        logger.warning(f"Column {col} is not numeric, attempting conversion")
                        try:
                            df[col] = pd.to_numeric(df[col], errors='coerce')
                        except:
                            logger.error(f"Could not convert {col} to numeric")
                            return False
            
            logger.info("Schema validation passed")
            return True
            
        except Exception as e:
            logger.error(f"Schema validation error: {e}")
            return False
    
    def _check_memory_usage(self):
        """Monitor and optimize memory usage"""
        try:
            memory = psutil.virtual_memory()
            memory_percent = memory.percent
            
            if memory_percent > self.memory_threshold:
                logger.warning(f"High memory usage: {memory_percent:.1f}%")
                
                # Force garbage collection
                gc.collect()
                
                # Check memory again after GC
                memory_after = psutil.virtual_memory()
                logger.info(f"Memory after GC: {memory_after.percent:.1f}%")
                
            if memory_percent > 90:
                logger.error(f"Critical memory usage: {memory_percent:.1f}%")
                # Could implement chunk size reduction here
                
        except Exception as e:
            logger.warning(f"Could not check memory usage: {e}")
    
    def get_csv_files(self):
        """
        Get list of all CSV files in the data directory
        
        Returns:
            list: List of CSV file paths
        """
        csv_files = list(self.data_dir.glob("*.csv"))
        logger.info(f"Found {len(csv_files)} CSV files in {self.data_dir}")
        return csv_files
    
    def load_sample_file(self):
        """
        Load a single sample file for testing
        
        Returns:
            pd.DataFrame or None: Sample data or None if loading failed
        """
        csv_files = self.get_csv_files()
        if not csv_files:
            logger.error("No CSV files found")
            return None
        
        # Load the first file as a sample
        sample_file = csv_files[0]
        logger.info(f"Loading sample file: {sample_file.name}")
        
        return self.load_csv_file(sample_file)
    
    def get_file_info(self, file_path):
        """
        Get detailed information about a CSV file
        
        Args:
            file_path (str or Path): Path to CSV file
            
        Returns:
            dict: File information including size, shape, and column info
        """
        try:
            # Get file size first
            file_size = os.path.getsize(file_path)
            file_size_mb = file_size / (1024 * 1024)
            
            # Load file info
            df = self.load_csv_file(file_path, process_chunks=False)
            if df is None:
                return None
            
            file_info = {
                'file_path': str(file_path),
                'file_name': Path(file_path).name,
                'file_size_mb': round(file_size_mb, 2),
                'shape': df.shape,
                'columns': list(df.columns),
                'data_types': df.dtypes.to_dict(),
                'memory_usage_mb': round(df.memory_usage(deep=True).sum() / (1024 * 1024), 2),
                'null_counts': df.isnull().sum().to_dict(),
                'estimated_chunks': max(1, df.shape[0] // self.default_chunk_size)
            }
            
            return file_info
            
        except Exception as e:
            logger.error(f"Error getting file info for {file_path}: {e}")
            return None
    
    def get_memory_usage(self):
        """Get current system memory usage"""
        try:
            memory = psutil.virtual_memory()
            return {
                'total_gb': round(memory.total / (1024**3), 2),
                'available_gb': round(memory.available / (1024**3), 2),
                'used_gb': round(memory.used / (1024**3), 2),
                'percent_used': round(memory.percent, 1)
            }
        except Exception as e:
            logger.warning(f"Could not get memory usage: {e}")
            return None

# Example usage and testing
if __name__ == "__main__":
    # Test the enhanced DataLoader
    try:
        loader = DataLoader()
        
        # Show memory usage
        memory_info = loader.get_memory_usage()
        if memory_info:
            print(f"Memory Usage: {memory_info['percent_used']}% used")
            print(f"Available: {memory_info['available_gb']} GB")
        
        # Test loading a sample file
        sample_data = loader.load_sample_file()
        
        if sample_data is not None:
            print("✅ Sample file loaded successfully!")
            print(f"Shape: {sample_data.shape}")
            print(f"Columns: {list(sample_data.columns)}")
            print(f"First few rows:")
            print(sample_data.head())
        else:
            print("❌ Failed to load sample file")
            
    except Exception as e:
        print(f"❌ Error testing DataLoader: {e}")