| [Canvas](https://canvas.sussex.ac.uk/courses/38867/pages/week-5-summary-2?module_item_id=1669828) | [Recording](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=a707c175-360c-478d-bf9a-b4f100d6f000) |
# Goals
- Continued practice in coding matrix operations and matrix algebra
- Understand the concepts of norm, rank, linear mapping, kernel, basis, span, rotation, and inverse, for matrices
- Abstracting vectors/matrices  as particular representations of general 'vector spaces'
- Bases of a vector space, Kernels and Images of a matrix, the properties of a linear mapping.
- Manipulating matrices into convenient forms
---
# Files
- [Linear Algebra 3: Transformations](Files/week_5_LA_3_transformations.pdf)
- [Linear Algebra Cheatsheet](../Week_3/Files/LinearAlgebra_cheatsheet.pdf)

---
# Links
- [Linear algebra explained in four pages](https://minireference.com/static/tutorials/linear_algebra_in_4_pages.pdf)

**[3blue1brown](https://www.3blue1brown.com/?topic=linear-algebra) videos 1-5:**
- [x] [The Determinant](https://www.3blue1brown.com/?topic=linear-algebra&lesson=determinant)
- [x] [Inverse matrices, column space, and null space](https://www.3blue1brown.com/?topic=linear-algebra&lesson=inverse-matrices)
- [x] [Nonsquare matrices as transformations between dimensions](https://www.3blue1brown.com/?topic=linear-algebra&lesson=nonsquare-matrices)
- [x] [Dot products and duality](https://www.3blue1brown.com/?topic=linear-algebra&lesson=dot-products)
- [x] [Change of Basis](https://www.3blue1brown.com/?topic=linear-algebra&lesson=change-of-basis)

A transformation typically changes a vector. Some special vectors remaining on the same span after transformation, meaning the transformation only squished or stretched the vector. 

When we talk about eigenvectors and $T(\underline{v}) = \lambda \underline{v}$, we are using an **active transformation**. The coordinate system ($\mathbb{R}^2$ with standard axes $\underline{e}_1, \underline{e}_2$) does **not** move. The matrix $A$ takes very vectors in the vector space and alters it, placing it in a new location in the existing coordinate grid. 

An eigenvector is a vector where its destination happens to land on the exact same straight line (span) from the origin that it started on. Its coordinates changed, but its direction relative to the origin didn't.

Another way to look at transformation is through a passive, change of basis and coordinate system. In this scenario we are changing the spaces grid and perspective by obtaining a different set of basis vectors. In can be helpful to do this as a transformation matrix can make the vector space look messy and complicated in the standard grid. By manipulating the perspective (basis) to align with the matrix's **eigenvectors**, the math and geometric intuition because trivial, based on stretching and squishing along the new grid lines. 

An eigenvector is a property active transformation but we eigenvectors by looking for the special coordinate system (basis change) where that motion becomes completely pure and un-entangled (just stretching along independent axes).

When you perform a passive transformation (change of basis) using eigenvectors, the eigenvectors become your new coordinate axes. Instead of using the standard grid ($\underline{e}_1 = \begin{bmatrix} 1 \\ 0 \end{bmatrix}$ and $\underline{e}_2 = \begin{bmatrix} 0 \\ 1 \end{bmatrix}$), you redraw your grid lines so they point _directly along the paths of the eigenvectors_.

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

- [x] [Eigenvectors and eigenvalues](https://www.3blue1brown.com/?topic=linear-algebra&lesson=eigenvalues)
Above with change of basis
- [ ] [A quick trick for computing eigenvalues](https://www.3blue1brown.com/?topic=linear-algebra&lesson=quick-eigen)
- [ ] [Abstract Vector Spaces](https://www.3blue1brown.com/lessons/abstract-vector-spaces)



---
# Lecture
The notes for this lecture are continued in the [Linear Algebra](../../Linear_Algebra.md) page under Part 3: Transformations

---
# Lab





---