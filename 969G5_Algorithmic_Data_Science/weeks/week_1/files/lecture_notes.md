# What is an algorithim?
- An algo is a recipe
- A prescise set of steps
- Well defined
- Input/Output

We want a process a large volume of information **quickly** and **cheaply**

# Data Structures and Data Formats

The atomitic data types. This means they cannot be broken down any further or interpreted at a smaller granularity: int, float, string, char

A data structure is a collection of data types stored in memory plus an operations for maniulating the data

Specififies how the data is organised and how to access

## Arrays
- Fixed length and width in memory
- Data is access through positions

## Linked List
- Dynamic in size and can grow
- Adds points to each data piece. The pointer says where in memory the next point of the linked list is
- Sequential, easy to add/append
- Expensive to access the ith link as you have to go through all links to find the pointer to the location

## Dictionaryies 
- Key, value step up
- Not sequential, have no order
- Can acess any data point using the key

## Hash Tables
- Store elemets with a key in slot h(k) where k is a function (hash function) which maps the key to a value
- Compute hash function to find memory
- A hash collision may occur is the function inputs and outputs are not one-to-one and 2 inputs create the same output (rare)
- A good function assumes uniform distribution whereby any output has equal probablity
- Keys are interpretted as ASCII chars which can be turned into single numbers. This is memory efficent approach
