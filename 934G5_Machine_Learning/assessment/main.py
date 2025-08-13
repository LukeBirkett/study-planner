#!/usr/bin/env python3
"""
Main entry point for the Data Processing Pipeline
ML Coursework 2025A3 - Rain Prediction
"""

import sys
import os

# Add src directory to Python path
sys.path.append(os.path.join(os.path.dirname(__file__), 'src'))

from pipeline import DataProcessingPipeline

def main():
    """Main execution function"""
    print("🚀 Starting Data Processing Pipeline...")
    print("Project: ML Coursework 2025A3 - Rain Prediction")
    print("=" * 50)
    
    # Initialize the pipeline
    pipeline = DataProcessingPipeline()
    
    # Run the pipeline
    try:
        pipeline.run()
        print("✅ Pipeline completed successfully!")
    except Exception as e:
        print(f"❌ Pipeline failed: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()