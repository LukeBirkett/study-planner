# Lab 3, 4 & Assignment Prep

Focus on lab house hunting derived from Robinsons Work:
- [A Simple Threshold Rule Is Sufficient to Explain Sophisticated Collective Decision-Making (Robinson et al. 2011)](https://canvas.sussex.ac.uk/courses/34991/files/5740841?wrap=1)
- [Paper's supplementary info](https://canvas.sussex.ac.uk/courses/34991/files/5740842?wrap=1)
- [How collective comparisons emerge without individual comparisons of the options (Robinson et al. 2014](https://canvas.sussex.ac.uk/courses/34991/files/5740820?wrap=1)

# Lab 3: Monte Carlo simulation of collective behaviour

Lab 3 goes thourgh the code which will be the same code for the assessment. The tasks explored may be used for assignment topics.

#### Resources to Work Through
- Lab Page: Intro, Setup, Model, Tasks
- Lab PDF: Code details TODO: LINK
- Lab Additonal: More code details TODO: LINK

## Introduction

The purpose of this lab is to get an introduction into Biological Modelling. 

We can explore whether an experiements outcomes can be explained using the threshold rule. 

Another purpose is to gain a technical understanding on how to use Monte-Carlo modelling. 

Begin testing models and explore how results varying with respect to changes in different parameters, i.e. parameter sensitivity. 

We can choose to use this style of modelling in our assignment so extending an investigation from the lan may form the basis of project.

Overall, we want to investigate how a model is implementing. If it meets out expecations and is plausible.

May choose to remove elemetns or add more capabilities.

The idea is probe and stress test the assumptions and investigate results to seem odd and to not follow intuition.

The correct methodology to be able to explain why a certain peice of informaiton occurs after a parameter change occurs.

The code provides us a tool to look at ant behaviour. It is our job to explain the aggregate behaviours and how many parameter changes relate to such. 

### Origins of the Code

Robinson et al. included MATLAB code for simulating their module in the supplementary information for their paper. The lecturer updated their code for use on this module, making two important additions:
- He added a limit to the number of steps the simulation will run for. This precludes the possibility of the simulation loop continuing to run indefinitely in the case where an ant does not select a nest site.
- For students' convenience, he added code to save simulation data to an Excel file, to make analysis easier.

In recent years, students have increasingly tended to prefer Python over other programming languages, so last year the university ported the simulation to Python. In the interests of continuity, I made the Python code as similar as possible to the lecturers MATLAB code.

## Setting Up

Execute the file by running `ExampleUsingRobinsonCode.py`

`enter` to iterate through steps within a simualtion

`1` to complete an ants route

There will be 2 graphical outputs:

### Ant x Route

TODO: image output

a. site {0, 1, 2} x num steps
b. site x time

Each walk has a threshold and perceived quality metric when a site is reached 

A site can be assessed mutliple times

### Summary Graphic 

TODO: image output

Aggregate steps for all ants 

1. num ants x chosen site
2. num ants x time till dec
3. mean time x site
4. mean num visits x site

### Excel Dump

TODO: example output of excel

This has no quality related data, just raw paths, sites and times

1 row for each ant

ant number # 

threshold (varies per ant)

final site

selected (all 1's?) deicison made?

end time

time site 0 discovered (all -1 = start point?)

time site 1 discovered

time site 2 discovered

visits to site 0

visits to site 1

visits to site 2

an array of the path taken (shows that if not at 1 or 2 then the site = 0, would imply site 0 is interpretted by the system as no site, i.e. travelling, just somewhere)

## The Model 

