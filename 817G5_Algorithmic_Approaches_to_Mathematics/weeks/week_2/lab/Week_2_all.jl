### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 4b9383af-8968-4af2-9298-c9ce114bb675
using PlutoUI, PlutoTeachingTools

# ╔═╡ ebc737da-ea35-48d9-94c6-ad21350d6e37
PlutoUI.TableOfContents()

# ╔═╡ f20a64ce-139a-11ee-275b-913605c7dd62
md"""
# Iterables, induction and recursion

## Goals

-  Understand, create and manipulate iterable objects in Julia
- Understand the conceptual division of iterables into ordered and unordered collections
- Express (un/)ordered collections, and operations on them, both mathematically and in Python
- Have a basic idea of functional programming styles and their advantages
- *(only in Julia option, Pluto notebooks)* Understand and use the concepts of induction and recursion, both in programming and in proving/expressing mathematical concepts 
"""

# ╔═╡ 262ef047-9366-46ea-b769-0a3257e0ac77
md"""
## Iteration
### Iterator objects
- We previously encountered sets: unordered collections of *things* (e.g. numbers, strings). Imagine sets as a bag.
- We can take individual set elements out of the bag, perhaps to do some operation on them: we can **iteratively** take out elements of the set. So a set is an example of an **iterable**. 
- An **iterator** is an object that does *something* to an iterable. See example below: below:
"""

# ╔═╡ 387e3e5f-cccf-4bc7-b10a-e6c7e78ab217
S = Set((1,2, 5)) #iterable

# ╔═╡ 55f9c84e-0d2b-455e-8b19-61f14c83593e
iter = (x*x for x in S) #iterator

# ╔═╡ f3dda0bd-c32f-4931-a40f-da7dd45e7f05
md"""
- `iter` is an **Iterator**. It is [**lazy**](https://en.wikipedia.org/wiki/Lazy_evaluation), i.e. it's just an expression at the moment, that hasn't been evaluated.

- However, if inputted to a function that accepts iterators, it will return x*x **for each** element of `S`:
"""

# ╔═╡ cfb60357-d978-461d-bcf1-7dbcb15e0679
sum(iter)

# ╔═╡ 4af2607d-69e5-4e39-91c3-082c11e6498b
@time sum(iter)

# ╔═╡ f014889d-08bb-439c-90ba-3e1a22c2cf4c
prod(iter)

# ╔═╡ 9360107c-6791-4b87-81cd-5e774ee7bac9
md"""
- note that `@time sum(iter)` had zero allocations. If you prepend `@time` to other code, e.g. the definition `S = Set(...)`, you will get allocations. `sum` is able to cycle through the iterator without ever allocating memory for the elements `x*x` in $S$. Operating on iterators, rather than iterables, gets you faster, allocation-free code on which the compiler can do more clever stuff.
"""

# ╔═╡ 9f9de79a-3772-46ba-ac1a-77f0d1380838
Set(iter) # also an iterable itself!

# ╔═╡ 30fc0a1e-747e-421d-88ad-b4dfb7e0404c
collect(iter)

# ╔═╡ fad53069-5ffd-47c0-a3ac-ad0c4b18db7d
md"""
!!! info "Notation"
	In mathematics, we also have to formulate operations on collections of things. For instance:
	
	$$\sum_{x \in S} x^2$$
	
	is the mathematical expression equivalent to `sum(iter)`:
	- The $\sum$ symbol means `sum over`.
	- The subscript $x \in S$ denotes the elements to sum over. In this case, we iteratively take each element in $S$, call it $x$, and add $x^2$ to our running total. 
	
	- Similarly 

	$$\prod_{x \in S} x^2$$
	is the product of the elements in $S$, equivalent to `prod(iter)`.
	
	- Similarly, $$\{x^2: x \in S \}$$ or 

	$$\{x^2\}_{x \in S}$$ 
	is equivalent to `Set(iter)`. Remember that curly braces denote sets. 


!!! info "Notation"
	The **cardinality** of a set is the number of elements in the set. The notation for the cardinality of a set $S$ is  	$$|S|$$




"""

# ╔═╡ de3aa4d3-49eb-48a5-9ecd-c432ee44254f
md"""
!!! info "Questions"
	- Fill in `cardinality`  function below. It should return the number of elements in any set given as input. 
"""

# ╔═╡ ee8c5841-0250-486b-82c7-84087a47f3af
answer_box(
md"""
`cardinality(S::Set) = sum(1 for s in S)`
"""
)

# ╔═╡ 9da1c569-8432-46f0-bc88-af52c0bd556d
md"""
### Conditional iterators
We can also add **conditions** to iterators. We only take the element from the set if the expression after `if` evaluates to true. 
- See the self-explanatory code below. 
- Note that by using `and` statements (`&&`), we can add any number of conditions


"""

# ╔═╡ 4610f922-745f-4a7e-806a-3a5409fcda8e
conditional_iter = (x*x for x in S if isodd(x))

# ╔═╡ c1b05bfc-c5d2-43ad-90d2-398bbeee5468
sum(conditional_iter)

# ╔═╡ 8b6ba0a5-75fd-4ab0-bef8-78428f346d99
md"""
!!! info "Question"
	Modify `conditional_iter` to only iterate over elements that are between `3` and `10`

"""

# ╔═╡ 264c9c7f-c1c1-416f-adbb-0403ca0257f4
answer_box(
	md"""
```
	modified_conditional_iter = (x*x for x in S if (x > 3) && (x < 10))
```
	"""
)


# ╔═╡ e0e8f616-62d7-4249-92ab-d3d81f1e6f20
md"""
!!! info "Question"
	- build a function that takes in a set `S`, and outputs an iterator (not a set/other collection!) iterating over only the string-type elements of `S`. 
	- build a function that takes in an iterator `i1`, and outputs a different iterator `i2` that iterates over the iterables in `i1`, but with strings converted to symbols.  Note that `Symbol("hi")` turns the string `"hi"` into a symbol. 
	- Compose the two functions above using the `∘` operator (see live docs), to make a new function `ff`.
	- Apply `ff` to the `test_set` below. It should output an iterator
	- Collect the elements of this iterator into a set.
	- Make another function `ff2` doing the same  as `ff` but using the `filter` function (see live docs) to only collect string-type elements of `S`.

!!! info "Notation"
	- The $\circ$ compose function is the same in both Julia and maths: $f \circ g(x) = f(g(x))$
	- If $f(x) = x^3$ and $g(x) = x^2 + 4$, what are the functions $f \circ g$ and $g \circ f$?

"""

# ╔═╡ 50076028-551a-47df-a655-640f2f798906
answer_box(
	md"""
```
	test_set = Set((1, "hi", 3.0))
	get_strings(s::Set) = (si for si in s if si isa String)
	collect(get_strings(test_set))
	str2symbol(i1) = (Symbol(it) for it in i1)
	ff = str2symbol ∘ get_strings
	Set(ff(test_set))
	Set((str2symbol ∘ filter(s -> s isa String))(test_set)) 
	# remember s -> ... is another syntax for writing a function!
```
	"""
)

# ╔═╡ 19928fb4-8dc3-4dce-8063-f54bbab889e7
md"""
### Nesting iterators

- We can chain iterators together 
- View the code below, which makes a separate function $y \to y^n$ for each element $n$ in $S$

"""

# ╔═╡ 0985a299-7d51-45cb-bbae-999fd60c81eb
pow_iter = (y -> y^n for n in S)

# ╔═╡ ea845072-e904-4688-9889-495671023f17
md"""
!!! info "Questions"

	- Write `pow_iter` out in mathematical notation
	- In one line of code, build a function `f(i::Number)` that returns an iterator. Each element of the iterator should correspond to an element of `pow_iter` evaluated at `i`. (Note that each element of pow_iter is a function)
	- Boom, you've nested iterators!
"""

# ╔═╡ 8da5f64b-53cb-4649-be01-10167c2bc03e
answer_box(
md"""
	1. $$f : S \to \{y \to y^n : n \in S \}$$
	2. 
```
f(i::Number) = (el(i) for el in pow_iter)
Set(f(4))
```
""")

# ╔═╡ 0691c52a-4820-48d4-ba0c-c3b2d308a4f3
md"""
### Zipping iterators

- Look up `zip` in the live docs. 
- Zipping runs multiple iterators at the same time. 
- Make sure you understand the example below. It uses a `Dict` (i.e. dictionary). This is an unordered collection of pairs. 
"""

# ╔═╡ f6fb4bc5-9956-4e17-ae3b-b9c76e427c12
alphabet = "abcdefghijklmnopqrstuvwxyz"

# ╔═╡ 6af7a884-8752-4f08-9919-3489122b9d79
opposite_pair = Dict(letter => reversal for (letter, reversal) in zip(alphabet, alphabet |> reverse))

# ╔═╡ fb93bade-b3e8-48c8-9eb7-75dc9d5ad919
opposite_pair['a'] 

# ╔═╡ e3038d4e-b0bc-4fe7-b229-6bca2330ece6
tip(md"""
- Look at [iteration utilities](https://docs.julialang.org/en/v1/base/iterators/) in the julia docs to see all sorts of other useful iterator gymnastics you can do. EG reversing iterators, cycling iterators indefinitely, etc. Mastering the elegant use of iterators is **very useful** when programming, and more importantly for this module helps with your 'maths mindset'. 
- - The nice thing about composing iterators and/or functions and applying them in one go, as we've been doing, is that you can build a complex pipeline that is **pure**. That is, it's behaviour depends only on the input data, and not other objects floating around in the code. This makes for fast, elegant, easily parallelisable code that is often easier to reason about and debug. It also minimises allocations in the code, which can often (but not always) help with speed. This is a simple example of the **functional programming style** 
""")

# ╔═╡ d1d658b6-96fc-4108-ad8a-ad85984ca5f5
md"""
## Ordered Collections

- Collections are sets of *things*. Ordered collections are sets of things which can be referred to by **indices** (singular is index). Each element of a collection has a position, the index (e.g. the first or fourth element), and can be referred to as such. **Unlike** sets, which are unordered.

- For **any** ordered collection in Julia (or python), one accesses a numbered element through **square brackets**. EG `x[5]` will return the 5th element of the ordered collection `x`.

### 1. Ranges
- Look like this:`1:10` or `-2:0.2:20` or `range(start, stop, length)`
- They correspond to evenly spaced numbers. The (optional) middle number provides the spacing, and defaults to `1`. But you should be using the live docs to look things like this up for yourself by now!
- Ranges are **lazy** iterators written as `a:b:c`. This means that defining a range doesn't allocate memory... if you write `1:100000`, the computer doesn't actually store each of the intermediate numbers. Sometimes this is useful: `1:1000000` takes up the same memory as `1:10`!
"""

# ╔═╡ 06a39215-155e-45e7-9939-04c02eed2c61
some_odd_numbers = 1:2:40

# ╔═╡ fe28c6e1-5216-4d07-9160-5a6bb32e3d15
tip(md"""Square brackets denote **indices of ordered collections**. Round brackets denote **inputs to functions**. Same as Python. Don't mix them up!""")

# ╔═╡ 2042582e-a4fe-492e-bf7c-e7dab458257c
some_odd_numbers[5]

# ╔═╡ db0ec1b7-9a07-414a-94ff-5a5a0c293e73
some_odd_numbers[end-1]

# ╔═╡ 2421944a-5f18-469d-8e79-553cbf5e177e
some_odd_numbers_as_function() = 1:2:40

# ╔═╡ 71341d89-9cb1-44ad-b22d-97d751b6116f
some_odd_numbers_as_function

# ╔═╡ 2af6163e-d8e7-4d46-a460-7fc1dbde7b13
some_odd_numbers_as_function()[7]

# ╔═╡ 3e257b92-45ac-4ac3-a627-057ffc173957
sum(some_odd_numbers)

# ╔═╡ cd85a010-9cdc-4db6-b85d-819a47c3fcc3
md"""
### 2. Arrays
- Arrays are the **general purpose** tool for storing ordered collections of (any) julia objects (including arrays themselves!). You encapsulate the objects in square brackets, and separate them by commas.

"""

# ╔═╡ c65ece43-379b-4c02-bd13-9fd93ae1f1f2
begin 
	simple_array = [1,5,6, "orange"] 
	i_reference_the_same_memory_as_simple_array = simple_array
	i_copied_simple_array = deepcopy(simple_array)
	simple_array[4] = "apple"
	push!(simple_array, "banana")
	popfirst!(simple_array)
	simple_array
end

# ╔═╡ e1e03573-d3d7-45a3-8bb8-582be50fb792
md"""
- Arrays are **mutable**. You can access the nth element of the array, and change it (see above)
- Arrays **pass by reference**. Setting a variable to equal an array (see above) **does not copy the contents of the array** (which might be memory intensive). Instead, think of it as a new hyperlink to the same block of memory on the computer. See above.
"""

# ╔═╡ e3e24453-3c97-4851-9511-071423a0f6b0
tip(md"""As you see above, some julia functions end with a `!`. They are known as in-place functions. Why?
1. Most functions **create a new** julia object representing the output, given an input. 
2. In-place functions **modify their first** input, rather than creating an entirely new output. Less memory usage!
""")

# ╔═╡ 09150459-a958-4778-b54f-cfd3c1c5dd3b
i_reference_the_same_memory_as_simple_array

# ╔═╡ 1d6444ce-a669-42cc-9fc5-2538faebd141
i_copied_simple_array

# ╔═╡ 42fcdaae-464f-4d16-a118-52339a46e14c
simple_array |> typeof

# ╔═╡ 97e92175-a3d2-48d3-908d-998f164cd049
eltype(simple_array)

# ╔═╡ 98230b2d-d200-4e33-9b38-080ce8cc144a
md"""
Here, `{Any}` refers to the type of the elements within the array. It is the `eltype` of the array. In this case, the elements don't share any abstract type (e.g. Number). Otherwise, `{Any}` would be replaced by the most specific abstract type shared by all elements of the array
"""

# ╔═╡ b630f3f3-8dd6-4215-9a2e-1a8dc3aa00e4
md"""
!!! info "Notation"

	- In mathematics, we also use square brackets to denote arrays. For instance:

	$$A = [1,3,  5] \in \mathbb{Z}^3$$
	$$B = [i : \mod(i,3) = 0; i < 100] \in \mathbb{Z}^{100}$$

	- So far we have only considered arrays with a single indexing variable (like $i$ above). These arrays are called **vectors** or (explained subsequently) **1-tensors**.



	- We can also construct arrays by defining their elementwise values, and the number of elements:
	
	$$B \in \mathbb{Z}^{100}: B[i] = 3i$$
"""

# ╔═╡ 82275081-0ecd-4bc9-8d9d-9d68443f7394
tip(md"""
Note that $\mathbb{Z}^3 = \mathbb{Z} \times \mathbb{Z} \times \mathbb{Z}$. I.e. it corresponds to elements that consist of three integers.
""")

# ╔═╡ 338e90ad-7b67-4662-a739-630a24a2077e
md"""
!!! info "Question"
	Build $B$ in Julia twice, reflecting the different, equivalent ways we defined $B$ mathematically. 
"""

# ╔═╡ c35f8a0b-4aee-4aea-a8dd-0a0056d8cb66
answer_box(

	md"""
```
B1 = [i for i in 1:100 if i % 3 == 0]
B2 = [3i for i in 1:100 if 3i < 100]
```
	"""
	
)

# ╔═╡ 3bc63945-f3a1-4135-850f-920a1367fe25
tip(md"""Programming with arrays that have a concrete type (e.g. `Int64`) as opposed to an abstract type (e.g. `Any`), is much more computationally efficient. And fast code is always a good thing.""")

# ╔═╡ 424315c3-2d2c-4a23-8ca2-3c113deab435
md"""
### 3. Tuples

- Tuples are **immutable**, ordered collections of objects. Once built, they cannot be changed.
- You won't use tuples much in this module, but it's useful to recognise them in code (Python as well!)
- You define a tuple with round brackets (as opposed to square brackets in arrays) **and a trailing comma** (see below)

!!! info "Question"
	Through experimentation, write a paragraph explaining the difference between the eltypes of arrays and tuples containing multiple elements. EG `[1, "hi" false]` vs `(1, "hi" false)` Your answer should contain the phrase **"least common denominator"** (google if necessary)
"""

# ╔═╡ 8a836cf1-00c2-481f-ab31-8a63e4459fd0
answer_box(md"""
- The type of a tuple contains type information on each individual element in the tuple. (See `(1, "hi")` below). This reflects the fact that the number of elements, and their types, are fixed. Tuples are immutable.
- The eltype of an array is the most specific abstract type that all elements of the array belong to. The *least common denominator* of the type. For `[1, "hi"]` below, this is the type `Any`, as there is no more specific abstract subtype that encompasses both numbers and strings.
""")

# ╔═╡ 339080ab-addb-4495-8d61-56dfcb386403
(1, "hi") |> typeof

# ╔═╡ 7ef7c352-437c-401a-b487-d9c5a8d3583b
[1, "hi"] |> typeof

# ╔═╡ fc77e8d1-a04c-4daa-bd45-9f187f1b4a5e
(1,) |> typeof

# ╔═╡ 60d2d0e2-34b6-4b0d-8f8c-d93aa32972d7
eltype((1, "hi", false)) == eltype([1, "hi", false])

# ╔═╡ 755f44a7-2e6e-4626-b2cb-64709fa4ef06
eltype([1, "hi", false])

# ╔═╡ e0e2953b-a723-4173-be5c-dfb105ab937d
md"""
### 4. In maths
"""

# ╔═╡ c40902b6-a49f-4283-8a77-448276066010
md"""

#### Representing iterators over ordered collections mathematically

- Mathematical notation often assumes that iterators operate over the natural numbers. In other words, that the iterables are ordered collections. As  such, the following:

$$\sum_{i \in S} i, \text{ where } S = \{x \in \mathbb{N}: x \leq 100 \}$$

is written using the following shorthand: $$\sum_{i=1}^{100} i$$. 

Similarly, you could write $\prod_{i=1}^{100} i$ for a product. You can also add conditions like so:

$$\sum_{i=1; \ 2i > 5}^{100} i$$

!!! info "Question"
	- Write the vector containing the first $100$ elements of the following sequence using mathematical notation:
	$$[1, 2, 4, 7, 11, 16, \dots]$$
	- Use the previous answer to build an iterator running over this sequence in one short line of code
"""

# ╔═╡ c808e9d6-0f60-4243-be1c-f4ed25f17543
answer_box(md"""
- If you note that the sequence can be written as $\bigg[\frac{n(n+1)}{2} + 1\bigg]_{i=0}^{99}$, then there is an easy answer (see `sumit1` below)
- Otherwise, see `sumit2` below. The difference between consecutive elements ($k$ and $k+1$, for some $k$) of the sequence is equal to $k$. The $i^{th}$ element is thus equal to the 1st element plus the sum of these differences, from $0$ to $i$.

```
#option 1
sumit1 = (n*(n+1)/2 + 1 for n in 0:100)    
collect(sumit1)
# option 2
sumit2(i) = (sum(1:j) + 1 for j in 0:i)
sumit2(4) |> collect
```
		   
""")

# ╔═╡ 55626b90-0a21-4f7a-8030-c7a97ff48d4b
md"""
!!! info "Question: The FizzBuzz game"

	This is a classic coding interview question. Write some code that takes in any iterator on the numbers (e.g. the range `1:100`), and outputs an iterator of the same length.
	- If the number is divisible by `3`, then the iterator should return "Fizz"
	- If the number is divisible by `5`, then the iterator should return "Buzz" 
	- If the number is divisible by `15`, then the iterator should return "FizzBuzz"
	- Otherwise, the iterator should output the same number as the input iterator

	**Challenge**: write the code without any `if ... end` statements
"""

# ╔═╡ c5dae429-c49d-4a5a-a64f-e9e59212a905
answer_box(md"""
```
function fizzbuzz(iter)
	function what_to_return(a)
		(a % 15 == 0) && return "FizzBuzz"
		(a % 3 == 0) && return "Fizz"
		(a % 5 == 0) && return "Buzz"
		return a
	end
	return (what_to_return(a) for a in iter)
end
fizzbuzz(1:20) |> collect
```
""")

# ╔═╡ 528f9a87-3e9d-485c-91c5-8ba2782eaa84
answer_box(md"""
```
function fizzbuzz_without_ifs(iter)

	fizz(el) = (mod(el, 3) == 0)
	buzz(el) = (mod(el,5) == 0)
	fizzbuzz(el) = fizz(el) && buzz(el)
	normal(el) = !fizz(el) && !buzz(el)

	strings = ["fizz", "buzz", "fizzbuzz"]
	fstrings(b::Number, el::Number) = try return strings[b] catch; return el end
	
	idx(el) = fizz(el)*(1-fizzbuzz(el))*1 + buzz(el)*(1-fizzbuzz(el))*2 + fizzbuzz(el)*3 
	

	replace(el) = fstrings(idx(el), el)
	
	return (replace(el) for el in iter)
end
fizzbuzz_without_ifs(1:20) |> collect
```
""")

# ╔═╡ d6da8780-1993-436f-b3b7-486c957432e5
md"""
## Tensors and Cartesian Indices

- So far, we have considered ordered collections with a **single** indexing variable. E.G. the indexing variable $i$ in the vector $[i]_{i=1}^{100}$

- However, it's often convenient to use **multiple** indexing variables. How do we refer to an element in a table? By it's row **and** column. The row/column number are separate indexing variables.

$$A =
\begin{bmatrix}
A_{11} & A_{12} \\
A_{21} & A_{22}
\end{bmatrix}$$

Thus in code, the bottom left entry of $A$ would be `A[2,1]`. IE 2nd row, 1st column. 


!!! info "Important"
	From now on, we will refer to an ordered collection with $n$ indexing variables as an $n$-tensor, or an $n$-dimensional tensor

So the table above is a two-tensor: to reference its elements we need two indexing variables (row and column number). 

We will sometimes have to deal with objects that have **more than two indexing variables!:**

![](https://codecraft.tv/courses/tensorflowjs/tensors/what-are-tensors/img/designed/3d-tensor.jpg)

!!! info "Important"
	What about an element without indexing variables, like the number 5? This is a **zero-tensor**. We require $0$ indexing variables to access the element. 

"""

# ╔═╡ 6209a439-18f6-4bb4-bd57-49a996f509e1
[i+j for (i,j) in zip(1:10, 2:11)]

# ╔═╡ 4cde198b-42a4-4093-ae44-47905f0e630d
tip(md"""

#### Explicitly writing multidimensional arrays
- Separate the $n^{th}$ dimension by $n$ semicolons

""")

# ╔═╡ 35f22988-ae2e-4ffb-9e91-7ba4e097334c
A = [3;4;;5;6]

# ╔═╡ 358ddd95-0893-40d8-b47b-693a7a67cce8
2A

# ╔═╡ ce9caee0-55a0-41e3-bd56-e2b2374a32e8
sum(A; dims=(1,2))

# ╔═╡ 4f567af7-b2ee-4f73-aa29-20e7024e5cdd
sum(A; dims=(1,)) #what type is the input to dims?

# ╔═╡ d836c138-f683-4554-975b-431fdf99cd7c
md"""
!!! info "Notation"
	Commonly used terms for different tensors:
	
	**1-tensor** $\leftrightarrow$ **Vector**

	**2-tensor** $\leftrightarrow$ **Matrix**


	The 1st/2nd indices of a matrix are called its rows and columns. The 3rd index of a 3-tensor is often referred to as a **layer** (as you see in a neural network) 

	Learn these!!!
"""

# ╔═╡ d9173851-c9ce-4b8c-87ec-db21e8222192
question_box(md"""
#### Functional programming practice

- I've provided two vectors: `mpg` and `hp`, specifying the fuel efficiency and horsepower of a selection of cars (from [here](https://raw.githubusercontent.com/vega/vega-datasets/master/data/cars.json))
- Build a function that operates on these vectors, and finds the max mpg of the cars whose horsepower satisfies $h^2 < 10300$. Critically, **it shouldn't allocate any intermediate arrays**. It should just be a nesting of iterators.
""")

# ╔═╡ 176a3b67-1fe7-4b5e-af45-2db2e634c4c0
begin
mpg = reshape([18.  15.  18.  16.  17.  15.  14.  14.  14.  15.   NaN  NaN  NaN  NaN
  NaN 15.  14.   NaN 15.  14.  24.  22.  18.  21.  27.  26.  25.  24.
 25.  26.  21.  10.  10.  11.   9.  27.  28.  25.  25.   NaN 19.  16.
 17.  19.  18.  14.  14.  14.  14.  12.  13.  13.  18.  22.  19.  18.
 23.  28.  30.  30.  31.  35.  27.  26.  24.  25.  23.  20.  21.  13.
 14.  15.  14.  17.  11.  13.  12.  13.  19.  15.  13.  13.  14.  18.
 22.  21.  26.  22.  28.  23.  28.  27.  13.  14.  13.  14.  15.  12.
 13.  13.  14.  13.  12.  13.  18.  16.  18.  18.  23.  26.  11.  12.
 13.  12.  18.  20.  21.  22.  18.  19.  21.  26.  15.  16.  29.  24.
 20.  19.  15.  24.  20.  11.  20.  21.  19.  15.  31.  26.  32.  25.
 16.  16.  18.  16.  13.  14.  14.  14.  29.  26.  26.  31.  32.  28.
 24.  26.  24.  26.  31.  19.  18.  15.  15.  16.  15.  16.  14.  17.
 16.  15.  18.  21.  20.  13.  29.  23.  20.  23.  24.  25.  24.  18.
 29.  19.  23.  23.  22.  25.  33.  28.  25.  25.  26.  27.  17.5 16.
 15.5 14.5 22.  22.  24.  22.5 29.  24.5 29.  33.  20.  18.  18.5 17.5
 29.5 32.  28.  26.5 20.  13.  19.  19.  16.5 16.5 13.  13.  13.  31.5
 30.  36.  25.5 33.5 17.5 17.  15.5 15.  17.5 20.5 19.  18.5 16.  15.5
 15.5 16.  29.  24.5 26.  25.5 30.5 33.5 30.  30.5 22.  21.5 21.5 43.1
 36.1 32.8 39.4 36.1 19.9 19.4 20.2 19.2 20.5 20.2 25.1 20.5 19.4 20.6
 20.8 18.6 18.1 19.2 17.7 18.1 17.5 30.  27.5 27.2 30.9 21.1 23.2 23.8
 23.9 20.3 17.  21.6 16.2 31.5 29.5 21.5 19.8 22.3 20.2 20.6 17.  17.6
 16.5 18.2 16.9 15.5 19.2 18.5 31.9 34.1 35.7 27.4 25.4 23.  27.2 23.9
 34.2 34.5 31.8 37.3 28.4 28.8 26.8 33.5 41.5 38.1 32.1 37.2 28.  26.4
 24.3 19.1 34.3 29.8 31.3 37.  32.2 46.6 27.9 40.8 44.3 43.4 36.4 30.
 44.6 40.9 33.8 29.8 32.7 23.7 35.  23.6 32.4 27.2 26.6 25.8 23.5 30.
 39.1 39.  35.1 32.3 37.  37.7 34.1 34.7 34.4 29.9 33.  34.5 33.7 32.4
 32.9 31.6 28.1  NaN 30.7 25.4 24.2 22.4 26.6 20.2 17.6 28.  27.  34.
 31.  29.  27.  24.  23.  36.  37.  31.  38.  36.  36.  36.  34.  38.
 32.  38.  25.  38.  26.  22.  32.  36.  27.  27.  44.  32.  28.  31. ], :)

hp = reshape([130. 165. 150. 150. 140. 198. 220. 215. 225. 190. 115. 165. 153. 175.
 175. 170. 160. 140. 150. 225.  95.  95.  97.  85.  88.  46.  87.  90.
  95. 113.  90. 215. 200. 210. 193.  88.  90.  95.  NaN  48. 100. 105.
 100.  88. 100. 165. 175. 153. 150. 180. 170. 175. 110.  72. 100.  88.
  86.  90.  70.  76.  65.  69.  60.  70.  95.  80.  54.  90.  86. 165.
 175. 150. 153. 150. 208. 155. 160. 190.  97. 150. 130. 140. 150. 112.
  76.  87.  69.  86.  92.  97.  80.  88. 175. 150. 145. 137. 150. 198.
 150. 158. 150. 215. 225. 175. 105. 100. 100.  88.  95.  46. 150. 167.
 170. 180. 100.  88.  72.  94.  90.  85. 107.  90. 145. 230.  49.  75.
  91. 112. 150. 110. 122. 180.  95.  NaN 100. 100.  67.  80.  65.  75.
 100. 110. 105. 140. 150. 150. 140. 150.  83.  67.  78.  52.  61.  75.
  75.  75.  97.  93.  67.  95. 105.  72.  72. 170. 145. 150. 148. 110.
 105. 110.  95. 110. 110. 129.  75.  83. 100.  78.  96.  71.  97.  97.
  70.  90.  95.  88.  98. 115.  53.  86.  81.  92.  79.  83. 140. 150.
 120. 152. 100. 105.  81.  90.  52.  60.  70.  53. 100.  78. 110.  95.
  71.  70.  75.  72. 102. 150.  88. 108. 120. 180. 145. 130. 150.  68.
  80.  58.  96.  70. 145. 110. 145. 130. 110. 105. 100.  98. 180. 170.
 190. 149.  78.  88.  75.  89.  63.  83.  67.  78.  97. 110. 110.  48.
  66.  52.  70.  60. 110. 140. 139. 105.  95.  85.  88. 100.  90. 105.
  85. 110. 120. 145. 165. 139. 140.  68.  95.  97.  75.  95. 105.  85.
  97. 103. 125. 115. 133.  71.  68. 115.  85.  88.  90. 110. 130. 129.
 138. 135. 155. 142. 125. 150.  71.  65.  80.  80.  77. 125.  71.  90.
  70.  70.  65.  69.  90. 115. 115.  90.  76.  60.  70.  65.  90.  88.
  90.  90.  78.  90.  75.  92.  75.  65. 105.  65.  48.  48.  67.  67.
  67.  NaN  67.  62. 132. 100.  88.  NaN  72.  84.  84.  92. 110.  84.
  58.  64.  60.  67.  65.  62.  68.  63.  65.  65.  74.  NaN  75.  75.
 100.  74.  80. 110.  76. 116. 120. 110. 105.  88.  85.  88.  88.  88.
  85.  84.  90.  92.  NaN  74.  68.  68.  63.  70.  88.  75.  70.  67.
  67.  67. 110.  85.  92. 112.  96.  84.  90.  86.  52.  84.  79.  82.],:);
end

# ╔═╡ 016c0a0a-0ae4-4d24-9c22-92370291893c
hcat(mpg, hp)

# ╔═╡ 8c94c6fb-641b-4edd-b017-02473431f444
function get_high_horsepower_mpgs()
	iterboth = zip(mpg, hp)
	f(x) = x[2]^2 > 10300
	filmpg = (x[1] for x in iterboth if x[2]^2 > 10300)
	no_nan_filmpg = (x for x in filmpg if !isnan(x))
	maximum(no_nan_filmpg)
end

# ╔═╡ c3ba9588-f977-40c5-bc4b-4cca56584dae
get_high_horsepower_mpgs()

# ╔═╡ b6c725af-ab6b-45c4-b4ca-782e32b87d60
md"""
# Advanced material
**Congratulations!** You're done with the necessary stuff and more for this module! What follows are optional extras that are good practice if you want to become a sophisticated programmer. 
"""

# ╔═╡ 64786a5e-aff1-4266-8bb9-f8b477660ed5
md"""
## Reductions

We've previously summed vectors (1-tensors). We ended up with a zero tensor. Summation is a form of **reduction**. We take 
"""

# ╔═╡ 01802d58-6f3a-4858-a97d-820dbad8ce83
reduce(+, 1:10)

# ╔═╡ 62aeabc8-bf74-45d8-8323-8c2efcaeef7a
question_box(md"""
1. Make your own version of the `sum` function. Your function should use `reduce`, but obviously you're not allowed to put `sum` in the code!

2. Make your own function that takes a matrix, and returns two vectors. One holds the mean of its rows. The other holds the mean of its columns.

3. Make your own function that takes a 3d tensor, and returns a matrix which is the sum of its layers.
""")

# ╔═╡ 2296fa01-c0e0-4548-9822-7a8a2783e3c4
answer_box(
	md"""

```
my_sum(x) = reduce(+, x)

#option 1
function row_and_col_mean1(x)
	a_mean(i) = sum(x; dims=(i,)) / size(A)[i] # this is a nested function
return collect(a_mean(el) for el in 1:2)
end

#option 2
function row_and_col_mean2(x)
	s = size(A) #get the number of rows and cols as a tuple
	#mean is sum / number of elements
	row_mean = sum(x; dims=(1,)) / s[1]
	col_mean = sum(x; dims=(2,)) / s[2]
	return row_mean, col_mean
end
```
```
my_sum(A)
row_and_col_mean1(A)
row_and_col_mean2(A)
layer_sum(x) = sum(x; dims=(3,))
begin
	test_3d_arr = zeros(2,2,2)
	test_3d_arr[:,:,1] = [1 2; 3 4]
	test_3d_arr[:,:,2] = [10 20; 30 40]
	test_3d_arr
end
layer_sum(test_3d_arr)
total_tensor_sum(x) = missing
```
	"""
)


# ╔═╡ 4093e894-ff91-4948-a9c0-b10e07867b79
md"""
## Induction
"""

# ╔═╡ 0222fb0b-af4f-4cec-9f79-327994612712
blockquote(md"""Mathematical induction proves that we can climb as high as we like on a ladder, by proving that we can climb onto the bottom rung (the basis) and that from each rung we can climb up to the next one (the step). 

*[Concrete Mathematics](https://en.wikipedia.org/wiki/Concrete_Mathematics), by Knuth, Graham & Patashnik* (a great, freely available book if you're serious about computational maths!)""" )

# ╔═╡ b8b42307-3dcd-4e43-846f-61b435c5117a
md"""
Recall our previous definition of $\mathbb{N}$ as the set of *counting* numbers (i.e. $1$, $2$, $3$, and so on). This is an imprecise definition that we can't express mathematically. Here is an **inductive** definition of $\mathbb{N}$:

$$\begin{align}
& 1 \in \mathbb{N}  \\
& x \in \mathbb{N} \Rightarrow x+1 \in \mathbb{N}
\end{align}$$


There are two components to an inductive definition:
- A base case ($1 \in \mathbb{N}$)
- An inductive step ($x \in \mathbb{N} \Rightarrow x+1 \in \mathbb{N}$)

... and now we've covered all the natural numbers $\mathbb{N}$!

But it gets better. Instead of using induction just to define the natural numbers, we can use it to define **things that are true for all the natural numbers**. You just need to prove the base case, and then the inductive case. And you're going to do it right now!

!!! info "Question"
	Prove that the following equation holds, for all $n \in \mathbb{N}$
	$$\sum_{i=1}^n (2i-1) = n^2$$ 


"""


# ╔═╡ 995d0f7c-90a0-46d9-8b66-318d4cdb3a3c
answer_box(md"""
- When $n=1$, the RHS is equal to 1, and the LHS is equal to $2 \times 1 - 1 = 1$.  Thus it holds for the base case $1 \in \mathbb{N}$.
- Inductive step: assume that the statement is true for some arbitrary $k \in \mathbb{N}$.  We want to show the statement holds for $k+1$.  For the LHS, we can split up the sum as follows:


```math
\begin{align}
\sum_{i=1}^{k+1} (2i -1) &= \big(2(k+1)- 1\big)  + \sum_{i=1}^{k} (2i -1)\\
\end{align}
```

By assumption, we have  $\sum_{i=1}^{k} (2i -1) = k^2$.  Thus we have:

```math
\begin{align}
\sum_{i=1}^{k+1} (2i -1) &= 2k + 1 + k^2\\
&= (k+1)^2
\end{align}
```

This means that the statement is true for $k+1$. Having proven the inductive step, we can conclude our statement holds $\forall k\in \mathbb{N}$.

""")

# ╔═╡ 61b0744c-08a1-4993-a2b2-d32c065600cd
md"""
## Recurrence relations

 $(Resource("https://upload.wikimedia.org/wikipedia/commons/7/71/Serpiente_alquimica.jpg", :width=>300))

*The ourobouros is a mythical dragon that eats its own tail. See the connection?*





!!! info "Question"
	1. Is the following definition correct? Explain your answer, yes or no.
	
	$$\mathbb{N} = \{x : (x = 1) \text{ or } (x-1 \in \mathbb{N}) \}$$

	2. Use your answer to fill in the missing `check_natural` function below. I've put in one line to help you! Only two more lines are required.







"""

# ╔═╡ 3661c267-69f6-4787-90d9-21185d8f7b78
answer_box(md"""
1. Yes.  This is easy to prove by induction.  It is trivially true for $x=1$.  Now, suppose it holds true for $x\in\mathbb{N}$.  For $x+1$, we have $(x + 1) - 1 = x \in \mathbb{N}$.  Thus, $\forall{x} \in \mathbb{N}$, we have $x=1$ or $x - 1 \in \mathbb{N}$.
2.
```
function check_natural(x)
	(x==1) && return true
	(x < 1) && return false # keep this line in the questions
	return check_natural(x-1)
end
```
""")

# ╔═╡ c831fc0f-d6ba-4720-a4ce-0a4d308f8d76
function check_natural(x)
	missing
end

# ╔═╡ 287f80f5-db7d-48a0-96ad-2d67cbd99225
check_natural(35)

# ╔═╡ 273ca57c-7905-49e7-9d58-d2dfe6b0f636
md"""

!!! info "Question"
	Write a `_cumsum` function that takes an integer $n$, and sums all the integers between $[0,n]$ inclusive.
"""

# ╔═╡ 22407a5e-4331-4ca7-b290-c533e408bb06
answer_box(md"""
```
function _cumsum(n)
	(n==0) && return 0
	return n + _cumsum(n-1)
end
_cumsum(10)
```
""")

# ╔═╡ a8bce8bd-c505-44a5-9d3c-30333e625b36
question_box(md"""

recursive bubble sort.
1. build a function that takes a vector of real numbers, and permutes it so the biggest number is at the end. 
2. use this to build a recursive sorting algorithm 
""")

# ╔═╡ 2c01599e-d2e9-4b86-81e0-bd54280f461c
answer_box(
	md"""
```
# this is a method that automatically calls the next method, down below
recursive_bubble_sort(v::Vector) = recursive_bubble_sort(v, length(v))
function recursive_bubble_sort(v::Vector, n::Integer)

	(n == 1) && return v #only need to do the recursion n-1 times!
    
	for i in 1:n-1 #iterate through the array, and swap pairs in the wrong order
        if v[i] > v[i+1]
            v[i], v[i+1] =  v[i+1], v[i]
        end
    end
    
    recursive_bubble_sort(v, n-1)
end
```
""")

# ╔═╡ d612f859-67d7-407f-aa2a-a294f68680e6
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Hint", [text]));

# ╔═╡ 0cc0446e-2544-436f-a5cc-5f9b375fd7a1
hint(md"""You need only one line of code, and the `sum` function!""")

# ╔═╡ 67af109a-f38b-4525-b919-dfaadcb6bc51
hint(md""" 
You might need to use two indexing variables, and have a summation **inside** your iteration!
""")

# ╔═╡ 536e4b98-85a6-4b3c-aef0-d73d8562a278
md"""
!!! info "Question"

	### **The Fibonacci sequence**
	1. **Defining the sequence**
	Let $x_i$ denote the $i^{th}$ term of the Fibonacci sequence. The starting elements of the sequence are $x_1 = 0$ and $x_2 = 1$. We define the sequence through the **recursive equation**
	
	$$x_i := x_{i-1} + x_{i-2}$$.
	(Here, the $:=$ operator means *is defined as*)

	2. **Coding the sequence** 

	- Complete the function below so that `fibonacci(n)` returns the $n^{th}$ value of the fibonacci sequence. 

	- You may know `for...end` syntax from your general knowledge. **You are not allowed to use it!**. 
	- You are allowed two `if-end` statements. Or instead (ideally), two uses of the and operator `&&`.

	3. **Extending the sequence** (Optional)

	- make a function `new_fib(x₀, x₁)` that returns a function analogous to `fibonaccci`, but with the first two elements being x₀ and x₁. So `new_fib(0,1)(n) = fibonacci(n)`.

	
"""

# ╔═╡ bb445347-f77a-49c0-a637-5f6609fffb92
answer_box(md"""
```
function fibonacci(n)
	(n <= 1) && return 1
	return fibonacci(n-1) + fibonacci(n-2)
end
collect(fibonacci(n) for n in 0:10)
function new_fib(x₀, x₁)
	function recursive_fib(n)
		(n == 0) && return x₀
		(n == 1) && return x₁
		return recursive_fib(n-1) + recursive_fib(n-2)
	end

	return recursive_fib
end
collect(new_fib(1,5)(n) for n in 0:10)
```
""")

# ╔═╡ 356c4c0d-3689-4b97-8eea-506942ded0f0
md"""
### **Binary Search**	

Searching over the values of an array generally requires you to check each element sequentially.  However, when we know that the array is sorted, there is a handy trick we can use to search more effectively: **binary search**.  You can think of it as a game of hot and cold.

The secret to binary search is that we keep track of a `low` and a `high` index.  We compare the values of the array at these indices with the value at the midpoint, and then replace the low/high index with the midpoint, if we undershoot/overshoot our target value.  You can find an illustration of this process below (the target is 37).

![alt text](https://blog.penjee.com/wp-content/uploads/2015/04/binary-and-linear-search-animations.gif)

!!! info "Question"
	1. What happens when you search for a value that is not in the array?  What happens to the low/high indices?  How can you catch that case?

	2. Fill in the `binary_search` function below, returning the index of the array that is closest to the value *without going over*.  Use recursion!

	3. When functions are non-decreasing or non-increasing, we can use binary search to find their zeroes.  Use the `binary_search` function to find an $x$ such that $x^2 \approx \mathrm{exp}(x)$.

	
"""

# ╔═╡ 656f4065-94dc-4d1e-8d29-601cdf28b8da
answer_box(
md"""
```
function binary_search(arr, target, low, high)
    if isempty(arr) return 0 end
    if low ≥ high
        if low > high
            return 0
        else
            return low
        end
    end
    mid = (low + high) ÷ 2
    if arr[mid] > target
        return binary_search(arr, target, low, mid-1)
	elseif arr[mid] < target
        return binary_search(arr, target, mid+1, high)
    else
        return mid
    end
end
begin
	test_func(x) = exp(x) - x^2
	interval = -2:0.001:2
	values = test_func.(interval) # the . is broadcasting: apply test_func each element of the input collection. instead of to the whole collection.
	best_ind = binary_search(values, 0, 1, length(interval))
	println("f($(interval[best_ind])) = $(values[best_ind]) ≈ 0")
end
```
""")

# ╔═╡ df9c881e-587d-4371-a158-db6b97aa4808
hint(md""" 
Create an array for the interval $[-2, 2]$, and search for an element where $\mathrm{exp}(x) - x^2 \approx 0$.  The more elements in the array, the better the approximation.
""")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoTeachingTools = "~0.2.11"
PlutoUI = "~0.7.51"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.0"
manifest_format = "2.0"
project_hash = "60751e6819dafc788d9b14c68a3fb817226a2dba"

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

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "980f01d6d3283b3dbdfd7ed89405f96b7256ad57"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "2.0.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.Compiler]]
git-tree-sha1 = "382d79bfe72a406294faca39ef0c3cef6e6ce1f1"
uuid = "807dbc54-b67e-4c79-8afb-eafe4df6f2e1"
version = "0.1.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

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

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "d8337622fe53c05d16f031df24daf0270e53bc64"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.10.5"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

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
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.11.1+1"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoweredCodeUtils]]
deps = ["CodeTracking", "Compiler", "JuliaInterpreter"]
git-tree-sha1 = "e24491cb83551e44a69b9106c50666dea9d953ab"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.4.4"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.5.20"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.1+0"

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
version = "1.12.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "8f5fa7056e6dcfb23ac5211de38e6c03f6367794"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.6"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "LaTeXStrings", "Latexify", "Markdown", "PlutoLinks", "PlutoUI", "Random"]
git-tree-sha1 = "5d9ab1a4faf25a62bb9d07ef0003396ac258ef1c"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.15"

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

[[deps.REPL]]
deps = ["InteractiveUtils", "JuliaSyntaxHighlighting", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
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

[[deps.Revise]]
deps = ["CodeTracking", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "d852eba0cc08181083a58d5eb9dccaec3129cb03"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.9.0"

    [deps.Revise.extensions]
    DistributedExt = "Distributed"

    [deps.Revise.weakdeps]
    Distributed = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
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

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

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
version = "1.3.1+2"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.13.1+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.5.0+2"
"""

# ╔═╡ Cell order:
# ╠═4b9383af-8968-4af2-9298-c9ce114bb675
# ╟─ebc737da-ea35-48d9-94c6-ad21350d6e37
# ╟─f20a64ce-139a-11ee-275b-913605c7dd62
# ╟─262ef047-9366-46ea-b769-0a3257e0ac77
# ╠═387e3e5f-cccf-4bc7-b10a-e6c7e78ab217
# ╠═55f9c84e-0d2b-455e-8b19-61f14c83593e
# ╟─f3dda0bd-c32f-4931-a40f-da7dd45e7f05
# ╠═cfb60357-d978-461d-bcf1-7dbcb15e0679
# ╠═4af2607d-69e5-4e39-91c3-082c11e6498b
# ╠═f014889d-08bb-439c-90ba-3e1a22c2cf4c
# ╟─9360107c-6791-4b87-81cd-5e774ee7bac9
# ╠═9f9de79a-3772-46ba-ac1a-77f0d1380838
# ╠═30fc0a1e-747e-421d-88ad-b4dfb7e0404c
# ╟─fad53069-5ffd-47c0-a3ac-ad0c4b18db7d
# ╟─de3aa4d3-49eb-48a5-9ecd-c432ee44254f
# ╟─0cc0446e-2544-436f-a5cc-5f9b375fd7a1
# ╟─ee8c5841-0250-486b-82c7-84087a47f3af
# ╟─9da1c569-8432-46f0-bc88-af52c0bd556d
# ╠═4610f922-745f-4a7e-806a-3a5409fcda8e
# ╠═c1b05bfc-c5d2-43ad-90d2-398bbeee5468
# ╟─8b6ba0a5-75fd-4ab0-bef8-78428f346d99
# ╟─264c9c7f-c1c1-416f-adbb-0403ca0257f4
# ╟─e0e8f616-62d7-4249-92ab-d3d81f1e6f20
# ╟─50076028-551a-47df-a655-640f2f798906
# ╟─19928fb4-8dc3-4dce-8063-f54bbab889e7
# ╠═0985a299-7d51-45cb-bbae-999fd60c81eb
# ╟─ea845072-e904-4688-9889-495671023f17
# ╟─8da5f64b-53cb-4649-be01-10167c2bc03e
# ╟─0691c52a-4820-48d4-ba0c-c3b2d308a4f3
# ╠═f6fb4bc5-9956-4e17-ae3b-b9c76e427c12
# ╠═6af7a884-8752-4f08-9919-3489122b9d79
# ╠═fb93bade-b3e8-48c8-9eb7-75dc9d5ad919
# ╟─e3038d4e-b0bc-4fe7-b229-6bca2330ece6
# ╟─d1d658b6-96fc-4108-ad8a-ad85984ca5f5
# ╠═06a39215-155e-45e7-9939-04c02eed2c61
# ╟─fe28c6e1-5216-4d07-9160-5a6bb32e3d15
# ╠═2042582e-a4fe-492e-bf7c-e7dab458257c
# ╠═db0ec1b7-9a07-414a-94ff-5a5a0c293e73
# ╠═2421944a-5f18-469d-8e79-553cbf5e177e
# ╠═71341d89-9cb1-44ad-b22d-97d751b6116f
# ╠═2af6163e-d8e7-4d46-a460-7fc1dbde7b13
# ╠═3e257b92-45ac-4ac3-a627-057ffc173957
# ╟─cd85a010-9cdc-4db6-b85d-819a47c3fcc3
# ╠═c65ece43-379b-4c02-bd13-9fd93ae1f1f2
# ╟─e1e03573-d3d7-45a3-8bb8-582be50fb792
# ╟─e3e24453-3c97-4851-9511-071423a0f6b0
# ╠═09150459-a958-4778-b54f-cfd3c1c5dd3b
# ╠═1d6444ce-a669-42cc-9fc5-2538faebd141
# ╠═42fcdaae-464f-4d16-a118-52339a46e14c
# ╠═97e92175-a3d2-48d3-908d-998f164cd049
# ╟─98230b2d-d200-4e33-9b38-080ce8cc144a
# ╟─b630f3f3-8dd6-4215-9a2e-1a8dc3aa00e4
# ╟─82275081-0ecd-4bc9-8d9d-9d68443f7394
# ╟─338e90ad-7b67-4662-a739-630a24a2077e
# ╟─c35f8a0b-4aee-4aea-a8dd-0a0056d8cb66
# ╟─3bc63945-f3a1-4135-850f-920a1367fe25
# ╟─424315c3-2d2c-4a23-8ca2-3c113deab435
# ╟─8a836cf1-00c2-481f-ab31-8a63e4459fd0
# ╠═339080ab-addb-4495-8d61-56dfcb386403
# ╠═7ef7c352-437c-401a-b487-d9c5a8d3583b
# ╠═fc77e8d1-a04c-4daa-bd45-9f187f1b4a5e
# ╠═60d2d0e2-34b6-4b0d-8f8c-d93aa32972d7
# ╠═755f44a7-2e6e-4626-b2cb-64709fa4ef06
# ╟─e0e2953b-a723-4173-be5c-dfb105ab937d
# ╟─c40902b6-a49f-4283-8a77-448276066010
# ╟─c808e9d6-0f60-4243-be1c-f4ed25f17543
# ╟─67af109a-f38b-4525-b919-dfaadcb6bc51
# ╟─55626b90-0a21-4f7a-8030-c7a97ff48d4b
# ╟─c5dae429-c49d-4a5a-a64f-e9e59212a905
# ╟─528f9a87-3e9d-485c-91c5-8ba2782eaa84
# ╟─d6da8780-1993-436f-b3b7-486c957432e5
# ╠═6209a439-18f6-4bb4-bd57-49a996f509e1
# ╟─4cde198b-42a4-4093-ae44-47905f0e630d
# ╠═35f22988-ae2e-4ffb-9e91-7ba4e097334c
# ╠═358ddd95-0893-40d8-b47b-693a7a67cce8
# ╠═ce9caee0-55a0-41e3-bd56-e2b2374a32e8
# ╠═4f567af7-b2ee-4f73-aa29-20e7024e5cdd
# ╟─d836c138-f683-4554-975b-431fdf99cd7c
# ╟─d9173851-c9ce-4b8c-87ec-db21e8222192
# ╟─176a3b67-1fe7-4b5e-af45-2db2e634c4c0
# ╠═016c0a0a-0ae4-4d24-9c22-92370291893c
# ╠═8c94c6fb-641b-4edd-b017-02473431f444
# ╠═c3ba9588-f977-40c5-bc4b-4cca56584dae
# ╟─b6c725af-ab6b-45c4-b4ca-782e32b87d60
# ╟─64786a5e-aff1-4266-8bb9-f8b477660ed5
# ╠═01802d58-6f3a-4858-a97d-820dbad8ce83
# ╟─62aeabc8-bf74-45d8-8323-8c2efcaeef7a
# ╟─2296fa01-c0e0-4548-9822-7a8a2783e3c4
# ╟─4093e894-ff91-4948-a9c0-b10e07867b79
# ╟─0222fb0b-af4f-4cec-9f79-327994612712
# ╟─b8b42307-3dcd-4e43-846f-61b435c5117a
# ╟─995d0f7c-90a0-46d9-8b66-318d4cdb3a3c
# ╟─61b0744c-08a1-4993-a2b2-d32c065600cd
# ╟─3661c267-69f6-4787-90d9-21185d8f7b78
# ╠═c831fc0f-d6ba-4720-a4ce-0a4d308f8d76
# ╠═287f80f5-db7d-48a0-96ad-2d67cbd99225
# ╟─273ca57c-7905-49e7-9d58-d2dfe6b0f636
# ╟─22407a5e-4331-4ca7-b290-c533e408bb06
# ╟─a8bce8bd-c505-44a5-9d3c-30333e625b36
# ╟─2c01599e-d2e9-4b86-81e0-bd54280f461c
# ╟─d612f859-67d7-407f-aa2a-a294f68680e6
# ╟─536e4b98-85a6-4b3c-aef0-d73d8562a278
# ╟─bb445347-f77a-49c0-a637-5f6609fffb92
# ╟─356c4c0d-3689-4b97-8eea-506942ded0f0
# ╟─656f4065-94dc-4d1e-8d29-601cdf28b8da
# ╟─df9c881e-587d-4371-a158-db6b97aa4808
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
