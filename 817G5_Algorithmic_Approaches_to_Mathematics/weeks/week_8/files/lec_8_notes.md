# Lecture 8 - More Optimisation (Vector Calculus)

Finish last weeks lecture...

Start this week which will also bleed into next weeks. 

## Last Week

Working on mutlivariate calculus 

Taylor series is easier to explain with 1 variable 

TS = Calsulus for extrapolation 

values right now and deriv of var now

extrapolate based on ^

ignoring accel (assumption)

accel is 2nd deriv of position (curvisness)

rate of change of slop

if exists then is curve

can assume that the accel is constant

this gives us some fixed curviness

quadratic approximation of position in tunnel

[insert quadratic eq]

diff twice to get 1

lose any information about b

ts upto two orders

[insert output eq]

1st ts = linear approx of pos in tennel (vel)

2nd ts = quad aprrox of pos in tunnel (accel)

[eq for each]

3rd doesnt really happen but is jerk 

0th order = inital position (ignore vel)

ts is askign how would function change if i change the indep var

given knowlege of the derivs at current val

[eqs of 0,1,2 terms]

have nn with weights and output 

can i explap how outputs will chnage if i change in the input

weights are optimisation variables

can i approx changes as a linear function

extraping how a function change is key to optimisation algos

## Current Weeks Lecture: Gradient Descent and more Vector Calculus

turn contraiened problems into unconstrained

langrange mutlipler = method used

unconstrained is finding the minima

gradient = 0

but curve needs to be positive (second deriviate)

to tell is it the minima not the maxima

- deriv at min
- curv at min

local min, local max and statioary = flat splots

plotting 3d graphs: bad indead convert to 2d with use of colours

e.g. contour plot

calc 1 var dont care about direction slop

>2 the deriviative does depend on the direction

notion of direcitonal deriviates

recap of dir dev

1st thing we need to get idea of direction is partial derividate

pd is to fix 1 var and deriv the other

gives us the 1st directional derivative

slope of cross seciton if i only change x_i

can draw ppartial derivatives as cross sections 

[include graph here to show this]

[include pd equation]

plt the pd's all on the same contour

we care about all directions not jsut the coord dirs

do this through linear combinations of the 2 two partial derivs

can write this fully in matrix vector formaiton

linear alg

vector of pds = gradient of function

gradient vector

find how function is changing in direction

take dot product of dir and vector

[bunch of eqautions]

think about dir vectors [3 1] and [9 3]

magnitute is different here

dir in multiplie dimensions has magnitute 

in 9 3 will be 3* bigger than 3 1 

even though they are the same direciton 

will be different

[general formaula of dir devir]
[explain this]

dot prod of gradient w/ direciton

dir devs and ts

[kills  if vars and plug back in]

get gradient 

end of this lecture should help understand this a lot better

dir dev is steepest uphill descent

notes on mun w/ dir dev

curv neg in all dirs

test using 2nd order deriv

<0 = max, >0 = min

mulitvar output = maxtrix noy scalar

but matrix have eigenvalue

here the eigenvalues need to satify

square matrix, pos engenvlaues, == curviture

how to calc 2nd deriv matrix

eq > calc gradiate vector > 2nd derviv but issue if func has 1 output but vecotr has a vector of outputs, vec=2 inputs, 2 outputs, vector=0 with inputs=0, this is flat, is it max or min?, 

2nd deriv (of the original eq)  gives a matrix not a vecot

stack the individal gradients

[2 0]
[0 6]

2nd deriv matrix always symetic

[notes on 2nd derive being against x1 and x2, one will be zero??? something like that]

eigenvalues of the matrix

eigenvectors

## Doing Maths

Direct Formulas

OR

Iterative improvements

latter is gradient descent

start with a guess

think about f(x) = x^2

how to find with iterations

start with random x

step right or step left e

most simple algo would be step +/- and see which improves

how big should delta x (change) be

need to optimize this 

too big could overshoot

how to do this easy algo with two inputs?

random x start

x = [vector of variables]

how many directions to test

4

because x1 and x2 

combination of two = 4 

with 3 vars this does to 8, 2^3 = 8

this simple algo scales poorly

becomes too large

2^n 

zero order optimization algo is the name

dont work well with lots of variables

need to find a targetted way to find direciton of imrovements 

random guessing is no good

targeted

better algo: go opposite direction of slope

(deriv)

step size = learning rate

[stuff about higher dimnsions and cross sections again]
[need better notes]
[something about how number of variables scales in this slope methd vs easiest algo method]

[stuff about reading points on a contour graph and working out slope directions]

[something about following the cross section directiond will tell us a certain direction of slope]

the gd comp cost scales lienarly with the number of variables (compare to easiest algo)

## Gradient Descent

minus of the the graduate

take a step/learning rate of the slope 

i.e. 0.0001

dont want to over step

dont want to understep = costly and time

1. chooose learn
2. choose random x staarting point
3. [psuedo code implementation]

repwat and hope you get the minima

gd might get stuck in a local minimum

cant stop this from hapoening

for some reason doesnt impact large NNs (unknown)

gd need to take the negative slope

because slope is up and we want minima

### contour plots

lines are call level sets

finction is constant as we travrse a level set

[insert set equation defintion]

take a line tangent to level set. dir deriv will be 0

[finding level set direction, didnt understand, redo and notes]

### why is gradient the direciton of the slope?

think abiut just looking at the level set

how can you work out the steepest part?

it is the perp (right angle) from any point on the set level

opposite of following the level set

orthogonal is math term for that

quickly cutting through any levels sets = steeper ascent

level step depends on granularity. less steps = less understanding of gradient

ascept step doesn't take into account how level steps change as we go

could step over many but the curves could be changing

gradient = zero dot product with level set direction by definition

geo metrically gradient vector is right angle to elvel set

# Week 9 Continuation

## Finding Level Set Direction

the dir of a coutnour line

the f(x) does not change all, all the same

partital deriviate of the function

these are the slopes in x1 and x2 dir

partial derivs paclages up are gradients

the graident is a vector valued function

it is still also a function (why?????)

0 dot product with gradient is at right angle to the point you were at
(level set conditon)

if two things dp is 0 then they are orthogonal

we want it to be zero along a level set

# grad is dir of slop

grad is steepest upward slode

it is orthogonal to the level set

exactly perpendic

cutting through lines

sortest route through the contours

level set condition [rewatch the lecture here for clarification]

[follows up with gradient defintion too]

grad dir = right angle to level set

## gradiant is dir of slope

anothet way of of explaining

dot prod same as [in sert alt equ here] 

mags by cos(0) 

how big things are times by the angle between them

if they are at 90 degs cos(0) = 0  so dot prod is 0

max of cos(x) is 1 (or -1) so dp is as big as it can get given the vectors values

is dp is 0 = orthog

## math justifying grad desc

[gd formula] 

[ dir deriv formula]

[something about subs]

[refollow this part of the lecture]

it is linear function

easy to find decreeasing dir

gd we want to min f hence decrease

easiest way is to just minus the gradient

## more generally

[some good equations]

## summary 

sum of gd

choose a learn rate

small steps in negative slope

gd only makes sense if we can efficently csalc graidents

lin alg makes it easy and quick 

-> auto diff

## forward mode AD

[review all of this again]

[all v important]

dispearing ep^2

new way of representing numbers

walks through route to getting deriv using dual number represation

dual (x lots of, infindes)

if we do this with numbers, not symbols we get [re do this part]

[do this whole section again]

[follow through all examples paper expanding with dual rep]

shows how product rule can be done via autodiff and dual rep

dual num algebra encodes the product rule

# Todays Lecture

## unconstrained recap

second partial deriv test to check for negative flat zone

this is to check for curviture, min will be u, max will be n

stuff about eigens

## equality constraints

='s not <='s

covert into

take the prev contour function that we have already calc erivs for

[in sert eq]

objective [eq]

constraint [eq]

graph rep of adding a constraint [add picture]

represents the constraint function

## cross section along consrtiaght

plotting hthe bottom

## zoom in

[something about guessing and constra line]

guess replates to cross section graph above

## another situ

parrall to level set (on it)

can't move anywhere else

both dirs are moving up off level set

it looks like constrianed min

## express mathematically

[review this seciton]

## nes cond on min 

[rev]

lagrange mutlis

## back to exmple

## lag nec cond on opt

[review all slides on lagrange]


