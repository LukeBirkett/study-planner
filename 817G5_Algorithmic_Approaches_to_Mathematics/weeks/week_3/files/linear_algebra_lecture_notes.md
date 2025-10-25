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


# Lecture Week 4


norm_1 : around the block instance
norm_2 : direct distances
norm_inf : biggest vector value, i.e. (1,0.5) = 1

norms depicate distance from 0

#### vector space

R^2 is a vector space, i.e. (x,y)

Vector space can be matrices too R^n*m

This means vector spaces can be images and neural networks etc

Vector spaces are set sof elements that interact in a particular way:
 - closed under addition. adding two vectors will remain in the set

 - closed under multi by scalar. Also remain in the vector space/field

what is a field?

it is the set of numbers

 - additive indentigy. zero vector. + doesnt change

- additive inverse. return vector to 0, i.e. a minsu vector. all vectors have minus

#### correlltion

dot product give angle

can be scaled by the size of the vectors

can find angle between imgaes and matrices


#### Linear (In)dependance

if you can add up vectors and get 0, then vectors are dependant

there is something that relates them

there vector may not directly add to 0 

but if there exists a c that scales each and then you get 0, then they are dependant

Sum(c_i, v_i) = 0

CLARIFY, DOES IT NEED TO BE THE SAME C_i FOR ALL OR JUST A SCALE APPLIED TO EACH

#### Basis of Vector Space

basis is the ground truth

rep in a coord system

[3.1]

e1 = [1 0] e2 = [0 1]

v = 3e1 + e2

{e1, e2} is a basis

it can reach any vector in V with linear comination of the basis vectors

[v1 v2] = v1 e1 + v2 e2

lin combs mean can add and mutliply by scalars

basis elements are linear independant

basis can be any vectors

imagine f1 = [1 1] f2 = [0 1]

diff basis can be used to create the same output vectors

basis are the coord systems to represent vectors

a vector is made up of the basis vectors

basis vectors can each any vectors

this can be proven by proving a new basis can reach the e-basis [e1, e2]

and we know the e-basis can reach everywhere

e_i is orthonormal basis

1. orgogonal: each basis elem is at right angle. their dot pproduct is 0

2. normalised: norm of each basis is 1 in the 2 norm || e ||_2


#### Span

this is the space you can reach using lin combinations

all possible vectors

### Range


### Rank

This is the dimension of the span

If you have 3 vectors but 1 is the product of 2 (lin dep) then the rank is of rank 2

it cant get everywhere

this is a singular span/rank

WE ARE NOT DOING DETERMINANT ON THIS COURSE

 

you can look a vector, i.e. 3x3, work out its range

this done by seperating the matrix out into columns and working out their dependancy

"range of A is a two-dimensional vector space (rank 2)"

if you can take a matrix and mutli by a vector and it = 0 

then the column vectors are linearly dep

#### image of a matrix

aka the span

things you can get to using mutliplication

#### Kernel

kernal of a matrix is the set of vectors that map to 0

{v : Av = 0} intercect ⊆ V

dimension of kernel is the nullity of A

the kernel is also its own vector space

#### rank-nullity theorem 

Rank(A) + Nullity(A) = No of Cols(A)

if rank is 2 then null is 1

#### linearity in lin alg

T(ax + by) = aT(x) + bT(y)

a,b scalars
x,y vectors

T is the mapping

f(x) = 2x + 4

linear algebra DOES NOT have this 

a(2x + 4) + b(2y + 4) 

DOES NOT EQUAL

2(ax + by) + 4

(In Linear Algebra)

f(x) is not linear

often people think that linearity means to the power of 1, i.e. not squared etc

this is not the defintion of linearity

linearity has to go through the original

linearity in algegra takes you back to 0

if you have an offset +4 you arent at the origin

#### Linear Map

matrices are linear maps

map is input and output

T: V -> W

Linear map

T transforms basis elements

if you know how your map transforms the basis elemtns

then you know how T transforms anything

T: R^2 -> R^3 (this is mapping)

start basis {e1 e2}

some basis of 3 {f1, f2, f3}


it tells you how it transforms the basis vector in terms of the output vector space

T(e1) = 3f1 + 7f2 + 5f3
T(e2) = 4f1 − 2f2 + 6f3

linear map can be represented as a matrix

the matrix columns impact the correspond basis vectors

the outcome is the output in the next basis vector coord ystem 

if we know how to transform between the basis vectors using this transformation matrix (linear map) then we can do this with any vector we start with


#### composing linear maps

MM matricies together composes linear maps

#### rotations

vector normals are invariant to rotation

angle between vectors in preserved under rotation

angle=dot prodct


#### Scaling

this is eigenvectors

diag matrix

the basis of the vector space (???)

 

