# Lab 2 - Elementary Motion Detection

This labs purpose is to simulate animal behaviour and analyse the output of simulations to answer research questions. The lab starts with a working, coded system and through analysis we to understand how it works and what makes it fail. This system we are using is very complex with many paramaters, too many to explore all of them

## What are we modelling?

**Bees centering response.** When flying through a narrow space bees will naturally go in the center. But bees do not have sterospoic vision. This means that they **do not have depth perception** like we do. The suggestion is that they instead use **optic flow independently in each eye.**

Optic flow is the pattern of perseived motion on the retina/sensor when either you (the agent) or the environment is moving - think train moving.

Srinvasan et al. do an experiement on bees where they line a corridor with vertical stripes. Flying through this corrirdor with create oscilliation and therefore strong apparent motion. The authors wanted to test centering ability when the walls were manipulated. They use 6 different patterns, including where the walls themselves are also moving. 

In our system we are simulating the bee, patterns and movemements. 

## Task 1: Understanding Elementary Motion Detectors

Using optic flow, an agent can: 
- Detect motion of other agents
- Detect surrounding objects
- Detect agents own motion

The latter point of agents own motion is the focus of this lab and experiement 

How to obtain a measure of optic flow? Have spatially seperated sensors which move together. This detect stimuli and different times. This information/signals are connected to an EMD to detect optic flow. This lab used an EMD called Hassenstein-Reichardt Detector. 

### A simple EMD explained:

2 optical sensor (retinas) from an agent in motion. Sensor 1 detects stimuli first and the Sensor 2 detects the same stimuli after. If the input from Sensor 1 is delayed by the same amount time that seperates the two sensors then both signals meet a point (called the mutlipler) @ the same time. If this happens then motion can be detected via the output of the multiplier. 

Note, an EMD doesn't do anything. It just collects signals and passed on information (motion detection) onto neurons. There would be many EMDs all capturing slightly different in formation but using the same delay maching mechanism 

### Type of info an EMD Could Monitor:
- Stabilizing flight by detecting **rotation**
- Navigation by identifying objects
- Speed detectors by EMDs using different levels of delay which will fire at different speeds.
- Direction detection (forwards vs backwards)

An individual EMD will only fire when its own conditions are seen. An EMD will be very sensitive to its surroundings, speed, delay, distance between sensors and distance from objects. 

### A Superior EMD

Based on Riabinina & Phillipides, it has less chance of being fooled. A fooled EMD is one where conflicting conditions product the same output signal. Misleading output. This happens because the classic EMD depends on constrast and the core matchingoperation is mutlipcation (non=linear). This means the output is highly dependant on instensity/constrast, not just speed. Known as speed-constract ambiguitity. 

A high-contrast, low speed observation will still generate very high output. A low-contrast, high speed will product lower output. The problem is that the magnitude is ambiguous 

R&P EMD is independant of contrast. It words by normalising the inputs and computes a ratio of contrast, i.e. A high constract setting is accounted for. It therefore provides an unambigous measure of visual speed

### Steps:
1. Input(s) passed into a high pass filter
2. Sensor 1 is then passed to a low pass filter
3. Sensor 1 (H, L), Sensor 2 (H) -> Passed into mutliplier unit

### What do high pass filters do?
