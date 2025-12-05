# Week 10 - Differential Equations 1

This week and final = diff eqs 1 & 2

## Dynamical Systems

dyn = something that changes w/ respect to some variable

flow changes over time and space

## What is a dynamical system 

Something that change sin time in a constrained way

bike accel (is the flow), constraint by law of physics

## what do we want to do with ds?

anaylse, predict, design, control 

[insert slide examples and questions]

we need math models of these systems

[scope into lecture points]

## how do we model dyn systems?

load but ordinary diffs are most comment 

caled ODE

## recap

[TAKE FULL NOTES OF THE EXAMPLE HERE]

summary is the the outcome of example is a differntial equation

to solve a diff eq, means to get rid of derivs

reshuffle

## deliberty confusing terminoly

moving from ` to . eqation

used for time as the indep

## what are we trying to do?

given -> solution 

[what?]

## terminoly

problem with approach above is that "asnwer" has any answers

this is because it unconstrained

[insert graphic]

diff functions with all the same answer

[something about starting position would give an exact answer]

[something about the constant]

solving= integrating the diff equations

## intial conditions allow us to pick a particular sol

what is the solution at a particular point in time

Intital conditions

using at time 0 but doesnt need to be

## what does it mean to solve a df?

how something changes + what something is at some time

this becomes what something is over all of time

diff eq = how changes over time

intital condition = what is at some time

soltuion = function of time but is at all point in time (how?)

that is solving a diff eq

[revist break down summary and note]

also called init value problem 

## classif of vars

indep = time

2 deps 

x`()

x() - one we are trying to solve for

## interest example

[FOLLOW AND BREAKDOWN EXAMPLE]

## analytic inte

pen and mark solutioning

not useful in real life 

wont be taught on course

## numerical integration

integrat on compu using simulation

[follow through example]

change from df smalll to just small

loose = for sqig =

[create equation]

[rearrange equation]

work through why and how for both points

## summary

1. approx formula

2. rearrange to x in near future (based on what we already know)

pred = know + know

3. repeat

[TAKE FULL NOTES OF SLIDE]

## firsot order ODE

[something how general form]

[something about first order]

double 2 is second order

2nd order eq diff

will only do first order 

because all other orders can be reframes as 1st order

## forward euler algo for num solv fir-order ODE

first need init cond

second need f functon (what?)

[take notes of the plot graphic example]

1. take deriv of f, init deriv, how x is changing
2. shoot, small change in time, assume slop is constant, new x at time t, change new deriv at time, why? because we have funciton
3. repeat at new point in time
4. repeat until some graph of solu


[something about py psudo code example]

## Terminoly

simpliest solver but not the best

## eval num solvers

deriv at each time step 

is second point looking like an over or underistmate

slope looks like it has gone up a lot

is continious assumption, then it looks like an over estimate

should be a small change because we only made a small change in t

[fill in a bunch of inutition here at the end]

but we trust the init point and we trust the arrows we calc (slopes) 

slope will be right but the assumption is wrong

the over estimate prediciton is ebcause the curve has changed alot

the diff wwas an approximation error

wat could decrease the approx error? 

brute force, decrease t step

clevel, change in a direction that interpolotes [SCOPE BETTER NOTES]

what happens to the approx error over time?

approx errors made compoound and be exponential

but could also be converigng


what does approx error compound over time? [something about there being many algos, quick summary in lecture, apparently better in lecture]

some give warning where approx error is compounding

## stiff ode example

[lectuers own research example, didn't listen to any of this]

## solve first-order ODE in python/julia

[examples]

## summary thus far

gain intutionts [explain what]

but havent learnt [something]

## modeeling badly a distceetee stochastic dyn system

[FOLLOW THIA THROUGH, LOTS OF INFO, EQUATIONS AND INTUTATIONS]

[EXPECTED VALUE SLIDE TOO]

## if you cant calculate then simulate

[intution on why to simulate, based on not being able to do something]

[DO GOOOD NOTES ON SIMULATING]

## Whats wrong with out model? 

doesnt moodel enough stuff

stoch makes it hard to math model

have to simulate

[something about things not occuring at midnight, as per the simulaiton setup]

## we going to approc model 

distcrete time to cont time oDE

measure all ime points 

measure exp number of healthy people

deterministic

## changing the discrete model

infections can happen at any time -> now twice per day

[NOTE OF BREAKDOWN OF EQUATION]

[EQS TO SHOW DIFF BETWEEN ONCE VS TWICE PER DAY]

[MOVE EQ TO EVERY CHANGE T, CONTINOUS]

## mean field equation for infection rate

[GO THROUGH THIS SLIDE AGAIN IN DETAIL]

## what have we done?

rewritten what we expect a stochastic proccess to do an ODE

[MAKE SURE UNDERSTAND THIS INTUTIATION]

# analy sol is easy in this case


## interpeting our (bad) model 

[break this down]

## systems of ODE

3 odes is a system

vector equation

## Improving the SI model 

[VERY LONG SECTION, STRUGGLED TO FOLLOW IT]

## SIR Model

An important part of this is that there are 3 functions that interact

## Analysis 

dynamics dpend upon parameters

P= num people
N= 
gamma= recovery

paramas are fixed that fixed but will change overall dynmics and solution

what combos of paramas could avoid a pandemic?

need T(t) to be decreasing

expected infections

if we need this then we set up a math equation

as we have a constraint now (my note, not sure if true)

[A SECOND ON THING ABOUT THE BOUNDRIES AND RELATIONSHIPS OF THE PARAMETERS AND SETTING UP EQUATIONS (?)]

[REarranging the maths of the eqs into something much more simple]

## the basic repodouction number

this is the rearranging outcome

## herd immmunity


## fixed ponts of the SIR model

steady state

all parameters = 0 (???)

no infection

no change in infectioned

no recovery rate

no infected people

## devidation from a fixed point

a single finction

if R_0 > 1 then growth

this is an unstable fixed point

if we move away from fix point then dynamics will move it even further

there are two types of fixed point: stable and unstable

## fixed points for general ODE

something about x(t) and x`(t) 

if x(t) isnt 0 then the rate of change also wont be

## fixed point for scalar ODE



# Math inution

[important slides]

[refollow slides]



