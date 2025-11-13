# Lecture 7 - Distributional Semantics

Lexical semantis and wordnet was a handcrafted dictionary of words

this week we are taking an unsupervised approach

- what it is?
- how to compute?
- applications?
- advantages, disadvantages

## Distributional Semantics

you know a word what a word means by the words surrounding it

## bootsrapping the semantics of unknown words

words and sentances have context

## Dist Semantics in Doc Classification

Imagine a NB classifiers with small training sample

test doc has an unseen word

by using dist semantics to a v large unlabled cpripus we can work out related words to the unknown

can assume that a similar word has a similar conditional probability 

P(unknown|class)  =approx  P(similar|class)


## Features for Capturing Facets of Meaning

-Dependancy parsing: "is subject of eat", "is object of eat"

but this is quite expesnsive

instead just look at workds around it (window)

bag of words around it

this is proximity of words

## Context window

Sliding window aquiring counts

word = +-1    <- window of 1 either side

output = ate : {maachine:1, my:1}

context window will normally be quite big, i.e. 10-20

window size is a hyper paramter to optimize

the context words are features


## Similarity Measure: Jaccards Measure

Over lap of sets as a proportion of the union of two sets

set-theory similarity measure

can apply to feature counts


## Cosine Similarity

main measure of use

similar words have a smaller angle 

applying to feature windows

treat feature counts as a vector and calculate the cosine (dot prods)


## Pointwise Mutual Information (PM)

Measures amount of info we gain by seeing  word and feature together

some words occur all the time so their weighting should be less

they want to understand what we expect

if words co-occur more than expections we can infer that the two words are important to one another

this is what pim measures

[THIS HAS SOME FORMULAS]

PMI is a single output metric, i.e. 1.42

the target word will have a pmi for each feature

t: banna
f: yellow
pmi: 1.42

but uses how column (all features) to calc each pmi

use log to calc so can't be calced if 0 occurances

just omit calc and imput 0 

## Automatic Thesaurus Generation

Extract feature reps based on co-occurances

convert reps to ppmi

calc cosines for all pairs 
- very expensive
- reduce words

find nearest neighbours for each word

## Evaluations

are the reps working?

are they good and meaningful reps

- intrisitic evals
	- direct evals
	- human synonmy judgements
	- manually compoied thesauruses

- extrinist eval
	- performance gain in an application
	- by how much did it improve a model (nb for example)


## Senses and Distribution Semantics

dis reps are of words, not senses

although dist neighbours tend to reflect predominant sense of word

## Semantic Relationships 

neigbourhoods contain all types of relationships

## Distinguishing Relationships

No just the words around "balls"

but the types of words around it

verbs, adjectives etc 

gramatic dependancies

more computationallly intense

context window vs dependancy parse


