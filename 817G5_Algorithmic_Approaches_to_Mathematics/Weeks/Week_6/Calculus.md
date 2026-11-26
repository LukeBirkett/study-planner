**| [Canvas](https://canvas.sussex.ac.uk/courses/38867/pages/week-6-summary?module_item_id=1669830) | [Recording](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=14c31243-b3ac-47d5-8cbc-b4f800d6d1e5&start=1.60349) |**
In the second half of this course, we will investigate systems that **change over time and space.**  Calculus is a mathematical framework for predicting how things change, based on their instantaneous (i.e. current) properties. Time and space (usually time for us) are **independent variables:** quantities whose measurement is independent of the system we are dealing with.
# Goals
- This week, we are going to do _calculus of a single variable_. That is: calculus on functions with one input and one output. (SISO = single input single output).
- Understand the notion of a differential quantity, and the derivative of a function with respect to an independent variable.
- Understand when and why function derivatives don't exist / aren't well defined.
- Understand the concept of the differential as a linear operator between functions.
- Understand the product and chain rules.
---
# Files
- [[calculus_slides.pdf | Calculus Slides]]
- [[Calculus_cheatsheet.pdf | Calculus Cheatsheet]]
---
# Links
[3B1B Calculus Series](https://www.3blue1brown.com/?topic=calculus)
- [x] [The Essence of Calculus](https://www.3blue1brown.com/?topic=calculus&lesson=essence-of-calculus)
- [x] [The Paradox of the Derivative](https://www.3blue1brown.com/?topic=calculus&lesson=derivatives)
- [x] [Power Rule Through Geometry](https://www.3blue1brown.com/?topic=calculus&lesson=derivatives-power-rule)
- [x] [Trig Derivative Through Geometry](https://www.3blue1brown.com/lessons/derivatives-trig-functions/)
- [x] [Visualising the Chain Rule and Produce Rule](https://www.3blue1brown.com/?topic=calculus&lesson=chain-rule-and-product-rule)
---
Automatic Differentiation:
- [A Quick Introduction to AD for Scientists](https://mitmath.github.io/18S096SciML/lecture7/ad)
- [What is Automatic Differentiation](https://www.youtube.com/watch?v=wG_nF1awSSY)
- [Intro to Computational Thinking; Section 1.3 Automatic Differentiation](https://computationalthinking.mit.edu/Fall22/images_abstractions/transformations_and_autodiff/)
---
# Lecture
**Differential quantities;**
- What are they
- What are their operations and algebra?
- How do we compute them?

Things that calculus leads to is understanding differential equations, which are equations about dynamics, things that change in time.

**Position of car as a function of time;**
- Draw the position of a car on a journey as a function of time
- X-axis is just time ($t$)
- Y-axis is position (distance) at time $t$ given as $x(t)$

![[calc_car_position_time.png]]

**Velocity of car at a point in time;**
- It is easy to read position from the graph. Just take a point $t$, read up to the curve, and follow the point across to $x(t)$
- But what does it mean to take velocity at a point in time? At a point in time there is no movement. 
- Velocity is a differential quantity, it requires the comparison of two points in time. 
---
**Velocity & Time Interval:**
- If the goal is to measure velocity at a point in time, how can we proxy this, or get a notion of it,  given its precise interpretation is impossible?
- We could measure two points in time and compare the positional difference.
- Here the change in position would be divided by the change in time. 
- However, the issue with this is that velocity might be changing over time. 
- Average velocity between times $t$ and $t + \Delta t$. We use this notion instead of specifying exact units and numbers.  
- Similarly, we can denote the change in distance: $\Delta x = x(t + \Delta t) - x(t)$
- Therefore, this computation is just giving us average velocity between two points in time. It's not a velocity and any one points in[[]] time. 
- For calculus, consider the divide sign as "per", e.g. km/ph is kilometers per hour. 
- Average velocity between times $t$ and $t + \Delta t$: 
$$\frac{x(t + \Delta t) - x(t)}{\Delta t} = \frac{x(20) - x(10)}{20 - 10}$$
![[Screenshot 2026-11-13 at 19.28.53.png]]

---
**Geometrically and Velocity as Slope:**
- Geometrically, what we are calculating is the average slope over the interval. 
- A steep slope shows that we are going fast. 
- The position $x(t)$ is changing a lot which each addition unit of time $t$.
- What we really wise to measure is the slope of a curve at a single time instances. 
---
**Infinitesimally Small Interval:**
- The way to do this is to take the $\Delta t$, shrink it and make it tiny until it is a infinitesimally small number.
- This proxies the velocity at that freeze frame in time.
$$\lim_{\Delta t \to 0} \frac{\Delta x}{\Delta t}$$
- We acknowledge that a true freeze frame has no velocity. 
- In maths, we say our velocity at time $t$ is the limit as the change in time goes to zero of the change in position divided by the change in time.
- Each time, we are taking a smaller and smaller $\Delta t$, calculating our average slope each instance and seeing what the average slope get towards as we get really small.
- As we get smaller, the changes between the instances should become smaller also. We are veering into "something". 
---
**Velocity is a differential quantity:**
- **Main Concept:** Velocity is a differential quantity.
- **Definition:** Velocity is $\frac{\Delta x}{\Delta t}$ for an infinitesimally small change in time.
- **Key Notation:**
    - **Time:** $t$
    - **Change in time:** $\Delta t$
    - **Infinitesimally small change in time:** $\mathrm{d}t$
$$velocity = \frac{\mathrm{d}x(t)}{\mathrm{d}t}$$
We are computing an infinitesimal change in position **per** an infinitesimal change in time. In english, we would say the velocity is the rate of change of position with respect to time.

We can flip this algebra, we can view it as if we moved an infinitesimal amount in time $\mathrm{d}x$, our change in $x$ would be velocity at time $t$ multiplied by the change in time $\mathrm{d}t$. 
$$\mathrm{d}x(t) = \text{velocity(t)} \times \mathrm{d}t$$
This highlights that we are working with approximations as $\mathrm{d}x$ represents a change in position we are working with $\text{velocity(t)}$ which represents at point in time. Recalling earlier that we highlight changes are variable overtime, which is why we started with looking at average velocity. 

---
**Derivative Notion:**
At each value $x$:
$$f'(x) = \lim_{\Delta x \to 0} \frac{f(x + \Delta x) - f(x)}{\Delta x}$$
Less property notion: 
$$f'(x) = \lim_{\Delta x \to 0} \frac{\Delta f(x)}{\Delta x}$$
---
**Derivatives are undefined at corners and jumps:**
We can consider forward of backward jumps. This is how we realised we cannot work with corners and jumpers. If consider $x^*$ to be the point precisely at the jump, we will get a different result wether we step forward or back. When we work with limited computations, the infinitesimally small change should proxy the notion of movement at a singular point. Therefore, whether the computation steps back or forward shouldn't change the result. 

We say it is not differentiable. 

---
**First vs Second Derivative:**
Geometrically, the first derivative $x'(t)$ is steepness of a graph at $t$. The second derivative $x''(t)$ is the curviness oof the graph at $t$, i.e. the steepness of steepness. 

---
**Independent vs Dependent Variables:**
When we're thinking about the position as a function of time, time is the input to the function and is therefore an independent variable. Position is the output of the function making it a dependent variable on time. 

We say that the dependent variable has been differentiated with respect to the independent variable. 

The dependent variable is obtained using a function and therefore may be represented as $f(x)$,$x(t)$ and occupied the vertical y-axis. 

The independent variable is what we measure something again, e.g. space or time, and therefore occupies the horizontal x-axis to demonstrate change. 

---
**Differentiation is an Operator:**
- We had a function position as a function of time.
- We differentiated it and we got a new function
- The process of differentiation it took in one function and it gave a new function.
- It is a function whose inputs are functions and whose outputs are functions.

Remember, start with a function that takes an input such as time and output position. This just a normal function. 

Differentiation is also function that makes a input and produces a function. However, $Dx$ is mapping between the two functions
- $Dx$ is the differential operator with respect to $x$
- $\frac{\mathrm{d}f}{\mathrm{d}x}$ is the output of $D_x(f)$ 

The inputs to both functions (the original function and the new derivative function) are the exact same type of thing—for example, both take time ($t$) or both take **$x$**.
- The left function gives us position. It is fed ($t = 3\text{ seconds}$), and it gives a position ($15\text{ meters}$).
- The right function gives us velocity, it also takes the input ($t = 3\text{ seconds}$) but it gives a velocity ($10\text{ m/s}$).

$D_x(f)$ takes the **entire Left Function machine** ($f$) and outputs the **entire Right Function machine** ($\frac{\mathrm{d}f}{\mathrm{d}x}$). It transforms the function. 

![[diff_mapping.png]]

The differential operator is itself just a function. Therefore, it can be composed to get the second order derivative function.  
$$f \xrightarrow{D_x(f)} \frac{\mathrm{d}f}{\mathrm{d}x} \xrightarrow{D_x \circ D_x(f)} \frac{\mathrm{d}^2 f}{\mathrm{d}x^2}
$$
---
**Differentiation is a linear operator:**
Differentiation ($D_x$, or $\frac{d}{dx}$) is an operator. Instead of process an number, it works with functions outputting new functions. Because this machine obeys the two fundamental rules of **linearity**, it behaves just like matrix multiplication in linear algebra.
###### 1. Scalar Multiplication (Scaling)
If you stretch a function vertically by multiplying it by a constant ($k$), its steepness (slope) scales by that exact same factor.
$$D_x(k \cdot f) = k \cdot D_x(f)$$
If multiplying the blue curve $f_1$ by $k = 3$ creates the steeper orange curve $3f_1$. At any given $x$-value, the orange curve is three times steeper than the blue curve.

![[function_scaling.png|333]]
###### 2. Additivity (Superposition)
If you add two functions together, the slope of the combined function at any point is simply the sum of their individual slopes.
$$D_x(f_1 + f_2) = D_x(f_1) + D_x(f_2)$$
The green dashed curve is the sum $f_1 + f_2$. On the left side, $f_1$ has a negative slope (going down) while $f_2$ has a positive slope (going up). Their slopes roughly cancel each other out, leaving the green curve nearly flat (slope $\approx 0$).
![[function_additive.png|454]]

###### 3. The General Linearity Rule
Both can be combined (scaling and addition) for any number of functions. Taking the derivative of a **weighted sum** of functions is the exact same as taking the **weighted sum of their derivatives**:
$$D_x\left(\sum_{i=1}^{n} a_i f_i\right) = \sum_{i=1}^{n} a_i D_x(f_i)$$
(Note: In linear algebra, functions live in "vector spaces." Because $D_x$ is a linear operator, if you restrict yourself to a finite set of functions, you can literally write differentiation as a matrix!)

---
**Why this matters? Modularity.**
Instead of using messy limit definitions to differentiate complex expressions from scratch, linearity lets you **break a big function into basic building blocks**, differentiate each simple piece using a lookup table, and reassemble them.

For example: $f(x) = x^2 + 3x - 4$.
1. **Decompose into building blocks:** Recognize $f(x)$ as a linear combination of three simple functions:
	- $f_1(x) = x^2$ (with weight $1$)
	- $f_2(x) = x$ (with weight $3$)
	- $f_3(x) = 1$ (with weight $-4$)
2. **Find the derivative of each block:**
	- $D_x(f_1) = 2x$
	- $D_x(f_2) = 1$ _(rate of change of $x$ with respect to $x$ is $1$)_
	- $D_x(f_3) = 0$ _(a constant never changes, so its slope is $0$)_
3. **Apply linearity to recombine:**
$$D_x(f) = 1 \cdot D_x(f_1) + 3 \cdot D_x(f_2) - 4 \cdot D_x(f_3)$$
$$D_x(f) = 1(2x) + 3(1) - 4(0) = 2x + 3$$
---
**Derivative Reference Table:**

|**Function (yyy)**|**Derivative (y′y'y′)**|**Key Intuition / Rule**|
|---|---|---|
|$x^n$|$nx^{n-1}$|**Power Rule:** Bring the exponent down front, subtract $1$ from the power.|
|$\sin(x)$|$\cos(x)$|Rate of change of a sine wave is a cosine wave.|
|$\cos(x)$|$-\sin(x)$|Rate of change of a cosine wave is a negative sine wave.|
|$\ln(x)$|$\frac{1}{x}$|Standard natural logarithm derivative.|
|$e^x$|$e^x$|**Unique property:** Its slope at every point equals its own value.|

---
**Automatic Differentiation:**
This is the way machine learning algorithms compute derivatives. They do not use the formulas which are slow. 

(Covering next week)

---
**More Differential Operator:**
Linearity guarantees that differentiation plays nicely with **addition** ($D_x(f + g) = D_x(f) + D_x(g)$) and **constant scaling** ($D_x(kf) = kD_x(f)$), but what about multiplying and composing functions? 

---
**Product Rule:**
However, **differentiation does not distribute over the multiplication of two functions**:
$$D_x(fg) \neq D_x(f) \times D_x(g)$$
- Let $f(x) = x$ and $g(x) = x$.
- Their product is $fg(x) = x \times x = x^2$. From your table, the true derivative of $x^2$ is **$2x$**.
- If you wrongly multiplied their individual derivatives ($1 \times 1$), you would get **$1$**, which is incorrect.

To do this we require something called the product rule: 
$$D_x(fg) = D_x(f) \cdot g + f \cdot D_x(g)$$
Picture the product $f(x) \times g(x)$ as the area of a rectangle with width $f(x)$ and height $g(x)$. When $x$ increases slightly, both dimensions stretch at once, adding a vertical strip of new area ($f'g$) and a horizontal strip ($fg'$). The tiny corner where both stretches overlap is infinitely small and disappears, leaving only the two main strips. In short, the Product Rule works by "taking turns"—freezing one function to measure the other's growth, then adding the two effects together: $(fg)' = f'g + fg'$.

![[rectangle_multiplication.png|393]]

**Goal:** Differentiate $h(x) = x^3 \cos(x)$.

1. **Split into two multiplied functions:** 
   Write $h(x)$ in the form $f(x)g(x)$:
	- $f(x) = x^3$
	- $g(x) = \cos(x)$
2. **Differentiate each piece individually** _(using the standard derivatives table)_:
	- $D_x(f) = 3x^2$ _(Power rule: $nx^{n-1}$)_
	- $D_x(g) = -\sin(x)$
3. **Substitute into the Product Rule formula:** 
   $D_x(h) = \cos(x)(3x^2) + x^3(-\sin(x))$
4. **Simplify:** 
   $D_x(h) = 3x^2\cos(x) - x^3\sin(x)$

---
**Chain Rule:**
Function composition—written as $f \circ g(x) = f(g(x))$—means **nesting** one function inside another. Instead of adding functions or multiplying their outputs, you feed $x$ into the inner function $g$, and then feed that result into the outer function $f$.

Because nesting functions is a non-linear operation, simple linearity rules do not apply here either—you must use the **Chain Rule**
$$D_x\big(f(g(x))\big) = f'\big(g(x)\big) \cdot g'(x)$$
If $g$ changes twice as fast as $x$, and $f$ changes three times as fast as $g$, then $f$ changes $3 \times 2 = 6$ times as fast as $x$. You **multiply** the rate of change of the outer function by the rate of change of the inner function.

Differentiate the **outside** function (leaving the inside untouched), then multiply by the derivative of the **inside** function.

| **Operation**          | **Notation**       | **How to Differentiate**                  |
| ---------------------- | ------------------ | ----------------------------------------- |
| **Linear Combination** | $a f(x) + b g(x)$  | **Linearity:** $a f'(x) + b g'(x)$        |
| **Multiplication**     | $f(x) \times g(x)$ | **Product Rule:** $f'(x)g(x) + f(x)g'(x)$ |
| **Composition**        | $f(g(x))$          | **Chain Rule:** $f'(g(x)) \cdot g'(x)$    |
|                        |                    |                                           |

---
# Lab
Differentiation maps a function $f$ to a new derivative function via the differential operator $D_x(f) = \frac{\mathrm{d}f}{\mathrm{d}x}$, which can then be evaluated at a specific point $x$ to return a scalar slope.

There are [3 main frameworks](https://juliadiff.org/) towards computing differentials:
- Symbolic differentiation, which uses [computer algebra](https://en.wikipedia.org/wiki/Computer_algebra) to work out explicit formulas. Generally fails with real world applications as there is no algebraic formula that defines that day.
- [Numerical differentiation](https://en.wikipedia.org/wiki/Numerical_differentiation), which relies on variants of the finite difference approximation $f′(x)≈f(x+ε)−f(x)εf′(x)≈εf(x+ε)−f(x)​$. With this you scope in a select a value of $x$ to explore, e.g. `velocity(t)` that looks up or interpolates the car's speed at time $t$. 
- [Automatic differentiation](https://en.wikipedia.org/wiki/Automatic_differentiation) (AD), which reinterprets the code of $f$ either in "forward" or "reverse" mode.
---
### **Symbolic Differentiation**
> Symbolics.jl (`@variables`, `Differential`, `expand_derivatives`)
- Applies exact pen-and-paper calculus rules (product, chain, quotient rules) to algebraic expression trees to output a closed-form formula.
- Exact mathematical truth** (zero step-size error).
- Only works on closed-form algebraic formulas; suffers from "expression swell" and slow simplification on large functions.
---
### **Automatic Differentiation (AD)**
> `ForwardDiff.jl` (`ForwardDiff.derivative`)
- Decomposes a program into elementary operations (`+`, `*`, `/`, `sin`) and applies exact calculus rules directly to numbers step-by-step using Dual numbers.
- Machine-precision exact**; fast on large programs and loops.
- Produces no human-readable symbolic equation.
---
### **Finite Differences**
> Custom `return_fd_operator(Δx)`
- Treats $f$ as a black box and approximates the tangent slope via a secant line: $\frac{f(x + \Delta x) - f(x)}{\Delta x}$.
- Always an approximation**
- Sensitive to step size $\Delta x$; fails when functions oscillate faster than $\Delta x$ or when $\Delta x$ hits floating-point rounding limits.
---

**Symbolic calculus** works _globally and abstractly_—it rearranges algebraic symbols before you ever pick a number, creating a formula that holds everywhere at once.
    
**The finite difference approach** works _locally and concretely_—it waits until you hand it a specific input $x$, looks right at that neighbourhood ($x$ and $x + \Delta x$), evaluates the function twice, and computes the slope right on the spot.

---
# Cheatsheet Questions
1. [[#First and Second Order Derivatives]]
	- [[#1. Modify the working in the previous section to find out that $ frac{d𝑥}{d𝑡} (𝑡)$]]
	- [[#2. Do your own working to show that the acceleration function is $ frac{d 2 𝑥}{d 𝑡2} (𝑡) = 2$]]
2. [[#Linearity and Derivatives]]
	- [[#1. Use linearity of the differential operator to calculate $D𝑥(ℎ)$ from the derivatives for $𝑓$ and $𝑔$]]
	- [[#2. Is it possible, or not, to calculate the derivative of $𝑗(𝑥) = cos(4𝑥) + sin(5𝑥)$ in the same way?]]
3. [[#Polynomials]]
	- [[#1. Why degree-3 polynomials form a vector space]]
	- [[#2. Finding the matrix for the differential operator $D$]]
		- [[#The differential operator $D$ is universal]]
	- [[#3. How would you use this matrix to differentiate a polynomial twice?]]
	4. [[]]
## First and Second Order Derivatives
Let position of an object at time $𝑡$ be described by the function $𝑥(𝑡) = 𝑡^2 + 4$: 
### 1. Modify the working in the previous section to find out that $\frac{d𝑥}{d𝑡} (𝑡)$ 
We need to first find the change in position: $x(t + \Delta t) - x(t)$

Plug $(t + \Delta t)$ into the new formula $x(t) = t^2 + 4$, and subtract the original $x(t)$: 
$$x(t + \Delta t) - x(t) = \left[(t + \Delta t)^2 + 4\right] - (t^2 + 4)$$
Note that, $x(t) = t^2 + 4$ means $x(\,\square\,) = (\,\square\,)^2 + 4$, we are plugging in $t + \Delta t$ which is why $+4+ remains outside the brackets. 

Next we expand $(t + \Delta t)^2$ and distribute the minus sign to the second group:
$$= t^2 + 2t\Delta t + (\Delta t)^2 + 4 - t^2 - 4$$
We grouping these terms, both ($t^2 - t^2 = 0$ and $4 - 4 = 0$) cancel out, resulting in 
$$= 2t\Delta t + (\Delta t)^2$$
Resultantly, this form is the same as if the input function was just $x(t) = t^2$, telling that the $+4$ does not impact the velocity calculation and instead just impact the starting point.

Then we divide by $\Delta t$. This isn't a lucky algebraic trick to just remove the terms, instead is converts the distance travelled equation ($x(t + \Delta t) - x(t)$) into **speed (velocity)** by dividing by the **time elapsed** ($\Delta t$):
$$\text{Average Velocity} = \frac{\text{Change in Position}}{\text{Change in Time}} = \frac{x(t + \Delta t) - x(t)}{\Delta t}$$
This gives us:
$$\frac{x(t + \Delta t) - x(t)}{\Delta t} = \frac{2t\Delta t + (\Delta t)^2}{\Delta t} = 2t + \Delta t$$
The question being asked is **"How many meters am I covering _per second_ right around this instant?"**. This shrinks both the distance and the time window shrink together proportionally revealing ($2t + \Delta t$)

The final step is to shrink the time window $\Delta t$ down to $0$ so the second term vanishes: 
$$\frac{\mathrm{d}x}{\mathrm{d}t}(t) = \lim_{\Delta t \to 0} (2t + \Delta t) = 2t$$
> **The intuition:** Adding $+ 4$ just shifts your starting position forward by 4 units—it doesn't change how fast you are moving at any moment, so the $+ 4$ vanishes during subtraction and gives the exact same velocity $2t$.
---
### 2. Do your own working to show that the acceleration function is $\frac{d^2 𝑥}{d^𝑡2} (𝑡) = 2$ 
To find the acceleration function $\frac{\mathrm{d}^2 x}{\mathrm{d}t^2}(t)$, we repeat the exact same four-step process, except this time our starting machine is the **velocity function**: 
$$v(t) = 2t$$
Find the change in velocity, $v(t + \Delta t) - v(t)$, by dropping $(t + \Delta t)$ into the velocity slot  $v(\,\square\,) = 2(\,\square\,)$ and subtract the original $v(t)$:
$$v(t + \Delta t) - v(t) = 2(t + \Delta t) - 2t$$
Expand and cancel the terms. The $2t$ and $-2t$ cancel each other out, leaving just the change in velocity:
$$= 2t + 2\Delta t - 2t$$
$$= 2\Delta t$$
Divide by $\Delta t$ to get the ratio representing the rate of change (average acceleration). Cancelling out the $\Delta t$ leaves us with:
$$\frac{v(t + \Delta t) - v(t)}{\Delta t} = \frac{2\Delta t}{\Delta t}$$
$$= 2$$
Take the limit as $\Delta t \to 0$. Note, the derivative is formally _defined_ as the limit of that ratio as $\Delta t \to 0$. Including the $\lim_{\Delta t \to 0}$ line simply finishes the formal mathematical sentence so that the average acceleration ($\frac{v(t + \Delta t) - v(t)}{\Delta t}$) officially becomes the instantaneous acceleration ($\frac{\mathrm{d}^2 x}{\mathrm{d}t^2}(t)$).
$$\frac{\mathrm{d}^2 x}{\mathrm{d}t^2}(t) = \lim_{\Delta t \to 0} 2 = 2$$
> **The intuition:** Because your velocity $2t$ increases by a steady $2$ units every single second, your acceleration is a constant **$2$**—independent of both $\Delta t$ and $t$.
> 
> Physically, this happens because $v(t) = 2t$ is a straight line—the rate of change is identical whether you measure it over $10$ seconds or $0.00001$ seconds, so zooming in with a limit leaves the number untouched.

---
## Linearity and Derivatives
Let $$f(x) = \sin(x) \qquad g(x) = \cos(x)$$ Note that $$\frac{\mathrm{d}f}{\mathrm{d}x}(x) = g(x) \qquad \frac{\mathrm{d}g}{\mathrm{d}x}(x) = -f(x)$$ Now let $h(x) = 2\cos(x) + 3\sin(x)$

### 1. Use linearity of the differential operator to calculate $D𝑥(ℎ)$ from the derivatives for $𝑓$ and $𝑔$
**Linearity** just means that the derivative operator plays nicely with addition and constant multipliers:
1. You can split a sum into separate derivatives: $\mathrm{D}_x(A + B) = \mathrm{D}_x(A) + \mathrm{D}_x(B)$
2. You can pull constant numbers out in front: $\mathrm{D}_x(c \cdot A) = c \cdot \mathrm{D}_x(A)$
#### Step-by-Step Solution
1. **Rewrite $h(x)$ using the names $f$ and $g$:** Since $f(x) = \sin(x)$ and $g(x) = \cos(x)$, we can rewrite $h(x) = 2\cos(x) + 3\sin(x)$ as:$$h(x) = 2g(x) + 3f(x)$$
2. **Apply the $\mathrm{D}_x$ operator to both sides:**$$\mathrm{D}_x(h) = \mathrm{D}_x\big(2g(x) + 3f(x)\big)$$
3. **Use linearity to split the sum and pull out the constants ($2$ and $3$):**
$$\mathrm{D}_x(h) = 2\,\mathrm{D}_x\big(g(x)\big) + 3\,\mathrm{D}_x\big(f(x)\big)$$
4. **Substitute the given derivatives:** The box tells us that $\mathrm{D}_x(g) = -f(x)$ and $\mathrm{D}_x(f) = g(x)$:
$$\mathrm{D}_x(h) = 2\big(-f(x)\big) + 3\big(g(x)\big)$$
$$= -2f(x) + 3g(x)$$
5. **Plug $\sin(x)$ and $\cos(x)$ back in:**
$$\mathrm{D}_x(h) = -2\sin(x) + 3\cos(x)$$
### 2. Is it possible, or not, to calculate the derivative of $𝑗(𝑥) = cos(4𝑥) + sin(5𝑥)$ in the same way?

**No**, it is not possible using linearity alone.

**What linearity allows:** Linearity allows us to split the sum into $\mathrm{D}_x\big(\cos(4x)\big) + \mathrm{D}_x\big(\sin(5x)\big)$ and pull out constant factors that multiply the _outside_ of a function, such as $\mathrm{D}_x\big(4\cos(x)\big) = 4\,\mathrm{D}_x\big(\cos(x)\big)$.

**Why it fails here:** In $j(x)$, the constants $4$ and $5$ multiply the input $x$ _inside_ the functions rather than multiplying the functions themselves. Because $\cos(4x)$ and $\sin(5x)$ are composite functions (functions nested inside other functions), you cannot pull $4$ or $5$ outside the differential operator—doing so requires the **chain rule** instead

---
## Polynomials
Let’s consider degree 3 polynomials (cubic equations). An example is $f(x) = -x^3 + 4x - 6$.

We can represent degree 3 polynomials as a 4 dimensional vector space, whose bases are
$\underline{e}_1 = 1 \qquad \underline{e}_2 = x$
$\underline{e}_3 = x^2 \qquad \underline{e}_4 = x^3$
For instance, in this basis, we have $f = \begin{bmatrix} -1 \\ 0 \\ 4 \\ -6 \end{bmatrix}$
Note, the vector represents the basis as **highest power to lowest power** ($x^3, x^2, x, 1$), not the same order as written out above it. 

### 1. Why degree-3 polynomials form a vector space
**Vector space axioms:** If you add two polynomials of degree $\le 3$ together, you still get a polynomial of degree $\le 3$ (closed under addition). If you multiply one by any constant scalar, its degree never exceeds $3$ (closed under scalar multiplication), and the zero polynomial $0$ acts as the zero vector.

**Spanning set:** Any degree-3 polynomial has the form $ax^3 + bx^2 + cx + d$, which is just a linear combination of the four basis pieces $\{x^3, x^2, x, 1\}$. Since no combination of lower powers can create a higher power, those four elements are linearly independent and span the entire 4D space.

> A **vector space** is simply any collection of objects ("vectors") equipped with **only two legal operations**:
> 1. **Vector addition:** Adding two objects in the set together ($\mathbf{u} + \mathbf{v}$).
> 2. **Scalar multiplication:** Stretching or shrinking an object by a plain number ($c \cdot \mathbf{u}$).
> To qualify as a vector space, the set must be **closed** under those two operations (meaning adding two objects or scaling one never kicks you out of the set), and those operations have to obey standard arithmetic rules (like $\mathbf{u} + \mathbf{v} = \mathbf{v} + \mathbf{u}$, having a zero object, etc.).

> Linearity is defined to respect the two operations of a vector space. 
> - **Vector Space (the objects):** A collection of things where the only two legal moves are **adding** ($\mathbf{u} + \mathbf{v}$) and **scaling** ($c \cdot \mathbf{u}$).
> - **Linearity (the transformation/operator):** A rule $T$ acting on those objects that **preserves** those exact two moves—meaning it doesn't matter whether you add/scale _before_ applying $T$ or _after_ applying $T$:
---
### 2. Finding the matrix for the differential operator $D$
Because a $4 \times 4$ matrix maps a 4-entry vector to a 4-entry vector, each **column** of the matrix simply shows what the derivative does to each basis element in order ($x^3$, then $x^2$, then $x$, then $1$)

$f(x) = -x^3 + 4x - 6$.
$\frac{\mathrm{d}f}{\mathrm{d}x}(x) = 0x^3 - 3x^2 + 0x + 4$

| Description                    | Input | Derivative                                                          | Vector                                           |
| :----------------------------- | :---- | :------------------------------------------------------------------ | :----------------------------------------------- |
| Column 1 (derivative of $x^3$) | $x^3$ | $\frac{\mathrm{d}}{\mathrm{d}x}(x^3) = 3x^2 = 0x^3 + 3x^2 + 0x + 0$ | $\begin{bmatrix} 0 \\ 3 \\ 0 \\ 0 \end{bmatrix}$ |
| Column 2 (derivative of $x^2$) | $x^2$ | $\frac{\mathrm{d}}{\mathrm{d}x}(x^2) = 2x = 0x^3 + 0x^2 + 2x + 0$   | $\begin{bmatrix} 0 \\ 0 \\ 2 \\ 0 \end{bmatrix}$ |
| Column 3 (derivative of $x$)   | $x$   | $\frac{\mathrm{d}}{\mathrm{d}x}(x) = 1 = 0x^3 + 0x^2 + 0x + 1$      | $\begin{bmatrix} 0 \\ 0 \\ 0 \\ 1 \end{bmatrix}$ |
| Column 4 (derivative of $1$)   | $1$   | $\frac{\mathrm{d}}{\mathrm{d}x}(1) = 0 = 0x^3 + 0x^2 + 0x + 0$      | $\begin{bmatrix} 0 \\ 0 \\ 0 \\ 0 \end{bmatrix}$ |
|                                |       |                                                                     |                                                  |

Putting those four columns side by side gives the differential operator matrix:
$$D = \begin{bmatrix} 0 & 0 & 0 & 0 \\ 3 & 0 & 0 & 0 \\ 0 & 2 & 0 & 0 \\ 0 & 0 & 1 & 0 \end{bmatrix}$$
**Quick check on $f$:**
$$D f = \begin{bmatrix} 0 & 0 & 0 & 0 \\ 3 & 0 & 0 & 0 \\ 0 & 2 & 0 & 0 \\ 0 & 0 & 1 & 0 \end{bmatrix} \begin{bmatrix} -1 \\ 0 \\ 4 \\ -6 \end{bmatrix} = \begin{bmatrix} 0 \\ -3 \\ 0 \\ 4 \end{bmatrix}$$
#### The differential operator $D$ is universal
> Its important to understand that computing the differential operator is a step that comes before working with a function and works for all functions. We are building a blank template for **all** degree-3 polynomials.
> 
> First we need to setup the coordinate slots. in the top-to-bottom order of our 4D vector space from highest power to lowest power:
> $$\text{Vector} = \begin{bmatrix} \text{coefficient of } x^3 \\ \text{coefficient of } x^2 \\ \text{coefficient of } x \\ \text{constant } (1) \end{bmatrix}$$
> Next we list the 4 pure basis polynomials: $b_1(x) = x^3$,  $b_2(x) = x^2$, $b_3(x) = x$, $b_4(x) = 1$
> 
> Now, apply the standard calculus derivative $\frac{\mathrm{d}}{\mathrm{d}x}$ to each of those four building blocks, and translate each result into our 4-slot vector format:
> 1. First basis element, $x^3$: 
> 	- Differentiate it: $\frac{\mathrm{d}}{\mathrm{d}x}(x^3) = 3x^2$
> 	- Fill in all four slots ($0x^3 + 3x^2 + 0x + 0$):
> 2. Second basis element, $x^2$:
> 	- Differentiate it: $\frac{\mathrm{d}}{\mathrm{d}x}(x^2) = 2x$
> 	- Fill in all four slots ($0x^3 + 0x^2 + 2x + 0$
> 3. Take the third basis element, $x$:
> 	- Differentiate it: $\frac{\mathrm{d}}{\mathrm{d}x}(x) = 1$
> 	- Fill in all four slots ($0x^3 + 0x^2 + 0x + 1$):
> 4. Take the fourth basis element, $1$:
> 	- Differentiate it: $\frac{\mathrm{d}}{\mathrm{d}x}(1) = 0$
> 	- Fill in all four slots ($0x^3 + 0x^2 + 0x + 0$)
>
> Each of those derivatives can be represented using the 4d basis vectors and put into a single matrix
> $$D = \begin{bmatrix} 0 & 0 & 0 & 0 \\ 3 & 0 & 0 & 0 \\ 0 & 2 & 0 & 0 \\ 0 & 0 & 1 & 0 \end{bmatrix}$$
> Because every degree-3 polynomial is just a combination of $x^3, x^2, x,$ and $1$, knowing what the derivative does to those four pure pieces automatically tells the matrix how to differentiate _any_ degree-3 polynomial you throw at it.
> 
> It is not unique to the function we are working with, it tells us how to work with all functions, say $g(x) = 5x^3 + 2x^2 - 7x + 9$:
> $$\begin{bmatrix} 0 & 0 & 0 & 0 \\ 3 & 0 & 0 & 0 \\ 0 & 2 & 0 & 0 \\ 0 & 0 & 1 & 0 \end{bmatrix} \begin{bmatrix} 5 \\ 2 \\ -7 \\ 9 \end{bmatrix} = \begin{bmatrix} 0 \\ 3(5) \\ 2(2) \\ 1(-7) \end{bmatrix} = \begin{bmatrix} 0 \\ 15 \\ 4 \\ -7 \end{bmatrix}$$
> Which is $15x^2 + 4x - 7$—the exact derivative of $g(x)$, using the **exact same matrix $D$**
> 
> **Why this works for any polynomial:** When you multiply $D$ by a vector $\begin{bmatrix} a \\ b \\ c \\ d \end{bmatrix}$, matrix
---
### 3. How would you use this matrix to differentiate a polynomial twice?
Since applying $D$ once differentiates the polynomial once, differentiating twice just means applying the matrix $D$ **twice**—which is matrix multiplication by **$D^2$** ($D \cdot D$):
$$\frac{\mathrm{d}^2 f}{\mathrm{d}x^2} = D(Df) = D^2 f$$
Explicitly, squaring the matrix shifts the numbers down one more diagonal:
$$D^2 = \begin{bmatrix} 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 6 & 0 & 0 & 0 \\ 0 & 2 & 0 & 0 \end{bmatrix}$$
_(Notice that if you apply $D$ four times, $D^4$ becomes the all-zero matrix—matching the fact that the 4th derivative of any cubic polynomial is $0$!)_

> This means that we don't need to play around with working out second-order and beyond differentials. We can just use the same one to cycle down. 

> Here is the neat surprise about polynomials: **you actually _can_ keep taking derivatives forever!** Unlike $f(x) = x\vert{}x\vert{}$, which broke at a sharp V-shaped corner on its second derivative, polynomials are completely smooth everywhere—they never develop corners, jumps, or breaks, no matter how many times you differentiate them. Instead of breaking, polynomials just **flatten out to zero**. This is unlike the $f(x\vert{}x\vert{})$ example from before which cannot enter this polynomial vector space.

---
### 4. What would the differential operator on degree 𝑛 polynomials look like? 
A degree-$n$ polynomial has $n + 1$ basis terms ($x^n, x^{n-1}, \dots, x, 1$), so it lives in an $(n + 1)$-dimensional vector space and uses an **$(n + 1) \times (n + 1)$ matrix**.

Following the exact same pattern (with $x^n$ at the top and $1$ at the bottom), the matrix has zeros everywhere except on the **subdiagonal** (the diagonal immediately below the main diagonal), which counts down from $n$ to $1$:
$$D = \begin{bmatrix} 0 & 0 & 0 & \cdots & 0 & 0 \\ n & 0 & 0 & \cdots & 0 & 0 \\ 0 & n-1 & 0 & \cdots & 0 & 0 \\ \vdots & \vdots & \ddots & \ddots & \vdots & \vdots \\ 0 & 0 & 0 & \ddots & 0 & 0 \\ 0 & 0 & 0 & \cdots & 1 & 0 \end{bmatrix}$$
---
## Derivative Proof
Here is the proof for $f(x) = x$

1. **Find the change in output, $f(x + \Delta x) - f(x)$:** Since the rule $f(\,\square\,) = \square$ just outputs whatever you feed into it, plugging in $(x + \Delta x)$ gives $x + \Delta x$, and plugging in $x$ gives $x$:
$$f(x + \Delta x) - f(x) = (x + \Delta x) - x$$
2. **Simplify by canceling terms:**
$$x + \Delta x - x = \Delta x$$
3. **Divide by the change in input, $\Delta x$:**
$$\frac{f(x + \Delta x) - f(x)}{\Delta x} = \frac{\Delta x}{\Delta x} = 1$$
4. **Take the limit as $\Delta x \to 0$:**
$$\frac{\mathrm{d}f}{\mathrm{d}x}(x) = \lim_{\Delta x \to 0} 1 = 1$$
---
# 3B1B
**| [3B1B Calculus Series](https://www.3blue1brown.com/?topic=calculus) | [The Essence of Calculus](https://www.3blue1brown.com/?topic=calculus&lesson=essence-of-calculus) | [The Paradox of the Derivative](https://www.3blue1brown.com/?topic=calculus&lesson=derivatives) | [Power Rule Through Geometry](https://www.3blue1brown.com/?topic=calculus&lesson=derivatives-power-rule)| [Trig Derivative Through Geometry](https://www.3blue1brown.com/lessons/derivatives-trig-functions/)] | [Visualising the Chain Rule and Produce Rule](https://www.3blue1brown.com/?topic=calculus&lesson=chain-rule-and-product-rule) |**

1. [[#Derivative Introduction]]
2. [[#Power Rule]]
3. [[#Sum Rule]]
4. [[#Power Rule]]
5. [[#Chain Rule]]
6. [[#Rules Summary]]

---
## Derivative Introduction
Well, as $dt$ approaches $0$, and those two points approach each other, the slope of that secant line approaches the slope of a line tangent to the graph at whatever point $t$ we're looking at. So the true, honest to goodness derivative, is not the rise-over-run slope between two nearby points on the graph; it's equal to the slope of a line _tangent_ to the graph at a single point.
	![[derivative_slope.png|270]]        ![[derivative_tangent.png|270]]

So if we ask what happens as $dt$ approaches $0$, representing the idea of looking at smaller and smaller changes in time, we can ignore those! By eliminating the need to think of a specific $dt$, we've eliminated much of the complication in this expression! So what we're left with is a nice clean $3t^2$. This means the slope of a line tangent to the point at $t = 2$ on the graph of $t^3$ is exactly $3(2)^2$, or $12$.
$$\frac{ds}{dt}(2) = 3(2)^2 + 3(2)(dt) + (dt)^2$$
---
## Power Rule
The derivative of $x^3$ is the rate at which $x^3$ changes per unit of change in $x$ 

So far, each of the monomial functions have had a nice geometric meaning. Nudging the input $x$ by a small amount $dx$ has allowed us to see how the geometry changes and find the derivative.

![[nudging_geometry.png]]

 > For example, the geometric intution for a 3-dimensional equation is that the rate of is $3 \approx x^3 + 3x^2 dx$ because the 3 slabs which are grow by a rate of $x^2$, which is the area of the slab face, multiplied by the $dx$ change. The other terms represent the throw of the pillar and cube but we can ignore anything $\ge dx^2$ as it becomes too small to impact anything as the limit approaches 0. 

The issue faced now is how to conceptualise higher dimensions. Thinking like a mathematician, the goal is the generalise and create abstract tools. 
$$f(x) = x^2$$
One path forward is to continue with algebra, using our geometric intuition to inform the base cases. For example, we can expand higher degree monomial expressions, where the input $x$ have been nudged by a small amount $dx$. This gives us the following series of expressions.

| Polynomial   | Expansion                                                               | Approx                             |
| :----------- | :---------------------------------------------------------------------- | :--------------------------------- |
| $f(x) = x^1$ | $(x + dx)^1 = x + 1dx$                                                  | $(x + dx)^1 \approx x + 1dx$       |
| $f(x) = x^2$ | $(x + dx)^2 = x^2 + 2x dx + dx^2$                                       | $(x + dx)^2 \approx x^2 + 2x dx$   |
| $f(x) = x^3$ | $(x + dx)^3 = x^3 + 3x^2 dx + 3x dx^2 + dx^3$                           | $(x + dx)^3 \approx x^3 + 3x^2 dx$ |
| $f(x) = x^4$ | $(x + dx)^4 = x^4 + 4x^3 dx + 6x^2 dx^2 + 4x dx^3 + dx^4$               | $(x + dx)^4 \approx x^4 + 4x^3 dx$ |
| $f(x) = x^5$ | $(x + dx)^5 = x^5 + 5x^4 dx + 10x^3 dx^2 + 10x^2 dx^3 + 5x dx^4 + dx^5$ | $(x + dx)^5 \approx x^5 + 5x^4 dx$ |
|              |                                                                         |                                    |

Recalling, the intuition that we can ignore anything containing $dx^2$ and beyond, the pattern emerging is the "power rule". Given a monomial function raised to some power, $n$, applying the rule gives us the derivative of the function.
$$\left. \begin{aligned} \frac{d(x^1)}{dx} &= 1x^0 \\ \frac{d(x^2)}{dx} &= 2x^1 \\ \frac{d(x^3)}{dx} &= 3x^2 \\ \frac{d(x^4)}{dx} &= 4x^3 \\ \frac{d(x^5)}{dx} &= 5x^4 \end{aligned} \right\} \implies \text{"Power Rule": } \frac{d(x^n)}{dx} = nx^{n-1}$$
---
## Sum Rule
The derivative of a sum of two functions is the sum of their derivatives. The tiny bump in $dx$ results in a tiny increase in each function which can simply be added together to obtain the derivative of the output. 
$$\frac{d}{dx}\left(g(x) + h(x)\right) = \frac{dg}{dx} + \frac{dh}{dx}$$
---
## Product Rule
Geometrically, it helps to think of the product rule and a computation to work out the area of a square whereby each function represents a side. Adjusting $x$ impacts each side of the area calculation creating 2 new slivers (or reduction slivers) and a tiny square. 

Each sliver comprise of a side which is made up by an original function against the $d$ change of the other. The tiny square of both of the $d$ changes multiplied against each other, we ignore it because it is tiny. 
				![[product_rule_geometric.png|389]]

Therefore, finding the change per unit $dx$ means finding the change created by the slivers. 
$$f(x) = g(x)h(X) \quad \mapsto \quad \frac{df}{dx} = g(x)\frac{dh}{dx} + h(x)\frac{dg}{dx}$$
---
## Chain Rule
Aside from addition and multiplication, the other common way to combine functions that comes up all the time is function composition. Here we are putting one function inside of another. Visually, a good way to thing about this is through a cascading number line where the input flows through the function onto the next number line. A nudge in $dx$ cascade through the function into the final output. 
				   ![[cascading_number_line.png|373]]

If we think about composition in terms of jumps, the first jump is $x \longrightarrow h(x)$, meaning we start with a number, nudge it a tiny bit $dx$ and pass it into a function $h(x)$. The "inner" function $h$ reacts to this nudge by stretching or shrinking it according to its own slope, $\frac{dh}{dx}$. So, the point on the middle number line moves by (the derivative of h with respect to x):
$$dh \approx \frac{dh}{dx} \cdot dx$$
Next, there is the second jump $h(x) \longrightarrow g(h(x))$. It is the movement of $dh$ itself that causes the nudge for the second, outer function $g()$. The outer function $g$ reacts to $dh$ according to _its_ slope at that spot, $\frac{dg}{dh}$. So, the final output on the bottom number line moves by:
$$dg \approx \frac{dg}{dh} \cdot dh$$
Putting the cascade together we get 
$$dg \approx \underbrace{\frac{dg}{dh}}_{\text{Outer stretch}} \cdot \underbrace{\left(\frac{dh}{dx} \cdot dx\right)}_{\text{Inner stretch}}$$
To find the overall rate of change (how much the final output moved per unit of initial nudge $dx$), divide both sides by $dx$:

$$\frac{d}{dx} g(h(x)) = \frac{d}{dh} g(h(x)) \cdot \frac{d}{dx} h(x)$$
Suppose you have $g(h(x)) = \sin(x^2)$, where the inner function is $h(x) = x^2$ and the outer function is $g(h) = \sin(h)$. Imagine you are at **$x = 3$** and nudge $x$ by **$0.01$**:
1. **Inner jump ($x^2$):** At $x = 3$, the slope of $x^2$ is $2x = 6$. Your $0.01$ nudge gets stretched by $6$, so $h(x)$ moves by **$0.06$** (from $9$ to $9.06$).
2. **Outer jump ($\sin$):** At $h = 9$, the slope of $\sin(h)$ is $\cos(9)$. That $0.06$ movement gets scaled by $\cos(9)$, so the final output moves by **$\cos(9) \cdot 0.06$**.
3. **Total multiplier:** Your initial nudge of $0.01$ was multiplied by $6$ and then by $\cos(9)$, giving an overall derivative of $6\cos(9)$—or in general, $2x\cos(x^2)$.

Despite its seeming complexity, we still only work out two derivatives (inner and outer function), its just important how we compose them. 
- Take the outer derivative, **keep the original inner function $h(x)$ plugged inside it** (do not replace it with $x$, and do not put $h'(x)$ inside it).
- **Multiply** that whole expression by the inner derivative.
---
## Rules Summary
- **Addition / Scaling (Linearity):** Differentiate each piece and keep the exact same signs and constants.
- **Multiplication (Product Rule):** Differentiate one at a time while leaving the other untouched, then add the two pairs together ($g \cdot f' + f \cdot g'$).
- **Nesting (Chain Rule):** Differentiate the outside (keeping the original inside intact), then multiply by the derivative of the inside.
---
