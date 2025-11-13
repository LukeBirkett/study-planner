# iLecture 6 - Similarity
ip
Different ways of measuring similarity

Applications:
- Similarity of documents (e.g. plagarism)
- Clusterings, indentify groups and sub-classes

## Set-Theoretic Notions of Similarity

Jaccard ratio is a measure of how simialr to sets are

Measures the ratio of the cardinality (size) of an intersection of two sets over the size of the union of the two ssets 

if two sets are the same, then the intersect is the same size as the union = 1

if sets are completely different then = 0 

#### Jaccards in python (lists)

Loop through list 1 and check if element is in list_2. if it is then = INTERSECT

The union is the combined length of each list minus the intersect

finally ratio = int/union


o-notation

1. will be at least O(N) as we need to loop through first list

2. worst case scenario is to loop all the way through the second list too

O(N^2)

# TAKE DURING LECTURE 7 catch up 


 LPF corner frequencies to sweep over
