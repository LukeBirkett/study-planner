# Revision File

This is the markdown file that will hold all of the resources used to revise and prepare for the exam. It will include notes of each weeks lecture, a breakdown of import code & concepts from the labs and possibly notes from any additional reading. 

## Contents for Whole Document
1. [Week 1 - Intro to ANLP and Python](#week-1---intro-to-anlp-and-python)
    - [Lecture Notes](#week-1-lecture-notes)
    - [Lab Session](#week-1-lab-session)
    - [Code Snippets](#week-1-code-snippets)
2. [Week 2 - Text Documents and Preprocessing](#week-2---text-documents-and-preprocessing)
---

<div style="page-break-after: always;"></div>

# Week 1 - Intro to ANLP and Python

1. [Lecture Notes](#week-1-lecture-notes)
2. [Lab Session](#week-1-lab-session)
3. [Code Snippets](#week-1-code-snippets)

## Week 1 Lecture Notes

Largely an intro class to the module. Light on content that will directly applied in the exam. More preliminary and base content. 

**Atomic Data Types**: int, float, cool, str

**Data Structures**: Lists, Tuples, Sets, Dicts

**Lists**: ordered, indexable, variable length, store sequences (words, sentences), iterable

**Tuples**: ordered, indexable, fixed length, often pairs/triples, iterable

**Sets**: unordered collections, no index, each item is unique, can be iterated but no order

**Dicts**: map keys to values, unordered, lookup via hash

**Functions**: apply code again, call on some arguments, return a value

<div style="page-break-after: always;"></div>

## Week 1 Lab Session

`NLE2023_lab_1_1_SOLUTIONS.ipynb`
`NLE2023_lab_1_2_SOLUTIONS.ipynb`
`NLE2023_lab_1_3_SOLUTIONS.ipynb`

The lab for this week was generally an intro session for people unfamilar with python. I am already familiar with Python so I won't do a full breakdown of the code in this section, where as for the notes on later weeks I will. However, when doing the assignment exam it will be important to reference these lab files to ensure good practice has been implemented in the code. There also may be some good tricks layed out in these notebooks. 

Below are some code snippets, functions and attributes taken from the notebook that tend to be things that slip out of my mind sometimes. 

<div style="page-break-after: always;"></div>

## Week 1 Code Snippets

#### `.split()`

this takes a sentence and splits it down into word tokens (strings) 

---

#### `text.isalpha()`, `.isalnum()`, `.isdigit()`

These are boolean operator methods that check an inputs type, useful when used in `if` statements

--- 

#### `.get("Key","Key does not exist value")`

An alterative way of obtaining a value from a dictionary. Allows you to specific an output value if a dictionary does not exist. Can be combined in various ways to produce different functionality. For example, as a word counter, allowing us to account for values that don't exist that need to be initalized and the first count added. 

`vocab[word]=vocab.get(word,0)+1`

---

#### `.keys()`

Obtain all of the keys from a dict. Often combined to enable looping through a dict

---

#### `.values()`

Obtain all of the values from a dict. Often combined with a sum or average.

---

#### `for person,age in simpsons_ages.items():`

this allows for an iterable that accessed keys and value pairs at the same time

--- 

#### `for i in range(0,10,2):`

Can be though of as a tuple with a starting and ending index that can be looped/iterated through. The find term is optional and specificies the increment. 

---

#### `word_positions = zip(words, indices)`

Combined to pairwise iterables. Output is a iterable of tuple pairs. The output is not a list but is instead an object which is itself an iterator. `Output: <class 'zip'>`

You can write it in in list to obtain a true list output: `list(zip(names, scores))`

---

#### `for a,b in enumerate(['The','Holy','Grail']):` 

Enumerate is an extension and replacement of `zip` and `range`. In a loop it gives you the value of the interatable, i.e. `The` and its index position `0`

---

#### `map()`

The map function takes a **function** and an **iterable** (e.g. a list) as arguments. It then applies the function to every item of the iterable, returning a map object (an iterator) of the results.

Again, not directly a list. The advantage of returning an iterator is that it applies the function to the items lazily (on demand) and doesn't store all the results in memory at once. This is more memory-efficient for large iterables.

```
natural_numbers = range(5)
squared_numbers = map(square, natural_numbers)
for i in squared_numbers:
    print (i)
``` 

#### List Comprehension

A more compact way of doing loops and constructing a list output. Can be nested but can sometimes obscure readability.

`[x**2 for x in range (4)]`

`[square(n) for n in range(15) if is_even(n)]`

##### Nested List Comp

`matrix = [[1, 2], [3, 4], [5, 6]]`

`flat_list = [item for row in matrix for item in row]`

`flat_list is [1, 2, 3, 4, 5, 6]`

Works left to right in terms of hierarchy:
- `for row in matrix` to access inner rows of matrix
- `for item in row` to access the items in the rows
- `item` main part of comp references the most granular item accessed

---

<div style="page-break-after: always;"></div>

# Week 2 - Text Documents and Preprocessing

- Defining different units of text; characters, lemmas, words, sentences, paragraphs, documents, corpora. 
- Bag of Words: Treating a unit of text as a colleciton without order or perhaps frequency.
- Sentence segmentation and tokenization
- Standard pre-processing or text normalisation techniques: case normalisation, stopword and punctuation removal, stemming, lemmatisation, morphological analysis, Regex

1. [Lecture Notes](#week-2-lecture-notes)
2. [Lab Session](#week-2-lab-session)

# Week 2 Lecture Notes

- [Introduction to the Document Retrieval](#introduction-to-the-document-retrieval)
- [Segmentation and Tokenization](#segmentation-and-tokenization)
- [How many words are there?](#how-many-words-are-there)
- [Normalisation](#normalisation)
- [Punctuaton and Stopword Removal](#punctuaton-and-stopword-removal)
- [Stemming and Lemmatisation](#stemming-and-lemmatisation)

## Introduction to the Document Retrieval

A large digital collection of documents is refered to a corpus. Docuement Retreival refers to the task of finding specific documents in a corpus given a goal. The goal might be that it contains a given word. To start, a computer sees a corpus as a sequence of characters but a human will automatically break down a corpus into its components. Thinking hierachrically: Documents, Paragraphs, Sentances, Words, Morhpemes/Syllables, Characters. Stop words are high frequency words that don't carry much information. Removing these is atype of text normalisation

## Segmentation and Tokenization

A corpus is a collection of documents that could be anything: News Articles, Essays, Books, Web Pages, Tweets.

There is no pre-determined structure of a corpus but its important to understand the structure of the corpus you are working with. 

Common structures are: one document per file; one single file were documents are sperated with delimiters; and single file with one document per line.

Documents have no fixed length and vary wildly between types and even within the same type, i.e. 5 word tweet vs 1000 word tweet. Therefore it is useful to break them down further

Something really important that we always need to do when working with text is to segment the sentance. 

This is a non-trival task because although words seperated by spaced seem easy to identify it because more different when the word is at the start of a sentance, at the end or used near punctuation. 

All componentents need to be identified and seperated because they all hold important context as to what is being said. This process of segmentation is known as tokenization. State-of-the-art methods will using classifers to work out difficult as aspects such as weather a `.` is a full stop or part of an acronym.

Natural Language Toolkit (NLTK) is a common tool for working with text in Python. It is originaly from Kiss and Strunk (2006)

```
from nltk.tokenize import sent_tokenize
sent_tokenize(testtext)
```

Tokenization is the task of segmenting text into "words". Includes more than just words. Puncutation, capitalisation, numbers, word parts, start of sentence and end of sentence

Python has a `.split()` function that breakdown text into a list of words but it is very basic and doesn't account for punctuation. Instead we tend to use `word_tokenize()` from the `nltk.tokenize` pakage.

Another option is to right custom rules Regex but this is not directly tested for on this course. 

## How many words are there?

**Types** are the number of distinct words in a corpus. If set of workds is *V*, the nymber of types is *|V|*

**Tokens** are total number N of running words

Tokens will be more than types. For example in Shakespeare: Tokens = 884k, Types = 31k

Herdan-Heaps Law: The larger the corpora, the more word types we find. According to HH law, the average type frequency in 1M word corpus is 30. 

But the frequency distribution of word types is not uniform or even normal. It is **Zipifan**. Half of all types will only occur once, hapax legomena. 

Zipf's Law Sates that "the product of a word's frequency and its rank frequency is approximately constant. i.e. if most frequent word occurrs 100 times, the second will occur 50, 3rd 33. And so on. 

## Normalisation

**Case Normalisation:** In document retreival, case is often considered irrelevant and in speech recognition it doesn't exist. Removing case reduces the number of types and increases the frequence of each type, i.e. types of the same words aren't split into capitalised vs not. Although removing case introduces ambiguity, particuarly where a word can be used to dicate a name or a thing. 

Python uses `.lower()` to remove case

**Number Normalisation:** The exact number(s) used in a corpus are often unique and therefore represent a rare type with low frequency, i.e. the exact year of someones birth is likely to only come up once and in the context of explaining birthday. Typically, the exact number used is irrelevant so a common practice is to replace any numbers with `NUM`

`["NUM" if token.isdigit() else token for token in tokens]`

Normalisation can be framed around remove rare "words" where the types have low frequency. For words that aren't captured through normailsation, it is common to just ignore them. 

The two main methods of "ignoring" are by either using a threshold, i.e. if less then x number of times then remove, or by only considering the n more frequent words, thus ommiting the low frequency words. 

## Punctuaton and Stopword Removal

The most frequent words in English are non-context bearing function words, in NLP these are known as stop words. In any application, such as document retreival, stopwords are removed along with punctuation. This has the benefit of reducing the size of the document and doesn't decrease functions such as word search capabilities. 

`the`, `of`, `and`, `a`, `in`, `to`, `it`, `is`, `was`, `to`

## Stemming and Lemmatisation

Morphology is the study how words are made up of smaller parts. For example, `cats` is `cat` and its plural `s`. In NLP application was probably want to capture all words with the base of `cat` (where cat refers to the animal). Other common morpology includes: `ed`, `ing`, `un`, `anti`.

Derivational Morphology is the process of creating a new work from an existing words with the use of affixes. `start`, `starter`, `restart`, `restartable`. The affixes not only create a new word but change to a different part of speech, i.e. noun to verb. 

**Stemming* is the process of removing unwanted affixes so we can focus on the base content of the word. The `nltk` package has some built in functions for this. 

```
from nltk.stem.porter import PorterStemmer
st = PorterStemmer()
words = [list of words]
stems = [st.stem(word) for word in words]
```

This will output a list of stems. You could `zip` this together with the original list and iterate. 

Some examples of stems include, `relational : relat`, `relate : relat`, `hopeful : hope`

**Lemmatisation:** Replace a word with its dictionary head word. It derives this relationship from an existing knowledge source such as a lexicono or dictionary. Commonly used is WordNet which holds a tree based knowledge of inflectional morpopolgy, i.e. where words and their peices derive from. 

The `nltk` implementation of lemmatisation is as follows: 

```
from nltk.stem.wordnet import WordNetLemmatiser
st = WordNetLemmatsier
words = [list of words]
lemmas = [st.lematize(word) for word in words]
for w,s in zip(words, lemmas):
    print(w,s)
```

The general workflow of lemmatisation is: apply stemming rules, is the outputcome is in the WordNet dictionary then keep it else just keep the orginal word with no changes. 

Lemmatization is another method for removing the number of types in a corpus. We group words by their inflections meaning several words are to be analyzed as one single item, i.e. dimension reduction. 

It is generally seen as an improvement on Stemming as the output combines vocabuluary (knowledge) with morpological analysis. 

For search tasks, the recall (relevant results) should be increased when using Lemmatisation, or Stemming, as all directly related words can be returned. `battery`, `batteries`

<div style="page-break-after: always;"></div>

# Week 2 Lab Session

There are 3 notebooks for this lab:
- [Preprocessing Text (Part 1)](#preprocessing-text-part-1) `NLE2023_lab_2_1_SOLUTIONS.ipynb`
- [Preprocessing Text (Part 2)](#preprocessing-text-part-2) `NLE2023_lab_2_2_SOLUTIONS.ipynb`
- [DIY Tokenisation with Regular Expressions](#diy-tokenisation-with-regular-expressions) `NLE2023_lab_2_3_SOLUTIONS.ipynb`

## Preprocessing Text (Part 1)

* [Overview](#overview-of-lab-21)
* [Sentence Segmenter](#sentence-segmenter)
* [Python's Split Tokenizer](#pythons-split-tokenizer)
* [NLTK Regex Tokenizer](#nltk-regex-tokenizer)
* [NLTK Built-in Corpora](#nltk-built-in-corpora)
* [Random Sampling of Sentences](#random-sampling-of-sentences)

### Overview of Lab 2.1

This section refer to notebook: `NLE2023_lab_2_1_SOLUTIONS.ipynb`

Any document starts of as just a sequence of characters. There are a number of basic steps that are either always or often carried out to make the document easier to work with and extract more context/information. This lab covered the main tools to be used. 

- **Sentence Segmentation:** grouping characters into sentences
- **Tokenisation:** grouping characters into "words"
- **Case Normalisation:** converting into lower case
- **Stemming:** removing a words inflections to obtain the stem
- **Punctuation and Stopword Removal:** removal of common and therefore low context tokens.

In addition to working with these methods, we will be learning to work with the NLTK package which provides as way to use these methods but also more generally allows use to smoothly work with corpora and text. 

Some common imports before setting off:

```
import sys
import re
import pandas as pd
from itertools import zip_longest
```

### Sentence Segmenter

There specific type of segmeneter that `NLTK` uses is called `Punkt Segmenter`, this needs importing. 

```
pip install nltk
import nltk
nltk.download('punkt_tab')
# nltk.download('punkt')
# nltk.download()
```

The exact function to be used is `from nltk.tokenize import sent_tokenize`.
It's input is just a string which will respresent a document or collection of documents. It will return a list of strings whereby the individual strings should be a sentence. 

```
#some text to segment stored in testtext
testtext="I went to Portsmouth last week.  Don't you remember?  I saw H.M.S. Victory in Portsmouth.  I want to go to the U.S.A. next Summer."
#call the function sent_tokenize on the value of testtext
sent_tokenize(testtext)
```

The output will look like:

```
['I went to Portsmouth last week.',
 "Don't you remember?",
 'I saw H.M.S.',
 'Victory in Portsmouth.',
 'I want to go to the U.S.A. next Summer.']
 ```

### Python's Split Tokenizer

Python has a very basic built in method called `.split()` which behaves as a tokenizer. 

```

opening_line="It was the best of times, it was the worst of times."
tokens=opening_line.split()
vocab=set(tokens)
print(vocab)

{'worst', 'best', 'the', 'of', 'was', 'It', 'it', 'times,', 'times.'}

```

The issue is that it is very naive and does not have the ability to seperate out words and punctuation so its applications are limited but can be useful for quick tests on santitisted test data. 

### NLTK Regex Tokenizer

`NLTK` has its own tokenizer which is derived from Regex logic: `from nltk.tokenize import word_tokenize`. The function takes an argument which is a string and returns a list of strings where each string is a token/word from within the input string (sentence)

```
test_sentence="The cat sat on the mat."
word_tokenize(test_sentence) 

['The', 'cat', 'sat', 'on', 'the', 'mat', '.']
```

It has a few specifc rules:
- Punctuation is split from adjoining words
- Opening quotes are changed to two single forward quotes to denote the start
- Closing quotes are changed to two single backwards quotes to denote the end
- Genitive nouns are split from their component parts: `children's` becomes `children` `'s`
- Contractions are split into parts: `won't` becomes `wo` and `n't`

Here is a snippet to compare how tokenizing increases the nuber of tokens in a corpus compared to a naive method like `.split()`. Note however, that the number of unique types will be reduced dramatically. This is because different variations of the same word will now be complied into one, i.e. `boy`, `boys` both categorized as `boy` and the connective `'s` is common is unlikely to add to the type count:

```
testsentence = "After saying \"I won't help, I'm gonna leave!\", on his parents' arrival, the boy's behaviour improved."

nltk_toks = word_tokenize(testsentence) # run the nltk tokeniser
split_toks = testsentence.split() # run split

pd.DataFrame(list(zip_longest(nltk_toks,split_toks)),columns=["NLTK", "SPLIT"])
```

Here is an example of using the tokenizer on a corpus where the sentance lists do not come pre-tokenized. This is the twitter corpus which start off as just strings. A sentence segmenter is applied and then the tokenizer is applied to the sentences. The result is a list of lists which hold tokens. This structure is the general baseline for working with docuements and text:

```
from nltk.corpus import twitter_samples

mysample=sample_sentences(twitter_samples.strings(),sample_size)

tokenised=[word_tokenize(sent) for sent in mysample]
tokenised
```

### NLTK Built-in Corpora

NTLK has some arge collections of documents known as corpora that can be used for NLP applications. 

- Gutenburg books (25k books `from nltk.corpus import gutenburg`)
- Reuters articles (~11k news articles `from nltk.corpus import reuters`)
- Twitter posts (20k tweets `from nltk.corpus import twitter_samples`)
- Brown corpus (the first 1 million word corpus made by Brown University in 1961, `from nltk.corpus import brown`)
- Plus many others: http://www.nltk.org/nltk_data/

Each corpus is a class and has slightly different functionality and methods but the `reuters` text can be access like this:

```
from nltk.corpus import reuters

sents = reuters.sents()
sample_size = 10

for s in sents[1:10]:
    print(len(s))
```

The actual output `sents` is a type called `ConcatenatedCorpusView` but in practice it can be considered as a list of lists. The entire lists is the corpus, the sub-lists are sentences, and each element of the sentances is a token. With the `ConcatenatedCorpusView` type the entire corpus is not held in memory at once so is more efficent as the corpora are very large. Elements of `sents` can be accessed just like a list: `sents[0:10]`

Most of the corpora come pre-tokenized, however, some like the twitter corpus do not and need some extract pre-processing:

```
reuterssample=sample_sentences(reuters.sents(),samplesize)
gutenbergsample=sample_sentences(gutenberg.sents(),samplesize)
twittersample=[word_tokenize(s) for s in sample_sentences(twitter_samples.strings(),samplesize)]
```

### Random Sampling of Sentences

For most analysis and applications is want to be able to take an unbiased random sample from a corpus. This function uses the `random` package to create a list of indexes to draw from the main corpus. The output will be a list of `n=sample_size` **sentences**. Note: there is no handle of the length of the sentences. 

```
import random

def sample_sentences(corpus,sample_size):
    
    size=len(corpus)
    ids=random.sample(range(size),sample_size)
    sample=[corpus[i] for i in ids] 
    return sample

random.seed(33)

sample=sample_sentences(sents,10)
print(sample)
```

<div style="page-break-after: always;"></div>

## Preprocessing Text (Part 2)

* [Overview](#overview-of-lab-22)
* []()
* []()
* []()
* []()
* []()

### Overview of Lab 2.2

This notebook continues looking at the pre-processing steps that can be applied to raw text documents. In the previous notebook we looked at tokenization and segmentation. This notebook looks at case normalisation, stemming and stopworld/punctuation removal. 

### Number and Case Normalisation

One of the way a corporas types are increased is through capitalisation, e.g. "help" and "Help". In most situations, there are not different between these two word hence we want to normalise the case to be all lower. Additionally, numbers, in particular years, provide any types but often the mere context that a number/year is given is all we need, though this is less true that for the capitalisation point because sometimes the exact number or year is very important. 

The main way of acheiving such normalisation tasks is through list comprehensions where by we loop through and filter items. As well as, built in python functions/methods that manipulate data. Note that normalisation techniques generally assume pre-tokenized inputs. 

Normalisation will heavily reduce the size of the vocabulary. It is often good practice to demonstrate and print out the reductions in the running of the code.

```
tokens = ["The","cake","is","a","LIE"] 
print([token.lower() for token in tokens])

numbers = ['in', 'the', 'year', '120', 'of', 'the', 'fourth', 'age', ',', 'after', '120', 'years', 'as', 'king', ',' , 'aragorn', 'died', 'at', 'the', 'age', 'of', '210']
print(["NUM" if token.isdigit() else token for token in numbers])
```

Code wrapped into a function. Also ability to process `th`, `rd`, `nd` affixes though the use of `.endswith()` and `.isdigit()` python methods and slicing `[:-2]`:

```
tokens = ["Within","5","minutes",",","the", "1st", "and", "2nd", "placed", "runners", "lapped", "the", "5th","."]
def number_normalise(tokens):
    normalised=["Nth" if (token.endswith(("nd","st","th")) and token[:-2].isdigit()) else token for token in tokens]
    normalised=["NUM" if token.isdigit() else token for token in normalised]
    return normalised

print(number_normalise(tokens))
```

### Stemming 

A huge amount of variation in vocabularies is due to morphological variation in which the stem of the word provides the bulk of information that most applications desire. This is particular true for topic evaluation and keyword searching. We remove this variation using a stemmer. The `NLTK` has a number of stemmers in the `nltk.stemmer` package. A common one used is the `from nltk.stem.porter import PorterStemmer`. It is initalised `st = PorterStemmer()` and then used via `st.stem(token)`, its output is just another token which is sometimes unchanged. 

The Porter Stemmer algorithm (originally published by Martin Porter in 1980) is based on a specific set of rules (or "phases") that look for patterns at the ends of words. It's rules aggressively strip suffixes to the extent that it often results in outputs that are not real dictionary words/stems - this is a reason why Lemmatizers were developed. Porters algoritm also has lower case normalisation integrated as the algorithm is directed to look for lowercase words. 

```
from nltk.stem.porter import PorterStemmer
 
st = PorterStemmer()

sample_size = 10

tokenised_sentences = sample_sentences(reuters.sents(),sample_size)

for sentence in tokenised_sentences:
  df = pd.DataFrame(list(zip_longest(sentence,[st.stem(token) for token in sentence])),columns=["BEFORE","AFTER"])
  display(df)
```

Here is a neat block of code that applies several preproccesing steps including Stemming and measures the change in vocabulary:

```
sample_size=10000
tokenised_sentences = sample_sentences(reuters.sents(),sample_size)
normalised_sentences=[number_normalise(sentence) for sentence in tokenised_sentences]
stemmed_sentences = [[st.stem(token) for token in sentence] for sentence in normalised_sentences]
raw_vocab_size = vocabulary_size(tokenised_sentences)
stemmed_vocab_size = vocabulary_size(stemmed_sentences)
print("Stemming produced a {0:.2f}% reduction in vocabulary size from {1} to {2}".format(
    100*(raw_vocab_size - stemmed_vocab_size)/raw_vocab_size,raw_vocab_size,stemmed_vocab_size))
```

### Lemmatizer

A Lemmatizer is an NLP tool to reduce a word to its lemma. This is its canonical, dictionary-standard form of the word. Where Stemming just chops off things it thinks are suffixes, a Lemmatizer uses an understanding of a langugages vocabulary and grammar to deduce it's lemma which will always be a real word. It can also use Part-of-Speech (noun, verb etc) to determine the type of word it should be searching through. Lemmatizer is more accurate but much slower, so its applications should be restricted to applications where meaning and grammatical correctness of the root word matter most such as Sentiment Analysis or Chatbots. Modern technology also means that the historical slowness of Lemmatizing will be negated to an extent. 

```
from nltk.stem.wordnet import WordNetLemmatizer
nltk.download('wordnet')
```

WordNet is a large, publicly available lexical database (essentially a "smart" dictionary) of the English language, developed by Princeton University. Unlike a standard dictionary where words are listed alphabetically, WordNet organizes words based on their semantic relationships—how they relate to each other in meaning. 

The core building block of WordNet is the "synset" (synonym set). Each synset represents a specific concept. For example, the word "bank" would belong to different synsets depending on whether you mean a "financial institution" or the "edge of a river.

"Relationship Mapping: WordNet connects these synsets using specific linguistic relationships:
- Hypernyms: "A is a type of B" (e.g., Salmon $\rightarrow$ Fish).
- Hyponyms: "B is a specific instance of A" (e.g., Fish $\rightarrow$ Salmon).
- Meronyms: "A is a part of B" (e.g., Wheel $\rightarrow$ Car).

Machine Readability: It is designed to be easily navigated by computers, which is why it is the "gold standard" resource for Lemmatizers and other NLP tools to understand context.


A Lemmatizer is more or less implemented in the exact same way as a Stemmer but the reduction in the output vocabulary should be much less. This is mostly due to the Stemmers aggressivness but also due to the Lemmatizer's use of Part-of-Speech which pre-categorizes words into their types resulting in similar words reducing to different Lemmas, which contextually is more accurate.

```
sample_size=10000
lemm = WordNetLemmatizer()
tokenised_sentences = sample_sentences(reuters.sents(),sample_size)
normalised_sentences=[number_normalise(sentence) for sentence in tokenised_sentences]
stemmed_sentences = [[lemm.lemmatize(token) for token in sentence] for sentence in normalised_sentences]
raw_vocab_size = vocabulary_size(tokenised_sentences)
stemmed_vocab_size = vocabulary_size(stemmed_sentences)
print("Lemmatizing produced a {0:.2f}% reduction in vocabulary size from {1} to {2}".format(
    100*(raw_vocab_size - stemmed_vocab_size)/raw_vocab_size,raw_vocab_size,stemmed_vocab_size))
```

### Punctuation and Stopword Removal

A stop word is a word that occurs so often in a vocabulary that it has little to no information and is just used for grammatical connectivity. By removing these words we make our courpus smaller and therefore more efficent but also concetrate the information availble in our corpus which is better for analysis. Punctuation is often treated the same way as stopwords. 

Typically, to remove stopwords we need a pre-existing word list to compare against. This can be generated from the corpus by compliling the most common words but `NLTK` also have a built in list that can be loaded in.

```
from nltk.corpus import stopwords
nltk.download('stopwords')
```

Like most over pre-processing steps, removal is most easily acheived using a list comprehension. 

```
stop = stopwords.words('english')
tokens="The cat , which is really fat , sat on the mat".lower().split()
filtered_tokens = [w for w in tokens if w.isalpha() and w not in stop]
print(tokens)
print(filtered_tokens)
```

Recall that `.isalpha()` only returns true when all characters are alphabet letters. If you want to account for letters and/or numbers then use `.isalnum()`.

A simple stopword reduction counter:

```
num_stopwords = 0
num_tokens = 0
for sentence in tokenised_sentences:
    for token in sentence:
        num_tokens += 1
        if token in stop:
            num_stopwords += 1

print("Stopword removal produced a {0:.2f}% reduction in number of tokens from {1} to {2}".format(
    100*(num_tokens - num_stopwords)/num_tokens,num_tokens,num_stopwords))
```

##### Tokens vs Types

The issue with stopwords is the sheer number of times they occur in a corpus. Relevatively speaking the length of the stopword list is quite small. Therefore, removing stopwords which has a huge effect on the number of tokens but not so much on the number of types in a corpus.


<div style="page-break-after: always;"></div>

## DIY Tokenisation with Regular Expressions

This section refer to notebook: `NLE2023_lab_2_3_SOLUTIONS.ipynb`

This section is entirely an optional extension for this module as Regular Expression/REGEX will not be tested or required for the exam. Due to this, no notes will made about this notebook. The file will be kept in the repository for reference but unlikely to be referenced during the exam.

<div style="page-break-after: always;"></div>
