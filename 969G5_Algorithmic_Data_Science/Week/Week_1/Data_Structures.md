**| [Canvas Page](https://canvas.sussex.ac.uk/courses/39278) |** [Video Lecture](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=f10339e7-66b3-48ac-8c48-b4d700c73e6f) |

This week we will be looking at some of the standard data structures which can be used in the formulation and decomposition of big data. We will consider these data structures at both the interface and implementation level, comparing them in terms of their impact on space and time complexity and their suitability to different types of data or tasks. We will also relate them to different standard data formats for data storage.

---
#### Learning Outcomes
- Be familiar with fixed size arrays, lists, dictionaries, hash tables and binary search trees.
- Be able to manipulate lists and dictionaries in Python, and time operations.
---
#### Background Reading
[Cormen et al](https://readinglists.sussex.ac.uk/leganto/public/44SUS_INST/citation/27057570290002461?auth=SAML) [Internet](https://www.cs.mcgill.ca/~akroit/math/compsci/Cormen%20Introduction%20to%20Algorithms.pdf):
- Chapter 10 (Elementary data structures)
- Chapter 11 (Hash tables)
- Chapter 12 (Binary Search trees)
---
#### [Lecture](Files/lecture1.pdf)
An algorithm is a  method, a recipe or a set of steps for doing something. It is more than an interface which specifies functionality or mappings from inputs to output.

Consider the problem of long division. An interface would specify the required inputs and outputs i.e., the mathematical function, but not how to achieve the output in practice.

Why do we need to consider algorithms carefully in data science? We want to process large volumes of data as quickly and cheaply as possible.

1. [Data Types](#1-data-types) 
2. [Data Structures](#2-data-structures) 
3. [Static Arrays](#3-static-arrays) 
4. [Linked Lists](#4-linked-lists) 
5. [Python Lists](#5-python-lists) 
6. [Maps / Dictionaries](#6-maps--dictionaries) 
7. [Hash Tables](#7-hash-tables) 
8. [Collisions](#8-collisions) 
9. [Hash Functions](#9-hash-functions) 
10. [Collision Resolution](#10-collision-resolution) 
11. [Binary Search Trees (BST)](#11-binary-search-trees-bst)

---
##### 1. Data Types
Programming languages typically support a number of atomic data types: integer, floating point number, string, character, boolean. 

---
##### 2. Data Structures
A data structure is a collection of data items stored in memory plus a number of **operations** for manipulating that collection

Specifies how the data is organised (at least conceptually) and how it should be accessed

---
##### 3. Static Arrays
The array is probably the most fundamental of data structures. It is fixed in terms of type that the elements can be and the number of elements (length) that can be stored. The elements are accessed from the structure using indices. In Python arrays are used via Numpy arrays and tuples. 

---
##### 4. Linked Lists
These are dynamic as they can can and change over time. The individual elements to not have points or indices stored, instead, a link or pointer is stored on the current elements to access the next. This perfect for sequential data.

LL's are easy to add/append new items, as well as, combine two lists. The academic default of adding to an LL pertains to adding at the head, making the procedure $O(1)$.

However, they are very expensive to concatenate as this entails connecting tail to head. The tail is the $i$-th item meaning you have to traverse the list until you reach the desired item. At worst, this requires you to loop through every item until the end which is a complexity of $O(n)$. 

An array is pre-allocated in memory, all the memory has to be together and contiguous. LL's do not allocate any memory. If you add a new entry, it finds a new slot of memory somewhere on the heap. This is important for times when the memory if fragmented (used up). An LL can just find suitable unused memory but the array will need to search hard for an appropriately size section. 

An LL could be doubly linked with a pointer to the next and previous. An LL could also be circular with the latest entry pointing the start. In a circular list, the pre pointer of the head of the list points to the tail, and the next pointer of the tail of the list points to the head. 

For clarity, the "head" is actually the first element not the last. It is the entry to the list. If L_head is empty then the list is empty. Tail is the last entry. 

---
###### 5.  Python Lists
Under the hood, Python lists are implemented in `C` and therefore the underlying representing is an array of fixed size. Semantically, its usage is variable length but this is because the `C` level array is over-allocated and the allocation can be dynamically relocated if the fixed length is exceeded.

Because of this, Python lists are efficient with fixed cost random access via indices meaning the time to access  $i$-th element is independent of the length of the list `n`, resulting in $O(1)$. 

---
###### 6. Maps/Dictionaries
These are non-sequential data structures. Conceptually, a map or dictionary is a collection of (key-> value) pairs. The values can be anything, e.g. objects, lists, other dictionaries etc. The key is a reference. 

---
###### 7. Hash Tables
Hash tables are the underlying data structure for Python dictionaries. They store the element with key $k$ at slot $h(k)$ where h is a hash function which maps $k$ to a number in the range ${0,...,n-1}.$ e.g. `h(k) = letter_sum(k) mod n`. Basically, we want the key to produce a number which we will use to access the memory stack like we do with an indicies and arrays. 

At its core in hardware memory, a hash table is built on a contiguous block of memory—an **array**—and the hash function provides the numerical address calculation. The nuance comes in the values that the function produces. It outputs an integer across a massive range (often 32-bit or 64-bit integers), significantly larger than array memory allocation so the hash value is compressed to fit the current size of the table using the modulo operator
$$\text{Index} = \text{hash}(\text{key}) \pmod{\text{array\_length}}$$
Because array lookups in computer memory take $O(1)$ time—simply `base_memory_address + (index * element_size)`—jumping straight to the computed index gives the hash table its near-instant speed.

###### 8. Collisions
A hash collision occurs when 2 (or more) keys map to the same slot (index). The first step to avoiding this is to have a good hash function, or "resolve" collisions using techniques like chaining or open-addressing

---
###### 9. Hash Functions
A good hash function satisfies the assumption of simple uniform hashing: each key is equally likely to hash to any of the $n$ slots. The goal is to intpret the keys as as natural numbers to be used as indices. Typically, functions integrate modular division to obtain the exact slot. 

Choosing $n$ as a **prime number not too close to a power of 2** protects the hash table from real-world data patterns and bad hash distributions. Composite numbers run the risk of clashes: Suppose your table size is $n = 12$ (factors: 2, 3, 4, 6), and your input keys happen to be multiples of 4 (e.g., memory addresses or timestamps like 4, 8, 12, 16, 20...):
- $4 \pmod{12} = 4$
- $8 \pmod{12} = 8$
- $12 \pmod{12} = 0$
- $16 \pmod{12} = 4$
- $20 \pmod{12} = 8$
All keys cram into only 3 slots ($0, 4, 8$), leaving the other 9 slots completely empty. Collisions skyrocket, and lookup times degrade toward $O(k)$

Essentially, the main goal is to avoid composite numbers, even numbers and power of 2 (or close). This is because the numbers is produce lack variability, particularly in binary code. If your keys are mostly even numbers (2, 4, 6, 8...), an even number in binary **always ends in `0`**. Similarly, if you took Base-2 - ($2 = 2^1 = 10_2$, $4 = 2^2 = 100_2$, $8 = 2^3 = 1000_2$, $16 = 2^4 = 10000_2$) the only variability in the binary is the start entry followed by zero. Essentially, for the allocation, all the bits are being thrown away increasing the risks of collisions. 

Conversely, 7 does not align with the binary digit boundaries, division by 7 **forces every single bit across the entire number to participate** in calculating the remainder, scattering the items across slots 6, 0, 1, and 2.

---
###### 10. Collision Resolution
**Chaining** resolves collisions by putting all elements that hash to the same slot in a linked list. **Open addressing** successively probes the hash table until a match or an empty slot is found.

They are **two fundamentally different approaches** to handling collisions. The core difference is _where_ collided items are placed: **chaining** stores them outside the main array, while **open addressing** keeps everything inside the array.

**A. Separate Chaining:**
Each slot in the array points to an independent data structure (usually a linked list, dynamic array, or balanced tree). On collision, if two keys map to index `4`, both keys are simply appended to the list at index `4`. The table can hold more elements than there are slots ($load\ factor > 1$). It never truly "runs out of space," though lookups slow down if chains get long. The complexity is $O(k)$ where $k$ is the list length. The initial hash lookup preserves **average $O(1)$ lookup performance**

**B. Open addressing**
Open addressing stores key-value pairs directly in the array without secondary lists. Collisions are resolved by probing for empty slots. Capacity cannot exceed array size, requiring dynamic resizing around 60–70% full. It improves CPU cache performance by avoiding pointers, but needs tombstones and careful collision handling for deletions.

The Hash function takes the probe number as second input. e.g.
- Linear probing: $h(k,i)= (h_{1}(k) + i) \bmod n$
- Double hashing: $h(k, i) = (h_{1}(k) + i * h_{2}(k)) \bmod n$

---
###### 11. Binary Search Trees

Alternative dictionary implementation that avoids hash functions and pre-reserved memory blocks.

**Structure & Mechanics:**
- **Node Components:** Each node contains a key, a value, and two pointers (left and right) pointing to other memory locations.
- **Dynamic Memory:** Allocates spare memory dynamically as needed rather than using a fixed block.
- **Navigation Rules:** Pointers are followed based on a comparison rule (e.g., alphabetical or numerical order).
- **Data Distribution Risk:** Rules must suit the data distribution. A poor starting point or rule can create excess layers, turning the tree into a linked list in the worst case.

**Search & Complexity:**
- **Traversal:** Finding items requires traversing the tree from the root.
- **Logarithmic Complexity:** Search complexity is $O(\log_2(n))$ because each left/right choice discards half of the remaining data.
- **Growth:** Number of data items grows exponentially with the number of layers.

**BST vs. Hash Tables:**
- **Sorting:** BSTs provide implicit sorting benefits without needing to loop through all data (unlike hash tables).
- **Flexibility:** BSTs are agnostic to data types and handle unknown data sizes well.
- **Performance:** Hash tables are faster for random access from a known pool of keys because hash lookups are independent of dictionary size.

---
#### Lab
Introduction into creating functions and timing them. Timing is important to measure complexity. Finally, we plotted the average time taken for and found that .append runs faster than list concatenation. This makes sense because in python the underlying data structure for a list is much large than the data we are working with, generally. Therefore, when we add (append) a new item, we are just adding to next available slot. Conversely, list concatenation allocates in memory two seperate data structure arrays which when added require merging together and creating a new object. There is no modification. 

---


