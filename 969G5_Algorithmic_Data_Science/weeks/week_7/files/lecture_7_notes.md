# Lecture 7 - Map Reduce 

## Finishing Week 6 

Get Jacc's sim quickly w/o going through every time

Avoid looping through all to get intersect and union

Do permutations, look for first entries and should give an idea of Jacc

Idea of locality sensitive hashing. don't need to compute all pairs, jsut nearby ones

## Locality-Sensitive Hashing

Efficently find nearest neightbours without computing all-pair similarities

General approach is to hash items several times in a way that holds similarity info

Any pair hashed in the same bucket is a candidate pair for computaiton

Hashing is not perfect and there will be false positives but these will be found out during similarity computation 

Goal is to compute less

**[NEED TO BACKGROUND READ ON LSH AND MINI HASHING]**

bands = split all sigs into groups
row = len of splits in the groups

i.e. 6 sigs. 3 bands, 2 rows

in the bands, all values have to match between sets/objects

## Complexity of LHS

O(n) to do mini hash

O(n) to do LSH (apply hash to each of n docs and look what is in each bucket)

Still O(n^2) but with factor of 10 saving on the constant (??? why does that matter)

[think it means saving on the n constant]

## SUMMARY

TAKE SUMMARY NOTES ONCE FINISHED WEEK 6 LECTURE






# Lecture 7 NOTES

[REWATCH FIRST 10 MINUTES ?????]


time-space tradeoff

for example in strassens

quicker but you need to create 7 new matricies 

this is significant extra memory req

for everything there is a time and space complexity calcualtion to make 

v similar to time comp

## Communication Complexity

this can also hold up an algo 

e.g. §how many packets of data need to be exchanged if computing an parallel?

## Map/Reduce Overview

recap: distributed systems

data centers, parralellism, clusters, nodes

to avoid issues, sys should be fault tollerant

if a component files, the sys can continue instead of having to completely restarted

division of computation into tasks, such that if one fails to complete it can be restarted without affecting other tasks (e.g., MapReduce)

MapReduce is a paradigm, not an algo, that applies many algo

write two functions map() and reduce()

run many times on small chunks of data

The system manages the parallel execution and coordination of the tasks that execute Map and Reduce, as well as dealing with the possibility that one of these tasks might fail.

### Map Reduce Example

Count word occurances in many documents

How to compute efficently?

distribute counting among many people

after we need to group and sum efficently somehow 

two rounds of computation

distribute > map > group > reduce

distribute chunks to nodes

worker at node counts words

key-value storing of words according to a hash function (grouping) (itermediate file)

int files traasfer to nodes responible for key-value pairs

worker at node adds up key-value pairds and produces a single output file with the word freqs


input > map task > intermediate files >  reduct task > output

### When to use MapReduce

good for data parellelism, i..e same task needs to be done many times

dont use if there is alittle calculations or changes to a database

not good for task parallelism i.e. lots of diff tasks need to be done to same piece of data

### Matrix-vector multi by MapReduce

the map function would just do one calculation

the calc is the single [i][j] mutliplication value

stored with a key (???) in a intermediate file

reduce function then sums up the associated value with a given view, i.e. vector values to be summated

### huge vectors and matrixes

divide the m/v into strips of equal widths

each map task is assigned as chunk


[FINISHING THE MM MAPREDUCE ALGOS FOR NEXT WEEK]

## Extending MapReduce


