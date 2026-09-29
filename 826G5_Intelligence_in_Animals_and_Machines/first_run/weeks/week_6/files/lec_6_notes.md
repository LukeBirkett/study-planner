# Lecture 6 - Motor Control

## Motor Control Problem

### Forward Kinematics

Start to end moving instructions and coordinate

fix all joints at specific values, where is the hand?

Easier to work out

### Inverse Kinematrics

Arm hanging loose and want to pick coffee up

There is an infinaite number of paths, speeds, solutions, etc

Very hard mathematically

Dynamic problem

Solution chosen will depend on goal, i.e. speed, effic, accuracy

Redunant in this topic means there is multiple ways of doing something

There are redundant ways to get to campus

Travelling to Aus is not redundant, you have to fly

### Problem 1: Redundancy

If you freeze all joints and only move the hand, the position is described by only 3 variables

But if you include arm and body there are many more degrees of freedom

Same hand position can have many diff combination of arms and body positions

This problem is underdetermined and system is redundant

Given the position of the hand you cannot work out the position of the body

### Problem 2: Delays

Delays in neural circuits

### Problem 3: Noise in the nervous system

Non-deterministic influences

Much of neuro-sciences is probalistic

### Problem 4: Non-Linearities

noise is exacerbated because relationship betbetween motor and movmenet depends in a non-linear way on other factors

This makes the inverse problem much more compex

e.g. muscle activity % changes depend on load. for every 10kg a disproporationate % of muscle activiations are needed

### Problem 5: Non-Stationarity

Parameters and problem are always changing

older/grow/stronger/tired/injury

can be quick (injury) or slow (older)


# Simplifying the Motor Control Problem

### Passive Dynamic Walkers

Use morphology of the body and gravity to walk with no motors down slodes

### Motor Invariants 

Syneries when joints coordinate 

Makes it easier to control by "functionally freezing degrees of freedom" 

e.g. imagine a car where each wheel could be steer individually. would be much hard. more degrees of freedom

synergies are dynamic and can be turned on/off when required

### Dynamic Stability

movement is a dynmaic inexact process

human locomation is a dynamic movement that we are constanstly correcting for

if we didnt move out legs, our body is leaning forward and would fall

success by correcting for mistakes and discrepencies

doesnt need to be precise, just a general idea what to do and correct for the obstacles that come up when trying to get there









