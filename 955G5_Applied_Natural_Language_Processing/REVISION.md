# Revision File

This is the markdown file that will hold all of the resources used to revise and prepare for the exam. It will include notes of each weeks lecture, a breakdown of import code & concepts from the labs and possibly notes from any additional reading. 

## Contents
* [Week 1 Intro to ANLP and Python](#week-1---intro-to-anlp-and-python)

---

# Week 1 - Intro to ANLP and Python

Largely an intro class to the module. Light on content that will directly applied in the exam. More preliminary and base content. 

**Atomic Data Types**: int, float, cool, str

**Data Structures**: Lists, Tuples, Sets, Dicts

**Lists**: ordered, indexable, variable length, store sequences (words, sentences), iterable

**Tuples**: ordered, indexable, fixed length, often pairs/triples, iterable

**Sets**: unordered collections, no index, each item is unique, can be iterated but no order

**Dicts**: map keys to values, unordered, lookup via hash

**Functions**: apply code again, call on some arguments, return a value

## Lab Session

`NLE2023_lab_1_1_SOLUTIONS.ipynb`
`NLE2023_lab_1_2_SOLUTIONS.ipynb`
`NLE2023_lab_1_3_SOLUTIONS.ipynb`

The lab for this week was generally an intro session for people unfamilar with python. I am already familiar with Python so I won't do a full breakdown of the code in this section, where as for the notes on later weeks I will. However, when doing the assignment exam it will be important to reference these lab files to ensure good practice has been implemented in the code. There also may be some good tricks layed out in these notebooks. 

Below are some code snippets, functions and attributes taken from the notebook that tend to be things that slip out of my mind sometimes. 

`.split()`

`.isalpha()`

`.isalnum()`

`.isdigit()`

`.get("Key","Key does not exist value")`

`vocab[word]=vocab.get(word,0)+1`

`.keys()`

`.values()`

`for person,age in simpsons_ages.items():`

`for i in range(0,10,2):`

`word_positions = zip(words, indices)`

`for a,b in enumerate(['The','Holy','Grail']):` replaces `zip` and `range`

`list.append(something)`

```
natural_numbers = range(5)
squared_numbers = map(square, natural_numbers)
for i in squared_numbers:
    print (i)
``` 
The map function takes a **function** and an **iterable** (e.g. a list) as arguments. It then applies the function to every item of the iterable, returning a list of the results.

`[x**2 for x in range (4)]`

`[square(n) for n in range(15) if is_even(n)]`







