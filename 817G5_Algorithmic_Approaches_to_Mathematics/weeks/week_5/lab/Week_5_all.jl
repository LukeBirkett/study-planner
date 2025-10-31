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

# ╔═╡ 29ca8dc6-7fc0-11ee-1453-47e017e908ee
using PlutoTeachingTools, Plots, Random, Distributions, PlutoUI

# ╔═╡ 32dfd8e1-5379-4403-b074-17d482fadd0d
PlutoUI.TableOfContents()

# ╔═╡ 5f39be10-509b-42b0-be6d-8c8a74a2482d
md"""
# Preamble: Tips and tricks
"""

# ╔═╡ 25e62c4c-2bea-4b51-a906-b13bff69fd45
aside(md"""
![](https://www.researchgate.net/profile/James-Peters-3/post/Why_LaTex_is_better_choice_than_Microsoft_Word/attachment/5e7df27a498d5000016dee25/AS%3A873677591674882%401585312378613/image/LaTeX-vs-Word.jpg)""")


# ╔═╡ 89b49e35-a0c9-4654-b2ad-23507be62512
tip(md"""
**Building latex shortcuts** (optional)

- We are going to be using the $\mathbb{P}$ symbol a lot. It's annoying to write: `\mathbb{P}`

- So I am going to make a **shortcut** in $$\LaTeX$$:
>\newcommand{\P}{\mathbb{P}}

(see code box below).

Now I can just write `\P` instead of `\mathbb{P}`. Much easier!

This tip can be useful when you're writing your masters dissertation, hopefully in LaTeX and not microsoft word!
""")

# ╔═╡ 847f3a0a-f86d-482e-a257-f8fc91e02cb3
md"""
$$\newcommand{\P}{\mathbb{P}}$$
$$\newcommand{\N}{\mathcal{N}}$$ 
$$\newcommand{\U}{\mathcal{U}}$$
"""

# ╔═╡ 016ec8c7-0e18-46ce-8993-841361d14aaf
begin
	f(x) = x^5 - x^3 + 1
	x = -5:5
	plot(x, f.(x); label=false, linewidth=4, xlims=(-2,2), ylims=(-100,100))
end

# ╔═╡ 0362bc5f-c568-4a85-a343-3af3efd98664
md""" 
### Plotting pdfs

- Inspect the plotting code above
- Notice that it has some special, **named** inputs (xlims, label,etc)
- These are known (python + julia) as [keyword arguments](https://docs.julialang.org/en/v1/manual/functions/#Keyword-Arguments)
- They are separated from *normal* arguments by a semicolon. They have to be entered after normal arguments.
- You can make your own keyword arguments for your own functions. They are convenient when you have lots of inputs and are getting mixed up with the order. 
- They are also convenient when you want your function to have **default** values that don't have to be entered manually
EG see below:


"""

# ╔═╡ d6017e00-ff59-4dd0-aaf8-2096fcfaae61
function i_do_nothing(x, y; kw1=5)
	println(kw1)
	return x + y
end

# ╔═╡ eb2da5a8-60b9-4af1-9ead-9f134941c7a7
i_do_nothing(3,4)

# ╔═╡ cbb2d809-f6ef-4800-bcb5-dc83206913b5
i_do_nothing(3,4, kw1=2)

# ╔═╡ 9c8df52a-a183-49b1-ad9d-99b08940c7f5
md"""

- The plot function takes a huge number of keyword arguments so you can annotate different aspects of the plot by name (e.g. `label="something"`). It's unnamed (normal arguments) are the x and y values of the plot.

- Another option is to directly plot a **function**, rather than the x and y values of a function, as done above. This corresponds do a different **method** of the plot function. See the two examples below



"""

# ╔═╡ 879e044d-7362-4262-8e29-10d034a19d63
plot(x, f.(x), title = "this doesn't look smooth due to spacing of xvals", linewidth=4, label=false)

#

# ╔═╡ 77b48e47-6f5b-461b-bb69-f659dde088fd
plot(f, x[1],x[end], label=false, linewidth=3, title = "Much better!")

# ╔═╡ bde7027e-0b04-4eaf-8e70-b8b0c29abfe4
tip(md"""
**Plotting a function directly usually provides a better looking graph, in all languages**. The plotting package intelligently figures out the appropriate spacing of the x values it should evaluate `f` at. See code below
""")

# ╔═╡ 2b1684e0-65da-4d86-b694-5f6f19958e41
md"""
# Practice with probability density functions (PDFs)

- Technically, **any** positive function for which the area under the curve integrates to one is a PDF.

- There are **common** pdfs, used in maths a lot. See code below for some common univariate pdfs ( no need to memorise!)

"""

# ╔═╡ 4d931118-272b-4192-bf4d-bc51dd3f91ca
subtypes(UnivariateDistribution)

# ╔═╡ 18da4764-d04e-469a-9be1-d38310b8b636
md"""
## The principle of maximum entropy

*We won't build on the concept of entropy any more in the course. It's just a fascinating concept which is used a lot and generally nice to understand. And the section is good for practice with PDFs. So it's the least important section of the notebook if you're under time pressure.*

**We will not go through entropy in the lectures**. Instead, this is a chance to practice the important skill of **understanding maths concepts from written notes**.


- The great-crested newt is a rare British amphibian that lives in ponds. 
- Suppose the weight of a newt is somewhere between $5$ and $15$ (grams). 
- Let $R(\omega)$ denote a random variable that outputs the weight of a newt
"""

# ╔═╡ 862663e6-4395-4b54-98c4-dd31b53ce899
question_box(md"""
1. What does the input $\omega$ represent? 
2. What is the outcome space for this experiment? Give an example of an event in this experiment.
3. Does $R$ have a PMF or PDF?
4. *(no correct answer)* Sketch how you think the PMF/PDF of $R$ might look
""")

# ╔═╡ 8ce82d63-95ac-43d2-bf41-c5fc25c569d5
answer_box(md"""
1. It represents an outcome in the experiment, as an RV takes outcomes as inputs and gives numbers as outputs. 
2. Outcomes are individual newts that I've picked from the popuilation in the pond. 
3. PDF: weight is a continuous variable
4. I'd graph the PDF as a uniform random variable on the interval between $5$ and $15$: $R \sim \mathcal{U}([5,15])$. Why? It's completely flat, and says any weight is as likely as any other. There is no reason for me to have a different distribution where some weights are more likely, given that I have no extra information on the weight characteristics of great-crested newts.
""")

# ╔═╡ 94f1bb7c-d863-4318-8856-eddcaca5621f
md"""
- A good choice of distribution for $R$ is a **uniform** (see answer included above). In other words, $R \sim \U([5,15])$.


So let's build a random variable in code!:



"""

# ╔═╡ cd2f6812-8566-46a0-8b73-bfface274d65
u = Uniform(5,15) # look at the live docs to see what you can do with it

# ╔═╡ 2e02bb3e-d314-4924-bfae-d8a4a243f37d
(mean(u), var(u), std(u)) # easy to get statistics of the RV!

# ╔═╡ 5d588e3f-5dfe-4e99-ad89-77f253eac3d2
md"""
We can get its probability density function with the function `pdf`:
`pdf(u,x)` gives the probability density of the RV $u$, at the value $x$.


"""

# ╔═╡ be1e10cf-90c2-4d35-93fb-440b62d45b1f
plot(     #it's nice to write functions with lots of arguments on multiple lines like this!
	x -> pdf(u, x), # this is an anonymous function that takes x-vals to y-vals
	0, 20; #lower and upper bounds
	ylims = (0,0.3), 
	label = "uniform RV",
	linewidth=6,
	linecolor=RGB(1,0,0),
	title = "PDF of a uniform on [0,10]",
	ylabel = "probability density",
	xlabel = "weight (grams)"
)

# ╔═╡ c01f84c9-5b3c-4250-9564-cea467f6680f
md"""


#### Why did we choose a uniform random variable?

- We chose a uniform distribution because you **don't want to be more confident about any particular outcome than you have to be**, given your information on the task. 

- You want the **most uncertain** distribution that corresponds to the information given *(i.e. support is $[5,15]$)*.

- As such, you unconsciously used the [**Principle of maximum entropy**](https://en.wikipedia.org/wiki/Principle_of_maximum_entropy), which we're going to explain a bit now:

---
1. Look at the two probability distributions below, which are high/low entropy respectively. I've added a scatter of samples of the two distributions.

2.  See that samples for the **low** entropy distribution are more likely to be in areas that the pdf assigns **high** probability. So they are **unsurprising** (we already thought beforehand that those outcomes had high probability density / were quite likely)

More generally, samples from a random variable distribution with low entropy are clustered in areas of high probability density (they are unsurprising). The opposite is true for a high entropy distribution. Entropy relates to the **expected surprise** of a sample.

---

"""

# ╔═╡ 95d19ac6-75b7-41ca-adba-66f11de6d1f0
function plot_two_betas(show_samples=true, num_samples=20)
	n = (Beta(10.1, 10.1), Beta(1.2, 1.2))
	descriptions = ("low entropy", "high entropy")
	colours = cgrad(:viridis, length(n), categorical=true)
	
	scaler(x) = 10x + 5 #goes from [0,1] to [5, 15]
	invscaler(x) = (x-5)/10
	x = 0.1:0.1:20

	p = plot()
	for (distribution, description, colour) in zip(n, descriptions, colours)
		plot!(p, x -> pdf(distribution,invscaler(x)), 0,20; label = description , linewidth=4,xlabel="weight (grams)", ylabel = "probability density", color=colour )
		end


	if show_samples
		s = [rand(dist, num_samples) for dist in n]
		for (i,col) in enumerate(colours)
			scatter!(p, scaler.(s[i]), pdf.((n[i],), s[i]) .+ 0.05 , label= false, color=col, markersize=5)
		end
	end
	
	
	return p
end

# ╔═╡ 3e56dc21-f899-430b-8c0a-77c905922746
plot_two_betas()

# ╔═╡ e66edd6d-3b70-4059-b669-c9b30c6878d8
md"## Entropy"

# ╔═╡ c87cb5d8-8e39-41a9-bb94-11b9ffa2ce94
keyconcept("Entropy", md"""

- Intuitively, it measures how *surprising* the average outcome is. Which corresponds to how spread out the distribution is / how short (on the y axis) the pdf tends to be.

- The formula for the entropy of a random variable $X$ is:

$$H(X) = \mathbb{E}[-\log \P[X]]$$

**Intuition for the formula**: 
- First look at the graph of $-\log \P[X]$ below. It's really high when $\mathbb{P}[X]$ is close to zero (i.e. a surprising event).
- I run an experiment, and record $X$
- Was the outcome of $X$ something that was highly likely (i.e. $\P[X]$ was close to $1$) or highly surprising (i.e. $\P[X]$ was close to 0)?
- Note that $-\log \P[X]$ corresponds to the degree of surprise. It's higher if $\P[X]$ is closer to zero.
- Now run the experiment thousands of time, and record the average degree of surprise. This is your entropy!
""")

# ╔═╡ 5faf9f98-61b9-4acf-8d5a-9ef353170753
plot(x -> -log(x), 0.001, 1, linewidth=4, title = "Plot of log X")

# ╔═╡ aa509ff6-34f8-4d2f-9c18-df291a50e790
question_box(md"""
### Entropy: interactive demo:

 $\sigma =$. $(@bind σ²_entropy Slider(0:0.1:10, show_value = true, default=5))
 
 $\mu =$ $(@bind μ_entropy Slider(-5:5, show_value = true, default=0))

- Look at the code in the function `entropy_demo` below
- Play with the sliders here. Explain verbally why changing $\mu$ has no effect, while increasing $\sigma^2$ increases the entropy.

""")

# ╔═╡ 06e82676-69c5-477f-a2b5-0a9093707bbc
function entropy_demo()
	μ = μ_entropy
	σ = sqrt(σ²_entropy)
	
	n1 = Normal(μ, σ)
	n2 = Exponential(σ)
	e = entropy(n1)
	e2 = entropy(n2)
	
	p1 = plot(x -> pdf(n1, x), -10, 10, label="entropy = $(e)", ylims=(0,0.4), linewidth=4)
	plot!(x -> pdf(n2, (x-μ)), -10, 10, label="entropy = $(e2)", ylims=(0,0.4), linewidth=4, title = "Both distributions have the same variance σ²")
	
	return p1
end

# ╔═╡ 953c3184-da11-4b5a-ac17-84b6bab5fef8
entropy_demo()

# ╔═╡ fcca652a-79ec-41f1-bfd5-e4627f4b87f4
md"""
- Both distributions have the same mean $\mu$ and variance $\sigma^2$. As you increase the variance, the entropy obviously increases.
- However, the Gaussian has higher entropy than the exponential for fixed variance.
- In fact, Gaussians are **maximum entropy** distributions: they have more entropy than **any other** distribution with the same mean and variance.
"""

# ╔═╡ 3bbbdc01-162a-4571-8cd7-1b4795e3fb20
keyconcept("Principle of maximum entropy", md"""
This principle says that you should pick the **least surprising** (i.e. highest entropy) probability distribution consistent with what you know about the experiment.

- There are mathematical ways to figure out the max entropy pdf in different scenarios. 
- Here is a list of common [maximum entropy probability distributions](https://en.wikipedia.org/wiki/Maximum_entropy_probability_distribution)
- The uniform distribution is the max ent distribution on an interval $[a, b]$, where $a, b \in \mathbb{R}$
- **The Normal/Gaussian distribution is the max ent distribution given a specified mean and variance**

In other words, if I know nothing about a distribution except its mean and variance, it makes the most sense to model it as a Gaussian!! If I only know the bounds of the random variable (5, 15 for the newt), it makes most sense to model as a uniform!
""")

# ╔═╡ ad8d555e-dffe-4e56-b1a7-47620a7b2ddb
question_box(md"""
I know that the mean height of a class is $170cm$, and the variance is $20$. Explain verbally why 
 	
a) Naively applying the principle of maximum entropy should lead me to model class height as a Gaussian.

 b) What extra 'common sense' (i.e. prior knowledge of the world not contained in this question) should lead me to not model class height as a Gaussian.

""")

# ╔═╡ 172b3814-7f2a-4cd6-8859-8d0438c10876
answer_box(md"""
a) A Gaussian specifies the principle of maximum entropy, given knowledge of the mean and variance. 

b) I know that most people are either biologically male or female, and this leads to differences in height. Thus the distribution might have two peaks (for mean heights of these two groups). This is extra information that should ideally be encoded in the probability distribution we choose.

""")

# ╔═╡ 9f12de78-8aae-4c9b-a5e2-5f9c21f24198
md"""
## Cumulative distribution functions
"""

# ╔═╡ 3667283c-be7b-4bda-9988-5afb37899b6a
keyconcept("CDF", md"""

1. Take a random variable $X$ whose outputs are in $\mathbb{R}$ *(a 'real-valued' RV)*
2. Consider a number $x \in \mathbb{R}$. What's the probability of the event $X \leq x$?
3. This is what the CDF, $F_X(x)$ provides:
$$F_X(x) = \P[X \leq x]$$

""")

# ╔═╡ 79e2df76-ba41-491f-be47-39a717491e5c
question_box(md"""

- In code: `cdf(n,x)` gives the cdf of a distribution `n` at x
- Use this to find the probability that a Gaussian (ie Normal) RV with mean $170$ and variance $30$ is between $165$ and $167$.
- Fill in the function below (`prob_between_a_and_b`). It should take in a distribution (e.g. `n = Normal(3,4)`)



""")

# ╔═╡ 60620f47-5ce5-45bd-8cbb-c879f3a064f2
answer_box(md"""
We have 
$$X \sim \N(170, \sqrt{30})$$

*(note that the second argument of `Normal` in julia is the standard deviation, not the variance. Standard deviation is the square root of variance)*



$\P[ 165 \leq X \leq 167] = \P[X \leq 167] - \P[X \leq 165]$

So we get 

$(cdf(Normal(170, sqrt(30)), 167) - cdf(Normal(170, sqrt(30)), 165))

- Same intuition for filling in the `prob_between_a_and_b` function below
""")

# ╔═╡ 790e8e47-f68e-4dc1-a4ea-85cf5add66aa
function prob_between_a_and_b(distribution, a, b)
	(a > b) && return 0 
	return cdf(distribution, b) - cdf(distribution,a)
end

# ╔═╡ 4c0c5d40-607a-43c6-8000-0a4544396224
begin
	nn = Normal(170, sqrt(30))
	prob_between_a_and_b(nn,163,167)
end

# ╔═╡ 95b91906-84b2-4eb3-884e-81671324d865
md"""

#### Understanding the CDF visually

- Play with the plots below. They show the PDF and CDF for both the (familiar) Gaussian distribution, and the (unfamiliar) Exponential distribution. What's the relationship with the pdf and the cdf? Why does the CDF tend towards $1$ for ANY pdf?

μ: $(@bind μᵪ Slider(1:10, show_value=true, default=0))

 $\sigma^2$: $(@bind σ²ᵪ Slider(0.2:0.2:2, show_value=true, default=1))

"""

# ╔═╡ 7afb3924-a811-45cf-b4ea-b0e26d9374ae
function gaussian_pdf_and_cdf(μ, σ²)
	n = Normal(μ, σ²)
	p = plot(x -> pdf(n, x), linewidth=4, label="pdf", title = "Normal distribution", xlims=(0,10))
	plot!(p, x -> cdf(n,x), linewidth=4, label="cdf")
	return p
end

# ╔═╡ d75138a3-51e8-41be-b8d1-14a8207fd21f
function exponential_pdf_and_cdf(μ)
	e = Exponential(μ)
	p = plot(x -> pdf(e, x), linewidth=4, label="pdf", title = "Exponential distribution", xlims=(-1,10))
	plot!(p, x -> cdf(e,x), linewidth=4, label="cdf")
	return p
end

# ╔═╡ 4d4d16c1-7812-40d1-afdf-4fcb339ba64d
plot(gaussian_pdf_and_cdf( μᵪ,σ²ᵪ), exponential_pdf_and_cdf( μᵪ), layout=(2,1))

# ╔═╡ 14fe2fbc-b4aa-4aed-a53b-027b3007e791
answer_box(md"""
- At a point $x$, the value of `cdf(x)` is given by the total area under the left hand side of the pdf curve (ie between $-\infty$ and $x$). For those who know integrals, this is $$-\int_{-\infty}^x f(x) \ dx$$ where $f$ is the pdf

- For a large enough $x$, we will always have $\mathbb{P}[X \leq x] = 1$, regardless of the pdf. In other words, any random variable is always smaller than **something**.
""")

# ╔═╡ d88b7d79-9573-4a8c-8e2a-e7fd56174dbc
md"""
# Practice with Bayes Theorem
"""

# ╔═╡ 657eb6f7-927a-4081-b748-40cb36e7c616
keyconcept("Law of conditional probability", md"""

$$\P[A | B] = \frac{\P[A \cap B]}{\P[B]}$$

""")

# ╔═╡ a61cf568-db35-433c-9f50-eee22bfd3440
keyconcept(" Bayes Theorem", md"""


$$\P[A | B] = \frac{\P[B | A] \P[A]}{\P[B]}$$.
""")

# ╔═╡ 45ee118a-1380-46ed-b8bb-6d4c599b0d34
md"""

- Make sure you understand how the law of conditional probability and Bayes' theorem are derived from a Venn diagram in the lectures 


"""

# ╔═╡ 9a67069d-54f4-4d9a-9445-a43c831eda66
question_box(md"""
**Deriving Bayes Law**

1. Use the law of conditional probabilities to write expressions for both $\P[B | A]$ and $\P[A | B]$

2. Use the previous question to write two expressions for $\P[A \cap B]$. One in terms of $\P[B | A]$, and the other in terms of $\P[A | B]$.

3. Use this to derive Bayes' Law
""")

# ╔═╡ 4fe16934-28a1-469f-a41c-0d42a6ebaa1a
answer_box(md"""

$$\P[B | A ] = \P[ A \cap B] \P[A]$$



$$\P[A \cap B] = \P[B | A] \P[A] = \P[A | B]\P[B]$$

Rearrange the last two terms to get Bayes' law
""")

# ╔═╡ 2e7b6321-8f56-400d-8f34-d6b3a11189c1
md"""

## Case study: notebooks and marks

In this long-format question we will the consider the marks you get on your assessment as the experiment.

- Suppose there are $230$ students
- Let the set of possible marks be $[1, 100] \cap \mathbb{N}$

*(In other words, any number on the interval between 1 and 100, intersected with the natural numbers)*
"""

# ╔═╡ 87cf64f5-1707-4ba3-ac54-ae5b7c705461
question_box(md"""
1. What is the sample space (/outcome space) for this experiment? Ideally write it in maths.
2. Is the sample space a vector space?
3. *Optional challenge*: What's the cardinality of the outcome space (easier)? What's the cardinality of the event space (harder)?
4. If we built a probability measure for the event space, would random variables on the sample space have a probability density function (PDF) or a probability mass function (PMF)? How does this relate to the cardinality of the outcome space?
""")

# ╔═╡ 82372462-2ab2-4ce3-b3c4-36548be2c276
answer_box(md"""


1. $$\Omega = \{n \in \mathbb{N}^{230}: n_i \in [1, 100] \ \forall i \}$$

IE the set of vectors of length $230$, whose entries are all natural numbers, and whose entries all fall between $1$ and $100$.

2. No it's not a vector space. We could do addition $\mod 100$ in this set and it would be closed under addition. But there is no multiplicative inverse. Just like the natural numbers themselves: the multiplicative inverse of $2$ is $\frac{1}{2}$, but this isn't in $\mathbb{N}$.

3. 

- The event space is the set of subsets of outcomes. Including the empty set $\emptyset$ and the entire outcome space $\Omega$. BTW, the set of subsets of a set is known as its [**power set**](https://en.wikipedia.org/wiki/Power_set)

- So the question boils down to asking: how many subsets can you make of a set of $M$ elements, where $M$ is the cardinality of the outcome space? 


- First,  $M = | \Omega | = 100^{230}$. Each student can get $100$ different possible marks. There are $230$ students*. So $100 \times 100 \times 100 \dots$ (230 times)

- The power set of a a set of cardinality $M$ has cardinality $2^M$. You can prove this by induction, starting with a set of cardinality one. I'm not going to here.

- So the number of possible events is $2^{100^{230}}$. Far higher than atoms in the universe!

4. Probability mass function. Despite the big numbers above, there are still finite possible outcomes. A random variable maps outcomes to numbers, and cannot be one-to-many. So it can only take finite values. 
""")

# ╔═╡ 371e7bc6-e229-4dfa-b998-e5caabe53f44
md"""


- Let's divide the AAM students into two sets. Those who attempted the notebooks and those who didn't. We will call these respective sets $Y$ (attempted notebooks) and $X$ (ignored notebooks).

- Let the cardinalities of the two sets be $| Y | = 150 $ and $ | X | = 80$

- Let the mean and variances respectively be:

$$\mu(Y) = 70; \quad \mu(X) = 60$$
$$\sigma^2(Y) = 10; \quad \sigma^2(X) = 30$$

*Notice that $\mu$ and $\sigma^2$ are commonly used shorthands for the mean and variance, respectively. $\sigma$ itself is the standard deviation: the square root of the variance*

So students who attempted the notebooks did a bit better, and had lower variance.

!!! info "Question"
	- We pick a random student. Let $E_n$ be the event that the student has $n$ marks. We're going to work towards calculating the probabilities  $\mathbb{P}[X | E_n]$ and $\mathbb{P}[Y | E_n]$: i.e. the probabilities they are in $X$ or $Y$ given their mark.
 

	1. Rewrite $\mathbb{P}[E_n]$ in terms of $\mathbb{P}{[E_n | X]}$, $\mathbb{P}{[E_n | Y]}$, $\mathbb{P}[X]$, and $\mathbb{P}[Y]$. Drawing a Venn diagram might help. Otherwise, google the law of total probability to help.

	2.  Use Bayes' theorem, and the previous question to re-express $\mathbb{P}[X | E_n]$ and $\mathbb{P}[Y | E_n]$ in terms of $\mathbb{P}{[E_n | X]}$,  $\mathbb{P}{[E_n | Y]}$, $\mathbb{P}[X]$, and $\mathbb{P}[Y]$.

We're going to work towards calculating these probabilities explicitly, using code. As such, you will need the answers, which are below:
"""

# ╔═╡ 1a3d8c0c-aa64-4213-b978-e2375feb26a4
answer_box(md"""
1. $\mathbb{P}[E_n] = \mathbb{P}[E_n  \cap X] + \mathbb{P}[E_n  \cap Y]$, since $X$, and $Y$ collectively cover the entire outcome space. We can rewrite this as 


$$\mathbb{P}[E_n] = \mathbb{P}[E_n |X] \mathbb{P}[X] + \mathbb{P}[E_n |Y] \mathbb{P}[Y]$$. 

using the law of conditional probability. Overall, this is  known as the law of total probability. 

2. $\mathbb{P}[X | E_n] = \frac{\mathbb{P}[E_n | X] \mathbb{P}[X]}{\mathbb{P}[E_n]}$.
Using our formula from the previous question, we can rewrite this as

$$\mathbb{P}[X | E_n] = \frac{\mathbb{P}[E_n | X] \mathbb{P}[X]}{\mathbb{P}[E_n |X] \mathbb{P}[X] + \mathbb{P}[E_n | Y] \mathbb{P}[Y]}$$
""")

# ╔═╡ 3e81e845-0b71-4314-9d63-4419e022d475
md"""

### What probability distribution should we give the marks?

- If we already had the marks, we could use some type of density estimation to get an empirical probability distribution for the marks. We aren't going to do that for this question though.

- If marks were continuous, the principle of maximum entropy would tell us that it's reasonable to model them as a Gaussian distribution.
- Marks can't be distributed as a Gaussian, since they are discrete. Instead, let's **do a common trick to make Gaussian-like discrete random variables** (done for $X$ below):

---

1. Take a **continuous** (Gaussian) random variable $Z_X \sim \mathcal{N}(\mu(X), \sigma^2(X))$. 

2. Gaussian random variables have unbounded support $(-\infty, \infty)$, and thus $Z_X$ could be outside $[1,100]$. So let's **condition** $Z_X$ to be in this interval:
- Take $G_X$ as the event that $Z_X \in [1,100]$
- Law of conditional probability: $\mathbb{P}[Z_X =z | G] = \frac{\mathbb{P}[Z_X = z]}{\mathbb{P}[G_X]}$

3. We then take the probability of a student  in $X$ getting a mark $m$ as:

 $$\mathbb{P}[X = m] = \P\big[Z_X | G_X \in [m-1, m]\big]$$

*EG the probability of getting a mark $m=3$ is the probability of the continuous random variable falling between $m-1=2$ and $m=3$.*

An alternative way to express this is:

 $\mathbb{P}[X = m] = \frac{\P[Z_X \in [m-1, m]]}{\mathbb{P}[ G_X]}$

---

- We can use the same formula for students in $Y$, but using a Gaussian RV $Z_Y$ and substituting $\mu(Y)$ and $\sigma^2(Y)$ instead.


"""


# ╔═╡ 49f3077b-e981-42d8-b3d2-beb7bec9677c
md"""
#### Overall goal: code functions that provide $\mathbb{P}[X | E_n]$ and $\mathbb{P}[Y | E_n]$

We are going to do this in stages. I'm going to hold your hand, and also push you to code the answer in a new style that may seem annoying / unintuitive, but is really useful
"""

# ╔═╡ d7723067-27dc-4b28-84f7-f06ef805ad6a
keyconcept("New programming technique: dictionaries", md"""

- We're going to be re-using/writing a lot of the same code, but for two different categorical variables: "X" and "Y".

- So instead of writing an entirely new function for each $X$ vs $Y$ probability, we can group variables into the two categories using a dictionary. See the code below:
""")

# ╔═╡ 899a3ee1-7baf-4332-a35b-a224cfce179a
begin
	groups = ["X", "Y"]
	μ = Dict(
		"X" => 60,
		"Y" => 70
	)

	σ = Dict(
		"X" => 30,
		"Y" => 10
	)

	prob_in_set = Dict(
		"X" => 80/230,
		"Y" => 150/230
	)

	Z = Dict(
		el => Normal(μ[el], σ[el]) for el in groups
	) #note that we have built a dictionary from an iterable here!!
end

# ╔═╡ eebd1b27-73e4-4683-831f-6bc366e815f2
prob_in_set["X"]

# ╔═╡ 2e9f4f30-4a1f-4f92-836e-4417c4154d6f
md"""
- Our first goal is to build functions describing the probabilities $\mathbb{P}[E_n | X]$ and $\mathbb{P}[E_n | Y]$
- Fill in the function `unnamed(n)`, and figure out how to call it from the dictionary `probEn_given`
"""

# ╔═╡ 679f9223-f68e-4739-8259-17dee1fde9f6
probEn_given = Dict(
	el => function unnamed(n)
		return missing
	end for el in groups)

# ╔═╡ 50ecd36c-183e-4681-977e-8c7a03bc0f02
answer_box(md"""
	```	   
	probEn_given = Dict(
	el => function unnamed(n)
		return cdf(Z[el], n) - cdf(Z[el], n-1)
	end for el in groups)
	```
	"""
)


# ╔═╡ 27a5536b-7ef6-47bd-92f7-c6ba17e1f3e5
probEn_given["X"](53)

# ╔═╡ ab2ec723-7c95-4e65-bbee-fa2fd35e9b93
md"""
Our next goal is to get an expression for $\mathbb{P}[E_n]$, using the law of total probability. Fill in the function below. IE replace the `0` with the correct formula, which will depend on the previous functions you have written.
"""

# ╔═╡ b7dd910b-c88b-4125-9648-b27557bc820e
function probEn(n)
	return sum(
		0 for el in groups
	)
end

# ╔═╡ 1cacb6ea-29e6-4b25-be7a-1f2dd0c921b7
answer_box(md"""
		   
```
function probEn(n)
	return sum(
				probEn_given[el](n)*prob_in_set[el] for el in groups)
end
```

""")

# ╔═╡ 5206a8ee-67d9-4296-ae00-176a6cc94b98
md"""
- Now you can fill in the final formula for $\mathbb{P}[X | E_n]$ and $\mathbb{P}[Y | E_n]$.

- Try to fill it in as a dictionary of functions, as you did for `probEn_given`.
"""

# ╔═╡ 90a11d6b-84f0-4d2e-804d-1051c9ec68f5
prob_in_set_given_en = Dict(
	el => function unnamed(n)
		return missing
	end for el in groups
)

# ╔═╡ 0258de9d-8a17-40a3-9e23-5aef81265fc0
answer_box(md"""
```	   
prob_in_set_given_en = Dict(
	el => function unnamed(n)
		return probEn_given[el](n)*prob_in_set[el]/probEn(n) 
	end for el in groups)
```
"""
)

# ╔═╡ 61e4c79c-0104-4ebe-b9a6-212ad7951237
prob_in_set_given_en["X"](80)

# ╔═╡ adb2ede5-f22d-4ca3-9f0a-2662499eebbf
question_box(md"""
1. Suppose I pick a student $s$ who got $53$. What's the probability that $s \in X$?
2. (*Optional challenge*): Suppose I pick two students: $s_1$ and $s_2$. They are both in the same set ($X$ or $Y$). They get marks $x_1$ and $x_2$. What is the probability they are both in $X$? The law of conditional probability will help!
""")

# ╔═╡ 57c70319-5105-4ec3-b422-7915355358b5
prob_in_set_given_en["X"](53)

# ╔═╡ b2580544-a8d8-434f-98d7-2db5bca01807
answer_box(md"""
- Let $A$ be the event that both students are in the same set.

- Let $B$ be the event that both students are in $X$.

- Let $C$ be the event that both students are in $Y$.

We are looking for $\P[B | A]$:

Law of conditional probability:

$\P[B| A] = \frac{\P[A \cap B]}{\P[A]}$

What is $\P[A]$? It's the union of the following two events: 
- probability both students are in $X$ 
- probability both students are in $Y$

Since these events, have no intersection, it's the sum of the probabilities of these two events:

$\P[A] = \P[B] + \P[C]$.

So we get 

$\P[B | A] = \frac{\P[A \cap B]}{\P[B] + \P[C]} = \frac{\P[B]}{\P[B] + \P[C]}$

How do we calculate $\P[B]$ and $\P[C]$? They're just the product of the probabilities of each student being in $X$ or $Y$!...

$$\mathbb{P}[B] = \mathbb{P}[s_1 \in X ] \mathbb{P}[s_2 \in X ]$$

The answer is coded below
""")

# ╔═╡ f34bf2cc-0ff3-40bf-92a0-39c5bad4c119
function q2_answer(x1,x2)
	return missing
end

# ╔═╡ d602f7cb-8cc6-4ff3-b3e9-e5a21b3e2d7d
answer_box(
	md"""
	```
	function q2_answer(x1, x2)
		Ps = Dict(group => prod(prob_in_set_given_en[group](el) for el in (x1, x2)) for group in groups)
		# so Ps["X"] is the probability both are in X. 
		return Ps["X"] / (Ps["X"] + Ps["Y"])
	end
	```
	"""
)

# ╔═╡ 8e583ba2-59f1-4b6b-801f-6c658a60db74
q2_answer(51,52)

# ╔═╡ f0bb41d5-43e2-4531-ac33-3c3ea7d70ef7
md"""
# Practice on transforming expectations and variances
"""

# ╔═╡ 12805d96-9dcc-4fb2-b882-7b0cbd16fbe6
question_box(md"""
In the lecture we talked about Bernoulli random variables. They describe questions about an experiment with a binary outcome (e.g. did the coin flip heads?).

Recall that if $X \sim Bern(p)$, then $X$ has the following PMF:
$$f_X(x) = 
\begin{cases}
1-p & (x = 0) \\
p & (x = 1)
\end{cases}$$


A binomial random variable is describes the sum of $n$ Bernoulli random variables. (e.g. how many heads did I get out of $n=5$ coin flips). We write: $X \sim B(n,p)$

1.  Use the PMF of a Bernoulli random variable to calculate its expected value and variance as a function of $p$.

2. **Use the previous answer** to determine the expected value and variance of a binomial random variable as a function of $n$ and $p$. You only need to think about how to calculate the variance of a sum of Bernoulli random variables. 
3. *(Hard, optional)*
In the previous answer, we derived the expected value and variance of a Binomial random variable **without** using its probability mass function. In this question, try to derive the probability mass function of a binomial random variable. Hints:
- Think about the probability of getting $k$ heads on a sequence of $n$ coin flips:
    - What's the probability of one particular sequence of heads and tails with $k$ heads? 
    - How many different sequences of flips with $k$ heads exist? [This page](https://en.wikipedia.org/wiki/Binomial_coefficient) might help answer that.
    
The answer to this question is summarised on the [wiki page](https://en.wikipedia.org/wiki/Binomial_distribution#Probability_mass_function). 
""")

# ╔═╡ 9e7daf27-1985-45c1-9cde-c808b076f383
answer_box(md"""

1. The mean is:
$$\mathbb{E}[X] = \P[X=0]*0 + \P[X=1]*1] = p$$

Note that
$$\mathbb{E}[X^2] = \P[X=0]*0^2 + \P[X=1] = p$$

The variance is therefore

$$\mathbb{E}[X^2] - \mathbb{E}[X]^2 = p-p^2 = p(1-p)$$

2. Suppose we have $n$ random variables $\{X_i\}_{i=1}^n$ that are independent and identically distributed (i.i.d) So they each have the same mean and variance. Let $S_n = \sum_{i=1}^nX_i$.

Then by the laws of adding variances, we have:

$var(S_n) = \sum var(X_n)$.

So if $X_i \sim \text{Bernoulli}(p)$, then $S_n$ is a binomial, and $var(S_n) = np(1-p)$

3. The answer to this question is summarised on the [wiki page](https://en.wikipedia.org/wiki/Binomial_distribution#Probability_mass_function). 
""")

# ╔═╡ e617500c-9c64-4303-a663-1986c32ee66f
md"""
# Practice on central limit theorem
"""

# ╔═╡ 47276d09-9cb2-46f8-b4cd-9dd8a0323161
aside(md"![](https://i.redd.it/el0bknfgdg091.jpg)")

# ╔═╡ 5b02cb14-01ce-4207-92d5-13e59a9561d6
question_box(md"""
- What's the relationship between the central limit theorem and the picture to the right?

- Would the pattern of wear look the same if there were only e.g. $5$ machine users?
""")

# ╔═╡ b770914b-c416-4309-9f50-d9e439bff1d1
answer_box(md"""
Suppose there are $n$ gym users. Let $w_i$ be the weight that the $i^{th}$ gym user works out with.

We can think of $\{w_i\}_{i=1}^n$ as a set of identically distributed random variables. No idea what the distribution is, of course.

let's assume that the wear on each weight is roughly proportional to the number of users. Then $S_n = \frac{1}{n}\sum_{i=1}^n$ is approximately distributed as a Gaussian, if $n$ is large, by the central limit theorem. This is regardless of the distribution of each random variable $w_i$.


- If $n$ is small, the central limit theorem doesn't hold. We might e.g. have 3 'strong' gymmers, and 2 'weak' gymmers. The pattern of wear would then have two peaks at the 'weak' weight and the 'strong' weight. There is no reason for it to look Gaussian.

""")

# ╔═╡ 96a30247-e66b-4324-80cd-ac1e9fe726d9
question_box(md"""
Take the following uniform distribution:

$$Z \sim \mathcal{U}[\{1,2,4,9\}]$$.

Note that it can be simulated with the following code: `rand([1,2,4,9])`. I've made a function below: `random_output`, that does this for you.

1. Inspect the histogram (and code) below. It gives you the histogram of the outcomes of $Z$ over $100$ trials.

We now want to investigate the distribution of a random variable $$\bar{Z}_n = \frac{1}{n} \sum_{i=1}^n Z_i,$$ which charts the average of $n$ i.i.d (independent, identically distributed) samples of $Z$ from the question above. 

I've built a function ```sample_average(n)```, that returns $\bar{Z}_n$. In other words, it samples ```random_output()``` $n$ times, and returns the average of these $n$ trials.

2. Build a function ```sample_average_distribution(m,n)```, which runs ```sample_average(n)``` $m$ times, and returns an array of length $m$ with the output of each experiment.

3. Plot a histogram of ```sample_average_distribution(400,100)```. What do you notice about the distribution? Can you explain in terms of the central limit theorem?

**Optional**:

We talked about the (true) variance of a random variable in the lecture. One can also estimate the variance of an RV with unknown distribution **from data**. This is known as the sample variance. You apply ```var``` to an array of samples (`np.var` in python) to get it.


I've plotted a scatter graph of the sample variance of ```sample_average(n)``` as a function of $n$ (i.e. $n$ on the x-axis, sample variance on the y-axis, together with its mean. What function $f(n)$ does/should it look like, given the central limit theorem? *Hint: you might need to calculate the analytic variance of `random_output`*!

""")

# ╔═╡ c7a1dfe9-742e-4ab1-b14e-d2e80685ba87
random_output() = rand([1,2,4,9])

# ╔═╡ b2cbffc5-887b-4731-8235-92cf5e84044d
random_output()

# ╔═╡ a5229c70-87d3-4761-8e52-7cce04d1ada5
histogram([random_output() for i in 1:100], bar_width=0.5, bars=4) #rerun this several times

# ╔═╡ 114b986e-0b7e-4547-8c93-7b49ceb2000c
function sample_average(n)
	run(i) = random_output()
	return mean(i -> run(i), 1:n) # could also just write mean(run, 1:n)
end

# ╔═╡ 21c7c5e3-a3cd-46e0-a59e-b515d25851be
answer_box(
md"""
```
function sample_average_distribution(m,n)
	return [sample_average(n) for i = 1:m]
end
histogram(sample_average_distribution(400,100))
```

- The distribution is Gaussian. The random variable is an average of another random variable (`rand_output`). It's an average of a sufficiently large number of copies (100) that the central limit theorem applies.

- If you change the 100 above to a lower number than 30, you might see that it looks less Gaussian

	
"""
)

# ╔═╡ 8ebb0cf9-9a99-4e21-8473-99fe0fc3d50c
answer_box(
md"""
### Optional question

```
sample_variance(m,n) = var(sample_average(n) for i = 1:m) #variance of m repeats of the sample average of n samples
num_samples = 100
my_sample_variance(n) = sample_variance(num_samples,n)
my_sample_variance(100)
mm = mean([1,2,4,9])
ss = mean([1,2,4,9].^2)
var_of_choice = ss - mm^2
println("analytic variance of random output is ", var_of_choice)
```

The variance of individual trials is $(var_of_choice). 
So the variance of an average of $n$ trials will be that value divided by $\sqrt{n}$

```
begin
	s = plot()
	repeats = 6
	for i = 1:repeats
		scatter!(s,my_sample_variance, 5:100, label = "repeat $i", xlabel = "number of trials", ylabel = "sample variance")
	end
	plot!(s, x -> var_of_choice/x, 5:100, linewidth=6, label="plot of $(var_of_choice)/x")
end
```

"""
)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
Distributions = "~0.25.122"
Plots = "~1.41.1"
PlutoTeachingTools = "~0.4.6"
PlutoUI = "~0.7.72"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.0"
manifest_format = "2.0"
project_hash = "cb8dd7f282e1196da72df41332bc29c080f958a3"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fde3bf89aead2e723284a8ff9cdf5b551ed700e8"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

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
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "d9d26935a0bcffc87d2613ce14c527c99fc543fd"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.0"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "6c72198e6a101cccdd4c9731d3985e904ba26037"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "473e9afc9cf30814eb67ffa5f2db7df82c3ad9fd"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.16.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "3bc002af51045ca3b47d2e1787d6ce02e68b943a"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.122"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

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

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "173e4d8f14230a7523ae11b9a3fa9edb3e0efd78"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.14.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

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

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "fcb0584ff34e25155876418979d4c8971243bb89"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+2"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "1828eb7275491981fa5f1752a5e126e8f26f8741"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.17"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "27299071cc29e409488ada41ec7643e0ab19091f"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.17+0"

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

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "50c11ffab2a3d50192a228c313f05b5b5dc5acb2"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.86.0+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a6dbda1fd736d60cc477d99f2e7a042acfa46e8"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.15+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "5e6fe50ae7f23d171f44e311c2960294aaa0beb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.19"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "f923f9a774fcf3f5cb761bfa43aeadd689714813"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.1+0"

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "68c173f4f449de5b438ee67ed0c9c748dc31a2ec"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.28"

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

[[deps.IrrationalConstants]]
git-tree-sha1 = "b2d91fe939cae05960e760110b328288867b5758"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.6"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

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

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

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
version = "1.12.0"

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

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f00544d95982ea270145636c181ceda21c4e2575"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.2.0"

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

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3cce3511ca2c6f87b19c34ffc623417ed2798cbd"
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.10+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.5.20"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.7+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "f1a7e086c677df53e064e0fdd2c9d0b0833e3f6e"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.5.0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.1+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

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
version = "10.44.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "f07c06228a1c670ae4c87d1276b92c7c597fdda0"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.35"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1f7f9bbd5f7a2e5a9f7d96e51c9754454ea7f60b"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.4+0"

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
version = "1.12.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "3ca9a356cd2e113c420f2c13bea19f8d3fb1cb18"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "12ce661880f8e309569074a61d3767e5756a199f"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.41.1"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoUI"]
git-tree-sha1 = "dacc8be63916b078b592806acd13bb5e5137d7e9"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.4.6"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "f53232a27a8c1c836d3998ae1e17d898d4df2a46"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.72"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "07a921781cab75691315adc645096ed5e370cb77"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.3"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "1d36ef11a9aaf1e8b74dacc6a731dd1de8fd493d"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.3.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "34f7e5d2861083ec7596af8b8c092531facf2192"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.8.2+2"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll"]
git-tree-sha1 = "da7adf145cce0d44e892626e647f9dcbe9cb3e10"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.8.2+1"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "9eca9fc3fe515d619ce004c83c31ffd3f85c7ccf"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.8.2+1"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "8f528b0851b5b7025032818eb5abbeb8a736f853"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.8.2+2"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "9da16da70037ba9d701192e27befedefb91ec284"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.2"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

[[deps.REPL]]
deps = ["InteractiveUtils", "JuliaSyntaxHighlighting", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "852bd0f55565a9e973fcfee83a84413270224dc4"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.8.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "58cdd8fb2201a6267e1db87ff148dd6c1dbd8ad8"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.1+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

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
version = "1.12.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "f2685b435df2613e25fc10ad8c26dddb8640f547"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.6.1"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "95af145932c2ed859b63329952ce8d633719f091"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.3"

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

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "8e45cecc66f3b42633b8ce14d431e8e57a3e242e"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.5.0"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.8.3+2"

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

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

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

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "96478df35bbc2f3e1e791bc7a3d0eeee559e60e9"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.24.0+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fee71455b0aaa3440dfdd54a9a36ccef829be7d4"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.1+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a3ea76ee3f4facd7a64684f9af25310825ee3668"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.2+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "9c7ad99c629a44f81e7799eb05ec2746abb5d588"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.6+0"

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

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c74ca84bbabc18c4547014765d194ff0b4dc9da"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.4+0"

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

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "75e00946e43621e09d431d9b95818ee751e6b2ef"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.2+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "a376af5c7ae60d29825164db40787f15c80c7c54"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.3+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "a5bc75478d323358a90dc36766f3c99ba7feb024"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.6+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "aff463c82a773cb86061bce8d53a0d976854923e"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.5+0"

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

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "e3150c7400c41e207012b41659591f083f3ef795"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.3+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "9750dc53819eba4e9a20be42349a6d3b86c7cdf8"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.6+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f4fc02e384b74418679983a97385644b67e1263b"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll"]
git-tree-sha1 = "68da27247e7d8d8dafd1fcf0c3654ad6506f5f97"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "44ec54b0e2acd408b0fb361e1e9244c60c9c3dd4"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "5b0263b6d080716a02544c55fdff2c8d7f9a16a0"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.10+0"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f233c83cad1fa0e70b7771e0e21b061a116f2763"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.2+0"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "801a858fc9fb90c11ffddee1801bb06a738bda9b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.7+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "00af7ebdc563c9217ecc67776d1bbf037dbcebf4"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.44.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c3b0e6196d50eab0c5ed34021aaa0bb463489510"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.14+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6a34e0e0960190ac2a4363a1bd003504772d631"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.61.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "371cc681c00a3ccc3fbc5c0fb91f58ba9bec1ecf"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.13.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "125eedcb0a4a0bba65b657251ce1d27c8714e9d6"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.4+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.13.1+1"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56d643b57b188d30cccc25e331d416d3d358e557"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.13.4+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "91d05d7f4a9f67205bd6cf395e488009fe85b499"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.28.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "07b6a107d926093898e82b3b1db657ebe33134ec"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.50+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.5.0+2"

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

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "fbf139bce07a534df0e699dbb5f5cc9346f95cc1"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.9.2+0"
"""

# ╔═╡ Cell order:
# ╠═29ca8dc6-7fc0-11ee-1453-47e017e908ee
# ╟─32dfd8e1-5379-4403-b074-17d482fadd0d
# ╟─5f39be10-509b-42b0-be6d-8c8a74a2482d
# ╟─25e62c4c-2bea-4b51-a906-b13bff69fd45
# ╟─89b49e35-a0c9-4654-b2ad-23507be62512
# ╠═847f3a0a-f86d-482e-a257-f8fc91e02cb3
# ╠═016ec8c7-0e18-46ce-8993-841361d14aaf
# ╟─0362bc5f-c568-4a85-a343-3af3efd98664
# ╠═d6017e00-ff59-4dd0-aaf8-2096fcfaae61
# ╠═eb2da5a8-60b9-4af1-9ead-9f134941c7a7
# ╠═cbb2d809-f6ef-4800-bcb5-dc83206913b5
# ╠═9c8df52a-a183-49b1-ad9d-99b08940c7f5
# ╠═879e044d-7362-4262-8e29-10d034a19d63
# ╠═77b48e47-6f5b-461b-bb69-f659dde088fd
# ╟─bde7027e-0b04-4eaf-8e70-b8b0c29abfe4
# ╟─2b1684e0-65da-4d86-b694-5f6f19958e41
# ╠═4d931118-272b-4192-bf4d-bc51dd3f91ca
# ╟─18da4764-d04e-469a-9be1-d38310b8b636
# ╟─862663e6-4395-4b54-98c4-dd31b53ce899
# ╟─8ce82d63-95ac-43d2-bf41-c5fc25c569d5
# ╟─94f1bb7c-d863-4318-8856-eddcaca5621f
# ╠═cd2f6812-8566-46a0-8b73-bfface274d65
# ╠═2e02bb3e-d314-4924-bfae-d8a4a243f37d
# ╟─5d588e3f-5dfe-4e99-ad89-77f253eac3d2
# ╠═be1e10cf-90c2-4d35-93fb-440b62d45b1f
# ╟─c01f84c9-5b3c-4250-9564-cea467f6680f
# ╟─95d19ac6-75b7-41ca-adba-66f11de6d1f0
# ╠═3e56dc21-f899-430b-8c0a-77c905922746
# ╟─e66edd6d-3b70-4059-b669-c9b30c6878d8
# ╟─c87cb5d8-8e39-41a9-bb94-11b9ffa2ce94
# ╠═5faf9f98-61b9-4acf-8d5a-9ef353170753
# ╟─aa509ff6-34f8-4d2f-9c18-df291a50e790
# ╠═953c3184-da11-4b5a-ac17-84b6bab5fef8
# ╟─06e82676-69c5-477f-a2b5-0a9093707bbc
# ╟─fcca652a-79ec-41f1-bfd5-e4627f4b87f4
# ╟─3bbbdc01-162a-4571-8cd7-1b4795e3fb20
# ╟─ad8d555e-dffe-4e56-b1a7-47620a7b2ddb
# ╟─172b3814-7f2a-4cd6-8859-8d0438c10876
# ╟─9f12de78-8aae-4c9b-a5e2-5f9c21f24198
# ╟─3667283c-be7b-4bda-9988-5afb37899b6a
# ╟─79e2df76-ba41-491f-be47-39a717491e5c
# ╟─60620f47-5ce5-45bd-8cbb-c879f3a064f2
# ╠═790e8e47-f68e-4dc1-a4ea-85cf5add66aa
# ╠═4c0c5d40-607a-43c6-8000-0a4544396224
# ╟─95b91906-84b2-4eb3-884e-81671324d865
# ╠═4d4d16c1-7812-40d1-afdf-4fcb339ba64d
# ╠═7afb3924-a811-45cf-b4ea-b0e26d9374ae
# ╠═d75138a3-51e8-41be-b8d1-14a8207fd21f
# ╟─14fe2fbc-b4aa-4aed-a53b-027b3007e791
# ╟─d88b7d79-9573-4a8c-8e2a-e7fd56174dbc
# ╟─657eb6f7-927a-4081-b748-40cb36e7c616
# ╟─a61cf568-db35-433c-9f50-eee22bfd3440
# ╟─45ee118a-1380-46ed-b8bb-6d4c599b0d34
# ╟─9a67069d-54f4-4d9a-9445-a43c831eda66
# ╟─4fe16934-28a1-469f-a41c-0d42a6ebaa1a
# ╟─2e7b6321-8f56-400d-8f34-d6b3a11189c1
# ╟─87cf64f5-1707-4ba3-ac54-ae5b7c705461
# ╟─82372462-2ab2-4ce3-b3c4-36548be2c276
# ╟─371e7bc6-e229-4dfa-b998-e5caabe53f44
# ╟─1a3d8c0c-aa64-4213-b978-e2375feb26a4
# ╟─3e81e845-0b71-4314-9d63-4419e022d475
# ╟─49f3077b-e981-42d8-b3d2-beb7bec9677c
# ╟─d7723067-27dc-4b28-84f7-f06ef805ad6a
# ╠═899a3ee1-7baf-4332-a35b-a224cfce179a
# ╠═eebd1b27-73e4-4683-831f-6bc366e815f2
# ╟─2e9f4f30-4a1f-4f92-836e-4417c4154d6f
# ╠═679f9223-f68e-4739-8259-17dee1fde9f6
# ╟─50ecd36c-183e-4681-977e-8c7a03bc0f02
# ╠═27a5536b-7ef6-47bd-92f7-c6ba17e1f3e5
# ╟─ab2ec723-7c95-4e65-bbee-fa2fd35e9b93
# ╠═b7dd910b-c88b-4125-9648-b27557bc820e
# ╟─1cacb6ea-29e6-4b25-be7a-1f2dd0c921b7
# ╟─5206a8ee-67d9-4296-ae00-176a6cc94b98
# ╠═90a11d6b-84f0-4d2e-804d-1051c9ec68f5
# ╟─0258de9d-8a17-40a3-9e23-5aef81265fc0
# ╠═61e4c79c-0104-4ebe-b9a6-212ad7951237
# ╟─adb2ede5-f22d-4ca3-9f0a-2662499eebbf
# ╠═57c70319-5105-4ec3-b422-7915355358b5
# ╟─b2580544-a8d8-434f-98d7-2db5bca01807
# ╠═f34bf2cc-0ff3-40bf-92a0-39c5bad4c119
# ╟─d602f7cb-8cc6-4ff3-b3e9-e5a21b3e2d7d
# ╠═8e583ba2-59f1-4b6b-801f-6c658a60db74
# ╟─f0bb41d5-43e2-4531-ac33-3c3ea7d70ef7
# ╟─12805d96-9dcc-4fb2-b882-7b0cbd16fbe6
# ╟─9e7daf27-1985-45c1-9cde-c808b076f383
# ╟─e617500c-9c64-4303-a663-1986c32ee66f
# ╟─47276d09-9cb2-46f8-b4cd-9dd8a0323161
# ╟─5b02cb14-01ce-4207-92d5-13e59a9561d6
# ╟─b770914b-c416-4309-9f50-d9e439bff1d1
# ╟─96a30247-e66b-4324-80cd-ac1e9fe726d9
# ╠═c7a1dfe9-742e-4ab1-b14e-d2e80685ba87
# ╠═b2cbffc5-887b-4731-8235-92cf5e84044d
# ╠═a5229c70-87d3-4761-8e52-7cce04d1ada5
# ╠═114b986e-0b7e-4547-8c93-7b49ceb2000c
# ╟─21c7c5e3-a3cd-46e0-a59e-b515d25851be
# ╟─8ebb0cf9-9a99-4e21-8473-99fe0fc3d50c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
