# Lecture 5 Notes: Prob and Stats

An experiment is a process with uncetain outcome

Probability theory is a mathmatical framework to deal with caracterising quantifying uncertain evetns

#### Seating Example & Terminaology

Eating seating outcome combination is an outcome



Events is a set of outcomes

Events gave a set algebra


- Union (or) U
- Interaction (and) N
- Complement (not/without)

every event has a probability

P: events  -> [0,1]

0 <= P(x) <= 1

Probability is wy of expressing partial knowledge of an event

There is no correct probability 

Prob is subjective

Maybe based on info availble and opinion

A probability spaice is:

1. Sample space. Set of all possible outcomes

2. Event space. Set of all possibl events (combinations of events)

3. Probablity function, Assign prob to single event


Sample: Every possible seating
Event: All combinatons where the backrow is filled

Events will uncompase outcomes but usually not all of them. Just subsets

Events can have intersections and unions

Mutually exclusive events. There is no intersection (N)

P[E1 U E2] = P[E1] + P[E2] - P[E1 N E2]

- prob of event1 
- prob of event2
- removing the prob when they occur together (union)

if mutually exclusive the P(E1 N E2] = 0

P[E2|E1] = conditional prob

Independant events are not mutally exclusive 

they are events that done impact the outcome of something else

i.e. eating eggs for breakfast and whether it will rain tomorrow

C = subset

i.e. in E1 means you are in E2

E^complement 

# Random Variables

These are functions (not variables)

they are quant questions about an experiement

a function that maps from outcomes to numbers

Random value takes an event set

An RV example:

What was the number of unfulled seats? X(w)

X() function
w = input

In input of a randon variable is the outcome of an experiment

An outcome is in the subspace of the OUTCOME SPACE

Note, 87 unfilled seats isn't the outcome

There are many different combinations where there are 87 unfilled seatrs and each is an outcome

The set of outcomes is an event

The set of outcomes where there as 87 unfilled seats is an event

This is the event where the random variable takes 87

#### Notation

P[{w in Omg : X(w) = 4}]

The probability of the set of outcomes such that the output of the random variable = 4

The output of the RV is 4 when we give it the right input

The inputs come from the outcome space and there will be a subspace of outcomes which suffice 

#### Deterministic 

Depsite their name, RVs are not random

The mapping of the RV is deterministic

i.e. RV(heads) = 0.5

the input itself, heads, might be random

recall that the input is an "outcome" from the outcome space

#### Support of a Random Variable

This is the set of plausible values a RV can takes, 

i.e. heads or tails

in practice these will be represented by numbers 

i.e. h = 8, t = 0

supp(X) = {0,8}

supp(x) = {tails, heads}

this is smallest set whereby the probabiltiy that the RV lies in that set is 1

Example: Z is the height of the 2nd person in the 3rd row

What is the support of Z? 

It is the possible height values of a person

supp(Z) = [l, u]

this [l, u] means range

#### 2 flavours of RV

- discrete: {1,2,3 ... 4}
- continous: [l,u]

# Probability Mass Function

PMF of a discrete RV

Fx: R -> [0,1]

x = num of unfilled seats
fx = prob of that value

f() is taking the output of a RV 

outcome space > event > rv > pmf > probabiliy

you can draw a graph of a prob mass function

x-axis = event
y-axis = prob

cumlative bars will = 1

# Types of PMFs

RV tend to pop up with particular types of PMFs

#### Bernoulli RV

Recall that RVs are quant questions about the experience 

Bernoulli RVs are binary questions 

"is the back row filled?"

pmf x-axis is yes or no

Y ~ Bern(p)

Y is distrib uted as a Bernoulli RV with probabiliy p

#### Uniform Rvs

prob of every outcome in the support of equal 

usuahlly means little information is known about the experiememt 

X is uniformly distributed on the set S

X ~ U(S)

Where S is the support

U() is the RV function 

X ~ U({0.1, 2, 5.5})

0.1 = 0.333
2 = 0.333
5.5 = 0.333

# Random Variable with Continous Support

What is the probability that a human is 180cm?

The answer is zero 

every exactly probabiliy has an outcome of 0

180cm = 180.00000000000000000cm

you can enver be the exact number

the only reasoable quanitiy is ranges of outcomes

we model ranges of outcomes

continous use Probabily Density Functions

not pmfs

P(X = anything] = 0

Instead

P[a <= X <= b] = ?

The maths uses integrals

But we arent using integrals on this course, only deriviatives

In PDF you look at the area between two points

The entire area under the curve = 1

Ranges just take a slice of this

## CUmulative Density Function

For a continous random variable 

Looks at the area upto a certain point

i.e. from 0 upto a range

Fx(b) = P[x < b]

CDF can be combined to create range

i.e. less than 180 - less then 160, is the ssame as between 160 and 180

need to minus the smaller from the bigger 

as the bigger (more right) will have the larger prob

can easily do cdfs in python

## Recap

Experiments have outcomes

Sets of outcomes are events

Random Variables map outcomes to values

Random variables taking a particular value is an event

PMFs and PDFs give probabilities of such events

## Statistics

Stats are summaries of random variable 

Sacrafice information for interpretablity 

Expectation, i.e. on average there are 23 unfilled seats

Vairbales, i.e. number of empty seats varies by X accrss samples

Neither of these give us the RV function

However, you can piece together qualities of the RV from these statistics

## Population vs Sample Stats

Experiement: pick a person from  a uni

Outcome: a person form the outcome space

RV: X(person) = height

Statistic: Average height from set of people

Event: Sets of outcomes (people)

A population statistic is the average over all people

Sample statistic is over limited outcomes

Gives an idea but not the true value

Much easier to measure

Much of statistics revolves around trying to infer stuff about population stats from sample stats

 A statistic summaries the Random Variable itself

## Statistic 1: Expectation/Average/Mean

Outcome space: all possible seating combinations

Subset: of Outcome Space, the seating combinations seen (samples) during a course

Random Variables: outcomes to number of filled seats (doesnt care about arrangment, just computes the number)

S = {w1, w2, ... , wx}

Set of outcomes

S RV = {X(w1), X(w2), ... , X(wx)}
-> {90, 90, ... , 130}

"sample the random variable"

Sample Expectation: u-hat(x) = sum( X(w) P(w) )

u-hat means expectation/average for the SAMPLE

= 90*0.5 + 90*0.5 + ... + X*y 

Population is the same method but w comes from the outcome space (omega) not the sample space, i.e. all of outcomes

Law of large numbers: as you take more samples, the sample expectation converges to the population expectation

#### Alternative Expection Formula

Instead of summing of the probability outcome values. You sumover prob of the values of the RV

x is drawn from a sample which is the support of X

The support is all of the values that the RV can take

i.e. all of the possible RV outputs

i.e. the possible number of seats filled in a lecture hall

RV poss * prob of that * ... for all possible values

This gives you the population statistic

For the sample statistic, you do a similar thing but just take the RV outcomes which were seen in the sample 

Population = sum_of_supports( x * P[X(w) = x]

Note each prob is just the probability mass function



