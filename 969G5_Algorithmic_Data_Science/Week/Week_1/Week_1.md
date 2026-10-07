**| [Canvas Page](https://canvas.sussex.ac.uk/courses/39278) |** [Video Lecture](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=f10339e7-66b3-48ac-8c48-b4d700c73e6f) |

This week we will be looking at some of the standard data structures which can be used in the formulation and decomposition of big data. We will consider these data structures at both the interface and implementation level, comparing them in terms of their impact on space and time complexity and their suitability to different types of data or tasks. We will also relate them to different standard data formats for data storage.

---
#### Learning Outcomes
- Be familiar with fixed size arrays, lists, dictionaries, hash tables and binary search trees.
- Be able to manipulate lists and dictionaries in Python, and time operations.
---
#### Background Reading
[Cormen et al](https://readinglists.sussex.ac.uk/leganto/public/44SUS_INST/citation/27057570290002461?auth=SAML):
- Chapter 10 (Elementary data structures)
- Chapter 11 (Hash tables)
- Chapter 12 (Binary Search trees)
---
#### Lecture
An algorithm is a  method, a recipe or a set of steps for doing something. It is more than an interface which specifies functionality or mappings from inputs to output.

Consider the problem of long division. An interface would specify the required inputs and outputs i.e., the mathematical function, but not how to achieve the output in practice.

Why do we need to consider algorithms carefully in data science? We want to process large volumes of data as quickly and cheaply as possible.

##### Data Types
Programming languages typically support a number of atomic data types: integer, floating point number, string, character, boolean. 

##### Data Structures
A data structure is a collection of data items stored in memory plus a number of **operations** for manipulating that collection

Specifies how the data is organised (at least conceptually) and how it should be accessed

##### Static Arrays
The array is probably the most fundamental of data structures. It is fixed in terms of type that the elements can be and the number of elements (length) that can be stored. The elements are accessed from the structure using indices. In Python arrays are used via Numpy arrays and tuples. 

##### Linked Lists
These are dynamic as they can can and change over time. The individual elements to not have points or indices stored, instead, a link or pointer is stored on the current elements to access the next. This perfect for sequential data. 

LL's are easy to add/append new items, as well as, combine two lists. However, they are very expensive to concatenate an $i$-th item as you have to traverse the list until you reach the desired item. At worst, this requires you to loop through every item until the end which is a complexity of $O(n)$. 






---
#### Lab




---


