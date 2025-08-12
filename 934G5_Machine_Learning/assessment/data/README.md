# Dataset Information

## Data Specification
Please place your data specification document in this folder.

## Expected Files
- [x] Data specification document
- [ ] Dataset file(s)
- [ ] Any additional data documentation

## Data Structure Notes
- **Target Variable**: Binary classification (rain vs no rain)
- **Prediction Horizon**: 1 week ahead
- **Available Data**: Up to 17 June 2036
- **Target Date**: 24 June 2036

## Data Preprocessing Checklist
- [ ] Examine data structure and format
- [ ] Identify features and target variables
- [ ] Check for missing values and data quality
- [ ] Understand temporal aspects of the data
- [ ] Document any data transformations needed

---

# Data Specification

The ML Coursework 2025A3 dataset was created for the A3 assessment of the 2025 Machine Learning module. It is made up of data extracted from the NASA database.

The dataset contains 132 csv files, each covering a category of variables. See each csv file for the variables it contains (you can preview each file by opening it using Microsoft Excel). The table below provides descriptions of the variables. Note that the files may not have the same number of rows and columns due to differences in data available. However, longitude, latitude, year, month, day, and hour variables are common to all files.

| Variable       | Full name | Additional info         | Unit          | Resolution  |
| :---           | :---      | :---                    | :---          | :---        |
| longitude      | Longitude |                         | Degrees east  | 1.0 degree  |
| latitude       | Latitude  |                         | Degrees north | 1.0 degree  |
| year           | Year      |                         |               | 1 year      |
| month          | Month     | Jan, Feb, Mar = 1, 2, 3 |               | 1 month     |
| day            | Day       |                         |               | 1 Day       |
| hour           | Hour      |                         |               | 3 Hours     |
| AvgSurfT_inst  | Average surface skin temperature | 'skin' =  top surface of the earth | Kelvin | PLL3H |
| CanopInt_inst  | Plant canopy surface water | 'canopy' = top portion of a cluster of plants | Kilogram per metre | PLL3H |
| LWdown_f_tavg  | Downward longwave radiation flux | Thermal radiation power | Watt per metre | PLL3H |
| Psurf_f_inst   | Surface air pressure |  | Pascal | PLL3H |
| Qair_f_inst    | Specific humidity | Mass of water per mass of air  | Kilogram per kilogram |  |
| Rainf_tavg     | Rain precipitation rate | Amount of rainfall per area per time | Kilogram per squared metre per second |  |
| SnowDepth_inst | Snow depth |  | Metre |  |
| Tair_f_inst    | Air temperature |  | Kelvin |  |
| TVeg_tavg      | Transpiration | Movement of water through vegetation | Watt per squared metre |  |
| Wind_f_inst    | Wind speed |  | Metre per second |  |

* PLL3H = per longitude and latitude pair every three hours