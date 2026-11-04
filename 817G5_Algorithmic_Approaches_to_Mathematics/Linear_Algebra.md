The content for linear algebra started in Week 1 but the slides holding this content come from from [Week 3](week_3_LA_1_Symbolic.pdf). 

[3B1B Playlist](https://www.3blue1brown.com/?topic=linear-algebra)

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
1. [[#Linear Algebra Part 2: Mechanical]]
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
2. [[#Linear Algebra Part 2: Geometric]]
---
# Linear Algebra Part 2: Mechanical

---
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
#### 2. Closed Under Vector Addition

Let $\mathbf{u}$ and $\mathbf{w}$ be any two arbitrary vectors in $S$. By the definition of $S$, they can be written as:
$$\mathbf{u} = a_1\mathbf{v}_1 + a_2\mathbf{v}_2 + \dots + a_n\mathbf{v}_n$$
$$\mathbf{w} = b_1\mathbf{v}_1 + b_2\mathbf{v}_2 + \dots + b_n\mathbf{v}_n$$
for some scalars $a_i, b_i \in \mathbb{R}$.

Now, add them together:
$$\mathbf{u} + \mathbf{w} = (a_1\mathbf{v}_1 + \dots + a_n\mathbf{v}_n) + (b_1\mathbf{v}_1 + \dots + b_n\mathbf{v}_n)$$
Regrouping the terms:
$$\mathbf{u} + \mathbf{w} = (a_1 + b_1)\mathbf{v}_1 + (a_2 + b_2)\mathbf{v}_2 + \dots + (a_n + b_n)\mathbf{v}_n$$
Since real numbers are closed under addition, each coefficient $(a_i + b_i)$ is just another scalar. Therefore, $\mathbf{u} + \mathbf{w}$ is a linear combination of $\{\mathbf{v}_1, \dots, \mathbf{v}_n\}$, which means **$\mathbf{u} + \mathbf{w} \in S$**.

#### 3. Closed Under Scalar Multiplication

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
The span of vectors forms a vector space 𝑉

Linearly independent spanning vectors form a basis of 𝑉

The number of basis elements is the dimension of 

The columns of a matrix 𝑀 span Im(𝑀) (thus a subspace)

Rank-deficient matrices have linearly dependent columns

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

![correlation unit vector](Files/unit_vector_correlation.png)

---

