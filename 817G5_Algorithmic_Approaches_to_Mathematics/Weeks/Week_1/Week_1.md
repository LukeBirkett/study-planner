**| [Canvas Page](https://canvas.sussex.ac.uk/courses/38867/pages/week-1-summary?module_item_id=1669820) |** 
### Weekly Goals:
- Introduction to mathematical syntax and its' manipulation
- Understanding sets and set operations
- Understanding the notion of variable assignment, and being able to assign variables
- Understanding the notion of functions, and nested functions.
- Understanding the notion of an axiom, and the axioms for number systems (no need to memorise the latter)
---
### Files:
1. [Introductory Cheatsheet](./Files/Introductory_cheatsheet.md)
2. [A Guide to Writting Mathematics](./Files/Guide_to_writting_mathematics.md)
3. [Week 1 Lecture Slides](./Files/week_1_slides.md)
---
### Links: 
1. [Canvas Page](https://canvas.sussex.ac.uk/courses/38867/pages/week-1-summary?module_item_id=1669820)
2. [Video Lecture](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=232af66a-46a7-4f96-84a0-b4d500c65487&start=0.42496)
3. [Julia Setup Guide](https://algorithmic-approaches-to-mathematics.github.io/prerequisites/installation/)
4. [Study Helpers](https://canvas.sussex.ac.uk/courses/38867/pages/study-helpers?module_item_id=1669822)
---
### Lecture
This lecture started as a general introduction to the course. The latter part of the lecture started on the basics of Linear Algebra. This is a topic which spans 2/3 weeks the notes for it are contained in the [Linear Algebra page](../../Linear_Algebra.md).

---
### Lab
#### 1. Maths
1. General introduction to doing maths in Julia. Notes compiled in the Julia Notes.
#### 2. Functions
There are two approaches to creating functions: multiple line and single-line

Multiple line opens with `function` and finished with `end`. It doesn't need an explicitly `return` as the final evaluated expression is returned but it can if desired

   ```
   function name(input_a, input_b)
	   # stuff
	   return input_a ^ input_b
	end
   ```

The single line approach assigns something, usually an expression, to a variable. Also, functions don't need to take arguments which is a property important for functional programming. 

```
square2(x) = x^2
square3 = 🐂 -> 🐂^2
```

Another important utility for functional programming is the ability to return another function. This allows the stacking of a computational workflow. 

   ```
   function pow(n) 
	   inner_pow(x) = x^n 
	end
   ```

Calling a structure like this is a two-step process. First you "call" the `pow` function  assigning the returned inner function to another variable `cube = pow(3)`. The new variable is just the inner function so it is to be called again `result = cube(4)
#### 3. Sets

A set is a collection of anything which by default is unordered. Here are some common mathematical sets:
- $\mathbb{N}$: the natural numbers.
- $\mathbb{Z}$: the integers. 
- $\mathbb{Q}$: the rational numbers 
- $\mathbb{R}$: the real numbers 
- $\mathbb{C}$: the complex numbers 

A set can be anything and therefore we can make our own customer set of number (or anything). A set is denoted with curly brackets: $S = \{1, 2\}$ though the values of the set do not have to be specific directly, instead they can be derived or constrained: $S_2 = \{x : x^2 > 10 \}.$ Recalling that $:$ means "such that" so the entries of the set are those that satisfy the logic beyond the colon. 

Recall that all of the operators in Julia are functions. We are using the shorthand notation, e.g. `S ∪ T`. We could instead use the full notation `∪(S,T)`

Julia uses `Set()` to create sets: `S = Set((1,2))`. Union `S ∪ T` and Intersection S ∪ T are utilised to create new sets, though `S ⊆ T` works slightly different as it is a logical operator that produces true or false, i.e. it is not a function as it doesn't return something else.
#### 4. Types
There is an explicit classification scheme for different Julia objects. This is known as the **type system**. 

Analogous example in Bio:  `> Homo sapiens <- Homo <- Hominidae <- Primates <- Mammalia <- Chordata <- Animalia`.

In Julia this looks like:  `> Int64 <: Signed <: Integer <: Real <: Number <: Any`

The notation `<:` to denote: **is a subtype of**. Logically, **every** Julia object belongs in a typetree and every object type is a subtype of `Any (Function <: Any). 

Types are important in Julia for speed and memory optimisation, however, that is not the full story.  In Julia, methods belong to generic functions, and Julia decides _which_ version of a function to run based on the types of **all** arguments. This is called "abstraction through types". If you input a type for which a method hasn't been defined, a MethodError will be thrown.
```
# Dispatch chooses behavior purely based on type combinations: collide(a::Circle, b::Circle) = "Circle-Circle intersection algorithm" collide(a::Circle, b::Rectangle) = "Circle-Box projection algorithm" collide(a::Rectangle, b::Rectangle) = "AABB Box overlap algorithm"
```

All Julia objects belong to a **concrete** type (also called a struct). You can build explicit instantiations of concrete types. They are like species. Other Julia objects are called **abstract types**. You can't init an abstract type, it would be like initing a "mammal" that is nothing else.  A concrete type, such as a a "Homo-sapien" would be a subtype of an abstract type e.g. mammal.

Here are some functions for determining type:
	1. `typeof(1)`
	2. `isconcretetype(Int32)`
	3. `supertype(typeof(1))` or stack to search higher `supertype(supertype(typeof(1)))`

Alternative to "stacking" there is the piping operator: `|>` : `typeof(1) |> supertype |> supertype |> supertype`

We can assert or change the type of something using `::` (`1::Number`), this is important for "abstraction through types". 


We can construct our own types but they must follow the abstract/concrete rules. To assign hierarchy and create own over typetrees we  use: `abstract type Animal <: Organism end `. But it must end with a struct: 
```
struct Elephant <: Animal # Elephants are concrete types. We can make explicit elephants
	name::String
	weight::Number 
end
```

Julia has a built in hierarchy for specialisation. For example if there is a function which takes abstracted types as arguments. if there is a clash, Julia will select the ones furthest down the type tree. 

---
#### 5. Mathematical Functions
Mathematical functions map elements of one set to elements of another set.

The input set is known as the **domain** and the output set the **range** or **codomain**. The outputs that are actually hit form a subset of the range, called the **image**. The image exists because not all elements of the output need to be mapped to. 

A function **can never map one input into many outputs**. IE it can never be a 'one-to-many' mapping. A function is designed to be a **deterministic evaluation rule**, given an input there must be a single, unambiguous result.

$$f: \mathbb{R}^+ \to \mathbb{R}^+; \quad f(x) = \sqrt{x}$$

**Convention** says to keep functions single-valued and unambiguous, values $x$ are defined to mean the non-negative branch $\mathbb{R}$. The square root of 9 can be $3$ or $-3$ ($\sqrt{9} = 3$) which would be one-to-many, not a function. 

Note, we don't have to define the range as only positive real numbers for it to be considered a function. The **convention** is what restricts the functions output to positive numbers. However, the defining the range different does change the properties of the function (tbc; **surjectivity**)

One way to side step this issue is to return the function as a pair $(a, b)$ or a set ${a, b}$. This way the returned is just a **single item**, i.e. one-to-one.

---

#### 6. Injectivity

**Injectivity** is the property of a function where no two elements in the domain map to the same element of the range. Mathematically, given a function $f:X \to Y$ , f is injective if: $\forall x_1, x_2 \in X \text{  s.t. } x_1 \neq x_2 : f(x_1) \neq f(x_2)$

Note, that in this equation, $\text{  s.t. }$ provides the "such that" functionality, where as, `:` is used to entail the conclusion in a "it holds that" or "then" capacity.  This is because With a universal quantifier ($\forall$), the standard mathematical convention is:

$$\forall (\text{variables}) \; [\text{conditions}] : (\text{conclusion})$$
Therefore the equation translates into *"For all $x_1, x_2 \in X$ **such that** $x_1 \neq x_2$, **it holds that** $f(x_1) \neq f(x_2)$."*
$$\underbrace{\forall x_1, x_2 \in X \text{ s.t. } x_1 \neq x_2}_{\text{The Setup / Condition}} \quad \mathbf{:} \quad \underbrace{f(x_1) \neq f(x_2)}_{\text{The Claim}}$$
Alternatively formulation pertains to using implication arrows ($\implies$): 
$$\forall x_1, x_2 \in X, \quad (x_1 \neq x_2 \implies f(x_1) \neq f(x_2))$$

---

#### 7. Surjectivity

**Surjectivity** is a function that maps something in the domain onto **every** element of the range. This why it is important to specific the correct domain as it potentially changes to the property of the equation particularly due to the positive convention. Given a function $f:X \to Y$, f is surjective if $$\forall y \in Y, \exists x \in X : f(x) = y.$$
Note that Surjectivity does not care if an output gets hit more than once. It only cares that an output gets hit **at least once**. Therefore, in this equation, it could be a one-to-one or one-to-many, it just states that every $y$ value is mapped from a function.


---

- Surjective is the complete range (output) mapping. If output values are left unmapped, i.e. negative real numbers, it is not surjective. 
- Injective is the one-to-one property. Note, the onus here is on the domain, every input must map to a range output. However, not all of the range needs to be filled so the input set can be smaller. A function can be many-to-one, i.e. not injective. And one-to-many violates the defintion of a "function". 
- A function is bijective if it is both injective and surjective.
- A function with an inverse guarantees bijectivity
- A function will not have an inverse if:
	- It has a complex many-to-one mapping. There is no reverse as this would be one-to-many and therefore not a function (even powers, wave functions [sin, cos], constant functions $f(x) = 5$, anything with rounding or steps as info is lost)
	- It has holes in the range (not surjective). Exponential functions as the outputs are positive, liner shifts over sets ($+1$)
	- A bunch of stuff about linear algebra. 

---

#### 8. Inverse
A function $f: X \to Y$ has a **left** inverse $f^{-1}:Y \to X$ if for every $x \in X$, the following holds:
$$f^{-1}\big( f(x)  \big) = x$$
A function $f: X \to Y$ has a **right** inverse $f^{-1}:Y \to X$ if for every $y \in Y$, the following holds:
$$f\big( f^{-1}(y)  \big) = y$$
A function $f^{-1}$ is an inverse of $f$ if it is both a left inverse and a right inverse. 


- Left inverse requires $f$ to be injective
- Right inverse requires $f$ to be surjective


**CLARIFICATION:** 
- The "inverse" is the mapping itself between $x$ and $y$ ($g: Y \to X$ (or $f^{-1}: Y \to X$))
- **The Full Loop ($f^{-1} \circ f$):** is The **composite function**. The input goes through $f$ and back through $f^{-1}$ resulting in a mapping from $X \to X$
- **The Equation $f^{-1}(f(x)) = x$:* is the **identity condition**. It checks whether the round-trip leaves every original input completely unchanged. $f^{-1} \circ f = \text{id}_X$


---

#### 9. Non-Injective Function Cannot Have an Inverse
If $f$ is injective then
$$\forall x_1, x_2 \in X: \quad x_1 \neq x_2 \Rightarrow f(x_1) \neq f(x_2)$$
To represent the converse, we need to use $\exists$ instead of $\forall$ to highlight a violation. As well as, $\land$ (and) instead of $\Rightarrow$ to point out where the violation occurs. This becomes:
$$\exists x_1, x_2 \in X: \quad (x_1 \neq x_2) \ \land \ (f(x_1) = f(x_2))$$
This tells us there is two unique values of $x$ which are equal when applied to the function, i.e. they have mapped one-to-many which is not injective. 

A function that is not injective demonstrates one-to-many. To prove this cannot have a left inverse $f: Y \to X$ we need to highlight a contradiction. We do this by picking a witness $x_1, x_2 \in X$ with $x_1 \neq x_2$ and $f(x_1) = f(x_2)$. 

If a contradiction were to exist then $\forall x \in X: \ g(f(x)) = x$ meaning $x_1 = g(f(x_1)) = g(f(x_2)) = x_2$ 

This is because we stablished $f(x_1) = f(x_2)$ but $g()$ is returning both which would be a left-inverse property. This therefore contradicts $x_1 \neq x_2$. Otherwise, we are suggesting that $f(x_1) = f(x_2)$ is mapped to "many" x values using  $g$ , which would violate its condition as a function. 

---

#### 10. Non-Surjective Cannot Have a Right Inverse
To not be surjective, there needs to be a value y in the set of $Y$ such that for all values of $x$ in the set $X$ there does not exist a $f(x)$ that equal a given value of $y$. i.e $y$ in the target range has not been hit.
$$\exists y^\star \in Y: \ \forall x \in X, \ f(x) \neq y^\star$$
Suppose for contradiction that a right inverse $g: Y \to X$ exists, i.e. $\forall y \in Y: \ f(g(y)) = y$$

Note that $g(y) = x$ is not enough, this is just a function. An inverse exists where we can take $y$ full circle back to itself. $g$ is a just a new function that takes $y$ to $x$. However, $f$ already exists, therefore, for there to be a right inverse, $f$ needs to take $g(y) = x$ back to $y$. If $f$ isn't surjective, this can't happen.

Apply it to $y^\star$ and set $x^\star := g(y^\star) \in X$. Then $f(x^\star) = y^\star$. But $x^\star \in X$, and *every* $x \in X$ has $f(x) \neq y^\star$.

Proving the contradiction for non-surjectivity is more subtle than injective. This is because $g(y)$ simply exists as a function. The issue is that no assignment works as a right inverse. Whatever function is applied to $y$ there exists no value $x$ that $f$ can return to obtain $y$ . Otherwise the original formula would entrain surjectivity, not $\ f(x) \neq y^\star$
$$\forall y \in Y, \exists x \in X : f(x) = y.$$

---

#### 11. Bijectivity as Full Inverse
Bijectivity says for every $y$ in $Y$, there exists a unique $x$ in $X$ such that $f(x)$ equals $y$.

$$\forall y \in Y, \ \exists! x \in X: \quad f(x) = y$$
- Surjectivity is covered by $\forall y$, every output defined
- Bijectivity the unique $x$ in $\exists! x$, the $y$ output is defined by a unique $x$

Therefore we can define the right inverse $f^{-1}: Y \to X$ by: $f^{-1}(y) :=$ the unique $x \in X$ with $f(x) = y$. 

To clarify, $f^{-1}(y)$ is a convention that clarifies we are seeking the reversal of the bijective mapping. Additionally, as we have already clarified it is Bijective, there is only 1 function that could achieve this mapping $g: Y \to X$.

To check the right inverse, we take any $y \in Y$. By construction (convention), $f^{-1}(y)$ obtains an $x$ which we known has a $f(x) = y$, so $f(f^{-1}(y)) = y$

To check the left inverse, we take any $x \in X$ and let $y := f(x)$. Both $x$ and $f^{-1}(y)$ are mapped to $y$ by $f$, by uniqueness they are the same element, so $f^{-1}(f(x)) = x$.

Surjectivity is exactly what makes $f \circ f^{-1} = \mathrm{id}_Y$ work, and injectivity is exactly what makes $f^{-1} \circ f = \mathrm{id}_X$ work

---

#### 12. Number Systems, definitions, and axioms
When we prove a statement in mathematics, we have to start from some **axioms**: statements which we take to be self-evident, and require no evidence or proof.

If we decided that $x \div 0 = x$, instead of being undefined, then lots of mathematical proofs would break! They **require** this axiom.

For the purposes of this module, whenever we refer to a 'number system' (like $\mathbb{Q}$, $\mathbb{R}$, or $\mathbb{C}$), we assume it comes equipped with these exact operations and rules.

| Label  | Operation      | Axiom Name      | Formal Statement                                                              |
| :----- | :------------- | :-------------- | :---------------------------------------------------------------------------- |
| **A1** | Addition       | Commutativity   | $(a + b = b + a \quad \forall a, b \in S)$                                    |
| **A2** | Addition       | Associativity   | $(a + (b + c) = (a + b) + c \quad \forall a, b, c \in S)$                     |
| **A3** | Addition       | Identity (Zero) | $(\exists 0 \in S : a + 0 = a \quad \forall a \in S)$                         |
| **A4** | Addition       | Inverse         | $(\forall a \in S, \; \exists -a \in S : a + (-a) = (-a) + a = 0)$            |
| **M1** | Multiplication | Commutativity   | $(a \times b = b \times a \quad \forall a, b \in S)$                          |
| **M2** | Multiplication | Associativity   | $((a \times b) \times c = a \times (b \times c) \quad \forall a, b, c \in S)$ |
| **M3** | Multiplication | Identity (One)  | $(\exists 1 \in S : a \times 1 = 1 \times a = a \quad \forall a \in S)$       |
| **M4** | Multiplication | Inverse         | $(\forall a \neq 0 \in S, \exists a^{-1} \in S : a \times a^{-1} = 1)$        |
| **D1** | Both           | Distributivity  | $((a + b) \times c = a \times c + b \times c \quad \forall a, b, c \in S)$    |

---


---
### Cheatsheet
| [Cheatsheet](./Files/Introductory_cheatsheet.pdf) |

---







