# Adapative Systems (Spring 26)

This is the main file for the Machine Learning module taken in Spring 26. It will act as the location for note taking accross all mediums, i.e. lectures, videos, labs and additional readings, as well as a directory for file locations. It will recorded chronologically with a section for each week. 

TODO: module overview

# Table of Contents
1. [Week 1 - Introduction](#week-1---introduction)
2. [Week 2 - ]()
3. [Week 3 - ]()
4. [Week 4 - ]()
5. [Week 5 - ]()
6. [Week 6 - ]()
7. [Week 7 - ]()
8. [Week 8 - ]()
9. [Week 9 - ]()
10. [Week 10 - ]()
11. [Week 11 - ]()

--- 

# [Week 1 - Introduction](https://canvas.sussex.ac.uk/courses/34987/pages/week-1-introduction-to-adaptive-systems-2?module_item_id=1616848)

#### Week 1: Contents

1. [Lecture Content](#week-1-lecture-content)
2. [Seminar Content](#week-1-seminar-content)
3. [Additional Reading](#week-1-additional-reading)

## Week 1 Lecture Content

This weeks lecture is split into two half. The first half introduces the module, it covers acedemic details like the weekly sylabus, learning objectives and the assessment. The second half beings to introduce adpative systems as a topic, it introduces this notion of a closed, coupled system between an agent and its environment and how evolutionary fitness is defined by this relationship. It moves on to adpatation as a mechanism to maintian or improve fitness, as well as, delving into evolution vs learning as different methods of adapating. In addition to the lecture/slides there is a lecture summary on Canvas and a page on defining adaptive systems. 

#### Lecture Contents:

1. [Part 1 Introduction to the Module](#part-1-introduction-to-the-module)
1. [Part 2 - Introduction to Adaptive Systems](#part-2---introduction-to-adaptive-systems)
1. [Week 1 - Lecture Summary](#week-1-lecture-summary)
1. [Defining Adaptive Systems](#defining-adaptive-systems)


* [Lecture Summary](https://canvas.sussex.ac.uk/courses/34987/pages/week-1-introduction-to-adaptive-systems-2?module_item_id=1616848)
* [Defining Adaptive Systems](https://canvas.sussex.ac.uk/courses/34987/pages/defining-adaptive-systems?wrap=1)

### Part 1: Introduction to the Module

**| [File Location](825G5_Adaptive_Systems/files/week_1/week_1_lecture_introduction_to_the_module.pdf) | [Recording](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=84021c4e-5e0c-40f1-aa19-b3e101082d12) |**

Adaptive systems is extremely cross-disciplinary subject. It can be found in the sciences, engineering, artifical life, finance, politics, economics and just about anything where a system is present. 

However, there are broad to two reasons to study adpative systems:
1. From the scientific perspective in the persuit of knowledge. We want to understand and model natural adapative systems around us. 
2. The technological/engineering perspective. The ability to make artifical adative systems for our own utility, i.e. software systems and robots. 

**Why should we study natural adative systems?** Generally, natural adapative systems are superior to our own. They are smarter, more agile and more dextrous. Therefore, when building our own systems, designing them based off of naturally found formations allows us to skips a lot of leg work. Some examples are: 
* Hexapod bodies for walking systems. This is insect inspired.
* Artifical NNs which are based off of brain neurons.
* Central Pattern Generators (CPG) for locomotion

**why study the artifical ones?** Natural systems are complex and often the full information is out of reach. This articical systems we can contruct something where we have full control of the inputs and outouts. We can simulation, iterate, automate and analysis how the system works, or doesn't work. Typically, we transfer learnings from natural systems into our artifical but we may (rarely) learn something in an aritfical system that can be applied to natural systems. Finally, artifical systems are modular and accessible, we can easily pickup or incorporate someone else work into our own. 

**<u>Module Structure:</u>**

* 10 lecture topics with one addition session for spill over. 
* 5 labs where we apply theories into coded, simulated systems.
* 6 seminars where discussions of adapative system theory and report writing takes place. 

1. An Introduction to Adaptive Systems
2. System Theory
3. Cybernetics and the Importance of Negative Feedback
4. Postive Feedback: Stigmergy and Chaos
5. Ashby Part 1: State-Determined Systems
6. Ashby Part 2: Ultrastable Systems
7. Sensorimotor Systems
8. Evolution and Evolutionary Robotics
9. Self-Organising Systems
10. Living Systems

**<u>Assessments:</u>**
1. 1000 word report, little bit of code, basic experiment, due week 8, worth 20%, consider a practice run
2. 3000 word report, a lot of coding required and in-depth experiements/analysis

Both need to be respresentive of an adaptive system with some sort of learning or evolution. Often includes some sort of agent application. 

There are 3 main directions for the assessments:
3 main directions for assessments:
1. Scientific: e.g. Simulating and analysing a model of a biological adpative system. Common topics are neuroscience, animal behaviour, ant behaviour.
2. Engineering: e.g. designing, implementing and testing your own adaptive system. You still collect results and test how well 
3. Artifical Life: Investigating and explaining theoretical adaptive systems. 

### Part 2: - Introduction to Adaptive Systems

**| [File Location](825G5_Adaptive_Systems/files/week_1/week_1_lecture_introduction_to_adpative_systems.pdf) | [Recording](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=84021c4e-5e0c-40f1-aa19-b3e101082d12) |**

[LEARNING OUTCOMES, Slides + Recording]

**[systems and their environments]**

coupled systems, where agents and envs effect eachother. causual relationshops [import slide image]

system/agent coupled to its enviroment

the arrow in the image respresnets a kind of interaction

image is very high level and basic

arrows in both dirs = circular causality

sys influences env, which influences sys, vv

closed loops more interesting than open loops (why, rewatch this section)

**[the fitt-est]**

survival of the fittest

darwin, how well species were fitted to their env

evolutionionary fittness is a two way relationship between a population and its environment

speciies fitness is intristicly linked to the env it is in. if env changes fitness changes. what charactistics suit or perform (or lack there of) in given env

fitness does not mean physical fitness, speed, strength etc

progress in the natural world doesnt mean bigger, better, more complex

humans are an exception

progress genrally meeans more suited to env

the idea of progress applies more to actifical than to natural evolution

there are examples in nature that would be anti-progress in terms of bigger, better, more complex

stickles backs over time became less armoured from preds as their env didn't require it anymore (reverse evolution)

evoultion has a trade off. more armour requires more resources. resources are limited

fit means surviving and thriving. if something becomes more simple but still sruves then it is just as fit

fittness can easily go down when env changes

**[maintaining a good fit]**

sucessful sys fit well into their envs

often then sys adapt they do so in order to maintain a good fit to the env

bateson "the unit of survival is a flexible organism in its env"

also said that envs must also be flexible 

flexible can be exchanged for capable of adaptiing

coupled sys of agent and env can both change to fit changes in the other

**[timescales]**

[slides covered a bit on learning vs evolution]

the ability to learn

however, rate of evolution depends on rate of reproduction. bacteria very fast

**[time]**

time is. repeating compoenent of this module

today main interest is rate of change and relative rate of change

i.e. rate of change of eco system 

rate of change of evolution. takes generates so may not be quick enough to track env changes. this results in a loss of fitness and risk of non-survival

**[why do systems adapt]**

to learn, 
* a behaviour or action 
* how to solve a problem
* to compensate for injury or damage
* to adpat to changes in the environment

### Week 1 Lecture Summary

### Defining Adaptive Systems


## Week 1 Seminar Content

## Week 1 Additional Reading
