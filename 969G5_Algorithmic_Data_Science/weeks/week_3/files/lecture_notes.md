# Matrices

#### time complex/finish off

run time is O(g(n)) if for large enough data g(n) * const approximates the run-time well

this gets more true the bigger the data is 

#### current lecture

matrix shapes and types: vector, 1n = row, n1 = col, matrix, square, zero, indentity

adding two matrices is O(m n)

have to specifify both m and n becasue the size of each is not specifiied 

one could be very large and dominate the run time

##  mutli by scalar

each component gets multiplied by scalar

time comlexity is O(n2)

requires 2 for loops to go through i rows and j cols

## matrix mutli

cols of first need to match number of rows in second

full row * full col (piece wise) = single number

same full row * next full col = next number

shape is determiend by the number of rows and cols

output = rows1 * cols2

O(n^n)

# inverse

A * A^-1 = I

there is a formula for calculing the inverse derived from calculating the determinant and using a formula

determinant:
| a b |
| c d | = ad - bc

A^-1 = 1/det ( a -b ; -c a)

for large matrixes the derminant can be calculated using a recursive function

## Page Rank Algo

search engine algo

based on number of links or clicks

matrix of page probabilities which can change over time, t

convered in detail in approx week 9 

## back to matrix mulitplication

## strassen method

a recurisive algo

larer matrix mutliplication can be broken down into sets of 2x2 MM which is computationally easier

collpese into 2x2 matrices then collpase down again etc ...

result is the same


if nxn is a power of 2 then it is striaghtforward to write the mm as a recurrance

where the components may be matrices or just numbers

example of a divide and concquer strategy

split the problem into smaller problems and combine the results

running time is solves by calcupalting the recurrance formula

for 2*2 2*2 MM (breaks down in to 4 calcs, e.g.  r = ae + bf)

T(n) = 8T(n/2) + O(n^2)

recall matrix multi is O(n^2), doing more only affects the constant

this is not strassen, he found a way on doing 7 insteasd of 8 

requires more additions but less multiplications

strassens recursive approach involves computer 7 calcs which give us the same information as the standard long form on MM

in some places the components of the 7 calcs are reused, hence the lower number of calculations and recurrsions

this method is impracticle if n < 45, this is because all the additional additions offset the reducations in reccursions

the technice is aimed for size that is of power 2 but if the size isn't then an additionall row of 0s can be padded in 


