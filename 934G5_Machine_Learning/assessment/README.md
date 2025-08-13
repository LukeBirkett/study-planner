# Data Processing Pipeline - ML Coursework 2025A3

**Rain Prediction Data Processing Pipeline**  
*Transform 132 NASA CSV files into ML-ready datasets*

## 🎯 Project Overview

This pipeline processes NASA weather data to create train/test/validation datasets for rain prediction models. It handles temporal aggregation, data transformation, and split management while optimizing for M1 Pro MacBook performance.

## 📁 Project Structure

```
assessment/
├── src/                    # Source code
│   ├── data_loader.py     # CSV loading and validation
│   ├── id_system.py       # Location-date ID management
│   ├── split_strategy.py  # Train/test/validation assignment
│   ├── aggregation.py     # Temporal aggregation logic
│   ├── transformation.py  # Data format conversion
│   ├── chunking.py        # Memory-efficient processing
│   ├── optimization.py    # M1 Pro optimizations
│   ├── error_handling.py  # Error management
│   ├── validation.py      # Data quality checks
│   └── pipeline.py        # Main orchestration
├── tests/                 # Unit and integration tests
├── data/                  # Input/output data
│   ├── raw/              # 132 NASA CSV files
│   ├── interim/          # Intermediate processing
│   └── processed/        # Final ML datasets
├── logs/                  # Processing logs
├── config.py              # Configuration parameters
├── main.py                # Entry point
└── requirements.txt       # Python dependencies
```

## 🚀 Quick Start

### 1. Setup Environment
```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # On macOS/Linux
# or
venv\Scripts\activate     # On Windows

# Install dependencies
pip install -r requirements.txt
```

### 2. Run Pipeline
```bash
python main.py
```

## 📊 Data Processing Strategy

### **Split Strategy**: Interleaved Monthly
- **Training**: March-December 2024 (10 months)
- **Testing**: January 2025 (1 month)
- **Validation**: February 2025 (1 month)

### **Data Flow**:
1. **Raw CSV Files** → Load and validate
2. **Temporal Aggregation** → 3-hourly to daily
3. **Data Transformation** → 2D to 3D format
4. **Split Assignment** → Train/test/validation
5. **Output** → ML-ready datasets

## 🛠️ Key Features

- **Memory Optimization**: Designed for 16GB M1 Pro
- **Split Integrity**: No data leakage across splits
- **Error Handling**: Robust processing with graceful degradation
- **Progress Tracking**: Real-time monitoring and ETA
- **Data Lineage**: Complete processing audit trail

## 📝 Configuration

Edit `config.py` to adjust:
- Chunk sizes and memory limits
- Split ratios and strategies
- Data type optimizations
- Validation thresholds

## 🧪 Testing

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=src

# Run specific test file
pytest tests/test_data_loader.py
```

## 📈 Performance

- **Target Memory**: < 12GB (leaving 4GB for system)
- **Processing Time**: Optimized for M1 Pro performance
- **Parallel Processing**: Multi-core utilization
- **Chunking**: Memory-efficient batch processing

## 🚨 Limitations

- **Dataset Size**: Only 12 months of data available
- **Seasonal Coverage**: Limited winter training data
- **Geographic Resolution**: 1.0 degree grid spacing
- **Temporal Resolution**: 3-hourly to daily aggregation

## 📚 Documentation

- **Implementation Roadmap**: `docs/implementation_roadmap.md`
- **Data Processing Notes**: `docs/data_processing_notes.md`
- **Code Documentation**: Inline docstrings and comments

## 🤝 Contributing

This is a university coursework project. The pipeline is designed to be:
- **Educational**: Clear, well-documented code
- **Robust**: Production-quality error handling
- **Efficient**: Optimized for the target hardware
- **Reproducible**: Complete data lineage tracking

## 📄 License

University coursework project - not for commercial use.

---

**Status**: Ready for Implementation  
**Next Step**: Follow the Implementation Roadmap in `docs/implementation_roadmap.md`
