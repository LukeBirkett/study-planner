# Linear Algebra

the lecture will cover the basics (the bare min)

3B provides a deeper understanding

Cheatsheet gives a little more information

+ the notebooks

complicated objs often boil down to arrays or matrices

data can be moulded into a shape: vector/matrix

this structure can be manipluated and changed

transformed

vectorized 

vector/matrices have a shape

vector = 1d array, 1 index, [n], row or col
matrix = 2d array, 2 indices, [n,m], rows and cols
tensor = 3d array, 3 indiex, [n,m,l], the 3rd dimension is a layer

# WEEK 3

#### Dot Product

similar to mutliplication but the output is just a number (Sclar)

2 vectors, flip one into a row and multiply each peicewise and take the product (sum)

written as: a^T x 

a transposed vector is a row

#### Matric Mutliplcation

Split the left into rows

Split the right into cols

Apply dot products between rows and cols

The length of rows and cols must match otherwise MM cannot be done

output is the left side nunber of rows and right side number of columns

A[n,m] B[j,k]

Output[n,k]

If MM by vector the rows of the matrix are retained with just 1 col

ALTERNATIVE WAY:
Scalar each component of the vector by each row of the matrix

this way doesn't allow us to pre-calc the size of the output

this way is easier to think from a geoemtry perspective

each element of the vector scales its inputs

they stay on the same line/course but stretced

MM is a geometric transformation

#### tranposing matrices

transposing matricies can make it easier to approach a problem sometimes

(Av)^T = v^T A^T

If you both you need to swap the order

This is a hard rule for any linear algebra

order is very important for matrices, unlike numbers

this is called non-commutativty

#### identity matrix

always square

has 1's on the diagonal 

top left to bottom right

known as the mutliplicative identity 

it proves the same function of 1 in numbers

indentify keeps the matrix the same

order doesnt matter for the identify, will have the same effect if it is oon the left or right of the calc AI or IA

#### inverse functions

g * f(x)

apply f func and then g

matrces sometimes have inverses

only square matrices will have invereses

AA^-1 = A^-1 A = I

AA^-1 x = x

inverse matrix turns it into the identity

a number example is 1/4(4x) = 1x = 1

there is a formula for calculating the inverse but julia and python will calc for you and that all we need for this module

the inverse helps you solve linear equations and constrained problems

inverse * the result = the contraints

if you set the output to [0,0] you can verify ifan inverse exists through proof by contradiction

#### types of transformations

scaling: the input vector is just stretched

here the vector is considered an eigen of the matrix because it doesnt change its path

eigenvectors of a matrix are those that dont rotate under a transformation

the matrix doesn't stretch all vectors, just a particular set of vector

eigenvectors have an eigenvalue which says how much they are to be stretched


Av = lambda v

#### PART 2

norm is a vectors version of magnitude

there are diffeent types of norms

l_1 norm = sum of vector values, i.e. [4,5] = 9

l_1 is known as taxi form, it is the entire distance, i.e. along the row and up the collumn

l_2 norm. route of the squares of the sums

sq(a^2 + b^2)

aka as the crow flys 

related to pythag

norms are used to measure distances between vectors

note translating vectors does not change their distance, just the vector space they sit in 

#### vector space

vectors live in a vector space

vectors spaces are sets of elements that are:

closed under addition: remain within the set bounds

closed under mutliplication by a scalar inthe same field

any vector space rests on a field of k of sclars

scalars are almost always real numbers

a vector space as an additive identify: this means adding 0 = the same input

additive inverse: minus of the same input takes you to 0


a vector space is a group of any objects that uphold these properties

#### relationships between vectors

dot product will tell us angle and correlation between vectors



