# WEEK 9 - Named entity recognition (NER) and information extraction (IE)

## Last Week 

Speech tagging

Sequence labelling

Part-of-speech tagging using Hidden Markov Models

## This week 

Focus of information extraction
- identify things being names
- what are their relationships

Breaking down sentances into chunks
- Chunking vs parsing 

Named Entity Recognition
- what is it? name, orgs, countries
- detetect and classift into their groups
- variation
- amgiutity, same name for several entities

### Information Extraction

Turning unstructued into structued information

sentances > to datbase entries (words, chunks, etc)

Extract words and their related words

country > role > person

take start with word from source and append info from other resources 


### Tasks in Information Extraction

1. Text chunking is a simplied version of parsing

2. Identify names entities (strongs of tokens)

3. Conference Reso - link related entities: trump > president

4. Entity Linking - link to knowledge base with additional info. possibly to clarify a name to an exact person, instead of anyone with name

5. Relation Recogniton - relaitons between entities, i.e. name and occupation. often looking at words around. 

6. Event Recognition - related temporal info or specifics

### Chunking

Useful preprocssing

#### Synatic Chunking

Group toekns into phases

usually noun phrase vs verb phrase 

"will arrow" verb phrase

"only 8 mill" noun phrase

generally can replace np with other nps and grammaticly will still make sense

and visa v for noun

Noun phrases tend to be longer

### chunking vs parse

parsw more complicated 

tends to be hiearchical

v reousrce intenseive and not required for chunks

we just want to know sentance structure or noun and verb prahses

gives enough structure

### IOB Labels

token

pos tag

chunk

IOB labels used to indicate chunk boundries

begin, inside, outside

where a token is within the group of tokens

can also use this to pick out information from the chunk

#### chunking as seq labelling

raw  text > 

[fill this in ]

### Names Entity Recognition (NER)

Detect, i.e. this is a name

Classified, this name is a person (not a business)

a named ent is anytihng that be ref by a proper name (norm with a capital)

### Questions about names e

mentions, types, relationships

### types of names entiess

people

locations/geo-polit

(location words may have several applications, city, football team)

organizations (man utd, red devils)

most entires have several words or ways to be refered to 

# relatiionships between names entiries

what is the entities

who

### detecting names entites

named ents are chunks

chunks of tokens

individual workds will often be pos tagged

some may be capitialised

could be recognised within noun phrase chunkings

### named entity classification

pepople, org, loc, geo-pol, facility, vehicle

[many more]

### varition and amb

[do notes here]

### Names Enitiy and seq labelling

bit more complicated that pos

[take better names]

note all the types of labelling can be complied into a single database

word -> cols: lower, lemm, pos, NER (names ent rec), IOB-NER

### Featues for NER 

[review notes]

pos tag, is just word ident and tag seq

NER is word ident, tag seq, caps, pos tag and chunks

### NER as classifc

take all info we have about word

shape, chunk IOB, pos tags, tokens 

into a classifer to get 

pass in as a window to get context around words

NE-IOB

### NER Sequence Labelling

could do better than classifing token seperately 

but HMM have structure feature indep assumptions

but our input features are not inde, i.e. iob and pos

[insert noted about other possible models here with less tructure indp assumps]

## CO-reference resolution

same ent reference in mutliple place/ways

man u, man utd, red dev

### entity abm 

same name or mutli things

machester to many idff things

### name variations

mulitple words that end up refering to the same thing

man u, red dev, utd > all mean manchester united

### forumlaiton of named ent link prob 

[take notes of this again]

introduces knowledge bases

### tehcnique for ent linking

2 step:

find cands in KB for given ent mention

rank the most porb cands

### generate candiates 

[note about prec vs recall trade off]

[do better notes]

need high recall so correct entity is there

### strats for gen cands

direct mention

subtring mentions

accronym references

known alias'

### gen cands using string sim

mention is s dimilar string to a page title

[better notes, didnt quite understand]

typos and spelling variations

### info for ranking candidates

co-occurance of entiry mentions

location context of entity mention (the words around mention = more info)

global context (bog of word of whole doc, what is doc about with mention)

### strats for rank cands

[do better notes of this bit]

### named entity linking as disambiguaiton

[need notes for this]


## Relation Extract

what is the document saying about the entities

### Relation Extraction

typically concerned with binary relations

fundemental to meansing

Name > boss-of > man u

ent > rel > ent

### relation gran

recall name ent classified into classes

relation types can algo go into classes

relatipnships into classes/types

with diff levels of gran

[note about hierachy of classes (grnular)

### supervised appproachs to rel ext

2 step:

1.
extract pairs of entrieis, usually close together

detect a relati or not


2. 
if det, class rel between ents

mutliclass class prob


OR build a binary classif for each relaitionship


### training relation extract 

[need notes]

### feautes of relation extraction

feeature rep need to capt pot relation between ents

[bullet points, need to collection notes]

## nb assumptions

is it approp to use said lciassifer

does the class violate the task

indep assumps not true

think about assumptions can selelct approp models


