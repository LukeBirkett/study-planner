### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 4b590c8e-4265-4339-9e9f-2c60a8e3bac7
using PlutoUI, PlutoTeachingTools, Colors, ColorVectorSpace, LinearAlgebra, Images, Luxor

# ╔═╡ 3c32a087-881d-431c-bc0f-806e7b9c7370
md"""
*NB this notebook can take ages (e.g. 10 mins) to load on slow computers. Sorry!*
"""

# ╔═╡ ccf5ef1b-6341-43fb-9cb7-5743b034fbd5
md"# Introduction to Linear Algebra"

# ╔═╡ 24687bbe-1875-4ef5-bd4b-e46c4763e37d
md"""
- Linear algebra takes time. A good way to get started is to watch [this video series](https://www.3blue1brown.com/topics/linear-algebra). You can skip any videos with *cross product* or *Cramer's rule* in the title.

- Chapters 2 & 3 of [this book](https://textbooks.math.gatech.edu/ila/) are good for those who prefer reading

- We have limited time to do Linear Algebra. I wish we had more. If you want python notebooks that go into more detail (maybe a Christmas present?), see [here](https://bvanderlei.github.io/jupyter-guide-to-linear-algebra/intro.html)
- [This](https://computationalthinking.mit.edu/Fall24/images_abstractions/transformations_and_autodiff/) is a really nice Pluto notebook (and really nice course!) that I got inspiration from for a lot of the examples below: 
"""

# ╔═╡ 2ec75628-1d65-4f38-ac5c-53168286b3f0
PlutoUI.TableOfContents()

# ╔═╡ aa5a077d-552e-4922-a5ac-cf8607f0781d
begin
	url = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Anas_platyrhynchos_male_female_quadrat.jpg/800px-Anas_platyrhynchos_male_female_quadrat.jpg"
	path = "data/duck.jpg"
	url_jack = "https://thesaurus.plus/img/synonyms/186/jack-of-all-trades.png"
	path_jack = "jack.png"
	url_pic = "https://upload.wikimedia.org/wikipedia/commons/2/29/20090211_thousand_words-01.jpg"
	path_pic = "snoopy.jpg"
end;

# ╔═╡ 82850d96-02f9-4825-bcf0-84af3a039f89
md"""
# All about matrices 
- Matrices are also known as *2-tensors*, as you need **2** indices to access an element of a matrix (the row number, and column number).
- You can also build 3 tensors, 4 tensors, or n-tensors! (see [here](https://docs.julialang.org/en/v1/manual/arrays/#man-array-literals))
Here are examples of two matrices:
"""

# ╔═╡ 7bcd2490-3543-4e6a-9e53-df37783b52ea
A = [1;4;;5;7]

# ╔═╡ 11f93907-9037-4d15-ac6e-d2b00dbe039e
tip(md"""
What's the size/dimension of a matrix?

Dimension and size are often used interchangeably! One person might say a $4 \times 3$ matrix has **dimension** $4$ by $3$. Another person (us/you) will say that all matrices have **dimension 2** (because it's a 2-tensor), and **size** $4 \times 3$. 

Just note the potential for confusion!
""")

# ╔═╡ b385d533-0775-4693-b2d2-eaddcaba22b7
A[1,2] # access a matrix element using 2 indices

# ╔═╡ 1837a32f-378a-4e47-a8bb-5229a074d2b8
size(A)

# ╔═╡ 1c848b46-6ea8-44a3-84d4-2619f724375e
question_box(md"""
- Use the `size` function to work out the sizes of `A` and `_A`. 
- Use your result to write a sentence or two about what the size of a matrix refers to, and whether it is distinct from dimension. 
- What are the dimension and sizes of `my_tensor` and `another_tensor` below?
- Look up the `reshape` function. Use this to build a 1-tensor, $C$, that has the same elements as $A$, but in a different order. What aspect of `size(A)` is **invariant** to reshaping?
""")

# ╔═╡ ef0939b4-2abd-4dd3-aae5-ba816a4460d0
my_tensor = [1;2;1;2;;;;3;4;3;4;;;;5;6;5;6;;;;7;8;7;8]

# ╔═╡ 40adf4f6-4608-4417-988a-4dac780bd1ef
begin # different ways to do the same thing
	C = reshape(A, (4,)) #(4,) is the desired size
	C = reshape(A, :) # look on live docs for reshape, paragraph 2 if you want to understand this one
end

# ╔═╡ b524f9a0-4b27-4bbe-bcd5-5c807a1940dc
prod(size(A)) == prod(size(C)) # invariant to reshaping. equals the total number of elements in the array.

# ╔═╡ 6af9cb07-aa2e-4757-b188-d248f054e8ed
md"""
!!! info "Answers"
	1. See above.
	2. The dimension of a matrix is the number of distinct indices we must specify in order to obtained the data stored within it.  The size/shape of a matrix is a tuple containing the maximum value that each index can take.
	3. See above.
	4. See above. We are re-ordering the elements, and thus, we are not adding or deleting elements.  Thus, the total number of elements is unchanged under reshaping.  The total number of elements for an array ```A``` is given by ```prod(size(A))``` - and thus, the product of ```size``` is invariant.
"""

# ╔═╡ aa8d4c23-7a89-40d7-a4ba-1ce53079ba2e
md"""
## What are they good for?
#### (Absolutely everything)

"""

# ╔═╡ d08d299c-71bd-4620-86f0-ececd359ef11
md"""
### 1. Storing data

Many of the courses you will do this year boil down to...
"""

# ╔═╡ ea4e38c4-b8fc-44f4-bdd3-4dc9d64960d3
blockquote("Doing transformations on data.")

# ╔═╡ 3b9dd93c-10d9-4471-aaeb-111384678b80
md"""
Let's be a bit more specific. Data can vary across lots of different dimensions, although space and/or time are common. (the word is spatiotemporally varying)

EG

- **Number of COVID infections each day** (spatial if measured in multiple places, temporal)
- **Images** (e.g. from an [MRI scan](https://en.wikipedia.org/wiki/Magnetic_resonance_imaging)). Adding a temporal component makes it a video.
- **Credit card scores** (varies across people, and time)

What do you do with this data?

- **Make decisions** (e.g. impose a lockdown)
- **Summarise** (e.g. by likelihood of an MRI scan including a cancerous tumour)
- **Predict** (what's the probability this person will default on their debt?)
- **Visualise** 
$(RobustLocalResource(url_pic, path_pic, :width=>600, :alt=>"hi") |> aside)

All of these actions require some computational model that **transforms** the data. EG 

- A model that predicts consequences of different lockdown options, and can be [**optimised**](https://en.wikipedia.org/wiki/Mathematical_optimization) to find the option with the best consequences. *(you're going to be doing a **lot** of optimisation!*)
- A classifier that bins MRI images as *cancerous* or *non-cancerous*
- A quantitative model that emits a probability of credit-card default, given somebody's personal data. *(please don't put your skills to bad use in your jobs next year!)*

In summary:

Raw input -> Stored data (e.g. as matrix) -> Preprocessing -> Computational model -> Output

As you progress in the year, you will see that each of these stages corresponds to a transformation of data. 
- Data is often represented in matrices
- We'll soon find out that even **transformations** are often represented as matrices.
"""

# ╔═╡ 3245a69d-0b94-4291-ae1a-fac2d66325eb
tip(md""" 
In real life (and sometimes in university courses). **There is no correct answer!** Too many years of jumping through loopholes for exams in school can induced a kind of [learned helplessness](https://en.wikipedia.org/wiki/Learned_helplessness) in these scenarios. Don't be that person! Make an educated guess. Justify it. Think, don't just google.
""") |> aside

# ╔═╡ d4c4f68a-2b3e-4452-ac78-a3455da6f5f2
question_box(md"""

What dimension of tensor would best store my data in the following cases? Why?

1. A database holding peoples' names, ages, job titles, and hometowns. 

2. Measurement of the diffusion of an inkdrop in a jug of water (optional)

3. A movie
""")

# ╔═╡ ea03487b-7f51-409a-81c4-566611b01d47
answer_box(md"""

1. A 2 dimensional tensor: each person gets a row, and there is one column for each feature (name, age, etc).
2. 3D tensor - one dim for each dim of the jug (which is a 3D object).  Each element of the tensor corresponds to the concentration of ink at the location in the jug.
3. A 3D tensor of pixels: We can think of a movie as a stack of images, ordered in time. So two dims for the position of the pixel in the image, and 1 for the time at which the image is shown.

""")

# ╔═╡ 2910635b-feb4-4ad0-add5-17d57f0c7bb4
md"""
### 2. Functions on matrices/tensors

- You will often build functions that operate on **singleton** inputs, and want to apply them to each element of a matrix/array/tensor. 
- EG `my_func(i) = i+4` adds 4 to an input number $i$. What if you want to apply it to an entire matrix and add 4 to every element? 
- Three main ways. Broadcasting (julia specific), list comprehension, and `map`. You could also using a boring for loop if you really wanted. See below
"""

# ╔═╡ 6ce59510-287e-4059-9efe-82133e7a0da7
tip(md"""
Summary of the concept of [**broadcasting**](https://docs.julialang.org/en/v1/manual/arrays/):

1. You have an array `an_array::Array{some_type}` of arbitrary size
2. You want to apply a function `my_func(some_type)` to each element of the array 
3. `my_func`
If you want to apply a function  to each element of an array, you append the function name with a dot: `.`. 

**See below for a simple example**

*An alternative (try it!) is to use a list comprehension.*
""")

# ╔═╡ 11952fe0-8cff-43f1-8011-45df9bba84fe
an_array = [3;4;;5;6]

# ╔═╡ e1614adb-8978-488f-828b-f6326c523713
md"""
### 3. Images are matrices

The purpose of this subsection is to
- get you some practice at working with matrices
- cement into you the principle of storing lots of data types as matrices 
- preparation for the subsequent concept of a **vector space**

For more intuition/fun, go through the pluto tutorial on **images as arrays**

We are going to consider [digital raster images](https://en.wikipedia.org/wiki/Raster_graphics). These are images represented as a matrix of pixels. Each pixel holds a colour.

What's a colour? We will use the RGBA representation: a colour is four numbers between $0$ and $1$. These are the relative proportions of red, blue, green, and alpha (opacity).
"""

# ╔═╡ 545016b2-9baa-4439-92e2-f360916875ca
[RGBA(1,0,0,1), RGBA(0,0.2,0.5,1)] # can you see what's happening here?

# ╔═╡ fc403be1-3410-4374-8949-cba372b1a23d
md"""
As you can see from above, you could build an image by building a matrix of RGBA pixels
"""

# ╔═╡ a538110d-6e14-4589-8301-2e9b08814c88
question_box(md"""


1. Find a png image off the internet. Or just keep the photo of the seagull boyband I found (see a few cells below).

2. Make a function that takes in an RGBA pixel and inverts it. i.e. sends every RGB value $(x,y,z,a)$ to $(1 - x, 1 - y, 1-z,a)$

3. Use [broadcasting](https://docs.julialang.org/en/v1/manual/arrays/#Broadcasting)/list comprehension/`map`/all of them (google these if necessary!) to apply your inverting function to the entire image. 

	
4.  Make a function that flips images left-to-right
""")

# ╔═╡ 693e420d-2b36-4698-ae98-89eb98b525f6
answer_box(md"""
		   
2. 
`invert_pixel(x::RGBA) = RGBA(1 - x.r, 1 - x.g, 1 - x.b, x.alpha)`
3.
```
begin # three ways of doing exactly the same thing. All are good to know!
	invert_pixel.(img) # by broadcasting
	[invert_pixel(pixel) for pixel in img] #by list comprehension
	map(x -> invert_pixel(x), img) #you will encounter map later in your programming modules
end
```
		   
3. 
""")

# ╔═╡ 86e90680-ad1b-4e39-93b0-919869fb187a
img = load(download("https://i.pinimg.com/originals/e9/84/90/e98490ea3dc49e5c326b8a6c9594d2e5.png"));

# ╔═╡ e3913345-f2e5-43ae-927a-c82aca59bcdd
fieldnames(eltype(img)) # The more obvious way is to look up the fields of the RGB struct in the live docs. This is a quick way to get a list of the fields.

#All computer colours are additive combinations of the three primary colours Red, Green, and Blue.  Thes fields correspond to the R,G,B values of the im.  To learn more about how images are built from RGB values, consult https://en.wikipedia.org/wiki/RGB_color_model

# ╔═╡ 5a42850c-ed87-486f-934b-3fb05c6eeeb0
answer_box(md"""
I've given two functions for flipping the image. One does it the 'long' way, using a for loop. The other cheats by using a useful function: ```reverse```. The equivalent numpy functions to reverse are ```numpy.fliplr``` and ```numpy.fliptd```.
""")

# ╔═╡ 893d9277-384c-4125-9e71-c6e4bd1f362d
answer_box(md"""
```
function long_flip_im(x::Matrix; tb=false, lr=false) #these are keyword arguments. useful to know about. work exactly the same as in python

	rows, cols = size(x)
	
	function fliptb(x)
		new_im = deepcopy(x)
		for i in 1:rows
			new_im[i,:] = x[end-i+1,:]
		end
		return new_im
	end

	function fliplr(x)
		new_im = deepcopy(x)
		for i in 1:cols
			new_im[:,i] = x[:, end-i+1]
		end
		return new_im
	end
	new_im = x
	tb && (new_im = fliptb(x)) # we are using short-circuiting instead of if statements
	lr && (new_im = fliplr(new_im))

	return new_im
end
```
New cell:
`long_flip_im(img; tb=false, lr=true)`

An easier answer that uses the `reverse` function instead of manually reversing:

```
function cheating_flip_im(x::Matrix; tb=true, lr=true)
	new_im = x
	if tb
		new_im = reverse(x, dims=1)
	end

	if lr
		new_im = reverse(new_im, dims=2)
	end
	return new_im
end
```
`cheating_flip_im(img, tb=false, lr=true)`
""")

# ╔═╡ 2fac2250-f530-4b43-a67d-999383491db6
md"""
When you've done the answers above, here is another example of a slightly more sophisticated image processing operation:
"""

# ╔═╡ 47fb2828-a963-41ec-a891-37c613c70b18
tip(md"""
Individual elements of the image array will show as colours. Prepending your code with `@show` (see below) will display textual information on the type itself
""")

# ╔═╡ 04c5606e-03a8-40e4-9f05-377e60acea03
@show RGBA(1,0,0,1)

# ╔═╡ 3df387bb-87a5-46ee-8052-9c932f510f72
question_box(md"""
1. Compare the colour of `RBG(1.,0.,0.)` to `RBG(10.,0.,0.)` . Use this to write a few sentences on the concept of 'colour saturation'. 

2. What happens when you *multiply* (using the `*` operator) the image by a coefficient `coeff` (as provided below in a slider)? What happens as $c$ increases? What are the remaining colours when you multiply the image by a large scalar number like $200$? Why?

3. How much computer storage (bits) would you imagine a single pixel to take up? Is this a question with one answer? If not, why not?

""")

# ╔═╡ 23cea3aa-0abb-44bc-ba89-acc83201c97b
RGB(1.,0.,0.)

# ╔═╡ 7ae2fa6f-f32b-4723-be83-26ac4af574dd
RGB(10.,0.,0.)

# ╔═╡ e01f14b9-73cd-4af5-afae-d5e8d5e8d3e5
@bind coeff Slider(0:0.1:10)

# ╔═╡ 1227c6df-31fb-430f-8aad-8cdf1d6eec71
answer_box(
md"""
1. See above.  Hue values for pixels range from 0 (black) to 1 (saturated). Increasing them past 1, whether it is 2 or 200, changes nothing as the colour is already saturated. It only changes between 0 and 1
2. Only the lightest colours remain as we multiply the image by larger and larger values.  At 200, all RGB values are saturated, so the image becomes all white.
3. A single pixel can take different storage space based on how many shades we want to distinguish. The eltype of images above was RGBA{N0f8}, meaning each colour value is represented by an 8-bit float, normalized to 0-1, letting us distinguish 256 different values. Allocating more or less space would change the number of colours we could create 
""")

# ╔═╡ a9f934f2-3758-4abf-af7f-7832775e29aa
question_box(md"""

Use `img2` provided below (change the url if you want a different picture). 

- Write a few sentences descring what happens if you **add** the two images together. IE `img + img2`. Include why we needed the `imresize` function below when loading `img2` (live docs could help here)

""")


# ╔═╡ 03c64d8c-c797-4b21-9a9d-3ee9662531c0
answer_box(
md"""
1. See below.
2. See below.
3. When two images are added together, the sum is carried out pixel wise along each color channel.  This results in a new image object, even though the results can look quite odd.  As we will discuss more in a bit, this has to do with the fact that the space of natural images is very small in comparison with the space of all images.
""")

# ╔═╡ 1fd4f645-a2a9-4240-8bb7-3af56061b560
begin
	img2 = mktemp() do fn,f
	    download("https://devforum-uploads.s3.dualstack.us-east-2.amazonaws.com/uploads/original/4X/f/8/3/f8394d70ca292898d70be85ed944480088b4aa41.jpeg", fn)
	    load(fn)
	end
	img2 = imresize(img2, size(img))
end

# ╔═╡ a141b04b-90bd-4387-93dd-301bda548333
@bind interp Slider(0:0.1:1, show_value=true)

# ╔═╡ 6339e219-9e85-4967-9e83-1cec60840da1
md"""
#### Image interactions
"""

# ╔═╡ 561e2571-12c5-43b4-8677-5c10662c16ac
B = [2;6;;5;3]

# ╔═╡ 6a0bec2b-3b8a-4795-9b61-e1b8e4db60c6
blockquote("A rose by any other name would smell as sweet"
) |> aside


# ╔═╡ 5d265ddf-5fec-4246-acab-5464ef54e5be
md"""
# Vector spaces

We are now going to move on to the concept of a vector space. This is a way of **grouping mathematical objects** based on the way they **interact** with each other. We can have a vector space of many different types of object though. Videos, mathematical functions, matrices...

## 1. Defining them
First recall the definition of a **number system** from week 1. For practice, answer:
"""

# ╔═╡ b498bad7-5948-4c14-ba67-3654a69ae806
question_box(md"""
Which of the following are number systems? $\mathbb{N}, \mathbb{Z}, \mathbb{Q}, \mathbb{R}, \mathbb{C}$
""")

# ╔═╡ 0b941cbd-911e-4aa4-b0eb-a323ca5ecc20
answer_box(
md"""
- Not all elements in $\mathbb{N}$ have additive or multiplicative inverses, so it is not a number system.
- While all elements in $\mathbb{Z}$ have additive inverses, not all have multiplicative inverses, so it is not a number system.
- The remaining sets satisfy all the properties of a number system.
""")

# ╔═╡ 83622612-6465-4168-a742-b15239996975
question_box(md"""
Would the set of $400 \times 400$ images form a number system?
""")

# ╔═╡ b763ee85-653e-439b-a2f7-d226f9fa429b
answer_box(
md"""
No.  See above.  While images can be added together pixel wise, multiplication is not defined, and so they cannot form a number system.
""")

# ╔═╡ 60853e74-bae4-4561-9c53-6ddc056a0b76
md"""

- Number systems are called **fields** if $0 \neq 1$. The most common (pretty much only?) fields we encounter outside of pure mathematics are $\mathbb{R}$ and $\mathbb{C}$: the real and complex numbers. 

A vector space is a set of array-like objects (which we will call vectors but see tip below) that crops up everywhere in mathematics. A vector spaces **lives on a field**, in the sense that vectors in the vector space can be **multiplied** by elements of the field. Elements of the field will be called **scalars**.

- Just like we multiplied images (vectors in a vector space of images) by a real number, e.g. $2$!

- Note that we will denote the product of a vector $v \in V$ and a scalar $a \in K$ as $av$ (i.e. we omit a $\times$ symbol).

*See the Linear Algebra cheatsheet for a proper definition of a vector space*

Phew! It's a long definition! No need to memorise. But useful to go through each axiom and check it makes sense in the context of a vector space such as images of a fixed size.
"""

# ╔═╡ e55061d0-e10f-4afa-819e-26f7f7d27252
tip(md"""
**Potential confusion**

We've previously referred to 1-tensors as  vectors. But we will also call elements of a vector space: 'vectors'. These two definitions of vectors **do not correspond!!!**. 

Sorry for the confusion. Apparently mathematicians aren't always clear.
""")

# ╔═╡ 48f1be0c-7c7a-4a4d-ba0c-b567198b04db
tip(md"""
Most of these axioms are pretty natural: you use them subconsciously when multiplying and adding numbers. Two important points:

1. Multiplication **between** vectors (as opposed to scalar $\times$ vector ) is not defined. We do not need a concept of multiplication to have a vector space.

2. **Existence of a "one" (multiplicative identity)**. Number systems have the concept of "one": an element which, if you multiply it with any other element $v$, doesn't change $v$. Without a concept of multiplication between vectors, there is no need for this.
""")

# ╔═╡ 50c3716f-aa78-4bed-8955-c6e19c6d2fcd
md"""
## 2. Building them

Clocks are a nice example of a vector space. I've built a simple type for clocks below. Make sure you understand the code. 
"""

# ╔═╡ db54ba6e-b419-4455-b0a8-79b65648ca19
struct Clock
	hours::Int64
	mins::Int64
	Clock(x,y) = new(mod(x,12), mod(y,60)) # This is an inner constructor, which you can google
end

# ╔═╡ a544ecb3-cfee-409f-9032-7942b16afb62
Clock(15, 70)

# ╔═╡ 01186de0-cc28-48c6-b54b-29a40469a8fd
md"""
I've also added functionality to draw a clock. The code is below. It uses Luxor.jl for drawing simple pictures. You **don't** have to understand this code. But you're welcome to try...it's not too difficult!
"""

# ╔═╡ f527b0c5-d6b7-4b7e-a29d-72bf477a5ff9
question_box(md"""

- For clocks to be a vector space, we need to be able to add them to each other, and to multiply them with a scalar. 

- One easy (wrong) way to add two clocks is the following:

*Add the hours together. Take the addition modulo 12. Add the minutes together. Take the addition module 60* 

- One easy way (correct) way to multiply a clock with a scalar $c$ is  the following:

*Multiply the hours and minutes by $c$, and then take the result modulo 12 (hours) and modulo 60 (minutes)*

- (**Hard**): Why is our addition function incompatible with a vector space? Can you fix it and fill in the code block below to build addition and multiplication functions that endow the clock with properties of a vector space?
""")

# ╔═╡ e091a327-f117-4b6c-9b53-ab4c4e181ea5
begin #fill the + and * functions in!
import Base.+
import Base.*
function +(c1::Clock, c2::Clock) 
	return missing 
end

function *(c1::Clock, k)
	return missing
end
	
end

# ╔═╡ 66e96c23-33d2-4337-9c30-0b3170288ed2
_A = 2.4*I(3) #I(n) makes the nxn identity matrix

# ╔═╡ b9ed6c20-8a58-461c-b5b3-75d133858098
begin
	println("Size of A is $(size(A))") #the $() does 'string interpolation', which you can look up if you want. 
	println("Size of _A: ", size(_A))
end

# ╔═╡ 09583ece-8ce7-45f1-94fb-5bcb96747aca
another_tensor = [a + b + c*d for a in 1:3, b in 1:2, c in 1:4, d in 1:3];

# ╔═╡ 1a01e5d6-753f-491a-bcb5-5c893ab1f48f
my_func(i::Integer) = 2i

# ╔═╡ 71efcc52-a2cb-44e5-9573-f95053f0da5f
my_func.(an_array) # broadcasting

# ╔═╡ 9fcbb1cf-b9d2-418c-92e1-4a3a12a3157b
map(my_func, an_array)

# ╔═╡ 74bc5258-ef53-497c-a3ac-3dd8c0cb6848
map(an_array) do x 
	my_func(x)
end #this is optional and julia specific, but quite nice for complicated mapping operations.

# ╔═╡ b8ab7927-dc7c-47ad-a9a6-ae4ddf092275
[my_func(el) for el in an_array] #list comprehension

# ╔═╡ 6c1f3788-c048-4e33-984c-b3b91a4201f7
function crop_right_half_im(x::Matrix{T}) where T <: RGBA
	m, n = size(x)
	return x[1:end, n ÷ 2 + 1:end]
end

# ╔═╡ ec8276fb-e4b8-49ee-aa52-1ffa16400267
crop_right_half_im(img)

# ╔═╡ b76a0b48-eae4-4544-9329-cb6c1b9516c5
coeff * img

# ╔═╡ 5ba1129b-a52a-431b-bfae-f33e0a43de31
200 * img

# ╔═╡ 0500c45e-fe6b-4156-92b5-d5ed6eaafb31
interp*img + (1-interp)*img2

# ╔═╡ 3b88831c-9b10-4409-8699-60f456c6fdb3
md"""

- The two images you played with above were different. Nevertheless they could **interact** with each other in certain ways. For instance, we could **add** the images together. You couldn't do that with an image and a string!
- They could also interact with a certain type of scalar (real numbers $\mathbb{R}$). You could **multiply** an image by a scalar. 

In mathematics and programming, it's often better to think about objects in terms of how they interact, rather than what they contain.
For instance, here is a matrix:
 
 $A =$ $(latexify_md(A))

We could classify $A$ into many sets: 
- the set of things which possess $4$ and $7$ as an element. 
- the set of things whose `[1,1]` element is $1$. 
- etc etc.
These are sets based on the **information** that $A$ contains. 

Here instead are examples where we classify $A$ based on how it **interacts** with other objects:


-  $A$ is in the set of things that can be added to matrices of numbers of size $(2,2)$, such as $B$! EG  $A+$ $(latexify_md(A)) = $(latexify_md(A+B))



-  $A$ is in the set of objects that can be multiplied by a scalar (i.e. zero-tensor) number. EG $4 × A$ =$(latexify_md(4*A))

These last two properties hold **regardless** of the information actually contained in $A$. They are based on the way $A$ **interacts** with other mathematical objects.



"""

# ╔═╡ 516ce3d3-f82b-4e83-a581-59b9d65862aa
function clock_render(c::Clock)
	
	# draw numbers
	for i = 1:12 
		text("$i", rotatepoint(Point(0,-120), Point(0,0), i*π/6))
	end

	# draw hours
	rotate(c.hours*π/6)
	arrow(Point(0,0), Point(0,-80), linewidth=4, arrowheadlength=20)
	rotate(-c.hours*π/6)

	#draw mins
	rotate(c.mins*π/30)
	arrow(Point(0,0), Point(0,-90), linewidth=2, arrowheadlength=10)
	circle(Point(0,0),100) 
end

# ╔═╡ 567d9a70-3f4d-46e9-bc24-0bb1b9831ca3
draw_clock(c::Clock) = @drawsvg begin
	background("pink")
	sethue("blue")
	clock_render(c)
	strokepath()
end 260 260

# ╔═╡ 1ee64a42-66d9-43db-ad0d-98fa392d0cd9
Clock(11, 35) |> draw_clock

# ╔═╡ aa0eedd9-10b2-4c81-8fe1-e98d5032cbfa
answer_box(md"""
```julia
begin
import Base.+
import Base.*
+(c1::Clock, c2::Clock) = Clock(c1.hours+c2.hours + (c1.mins + c2.mins)÷60, c1.mins+c2.mins)

function *(c1::Clock, k)
	return Clock(c1.hours*k, c1.mins*k)
end
	
end
```

```julia
draw_clock(Clock(11, 35) + Clock(11, 35))
```
"""
)

# ╔═╡ a7f97394-db89-4a9a-9571-41e549b98a96
tip(md"""

We are **overloading** existing functions (`+` and `-`). They already have methods (*how many? Find out by typing `methods(+)`*). So we have to import the functions from their module ([Base](https://docs.julialang.org/en/v1/base/base/)) before we can add new methods.

""")

# ╔═╡ ecd7e9e0-ceea-4642-a1dc-9d9037e6bd8d
question_box(md"""
**Subspaces**

Let $V$ be the set of clocks. You have already shown $V$ is a vector space.


1. Find a **strict subset** $S \subset V$ such that $S$ is a vector space. 
2. Build a function that checks if a given clock is a member of your defined subspace

""")

# ╔═╡ d7715940-7493-4699-be9d-08b92ad95def
answer_box(
md"""
Let $S$ be the set of clocks ```c``` such that ```c.mins=0```. $S$ is a vector space.  You can check for yourself. It's closed under addition (i.e. $s_1 + s_2 \in S \  \forall s_1, s_2 \in S$). You can check it satisfies the other properties of a vector space. 
""")

# ╔═╡ d764fb38-a546-4a54-b3eb-0ee61cd71a12
question_box(md"""

**Hard, optional**:

Let $K$ be a field. Let $x$ be a variable. Let

$K[x] = \{a_0 + a_1 x + a_2 x^2 + a_3x^3 + \dots a_n x^n \ \ | \quad n \geq 0, \ \  a_i \in K \}$

1. Is $K[x]$  a vector space? 

$K[x]$ is often referred to as the set of **polynomials** over a field $K$. If $K = \mathbb{R}$ and $x \in \mathbb{R}$, this corresponds to the standard polynomials you see in school. 

The **degree** of a polynomial is the highest $n$ for which $a_n \neq 0$. 

2. Let $K[x]_{\leq N}$ be the set of polynomials of degree **at most N**. Is this a vector space?

3.  Let $K[x]_{N}$ be the set of polynomials of degree **exactly N**. Is this a vector space?

4. Write down the sets $K[x]_{\leq N}$ and $K[x]_{N}$ in mathematical notation, like I did for $K[x]$.



""")

# ╔═╡ 240d7d7f-b26e-4578-9ff5-42f5f4972759
answer_box(
md"""
1. Yes. 
- When adding polynomials, we can add the coefficients of the monomials with equal degree.  Thus, the vector space is closed under addition. For instance, the sum of two polynomials $p_1 = b_0 + b_1x + b_2x^2$ and $p_2 = c_0 + c_1x + c_2x^2$ is $p_1 + p_2 = b_0 + c_0 + (b_1 + c_1)x + (b_2 + c_2)x^2$. This is a polynomial since $b_i + c_i \in K$.
- Because $K$ is a field, addition of coefficients is transitive and commutative. 
So we can take the $0$ vector as the polynomial with $a_i = 0 \forall i$. 

- Consider any polynomial $p = a_0 + a_1 x + \dots$, there is an additive inverse given by the polynomial $-p = -a_0 - a_1 x - \dots$. We can define multiplication by a scalar $c$ as $cp = ca_0 + ca_1 + \dots$. Because $K$ is a field, the distributive properties, along with transitivity, commutativity, all hold.

2. Yes, all of the same reasoning from the previous question carries over.
3.  No, because it is not closed under addition. The sum of two degree-$n$ polynomials might not be degree $n$ itself, and thus not in the vector space. As a simple counterexample, consider the polynomials $v_1 = x^N$ and $v_2 = -x^N$.  Then we have $v_1 + v_2 = 0 \notin K[x]_N$, and so $K[x]_N$ is not a vector space.  
4. 
$K[x]_{\leq N} = \{a_0 + a_1 x + a_2 x^2 + a_3x^3 + \dots a_n x^n \ \ | \quad 0 \leq n \leq N, \ \  a_i \in K \}$
$K[x]_{N} = \{a_0 + a_1 x + a_2 x^2 + a_3x^3 + \dots a_N x^N \ \ | \quad a_i \in K, \, a_N \neq 0 \}$
""")

# ╔═╡ 42062f71-0160-4c4f-9b47-281fa7e752a1
md"""
## 3. Understanding them

!!! info "Notation"
	- Consider a matrix with $m$ rows and $n$ columns, whose elements are real numbers. We refer to it as being in the set $\mathbb{R}^{m \times n}$.



	- More generally, we would write a $d$-tensor as $\mathbb{R}^{n_1 \times n_2 \times \dots n_d}$, where $n_i$ is the length of the $i^{th}$ dimension.
So $(latexify_md(A)) 
	 $$\in \mathbb{R}^{2 \times 2}.$$

"""

# ╔═╡ 34983789-9500-4cbf-baba-73a22fc20c2e
question_box(md"""
What is mathematical notation for the set of 4-tensors, where the first dimension takes integer values, and the next 3 dimensions take real values?

The sizes of the $4$ dimensions are $(3,2,1,6)$.
""")

# ╔═╡ eaeea038-15a3-4b49-86c4-6bb33f7be09c
answer_box(
md"""
$\mathbb{Z}^{3} \times \mathbb{R}^{2\times1\times6}$
""")

# ╔═╡ 1a5dfb11-64be-4a0d-acc6-0630ba22027f
md"""
Watch the following videos
"""

# ╔═╡ 2150e64a-f3d7-4df3-a2a1-1b63a908b54e
html"""
<iframe width="560" height="315" src="https://www.youtube.com/embed/fNk_zzaMoSs?si=HKoGw_vJVt6FNd0w" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
"""

# ╔═╡ daba127c-bfa1-4d81-b3d3-e3011e0f4a60
html"""
<iframe width="560" height="315" src="https://www.youtube.com/embed/k7RM-ot2NWY?si=YZfzb5DImjrC6xnb" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
"""

# ╔═╡ 870ffdde-28ae-4376-a565-c9644e4979f0
md"""
!!! info "Definition" 
	#### The **span** of a set of vectors

	Consider a vector space $V$, with associated field $K$ (usually $K = \mathbb{R}$). Pick two elements $e_1, e_2 \in V$. Consider the set
	
	$$S = \{ v \in V : v = \alpha_1 e_1 + \alpha_2 e_2, \ \text{ where } \ \alpha_1, \alpha_2 \in K \}$$ 

	1.  $S$ is known as the **span** of the vectors $e_1$ and $e_2$. 
	
	Pick an element $s \in S$. By definition $s = \alpha_1 e_1 + \alpha_2 e_2$, for some $\alpha_1, \alpha_2 \in K$. 
	
	2. We say that $s$ has **co-ordinates** $[\alpha_1, \alpha_2]$.
"""

# ╔═╡ 7f6ed4d9-14b9-43ce-8515-da0e89c48a0f
question_box(md"""
**Hard, optional**
1. Prove that $S$, as defined in the previous definition, is a vector space itself.
""")

# ╔═╡ b960cf36-1af1-4b86-b680-29a1054e90e7
answer_box(
md"""
We will prove that $S$ is a subspace of $V$, and thus, is also a vector space.  We can show this by proving that $S$ is closed under linear combinations.  Let $a,b \in S$ with coordinates $[\alpha_1, \alpha_2]$ and $[\beta_1, \beta_2]$, respectively.  Let us consider the linear combination, for arbitrary $\mu,\nu \in K$:

```math
	
\begin{align}
\mu a + \nu b &= \mu(\alpha_1 e_1 + \alpha_2 e_2) + \nu (\beta_1 e_1 + \beta_2 e_2) \\
&=  \mu\alpha_1 e_1 + \mu\alpha_2 e_2 + \nu\beta_1 e_1 + \nu\beta_2 e_2 \quad \text{K1} \\
&= \mu\alpha_1 e_1  + \nu\beta_1 e_1 + \mu\alpha_2 e_2 +  \nu\beta_2 e_2 \quad \text{A1} \\
&= (\mu\alpha_1 + \nu\beta_1) e_1 + (\mu\alpha_2 +  \nu\beta_2) e_2 \quad \text{K2} 
	\end{align}
	```

Because $K$ as a field is closed under addition and multiplication, thus the scalar factors in the last line are also elements of $K$.  Hence, we have shown that $S$ is closed under linear combinations, and is a subspace of $V$.
""")

# ╔═╡ 1804bf55-a684-45d5-a7fe-d1e45b3ec0a5
md"""
### Representing the same vector in different ways

- The vector $[1,3,2]$ means: *one lot of $e_1$, plus three lots of $e_2$, plus two lots of $e_3$.*

- What the vector is geometrically depends on $e_1$, $e_2$, and $e_3$! We usually use the **canonical basis**: $e_1 = [1,0,0]$, $e_2 = [0,1,0]$, $e_3 = [0,0,1]$. But not always!

We can visualise this in the 2d case, for a vector $v = a_1 e_1 + a_2 e_2$...

- Play with the sliders for a₁ and a₂ below. The black arrow denotes the vector $v$. As you change the sliders, you should be able to range over vectors $v$ in the **span** of $e_1$ and $e_2$.
- In reality, $a_1$ and $a_2$ are allowed to take any real value. I've restricted them to be between $-10$ and $10$ since the graph has a limited size.
- Change $e_1$ and $e_2$ in the code and see what happens!
"""

# ╔═╡ 194deaf5-a8dc-49e3-81ae-2f918763e2da
begin
	e₁ = [1, 0] #[0.8, 0.1]
	e₂ = [0, 1] #[-0.4, 0.5]


	e₁, e₂ = 100*e₁, 100*e₂ # for visual scaling
end

# ╔═╡ 7aad6ffd-e504-472a-a9d5-0bf962e94d88
@bind a₁ Slider(-10:0.1:10; show_value=true, default=1.0)

# ╔═╡ a41047ab-b195-4719-b48a-2da84fa70454
@bind a₂ Slider(-10:0.1:10; show_value=true,default=1.0)

# ╔═╡ 65aeec1f-b13d-4c03-b681-d5ac34b2f8fa
@drawsvg begin
	background("white")
	sethue("black")
	fontsize(30)
	sethue("blue")
	label("v = $(a₁)e₁", :NW, Point(-100, -250))
	sethue("red")
	label(" + $(a₂)e₂", :NE, Point(-100, -250))
	sethue("black")
	fontsize(20)
	label("xy - coordinates: = $(a₁.*e₁/100.0 .+ a₂.*e₂/100)", :NW, Point(50, 100))
	label("e₁e₂ - coordinates: = $([a₁ , a₂])", :SW, Point(50, 100))
	
	rotate(π)
	transform([-1 0 0 1 0 0])	

	sethue("blue")
	arrow(Point(0,0), Point(e₁...), linewidth=6, arrowheadlength=20)
	sethue("red")
	arrow(Point(0,0), Point(e₂...), linewidth=6, arrowheadlength=20)
	sethue("black")
	circle(Point((a₁.*e₁ .+ a₂.*e₂)...), 4; action =:fill)
	arrow(Point(0,0), Point((a₁.*e₁ .+ a₂.*e₂)...), arrowheadlength=0)
	rulers()
	
end

# ╔═╡ 82edcf27-fb11-441b-8daa-d5a7240ac400
md"""### Why are we doing this?

- I want to emphasise that **the same vector** $v \in V$, can have **multiple representations**. The exact representation depends upon the **co-ordinate system**. This in turn depends upon the choice of $e_1$ and $e_2$.


- In school, you use a particular choice of $e_1$ and $e_2$  to represent vectors. But it's not the only choice!

- Linear algebra is all about transforming co-ordinate systems.

"""

# ╔═╡ 7b6be34b-1c3f-4dbd-a741-b1318b09aecb
question_box(md"""
1. Tinker with the values of $e_1$ and $e_2$. For what values do the xy-co-ordinates correspond to the $e_1e_2$-coordinates?
2. What relationship has to hold between $e_1$ and $e_2$ for the statement: $S = \mathbb{R}^2$ to be true? *(i.e. when can you get the circular arrow to move anywhere?)*
3. When is $S \subset V$? In what situation is one of the spanning vectors ($e_1$ or $e_2$) **redundant**?
""")

# ╔═╡ 21858957-34b6-4339-8a84-4198a36c61dc
answer_box(
md"""
1. For ```e₁ = [1,0]``` and ```e₂ = [0,1]```
2. See next question.
3. One of the spanning vectors is redundant when they lie on the same line. In other words, we can find a constant $c$ so that $e_1 + c e_2 = 0$.  When this happens, weighted sums of $e_1$ and $e_2$ can only lie along that line, which is a subspace of $V$.  Conversely, if no such constant $c$ exists, i.e. $e_1$ and $e_2$ are not on the same line, then we will have $S = \mathbb{R}^2$.
""")

# ╔═╡ 32ec7f07-e107-4515-8f5b-a85111a815d2
md"""
- You should have seen from the above exercise that *sometimes* one of the spanning vectors can be **pruned**, without altering the span $S$. 


"""

# ╔═╡ c691600e-a5c0-450a-a457-9409172377e3
md"""
!!! info "Definition"
	#### Linear combinations and linear dependence
	An object $v$ is a **linear combination** of  $\{v_1, \dots v_n\}$ if there exists scalars $\alpha_1 \dots \alpha_n$ from a field $K$ such that 

	$v = \sum_{i=1}^n \alpha_i v_i$

	In this case, we say that $v$ is **linearly dependent** on $\{v_1, \dots v_n\}$
"""

# ╔═╡ aaa9f939-188e-4c75-b58e-2eb5e88b37f8
question_box(md"""
1. If you're allowed to use the definition for linear combinations, what's an easier definition for the set spanned by a set of vectors $\{e_1, \dots e_n\}$?

2. In the interactive graph above, what happends if $e_2$ is a linear combination of $e_1$?
""")

# ╔═╡ c1a95de7-2e2a-4cd2-921e-32bfedf7b329
answer_box(md"""
1. The span of a set of vectors $\{e_1, \ldots e_2\}$ is the set of vectors that are linearly dependent on $\{e_1, \ldots e_2\}$.
2. As described in the previous answer, the span of $\{e_1, e_2\}$ will be a line in $\mathbb{R}^2$ - that is, a subspace.
""")

# ╔═╡ 523a2309-862e-45af-81c2-9124c260a5f8
md"""
!!! info "Definition"
	#### **Dimension** of a vector space

	1. A set $\{e_i\}_{i=1}^n$ **spans** $V$ if 
	$v \in V \Rightarrow v = \sum_i \alpha_i e_i \ \ \text{ for some } \{\alpha_i\}_{i=1}^n: \alpha_i \in K$
	(*i.e. any vector is a linear combination of the spanning set*)

	The **dimension** is $n \in \mathbb{N}$ if there exists a **minimal-length** spanning set of length $n$ (i.e. no spanning sets of length $n-1$ or less exist).

	#### **Basis**
	If a set $\{e_i\}_{i=1}^n$ of vectors spans $V$ and is minimal (removing any set element stops it spanning $V$), then the set is known as a **basis** for $V$.

"""

# ╔═╡ 6a9d87fc-90c7-4b93-a513-24f14bf3bffe
md"""
!!! info "Definition"

	#### The basis theorem
	Suppose that $v_1, \dots, v_m$ and $w_1, \dots , w_n$ are both bases of the vector space $V$ . Then $m = n$. In other words, all finite bases of V contain the same number of vectors. 
*tricky to prove so we'll skip!*

!!! info "Notation"
	The **canonical** basis in $\mathbb{R}^n$ consists of the vectors:
	
	$$e_1 = [1,0,0, \dots, 0]$$
	$$e_2 = [0,1,0, \dots, 0]$$
	$$\vdots$$
	$$e_n = [0, 0, \dots, 0, 1]$$

This is the basis we usually use to represent vectors. For instance:

$$[3,4] = 3e_1 + 4e_2$$
"""

# ╔═╡ e4fdd0bb-11e1-4e42-8c3b-5f29a70cd7a6
tip(md"""
- Recall the interactive graph earlier, where we could change a circle-headed vector by sliding two knobs. 

- The dimension of a vector space is the **minimum number** of knobs you would need to have be able to move the circle-headed vector along the entirety of the vector space.

- For instance, a line intersecting the origin $(0,0)$ is a 1d vector space. If you point $e_1$ in the correct direction, you only need to change $a_1$ to traverse the line.

- For instance, it's intuitively obvious that in a three-dimensional graph (instead of the 2d one shown), we would need three basis elements and three knobs to get the vector to go in every possible direction. 
""")

# ╔═╡ d6f811a8-5cb7-44ed-af1c-e05fe61e32ff
question_box(md"""
1. Does $S = \{[2,1], [3,2], [5,3]\}$ span $\mathbb{R}^2$?
2. Is $S$ a basis for $\mathbb{R}^2$?
3. Suppose $S = \{e_i\}_{i=1}^m$ is a spanning set for a vector space $V$. Suppose a particular set element $e_k$ is a linear combination of the other set elements. Let's remove $e_k$ from $S$, leaving us with $\{e_i\}_{i=1, i \neq k}^m$. Does the remaining set also span $S$?
""")

# ╔═╡ 8876ffc5-c00a-4c5e-94cd-c3dacb81eb67
answer_box(
md"""
1. Yes.  Any vector in $\mathbb{R}^2$ can be decomposed into a sum over the elements of $S$.
2.  No, it is not minimal.  There are three vectors in this set, but $\mathbb{R}^2$ is two dimensional.  More explicitly, we can see that $[5,3] = [2,1] + [3,2]$, so that some of the elements in $S$ are linearly dependent.
3.  Yes.  If any vector can be expressed as a sum involving $e_k$ and the remaining elements, then because $e_k$ itself can be expressed in terms of the remaining elements, what remains is enough to express any vector in $V$.
""")

# ╔═╡ e4cc355b-85e7-4d1a-9401-60be5bcb0880
md"""
### Quick note on affine spaces
"""

# ╔═╡ fb36491e-6df0-4772-8066-f29cf00d04af
blockquote(md"""
An affine space is nothing more than a vector space whose origin we try to forget about, by adding translations to the linear maps"

*Marcel Berger*
""") |> aside

# ╔═╡ 9a4f3052-70db-4b4c-84cd-2192e2b397a5
md"""
!!! info "Definition"
	- An affine space $A$ is a set of the form $v + V$, where $V$ is a vector space and $v \in V$. 

	- For instance, a line intersecting an origin is a vector space. A line not intersecting the origin is an affine space. $v$ is the offset from the origin

	- Notions of spanning set, basis, dimension, etc are all as for $V$


"""

# ╔═╡ 818df519-8154-4deb-97d2-8e70d7d6483f
@drawsvg begin
	sethue("red")
	fontsize(18)
	label("Vector space", :NE, Point(50, -100))
	sethue("blue")
	label("Affine space", :NE, Point(50, -130))
	rotate(π)
	transform([-1 0 0 1 0 0])	
	sethue("black")
	for x in [-150, 150]
		arrow(Point(0,0), Point(x, 0))
		arrow(Point(0,0), Point(0, x))
	end
	sethue("red")
	rotate(pi/3)
	arrow(Point(-100,0), Point(100,0), linewidth=6, arrowheadlength=20)
	sethue("blue")
	arrow(Point(-100, 40), Point(140, 40), linewidth=6, arrowheadlength=20)
end 400 300

# ╔═╡ 642373b7-441f-4d17-8f23-41c09302f07c
md"""
# All about matrices: the sequel
## What are they good for?
## 3. Transforming data
(i.e. vectors)

We can think of a matrix $A \in \mathbb{R}^{m \times n}$ as a function that transforms data:

$$f(v) = Av$$

Here, $Av$ means *A (on the left) multiplied by v (on the right)*
"""

# ╔═╡ e839ca44-a651-4911-a43f-09859262dbbb
html"""
<iframe width="560" height="315" src="https://www.youtube.com/embed/kYB8IZa5AuE?si=oGVLjahjW6J6-N_3" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
"""

# ╔═╡ ab9c4f2e-943b-43c5-9954-6d3e10a67d9f
html"""
<iframe width="560" height="315" src="https://www.youtube.com/embed/XkY2DOUCWMU?si=NJTaZjtR-gJxsUEC" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
"""

# ╔═╡ e2c3e757-e038-4748-940d-c60045a034e3
tip(md"""
We're not going to add to the mess on the internet by including yet another manual for multiplying matrices. [See e.g. here](https://www.khanacademy.org/math/precalculus/x9e81a4f98389efdf:matrices/x9e81a4f98389efdf:multiplying-matrices-by-matrices/a/multiplying-matrices) if you need to recap/learn it. **But the ability to multiply matrices on pen and paper is extremely important**
""")

# ╔═╡ c6f8cf20-0c11-4252-8d74-c12a2979b6fa
tip(md"""
Always keep track of the input and output sizes/dimensions of your functions! It's useful to figure these out **before** you work out the transformation, e.g. for the questions below.
""")

# ╔═╡ 6cbf295b-a8e5-4494-ba03-94afcb98ee61
begin
m1 = [3;2;;4;5;;6;8]
v1 = [2;4]
v2 = [2;4;6]
end;

# ╔═╡ 7d8f8160-91d7-46f3-aa44-c881774074e0
md"""
Do the following matrix multiplications **by hand**. (you can check correctness after on the computer)

*not all the multiplications are allowable!*

 $(latexify_md(v1')) $(latexify_md(m1))

---
 $(latexify_md(v2')) $(latexify_md(m1))

---

 $(latexify_md(v2')) $(latexify_md(v2))

---

 $(latexify_md(v2)) $(latexify_md(v2'))

---
 $(latexify_md(m1)) $(latexify_md(m1'))

---

 $(latexify_md(m1')) $(latexify_md(m1))

---
 $(latexify_md(m1')) $(latexify_md(m1'))
""" |> question_box

# ╔═╡ 3d76dca9-8b41-49ac-b4b2-0d7e5e233cbf
md"""
!!! info "Answers"
	I haven't hidden the answers because they are lower on the page. Don't look down! Until you want the answers...then see below
"""

# ╔═╡ bd0f6fd0-080b-49bb-82a7-537949d47a36
[2;;4] * [3;2;;4;5;;6;8] #(1×2) x (2x3) -> (1x3)

# ╔═╡ 1666c54d-bb77-463c-8efe-4c1123207527
[2;;4;;6] * [3;2;;4;5;;6;8] #(1×3) x (2x3) are mismatched dimensions

# ╔═╡ 4129c46b-052c-4d3b-b87c-1277ce79131d
[2;;4;;6] * [3;4;6;;2;5;8]

# ╔═╡ 1aaba886-1a8d-4909-bb62-64e531adee36
[2;;4;;6] * [2;4;6;;] #(1×3) x (3x1) -> (1x1)

# ╔═╡ 1dd25800-8ddf-4945-92b5-0bb3cabd7682
[2;4;6;;] * [2;;4;;6] #(3x1) x (1x3) -> (3x3)

# ╔═╡ 668ecf6a-3567-4a51-8da4-acd641a27993
[3;2;;4;5;;6;8] * [3;4;6;;2;5;8] #(2x3) x (3x2) -> (2x2)

# ╔═╡ 437bd0fe-acc6-4b74-8c15-e76b459734c8
[3;4;6;;2;5;8] * [3;2;;4;5;;6;8] #(3x2) x (2x3) -> (3x3)

# ╔═╡ d62aa175-5268-4bf0-82b4-47c44c560794
[3;4;6;;2;5;8] * [3;4;6;;2;5;8] #(3×2) x (3x2) are mismatched dimensions

# ╔═╡ 3614bee2-86cb-46a0-ac36-dbe1c6eecac7
question_box(md"""
1. Suppose we multiply two matrices $A$ and $B$. For $AB$ (i.e. $A$ multiplied by $B$ to be a valid operation, what relationship must hold between the sizes of $A$ and $B$? Write a sentence or two.

2. If $AB$ is valid, does that mean that $BA$ is valid? If not, find a counterexample. 

3. If $AB$ and $BA$ are valid, does $AB=BA$ hold, like for scalar numbers? If not, find a counterexample (the previous question might help!)
""")

# ╔═╡ 111e0ad1-9a91-4cbc-8653-f642c12b2599
answer_box(md"""
1. If $A$ has shape $m \times n$, and $B$ has shape $p \times q$, then we must have $n=p$ in order to take the product $AB$.  That is to say, the last dimension of $A$, and the first dimension of $B$, must have matching size.
2. No, this is not the case.  For example, consider any $1 \times 3$ matrix $A$ and any $3\times 2$ matrix $B$.  $AB$ exists, but $BA$ does not.  
3. No.  For example, consider any $1 \times 3$ matrix $A$ and any $3 \times 1$ matrix $B$.  $AB$ will have shape $1\times 1$, and $BA$ will have shape $3 \times 3$.
""")

# ╔═╡ 13773451-c9a2-47db-a260-78a6f809daad
md"""
# Fun extras!

I'm leaving the answers in here, because I don't want you to spend ages taking this too seriously.
"""

# ╔═╡ 46f0fbc9-84ba-41ec-98a7-51688d80a7b7
md"""
### Example: linear image transformations

- As explained in the 3blue1brown videos above, we can think of matrices as objects that transform vectors.
- Instead of drawing all the vectors as arrows, this is easier to visualise if one only draws the tips of the arrows as e.g. circles. 
- Another way of visualising and gaining intuition is taking an image of $m \times n$ pixels (like our seagull). We can consider the position of each pixel as the tip of a vector emanating from the centre $(0,0)$ position (see *transformation co-ordinates in the pic below*)
Thus it corresponds to a vector. We can transform this vector by a matrix, and see how the image changes! **Let's try this by following the steps below**
"""

# ╔═╡ a8c54fe3-a116-4980-9459-56988a401442
md"""
#### Step 1

- We need to build a function that goes from the transformation co-ordinates on which we do linear algebra, to the array co-ordinates (i.e. rows and columns) on which the pixels are organised in the image matrix. 

- After all, we are thinking of each pixel as a vector emanating from the $(0,0)$ point corresponding to the centre of the image.
- Look at the function `trygetpixel` below, which does this. Make sure you understand it!
"""

# ╔═╡ 1528e80e-e9f2-4417-a938-4c95dbb603c7
@drawsvg begin

	sethue("black")
	fontsize(16)
	label("Array Co-ordinates", :E, Point(-200, -120))
	fontsize(12)
	label("(1, 1)", :W, Point(-150, -50))
	label("(1,m)", :E, Point(-50, -50))
	label("(n,m)", :E, Point(-50, 50))
	label("(n,1)", :W, Point(-150, 50))
	Rectangle(Turtle(-100.0,0.0),  70., 70.)

	sethue("red")
	arrow(Point(0, 0), Point(60, 0))
	arrow(Point(60, 10), Point(0, 10))
	sethue("black")
	
	fontsize(16)
	label("Transformation Co-ordinates", :E, Point(30, -120))
	fontsize(12)
	label("(-1, 1)", :W, Point(100, -50))
	label("(1,1)", :E, Point(200, -50))
	label("(-1,1)", :E, Point(200, 50))
	label("(-1,-1)", :W, Point(100, 50))
	Rectangle(Turtle(150.0,0.0), 70, 70)
	arrow(Point(150, 100), Point(150, -100))
	arrow(Point(80, 0), Point(250, 0))
	label("x", :SW, Point(250,10))
	label("y", :SE, Point(150,-90))
end 500 300 


# ╔═╡ fc25b76d-3168-4c98-b862-2342e8671f2d
begin
	_white(c::RGB) = RGB(1,1,1)
	_white(c::RGBA) = RGBA(1,1,1,0.75)
end

# ╔═╡ 96dd6c1c-1a3e-48a5-9c00-8280d404a8e3
"""
1. Go from transformation co-ordinates to array co-ordinates. 
2. Extract appropriate pixel from image in array co-ordinates
*Adapted from the MIT Intro to computational thinking course*
"""
function trygetpixel(img::AbstractMatrix, x::Float64, y::Float64)
	rows, cols = size(img)
	
	"The linear map that squeezes [-1,1] into [0,1]"
	f = t -> (t - -1.0)/(1.0 - -1.0)
	
	i = floor(Int, rows *  f(-y))
	j = floor(Int, cols *  f(x * (rows / cols)) )
 
	if 1 < i ≤ rows && 1 < j ≤ cols
		img[i,j]
	else
		_white(img[1,1])

	end
end

# ╔═╡ 6380b622-8dd8-4bbb-a31d-32694b44a802
md"""
#### Step 2
- Just for clearer imagery, let's add gridlines to the image.
- Reading the code for `with_gridlines` helps your understanding of array operations and selecting subsets of arrays using array slicing
"""

# ╔═╡ 5b9dadd8-3062-4289-b880-da976eb13a62
"""
takes image. adds gridlines. keyword argument: `n=16` can be modified to determine the number of gridlines
"""
function with_gridlines(img::Array{<:Any,2}; n=16)
	
	sep_i = size(img, 1) ÷ n #rows/n . sep = separation
	sep_j = size(img, 2) ÷ n #cols/n
	
	result = copy(img)
	# stroke = zero(eltype(img))#RGBA(RGB(1,1,1), 0.75)
	
	stroke = RGBA(1, 1, 1, 0.75)
	
	result[1:sep_i:end, :] .= stroke
	result[:, 1:sep_j:end] .= stroke

	# a second time, to create a line 2 pixels wide
	result[2:sep_i:end, :] .= stroke
	result[:, 2:sep_j:end] .= stroke
	
	 result[  sep_i * (n ÷2) .+ [1,2]    , :] .= RGBA(0,1,0,1)
	result[ : ,  sep_j * (n ÷2) .+ [1,2]    ,] .= RGBA(1,0,0,1)
	return result
end

# ╔═╡ 133c0979-608b-4bff-bff3-91ccb783600d
md"""
#### Step 3
Build the $2 \times 2$ matrix by which you transform each vector (pixel)
"""

# ╔═╡ fe55f4d2-170e-40c3-8232-9de2fc363bf8
let

range = -1.5:.1:1.5
md"""
This is a "scrubbable matrix" -- click on the number and drag to change.	
	
``(``	
 $(@bind a Scrubbable( range; default=1.0))
 $(@bind b Scrubbable( range; default=0.0))
``)``

``(``
$(@bind c Scrubbable(range; default=0.0 ))
$(@bind d Scrubbable(range; default=1.0))
``)``
	
	**Re-run this cell to reset to identity transformation: open the code and then 'shift+enter'**
"""
end

# ╔═╡ b5618248-bcb0-4987-8ce6-e93f2c40d5ed
M = [a;c;;b;d]

# ╔═╡ 17ae157e-42ee-4853-a647-1ff1269bd37c
gridded_img = with_gridlines(img; n =12);

# ╔═╡ 98e5556c-9b65-4cec-a725-6429a2c94100
transformed_img = [ # This is a list comprehension. 
	if det(M) == 0
		RGB(1.0, 1.0, 1.0)
	else
		in_x, in_y =  inv(M)*([out_x, out_y]) #transform by matrix
		trygetpixel(gridded_img, in_x, in_y) 
	end
	
	for out_y in LinRange(1.0, -1.0, 500),
		out_x in LinRange(-1.0, 1.0, 500)
];

# ╔═╡ 1389c62b-5f18-4ccf-9881-2cffef2a7237
eigenvectors = @drawsvg begin
	for i in 1:2
		ei = eigen(M).vectors[:,i]
		λ = eigen(M).values[i]
		if  (ei |> eltype<:Real) && (norm(λ) > 0.01) && (norm(ei) > 0.01)
		 	arrow(Point(0,0), 50*λ*Point(ei...))
		end
	end
end 250 250;

# ╔═╡ 9d449bfb-b3bc-497c-b2e4-b634c93552f4
TwoColumn(md"$(transformed_img)", md"$(eigenvectors)")

# ╔═╡ bed2e6ff-5045-4cf1-b85c-5853aa89619b
md"""
#### Step 4:

Draw the new image! 

Note the use of a **list comprehension**. This is a powerful programming trick in many languages. 
"""

# ╔═╡ bda85f37-da24-4d7e-9f4c-40e3f5974461
question_box(md"""
Can you give an intuitive explanation of
1. Why increasing `M[1,2]` [shears](https://en.wikipedia.org/wiki/Shear_mapping) the image along the $x$-axis?
2. Why increasing `M[2,1]` [shears](https://en.wikipedia.org/wiki/Shear_mapping) the image along the $y$-axis?

It may help to think of how these altered matrices transform the vectors $[1,0]$ and $[0,1]$. Don't use google!
""")

# ╔═╡ d735a634-fe06-42a0-86eb-ec631230b35c
answer_box(md"""
1. The transformation acts as follows: $M : [0,1] \to [m,1]$, where $m$ denotes `M[1,2]`.  Hence, `M[1,2]` controls the rate a which the $y$-axis is displaced from its original position.  If `M[2,1]` is 0, only the $y$-axis will be transformed, and this appears as a shear.
2. The argument follows as in the previous question by examining how $M$ transforms $[1,0]$, but with the $x$-axis and $y$-axis reversed.
""")

# ╔═╡ 5f4d78a2-7ed7-48e6-a814-8fb424ed9cb8
question_box(md"""
#### Bonus

Add sliders that allow you to zoom the image in or out. 

1. (easier) modify the list comprehension to zoom towards the centre.
2. (harder) modify the `trygetpixel` function to zoom towards the top left
""")

# ╔═╡ 59d95845-23c4-4548-99cf-4d9fcf91d537
tip(md"""
- As you move the image, it's difficult but possible to notice that there is a line of pixels (a vector emanating from the centre) that expands or contracts, but doesn't change angle. 

- To make it easier to visualise, the graphic has black arrows on the right representing these directions.

- These directions are called the **eigenvectors** of the transformation. We will think a lot about eigenvectors in future notebooks. For now, this is just a teaser!
""")

# ╔═╡ 3010bc81-7d54-4897-b0c1-12f88451695f
html"""
<iframe width="560" height="315" src="https://www.youtube.com/embed/rHLEWRxRGiM?si=xVx_kBqINsQs2tHs" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
"""

# ╔═╡ 76b75272-9f9d-4310-b4fd-dad49ea62c33
md"""
### Linear vs nonlinear transformations

- You have probably dealt with SISO (single input single output) functions $f: \mathbb{R} \to \mathbb{R}$ in school. You can draw a **graph** of these functions on Cartesian axes, as below. At each point on the $x$-axis, one draws $y=f(x)$ on the $y$-axis. 

- You may have disambiguated the concepts of **linear** and **nonlinear** functions in this context. Which is easy! Nonlinear functions are curvy, linear functions are straight. So if you know the values of a linear function at two points, you can **extrapolate** to know its values everywhere!
"""

# ╔═╡ 8f830e79-fd4c-46f2-9a02-67a99e439f41
@drawsvg begin
	sethue("red")
	label("nonlinear", :N, Point(-70,0))
	sethue("black")
	arrow(Point(-100,50), Point(-100,-100))
	arrow(Point(-100, 50), Point(70, 50))
	sethue("red")
	curve(Point(-100,0), Point(20,80), Point(50,-50))
	strokepath()
	sethue("black")
	label("linear", :NW, Point(60, -60))
	line(Point(-100,50), Point(60, -60))
	strokepath()
	label("x", :SW, Point(-0, 55))
	label("y", :NW, Point(-100, 0))

	circle(Point(200,-30), 5, action=:fill)
	circle(Point(140, 30), 5, action=:fill)
	label("Unique line through points", :N, Point(150, 10))
end 420 200

# ╔═╡ b1393e21-0338-4e01-8855-e9b52f671c2a
md"""
...but more generally, we can define functions with **any** domain and range as non/linear!

!!! info "Definition"
	- Let $U$ and $V$ be vector spaces on a field $K$.
	- Consider a function $T: U \to V$. $T$ is linear if it satisfies:
	$$1. \quad f(v + w) = f(v) + f(w) \quad \forall v, w \in U$$
	$$2. \quad f(av) = af(v) \quad \forall a \in K; \quad v \in U$$
"""

# ╔═╡ ce8d095d-5e66-452a-b81c-913f03c794c4
question_box(md"""
1. Turn the two necessary conditions on linearity into a single condition that subsumes them both.
2. Is translation a linear function?
3. Verify that the scalar function $f(x) = mx + c$, where $m, c \in \mathbb{R}$, satisfies linearity.
""")

# ╔═╡ de1c35e3-979d-4d1b-8b8a-111c501c9597
answer_box(md"""
1. A single condition could be given by: $f(a v + b w) = af(v) + bf(w)$.
2. No.  Consider $f(x) = x + c$.  $f(x + y) = x + y + c$, whereas $f(x) + f(y) =   x + y + 2 c$.  Hence, $f(x+y) \neq f(x) + f(y)$.
""")

# ╔═╡ aa7d28b0-a5a4-4a01-92c9-eca2aeeeaa93
tip(md"""
**Any** linear transformation can be realised by a matrix. What do we mean? 

If $T:U \to V$ is a linear transformation, then $T(u) = Au$ for some matrix $A$. We won't prove this, but you can try/look up the proof if you're keen.
""")

# ╔═╡ 2959662f-869e-4cd0-8030-cc9b652e03d8
question_box(md"""
These questions assume vector spaces $U$ (with an $n$ dimensional basis set $e_1, \dots e_n$) and $V$ (with an $m$ dimensional basis set $f_1, \dots, f_m$), over a field $K = \mathbb{R}$.

We will consider a linear function (often called a linear **map**) $T: U \to V$. Remember that we can represent any vector as $v = \sum_{i=1}^n \alpha_i e_i$.

1. Use linearity to express a linear transformation $T(u)$ as a weighted sum of the transformations $\{T(e_i)\}_{i=1}^n$.

2. **Extrapolation**: Is it possible to completely specify a linear map $T$ (i.e. know $T(u)$ for any vector $u \in U$, given knowledge only of the set $\{T(e_i)\}_{i=1}^n$?

3. Suppose we multiply a matrix $A$ with the $k^{th}$ **canonical** basis element: $e_k$. Describe the output in terms of the rows and columns of $A$.

4. We know that $T(e_i)$ will give a vector $v \in V$. Therefore, we can represent 

$$T(e_i) = \sum_{j=1}^m \beta_{ji} f_j$$ for some scalars $\beta_{ji} \in K$.

Suppose that $u = \sum_{i=1}^n \alpha_i e_i$. Write $T(u)$ in terms of $\{\alpha_i\}$, $\beta_{ij}$, and $T(e_i)$.

Now use matrix multiplication to calculate:

$$\begin{bmatrix}
\beta_{11} & \beta_{12} \\
\beta_{21} & \beta_{22}
\end{bmatrix}
\begin{bmatrix}
\alpha_1 \\ \alpha_2
\end{bmatrix}$$

... is there a correspondence between the matrix filled with $\beta_{\bullet}$ elements, and the linear map $T$?
""")

# ╔═╡ 6308ee86-6d28-4ba5-a179-bd682606ab1a
answer_box(md"""
1. Since any vector $u \in U$ can be decomposed as $u = \sum_{i=1}^n \alpha_i e_i$, and this decomposition is a linear function of the basis, we must have that $T(u) = \sum_{i=1}^n \alpha_i T(e_i)$.
2. Yes. Since $\{e_i\}_{i=1}^n$ is a basis, we can express **any** vector $u \in U$ as a weighted sum of the basis elements: $u = \sum_{i=1}^n \alpha_i e_i$, for some $\alpha_i \in K$. This means that $T(u) = T(\sum_{i=1}^n \alpha_i e_i) = \sum_{i=1}^n \alpha_i T(e_i)$. And we know the set $\{T(e_i)\}_{i=1}^n$. .  
3. The product $A e_k$ will yield the $k$-th column of $A$.
4. By using the linearity of $T$, and the previous expression for $T(e_i)$, we can compute:

```math
\begin{align}
	T(u) &= \sum_{i=1}^n \alpha_i T(e_i) \\
	&= \sum_{i=1}^n \sum_{j=1}^m \alpha_i \beta_{ji} f_j
\end{align}
```
5. Via matrix multiplication, we have:

$$\begin{bmatrix}
	\beta_{11} & \beta_{12} \\
	\beta_{21} & \beta_{22}
\end{bmatrix}
\begin{bmatrix}
	\alpha_1 \\ \alpha_2
\end{bmatrix} =
\begin{bmatrix}
	\beta_{11}\alpha_1 + \beta_{12}\alpha_2 \\ 
	\beta_{21}\alpha_1 + \beta_{22}\alpha_2
\end{bmatrix}$$

The correspondence between $T$ and the $\beta$ matrix above:
	
- Let $e_1 = [1,0]$ and $e_2 = [0,1]$. Note that $[\alpha_1, \alpha_2] = \alpha_1 e_1 + \alpha_2 e_2$. In other words, the vector $[\alpha_1, \alpha_2]$ is a representation of $u$, since $u = \sum_i \alpha_i e_i$. Recall that we say $that $u$ has **co-ordinates** $[\alpha_1, \alpha_2]$ in the basis of $\{e_i\}$.
- Similarly let $f_1 = [1,0]$ and $f_2 = [0,1]$. Note that the $j^{th}$ row of the output, which we will call $r_j$, corresponds to $\sum_{i=1}^n \alpha_i \beta_{ji}f_j$. EG $r_1 = \beta_{11}\alpha_1 + \beta_{12}\alpha_2$. Note that the overall output is then $\sum_{j=1}^2 r_j f_j$. This is also equal to $T(u)$.
- So the $\beta$ matrix represents the transformation $T$! It has mapped $u$ (as represented by $[\alpha_1, \alpha_2]$), to $T(u$)!
""")

# ╔═╡ b21d472a-c22a-4f7e-a0f6-4ff9906666ad
tip(md"""
The point of the previous questions was to show that
- Knowing how a linear map transforms a basis is enough to fully specify a linear map
- A matrix is essentially a list containing the requisite information on how to transform the different canonical basis elements in a vector space
- Therefore, a matrix is a convenient way of describing a linear map.
""")

# ╔═╡ dd2e7573-9cd9-4b5d-84f8-b7864d412770
md"""

##### Lines in 1d become gridlines in 2d: 

- Go back to the seagull that is transformed by a matrix. 
- Notice that whatever the transformations, the gridlines of the transformed image remain **straight**.
- A 2d linear transformation is **guaranteed** to have straight gridlines, in the same way that a 1d linear transformation yields a straight line.

""" |> tip

# ╔═╡ c9a67ff1-57cf-4c3f-98c3-00e933f88cef
question_box(md"""
1. Use google to find the expression for a matrix $R(\theta)$ that **rotates** vectors by an angle $\theta$. 
2. Use your own judgement to find an expression for a matrix $S(\lambda)$ that scales all vectors by a factor $\lambda$ without altering their direction. 
3. Use matrix multiplication to find a composite matrix that rotates and then scales 

Recall the function composition operator `∘` from notebook 1 (or the live docs). 

4. Make two functions (e.g. $f$ and $g$) that separately apply matrices $A$ and $B$ to an input vector $v$. Make a single function $h$ that applies the matrix product of $A$ and $B$ to an input vector $v$. Verify that exactly one of the following statements is true:
`f ∘ g = h`

`g ∘ f = h`
""")

# ╔═╡ 848bb930-f3fd-42a0-ab80-c51a8ded8a7c
answer_box(
md"""
1. The matrix that rotates vectors in 2D by an angle $\theta$ is given by:
$$R(\theta) = \begin{bmatrix}
\mathrm{cos}(\theta) & -\mathrm{sin}(\theta)  \\
\mathrm{sin}(\theta)  & \mathrm{cos}(\theta) 
\end{bmatrix}.$$
2.  We can scale a vector without changing its direction by multiplying it with a scalar, to obtain $v \to \lambda v$. $S(\lambda) = \lambda I$, where $I$ is the identity matrix, satisfies this.  Explicitly, this matrix is given by:
$$S(\lambda) = \begin{bmatrix}
\lambda & 0  \\
0  & \lambda 
\end{bmatrix}.$$
3. The matrix is given by:
$$M(\theta, \lambda) = \begin{bmatrix}
\lambda\mathrm{cos}(\theta) & -\lambda\mathrm{sin}(\theta)  \\
\lambda\mathrm{sin}(\theta)  & \lambda\mathrm{cos}(\theta) 
\end{bmatrix}.$$
`
4. 

```julia
f(v) = A*v
g(v) = B*v
h(v) = A*B*v
```


```julia
(f ∘ g)([2, 1]) == h([2, 1])
(g ∘ f)([2, 1]) == h([2, 1])
```
	
""")

# ╔═╡ b528562d-fea2-468b-bb0d-60797482994b
A

# ╔═╡ e7f21084-847c-42c5-b95e-27b7029e7bc0
B

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ColorVectorSpace = "c3611d14-8923-5661-9e6a-0046d554d3a4"
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Luxor = "ae8d54c2-7ccd-5906-9d76-62fc9837b5bc"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
ColorVectorSpace = "~0.11.0"
Colors = "~0.13.1"
Images = "~0.26.2"
Luxor = "~4.3.0"
PlutoTeachingTools = "~0.3.0"
PlutoUI = "~0.7.71"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.7"
manifest_format = "2.0"
project_hash = "b24bc17f2bb153d3b9ca732bc1263cb038fbf277"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"
weakdeps = ["ChainRulesCore", "Test"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"
    AbstractFFTsTestExt = "Test"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "7e35fca2bdfba44d797c53dfe63a51fabf39bfc0"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.4.0"
weakdeps = ["SparseArrays", "StaticArrays"]

    [deps.Adapt.extensions]
    AdaptSparseArraysExt = "SparseArrays"
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "d57bd3762d308bded22c3b82d033bff85f6195c6"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.4.0"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra"]
git-tree-sha1 = "dbd8c3bbbdbb5c2778f85f4422c39960eac65a42"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.20.0"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = "CUDSS"
    ArrayInterfaceChainRulesCoreExt = "ChainRulesCore"
    ArrayInterfaceChainRulesExt = "ChainRules"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceMetalExt = "Metal"
    ArrayInterfaceReverseDiffExt = "ReverseDiff"
    ArrayInterfaceSparseArraysExt = "SparseArrays"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    CUDSS = "45b445bb-4962-46a0-9369-b4df9d0f772e"
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    Metal = "dde4c033-4e86-420c-a63e-0dd931031962"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "01b8ccb13d68535d73d2b0c23e39bd23155fb712"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.1.0"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "4126b08903b777c88edf1754288144a0492c05ad"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.8"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BitTwiddlingConvenienceFunctions]]
deps = ["Static"]
git-tree-sha1 = "f21cfd4950cb9f0587d5067e69405ad2acd27b87"
uuid = "62783981-4cbd-42fc-bca8-16325de8dc4b"
version = "0.1.6"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.CPUSummary]]
deps = ["CpuId", "IfElse", "PrecompileTools", "Preferences", "Static"]
git-tree-sha1 = "f3a21d7fc84ba618a779d1ed2fcca2e682865bab"
uuid = "2a0fbf3d-bb9c-48f3-b0a9-814d99fd7ab9"
version = "0.2.7"

[[deps.Cairo]]
deps = ["Cairo_jll", "Colors", "Glib_jll", "Graphics", "Libdl", "Pango_jll"]
git-tree-sha1 = "71aa551c5c33f1a4415867fe06b7844faadb0ae9"
uuid = "159f3aea-2a34-519c-b102-8c37f9878175"
version = "1.1.1"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fde3bf89aead2e723284a8ff9cdf5b551ed700e8"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+0"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "e4c6a16e77171a5f5e25e9646617ab1c276c5607"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.26.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.ChunkCodecCore]]
git-tree-sha1 = "51f4c10ee01bda57371e977931de39ee0f0cdb3e"
uuid = "0b6fb165-00bc-4d37-ab8b-79f91016dbe1"
version = "1.0.0"

[[deps.ChunkCodecLibZlib]]
deps = ["ChunkCodecCore", "Zlib_jll"]
git-tree-sha1 = "cee8104904c53d39eb94fd06cbe60cb5acde7177"
uuid = "4c0bbee4-addc-4d73-81a0-b6caacae83c8"
version = "1.0.0"

[[deps.ChunkCodecLibZstd]]
deps = ["ChunkCodecCore", "Zstd_jll"]
git-tree-sha1 = "34d9873079e4cb3d0c62926a225136824677073f"
uuid = "55437552-ac27-4d47-9aa3-63184e8fd398"
version = "1.0.0"

[[deps.CloseOpenIntervals]]
deps = ["Static", "StaticArrayInterface"]
git-tree-sha1 = "05ba0d07cd4fd8b7a39541e31a7b0254704ea581"
uuid = "fb6a15b2-703c-40df-9091-08a04967cfa9"
version = "0.1.13"

[[deps.Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "Random", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "3e22db924e2945282e70c33b75d4dde8bfa44c94"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.15.8"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "980f01d6d3283b3dbdfd7ed89405f96b7256ad57"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "2.0.1"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "b0fd3f56fa442f81e0a47815c92245acfaaa4e34"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.31.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.CommonWorldInvalidations]]
git-tree-sha1 = "ae52d1c52048455e85a387fbee9be553ec2b68d0"
uuid = "f70d9fcc-98c5-4d4a-abd7-e4cdeebd8ca8"
version = "1.0.0"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "9d8a54ce4b17aa5bdce0ea5c34bc5e7c340d16ad"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.Compiler]]
git-tree-sha1 = "382d79bfe72a406294faca39ef0c3cef6e6ce1f1"
uuid = "807dbc54-b67e-4c79-8afb-eafe4df6f2e1"
version = "0.1.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.ConstructionBase]]
git-tree-sha1 = "b4b092499347b18a015186eae3042f72267106cb"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.6.0"
weakdeps = ["IntervalSets", "LinearAlgebra", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "a692f5e257d332de1e554e4566a4e5a8a72de2b2"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.4"

[[deps.CpuId]]
deps = ["Markdown"]
git-tree-sha1 = "fcbb72b032692610bfbdb15018ac16a36cf2e406"
uuid = "adafc99b-e345-5852-983c-f28acb93d879"
version = "0.3.1"

[[deps.CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4e1fe97fdaed23e9dc21d4d664bea76b65fc50a0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.22"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "c7e3a542b999843086e2f29dac96a618c105be1d"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.12"
weakdeps = ["ChainRulesCore", "SparseArrays"]

    [deps.Distances.extensions]
    DistancesChainRulesCoreExt = "ChainRulesCore"
    DistancesSparseArraysExt = "SparseArrays"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7bb1361afdb33c7f2b085aa49ea8fe1b0fb14e58"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.7.1+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "83dc665d0312b41367b7263e8a4d172eac1897f4"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.4"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "3a948313e7a41eb1db7a1e733e6335f17b4ab3c4"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "7.1.1+0"

[[deps.FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "Libdl", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "97f08406df914023af55ade2f843c39e99c5d969"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.10.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6d6219a004b8cf1e0b4dbe27a2860b8e04eba0be"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.11+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "b66970a70db13f45b7e57fbda1736e1cf72174ea"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.17.0"

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

    [deps.FileIO.weakdeps]
    HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "f85dac9a96a01087df6e3a749840015a0ca3817d"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.17.1+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "2c5512e11c791d1baed2049c5652441b28fc6a31"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Giflib_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6570366d757b50fabae9f4315ad74d2e40c0560a"
uuid = "59f7168a-df46-5410-90c8-f2779963d0ec"
version = "5.2.3+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "50c11ffab2a3d50192a228c313f05b5b5dc5acb2"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.86.0+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "a641238db938fff9b2f60d08ed9030387daf428c"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.3"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a6dbda1fd736d60cc477d99f2e7a042acfa46e8"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.15+0"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "7a98c6502f4632dbe9fb1973a4244eaa3324e84d"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.13.1"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "f923f9a774fcf3f5cb761bfa43aeadd689714813"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.1+0"

[[deps.HashArrayMappedTries]]
git-tree-sha1 = "2eaa69a7cab70a52b9687c8bf950a5a93ec895ae"
uuid = "076d061b-32b6-4027-95e0-9a2c6f6d7e74"
version = "0.2.0"

[[deps.HistogramThresholding]]
deps = ["ImageBase", "LinearAlgebra", "MappedArrays"]
git-tree-sha1 = "7194dfbb2f8d945abdaf68fa9480a965d6661e69"
uuid = "2c695a8d-9458-5d45-9878-1b8a99cf7853"
version = "0.3.1"

[[deps.HostCPUFeatures]]
deps = ["BitTwiddlingConvenienceFunctions", "IfElse", "Libdl", "Static"]
git-tree-sha1 = "8e070b599339d622e9a081d17230d74a5c473293"
uuid = "3e5b6fbb-0976-4d2c-9146-d79de83f2fb0"
version = "0.1.17"

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

[[deps.IfElse]]
git-tree-sha1 = "debdd00ffef04665ccbb3e150747a77560e8fad1"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.1"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "e12629406c6c4442539436581041d372d69c55ba"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.12"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "eb49b82c172811fd2c86759fa0553a2221feb909"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.7"

[[deps.ImageBinarization]]
deps = ["HistogramThresholding", "ImageCore", "LinearAlgebra", "Polynomials", "Reexport", "Statistics"]
git-tree-sha1 = "33485b4e40d1df46c806498c73ea32dc17475c59"
uuid = "cbc4b850-ae4b-5111-9e64-df94c024a13d"
version = "0.3.1"

[[deps.ImageContrastAdjustment]]
deps = ["ImageBase", "ImageCore", "ImageTransformations", "Parameters"]
git-tree-sha1 = "eb3d4365a10e3f3ecb3b115e9d12db131d28a386"
uuid = "f332f351-ec65-5f6a-b3d1-319c6670881a"
version = "0.3.12"

[[deps.ImageCore]]
deps = ["ColorVectorSpace", "Colors", "FixedPointNumbers", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "PrecompileTools", "Reexport"]
git-tree-sha1 = "8c193230235bbcee22c8066b0374f63b5683c2d3"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.10.5"

[[deps.ImageCorners]]
deps = ["ImageCore", "ImageFiltering", "PrecompileTools", "StaticArrays", "StatsBase"]
git-tree-sha1 = "24c52de051293745a9bad7d73497708954562b79"
uuid = "89d5987c-236e-4e32-acd0-25bd6bd87b70"
version = "0.1.3"

[[deps.ImageDistances]]
deps = ["Distances", "ImageCore", "ImageMorphology", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "08b0e6354b21ef5dd5e49026028e41831401aca8"
uuid = "51556ac3-7006-55f5-8cb3-34580c88182d"
version = "0.2.17"

[[deps.ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageBase", "ImageCore", "LinearAlgebra", "OffsetArrays", "PrecompileTools", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "52116260a234af5f69969c5286e6a5f8dc3feab8"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.12"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs", "WebP"]
git-tree-sha1 = "696144904b76e1ca433b886b4e7edd067d76cbf7"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.9"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "8e64ab2f0da7b928c8ae889c514a52741debc1c2"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.4.2"

[[deps.ImageMagick_jll]]
deps = ["Artifacts", "Bzip2_jll", "FFTW_jll", "Ghostscript_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "OpenJpeg_jll", "Zlib_jll", "Zstd_jll", "libpng_jll", "libwebp_jll", "libzip_jll"]
git-tree-sha1 = "d670e8e3adf0332f57054955422e85a4aec6d0b0"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "7.1.2005+0"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "2a81c3897be6fbcde0802a0ebe6796d0562f63ec"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.10"

[[deps.ImageMorphology]]
deps = ["DataStructures", "ImageCore", "LinearAlgebra", "LoopVectorization", "OffsetArrays", "Requires", "TiledIteration"]
git-tree-sha1 = "cffa21df12f00ca1a365eb8ed107614b40e8c6da"
uuid = "787d08f9-d448-5407-9aad-5290dd7ab264"
version = "0.4.6"

[[deps.ImageQualityIndexes]]
deps = ["ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "LazyModules", "OffsetArrays", "PrecompileTools", "Statistics"]
git-tree-sha1 = "783b70725ed326340adf225be4889906c96b8fd1"
uuid = "2996bd0c-7a13-11e9-2da2-2f5ce47296a9"
version = "0.3.7"

[[deps.ImageSegmentation]]
deps = ["Clustering", "DataStructures", "Distances", "Graphs", "ImageCore", "ImageFiltering", "ImageMorphology", "LinearAlgebra", "MetaGraphs", "RegionTrees", "SimpleWeightedGraphs", "StaticArrays", "Statistics"]
git-tree-sha1 = "7196039573b6f312864547eb7a74360d6c0ab8e6"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.9.0"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "3b5344bcdbdc11ad58f3b1956709b5b9345355de"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.8"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "dfde81fafbe5d6516fb864dc79362c5c6b973c82"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.10.2"

[[deps.Images]]
deps = ["Base64", "FileIO", "Graphics", "ImageAxes", "ImageBase", "ImageBinarization", "ImageContrastAdjustment", "ImageCore", "ImageCorners", "ImageDistances", "ImageFiltering", "ImageIO", "ImageMagick", "ImageMetadata", "ImageMorphology", "ImageQualityIndexes", "ImageSegmentation", "ImageShow", "ImageTransformations", "IndirectArrays", "IntegralArrays", "Random", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "StatsBase", "TiledIteration"]
git-tree-sha1 = "a49b96fd4a8d1a9a718dfd9cde34c154fc84fcd5"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.26.2"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0936ba688c6d201805a83da835b55c61a180db52"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.11+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "d1b1b796e47d94588b3757fe84fbf65a5ec4a80d"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.5"

[[deps.IntegralArrays]]
deps = ["ColorTypes", "FixedPointNumbers", "IntervalSets"]
git-tree-sha1 = "b842cbff3f44804a84fda409745cc8f04c029a20"
uuid = "1d092043-8f09-5a30-832f-7509e371ab51"
version = "0.1.6"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "ec1debd61c300961f98064cfb21287613ad7f303"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2025.2.0+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "65d505fa4c0d7072990d659ef3fc086eb6da8208"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.16.2"

    [deps.Interpolations.extensions]
    InterpolationsForwardDiffExt = "ForwardDiff"
    InterpolationsUnitfulExt = "Unitful"

    [deps.Interpolations.weakdeps]
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.IntervalSets]]
git-tree-sha1 = "5fbb102dcb8b1a858111ae81d56682376130517d"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.11"
weakdeps = ["Random", "RecipesBase", "Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

[[deps.IrrationalConstants]]
git-tree-sha1 = "e2222959fbc6c19554dc15174c81bf7bf3aa691c"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.4"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.JLD2]]
deps = ["ChunkCodecLibZlib", "ChunkCodecLibZstd", "FileIO", "MacroTools", "Mmap", "OrderedCollections", "PrecompileTools", "ScopedValues"]
git-tree-sha1 = "da2e9b4d1abbebdcca0aa68afa0aa272102baad7"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.6.2"
weakdeps = ["UnPack"]

    [deps.JLD2.extensions]
    UnPackExt = "UnPack"

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

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "9496de8fb52c224a2e3f9ff403947674517317d9"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.6"

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

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aaafe88dccbd957a8d82f7d05be9b69172e0cee3"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.1+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eb62a3deb62fc6d8822c0c4bef73e4412419c5d8"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.8+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c602b1127f4751facb671441ca72715cc95938a"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.3+0"

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

[[deps.LayoutPointers]]
deps = ["ArrayInterface", "LinearAlgebra", "ManualMemory", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "a9eaadb366f5493a5654e843864c13d8b107548c"
uuid = "10f19ff3-798f-405d-979b-55457f8fc047"
version = "0.1.17"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"
version = "1.11.0"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

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

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3acf07f130a76f87c041cfb2ff7d7284ca67b072"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.2+0"

[[deps.Librsvg_jll]]
deps = ["Artifacts", "Cairo_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "Libdl", "Pango_jll", "XML2_jll", "gdk_pixbuf_jll"]
git-tree-sha1 = "e6ab5dda9916d7041356371c53cdc00b39841c31"
uuid = "925c91fb-5dd6-59dd-8e8c-345e74382d89"
version = "2.54.7+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "f04133fe05eff1667d2054c53d59f9122383fe05"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.2+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2a7a12fc0a4e7fb773450d17975322aa77142106"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.2+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LittleCMS_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll"]
git-tree-sha1 = "8e6a74641caf3b84800f2ccd55dc7ab83893c10b"
uuid = "d3a379c0-f9a3-5b72-a4c0-6bf4d2e8af0f"
version = "2.17.0+0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoopVectorization]]
deps = ["ArrayInterface", "CPUSummary", "CloseOpenIntervals", "DocStringExtensions", "HostCPUFeatures", "IfElse", "LayoutPointers", "LinearAlgebra", "OffsetArrays", "PolyesterWeave", "PrecompileTools", "SIMDTypes", "SLEEFPirates", "Static", "StaticArrayInterface", "ThreadingUtilities", "UnPack", "VectorizationBase"]
git-tree-sha1 = "e5afce7eaf5b5ca0d444bcb4dc4fd78c54cbbac0"
uuid = "bdcacae8-1622-11e9-2a5c-532679323890"
version = "0.12.172"

    [deps.LoopVectorization.extensions]
    ForwardDiffExt = ["ChainRulesCore", "ForwardDiff"]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.LoopVectorization.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.LoweredCodeUtils]]
deps = ["CodeTracking", "Compiler", "JuliaInterpreter"]
git-tree-sha1 = "e24491cb83551e44a69b9106c50666dea9d953ab"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.4.4"

[[deps.Luxor]]
deps = ["Base64", "Cairo", "Colors", "DataStructures", "Dates", "FFMPEG", "FileIO", "PolygonAlgorithms", "PrecompileTools", "Random", "Rsvg"]
git-tree-sha1 = "54bdbc3b05b3a4cf25ec4c00054038758c1c090b"
uuid = "ae8d54c2-7ccd-5906-9d76-62fc9837b5bc"
version = "4.3.0"

    [deps.Luxor.extensions]
    LuxorExtLatex = ["LaTeXStrings", "MathTeXEngine"]
    LuxorExtTypstry = ["Typstry"]

    [deps.Luxor.weakdeps]
    LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
    MathTeXEngine = "0a4f8689-d25c-4efe-a92b-7142dfc1aa53"
    Typstry = "f0ed7684-a786-439e-b1e3-3b82803b501e"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "oneTBB_jll"]
git-tree-sha1 = "282cadc186e7b2ae0eeadbd7a4dffed4196ae2aa"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2025.2.0+0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.ManualMemory]]
git-tree-sha1 = "bcaef4fc7a0cfe2cba636d84cda54b5e4e4ca3cd"
uuid = "d125e4d3-2237-4719-b19c-fa641b8a4667"
version = "0.1.8"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "3a8f462a180a9d735e340f4e8d5f364d411da3a4"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.8.1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "ca7e18198a166a1f3eb92a3650d53d94ed8ca8a1"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.22"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OffsetArrays]]
git-tree-sha1 = "117432e406b5c023f665fa73dc26e79ec3630151"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.17.0"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "97db9e07fe2091882c765380ef58ec553074e9c7"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.3"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "8292dd5c8a38257111ada2174000a33745b06d4e"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.2.4+0"

[[deps.OpenJpeg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libtiff_jll", "LittleCMS_jll", "libpng_jll"]
git-tree-sha1 = "7dc7028a10d1408e9103c0a77da19fdedce4de6c"
uuid = "643b3616-a352-519d-856d-80112ee9badc"
version = "2.5.4+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.5+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f19301ae653233bc88b1810ae908194f07f8db9d"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c392fc5dd032381919e3b22dd32d6443760ce7ea"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.5.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "cf181f0b1e6a18dfeb0ee8acc4a9d1672499626c"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.4"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1f7f9bbd5f7a2e5a9f7d96e51c9754454ea7f60b"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.4+0"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "db76b1ecd5e9715f3d043cec13b2ec93ce015d53"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.44.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

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
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoLinks", "PlutoUI"]
git-tree-sha1 = "8252b5de1f81dc103eb0293523ddf917695adea1"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.3.1"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "8329a3a4f75e178c11c1ce2342778bcbbbfa7e3c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.71"

[[deps.PolyesterWeave]]
deps = ["BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "Static", "ThreadingUtilities"]
git-tree-sha1 = "645bed98cd47f72f67316fd42fc47dee771aefcd"
uuid = "1d0040c9-8b98-4ee7-8388-3f51789ca0ad"
version = "0.2.2"

[[deps.PolygonAlgorithms]]
git-tree-sha1 = "809227325f22eedaf6f9eaac311247950678ec8d"
uuid = "32a0d02f-32d9-4438-b5ed-3a2932b48f96"
version = "0.3.3"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "OrderedCollections", "RecipesBase", "Requires", "Setfield", "SparseArrays"]
git-tree-sha1 = "972089912ba299fba87671b025cd0da74f5f54f7"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "4.1.0"

    [deps.Polynomials.extensions]
    PolynomialsChainRulesCoreExt = "ChainRulesCore"
    PolynomialsFFTWExt = "FFTW"
    PolynomialsMakieExt = "Makie"
    PolynomialsMutableArithmeticsExt = "MutableArithmetics"

    [deps.Polynomials.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    FFTW = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
    Makie = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
    MutableArithmetics = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"

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

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "fbb92c6c56b34e1a2c4c36058f68f332bec840e7"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "1d36ef11a9aaf1e8b74dacc6a731dd1de8fd493d"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.3.0"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "8b3fc30bc0390abdce15f8822c889f669baed73d"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.1"

[[deps.Quaternions]]
deps = ["LinearAlgebra", "Random", "RealDot"]
git-tree-sha1 = "994cc27cdacca10e68feb291673ec3a76aa2fae9"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.7.6"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "1342a47bf3260ee108163042310d26f2be5ec90b"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.5"
weakdeps = ["FixedPointNumbers"]

    [deps.Ratios.extensions]
    RatiosFixedPointNumbersExt = "FixedPointNumbers"

[[deps.RealDot]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9f0a1b71baaf7650f4fa8a1d168c7fb6ee41f0c9"
uuid = "c1ae055f-0cd5-4b69-90a6-9a35b1a98df9"
version = "0.1.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

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
weakdeps = ["Distributed"]

    [deps.Revise.extensions]
    DistributedExt = "Distributed"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays"]
git-tree-sha1 = "5680a9276685d392c87407df00d57c9924d9f11e"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.7.1"
weakdeps = ["RecipesBase"]

    [deps.Rotations.extensions]
    RotationsRecipesBaseExt = "RecipesBase"

[[deps.Rsvg]]
deps = ["Cairo", "Glib_jll", "Librsvg_jll"]
git-tree-sha1 = "e53dad0507631c0b8d5d946d93458cbabd0f05d7"
uuid = "c4c386cf-5103-5370-be45-f3a111cca3b8"
version = "1.1.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "e24dc23107d426a096d3eae6c165b921e74c18e4"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.7.2"

[[deps.SIMDTypes]]
git-tree-sha1 = "330289636fb8107c5f32088d2741e9fd7a061a5c"
uuid = "94e857df-77ce-4151-89e5-788b33177be4"
version = "0.1.0"

[[deps.SLEEFPirates]]
deps = ["IfElse", "Static", "VectorizationBase"]
git-tree-sha1 = "456f610ca2fbd1c14f5fcf31c6bfadc55e7d66e0"
uuid = "476501e8-09a2-5ece-8869-fb82de89a1fa"
version = "0.6.43"

[[deps.SciMLPublic]]
git-tree-sha1 = "ed647f161e8b3f2973f24979ec074e8d084f1bee"
uuid = "431bcebd-1456-4ced-9d72-93c2757fff0b"
version = "1.0.0"

[[deps.ScopedValues]]
deps = ["HashArrayMappedTries", "Logging"]
git-tree-sha1 = "c3b2323466378a2ba15bea4b2f73b081e022f473"
uuid = "7e506255-f358-4e82-b7e4-beb19740aa63"
version = "1.5.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "c5391c6ace3bc430ca630251d02ea9687169ca68"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.2"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"
version = "1.11.0"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "be8eeac05ec97d379347584fa9fe2f5f76795bcb"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.5"

[[deps.SimpleWeightedGraphs]]
deps = ["Graphs", "LinearAlgebra", "Markdown", "SparseArrays"]
git-tree-sha1 = "3e5f165e58b18204aed03158664c4982d691f454"
uuid = "47aef6b3-ad0c-573a-a1e2-d07658019622"
version = "1.5.0"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "0494aed9501e7fb65daba895fb7fd57cc38bc743"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.5"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "64d974c2e6fdf07f8155b5b2ca2ffa9069b608d9"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.2"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "be1cf4eb0ac528d96f5115b4ed80c26a8d8ae621"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.2"

[[deps.Static]]
deps = ["CommonWorldInvalidations", "IfElse", "PrecompileTools", "SciMLPublic"]
git-tree-sha1 = "1e44e7b1dbb5249876d84c32466f8988a6b41bbb"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "1.3.0"

[[deps.StaticArrayInterface]]
deps = ["ArrayInterface", "Compat", "IfElse", "LinearAlgebra", "PrecompileTools", "Static"]
git-tree-sha1 = "96381d50f1ce85f2663584c8e886a6ca97e60554"
uuid = "0d7ed370-da01-4f52-bd93-41d350b8b718"
version = "1.8.0"
weakdeps = ["OffsetArrays", "StaticArrays"]

    [deps.StaticArrayInterface.extensions]
    StaticArrayInterfaceOffsetArraysExt = "OffsetArrays"
    StaticArrayInterfaceStaticArraysExt = "StaticArrays"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "b8693004b385c842357406e3af647701fe783f98"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.15"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9d72a13a3f4dd3795a195ac5a44d7d6ff5f552ff"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.1"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "2c962245732371acd51700dbb268af311bddd719"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.6"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.ThreadingUtilities]]
deps = ["ManualMemory"]
git-tree-sha1 = "d969183d3d244b6c33796b5ed01ab97328f2db85"
uuid = "8290d209-cae3-49c0-8002-c8c24d57dab5"
version = "0.5.5"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "PrecompileTools", "ProgressMeter", "SIMD", "UUIDs"]
git-tree-sha1 = "98b9352a24cb6a2066f9ababcc6802de9aed8ad8"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.11.6"

[[deps.TiledIteration]]
deps = ["OffsetArrays", "StaticArrayInterface"]
git-tree-sha1 = "1176cc31e867217b06928e2f140c90bd1bc88283"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.5.0"

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

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.VectorizationBase]]
deps = ["ArrayInterface", "CPUSummary", "HostCPUFeatures", "IfElse", "LayoutPointers", "Libdl", "LinearAlgebra", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "d1d9a935a26c475ebffd54e9c7ad11627c43ea85"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.72"

[[deps.WebP]]
deps = ["CEnum", "ColorTypes", "FileIO", "FixedPointNumbers", "ImageCore", "libwebp_jll"]
git-tree-sha1 = "aa1ca3c47f119fbdae8770c29820e5e6119b83f2"
uuid = "e3aaa7dc-3e4b-44e0-be63-ffb868ccd7c1"
version = "0.1.3"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c1a7aa6219628fcd757dede0ca95e245c5cd9511"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "1.0.0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "80d3930c6347cfce7ccf96bd3bafdf079d9c0390"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.9+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fee71455b0aaa3440dfdd54a9a36ccef829be7d4"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.1+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "b5899b25d17bf1889d25906fb9deed5da0c15b3b"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.12+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a4c0ee07ad36bf8bbce1c3bb52d21fb1e0b987fb"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.7+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.gdk_pixbuf_jll]]
deps = ["Artifacts", "Glib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Xorg_libX11_jll", "libpng_jll"]
git-tree-sha1 = "895f21b699121d1a57ecac57e65a852caf569254"
uuid = "da03df04-f53b-5353-a52f-6a8b0620ced0"
version = "2.42.13+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4bba74fa59ab0755167ad24f98800fe5d727175b"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.12.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "125eedcb0a4a0bba65b657251ce1d27c8714e9d6"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.4+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "07b6a107d926093898e82b3b1db657ebe33134ec"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.50+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "libpng_jll"]
git-tree-sha1 = "c1733e347283df07689d71d61e14be986e49e47a"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.5+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.libwebp_jll]]
deps = ["Artifacts", "Giflib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libglvnd_jll", "Libtiff_jll", "libpng_jll"]
git-tree-sha1 = "4e4282c4d846e11dce56d74fa8040130b7a95cb3"
uuid = "c5f90fcd-3b7e-5836-afba-fc50a0988cb2"
version = "1.6.0+0"

[[deps.libzip_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "OpenSSL_jll", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "86addc139bca85fdf9e7741e10977c45785727b7"
uuid = "337d8026-41b4-5cde-a456-74a10e5b31d1"
version = "1.11.3+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.oneTBB_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d5a767a3bb77135a99e433afe0eb14cd7f6914c3"
uuid = "1317d2d5-d96f-522e-a858-c73665f53c3e"
version = "2022.0.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"
"""

# ╔═╡ Cell order:
# ╠═4b590c8e-4265-4339-9e9f-2c60a8e3bac7
# ╟─3c32a087-881d-431c-bc0f-806e7b9c7370
# ╟─ccf5ef1b-6341-43fb-9cb7-5743b034fbd5
# ╟─24687bbe-1875-4ef5-bd4b-e46c4763e37d
# ╟─2ec75628-1d65-4f38-ac5c-53168286b3f0
# ╟─aa5a077d-552e-4922-a5ac-cf8607f0781d
# ╟─82850d96-02f9-4825-bcf0-84af3a039f89
# ╠═7bcd2490-3543-4e6a-9e53-df37783b52ea
# ╠═66e96c23-33d2-4337-9c30-0b3170288ed2
# ╟─11f93907-9037-4d15-ac6e-d2b00dbe039e
# ╠═b385d533-0775-4693-b2d2-eaddcaba22b7
# ╠═1837a32f-378a-4e47-a8bb-5229a074d2b8
# ╟─1c848b46-6ea8-44a3-84d4-2619f724375e
# ╠═b9ed6c20-8a58-461c-b5b3-75d133858098
# ╠═ef0939b4-2abd-4dd3-aae5-ba816a4460d0
# ╠═09583ece-8ce7-45f1-94fb-5bcb96747aca
# ╠═40adf4f6-4608-4417-988a-4dac780bd1ef
# ╠═b524f9a0-4b27-4bbe-bcd5-5c807a1940dc
# ╟─6af9cb07-aa2e-4757-b188-d248f054e8ed
# ╟─aa8d4c23-7a89-40d7-a4ba-1ce53079ba2e
# ╟─d08d299c-71bd-4620-86f0-ececd359ef11
# ╟─ea4e38c4-b8fc-44f4-bdd3-4dc9d64960d3
# ╟─3b9dd93c-10d9-4471-aaeb-111384678b80
# ╟─3245a69d-0b94-4291-ae1a-fac2d66325eb
# ╟─d4c4f68a-2b3e-4452-ac78-a3455da6f5f2
# ╟─ea03487b-7f51-409a-81c4-566611b01d47
# ╟─2910635b-feb4-4ad0-add5-17d57f0c7bb4
# ╟─6ce59510-287e-4059-9efe-82133e7a0da7
# ╠═11952fe0-8cff-43f1-8011-45df9bba84fe
# ╠═1a01e5d6-753f-491a-bcb5-5c893ab1f48f
# ╠═71efcc52-a2cb-44e5-9573-f95053f0da5f
# ╠═9fcbb1cf-b9d2-418c-92e1-4a3a12a3157b
# ╠═74bc5258-ef53-497c-a3ac-3dd8c0cb6848
# ╠═b8ab7927-dc7c-47ad-a9a6-ae4ddf092275
# ╟─e1614adb-8978-488f-828b-f6326c523713
# ╠═545016b2-9baa-4439-92e2-f360916875ca
# ╠═e3913345-f2e5-43ae-927a-c82aca59bcdd
# ╟─fc403be1-3410-4374-8949-cba372b1a23d
# ╟─a538110d-6e14-4589-8301-2e9b08814c88
# ╟─693e420d-2b36-4698-ae98-89eb98b525f6
# ╠═86e90680-ad1b-4e39-93b0-919869fb187a
# ╟─5a42850c-ed87-486f-934b-3fb05c6eeeb0
# ╟─893d9277-384c-4125-9e71-c6e4bd1f362d
# ╟─2fac2250-f530-4b43-a67d-999383491db6
# ╠═6c1f3788-c048-4e33-984c-b3b91a4201f7
# ╠═ec8276fb-e4b8-49ee-aa52-1ffa16400267
# ╟─47fb2828-a963-41ec-a891-37c613c70b18
# ╠═04c5606e-03a8-40e4-9f05-377e60acea03
# ╟─3df387bb-87a5-46ee-8052-9c932f510f72
# ╠═23cea3aa-0abb-44bc-ba89-acc83201c97b
# ╠═7ae2fa6f-f32b-4723-be83-26ac4af574dd
# ╠═e01f14b9-73cd-4af5-afae-d5e8d5e8d3e5
# ╠═b76a0b48-eae4-4544-9329-cb6c1b9516c5
# ╠═5ba1129b-a52a-431b-bfae-f33e0a43de31
# ╟─1227c6df-31fb-430f-8aad-8cdf1d6eec71
# ╟─a9f934f2-3758-4abf-af7f-7832775e29aa
# ╟─03c64d8c-c797-4b21-9a9d-3ee9662531c0
# ╠═1fd4f645-a2a9-4240-8bb7-3af56061b560
# ╠═0500c45e-fe6b-4156-92b5-d5ed6eaafb31
# ╠═a141b04b-90bd-4387-93dd-301bda548333
# ╟─6339e219-9e85-4967-9e83-1cec60840da1
# ╠═561e2571-12c5-43b4-8677-5c10662c16ac
# ╟─6a0bec2b-3b8a-4795-9b61-e1b8e4db60c6
# ╟─3b88831c-9b10-4409-8699-60f456c6fdb3
# ╟─5d265ddf-5fec-4246-acab-5464ef54e5be
# ╟─b498bad7-5948-4c14-ba67-3654a69ae806
# ╟─0b941cbd-911e-4aa4-b0eb-a323ca5ecc20
# ╟─83622612-6465-4168-a742-b15239996975
# ╟─b763ee85-653e-439b-a2f7-d226f9fa429b
# ╟─60853e74-bae4-4561-9c53-6ddc056a0b76
# ╟─e55061d0-e10f-4afa-819e-26f7f7d27252
# ╟─48f1be0c-7c7a-4a4d-ba0c-b567198b04db
# ╟─50c3716f-aa78-4bed-8955-c6e19c6d2fcd
# ╠═db54ba6e-b419-4455-b0a8-79b65648ca19
# ╠═a544ecb3-cfee-409f-9032-7942b16afb62
# ╟─01186de0-cc28-48c6-b54b-29a40469a8fd
# ╠═567d9a70-3f4d-46e9-bc24-0bb1b9831ca3
# ╠═516ce3d3-f82b-4e83-a581-59b9d65862aa
# ╠═1ee64a42-66d9-43db-ad0d-98fa392d0cd9
# ╟─f527b0c5-d6b7-4b7e-a29d-72bf477a5ff9
# ╠═e091a327-f117-4b6c-9b53-ab4c4e181ea5
# ╟─aa0eedd9-10b2-4c81-8fe1-e98d5032cbfa
# ╟─a7f97394-db89-4a9a-9571-41e549b98a96
# ╟─ecd7e9e0-ceea-4642-a1dc-9d9037e6bd8d
# ╟─d7715940-7493-4699-be9d-08b92ad95def
# ╟─d764fb38-a546-4a54-b3eb-0ee61cd71a12
# ╟─240d7d7f-b26e-4578-9ff5-42f5f4972759
# ╟─42062f71-0160-4c4f-9b47-281fa7e752a1
# ╟─34983789-9500-4cbf-baba-73a22fc20c2e
# ╟─eaeea038-15a3-4b49-86c4-6bb33f7be09c
# ╟─1a5dfb11-64be-4a0d-acc6-0630ba22027f
# ╟─2150e64a-f3d7-4df3-a2a1-1b63a908b54e
# ╟─daba127c-bfa1-4d81-b3d3-e3011e0f4a60
# ╟─870ffdde-28ae-4376-a565-c9644e4979f0
# ╟─7f6ed4d9-14b9-43ce-8515-da0e89c48a0f
# ╟─b960cf36-1af1-4b86-b680-29a1054e90e7
# ╟─1804bf55-a684-45d5-a7fe-d1e45b3ec0a5
# ╟─194deaf5-a8dc-49e3-81ae-2f918763e2da
# ╠═7aad6ffd-e504-472a-a9d5-0bf962e94d88
# ╠═a41047ab-b195-4719-b48a-2da84fa70454
# ╟─65aeec1f-b13d-4c03-b681-d5ac34b2f8fa
# ╟─82edcf27-fb11-441b-8daa-d5a7240ac400
# ╟─7b6be34b-1c3f-4dbd-a741-b1318b09aecb
# ╟─21858957-34b6-4339-8a84-4198a36c61dc
# ╟─32ec7f07-e107-4515-8f5b-a85111a815d2
# ╟─c691600e-a5c0-450a-a457-9409172377e3
# ╟─aaa9f939-188e-4c75-b58e-2eb5e88b37f8
# ╟─c1a95de7-2e2a-4cd2-921e-32bfedf7b329
# ╟─523a2309-862e-45af-81c2-9124c260a5f8
# ╟─6a9d87fc-90c7-4b93-a513-24f14bf3bffe
# ╟─e4fdd0bb-11e1-4e42-8c3b-5f29a70cd7a6
# ╟─d6f811a8-5cb7-44ed-af1c-e05fe61e32ff
# ╟─8876ffc5-c00a-4c5e-94cd-c3dacb81eb67
# ╟─e4cc355b-85e7-4d1a-9401-60be5bcb0880
# ╟─fb36491e-6df0-4772-8066-f29cf00d04af
# ╟─9a4f3052-70db-4b4c-84cd-2192e2b397a5
# ╟─818df519-8154-4deb-97d2-8e70d7d6483f
# ╟─642373b7-441f-4d17-8f23-41c09302f07c
# ╟─e839ca44-a651-4911-a43f-09859262dbbb
# ╟─ab9c4f2e-943b-43c5-9954-6d3e10a67d9f
# ╟─e2c3e757-e038-4748-940d-c60045a034e3
# ╟─c6f8cf20-0c11-4252-8d74-c12a2979b6fa
# ╟─6cbf295b-a8e5-4494-ba03-94afcb98ee61
# ╟─7d8f8160-91d7-46f3-aa44-c881774074e0
# ╟─3d76dca9-8b41-49ac-b4b2-0d7e5e233cbf
# ╠═bd0f6fd0-080b-49bb-82a7-537949d47a36
# ╠═1666c54d-bb77-463c-8efe-4c1123207527
# ╠═4129c46b-052c-4d3b-b87c-1277ce79131d
# ╠═1aaba886-1a8d-4909-bb62-64e531adee36
# ╠═1dd25800-8ddf-4945-92b5-0bb3cabd7682
# ╠═668ecf6a-3567-4a51-8da4-acd641a27993
# ╠═437bd0fe-acc6-4b74-8c15-e76b459734c8
# ╠═d62aa175-5268-4bf0-82b4-47c44c560794
# ╟─3614bee2-86cb-46a0-ac36-dbe1c6eecac7
# ╟─111e0ad1-9a91-4cbc-8653-f642c12b2599
# ╟─13773451-c9a2-47db-a260-78a6f809daad
# ╟─46f0fbc9-84ba-41ec-98a7-51688d80a7b7
# ╟─a8c54fe3-a116-4980-9459-56988a401442
# ╟─1528e80e-e9f2-4417-a938-4c95dbb603c7
# ╟─fc25b76d-3168-4c98-b862-2342e8671f2d
# ╟─96dd6c1c-1a3e-48a5-9c00-8280d404a8e3
# ╟─6380b622-8dd8-4bbb-a31d-32694b44a802
# ╟─5b9dadd8-3062-4289-b880-da976eb13a62
# ╟─133c0979-608b-4bff-bff3-91ccb783600d
# ╟─fe55f4d2-170e-40c3-8232-9de2fc363bf8
# ╠═b5618248-bcb0-4987-8ce6-e93f2c40d5ed
# ╠═17ae157e-42ee-4853-a647-1ff1269bd37c
# ╠═98e5556c-9b65-4cec-a725-6429a2c94100
# ╟─9d449bfb-b3bc-497c-b2e4-b634c93552f4
# ╠═1389c62b-5f18-4ccf-9881-2cffef2a7237
# ╟─bed2e6ff-5045-4cf1-b85c-5853aa89619b
# ╟─bda85f37-da24-4d7e-9f4c-40e3f5974461
# ╟─d735a634-fe06-42a0-86eb-ec631230b35c
# ╟─5f4d78a2-7ed7-48e6-a814-8fb424ed9cb8
# ╟─59d95845-23c4-4548-99cf-4d9fcf91d537
# ╟─3010bc81-7d54-4897-b0c1-12f88451695f
# ╟─76b75272-9f9d-4310-b4fd-dad49ea62c33
# ╟─8f830e79-fd4c-46f2-9a02-67a99e439f41
# ╟─b1393e21-0338-4e01-8855-e9b52f671c2a
# ╟─ce8d095d-5e66-452a-b81c-913f03c794c4
# ╟─de1c35e3-979d-4d1b-8b8a-111c501c9597
# ╟─aa7d28b0-a5a4-4a01-92c9-eca2aeeeaa93
# ╟─2959662f-869e-4cd0-8030-cc9b652e03d8
# ╟─6308ee86-6d28-4ba5-a179-bd682606ab1a
# ╟─b21d472a-c22a-4f7e-a0f6-4ff9906666ad
# ╟─dd2e7573-9cd9-4b5d-84f8-b7864d412770
# ╟─c9a67ff1-57cf-4c3f-98c3-00e933f88cef
# ╟─848bb930-f3fd-42a0-ab80-c51a8ded8a7c
# ╠═b528562d-fea2-468b-bb0d-60797482994b
# ╠═e7f21084-847c-42c5-b95e-27b7029e7bc0
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
