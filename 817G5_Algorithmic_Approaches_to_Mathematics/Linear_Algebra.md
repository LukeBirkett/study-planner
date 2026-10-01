The content for linear algebra started in Week 1 but the slides holding this content come from from [Week 3](./Weeks/Week_3/Files/week_3_slides.pdf). 


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

