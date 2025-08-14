    # avgsurft_df_rename = avgsurft_df.rename(columns={'AvgSurfT_inst': 'n1'})
    # final_df = pd.merge(target_instance, avgsurft_df_rename, on=['longitude', 'latitude', 'year', 'month', 'day'], how='left')

    # # Now you can safely modify it
    # target_instance['date'] = pd.to_datetime(target_instance[['year', 'month', 'day']])
    # avgsurft_df['date'] = pd.to_datetime(avgsurft_df[['year', 'month', 'day']])

    # for i in range(1, 30):
    #     start_time = time.perf_counter()

    #     # Create a temporary dataframe for each preceding day
    #     temp_df = avgsurft_df.copy()

    #     # Shift the date for the preceding day
    #     # print("before:", temp_df['date'][i])
    #     temp_df['date'] = temp_df['date'] + pd.Timedelta(days=i)
    #     # print("after:", temp_df['date'][i])

    #     # Extract the new year, month, day from the shifted date
    #     temp_df['year'] = temp_df['date'].dt.year
    #     temp_df['month'] = temp_df['date'].dt.month
    #     temp_df['day'] = temp_df['date'].dt.day

    #     # Drop the date column
    #     temp_df = temp_df.drop('date', axis=1)

    #     # Rename the value column to avoid collision, e.g., 'value_n-1'
    #     temp_df = temp_df.rename(columns={'AvgSurfT_inst': f'n{1+i}'})


    #     # Merge the temporary dataframe with the main one
    #     final_df = pd.merge(final_df, temp_df, on=['longitude', 'latitude', 'year', 'month', 'day'], how='left')
    #     end_time = time.perf_counter()
    #     print(f"Loop execution time {i}: {end_time - start_time:.2f} seconds")
    # print(final_df)