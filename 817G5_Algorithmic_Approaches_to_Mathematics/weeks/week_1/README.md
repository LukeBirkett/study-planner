# [Week 1 - Intro/Setup](https://canvas.sussex.ac.uk/courses/34902/pages/week-1-summary?module_item_id=1565137)

## Lecture
- [x] [Week 1 Intructions/Summary](https://canvas.sussex.ac.uk/courses/34902/pages/week-1-summary?module_item_id=1565137)
- [x] [Slides](https://github.com/LukeBirkett/study-planner/blob/main/817G5_Algorithmic_Approaches_to_Mathematics/weeks/week_1/files/Week_1.pdf)
- [x] [Lecture Recording](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=2220220c-19c8-4ea9-8f7e-b36b0108142d)
- [ ] [Introductory Cheatsheet](https://github.com/LukeBirkett/study-planner/blob/main/817G5_Algorithmic_Approaches_to_Mathematics/weeks/week_1/files/Introductory_cheatsheet.pdf)
- [ ] [Latex Cheatsheet](https://quickref.me/latex.html)
- [ ] [Latex Writting Converter](https://detexify.kirelabs.org/classify.html)

## Lab
- [ ] [Lab](https://github.com/LukeBirkett/study-planner/tree/main/817G5_Algorithmic_Approaches_to_Mathematics/weeks/week_1/lab)
- [ ] [Julia Setup](https://algorithmic-approaches-to-mathematics.github.io/prerequisites/installation/)

---

| **Symbol**  | **Explanation**  |
|---|---|
| $$a \Rightarrow b$$  | a implies b   |
| $$a \Leftarrow b$$  | a is implied by b   |
| $$a \Leftrightarrow b$$  | a is equivalent to b   |
| $$a^c$$  | The negation (opposite) of a  |
| $$\therefore$$  | Therefore  |
| $a \land b$  | a and b  |
| $a \lor b$  | a or b  |
| $\forall$  | for all or for each  |
| $:$  | such that  |
| $\exists$ | there exists  |
| $\in$ | is a member of, e.g. $3 \in \mathbb{N}$  |
| $!$ | unique, e.g. $\exists! x \in \mathbb{N}: x > 3 \land x < 5$  |

--- 

-  $\mathbb{N}$: the natural numbers.
-  $\mathbb{Z}$: the integers. 
-  $\mathbb{Q}$: the rational numbers 
-  $\mathbb{R}$: the real numbers 
-  $\mathbb{C}$: the complex numbers

--- 
-  $\subset$ means: "is a subset of"
-  $\subseteq$ means "is a subset of, and may be the entire set"
-  $\in$ means: is a member of
-  $A\cup B$ means: the union of sets $A$ and $B$.
-  $A \cap B$ means: the intersection of sets $A$ and $B$. 	
-  $A^c$ means: the complement of $A$. IE the set of things **not** in $A$.

---

- Injective: A function that maps every element of its domain to a unique element of the range is injective. In other words, no two elements in the domain map to the same element of the range.
- Surjective: A surjective function maps something in the domain onto every element of the range.
- Bijective: Injective and Surjective. If a function has an inverse, it will be bijective

---

### Addition
**A1** (commutativity):    
	
$\quad \quad a + b = b + a \quad \forall a,b \in S$

**A2** (transitivity): 

$\quad \quad a + (b + c) = (a + b) + c \quad \forall a,b,c \in S$

**A3** (zero):

$\quad \quad \exists 0 \in S:  \quad a + 0 = a, \quad \forall a \in S$

**A4** (additive inverse):  

$\quad \quad \forall a \in S, \ \ \ \exists -a \in S: a + -a = -a + a = 0$

### Multiplication
**M1** (commutativity):    

$\quad \quad a \times b = b \times a \quad \forall a,b \in S$

**M2** (transitivity):    

$\quad \quad (a \times b)\times c = a \times (b \times c) \quad \forall a,b,c \in S$

**M3** (one):    

$\quad \quad \exists 1 \in S:  \quad a \times 1 = 1 \times a = a \quad \forall a \in S$

**M4** (multiplicative inverse):

$\quad \quad \forall a \neq 0 \in S: \ \ \ \exists a^{-1} \in S: a \times a^{-1} =  1$

### Addition and multiplication

**D1** (expanding brackets):

$\quad \quad (a + b) \times c = a \times c + b \times c \ \ \  \forall \ a,b,c \in S$
