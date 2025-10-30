# Lecture 5 - Document Similarity and Clusters

Previous week focused on naive bayers classigfier which is a supervised learning methhod 

This week focuses more on unsupervised methods, unlabled data


Main theme is document similarity

---

## Similarity Scenarios:

- Navigating a document collection. Find stuff similar or related
- Clustering document collection. Group similars
- Seach a collection. More efficent access

## Similarty vs Classification

- Sim is a related topic but not identical 
- Classification has a fixed number of classes, i.e. pos or neg
- Class often has labelled data

- Simiarlity has no known number of classes
- Docs in diff classes may still be similar
- Can often repurpose similarity into classes

## Vector SPace Models for Documents

Identify a fixed set of topic terms

i.e. content words, lemmas, stems

but not stop words or connectives

One dimension in space for each terms. This creates a very high dimension space

Each row is a word respresented as hot-one encoded vector

[0 0 0 0 0 1 0 0 0]

A doc could be related as combination and count of the vectors 

[0 2 4 0 1 0 5 0 ]

^ this but an really long vector

#### Measuring the Value of Term

We need a number, value or weight of a term to reflect its importance to the document 

The most obvious is term frequence

More freq words are generally more impoirtat

Ignoring stop-words

Another is document frequency

If words only occur in a few documents then they may be very specific to those documenets

That is, words that are rare and specific to a collection of documents are important and descriptive

#### Term Frequency Inverse Document Freq (TFIDF)

term freq is the num of occ of a term in a document: tf(d,t)

docu freq is the num of docs in which a term occurs: df(t)

N = documents

inverse doc freq: idf(t) = log(N/df(t))

term freq inverse doc freq: tfidf(d,t) = tf(d, t) * idf(t)

standard way that serach ingines measure important 


#### some variant options:
- boolean instead of freq counts
- term freq normailsed for doc length
- log scaled term freq

# Vector Similarity

if docs/words are vectorised we have access to way to derive similarity

think about ploting 2d/3d vectors in space

but with very many dimensions

The main measure of similar is Cosine Similarity which works around the angle between vectors

1 when vectors are in the same direction 

0 when orthogonal or right angle

cos(0) = 1
cos(90) = 0

calculared using dot product of vectors over the length normalisers

#### using cosine

Measure of similarty:
- two docs
- doc + query
- queries
- terms

# Beyond Words

So far we have assumed that topic terms are unigrames, i.e. single words

often things are described using mutliple words

i.e. hedge fund, black hole

the individual word would possibly be ambiguous

was tfidf weighting can be applied to phrases

# Collocations

n-grams which occur more often thank by chance

oberserve freq of black and hole

do they randomly occur together as a comparable rate?

if not then they are probably a signficant phrase and a bigram

can used bayes logic to look at these things

find prob of each, assume independance and take product. This is the freq of random

does oberserved bigram exceed this? 

if so then it is an important phrase

collocations are n-grams where the obs join prob is greather than the expected join prob for independant events

use the Point-wise Mutual Information (PMI) to metric this

PMI tells us how suprising it is that a phrase has occured as freq as it does

if obs > exp then pmi ratio > 1

psi is pos. THIS IS COLLOCATION

Occuring more than we expected it to. A candiate for a meaningful phrase

obs < exp, <1, pmi negative. THIS IS NOT SUPRISING


# Clusters

Grouping unsupervised to create classes

group objects that are mutually similar

+ disimilar to other obkects

object can be documents in **vector space**

#### k-means

k num of clusters

mean is the value assigned to a cluster

mean = centroid of a group of points in euclidean space

# Agglomerative Hierarchical Clustering

build up clusters by repeatedly mergingthe closest pairs of clusters

hierarchical means the clusters have internal structures
