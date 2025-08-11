# Data Specification

The ML Coursework 2025A3 dataset was created for the A3 assessment of the 2025 Machine Learning module. It is made up of data extracted from the NASA database.

The dataset contains 132 csv files, each covering a category of variables. See each csv file for the variables it contains (you can preview each file by opening it using Microsoft Excel). The table below provides descriptions of the variables. Note that the files may not have the same number of rows and columns due to differences in data available. However, longitude, latitude, year, month, day, and hour variables are common to all files.

| Variable | Full name | Additional info | Unit | Resolution | Source |
| :--- | :--- | :--- | :--- | :--- | :--- |
| longitude | Longitude | Degrees east | 1.0 degree | | [https://disc.gsfc.nasa.gov/datasets/GLDAS_CLSM10_3H_2.1/summary](https://disc.gsfc.nasa.gov/datasets/GLDAS_CLSM10_3H_2.1/summary) |
| latitude | Latitude | Degrees north | 1.0 degree | | |
| year | Year | | 1 year | | |
| month | Month in the year | Months 1, 2, 3, ... in a year always correspond to Jan, Feb, March, ... | 1 month | | |
| day | Day in the month | | 1 day | | |
| hour | Hour in the day | | 3 hours | | |
| AvgSurfT_inst | Average surface skin temperature | 'skin' here refers to the top surface of the earth | Kelvin per longitude and latitude pair every three hours | | |
| CanopInt_inst | Plant canopy surface water | 'canopy' here refers to the top portion of a cluster of plants | Kilogram per metre | | |
| LWdown_f_tavg | Downward longwave radiation flux | Thermal radiation power, 'thermal' here refers to heat radiation from the sun | Watt per metre | | |
| Psurf_f_inst | Surface air pressure | | Pascal | | |
| Qair_f_inst | Specific humidity | Mass of water per mass of air | Kilogram per kilogram | | |
| Rainf_tavg | Rain precipitation rate | Amount of rainfall per area per time | Kilogram per squared metre per second | | |
| SnowDepth_inst | Snow depth | | Metre | | |
| SWdown_f_tavg | Downward shortwave radiation flux | Solar radiation power, 'solar' here refers to ultraviolet radiation from the sun | Watt per squared metre | | |
| Tair_f_inst | Air temperature | | Kelvin | | |
| TVeg_tavg | Transpiration | Movement of water through vegetation | Watt per squared metre | | |
| Wind_f_inst | Wind speed | | Metre per second | | |