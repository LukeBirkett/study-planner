**| [Canvas Page](https://canvas.sussex.ac.uk/courses/38867/pages/week-1-summary?module_item_id=1669820)
#### Weekly Goals:
- Introduction to mathematical syntax and its' manipulation
- Understanding sets and set operations
- Understanding the notion of variable assignment, and being able to assign variables
- Understanding the notion of functions, and nested functions.
- Understanding the notion of an axiom, and the axioms for number systems (no need to memorise the latter)
---
#### Files:
1. [Introductory Cheatsheet](./Files/Introductory_cheatsheet.md)
2. [A Guide to Writting Mathematics](./Files/Guide_to_writting_mathematics.md)
3. [Week 1 Lecture Slides](./Files/week_1_slides.md)
---
##### Links: 
1. [Canvas Page](https://canvas.sussex.ac.uk/courses/38867/pages/week-1-summary?module_item_id=1669820)
2. [Video Lecture](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=232af66a-46a7-4f96-84a0-b4d500c65487&start=0.42496)
3. [Julia Setup Guide](https://algorithmic-approaches-to-mathematics.github.io/prerequisites/installation/)
4. [Study Helpers](https://canvas.sussex.ac.uk/courses/38867/pages/study-helpers?module_item_id=1669822)
---
##### Lecture
This lecture started as a general introduction to the course. The latter part of the lecture started on the basics of Linear Algebra. This is a topic which spans 2/3 weeks the notes for it are contained in the [Linear Algebra page](../../Linear_Algebra.md).

---
##### Lab
1. General introduction to doing maths in Julia. Notes compiled in the [Julia Notes](../../Julia/Julia.md)
2. Basic syntax for calling and creating functions. 
3. This is a mutli-line function
   ```
   function name(input_a, input_b)
	   # stuff
	   return input_a ^ input_b
	end
   ```
4. This is a single line function using assignment. It doesn't need to take argument, this is important for functional programming.
```
square2(x) = x^2
square3 = 🐂 -> 🐂^2
```
5. In Julia, we do not need to state `return` in order to return something from a function. Instead, the value of the last evaluated expression in returned
6. **Returning a function:** Therefore if the final line is another function then you return a function 
   ```
   function pow(n) 
	   inner_pow(x) = x^n 
	end
   ```
7. `inner_power` is strictly local, not global.
8. Calling this structure is a two step process. First you "call" the `pow` function  assigning the returned inner function to another variable `cube = pow(3)`
9. The new variable is just the inner function so it is to be called again `result = cube(4)`
10. 



---

