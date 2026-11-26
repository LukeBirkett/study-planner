**| [Canvas](https://canvas.sussex.ac.uk/courses/38867/pages/week-8-summary-2?module_item_id=1669835) | [Recording](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=ef9485cf-51c6-40ac-8517-b50600d753ee) |**
- Gradient descent: a famous technique for unconstrained optimisation that underlies neural network learning
	- Relies on calculating the gradients of complicated functions, which is usually achieved using automatic differentiation.
- A quick look at how forward mode automatic differentiation works.
- The other version (backward mode) is covered in next term's lectures on machine learning (it's called backpropagation).

- Then we'll be asking how we can turn a _equality-__constrained_ optimisation problem into an unconstrained one. After all, real life optimisation problems outside of neural network training often have constraints.
	- leads us to the famous _Lagrange conditions_ for a constrained local minimum.
	- We'll skip the equivalent technique for turning _inequality-constrained_ optimisation problems into unconstrained ones (the Karush-Kuhn-Tucker conditions), as they have similar intuition.
# Goals
- Be able to implement a gradient descent routine by hand, and by using existing Python/Julia functions
- Understand the graphical intuition behind gradient descent
- Understand how forward-mode automatic differentiation works, and why it's different from symbolic (i.e. pen-and-paper) differentiation.
- Use the Lagrange conditions to turn an equality constrained optimisation problem into an unconstrained problem that can be solved by gradient descent.
---
# Files
- [[Vector calculus week 8.pdf]]

---
# Links
- [3B1B - How to compress text to 1 bit per character | Compression is Intelligence Part 3](https://www.3blue1brown.com/?v=gradient-descent)
- [Khan - Why is the gradient the direction steepest ascent?](https://www.khanacademy.org/math/multivariable-calculus/multivariable-derivatives/gradient-and-directional-derivatives/v/why-the-gradient-is-the-direction-of-steepest-ascent)
- [Khan - Lagrange multiplier](https://www.khanacademy.org/math/multivariable-calculus/applications-of-multivariable-derivatives/constrained-optimization/a/lagrange-multipliers-single-constraint)
- [Khan - A worked example of using the Lagrange multiplier to solve a practical optimisation problem](https://www.khanacademy.org/math/multivariable-calculus/applications-of-multivariable-derivatives/lagrange-multipliers-and-constrained-optimization/v/lagrange-multiplier-example-part-1)
- [Summary of Autodiff](https://jingnanshi.com/blog/autodiff.html)

---
# Lecture



---
# Lab
- 


---
# 3B1B
