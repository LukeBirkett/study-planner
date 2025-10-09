# intro to doc retrieval 

i.e. google search 

find all relevant documents given a query o keywork 

humans easily break down a corpus of text into docs, paras, sent, words etc

computer just see a sequence of chars

stop words are high freq words that don't carry much information

removing these is a type of text normalisation

other types of normalisation: cases, numbers, puncuation


# segmentation and tokenization

there is no stardard structure of a corpus

might be a succesion of files, a sequeunce, a csv etc 

important to understand the format but a straightforward task to process usually

Pythons Natural Language Toolkit (NLTK) is from 2006 (Kiss and Strunk, 2006)

nltk.tokensize

sent_tokenize(x)

# tokenization

task of segmenting text into "words"

tokens could be more than just words

punctuation, numbers

tokens are generally delmited by whitespace but can sometimes include whitespace

sometimes punct can be the delimiter, i.e. i'm = i am

python has a .split() function that breaks ddown text into a list of words but it is very basic and doesn't cover punct etc

nltk.tokenzie

word_tokenize()

based on regex 

regex not tested on this course

# how many words are there?

# what is a word

types are distinct words in a corpus

tokens are the total number of running words

the larger the corpa the more words we find

# normalisation

helps us reduce a corpus' variation
