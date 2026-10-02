**Self-Study Resources:**
[Think Julia Study Book](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html)
[Julia Academy](https://juliaacademy.com/)
[Julia Companion Course: Introduction to Computational Thinking](https://computationalthinking.mit.edu/Fall24/)

**Setup:**
[Julia Setup Guide](https://algorithmic-approaches-to-mathematics.github.io/prerequisites/installation/)

---
##### Basic Arithmetic
| Expression | Name           | Description                             |
|:---------- |:-------------- |:----------------------------------------|
| `+x`       | unary plus     | the identity operation                  |
| `-x`       | unary minus    | maps values to their additive inverses  |
| `x + y`    | binary plus    | performs addition                       |
| `x - y`    | binary minus   | performs subtraction                    |
| `x * y`    | times          | performs multiplication                 |
| `x / y`    | divide         | performs division                       |
| `x ÷ y`    | integer divide | x / y, truncated to an integer          |
| `x \ y`    | inverse divide | equivalent to `y / x`                   |
| `x ^ y`    | power          | raises `x` to the `y`th power           |
| `x % y`    | remainder      | equivalent to `rem(x,y)`                |

---
##### Logical Programming
| Operator  | Name                     |
|:--------- |:------------------------ |
| `==`      | equality                 |
| `!=`, `≠` | inequality               |
| `<`       | less than                |
| `<=`, `≤` | less than or equal to    |
| `>`       | greater than             |
| `>=`, `≥` | greater than or equal to |
| `!x`       | negation             |
| `x && y`   | short-circuiting `and` |
| `x \|\| y` | short-circuiting `or`  |
**Ternary operator:** ` a ? b : c` if `a` is true run `b` else run `c`

---
##### Mathematics
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

##### Unary Operators
The unary plus (+x) and minus (-x) in isolate do nothing other an assign. This is important when creating independent variables and not copies of existing data. They act as the **identity operation**, simply returning the value unchanged.

---

###### Short-Circuits
&& (and) and || (or) are known as "short-circuits". These are not functions and are instead are special syntactic form for control flow. Here, the LHS is evaluated first. For `&&` if the term fails then the flow stops and the RHS is not evaluated. The same is true for `||` but if the LHS passes then the RHS is omitted. 

This is important for examples where a failure of the LHS would lead to a result that is catastrophic for the RHS and would lead to a runtime error 

`denom != 0 && (100 / denom > 2)`

Additionally, the second expression in an `&&` doesn't need to be another eval. It could be an execution like `print('hello')`. Infact `&&` can be used as an alternative to `if-else-end` statements
```
begin
	(x == 1) && println("x == 1")
	(x != 1) && println("x != 1. Actually, x == $x")
end
```
Conversely, single `&` is a function (`Base.:&`) and forces the evaluation of both arguments. 

---



as oppose to single digit representations. 



