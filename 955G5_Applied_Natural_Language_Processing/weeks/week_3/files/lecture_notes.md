# Lecture 3 Docu Classification

Feature extraction, word list classifers

Evaluation metrics: acc, err, conf matrix, prec, recall, f1

lectures focus is binary/boolean classification

review > classifier > pos or neg

will build up to using naive bayes next week

a mutliclass classifier can be ensebled from several binary classifier

#### general issues with classifers
- specificy the diffference between two classes
- adpating to changing/updating data (lanugage)
- unbalanced classes

#### general architecture of doc classif

doc > feature extractor > features > classifer

feature extraction is just pre-processing and turns into a vector of features

classifer calls on model(s)

#### words a features

create a document as a bag-of-words as words also tell us alot about the document

BoW ignores the order

sometimes we can ignore the frequency of words too

this isn't ideal because order holds context. however it is a good starting point and allows for quicker and cheaper results

#### feature respresentation

respresenting a document as a dictionary is the standard way to do this python

{words: some data}

the data could be freq, a boolen, binary rep

#### vectors and matrices

another way to store data

this route will have lots of zeros

cols = words
rows = document

the row is a document vector

dictionaries are a way to avoid all of the zeroes and save space

#### word list classifers

options for scoring words in documents:
1. frequency
2. uniform score, i.e. 0 or 1 for appearing or not
3. weighted by importance

#### automatic word lists

use a smple of labelled docs

class imbalane can be a big issue

partition this data into training and test set

labelled data is harder to aquire and often expension 

labelled data sets tend to be smaller

but labelled data is the best data

#### evaluation classifiers

want to be able to measure how well our data does on unseen data

eval on test set

best practice is training-dev-test sets (3)

f1 is the harmonic mean between precision and recall


