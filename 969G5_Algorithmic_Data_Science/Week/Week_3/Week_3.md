**| [Canvas Page](https://canvas.sussex.ac.uk/courses/39278/modules#:~:text=Manipulation%20and%20computation-,Lecture,-3%20/%20Lab%204) | [Video Lecture](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=3e69d8a1-c959-4139-bda9-b4e500c5e2b5) |** 
This week we will be looking at matrix algebra. We will start with basic matrix theory and consider operations such as transpose, inverse and multiplication, including Strassen's algorithm for matrix multiplication. We will consider what happens when we scale up to big data.

---
#### Learning Outcomes
- Do basic matrix manipulations yourself on small matrices.
- Understand asymptotic run-times of some matrix manipulations.
- Do some basic matrix manipulations in Python and empirically examine their time complexity.
---
#### Background Reading
[Cormen et al](https://readinglists.sussex.ac.uk/leganto/public/44SUS_INST/citation/27057570290002461?auth=SAML) [Internet](https://www.cs.mcgill.ca/~akroit/math/compsci/Cormen%20Introduction%20to%20Algorithms.pdf):
- Chapter 4 (Strassen's algorithm)
- Chapter 28 (Matrix operations).
---
#### Lecture
Do the recap as notes in the previous weeks lab. It covers the derivation on how to go the complex O() to working its out from the graph. 


1. What is a matrix; Terminology;
	- Vector is a point in n-dimensional space
	- A matrix is a transformation on space, like a function
	- Transpose exchange rows and columns
2. Matrix Addition; 
	- same dimensions, component wise
	- formula
	- example, 
	- complexity
		- $m \times n$ independent scalar sums
		- nested for loops
		- We say it is $\mathcal{O}(m \times n)$ because Big-O notation measures the fundamental resource requirements of the problem itself, deliberately ignoring specific hardware tricks.
		- Big-O describes asymptotic behaviour—what happens as the input size $N = m \times n$ grows toward infinity ($N \to \infty$)
3. Matrix Multiplication by Scalar;
	- scalar lambda
	- definition
	- equation
	- example
	- o(n^2) of n by n matrix. all components need to be accessed a multiplied
4. Matrix subs
5. Matrix Multiplication
	- Compatible; rows, columns
	- Definition
	- Formulas; mathematical form, summation with double loop ij jk
	- Examples
	- MM not commutative
	- Complexity; $n^3$, loop, loop, sum, $\text{Total Operations} = n^2 \times 2n = 2n^3 = \mathcal{O}(n^3)$, Both matrices have their elements accessed **$n$ times each**, which leads directly to: $\text{Total Accesses} = (n^2 \text{ elements in } A \times n) + (n^2 \text{ elements in } B \times n) = 2n^3 = \mathcal{O}(n^3)$, Even if you keep the LHS elements in hand (e.g. in CPU registers or cache) rather than re-reading them from RAM, you still have to **perform a brand new multiplication with each element of the RHS**, In algorithm analysis, "accessing" or "processing" means **participating in an operation**.
6. Identity Matrix; same matrix back 1 eqi; example
7. Matrix Division? There is no such thing but we do define the inverse; mutli by inverse you get inverse matrix; non-invertible; there is formula for obtaining the inverse but it is very complicated; 
8. Applications 1: Matrix Solving Linear Equations; example written as matrix; rearrange and use inverse to work out; 
9. Applications 2: Probability, marginal distributions, formula; transform to matrix
10. The Page Rank Algorithm; covered properly in week 9; google search; follow through matrix example; random surf; matrices for these computation were extremely large, i.e. size of the web, which led to innovations in parallel computing.
11. ps-code implementation of matrix multiplication; route to $n^3$
12. Strassen's method
	- Recursive algo for matrix multiplication
	- split down in size $n$ matrices, i.e. 2 by 2
	- Any multiplication of two size n matrices can be broken down into multiplication of size n over two matrices
	- equation example of 4x4 matrix into 2 by 2 matrices
	- you treat the individual sub matrices as if they were "numbers", i.e. split into rows and columns and piece wise multiply like you would a mm
	- can work with non square matrices using padding but assume square
	- this is a divide and conquer strategy
	- formula/example of taking a 4x4 matrix and extracting all the individual equations derived
	- this is what the n chunks gives recursively
	- complexity
	- still $n^3$ but requires only 7 multiplication's rather than 8 which brings it to 2.81 in complexity (this is strassens method)
	- an alternative way of doing n size mm
	- equations from normal to strassen recursive $P_n$
	- replace i mutliplication with more additions and subtractions


---
#### Lab




---

#### Readings

Chapter 4 - 
$T(n) = a \cdot T(n/b) + f(n)$
This is a divide and conquer algorithm that creates $a$ sub-problems, each of which is $n/b$ the size of the original problem. 
- **$a$:** The number of recursive subproblems the algorithm spawns.
- **$T(n/b)$:** The cost to execute the recursive call on a subproblem whose size has been scaled down by a factor of $b$.
- **$a \cdot T(n/b)$:** The combined time spent running all $a$ recursive calls.
- **$f(n)$:** The non-recursive overhead—namely the time spent dividing the problem and combining the results at the current level.

##### The Three Notations: A Quick Refresher
- **$\mathcal{O}$ (Big-O):** An **upper bound** ("at most" / worst case).
- **$\Omega$ (Big-Omega):** A **lower bound** ("at least" / best case).
- **$\Theta$ (Big-Theta):** A **tight bound** (both upper and lower bounds match; "scales exactly like").

##### Strassen
---

Square-Matrix-Mutliply Psudo

---

Because each of the triply-nested for loops runs exactly n iterations, and each execution of line 7 takes constant time, the SQUARE-MATRIX-MULTIPLY procedure takes $\Theta(n^3)$ time.

A function $f(n)$ belongs to $\Theta(g(n))$ if and only if it is bounded both from above and below by constant multiples of $g(n)$ for sufficiently large $n$: $0 \le c_1 \cdot g(n) \le f(n) \le c_2 \cdot g(n)$. Because both the upper bound ($\mathcal{O}$) and lower bound ($\Omega$) match at $n^3$, the bound is asymptotically tight.

The passage describes three nested loops where each loop executes **exactly** $n$ iterations. The inner step (line 7) takes constant time, meaning it requires at least $c_1$ operations and at most $c_2$ operations per step ($c_1 \le \text{time} \le c_2$). Multiplying these gives a lower bound of $c_1 \cdot n^3$ and an upper bound of $c_2 \cdot n^3$.

The passage explicitly states $\Theta(n^3)$ (Big-Theta), which is the mathematical symbol reserved exclusively for tight bounds.

You might at first think that any matrix multiplication algorithm must take $\Omega(n^3)$  time, since the natural definition of matrix multiplication requires that many multiplications. You would be incorrect, however: we have a way to multiply matrices in $O(n^3)$ time.

---

#### Simply Divide and Conquer Matrix Multiplication
use a divide-and-conquer algorithm to compute the matrix product $C =  A \mutliply B$ , we assume that $n$ is an exact power of $2$ in each of the $n \x n$ matrices. This so we can divide the inputs equally. 

(4.9) Shows an equation splitting $A$, $B$ and $C$ into four $n/2$ by $n/2$ matrics


The important thing to remember here is that (4.9) isn't splitting a matrix down into a 2 by 2 matrix, it is splitting an undefined matrix size into quadrants. A_11 is another matrix, not a scalar. 





Every divide-and-conquer step splits a matrix into **$4$ quadrants** (2 blocks high by 2 blocks wide):
$$\begin{pmatrix} a & b \\ c & d \end{pmatrix}$$
If $n = 64$, $a, b, c, d$ are each **$32 \times 32$ matrices**. To multiply $a$ by $(g - h)$ to get $P_1$, you cannot just do a simple scalar multiplication—you have to multiply two $32 \times 32$ matrices. 

How do you multiply those two $32 \times 32$ matrices? **You run the exact same slide again!**

That child call splits the $32 \times 32$ into four $16 \times 16$ quadrants ($a', b', c', d'$), which split into $8 \times 8$, then $4 \times 4$, then $2 \times 2$.

When your recursive subproblem is down to a tiny $2 \times 2$ matrix, you split it one last time into four **$1 \times 1$ matrices (single numbers)**:
- Now, $a, b, c, d, e, f, g, h$ are **numbers** rather than matrices.
- Calculating $P_1 = a(g - h)$ no longer makes a recursive matrix call—it is literally just ordinary arithmetic with single numbers.
- This base case of $1 \times 1$ is where the recursion stops.
- The from her the simple equations and strassens reformulation take place

---
##### Full Summary
1. **Going Down (Splitting):** Large matrices get sliced into smaller blocks until a block is just a single $1 \times 1$ scalar.
2. **At the Bottom:** Scalar multiplication happens.
3. Four $2 \times 2$ matrices form a $4 \times 4$ matrix.
4. Four $4 \times 4$ matrices form an $8 \times 8$ matrix...
5. ...all the way until you reconstruct the original $n \times n$ matrix at the top.

In pure theoretical algorithmic terms, each time the algo bubbled with to $2 \times 2$ matrix, it is again split down to a $1 \times 1$ scalar unit. This is because to get the four $2 \times 2$ quadrant matrices ($r, s, t, u$), the algorithm needs to compute Strassen's 7 products: $P_1, P_2, P_3, P_4, P_5, P_6, P_7$

If you did a standard $2 \times 2$ matrix multiplication here, you would use **8 scalar multiplications**. Strassen's whole purpose is to never do 8 multiplications for any $2 \times 2$ block. Instead, it calls the Strassen function recursively on those $2 \times 2$ matrices. That recursive call splits the $2 \times 2$ matrices into four **$1 \times 1$ scalar quadrants**, and computes _its_ 7 scalar multiplications using single numbers.

However, in practice, splitting all the way to $1 \times 1$ creates massive overhead from function calls and temporary arrays. Real software stops recursing when matrices are around $64 \times 64$ or $32 \times 32$ and uses hardware loops for the rest. 

For an exam or theoretical analysis, the base case is strictly $n = 1$ ($1 \times 1$ scalars). The algorithm keeps halving the dimensions until there is nothing left to partition.

---

##### What is the Base Case
In formal complexity analysis and pseudocode, **$1 \times 1$ is the base case**. However, the **$2 \times 2$ level is the final partition step** where the elements being plugged into the 7 equations are indeed single scalar numbers.

In the pseudocode, the base case check is explicitly written as: $\text{if } n == 1 \quad \text{then } c_{11} = a_{11} \cdot b_{11}$

A $1 \times 1$ matrix contains exactly one element—a single scalar number.

This means, when $n = 2$, the algorithm hits the `else` branch, not the base case. It partitions each $2 \times 2$ matrix into four $1 \times 1$ blocks:

$$A = \begin{pmatrix} A_{11} & A_{12} \\ A_{21} & A_{22} \end{pmatrix}$$where each block $A_{ij}$ is a $1 \times 1$ matrix (a scalar). It then makes recursive calls with these $1 \times 1$ matrices. Inside those child calls, $n = 1$ is true, so the single scalar multiplication executes and returns.

Practically and conceptually, thinking of $2 \times 2$ as the base case is very common because $2 \times 2$ is where the **last set of Strassen equations** ($P_1, \dots, P_7$) is applied. At that $2 \times 2$ level, the submatrices $a, b, c, d, e, f, g, h$ are just individual numbers, so the 7 multiplications are simple scalar products rather than calls that spawn further subproblems.


--- 

Strassen’s algorithm is fundamentally self-similar at every scale, repeatedly halving an $n \times n$ matrix into four quadrants until it decomposes entirely into $1 \times 1$ scalar base cases. At the bottom of this recursion tree, simple numbers are multiplied, and the results then bubble back up the call stack by applying the exact same seven product formulas ($P_1$ through $P_7$) and quadrant reconstruction equations ($r, s, t, u$) at every single level. The underlying algebra never changes as the matrix is rebuilt; the only difference is that each step upward executes those additions and subtractions on progressively larger submatrix blocks—merging scalars into $2 \times 2$ matrices, then $2 \times 2$ blocks into $4 \times 4$ quadrants, and repeating layer by layer until the complete matrix dimensions are fully restored.

---

```
SQUARE-MATRIX-MULTIPLY-RECURSIVE(A, B)
1  n = A.rows
2  let C be a new n × n matrix
3  if n == 1
4      c₁₁ = a₁₁ · b₁₁
5  else partition A, B, and C into (n/2) × (n/2) submatrices:
        A₁₁, A₁₂, A₂₁, A₂₂
        B₁₁, B₁₂, B₂₁, B₂₂
        C₁₁, C₁₂, C₂₁, C₂₂
6      C₁₁ = SQUARE-MATRIX-MULTIPLY-RECURSIVE(A₁₁, B₁₁)
             + SQUARE-MATRIX-MULTIPLY-RECURSIVE(A₁₂, B₂₁)
7      C₁₂ = SQUARE-MATRIX-MULTIPLY-RECURSIVE(A₁₁, B₁₂)
             + SQUARE-MATRIX-MULTIPLY-RECURSIVE(A₁₂, B₂₂)
8      C₂₁ = SQUARE-MATRIX-MULTIPLY-RECURSIVE(A₂₁, B₁₁)
             + SQUARE-MATRIX-MULTIPLY-RECURSIVE(A₂₂, B₂₁)
9      C₂₂ = SQUARE-MATRIX-MULTIPLY-RECURSIVE(A₂₁, B₁₂)
             + SQUARE-MATRIX-MULTIPLY-RECURSIVE(A₂₂, B₂₂)
10 return C
```

Note, this isn't strassens, it is just matrix mutllpication recurively 

---

```
STRASSEN(A, B)
 1  n = A.rows
 2  let C be a new n × n matrix
 3  if n == 1
 4      c₁₁ = a₁₁ · b₁₁
 5      return C
 6  else
 7      // --- DIVIDE ---
        Partition A, B, and C into (n/2) × (n/2) submatrices:
            A₁₁, A₁₂, A₂₁, A₂₂
            B₁₁, B₁₂, B₂₁, B₂₂
            C₁₁, C₁₂, C₂₁, C₂₂

 8      // --- STEP 1: Compute the 10 helper matrices (Matrix Additions/Subtractions) ---
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

 9      // --- STEP 2: The 7 Recursive Multiplications ---
        P₁ = STRASSEN(A₁₁, S₁)
        P₂ = STRASSEN(S₂, B₂₂)
        P₃ = STRASSEN(S₃, B₁₁)
        P₄ = STRASSEN(A₂₂, S₄)
        P₅ = STRASSEN(S₅, S₆)
        P₆ = STRASSEN(S₇, S₈)
        P₇ = STRASSEN(S₉, S₁₀)

10      // --- STEP 3: BUBBLING UP (Reconstruct C's Quadrants) ---
        C₁₁ = P₅ + P₄ - P₂ + P₆
        C₁₂ = P₁ + P₂
        C₂₁ = P₃ + P₄
        C₂₂ = P₅ + P₁ - P₃ - P₇

11      // --- STEP 4: Combine the four quadrants into C ---
        C = [ C₁₁  C₁₂ ]
            [ C₂₁  C₂₂ ]

12      return C
```

The key to Strassen’s method is to make the recursion tree slightly less bushy. That is, instead of performing eight recursive multiplications of n/2 n/2 matrices, it performs only seven.