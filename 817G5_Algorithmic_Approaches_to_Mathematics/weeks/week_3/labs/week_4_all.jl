### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 8a5e3701-4d2d-4709-a7d3-a561cca1e1aa
using PlutoTeachingTools, PlutoUI, LinearAlgebra, Random

# ╔═╡ 910c0712-821b-4a82-b35d-d64516039d58
PlutoUI.TableOfContents()

# ╔═╡ e4786b86-cf37-47cb-a18b-a48e23fe6f8d
PlutoTeachingTools.ChooseDisplayMode()

# ╔═╡ 7d4f575e-e942-4730-a788-6e1fae369c28
md"""
# Warm-up questions

"""

# ╔═╡ 949525b7-ba63-49c2-b4ff-25e6d635f302
question_box(md"""

Let $A \in \mathbb{R}^{m \times n}$ and $B \in \mathbb{R}^{k \times p}$ be two matrices.

What relationship should hold between the $k,m,n,p \in \mathbb{N}$ for the matrix multiplication $AB$ to be allowable?
""")

# ╔═╡ 3fcf9402-1f09-4031-b647-0aef2b2ed12f
answer_box(md"""
We need the number of columns in $A$ to equal the number of rows in $B$. So the constraint is $n=k$
""")

# ╔═╡ ee12f122-7752-4a4d-95da-6349dbde5afb
question_box(md"""

1. Fill in the missing function `matrix_multipy(A,B)` below. It should multiply the matrices $A$ and $B$

2. *(Optional)*: Build a **non-allocating function** `matrix_multiply!(C,A,B)`. It should multiply the matrices $A$ and $B$, and then write the output to $C$. Test it by building large random matrices (e.g. `rand(1000,1000)`), and using the `@time` macro to measure allocations EG 
`@time matrix_multiply!(zeros(1000,1000), rand(1000,1000), rand(1000,1000))`

""")

# ╔═╡ c2f1f129-1faf-4890-b6de-d4c32efaef90
answer_box(md"""
```julia	   
function matrix_multiply(A,B)
	num_rows = size(A)[2] # can also use size(A,2)
	num_cols = size(B)[2]
	
	ith_sum(i,k) = sum(A[i,j]*B[j,k] for j in 1:num_rows) # a nested function
	
	return [ith_sum(i,k) for i in 1:size(A,1), k in 1:num_cols] # a list comprehension
end
```
"""
	)

# ╔═╡ 2bc831d4-b0c3-40df-b3da-0de07849ad60
answer_box(
md"""
```julia
function matrix_multiply!(C,A,B)
	
	ith_sum(i,k) = sum(A[i,j]*B[j,k] for j in 1:size(A,2))
	for i in 1:size(C,1)
		for k in 1:size(C,2)
			C[i,k] = ith_sum(i,k)
		end
	end
end
```
""")

# ╔═╡ d9dcb2df-9bef-41d8-8d30-ead194ca7de5
function matrix_multiply(A,B)
	return A
end

# ╔═╡ d533fad2-dc2d-4ecd-b569-e610377dc3e3
begin
	A,B = randn(10,10), randn(10,10)
	correct_matmul = (matrix_multiply(A,B) ≈ A*B)
	correct_matmul ? correct() : keep_working();
end

# ╔═╡ 8ddfd786-d481-4029-89be-3676ebfbf390
	correct_matmul && confetti()

# ╔═╡ d2f72333-3a64-42b6-b1e1-5794cb8f338d
md"""
## Useful videos

(Of course, the entire linear algebra series of these youtube videos is great if you really want to understand the concepts. We don't have time to cover everything in this module)
"""

# ╔═╡ 9b12aed7-5fe2-4162-8823-f94d04fd6011
html"""
<iframe width="560" height="315" src="https://www.youtube.com/embed/Ip3X9LOh2dk?si=Fag8JsyQnG6dOfVG" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
"""

# ╔═╡ 92c3d25f-ba36-429b-8515-f962d2eff8e8
html"""
<iframe width="560" height="315" src="https://www.youtube.com/embed/PFDu9oVAE-g?si=abUKzLl7jTr1yMg5" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
"""

# ╔═╡ b08edae5-1b12-4a78-90f0-da17a6637cfa
md"""
# Solving systems of linear equations

Let's start with a [rhetorical](https://en.wikipedia.org/wiki/Rhetorical_question) maths question.

!!! info "Rhetorical question"
	- I go to the market with a rucksack that can carry $5kg$ of fruit. I want to fill it. 
	- I have £12 of cash 
	- Apples are £3/kg. Bananas are £2/kg.
	How many kg of apples and bananas should I buy to use my money and fill my rucksack?

Maths questions are just wordy ways of **embedding constraints** (e.g. the constraint of having £12). To solve a question, the first step is to list the constraints mathematically:

$£3 \times 🍎 + £2 \times 🍌 = £12$
$🍎 + 🍌 = 5kg$

(where 🍌 and 🍎 represent the desired weight of each fruit, in kg)

In a more condensed form, this is:

$$\begin{align}
3&🍎 + 2🍌 &= 12 \\
1&🍎 + 1🍌 &= 5
\end{align}$$

We can write this as a matrix equation!... 

"""

# ╔═╡ ce124fbc-96f8-4159-b402-d8a42b477671
question_box(md"""
Find 🍎, 🍌 *such that:
	
 $$\begin{bmatrix} 
	3 & 2 \\ 1 & 1 
	\end{bmatrix}
	\begin{bmatrix}
	🍎 \\ 🍌
	\end{bmatrix} = 
	\begin{bmatrix}
	12 \\ 5
	\end{bmatrix}$$
""")

# ╔═╡ 58b49cd9-ea4a-43de-a843-466bf5a3e4f0
md"""
#### Important points:
1. **The question above is known as a matrix equation. Or a system of linear equations**. The general form of a matrix equation is:

!!! info "General matrix equation"
	Find $x$ such that $Ax = b$, where
	-  $A$ is a **known** matrix
	-  $b$ is a **known** vector 
	-  $x$ is an **unknown** vector
	Solving the equation consists of finding $x$.

2. Most computational mathematics problems in the world boil down to solving matrix equations. **It's a really important class of problem**. 
- Interestingly, **there is no computational method that can solve really big matrix equations efficiently**. If you have a vector $x$ of length $n$, you need **more than** $n^2$ computations to solve the problem (somewhere between $n^2$ and $n^3$). If $n = 1000,000$, well.... a million squared is a large number, and a million cubed even more so!
- There's an entire field of maths devoted to slightly speeding up solutions to this problem, e.g. see [here](https://www.quantamagazine.org/new-algorithm-breaks-speed-limit-for-solving-linear-equations-20210308/) for a fun news article on the topic.

"""

# ╔═╡ ed501188-d149-4747-8e3d-afe6d7531f65
md"""
### Solving on a computer

```x = A \ b``` 
will find an `x` that solves `Ax = b`.
See below.
"""

# ╔═╡ e5058de9-abb2-43d8-9096-ffb012ef21a6
[3;1;;2;1] \ [12; 5]

# ╔═╡ 100e52a0-a3c4-4509-a8c3-0212b6386620
tip(md"""

- Mathematically, we could have done `inv([3;1;;2;1]) * [12; 5]`
- Pragmatically, never compute matrix inverses unless you need to. They are computatationally burdensome, and prone to numerical error.

""")

# ╔═╡ c8e8b656-bad8-44d5-96da-b687327ccd74
md"""
## Solving by hand 
(is something you **never** need to do)

**Nevertheless**, understanding how matrix algebra works is important, so let's go through how you might do it:


### 1. What would make it an **easier** matrix problem?

- What's the easiest type of matrix equation to solve? Something like this?

$$\begin{bmatrix} 
	3 & 0 \\ 0 & 2 
	\end{bmatrix}\begin{bmatrix}
	🍎 \\ 🍌
	\end{bmatrix} = 
	\begin{bmatrix}
	\bullet \\ \bullet
	\end{bmatrix}$$

This is a **diagonal** matrix equation. If the matrix is diagonal, the unknowns have been decoupled, so you can solve them separately! You'd get: $🍎 = \frac{\bullet}{3}$, for instance (whatever $\bullet$ is). See below for how to write a diagonal matrix in julia (using LinearAlgebra.Diagonal):

"""

# ╔═╡ 91961a5b-3150-4168-8172-e50fc28820a1
Diagonal([3,4,5])

# ╔═╡ 8fa1cb00-1913-4080-bbc6-e68421dac9dc
upperT = [i<=j ? i+ j : 0 for i in 1:4, j in 1:4]

# ╔═╡ 3bf3d380-0997-4c92-81b2-7f1b35db4d82
md"""
- What's the next easiest type of matrix equation to solve? Something like this?

$$\begin{bmatrix} 
	3 & 1 \\ 0 & 2 
	\end{bmatrix}\begin{bmatrix}
	🍎 \\ 🍌
	\end{bmatrix} = 
	\begin{bmatrix}
	\bullet \\ \bullet
	\end{bmatrix}$$

This is an **upper triangular matrix**: Any entry below the diagonal is zero. Here is a larger example of an upper triangular matrix: $(latexify_md(upperT)).
"""

# ╔═╡ 95e9e315-2304-4d69-b716-a2fac785113c
tip(md"""
- In the markdown box above, look how I used the function a julia function: `latexify_md` inside my markdown.
- You can run any julia code in a markdown box by enclosing the julia code in <dollar sign>(code). 
- `PlutoTeachingTools.latexify_md` is a useful function: it writes out julia objects like matrices (e.g. `upperT` defined below) in latex!
- If you right-click on the $\LaTeX$ (i.e. the big matrix), you have the option to copy paste the $\LaTeX$ code. Neat!
""")

# ╔═╡ c2e432de-dd3b-4d83-b704-c9e6d55d83f0
md"""
Why are upper triangular matrix problems easy to solve?

- Well, the bottom row is solved immediately, as it only involves the bottom unknown. In the example above, $🍌 = \frac{\bullet}{2}$.
- If we have solved the bottom row, then the second-bottom row is solved immediately. We know the numerical value of 🍌 (i.e. `x[end]`) from the equation of the bottom row. We can substitute this in. Then the equation for the `[end-1]` row only has one remaining unknown: x[end - 1].
- ...and so on, iteratively, until we get to the top!

"""

# ╔═╡ a9e14425-c839-4d01-835e-361d992d1aa6
md"""
### 2. How can we **turn it into** an easier matrix problem?

- We already know that
$$\begin{align}
3&🍎 + 2🍌 &= 12 \\
1&🍎 + 1🍌 &= 5
\end{align}.$$

We can **add or subtract** one equation from the other, and it won't change the solution! For instance

$$\begin{align}
2&🍎 + 1🍌 &= 7
\end{align}.$$

(by subtracting the bottom equation from the top).

The golden rule of equations is that **you can do anything to the equation, as long as you do it to both sides of the equation**. As such, we can also multiply equations by any nonzero scalar. For instance

$$\begin{align}
3*(2&🍎 + 1🍌) &= 3*7
\end{align}.$$
so

$$\begin{align}
6&🍎 + 3🍌 &= 21
\end{align}.$$

**Matrix interpretation**: We are solving * an equivalent problem with the same answer* if we perform the following **row operations**:
- add or subtract rows from each other
- **swap** rows
- Multiply rows by a nonzero scalar.



So can you see why 
 $$\begin{bmatrix} 
	2 & 2 \\ 2 & 1 
	\end{bmatrix}
	\begin{bmatrix}
	🍎 \\ 🍌
	\end{bmatrix} = 
	\begin{bmatrix}
	10 \\ 7
	\end{bmatrix}$$
is the same problem?


"""

# ╔═╡ fe4f3da6-5613-4f6a-aa78-c385c7cb2ae2
question_box(md"""
Go back to the original problem armed with these tools:

$$\begin{bmatrix} 
	3 & 2 \\ 1 & 1 
	\end{bmatrix}
	\begin{bmatrix}
	🍎 \\ 🍌
	\end{bmatrix} = 
	\begin{bmatrix}
	12 \\ 5
	\end{bmatrix}$$

What sequence of row operations do you need to turn this into the answer?

$$\begin{bmatrix} 
	1 & 0 \\ 0 & 1 
	\end{bmatrix}
	\begin{bmatrix}
	🍎 \\ 🍌
	\end{bmatrix} = 
	\begin{bmatrix}
	2 \\ 3
	\end{bmatrix}$$

""")

# ╔═╡ b926e6a1-142b-47fb-ad06-396704b4a320
answer_box(md"""
1. Take away twice the bottom row from the top row.
2. Take away the new top row from the bottom row

In maths notation:

Let $M = \begin{bmatrix}
3&2 \\ 1 & 1
\end{bmatrix}$. Let $M_{i, \bullet}$ denote the $i^{th}$ row of $M$.

1. $M_{1, \bullet} \to M_{1, \bullet} - 2M_{2,\bullet}$
2. $M_{2, \bullet} \to M_{2, \bullet} - M_{1,\bullet}$

""")

# ╔═╡ f4aa4b49-1900-4377-a01c-b7e722d0ecb4
keyconcept("Gaussian elimination", md"""

We won't cover this in the course. However, **it's a good technique to understand if you want to do further work**. There are so many resources on the internet about Gaussian elimination, that I won't talk about it here.

It's basically a principled way of doing row operations, as we did above, to solve a matrix equation. And it works, no matter how big the matrix (although it is inefficient and slow).
""")

# ╔═╡ ab41918e-1af7-4f7b-a652-6e674aacd72c
question_box(md"""

1. Build a function `CheckUpperTriangular(A)` that takes any matrix $A$, and checks if it is upper triangular.

2. (Challenging, optional) Complete the function called `UpperTriangularSolve(A,b)`, that takes any upper triangular matrix $A$, and solves $Ax=b$ using your own algorithm. The easiest way is to start by solving the bottom row, and then work your way up, as described above. 




""")

# ╔═╡ bff486b1-30ff-4254-a5ed-7f72ae64c143
answer_box(md"""
```julia
function CheckUpperTriangular(A)

	# two nested functions below! now you can see why the technique is useful.
	iszero(index) = (A[index] == 0)
	isok(index) = (index[1] > index[2]) ? iszero(index) : true
	# isok returns false ONLY if index[1] > index[2] AND A[index] is not zero. Week 1 logic is useful for programming too!

	all(isok, CartesianIndices(A))
	# CartesianIndices(A) is an ITERATOR. It iterates through the (row, column) pairs of A
end
```
""")

# ╔═╡ d49345e0-3c1a-4d68-8093-199b6c696de1
function CheckUpperTriangular(A)
	return A
end

# ╔═╡ eee94bf3-4455-434d-8047-b6f7408da991
answer_box(md"""
```julia
function UpperTriangularSolve(A,b)
	num_cols = size(A,2)
	x = zeros(num_cols) 
	for i in num_cols:-1:1
		x[i] = (b[i] - sum(A[i,j]*x[j] for j = i+1:num_cols; init=0))/A[i,i]
	end
	return x
end
```
""")

# ╔═╡ 178764a9-211c-42be-8f94-108addc87512
function UpperTriangularSolve(A,b)
	return b
end

# ╔═╡ 569016b5-3420-48fe-ab18-32131e527573
if UpperTriangularSolve(upperT, [1;2;3;4]) ≈ upperT \ [1;2;3;4]
	correct()
else
	keep_working()
end

# ╔═╡ b9611135-5e61-4e44-9204-af4e2acba332
if UpperTriangularSolve(upperT, [1;2;3;4]) ≈ upperT \ [1;2;3;4]
	confetti()
end

# ╔═╡ 73eef9da-9e06-42a6-80c2-a43bf2841e71
if UpperTriangularSolve(upperT, [1;2;3;4]) ≈ upperT \ [1;2;3;4]
	confetti()
end

# ╔═╡ d63b2c66-4b0e-11ee-31ec-654efe7d8a86
md"""
# Matrix inverses

We've talked previously about **solutions** to matrix problems. Actually, there can be an entire **set** of solutions (the solution set). In maths notation:

$$S = \{ x \in \mathbb{R}^m : Ax = b \}$$, where $A \in \mathbb{R}^{m \times n}, \ b \in \mathbb{R}^n$.
"""

# ╔═╡ 0357880a-7fbf-4c4c-a7d7-76d6cf56afa6
question_box(md"""

Let's take:

$$A = \begin{bmatrix}
0 & 0 \\
0 & 1
\end{bmatrix}, \quad 
B = \begin{bmatrix}
2 & 0 \\
0 & 3
\end{bmatrix}
$$

Comment on the solution set for the following problems:

1.
$$Ax = \begin{bmatrix}
3 \\ 4
\end{bmatrix}$$

2.
$$Ax= \begin{bmatrix}
0 \\ 4
\end{bmatrix}$$

3. 

$$Bx = z  \text{ where } z \in \mathbb{R}^2$$

""")

# ╔═╡ c2f8dd92-71b5-4d56-854a-9f94b002bdb4
answer_box(md"""
1. There is no solution to 
$$Ax = \begin{bmatrix}
3 \\ 4
\end{bmatrix}$$. The constraint $$0x + 0y = 3$$ has no solution. 

2. There are infinite solutions to 
$$Ax = \begin{bmatrix}
0 \\ 4
\end{bmatrix}$$. The solution set is $$\{v \in \mathbb{R}^2: v_2 = 4\}$$ 

3. Given any $$z = [z_1, z_2]$$, if we take $$x = [\frac{1}{2} z_1, \frac{1}{3}z_2]$$, then $Bx = z$. This is the **unique** solution to $$Bx=z$$. We can prove this by contradiction:

Suppose $\exists x, y \in \mathbb{R}^2$ such that $$x \neq y$$ and $$Bx = By = z$$. Then $$B(x-y) = 0$$. Therefore $$2(x_1 - y_1)=0$$ and $$3(x_2 - y_2) = 0$$. Therefore $$x_1 = y_1$$ and $$x_2 = y_2$$. But this contradicts our initial assumption of $$x \neq y$$. Therefore, $$Bx=z$$ has a unique solution.


""")

# ╔═╡ f32369e3-5c4b-4bc1-a2c8-49d268f6c17e
question_box(md"""
1. Find a matrix $M \in \mathbb{R}^{2 \times 3}$ and a vector $b \in \mathbb{R}^2$ such that $$Mx=b$$ expresses the following constraints:

$$x_1 + x_2 + x_3 = 0$$
$$x_1 = -x_2$$

2. Consider a general matrix problem $Ax = b$:
- What aspect of the size of $A$ tells you the number of constraints in the matrix equation?
- What aspect of the size of $A$ tells you about the number of free variables? 
3. Is the solution set of $Ax = 0$ a vector space? 
4. Consider $S= \{x \in \mathbb{R}^2: Ax \neq 0 \}$. Is this a vector space? 
""")

# ╔═╡ f749475b-5c55-4bf7-a6a3-9b7cd7ba4e93
answer_box(md"""

1.$$\begin{bmatrix}
1 & 1 & 1 \\ 1 & 1 & 0
\end{bmatrix}x = \begin{bmatrix}
0 & 0
\end{bmatrix}$$

2.
- Number of rows: each row represents one simultaneous equation, which is a constraint on the possible values of $x$

- Number of columns: this is the dimensionality of $x$, i.e. the number of component variables it contains.

3. Yes. It's closed under addition and scalar multiplication. It has a zero element. 
4. No, because it has no zero element.

""")

# ╔═╡ ef4ef6b3-64c4-4825-aeb1-c7eea23fef26
md"""
!!! info "Notation"
	- For any matrix $A$, $$\{x : Ax = 0 \}$$ is known as the **kernel** of $A$. It is denoted $$\ker(A)$$.
	- If $$\ker(A) = \{0\}$$, then $$A$$ is called a **nonsingular matrix**. 
	- If $$\ker(A)$$ has nonzero elements, then $$A$$ is **singular**. 

	Meanwhile, the **range** of $A$ is defined as $\{b : \exists x : Ax = b \}$. In other words, the set of $b$ with a nonempty solution set for $Ax=b$. 
"""

# ╔═╡ 74c55f79-1d72-41b9-b011-6ffb426bf183
question_box(md"""
**These are harder questions to stretch those who have seen linear algebra before. Not going to be on the exam, or necessary for the rest of the course!**

These questions assume a square matrix $$A \in \mathbb{R}^{m \times n}$$. 


1. Suppose $$Ax = b$$. Note that we can consider the columns of $A$ as a set of vectors in $\mathbb{R}^n$. 
- Let's denote the $i^{th}$ column as $A_{\bullet, i}$. Can you write $b$ mathematically as a weighted sum of the columns? 

2. Is $b$ in the span of the columns of $A$? 

3. Suppose $A$ has a nonempty kernel. Can you show that the columns of $A$ are not linearly independent? 


4. What can you say about the span of the columns of $A$ if $\ker(A) \neq \{0\}$?
""")

# ╔═╡ 62141aa9-62a1-4f73-8b46-a0c652ccc79c
answer_box(md"""

1. If we wrote out the **usual** method of matrix multiplication, we would get:

$$b_i = \sum_{j=1}^n A_{ij}x_j$$
This is the formula for the $i^{th}$ row of $b$: $b_i$.

We can get the same result by considering $b$ as a weighted sum of the columns of $A$. Let $A_{\bullet, i}$ denote the $i^{th}$ column of $A$ (which is a vector). Then

$$b = \sum_{i=1}^n x_i A_{\bullet, i}$$.

Note that $x_i$, the $i^{th}$ element of $x$, is just a number here. 

2. This means that $b$ is in the span of the columns of $A$, as we have just written it as a weighted sum of the columns, where the numbers $x_i$ constitute the weights. 

Recall that the span of any set of vectors (i.e. the columns of $A$) forms a vector space.

3. Nonempty kernel means there is some nonzero $x$ such that $Ax = 0$. Writing this out like in question one:

$$0 = \sum_{i} x_i A_{\bullet, i}$$.

We can take one of the columns (e.g. the first) onto the left-hand-size (LHS) of this equation:

$$-x_1 A_{\bullet, 1} = \sum_{i=2}^n x_i A_{\bullet, i}$$

$$A_{\bullet, 1} = \sum_{i=2}^n -\frac{x_i}{x_1} A_{\bullet, i}.$$

But now we have written the first column as a weighted sum of the other columns! So the first column is in the span of the other columns. It is not linearly independent of them. Finished.


**Addendum**

*We showed above that removing one of the columns doesn't change the span. Therefore, the span of the columns of $A$ must form a vector space of dimension strictly less than $n$, since it's spanned with $n-1$ elements. Therefore*

$$\{b : \exists x : Ax = b \}$$ *(i.e. the range of $x$) is a lower dimensional vector subspace of dimension $n-1$ or less.*

For further reading if you're interested, see the [rank-nullity theorem](https://en.wikipedia.org/wiki/Rank%E2%80%93nullity_theorem) 
""")

# ╔═╡ eba8acd8-2de6-4afa-be71-cde392f89514
md"""



OK. So we've seen last week how a matrix can be viewed a *transformation*. It takes in an input vector $u$, and spits out an output vector $v$. It's a function!:

$$f(u) = Au$$.

Remember from week 1: functions (sometimes) have inverses!

!!! info " Week 1 Recap"
	- What's another name for an invertible function?
	- We are talking about a *full* inverse. What are the two types of *partial* inverses? What are the names of functions that have these partial inverses?





"""

# ╔═╡ 9313d596-bd17-4385-aca9-42cf127c9f96
answer_box(md"""
- Bijective function 

- Left and right inverse. Injective and surjective:
""")

# ╔═╡ 7f624e97-7f0d-4f05-8b28-4f43f8d84f06
question_box(md"""
**Harder, optional**

What constraint on the size of a matrix $M$ must hold for it to have both a left and right inverse? Think about the sizes of the inputs and outputs to $f(u)$. 
""")

# ╔═╡ 932bc70a-306c-4faf-bb32-43591ad4e2f6
answer_box(md"""

**Harder, skip if you like**

Suppose $A \in \mathbb{R}^{m \times n}$, i.e. it has size $m \times n$.

First:
- If $A$ is invertible, then $\ker(A) = \{0\}$. 
- This means the columns of $A$ are linearly independent, from the question above. 
- There are $n$ columns, and they each have length $m$. This means that $m \geq n$. If $m < n$, then you've found more than $m$ linearly independent vectors in $\mathbb{R}^m$, which means the dimension of the vector space $\mathbb{R}^m$ is more than $m$, which is a contradiction.

Second:
- If $A$ is invertible, then $A^T$ is invertible, with inverse $(A^{-1})^T$. 
- $A^T$ has $n$ rows and $m$ columns. We can repeat the argument above, replacing $A$ with $A^T$. We get that $n \geq m$.

Overall, we have that $m \geq n$ and $n \geq m$. So $m=n$. It's a square matrix.
""")

# ╔═╡ 5e318189-fdfc-44a1-bc69-16c98e01e80e
question_box(md"""
Build a matrix $M$ that collapses any vector onto the $x$-axis. In other words, a vector $(x_1,y, \dots)$ goes to $(x_2,0, 0, \dots, 0)$. Can $M$ be invertible? If not, why not? 

*It may help to recall the definition of a function from the first notebook*
""")

# ╔═╡ 605a940d-6616-4a8e-adb4-e0f62eb39a83
answer_box(md"""

All the rows of $M$, except the first, must only contain zeros. EG 

$$M = \begin{bmatrix}
1 & 4 &3 \\ 0 & 0 & 0 \\ 0 & 0 & 0
\end{bmatrix}$$

There are many reasons $M$ can't be invertible. One is that:

We can always find a nonzero vector $x$ that is orthogonal to the first row of $M$: $M_{1, \bullet}$. (*In other words, so that the dot product $(M_{1, \bullet})^Tx = 0$.*)

- We could find such an $x$ by rotating the first row by $\pi/2$ degrees.
- Or by taking (in code) `x[1:end-1] = M[1,1:end-1]` and `x[end] = -dot(x[1:n-1], M[1, 1:end-1])`

If $x$ is orthogonal to the first row of $M$, then $Mx = 0$. The orthogonality ensures that the first element $(Mx)_1$ is the number zero. All other elements of $Mx$ are zero by the design of $M$. 

This means that $M$ has a non-trivial kernel, as $x \in \ker(M)$ and $x \neq 0$. So $M$ is non-invertible. 

""")

# ╔═╡ 4592dae2-392f-44fe-bce2-f0bb470a603f
md"""
# Eigenvectors and eigenvalues
Now we are going to cover eigenvalues and eigenvectors. These are a really important concept!

!!! info "Definition: eigenvalues and eigenvectors"
	Consider a square matrix $A \in \mathbb{R}^{n \times n}$. $v \in \mathbb{R}^n$ is an **eigenvector** of $A$ if $\exists \lambda \in \mathbb{R}$ such that $$Av = \lambda v$$. Here, $\lambda$ is known as the **eigenvalue** associated with $v$  We call $(\lambda, v)$ the eigenvalue-eigenvector pair.

Intuition: $v$ is an eigenvector if **it doesn't change direction when transformed by $A$**. In other words, applying $A$ just scales it. See 3blue1brown video at the top of the notebook.

"""

# ╔═╡ 1a53cf60-bbcd-44ca-af9d-3d7e619d879b
question_box(md"""
Suppose an invertible matrix $A$ has a set of eigenvalue-eigenvector pairs: $\{(\lambda_i, v_i)\}_{i=1}^n$.

- What are the eigenvalues of $A^{-1}$?
- If $A$ is a rotation matrix that only rotates vectors, what are the eigenvalues of $A$? What property does $A^TA$ satisfy and why? *Tip, look back at lecture 4!*

""")

# ╔═╡ 59e8a422-ee57-4a4a-a62e-2e6e4e926e97
answer_box(md"""

Take any eigenvector-value pair $(\lambda, v)$, of $A$

-  $Av = \lambda v$
-  $A^{-1}Av = v$ 
- So $A^{-1}(\lambda v) = v$
- We can divide both sides of the equation by $\lambda$ by linearity. So $A^{-1}v = \lambda^{-1}v$
- Hence $(\lambda^{-1}, v)$ is an eigenvalue-vector pair of $A^{-1}$.

Overall, for any eigenvalue $\lambda$ of $A$, we get that $\lambda^{-1}$ is an eigenvalue of $A^{-1}$, and it also has the same eigenvector.

If we're being complete, we should also ask whether there could be any extra eigenvalues for $A^{-1}$, which are not inverses of eigenvalues of $A$. The answer is no. Why? 

-  $A$ is an inverse to $A^{-1}$. 
- So by the above argument, for any eigenvalue $\lambda$ of $A^{-1}$, the inverse $\lambda^{-1}$ will be an eigenvalue of $A$, with the same eigenvector.

""")

# ╔═╡ 1581baac-9f0a-494f-9f2c-153a97421d17
md"""
# Matrix factorisations 
(also known as matrix decompositions)

**Take this section as a fun read, and extra practice on matrix manipulation. None of the content is critical**

Take a matrix $M$. If we can rewrite it as the **product** of two (or more matrices), then we have **factorized** $M$. 

So for instance $M = ABC$ is a decomposition of $M$. Just like $3*4*2$ is a factorisation of $24$!

There are many matrix decompositions with long names! Cholesky, LU, QR, SVD. In fact matrix factorizations are an **abstract type** in the LinearAlgebra package. So you can see all the factorisations supported in LinearAlgebra with the code below:

"""

# ╔═╡ 84f9dbcd-4a8e-4f11-8a83-3dc288d36475
subtypes(Factorization)

# ╔═╡ e911b502-961b-4baf-beda-068bd32d9d48
md"""

What's the point of all these factorisations? Are they useful to know about or understand?

- Mostly, exotic factorisations are used to solve specific types of matrix equation (i.e. where the matrix has specific properties) more efficiently. Sometimes, they help when doing tricky matrix algebra (e.g. the Schur factorization). 

- Therefore they are **not that important** to end-users such as yourself, who are going to write ```A \ B``` to solve a matrix equation, and leave the details to the programming language. 

- It's however important to know they exist and what they amount to (i.e. what I wrote above) so that they don't sound intimidating if you do come across them!


**Also!**... 

When we are testing hypotheses in complex systems / data science research, sometimes we want to generate 'random' matrices to test our hypotheses on. Sometimes we want these random matrices to have specific properties. 

!!! info "Example"
	You've built a processing pipeline for some data represented in a matrix. EG people's exam grades for different modules. You hypothesise that there are hidden correlations, e.g. people that did well in English also do well in French. You build a customised pipeline, e.g. using something like [PCA](https://en.wikipedia.org/wiki/Principal_component_analysis) to see if this is true. 

	Does your pipeline work? Are there bugs? To check, you want to test your pipeline on different pieces of *fake, pseudo-data*, where you know the ground truth. So you might want to generate 'random' matrices with fixed eigenvalues (representing correlations in the data). How?



One decomposition is often useful for situations like this, when you want to construct `random' matrices with particular properties...

### The QR factorisation

"""

# ╔═╡ 356559cf-2e9a-44fe-ac57-5c001793cc36
md"""

!!! info "The QR factorisation"

	The QR factorisation of a matrix $M$ yields two matrices $Q$ and $R$, such that $M = QR$. Moreover
	1.  $Q$ is a rotation matrix, i.e. $Q^TQ = QQ^T  = \mathbb{I}$. 
	2.  $R$ is upper triangular

	In code: `Q, R = qr(M)`	

"""

# ╔═╡ 7569c12f-a1e5-4260-8c19-76e9e776627b
question_box(md"""

- Let $Q$ be a rotation matrix: $Q^TQ = \mathbb{I}$
- Let $Q_{\bullet, i}$ denote the $i^{th}$ column of $Q$.

What is the dot product of $Q_{\bullet, i}$ and $Q_{\bullet, j}$ where $i \neq j$? What about when $i = j$?

- Suppose $Q$ is a square matrix. What is the **range** of $Q$. *(Recalling that $Q$ is a rotation might help you answer this question more easily)*. What does this tell you about the span of the columns of $Q$?

- **Harder, optional**: Do the columns for $Q \in \mathbb{R}^{n \times n}$ form a basis for the vector space $\mathbb{R}^n$?  
""")

# ╔═╡ 9e19c32b-e988-423f-9fc8-e7ffb171a6e8
answer_box(md"""
- The dot product of $Q_{\bullet, i}$ and $Q_{\bullet, j}$ is the $(i,j)$ element of $Q^TQ$. And $Q^TQ = \mathbb{I}$.
- So the dot product is $1$ if $i=j$, and $0$ if $i \neq j$
- The range of $Q \in \mathbb{R}^{n \times n}$ is the entire vector space $\mathbb{R}^{n}$. Take any $b \in \mathbb{R}^n$. We can find an $x$ such that $Qx = b$ by taking the inverse rotation, i.e. $x = Q^Tb$. Then $QQ^T = \mathbb{I}$ so $Qx = b$.
- Yes. There are $n$ columns. Take any vector $b \in \mathbb{R}^n$. Take $x$ such that $Qx = b$. We can write $b$ as a weighted sum of the columns (see prev question), i.e.

$$b = \sum_{i=1}^n Q_{\bullet,i} x_i.$$

So $b$ is in the span of the columns of $Q$. So they span the whole vector space $\mathbb{R}^n$, as $b$ was chosen arbitrarily.

For the columns to be a basis, they have to span $\mathbb{R}^n$, and they have to be linearly independent. 

They are linearly independent. If not, we could delete one linearly independent columns without affecting the span. Then we would have $n-1$ vectors spanning $\mathbb{R}^n$. This would mean that the latter was an $n-1$ dimensional vector space, which it is not.

""")

# ╔═╡ ba8ec944-5a8a-4898-b3b7-eb8b7ac0d8ac
md"""
- The code below provides a method for generating a **symmetric** matrix consisting of random numbers, where the matrix has pre-specified eigenvalues:

- play with the input eigenvalues, and note that the output will be random, but will always have the right eigenvalues.
"""

# ╔═╡ 9cd94990-c73f-415a-9434-bff383ce947b
function generate_random_matrix(eigenvalues)
	n = length(eigenvalues)
	M = rand(n,n)
	Q,R = qr(M)
	D = Diagonal(eigenvalues)
	return Q'*D*Q
end

# ╔═╡ 14ec8285-13d4-4cf6-b75b-d42ef9395189
some_random_mat = generate_random_matrix(2:2:10)

# ╔═╡ feab02c5-58ad-4ab5-970e-3667aff8b4d3
srm_evecs = eigen(some_random_mat)

# ╔═╡ b033c067-d73a-4ec0-bc27-b1e427115f9b
md"""
Notice that we have generated a symmetric matrix composed of apparently random values, whose eigenvectors are as we specified. 

*Why does it have to be symmetric, mathematically?*
"""

# ╔═╡ 503dcd8b-25dc-4c02-aa79-cecb96a671bd
md"""



-  $(Q^TDQ)^T = Q^T D^T (Q^T)^T = Q^TD^TQ$
-  $D^T = D$, as diagonal matrices are symmetric.
- So $(Q^TDQ)^T = Q^TDQ$

"""

# ╔═╡ 5d1b7684-b844-4ebf-83c9-62d4395198be
question_box(md"""

#### Challenge: making your own matrix equation solver

1. You've already made an equation solver for upper triangular matrices 
2. You are allowed to use the qr decomposition.
3. Put the qr decomposition and your previous upper-triangular solution together to make a function that can solve all matrix equations!


""")

# ╔═╡ 7a33c2a6-e1e0-4265-9c59-35a3c13a2ce1
answer_box(md"""

- We want to solve $Ax = b$ for $x$.
- Take a QR decomposition, $A = QR$ where $Q$ is a rotation matrix
- Then we want to solve $QRx = b$
- Left-multiply both sides by $Q^T$. We get $Q^TQRx =  Rx = Q^TB$
-  $R$ is upper triangular, so we can use our previous function to solve this
See code below:

""")

# ╔═╡ f0898ce4-5199-4c1d-9123-7877705200f1
answer_box(md"""
```julia
function matrix_solve(A,b)
	Q,R = qr(A)
	return UpperTriangularSolve(R, Q'b)
end
```
""")

# ╔═╡ 8de0c496-875b-4bfc-887c-d629c354475a
function matrix_solve(A,b)
	return b
end

# ╔═╡ 1f74b8f5-22ca-46a4-9423-bb7ea43a4d57
function checksolve()
 	A, b = randn(4,4), randn(4)
	if matrix_solve(A,b) ≈ A \ b
		correct()
		confetti()
	else
		keep_working()
	end

end

# ╔═╡ 37304bec-db5c-463e-a2d2-8fca6a5c120f
checksolve()

# ╔═╡ dd6d9058-3930-4dfc-a5ee-396433bc9fbf
md"""
# A teaser on probability

- You can make a random matrix of size $(m,n)$ with the command `rand(m,n)`
- Notice that computers can only generate **pseudorandom** numbers: true randomness is really difficult to replicate!

- All programming languages using random numbers have the concept of a **random seed**.

- Look at the code below. Rerun it multiple times. Notice that the random numbers never change! 

- Now change the seed (ie the number 123) to something else, like 345

- Now the numbers change!
"""

# ╔═╡ 246b3ecc-fd27-4b71-913d-c245d6bb8ac9
begin
	Random.seed!(123)
	rand(5)
end

# ╔═╡ 057b5b7d-871e-4a06-9239-36a0e08e65dd
md"""
Now look at the code below that **doesn't** have a random seed. Notice that each time you run it, the random numbers change. 
"""

# ╔═╡ 3754709c-86f5-4d09-a995-74a97be3f275
rand(5)

# ╔═╡ 8e529bcc-d89a-408e-aeef-6b0f2ac20374
md"""
**What's going on?**

Essentially, the computer chooses random numbers from a **deterministic** (i.e. non-random) sequence. 

- The seed tells it which element of the sequence to start from

- Otherwise, it will take the seed from something like the current time, so that pseudorandom numbers always come out different, like in the no-seed case.

"""

# ╔═╡ c41da523-d3a1-4fef-92c2-1375d626f7eb
question_box(md"""

1. What's are the outcome space, event space, and probability function for generating a (pseudo) random matrix with the command `rand(m,n)`? (where $m,n \in \mathbb{N}$)?


2. Can you use the `generate_random_matrix` function from before to generate a matrix with a nonempty kernel? If not, why not? 

3. What's the probability of `rand(m,n)` generating a singular matrix? Why? 
""")

# ╔═╡ 83bc2674-6d69-418b-a1e5-dd18a7a0d01b
answer_box(md"""
`rand` generates a number between $0$ and $1$. Any such number. So the outcome space is 

$$\Omega = \{v \in \mathbb{R}^{m \times n}: v_{ij} \in [-1, 1], \ \forall i,j \}$$

In other words, the set of matrices consisting of elements between $-1$ and $1$.

*NB [a,b] is read as ''the **interval** $a$, $b$''. It denotes the set of numbers between $a$ and $b$*


- The event space is the set of sets of outcomes (if you want to be really finicky, the Borel $\sigma$ algebra of measurable sets of outcomes).

- The probability density function is uniform. 

- No. For $M$ to be singular / to have a nonempty kernel, it must have a zero eigenvalue. The probability of the eigenvalue being **exactly** zero is zero. Just like the probability of somebody being an exact height is zero.

""")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
PlutoTeachingTools = "~0.4.6"
PlutoUI = "~0.7.71"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.7"
manifest_format = "2.0"
project_hash = "eb1a858966b1ee126b4ca971775fca3755135162"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

    [deps.ColorTypes.weakdeps]
    StyledStrings = "f489334b-da3d-4c2e-b8f0-e476e12c162b"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4255f0032eafd6451d707a51d5f0248b8a165e4d"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.3+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "Ghostscript_jll", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "44f93c47f9cd6c7e431f2f2091fcba8f01cd7e8f"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.10"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoUI"]
git-tree-sha1 = "dacc8be63916b078b592806acd13bb5e5137d7e9"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.4.6"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "8329a3a4f75e178c11c1ce2342778bcbbbfa7e3c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.71"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "372b90fe551c019541fafc6ff034199dc19c8436"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.12"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╠═8a5e3701-4d2d-4709-a7d3-a561cca1e1aa
# ╟─910c0712-821b-4a82-b35d-d64516039d58
# ╟─e4786b86-cf37-47cb-a18b-a48e23fe6f8d
# ╟─7d4f575e-e942-4730-a788-6e1fae369c28
# ╟─949525b7-ba63-49c2-b4ff-25e6d635f302
# ╟─3fcf9402-1f09-4031-b647-0aef2b2ed12f
# ╟─ee12f122-7752-4a4d-95da-6349dbde5afb
# ╠═c2f1f129-1faf-4890-b6de-d4c32efaef90
# ╟─2bc831d4-b0c3-40df-b3da-0de07849ad60
# ╠═d9dcb2df-9bef-41d8-8d30-ead194ca7de5
# ╟─d533fad2-dc2d-4ecd-b569-e610377dc3e3
# ╟─8ddfd786-d481-4029-89be-3676ebfbf390
# ╟─d2f72333-3a64-42b6-b1e1-5794cb8f338d
# ╟─9b12aed7-5fe2-4162-8823-f94d04fd6011
# ╟─92c3d25f-ba36-429b-8515-f962d2eff8e8
# ╟─b08edae5-1b12-4a78-90f0-da17a6637cfa
# ╟─ce124fbc-96f8-4159-b402-d8a42b477671
# ╟─58b49cd9-ea4a-43de-a843-466bf5a3e4f0
# ╟─ed501188-d149-4747-8e3d-afe6d7531f65
# ╠═e5058de9-abb2-43d8-9096-ffb012ef21a6
# ╟─100e52a0-a3c4-4509-a8c3-0212b6386620
# ╟─c8e8b656-bad8-44d5-96da-b687327ccd74
# ╠═91961a5b-3150-4168-8172-e50fc28820a1
# ╟─3bf3d380-0997-4c92-81b2-7f1b35db4d82
# ╠═8fa1cb00-1913-4080-bbc6-e68421dac9dc
# ╟─95e9e315-2304-4d69-b716-a2fac785113c
# ╟─c2e432de-dd3b-4d83-b704-c9e6d55d83f0
# ╟─a9e14425-c839-4d01-835e-361d992d1aa6
# ╟─fe4f3da6-5613-4f6a-aa78-c385c7cb2ae2
# ╟─b926e6a1-142b-47fb-ad06-396704b4a320
# ╟─f4aa4b49-1900-4377-a01c-b7e722d0ecb4
# ╟─ab41918e-1af7-4f7b-a652-6e674aacd72c
# ╟─bff486b1-30ff-4254-a5ed-7f72ae64c143
# ╠═d49345e0-3c1a-4d68-8093-199b6c696de1
# ╟─eee94bf3-4455-434d-8047-b6f7408da991
# ╠═178764a9-211c-42be-8f94-108addc87512
# ╟─569016b5-3420-48fe-ab18-32131e527573
# ╟─b9611135-5e61-4e44-9204-af4e2acba332
# ╟─73eef9da-9e06-42a6-80c2-a43bf2841e71
# ╟─d63b2c66-4b0e-11ee-31ec-654efe7d8a86
# ╟─0357880a-7fbf-4c4c-a7d7-76d6cf56afa6
# ╟─c2f8dd92-71b5-4d56-854a-9f94b002bdb4
# ╟─f32369e3-5c4b-4bc1-a2c8-49d268f6c17e
# ╟─f749475b-5c55-4bf7-a6a3-9b7cd7ba4e93
# ╟─ef4ef6b3-64c4-4825-aeb1-c7eea23fef26
# ╟─74c55f79-1d72-41b9-b011-6ffb426bf183
# ╟─62141aa9-62a1-4f73-8b46-a0c652ccc79c
# ╟─eba8acd8-2de6-4afa-be71-cde392f89514
# ╟─9313d596-bd17-4385-aca9-42cf127c9f96
# ╟─7f624e97-7f0d-4f05-8b28-4f43f8d84f06
# ╟─932bc70a-306c-4faf-bb32-43591ad4e2f6
# ╠═5e318189-fdfc-44a1-bc69-16c98e01e80e
# ╟─605a940d-6616-4a8e-adb4-e0f62eb39a83
# ╟─4592dae2-392f-44fe-bce2-f0bb470a603f
# ╟─1a53cf60-bbcd-44ca-af9d-3d7e619d879b
# ╟─59e8a422-ee57-4a4a-a62e-2e6e4e926e97
# ╟─1581baac-9f0a-494f-9f2c-153a97421d17
# ╠═84f9dbcd-4a8e-4f11-8a83-3dc288d36475
# ╟─e911b502-961b-4baf-beda-068bd32d9d48
# ╟─356559cf-2e9a-44fe-ac57-5c001793cc36
# ╟─7569c12f-a1e5-4260-8c19-76e9e776627b
# ╟─9e19c32b-e988-423f-9fc8-e7ffb171a6e8
# ╟─ba8ec944-5a8a-4898-b3b7-eb8b7ac0d8ac
# ╠═9cd94990-c73f-415a-9434-bff383ce947b
# ╠═14ec8285-13d4-4cf6-b75b-d42ef9395189
# ╠═feab02c5-58ad-4ab5-970e-3667aff8b4d3
# ╟─b033c067-d73a-4ec0-bc27-b1e427115f9b
# ╟─503dcd8b-25dc-4c02-aa79-cecb96a671bd
# ╟─5d1b7684-b844-4ebf-83c9-62d4395198be
# ╟─7a33c2a6-e1e0-4265-9c59-35a3c13a2ce1
# ╟─f0898ce4-5199-4c1d-9123-7877705200f1
# ╠═8de0c496-875b-4bfc-887c-d629c354475a
# ╟─1f74b8f5-22ca-46a4-9423-bb7ea43a4d57
# ╟─37304bec-db5c-463e-a2d2-8fca6a5c120f
# ╟─dd6d9058-3930-4dfc-a5ee-396433bc9fbf
# ╠═246b3ecc-fd27-4b71-913d-c245d6bb8ac9
# ╟─057b5b7d-871e-4a06-9239-36a0e08e65dd
# ╠═3754709c-86f5-4d09-a995-74a97be3f275
# ╟─8e529bcc-d89a-408e-aeef-6b0f2ac20374
# ╟─c41da523-d3a1-4fef-92c2-1375d626f7eb
# ╟─83bc2674-6d69-418b-a1e5-dd18a7a0d01b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
