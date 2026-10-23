The content for linear algebra started in Week 1 but the slides holding this content come from from [Week 3](./Weeks/Week_3/Files/week_3_slides.pdf). 

[3B1B Playlist](https://www.3blue1brown.com/?topic=linear-algebra)

---
Lecture 1 started by looking into the pure basics of Linear Algebra. 

We were introduced to the two foundational faces of Linear Algebra: **Symbolic** and **Geometric**. 

The symbolic leg involves working with indices, equations, algebraic manipulation, and numbers. Where as the geometric thinks in terms of spaces, transformations, directions, and shapes.

While linear algebra is **fundamentally a geometric discipline**, mastering the mechanics first provides the vocabulary needed to navigate the geometry later.

---
#### Core Primitives: Vectors, Matrices, and Tensors
To understand linear algebra we need to learn to core underlying substrate. 

---
##### Vectors
An ordered collection of numbers. Unlike unordered sets, element positions matter ($v_1$ is distinct from $v_2$).

There are two types of vector orientations: 
- **Column Vector:** Formatted vertically ($n \times 1$). This is the default convention in mathematical literature.
- **Row Vector:** Formatted horizontally ($1 \times n$).
$$ \underline{p} = \begin{bmatrix} p_1 \\ p_2 \\ p_3 \\ \vdots \\ p_n \end{bmatrix} \qquad\text{,}\qquad \underline{p}^T = \begin{bmatrix} p_1 & p_2 & p_3 & \dots & p_n \end{bmatrix} $$
A key thing to remember here is the matrix notation is formatted as (*row*, *columns*) hence ($1 \times n$) is a row because it has depth of 1 row only. 

---
##### Matrices
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
##### Sets & Spaces Notation
- $\mathbb{R}$: The set of all real numbers.
- $\mathbb{R}^n$: The space of vectors containing $n$ elements, where each entry is a real number.
- $\mathbb{R}^{m \times n}$: The space of matrices with $m$ rows and $n$ columns.
---
#### Core Operations & Mechanics
Similarly, there are a set of fundamental operational tools that underpin linear algebra and its advanced techniques. 

---
##### Transposition ($T$)
This flips a matrix or vector over its diagonal—interchanging rows and columns. For the case of a vector it turns a $n \times 1$ column vector into a $1 \times n$ row vector: 
$$\underline{v} \xrightarrow{\text{transpose}} \underline{v}^T$$
---
##### Dot Product (Inner Product)
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
##### Matrix Multiplication ($AB$)
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
##### Norm
The magnitude of a number is it's distance from 0, e.g. $\vert{}-3\vert{} > \vert{}1\vert{}$. This becomes a little more complicated when looking at vectors as there is lots of numbers. To do this we need Norms which is the vectors notion of distXance from the zero vector.
$$\left\Vert{} \begin{bmatrix} \bullet \\ \bullet \end{bmatrix} \right\Vert{}, \left\Vert{} \begin{bmatrix} -2 \\ 3 \end{bmatrix} \right\Vert{}$$
A norm is easily demonstrated in a graph geometrically as vector arrows distance away from the centre axis. This method does not scale well when we move beyond 2/3 dimensions but working as this dimension level is a good way to learn and conceptualise linear algebra. 

![vector norm distance graph](Files/norm_graph.png)

However, this representation is only 1 possible type of Norm. Linear Algebra has many Norms which all measure the distance from zero. This module focused on 3 types which are the most popular for Machine Learnings. 

---
###### What Properties Should a Norm Have?
- **Non-Negativity** ($\|v\| \ge 0 \quad \forall v$): A distance by definition needs to be more than 0. There can't be a negative distance. 
- **Homogeneity of Scaling** ($k\Vert{}\underline{v}\Vert{} = \Vert{}k\underline{v}\Vert{} \quad \forall k \in \mathbb{R}$): This is the contingency that the Norm of vectors going in the same direct scale to their size. If a vector ($2\underline{v}$) is doubled in size then so should its Norm ($2\Vert{}\underline{v}\Vert{}$). 
- **Triangle Inequality** ($\|\underline{a} + \underline{b}\| \le \|\underline{a}\| + \|\underline{b}\| \quad \forall \underline{a}, \underline{b}$): The distance of "via" something will always be as long or longer than the direct route. 
---
###### The Three Norms

|**Name**|**Formula**|**Definition**|**Example**|
|---|---|---|---|
|**$L_1$ (Taxicab) Norm**|$\Vert{}\underline{v}\Vert{}_1 = \sum_{i=1}^n \vert{}v_i\vert{}$|Sum of the magnitudes of each element in a vector. Named after a taxicab navigating a grid-like street network.|$\Vert{}\underline{x}\Vert{}_1 = \vert{}2\vert{} + \Vert{}-4\Vert{} = 6$|
|**$L_2$ (Euclidean) Norm**|$\Vert{}\underline{v}\Vert{}_2 = \sqrt{\sum_{i=1}^n v_i^2}$|Straight-line length of the vector arrow from the origin. Derived from the Pythagorean theorem.|$\Vert{}\underline{x}\Vert{}_2 = \sqrt{2^2 + (-4)^2} = \sqrt{20}$|
|**$L_\infty$ (Maximum) Norm**|$\Vert{}\underline{v}\Vert{}_\infty = \max_i \vert{}v_i\vert{}$|Takes only the maximum absolute magnitude among all vector components.|$\Vert{}\underline{x}\Vert{}_\infty = \max(\vert{}2\vert{}, \vert{}-4\vert{}) = 4$|

---
###### Normalising Vectors 
Normalising a vector refers to the process of scaling a non-zero vector so that its length (magnitude) equals $1$, while preserving its original direction. A vector with a magnitude of $1$ is called a **unit vector** (commonly denoted with a "hat", e.g., $\hat{\underline{v}}$).

To normalise a vector, divide each component of the vector by its norm:
$$\hat{\underline{v}} = \frac{\underline{v}}{\Vert{}\underline{v}\Vert{}}$$
Doing this allows us to isolate direction from magnitude. Vectors inherently encode both direction and magnitude, this is why dot product isn't a perfect computation of correlation. Normalisation removes the effect of scale, allowing algorithms to compare the orientation or direction of vectors without bias from their lengths (e.g., in cosine similarity). Furthermore, scaling a vector by its own norm ensures the unit length of the resulting vector sums to $1$.

Unit vectors are commonly used in Machine Learning to prevent numerical explosions or decay during iterative calculations (such as gradient descent or iterative projections).

---
#### What is an Algebra?
> A framework for groups of objects to interact and make babies

This definition is in intentionally vague because no one thing is an algebra. Instead algebra is a set of rules to govern the interaction of something. The most common example of an algebra is numbers. Here we have a number of rules (Axioms) such as addition, multiplication and associativity which govern the use of numbers. 

> In algebra, an operation is **associative** if changing the grouping of operands with parentheses does not alter the final result, satisfying $(a * b) * c = a * (b * c)$.

Similarly we have an algebra for vectors/matrices. We have matrix multiplication, elementwise vector addition, scaling $3 \begin{bmatrix} 4 \\ 5 \end{bmatrix}$ and a given rule of associativity $(AB)C=A(BC)$.
In associativity brackets are really important tools to denote order. Order is also very important for multiplication in vector algebra because matmul is not commutative ($AB \ne BA$), unlike numbers algebra. Furthermore, there are additional rules on what vectors qualify for multiplication and additional as the vectors need to be compatible shapes

> Matrix multiplication $AB$ is valid only if the number of columns in the first matrix (or vector) matches the number of rows in the second matrix (or vector). When multiplying a size $m \times k$ matrix by a size $k \times n$ matrix, the matching inner dimensions $k$ allow the operation, producing an output of size $m \times n$.

This general concept is important to understand because there are algebgras for everything, each with their own axiom rules. Later we will study the axioms for probability and calculus. 

---
##### Special matrices

The **additive identity** is comprised of all zeroes and doesn't anything when added to another vector. 
$$\underline{0}_3 = \begin{bmatrix} 0 & 0 & 0 \\ 0 & 0 & 0 \\ 0 & 0 & 0 \end{bmatrix}, \quad A + \underline{0}_n = \underline{0}_n + A = A \quad\quad \forall A \in \mathbb{R}^{n \times n}, n \in \mathbb{N}$$
The **multiplicative identity** also doesn't change the outcome when multiplied by a vector. 
$$\underline{I}_3 = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 1 \end{bmatrix}, \quad\quad AI_n = A \quad \text{and} \quad I_m A = A \quad \forall A \in \mathbb{R}^{m \times n}$$
---

##### Law of Transposition
If you are transposing two matrices which you multiply together, you need to reverse the order when you transpose
$$(AB)^T = B^T A^T$$
> LHS ($(AB)^T$) is saying to matmul AB and transpose the output. The Law of Transposition says that final output is the same as transposing both matrices and reversing the order of the matmul. 
> 
> The reversal is necessary because transposition swaps dimensions: if $A$ is $m \times k$ and $B$ is $k \times n$, their product $AB$ is $m \times n$, so $(AB)^T$ is $n \times m$. Multiplying the individual transposes as $A^T B^T$ would try to multiply an $(k \times m)$ by an $(n \times k)$ matrix—which violates the dimension compatibility rule. Reversing them to $B^T A^T$ multiplies $(n \times k)$ by $(k \times m)$, correctly producing the $(n \times m)$ output.

---
##### Solving Matrix Equations
Matmul can be considered as answering: $\textbf{Basket + questions} \underset{\text{matmul}}{\rightarrow} \textbf{answers}$. This is called a matrix question: 
$$\underbrace{A}_{\text{known}} \quad \underbrace{X}_{\text{unknown}} = \underbrace{Y}_{\text{known}}$$
However, what happens when either "basket" or "questions" is unknown: $\textbf{? + questions} \underset{\text{matmul}}{\rightarrow} \textbf{answers}$
$$\begin{bmatrix} 1.50 & 0.75 \\ 0.5 & 0.25 \end{bmatrix} \begin{bmatrix} x_{11} & x_{12} \\ x_{21} & x_{22} \end{bmatrix} = \begin{bmatrix} 6 & 4.50 \\ 2 & 1.5 \end{bmatrix}$$
---
###### Number Based Algebra
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
###### Matrix Base Algebra
This scalar inverse logic ($4^{-1} \times 12 = 3$) ports directly into linear algebra to solve a system of linear equations of the form $A\underline{x} = \underline{y}$

It should be noted that division does not exist for linear algebra therefore we need to work only with multiplication. Therefore, if our goal is to isolate the unknown vector $\underline{x}$ then both sides need to be **left-multiplied** by the matrix inverse $A^{-1}$. Order matters because matrix multiplication is non-commutative, we must multiply by $A^{-1}$ from the left on both sides:
$$A^{-1}A\underline{x} = A^{-1}\underline{y}$$
Since $A^{-1}A = \underline{I}_2$ (the identity matrix, which acts like multiplying by $1$), this simplifies directly to:
$$\underline{x} = A^{-1}\underline{y}$$
This equation tells us that to find $\underline{x}$ we need to know the inverse of $A$. Work from hand this is not a trivial thing to compute, however, it is extremely simple in programming languages. 

---
###### Non-Invertible Matrices
Not all matrices have an inverse. In parrell, for numbers 0 has no inverse. Therefore, non-invertible matrices behave like zero. This means two things, either: 
- An equation with a non-invertible matrix has no solution, i.e. ($0 * x =20$)
- An equation with a non-invertible matrix has infinite solutions, i.e. ($0 * x = 0$)
Problems like this are solved using optimisation which is a topic for later in the module. 

A square matrix is non-invertible if there exists a non-zero solution to $𝐴\underline{x} = \underline{0}$. This means when you matmul you end up with a zero matrix. This represents a slight difference to numbers as there we only get 0 when mutliplying by zero. With matrices, we can get 0 where nothing in the matrix is 0. 

These non-invertible situations tend to happen where there are correlations in the matric, for example, the bottom row is a scaled version of the top. 

---

##### Tall or Wide Systems
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