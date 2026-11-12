def work_that_CPU(num_loops):
    import random
    import multiprocessing
    import time

    startTime = time.time()
    
    for w in range(num_loops):
        random.random()
        
    endTime=time.time()
    
    process_name = multiprocessing.current_process().name
    
    # Create a text file containing the name of the process and the time taken for it to run.
    text_file = open("TimedProcess"+str(process_name)+".txt", "w")
    my_string = str(process_name)+" took "+str(endTime-startTime)+" seconds"
    text_file.write(my_string)
    text_file.close()