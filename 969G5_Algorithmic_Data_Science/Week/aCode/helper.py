import random
import numpy as np
import time

def make_rand_list1(n):
    random.seed(42)
    l = []
    for i in range(n):
        l.append(random.randint(1,100))
    return l


def timeit(somefunc,*args,repeats=25,**kwargs):
    times=[]
    for i in range(repeats):
        starttime=time.time()
        ans=somefunc(*args,**kwargs)
        endtime=time.time()
        timetaken=endtime-starttime
        times.append(timetaken)
    
    mean=np.mean(times)
    stdev=np.std(times)
 
    return (mean,stdev)

def insertion_sort(alist):
    for index in range(1,len(alist)):
        item=alist[index]
        sofar=index-1
        while sofar > -1 and alist[sofar]>item:
            alist[sofar+1]=alist[sofar]
            sofar -= 1
        alist[sofar+1]=item
    return alist