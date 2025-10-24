# Week 4 - Futher text classification - Notes

This week is the ML approach
 - Some probability theory
 - Naive Bayes Classifiation

Goal is to assigned probabilities to classes/tokens

 - Marginal Probability: P(b)
 - Joint Probability: P(a,b)
 - Conditional Probability: outcome, prob a given b
 - Bayes Law

cond = joint/marginal

for indep events:
	P(a,b) = P(a)*P(b)

i.e. flipping two coins in succession

otherwise, p(a|b)*p(b)

an assumption for naive bayes is to assume independance to allow for simplicity

Naive Bayes Classifation flow:
bayes rules > ignore denominatior > aapply joint prob simiplictation?

why ignore demonominator? it is the same for all calcs, hence, is just a scaling factor. we just want to the hightest

removing the demoninator means we don't get the offical probablilty but ththat is not what we want, just want the argmax

argmaxP(c|fn) = argmax p(fn|c)*p(c) / p(fn)

drop fn and assump

argmax p(c|fn) =(approx) argmax sum(pf|c) * p(c)

params of NB:
- proir P(c)
- class conditional P(f|c)

calc the prior: percentage of a class over the total number of observations

easy to calculate

P(c) = {i|label} = c / k

k = all obs
c = class

think of it as class priors

#### add-one smooth

we don't want anything to come out as impossible due to our sample

this is treated by the add one method where you add 1 to all class counts

if 0 == 1

if 1 == 2


