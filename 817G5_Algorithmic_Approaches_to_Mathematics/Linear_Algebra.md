The content for linear algebra started in Week 1 but the slides holding this content come from from [Week 3](week_3_LA_1_Symbolic.pdf). 

Lecture 1 started by looking into the pure basics of Linear Algebra. We were introduced to the two foundational faces of Linear Algebra: **Symbolic** and **Geometric**. 

The symbolic/mechanical leg involves working with indices, equations, algebraic manipulation, and numbers. Where as the geometric thinks in terms of spaces, transformations, directions, and shapes.

While linear algebra is **fundamentally a geometric discipline**, mastering the mechanics first provides the vocabulary needed to navigate the geometry later.

---
#### Files
- [Linear Algebra Part 1: Symbolic](Weeks/Week_3/Files/week_3_LA_1_Symbolic.pdf)
- [Linear Algebra Part 2: Geometric](Weeks/Week_3/Files/week_3_LA_1_Geometric.pdf)
- [Linear Algebra Cheatsheet](Weeks/Week_3/Files/week_3_LA_1_Symbolic.pdf)
- [Deep Learning Book: Linear Algebra Chapter](https://www.deeplearningbook.org/contents/linear_algebra.html)
---
# Contents

###  [[#Linear Algebra Part 1: Mechanical]]
1. [[#Core Primitives: Vectors, Matrices, and Tensors]]
2. [[#Vectors]]
3. [[#Matrices]]
4. [[#Sets & Spaces Notation]]
5. [[#Core Operations & Mechanics]]
6. [[#Transposition (T)]]
7. [[#Dot Product (Inner Product)]]
8. [[#Matrix Multiplication (AB)]]
9. [[#Norm]]
	1. [[#What Properties Should a Norm Have?]]
	2. [[#The Three Norms]]
	3. [[#Normalising Vectors]]
10. [[#What is an Algebra?]]
11. [[#Special matrices]]
12. [[#Law of Transposition]]
13. [[#Solving Matrix Equations]]
14. [[#Number Based Algebra]]
15. [[#Matrix Base Algebra]]
16. [[#Non-Invertible Matrices]]
17. [[#Tall or Wide Systems]]
---  
### [[#Linear Algebra Part 2: Geometric]]
1. [[#Vector Spaces]]
2. [[#What is a Field ($K$)?]]
3. [[#Vector Space Rules]]
4. [[#Spans]]
5. [[#Canonical Basis Vectors]]
6. [[#Geometric Interpretation of Vectors]]
7. [[#Flexibility of Basis Vectors and Co-Ordinate Systems]]
8. [[#Subspace Exercise]]
9. [[#Definition of the Span]]
	1. [[#1. Contains the Zero Vector ($ mathbf{0} in S$)]]
	2. [[#2. Closed Under Vector Addition]]
	3. [[#3. Closed Under Scalar Multiplication]]
10. [[#Linear Independence]]
11. [[#Formal Linearly Dependent Definition]]
12. [[#New Way of Multiplying Matrices]]
13. [[#Image of the Matrix]]
14. [[#Rank of Matrix]]
15. [[#Interim Summary]]
16. [[#Dot Product Geometric]]
17. [[#Dot Product Projects]]
18. [[#Correlation]]
---
### [[#Linear Algebra Part 3 Transformations]]
1. [[#Recap Matrices Convert Coordinates (Transformations)]]
2. [[#About Linearity]]
3. [[#Why Linear Maps Matter The "Superpower" of Linear Algebra]]
4. [[#Kernel and Nullity]]
5. [[#The Kernel (Null Space) What Gets Crushed to Zero]]
6. [[#The Image (Column Space) What You Can Actually Reach]]
7. [[#The Conservation of Dimension Rank-Nullity Theorem]]
8. [[#Maps, Geometrically]]
9. [[#The Eigenvector–Eigenvalue Relationship]]
---
### [[#3B1B]]
1. [[#Matrics as transformation functions]]
2. [[#Composition of Transformations]]
3. [[#Associativity]]
4. [[#Determinant, Inverse matrices, Column space, and Null space]]
5. [[#Change of Basis and Eigenvectors]] 
---
# Linear Algebra Part 1: Mechanical
1. [[#Core Primitives: Vectors, Matrices, and Tensors]]
2. [[#Vectors]]
3. [[#Matrices]]
4. [[#Sets & Spaces Notation]]
5. [[#Core Operations & Mechanics]]
6. [[#Transposition (T)]]
7. [[#Dot Product (Inner Product)]]
8. [[#Matrix Multiplication (AB)]]
9. [[#Norm]]
	1. [[#What Properties Should a Norm Have?]]
	2. [[#The Three Norms]]
	3. [[#Normalising Vectors]]
10. [[#What is an Algebra?]]
11. [[#Special matrices]]
12. [[#Law of Transposition]]
13. [[#Solving Matrix Equations]]
14. [[#Number Based Algebra]]
15. [[#Matrix Base Algebra]]
16. [[#Non-Invertible Matrices]]
17. [[#Tall or Wide Systems]]
## Core Primitives: Vectors, Matrices, and Tensors
- To understand linear algebra we need to learn to core underlying substrate. 
---
### Vectors
An ordered collection of numbers. Unlike unordered sets, element positions matter ($v_1$ is distinct from $v_2$).

There are two types of vector orientations: 
- **Column Vector:** Formatted vertically ($n \times 1$). This is the default convention in mathematical literature.
- **Row Vector:** Formatted horizontally ($1 \times n$).
$$ \underline{p} = \begin{bmatrix} p_1 \\ p_2 \\ p_3 \\ \vdots \\ p_n \end{bmatrix} \qquad\text{,}\qquad \underline{p}^T = \begin{bmatrix} p_1 & p_2 & p_3 & \dots & p_n \end{bmatrix} $$
A key thing to remember here is the matrix notation is formatted as (*row*, *columns*) hence ($1 \times n$) is a row because it has depth of 1 row only. 

---
### Matrices
An ordered collection of numbers across two index dimensions (rows and columns). An element is identified by $M_{i,j}$ where:
- $i$ = row index (vertical position).
- $j$ = column index (horizontal position).
$$
M \in \mathbb{R}^{m \times n} = \begin{bmatrix}
M_{11} & M_{12} & \dots & M_{1n} \\
M_{21} & M_{22} & \dots & M_{2n} \\
\vdots & \vdots & \ddots & \vdots \\
M_{m1} & M_{m2} & \dots & M_{mn}
\end{bmatrix}
$$
---
### Sets & Spaces Notation
- $\mathbb{R}$: The set of all real numbers.
- $\mathbb{R}^n$: The space of vectors containing $n$ elements, where each entry is a real number.
- $\mathbb{R}^{m \times n}$: The space of matrices with $m$ rows and $n$ columns.
---
## Core Operations & Mechanics
- Similarly, there are a set of fundamental operational tools that underpin linear algebra and its advanced techniques. 
---
### Transposition ($T$)
This flips a matrix or vector over its diagonal—interchanging rows and columns. For the case of a vector it turns a $n \times 1$ column vector into a $1 \times n$ row vector: 
$$\underline{v} \xrightarrow{\text{transpose}} \underline{v}^T$$
---
### Dot Product (Inner Product)
Pairwise multiplication of corresponding components of two equal-length vectors, followed by summing the products. It evaluates the aggregate interaction between two vectors (e.g., weights vs. inputs). A row vector multiplied by a column vector: 
$$
\underline{u}^T \underline{v} = \sum_{i=1}^n u_i v_i
\qquad\Longleftrightarrow\qquad
\begin{aligned}[c]
&\underbrace{\begin{bmatrix} p_1 & p_2 & p_3 & \dots & p_n \end{bmatrix}}_{\text{prices}}
\overbrace{\begin{bmatrix} g_1 \\ g_2 \\ g_3 \\ \vdots \\ g_n \end{bmatrix}}^{\text{quantities}} \\
&= p_1 g_1 + p_2 g_2 + p_3 g_3 + \dots + p_n g_n
\end{aligned}
$$
The outcome of a dot product tells us information on vector correlation. If $\underline{u}^T \underline{v} < 0$ the vectors are anti-correlated, they are opposites. $\underline{u}^T \underline{v} = 0$ provides proof of no relationship, uncorrelated. And $\underline{u}^T \underline{v} > 0$ suggests there is a positive relationship. 

That said, dot products are not perfect measures of correlation because they encode other pieces of information. 

---
### Matrix Multiplication ($AB$)
Matrix multiplication is a batch or concatenation of multiple dot products arranged in a systematic grid. Semantically, the left **matrix rows** act as queries/questions/filters and the right **matrix columns** act as data instances/answers. The entry at position $(i, j)$ in the product represents the evaluation of row $i$ against column $j$.

$$
\left[
\begin{array}{ccc}
\bullet & \bullet & \bullet \\
\hline
\bullet & \bullet & \bullet
\end{array}
\right]
\left[
\begin{array}{c|c}
\bullet & \bullet \\
\bullet & \bullet \\
\bullet & \bullet
\end{array}
\right]
=
\begin{bmatrix}
\bullet & \bullet \\
\bullet & \bullet
\end{bmatrix}
$$
Matrix multiplication $A B$ can only be defined if the columns of $A$ equal the rows of $B$. If $A \in \mathbb{R}^{m \times k}$ and $B \in \mathbb{R}^{k \times n}$, then $(AB) \in \mathbb{R}^{m \times n}$. Additionally, the size of the output is determined by the number of LHS rows and the RHS columns. 

Finally, unlike scalar arithmetic, matrix multiplication is **not commutative**: $AB \neq BA$. Changing the order changes the dimensional compatibility, the questions being evaluated, and the resulting values entirely.

---
### Norm
The magnitude of a number is it's distance from 0, e.g. $\vert{}-3\vert{} > \vert{}1\vert{}$. This becomes a little more complicated when looking at vectors as there is lots of numbers. To do this we need Norms which is the vectors notion of distXance from the zero vector.
$$\left\Vert{} \begin{bmatrix} \bullet \\ \bullet \end{bmatrix} \right\Vert{}, \left\Vert{} \begin{bmatrix} -2 \\ 3 \end{bmatrix} \right\Vert{}$$
A norm is easily demonstrated in a graph geometrically as vector arrows distance away from the centre axis. This method does not scale well when we move beyond 2/3 dimensions but working as this dimension level is a good way to learn and conceptualise linear algebra. 

![vector norm distance graph](Files/norm_graph.png)

However, this representation is only 1 possible type of Norm. Linear Algebra has many Norms which all measure the distance from zero. This module focused on 3 types which are the most popular for Machine Learnings. 

---
#### What Properties Should a Norm Have?
- **Non-Negativity** ($\|v\| \ge 0 \quad \forall v$): A distance by definition needs to be more than 0. There can't be a negative distance. 
- **Homogeneity of Scaling** ($k\Vert{}\underline{v}\Vert{} = \Vert{}k\underline{v}\Vert{} \quad \forall k \in \mathbb{R}$): This is the contingency that the Norm of vectors going in the same direct scale to their size. If a vector ($2\underline{v}$) is doubled in size then so should its Norm ($2\Vert{}\underline{v}\Vert{}$). 
- **Triangle Inequality** ($\|\underline{a} + \underline{b}\| \le \|\underline{a}\| + \|\underline{b}\| \quad \forall \underline{a}, \underline{b}$): The distance of "via" something will always be as long or longer than the direct route. 
---
#### The Three Norms

|**Name**|**Formula**|**Definition**|**Example**|
|---|---|---|---|
|**$L_1$ (Taxicab) Norm**|$\Vert{}\underline{v}\Vert{}_1 = \sum_{i=1}^n \vert{}v_i\vert{}$|Sum of the magnitudes of each element in a vector. Named after a taxicab navigating a grid-like street network.|$\Vert{}\underline{x}\Vert{}_1 = \vert{}2\vert{} + \Vert{}-4\Vert{} = 6$|
|**$L_2$ (Euclidean) Norm**|$\Vert{}\underline{v}\Vert{}_2 = \sqrt{\sum_{i=1}^n v_i^2}$|Straight-line length of the vector arrow from the origin. Derived from the Pythagorean theorem.|$\Vert{}\underline{x}\Vert{}_2 = \sqrt{2^2 + (-4)^2} = \sqrt{20}$|
|**$L_\infty$ (Maximum) Norm**|$\Vert{}\underline{v}\Vert{}_\infty = \max_i \vert{}v_i\vert{}$|Takes only the maximum absolute magnitude among all vector components.|$\Vert{}\underline{x}\Vert{}_\infty = \max(\vert{}2\vert{}, \vert{}-4\vert{}) = 4$|

---
#### Normalising Vectors 
Normalising a vector refers to the process of scaling a non-zero vector so that its length (magnitude) equals $1$, while preserving its original direction. A vector with a magnitude of $1$ is called a **unit vector** (commonly denoted with a "hat", e.g., $\hat{\underline{v}}$).

To normalise a vector, divide each component of the vector by its norm:
$$\hat{\underline{v}} = \frac{\underline{v}}{\Vert{}\underline{v}\Vert{}}$$
Doing this allows us to **isolate direction from magnitude**. Vectors inherently encode both direction and magnitude, this is why dot product isn't a perfect computation of correlation. Normalisation removes the effect of scale, allowing algorithms to compare the orientation or direction of vectors without bias from their lengths (e.g., in cosine similarity). Furthermore, scaling a vector by its own norm ensures the unit length of the resulting vector sums to $1$.

Unit vectors are commonly used in Machine Learning to prevent numerical explosions or decay during iterative calculations (such as gradient descent or iterative projections).

A norm is simply a definition of distance or size. Because different norms calculate distance differently, **what counts as "having length 1" changes completely depending on which norm you choose:**
- If you measure with the **$L_2$ (Euclidean) norm**, a vector has norm 1 when: $\sqrt{v_1^2 + v_2^2} = 1$ 
- If you measure with the **$L_1$ (Taxicab) norm**, a vector has norm 1 when: $\vert{}v_1\vert{} + \vert{}v_2\vert{} = 1$

Take the vector $\mathbf{v} = \begin{bmatrix} 3 \\ 4 \end{bmatrix}$

| **Property**     | **L2​ (Euclidean) Norm**                                                                                 | **L1​ (Taxicab) Norm**                                                                                           |
| :--------------- | :------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------- |
| **Length**       | $\Vert{}\mathbf{v}\Vert{}_2 = \sqrt{3^2 + 4^2} = 5$                                                      | $\Vert{}\mathbf{v}\Vert{}_1 = \vert{}3\vert{} + \vert{}4\vert{} = 7$                                             |
| **Normalised**   | $\hat{\mathbf{v}} = \begin{bmatrix} 3/5 \\ 4/5 \end{bmatrix} = \begin{bmatrix} 0.6 \\ 0.8 \end{bmatrix}$ | $\hat{\mathbf{v}} = \begin{bmatrix} 3/7 \\ 4/7 \end{bmatrix} \approx \begin{bmatrix} 0.43 \\ 0.57 \end{bmatrix}$ |
| **Verification** | $\Vert{}\hat{\mathbf{v}}\Vert{}_2 = \sqrt{0.6^2 + 0.8^2} = \sqrt{0.36 + 0.64} = \mathbf{1}$              | $\Vert{}\hat{\mathbf{v}}\Vert{}_1 = \vert{}3/7\vert{} + \vert{}4/7\vert{} = \mathbf{1}$                          |
It really important to understand that the verification step have different approaches because they are fundamentally different measures of distances. 

---
#### Mean Centring
Mean centring is when you calculate the average ($\mu$) across your data points or vector components, and **subtract** it from each value in order to remove constant offsets (bias) and allow data to fluctuate around zero.
$$\tilde{x}_i = x_i - \mu$$
By definition this means we want to see negative values. Negative values are import for Dot Product, which pairs corresponding items and multiplies them:
$$\mathbf{u}^T \mathbf{v} = \sum u_i v_i$$
Without negative numbers, dot products are fundamentally broken as a measure of agreement as all-positive vectors would always produce positive numbers making vectors look positively aligned simply because both sets of ratings are positive

Negative numbers allow opposite preferences to generate a negative outcome ($\text{positive} \times \text{negative} = \text{negative}$), correctly signalling anti-correlation.

In the moving ratings example the table was already mean-centred on the rows: 
**A:** $\frac{1 + 1 - 1 - 1}{4} = \mathbf{0}$, **B** $\frac{1 + 1 - 1 - 1}{4} = \mathbf{0}$, **C:** $\frac{-1 - 1 + 1 + 1}{4} = \mathbf{0}$, **E:** $\frac{1 - 1 + 0 + 0}{4} = \mathbf{0}$, **F:** $\frac{10 + 10 - 10 - 10}{4} = \mathbf{0}$


---
### What is an Algebra?
> A framework for groups of objects to interact and make babies

This definition is in intentionally vague because no one thing is an algebra. Instead algebra is a set of rules to govern the interaction of something. The most common example of an algebra is numbers. Here we have a number of rules (Axioms) such as addition, multiplication and associativity which govern the use of numbers. 

> In algebra, an operation is **associative** if changing the grouping of operands with parentheses does not alter the final result, satisfying $(a * b) * c = a * (b * c)$.

Similarly we have an algebra for vectors/matrices. We have matrix multiplication, elementwise vector addition, scaling $3 \begin{bmatrix} 4 \\ 5 \end{bmatrix}$ and a given rule of associativity $(AB)C=A(BC)$.
In associativity brackets are really important tools to denote order. Order is also very important for multiplication in vector algebra because matmul is not commutative ($AB \ne BA$), unlike numbers algebra. Furthermore, there are additional rules on what vectors qualify for multiplication and additional as the vectors need to be compatible shapes

> Matrix multiplication $AB$ is valid only if the number of columns in the first matrix (or vector) matches the number of rows in the second matrix (or vector). When multiplying a size $m \times k$ matrix by a size $k \times n$ matrix, the matching inner dimensions $k$ allow the operation, producing an output of size $m \times n$.

This general concept is important to understand because there are algebgras for everything, each with their own axiom rules. Later we will study the axioms for probability and calculus. 

---
### Special matrices
The **additive identity** is comprised of all zeroes and doesn't anything when added to another vector. 
$$\underline{0}_3 = \begin{bmatrix} 0 & 0 & 0 \\ 0 & 0 & 0 \\ 0 & 0 & 0 \end{bmatrix}, \quad A + \underline{0}_n = \underline{0}_n + A = A \quad\quad \forall A \in \mathbb{R}^{n \times n}, n \in \mathbb{N}$$
The **multiplicative identity** also doesn't change the outcome when multiplied by a vector. 
$$\underline{I}_3 = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 1 \end{bmatrix}, \quad\quad AI_n = A \quad \text{and} \quad I_m A = A \quad \forall A \in \mathbb{R}^{m \times n}$$
---

### Law of Transposition
If you are transposing two matrices which you multiply together, you need to reverse the order when you transpose
$$(AB)^T = B^T A^T$$
> LHS ($(AB)^T$) is saying to matmul AB and transpose the output. The Law of Transposition says that final output is the same as transposing both matrices and reversing the order of the matmul. 
> 
> The reversal is necessary because transposition swaps dimensions: if $A$ is $m \times k$ and $B$ is $k \times n$, their product $AB$ is $m \times n$, so $(AB)^T$ is $n \times m$. Multiplying the individual transposes as $A^T B^T$ would try to multiply an $(k \times m)$ by an $(n \times k)$ matrix—which violates the dimension compatibility rule. Reversing them to $B^T A^T$ multiplies $(n \times k)$ by $(k \times m)$, correctly producing the $(n \times m)$ output.

---
### Solving Matrix Equations
Matmul can be considered as answering: $\textbf{Basket + questions} \underset{\text{matmul}}{\rightarrow} \textbf{answers}$. This is called a matrix question: 
$$\underbrace{A}_{\text{known}} \quad \underbrace{X}_{\text{unknown}} = \underbrace{Y}_{\text{known}}$$
However, what happens when either "basket" or "questions" is unknown: $\textbf{? + questions} \underset{\text{matmul}}{\rightarrow} \textbf{answers}$
$$\begin{bmatrix} 1.50 & 0.75 \\ 0.5 & 0.25 \end{bmatrix} \begin{bmatrix} x_{11} & x_{12} \\ x_{21} & x_{22} \end{bmatrix} = \begin{bmatrix} 6 & 4.50 \\ 2 & 1.5 \end{bmatrix}$$
---
### Number Based Algebra
With number based algebra, we use backward logic to work out an unknown variable by applying the fundamental rule of algebra: Any operation applied to one side of an equation must be applied equally to the other side to preserve equality. 

The key tool for this task is the "inverse". Every non-zero number $x$ has a multiplicative inverse $x^{-1}$ (the reciprocal, $\frac{1}{x}$) such that:
$$x^{-1} \times x = x \times x^{-1} = 1$$
Consider this, we start with an equation: 
$$4 \cdot \text{🍌} = 12$$
Multiply both sides by the inverse of 4 ($4^{-1}$):
$$4^{-1} \times (4 \cdot \text{🍌}) = 4^{-1} \times 12$$
Use the inverse identity ($4^{-1} \times 4 = 1$):
$$1 \cdot \text{🍌} = 4^{-1} \times 12$$
Evaluate:
$$\text{🍌} = \frac{1}{4} \times 12 = 3$$
---
### Matrix Base Algebra
This scalar inverse logic ($4^{-1} \times 12 = 3$) ports directly into linear algebra to solve a system of linear equations of the form $A\underline{x} = \underline{y}$

It should be noted that division does not exist for linear algebra therefore we need to work only with multiplication. Therefore, if our goal is to isolate the unknown vector $\underline{x}$ then both sides need to be **left-multiplied** by the matrix inverse $A^{-1}$. Order matters because matrix multiplication is non-commutative, we must multiply by $A^{-1}$ from the left on both sides:
$$A^{-1}A\underline{x} = A^{-1}\underline{y}$$
Since $A^{-1}A = \underline{I}_2$ (the identity matrix, which acts like multiplying by $1$), this simplifies directly to:
$$\underline{x} = A^{-1}\underline{y}$$
This equation tells us that to find $\underline{x}$ we need to know the inverse of $A$. Work from hand this is not a trivial thing to compute, however, it is extremely simple in programming languages. 

---
### Non-Invertible Matrices
Not all matrices have an inverse. In parrell, for numbers 0 has no inverse. Therefore, non-invertible matrices behave like zero. This means two things, either: 
- An equation with a non-invertible matrix has no solution, i.e. ($0 * x =20$)
- An equation with a non-invertible matrix has infinite solutions, i.e. ($0 * x = 0$)
Problems like this are solved using optimisation which is a topic for later in the module. 

A square matrix is non-invertible if there exists a non-zero solution to $𝐴\underline{x} = \underline{0}$. This means when you matmul you end up with a zero matrix. This represents a slight difference to numbers as there we only get 0 when mutliplying by zero. With matrices, we can get 0 where nothing in the matrix is 0. 

These non-invertible situations tend to happen where there are correlations in the matric, for example, the bottom row is a scaled version of the top. 

---

### Tall or Wide Systems
This notion of questions (LHS, rows) and unknown variables (LHS, cols) is really important for determining the type of problem we are facing. 

**1. Square Systems: $m = n$ ("Questions = Unknowns")**
$$\begin{bmatrix} \bullet & \bullet \\ \bullet & \bullet \end{bmatrix} \begin{bmatrix} \bullet \\ \bullet \end{bmatrix} = \begin{bmatrix} \bullet \\ \bullet \end{bmatrix}$$
Here you have exactly as many distinct pieces of information as you have unknowns. If the questions (rows) are **linearly independent** (none of the equations are redundant or contradictory), there is **exactly one unique solution**.

**2. Tall Systems: $m > n$ ("Questions > Unknowns")**
$$\begin{bmatrix} \bullet & \bullet \\ \bullet & \bullet \\ \bullet & \bullet \end{bmatrix} \begin{bmatrix} \bullet \\ \bullet \end{bmatrix} = \begin{bmatrix} \bullet \\ \bullet \\ \bullet \end{bmatrix}$$
More rows than columns—meaning you have more constraints/measurements than variables to satisfy them. The system is over-constrained. If the questions are independent, there is generally **no exact solution** that makes all equations exactly true.

**3. Wide Systems: $m < n$ ("Questions < Unknowns")** 
$$\begin{bmatrix} \bullet & \bullet & \bullet \\ \bullet & \bullet & \bullet \end{bmatrix} \begin{bmatrix} \bullet \\ \bullet \\ \bullet \end{bmatrix} = \begin{bmatrix} \bullet \\ \bullet \end{bmatrix}$$
Fewer rows than columns—meaning you have more variables than pieces of information to pin them down. This is under-constrained system which usual has usually has infinite possible answers. Optimisation is used to pick the best. 

--- 
# Linear Algebra Part 2: Geometric
1. [[#Vector Spaces]]
2. [[#What is a Field ($K$)?]]
3. [[#Vector Space Rules]]
4. [[#Spans]]
5. [[#Canonical Basis Vectors]]
6. [[#Geometric Interpretation of Vectors]]
7. [[#Flexibility of Basis Vectors and Co-Ordinate Systems]]
8. [[#Subspace Exercise]]
9. [[#Definition of the Span]]
	1. [[#1. Contains the Zero Vector ($ mathbf{0} in S$)]]
	2. [[#2. Closed Under Vector Addition]]
	3. [[#3. Closed Under Scalar Multiplication]]
10. [[#Linear Independence]]
11. [[#Formal Linearly Dependent Definition]]
12. [[#New Way of Multiplying Matrices]]
13. [[#Image of the Matrix]]
14. [[#Rank of Matrix]]
15. [[#Interim Summary]]
16. [[#Dot Product Geometric]]
17. [[#Dot Product Projects]]
18. [[#Correlation]]
### Vector Spaces
When we think of vector, we think of a long list of numbers. But actually, vectors are a much more abstract thing. A vector/matrix can represent many things, e.g. images, audio, signals, and therefore, we can apply linear algebra as these items. 
$$\begin{bmatrix} 3 \\ 5 \\ 4 \end{bmatrix} \in \mathbb{R}^3$$
So what is a vector to a mathematician? **A vector is an object that lives in a vector space.**

Clearly this leads to the question, what is a Vector Space? 
We are going to be defining vectors not by what they are but how they interact with each other. 



---
#### What is a Field ($K$)? 
When we say $\mathbb{R}^3$ we are denoting a vector with 3 dimensions comprised of Real numbers. $\mathbb{R}$ is field. A field is a collection of "scalars", which satisfy certain properties.

Normally $\mathbb{R}$ is the default field, and it is really important as it has a $0$. However, sometimes it could be complex numbers $\mathbb{C}$.

Note that the axioms: integers $\mathbb{I}$ and nature $\mathbb{N}$ numbers are not fields

---
#### Vector Space Rules
The cheatsheet holds the full set of rules but there 3 main/interesting ones:

**Closure under addition:** $\forall \underline{v}, \underline{w} \in V : \underline{v}+\underline{w} \in V$ 
- This just says, if you add one vector to another the output is still in the vector space. 
---
**Closure under scalar multiplication:** $\forall \underline{v} \in V, k \in K : k\underline{v} \in V$
- If scaled by value in the field $K$ the vector still remains in $V$
---
**Additive identity and inverse:** 
- $\exists \underline{0} \in V : \underline{v} + \underline{0} = \underline{v} \quad \forall \underline{v} \in V$
- $\forall \underline{v} \in V \quad \exists -\underline{v} \in V : \underline{v} + -\underline{v} = \underline{0}$
- There exists a 0 item. 
---
#### Spans
Given two vectors, what can we reach through some combination of them. If a vector cannot be reached, it is not in the span.

If we have a cohort of vectors, like the movie ratings, if a vector is accessible through a combination of two other vectors then we can say is it in their span. 

---
### Canonical Basis Vectors
This is a special set of vectors $e_1$ and $e_2$. 

![tt](Files/basis_vectors.png)

You can reach any vector in the $\mathbb{R}^2$ field through a weighted combination of the canonical basis vectors. These vectors span $\mathbb{R}^2$.

We say if we take any vector $\underline{v} = \begin{bmatrix} v_1 \\ v_2 \end{bmatrix}$, we can reach it using a scaled combination of the basis vectors: $\underline{v} = v_1 \underline{e}_1 + v_2 \underline{e}_2$

### Geometric Interpretation of Vectors
When we right a vector like $\underline{v} = \begin{bmatrix} 3 \\ 4 \end{bmatrix}$ this is actually a physical geometric object. For 2 dimensions is it a simple arrow. 

When it comes to the basis vectors, we are just saying that the vector $\underline{v}$ is a scaled combination of the basis vectors, whatever they may be: $\underline{v} = v_1 \underline{e}_1 + v_2 \underline{e}_2$

### Flexibility of Basis Vectors and Co-Ordinate Systems
Given the canonical basis vectors span $\mathbb{R}^2$ then we we should be able to take most pairs of vectors and also reach the entire span $\mathbb{R}^2$. This is because we convert the vectors into scaled versions of the basis vectors 
$$\underline{v}_1, \underline{v}_2 \quad \underbrace{\to}_{\text{convert into}} \quad \underline{e}_1, \underline{e}_2 \quad \underbrace{\to}_{\text{convert into}} \quad \text{anything}$$

- $\underline{v}_1 = \begin{bmatrix} 1 \\ 3 \end{bmatrix}, \quad \underline{v}_2 = \begin{bmatrix} 2 \\ 1 \end{bmatrix}$
- $\underline{e}_1 = -\frac{1}{5}\underline{v}_1 + \frac{3}{5}\underline{v}_2$
- $\underline{e}_2 = \frac{2}{5}\underline{v}_1 - \frac{1}{5}\underline{v}_2$

However, we need $\underline{v}_1, \underline{v}_2$ to not be parallel. If they are then the combination reached can only be in one given direction. If they are not parallel then you can get anywhere. 

---
### Subspace Exercise
To show that $S = \text{span}(\{\mathbf{v}_1, \mathbf{v}_2, \dots, \mathbf{v}_n\})$ is a vector space inside $V$, you need to prove that it satisfies the criteria of being a **subspace** of $V$.

Because $S$ is a subset of an existing vector space $V$, it already inherits operations like associativity, commutativity, and distributivity from $V$. You only need to verify the **Three Subspace Conditions**:

1. **The zero vector is in $S$**
2. **$S$ is closed under vector addition**
3. **$S$ is closed under scalar multiplication**

The span of any of a collection of vectors forms a vector space. It might be a subspace inside a higher or larger vector space.

---
#### Definition of the Span
By definition, the span of a set of vectors is the set of all possible **linear combinations**:
$$S = \left\{ c_1\mathbf{v}_1 + c_2\mathbf{v}_2 + \dots + c_n\mathbf{v}_n \;\middle\vert{}\; c_1, c_2, \dots, c_n \in \mathbb{R} \right\}$$
##### Step-by-Step Proof
---
##### 1. Contains the Zero Vector ($\mathbf{0} \in S$)

Choose all scalars to be zero: $c_1 = c_2 = \dots = c_n = 0$.
$$0\mathbf{v}_1 + 0\mathbf{v}_2 + \dots + 0\mathbf{v}_n = \mathbf{0}$$
Since $\mathbf{0}$ can be expressed as a linear combination of the vectors, **$\mathbf{0} \in S$**.
##### 2. Closed Under Vector Addition

Let $\mathbf{u}$ and $\mathbf{w}$ be any two arbitrary vectors in $S$. By the definition of $S$, they can be written as:
$$\mathbf{u} = a_1\mathbf{v}_1 + a_2\mathbf{v}_2 + \dots + a_n\mathbf{v}_n$$
$$\mathbf{w} = b_1\mathbf{v}_1 + b_2\mathbf{v}_2 + \dots + b_n\mathbf{v}_n$$
for some scalars $a_i, b_i \in \mathbb{R}$.

Now, add them together:
$$\mathbf{u} + \mathbf{w} = (a_1\mathbf{v}_1 + \dots + a_n\mathbf{v}_n) + (b_1\mathbf{v}_1 + \dots + b_n\mathbf{v}_n)$$
Regrouping the terms:
$$\mathbf{u} + \mathbf{w} = (a_1 + b_1)\mathbf{v}_1 + (a_2 + b_2)\mathbf{v}_2 + \dots + (a_n + b_n)\mathbf{v}_n$$
Since real numbers are closed under addition, each coefficient $(a_i + b_i)$ is just another scalar. Therefore, $\mathbf{u} + \mathbf{w}$ is a linear combination of $\{\mathbf{v}_1, \dots, \mathbf{v}_n\}$, which means **$\mathbf{u} + \mathbf{w} \in S$**.

##### 3. Closed Under Scalar Multiplication

Let $\mathbf{u} \in S$ and let $k$ be any scalar ($k \in \mathbb{R}$).

Multiply $\mathbf{u}$ by $k$:
$$k\mathbf{u} = k(a_1\mathbf{v}_1 + a_2\mathbf{v}_2 + \dots + a_n\mathbf{v}_n)$$
Distribute $k$:
$$k\mathbf{u} = (ka_1)\mathbf{v}_1 + (ka_2)\mathbf{v}_2 + \dots + (ka_n)\mathbf{v}_n$$

Each coefficient $(ka_i)$ is a real scalar. Therefore, $k\mathbf{u}$ is also a linear combination of the spanning set, meaning **$k\mathbf{u} \in S$**.

Because $S$ contains the zero vector and is closed under both addition and scalar multiplication, $S$ is a subspace of $V$, and therefore **$S$ is itself a vector space**.

---
### Linear Independence
The vectors below are not considered to be independent because you can make one by summing or some combination of the others. Here, the first vector plus 2 lots of the second vector equals the third vector. 
$$\begin{bmatrix} 1 \\ 3 \\ 1 \end{bmatrix}, \quad \begin{bmatrix} 4 \\ 2 \\ 0 \end{bmatrix}, \quad \begin{bmatrix} 9 \\ 7 \\ 1 \end{bmatrix}$$
Alternatively, you can sum up 3 non-zero amounts of all three and get to 0. 
$$1\underline{y}_1+2\underline{y}_2-\underline{v}_3=\underline{0}$$
By definition, a set of vectors $\{\mathbf{v}_1, \mathbf{v}_2, \mathbf{v}_3\}$ is **linearly independent** if and only if the equation:
$$c_1\mathbf{v}_1 + c_2\mathbf{v}_2 + c_3\mathbf{v}_3 = \mathbf{0}$$
forces all the coefficients to be zero:
$$c_1 = 0, \quad c_2 = 0, \quad c_3 = 0$$
This is called a "trivial solution". Our example demonstrates a non-trivial solution because the scalars are $c_1 = 1$, $c_2 = 2$, and $c_3 = -1$. Having any non-zero coefficients sum to zero makes the set **linearly dependent** because it proves that one vector is redundant. By rearranging the equation we can see the redundancy: 
$$\mathbf{v}_3 = 1\mathbf{v}_1 + 2\mathbf{v}_2$$
$\mathbf{v}_3$ lies entirely in the plane spanned by $\mathbf{v}_1$ and $\mathbf{v}_2$. This means adding $\mathbf{v}_3$ to the set does not expand the span: $\text{span}\{\mathbf{v}_1, \mathbf{v}_2, \mathbf{v}_3\} = \text{span}\{\mathbf{v}_1, \mathbf{v}_2\}$. 

Because the vectors depend on each other to reach zero without all coefficients vanishing, they fail the test for independence. The reasons for this is that the step returning to 0 must simply be undoing and therefore repeating the same movement as another vector. The third movement simply retraced the net progress of the first two. 

Imagine you just have the two canonical basis vectors and you are controlling these using a game console. You move up 1 and then the second canonical basis only allows you to move right, you cannot return. a third diagonal direction would allow you to return, but this is simply a combination of the original two. 

---
#### Formal Linearly Dependent Definition
A set of vectors $\{\underline{v}_i \in V\}_{i=1}^n$ is **linearly dependent** if there exist scalars $\{c_i \in K\}_{i=1}^n$, **not all zero**, such that:
$$\sum_{i=1}^{n} c_i \underline{v}_i = \underline{0}$$
- **$V$ and $K$:** $V$ is a vector space, and $K$ is the scalar field over which $V$ is defined (in standard linear algebra courses, $K$ is usually the real numbers $\mathbb{R}$ or complex numbers $\mathbb{C}$).
- **$\{\underline{v} \in V\}_{i=1}^n$:** Shorthand notation for the collection of $n$ vectors: $\{\underline{v}_1, \underline{v}_2, \dots, \underline{v}_n\}$.
- **$\exists \{c_i \in K\}_{i=1}^n$, not all zero:** "There exists" a set of scalars $(c_1, c_2, \dots, c_n)$ where at least one scalar $c_j \neq 0$.
- **$\sum_{i=1}^n c_i \underline{v}_i = \underline{0}$:** Expanding the summation gives:
$$c_1 \underline{v}_1 + c_2 \underline{v}_2 + \dots + c_n \underline{v}_n = \underline{0}$$
---
### New Way of Multiplying Matrices
When you multiply a matrix $A$ by a vector $\mathbf{x}$, the result is a **linear combination of the columns of $A$**, weighted by the entries of $\mathbf{x}$:
$$A\mathbf{x} = \begin{bmatrix} \mathbf{a}_1 & \mathbf{a}_2 \end{bmatrix} \begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = x_1 \mathbf{a}_1 + x_2 \mathbf{a}_2$$
$$\left[\begin{array}{c|c}
1.50 & 0.75 \\
0.5  & 0.25
\end{array}\right]
\begin{bmatrix} 3 \\ 2 \end{bmatrix}
= 3 \begin{bmatrix} 1.50 \\ 0.5 \end{bmatrix} + 2 \begin{bmatrix} 0.75 \\ 0.25 \end{bmatrix}$$
Viewing matrix-vector multiplication as a linear combination of columns—rather than the traditional "row dot product" method—shifts the focus from rote arithmetic to geometric and algebraic meaning.

When you write the linear system $A\mathbf{x} = \mathbf{b}$:
$$x_1 \mathbf{a}_1 + x_2 \mathbf{a}_2 + \dots + x_n \mathbf{a}_n = \mathbf{b}$$
This immediately reveals the condition for whether a solution exists: **$A\mathbf{x} = \mathbf{b}$ has a solution if and only if $\mathbf{b}$ lies in the span of the columns of $A$ (the column space).** The row-by-row method checks equations one by one, hiding this global geometric picture entirely.

In linear algebra, a matrix is best understood not as a table of numbers, but as a **linear transformation** mapping one space to another.
- The columns of $A$ tell you exactly where the standard basis vectors land:
    - $A \begin{bmatrix} 1 \\ 0 \end{bmatrix} = \mathbf{a}_1$ (where the $x$-axis vector goes)
    - $A \begin{bmatrix} 0 \\ 1 \end{bmatrix} = \mathbf{a}_2$ (where the $y$-axis vector goes)
- The vector $\mathbf{x} = \begin{bmatrix} 3 \\ 2 \end{bmatrix}$ simply says: "Take 3 steps along the transformed first axis and 2 steps along the transformed second axis."
---
### Image of the Matrix
By definition, the image (or column space) of a general matrix $A = [\mathbf{v}_1 \; \mathbf{v}_2 \; \dots \; \mathbf{v}_n]$ is the set of all possible outputs, which equals the span of **all** its columns:
$$Im(A) = span(\underline{v_1})$$
If one column is dependent on another then the image is only:
$$\text{Im}(A) = \text{span}(\{\mathbf{v}_1, \mathbf{v}_2\}) = \text{span}(\{\mathbf{v}_1\})$$
---
### Rank of Matrix
The definition of rank is precisely the dimension of the image (column space): 
$$rank(A) = dim(Im(A))$$
Note that the matrix is wrapped in the image, this is because the rank is number of linearly independent columns. Sometimes its called column rank. 

We think of the rank of a matrix as its number of linearly independent columns. If there are linearly dependant columns then would say the matrix is rank deficient because its rank is lower than it could be given the number of columns. 

Note, that the number of linearly independent columns will equal the number of independent rows. 

--- 
### Interim Summary
- The span of vectors forms a vector space 𝑉
- Linearly independent spanning vectors form a basis of 𝑉
- The number of basis elements is the dimension of 
- The columns of a matrix 𝑀 span Im(𝑀) (thus a subspace)
- Rank-deficient matrices have linearly dependent columns

---
### Dot Product Geometric
Mechanically, the dot product multiplies corresponding elements pairwise and sums them up, producing a **single scalar value** ($\mathbf{u} \cdot \mathbf{v} = \sum u_i v_i$).

Geometrically:
$$\mathbf{u} \cdot \mathbf{v} = \Vert{}\mathbf{u}\Vert{} \Vert{}\mathbf{v}\Vert{} \cos(\theta)$$
where $\theta$ is the angle between the two arrows

Because vector lengths ($\Vert{}\mathbf{u}\Vert{}$ and $\Vert{}\mathbf{v}\Vert{}$) are always non-negative, the sign of the dot product is determined entirely by $\cos(\theta)$:
- **Positive ($\mathbf{u} \cdot \mathbf{v} > 0$):** Acute angle ($\theta < 90^\circ$). The arrows generally point in the same direction (one casts a positive shadow onto the other).
- **Zero ($\mathbf{u} \cdot \mathbf{v} = 0$):** Right angle ($\theta = 90^\circ$). The arrows are perpendicular (orthogonal); neither projects onto the other.
- **Negative ($\mathbf{u} \cdot \mathbf{v} < 0$):** Obtuse angle ($\theta > 90^\circ$). The arrows point in opposing directions (one casts a backward shadow onto the other).

If the dot product is large, usually the angle between the vectors is small. If the output is small, the angle is large and the arrows are points away from each other. 

---
#### Dot Product Projects
The dot product measures how much of arrow $\mathbf{w}$ points along arrow $\mathbf{w}$. If you drop a perpendicular line from the tip of $\mathbf{v}$ onto the line spanning $\mathbf{w}$:
- Falling forward along $\mathbf{w}$ yields a positive result.
- Falling backward along $\mathbf{w}$ yields a negative result.
$$\langle \underline{v}, \underline{w} \rangle = \Vert{}\underline{w}\Vert{} \times \Vert{}\text{shadow}\Vert{}$$
![225](Files/dot_prod_proj.png)
$$\langle \underline{v}, \underline{w} \rangle \approx 1.4\Vert{}\underline{w}\Vert{}^2$$
![227](Files/dot_prod_proj_back.png)
$$\langle \underline{v}, \underline{w} \rangle \approx -0.8\Vert{}\underline{w}\Vert{}^2$$
Note, the shadow must have smaller norm than vector 𝑣 itself

---
### Correlation
The annoying thing about the dot product is that it magnifies big vectors. 

What if we take the dot product but then normalise both the sizes of both the vectors?
$$\operatorname{corr}(\underline{v}, \underline{w}) = \frac{\langle \underline{v}, \underline{w} \rangle}{\Vert{}\underline{v}\Vert{}_2 \Vert{}\underline{w}\Vert{}_2}$$
This is still a dot product but divided by the $L_2$ norms of these two vectors. This is correlation. 

Here, we are taking vector v and a vector w, and shrinking them back onto the unit circle. With the unit circle being the set of vectors which have an $L_2$ norm of 1. 

> Correlation is the normalised Dot Product. Normalising a vector in L2, which is what we normally do, is shrinking it onto the unit circle. So its L2 norm is one L2 norm is the Euclidean distance.

![[correlation_normalisation.png]]

---

# Linear Algebra Part 3: Transformations
1. [[#Recap Matrices Convert Coordinates (Transformations)]]
2. [[#About Linearity]]
3. [[#Why Linear Maps Matter The "Superpower" of Linear Algebra]]
4. [[#Kernel and Nullity]]
5. [[#The Kernel (Null Space) What Gets Crushed to Zero]]
6. [[#The Image (Column Space) What You Can Actually Reach]]
7. [[#The Conservation of Dimension Rank-Nullity Theorem]]
8. [[#Maps, Geometrically]]
9. [[#The Eigenvector–Eigenvalue Relationship]]
### Recap: Matrices Convert Coordinates (Transformations)
Two ways to think about transformations:
1. It simply changes the vector.
2. Or, it changes the entire coordinate system.

![[transformation_vector_vs_space.png]]

$e_1$ and $e_2$ are basis vectors if: 
- They span an entire space, e.g. $R^2$
- They're minimal spanning set, you can't remove 1 one of the basis vectors without losing the first property. 

$$\underline{e}_1 = \begin{bmatrix} 1 \\ 0 \end{bmatrix} \quad \underline{e}_2 = \begin{bmatrix} 0 \\ 1 \end{bmatrix}$$
An arbitrary vector $\underline{v}$ can be represented using the canonical basis vectors but it can also be represented using and set of spanning basis vectors ($\underline{f}_1, \underline{f}_2$). This is important because the representation of a vector $\underline{v}$ depends on its basis vectors. 
$$\underline{v} = 3\underline{e}_1 + 2\underline{e}_2 \quad , \quad \underline{v} = 1\underline{f}_1 + 2\underline{f}_2$$
We it comes to transformations, we thinking of a matrix as changing the coordinates of a vector $\underline{v}$. 

---
### About Linearity
In this section we define what linearity means and its meaning is a little different to high school mathematics 

$T : U \to V$ is a linear map (function) if: 
$$T(\underline{v} + \underline{w}) = T(\underline{v}) + T(\underline{w}) \quad \forall \underline{v}, \underline{w} \in U$$
$$T(c\underline{v}) = cT(\underline{v}) \quad \forall c \in K, \underline{v} \in U$$
Note, that $U$ and $V$ are vector space, i.e. $R^2$ to $R^3$. Also, $T$ just means a function $f()$, e.g. $f(x) = 4x$ where $x$ is either could be $\underline{v} + \underline{w}$.

The rules state that a transformation provides the same output whether it is applied to the elements then added or the elements are added then transformation (applying the map). Similarly, the result is the same whether the the vector is scaled before transforming or after. 

According to these rules, $T(x+1)$ is non-linear. This is because it violated the second rule. When $T(0)$ is scaled prior is becomes $Y=1$ but when it is scaled after the mapping it becomes $Y=3$. This is not linear, instead it is called affine which is linear plus a constant ($f(x) = Ax + b$). 

An example of something that isn't a linear map is $f(x) = x^2$ this is because $f(2 \cdot 1) = 4 \neq 2 f(1)$.

Multiplying a vector by a matrix always defines a linear transformation. Because matrix multiplication is built entirely out of scaling and addition (linear combinations). If you test any matrix multiplication against the two formal rules of linearity we looked at earlier:
1. **Additivity ($A(\mathbf{u} + \mathbf{v}) = A\mathbf{u} + A\mathbf{v}$):** Multiplying the sum of two vectors by a matrix gives the exact same result as multiplying them separately and adding them together.
2. **Homogeneity / Scaling ($A(c\mathbf{v}) = c(A\mathbf{v})$):** Scaling a vector by a constant before multiplying by the matrix gives the same result as multiplying by the matrix first and then scaling the output.

![[Screenshot 2026-11-07 at 16.10.30.png]]

Because the rows and columns of a matrix combine through simple dot products (multiplication and addition of numbers), it is mathematically impossible for matrix multiplication to curve, warp, or break the origin. Every matrix multiplication is, by definition, a linear map.

---
#### Why Linear Maps Matter: The "Superpower" of Linear Algebra
Suppose you have an abstract vector space $V$ with dimension $n$, possessing a basis $\{\underline{e}_1, \underline{e}_2, \dots, \underline{e}_n\}$. If you are given a **linear map** $T$, you do _not_ need to know how it acts on every single point in space. You are only given $n$ pieces of data: **where the basis vectors land** ($T(\underline{e}_i := \underline{f}_i$)).

Can you figure out how $T$ transforms **any** vector in the entirety of the vector space using _only_ those $n$ pieces of information?

Because a map is linear, it strictly obeys additivity and scaling ($T(c\underline{v}) = cT(\underline{v})$ and $T(\underline{v} + \underline{w}) = T(\underline{v}) + T(\underline{w})$). This unlocks a powerful shortcut:

Let $T: \mathbb{R}^2 \to \mathbb{R}^3$, where:
$$T(\underline{e}_1) = \begin{bmatrix} 2 \\ 1 \\ 3 \end{bmatrix}, \quad T(\underline{e}_2) = \begin{bmatrix} 3 \\ 2 \\ 1 \end{bmatrix}$$
If we want to transform $\underline{v} = \begin{bmatrix} 3 \\ 2 \end{bmatrix}$, we first break it into its basis components ($3\underline{e}_1 + 2\underline{e}_2$). Applying linearity gives:
$$T(\underline{v}) = 3 \, T(\underline{e}_1) + 2 \, T(\underline{e}_2) = 3 \begin{bmatrix} 2 \\ 1 \\ 3 \end{bmatrix} + 2 \begin{bmatrix} 3 \\ 2 \\ 1 \end{bmatrix}$$
For a completely arbitrary input vector $\underline{v} = \begin{bmatrix} v_1 \\ v_2 \end{bmatrix}$, the transformation is entirely governed by the weights:
$$T(\underline{v}) = v_1 \begin{bmatrix} 2 \\ 1 \\ 3 \end{bmatrix} + v_2 \begin{bmatrix} 3 \\ 2 \\ 1 \end{bmatrix}$$
Because the output is always a linear combination of the transformed basis vectors weighted by the input coordinates ($v_1, v_2$), we can bundle this operation directly into a matrix:
$$T(\underline{v}) = \begin{bmatrix} 2 & 3 \\ 1 & 2 \\ 3 & 1 \end{bmatrix} \begin{bmatrix} v_1 \\ v_2 \end{bmatrix}$$
You have **extrapolated the entire infinite function from just two "dots"** (the destinations of the basis vectors).  This rigidity and predictability are why applied mathematics and physics love linear systems. Even complex, messy real-world systems are constantly approximated as linear because once you know how the basis vectors behave, you know _everything_.

---
### Kernel and Nullity
When a linear transformation acts on a space, it can either preserve the dimensionality of the input or collapse it into a lower-dimensional shadow. The **kernel** tells you exactly what gets crushed into nothingness (the lost information), while the **image** tells you what survives (the reachable output space). The slides explore this through a grocery matrix relating quantities of apples and bananas to their total cost and weight:
$$A = \begin{bmatrix} 1.50 & 0.75 \\ 0.50 & 0.25 \end{bmatrix}$$
Here, column 1 represents an apple (costing £1.50 and weighing 0.5 kg), and column 2 represents a banana (costing £0.75 and weighing 0.25 kg). Notice that an apple costs twice as much and weighs twice as much as a banana; the two columns are scalar multiples of each other, meaning they lie on the exact same line.

---
#### The Kernel (Null Space): What Gets Crushed to Zero
In normal arithmetic, multiplying a non-zero number by another non-zero number can never yield zero. In linear algebra, however, a non-zero matrix can multiply a non-zero vector and completely extinguish it. The **kernel** (also called the _null space_) is defined as the set of all input vectors $\underline{x}$ that map directly to the zero vector
$$\ker(A) = \{\underline{x} : A\underline{x} = \underline{0}\}$$
In the grocery context, this corresponds to finding a basket of fruit that costs £0 and weighs 0 kg. Since one apple equals two bananas in both price and weight, buying 1 apple and selling 2 bananas (represented by the vector $\underline{x} = \begin{bmatrix} 1 \\ -2 \end{bmatrix}$) cancels everything out completely:
$$\begin{bmatrix} 1.50 & 0.75 \\ 0.50 & 0.25 \end{bmatrix} \begin{bmatrix} 1 \\ -2 \end{bmatrix} = \begin{bmatrix} 1.50(1) + 0.75(-2) \\ 0.50(1) + 0.25(-2) \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}$$
Because matrix transformations are linear, scaling this vector by any constant $c$ preserves the zero output ($A(c\underline{x}) = c(A\underline{x}) = \underline{0}$). Therefore, the kernel is not just a single isolated point; it is an entire vector space formed by the continuous line of all scalar multiples of that vector:
$$\ker(A) = \operatorname{span}\left\{\begin{bmatrix} 1 \\ -2 \end{bmatrix}\right\}$$
> The notation $\operatorname{span}\left\{\begin{bmatrix} 1 \\ -2 \end{bmatrix}\right\}$ means the collection of **every vector you can produce by multiplying $\begin{bmatrix} 1 \\ -2 \end{bmatrix}$ by any scalar $c$**. The reason **every one** of these scaled vectors belongs to $\ker(A)$ comes directly from the linearity rule $T(c\underline{v}) = cT(\underline{v})$.

Because this particular subspace is spanned by a single basis vector, it forms a **one-dimensional line** passing through the origin. The dimension of the kernel is called the **nullity**, so here $\operatorname{nullity}(A) = 1$. If there is no collapse the nullity is 0. A 2d space could have a nullity of 2 where the The transformation crushes every single point in the 2D plane directly into the origin $(0, 0)$. The entire input space $\mathbb{R}^2$ is in the kernel, so its dimension is $2$. Here this would be a zero matrix: 
$$\begin{bmatrix} 0 & 0 \\ 0 & 0 \end{bmatrix}$$
---
#### The Image (Column Space): What You Can Actually Reach
The **image** (also referred to as the _column space_ or _range_) is the set of all possible outputs $\underline{y}$ that can be generated by applying the matrix to any valid input vector $\underline{x}$:
$$\mathfrak{I}(A) = \{\underline{y} : \underline{y} = A\underline{x}\}$$
Because matrix-vector multiplication is simply a linear combination of the matrix's columns, the reachable outputs are strictly limited to whatever the columns can span. Looking at the matrix entries, every pound spent corresponds to a consistent price-to-weight ratio of £3 per kilogram ($\frac{1.50}{0.50} = \frac{0.75}{0.25} = 3$). Consequently, no matter what combination of fruit you purchase, the cost will always be three times the weight:
$$\mathfrak{I}(A) = \operatorname{span}\left\{\begin{bmatrix} 3 \\ 1 \end{bmatrix}\right\}$$
Even though the inputs come from a 2D plane ($\mathbb{R}^2$), the outputs are trapped on a single 1D line defined by the vector $\begin{bmatrix} 3 \\ 1 \end{bmatrix}$. The dimension of this reachable output space is called the **rank** of the matrix:
$$\operatorname{rank}(A) = \dim(\mathfrak{I}(A)) = 1$$
---
#### The Conservation of Dimension: Rank-Nullity Theorem
The fundamental relationship connecting these two concepts is the **Rank-Nullity Theorem**. Think of the dimension of the input space as a fixed budget of degrees of freedom. A transformation can either preserve an input dimension into the output space (contributing to the rank) or collapse it into the origin (contributing to the nullity):
$$\operatorname{rank}(A) + \operatorname{nullity}(A) = n \quad (\text{number of input dimensions / columns})$$
In this system, we started with 2 input dimensions ($n = 2$). One full dimension of freedom collapsed into the kernel ($\operatorname{nullity} = 1$), leaving exactly one dimension of reachable outputs ($\operatorname{rank} = 1$), satisfying $1 + 1 = 2$. If the two columns had not been parallel, the basis vectors would have spanned the full 2D plane: the image would be all of $\mathbb{R}^2$ ($\operatorname{rank} = 2$), and nothing non-trivial would have collapsed to zero, leaving the kernel containing only the origin ($\operatorname{nullity} = 0$)
$$A \underline{x} = (x_1 + 2x_2) \begin{bmatrix} 1 \\ 4 \\ 8 \end{bmatrix} + x_3 \begin{bmatrix} 2 \\ 5 \\ 0 \end{bmatrix}$$
Therefore if have a 3-d input matrix (transformation) where one of the columns is linearly dependent then we know the image will map to 2-dimensions. The Rank-Nullity Theorem tell us that the combination of the image ($\operatorname{rank}(A)$) and the dimensions of the kernel ($\operatorname{nullity}(A) = dims(\ker(A))$) must equal dimension of the input matrix which was 3. Therefore, the $dims(\ker(A)) = 1$ meaning there exists a 1 dimensions line in the input space that collapses to zero when the transformation is applied.  

Another thing to consider here is that because have a transformation that is loosing a rank, any arbitrary output vector also has infinite input vectors. Take for example: 
$$A \begin{bmatrix} 1 \\ 2 \\ 3 \end{bmatrix} = \begin{bmatrix} 11 \\ 25 \\ 20 \end{bmatrix}$$
Because of linearity, $Av + Aw$ is the same as $A(v + w)$ where $w$ is the kernel, giving is the same output. Here, we have established that $w$ is non-trivial, i.e. not a zeros, therefore ($v+w$) is unique vector that also maps to the same output vector
$$\text{Solution set} \quad \left\{ \underline{x} : A\underline{x} = \begin{bmatrix} 11 \\ 25 \\ 20 \end{bmatrix} \right\}?$$
The solution set of vectors that map to an arbitrary vector is the same as a know solution plus the set of vectors from the kernel.  
$$= \left\{ \begin{bmatrix} 1 \\ 2 \\ 3 \end{bmatrix} + \underline{v} : \underline{v} \in \ker(A) \right\}$$
---
### Maps, Geometrically
We've already said that rotation is a matrix. Can we actually make that? Can we find an arbitrary, fits all, rotation matrix?

...

#### The Eigenvector–Eigenvalue Relationship
When a matrix transforms most vectors, it does two things: it **rotates** them (changes their direction) and **scales** them (changes their length).

An **eigenvector** is a special non-zero vector that does **not change its direction** when transformed by the matrix. It remains on the exact same line passing through the origin.

The **eigenvalue** ($\lambda$) is the scalar that measures how much the eigenvector gets stretched, squished, or flipped along that line:

Eigenvector/value pair: $(\underline{v}, \lambda)$
$$A\underline{v} = \lambda\underline{v}$$
Notice what happens when the matrix acted on $\begin{bmatrix} 1 \\ 1 \end{bmatrix}$:
$$\begin{bmatrix} 3 & 2 \\ 2 & 3 \end{bmatrix} \begin{bmatrix} 1 \\ 1 \end{bmatrix} = \begin{bmatrix} 5 \\ 5 \end{bmatrix} = 5 \begin{bmatrix} 1 \\ 1 \end{bmatrix}$$
- **Eigenvector ($\underline{v}$):** $\begin{bmatrix} 1 \\ 1 \end{bmatrix}$ (and any scalar multiple of it along the line $y = x$). The transformation kept it pointing in the exact same direction.
- **Eigenvalue ($\lambda$):** $5$. The vector didn't rotate; it was simply scaled by a factor of $5$.

In short: an eigenvector identifies an axis in space that doesn't rotate under the transformation, and the eigenvalue tells you how much space stretches along that axis.

##### Definition
$v \in \mathbb{R}^n$ is an eigenvector of $A \in \mathbb{R}^{n \times n}$ if:
$$A \underline{v} = \lambda \underline{v},$$
for some scalar $\lambda \in K$ called the associated eigenvalue



---
# 3B1B
1. [[#Matrics as transformation functions]]
2. [[#Composition of Transformations]]
3. [[#Associativity]]
4. [[#Determinant, Inverse matrices, Column space, and Null space]]
5. [[#Change of Basis and Eigenvectors]] 

**| [Vectors](http://3blue1brown.com/?topic=linear-algebra&lesson=vectors) | [Linear Combinations](https://www.3blue1brown.com/?topic=linear-algebra&lesson=span) |  [Basis Vectors](https://www.3blue1brown.com/?topic=linear-algebra&lesson=span) |  [Linear Transformations](https://www.3blue1brown.com/?topic=linear-algebra&lesson=linear-transformations) | [Matrix Multiplications](https://www.3blue1brown.com/?topic=linear-algebra&lesson=matrix-multiplication) | [The Determinant](https://www.3blue1brown.com/?topic=linear-algebra&lesson=determinant) | [Inverse matrices, column space, and null space](https://www.3blue1brown.com/?topic=linear-algebra&lesson=inverse-matrices) | [Nonsquare matrices as transformations between dimensions](https://www.3blue1brown.com/?topic=linear-algebra&lesson=nonsquare-matrices) | [Dot products and duality](https://www.3blue1brown.com/?topic=linear-algebra&lesson=dot-products) | [Change of Basis](https://www.3blue1brown.com/?topic=linear-algebra&lesson=change-of-basis)**
## Matrices as transformation functions
Vectors are used to denote a point, or direction, in the dimensions of a given space, e.g. 2D. Semantically, matrices differ from vectors as their purpose is to encode a transformation. This is an important distinction to remember when we are trying to interpret a matrix applied to an arbitrary vector. 

To apply a transformation we need to a matrix-vector mutliplication: $\text{Matrix} \times \text{Vector} = M\mathbf{v}$. Order matters because the **LHS Matrix ($2 \times 2$) $\times$ Column Vector ($2 \times 1$):** $\underbrace{(2 \times \mathbf{2}) \quad (\mathbf{2} \times 1)}_{\text{Inner numbers match!}}$. 

But we need to think about what the vector represents in terms of the basis vectors. An any given vector is instruction on how to navigate the space using the basis vectors, i.e . $= a \begin{bmatrix} b \\ 1 \end{bmatrix} b \begin{bmatrix} 0 \\ 1 \end{bmatrix}$

A transformation could therefore be reimagined as a transformation on the space itself and the basis vectors. This is because whatever happens to the basis vectors, must happen to the vector representation itself. If the basis vectors are transformation then the vector representation will encode the transformation. 

We could write this something like:
$$T(x\hat{i} + y\hat{j}) = x T(\hat{i}) + y T(\hat{j})$$
Here we are writing the transformations like functions and applying the input vector to the transformed basis vectors
$$L(\vec{\mathbf{v}}) = x \begin{bmatrix} 1 \\ -2 \end{bmatrix} + y \begin{bmatrix} 3 \\ 0 \end{bmatrix} = \begin{bmatrix} 1x + 3y \\ -2x + 0y \end{bmatrix}$$
 What all of this is saying is that the two-dimensional linear transformation is completely described by just four numbers: The two coordinates for where lands, and the two coordinates for where lands.

Note, that if we are using the canonical basis, technically we do not need to work through the example like this. Instead, we can just directly apply the transformation to the input vector. This works because applying the transformation to the canonical basis just returns the matrix again. However, if we were using an alternative basis, then we couldn't just apply the transformation to the input vector.

 $\hat{i} = \begin{bmatrix} 1 \\ 0 \end{bmatrix} \quad \hat{j} = \begin{bmatrix} 0 \\ 1 \end{bmatrix}$        $\hat{i}$: $\begin{bmatrix} a & b \\ c & d \end{bmatrix} \begin{bmatrix} 1 \\ 0 \end{bmatrix} = \begin{bmatrix} a \\ c \end{bmatrix}$      $\hat{j}$: $\begin{bmatrix} a & b \\ c & d \end{bmatrix} \begin{bmatrix} 0 \\ 1 \end{bmatrix} = \begin{bmatrix} b \\ d \end{bmatrix}$

Because a linear transformation preserves scaling and addition (linearity), the transformed vector is just that same recipe applied to your _new_ basis vectors. 

However, if you decide to use custom basis vectors $\mathbf{v}_1$ and $\mathbf{v}_2$ instead, that exact same matrix **will not** give you the right answer anymore, because the numbers $x$ and $y$ in your input vector would now mean _"how much of $\mathbf{v}_1$ and $\mathbf{v}_2$ to use,"_ rather than how much of $\hat{i}$ and $\hat{j}$ to use.

If your entire coordinate system is built on custom basis vectors $\mathbf{v}_1$ and $\mathbf{v}_2$, and you want to represent a transformation _relative to those vectors_, the columns of your matrix change:
- **Column 1** must be where **$\mathbf{v}_1$** lands after the transformation.
- **Column 2** must be where **$\mathbf{v}_2$** lands after the transformation.

---
## Composition of Transformations
Sometimes we have multiple matrix transformations that we want to apply in succession. Like any linear transformation, it can be described with a matrix all of its own by following $\hat{i}$ and $\hat{j}$. Resulting, giving us a new vector matrix that captures the overall effect, e.g. applying a rotation then a shear. 
$$\underbrace{\begin{bmatrix} 1 & 1 \\ 0 & 1 \end{bmatrix}}_{\text{Shear}} \underbrace{\begin{bmatrix} 0 & -1 \\ 1 & 0 \end{bmatrix}}_{\text{Rotation}} = \underbrace{\begin{bmatrix} 1 & -1 \\ 1 & 0 \end{bmatrix}}_{\text{Composition}}$$
In general matrix multiplication form this looks like: 
$$\underbrace{\begin{bmatrix} a & b \\ c & d \end{bmatrix}}_{M_2} \underbrace{\begin{bmatrix} e & f \\ g & h \end{bmatrix}}_{M_1} = \underbrace{\begin{bmatrix} ? & ? \\ ? & ? \end{bmatrix}}_{M_2 M_1}$$
However, instead of doing traditional row, column and additional multiplication we can thinking about what the matrices are doing and follow the basis vectors ($\hat{i}$, $\hat{j}$)

$\begin{bmatrix} a & b \\ c & d \end{bmatrix} \begin{bmatrix} e \\ g \end{bmatrix} = e \begin{bmatrix} a \\ c \end{bmatrix} + g \begin{bmatrix} b \\ d \end{bmatrix} = \begin{bmatrix} ae + bg \\ ce + dg \end{bmatrix}$, $\begin{bmatrix} a & b \\ c & d \end{bmatrix} \begin{bmatrix} f \\ h \end{bmatrix} = f \begin{bmatrix} a \\ c \end{bmatrix} + h \begin{bmatrix} b \\ d \end{bmatrix} = \begin{bmatrix} af + bh \\ cf + dh \end{bmatrix}$
  $$\underbrace{\begin{bmatrix} a & b \\ c & d \end{bmatrix}}_{M_2} \underbrace{\begin{bmatrix} e & f \\ g & h \end{bmatrix}}_{M_1} = \underbrace{\begin{bmatrix} ae + bg & af + bh \\ ce + dg & cf + dh \end{bmatrix}}_{M_2 M_1}$$
  
---
## Associativity
That means if you have three matrices, A, B and C, and multiply them all, it shouldn't matter if you first compute A times B, then multiply the result by C, or if you first multiply B times C, then multiply the result by the matrix A on the left. In other words, does it matter where you put the parentheses.

The intuition makes more sense when you consider matrix multiplication as applying one transformation after another. if you first apply (C then B), then A, it's the same as applying C, (then B then A)

$(AB)C \stackrel{?}{=} A(BC)$

**Order** is really important when it comes to matrix multiplication, but there is a massive difference between **the order of the matrices** (which side they are on) and **the grouping of the parentheses** (which multiplication you calculate first). 

Look closely at the associative law: the actual left-to-right order of the matrices ($A$, then $B$, then $C$) **does not change**. The only thing the parentheses change is **the order in which you do the arithmetic**.

1. 1**Writing it as $(AB)C\mathbf{v}$:** You can think of this as calculating the combined matrix $(AB)$ first, or you can think of it as applying $C$ to the vector, then $B$ to that result, and then $A$ to _that_ result.
2. **Writing it as $A(BC)\mathbf{v}$:** You can think of this as calculating $(BC)$ first, but when applied to the vector, it _still_ means: apply $C$ to the vector, then $B$, then $A$.

Associativity just means that when you are chaining three or more operations together, it doesn't matter which pair you choose to multiply first—the final destination is identical.

---
## Determinant, Inverse matrices, Column space, and Null space
For any square ($n \times n$) matrix $A$, the determinant directly tells you whether the kernel contains non-zero vectors:
- **$\det(A) \neq 0 \iff \text{Ker}(A) = \{\underline{0}\}$** (Trivial kernel / Nullity = $0$)
- **$\det(A) = 0 \iff \text{Ker}(A) \neq \{\underline{0}\}$** (Non-trivial kernel / Nullity $\ge 1$)

The determinant measures how much a matrix scales area or volume:
- In 2D, $\vert{}\det(A)\vert{}$ is the area of the parallelogram formed by the columns.
- In 3D, $\vert{}\det(A)\vert{}$ is the volume of the parallelepiped formed by the columns.

If $\det(A) \neq 0$: Space stretches or flips, but its volume **never collapses to zero**. Because full dimension is preserved, no non-zero lines or planes get crushed down into a single point. The only input that lands on the origin $\underline{0}$ is the origin itself. Therefore, **$\text{Ker}(A) = \{\underline{0}\}$**.

A non-zero determinant represents a **one-to-one** (injective) transformations. 

If $\det(A) = 0$: The volume **collapses to zero**. A 3D space might get flattened into a 2D sheet, a 1D line, or a single point. To lose a dimension, an entire line or plane of non-zero input vectors must get crushed directly into the origin $\underline{0}$. The collection of all those crushed vectors is precisely the **kernel**. Therefore, $\text{Ker}(A)$ contains infinitely many non-zero vectors.

A zero determinant represents a **many-to-one** transformation. By definition the higher dimension has more points in the vector space, and therefore, we mapped to a lower dimension has to compress many points into a single point to redistribute the inputs. This is the key reason why a $\det(A) = 0$ has no inverse, as to get back to the higher dimension the transformation would need to be **one-to-many** which violates what a function is as it must only have 1 output. 

> Importantly, a transformation can take a vector from a lower to higher dimension. However, it will not fill out the entire higher dimension space as it does not have enough input points and a function cannot be one-to-many. Similarly, when we think of a transformation, we assume that the input space if the entire vector space, i.e. $R^3$. Mapping from $R^2$ to $R^3$ maps to a subspace, we can map back from this subspace to $R^2$, however, this is not an inverse as this requires a mapping of the full $\mathbb{R}^3$. An inverse function must be able to take _any_ point in the target space and send it back

> - T**he domain** is the whole space ($\mathbb{R}^2$).
> - **The image** is a subset (a 2D plane inside $\mathbb{R}^3$).
> 
> If you **restrict the target** strictly to that subset, you can invert it (via a left-inverse). - But it lacks a full, true inverse because the ambient space (R3\mathbb{R}^3R3) is too big and contains unreachable points.

Also note, that a $\det(A) = 0$ transformation does not map the entire space to the origin, this can only be achieved by the zero matrix. Instead it maps a **on-zero cohort** (a line, plane, or higher-dimensional subspace) to and through the origin. The matrix transformation will make the rest of the vector space to non-zero outputs. 

The reasons a standalone matrix is able to encode the information that there exists some vectors in the vector space that map to 0 but nots all of the vector space is because some of the columns are linearly dependent. Therefore, the matrix and determinant formula encode redundancy, gives us a circular computation that results in $0$. 

The key is to remember what a transformation does to the basis vectors. **Linear dependence** is redundancy and resulting means you can play the basis vectors against each other to cancel out to zero. The transformation encodes the basis vectors to a valid output space but it is restricted, e.g. the basis vectors are mapped to a 2d space but both on the same line ($\begin{bmatrix} 2 \\ 4 \end{bmatrix}$ is just $2 \times$ $\begin{bmatrix} 1 \\ 2 \end{bmatrix}$). 


Also, when $\det(A) \neq 0$ the matrix has an inverse $A^{-1}$. Multiplying both sides of $A\underline{x} = \underline{0}$ by $A^{-1}$ gives:
$$\underline{x} = A^{-1}\underline{0} = \underline{0}$$
There can be no other solution besides $\underline{x} = \underline{0}$.

When $det⁡(A)=0$ The matrix is non-invertible (singular). Its columns are linearly dependent, meaning you can combine them to cancel out to zero without setting all weights to zero ($c_1 \underline{v}_1 + \dots + c_n \underline{v}_n = \underline{0}$) Those non-zero weights form a non-zero vector in the kernel.

In some ways, stating that a transformation is zero-determinant is lacking in information. Some cases are much more limited and restricting than others. Given a $3 \times 3$ matrix, it could map to a plane (2d), line (1d) or a point (-d). To encode this nuance we can talk about the rank and say a transformation which reduces the space to a line has a rank of 1 -  or rank 2 for a two-dimensional plane. The rank means the number of dimensions in the output of a transformation. 

If a 3D transform has a non-zero determinant and its output fills all of 3D space, it has a rank of . This set of all possible outputs for your matrix, whether it's a line, a plane, or 3D space; is called the "column space" of your matrix. It means the columns of a matrix tell you where the basis vectors land and the span of those transformed basis vectors gives you all possible outputs. The column space is the span of the columns. 

A more precise definition of rank is the number of dimensions in the column space. A full rank matrix has no linear dependant columns and therefore the rank and dimensions are equivalent to the number of columns. 

---
## Change of Basis and Eigenvectors
A transformation typically changes a vector. Some special vectors remaining on the same span after transformation, meaning the transformation only squished or stretched the vector. 

When we talk about eigenvectors and $T(\underline{v}) = \lambda \underline{v}$, we are using an **active transformation**. The coordinate system ($\mathbb{R}^2$ with standard axes $\underline{e}_1, \underline{e}_2$) does **not** move. The matrix $A$ takes very vectors in the vector space and alters it, placing it in a new location in the existing coordinate grid. 

An eigenvector is a vector where its destination happens to land on the exact same straight line (span) from the origin that it started on. Its coordinates changed, but its direction relative to the origin didn't.

Another way to look at transformation is through a passive, change of basis and coordinate system. In this scenario we are changing the spaces grid and perspective by obtaining a different set of basis vectors. In can be helpful to do this as a transformation matrix can make the vector space look messy and complicated in the standard grid. By manipulating the perspective (basis) to align with the matrix's **eigenvectors**, the math and geometric intuition because trivial, based on stretching and squishing along the new grid lines. 

An eigenvector is a property active transformation but we eigenvectors by looking for the special coordinate system (basis change) where that motion becomes completely pure and un-entangled (just stretching along independent axes).

When you perform a passive transformation (change of basis) using eigenvectors, the eigenvectors become your new coordinate axes. Instead of using the standard canonical grid, you redraw your grid lines so they point _directly along the paths of the eigenvectors_.

Under an active transformation, the system of transformed vectors may look messy as it mixes the $x$ and $y$ coordinates together. However, an eigenvector transformed matrix  stops mixing coordinates as it only stretches or shrinks coordinates. In this new coordinate system, the matrix its turned into a diagonal matrix ($D$) where the diagonals are the eigenvalues ($\lambda_1, \lambda_2, \dots$).
$$\text{Standard Matrix } A \quad \xrightarrow{\text{Change of Basis}} \quad \text{Diagonal Matrix } D = \begin{bmatrix} \lambda_1 & 0 \\ 0 & \lambda_2 \end{bmatrix}$$
In the eigenvector grid, because the axes _are_ the eigenvectors, applying the transformation simply means multiplying each coordinate by its respective eigenvalue, resulting in pure, independent scaling along each axis.
$$\text{New Output} = \begin{bmatrix} \lambda_1 x \\ \lambda_2 y \end{bmatrix}$$
When you change your basis to the eigenvectors, you are putting on "eigenvector glasses." It reveals that the complicated transformation was actually just a set of independent stretches happening along hidden, natural pathways all along.

Note, that under this new eigen-transformation matrix, general vectors do not just get stretched or squished. They still change direction—unless they happen to lie directly on one of the new coordinate axes.
$$D = \begin{bmatrix} \lambda_1 & 0 \\ 0 & \lambda_2 \end{bmatrix}$$
Now, take a _general_ vector $\vec{x} = \begin{bmatrix} x \\ y \end{bmatrix}$ in this new coordinate system.
$$D \begin{bmatrix} x \\ y \end{bmatrix} = \begin{bmatrix} \lambda_1 x \\ \lambda_2 y \end{bmatrix}$$
- The $x$-coordinate got multiplied (stretched/shrunk) by **$\lambda_1$**.
- The $y$-coordinate got multiplied (stretched/shrunk) by **$\lambda_2$**.

Imagine a vector pointing diagonally at a $45^\circ$ angle, where $x = 1$ and $y = 1$. If $\lambda_1 = 2$ and $\lambda_2 = 3$, your new vector becomes: 
$$\begin{bmatrix} 2(1) \\ 3(1) \end{bmatrix} = \begin{bmatrix} 2 \\ 3 \end{bmatrix}$$
This means the direction changed, it started with a ratio of 1:1 but now is 2:3. But it got it got warped and pulled toward whichever axis had the larger eigenvalue.

In this new coordinate system, the $x$-axis and the $y$-axis _are_ the eigenvectors.  Changing the basis to the eigenvectors doesn't magically turn _every_ vector into an eigenvector. Instead, it rotates and stretches your perspective so that the special, non-warping pathways (the eigenvectors) are lined up straight with your coordinate grid.

When we think of eigenvectors in a passive, change of basis way, we are space through its own internal anatomy, rather than an arbitary grid. By changing your basis to align with the eigenvectors, we are rotating and scaling your perspective so that the coordinate axes now run along the natural "grain" of the transformation.

Let’s take a simple 2D transformation matrix:
$$A = \begin{bmatrix} 2 & 1 \\ 1 & 2 \end{bmatrix}$$
If you multiply $A$ by a random vector like $\begin{bmatrix} 3 \\ 1 \end{bmatrix}$, the coordinates get mixed up and warped in a messy way.

For this matrix, the eigenvectors are: 
- **Eigenvalue $\lambda_1 = 3$** has the eigenvector: $\vec{v}_1 = \begin{bmatrix} 1 \\ 1 \end{bmatrix}$ (Any vector on this $45^\circ$ line just gets tripled in length).
- **Eigenvalue $\lambda_2 = 1$** has the eigenvector: $\vec{v}_2 = \begin{bmatrix} -1 \\ 1 \end{bmatrix}$ (Any vector on this perpendicular line doesn't change length at all).

We build a matrix $P$ whose columns are literally our eigenvectors. This matrix represents our **new coordinate system** (our "eigenvector glasses"):
$$P = \begin{bmatrix} \vec{v}_1 & \vec{v}_2 \end{bmatrix} = \begin{bmatrix} 1 & -1 \\ 1 & 1 \end{bmatrix}$$
To view our original transformation $A$ through this new eigenvector coordinate system, we sandwich $A$ between $P$ and its inverse ($P^{-1}$):
$$D = P^{-1} A P$$
When you compute this matrix multiplication, $A$ transforms into a **diagonal matrix** ($D$):

$$D = \begin{bmatrix} 3 & 0 \\ 0 & 1 \end{bmatrix}$$
Look at that diagonal matrix $D$. It has $3$ and $1$ on the diagonal, and zeros everywhere else. If you take a _completely random, non-eigenvector_ input vector $\vec{x}$ and apply $D$ to it, it still gets warped and changes direction.

So why do we call it a "diagonal eigenvector matrix"? Because when we write $D = P^{-1}AP$, the matrix $A$ isn't just acting raw on the space. It is executing a 3-step pipeline for _any_ vector $\vec{x}$:
1. **Translate into the Eigenvector Grid ($P^{-1}$): **Take a random vector $\vec{x}$ and rewrite its coordinates in terms of how much of $\vec{v}_1$ and $\vec{v}_2$ it contains.
2. **Apply the Independent Stretch ($D$):** Multiply the $\vec{v}_1$ component by $3$, and the $\vec{v}_2$ component by $1$. Because we are in the eigenvector coordinate system, these stretches happen **independently** along the axes without cross-contamination.
3. **Translate Back to the Standard Grid ($P$):** Convert the resulting coordinates back into the original standard $x-y$ system.


> How do eigenvectors remain on the same axis line, even after a change in basis and coordinate system?

> These special vectors are called the "eigenvectors" of the transformation, and each eigenvector has associated with it what's called an "eigenvalue", which is the factor by which it's stretched or squished during the transformation.

> Each eigenvector span (line) has an associated eigenvalue. All vectors when transformed will stretch or squish by the given value. 

> Eigenvectors stay on the line without being rotated off of it.

> The basis formulation always goes, [inverse change of basis] [transformation], [change of basis matrix transformation] = [diagonal]

> Why diagonal? represents working in a coordinate system where basis vectors just get scaled during the transformation.

---

