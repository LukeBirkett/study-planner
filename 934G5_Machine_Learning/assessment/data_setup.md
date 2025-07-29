The task at hand is to predict rain or no rain in 7 days time given upto X date

The ML Coursework 2025A3 dataset was created for the A3 assessment of the 2025 Machine Learning module. It is made up of data extracted from the NASA database.

The dataset contains 132 csv, each covering a category/parameter for a given month

In total there are 11 parameters and the time scale covers Mar 2024 to Feb 2025

12 months * 11 params = 132 files

Within each file there 6 common static parameters: longitude, latitude, year, month, day, hour

The following 6 lines describe the static parameters in var_name/Full Name/Unit/Resolution format:
- [longitude, Longitude, Degrees East, 1.0 degree]
- [latitude, Latitude, Degrees North, 1.0 degree]
- [year, Year, 1, 1 year]
- [month, Month in year, 1, 1 month]
- [day, Day in the month, 1, 1 day]
- [hour, Hour in the day, 1, 3 hours]

Months 1, 2, 3 always correspond to Jan, Feb, March

The following 11 lines describe the parameters in var_name/Full Name/Unit/Resolution format:
- [AvgSurfT_inst, Average surface skin temperature, Kelvin, per longitude and latitude pair every three hours]
- [CanopInt_inst, Plant canopy surface water, Kilogram per metre, per longitude and latitude pair every three hours]
- [LWdown_f_tavg, Downward longwave radiation flux, Watt per metre, per longitude and latitude pair every three hours]
- [Psurf_f_inst, Watt per metre, Pascal, per longitude and latitude pair every three hours]
- [Qair_f_inst, Specific humidity, Kilogram per kilogram]
- [Rainf_tavg, Rain precipitation rate, Kilogram per squared metre per second]
- [SnowDepth_inst, Snow depth, Metre]
- [SWdown_f_tavg, Downward shortwave radiation flux, Watt per squared metre]
- [Tair_f_inst, Air temperature, Kelvin]
- [TVeg_tavg, Transpiration, Watt per squared metre]
- [Wind_f_inst, Wind speed, Metre per second]

The field Rainf_tavg will be used as the label vector leaving only 10 parameters 

Note that params should be checked for correlations and potentially not used. For example, Plant canopy surface water and Transpiration may simply be copies of the label data. This is known as data leakage and can potentially lead to overfitting the training data and having poor generalization 
