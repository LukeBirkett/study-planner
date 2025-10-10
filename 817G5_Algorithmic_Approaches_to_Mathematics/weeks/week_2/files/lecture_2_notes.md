# Week 2 Notes - Programming

# Julia

Using for julia 

using LinearAlgebra 

this is julias numpy

Julia is one indexed, starts at 1 

example[1]
example[1:10]

Julias package managment is pkg

#### just-in-time

Julia is a just-in-time language 

looks like interpeted but works like a compiled

JIT is it often better to write the algos yourself

if you give the complier lots of extra info it runs better

i.e. denoted the type of input and output

#### pre-allocate

a really good practise in programming is to pre-allocate size

e.g. setting up an empty list = [] and filling it up isn't ideal

if you can it is best to set up an empty array or matrix

and specifiy the type if possible 

#### pass by reference

arrays are passed by referece

if you assign en existing array to a new var then any edits change all instance of an array

an array is a specific block of memeory

the var names are just shortcuts

note this specifically for arrays, not all types

the general reasoning is because they are mutable

#### pass by value

to create a new array you need to copy

this is known as pass by value

arr2 = copy.deepcopy(arr1)

integers are immutable hence are passed using pass by value (not reference)


#### type annotation types

def mutli(a: int, b: int) -> int:

labelling the inputs and output types as integrar

in python, labelling is just useful to help with errors 

for complied it makes the code much more efficent

avoids real time conversions

helps complier pre-allocate memory


