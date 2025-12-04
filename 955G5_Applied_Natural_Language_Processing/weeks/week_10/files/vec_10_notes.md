# Lecture 10 - Question Answering

A pooling of all modules content

Prev: 
- POS tagging
- Information Extraction

Today:
- Question Answering
- Info Retrieval
- QA
- QA

## Computers thtat can answer questions

IBM Watson in 2011. took a lot of work and input

## QUestion Answering

Focus on factiod question answers

Answers by facts and small piecing of text

Not opinion based, has to be correct answer

Facts often include named entities

## Paradigms in Question Answering

Info Retrivlal (IR-Based)

vs

Knowledge Based

Database that we have built

## Info Ret

i.e. type query into google

obtain info resrouces to an info need

from a large collection of info resources


info need is expressed as query

## issues

IR issues

1. Accuracy - find what we should find

2. Efficency - speed. i.e. cant compare to every document, need prprocessing. indexing 

3. revelance ranking - the ordering of reterival, quality of ret

## Relvant Documents

Goal is to ident rel docs

Could just look for matching keywords

but a query language would be better

i.e. NOT searchings, IN searches

Simple form in boolnea

Rank Ret, return but also have an order of qual

Start with bool, look for keyword or follow query

## Boolean IR

Return a doc or not

Doc repped as BoW

Query expressed as bool comin of keyworks 

[INSERT EXAMPLE QUERY]

Most useful when you have a small corpus of docus

Legal or archival e.g.

Ouput is just docs

no partial match

no ranl

## Canon of terms

Apply starts canons of terms: case norm, num norm, stopwords, stem, lem

Must apply the prop to both the docs and the query

Do norm to reduce vocab

improvees storage, efficent, querying fast and often improved recall

[what is recall again]

## MEasuring Performance

Ret Docs vs Relevant Docs

use startard measures FP TP FN

[insert grapic]

Precision 

Recall

F1

[Re-do defintions and equations here]

note, it can be difficult to measure recall

falses are hard to measure

this is the set of relevant docs that werent retrireved 

i.e. image scale of web, imposs to find all relevant docs

Recall = TP/TP/FN

## Indexing Documents

quick way of getting docs

invertsed index

replace  keywords with numeric ids

because more efficent

then do the same for docs

term_id -> [list of doc ids]

^ that is the invereted part

list is called posting

should be in order (of what?)

small -> bigger

this is is a procpessing step 

each time a new doc comes in then preprop

## ret with an inter index

queryy = collection of connected with logical operators

keyworkd, to term id, to doc id

return list of docs that match query

## interseciton algo

find intersec of list of docs (what matches)

because each posting list is sorted 

loop through the list and into each doc

compare 2 lists 

[COPY AND UNPACKED CODE]

[work through example]

[algo keeps the O(n) down using pointers]

algo only works if it is in order

[this is an and/INTERSECT algo]

[how to change to a union algo (OR)?]

[example work through again]

## More Implementation Details

[refollow lecture and slide notes]

## Ranked Ret

What is we want to rank ret docs

Bool will be useless for large corpuses as too many matching docs

We need ranking to just return the best

if less common query terms occor more freq in a doc then it will be more relevant

## Relevancy Sorting

tf-idf scoring can be calc for each doc

want to turn this into a ranking

could just use sum of tf-idf values 

or could use a product. here is any are zero then will wipe out document rank/score

could use cosine similar. query is a vector. doc is query in space. look at two doc vectors with td-idf. how similar query is to doc

there are diff reasons to do each to cosine is popular genrally

## Query Expansion 

[didnt listen to any of this slide]


# Part 2

## IR-based factoid question answering

Example factiod question and answers

## Many factoid questions can already be answered by web search

Google Example

## IR-based Factoid QA

Whats the architecture and process we need to approach the quesiton

[insert graphic]

## Question Processing: Things to extract from the question

what keywords can be get from the question and how

ignore stop words

determine from the question, what will the structure of the answer look like

[has a second part of the slide name. didn't listen to this much but have a breakdown of what to extract from the quesiton/query] (this was means for the while above*****

[THIS SLIDE HAS A DETAILED BREAKDOWN OF THINGS TO EXTRACT]

## Question processing

Example of how to struture what you pull out 

Would be a good slide/lecture to take detailwd notes

## Answer Type Detection: Named Entities

didn;t listen

## Answer Type Taxonomy

Get best answers if you come up with taxonomy

coarser classes (6) and finer sub-classes (50) based on the coarses classes

used for answer type detection

where > leads to coarse location class > but may not be clear the sub-clas

depends on how much info we have

## Part of Li & Roth’s Answer Type: Taxonomy

graphic from paper 

## Answer Types

questions get a pair answer types

similar to question answer det up

## More Answer Types


## Answer types in Jeopardy

2500 answer ttypes from 20000 questions

mpost freq types

appear to be male biased

## Answer Type Detection 1

Could do hand written rules. if who you know its person

But if you have 2500 answer types this would be a big class

ML approach, identify features to acheive this

Hyrid most likely, use some handwritten an inputs

## Answer Type Detection 2

Regex rules

Question headword trick

wh-word + first noun

## Answer Type Detection 3

[GOOD SLIDE ON THE BREAKDOWN ON HOW TO APPROACH THE PROBLEM]

Define tax, annontate date, feature train

## Features for Answer Type Detection

[breakdown of what to include as features]

## Keyword Selection Algorithm


## Choosing keywords from the query



## Factoid Q/A

[Earlier Grapgic Again]

## Passage Retrieval

Retrev docs

then segment the docs into smaller units, i.e. paragraphs

3. passage ranking

get best sub-text based on Q

## Features for Passage Ranking



## Factoid Q/A


## Answer Extraction

run asnwer type named-ent tagger across passage

return string with right type

e.g. person -> pull out people in passages

if only 1 person in passage then we have the asnwer

## Ranking Candidate Answers 1

What if mutli cands in passagege

we need to rank

## Ranking Candidate Answers 2



## Use machine learning: Features for ranking candidate answers

[didnt follow this slide but has some good content]

## Common Evaluation Metrics

accuracy = simple

start of poor system and improve part by part

but accruacy only goes 0 to 1

we want a metric that can increment with rewards

2. Mean Recoprocal Rank

Allows this better

[TAKE BETTER NOTES ON HOW IT WORKS]

MRR 

[insert equation and expplain]



## Knowledge-based approaches (Siri)

Instead of going to cll of documents, go a database of facts

Need to turn question into a form that can query a database

map query to databse

may types of databases, not just standard tabular

## Relation Extraction


## Temporal Reasoning


## Geospatial knowledge (containment, directionality, borders)


## Context and conversation in virtual assistants like Siri



## Hybrid approaches (IBM Watson)


## What Now?

## Making progress



