def myfunc(b):
    
    x=0
    a=2
    
    for i in range(100000):
        x+=a*i/b*(i+1) 
    
    return x