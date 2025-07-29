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

Routes to deal with: Use domain knowledge, visualisation, statistical correlations, hypothesis creation

All of the data is given at (3) hourly rate. This granularity is unnessecary. Daily is preferred. Can be converted to daily using aggregation. Will need to decide how metrics need to be aggreggated. Normally sum or average.

Data comes as seperate CSV files per parameter. 

To organise/access the data create a base table which holds all of the desired combinations of dates and locations (long/lat). The desired data will be then joined to this base table. This will have two other uses: firstly, it will make it eaiser to highlight missing data as joins will not take place and the data will be null. secondly, index can be applied to this base table for the train/test/valid as well as batch processing. 

Conceptually, the first step in collecting all of the data together is to create tabular dataset starting with the base table which joins in all of the parameter data for a given date. 

That is to say, given a row which denoted the long-lat 10:10 for the year-month-day 2024-01-01, the param AvgSurfT_inst will be joined column wise so that the left most entry represents the value for the 2024-01-01 date and then every right sided column represents an a subsequent day with N number of columns - where N is yet to be decided. This process will be repeated for every parameter so that data set will have (N * Number of Parameters) number of columns in total (in addition to that static parameters). These columns represent the time-series structure of the dataset.

Following the establishment of this comprehensive tabular dataset 2 transformation will take place: 

1. The static parameters columns will be sliced off from the dataset and retained as its own stand alone dataset with the order retained
2. The remaining dataset will be stacked per param taking it from a 2D tabular dataset of (Number of data instances * number of joined param columns) into a 3D dataset of (Instances * N Time Series Joins * Params) where by the params are access via the 3D tensor dimension.

This second transformation is important as it is the understand input format for CNN and RNN

The data in transformation 1 is static and repeating. Hence doesnt make sense to go into CNN and RNN as temporal relationships aren't a relevant factor here. Instead it will be linked back into the pipeline at the fully connected stage in accordance to its batch/instance

The result is 3 datasets:
1. 2D static dataset
2. 3D timeseries parameter dataset
3. 1D vector of rain labels

All 3 datasets are in the same order and will be accessed together as a batch/instance

The testing and build out of this data process should be first iterated on reduced Location/Data sample, 1-2 params and lower timeseries N so that the code/process can be inspected and tested

After completed and comfortable with the outcomes, a method should be created to process the data on batches. This is because the data in total is vast and holding it all in memory would be slow and costly

Note, yet focused on here but the data also needs normalizing, scaling and augmenting. 

In additional to this, the data will need checking for NULLs and broken values. If these exist then there need to be a proccess for the data to be corrected
