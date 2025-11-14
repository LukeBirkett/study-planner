# Lecture 7 - Optimisation (Intro)

Lecture slit into 2:
- intro into optimisation (mordern term in learning, ml). more classical stuff. still useful. linear and quadratic programmes
- second half is calc again w/ mutli inputs

## Optimisation Thoery

extremising quanities subject to constraints

- max profits over contraints of risk and money
- min delivery times subject to locaations, fuel
- min classifcation error by changing weights (UNCONSTAINED)

course focuses on constrained optimisation more

## Terminology

Min f(X) means minimise the output 

arg min f(x) means the vector that mins the output

## Adding contraints

e.g. kcal > 2000

represent as matrix vector mutli

g(x) = [con_1, con_2, con_3] [x1, x2, x3]

## Standard Form

Constraints by default should be <= 0

how to create this from kcal > 0 

algera

easiest way is to flip via *-1 

and then + 2000

g(x) = 2000 - g(x)

now contraint should be less or equal to 0

constraint - original con function

## Mutli constraints

using linear algebra you can present mutli constraints using matrices

each row is a diff constraint


\mathbf{g}(\underline{x}) = \begin{bmatrix} g_1(\underline{x}) \\ g_2(\underline{x}) \end{bmatrix} \\
= \begin{bmatrix} 2000 \\ 100 \end{bmatrix} - \begin{bmatrix} 450 & 300 & 700 \\ 9 & 0 & 4 \end{bmatrix}i

## Linear Optimisation Problem

\min_{\underline{x} \in \mathbb{R}^n} f(\underline{x}) = \underline{c}^T \underline{x}

can always explace an equality constraint with two inequality constraints

x + 4 = 0 

x + 4 >= 0 and x + 4 <= 0

linear optimisation = linear program

same thing

## Our Linear Program

\min_{\underline{x} \in \mathbb{R}^n} f(\underline{x}) = \underline{c}^T \underline{x} \quad \text{subject to} \quad A\underline{x} \leq \underline{b} \\
\underline{c}^T = \begin{bmatrix} 3.99, 1.49, 4.99 \end{bmatrix} \\
A\underline{x} = \begin{bmatrix}
-450 & -300 & -700 \\
-9 & 0 & -4 \\
1 & 0 & 0 \\
-1 & 0 & 0 \\
-1 & 0 & 0 \\
0 & -1 & 0 \\
0 & 0 & -1
\end{bmatrix}
\begin{bmatrix} x_1 \\ x_2 \\ x_3 \end{bmatrix}
\leq \underline{b} =
\begin{bmatrix}
-2000 \\
-100 \\
1 \\
-1 \\
0 \\
0 \\
0
\end{bmatrix}
\begin{array}{l}
\text{- calories less than -2000} \\
\text{- protein } < -100 \\
\text{more than one burger} \\
\text{less than one burger} \\
\text{positivity constraint} \\
\text{positivity constraint} \\
\text{positivity constraint}
\end{array}


note the way of enabling min constraights in using -1 < 0 aka positivity constraint

## int vs cont, relaxation

must optimize other integers 

integer program

int progs are horrible to solve

math tools do not exists

trick is the solve the real problem and round up 

called 'relaxing the problem'

look at problem, if too hard, solve similar and use solution as estimate

important skill for optimization

'art' not science

## Code example

\text{Factory makes products } A \text{ ($\pounds30$ profit) and } B \text{ ($\pounds20$ profit)} \\
\begin{itemize}
    \item A: 2 \text{ hours of labour, } 1\text{kg of material}
    \item B: 1 \text{ hour of labour, } 2\text{kg of material}
\end{itemize}
\text{Maximise profit in one day (8 hours) with } 8\text{kg material} \\
\vspace{0.5em}
\text{Maximise } \begin{bmatrix} 30 & 20 \end{bmatrix} \begin{bmatrix} x_1 \\ x_2 \end{bmatrix} \quad \text{subject to} \\
\begin{align*}
2x_1 + x_2 &\leq 8 \quad & \text{(Labour Constraint)} \\
x_1 + 2x_2 &\leq 8 \quad & \text{(Material Constraint)} \\
x_1, x_2 &\geq 0 \quad & \text{(Non-negativity Constraint)}
\end{align*}


```
using JuMP
import GLPK

# 1. Initialize the optimization model
model = Model(GLPK.Optimizer)

# 2. Define variables
# The 'lower_bound = 0' enforces the nonnegativity constraint
@variable(model, x1 >= 0)
@variable(model, x2 >= 0)

# 3. Define objective (maximize 30x1 + 20x2)
@objective(model, Max, 30*x1 + 20*x2)

# 4. Define constraints
@constraint(model, con1, 2*x1 + x2 <= 8)
@constraint(model, con2, x1 + 2*x2 <= 8)

# 5. Solve the problem
optimize!(model)

# 6. Display results
println("--- Results ---")
println("Status: ", termination_status(model))
println("Optimal value (profit): ", round(objective_value(model), digits=2))

if termination_status(model) == MOI.OPTIMAL
    println("Optimal x1 = ", round(value(x1), digits=2))
    println("Optimal x2 = ", round(value(x2), digits=2))
else
    println("No optimal solution found.")
end

```


