**| [Canvas Page](https://canvas.sussex.ac.uk/courses/39278/pages/overview-and-reading-unit-1?module_item_id=1685486) | [Video Lecture](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=f020f9a4-93c1-4d97-ac71-b4de00c5c45b) |** 
This week we will be thinking about the complexity of an algorithm and how this impacts on run-time. We will consider how run-time grows with the size of a problem, defined in terms of the input data. For example, if we wish to sort a list of 10 numbers, the problem is small and it does not matter much which algorithm we use to solve the problem (it need only be correct). However, if we wish to sort billions of numbers, the need for an efficient algorithm becomes apparent. We will discuss best-case, worst-case and average-case variation (i.e., are there other factors which impact run-time other than size of input, e.g., the order of the input?), and introduce O notation. We apply the theory to sorting algorithms.

---
#### Learning Outcomes
- Work out the asymptotic run time of simple algorithms, in O notation.
- Be able to establish the asymptotic run-time function of an algorithm by running experiments in Python.
---
#### Background Reading
[Cormen et al](https://readinglists.sussex.ac.uk/leganto/public/44SUS_INST/citation/27057570290002461?auth=SAML) [Internet](https://www.cs.mcgill.ca/~akroit/math/compsci/Cormen%20Introduction%20to%20Algorithms.pdf):
- Chapter 2 Getting Started Algorithms
- Chapter 3 Growth of Functions
- Chapter 8 Sorting in Linear Time
---
### [Lecture](Files/lecture2.pdf)
1. [[#Algorithms vs Programs|Algorithms vs Programs]]
2. [[#Problems|Problems]]
3. [[#Quality of Algo|Quality of Algo]]
4. [[#Comparing algorithms|Comparing algorithms]]
5. [[#What could being faster mean?|What could being faster mean?]]
6. [[#Complexity and Timing Framework|Complexity and Timing Framework]]
7. [[#Constant-time Operations|Constant-time Operations]]
8. [[#Iterations: Linear-time|Iterations: Linear-time]]
9. [[#Nested iterations: quadratic tim|Nested iterations: quadratic tim]]
10. [[#Broken Iterations: Linear-time|Broken Iterations: Linear-time]]
11. [[#Asymptotic order of growth|Asymptotic order of growth]]
12. [[#Time complexity O Notation: Loose definition.|Time complexity O Notation: Loose definition.]]
13. [[#Divide-and-Conquer|Divide-and-Conquer]]
14. [[#Insertion sort (Cormen et al. Notes)|Insertion sort (Cormen et al. Notes)]]
15. [[#Insertion-Sort Algo (A)|Insertion-Sort Algo (A)]]
16. [[#Merge-Sort|Merge-Sort]]
17. [[#The Purpose of the Upper-Bound Constant (c) in Big-O (Cormen et al. Chapter 3)|The Purpose of the Upper-Bound Constant (c) in Big-O (Cormen et al. Chapter 3)]]
18. [[#The Practical/Empirical Test (Doubling Test)|The Practical/Empirical Test (Doubling Test)]]
19. [[#The Formal Mathematical Test (Limit Ratio Test)|The Formal Mathematical Test (Limit Ratio Test)]]



---
#### Algorithms vs Programs
We use the term algorithm interchangabley with program (e.g., in Python). The emphasis is different though

An algorithm 
```
Finding biggest element in a list: Set biggest_sofar to be first element of list. 
Then, check each element in list in turn 
If It is bigger than biggest_sofar, 
update biggest_sofar
```
Algorithms focus on ideas, not syntax


A program
```
def find_max_element(alist):
    sofar=alist[0]
    for thing in alist[1:]:
        if thing>sofar:
            sofar=thing
    return sofar
```
Programs should be syntactically correct

---
#### Problems
Recalling that we distinguish algorithms from problems (or functions), because intuitively we know that sometimes very different algorithms do the same thing i.e., solve the same problem

An algorithm is a well-defined procedure that takes a value or set of values as input and produces some value or set of values as output

More formally, a problem is a mapping or a relation from inputs to outputs.

Many problems are also functions. For functions, the mapping is many-to-one or one-to-one. In other words there is only a single correct output for a given input.

𝑓: 𝑋 → 𝑌

We say that an algorithm $A$ implements a function problem $f$, if: 
$$\forall x \in X, \forall y \in Y: f(x) = y \quad \text{if} \quad A(x) \text{ terminates and yields } y$$

---
#### Quality of Algo
Its not enough to write down an algorithm and say ‘Behold. Look at this marvellous algorithm I have written.

We need to convince ourselves that:
- The algorithm terminates (for every possible input)
- The algorithm is correct (for every possible input)
- The algorithm is better than other possible algorithms.

---
#### Comparing algorithms
What does it mean for algorithm A to be better than algorithm
- **Time Complexity:** How long will my program take to run? Is algorithm A faster than algorithm B?
- **Space Complexity:** How much memory will my program need? Does algorithm A use less memory than algorithm B?
- **Communication Complexity:** How many packets of data will my program send over the network? Does algorithm A send less packets over the network than algorithm B?
We are starting this module looking at only Time Complexity on a single machine with no parallel computing but we will later move onto considering memory and finally involving mutli-computer scenarios where the cost of transfer information across a network can slow things down.

---
### What could being faster mean? 
- A runs faster than B on some inputs
- A runs faster than B on all inputs
- A runs faster than B on the best case
- A runs faster than B on the worst case
- A runs faster than B on average
- A runs faster than B on average relative to some probability distribution over the inputs
- A runs faster than B on typical inputs

The default is to consider the worst case scenario. But specific use-cases may use specific definitions.

---
#### Complexity and Timing Framework
We could scope into every detail and compute run times and mathematics for every component in the algorithm. However, this in itself would take a long time and outweigh the benefit. Really, we just want to run the algo and see what happens

Certain things like "if my data doubles, how much this the run time increase" need quick and intuitive answers. 

We need a framework to get these estimates quickly. (this is for large data considerations)

---
#### Constant-time Operations
Some operations are instant meaning they always take the same amount of time. These are time constant operations. 

Things like addition, subtraction, if-then-else are good approximations for time constant

- Executing an addition always takes $c_{add}$ seconds
- Executing a subtraction always takes $c_{subtract}$ seconds
- Executing a conditional always takes $c_{if-then-else}$ seconds

These constants rely heavily on the chosen programming language, CPU, compiler, clock speed etc

```
def myfunc(alist)"
	ans=alist[0]**2
	print("answer:" + str(ans))
```

nothing here depends on the length of the list. all the actions are instantly executable. this is said to be $O(1)$. This comes from 1^0 being 1. There is nothing increasing the complexity, either linearly or exponentially. 

This is a constant-time function. The run-time is of the order of 1: O(1)

---
#### Iterations: Linear-time
Alternatively, we have linear-time actions. These are things that by definition scale the time taken by the size of the input
```
def myfunc1(alist):
	for thing in alist:
		print(thing)
```

This has a problem size of $n = len(alist)$ 

There is a loop which force the constant time operation (print) to be executed $n$ times. 

The length of time to complete depends linearly on the size of the input. If the length of the list is doubled, the run- time will be doubled. The run time is some function of n i.e., it is of the order of n. We call this O(n)

The run time of proportional to $n$

---
#### Nested iterations: quadratic tim
```
def myfunc2(alist):
	for thing1 in alist:
		for thing2 in alist:
			print("A pair is: "+str(thing1)+ "," +str(thing2))
```

Still the problem size is n but there is a duplicated of the loop also traversing $n$

therefore the instructions are carried out $n * n$ times

The run-time is quadratic in the size of the input. If the length of the list doubles, the run-time will quadruple. We call this O(n2)

if the list doubles in size, the run time will quadruple. 

---
#### Broken Iterations: Linear-time
```
def myfunc1b(alist,something):
	for thing in alist:
		print(thing)
	if thing==something:
		break
```

3 constant time operations (print, == and if) is carried out up to n times

The UPPER BOUND on the length of time to complete depends linearly on the size of the input. If the length of the list is doubled, the run-time will be potentially doubled. The upper-bound on run time is some linear function of n i.e., it is of the order of n. This is O(n)

The complexity is considered to be the upper possibility. we don't know what he something is and if it will impact. 

---
#### Asymptotic order of growth
Let’s assume we have two algorithms $A_1$ and $A_2$ for a given problem, and their run-time is given by $f_1$ for $A_1$ and $f_2$ for $A_2$ where:

$f_1(n) = 0.00001 * 2^n$
$f_2(n) = 289346724587138654380 × n^2$

For small data, $A_1$ is faster, but eventually, for big enough data $A_2$ is faster. We are interested in the behaviour of algorithms as the input data grows large.

---
#### Time complexity O Notation: Loose definition.
A run-time is $O(g(n))$ if:
- For sufficiently large data, *const x* $g(n)$ approximates the run-time well, and the approximation generally gets better and better the bigger the data.

Example: $17n^6 + 15n^4$ = $O(n^6)$ 

Here $g(n()$ is $n^6$ and the constant is $17$

The approximation becomes more accurate the larger $n$ gets. This is because as $n$ grows the $n^6$ begins to completely dwarf $n^4$, however, at smaller $n$ sizes it will contribute to the run-time complexity. 

Big-O is fundamentally about **scaling behavior** as $n$ grows toward infinity, not the absolute number of operations. An operation made have a fundementally sorter run time than another operation, however, their O-notion can both be $n^2$. This would mean that when $n$ doubles, the number of operations quadruples. When thinking about complexity we really need to think dynamically and about things scale.

| **Complexity Class** | **If n→10n, how much longer does it take?** | **Examples that share this complexity**                              |
| -------------------- | ------------------------------------------- | -------------------------------------------------------------------- |
| **$O(1)$**           | **No change ($1\times$)**                   | Accessing `arr[0]` vs. accessing `arr[999]`                          |
| **$O(n)$**           | **$10\times$ longer**                       | A loop running $n$ times vs. two separate loops running $2n$ times   |
| **$O(n^2)$**         | **$100\times$ longer ($10^2$)**             | A full nested loop ($n^2$) vs. our shrinking loop ($\frac{1}{2}n^2$) |
| **$O(n^3)$**         | **$1,000\times$ longer ($10^3$)**           | Three nested loops vs. a triangular volume ($\frac{1}{6}n^3$)        |


---
#### Divide-and-Conquer
 Many useful algorithms are recursive in nature. They use the divide- and-conquer paradigm
 1. Divide the problem into a number of subproblems which are similar to the original problem but smaller in size
 2. Conquer the subproblems by solving them recursively. If the subproblems are small enough, solve them in an obvious way (the base case)
 3. Combine the solutions to the subproblems into the solution for the original problem 

---
#### Insertion sort (Cormen et al. Notes) 
**Input:** A sequence of $n$ numbers $\langle a_1, a_2, ..., a_3 \rangle$
**Output:** A permutation (reordering) $\langle a'_1, a'_2, ..., a'_3 \rangle$ of the input sequence such that $a'_1 \le a'_2 \le ... \le a'_n$

The input conceptually is a sequences but programmatically is an array with $n$ elements.

Insertion sort is efficient algorithm for sorting a **small** number of elements.

Insertion sort works much like sorting cards. You start with a selection card where the order is unknown and face down, consider this as the right hand bundle, and a left hand bundle which is empty. 

You drawn a random card from the right hand side and place it in order in the left hand side. Clearly, for the first entry this results in simply placing the card in the left side. For the second drawn card, you iteratively compare it to the $m$ cards in the left hand side. If it is higher than the compare card you place it down. If it is lower you move down one. If there exists another card to compare you repeat, else if there are no more you are at the start of the queue so you place it down. 

Conceptually, and in pseudocode, the input array $A[1,...,n]$ is considered to be "replaced" or "updated" rather than a new array created. This is because we consider $A[0]$ to be already "sorted" and the basis for the element in the left bundle. The algorithm sorts the input numbers "**in place**". 

##### Insertion-Sort Algo (A)
```
for j = 2 to A.length:
	key = A[j]
	i = j - 1
	while i > 0 and A[i] > key
		A[i + 1] = A[i]
		i = i - 1
	A[i + 1] = key

```

This pseudocode demonstrates the in-place sorting. The first element of the list is forgone and considered to be sorted meaning the loop starts at `j=2`. The `key` is assigned to the second value, after which the indexer `i` is set to the value before `j`. Therefore, during the while loop, the first element accessed is `A[i]` which for the first iteration would be the first "sorted" element. If this value `A[i] > key` the second slot `A[i + 1]` is assigned to the original `A[i]` and the index incremented back again. This increment is so the function can iterate through $n$ sorted values. Once all values are checked or the conditions are violated, i.e. the key is no longer smaller than whatever `A[i]` is, the key is assigned to `A[i + 1] = key`. The index is `+1` because the final step in while loop is to lower it in anticipation for another index to check which never came. 

---
#### Merge-Sort
Cormen has a comprehensive overview of merge and merge-sort but I didn't take notes. Maybe some back and do notes if it turns out to be important for the exam. 

---
#### The Purpose of the Upper-Bound Constant ($c$) in Big-$O$ (Cormen et al. Chapter 3)
In $T(n) \le c \cdot f(n)$, the constant $c$ represents fixed hardware and language speed—it scales the curve up or down, but it **cannot change its shape**.

**Why it proves complexity:**
If you make an incorrect claim—such as claiming a quadratic algorithm $T(n) = n^2$ is linear $O(n)$—the math demands finding a single fixed $c$ such that:

$$n^2 \le c \cdot n \implies n \le c$$
No matter how large a constant $c$ you choose (even $c = 1{,}000{,}000$, representing an ultra-fast supercomputer), input size $n$ will eventually exceed it ($n = 1{,}000{,}001$).

Because no fixed constant $c$ can keep that ceiling intact as $n \to \infty$, the claim mathematically fails. This proves that hardware ($c$) cannot rescue an algorithm from a worse growth class ($f(n)$).

A correct complexity notation will be validated by a constant scaling rule which will hold true at large enough values of $n$

The constant scaling can be considered as a test or validation of the complexity nomination: 

###### 1. **The Practical/Empirical Test (Doubling Test)**
When you write an algorithm and want to prove your Big-$O$ derivation matches real code, you run a **Doubling Hypothesis Test**:
2. Measure runtime at input size $N$: record time $T(N)$.
3. Double the input size to $2N$
4. Compute the ratio:
$$\text{Scaling Ratio} = \frac{T(2N)}{T(N)}$$

| **Observed Ratio as N→∞** | **Validated Complexity** |
| :------------------------ | :----------------------- |
| $\approx 1$               | $O(1)$ or $O(\log n)$    |
| $\approx 2$               | $O(n)$                   |
| $\approx 4$ ($2^2$)       | $O(n^2)$                 |
| $\approx 8$ ($2^3$)       | $O(n^3)$                 |
|                           |                          |

If the theoretical paper calculation says an algorithm is $O(n)$, but the benchmark shows the runtime quadrupling ($\approx 4\times$) every time you double $n$, the empirical scaling test has **falsified** your complexity claim.

###### 2. The Formal Mathematical Test (Limit Ratio Test)
In mathematics and formal algorithm analysis, the exact tool used to validate whether $T(n) = O(f(n))$ is the **Limit Test**:
$$\lim_{n \to \infty} \frac{T(n)}{f(n)} = L$$
- If the limit $L$ is a **finite constant** ($0 \le L < \infty$), the complexity claim is **validated**. (That finite value $L$ is directly tied to the constant multiplier $c$).
- If the limit goes to **$\infty$**, the scaling rule has been violated. The claimed $f(n)$ grows too slowly to bound $T(n)$, meaning the Big-$O$ notation is **invalid**.
For example, testing the claim that $T(n) = n^2$ is $O(n)$:
$$\lim_{n \to \infty} \frac{n^2}{n} = \lim_{n \to \infty} n = \infty$$
Because it blows up to infinity rather than settling under a finite constant bound, the notation is mathematically invalid.

---
### Lab
### 1. Lab Objectives & Core Hypothesis
- **Theoretical Claim:** The runtime $T(n)$ of Insertion Sort scales as a power-law relationship $T(n) \approx c_a n^\alpha$, where theory predicts quadratic growth ($\alpha = 2$) for sufficiently large $n$.
- **Methodology:** Use empirical benchmarking (`timeit`), log-log transformation, and linear regression to extract the scaling exponent $\alpha$ and the machine-dependent constant $c_a$.
---
### 2. Experimental Procedure & Results
**Log-Log Formulation:** Taking the natural logarithm of both sides converts the power law into a straight line:
$$\ln(T) = \alpha \ln(n) + \ln(c_a)$$
- **Gradient ($\text{slope}$):** Scaling power $\alpha$
- **Y-intercept:** $\ln(c_a)$, from which the machine constant is calculated via $c_a = e^{\text{intercept}}$

**Empirical Measurements (Random / Average Case):**
- **Estimated exponent ($\alpha$):** $\approx 2.0155$ (closely matches the expected $\alpha = 2$ for quadratic growth)
- **Estimated intercept ($\ln(c_a)$):** $-21.2351$
- **Derived constant ($c_a$):** $\approx 5.9939 \times 10^{-10}\text{ s}$
---
### **3. Scenario Comparison: Best, Average, and Worst Cases**

|**Metric / Property**|**Best Case (Already Sorted) IPYNB**|**Average Case (Random Lists) IPYNB**|**Worst Case (Reverse-Sorted) IPYNB**|
|---|---|---|---|
|**Log-Log Slope ($\alpha$)**|$\approx 1$ (flatter line)|$\approx 2$|$\approx 2$|
|**Relative Line Position**|Lowest vertical placement|Middle vertical placement|Highest vertical placement|
|**Growth Family ($\Theta$)**|$\Theta(n)$|$\Theta(n^2)$|$\Theta(n^2)$|
|**Upper Bound ($O$)**|$O(n)$ (tight); $O(n^2)$ (loose)|$O(n^2)$|$O(n^2)$|

---
#### Key Analytical Takeaways
- **Parallel Slopes:** The average- and worst-case curves run parallel on the log-log plot because both scale quadratically ($\alpha \approx 2$), confirming both belong to the exact same $\Theta(n^2)$ complexity class.
- **Vertical Offset ($\ln(2)$):** The worst case is vertically shifted above the average case by an intercept difference of $\approx \ln(2)$ because an element in a reversed list shifts past all preceding items, whereas in a random list it shifts past roughly half on average ($c_{\text{worst}} \approx 2 \cdot c_{\text{avg}}$).
- **Best-Case Divergence:** The best case is not parallel because it requires only a single comparison per element with zero shifts, yielding linear time $\Theta(n)$ and a slope of $\alpha \approx 1$.

---


