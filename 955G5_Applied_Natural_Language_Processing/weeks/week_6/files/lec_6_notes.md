# Lecture 6 Notes - Lexical Semantics

Word meanings

Infer that documents have related meanings, not just contain the same words

Begining approach is to make use of a dictionary

Words generally have mutliple senses, i.e. meanings, applications, uses

Lexciographers produce dictionaries

WordNet is an API dictionary

```from nltk.corpus import wordnet as ws```

ws.synsets(word)

takes a word and returns a list that contains all the synsets a word is a part of 

different sense of the word

generally in order of common usage or interpretation

competing dictionaries may have different definitons and diff number of senses

senses can be broken down into noun[N], verb[V], adjective[J], adverb[R]

## Homonyms

Greek for same name

Refers to v broad differences in meaning

Diff concepts just happen to have the same name

## Homogrpahs

Written in the same way but prounounced different

Mostly an issue/consideration for speech applications

## Homophones

Same pronounciation but different spellings

And diff meanings

there, their

Porblem main for speech input

## Polysemy

A word with many meanings and many sub meanings within each category

Ability to make fine-grain distinctions

book 

novel

book to write in > accounts OR bets OR notebook OR football punishment

senses are related but different

## Getting Definitions of Senses

wn.synset('plant')

s.definition()

recall that sysnet produces a list so senses can be either be looped through or indexed

## Monosemous

Just one single meaning

Very rare in words

Though most words will have a dominant sense

Could be considered Monosemous in a particular domain

If you can identify the type of document then easier to understand dominant sense of words

# Semantic Relationships

Relationships between senses

WordNet is more than just electronic dictionary

Maps/Networds relationships between words

quickly > slowly > fast

related but not in meaning

types of semantic relationships:
- synonyms
- antonymy
- hyponymy

## Synonymy

Words which mean the same thing (but diff words)

Words that are synonymous can be substituted in all possible contexts

True synonyms are very rare

choice of syn may give additional info or context

## Anyonymy

Words that have opposite meaning

Swapping word would create a contradiction

Very similar in the sense that they scope into a specific topic/domain

hot/cold are defininelty commenting on the extreme possibilities of temp

Dont genenrally get opposite nouns. usually verbs, adj or adverbs

## Hyponymmy and Hypernymy

Words that capture the idea of class inclusions

dog is a hyponym

animal is hypernym

dog is a subset of aninal

poodle > dog > animal

words can be both H's

dog is hyponym of animal but hypernym of poodle

concept is based on hierarchies and trees

root, parents, childen, nodes, leaves

general > specific

general as root

this is was WordNet captures

childen of the same word are co-hyponyms

## Wordet 

Linguistic NetWork organized around synonym and hyponym 

Core unit is the synset (sense)

synset = set of synonmous word senses

{plant, flora} = living organmism without loco

may be bigrams, i.e. two words (plant life)

but usually unigrams (one word)

polysemous words appear in mutliple sysnets

sysnets are then connected through their hypo relationships and structures

## Synonyms in WordNet NLTK

wn.synsets("cat", wn.NOUN)

l.name() for l in s.lemmas()

A lemma is class which can be thought of as a sense

We use its name() method to the word form itself

Hypernyms: cat_sysnet[index].hypernyms()

returns another list (but will usually just be 1)

## Semantic Similarity

We have a heirachy in wordnet

intuttion things closer together in the network are more closely related

a very basic way of doing this might be to count the length of path inbetween

traversing the tree

shorter path = more similar

prob with path length is that we don't distinguish the type of path

striaght down, diagonal, up and down

## Lowest Commmon Subsumer

similairty based on what two concepts share in the hierachy

lowest connect in the network (i.e. not the root)

## Information Content

inituation: concepts that have LCS carnviore are more similar tha LCS vertibrate

carnviore holds more information

capture probabilitistic via Information Store of a concept

look at frequency of concept in an corupus

## Simlarity Types

WordNet Path

Human

Resnik

Sim ratio

The types are all on different scales so a good way to compare them is to work on correlation between them


