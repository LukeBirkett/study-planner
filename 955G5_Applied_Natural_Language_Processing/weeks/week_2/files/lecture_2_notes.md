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

#### case normalisation

lower vs upper often considered as irrelevant

normalisation allows us to reduce word count (type)

downside is there is some examples where it is useful

i.e. name Mark vs mark

in python can chain .lower().split()

# number normalisation

how many numebrs are there? lots

particulary in terms of types and unique numbers in a corpus

often just replace any number with "num"

# stopword removal 

most freq words in english tend to be non-content brearing function words

the, of, and, a  in, to, it, is, was, to

often don't tell us about what happened but my hold content of some type

significantly lowers tokens

dont away throw stopwords, depends on use case

stopwords generally removed for doc retrieval

# stemming and lemmenisation

morhology is the study of the way words are made up of smaller parts

i.e. cat(s)

if we want cats, we probaly just need cat

ed, ing, un are example of other prefix and suffixes

morphemes are the smallest meaningful unit of a word

words have a root/stem that we affixes other information too 

in english we have inflectional morphology

number, sing vs plur
gender
tense
person, 1st 2nd 3rd
case, mark vs mark's

stemming is removing unwanted affixes

NLTK Porter Stemmer 

nltk.stem.porter imort PorterStemmer

relational > relat
relate > relat

note, this can easily make mistakes

organization > organ

this is rule based, not lexicon derived

#### lemmenatistion 

trys to be a bit smarts

looks for dictionary words

tends to have less impact then the stemmer 

works by trying stemming and comparing to dictionary 


