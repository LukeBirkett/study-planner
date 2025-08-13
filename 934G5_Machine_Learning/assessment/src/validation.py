"""
Essential Data Validation Module
Lightweight validation for NASA weather data - focused on what matters
"""

import pandas as pd
import logging
from typing import Dict, Any, List
from pathlib import Path

logger = logging.getLogger(__name__)

class EssentialValidator:
    """Essential validation for NASA weather datasets - simple and focused"""
    
    def __init__(self):
        """Initialize with NASA weather data validation rules"""
        # Required columns for NASA weather data
        self.expected_columns = ['year', 'month', 'day', 'hour', 'longitude', 'latitude']
        
        # Geographic coordinate bounds (standard Earth bounds)
        self.geo_bounds = {
            'longitude': (-180, 180),
            'latitude': (-90, 90)
        }
        
        # Temporal data bounds (reasonable ranges for NASA data)
        self.temporal_bounds = {
            'year': (2020, 2030),    # Recent years
            'month': (1, 12),         # 1-12 months
            'day': (1, 31),           # 1-31 days
            'hour': (0, 23)           # 0-23 hours
        }
        
        logger.info("EssentialValidator initialized with NASA weather data rules")
    
    def validate_file(self, df: pd.DataFrame, file_path: str = None) -> Dict[str, Any]:
        """
        Essential validation - only what you actually need
        
        Args:
            df: DataFrame to validate
            file_path: Optional file path for logging
            
        Returns:
            Dict with validation results and specific issues
        """
        if file_path:
            logger.info(f"Validating file: {Path(file_path).name}")
        else:
            logger.info("Validating dataset")
        
        # Run essential validations
        validation_results = {
            'file_path': file_path,
            'overall_valid': True,
            'issues': [],
            'warnings': [],
            'validation_details': {}
        }
        
        # 1. Schema Validation
        schema_result = self._validate_schema(df)
        validation_results['validation_details']['schema'] = schema_result
        if not schema_result['valid']:
            validation_results['overall_valid'] = False
            validation_results['issues'].extend(schema_result['errors'])
        
        # 2. Geographic Validation
        geo_result = self._validate_geographic(df)
        validation_results['validation_details']['geographic'] = geo_result
        if not geo_result['valid']:
            validation_results['overall_valid'] = False
            validation_results['issues'].extend(geo_result['errors'])
        
        # 3. Temporal Validation
        temp_result = self._validate_temporal(df)
        validation_results['validation_details']['temporal'] = temp_result
        if not temp_result['valid']:
            validation_results['overall_valid'] = False
            validation_results['issues'].extend(temp_result['errors'])
        
        # Log validation summary
        if validation_results['overall_valid']:
            logger.info(f"✅ File validation PASSED")
        else:
            logger.warning(f"⚠️ File validation FAILED: {len(validation_results['issues'])} issues found")
        
        return validation_results
    
    def _validate_schema(self, df: pd.DataFrame) -> Dict[str, Any]:
        """Validate basic schema - columns exist and have correct types"""
        result = {
            'valid': True,
            'errors': [],
            'column_count': len(df.columns),
            'row_count': len(df)
        }
        
        # Check if DataFrame is empty
        if df.empty:
            result['valid'] = False
            result['errors'].append("Dataset is empty")
            return result
        
        # Check required columns exist
        missing_columns = set(self.expected_columns) - set(df.columns)
        if missing_columns:
            result['valid'] = False
            result['errors'].append(f"Missing required columns: {list(missing_columns)}")
        
        # Check data types for key columns
        for col in ['longitude', 'latitude']:
            if col in df.columns:
                if not pd.api.types.is_numeric_dtype(df[col]):
                    result['errors'].append(f"Column {col} is not numeric: {df[col].dtype}")
                    result['valid'] = False
        
        return result
    
    def _validate_geographic(self, df: pd.DataFrame) -> Dict[str, Any]:
        """Validate geographic coordinates are within reasonable bounds"""
        result = {
            'valid': True,
            'errors': [],
            'invalid_coordinates': 0
        }
        
        for coord_col, (min_val, max_val) in self.geo_bounds.items():
            if coord_col in df.columns:
                # Check bounds
                invalid_mask = (df[coord_col] < min_val) | (df[coord_col] > max_val)
                invalid_count = invalid_mask.sum()
                
                if invalid_count > 0:
                    result['valid'] = False
                    result['errors'].append(f"{invalid_count} {coord_col} values outside bounds [{min_val}, {max_val}]")
                    result['invalid_coordinates'] += invalid_count
        
        return result
    
    def _validate_temporal(self, df: pd.DataFrame) -> Dict[str, Any]:
        """Validate temporal data is within reasonable ranges"""
        result = {
            'valid': True,
            'errors': [],
            'temporal_range': {}
        }
        
        for time_col, (min_val, max_val) in self.temporal_bounds.items():
            if time_col in df.columns:
                # Check bounds
                invalid_mask = (df[time_col] < min_val) | (df[time_col] > max_val)
                invalid_count = invalid_mask.sum()
                
                if invalid_count > 0:
                    result['valid'] = False
                    result['errors'].append(f"{invalid_count} {time_col} values outside bounds [{min_val}, {max_val}]")
                
                # Store actual range for reference
                result['temporal_range'][time_col] = (int(df[time_col].min()), int(df[time_col].max()))
        
        return result
    
    def generate_validation_report(self, validation_results: Dict[str, Any]) -> str:
        """Generate a simple, readable validation report"""
        report = []
        report.append("=" * 50)
        report.append("NASA WEATHER DATA VALIDATION REPORT")
        report.append("=" * 50)
        
        if validation_results['file_path']:
            report.append(f"File: {Path(validation_results['file_path']).name}")
        
        report.append(f"Status: {'✅ PASSED' if validation_results['overall_valid'] else '❌ FAILED'}")
        report.append("")
        
        # Summary
        if validation_results['issues']:
            report.append("ISSUES FOUND:")
            for issue in validation_results['issues']:
                report.append(f"  ❌ {issue}")
        else:
            report.append("✅ No validation issues found")
        
        # Validation details
        if validation_results['validation_details']:
            report.append("")
            report.append("VALIDATION DETAILS:")
            for validation_type, details in validation_results['validation_details'].items():
                report.append(f"  {validation_type.upper()}: {'✅ PASSED' if details['valid'] else '❌ FAILED'}")
                if 'temporal_range' in details:
                    report.append(f"    Temporal ranges: {details['temporal_range']}")
        
        report.append("=" * 50)
        return "\n".join(report)

# Example usage
if __name__ == "__main__":
    # Test the validator with sample data
    validator = EssentialValidator()
    
    # Create sample data
    sample_data = pd.DataFrame({
        'year': [2024, 2024, 2024],
        'month': [4, 4, 4],
        'day': [1, 1, 1],
        'hour': [0, 6, 12],
        'longitude': [-120.0, -119.5, -119.0],
        'latitude': [34.0, 34.5, 35.0]
    })
    
    # Validate the sample data
    results = validator.validate_file(sample_data, "sample_data.csv")
    
    # Generate and print report
    report = validator.generate_validation_report(results)
    print(report) 