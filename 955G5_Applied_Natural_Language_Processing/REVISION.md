# Revision File

This is the markdown file that will hold all of the resources used to revise and prepare for the exam. It will include notes of each weeks lecture, a breakdown of import code & concepts from the labs and possibly notes from any additional reading. 

## Contents for Whole Document
1. [Week 1 - Intro to ANLP and Python](#week-1---intro-to-anlp-and-python)
2. [Week 2 - Text Documents and Preprocessing](#week-2---text-documents-and-preprocessing)
3. [Week 3 - Document Classification](#week-3---document-classification)
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

There are 3 labs for week 1:
* `Lab_1_1_SOLUTIONS.ipynb`
* `Lab_1_2_SOLUTIONS.ipynb`
* `Lab_1_3_SOLUTIONS.ipynb`

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

**Types** are the number of distinct words in a corpus. If set of workds is *V*, the nymber of types is *|V|*. **Tokens** are total number N of running words. Tokens will be more than types. For example in Shakespeare: Tokens = 884k, Types = 31k

Herdan-Heaps Law: The larger the corpora, the more word types we find. According to HH law, the average type frequency in 1M word corpus is 30. But the frequency distribution of word types is not uniform or even normal. It is **Zipifan**. Half of all types will only occur once, hapax legomena. Zipf's Law Sates that "the product of a word's frequency and its rank frequency is approximately constant. i.e. if most frequent word occurrs 100 times, the second will occur 50, 3rd 33. And so on. 

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

**Stemming** is the process of removing unwanted affixes so we can focus on the base content of the word. The `nltk` package has some built in functions for this. 

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

There are 3 notebooks for lab 2:
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
* [Number and Case Normalisation](#number-and-case-normalisation)
* [Stemming](#stemming)
* [Lemmatizer](#lemmatizer)
* [Punctuation/Stopword Removal](#punctuationstopword-removal)

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

### Punctuation/Stopword Removal

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

# Week 3 - Document Classification

A common task in NLP is to classify a document. This lecture covers 3 types of classification: topic, sentiment nad relevancy. The basis of this work is classification, this week we will look at how to do classification from pre-constructed words lists and next week we will take this to a more advanced level facilitating it via machine learning, specificly Naive Bayes. Additionally, we will cover how to evaluate metrics through accuracy, precision, recall and f-score. Inconjuction with evaluation we will understand why hold-out and unseen data is so important.  

**Document Classification:** Feature extraction, word list classifier.

**Evaluation:** accuracy and error rate, confusion matrix, precision, recall and F-1 score. 

1. [Lecture Notes](#week-3---lecture-notes)
2. [Lab Session](#week-3---lab-session)

## Week 3 - Lecture Notes

* [Feature Extraction](#feature-extraction)
* [World List Classifiers](#world-list-classifiers)
* [Evaluating Classifiers](#evaluating-classifiers)
    - [Accuracy and Error Rate](#accuracy-and-error-rate)
    - [Confusion Matrix](#confusion-matrix)
    - [Precision and Recall](#precision-and-recall)
    - [F1-Score](#f1-score)

### Feature Extraction

In a document or corpus, words are a our most basic feature. Word along can give us an idea of what class something belongs to for all topic, sentiment and relevancy classification. 
- Excellent = positive review (sentiment)
- Bitcoin = may indicate email is spam (sentiment, topic)
- lemma = article is about NLP (relevancy, topic)

One of the most simple ways to compile the words (features) of a document is to treat it as a **bag-of-words**

A BoW ignores order and grammatrical structure and just log the frequency of each word. Sometimes even frequency is ignored as we just compile the mere occurance of words. Note, preprocessing is really important here because recall that when we talk about "words" we normally mean tokens and our preprocessing handles what a token is. 

There are a number of difference structures and ways to represent features. A frequency BoW would be numerical `D1 = {cats: 1, Mice:2, chase: 3}`. If we are ignoring frequency then the approach can be binary valued `D1 = {cats: TRUE, mice:TRUE}`

Note that using a python dictionary to represent data like this is known as a sparse vector respresentation. It is sparse because most of the memory is empty and there is no default value for key/features no present (0 or FALSE). There are many (endless) words that could be mapped but we have only mapped 3. The opposite approach would be a dense vector. Here, N values are stored in memory wether they occur or not. 

Dense vectors are generally stored as vectors and matrices. Length of each vector may be the total types of a vocabulary. In terms of document analysis, this will inherently lead to sparsity and a lot of zeros as a single document cannot possibly match an entire lexicon. 

### World List Classifiers

Word lists can be either be handcrafted or automatically derived from vobaculary lists. 

In order to classify documents, we need to score them. Recall we can treat a document as a bag-of-words. If taking a frequency approach, we count the number of times a word `w` from list L occurs `d` in a document count: `count(d,w)`

If scoring for sentiment analysis we would have two lists: positive or negative. Therefore we acrue two counts: `count(d, positive_list)` and `count(d, negative_list)`

To detemine the class, we say the outcome is positive if the counts for the `positive_list > negative_list`

$$class(d) = 
\begin{cases} 
positive & \text{if } count(d, L_+) > count(d, L_-) \\
negative & \text{if } count(d, L_-) > count(d, L_+) 
\end{cases}$$

That being said, there are generally 3 approaches to scoring words in a document:
- Frequency (as seen above)
- Uniform. 1 if it occurs at all, otherwise 0
- Weighted by importance of word. This is similar to frequency but includes a mutliplier for each word, usually between 0 and 1. However, this adds another layer of complexity whereby there needs to be a proccess of calculating word importance. 

The easiest way to approach a word list classifer is to use a hand-crafted list. However this comes with a number of problems:
- Each list will be bias and specific to the person(s) creating the list
- It is hard and expensive (time) to create a comprehensive list
- Lists often become unbalanced due to bias or approach taken
- Lists will vary accross domains

Therefore, a more scienticially solid way to construct a list is by automatically deriving one.  

The golden standard for achieving something like this would be through a supervised machine learning approach. However, this relies on labelled data which is expensive and often required human input to label it which is what we want to avoid. 

There are two go to "naive" methods that form the basis for automatically constructing word lists:

**Most Frequent Items:** Simply put, we take the top `N` occuring words as use this as our lists. FOr example, given a positive corpora, the most frequent words would become the `positive_list` and the same for the negative corpora and list. 

**Greatest Frequency Difference:** Here, you look at the differential counts between the labelled corpora. The highest differences are considered to be the words most appropriate for each list. Still requires a cutt off point which can either be a fixed `N` for by a threshold which could be a raw numerical value or percentage. 

### Evaluating Classifiers

Evaluating a classifer tells us how well it willl do on unseen documents. Through comparing evulation metrics accross models, or even parameter settings, we can select for the best performing one. In order to do evaluation we need a labelled dataset that has not been trained on. This means we have to partition our data into into test and training before anything else takes place. 

Often we partition into 3 sets: training, tests and development. The development set is also a hold-out set that the training process doesn't seen but it is used to tests different parameter settings. Generally, settings are compared on the development set, then the model + the settings are sent to the test set for the final evaluation. The ability to use a development set is often determined by how much data is available. 

#### Accuracy and Error Rate

Accuracy is a simple metric that measures the proportion of items in the test set that were classified correctly. Conversely, the error rate would be the proporition iof items classifed incorrectly. 

$$accuracy = \frac{|\{i | prediction(i) = label(i)\}|}{|\{i\}|}$$

$$error \ rate = \frac{|\{i \mid prediction(i) \neq label(i)\}|}{|\{i\}|}$$

Accuracy is an intutative metric but can provide misleading results, particularly when the underlying dataset is imbalanced. For example, if the class if split 99% negative and 1% positive then a classifer that only predicts negative for every instance will have an accuracy of 99% despite missing every positive instance. Additionally, it weights all errors the same, however, in practice we have False Positives and False Negatives. A False Positive might be incorrectly flagging a card transaction as fraud when it is legitimate. A False Negative could be missing a present disease. Clearly these errors are not equal and accuracy would have no way of balancing these. 

#### Confusion Matrix 

The confusion matrix is a performance measurement tool and that makes it quick and easy to compare between actual and predict values. The 4 quarters of TP, FP, RN and FN can be combined to create different metrics. Additionally, it is useful by its self as it allows to see a breakdown of not just how many errors there were but which classes are a symptom of the errors. In this way, it is an improvement on Accuracy. 

- True Positives (TP): The model correctly predicted the "Positive" class.
- True Negatives (TN): The model correctly predicted the "Negative" class.
- False Positives (FP): The model predicted "Positive," but it was actually "Negative" (Type I Error).
- False Negatives (FN): The model predicted "Negative," but it was actually "Positive" (Type II Error)

$$\begin{array}{|c|c|c|}
\hline
& \text{Predicted +ve} & \text{Predicted -ve} \\ \hline
\text{True +ve} & \text{True Positives (TP)} & \text{False Negatives (FN)} \\ \hline
\text{True -ve} & \text{False Positives (FP)} & \text{True Negatives (TN)} \\ \hline
\end{array}$$

* Total Samples ($n$): $TP + TN + FP + FN$

* Accuracy: $\frac{TP + TN}{n}$ (Correct predictions / Total)

* Error Rate: $\frac{FP + FN}{n}$ (Incorrect predictions / Total)

* Precision: $\frac{TP}{TP + FP}$

* Recall: $\frac{TP}{TP + FN}$

* F1-Score: $2 \cdot \frac{Precision \cdot Recall}{Precision + Recall}$

#### Precision and Recall

Recall is proportion of actual positive documents that are predicted correctly. To get this you need to compile all of the positive documents which from the confusion matrix will be the $TP$ and $FN$ (False Negatives are documents that were true but predicts false). The $TP$ is then taken as a ratio of this number. 

$$\frac{TP}{TP + FN}$$

Precision is the proportion of positive predictions that are correct. This looks as how many instances the model predicted to be true and then identifies the actual proportion of this number that were offically true. The metric complies the $TP$ and $FP$ on the denominator and creates a ratio with the $TP$.

$$\frac{TP}{TP + FP}$$

Recall is concerned with actual positives

Precision is concerned with modelled positives

#### F1-Score

In an ideal world we want high precision and high recall. The F1-score is a metric that combines the two. It is the harmonic mean or balance of the precision and recall. Because it is the harmonic mean and not the arithmetic mean is skews towards which ever input metric is lower. A harmonic mean punishes difference between two inputs and is sensitive to the minimum value. If one input was to be 0% the F1 would be 0%. 

Shorthand: 
$$F1 = \frac{2PR}{P + R}$$

Longform:
$$F1 = 2 \cdot \frac{Precision \times Recall}{Precision + Recall}$$

#### Precision, Recall Tradeoff

Any classifer has a decison boundry. By manipluating the boundry we can changes tightly contested instances outcome. This therefore impacts precision and recall. Whether or not we choose to do this will be based on the domain topic. For example, in medial applications, it is normally imperative that the Recall is as high as possible or even perfect, if someone is positive it must be caught. As a result precision can be traded off until the model behaves well enough in recall. This might result in more patients being marked as positive who are negative but in this domain they would be screened further or possibly rules out by an ensemble of models. 

<div style="page-break-after: always;"></div>

## Week 3 - Lab Session 

There are 2 notebooks for lab 3:
- [Basic Document Classification (Part 1)](#basic-document-classification-part-1) `Lab_3_1_SOLUTIONS.ipynb`
- [Document Classification (Part 2)](#document-classification-part-2) `Lab_3_2_SOLUTIONS.ipynb`

## Basic Document Classification (Part 1)

This weeks lab focuses on sentiment analysis. The corpus we are working with is movie reviews and we want to be able to classifc the sentiment of a movie review, either positive or negative. We will build a world list classifer, a naive bayes classifers and compare them both to the NLTK Naive Bayes implementation. 

* [Movie Review Corpus](#movie-review-corpus)
* [Creating Test and Training Sets](#creating-test-and-training-sets)
* [Document Representations](#document-representations)
* [Creating Word Lists](#creating-word-lists)
* [Creating a Word List Based Classifer](#creating-a-word-list-based-classifer)

### Movie Review Corpus

This is how to import the corpus:

```
import nltk
nltk.download('movie_reviews')
```

This corpus has a number of useful methods: `.categories()`, `fileids()` and `.words()`. This corpus is prelabelled and `.categories()` gives us the labels used in the corpus which is `['neg', 'pos']`. `fileids()` give us all of a particular category: `movie_reviews.fileids('pos')`. Finally, using `.words()` with an `id` returns a review: `movie_reviews.words(pos_review_ids[0])`.

The item returned by `.words()` looks and behaves like a list but it is actually called `SteamBackCorpusView`. It can be converted to a list which will allow you to see the whole review `list(movie_reviews.words(pos_review_ids[0]))`. The review comes as a tokenized list. 

### Creating Test and Training Sets

Recall that is is imperative to split the data into test and train whenever building any sort of model or classifer. There are many ways to split a dataset but the following presents a function which generates a list of indices using the `random` package and uses a list comprehensive to extact the entries into `train` or `test`

```
import random 

def split_data(data, ratio=0.7):
    """
    Given collection of items and ratio:
     - partitions the collection into training and testing, where the proportion in training is ratio,

    :param data: A list (or generator) of documents or doc ids
    :param ratio: The proportion of training documents (default 0.7)
    :return: a pair (tuple) of lists where the first element of the 
            pair is a list of the training data and the second is a list of the test data.
    """
    
    n = len(data) 
    train_indices = random.sample(range(n), int(n * ratio))        
    test_indices = list(set(range(n)) - set(train_indices))
 
    train = [data[i] for i in train_indices]
    test = [data[i] for i in test_indices]
 
    return (train, test) 
```

Here is the implementaiton: 

```
random.seed(41)  #set the random seeds so these random splits are always the same
pos_train_ids, pos_test_ids = split_data(pos_review_ids)
neg_train_ids, neg_test_ids = split_data(neg_review_ids)
```

With this dataset, the key to pairing up a review with its label to obtain the ids for `pos` or `neg` using `movie_reviews.fileids('pos')` and then manually code in it's label. Note, it is important to also apply the same processing to the training and test set:

```
training = [(movie_reviews.words(f),'pos') for f in pos_train_ids]+[(movie_reviews.words(f),'neg') for f in neg_train_ids]

testing = [(movie_reviews.words(f),'pos') for f in pos_test_ids]+[(movie_reviews.words(f),'neg') for f in neg_test_ids]
```

### Document Representations

The current structure of this review data, as with most of the preprocessed data we have been working on in previous labs, is an ordered list of tokens (words). Often the order of words in a document is deemed irrelevant as the most importance is on the words themselves. This is particular true for sentiment analysis as words like `terrible` in a review almost certianly mean it is negative regardless of where they are in a document or string. 

With this in mind, we can reconstruct the list of tokens into a bag-of-words. This can be manually done using a python dictionary to iteratively create a sparse vector of frequncies or booleans. However, `NLTK` has a built in method for this exact thing called `FreqDist`: from nltk.probability import FreqDist. This behave the same as a dictionary but has some built in methods that allow easier manilpluation, adding and subtracting of the data. Here is an example where we add a review (without the label) into a `FreqDist` stored in a variable called `doc1`:

```
from nltk.probability import FreqDist

doc1 = FreqDist(training[0][0])
doc1
```

The output looks like:

```
FreqDist({',': 24, '.': 18, 'and': 11, 'a': 9, 'to': 8, 'the': 7, 'melvin': 6, 'his': 6, "'": 6, 's': 6, ...})
```

Here an implementation of turning a test and training set into a `FreqDist` format whilst retaining the `(review, label)` structure:

```
training_basic=[(FreqDist(wordlist),label) for (wordlist,label) in training]
testing_basic=[(FreqDist(wordlist),label) for (wordlist,label) in testing]
```

One thing that is important to remember is that most preprocessing steps are easier to apply in the original wordlist format rather than to the `FreqDist` itself. 

### Creating Word Lists

This section focuses on creating a manual sentiment classifers that used nothing more than a pre-existing wordlist to determine its decisions. We need to construct to worldlists, a postivie and negative one. The classifer words by counting the number of instances its sees of the postive or negative word lists in a document. The list with the most entries is the decision. Although slightly more complicated rulings such as weighted or thresholding can be implemented too. The postive or negative word lists can be handcrafted or automatically generated. 

A `FreqDist` or Python Dictionary can gain be used to hold the counts for each label seen in the document's training data:

```
pos_freq_dist=FreqDist()
neg_freq_dist=FreqDist()

for reviewDist,label in training_norm:
    if label=='pos':
        pos_freq_dist+=reviewDist
    else:
        neg_freq_dist+=reviewDist
        
pos_freq_dist
```

The words from the wordlists can then be checked in the counts: 

```
words=['bad']

for word in words:
    diff=pos_freq_dist[word]-neg_freq_dist[word]
    print(word,diff)
```

Note, that just because a word itself infers a certain sentiment it can still show up in either type of review. Because of this it important to check the difference between the counts in each sentiment. The words that appears disproportionatly in either category can then be compliles and extracted as automatically derived wordlists. Additionally, the magnitude of the difference can be converted into some sort of weighting mechanism. 

The most common rules for constructing automatric wordlists are `n` most frequent words or thresholding. 

For the former, we pre-determine that we are looking for `n` most popular words for each sentimal. We calculate the differences as above and order by highest differences. The top `n` are out words. 

For the later, we start of doing the same thing and sort the list. This time the length of the list can be variable. We just want all entries that obtained a different more than `x`. 

A good trick to remeber is that `FreqDists` can be added or subtracted from eachother resulting in the difference between sets: `posdiff=pos_freq_dist-neg_freq_dist`

Additonally, `FreqDist` allows you to ge the counts of specific entries using `.get()`: `posdiff.get('excellent',0)` and simply return a list of the most common words using `posdiff.most_common()`

Here is function that combines the above functionality to get the top `k` most frequent words:

```
def most_frequent_words(posfreq,negfreq,topk):
    difference=posfreq-negfreq
    sorteddiff=difference.most_common()
    justwords=[word for (word,freq) in sorteddiff[:topk]]
    return justwords
```

Note that the order that the `FreqDist` are passed here determined the top list that is outputted:

```
top_pos=most_frequent_words(pos_freq_dist,neg_freq_dist,50)
print(top_pos)

top_neg=most_frequent_words(neg_freq_dist,pos_freq_dist,50)
print(top_neg)
```

Here is a function to give a thresholded list:

```
def above_threshold(posfreq,negfreq,threshold):
  difference=posfreq-negfreq
  sorteddiff=difference.most_common()
  filtered=[w for (w,f) in sorteddiff if f>threshold]
  return filtered
```

```
above100pos = above_threshold(pos_freq_dist,neg_freq_dist,100)
print(above100pos)
```

### Creating a Word List Based Classifer

Now that we have a way to construct word lists, we can use them to create a classifer. Below is a basic Class which contains a word list classifer. It inherits from `from nltk.classify.api import ClassifierI` which does not do anything itself but is instead a template. The main benefit of using this is that it ensures that your classifer/model is compatible with the rest of the `NLTK` ecosystem and can seemlessly use other `NLTK` elements such as evaluation tools and batch proccessing methods. Additionally, by inherting this class, you are conceptually agreeing to structure your class as per standard practice. Namely the structure expects `classify(featureset)` which returns the most likely label/decision for a input and `prob_classify(featureset)` which returns a probability distribution on how confident the model is on each label. Additionally, the inherited class as a few automated methods which are included. Once you create the `classify()` and `prob_classify()` you are given `classify_many()` and `prob_classify_many()` which allow you to loop through a list of inputs as a batch. As for evaluation methods, your model can be plugged direction into NLTK functionality: `nltk.classify.accuracy(classifier, test_set)`

```
from nltk.classify.api import ClassifierI
import random

class SimpleClassifier(ClassifierI): 

    def __init__(self, pos, neg): 
        self._pos = pos 
        self._neg = neg 

    def classify(self, doc): 
        #doc is a FreqDist
        score = 0
        
        # add code here that assigns an appropriate value to score
        for word,value in doc.items():
            if word in self._pos:
                score+=value
            if word in self._neg:
                score-=value
        
        return "neg" if score < 0 else "pos" 

    def labels(self): 
        return ("pos", "neg")

#Example usage:

classifier = SimpleClassifier(my_positive_word_list, my_negative_word_list)
classifier.classify(FreqDist("This movie was dreadful".split()))
```

When thinking about train and test sets, it is often more intuative to think about more complex ML and statical methods when there the training set is used to instantiate some sort of model or respresentation that can then be applied to the test set to be evaluated. With wordlist classifers, the training can be thought of as the task of building the worldlist. Better wordlists will perform better on the test set. The code below demonstrates a way of automatically deriving `pos` and `neg` word lists from the training set:

```
class SimpleClassifier_mf(SimpleClassifier):
    
    def __init__(self,k):
        self._k=k
    
    def train(self,training_data):
        
        pos_freq_dist=FreqDist()
        neg_freq_dist=FreqDist()

        for reviewDist,label in training_data:
            if label=='pos':
                pos_freq_dist+=reviewDist
            else:
                neg_freq_dist+=reviewDist
                
        self._pos=most_frequent_words(pos_freq_dist,neg_freq_dist,self._k)
        self._neg=most_frequent_words(neg_freq_dist,pos_freq_dist,self._k)
```

``` 
movieclassifier=SimpleClassifier_mf(100)
movieclassifier.train(training_norm)

testing,labels=zip(*testing_norm)
movieclassifier.classify_many(testing)
```

<div style="page-break-after: always;"></div>

## Document Classification (Part 2)

This lab again builds on sentiment analysis. There will be a closer focus on evaluation metrics and impact of training data size. This lab picks up functions build in previous labs using a `utils.py` file. The file is manually updated with whatver was personally written in previous labs. 

* [Evalution Metrics for Classifer Performance](#evalution-metrics-for-classifer-performance)

### Evalution Metrics for Classifer Performance

* [Accuracy](#accuracy)
* [Precision, Recall, F1-Score](#precision-and-recall)

#### Accuracy

Accuracy is the proportion of documents that are classifed correctly. The function below evaluates can entire classifer inconjection with a specified test set. Note, this function requires all the previous steps where we split the data, constructed world lists and built a classifer.

```
def classifier_evaluate(cls, test_data):
    '''
    cls: an instance of a classifier object which has a classify method which returns "pos" or "neg"
    test_data: a list of pairs where each pair is a FreqDist rep of a doc and its label
  
    returns: float point number which is the accuracy of the classifier on the test data provided 
    '''
    acc = 0
    docs,goldstandard=zip(*test_data) #note this neat pythonic way of turning a list of pairs into a pair of lists
    #pass all of the docs to the classifier and get back a list of predictions
    predictions=cls.classify_many(docs)
    #zip the predictions with the goldstandard labels and compare
    for prediction,goldlabel in zip(predictions,goldstandard):
        if prediction==goldlabel:
            acc+=1
    
    return acc / (len(test_data))
```

```
#Create a new classifier
#Make sure you have updated the code in utils.py to contain your WordList Classifier
#If you update the utils.py code mid-session, you will need to restart the runtime / kernel in order to force it to import the new updated code
movie_classifier2 = SimpleClassifier_mf(100)
#train it
movie_classifier2.train(training)
#evaluate it on the test data
score=classifier_evaluate(movie_classifier2,testing)
print(score)
```

#### Precision, Recall, F1 Score

When classes are unbalnced, accuracy can be misleading. Precision, Recall and F1 Scores are better measures as they allow us to distinguish between different types of errors

Recall:
- Recall is concerned with actual positives. This means that the True Positives are taken as a ratio of the actual positives (even if they were predicted as negative, False Negative)
- Precision is concerned with modelled positives. This means it takes the True Positives as a ratio of all of the instances tha the model labelled as True (even if they were wrong)
- F1-Score is the harmonic mean of the two and the harmonic mean means that it skews towards the lower value and difference between the two are penalised. Harmonic means are sensntive to the minimum. 

There code below constructs a class that builds out a Confusion Matrix. The confusion matrix allows use to easy compute several evaluation metrics from its outputs. This class computes precision, recall and f1:

```
class ConfusionMatrix:
    def __init__(self,predictions,goldstandard,classes=("pos","neg")):
    
        (self.c1,self.c2)=classes
        #self.predictions=predictions
        self.TP=0
        self.FP=0
        self.FN=0
        self.TN=0
        for p,g in zip(predictions,goldstandard):
            if g==self.c1:
                if p==self.c1:
                    self.TP+=1
                else:
                    self.FN+=1
        
            elif p==self.c1:
                self.FP+=1
            else:
                self.TN+=1
        
    
    def precision(self):
        p=0
        #put your code to compute precision here
        p = self.TP / (self.TP + self.FP)
    
        return p
  
    def recall(self):
        r=0
        #put your code to compute recall here
    
        return r
  
    def f1(self):
        f1=0
        #put your code to compute f1 here
        p=self.precision()
        r=self.recall()
        f1=p*r/()
        return f1 


#docs will contain the documents to classify, labels contains the corresponding gold standard labels
docs,labels=zip(*testing)
senti_cm=ConfusionMatrix(movie_classifier1.classify_many(docs),labels)
print(senti_cm.TP)
print(senti_cm.FP)
print(senti_cm.TN)
print(senti_cm.FN)
senti_cm.precision()
```

<div style="page-break-after: always;"></div>

# Week 4 - Further Document Classification

This week continues to look into document classifcation. It starts with some probability theory which lays the ground to move into Machine Learning classification, specifically Naive Bayes. One of the main issues when applying ML to Natural Language problems is data sparisty. Word do not occur that often relative to the number of words used in a document. Also, in terms of an entire vocabulary, document use very few features/words. In the context of Naive Bayes, this lab looks into "add-one-smoothing" to address the 0 counts of features. 

1. [Lecture Notes](#week-4---lecture-notes)
2. [Lab Session](#week-4---lab-session)

## Week 4 - Lecture Notes

* [Probability Theory](#probability-theory)
* [Naive Bayes Classification](#naive-bayes-classification)
    * [Instantiating the Problem](#instantiating-the-problem)
    * [Bayes Rule](#bayes-rule)
    * [Naive Assumption](#naive-assumption)
    * [Training a Naive Bayes](#training-a-naive-bayes)
    * [Calculating Conditional Probabilities ](#calculating-conditional-probabilities)
        * [Multi-variate Bernoulli Model](#multi-variate-bernoulli-model)
        * [Multinomial Model](#multinomial-model)
        * [Multinomial Model Truncated to 1](#multinomial-model-truncated-to-1)
    * [Smoothing](#laplace-smoothing)

## Probability Theory

A Random Variable has a predefined range of values. For example, is the RV is "a student lives on campus" then the range of values are `{true, false}`. The sum of all the possible RV values will sum to 1: $ \sum_{v} P(X = v) = 1 $

The probability that X has some value **v** is written as: $P(X=v)$. For example, $P(C=true) = \frac{100}{250} = 0.4$.

In the case of the living on campus question, the two outcomes are dependent. They cannot occur at the same time. However, we could look at two events that are independent. `a = living on campus = C = True` and `b = regularly late for class = L = true`.

This $ P(b|a) $ is the way to present conditional probability. It is the probability of `b` occuring given that `a` has already occured. In the case of independent events, the probability is the same as $ P(b) $: $ P(b|a) = P(b) $. If this is true then it means that the event events are completely unrelated and there is no association between them both. For this example example, that probably isn't true as living on campus would make it easier to be on time for class. 

Conditional probability is an important concept and its equation is made up of different parts. The conditional probability of two events is equal to the ratio of the joint probability to the marginal probability

$$P(A|B) = \frac{P(A \cap B)}{P(B)}$$

Conditional probability is the likelihood of an event occurring given that another event has already happened. It allows us to update our beliefs or predictions based on new information.

$P(A \cap B)$ is the joint probability (both happening). It is the intersection whereby two events occur. It can be written $P(A \cap B)$ or 5$P(A, B)$. If you draw a card from a deck, the joint probability of drawing a card that is both Red AND an Ace is $2/52$ (since there are only two red aces: Hearts and Diamonds).

Marginal probability is the probability of a single event occurring, regardless of the outcome of any other variables. It "ignores" other information. Using the same deck of cards, the marginal probability of drawing a Red card is 13$26/52$ or 14$1/2$.15 We don't care if it’s an Ace, a King, or a 2—we only care that it is red.

Bayes' Theorem (or Bayes' Law) is essentially a way to "reverse" conditional probability. It allows you to calculate the probability of a cause given its effect. It is derived directly from the definition of conditional probability.

By rearranging the conditional probability equation for the joint probabiliy we find: 

$$P(A \cap B) = P(A|B) \times P(B)$$

However, the intersection is symmetrical ($A \cap B$ is the same as $B \cap A$). So we can also write:

$$P(A \cap B) = P(B|A) \times P(A)$$

Because both expressions equal 3$P(A \cap B)$, we can set them equal to each other:

$$P(A|B) \times P(B) = P(B|A) \times P(A)$$

By dividing both sides by $P(B)$, we get Bayes' Theorem:

$$P(A|B) = \frac{P(B|A) \times P(A)}{P(B)}$$

It should be noted that mathematically, Conditional Probability and Bayes' Theorm calcuation the same thing: $P(A|B)$. However, the Conditional Probability formula is more the mathmematical definition where by Bayes is the tool for inference when you don't have the full picture. 

Conditional Probability could only be used when you how the full joint probability map. For exampe, you already know how many people are "Sick" and "Tested Positive" and you are just scoping into one specific part of the data. 

With Bayes Theorm you might only have two pieces of information. Like the accuracy of a test and rarity of a disease and you are working backwards to derive the probabilty of something.

Bayes is generally written using an Evidence (E) and Hypothesis (H) approach and have four parts. 

1. **Prior: $P(H)$** This is your "Initial Gut Feeling." Before you even look at the email, what do you know about the world?
    - Example: "I know that 80% of all emails sent globally are spam." Your starting point is $P(\text{Spam}) = 0.8$.

2. **Likelihood: $P(E|H)$** This is the "Consistency Check." If the email really were spam, how likely is it that it would contain the word "WINNER"? 
    - Example: "Spam emails use the word 'WINNER' all the time (maybe 60% of them)."

3. **Evidence (Marginal): $P(E)$*** This is the "Uniqueness Check." How common is the word "WINNER" across all emails (both spam and regular)? 
    - Example: "How often do my friends or boss send me the word 'WINNER'? Rarely. So the word 'WINNER' is pretty uncommon in total."
    - Note: If the evidence is common (like the word "the"), it’s not a very helpful clue. If the evidence is rare, it’s a very strong clue!

4. **Posterior: $P(H|E)$** This is your "Final Answer." You combine your gut feeling with the new clue to get a final probability. 
    - Example: "Given that I saw the word 'WINNER', what is the updated probability that this is Spam?"

$$P(H|E) = \frac{P(E|H) \cdot P(H)}{P(E)}$$

## Naive Bayes Classification

Recall the general architecture of document classification: 

document -> feature extractor (vectorize) -> features (vector)

The vector is passed into a classifer with consults a model, or ensemble of models, to detemined the mostly likely class given the features. 

In Machine Learning, the model is trained on labeled data where the given features/vectors has a known outcome. The model learns which parameters in the features are important. From here the model can be applied to unlabelled data to work out what labelled the features should be assigned to. 

### Instantiating the Problem

The following bullet points instantiate the problem:

* Any data instance is a tuple of features: $(f_1, f_2, ..., f_n)$. In NLP this would be something like either a list of words or a bag-of-words. Fpr shorthand, we write $f_1^2$.

* The set of possible classes is C. If the input is sentences of 10 words then the set is all true sentence made up of 10 words. If there is no brief and it is just any sentence or document then the combination of features (words) will be unfathomamly large

* A particular class is denoted by $c$ where $ c \in C $

* The goal of a model is to take in a set of features $f_1^2$ and assign a class based on the features. The decision itself will be derived from a probability with the most likely class being selected. This is written: $P(c|f_1^2)$. The mathmatical way of writting to select the most probable class is $\mathop{\mathrm{argmax}}_{c} P(c|f_1^n)$

### Bayes Rule

We can put this into the Bayes Rule:

$$\operatorname*{argmax}_{c} P(c|f_1^n) = \operatorname*{argmax}_{c} \frac{P(f_1^n|c) \cdot P(c)}{P(f_1^n)}$$

In this example the prior is the distribution of the class as a whole and it is updated with the likelihood of the feature occuring given we know that the class has occured. This is over the evidence of the feature having occured. Finally giving us the posterior probabiltiy which tells use the probabilty that a class is belongs to this set of features. 

(Likelihood * Prior) / Evidence

One thing that is important to point out is that the evidence is a normalization term. It ensures that the outcome posterior probabilities all sum to 1 and therefore the output of each calculate is real probability. However, the calculation is repeated for each class andf the evidence is the same for each calculation. Therefore, the term can be dropped and the proportion of the outcomes is still valid. This means the `argmax` can still just look for the highest value and it will be still correct. We can simplify our calculations and workflow but at the trade of see the exact probabilities. It should be considered whether the use case requires the individual probablities or we just want to know the most likely. 

Also remember that the definition of the posterior is the the final "updated" belief. It answers the question: "Now that I've seen these specific words (features), what is the probability that this article belongs to the Sports category?"

### Naive Assumption

Now, at this one, one really important thing to consider is the feature vector. In order to carry out this bayes calculation we need to work out the exact probability of our sentence occuring given all of the features (words) in a vocabulary. This would result in a miniscule probability as a single sentence will be a very sparse vector. This is know as a curse of dimensionality. Additionally, if we assume a dependendancy relationship between words, then we need to work out dependancies for all combinations of words. If we have a 10k word vocab then this results in a model will billions of parameters. 

There is a solution to this which is know as the Naive Bayes application. Here we assume that words are independanance features. This probably isn't true for words but it will get us a good enough answer. Instead of working out endless probabilitiy dependancies of each posssilbe comination of words, we just treat each word as independent feature with is own probablitily of occur. Then we take all the words that occured in a sentence and compute the joint probability: 

$$ \operatorname*{argmax}_{c} P(c | f_1^n) \approx \operatorname*{argmax}_{c} \left( \prod_{i}^n P(f_i | c) \right) \cdot P(c) $$

This is still a complex task as we need to know the probability of each word but is much more simple. Additionally, in practice this is easier to implement. It is actually just a boolean `FreqDist` approach that is passed into a model. This approach is known as Naive Bayes Classification as it implements as naive assumption of independence.

### Training a Naive Bayes

To train a naive bayes we need to work out two things which we learn from the labelled training data: 

* The prior probabilities of each class, i.e. how much each class occurs in the training data: $P(c)$

* The class conditional probabilities of each feature given a class: $P(f|c)$. That is the say the probability of a words occurance split down into class subsets. If this were sentiment analysis of good and bad, the word "terrible" should have a higher probability derived from the bad class. 

Then with these parameters caclulated and learned, we can apply them to unlabelled features to determined what their most likely class is. 

Calculating the probability of the prior is simple. We just look at the proportion of documents labelled `X` compared to the total number of documents. 

### Calculating Conditional Probabilities 

For the conditional probabilities we want to know the probability of the feature vectors occurance for each class. We know the label of each document and the features/words in each document. There are 3 approachs to calculating the conditional probabilites:

* Multi-variate Bernoulli Model 
* Multinomial Model 
* Multinomial Model Truncated to 1

#### Multi-variate Bernoulli Model 

The Bernoulli model only considers whether a feature is in a document or not. It is equivelant to our boolean bag-of-words approach, it takes no consideration of frequency within the document. The maximum likelihood estimate for the conditional probability $P(f_j|c)$ is the proportion of documents labelled with class $c_i$ that have feature $f_j$. It be pretty easy to compute, if there at 100 documents with class positive and 80 have the word "amazing" then the calculation is $\frac{80}{100}$. The Bernoulli model only focuses on the presence or absense of a word from a document.

$$ P(f_j|c) = \frac{|\{i | label(d_i) = c \text{ and } f_j \in feats(d_i)\}|}{|\{i | label(d_i) = c\}|} $$

#### Multinomial Model 

The Mutlinomal Naive Bayes Model shifts is focus to word counts (frequencies). This will be muc better for text application where occurance of a word mutliple times in a document will have signficance, assuming it is isnt a connective or stopword. This will look at the proportion of total words within a class. The numerator will count every single time the word $f_j$ appears across all documents in class $c$. If "amazing" appears twice in one positive document and three times in another, that counts as 5.  The denomenator counts the total number of words (the total length) of all documents in class $c$ combined.

$$P(f_j|c) = \frac{count(f_j, c)}{\sum_{f \in V} count(f, c)}$$

#### Multinomial Model Truncated to 1

An extension of the mutlinomial model is the truncated to 1 version. In this, each documents occurance of a word is truncted to 1. This is true for the numerator and denomenators. The numerator is capped at the number of documents, i.e. a particular word comes up in all of them. The denominator is the sum of each documents vocab/types $|V|$. It is similar to Bernoulli in the sense that the feature representation are binary but different at the denomenator will be much larger. It may improve on the general mutlinomial as documents with a high properotion of a single word cannot bias the learned parameters (conditional probabilities). 

### Laplace Smoothing

An issue that keep reoccuring for out NLP tasks is sparseness. Words are sparse and sentences or bag-of-word combinations are even sparser. For our naive assumption where we focus on individual words, a huge issue arises when a word comes up in the test set that was not in the training set, this is known as the Zero Frequency problem. A word exists and was seen in the training set, however, is was only seen in a certain context. Perhaps in postive or negative sentiment analysis, it was only seen in the positive class, hence, the model knows it exists but doesn't know how to assign a value to it for a certain class. Given that Naive Bayes is a product model, anything assigned a 0 probability will result in the model producing a 0 probability overall. 

The solution is to simply add one when estimating the likelihood probabilities $p(f|c)$. You add 1 to all words in the vocab, this way all words are assigned a value for all classes. 

In probability, if you've never seen a black swan, a "Maximum Likelihood" approach would say the probability of a black swan is $0$. Smoothing says, "I haven't seen one yet, but I'll reserve a tiny bit of probability space just in case one exists."

Remember that when you add $+1$ to every word in the numerator, you are effectively adding "fake" counts to the model. If your vocabulary has 10,000 words, you've just added 10,000 fake observations. To keep the math honest, you must add that same 10,000 ($|V|$) to the denominator.

Imagine a "Spam" class that has seen 1,000 total words during training. You see a new word "Urgent" in a test email.

| Situation | Numerator | Denominator | Probability $P(\text{Urgent} |
| :--- | :--- | :--- | :--- |
| No Smoothing | 0 | 1,000 | $0.0$ (Crashes the whole model) |
| Laplace Smoothing | $0 + 1$ | $1,000 + 20,000^*$ | $0.000047$ (Tiny, but safe) |

Sometimes "Add-One" is too much (it gives too much weight to rare words). In those cases, people use Lidstone Smoothing, where instead of adding $1$, you add a smaller fraction like $\alpha = 0.1$.

<div style="page-break-after: always;"></div>

## Week 4 - Lab Session

There are 2 notebooks for lab 4:
- [Naive Bayes Classification]() `Lab_4_1_SOLUTIONS.ipynb`
- [Naive Bayes Classification (Part 2)]() `Lab_4_2_SOLUTIONS.ipynb`

## Naive Bayes Classification (Part 1)

This lab again focuses on sentiment analysis but builds on the Word List classifers by developing a Naive Bayes classifer.

* [How a Naive Bayes Classifer Works](#how-a-naive-bayes-classifer-works)
* [Conditional Probabilities](#conditional-probabilities)
* [Feature Probabilities](#feature-probabilities)
* [Naive Bayes Classify](#naive-bayes-classify)
* [Add One Smoothing and Known Vocab](#add-one-smoothing-and-known-vocab)
* [Out-of-Vocabulary words (OOV)](#out-of-vocabulary-words-oov)
* [Underflow](#underflow)
* [Complete Naive Bayes Classifer Class](#complete-naive-bayes-classifer-class)

This labs starts by building a very basic classifier that determins if the input is about the weather or football. All inputs into the model will be one of the topics. 

```
weather_sents_train = [
    "today it is raining",
    "looking cloudy today",
    "it is nice weather",
]

football_sents_train = [
    "city looking good",
    "advantage united",
]
```

Recall that the independence assumption of Naive Bayes means that the input into the model will be that of a Bag-of-Words. The structure within the BoW can either be Bernoulli where words either appear or not in a documunent or Multinomial where the frequency of words is taken into account. The example given will use Mutlinomial events.

This is how we will set the data up: 

```
from nltk.probability import FreqDist

weather_data_train=[(FreqDist(sent.split()),"weather") for sent in weather_sents_train]

football_data_train=[(FreqDist(sent.split()),"football") for sent in football_sents_train]

football_data_train=[(FreqDist(sent.split()),"football") for sent in football_sents_train]
```

The output is structued like this. It is a list of BoW's from each sentence with their label attached within a tuple. A list of tuples with a dict and string nested:

```
[(FreqDist({'is': 1, 'it': 1, 'raining': 1, 'today': 1}), 'weather'),
 (FreqDist({'cloudy': 1, 'looking': 1, 'today': 1}), 'weather'),
 (FreqDist({'is': 1, 'it': 1, 'nice': 1, 'weather': 1}), 'weather'),
 (FreqDist({'city': 1, 'good': 1, 'looking': 1}), 'football'),
 (FreqDist({'advantage': 1, 'united': 1}), 'football')]
```

### How a Naive Bayes Classifer Works

In order to classify a document we need to be able to work out which classes probabilty is greater:

$$P(\text{weather} \mid d) \quad \text{versus} \quad P(\text{football} \mid d)$$

$d$ is the input sentence are for a single instance passed into the model, the same sentence's probability will be computed for each class:

$$P(\text{weather} \mid \text{``today is looking cloudy''}) \quad \text{versus} \quad P(\text{football} \mid \text{``today is looking cloudy''})$$

The idea is that the sentence which is most suited to a topic will have a higher probability for that class. The english translation of what is written is the "probability of this (weather or football) being class given that we have seen the input sentence"

To build out a Naive Bayes classifer you start with the Bayes Rule: 

$$P(X|Y) = \frac{P(Y|X)\cdot P(X)}{P(Y)}$$

This leads to the following comparison: 

$$\frac{P(d \mid \text{weather}) \cdot P(\text{weather})}{P(d)} \quad \text{versus} \quad \frac{P(d \mid \text{football}) \cdot P(\text{football})}{P(d)}$$

Because both side are divided by the same thing we can drop/cancel out the denominator. Though note, that doing this means the output will not be a true probabiliy, however, the magnitute of the numbers will still be true, i.e. a higher number is more probable, which is all we need to execture a Naive Bayes, though is we need true probabilities for another reason then we cannot use this simplification: 

$$P(d \mid \text{weather}) \cdot P(\text{weather}) \quad \text{versus} \quad P(d \mid \text{football}) \cdot P(\text{football})$$

This is what each of the probabilities mean in isolation:

1. $P(\,d\,|\,\text{weather}\,)$: this is the probability of a document in the `weather` category being the document $d$

2. $P(\,d\,|\,\text{football}\,)$: this is the probability of a document in the `football` category being the document $d$

3. $P(\,\text{weather}\,)$: this is the probability of a randomly selected document being of category `weather`.

4. $P(\,\text{football}\,)$: this is the probability of a randomly selected document being of category `football`.

$P(\,\text{weather}\,)$ and $P(\,\text{football}\,)$ are really important piece of information we need to calculate and are know as the class prior. They represent out knowledge prior to adding any addition information, which in our case will be the input sentnece. The prior are the class wide distributions. 

Prior are simple to calculate and are the ratio of documents list with class $n$ against call documents: 

$$P(\text{weather})=\frac{n_1}{n_1+n_2} \qquad \text{and} \qquad P(\text{football})=\frac{n_2}{n_1+n_2}$$

The code below is a basic function to calculate prior for any number of given classes. It works by initalizing a dictionary with will be filled interatively with the number of times a class is seen connected to a document. With this function, it doesn't actually matter what format the document is in, list vs BoW, just that the training data takes the structure of a tuple with `(document, label)` whereby the label can be accessed. In the middle of this function, after all the class instances can be counted, the total number of documents is counted. Finally, the dict keys (classed) are loop through and the counts are update to be a ratio based on the total value. The output is a dict of classes with their respective prior probability value:

```
def class_priors(training_data):
    priors={}
    for (doc,label) in training_data:
        priors[label]=priors.get(label,0)+1
    total=sum(priors.values())
    for key,value in priors.items():
        priors[key]=value/total
    return priors

class_priors(train_data)

{'football': 0.4, 'weather': 0.6}
```

### Conditional Probabilities

Next the task is calculate the conditional probabilities which is $P(\,d\,|\,\text{weather}\,)$ and $P(\,d\,|\,\text{football}\,)$. That is the probability of seeing some  document $d$ given that we have observed a class. 

The problem is that a documents are long sequence of words and are generally unique, that means we won't have been the exact document in the training data. Remember, a document is just any text based thing. It can be an entire magazine or just a sentence on twitter, but even then most tweet have some variation in words and grammar even if thay are saying thr same thing. 

To address this, the Naive Bayes makes a simplifying assumption of independance. Each word in a document is an independant feature and comes with its own probability of occuring. In reality, words used are related, domain words used together and certain words lead to other words being used. However, the assumption allows us to practically execture the model and gives us an approximation. The result is the the previous calcuation of $P(\,\text{"today is looking cloudy"}\,|\,\text{weather}\,)$ now becomes that of a joint probability product:

$$
P(\,\text{"today"}\,|\,\text{weather}\,)\times P(\text{"is"}\,|\,\text{weather}\,)\times P(\text{"looking"}\,|\,\text{weather}\,)\times P(\text{"cloudy"}\,|\,\text{weather}\,)
$$

For the general case, with class $c$ and document $d=\{w_1,\ldots,w_n\}$, we have:

$$
\begin{aligned}
P(\,d\,|\,c\,) &=& P(\,\{w_1,\ldots,w_n\}\,|\,c\,)\\
&=& \prod_{i=1}^n P(\,w_i\,|\,c\,)
\end{aligned}
$$

### Feature Probabilities

In order to exectute these conditional probabiltiy calculations we need to derive estimates of the probabilities for each word/feature. $P(\,\text{"cloudy"}\,|\,\text{weather}\,)$, $P(\text{"is"}\,|\,\text{weather}\,)$, $P(\text{"today"}\,|\,\text{weather}\,)$, and $P(\text{"looking"}\,|\,\text{weather}\,)$.

To start, you look into the training data and find all of the documents that are labelled `weather` and compile a count of all the documents tokens, e.g. 12 tokens with 8 types. 

- the probability of seeing "today" in a `weather` document is $\frac{2}{11}$
i.e. $P(\text{"today"}\,|\,\text{weather})=\frac{2}{11}$;
- the probability of seeing "it" in a `weather` document is $\frac{2}{11}$ 
i.e. $P(\text{"it"}\,|\,\text{weather})=\frac{2}{11}$;
- the probability of seeing "is" in a `weather` document is $\frac{2}{11}$

You repeat this for all of the words (types) and the condiitional probabilites will sum to 1. You sent do the same thing for the other class(es) and in the end you have a respository for all words seen with respect to a class. 

The function outlines a way to calculate the conditional probabilities from the training data. It starts by initalizing a dictionary to hold the probabilities. The training data is looped through in `(doc, label)` tuple format. A variable called `classcond` is created which holds a copy of the `label` if it exists in `conds` otherwise just holds an empty dictionary. Then the items of the `doc`, with is in `FreqDist` BoW form, are looped through. The words from the `doc` are added to the `classcond` dict, if they already exist their freqency is located using `.get()` and the additional frequency from the current BoW is added, otherwise if it a new entry just the new frequency is added. Finally, within each iteration of the loop, the `classcond` dictionary which holds the counts is called to `conds` where the key is the label. This line is within the loop so it may look like it is overwritting the label key for each document but it is important to notice that `classcond` is always either a fresh empty dictionary or an ongoing version to be updated which is pulled in on each document using `.get(label,{})` so `conds[label]` is overwritting the key but with an updated version of the existing value. Finally, after all documents are looped through, the `conds` dict is looped through extracting `label,dist`, remember this dict as the `label` as the key. For each label at total feature count is computed using `sum(dist.values())` and then within the `cond` the `dist` dictionary which holds the feature and frequencies is updated so that frequences are a ratio against the total features `value/total`: 

```
def cond_probs(training_data):
    conds={}
    for(doc,label) in training_data:
        classcond=conds.get(label,{})
        for word,value in doc.items():
            classcond[word]=classcond.get(word,0)+value
        
        conds[label]=classcond
    print(conds)
    for label,dist in conds.items():
        total=sum(dist.values())
        conds[label]={key:value/total for (key,value) in dist.items()}
        
    return conds

cond_probs(train_data)

# this the printed version of the counts
{'weather': {'today': 2, 'it': 2, 'is': 2, 'raining': 1, 'looking': 1, 'cloudy': 1, 'nice': 1, 'weather': 1}, 'football': {'city': 1, 'looking': 1, 'good': 1, 'advantage': 1, 'united': 1}}

# this is the outputted conditional probabilities for each word
{'football': {'advantage': 0.2,
  'city': 0.2,
  'good': 0.2,
  'looking': 0.2,
  'united': 0.2},
 'weather': {'cloudy': 0.09090909090909091,
  'is': 0.18181818181818182,
  'it': 0.18181818181818182,
  'looking': 0.09090909090909091,
  'nice': 0.09090909090909091,
  'raining': 0.09090909090909091,
  'today': 0.18181818181818182,
  'weather': 0.09090909090909091}}

```

### Naive Bayes Classify

Now we have the functions to compute prior and conditional probabiltiies which makes up the components of a naive bayes classifer:

```
c_priors = class_priors(train_data)
c_probs = cond_probs(train_data)
```

Now these two functions can easily be wrapped into a `classify` function, or method to fit into the classes we made earlier: `classify(doc,priors,c_probs)`. The logic would involve using functions outputs to calculate a probability for each class based on the input `doc`. Remeber, this will take the form of the `product of the join prob for all tokens` * `prior for the class`, then we just take the highest of the two.

```
c_priors = class_priors(train_data)
c_probs = cond_probs(train_data)
sent = "looking cloudy today"
doc = FreqDist(sent.split())
classify(doc,c_priors,c_probs) # need to write a function with logic for computation
```

This follow function works by taking a copy of the `prior` under the variable `doc_probs` and updating the prior for each work in a document using a loop which updates and overwrittes `doc_probs` each iteration in th end `doc_probs` holds two probabilties which we can select for the highest:

```
def classify(doc,priors,c_probs):

    #<put your definition of classify here>
    doc_probs=priors
    for word in doc.keys():            
        doc_probs={classlabel:sofar*c_probs[classlabel].get(word,0) for (classlabel,sofar) in doc_probs.items()}

    highprob=max(doc_probs.values())
    print(doc_probs.values())
    print(highprob)
    classes=[c for c in doc_probs.keys() if doc_probs[c]==highprob]
    print(classes)
    return random.choice(classes)
```

### Add One Smoothing and Known Vocab

One large issue with the implementation shown is that is does not handle the problem of sparsity, particularly where in the training data a word shows up in one class and not the other. This is a huge issue because we need to calculate the probabilties for both classes. If a word never came up in one class, when we go to look up its conditional probability then we won't get anything. As we are using a Naive solituion we take the product of all the conditional probabilities. The solution to this is "Add One Smoothing" which will allow us to avoid zero probabiltiies by adding a 1 count to every word in the vocab. The easiest way to acheive this is to make a copy of the known vocabulary found in the training data. Remember the classifer can only learn about features found in the training data. The function below creates a known vocabilary set from a inputted training data:

```
def known_vocabulary(training_data):
    known=set()
    for doc,label in training_data:
        for word in list(doc.keys()):
          known.add(word)
    return known

vocab=known_vocabulary(train_data)

len(vocab)

"12"

vocab

{'advantage',
 'city',
 'cloudy',
 'good',
 'is',
 'it',
 'looking',
 'nice',
 'raining',
 'today',
 'united',
 'weather'}
```

Now for each word in the known vocabulary and for every class, we need to add one extract count to the records. Below is an updated version of the `cond_probs` function we made earlier.  In the middle of the function the `known_vocabulary` function is invoked. Then, once we are upacking the `conds` labels, we loop through the vocab set. We check if a word exists in the labels `classcond` if it does we `+1`, if it doesn't we instantiate a record and `+1`. Aside from these steps, the `cond_probs` function is the same as before: 

```
def cond_probs(training_data):
    conds={}
    for(doc,label) in training_data:
        classcond=conds.get(label,{})
        for word,value in doc.items():
            classcond[word]=classcond.get(word,0)+value
        
        conds[label]=classcond

    vocab=known_vocabulary(training_data)
    for label, classcond in conds.items():
        for word in vocab:
        
            classcond[word]=classcond.get(word,0)+1
        conds[label]=classcond
            
    for label,dist in conds.items():
        total=sum(dist.values())
        conds[label]={key:value/total for (key,value) in dist.items()}
        
    return conds
```

### Out-of-Vocabulary words (OOV)

Something we haven't covered so far is Out-of-Vocabulary words. These are words at arise in the test set or IRL once the model is deployed and were not in the training set. Because they were not in the training set, the model did not learn how to process these words, hence, the model will break or return a `0` probability. The code below makes use for the `known_vocab` function and whilst looping through a document checks if the word exists in the vocab, if it doesn't then it isn't processed. 

```
def classify(doc,priors,c_probs,known):

    doc_probs=priors
    for word in doc.keys():
        if word in known:
            doc_probs={classlabel:sofar*c_probs[classlabel].get(word,0) for (classlabel,sofar) in doc_probs.items()}
    print(doc_probs)
    highprob=max(doc_probs.values())
    classes=[c for c in doc_probs.keys() if doc_probs[c]==highprob]
    print(classes)
    return random.choice(classes)
        
c_priors = class_priors(train_data)
c_probs = cond_probs(train_data)
sent = "looking cloudy today"
doc = FreqDist(sent.split())
classify(doc,c_priors,c_probs,known_vocabulary(train_data))
```

```
sent = "looks cloudy today"
doc = FreqDist(sent.split())
classify(doc,c_priors,c_probs,known_vocabulary(train_data))

{'weather': 0.006805293005671077, 'football': 0.001384083044982699}
['weather']
'weather'
```

### Underflow

Recall the Naive product implementation we went through earlier:

$$
\begin{align}
P(\,d\,|\,c\,) &=& P(\,\{w_1,\ldots,w_n\}\,|\,c\,)\\
&=& \prod_{i=1}^n P(\,w_i\,|\,c\,)
\end{align}
$$

This tells that in order to derive the probability for some document, we need to mutliply all of the conditional probabilies for each word to get the joint probability. 

This has been fine for the example toy sentence we have been working with but when we start to work with whole files and documents we find ourselves with a situation where we are mutliplying where large numbers of words which have very small probabilties. This leads to the underflow probablem where the computed probabilities are tiny, basically 0. 

To avoid this, insread of taking the product of conditional probabilties, we will ADD the log of the probabilties. This is fundamental property of logarithms: the log of a product is equal to the sum of the logs. 

In Naive Bayes, you are trying to calculate the likelihood of a document ($d$) given a class ($c$). When you take the log of both sides, the multiplication symbols literally "turn into" addition symbols. Since the logarithm is a monotonically increasing function (meaning if 2$x > y$, then 3$\log(x) > \log(y)$), the "winner" stays the same.4 The class that has the highest product will also have the highest sum of logs. 

Now, the practicle reason we are doing this in NLP is because the product approach will give us a number that is so tiny e.g. $10^{-150}$. that a computer’s memory cannot store it accurately. It rounds down to exactly 0.0, which ruins your calculation. This is called Arithmetic Underflow.

 Logarithms convert these tiny decimals into manageable negative numbers (e.g., $\log(0.0001) = -4$). Adding $-4 + (-4) + (-4)$ is numerically stable and will never cause your computer to round to zero.

$$
\begin{align}
\log(P(\,d\,|\,c\,)) &=& \log(P(\,\{w_1,\ldots,w_n\}\,|\,c\,))\\
&=& \sum_{i=1}^n \log(P(\,w_i\,|\,c\,))
\end{align}
$$

Below is an updated `classfiy` function that stores the probabilities as `log()` values and implements a summation rather than product: 

```
import math
def classify(doc,priors,c_probs,known):

    doc_probs={key:math.log(value) for (key,value) in priors.items()}
    #<put your definition of classify here>
    for word in doc.keys():
        if word in known:
            doc_probs={classlabel:sofar+math.log(c_probs[classlabel].get(word,0)) for (classlabel,sofar) in doc_probs.items()}

    highprob=max(doc_probs.values())
    classes=[c for c in doc_probs.keys() if doc_probs[c]==highprob]
    return random.choice(classes)
        
c_priors = class_priors(train_data)
c_probs = cond_probs(train_data)
sent = "looking cloudy today"
doc = FreqDist(sent.split())
classify(doc,c_priors,c_probs,known_vocabulary(train_data))
```

### Complete Naive Bayes Classifer Class

```
from nltk.classify.api import ClassifierI

class NBClassifier(ClassifierI):
    
    def __init__(self):
        
        pass
    
    def _set_known_vocabulary(self,training_data):
        #add your code here
        known=[]
        for doc,label in training_data:
            known+=list(doc.keys())
        self.known= set(known)
    
    def _set_priors(self,training_data):
        #add your code here 
        priors={}
        for (doc,label) in training_data:
            priors[label]=priors.get(label,0)+1
        total=sum(priors.values())
        for key,value in priors.items():
            priors[key]=value/total
        self.priors=priors
        
    def _set_cond_probs(self,training_data):       
        #add your code here
        conds={}
        for(doc,label) in training_data:
            classcond=conds.get(label,{})
            for word in doc.keys():
                classcond[word]=classcond.get(word,0)+1
        
            conds[label]=classcond
    
        for label, classcond in conds.items():
            for word in self.known:
        
                classcond[word]=classcond.get(word,0)+1
            conds[label]=classcond
            
        for label,dist in conds.items():
            total=sum(dist.values())
            conds[label]={key:value/total for (key,value) in dist.items()}
        
        self.conds=conds
    
    def train(self,training_data):
        self._set_known_vocabulary(training_data)
        self._set_priors(training_data)
        self._set_cond_probs(training_data)
    
    def classify(self,doc):
        #add your code here
        doc_probs={key:math.log(value) for (key,value) in self.priors.items()}
        for word in doc.keys():
            if word in self.known:
                doc_probs={classlabel:sofar+math.log(self.conds[classlabel].get(word,0)) for (classlabel,sofar) in doc_probs.items()}

        highprob=max(doc_probs.values())
        classes=[c for c in doc_probs.keys() if doc_probs[c]==highprob]
        return random.choice(classes)
```

```
myclassifier=NBClassifier()
myclassifier.train(train_data)
myclassifier.classify_many(doc for (doc,label) in test_data)
```

<div style="page-break-after: always;"></div>

## Naive Bayes Classification (Part 2)

This lab build on all previous labs and is the stage of putting everything together. I won't go through everything in detail here but the file can be refered back to if required. 

Below is a function design to bring in data from the NLTK movie_reviews corpus, split it, label it, normailse it and put it into `FreqDist` form ready to be used:

```
def get_train_test_data():
    
    #get ids of positive and negative movie reviews
    pos_review_ids=movie_reviews.fileids('pos')
    neg_review_ids=movie_reviews.fileids('neg')
   
    #split positive and negative data into training and testing sets
    pos_train_ids, pos_test_ids = split_data(pos_review_ids)
    neg_train_ids, neg_test_ids = split_data(neg_review_ids)
    #add labels to the data and concatenate
    training = [(movie_reviews.words(f),'pos') for f in pos_train_ids]+[(movie_reviews.words(f),'neg') for f in neg_train_ids]
    testing = [(movie_reviews.words(f),'pos') for f in pos_test_ids]+[(movie_reviews.words(f),'neg') for f in neg_test_ids]
    #now normalise and create bag-of-words FreqDist representations
    training_norm=[(FreqDist(normalise(wordlist)),label) for (wordlist,label) in training]
    testing_norm=[(FreqDist(normalise(wordlist)),label) for (wordlist,label) in testing]
    return training_norm, testing_norm

random.seed(67)
training,testing=get_train_test_data()

nb_classifier=NBClassifier()
nb_classifier.train(training)

docs,labels=zip(*testing)
cm=ConfusionMatrix(nb_classifier.classify_many(docs),labels,classes=('pos','neg'))
cm.precision()
```

In all of the previous labs we have mostly focused on building out our own classifer from scratch (mostly). But in practice, once the processes are understood it is generally easier to pick up a prebuilt model like those from `NLTK` or `sklearn` or `pytorch`

```
from nltk.classify import NaiveBayesClassifier

#note that the NaiveBayesClassifier.train() method is a class method which returns the classifier object.
#this is different to ours and other classifiers which are first instantiated and then trained via an object method
nltk_nb=NaiveBayesClassifier.train(training)
```

<div style="page-break-after: always;"></div>

# Week 5 - Document Similarity and Clustering

The past few weeks have looked at Document Classification with is generally a supervised tasks working with labelled data. Clustering and similarity techniques typically are applied to unlabelled data and are a form of unsupervised learning. Goal is to find a way to link certain documents and say they are similar

1. [Lecture Notes](#week-5---lecture-notes)
2. [Lab Session](#week-5---lab-session)

## Week 5 - Lecture Notes

* [Document Similarity](#document-similarity)
    * [Measuring Value of a Term ](#measuring-value-of-a-term)
    * [Term Frequency Inverse Document Frequency (TFIDF)](#term-frequency-inverse-document-frequency-tfidf)
    * [Vector Similarity](#vector-similarity)
    * [Cosine Similarity](#cosine-similarity)
* [Beyond Words](#beyond-words)
    * [Collocations, Joint Probability, Independent Events](#collocations-joint-probability-independent-events)
    * [Point-wise Mutual Information (PMI)](#point-wise-mutual-information-pmi)
* [Clustering](#clustering)
    * [K-Means](#k-means)
    * [Agglomerative Hierachical Clustering](#agglomerative-hierachical-clustering)

### Document Similarity

With classification we had a fixed number of classes and we knew the classes in advance, i.e. postive or negative

When dealing with similarity, we may not know any of the classes or how many there may be. Similarity as a measure is vague as documents in different classes may be similar in some ways but different in others to justify a different class. Similarity can work inconjeciton with classification. We have a large sample of unsupervised data, we can learn a way to split these by some sort of measure of similarity. Then we can take very small sample of labelled data and placed these into the learn splits. Through similarity, these small number of labelled points can detemined what true class the unsupervised splits belong to

#### Measuring Value of a Term 

We need to assign weight or value to a feature to reflect its importance within a document. There are generally two approaches: Term Frequency or Document Frequency

With Term Frequency, we might infer that if a word occur a lot of times in a document then it is more important. However, high frequency words are not always discriminating, i.e. stopwords or domain specific words such as "country" within a travel book. 

Document Frequency says that is a term occurs in less documents then it might hold some specific important context. For example, "Kenya" in a collection of document about travel would infer those documents will be about "Kenya" specifically. 

#### Term Frequency Inverse Document Frequency (TFIDF)

Term frequency is the number of occurances of a term in a document:

$$ tf(d,t) $$

Document frequency is the number of documents in which a term occurs:

$$ df(t) $$

If there are $N$ documents in total, inverse document frequency is given by: 

$$ idf(t) = log(\frac{N}{df(t)}) $$

The TFIDF is the product of the two:

$$ tf-idf(d,t) = tf(d,t) * idf(t) $$

The TFIDF may be adapted:
* so the the TF is boolean meaning it either appears in a document or not: $tf(d,t) = 1 or 0$. 
* Term frequency may be adjusted for document length to avoid long documents skewing the overally counts: $tf(d, t) = \frac{\text{freq}(d, t)}{\sum_{t' \in d} \text{freq}(d, t')}$
* Logarithmically scalled frequency terms: $tf(d,t) = log(1 + freq(d,t))$

#### Vector Similarity

For NPL purposes, sentences are converted into feature vectors where indices represents words. Imagining a 2d vector space, we could measure the distance between vectors by their Euclidean distance. 

#### Cosine Similarity

A more practical and feasible approach would be Cosine Similarity where we measure the angle between two vectors: 
* $cos(0) = 1$
* $cos(90) = 0$

Also, for unit vectors, the dot product is equal to the cosine of the angle between them.

$$ \cos(\theta) = \frac{\mathbf{a} \cdot \mathbf{b}}{\|\mathbf{a}\| \|\mathbf{b}\|} $$

The intuition of Cosine Similarity is that the dot product of two vectors is high when they are in the same direction. If they are in the same direction then the angle will be low(er)

### Beyond Words

So far we have assumed that features and topic terms are unigrams, this is single words. In reality, phases or mutliword terms make up the topic, know as n-grams. E.g. "hedge fund", "black hole", "surface to air missle". Taking any of these words individuals would be misleading or ambigous to the topic. We can apply TFIDF weighting to phrases. 

Bigrams, and phrases of n length, will be much more than the number of unigrams. If there are 100,000 unigrams, there will be something like 100,000^2 bigrams which is because we are now look at ways to organise unigrams in a sequence. The question is how to find the useful combinations as "hole black" is not a useful phrase where as its opposite "black hole" is. 

#### Collocations, Joint Probability, Independent Events

Collocations are n-grams which occur togeether more often than by chance. Consider the bigram, "black" and "hole". How often to this unigrams occur? If we were to consider these words independent, how often would we expect these words to occur next to each other? Collociations are n-grams where the observed joint probability is more than the expected joint probability for independent events. 

#### Point-wise Mutual Information (PMI)

$$ PMI(w_1, w_2) = log(\frac{P(w_1, w_2)}{P(w_1).P(w_2)}) $$

PMI tells how suprising it is that a phrase has occured as frequently as it has been observed. The numerator of the fraction is the observed joint probability and the denomenator is the expected joint probability assuming independence. This second part would be cacluated using the conditional probabilities that we created in the previous labs. 

If the ratio is greater than 1, the PMI is positive and we have a collocation. It means that the words occur together more than we would expect if we were assuming independence. If PMI tells us how suprising it is that a phrase occurs together then `>1` is suprised. Otherwise, if it less than these words occur together as much as random chance would dictate.

### Clustering

Clustering is the task of grouping together instances in a way that objects within a group are similar to each other and distinctive compared to other clusters. There is never a correct way to cluster something, cluster will be different between algorithms and even within the same algo if tuned differently. Clustering algorithms generally have a similarity or distance measure which is what detmines how to cluster the feature vectors. 

#### K-Means 

This is the one of the omst simple models based on the idea of centroids or prototypes. Given a pre-set set number of points to look at, the centeroid (middle) of the group in a Euclidean space can found by taking the mean on every dimension. 

$$ c_{d_j} = \frac{\sum_{i=0}^{n} p_{d_j, i}}{n} $$

1. Select K points as initial centroids
2. While controids changing:
    1. Form K clusters by assigning each point to its nearest centroid
    2. Recompute centroid of the cluster

The issue with K-means is that you need to know the number of clusters that you want to compute in advance. Each point will only be assigned to a single cluster even if it matches to more than 1 semantically. The starting point may converge to a local minimum, though this can be overcome by randomising the start point and repeating. 

#### Agglomerative Hierachical Clustering

An agglomerative technique which builds up clusters by repeatedly merging the closest pair of clusters. There is no pre-determined number of clusters, the data determines what exists. Clusters are hierarchical, there can be a structure within the cluster. 

1. Initalise n clusters as the n data starting data points 
2. Find the closest pair $<p_i, p_j>$ of clusters with distance `d`
3. while d < theshold:
    1. Merge clusters $<p_i, p_j>$
    2. Find closest pair $<p_i, p_j>$ with distance d

The issue with this method is that it is computationally expensive to keep recomputing all the nearest neighbours. The runtime is $O(n^2 log n)$ where n is the number of data points. In comparison k-means is only $O(n*d*k*l)$ where k is the number of clusters and l is the number of iterations repeated. 

<div style="page-break-after: always;"></div>

## Week 5 - Lab Session

There is only 1 notebooks for lab 5:
- [Document Similarity](#document-similarity-lab) `Lab_5_1_SOLUTIONS.ipynb`

### Document Similarity Lab

* [Week 5 Lab Setup](#week-5-lab-setup)
* [Measuring Similarity](#measuring-similarity)
    * [Dot Product](#dot-product)
    * [Cosine Similarity](#cosine-similarity)
* [Beyond Frequency ](#beyond-frequency)
    * [TFIDF](#tfidf)
    * [Nearest Neighbour Implementation ](#nearest-neighbour-implementation)

In some applications it may be difficult to know and define the classes that we want to use in classification ahead of time. Or classes might be made up of various sub-classes which differ in terms of vocab used to get to the same undertanding. In both of these cases it might be more appropriate to think about Document Similarity. That is to say, given a new document, what is the most similar document(s) that we already have.

### Week 5 Lab Setup

For this lab we will be using the Gutenberg collection of books. We will get tokenized content of each book and store it in a dictionary:

```
from nltk.corpus import gutenberg
book_ids=gutenberg.fileids()
books={b:gutenberg.words(b) for b in book_ids}

books[book_ids[0]]
['[', 'Emma', 'by', 'Jane', 'Austen', '1816', ']', ...]

books.keys()
dict_keys(['austen-emma.txt', 'austen-persuasion.txt', 'austen-sense.txt', 'bible-kjv.txt', 'blake-poems.txt', 'bryant-stories.txt', 'burgess-busterbrown.txt', 'carroll-alice.txt', 'chesterton-ball.txt', 'chesterton-brown.txt', 'chesterton-thursday.txt', 'edgeworth-parents.txt', 'melville-moby_dick.txt', 'milton-paradise.txt', 'shakespeare-caesar.txt', 'shakespeare-hamlet.txt', 'shakespeare-macbeth.txt', 'whitman-leaves.txt'])
```

We can normalise the tokens in the document and construct a bag-of-words representation. The `normalise` function is not setup in the code below but can be filled with everything we did in the previous labs:

```
book_reps={key:FreqDist(normalise(book)) for key,book in books.items()}

print(book_reps[book_ids[0]].items())
dict_items([('emma', 865), ('jane', 301), ('austen', 1), ('volume', 3), ('chapter', 56), ('woodhouse', 313), ('handsome', 38), ('clever', 27), ('rich', 14), ('comfortable', 34), ('home', 130), ('happy', 125), ('disposition', 24), ('seemed', 141), ('unite', 3), ('best', 85), ('blessings', 6), ('existence', 8), ('lived', 25), ('nearly', 14), ('twenty', 30), ('one', 452), ('years', 57), ('world', 81), ('little', 359), ('distress', 19), ('vex', 1), ('youngest', 4), ('two', 178), ('daughters', 7), ('affectionate', 9), ('indulgent', 2), ('father', 207), ('consequence', 27) [...]])

book_reps[book_ids[0]]['indulgent']
"0"
```

### Measuring Similarity

We are going to use Cosine Similarity to measure how similar two books are. 

$$
\begin{align}
\text{sim}_{\text{cosine}}(A,B) = \frac{A.B}{\sqrt{A.A \times B.B}}
\end{align}
$$

The dot product of two vectors is defined as:

$$
\begin{align}
A.B = \sum_{\text{f}} \text{weight}(A,f)\times \text{weight}(B,f) 
\end{align}
$$

The weight is the measurement or value assigned to each word/feature in the vector (usually a BoWs). It could be:
- Binary: 1 if the word is in the book, 0 if it isn't.
- Term Frequency (TF): The raw count of how many times the word appears (as seen in your earlier formula).
- TF-IDF: A more complex weight that gives higher value to words that are unique to that specific book and lower value to common words like "the" or "and".

But the main thing to understand is that the dot product is taken of the vectors and this value is used to compute the cosine similarity.

#### Dot Product

The function below takes in two documents represented as Bag-of-Words in `FreqDist` or dict form and iternatively compute the dot product using the `key` to match the features from the dict's 

```
def dot(docA,docB):
    the_sum=0
    for (key,value) in docA.items():
        the_sum+=value*docB.get(key,0) 
    return the_sum

testA=book_reps[book_ids[0]]    
testB=book_reps[book_ids[1]]
dot(testA, testB)

"3882298"
```

#### Cosine Similarity

From this we can easily extend our code to calculate Cosine Simialrity given the numerator is just the dot product. The denominator is the length of the vectors $\|A\|$ mutliplied together. In practice, this can be written as the square root of the dot product of the vector with itself. Note that the numerator give us most of the information we need, the demonenator is a normalizing factor. Bigger documents will have many more word counts resulting in a "longer" vector. Dividing by the product of vector lengths we normilise this parameter allowing us to just focus on the angle's information of similarity. 

```
import math

def cos_sim(docA,docB):
    sim=dot(docA,docB)/(math.sqrt(dot(docA,docA)*dot(docB,docB)))
    return sim

cos_sim(testA,testB)
```

#### Cosine Implementation

The function below wraped our dot product and cosine functions into something we can deploy into documents. It takes two collections of document (equal length, can be itself) and loops through them in a nested loop to create a matrix where each document is compared with all documents in the other collection. The outcome is a similarty rating for each pair:

```
def all_pairs_sims(collectionA,collectionB):
    sims={}
    for keyA,docA in collectionA.items():
        sims[keyA]={}
        for keyB,docB in collectionB.items():
            sim=cos_sim(docA,docB)
            sims[keyA][keyB]=sim
            
    return sims


allsims=all_pairs_sims(book_reps,book_reps)
print(allsims)
```

Becuase it is a matrix, it can be presented in tabular formusing `pandas`:

```
import pandas as pd

df = pd.DataFrame(allsims)
df
```

### Beyond Frequency 

Frequency is a word in a document is a very basic weight value because some words just occur frequently in all documents. If two rare words occur in a pair of documents that should highlight the two documents as being similar, rather than the matching common words found in both. 

#### TFIDF

A commonly used weight is TF-IDF which stands for term frequency, inverse document frequency. 

$$
\begin{align}
\text{tfidf}(D_i,f) = tf(D_i,f) \times \text{idf}(D_i,f)
\end{align}
$$

where $tf(D_i,f)$ is simply the frequency of feature f in document $D_i$
and

$$
\begin{align}
idf(D_i,f) = log \frac{N}{df(f)}
\end{align}
$$

where $N$ is the total number of documents and $\text{df}(f)$ is the number of documents containing $f$:  

$$
\begin{align}
df(f)=|\{i|\text{freq}(D_i,f)>0\}|
\end{align}
$$

The code below takes a list of document (BoWs/Dicts) and computes the document frequency for each word/feature. The `.get(feat,0)+1` method means that if a word already exists in the `df` dict then the value is pulled in and updated, otherwise, it is initalised with a 0 and the first value count is added. Remeber the docuement frequency can only be as high as the number of documents, i.e. the word occur in all of them at least once.

```
def doc_freq(doclist):
    df={}
    for doc in doclist:
        for feat in doc.keys():
            df[feat]=df.get(feat,0)+1
            
    return df

doc_freq(book_reps.values())

{'emma': 2,
 'jane': 3,
 'austen': 3,
 'volume': 11,
 'chapter': 8,
 ...
}
```

The IDF takes the document list and counts the number of documents. Then for each feature it takes the `log()` of the number of documents over the features document count which was derived using the `doc_freq()` above. The result is an idf for each feature:

```
def idf(doclist):
    N=len(doclist)
    return {feat:math.log(N/v) for feat,v in doc_freq(doclist).items()}

books_idf=idf(book_reps.values())
books_idf

{'emma': 2.1972245773362196,
 'jane': 1.791759469228055,
 'austen': 1.791759469228055,
 'volume': 0.49247648509779424,
 'chapter': 0.8109302162163288,
 ...,
}
```

The final goal is to get TF-IDF. Recall that TF is simply the terms frequency in the document. The count of the feature in a document over a count of all words in a document:

$$tf(d, t) = \frac{\text{freq}(d, t)}{\sum_{t' \in d} \text{freq}(d, t')}$$

In the following code, the functions first argument takes `docs` which is a dictionary of `book_ids` and a `FreqDist` representation of that book. The second argument `idfvalues` is a dictionary of computed inverse document (idf) values for each feature/word. 

The goal to create a dict `converted` which holds an entry for every book_id and a nested dict which holds the `(feature, value)` pairs where the value will be updated from `idf` to `tf-idf`. 

The `converted` dict has a nested list comprehension. The outer loops through the list of documents collecting the `key,value` pairs which are the `book_id` and the doc represenation. The `book_id` is assigned as the key of the `converted` dict and then the value instantiates nest dict. This dict triggers another loop which loops through the doc representation from the outer loop, meaning the inner `key,value` pair is `feature, frequency` (tf). From this the inner dict is constructed, where the key is the `feature` and the value is calculated as the `tf` from the value * the features value from the the `idfvalues`: `v*idfvalues.get(f,0) ` 

```
def convert_to_tfidf(docs,idfvalues):
    converted={bookid:{f:v*idfvalues.get(f,0) for f,v in doc.items()} for bookid,doc in docs.items()}
    return converted
```

```
convert_to_tfidf(book_reps,books_idf)

{'austen-emma.txt': {'emma': 1900.59925939583,
  'jane': 539.3196002376445,
  'austen': 1.791759469228055,
  'volume': 1.4774294552933827,
  'chapter': 45.41209210811441,
  ...
  }
}
```

When use TF-IDF as a similiarty measure there will much less general similarity within collections, compared to just Term Frequency. This is because the overlap of commonly occuring words have been mitigated so similarities only arises through documents unique aspects. 

#### Nearest Neighbour Implementation 

Once we have a weighting metric which is robust and suitable for applications, we can use it to do more complex stuff such as for every book work out the book most similar to itself. 

The code below implements a neighest neighbour from stratch using the `bookid` and similarity dictionary `simdict` (combined into a matrix called `simmatrix`). 

Note that a dictionary where the `key,value` pair is an `id` and nested dictionary is a matrix. It is tabular in form because the `id`s make up the rows and the dict holds the column information. It can be passed directly into pandas and viewed as a tabular form: `df = pd.DataFrame.from_dict(docs, orient='index')`. But remember to fill in the blanks because dictionaries are sparse vectors with missing entries: `df.fillna(0)`. However, recall that the reason we use sparse data structures like dictionaries is because a dense respresentation will take up huge amounts of memory, so only convert to a tabular form if you are sure your respresentation is small enough. 

```
from operator import itemgetter
import pandas as pd

def nearestneighbours(simmatrix):
    nn={}
    for bookid,simdict in simmatrix.items():
        ordered=sorted(simdict.items(),key=itemgetter(1),reverse=True)
        nn[bookid]=ordered[1]
    return nn
        
nn1=nearestneighbours(allsims)
df = pd.DataFrame(nn1)
df=df.transpose()
df.columns=['nearest neighbour','similarity']
df
```

The output would give something like this:

| | nearest neighbour | similarity |
| :--- | :----: | ---: |
| austen-emma.txt | edgeworth-parents.txt | 0.076654 |
| bible-kjv.txt | milton-paradise.txt | 0.201482 |

<div style="page-break-after: always;"></div>

# Week 6 - Lexical Semantics and Word Senses

This week scopes the focus down from documents to words. It introduces the area of Lexical Semantics (meaning of words) and Lexical Relationships including: 
- synonymy, which is different words meaning the same thing
- hyponymy, which is a word that is a member of a class defined by another word (Hypernym). The Hypernym might be fruit and Hyponymy may be apple. It is a lead into how language and words can be hierarchical.
- antonymy, words that have opposite meanings, hot vs cold

This week also looks into word sense ambiguity and introduces WordNet which is a natural language resource. 

1. [Lecture Notes](#week-6---lecture-notes)
2. [Lab Session](#week-6---lab-session)

## Week 6 - Lecture Notes

* [Lexical Semantics](#lexical-semantics)
    * [WordNet](#wordnet)
* [Semantic Relationships](#semantic-relationships)
* [Semantic Similarity](#semantic-similarity)
* [Word Sense Disambigutation (WSD)](#word-sense-disambigutation-wsd)
    * [One Sense Per Collocation](#one-sense-per-collocation)
    * [One Sense Per Discourse](#one-sense-per-discourse)
    * [Approaches to WSD](#approaches-to-wsd)
        * [Knowledge-based Methods](#knowledge-based-methods)
        * [Supervised Corpus-Based Methods](#supervised-corpus-based-methods)
    * [Seed Collocates](#seed-collocates)

### Lexical Semantics

Most NL applications care about the semantics, the meaning of words. In NLE, providing computers with rich represenations of lexical semantics should lead to more intelligent applications. 

Words are often ambiguous and can often have multiple senses (meanings) depending on the context or where they are used in a sentence. 

Lexicopgraphers produce dictionaries from which the purpose is to establish the all of the sense of a word (in 1 language), provide definitions of each sense and provide examples of how they should be used. In order to us these dictionaries in applications they need to be machine readable, and can even go as far and only being machine readable, i.e. the format doesn't need to be structure that we humans are used to.

#### WordNet

WordNet can be accessed via python NLTK using `from nltk.courpus import wordnet as wn`

A synset is a group of words, a synonym set, that are considered semantically equivalent. For example, {bank, depository_financial_institution, banking_concern} — The financial entity. 

`wn.sysnsets("plant")` returns all of the senses for a given word. That is the diffent way the word plant can be used. This is slightly different to the defintiion of synset. The returns are each synsets, so we are getting an idea of the different synsets a word is a part of. You can't just get a sysnet for a word because you first need to udnerstand the usage of the word, once you have that you can find the sysnet for the word in context. 

It should be highlighted that different dictionaries have different definitions on a words sense. For example, for plant, WordNet has `noun:4, verb:6` where as Oxford as `noun:6, verb:11`. 

Homonyn is what you call words that have the same word and spelling but a different meaning. They are different concepts that just happen to labelled with the same word. 

A homograph is when a word has the same spelling but is pronounced different. It litterally means "same writing". These can be quite a big issue when working with text-to-speech applications. 

Polysemy is when a word has many different meanings that can extended to nested fine-grained senses within meanings. The senses are often related but sligtly different. Book is a good example

In WordNet sense defintions are extracted using `s.definition()`. 

Monosemous is a word that only have one meaning. The literal meaning is "single sense". There are very few of these in the English language but some words may have a strong predominant sense - or may be monsemous in a specific domain. 

### Semantic Relationships

Synonym is for different words that share the same meaning. Two words are synonymous if they can be substitued in all possible contexts and allowing the meaning to be the same. True synonyms are rare but all possible contexts is very broad. The choice of synonym often gives us some subtle information about the speaker even if the meaning of the word and sentence doesn't change. 

Antonymy is words of complete opposite meaning. Substituting one for the other would cause a contradiction to the orgininal sentence. Topic wise, Antonyms are very similar in meaning, most come in pairs and are adjectives, verbs or adverbs. 

Hyponymy and Hypernymy capture the idea of class. A dog is a type of animal. Dog is a Hyponymy and Animal is the Hypernymy. Hyponyms are part of a hierachical structure. Often a word that is a Hypernymy to something is also a Hyponymy. `animal > dog > poddle`. Threse relationships can be visualed in a tree like structure with the most general at the top and most specific at the bottom. 

The WordNet linguistic network is organised around synonymy and hyponymy. That is to say related word or meaning and then navigated through a hierarchical structure. 

The core unit is the sysnet. A set og synonymous word senses. Items can be unigrams or bigrams. Each specific sysnet is associated with a single definition. Polysemous words will appear in mutliple synsets because they have multiple meanings.


Each synset has a `.lemmas()` class which can though of an as sense. For example, for "cat" is will return `[cat, true_cat]` and `[guy, cat, hombre, bozo]` as well as others. `.definition()` then gets you the definition for the particular synset sense that you are looking at: 
```
for index,synset in enumerate(cat_synsets):
    wordforms = [l.name() for l in synset.lemmas()]
    print(index, wordforms, synset.definitions()))
```


Remember that a Hypernym is the root of a sense. A synset has a `.hypernyms()` which accesses the root. The root that is returns will be a another list of synset(s) as the root will also have multiple words. For example, `[cat, true_cat]` gets `[feline, felid]`:
```
for h in cat_synset[6].hypernyms():
    h_words=[w.name() for w in h.lemmas()]
    print(h.words, h.definition)
```

Hyponyms are the next branch down from a sense. This is accessed from a synset using `.hyponyms()`. Again it comes as a list but this can be very big, the cat example gets: `[cheetah, chetah]`, `[jaguar, panther]`,`[lion]`. Basically all different types of cat:

```
for hypo in cat_synset[6].hyponyms():
    h_words=[w.name() for w in h.lemmas()]
    print(h_words, h.definition())
```

### Semantic Similarity

The intuition with WordNet is that similar concepts are closer together in the hierachy.

One measure of closeness could be path length. The issue with this is that is doesn't not discriminate when pathways diverage in meaning, e.g. canine and verbebrate. Also as you go further up the tree, the concepts become less similar, where as lateral concepts may be connected but have a longer path, e.g. dog and cat are lateral. 

Another version of similarity is Lowest Common Subsemer (LCS). It looks at what two concepts share. E.g. tabby and liger first share feline. The intution is that concepts which share a lower shared concept are more related than an higher one. We gain more info when two objects are carnivores than if they are vertebrates. This can be captured probabilitistically via the information content (IC). Annotate the hierarchy with the frquency of occurance of each concept in a document. Note, the occurance of a concept implies the occurance of all Hypernyms. 

### Word Sense Disambigutation (WSD)

WDS is about, "how do we know the sense of a word" 

#### One Sense Per Collocation

Recall that a collocation is a pair, or group, of words wich frequently co-occur togeher in some defined relationship. Can be defined or identified as they occur more often than random chance. Yarowsky (1993) showed that, an ambigous word only have one sense in a given collocation with probability of 90% to 99%

The word(s) aid/aide is an ambiguous homophobe. However, when paired with its collocations we start to see a clear distribution of usage:

| Collocation | Aid Freq | Aide Freq |
| :-- | :-- | :-- |
| Foreign      | 718 | 1  |
| Federal      | 297 | 0  |
| Presidential | 0   | 63 |
| Cheif        | 0   | 40 |

#### One Sense Per Discourse

Sense usage tends to clump to use cases and contexts. Gate et al (1992) demonstrated that there is a very strong tendancy for mutliple uses of the same word to share the same sense in a well written discourse. 

### Approaches to WSD

There is:
* Knowledge-Based methods
* Supervised Corpus-Based methods
* Semi-supervised corpus-based methods (bootstrapping, active learning)
* Unsupervised corupus-based methods

#### Knowledge-based Methods

These are methods that reply on dictionaries, thesauri and lexical knowledge bases without consulting the evidence of a corpus. Also known as dictionary methods. Includes: handcrafted disambigutaiton rules, comparing dictionary definitions to the context, use semantic similarity measures. 

#### Supervised Corpus-Based Methods

Requires "sense inventory", a pre-specified set of class labels for each word fo interest and training data, i.e. a corpus of examples annotated with the class labels. This is so a classifer can learn which features will be more likely to be assigned to which class. 

#### Semi-Supervised Corpus-Based Methods

No longer rely on annotated training - because of this may be refered to as unsupervised. However, they still require a sense inventory of classes and possibly some expert input to create the classes. 

Bootstrapping comes from Yarowsky (1995). 

1. Start with some seed collocoates for each ambiious word we are looking at which reliably disambiguate the word. 

2. Find example in the corpus where these collocates occur and tag them accodingly

3.  Use these tagged examples to find other collocates which relibably partition the tagged examples

4. repeat

e.g. plant, collocates with manufacturing and life. manufacturing plant collocates with computer, copper and company. Plant life collocates with mircoscopic, virus and animal. 

### Seed Collocates

Where might the initial seed collocates come from? 

Hand-labeling: A human identifies a few very obvious words that only appear with one sense (e.g., "leaf" for the biological plant and "factory" for the industrial plant).

Dictionary Definitions: Taking words directly from the WordNet "gloss" or definition for that specific synset.

But you need to pick a good seed. To know if a seed is "good," you look at how often it appears with Sense A versus Sense B. A "reliable" seed is one that appears frequently with one sense but almost never with the other. "Chlorophyll" is a highly reliable seed for the biological sense of plant because it almost never appears in a sentence about a manufacturing plant. 

If you decide to use seeds that are a bit more "vague" to expand your search, two things happen: 
- Increased Recall: You will find and tag more instances of Sense A that you would have otherwise missed.
- Decreased Precision: Because the seed isn't perfect, you will accidentally tag instances of Sense B as Sense A.

Using the word "water" as a seed. While biological plants need water, a "cooling water" system in a factory might lead the computer to wrongly tag a factory as a biological organism.

<div style="page-break-after: always;"></div>

## Week 6 - Lab Session

There is only 1 notebooks for lab 6:
- [Lexical Semantics](#lexical-semantics-lab) `Lab_6_1_SOLUTIONS.ipynb`

## Lexical Semantics Lab

This lab covered Lexical Semantics, that is to say, the meaning of words. We will be exploring the WordNet resource, learning about and traversing lexical relations (synonymy, hyponymy), quantifying semantic similarity via distance metrics applied to the WordNet hierarchy and comparing WordNet similar scores with human synonym judgements. 

* [Navigating WordNet](#navigating-wordnet)
* [Computing the Number of POS Senses a word has](#computing-the-number-of-pos-senses-a-word-has)
* [Calculating Distance to the Root](#calculating-distance-to-the-root)
* [Semantic Similarity in WordNet](#semantic-similarity-in-wordnet)
* [Comparing WordNet Similarities with Human Synonymy Judgements](#comparing-wordnet-similarities-with-human-synonymy-judgements)

### Navigating WordNet

NLTK WordNet, Navigation, Methods, Tools

WordNet can be imported through the following:
```
#import nltk
#nltk.download('wordnet')
#nltk.download('wordnet_ic')

from nltk.corpus import wordnet as wn
from nltk.corpus import wordnet_ic as wn_ic
```
These two imports work together and hold different part of information. 

`wn` is the tree structure itself, the semantic database, it holds the Synsets, definitions, examples, and the relationships between words (hypernyms, hyponyms, antonyms). It is used to find synonyms, traverse the hierarchy to find the roots or related connections of words (hypernyms) and check definitions. 

`wc_ic` provides statistical data about word usage gathered from large bodies of text. It contains probability scores for how often a concept appears in a specific corpus, or frequency counts. It is a required input for certain similarity metrics, specifically Resnik (res), Lin (lin), and Jiang-Conrath (jcn). 

The information is often used together. If you want to calculate how similar two words are, standard WordNet (wn) can tell you how many "steps" apart they are in the tree. However, many famous algorithms (like Lin Similarity) require wn_ic to weigh those steps based on how common the words are. 

```
# Load the Information Content from a specific corpus
brown_ic = wn_ic.ic('ic-brown.dat')

# You need 'wn' for the synsets and 'brown_ic' for the math
dog = wn.synset('dog.n.01')
cat = wn.synset('cat.n.01')

# This similarity check requires the Information Content (wn_ic)
score = dog.lin_similarity(cat, brown_ic)
```

The key function and starting point for WordNet is the idea of a synset. Words have senses and senses are grouped with synonymous senses in synsets. The `synsets()` function finds out which synset a word belongs to. 

```
from nltk.corpus import wordnet as wn
wn.synsets("plant")

[Synset('plant.n.01'),
 Synset('plant.n.02'),
 Synset('plant.n.03'),
 Synset('plant.n.04'),
 Synset('plant.v.01'),
 Synset('implant.v.01'),
 Synset('establish.v.02'),
 Synset('plant.v.04'),
 Synset('plant.v.05'),
 Synset('plant.v.06')]
```

This output is a list of `Synset` objects where each has a unqiue identifer containing one of its words, its part of speech and a number. E.g. `Synset('book.n.01')` is the first noun sense of *book*. However the word book is also in `Synset('record.n.05')` which is the fifth noun sense of *record*

We can scope down into one sense `book_synsets[2]` and look at various piece of information connected to this particular sense:

```
book_synsets=wn.synsets('book')
recordn5=book_synsets[2]
print(recordn5.lemma_names())  #get the words in the synset
print(recordn5.definition())   #get the definition of the synset
print(recordn5.examples())  #get examples of the words used in this sense
```

It can sometimes be useful to print out all of the available senses to determine the most suitable one: 

```
plant_synsets=wn.synsets('plant')
for i,s in enumerate(plant_synsets):
    print("{}:{}".format(i+1,s.definition()))
```

Sometimes you know the wider topics and context of what you are looking for so the only want to look at sysnets within a certain Part-of-Speech tag. The structure of the output will still be the same in terms of a list of objects but it may be filtered/smaller: 

```
#all of the WN POS tags
parts_of_speech=[wn.NOUN,wn.VERB,wn.ADJ,wn.ADV]

print(wn.synsets("red",parts_of_speech[0]))

[Synset('red.n.01'), Synset('red.n.02'), Synset('bolshevik.n.01'), Synset('loss.n.06')]
```

### Computing the Number of POS Senses a word has

By setting up lists for POS and Words, we can use a nested loop to extract the POS entries for each word within its synset using `wn.synset(word,pos)` with pos tag:

```
import pandas as pd
parts_of_speech=[wn.NOUN,wn.VERB,wn.ADJ,wn.ADV]
words=["book","chicken","counter","twig","fast","plant"]

results=[[len(wn.synsets(word,pos)) for pos in parts_of_speech]for word in words]

df =pd.DataFrame(results,index=words,columns=parts_of_speech)
df
```

The `Synset` object also as a `lemmas()` method. A lemma is just a word so this method returns all of the words in a synset's sense, that is, the words that are synonymous and mean the same thing. 

```
for i,s in enumerate(plant_synsets):
    print("{}:{}".format(i,s.lemmas()))

0:[Lemma('plant.n.01.plant'), Lemma('plant.n.01.works'), Lemma('plant.n.01.industrial_plant')]
1:[Lemma('plant.n.02.plant'), Lemma('plant.n.02.flora'), Lemma('plant.n.02.plant_life')]
2:[Lemma('plant.n.03.plant')]
...
9:[Lemma('plant.v.06.plant'), Lemma('plant.v.06.implant')]
```

`lemmas()` returns the unique id form, though the word is also visible. But to just get the pure lemma/word you use `names()`: 

```
cat_synsets = wn.synsets("cat",wn.NOUN)
for i,s in enumerate(cat_synsets):
    wordforms=[l.name() for l in s.lemmas()]
    print("{}:{}\n\t{}".format(i,wordforms,s.definition()))

0:['cat', 'true_cat']
	feline mammal usually having thick soft fur and no ability to roar: domestic cats; wildcats
1:['guy', 'cat', 'hombre', 'bozo']
	an informal term for a youth or man
2:['cat']
	a spiteful woman gossip
...
7:['computerized_tomography', 'computed_tomography', 'CT', 'computerized_axial_tomography', 'computed_axial_tomography', 'CAT']
	a method of examining body organs by scanning them with X rays and using a computer to construct a series of cross-sectional scans along a single axis
```

Remember that the other key dimension of WordNet, aside from synsets/synonyms, is the hierarchical structure around hyonymns and hypernyms. 

The hyonymns of a word (from within a sense) are accessed using `.hyponyms()`. Hyonymns are the lower, more granular applications. Given the tree like structure, is often returns a lot. 

```
#iterating over the hyponyms of the 6th Synset in the list of synsets for cat
for h in cat_synsets[6].hyponyms():
    h_words=[w.name() for w in h.lemmas()]
    print("{}:{}".format(h_words,h.definition()))


['cheetah', 'chetah', 'Acinonyx_jubatus']:long-legged spotted cat of Africa and southwestern Asia having nonretractile claws; the swiftest mammal; can be trained to run down game
['jaguar', 'panther', 'Panthera_onca', 'Felis_onca']:a large spotted feline of tropical America similar to the leopard; in some classifications considered a member of the genus Felis
...
['lion', 'king_of_beasts', 'Panthera_leo']:large gregarious predatory feline of Africa and India having a tawny coat with a shaggy mane in the male
['tiglon', 'tigon']:offspring of a male tiger and a female lion
```

Conversely you can go the otherway to collect the `hypernyms()`. This list should almost always be smeller, unless we are at the bottom of the tree where there is no more branches. The very top of a tree is called the root and the hypernym list returned will be empty - this will also occur on the leaves at the bottom. Most nouns in WordNet share a common root which is known as their entity. 

```
##Iterating over the hypernyms of the 6th sense of cat and output lemma names and definition
for h in cat_synsets[6].hypernyms():
    h_words=[w.name() for w in h.lemmas()]
    print("{}:{}".format(h_words,h.definition()))

['feline', 'felid']:any of various lithe-bodied roundheaded fissiped mammals, many with retractile claws
```

The above it quite a long proccess because it involves calling `.lemmas()` and calleding `.names()` on that. This can be skipped by calling `lemma_names()`directly:

```
for h in recordn5.hypernyms():
  print(h.lemma_names())
```

### Calculating Distance to the Root

The first component to measuring distance between two words it to traverse up the tree. Below we build a function that traverses all the way to the root. This likely won't be part of a similarity metric exactly but it builds the knowledge and tools of how to traverse. The function below is a recurisve function that repeatedly calls itself until the root is found. 

The function first exracts the `hypernyms()`. It check if the hypernyms are empty because it is we are at the root. If the number of hypernyms is more than 1 then it calls itself again to repeat the checks.


```
def distance_to_root(asynset): # passes just one sense from the synset, e.g. synset[1], not the list of sysnets
    #print(asynset.lemma_names())
    hypernyms=asynset.hypernyms()
    if len(hypernyms)==0:
        #reached the top and have to stop
        return 0
    else:
        if len(hypernyms)>1:
            print("Warning: multiple hypernyms")
        return (distance_to_root(hypernyms[0])+1)
    
for asynset in wn.synsets('plant',wn.NOUN):
    print(asynset.lemma_names(),distance_to_root(asynset))

['plant', 'works', 'industrial_plant'] 7
['plant', 'flora', 'plant_life'] 6
Warning: multiple hypernyms
['plant'] 7
['plant'] 10
```

Note that the senses, depsite being the same word, can and often will have different roots. This is because they have different meanings. 

1.2 Distance to root, synset, traverse to root of tree, count steps

### Semantic Similarity in WordNet

The hierarchical structure of WordNet means that it lends itself to using PathLength measures to determine similarity.

$$
\begin{align}
\text{sim}(\text{synsetA},\text{synsetB})=\frac{1}{1+\text{lengthOfPath}(\text{synsetA},\text{synsetB})}
\end{align}
$$

The lecture also introduced **information content**, i.e., the amount of information we receive when a word from a given synset is used (there is more information in being told that something is a *poodle* than in being told it is an *animal*).

The `nltk.wn` module has built-in functions for computing these similarities between synsets. Note, in the code below, two explicity senses `books[0],books[1]` are being compared. `wn.path_similarity()` is a called directly. Where are Information Content requires a corpus as evidence to reference. The corpus is read in from the `wn_ic` imported at the start and uses `"ic-brown.dat"` as the corpus. The similarity measure itself comes from the `wn` package and a specific measure called `res_similarity` (resnik_similarity) is used. Again it takes two specific sense to compare but also the corpus `books[0],books[1],brown_ic`. Another similarity is also computed called the `lin_similarity`.

```
books=wn.synsets("book",wn.NOUN)
print("path_similarity {}".format(wn.path_similarity(books[0],books[1])))

brown_ic=wn_ic.ic("ic-brown.dat")

print("resnik_similarity {}".format(wn.res_similarity(books[0],books[1],brown_ic)))
print("lin_similarity {}".format(wn.lin_similarity(books[0],books[1],brown_ic)))

path_similarity 0.2
resnik_similarity 5.454686565783099
lin_similarity 0.7098990245459575
```

Note that the reason that the `book` variable specificies the `wn.NOUN` of the synset is because it is impossible to compare the synets of different parts of speech as they will be completely disconnected and have no mutual hyponymy/hypernymy root. 

If you ever do need to compare a noun and a verb (e.g., the noun "payment" and the verb "pay"), you cannot use path-length. Instead, you have to use Derivational Morphology links. These are special pointers in WordNet that connect different parts of speech that share a root meaning.


The similarity of two **words** with a given part of speech is defined as the **maximum** similarity of all possible sense pairings.  If word A has 5 noun senses and word B has 4 noun senses than there are 20 possible sense pairings to check. This is because the computer doesn't know what sense of a word you mean it checks them all. It will also the outcome with the best similarity is the one you wanted.

The function below computes the similarity of two nouns. It aquires the availble synsets for each work and then uses a nest loop to compare them all. It simply uses a pre-initalised variable `maxsofar` which it overwrites every time is sees a higher similarity:
```
def path_similarity(wordA,wordB,pos=wn.NOUN):
    synsetsA=wn.synsets(wordA,pos)
    synsetsB=wn.synsets(wordB,pos)
    maxsofar=0
    for synsetA in synsetsA:
        for synsetB in synsetsB:
            sim=wn.path_similarity(synsetA,synsetB)
            if sim>maxsofar:
                maxsofar=sim
    return maxsofar

path_similarity("chicken","car")
```

The structure of this function can easily be adpat to allow any similarity measure. Most measures need a corpus to that needs to be factor in. Otherwise it is just a case of adding a param for the type of measure and an `if/else` to pick the similarity functionality.

```
def word_similarity(wordA,wordB,pos=wn.NOUN,measure="path"):
    synsetsA=wn.synsets(wordA,pos)
    synsetsB=wn.synsets(wordB,pos)
    maxsofar=0
    brown_ic=wn_ic.ic("ic-brown.dat")
    for synsetA in synsetsA:
        for synsetB in synsetsB:
            if measure=="path":
                sim=wn.path_similarity(synsetA,synsetB)
            elif measure=="res":
                sim=wn.res_similarity(synsetA,synsetB,brown_ic)
            elif measure=="lin":
                sim=wn.lin_similarity(synsetA,synsetB,brown_ic)
            
            if sim>maxsofar:
                maxsofar=sim
    return maxsofar

word_similarity("chicken","car",measure="lin")
```

### Comparing WordNet Similarities with Human Synonymy Judgements

In order to compare with human judgements we are going to read in a `.csv` that contains 30 noun pairs descriptions. The headers are `["word1","word2","human similarity"]`. As it is a `.csv` and therefore tabular, we can use `pandas` and `.describe()` to create some exporatory analysis and summary stats. 

The code below uses the `word_similarity` function we created above to create new column(s) for similarity which we can compare to the human similarity measure:

```
measures=["path","res","lin"]
for measure in measures:
    scores=[]

    for triple in mcdata:
        scores.append(word_similarity(triple[0],triple[1],measure=measure))
    df[measure]=scores
    
df
```

One of the easiest way to visualise this data would be through a scattergraph and plotting human judgement against 1 type of similarity measure `df.plot.scatter("human similarity","res")`

Additionally, you could compute the correleation, this would allow you to compare all measures at once and produce a correlation table: `df.corr(method='spearman')`



    * Looking at the scatter plots and the correlation coefficients, what do you conclude about the different WordNet similarity measures?
    * Do you have any reservations about your conclusions?

<div style="page-break-after: always;"></div>

# Week 7 - Distributional Semantics

Distributional semantics is based on the intuitively appealing hypothesis that words which mean similar things are used in similar ways.

This is important because if we are able to identify which words are used in similar ways, we can build a stronger language model and discover similarity in meaning. This may allow us to automatically generate thesauruses. 

To start, we look at representing vector respresentations of words based on their co-occurences with other words. Then we will consider different measures of association, that is how important the co-occurances are and then finally a measure of similarity between the vectors which will be derived from cosine similarity. 

In the second session, we will consider intrinsic and extrinsic evaluation of distributional semantic methods.  In particular, we will focus on the commonly used intrinsic method using word-similarity tasks.  We will also discuss the main problems encountered when using distributional methods to automatically generate thesauruses, including:
- word sense ambiguity
- differentiation of lexical relations
- data sparsity / frequency effects

1. [Lecture Notes](#week-7---lecture-notes)
2. [Lab Session](#week-7---lab-session)

## Week 7 - Lecture Notes

* [Distributional Semantics: Part 1](#distributional-semantics-part-1)
    * [Meaning Features (Distributional vs Promiximity)](#meaning-features-distributional-vs-promiximity)
    * [Similarity Measures](#similarity-measures)
        * [Jaccard’s Measure](#jaccards-measure)
        * [Cosine Similarity](#cosine-similarity-for-distributional-meaning)
        * [Pointwise Mutual Information (PMI)](#pointwise-mutual-information-pmi)
        * [ Positive PMI (PPMI)](#positive-pmi-ppmi)
* [Distributional Semantics: Part 2](#distributional-semantics-part-2)
    * [Automatic Thesaurus Generation](#automatic-thesaurus-generation)
    * [Evaluation](#evaluation)
        * [Intrinstic Evaluation](#intrinstic-evaluation)
        * [Extrinsic Evaluation](#extrinsic-evaluation)
        * [Absolute vs. Comparative Evaluation](#absolute-vs-comparative-evaluation)
    * [Word Ambiguity in Distributional Semantics](#word-ambiguity-in-distributional-semantics)

### Distributional Semantics: Part 1

"you shall know a word by the company it keeps"

What does tezguino mean? You can often derive a words meaning by the contexts it is used in:
* A bottle of tezguino on the table. 
* Everyone like tezguino
* Tezguino makes you drink
* We make tezguino out of corn 

Without any prior info on Tezguino, the sentence contexts tell us that it is a kind of alcoholic beverage made from corn mash. By using a large corpora we can look at the words surround a word to learn its contexts. From that, we can compare other words with the same contexts and infer that the words are related and similar in some way. 

The main application of distribution semantics is the automatic generation of thesaursus in any language, genre and domain where we have a corpus. It also allows to overcome data sparsness as we no longer require labelled training data which is expensive and slow to aquire. 

Think about a Nauve Bayes classifer trained on 500 documents which is relatively small for NLP standards. A test document contains the word Tezuino which has not been seen in the training sample so it cannot contribute to the relevancy classifcation. By applying distribution semnatics, using a sperate very large unlablled corpus, we can infer that Tezuino is similar to beer. Beer is a common word and is likely seen in our training data of 500 documents. So we can assume that $P(tezuino|class) = P(beer|class)$

### Meaning Features (Distributional vs Promiximity)

If order to capture meaning we need to extract features that respresent meaning. Distributional Semenatics means that we look at the words around a word to capture its meaning. We can largely take two approaches: Dependency or Proximity. 

Dependency is a grammatically approach. Instead is just acknowledging that "tiger" and "eats" are near eachother we record that "tiger" is the subject of eats. It is the tiger that eats, a tiger is something that can eat. It captures deep semantic roles. For example, "meat" and "banana" share a facet of meaning because they are both frequently the object of the verb "eat". This is technically difficult because it requires "dependency parsing"—software that can accurately map out the grammar of every sentence.

Promiximity is much more naive approach. It looks at which words are physically close to each other. It words by using a window around the word, i.e +1 either side of the word. The sentence "The machine ate my credit card," the word "machine" has the features "the" and "ate". The results from the window would generally be stored in a sparse vector like a dict `{machine: 1, ate: 1}` This also means that there is hyperparameter which flexibile and can be optimized for use case. Additionally, unlike dependency parsing, it is very easy to compute and doesn't require outside inputs beyond the corpus. It gives the general topic similarity but might struggle on specific functional roles like the dependecy will give. 

### Similarity Measures

#### Jaccard’s Measure

This measure comes from set theory. It calcualtes the amount of overlap between sets, i.e. the intersection. 

The formula is the ratio of the intersection of the feature sets to their union and $T(w)$ represents the set of features for word $w$2. Remeber the features of a word are the words found in the context windows. These words could either be counted or in a simple case, boolean recorded. 

$$\text{Jaccard}(w_1, w_2) = \frac{|T(w_1) \cap T(w_2)|}{|T(w_1) \cup T(w_2)|}$$

The numerator looks at the intersection of the features, that is the one they have in common. It takes the minimum value from the two words, if "yellow" appears 10 times with "banana" and 2 times with "meat," the intersection value for that feature is 2.

The denominator looks at the union and takes the maximum count founds in the overlap. Remember a word will have a set of features, so for each feature you take the max count.

By using the minimum for intersection and maximum for union, you are effectively asking: "Of all the times this feature appeared for either word, what proportion was shared by both?". We are meaasuring the amount of overlap in the feature sets compared to their potential for overlap. 

$$\text{Jaccard}(w_1, w_2) = \frac{\text{Intersection}}{\text{Union}}$$

If there overlap is high and the ratio is therefore high, we are saying that the meaning of the words is very similar. The set of features surrounds the words are similar. 

Note, just because two things are very similar in meaning does not mean they are synonyms. Words like "hot" or "cold" are Antonyms, so are used in the same context and sentence structure but not at all. You have co-hyponyms like "car" and "bus" will be used in many says the same way structurally but are different types of vehicles. Then you have words, that are simply very closely tried topically, like "doctor" and "hospital" these can never be used interchangable but the their features will be remarkebly similar. This latter is a big downside of promiximity features comapred to dsitributional. 

#### Cosine Similarity for Distributional Meaning

Cosine Similarity is a geometric measure that treats word representations as vectors in a multi-dimensional space. It measures the angle ($\theta$) between two vectors; the smaller the angle, the more similar the words are. It is calculated using the dot product of the vectors divided by the product of their magnitudes.

$$\text{sim}(w_1, w_2) = \cos(\theta) = \frac{a \cdot b}{\|a\| \times \|b\|}$$

When it comes to measuring the similarity, we construct a dense vector which made up of only the words that are found in both feature sets. If there are no features the similarity score is 0. In vector space, these two words with no matching features are orthogonal (at a 90-degree angle to each other). The cosine of 90 degrees is 0. 

#### Pointwise Mutual Information (PMI)

This measure is used to weight features because simple frequency or probability often fails to distinguish truly informative features from common, uninformative words like "the" or "is". PMI measures the amount of information gained by seeing a word and feature together. It quantifies how much more often a word and a feature co-occur than would be expected if they were independent.

$$I(w, f) = \log \left( \frac{\text{freq}(f, w) \times \text{freq}(*,*)}{\text{freq}(f,*) \times \text{freq}(*, w)} \right)$$

- $\text{freq}(f,*)$ is the row total
- $\text{freq}(*, w)$ is the column total
- $\text{freq}(*,*)$ is the grand total

| Feature| banana | meat | credit | Total |
| :--- | :--- | :--- | :--- | :--- |
| yellow | 10  | 2   | 3   | 15  |
| red    | 2   | 14  | 19  | 35  |
| eat    | 20  | 9   | 1   | 30  |
| spend  | 1   | 2   | 27  | 30  |
| card   | 3   | 2   | 50  | 55  |
| the    | 25  | 25  | 50  | 100 |
| is     | 20  | 20  | 40  | 80  |
| tiger  | 3   | 17  | 0   | 20  |
| man    | 6   | 9   | 10  | 25  |
| monkey | 10  | 0   | 0   | 10  |
| Total  | 100 | 100 | 200 | 400 |

$$I(w, f) = \log_2 \left( \frac{freq(w, f) \times freq(*, *)}{freq(w, *) \times freq(*, f)} \right)$$$$I(banana, yellow) = \log_2 \left( \frac{10 \times 400}{100 \times 15} \right) = \log_2(2.66) \approx 1.42$$

The numerator is the total count of a word and features occurance mutlipled by the total occurance of all feature combinations. The numerator is designed to measure the observed co-occurrence between a specific word and a specific feature, scaled by the size of the entire corpus. It is scaled to boost the signficance of smaller numbers of pairs that do actually have important meaning. 

The denomenator is the total occurance of the feature accross all words mutliplied by the total occurance of a word. The intuition behind the denominator is that it represents the expected co-occurrence of the word and the feature if they had no special relationship at all—essentially, if they were just paired together by random chance. By multiplying the total frequency of the word by the total frequency of the feature, the denominator creates a "score" for how much they should be seen together based purely on how common they are individually.

#### Positive PMI (PPMI)

A variation of PMI designed to handle the issue of zero co-occurrence frequencies. In standard PMI, a zero frequency results in negative infinity. PPMI replaces all negative PMI values with zero, focusing the similarity calculation on shared features rather than the sharing of "absent" features. 

$$\text{PPMI}(w, f) = 
\begin{cases} 
I(w, f) & \text{if } I(w, f) > 0 \\
0 & \text{otherwise}\end{cases}$$

### Distributional Semantics: Part 2

The second half of the slides shifts the focus from how we build the vectors to what we do with them and the advanced challenges involved. We are going to cover evaluation, word ambiguity, distinguiging semantic relationships and sparsenss. 

#### Automatic Thesaurus Generation

Based on all of the previous labs we now have the tooling to automatically generate Thesaurus:

1. Extract feature respresentation based on corpus co-occurance frequence. (Proximity, Window)
2. Convert the representations to PPMI. Instead of just using the count as a weight we maniplulte the figure to be a ratio of totals. Which is enriching the vector
3. Use the vectors to calculate cosine similarities for all pairs. This is very expensive as we need to compare all pairs of words in the vocab. It would good if we has some method to reduce the number of words. 
4. Find the nearest neigbours. This doesn't mean construct a clustering algoirthm. It means that the Cosine is our distance metric. We just sort the list to find the most similar word with the highest cosine similarity. 

#### Evaluation 

Now that we have these vectors and similarity scores, how do we know if they are actually any good? In NLP there are two types of evaluation, instrinstic and extrinsic. 

##### Intrinstic Evaluation

Intrinsic evaluation tests the model on its own, based on its internal logic, without plugging it into a larger application. The goal is to see how well the computer's "intuition" matches human intuition. There are pre-made lists of word pairs that humans have already judged:

- WS-353 (WordSim-353): A famous dataset where humans rated pairs like (cat, dog) or (bank, money) on a scale of 1–10.
- SimLex-999: A more modern dataset that strictly focuses on similarity (synonyms) rather than just relatedness (topically linked words).

For intrinstic evaluation, we would calculate to cosine similarity for the same word pairs and then use a correlation method, such as Spearmans Rank, to assess how similar they are. The most similar the computer ranks are to the human, the better the model. 

##### Extrinsic Evaluation

Extrinsic evaluation (sometimes called "task-based" evaluation) measures the quality of your word vectors by seeing how much they improve a real-world NLP application. You take a complex system—like a Machine Translation engine, a Sentiment Analysis tool, or a Question Answering system—and "plug in" your word vectors. You measure the final accuracy of that system (e.g., "Did the translation get better when I used these PMI vectors?"). While this is the most "honest" test of a vector's value, it is very expensive and slow to run compared to intrinsic tests. 

##### Absolute vs. Comparative Evaluation

Absolute: You give your model a score (e.g., "My model has a 0.72 correlation on SimLex-999").

Comparative: You run two different models (e.g., Jaccard vs. Cosine) on the same dataset and see which one performs better.

This is all important because high cosine similarity score isn't "the truth"—it's just a prediction. To prove it works, you have to show it aligns with human "Gold Standards" or improves a "Downstream Task."

#### Word Ambiguity in Distributional Semantics

One of the biggest enemies of Distribution Semantics is words that have multiple meanings. We can take the noun word "bow" and automatically derive a distributional thesaurus using `nltk.lin_thesaurus` and the retuned with with most similarity will be a muddy select of words from different senses: ribbon, machete, scarf, rope. 

This because Distributional Respresentaitons are of words not senses. It returns a mixture of sense in distributional neighbourhoods.  

One possible solution is Word Sense Disambiguation (WSD). If the problem is that we have one vector per word, the WSD solution is to move toward one vector per word sense. WSD was covered in Week 6 and is concered with "how do we know the sense of a word". There were several approaches to it includes knowledge-based, supervised and unsupervised. 

Finding your distibutional neighbours before doing WSD is more of a diagnositc steps. If you are returned as list with more an one sense you can see that actually you need to find a way to seperate the senses. 

If finding the neighbours after WSD you should have already cleaned the data. "bank" might be turned into into bank_financial and bank_river and will recieve a neighrbour list for both. This is similar to how wordnet works. Banks is the hypernym and bank_financial/bank_river are the hyponyms. By working with these more granualr types we can ensure our neighbour lists will be more specific and less muddy. This is the goal of a high-quality automated thesaurus. It allows the system to provide accurate synonyms that don't confuse the different meanings of the word.

WordNet is a tool that WSD use to put words into buckets. It is a lexical database that facilities WSD through two methods:
- Knowledge-Based WSD (The Lesk Algorithm): This is a classic method. It looks at the dictionary definitions (glosses) in WordNet for every sense of "bank." It then looks at the words in your current sentence. Whichever WordNet definition has the most words in common with your sentence is the sense it picks.
- Supervised WSD: Researchers use WordNet to label large bodies of text (corpora). They might hire humans to look at 1,000 sentences containing "bank" and tag them with the specific WordNet Sense ID. This "Gold Standard" data is then used to train machine learning models.

<div style="page-break-after: always;"></div>

## Week 7 - Lab Session 

There is only 1 notebooks for lab 7:
- [Distributional Semantics Lab](#distributional-semantics-lab) `Lab_7_1_SOLUTIONS.ipynb`

## Distributional Semantics Lab

In a distributional model of meaning, words are respresented in terms of their co-occurences. This lab looks at how the definition of co-occurence used affects the nature of the similarity discovered. In particular, we are going to contrast *close proximity* co-occurrence (where words co-occur, say, next to each other) with more *distant proximity* (where words co-occur, say, within a window of 10 words).

* [Lab 7 Set Up](#lab-7-set-up)
* [Finding the Frequency Distribution of Words in Sample Sentences](#finding-the-frequency-distribution-of-words-in-sample-sentences)
* [Generating Feature Respresentations](#generating-feature-respresentations)
* [Postitive PMI (PPMI)](#positive-pmi-ppmi-lab)
* [Word Similarity (Lab 7)](#word-similarity-lab-7)
* [Nearest Neighbours (Lab 7)](#nearest-neighbours-lab-7)

### Lab 7 Set Up

This lab uses the Gutenberg fiction book corpus. 
```
import nltk
nltk.download('punkt')
nltk.download('stopwords')
nltk.download('gutenberg')

from nltk.corpus import gutenberg
book_ids=gutenberg.fileids()
books={b:gutenberg.words(b) for b in book_ids}
len(books)

books.keys()
books['austen-emma.txt']
```

The code below collapesed the 18 book corpus into one huge list. I will contain over 2 milltion tokens:
```
gutenberg_corpus=[]
for b in books.values():
    gutenberg_corpus+=list(b)
    
len(gutenberg_corpus)
```

Whilst we don't care about where one book ends and another begins, we do want some structure to the tokens in the form of sentences. We build sentence segmenters in the early labs. Whilst doing this segmenting we will carry out the that standard normalisation techniques. Note, the output we want is normalised tokenized sentencesL

```
from nltk.tokenize import sent_tokenize, word_tokenize
gutenberg_sentences=sent_tokenize(' '.join(gutenberg_corpus))
tokenized1=[word_tokenize(sent) for sent in gutenberg_sentences]
len(tokenized1)
```

Here is a boiler plate normailzation functions: 

```
def normalise(wordlist):
    lowered=[word.lower() for word in wordlist]
    normalised=["Nth" if (token.endswith(("nd","st","th")) and token[:-2].isdigit()) else token for token in lowered]
    normalised=["NUM" if token.isdigit() else token for token in normalised]
    filtered=[word for word in normalised if word.isalpha()]
    return filtered

normalised1=[normalise(sent) for sent in tokenized1]

normalised1[0]
```

### Finding the Frequency Distribution of Words in Sample Sentences

This once again utilises dictionaries `.get(token,0)+1` method which allows us to record and update frequencies:

```
def freq_dist(sentences):
    mydict={}
    for sentence in sentences:
        for token in sentence:
            mydict[token]=mydict.get(token,0)+1
    return mydict

def most_frequent(freqdist,k=100):
    return sorted(freqdist.items(),key=operator.itemgetter(1),reverse=True)[:k]

print(most_frequent(freq_dist(normalised2),5))
```

### Generating Feature Respresentations

Remember the simplist method of constructing Distribution Feature Representations is to look at proximity within a two sided window around a word. 

The code below shows how to iterate through a sentence, extracting the `n` words either side of a token. 

```
tokens=word_tokenize("the moon is blue and made of cheese")

window=1

for i,word in enumerate(tokens):
    print(word,tokens[max(0,i-window):i]+tokens[i+1:i+window+1])
```

The code below takes a list of sentences and a window size and will output a dictionary of dictionaries. The key will be a word and itself dictionary will be the count for words that were found around it. Note, that the key is the cumlative counts for that word, so if "moon" comes up several times in a document the counts will summed. The code works by first looping through the sentences, then looping through the tokens. For each token, it checks/records and entry in the output dict, then it runs the window feature code to get the features. Then it loops through the features distributing them into the tokens nested dict and adding counts as it sees them:

```
def generate_features(sentences,window=1):
    mydict={}
    for sentence in sentences:
        for i,token in enumerate(sentence):
            current=mydict.get(token,{})
            features=sentence[max(0,i-window):i]+sentence[i+1:i+window+1]
            for feature in features:
                current[feature]=current.get(feature,0)+1
            mydict[token]=current
    return mydict
```

```
sents=["the moon is made of blue cheese",
        "the really fat cat is eating blue cheese sitting on the mat"]
tokenised_sentences=[word_tokenize(sent) for sent in sents]
generate_features(tokenised_sentences,window=1)

{'the': {'moon': 1, 'really': 1, 'on': 1, 'mat': 1},
 'moon': {'the': 1, 'is': 1},
 'is': {'moon': 1, 'made': 1, 'cat': 1, 'eating': 1},
 'made': {'is': 1, 'of': 1},
 'of': {'made': 1, 'blue': 1},
 'blue': {'of': 1, 'cheese': 2, 'eating': 1},
 'cheese': {'blue': 2, 'sitting': 1},
 'really': {'the': 1, 'fat': 1},
 'fat': {'really': 1, 'cat': 1},
 'cat': {'fat': 1, 'is': 1},
 'eating': {'is': 1, 'blue': 1},
 'sitting': {'cheese': 1, 'on': 1},
 'on': {'sitting': 1, 'the': 1},
 'mat': {'the': 1}}
```

### Positive PMI (PPMI) (Lab)

So far we have generated representations which are simply the frequency of events occuring together. We can use PPMI to establish how significant a given frequency of co-occurence is.  

If the words "player" and "tennis" are both very common words in their own independent right then their co-occuring 10 times together may be insignifciant. However, if they are rare words which co-occure 10 times then this should be considered more significant. 

$$
\begin{align}
PMI(word,feat) = \frac{\text{freq}(word,feat) \times \Sigma_{w*,f*} \text{freq}(w*,f*)}{\Sigma_{f*} \text{freq}(word,f*) \times \Sigma_{w*} \text{freq}(w*,feat)}
\end{align}
$$

There are a few things we need to execute this calculation:
* the frequency of co-occurance between "word1" and "word2"
* the total number of times "word1" has occur with any feature
* the total number of times tennis has occured as a feature
* the grand total of all possible co-occurances (based on how much they occured each)

To do this we create a class called `WordVec`. This takes a list of sentences and a desired window size. The class has a method automatically called in this init function called `_generate_features`. This will gather the disributional features, calculate the word and feature total totals, all of this informatio will be stored in Instance Attributes created in the in init which can be used within the class or access from the inistnated class.

```
class WordVectors:
    def __init__(self,sentences,window=3):
        self.sentences=sentences
        self.window=window
        self.reps={}
        self.wordtotals={}
        self.feattotals={}
        self._generate_features()
        self.grandtotal=sum(self.wordtotals.values())
    
    def _generate_features(self):
        for sentence in self.sentences:
            for i,token in enumerate(sentence):
                current=self.reps.get(token,{})
                features=sentence[max(0,i-self.window):i]+sentence[i+1:i+self.window+1]
                for feature in features:
                    current[feature]=current.get(feature,0)+1
                    self.feattotals[feature]=self.feattotals.get(feature,0)+1
                self.wordtotals[token]=self.wordtotals.get(token,0)+len(features)
                self.reps[token]=current
```

```
vectors_3=WordVectors(normalised2)
print(vectors_3.reps['house']['summer'])
print(vectors_3.wordtotals['house'])
print(vectors_3.feattotals['summer'])

feattotals=FreqDist()
for wordrep in vectors_3.reps.values():
    feattotals.update(wordrep)
list(feattotals.keys())

feattotals['summer']
```

Now we want to convert the representations based on frequency into one based on PMI. 

$$
\begin{align}
\text{PPMI}(word,feat)=
\begin{cases}PMI(word,feat),& \text{if PMI}(word,feat)>0\\
=0,& \text{otherwise}
\end{cases}
\end{align}
$$

We add to our class a way to pick up the items and the frequency and use the additional information we have calculated to invoke our PPMI calculaion:

```
def convert_to_ppmi(self):
        self.ppmi={word:{feat:max(0,math.log((freq*self.grandtotal)/(self.wordtotals[word]*self.feattotals[feat]),2)) for (feat,freq) in rep.items()} for (word,rep) in self.reps.items()}
```

```
vectors_3=WordVectors(normalised1)
vectors_3.convert_to_ppmi()
print(vectors_3.ppmi['house']['summer'])
```

Final Class: 

```
class WordVectors:
    def __init__(self,sentences,window=3):
        self.sentences=sentences
        self.window=window
        self.reps={}
        self.wordtotals={}
        self.feattotals={}
        self.generate_features()
        self.grandtotal=sum(self.wordtotals.values())
    
    def generate_features(self):
        for sentence in self.sentences:
            for i,token in enumerate(sentence):
                current=self.reps.get(token,{})
                features=sentence[max(0,i-self.window):i]+sentence[i+1:i+self.window+1]
                for feature in features:
                    current[feature]=current.get(feature,0)+1
                    self.feattotals[feature]=self.feattotals.get(feature,0)+1
                self.wordtotals[token]=self.wordtotals.get(token,0)+len(features)
                self.reps[token]=current

    def convert_to_ppmi(self):
        self.ppmi={word:{feat:max(0,math.log((freq*self.grandtotal)/(self.wordtotals[word]*self.feattotals[feat]),2)) for (feat,freq) in rep.items()} for (word,rep) in self.reps.items()}
```

### Word Similarity (Lab 7)

No that we have feature vectors that has been enriched with PPMI weights instead of frequences, we can use cosine similarity to compute the similiarty between two word vectors. 

To reiterate, the words respresented by vectors which do not include the word themselve but area insteadare  the words surrounding the word of which the value has been enriched to highlight if the word surrounding pair is of statistical signficace or not. 

Below is a boilerplate function for computing the dot product whihc cosine similarity uses: 

```
def dot(vecA,vecB):
    the_sum=0
    for (key,value) in vecA.items():
        the_sum+=value*vecB.get(key,0)
    return the_sum
```

Extending this, we can add another method into the class to compute the similarity between two words. This function picks up the `ppmi` dictionary created and uses the `dot` function to calculate a cosine similarity using this vector: 

```
ef similarity(self,word1,word2):
        rep1=self.ppmi.get(word1,{})
        rep2=self.ppmi.get(word2,{})
        return dot(rep1,rep2)/math.sqrt(dot(rep1,rep1)*dot(rep2,rep2))
```

```
vectors_3=WordVectors(normalised1)
vectors_3.convert_to_ppmi()
print(vectors_3.similarity('summer','winter'))

0.0872055132966406
```

### Nearest Neighbours (Lab 7)

Now we want to use this similarity metric to find the "nearest neighbours" to a given word. In order do do this we need to run `.similarity()` on all other words in a set of candidates (or the whole corpus). Then rank the outcomes by similarity. 

The function below can be added to the `WordVectors` class to provide this functionality:

```
def nearest_neighbours(self,word1,n=1000,k=10):
    candidates=sorted(self.wordtotals.items(),key=operator.itemgetter(1),reverse=True)[:n]
    sims=[(cand,self.similarity(word1,cand)) for (cand,_) in candidates]
    return sorted(sims,key=operator.itemgetter(1),reverse=True)[:k]

vectors_1=WordVectors(normalised1,window=1)
vectors_1.nearest_neighbours('summer',n=2000)

[('summer', 1.0),
 ('winter', 0.11408560697639314),
 ('sabbath', 0.10343614608653066),
 ('evening', 0.09953955510058124),
 ('sunday', 0.09260322034936996),
 ('supper', 0.09177689366961025),
 ('watch', 0.08074545777876865),
 ('season', 0.07798892936987538),
 ('week', 0.07583785807132003),
 ('walls', 0.06984271903761587)]
```

<div style="page-break-after: always;"></div>

# Week 8 - Part-of-Speech Tagging and Hidden Markov Models

This lecture has two parts. It is split into understanding what Part-of-Speech is and how it is useful and moves into methods to tag existing corpora and specifically looks into Hidden Markov Methods.

The part-of-speech of a word determines the role it plays in the sentence; for example, whether it is a noun, a verb, an adjective, an adverb, a conjunction, a determiner ... 

Many words, taken in isolation, are ambiguous as to their part of speech.  For example, the word book can be used as a noun or a verb.  Therefore, we tend to look at sequences of words when part-of-speech tagging:
- I picked up the book from the library.
- I want to book a table for this evening.

The previous word gives a strong clue as to the POS tag of the word book.   Therefore, an effective method for POS tagging involves using Hidden Markov Models (HMMs). 

1. [Lecture Notes](#week-8---lecture-notes)
2. [Lab Session](#week-8---lab-session)

<div style="page-break-after: always;"></div>

## Week 8 - Lecture Notes

* [Parts of Speech](#parts-of-speech)
    * [POS Definitions](#pos-definitions)
    * [Open and Closed Classes](#open-and-closed-classes)
    * [Part-of-Speech Tagset](#part-of-speech-tagset)
    * [Part-of-Speech Tagging](#part-of-speech-tagging)
    * [PoS Ambiguity](#pos-ambiguity)
    * [Evaluating Taggers](#evaluating-taggers)
    * [Word Identities](#word-identities)
    * [A Unigram PoS Tagger ](#a-unigram-pos-tagger)
* [Hidden Markov Models](#hidden-markov-models)
    * [HMMs for POS Tagging](#hmms-for-pos-tagging)
    * [Encoding the Assumptions Probabilistically](#encoding-the-assumptions-probabilistically)
    * [Parameters for an HMM](#parameters-for-an-hmm)
    * [Calculating Emissions](#calculating-emissions)
    * [Calculting Transitions](#calculting-transitions)
    * [Forward Algorithm](#forward-algorithm)
    * [Decoding HMM](#decoding-hmm)
    * [Viterbi Algorithm](#viterbi-algorithm)
        * [Horiztonal Assumption](#horiztonal-assumption)
        * [Vertical Assumption](#vertical-assumption)
        * [Trellis Building](#trellis-building)
        * [Assumption Summary Points](#assumption-summary-points)
        * [Sub Problems](#sub-problems)
        * [Recursive Step](#recursive-step)
        * [Efficiency of Viterbi](#efficiency-of-viterbi)

## Parts of Speech

Words can be categorised according to how they behave grammatically. Traditionally, there are 9 or 10 lexical categories (PoS):
- Noun
- Verb
- Adjective
- Adverb
- Auxilary Verb
- Conjunction
- Determiner
- Interjection
- Preposition
- Pronoun

Identifying PoS is a useful pre-processing step. It can help disambiguate word which is good for accuracy information retreival, text-to-speech and document classifcation. The context of what a word is can help us better understand what words are likely to occur nearby.  Adjectives are often followed by nouns "happy student", personal pronouns follows by verbs "you laugh". 

### POS Definitions

**Nouns and Pronouns**: used to identify people, places and things. Divided into Proper Nouns: "England", "Luke", "Microsoft". And Common Nouns: which too and split into Count Nouns: "window", "tyre" and Mass Nouns: "snow", "rice". Pronouns stand in place of a noun: "she", "you", "I"

**Verbs and Auxiliary Verbs**: These are ations and processes: run, chase, say. Auxiliary verbs usually precede a main verb. "she **should** chase the thief".

**Adjectives and Adverbs**: Adjectives are properties and qualities that modify nouns: green, small, clever. Adverbs usually modify verbs or verb phrases: slowly, now, unfortunantely. 

**Determiners**: a modifying word that determins the kind of references a noun has. "i would like *a* cake" vs "i would like *the* cake". Also known as articles.

**Preposition and Particles**: Preposition specific the relative position of two things. "I saw the boy UNDER the bridge". Particles are sometimes distinguished from prespositions, they modify a verb: "i tidied UP the room".

**Conjunctions and Interjections**: Conjunctions join words and phrases together. "and, but, because, either". Interjections are exclamations with any gramatical connection to the other words "hey, ouch, darn". 

### Open and Closed Classes

The are two fundamental categories of parts of speech (PoS) based on how their vocabulary evolves over time and their role in a sentence. 

Open classes are categories of words that are not fixed; they are constantly evolving as the language changes: 
* New Additions: New words are added to these classes frequently (e.g., modern terms like "boop," "bussin’," and "AGI").
* Archaic Words: Older words can also drop out of common usage and become archaic (e.g., "camelopard" or "sanative").
* Content-bearing: These words carry the primary meaning or "content" of a sentence.
* Typical Examples: Nouns, Verbs, Adjectives, and Adverbs

Closed classes are fixed categories that rarely, if ever, change or accept new members.
* Functional Role: These words are "functional" rather than "content-bearing"; they act as the "glue" that specifies how different concepts in a sentence relate to each other.
* Characteristics: They are typically short in length and occur very frequently in text.
* NLP Application: Because they are so common and often carry less specific "meaning" on their own, they are frequently treated as stopwords in various NLP applications.
* Typical Examples: Determiners (e.g., a, the), Prepositions (e.g., on, under), Pronouns (e.g., she, you), and Conjunctions (e.g., and, but)

Understanding this distinction is important because it explains why simple PoS taggers (like the Unigram Tagger) can often achieve high accuracy as many of the most frequent "closed class" words are rarely ambiguous, whereas "open class" words are where the complexity of language change and ambiguity typically resides.

### Part-of-Speech Tagset

A tagset is an inventory of labels, not a data collection itself. It provides the labels for marking different PoS classes, a list of codes like NN (Noun), VB (Verb), or JJ (Adjective). There are different decisions on how many tages there are which are derived from different corpora. For example, the Brown corpus uses a larger tagset (80 tags) compared to the Penn Treebank (45 tags), meaning it makes finer distinctions between word types. 

The Penn Treebank Tagset is a widely used standard in Natural Language Processing for labeling parts of speech. t is significantly smaller and more condensed than other common tagsets, such as the Brown Corpus (80 tags) or the Susanne Corpus (350 tags). It is the standard used to evaluate modern PoS taggers; on well-formed text, state-of-the-art methods achieve an accuracy of 96–97% when using the Penn Treebank tagset. 

### Part-of-Speech Tagging

PoS tagging is the proccess of assigning a single PoS tag to each word and punctutation is some text. 

PoS is generally a shallow form of processing. Is it 1:1 tags to per word, it doesn't try to understand the whole sentence or topic, it just wants to tag the individual word. Often it only looks at the word ahead so it is can tag for that. PoS is a non-trival task for computers because of ambiguity. The same word can function as different PoS depending on its neighbours. A good tagger must use the clues around the word to tag correctly. 

### PoS Ambiguity

In the Brown corpus 11.5% of word types and 40% of word tokens are ambiguous with respect to POS tag. That is, they could be labelled with mutliple tags. 

Global ambiguity occurs when an entire sentence can be assigned multiple, completely different PoS tag sequences, each resulting in a different (but grammatically valid) meaning.

"Fruit flies like a banana."

Interpretation A (The "Insect" meaning):
- Fruit (Noun/Adjective): A type of fruit.
- flies (Noun): The insects.
- like (Verb): To enjoy.
Meaning: Insects called fruit flies have a preference for bananas.

Interpretation B (The "Physics" meaning):
- Fruit (Noun): The object.
- flies (Verb): To move through the air.
- like (Preposition): Similar to.
Meaning: A piece of fruit is traveling through the air in the same manner as a banana travels.

In global ambiguity, the context within the sentence itself is not enough to definitely pick one tag sequence over the other; you would need outside knowledge or broader paragraph context to know which is intended.

Local ambiguity occurs when a word is ambiguous in isolation, but the surrounding words (local context) make only one PoS tag plausible.

"Time always flies like an arrow."

- The word "flies" is locally ambiguous (it could be a noun or a verb).
- However, the presence of "Time" (Subject) and "always" (Adverb) before it "locks" "flies" into being a Verb.
- The sequence "Noun + Adverb + Noun" (Time always insects...) would be ungrammatical in English, so a PoS tagger can use this local context to resolve the ambiguity.

Simple models like the Unigram Tagger (Slide 28) fail at local ambiguity because they only look at the word itself, not the context. More advanced models like Hidden Markov Models (HMMs) (Slide 34) are designed specifically to solve local ambiguity by looking at the "Transition Probabilities"—the likelihood of one tag following another (e.g., how likely is a Verb to follow an Adverb?).

### Evaluating Taggers

This is how we determine the success of a tagging model. it's about comparing a machine's "guess" against a "ground truth."

To evaluate a tagger, you need a Gold Standard—a corpus where every word has been manually labeled by expert linguists (e.g., the Penn Treebank or the Brown Corpus).

We assume that if a tagger performs well on the gold standard (e.g., Wall Street Journal articles), it will perform similarly on other "similar" unlabelled text (like New York Times articles). However, if you move the tagger to a very different domain (like Tweets or medical journals), accuracy usually drops significantly.

Accuracy (The Standard): This is the primary metric for PoS tagging. It is the simple proportion of tags that the model got right out of the total number of words.Calculation: $\frac{\text{Correct Tags}}{\text{Total Words}}$

Precision (Per Class): While accuracy gives the "big picture," precision looks at individual tags. For example, if the model tags 100 words as VB (Verb), but only 80 of them were actually Verbs in the gold standard, the Precision for the Verb class is 80%. This is useful for identifying which specific grammatical categories the model is struggling with (e.g., it might be great at Nouns but terrible at Adverbs).

The slide notes that state-of-the-art taggers achieve 96–97% accuracy on well-formed text. This number is significant because Inter-annotator agreement is also around 97%. This means that if you give the same sentence to two expert linguists, they will only agree on the tags about 97% of the time. Since humans don't agree 100% of the time, we cannot realistically expect a machine to hit 100% accuracy. A 97% accurate machine is essentially performing at the level of a human expert. 

If a tagger is 97% accurate, it makes an error on 3% of words. If an average sentence is 15–20 words long, you can expect one incorrect tag roughly every 30–40 words. Most of these errors happen on locally ambiguous words (like the "flies" example on Slide 24) or on rare words that the model didn't see enough during training. 

n PoS tagging, a confusion matrix is particularly useful for seeing which tags are being swapped—for example, a model might frequently "confuse" a Past Tense Verb (VBD) with a Past Participle (VBN).

While there are roughly 9 or 10 basic categories (Noun, Verb, etc.), most NLP tasks use the Penn Treebank Tagset (45 tags). A $45 \times 45$ matrix is very common in research. It is useful because it reveals "fine-grained" errors that a simple accuracy score would hide: 

- Tense Confusion: You might see a high number of errors where the model confuses VBD (verb, past tense) with VBN (verb, past participle). These are both "Verbs," but the matrix tells you exactly which grammatical distinction the model is failing to make.
- Noun vs. Adjective: As mentioned in the Local vs. Global Ambiguity section (Slide 24), words like "building" are tricky. The confusion matrix will show if your tagger is systematically misidentifying nouns as adjectives when they appear before another noun.
- Sparsity: In a large matrix, you will notice that most cells are zero. For example, a model is very unlikely to confuse a DT (Determiner like "the") with a VB (Verb like "run"). If you see numbers in that cell, it indicates a major flaw in your model's logic or training data.

Accuracy tells you the overall performance. The Confusion Matrix allows you to calculate the Precision and Recall for specific tags.

### Word Identities

The word itself is the first and often biggest clue in identifying the PoS. A word may have many different possible PoS tags but they are generally not all equal it likelihood. Tag distributions often low entropy and one tag is far more likley then the others. Entropy is a measure that can be used for uncertainty in the tag distribution. 50:50 is high entropy, 90:10 is low entropy. Entropy and uncertainty can be used interchangably. 

If we know the word is "book," even without looking at the sentence, we can guess it's a Noun and be right most of the time because it acts as a noun more frequently than a verb.

Because most words have a dominant tag (low entropy), a tagger that only looks at the word identity and always picks the most frequent tag can achieve roughly 90% accuracy. The reason we can't get to 100% using word identities alone is because of those "High Entropy" moments where context is required to break the tie.

This is the "baseline" of PoS tagging. Every advanced model (like an HMM) starts with this word identity information (Emission Probabilities) and then adds context (Transition Probabilities) to solve the remaining uncertainty.

### A Unigram PoS Tagger 

The logic of a unigram tagger is the most likely tag. For any given word, it always assigns the tag that was most frequent for that word in the training data. 

It completely ignores the surrounding words. For example, if the word "flies" appeared as a Noun 60 times and a Verb 40 times in your training set, the unigram tagger will always label it as a Noun, even in the sentence "Time flies". To "learn," the tagger looks at a labeled corpus and builds a frequency table for every word. 

$$tag(w) = \text{argmax}_t P(t|w)$$

Despite its simplicity, this tagger usually achieves around 90% accuracy. This is because most words have a dominant meaning/tag. The tagger fails whenever a word is used in its "non-dominant" sense. It cannot solve Local Ambiguity because it doesn't look at the adjacent tags.

Just as Naive Bayes used prior probabilities to make a "best guess" based on features, the Unigram Tagger uses the "prior" tag frequency for a specific word to make its guess.

Hidden Markov Models (HMMs) bridge that final 6–7% gap by incorporating "Transition Probabilities"—looking at the tags of neighboring words.

## Hidden Markov Models 

A tagger takes an input of words: $w^2_1 = (w_1, w_2, ..., w_n)$ and outputs a sequence of tags $t^n_1 = (t_1, t_2, ..., t_n)$. Specifically, it finds the most probable PoS tag sequence. 

In a Hidden Markov Mode, a sequence of observations is generated by a sequence of hidden states. There are two layers working together: The hidden states which are the underlying PoS tags, grammatical categories that generate words. And there are obversations, these are the words themsevles (may be presented as numbers or vectors). 

Think of these structure and two layers of information chained together as a sentence.

The Markov Assumption is that the "current state depends only on the previous state". It is the Horizontal Link. This means the probability of a word being a Verb depends only on the tag of the word immediately before it (e.g., if the previous tag was a Noun, a Verb is very likely). It's a "Markov Chain" because of this dependency, but it is "Hidden" because we only see the words, not the tags themselves.

The Output Assumption is the vertical link between word and PoS (state). The "current output depends only on the current state". This means that once the model has decided a hidden state is a Noun, the specific word it "outputs" (like "dog" or "cat") depends only on that Noun tag, not on any previous words in the sentence. 

Previously we saw that the Unigram Tagger is "context-free". By contrast, the HMM uses the Markov Assumption to bring in context. 

If the model sees the word "flies" (which is ambiguous), but the previous state was "Fruit" (tagged as a Noun), the Markov Assumption helps the model realize that "flies" is much more likely to be a Verb in that specific sequence than a Noun.

To make this work, the model needs two sets of probabilities which are detailed later in the lecture:
* Transition Probabilities: How likely is one tag to follow another? (The Markov link) .
* Emission Probabilities: How likely is a specific word to be generated by a specific tag? (The Output link)

### HMMs for POS Tagging

HMM is a "two-layer" architectural model. 

The Hidden States ($\text{PoS tags}$): These are the grammatical categories like Noun, Verb, and Adjective. They are called "hidden" because when you read a book, you only see the ink of the words; the grammatical structure is an underlying mental or logical layer you have to infer

The Observations ($\text{Words}$): These are the physical tokens you see in the sequence (e.g., "Every", "night", "I", "dream").

HMM is a generative model. It imagines that the language was created in this order: Your brain picks a sequence of Tags based on grammar rules (e.g., "I need a Determiner, then a Noun, then a Verb"). Each of those Tags then "emits" a Word (e.g., the Determiner emits "The", the Noun emits "dog")

The Markov Assumption (Horizontal Link): "Current PoS tag depends only on single previous tag". This means the model assumes English grammar is a "chain." To decide if the current word is a Verb, the model only looks at the tag of the word immediately before it. It doesn't look back at the start of the sentence. This is technically a "Bigram" model. 

The Output Assumption (Vertical Link): "Word depends only on current PoS tag". This assumes that if the model is currently in a "Noun" state, the probability of it choosing the word "apple" is fixed. It doesn't care if the previous word was "eat" or "the." While this is a simplification (obviously "eat" makes "apple" more likely), it keeps the mathematics of the Viterbi Algorithm (Slide 47) efficient.

An HMM models a sequence like "Every night I dream," you should explain that the model is trying to find the most likely path through the "hidden" tag states that could have produced those specific observed words. It does this by balancing:
* Grammar: How likely is the tag sequence? (Markov Assumption) .
* Vocabulary: How likely are these words to come from those tags? (Output Assumption).

### Encoding the Assumptions Probabilistically

Translting the conceptual logic of HMMs into mmathematical formulas used for calculation. 

**The Markov Assumption (Horizontal Probability):**

How to calculate the likelihood of a sequence of tags

$P(t_i | t_1 \dots t_{i-1}) = P(t_i | t_{i-1})$

 In a full probability model, the probability of the current tag would depend on every previous tag in the sentence. The HMM "simplifies" this by assuming the current tag $t_i$ only depends on the single previous tag $t_{i-1}$. This is called a First-Order Markov Assumption or a Bigram assumption. For example, the probability of the word "dream" being a Verb depends only on the fact that the previous word "I" was a Pronoun.

 **The Output Assumption (Vertical Probability):**

 Formalizes the likelihood of a word being "emitted" by a tag.

 $$\P(w_1^n | t_1^n) = \prod_{i=1}^{n} P(w_i | t_i)$$

 This says the probability of the entire sequence of words given a sequence of tags is simply the product ($\prod$) of the individual probabilities for each word given its tag.

 It assumes the word $w_i$ depends only on its current tag $t_i$. It ignores the surrounding words. In the example "Every night I dream," the probability of the state Verb producing the word "dream" is independent of the fact that the word "night" appeared earlier.

In Naive Bayes, we saw how we multiply probabilities together to get a final score. The HMM does the same thing. To find the probability of a specific "path" through the sentence, you multiply:
* All the Transition Probabilities (Tag $\rightarrow$ Tag).
* All the Emission Probabilities (Tag $\rightarrow$ Word).

Markov: $P(t_i \mid t_{i-1})$ Probability of the next tag given the current one (Grammar)

Output: $P(w_i \mid t_i)$ Probability of the tag producing that specific word (Vocabulary)

### Parameters for an HMM

These are the specific data points at HMM model needs to actually function. There are two essential parameters: Emission and Transition.  

1. Emission (Observation) Probabilities: $P(w|t)$
    * For every possible tag in your tagset, what is the likelihood that it "emits" a specific word?
    * If the tag is NN (Noun), what is the probability the word is "dream" vs. "night"?
    * This links the Hidden States to the Observations.
2. Transition (Bigram) Probabilities: $P(t_j|t_i)$
    * For every pair of tags, what is the probability that tag $t_j$ follows tag $t_i$5?
    * How likely is a Verb to follow a Noun? Or a Determiner to follow another Determiner?
    * This represents the "Grammar" of the model, moving horizontally across the Hidden States.

There are two ways to get these probability tables: 
- Supervised Approach: You calculate them directly from a pre-tagged corpus like the Penn Treebank. You simply count the occurrences (e.g., "How many times did a Verb follow a Noun?") and divide to get the probability.
- Unsupervised Approach: If you only have raw text with no tags, you can use Expectation Maximization (EM) to "guess" the parameters that best fit the data

The intitution behind the Transition and Emission calculations is:  
- We use Transition Probabilities $P(t_i | t_{i-1})$ to determine how likely a tag is, given the previous tag. For the very first word in a sentence, we use a special "start" transition $P(t_1 | start)$. This is almost like a prior in Naive Bayes
- Now give we have a set of probabilites for each state (class), we can compute the joint probability which is found in the probabiliy of a word occuring ever in that state, i.e. noun. This part is almost like updating the prior with the likelihood in Naive Bayes. 

The slight different to Naive Bayes is that we don't run an argmax to select the highest value. This is because if we were to have a bad word select this would ruin the sequence. Instead we keep all of the computed values and contine a branch from all of them. The send goal is to find the route/sequence that resulted in the highest Total Joint Probability. Something called the Viterbi Algorithm is used to keep track of all routes. Note, HMMs are incredible computationally expensive, there are a lot of calculations made and stored.

### Calculating Emissions

Emissions are the probability of a word given a tag. To calculate this we rely on a pre-existing tagged dataset. We compile the word counts broken down into tag subsets and then store them as a ratio against total word list counts.

The training set would look something like:
```
train = [
    ('Pierre', 'NNP'),
    ('Vinken', 'NNP'),
    (',', ','),
    ('61', 'CD'),
    ('years', 'NNS'),
    ('old', 'JJ'),
    (',', ','),
    ('will', 'MD'),
    ('join', 'VB'),
    ('the', 'DT'),
    ('board', 'NN'),
    ...
]
```

The function below counts class occurances and normailzes them using the total token count within each subcless, not the overall training list count:
```
def calculate_emissions(trainlist):
    # trainlist is a list of (word, tag) pairs
    emissions = {}
    for word, tag in trainlist:
        current = emissions.get(tag, {})
        current[word] = current.get(word, 0) + 1
        emissions[tag] = current
        
    return {tag: {word: value/sum(worddist.values()) 
                  for word, value in worddist.items()} 
            for tag, worddist in emissions.items()}
```

The output would look something like this. NNP means Noun: Proper Noun meaning it is specific sub-class
```
{
    'NNP': {
        'Pierre': 6.613100552193897e-05,
        'Vinken': 2.204366850731299e-05,
        'Nov.': 0.0026231965523702454,
        'Mr.': 0.04412040251738694,
        'Elsevier': 1.1021834253656494e-05,
        'N.V.': 0.0001432838452975344,
        'Dutch': 8.817467402925195e-05,
        'Rudolph': 8.817467402925195e-05,
        'Agnew': 3.306550276096948e-05,
        ...
    }
}
```


### Calculting Transitions

Transistions are the probability of a tag given the previous tag. 

This function iterates through the training list to count how often one tag follows another, starting with a special "start" tag for the beginning of the sequence. 

Key Differences from Emissions
* Normalization: Like the emission function, this normalizes by the total counts of the previous tag (the subclass). This ensures that for any given tag, the probabilities of all possible "next" tags sum to 1.0.
* Context: While emissions link tags to words, transitions link tags to other tags, representing the "grammar" of the HMM

```
def calculate_transitions(trainlist):
    # trainlist is a list of (word, tag) pairs
    transitions = {}
    previous = "start"
    for _, tag in trainlist:
        current_transitions = transitions.get(previous, {})
        current_transitions[tag] = current_transitions.get(tag, 0) + 1
        transitions[previous] = current_transitions
        previous = tag
        
    return {previous: {tag: value/sum(tagdist.values()) 
                       for tag, value in tagdist.items()} 
            for previous, tagdist in transitions.items()}
```

### Forward Algorithm 

This is what is used to calculate the Probability of a word sequence given a tag sequence. In the context of the larger HMM "Decoding" problem, this is a sub-step that uses the Output Assumption to calculate the vertical "emission" score for a full sentence. 

The probability of a word sequence ($w_1^n$) given a tag sequence ($t_1^n$) as the product of the individual emission probabilities:

$$P(w_1^n | t_1^n) = \prod_{i=1}^{n} P(w_i | t_i)$$

Part of the intution here is that the transition probabilities have already been computed and we are left with many chains of sequences which are just PoS tags. We are now going to fill these tags by deriving the most expected words given the emmissions and calculating the joint probability.Given the Output Assumption the model assumes the current word depends only on its current tag and nothing else in the sequence.

For an example, take an input sequence like "flies like flowers" and a proposed tag sequence of $N, V, N$ (Noun, Verb, Noun) 

With an emissions table of:

| Word ($w$) | $P(w|N)$ | $P(w|V)$ |
| :--- | :--- | :--- |
| flies | 0.025 | 0.015 |
| like | 0.012 | 0.034 |
| flowers | 0.05 | 0.005 |

The calculating would look like:

$$P(\text{flies like flowers} | N, V, N) = P(\text{flies}|N) \times P(\text{like}|V) \times P(\text{flowers}|N)$$$$= 0.025 \times 0.034 \times 0.05 = \mathbf{0.0000425}$$

You can visualize the hidden states as a trellis or a network of all possible grammatical sequences. If you have a sentence of 3 words and a tagset of 45 tags, there are $45^3$ (91,125) possible "chains" or paths through the hidden states. Each link in the chain is governed by the Transition Probability $P(t_i | t_{i-1})$, which determines how likely that specific sequence is according to the rules of grammar. For every one of those possible chains, the HMM calculates how well the observed words "fit" that specific path using the Emission Probabilities $P(w_i | t_i)$. The goal of the HMM is to find the tag sequence ($T$) that maximizes the joint probability of the tags and the words together.

$$\text{Best Path} = \operatorname*{argmax}_{t_1 \dots t_n} \prod_{i=1}^{n} \underbrace{P(t_i | t_{i-1})}_{\text{Grammar Chain}} \times \underbrace{P(w_i | t_i)}_{\text{Word Fit}}$$

The intuition of "all possible chains" is theoretically correct, calculating every single one would be computationally impossible for long sentences (e.g., a 20-word sentence would have $45^{20}$ paths).

Viterbi is the "shortcut" that allows us to find the best chain without actually computing every single possibility. It works by moving word-by-word and only keeping track of the best path leading into each tag at each step, effectively "pruning" the chains that are mathematically impossible to be the winner.


### Decoding HMM

We calculated the probability of a specific word sequence given a specific tag sequence. This is essentially an "evaluator"—if you tell the model exactly what the tags are, it can tell you how well the words fit those tags.

In the real world, we don't know the tag sequence; we only have the words. Decoding is the process of working backward from the observed words to find the single most likely tag sequence (the "best path") out of every possible combination.

Decoding is a very important topic. As discussed, for a sentence of length $n$ and a tagset of size $k$, there are $k^n$ possible tag sequences. If we used the logic from Slide 39 to evaluate every possible sequence to find the winner, it would be computationally impossible for standard sentences (e.g., $45^{20}$ combinations).

We need to move from observing a sequence of words to identifying the single most probable sequence of tags.

We are given a sequence of $n$ words ($w_1, w_2, \dots, w_n$). Our task is to find the sequence of $n$ tags ($t_1, t_2, \dots, t_n$) that is most likely to have generated those words.

Among all possible combinations of tags, we are looking for the "Best" one, which is defined as the sequence that maximizes the joint probability of the words and tags together.

$$\hat{t}_1^n = \operatorname*{argmax}_{t_1^n} P(t_1^n, w_1^n)$$

* $\hat{t}_1^n$: This represents our chosen "best" sequence of tags.
* $P(t_1^n, w_1^n)$: This is the joint probability of a specific tag sequence and the word sequence.

In a Hidden Markov Model, we find this best sequence by multiplying together all the individual Transition Probabilities and Emission Probabilities that make up that specific path.

Since it is difficult to calculate $P(t_1^n | w_1^n)$ directly (the probability of a tag sequence given the words), we apply Bayes' Rule to reverse the conditional probability.

$$\hat{t}_1^n = \operatorname*{argmax}_{t_1^n} \frac{P(w_1^n | t_1^n) \times P(t_1^n)}{P(w_1^n)}$$

To make the task easier we drop the denominator: 

$$\hat{t}_1^n = \operatorname*{argmax}_{t_1^n} \underbrace{P(w_1^n | t_1^n)}_{\text{Likelihood (Emissions)}} \times \underbrace{P(t_1^n)}_{\text{Prior (Transitions)}}$$

Finally, we substitute the HMM assumptions (Markov and Output assumptions) into this simplified Bayes equation:
- Likelihood becomes the product of individual Emission Probabilities: $\prod P(w_i | t_i)$.
- Prior becomes the product of individual Transition Probabilities: $\prod P(t_i | t_{i-1})$.

The move into Bayes' Rule is essentially a way to turn a "Decoding" problem into a "Multiplication" problem. Instead of trying to guess tags from words, the model calculates:
- Prior: How likely is this "chain" of tags grammatically?
- Likelihood: How likely are these words to come from those specific tags?
- The Answer: The path where the product of these two is the highest is your winner.

$$t̂₁ⁿ = argmax_{t₁ⁿ} ∏_{i=1}^{n} P(tᵢ | tᵢ₋₁) * P(wᵢ | tᵢ)$$

### Viterbi Algorithm

The Viterbi Algorithm is our tool for finding the besr tag sequence without having to compute all possibilities as that would result in an unfathomable number. The algorithm inherently occupies the HMM assumptions to make the simplificaiton of calculations possible. 

#### Horiztonal Assumption

The Horizontal Assumption says that the probability of a tag occuring depends only on the sequences previous tag $P(t_i | t_{i-1})$. The next tag does not care about the combination of the sequence that pertained to the previous tag. 

Imagine you are at tag 3 in a sentence, you have the word flies and are considering the tag "Verb". If there are 45 tags, that will be many (e.g. 100) theoretically possible tag sequences that allow for Verb in position 3. In an exhaustive approach where you calculate every possible path and select for the highest, you would need to keep all 100 in memory and calculate for position 4. 

The Viterbi Algoritm recognises that for any future tags in this sequence, the only thing that matters is the position 3 is a verb. Therefore, it only needs to remember the one single best path out of those 100 that reached the "Verb" state at word 3. This intuition would be true for every class at word 3. Hence only 45* sequencies would be stored and carried over to word 4 for calculation. 

As a result, the calculation take at section 4 would look something like: $(Previous Path Probability) $\times$ (Transition Probability) $\times$ (Emission Probability)$

By throwing away all suboptimal paths at every step, the algorithm prevents the search space from exploding exponentially ($k^n$). Instead of $45 \times 45 \times 45 \dots$ (growing forever), it effectively resets the search at every word. At any given word $i$, you are only ever keeping track of $k$ paths (one for each possible tag in the tagset).

This turns a "Global" search for the best sequence into a series of "Local" decisions that are guaranteed to lead to the global optimum. Without the Markov assumption (if $t_i$ depended on every previous tag), you couldn't throw those paths away, and the Viterbi algorithm wouldn't work.

#### Vertical Assumption 

The HMM assumes that the current observed word ($w_i$) depends only on its current hidden PoS tag ($t_i$). The model acts as if the tag "emits" the word in a vacuum. It assumes that if the tag is Noun, the probability of the word being "flies" is the same regardless of whether the previous word was "Fruit" or "Time". This assumption says there are no diagonal links between a word and previous or future tags.

Because of this vertical isolation, the Viterbi algorithm can perform local multiplication. When the algorithm is filling in a cell in the trellis (calculating the score for a specific tag at a specific word), it only needs two local numbers to update the path:
* The Transition Probability ($P(t_i | t_{i-1})$): The horizontal "grammar" score.
* The Emission Probability ($P(w_i | t_i)$): The vertical "vocabulary" score.

$$\text{New Score} = (\text{Best Previous Path Score}) \times P(t_i | t_{i-1}) \times \mathbf{P(w_i | t_i)}$$

Because $P(w_i | t_i)$ is independent of everything else, Viterbi can pre-calculate or simply look up the tag-word value in a pre-calculateed table and apply it instantly to every incoming path.

If the word ($w_i$) depended on the previous tag ($t_{i-1}$) or the previous word ($w_{i-1}$), the number of combinations would explode. You would have to track every possible word-tag-word triplet. By exploiting the output assumption the algorithm only has to perform one vertical lookup per cell. This keeps the "Emission" part of the calculation at a constant cost, contributing to the overall $O(k^2 \times n)$ efficiency.

Remeber, there are two applications of HMMs. It is a generative tool but we are using it is a context of POS tagging so we already have the sequence, we just want to generative the POS tags. The Task is "Inference" (Decoding). 

To be clear, the way that the Viterbi leans on the vertical assumption is that it allows us to not need to do any combinational calculations, i.e. previous tag, tag, next word. We have a store of n-tag optimal sequences, we have a lookup table of tag-to-tag probabilities $P(t_i | t_{i-1})$ and then we have a look up of tag-to-word probabilities $P(w_i | t_i)$. With the latter point owing to the vertical assumptions isolation benefit.

#### Trellis Building

When it comes to building the trellis we store the 45 top sequences at each word. This knows as the Forward Pass. Beside each score there will be a pointer saying "To get this high score, I came from Tag X in the previous column." By the time you reach the end of a 10-word sentence, you have a grid of $10 \times 45$ scores and $10 \times 45$ pointers. 

To get the correct sequence you do a backpass. Here you follow the breadcrumb pointers back picking up the tags and contructing the POS tag sequence which most likely matches the input sentence.

The Trellis Memory: Is a cumulative "map" of the best ways to reach every possible tag at every possible word.

The Choice: We only make the "final" choice of the sequence once we reach the end of the sentence and work backward.

#### Assumption Summary Points

The look up tables are: **A Transition Matrix (Tags $\times$ Tags)** and **Emission Matrix (Tags $\times$ Words)**. And the top previous sequences are stored in the "trellis memory". This is just the highest score achieved to reach a specific tag at the previous word. 

The Viterbi Algorithm is using the HMM assumptions to partition down and therefore minimize the number calculation are each step by combining these 3 different ingredients, 2 of which are pre-calculated look ups. 

#### Sub Problems

The key to Viterbi's functionality is that is it able to break things down into sub problems. 

The structure of the subproblem is given by the format: $V(n,tag)$
- V means Viterbi
- $n$ is the iteration of the sub-problems based on the position of the sentence being docoded. The first poisiton is 1. 
- $t$$ is is the type of speech being investigated. 

If there are 10 words in a sentence and 45 tags then `n=10` and `t=45`. It should be noted that conceptually, these sub-problems are what we used to compute and store the trellis table. At each sub problem, we will calculate 45 best sequences which will use the previous 45 as input to the calculations. 

If we have an input sequence $w_1^n$, we break down into sub-problems using the pairwise $(n,t)$. We want to work out what the most probable tag is in each position. 

`"flies like flowers"`

if "flies" (the word) is the noun, what is the most probable tag sequence to produce it? and then repeat for all tags, e.g. verb. 

The start of the Viterbi is easy because the first position has no preceeding sequence to make into account, just start of sentence. So we just take the tag with the highest probability. The values determined for each tag are stored in the first trellis table column. 

In the next position, `n=2`= `V(2,tag)` we first look at the sub-problem as `n=1`. If `n=2` the word is `like` and we want to work out the probability that it is a `NOUN` = `V(2,NOUN)` we need to consult all 45 possible sequences from `n=1` and identify the highest probability. We then need to cycle through every tag, repeating the same function. This is where Viterbi's recursive nature is shown. It also highlights the modularity of the problems. Finally, 45 best probability sequences will be calculated for each tag which will each consult on and draw on a sequence from the previous position. These 45 will be stored in the next column of the trellis table with each row having a pointer to the previous positons entry that it carried on from. 

For an example of the structure of the calculations/equations taken. 

The first because there is only 1 previous position to consult which is the start:

$$sb_1^n: V(1,noun) = P(t_1 = N) = P(flies|N)*P(N|start)$$

$$sb_1^v: V(1,verb) = P(t_1 = V) = P(flies|V)*P(V|start)$$

The second becomes more complicated.

Here would be the calculations needed to work out if the 2nd position word is going ot be a noun:

Here the probability of position 2 being a NOUN is calculated using `V(1,N)`, and there uses the look up `P(N|N)` in its calculation: 

$$sb_2^n: V(2,NOUN) = P(t_2 = N) = V(1,N) * P(N|N) * P(word|N)$$

Here we are still working out the probability of it being a NOUN but instead it consultes `V(1,V)` from the trellis and `P(N|V)` for the look up:

$$sb_2^n: V(2,NOUN) = P(t_2 = N) = V(1,V) * P(N|V) * P(word|N)$$

These calculations are repeated recurisively for all tags, e.g. 45, and then the highest probability is selected as the route for NOUN in position two for which a row entry is may for position 2 trellis column. In code, the recurive nature of the function might have the functionaily to process, if `if prev was tag` etc to pickup the correct values from the tables. 

#### Recursive Step

The middle of Viterbi is a recursive and acts as the main engine. his is where the "work" happens for every word between the first and the last. The Viterbi Algorithim is simply one calculation repeated over and over. For every possible Tag at the current Word, we want to find the single best path that could have led to it. We represent this as a value in a cell: $v_t(j)$ (The Viterbi value for Tag $j$ at time $t$).

To fill in a single cell, the algorithm looks at the previous column and performs this "Local Winner" calculation:

$$v_t(j) = \underbrace{\max_{i=1}^{k} \left[ v_{t-1}(i) \cdot P(t_j | t_i) \right]}_{\text{The Horizontal Winner}} \cdot \underbrace{P(w_t | t_j)}_{\text{The Vertical Toll}}$$

* $v_{t-1}(i)$: The "Inherited Wealth." This is the best score of a tag in the previous column.
* $P(t_j | t_i)$: The "Grammar Cost." The probability of moving from the previous tag $i$ to the current tag $j$.
* $P(w_t | t_j)$: The "Observation Evidence." How well the current word matches the current tag.

We calculate the product for all $k$ previous tags and only keep the highest number. This number is stored in the trellis cell. It represents the "best case scenario" probability. While we are finding that "Max" number, we also note which tag $i$ produced it. We store that tag's identity in a separate "Backpointer" table. 

Think of 45 different paths all trying to enter the "Verb" state at Word 3.Without Viterbi, you’d have to keep all 45 paths alive. With Viterbi's recursive step, those 45 paths merge into one. Only the strongest path survives. By the time you move to Word 4, you aren't dealing with a history of 45 paths; you are just dealing with one number that represents the best possible history.

If you are asked to calculate the Viterbi value for a cell:
1. Look at the previous column's scores.
2. Multiply each by its specific transition to your current tag.
3. Pick the winner.
4. Multiply that winner by the emission probability of the current word.
5. Write that final number in the cell and record where you came from.

#### Efficiency of Viterbi

The efficiency gains of Viterbi are derived from its modularity and reduction in total calculations needed. 

If there `n` words in a sentence and `k` then for each position we need to calculate `k*n` probabilities, that is `V(n,t)` as each sub-problem's POS tag. However, based on the HMM horizontal assumption, for each tag in the sub-problem, we need consult all `k` previous tags, meaning the complexity becomes `k^2 * n`

If there are 8 positions in a sentence with 10 tags then the number of computations is: $10^2 * 8 = 800$. If we needed to explicity keep track of every sequence ever produced then at the final sub-problem we would need to calculate the 10 tags at position 8 against every sequence from the previous 8 words which would be $10^8$ which is $100,000,000$ calculations at that position alone, not including the previous positions. 

If we start looking at more realistic inputs, for example the 45 penn tags and 15 word sentences then it is impossible for computers to acheive this through brute force, i.e. $45^15$ 

<div style="page-break-after: always;"></div>

# Week 8 - Lab Session

* [Average PoS Tag Ambiguity](#average-pos-tag-ambiguity)
* [Find the Distribution of Tags](#find-the-distribution-of-tags)
* [Simple PoS Ambiguity Measure](#simple-pos-ambiguity-measure)
* [Entrophy as a Measure of Tag Ambiguity](#entrophy-as-a-measure-of-tag-ambiguity)
* [Entrophy Ambiguity](#entrophy-ambiguity)
* [A Simple Unigram Tagger](#a-simple-unigram-tagger)
* [Hidden Markov Model Tagging ](#hidden-markov-model-tagging)
* [HMM Emission and Transition Probabilities](#hmm-emission-and-transition-probabilities)


## Average PoS Tag Ambiguity

Word tag ambiguity occurs due to different ways a word can be applied. Word often have mutliple different meanings and these can vary out into different PoS types. Having a way to measure PoS tag ambiguity can be very helpful. Some words have a colleciton of senses that are all the same, meaning sense ambiguity does not impact tag ambiguity. However, types with a variety of tags are particularly challenging to deal with. 

In this lab we are going to be considering two types of ambiguity: 
- Simple approach that just counts the number of different tags that label a type. 
- A more complex information-theorectic measure based on entropy

The data we are going to use for this lab is from the Wall Street Journal courpus and has been hand-annotated with PoS tags. It is accessed via `nltk` via `from nltk.corpus import treebank` which gives a 10% sample to work with.


The corpus allows with to directly access all tagged words. This is a completely token collection for the entire corpus with the tag given for each individual usage based on its surrounding context. There will be many instances of the same word and it can have serval different tags if appropriate:
```
from nltk.corpus import treebank

taggedWSJ=treebank.tagged_words()

taggedWSJ[0:10]


[('Pierre', 'NNP'),
 ('Vinken', 'NNP'),
 (',', ','),
 ('61', 'CD'),
 ('years', 'NNS'),
 ('old', 'JJ'),
 (',', ','),
 ('will', 'MD'),
 ('join', 'VB'),
 ('the', 'DT')]
 ```

```
 len(taggedWSJ)
 
 100676
```

### Find the Distribution of Tags

Here we are going to build a function `find_tag_distributions(tokentaglist)` which identifies the distribution of tags for every word in the input. It will take a list of pairs `(token, tag)` and return a dictionary of dictionaries whereby the nested dict will be a count of each tag used per word:

```
def find_tag_distributions(tokentaglist,num=-1):
    tag_dists={}
    for i,(token,tag) in enumerate(tokentaglist):
        current=tag_dists.get(token,{})
        current[tag]=current.get(tag,0)+1
        tag_dists[token]=current
        if num > 0 and i>num:
            print("Max number exceeded")
            break
    return tag_dists

distsWSJ=find_tag_distributions(taggedWSJ)
```

```
distsWSJ['the']

{'DT': 4038, 'NNP': 1, 'JJ': 5, 'CD': 1}
```

### Simple PoS Ambiguity Measure

This is function that takes the tagged data with has been converted into dictionaries counts of tag types and counts the number of tags each word has. It words by looping through the dictionary and taking the len of the tag type nested dict. 

```
def simple_pos_ambiguity(tag_dists):
    return {word:len(tag_dist.keys()) for word,tag_dist in tag_dists.items()}

#wsjreader=WSJCorpusReader()
#taggedWSJ=wsjreader.tagged_words()
ambiguity=simple_pos_ambiguity(distsWSJ)
words=['the','white','show']
for word in words:
    print("{}: {}".format(word,ambiguity[word]))
```

### Entrophy as a Measure of Tag Ambiguity

Entrophy is a measure uncertainty. High entropy will occur when there is high, or equally high, number of count accross several tag types. This is uncertain because in terms of raw statistics there is good chance of it being several tags. In this scenario we could not just select for the highest probable tag and assume it will be right most of the time. A low entropy word will be one where there is a clear statistical winner in the distribution. 

This is our mathmatical implementation of entrophy:

$$ H([x_1,\ldots,x_n])= - \sum_{i=1}^nP(x_i)\log_2 P(x_i) $$

- $n$ is the number of PoS tags
- $x_i$ is the number of times the word has been labelled with a particular PoS tag $i$

Below is a function to calculate the entropy for a given word. It takes a list which holds the count occurances of tags. It does not care about the order, it just wants the count. The calculation starts with calculating the probability `p = i/total` and turns it into by multipling the informaiton which weights the probability. The information is the inverse of the probability. If something is very rare it carries a lot of information. The math.log(p, 2) part calculates this "surprisal" in bits. Because $p$ is a fraction (less than 1), the log is a negative number. 

```
def entropy(counts):
    total = sum(counts)
    if not total: return 0
    entropy = 0
    for i in counts:
        p = i/total
        try:
            entropy += p * math.log(p,2)
        except ValueError: pass  
    return -entropy if entropy else entropy
```

``` 
entropy([10,10,10])
1.584962500721156
```

### Entrophy Ambiguity

This function starts to build a measure of ambiguity. It takes the tagged WSJ text list and returns a dicitonary where each word is assigned a measure of entrophy. The `entrophy` function above is simply fed by unpacking nested nest using `dist.values()`:

```
def entropy_ambiguity(tag_dists):
    #tag_dists=find_tag_distributions(tokentaglist)
    ent_ambiguity={key:entropy(dist.values()) for key,dist in tag_dists.items()}
    return ent_ambiguity

#wsjreader=WSJCorpusReader()
#taggedWSJ=wsjreader.tagged_words()

entropydict=entropy_ambiguity(distsWSJ)
words=['white','show','the']
for word in words:
    print("{}: {}".format(word,entropydict.get(word,0)))

white: 0.9182958340544896
show: 1.419556298571613
the: 0.020359443628112334
```

## A Simple Unigram Tagger

A Unigram Tagger is the most simple tool for Part-of-Speech tagging. That is the problem of determining the correct tag for a given word token. In this section we will:
- implement a unigram tagger
- use an off-the-shelf POS tagger which uses information about the previous words or tags in the sequence. 

In order to later test and evaluate a tagger we first need to split it into training and test:

```
def get_train_test_pos(split=0.7):

    taggedWSJ=treebank.tagged_words()
    #we don't want to randomly select data because we need to preserve sequence information
    #so we are just going to take the first part as training and the second as test
    n=int(len(taggedWSJ)*split)
    return taggedWSJ[:n],taggedWSJ[n:]

train, test = get_train_test_pos(split=0.8)
```

The first step is to calculate the tag distributions for each word:

```
unigram_model=find_tag_distributions(train)
unigram_model.get('the',{})

{'DT': 3265, 'NNP': 1, 'JJ': 5, 'CD': 1}
```

The following function builds a unigram part-of-speech tagger `uni_pos_tag()`. It takes two inputs: 
- A list of tokens which represents a sentence
- a unigram model which is stored a dictionary of dictionaries, i.e. the tag distribution for each word. 
The function returns a tagged sequence of tokens, i.e. `(wordtoken1, pos_tag1)`

The functionality is combined over two functions. `best_tag` implements the logic on 1 word and `uni_pos_tag` processes an entire sequence. 

```
def best_tag(word,unimodel):
    dist=unimodel.get(word,{})
    ordered=sorted(list(dist.items()),key=operator.itemgetter(1),reverse=True)
    return ordered[0][0]

def uni_pos_tag(words,unimodel):
    return [(word,best_tag(word,unimodel)) for word in words]
```

``` 
best_tag("show",unigram_model)
`NN`
```

Now we have a functioning tagger we can training it on the training split and evaluate on the test split. A good trick to remember is that you can seperate a list of tuples into two lists: 

``` 
`train_toks,train_tags=zip(*train)`
`test_toks,test_tags=zip(*test)`
```

Below we are implementing the tagger on the training split: 
```
train_toks,train_tags=zip(*train)
uni_pos_tag(train_toks,unigram_model)

[('Pierre', 'NNP'),
 ('Vinken', 'NNP'),
 (',', ','),
 ('61', 'CD'),
 ('years', 'NNS'),
 ('old', 'JJ'),
 (',', ','),
 ('will', 'MD'),
 ('join', 'VB'),
 ('the', 'DT'),
 ('board', 'NN'),
 ...
]

```

In order to produce something to test we just run the tagger on the test set. Remember the `unigram_model` which tolds the dict of frequences was constructed using the training set. Also note the previous function did not build anything to handle OOV words in the test set. 

```
test_toks,test_tags=zip(*test)
uni_pos_tag(test_toks,unigram_model)
```

Also note the previous function did not build anything to handle OOV words in the test set. There are many ways of handling words like these. One strategy is the "Back-off". Here the first call is to check if the word is known from the training set. If it is isnt then we need to assign it a tag in order to allow the model flow through. Back-off assigns the tag value that is most likely to the entire corpus. That is statistically the most common tag in the corpus. It calculates the default tag. 

```
def back_off(unimodel):
    #find which is the most frequent tag assigned to any type
    combined={}
    for adict in unimodel.values():
        for (tag,value) in adict.items():
            combined[tag]=combined.get(tag,0)+value
    ordered=sorted(list(combined.items()),key=operator.itemgetter(1),reverse=True)
    return ordered[0][0]

back_off(unigram_model)
```

The tagging functions can then be updated to allow for a fall back when an unknown word is experienced:

```
def best_tag(word,unimodel,default='N'):
    dist=unimodel.get(word,{default:1})
    ordered=sorted(list(dist.items()),key=operator.itemgetter(1),reverse=True)
    return ordered[0][0]

def uni_pos_tag(words,unimodel):
    default_tag=back_off(unimodel)
    return [(word,best_tag(word,unimodel,default=default_tag)) for word in words]
```

```
test_toks,test_tags=zip(*test)
uni_pos_tag(test_toks,unigram_model)

[('The', 'DT'),
 ('Treasury', 'NNP'),
 ('said', 'VBD'),
 ('0', '-NONE-'),
 ('the', 'DT'),
 ('refunding', 'NN'),
 ('is', 'VBZ'),
 ('contingent', 'NN'),
 ('upon', 'IN'),
 ('congressional', 'JJ'),
 ...
]
```

Now that we have a tagged test list of words we can begin to evaluate. The following function will calculate the accuracy `evaluate_uni_pos_tag` . In order to do this it needs to have access to a goldstandard list of "correct" tags. In our case it is the human tagged sequences from treebank. The evaluation function takes in the `unigram_model` and the `goldstandard` list as arguements. 

```
def evaluate_uni_pos_tag(unigram_model,goldstandard):
    goldtoks,goldtags=zip(*goldstandard)
    pretoks,pretags=zip(*uni_pos_tag(goldtoks,unigram_model))
    print(goldtags[:10])
    print(pretags[:10])
    n=len(pretags)
    correct=0
    for (pre,gold) in zip(pretags,goldtags):
        if pre==gold:
            correct+=1
    return correct/n

evaluate_uni_pos_tag(unigram_model,train)

('NNP', 'NNP', ',', 'CD', 'NNS', 'JJ', ',', 'MD', 'VB', 'DT')
('NNP', 'NNP', ',', 'CD', 'NNS', 'JJ', ',', 'MD', 'VB', 'DT')

0.959709461137323
```

## Hidden Markov Model Tagging 

State of the art POS taggers use information about likely sequences to get higher performance. In this section we are going to experiement with the pre-built HMM from NLTK. 

In order to construct a HMM we need to work with input that are sentences, or at least resemble sentences. This is because the Viterbi Algorithm which will implement our HMM words by trying to find the best sequence of tags by considering the whole sentence as context. Given this we dont want to be working with seqeuences which are to long as this will be bad for efficency but also evaluation as we will have less to test on. 

A very rudimentary way to do this is to split on the fullstops. This is the best but we actually want is a way to split up the input so the HMM doesn't view it as a really long string. So this is good enough

```
def sentence_split(labelledsequence):
    #this is going to do a very rough job - just splitting on '.'
    #due to the tags, we can't rejoin, use the sentence splitter and then re-tokenise
    #we could do a better job than this, but don't really need to
    #we just want to split the input up so that the HMM tagger doesn't view it as one long sequence which it needs to run Viterbi over
    
    sentences=[]
    
    sentence=[]
    for token,tag in labelledsequence:
        sentence.append((token,tag))
        if tag=='.':
            sentences.append(sentence)
            sentence=[]
    return sentences

train_sentences=sentence_split(train)
test_sentences=sentence_split(test)
print("Number of training sentences: {}".format(len(train_sentences)))
print("Number of testing sentences: {}".format(len(test_sentences)))
```

The pre-built library we are going to use is `nltk.tag.hmm`. We want to build a `HiddenMarkovModelTagger` but first we need to build a `HiddenMarkovModelTrainer`. The class has a built in `train_supervised()` method which takes in the split training sentences. It will compute the table of emissions and transistions. This is the pre-calculated look up tables that the Viterbi algo will use for its sub problem structure. The tables represents the training portion as they are constructed according to the evidence in the training data. The calculate parameters are retuned in a `HiddenMarkovModelTagger`. 

```
from nltk.tag import hmm
hmmTrainer = hmm.HiddenMarkovModelTrainer([],[])
hmmTagger =hmmTrainer.train_supervised(train_sentences)
hmmTagger.test(train_sentences)
hmmTagger.test(test_sentences)
```

Note that off the bat the HMM will do a great job at predicting on the training set but poorly on the unseen test set. This is because of the small size of the training sample meaning there are lots of tokens and tag transitions in the test sample that were not seen in the training sample. 

We can improve this by smoothing the probablilty estimates. By default, the `train_supervised` method uses a plain Maximum Likelihood Estimator to convert the observed frequency distributions into probability distributions. We can use a different estimator which will carry out the smoothing for us. Below we use the `LidstoneProbDist` which will "add-gamma" to all of the counts. Gamma is just a small number.  

``` 
from nltk.probability import MLEProbDist,LidstoneProbDist

#this is the default estimator used by HiddenMarkovModelTrainer.trained_supervised
default_estimator = lambda fdist, bins: MLEProbDist(fdist,bins)

#we are going to replace it with this
gamma=1
smoothed_estimator = lambda fdist, bins: LidstoneProbDist(fdist,gamma,bins)
```

```
hmmTagger_smooth =hmmTrainer.train_supervised(train_sentences,estimator=smoothed_estimator)
hmmTagger_smooth.test(train_sentences)
hmmTagger_smooth.test(test_sentences)
```

This change will slightly reduce the train accuracy but increase the test accuracy a lot. It is possible that we can play with the gamma to improve the results. 

However, first we need build our over evaluator as the built in `.test()` only prices accuracy and does not return it for future use. 

```
def evaluate(labelledsequences,tagger=hmmTagger):
    count=0
    correct=0
    for sequence in labelledsequences:
        goldtoks,goldtags=zip(*sequence)
        goldtoks=list(goldtoks)
        #print(goldtoks)
        predictions=tagger.tag(goldtoks)
        predtoks,predtags=zip(*predictions)
        for g,p in zip(goldtags,predtags):
            if g==p:
                correct+=1
            count+=1
    return correct/count
evaluate(test_sentences)
```

Below we are going to by playing with gamma as a hyperparameter. Hyperparameters should be tuned on the trainng set and "tested" on a validation set which can be created by splitting the training set. Ideally, you should conduct a number of runs with different training and validation splits. Once the hyperparameters are tuned you can test from on the training data using the optimal value of gamma, but no changes should take place after this otherwise the tagger is being trained on the test set. 

Below is function to create train and validation (dev) splits on the fly. 

```
def random_split(labelledsequences,ratio=0.8):
    n=len(labelledsequences)
    tr_indices=set(random.sample(range(n),int(n*ratio)))
    test_indices=set(range(n))-tr_indices
    train=[labelledsequences[i] for i in tr_indices]
    dev=[labelledsequences[i] for i in test_indices]
    return train,dev
    
train,dev=random_split(train_sentences)
print(dev[0])
```

Below is a looping implementation of a hyperparameter tuner. A list of gramma values are initalised to test and loop is set up to run through them. The loop is nested because the outer layer allows for `n` number of runs to be constructed and the results to be averaged. 

```
#this will take some time to run

gamma_values=[0,0.001,0.01,0.05,0.1,0.2,0.4,0.5,0.75,1,2]
#gamma_values=[0,1]
number_of_runs=3

train_accs={}
dev_accs={}

for run in range(number_of_runs):
    train,dev=random_split(train_sentences)
    
    for gamma in gamma_values:
        smoothed_estimator = lambda fdist, bins: LidstoneProbDist(fdist,gamma,bins)
        hmmTagger_smooth =hmmTrainer.train_supervised(train,estimator=smoothed_estimator)
        train_acc=evaluate(train,hmmTagger_smooth)
        dev_acc=evaluate(dev,hmmTagger_smooth)
        print("{}: {}: {}".format(gamma,train_acc,dev_acc))
        train_accs[gamma]=train_accs.get(gamma,0)+train_acc/number_of_runs
        dev_accs[gamma]=dev_accs.get(gamma,0)+dev_acc/number_of_runs
        
print(train_accs)
print(dev_accs)
```

The results can then be plotted ot easily understand the best performing values:
```
import pandas as pd
results=[]
for key,value in train_accs.items():
    results.append((key,value,dev_accs.get(key,0)))
accuracy_df=pd.DataFrame(results,columns=['gamma','training_acc','dev_acc'])
accuracy_df.plot(x='gamma')
```

From this you look the best gamma value and then re-run on the whole training set to reconstruct the transition and emission lookup tables

```
gamma=0.01
smoothed_estimator = lambda fdist, bins: LidstoneProbDist(fdist,gamma,bins)
hmmTagger_smooth =hmmTrainer.train_supervised(train_sentences,estimator=smoothed_estimator)
hmmTagger_smooth.test(train_sentences)
hmmTagger_smooth.test(test_sentences)
```

## HMM Emission and Transition Probabilities

Here is the code used to manaully calculate Emissions and Transitions probabilities. 

```
def calculate_emissions(trainlist):
    #trainlist is a list of (word,tag) pairs
    emissions={}
    for word,tag in trainlist:
        current=emissions.get(tag,{})
        current[word]=current.get(word,0)+1
        emissions[tag]=current
    return {tag:{word:value/sum(worddist.values()) for word,value in worddist.items()} 
            for tag,worddist in emissions.items()}
```

```
calculate_emissions(train)
```

```
def calculate_transitions(trainlist):
    transitions={}
    previous="start"
    for _, tag in trainlist:
        current=transitions.get(previous,{})
        current[tag]=current.get(tag,0)+1
        transitions[tag]=current
        previous =tag
    return {previous:{tag:value/sum(tagdist.values()) for tag,value in tagdist.items()} 
            for previous,tagdist in transitions.items()}
```

```
calculate_transitions(train)
```

<div style="page-break-after: always;"></div>

# Week 9 - Named Entity Recognition (NER) and Information Extraction (IE)

This week looks at the tasks of Named Entity Recognition (NER) and Information Extraction (IE). NER requires us to recognise spans of text which refer to real world entities and to determine their type e.g., PERSON, ORGANISATION or PLACE.  Depending on the task, we may also want to be able to link information in the text, where a named entity is mentioned, to information about known real world entities in a database.  When extracting information from text, we also want to be able to extract relationships between real world entities e.g., that PERSON X is the manager of ORGANISATION Y.

NER, and IE more generally, is challenging due to:
* ambiguity: the same string can refer to different real world entities which may even be of different types (e.g., JFK can refer to a person or an airport). 
* variation: the same real world entity can be referred to in many different ways (e.g., John F. Kennedy, JFK, J.F.K. etc.)

We will see how NER can be viewed as a sequence labelling problem which makes it possible to borrow techniques and methodology from POS tagging.  However, due to the richness of the feature space available in NER, we move away from generative models (which require features to be independent) to discriminative models (which do not require features to be independent).

1. [Lecture Notes](#week-9---lecture-notes)
2. [Lab Session](#week-9---lab-session)

<div style="page-break-after: always;"></div>

# Week 9 - Lecture Notes

* [Information Extraction](#information-extraction)
* [Chunking](#chunking)
* [Named Entity Recognition](#named-entity-recognition)
* [Co-reference Resolution](#co-reference-resolution)
* [Entity Linking](#entity-linking)
* [Relation Extraction](#relation-extraction)

## Information Extraction

This is the proccess of turning unstructed informaiton founds in text into structured information that may be stored and access from a database. For example, a given text text extract "Mrs May spoke to Spanish Prime Minister Pedro Sanchez on Wednesday evening", the information to be extracted is {Country:Spain, Role: Prime Minister, Person: Pedro Sanchez}. All of this information is explicity in this sentence but in future sentences something might just say "The Spanish Prime Minister", from this the database can be consulted and the model will have access to knowing that the person not explicity names is Pedro Sanchez. 

There are number of different applications for Information Extraction

**Text Chunking**: A simplified form of parsing that groups tokens into syntactically correlated phrases, like Noun Phrases (NPs) and Verb Phrases (VPs).

**Named Entity Recognition (NER)**: finds and classifies strings of tokens that mention named entities. 

**Coreference Resolution**: Linking different mentions in a document that refer to the same entity (e.g., linking "Lorenzo Pellegrini" to "he")

**Entity Linking**: Associating a mention with a specific entry in a knowledge base like Wikipedia.

**Relation Recognition**: Finding and classifying relationships between entities (e.g., "Jose Mourinho" is the "boss-of" "Manchester United").

**Event Recognition**: finds and classifes events and the entities in roles associated with the event

## Chunking

Syntactic chunking is the task of grouping tokens into syntactically correlated phrases (chunks). Usually the goal is to distinguish between noun phrases (NPs) or verb phrases (VPs). Generally, you can replace NP with another NP and grammatically, the sentence will still make sense. 

While Parsing determines the complete hierarchical structure of a sentence, Chunking is easier, more efficient, and more robust. Parsing can be presented as a tree of the syntatic structure and indentifies how phrases combine to make other words. Chunking maintained the structure of a full sentences but segments it down into its parts. It is easier, more efficent and robust to unexpected input. In terms of detail, is it seen as the good enough approach. 

IOB labels are the tools used to indicidate chunk boundaries. It is much like PoS tagging but insteads instead labels a sequence. It can be acheived using the same process such as Hidden Markov Models:
* B-NP: Beginning of a Noun Phrase.
* I-NP: Inside a Noun Phrase.
* B-VP: Beginning of Verb Prase
* O: Outside any chunk

$$ Raw Text > Tokeniser > Token Seqeuence > HMM POS Labeller > PoS Sequence > HMM IOB Labeller > IOB Sequence $$

IOB labeling happens after PoS tagging and essentially treats the PoS tags as its primary input. The logic is that syntactic patterns (like Noun Phrases) are much easier to see in PoS tags than in raw words. There are millions of English words. It's hard for a model to learn that "The shiny new bicycle" is a chunk just by looking at the specific words. It is much easier for the model to learn a rule like: DET + ADJ + ADJ + N usually equals one NP (Noun Phrase). 



## Named Entity Recognition

NER is the detection and classification of named entities in a text. A names entity is anything which can be refered to with a proper noun, e.g. Boris Johnson, England, Facebook, Uni of Sussex, Bright and Hove Albion.

While basic Chunking relies heavily on PoS tags, in Named Entity Recognition (NER), we often use a "richer" set of features. For NER, the model might look at the PoS tags AND the original words (Word identity), as well as things like capitalization. 

Named entities are chunks of tokens, usually. The individual words within the sequence may be tagged as "Proper Nouns". These words may be capitalised. The full sequence may have been recognised as Noun Phrase (NP). 

The type/class of the Named Entity make vary accross domains. Common classed include: People (PER), Organization (ORG), Location (LOC), Geo-Political Entity (GPE), Facility (FAC), Vehcicles (VEH). But the list is almost infinite as there will be nouns for any topic you can think of. 

One of the issues with entities is variation, a person may be refered to is several different way. Dr Jeff Mitchell, Dr Mitchcell, Dr J Mitched etc. Variants often follow orthographic riles but sometimes may be completely different: Manchester United, Man Utd, United, Red Devils. These variants make named entity linking difficult. It usually requires a knowledge source compliling known named entities. 

Ambiguity too poises an issue for naming entitys when the same name, word or phrase refers to different things. For example, there are multiple Manchesters in the world (LOC) and people often has the same name "John Smith". This makes both type classification and named entity linking difficult. 

NER is gernally seen as a sequence labelling task. The detection and classification steps are usually carried out simultaneously. Each token in a sequence/sentnece is tagged with the named entity type associated with it. This means NER can be performed the same way as POS tagging.

Typically, we want to find chunks of consecutive tags that make up an NER. Not just it seperate tags. This is where IOB encoding comes in, we wish to tag the Inside, Outside and Beginning of a NER phrase. Not all NER systems use this technology but it is useful to avoid possible ambiguity between tokens. 

The main features for NER are order identity, tag sequence, capitalization, POS tags and chunks. These features can then be placed into a classifer to identify the NER tag. 

For POS tagging we used Hidden Markov Models. This method worked on a strict assumption of independence, an observation (a word) only depends on the current state (the tag). With Vertical Efficiency, the HMM assumes that features don't interact with each other or with previous/future words in complex ways. 

This assumption poses an issue for NER recognition and the construction of feature sets. Identifying a name like the company "Apple" requires looking at many clues simultaneously: Is it capitalized? Is the previous word "at"? Is it tagged as a Proper Noun? These features are rich and overlapping. For example, "Capitalization" and "PoS=Proper Noun" are highly correlated; they aren't independent. Using these features in an HMM violates the model's fundamental math (the independence assumptions).

The sequencing models for NERs tend ot be variants/extensions of HMMs with less stricture feature independence assumptions.
* Maximum Entropy Markov Models (MEMMs): These allow the model to look at multiple features (capitalization, PoS, etc.) for the current word more flexibly than an HMM.
* Conditional Random Fields (CRFs): These go a step further by removing the "directionality" of HMMs, allowing every tag in the sequence to influence every other tag more globally.
* Neural Networks: Modern systems use deep learning to learn these complex feature relationships automatically.

If an exam asks "Why is an HMM not ideal for NER?", your answer should be:

"NER requires a rich set of overlapping features (like capitalization, word identity, and context windows) that violate the strict feature independence assumptions of a standard HMM."

## Co-reference Resolution

Co-reference Resolution is the task of identifying which different mentions in a document refer to the same real-world entity. While NER identifies that a word is a "Person," Co-reference Resolution connects that person to every other time they are mentioned in the text, even if they are referred to by a different name or a pronoun. The goal is to link all mentions that "co-refer" to the same thing.

In the sentence "Lorenzo Pellegrini's agent shuts down Manchester United links... his agent says," Co-reference resolution links the word "his" back to "Lorenzo Pellegrini".It allows the computer to understand that "his," "Pellegrini," "The 22-year-old Italy international," and "Lorenzo Pellegrini" are all the same person.

Like most other Information Extraction tasks we have the issue of variability and ambiguity again. 
* Variation: The same entity is called many different things (e.g., "Manchester United," "Man Utd," "The Red Devils").
* Ambiguity: A pronoun like "it" could refer to many different objects mentioned earlier in the paragraph.

Think of Co-reference resolution as the "Glue" of Information Extraction:
1. NER finds the entities in isolation.
2. Co-reference Resolution clusters them together within a document so you don't think "Pellegrini" and "him" are two different people.
3. Entity Linking (the next step) then takes that cluster and connects it to a single Knowledge Base entry, like a Wikipedia page.

## Entity Linking

After establishing NERs and their referencing clusters we need to identify which real world entity they refer to. The challenges will ambiguit and variation. Simply identifying the different names that someone goes by isn't enough because those names can be shared among other people

The formulation of the Named Entity linking problem goes as follows where a problem instance consists of:
* A knowledge base (KB) such as Wikipedia.
* A entity mention in a text with surrounding context. 

The goal will be to return a KB canonical entry of the entity being mention (nor NIL if the enity does not have a KB entry). In the context of Entity Linking, a canonical entry is the unique, standardized "official" record of an entity in a Knowledge Base (KB). Since the same person or thing can be referred to by many different names (variation), the system needs one single point of reference to represent that entity in a structured database. If you are using Wikipedia as your Knowledge Base, the title of the Wikipedia page is typically considered the canonical way of naming that entity. A problem instance of Entity Linking is considered successful when the system takes a mention from a text and returns the correct canonical entry from the KB. If the entity does not exist in the KB, the system should return "NIL".

The technique for entity linking is 2 step proccess:
1. Find candidates in the KB for given entity mention
2. Rank candidates to find the most probable

Generating candidates is a trade of between precision and recall. We need high recall to assure that the right entity is among the candidates. But too many candidates hurts precision and efficent. 

Strategies for generating the correct candidates include: 
* Exact Matching: Finding a mention that is an identical match with the title of a Wikipedia page (e.g., "Bill Clinton").
* Substring Matching: Identifying if a mention is a part of a Wikipedia page title or vice-versa (e.g., "Clinton" or "Mr Bill Clinton").
* Acronym Matching: Linking a mention that is an acronym of a page title (e.g., "B.C." or "UoS" for University of Sussex).
* Known Aliases: Using information extracted from redirects and disambiguation pages to find alternative names (e.g., "William Clinton").
* String Similarity: Using measures like Levenshtein Distance (Minimum Edit Distance) to find page titles that are spelled similarly to the mention.

String similarity (specifically measures like Levenshtein Distance) is primarily used to catch variations in spelling, typos, and slight orthographic differences. This measures the number of insertions, deletions, and substitutions needed to turn one string into another. While great for spelling, string similarity is bad at identifying aliases that look nothing like the original name. Using string similarity is a "High Recall" strategy: It ensures you don't miss "Clinten" but if you set the "similarity" threshold too low, you might accidentally link "Bill Clinton" to "Bill Clintons" (a different entity) or "Hillary Clinton" because they are spelled similarly. 

Once you have the candidates you need to rank them. There 3 main approaches to gathing features:
- **Co-occurence** of entity mentions. If another version of the names entity is found in the same documents.
- **Local Context** of a mention. This is taking into account the context of the neighbouring words. 
- **Global Context** of an entity mention. This looks at the entity mention in term of the whole document. It takes a Bag-of-Word apporach. 

Then the stategies for ranking include:
* Entity Relatedness: The system asks if other entities mentioned in the text (e.g., "Pedro Sánchez") typically link to similar or related Knowledge Base pages (e.g., "Spain").
* Query Relevance: The system checks if the candidate's Knowledge Base page contains tokens that match the local context of the mention in the text.
* Document Similarity: The system performs a bag-of-words comparison to see if the candidate's Knowledge Base page has a high similarity to the global context of the document.

This ranking process can be treated as a Disambiguation problem, similar to Word Sense Disambiguation (WSD). The candidates produced each time a string for a named entity is seen are the same. Each candiate is a possible sense of the named entity mention. You can train a supervised ML classifier (like Naive Bayes) using an annotated corpus. The classifier uses vectors representing the local context, global context, and co-occurring entities to make the final ranking decision. 

## Relation Extraction

Relation Extraction is the final stage of the Information Extraction pipeline. It focuses on discovering and classifying binary relationships between the named entities you have already detected and linked. Relation extraction turns a sentence into a structured "triple" consisting of two entities and the relationship between them. Most systems focus on binary relations (pairs), which are considered fundamental to the meaning of the text. From the text "Jose Mourinho boss of Manchester United," the system extracts: `{Entity 1: Jose Mourinho, Relationship: boss-of, Entity 2: Manchester United}`

ust like Named Entities (PER, ORG), relationships can be organized into classes with different levels of detail: Specific: "star-of" or "plays-for". General: "works-for" or "is-associated-with".

A standard machine learning approach to solving this:
- Find a pair of entities ($e_1, e_2$) that appear together and decide if any relationship is being asserted between them.
- If a relationship exists, determine which specific type it is (e.g., is it "boss-of" or "works-for"?).

To train a classifer, such as Naive Bayes, you need a feature representation which captures potential relationships between paired entities: 
* Entity Types: Knowing if the entities are (PER, ORG) vs (LOC, LOC) helps predict the relation.
* Distance: How many words or other entities sit between the two targets?.
* Contextual "Bags": The words and tags separating the entities (local context) or surrounding them (global context).

Note, that while Naive Bayes is common, its strict independence assumptions are often violated. If the goal is accurate probability estimates, other models might be better:
* Logistic Regression (Maximum Entropy classifiers).
* Advanced Models: These are discussed further in more advanced modules.

<div style="page-break-after: always;"></div>

# Week 9 - Lab Session

