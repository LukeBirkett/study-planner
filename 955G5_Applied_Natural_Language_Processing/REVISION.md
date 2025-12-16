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

## Code Snippets

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







