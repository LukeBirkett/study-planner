"""
Data Loader Module
Simple and clean CSV file loading for NASA weather data
"""

import pandas as pd
from pathlib import Path
import logging

# Set up basic logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class DataLoader:
    """Simple CSV file loader for NASA weather data"""
    
    def __init__(self, data_dir="data/raw"):
        """
        Initialize the DataLoader
        
        Args:
            data_dir (str): Path to directory containing CSV files
        """
        self.data_dir = Path(data_dir)
        self.expected_columns = ['year', 'month', 'day', 'hour', 'longitude', 'latitude']
        
        # Validate data directory exists
        if not self.data_dir.exists():
            raise FileNotFoundError(f"Data directory not found: {self.data_dir}")
        
        logger.info(f"DataLoader initialized with directory: {self.data_dir}")
    
    def load_csv_file(self, file_path, validate=True):
        """
        Load a CSV file with essential validation
        
        Args:
            file_path (str or Path): Path to CSV file to load
            validate (bool): Whether to run essential validation
            
        Returns:
            pd.DataFrame or None: Loaded data or None if loading failed
        """
        try:
            logger.info(f"Loading CSV file: {file_path}")
            
            # Load the CSV file
            df = pd.read_csv(file_path)
            
            # Basic validation
            if df.empty:
                logger.warning(f"File is empty: {file_path}")
                return None
            
            # Essential validation if requested
            if validate:
                from validation import EssentialValidator
                validator = EssentialValidator()
                validation_results = validator.validate_file(df, str(file_path))
                
                if not validation_results['overall_valid']:
                    logger.error(f"Validation failed for {file_path}")
                    logger.error(f"Issues: {validation_results['issues']}")
                    return None
                
                logger.info(f"✅ Validation passed for {file_path}")
            
            logger.info(f"Successfully loaded {file_path}: {df.shape[0]} rows, {df.shape[1]} columns")
            return df
            
        except Exception as e:
            logger.error(f"Error loading {file_path}: {e}")
            return None
    
    def _validate_basic_schema(self, df):
        """Basic schema validation"""
        try:
            # Check if file has data
            if df.empty:
                logger.error("File is empty")
                return False
            
            # Check expected columns exist
            missing_columns = set(self.expected_columns) - set(df.columns)
            if missing_columns:
                logger.error(f"Missing expected columns: {list(missing_columns)}")
                return False
            
            logger.info("Schema validation passed")
            return True
            
        except Exception as e:
            logger.error(f"Schema validation error: {e}")
            return False
    
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
        Get basic information about a CSV file
        
        Args:
            file_path (str or Path): Path to CSV file
            
        Returns:
            dict: File information including size, shape, and column info
        """
        try:
            # Get file size
            file_size = file_path.stat().st_size
            file_size_mb = file_size / (1024 * 1024)
            
            # Load file info
            df = self.load_csv_file(file_path)
            if df is None:
                return None
            
            file_info = {
                'file_path': str(file_path),
                'file_name': Path(file_path).name,
                'file_size_mb': round(file_size_mb, 2),
                'shape': df.shape,
                'columns': list(df.columns),
                'data_types': df.dtypes.to_dict()
            }
            
            return file_info
            
        except Exception as e:
            logger.error(f"Error getting file info for {file_path}: {e}")
            return None

# Example usage and testing
if __name__ == "__main__":
    # Test the simplified DataLoader
    try:
        loader = DataLoader()
        
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
