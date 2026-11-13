| [Canvas](https://canvas.sussex.ac.uk/courses/38867/pages/week-6-summary?module_item_id=1669830) | [Recording](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=14c31243-b3ac-47d5-8cbc-b4f800d6d1e5&start=1.60349) |
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
3B1B Calculus Series](https://www.3blue1brown.com/?topic=calculus)
- [ ] [The Essence of Calculus](https://www.3blue1brown.com/?topic=calculus&lesson=essence-of-calculus)
- [ ] [The Paradox of the Derivative](https://www.3blue1brown.com/?topic=calculus&lesson=derivatives)
- [ ] [Power Rule Through Geometry](https://www.3blue1brown.com/?topic=calculus&lesson=derivatives-power-rule)
- [ ] [Trig Derivative Through Geometry](https://www.3blue1brown.com/lessons/derivatives-trig-functions/)
- [ ] [Visualising the Chain Rule and Produce Rule](https://www.3blue1brown.com/?topic=calculus&lesson=chain-rule-and-product-rule)

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









---
# Lab


---