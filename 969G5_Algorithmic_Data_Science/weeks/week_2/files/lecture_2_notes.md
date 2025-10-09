Algorithms focus on ideas, not syntax. Can be pseudo code

"Program" should by syntax correct

3 considering for algos: 
- Terminate for every input
- correct for every input
- better than other algos

What is better? time complex, space (memory) complex, communication complex (packets around network)

Faster can be dependant on parameters, i.e. faster on some, faster when, rather on average/typical inputs, faster on certain conditions


#Constant time function

Constant time function is O(1)

Time does not depend on any size factors (n) 

# Linear time function

A linear time function is O(n)

It is intrinsicly linked to the size of the input n

If n doubles then so does the run time

direcly proportional to n

#Quadratic time function
run time is quadruple the size. 

if size doubles then time quadruples

O(n^2)


worst case scenario is what diciate thes complexity

upper-bound run time 

powers quickly swamp out the complexity of constants so for big data the more efficent option is always the constants

O(g(n)) we can approx the run time by working out a function against n

for large enough data some elements (the constants) become irrelevant hence we can approx using a certain function g()

const x g(n)

17n^6 + 15n^4 is O(n6)

g() = n^6

biger n gets the better 17g(n) approximates

#### query why 15n^4 gets ignored

eventually the highest power will dominate after a certian n 

recall that the O complexity is a worst case scenario so it is often better in practice


