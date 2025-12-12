# Week 11 - Differential Equations 2

Recap of sys of irdinary diff eqa (ODE)

un/stable dixed points 

math conditions for fixed pooints


## Warm up: complex numbers

Real numbers

Comp number: has a real component then another times by something imarginary `i` [insert example]

[INSERT CIMPLEX NUMBER MATHS EQUATION]

highlight the real and imaginary part

complex number come in paris

pairs cancel out the imaginary part when +

"complex conjugate" = opposite

multipling creates a real number > 0

these slides are justa  reminder and in the cheatsheet

real matrics can have complex eigenvalues

[something about matricies and eigens, probably understand this]

## Boring, relevant facts

[bunch of matrix stuff, go through, breakdown and understand]

complex eigenvalues also come in pairs

## What do we want to do with dynamical systems?



## Recap: SIR model

system of diff equations with 3 states

clauclation of infection rate

outputs the set of differential equations

[would be good to put this summary in a clear para]

break down of diff eqs and the parameters

[linear first order ODE, explain]

states, formula and rates of change

[AUTONOMOUS ODE]

[theta is vector holding all parameters]

[spell out the paarameters]


## Terminology

diff eqs have a state vector that you want to montior as things change

parameters (theta, rates)

vector field

[TAKE FULL NOTES OF THIS SLIDE]

## Analysis recap


What combintation of params could avoids a pandemic?

turn into questions that cen measured

we need expected infections to be always decreasing

## Recap: the basic reproduction number

this was the metric we made to track the question

[re do a quick defintion and explantion of this]


## Fixed points of the SIR model

for what vlaues of the states are there no dynamics

what do you need for the states to be 0

i.e. no change in rate of infection if there are no infected poeple

[do breakdown of when each rate becomes 0]

## Deviation from a fixed point

fixed point stability

i.e. adding an infected person

[unstable, define when in related to R]

same for stable

## Other examples

stable points will return to the fix 

[note the examples given]

## Stability of fixed points

[didnt listen to slide properly but it is important so full notes]

## Curse of dimensionality

why ant we just simulate to figure things out

CoD

assess equation for stability with 3 parameters

how many sims to do? 10 values for each params = 1000 sims

cover k values for m params

k=3 m=10, s=1000

m^k

huge nunbers when increase

## How did we avoid lots of simulations here?

[wordy, slowly breakdown and take full notes]

## Always start with the linear case

[explains why to start with linear but missed this]

[full breakdown, draws on previously learnt concepts]

## What does this mean?

Global stability

## Checking our claim

opt 1: simulate, lot of dimensions

opt 2: ???

opt 3: lin alg tric <- this

## Important trick for determining negativity of eigenvalues

[break this down]

## Stability of our linear ODE
## Where did this ODE come from? 
## Deriving the equations
## Application of Newton’s Law

[did not follow any of these]

## What if we move the mass

[need to go through this full example, also some stuff in cheatsheet]

## Equate force and acceleration

laws 

almost eq for motion of a spring

prob this is second order diff

in notebook we did first oder diff

almost all packages only do first order

but we can turninto first oder

## Dealing with high order ODEs

breakdown of how to change

new states for postition and velocity

explanations of old equations into new

example turning it into matrix representation

perpetual motion, no dampening, will oscilate perfectly forever

[something about track determinant trick]

2 conditional eqs to meet in the trick

answ: complex numbers

[why the claim is not valid]

## One plot. More insight

plotting states aginst each other

phase portrait

time is not plotted

somethig about initali conditions

can plot multiple init conditions

tangent line: rate of change of state with respect to other state

ratio of states

[showing lots of tangent arrows]

see wht ahppens at every inital condition

vector field/quiver plot

## Perpetual motion is impossible

before we did not model friction

build a basic model and then as the complexities in iteratively

[irl example tht needs following]

## Previously on channel 4

[didnt follow]

## Turn this into first-order ODE?

use trick to turn into first-order

change deriv for new state

[somewhere need to have a good understanding of this trick]

## Stability of damped oscillator

simulat using inital condition

show the system oscilates and returns to 0

this means it is stable

whereever you start it will return to the fixed point

globally stable fixed point

under what params will this be unstable?

k or c negative would break [irl interpretation]

phase portrate of stable cond

[maths validation of stabiltiy, need to follow]

## Why is our claim true?

[identify claim in full]

[the maths will be inthe cheatsheet]

wan tto prove that everyting is moving towards 0 if we hve glob stable point

[some forward euular equaitone xample]

[special case x(t) is an eigenvector of A]

[complicated, follow through]

[claim itself is not in exam, explanations are just for intution]

## Converse claim

[spell out, opposute of previous claim so relational to unstable]

## Summary thus far

[breakdown]

## Stability of fixed point

most things work with linear modellings

most things are linear with used within their normal range

SIR models are non-linear

## Example

of non-linear differential equation


## Evaluating fixed point stability

## More generally

## Apply to SIR model?

## Useful how/when/why?

## Ecological systems?



