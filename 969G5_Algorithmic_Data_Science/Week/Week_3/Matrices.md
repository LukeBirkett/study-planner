***| [Canvas Page](https://canvas.sussex.ac.uk/courses/39278/modules#:~:text=Manipulation%20and%20computation-,Lecture,-3%20/%20Lab%204) | [Video Lecture](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=3e69d8a1-c959-4139-bda9-b4e500c5e2b5) |***
This week we will be looking at matrix algebra. We will start with basic matrix theory and consider operations such as transpose, inverse and multiplication, including Strassen's algorithm for matrix multiplication. We will consider what happens when we scale up to big data.

---
#### Learning Outcomes
- Do basic matrix manipulations yourself on small matrices.
- Understand asymptotic run-times of some matrix manipulations.
- Do some basic matrix manipulations in Python and empirically examine their time complexity.
---
## Background Reading
[Cormen et al](https://readinglists.sussex.ac.uk/leganto/public/44SUS_INST/citation/27057570290002461?auth=SAML) [Internet](https://www.cs.mcgill.ca/~akroit/math/compsci/Cormen%20Introduction%20to%20Algorithms.pdf):
- Chapter 4 (Strassen's algorithm)
- Chapter 28 (Matrix operations).
---
# Lecture
**_| [[lecture3.pdf | Slides]] |_**

Do the recap as notes in the previous weeks lab. It covers the derivation on how to go the complex O() to working its out from the graph. 
1. [[#What is a matrix: Terminology. | What is a matrix: Terminology.|]]
2. [[#Matrix Operations | Matrix Operations]]
	1. [[#Transpose | Transpose]]
	2. [[#Addition | Addition]]
	3. [[#Scalar Multiplication]]
	4. [[#Multiplication]]
	5. [[#Identity Matrix]]
3. [[#Naive Matrix Multiplication Algorithm]]
4. [[#Strassen's Method]]
---
## What is a matrix: Terminology.
| **Matrix Type**           | **Definition**                                                                                                                                       | **Example / Visual Look**                                                                                                         |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Vector** (Row & Column) | A **vector** is a 1-dimensional matrix ($1 \times n$ or $n \times 1$). A **row vector** is $1 \times n$ whereas a **column vector** is $n \times 1$. | Row vector: $\begin{pmatrix} 5 & 2 & 3 \end{pmatrix}$<br><br>  <br><br>Column vector: $\begin{pmatrix} 1 \\ 4 \\ 2 \end{pmatrix}$ |
| **Zero Matrix**           | A **zero matrix** is a matrix where every entry is 0.                                                                                                | $\begin{pmatrix} 0 & 0 \\ 0 & 0 \end{pmatrix}$                                                                                    |
| **Square Matrix**         | A **square matrix** has dimensionality $n \times n$.                                                                                                 | $\begin{pmatrix} 1 & 3 \\ 4 & 2 \end{pmatrix}$                                                                                    |
| **Diagonal Matrix**       | A **diagonal** matrix is a square matrix with $a_{ij} = 0$ if $i \neq j$.                                                                            | $\begin{pmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 5 \end{pmatrix}$                                                               |
| **Identity Matrix** ($I$) | An **identity** matrix, $I$, is a diagonal matrix with $a_{ij} = 1$ if $i = j$.                                                                      | $\begin{pmatrix} 1 & 0 \\ 0 & 1 \end{pmatrix}$                                                                                    |
Semantically, vectors and matrices appear similar things in linear algebra, however, they represent two fundamentally different things. A vector is point in space given by $n$-dimensions. Matrix is a transformation, something that is applied on space much like a function. 

---
## Matrix Operations
### Transpose
The transpose of a matrix $A$ is the matrix $A^T$ obtained by exchanging the rows and columns of $A$ 
$$A = \begin{pmatrix} 0 & 3 \\ -2 & 5 \\ 0.2 & 10 \end{pmatrix} \to A^T = \begin{pmatrix} 0 & -2 & 0.2 \\ 3 & 5 & 10 \end{pmatrix}$$

---
### Addition
Addition can only be carried out for matrices which have the same dimension and is defined component wise: 
$$C = A + B \leftrightarrow \forall_{ij} (c_{ij} = a_{ij} + b_{ij})$$
$$\begin{pmatrix} 1 & 3 & 1 \\ 1 & 0 & 0 \end{pmatrix} + \begin{pmatrix} 0 & 0 & 5 \\ 7 & 5 & 0 \end{pmatrix} = \begin{pmatrix} 1 + 0 & 3 + 0 & 1 + 5 \\ 1 + 7 & 0 + 5 & 0 + 0 \end{pmatrix} = \begin{pmatrix} 1 & 3 & 6 \\ 8 & 5 & 0 \end{pmatrix}$$
Matrix addition requires matching dimensions and is computed component-wise using **nested for loops** to perform $m \times n$ independent scalar sums. This yields a time complexity of $\mathcal{O}(m \times n)$, which measures the fundamental resource requirements of the problem while deliberately ignoring specific hardware optimisations. Big-O notation describes this asymptotic behaviour as the input size $N = m \times n$ grows toward infinity. For square matrices where $m$ = $n$ this is $\mathcal{O}(n^2)$.

---
### Scalar Multiplication
- **Scalar Multiplication:** Multiplying a matrix $A = (a_{ij})$ by a scalar $\lambda$ scales every element individually, expressed as $\lambda A = (\lambda a_{ij})$.
- **Matrix Negation:** The negative of a matrix is defined as $-A = -1 \cdot A = (-a_{ij})$, satisfying the identity property $A + (-A) = 0 = (-A) + A$.
- **Asymptotic Complexity:** For an $n \times n$ matrix, scalar multiplication runs in $\mathcal{O}(n^2)$ time.
- **Complexity Explanation:** This quadratic complexity arises because every single element in the $n \times n$ grid must be independently accessed and multiplied by the scalar value.
---
### Multiplication
Two matrices ($A, B$) can only be mutliplied if they are compability in size meaning the the number of columns of $A$ equals the number of rows of $B$. If $A = (a_{ij})$ is an $m \times n$ matrix and $B = (b_{jk})$ is an $n \times p$ matrix, then their matrix product $C = AB$ is the $mxp$ matrix $C = (c_{ik})$ where: $c_{ik} = \sum_{j=1}^{n} a_{ij}b_{jk}$
$$\begin{pmatrix} 2 & 0 & 1 \\ 0 & -1 & 3 \end{pmatrix} \times \begin{pmatrix} 3 & -2 \\ 1 & 5 \\ 0 & 0 \end{pmatrix} = \begin{pmatrix} 6 & -4 \\ -1 & -5 \end{pmatrix}$$
Standard matrix multiplication operates in $\mathcal{O}(n^3)$ time, driven by three nested loops—two traversing the output matrix grid and an inner loop handling the summation. This structure results in $n^2 \times 2n = 2n^3$ total operations, which simplifies asymptotically to $\mathcal{O}(n^3)$. Furthermore, this process requires $2n^3$ total memory accesses, as every element in both matrices is accessed $n$ times ($n^2$ elements in $A \times n$ plus $n^2$ elements in $B \times n$). Even if left-hand-side elements are kept in CPU registers or cache rather than re-read from RAM, brand-new multiplications must still occur for every right-hand-side element, because in algorithm analysis, "accessing" or "processing" refers to active participation in an operation.

---
### Identity Matrix
The identity matrix is multiplicative identity. It functions as matrices version of 1. A matrix multiplied by $I$ returns $A$
$$AI = IA = A$$
---
### Inverses 
In Linear Algebra there is no such thing as division. Instead, we define the inverse of a $n \times n$ matrix $A$ to be a matrix with the same dimensions denoted $A^{-1}$ such that $AA^{-1} = I = A^{-1}A$. Therefore if $AB=C$ then $B=A^{-1}C$.

Note, that a given matrix may not have an inverse. Many nonzero square matrices do not have inverses. A matrix without an inverse is called noninvertible or singular. If a matrix has an inverse, it is called invertible or non-singular. • The transpose operation commutes with the inverse operation:

---
## Naive Matrix Multiplication Algorithm
- **The Output Grid ($n^2$):** The outer two loops (`i` and `j`) run a total of $n \times n = n^2$ times, which corresponds to the total number of elements in the resulting matrix $C$.
- **The Dot Product Inner Loop ($n$):** For every single one of those $n^2$ elements, the inner loop (`k`) runs $n$ times to compute the row-column dot product.
- **Operations per Iteration:** Inside that innermost loop, the statement `c_ij += a_ik * b_kj` executes **one multiplication** and **one addition** on every single pass.
- **Total Multiplications:** $n^2 \text{ (elements)} \times n \text{ (inner loop iterations)} = n^3$
- **Total Additions:** $n^2 \text{ (elements)} \times n \text{ (inner loop iterations)} = n^3$
- Because both core arithmetic operations scale as $n^3$, the combined running time is bounded by $\mathcal{O}(n^3)$
- In terms of the **exact number of operations**, it is $2n^3$ ($n^3$ multiplications plus $n^3$ additions)
- However, in asymptotic analysis ($\mathcal{O}$ and $\Theta$ notation), constant multipliers like the $2$ are dropped because they do not change how the algorithm scales as input size grows toward infinity.

```
Matrix-Multiply (A,B): 
if A and B are nxn matrices: 
	let C be an nxn matrix 
	for i from 1 to n: 
		for j from 1 to n: 
			c_ij = 0 
		
	for k from 1 to n: 
		c_ij += a_ik * b_kj 
return C
```

---
## Strassen's Method
Strassen's method is a recursive algo for matrix multiplication. It starts by noting that any multiplication of two size n matrices can be broken down into multiplication of size n over two matrices. 

So for any nxn matrix, where n is a power of 2, it is straightforward to write matrix multiplication as a recurrence, where the components of the matrices may be numbers or matrices:
$$\begin{pmatrix} a & b \\ c & d \end{pmatrix} \begin{pmatrix} e & g \\ f & h \end{pmatrix} = \begin{pmatrix} r & s \\ t & u \end{pmatrix}$$
$$\begin{aligned} r &= ae + bf \\ s &= ag + bh \\ t &= ce + df \\ u &= cg + dh \end{aligned}$$
This is an example of a divide-and-conquer strategy. We split the problem into smaller problems, solve each smaller problem and then combine the results. Here the smaller problem is of size $n/2$. There are $2^3$ of them to solve. Combining requires 4 matrix additions.

This basic recursive approach is not Strassen's but just a recursive approach of matrix multiplication. The run time for this approach is still $O(n^3)$ meaning it is no better than naive matrix multiplication:
$$T(n) = 8T(n/2) + O(n^2)$$
$$T(n) = O(8^{\log_2 n}) = O(n^{\log_2 8}) = O(n^3)$$
Strassen's on the other had discovered an approach which only used 7 recursive multiplications at each step, replacing the other multiplication with (many) additions and subtractions. 
$$T(n) = 7T(n/2) + O(n^2) = O(n^{\log_2 7}) = O(n^{2.81})$$
To bridge standard matrix multiplication and Strassen’s optimised method, we analyse how standard quadrant equations are re-engineered using 7 recursive products ($P_1$ through $P_7$) and 10 additions/subtractions.

When multiplying two $2 \times 2$ block matrices (where quadrants $a, b, c, d$ make up matrix $A$ and $e, f, g, h$ make up matrix $B$), standard recursive multiplication requires 8 products to find the output quadrants ($r, s, t, u$):
- $r = ae + bf$        $s = ag + bh$         $t = ce + df$         $u = cg + dh$

Strassen's replaces the 8 standard products with 7 ($P_1$–$P_7$) carefully engineered recursive multiplications. By utilising precomputed sums and differences of the input blocks, each product expands into specific cross-terms:
- $P_1 = a(g - h) = ag - ah$
- $P_2 = (a + b)h = ah + bh$
- $P_3 = (c + d)e = ce + de$
- $P_4 = d(f - e) = df - de$
- $P_5 = (a + d)(e + h) = ae + ah + de + dh$
- $P_6 = (b - d)(f + h) = bf + bh - df - dh$
- $P_7 = (a - c)(e + g) = ae + ag - ce - cg$

> The 10 preliminary helper matrices ($S_1$ through $S_{10}$) are an essential part of the algorithm's preparation phase. Because Strassen's 7 products ($P_1$ through $P_7$) multiply customized sums and differences of your input quadrants rather than the raw quadrants themselves, you must compute those 10 combinations first before you can pass them into the recursive calls.

So we can carry out matrix multiplication with just 7 recursive multiplications of matrices size $n/2$ (but we now have 18 additions/subtractions rather than 4). So:
$$T(n) = 7T(n/2) + \mathcal{O}(n^2) = \mathcal{O}(n^{\log_2 7}) = \mathcal{O}(n^{2.81})$$
In practice, the large constant hidden in the running time makes Strassen’s algorithm impractical unless n is large ($>45$) and dense (few zero entries). • For sparse matrices, there are special sparse-

---
# Lab
- Naive Implementation
- Strassen's Implementation of Matrix Multiplication
- Time comparison between the two over a range of size.
- At lower numbers the Naive performs the same or better than Strassen's as the increase on constant load for Strassen's causes the lower complexity ($2.807$ vs. $3.0$) to not be realised. 
- At $n=512$, which took several minutes to run, the different between Strassen's and the Naive method began to kick in. `Timeit` suggested that Naive took 150s and Strassen 30s.
- Strassen's inefficiencies are caused by traversing down to the base case `n<=2`. The function can be manipulated to convert to matrix multiplication and higher quadrant sizes allowing quick run time at lower input sizes. 
---
# Readings
1. [[#Chapter 4 - Divide and Conquer (Strassen's) | Chapter 4 - Divide and Conquer (Strassen's)]]
	1. [[#4.2. Strassen’s algorithm for matrix multiplication | Strassen’s algorithm for matrix multiplication]]
	2. [[#Simple Divide and Conquer Matrix Multiplication | Simple Divide and Conquer Matrix Multiplication]]
	3. [[#What is the Base Case | What is the Base Case]]
	4. [[#Strassen's and Recursion | Strassen's and Recursion]]
	5. [[#Strassen's Complexity | Strassen's Complexity]]
	6. [[#The Dividing Step | The Dividing Step]]
	7. [[#The Addition Submatrix Step | The Addition Submatrix Step]]
## Chapter 4 - Divide and Conquer (Strassen's)
This is a divide and conquer algorithm that creates $a$ sub-problems, each of which is $n/b$ the size of the original problem. 
$$T(n) = a \cdot T(n/b) + f(n)$$
- **$a$:** The number of recursive subproblems the algorithm spawns.
- **$T(n/b)$:** The cost to execute the recursive call on a subproblem whose size has been scaled down by a factor of $b$.
- **$a \cdot T(n/b)$:** The combined time spent running all $a$ recursive calls.
- **$f(n)$:** The non-recursive overhead—namely the time spent dividing the problem and combining the results at the current level.

> **The Three Notations: A Quick Refresher**
> - **$\mathcal{O}$ (Big-O):** An **upper bound** ("at most" / worst case).
> - **$\Omega$ (Big-Omega):** A **lower bound** ("at least" / best case).
> - **$\Theta$ (Big-Theta):** A **tight bound** (both upper and lower bounds match; "scales exactly like").

### 4.2. Strassen’s algorithm for matrix multiplication
---
The standard formula for matrix multiplication contains a nested loop meaning we must compute $n^2$ for the multiplication step(s) and another $n$ for the addition phase bringing the complexity to $\Theta(n^3)$.
$$c_{ij} = \sum_{k=1}^{n} a_{ik} \cdot b_{kj}$$
###### SQUARE-MATRIX-MULTIPLY(A, B)
``` 
1 n = A.rows 
2 let C be a new n × n matrix 
3 for i = 1 to n 
4     for j = 1 to n 
5         c_ij = 0 
6         for k = 1 to n 
7             c_ij = c_ij + a_ik · b_kj 
8 return C
```

A function belongs to $\Theta(n^3)$ when it is asymptotically tight, meaning its growth rate is bounded both above ($\mathcal{O}$) and below ($\Omega$) by constant multiples of $n^3$. This behavior characterizes standard three-nested-loop algorithms, where $n$ iterations across three levels with constant-time inner work guarantee execution between $c_1 n^3$ and $c_2 n^3$ operations. Crucially, while this confirms naive multiplication is strictly $\Theta(n^3)$, it disproves the common assumption that all matrix multiplication inherently demands an $\Omega(n^3)$ lower bound.

---
### Simple Divide and Conquer Matrix Multiplication
Here we use a divide-and-conquer algorithm to compute the matrix product $C =  A \cdot B$ , where we assume that $n$ is an exact power of $2$ in each of the $n \times n$ matrices. This so we can divide the inputs equally. 

Below we show how we breakdown the matrices into smaller parts. The important thing to remember here is that we aren't splitting a matrix down into a 2 by 2 matrix, it is splitting an undefined matrix size into quadrants. A_11 is another matrix, not a scalar. 
$$A = \begin{pmatrix} A_{11} & A_{12} \\ A_{21} & A_{22} \end{pmatrix}, \quad B = \begin{pmatrix} B_{11} & B_{12} \\ B_{21} & B_{22} \end{pmatrix}, \quad C = \begin{pmatrix} C_{11} & C_{12} \\ C_{21} & C_{22} \end{pmatrix}$$
$$\begin{equation} \begin{pmatrix} C_{11} & C_{12} \\ C_{21} & C_{22} \end{pmatrix} = \begin{pmatrix} A_{11} & A_{12} \\ A_{21} & A_{22} \end{pmatrix} \cdot \begin{pmatrix} B_{11} & B_{12} \\ B_{21} & B_{22} \end{pmatrix} \end{equation}$$
Under "normal" matrix multiplication rules we would have, where each of the four equations specifies two multiplications of $n/2 \times n/2$ and the addition of their $n/2 \times n/2$ products. 
$$\begin{align} C_{11} &= A_{11} \cdot B_{11} + A_{12} \cdot B_{21} \\ C_{12} &= A_{11} \cdot B_{12} + A_{12} \cdot B_{22} \\ C_{21} &= A_{21} \cdot B_{11} + A_{22} \cdot B_{21} \\ C_{22} &= A_{21} \cdot B_{12} + A_{22} \cdot B_{22} \end{align}$$
Every divide-and-conquer step splits a matrix into **$4$ quadrants** (2 blocks high by 2 blocks wide):
$$\begin{pmatrix} a & b \\ c & d \end{pmatrix}$$
If $n = 64$, $a, b, c, d$ are each **$32 \times 32$ matrices**. To multiply $a$ by $(g - h)$ to get $P_1$, you cannot just do a simple scalar multiplication because the elements are $32 \times 32$ matrices. Therefore, the recursion needs to continue, splitting down the $32 \times 32$ matrices. That child call splits the $32 \times 32$ into four $16 \times 16$ quadrants ($a', b', c', d'$), which split into $8 \times 8$, then $4 \times 4$, then $2 \times 2$.

When the recursive subproblem is down to a $2 \times 2$ matrix, we split it one last time into four **$1 \times 1$ matrices (single numbers)**:
- Now, $a, b, c, d, e, f, g, h$ are **numbers** rather than matrices.
- Calculating $P_1 = a(g - h)$ no longer makes a recursive matrix call, it is literally just ordinary arithmetic with single numbers.
- This base case of $1 \times 1$ is where the recursion stops.
- In this form the simple equations and Strassen's reformulation take place

> Note, in theoretical terms we split all the way down so simple units to execute Stassen's. 

---
### What is the Base Case
The base case is the terminal $1 \times 1$ matrix where the elements are scalars. However, the **$2 \times 2$ level is the final partition step** where the elements being plugged into the 7 equations are indeed single scalar numbers. Pseudocode's may differ whether they use $n==1$ or $n == 2$ to demonstrate the "base case". 

In true theoretical pseudocode, the base case check is explicitly written as: $\text{if } n == 1 \quad \text{then } c_{11} = a_{11} \cdot b_{11}$. Note, that a $1 \times 1$ matrix contains exactly one element—a single scalar number. 

This means, when $n = 2$, the algorithm hits the `else` branch, not the base case. It partitions each $2 \times 2$ matrix into four $1 \times 1$ blocks where each block $A_{ij}$ is a $1 \times 1$ matrix (a scalar).
$$A = \begin{pmatrix} A_{11} & A_{12} \\ A_{21} & A_{22} \end{pmatrix}$$
Semantically, the code could be set up either way as the $2 \times 2$ level submatrices $a, b, c, d, e, f, g, h$ are just individual numbers but doing the formal way focuses in on the recursion all the way down to Strassen's equations ($P_1, \dots, P_7$).

--- 
### Strassen's and Recursion
Strassen’s algorithm is fundamentally self-similar at every scale, repeatedly halving an $n \times n$ matrix into four quadrants until it decomposes entirely into $1 \times 1$ scalar base cases. At the bottom of this recursion tree, simple numbers are multiplied, and the results then bubble back up the call stack by applying the exact same seven product formulas ($P_1$ through $P_7$) and quadrant reconstruction equations ($r, s, t, u$) at every single level. The underlying algebra never changes as the matrix is rebuilt; the only difference is that each step upward executes those additions and subtractions on progressively larger sub matrix blocks—merging scalars into $2 \times 2$ matrices, then $2 \times 2$ blocks into $4 \times 4$ quadrants, and repeating layer by layer until the complete matrix dimensions are fully restored.

```
STRASSEN(A, B)
 1  n = A.rows
 2  let C be a new n × n matrix
 3  if n == 1
 4      c₁₁ = a₁₁ · b₁₁
 5      return C
 6  else
 7 // --- STEP 1 DIVIDE ---
        Partition A, B, and C into (n/2) × (n/2) submatrices:
            A₁₁, A₁₂, A₂₁, A₂₂
            B₁₁, B₁₂, B₂₁, B₂₂
            C₁₁, C₁₂, C₂₁, C₂₂

 8 // --- STEP 2: 10 helper matrices (Matrix Additions/Subtractions) ---
        S₁  = B₁₂ - B₂₂
        S₂  = A₁₁ + A₁₂
        S₃  = A₂₁ + A₂₂
        S₄  = B₂₁ - B₁₁
        S₅  = A₁₁ + A₂₂
        S₆  = B₁₁ + B₂₂
        S₇  = A₁₂ - A₂₂
        S₈  = B₂₁ + B₂₂
        S₉  = A₁₁ - A₂₁
        S₁₀ = B₁₁ + B₁₂

 9 // --- STEP 3: The 7 Recursive Multiplications ---
        P₁ = STRASSEN(A₁₁, S₁)
        P₂ = STRASSEN(S₂, B₂₂)
        P₃ = STRASSEN(S₃, B₁₁)
        P₄ = STRASSEN(A₂₂, S₄)
        P₅ = STRASSEN(S₅, S₆)
        P₆ = STRASSEN(S₇, S₈)
        P₇ = STRASSEN(S₉, S₁₀)

10      // --- STEP 4: BUBBLING UP (Reconstruct C's Quadrants) ---
        C₁₁ = P₅ + P₄ - P₂ + P₆
        C₁₂ = P₁ + P₂
        C₂₁ = P₃ + P₄
        C₂₂ = P₅ + P₁ - P₃ - P₇

11      // --- STEP 5: Combine the four quadrants into C ---
        C = [ C₁₁  C₁₂ ]
            [ C₂₁  C₂₂ ]

12      return C
```

### Strassen's Complexity
The key to Strassen’s method is instead of performing eight recursive multiplications of n/2 n/2 matrices as per standard recursive matrix mutliplication, it performs only seven.

#### The Dividing Step
1. Divide the input matrices $A$ and $B$ and the output matrix $C$, the same as recursive matrix multiplication algorithm. This takes This step $\Theta(1)$ (upper and average the same) time by index calculation.
2. When $n>1$ steps 1, 2, and 4 take $\Theta(n^2)$ and step 3 requires us to perform seven multiplications of $n/2$ by $n/2$ matrices giving us the following recurrence for the running time $T(n)$ of Strassen’s algorithm:
$$T(n) = \begin{cases} \Theta(1) & \text{if } n = 1, \\ 7T(n/2) + \Theta(n^2) & \text{if } n > 1. \end{cases}$$
3. We have traded off one matrix multiplication for a constant number of matrix additions
---
#### The Addition Submatrix Step
1. In step 2, we need to create 10 matrices. recalling that the original matrices have been split into quadrants hence the $N_{ij}$. The complexity of this step is is $\Theta(n^2)$ because of how the total number of arithmetic operations scales with $n$.: 
$$
\begin{aligned} S_{1} &= B_{12} - B_{22} , \\ S_{2} &= A_{11} + A_{12} , \\ S_{3} &= A_{21} + A_{22} , \\ S_{4} &= B_{21} - B_{11} , \\ S_{5} &= A_{11} + A_{22} , \\ S_{6} &= B_{11} + B_{22} , \\ S_{7} &= A_{12} - A_{22} , \\ S_{8} &= B_{21} + B_{22} , \\ S_{9} &= A_{11} - A_{21} , \\ S_{10} &= B_{11} + B_{12} . \end{aligned}
$$
2. This step here is the most important part of Strassens and is not at all logical. By combining the quadrants (8) to 10 sub-matrices, we create a scenario where the Stassen's formulas can achieve matrix multiplication results in 7 multiplications rather than 8. Strassen's doesn't work without this seemingly arbitary step. 
3. Each of the sub-matrices being added or subtracted has dimensions $(n/2) \times (n/2)$. The number of individual scalar entries in one such matrix is:
$$\frac{n}{2} \times \frac{n}{2} = \frac{n^2}{4}$$
4. Adding or subtracting two matrices is done entry by entry. Performing an addition or subtraction on a single entry takes $\Theta(1)$ constant time. Therefore, adding or subtracting two $(n/2) \times (n/2)$ matrices requires:
$$\frac{n^2}{4} \times \Theta(1) = \Theta\left(\frac{n^2}{4}\right)$$
5. Because this operation is performed exactly $10$ times (to produce $S_1, S_2, \dots, S_{10}$):
$$\text{Total Operations} = 10 \times \left( \frac{n^2}{4} \right) = \frac{10}{4} n^2 = 2.5\, n^2$$
6. In asymptotic analysis ($\Theta$-notation), constant multipliers drop out:
$$2.5\, n^2 = \Theta(n^2)$$
  7. Because the exponent on $n$ is $2$ and the number of repetitions ($10$) is a fixed constant that does not grow with matrix size, the entire preparation step scales quadratically as $\Theta(n^2)$
---

