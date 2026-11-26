**| [Canvas](https://canvas.sussex.ac.uk/courses/38867/pages/optimisation-summary?module_item_id=1669833) | [Recording](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=06c42aea-87ac-48d2-a843-b4ff00d66f70) |**
This week we start **optimisation theory.** This is the mathematical (and coding!) framework for how to solve optimisation problems. What's an optimisation problem? The problem of extremising (minimising/maximising) quantities subject to constraints. For instance:
- How do I minimise fuel usage while designing multiple lorry trips that arrive at different warehouses in a given order?
- How do I minimise money on my supermarket shop while having sufficient calories and nutrients? And also exactly two burgers for my cheat days?
There is a lot of mathematical theory on optimisation. This covers when an optimal solution is/not guaranteed, and how fast different optimisation algorithms converge (i.e. find a solution). We aren't going to cover this. Instead, we are going to look at optimisation as a **user.**

# Goals
- Understand the meaning of the **standard form** of a given optimisation algorithm
- Know some of the tricks that can be used to massage a problem into a standard form
- Understand terminology: optimisation variables, objective, min vs arg min, in/equality constraints.
- Understand the concept of a stationary point. Note that not all stationary points are local maxima/minima
- Understand the concept of a directional derivative, jacobian, partial derivative, and Taylor series. Be able to calculate them in code.
---
# Files
- [[Intro to optimisation.pdf]]
- [[Vector_calculus_week7.pdf]]
- [[Calculus2_cheatsheet.pdf]]
---
# Links
- [Julia Course Optimisation Notebook](https://computationalthinking.mit.edu/Fall24/data_science/optimization/)
- [Optimisation Textbook](https://web.stanford.edu/~boyd/vmls/vmls.pdf)

[3B1B Calculus Series](https://www.3blue1brown.com/?topic=calculus) (6,7,8,14)
- [What's so special about Euler's number e?](https://www.3blue1brown.com/?topic=calculus&lesson=eulers-number)
- [Implicit differentiation, what's going on here?](https://www.3blue1brown.com/?topic=calculus&lesson=implicit-differentiation)
- [Limits and the definition of derivatives](https://www.3blue1brown.com/?topic=calculus&lesson=limits)
- [Taylor series](https://www.3blue1brown.com/?topic=calculus&lesson=taylor-series)

---
# Lecture



---
# Lab
First:
- Do extensions from Week 6 labs (vector/multivariate calc)
-  Also do Comp Thinking section Auto Diff from last week
	- [A Quick Introduction to AD for Scientists](https://mitmath.github.io/18S096SciML/lecture7/ad)
	- [What is Automatic Differentiation](https://www.youtube.com/watch?v=wG_nF1awSSY)
	- [Intro to Computational Thinking; Section 1.3 Automatic Differentiation](https://computationalthinking.mit.edu/Fall22/images_abstractions/transformations_and_autodiff/)

After these, the notebooks set are for for the rest of the course (weeks 7, 8, 9, 10):
- Lecture companion with some small questions practicing vector calculus and Lagrangians (`Lagrangians_vectorcalc.jl`)
- Doing vector calculus on a real life dataset. It does gradient descent practically (`Dataset_resgression.jl)`
- Finally, another Comp Thinking section on Optimisation:
	- [2.9 Optimisation](https://computationalthinking.mit.edu/Fall24/data_science/optimization/)
---
# 3B1B
