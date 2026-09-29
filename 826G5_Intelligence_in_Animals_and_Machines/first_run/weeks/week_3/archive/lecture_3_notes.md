# Lecture 3 Notes - Collective Intelligence

self organisation has a big focus on local and global aspects

local is what an individual and agents can interactive with right now

global is wider information from a variety of perspects 

global behaviour is the wider pattern that emerges from local behaviour and actions

swarming and flocking is a well known type of collective behaviour

the fish or birds do not know they are in a flock

they are just responding and relacting to local information

alts to self-org? a researcher in a 1930s thought it was due to transfer of thoughts

craig reynolds (1986) boids

first research breaking down how flocks is possible

idea is that it must be self-organisation, otherwise the alternative is that there are certain birds leading the pack

bois are simple flying agents and they all have a very simple set of behaviour rules

local rule 1: seperation, avoid hitting
local rule 2: allignment, follow neighbours
local rule 3: cohension, if too far away from neigh then move towards

these rules restuls in naturalistic, flocking behaviour 

its said that reyonolds hypo was not correct (3 rules)

they instead do it in a topological way

they pay attention to approve the closest 6 birds and align with them 

an experiement proved this by introducing a predator

with reynolds metric approach, the flock more often fragmented which is not the behaviour of a flock

where as topological was more likely to stay togeher

the rules of nearest 6 were more robust


experiment > model > test

#### stigmergy

pierre-paul grasse coined when studying termintes

realted to outsource things to the enviroment

i.e. a todo list is external environment

reduces our cogniative load

stigmergic act

postivie feedback loops are a common characterics of self-organising systems

another classic stugmeric behaviour is pheromone trails

pheromones attarct more ants, more ants increases the pheromene strength

this is a pos feedback loop

ants will all end up on the same path due to this

the route that wins appears to be a high-level intelligence pattern

but no ant knows that one route is better than another

it is the collective that makes the decision

the shortest route will build up the more powerful pheremone route and it will win

there is no decision processes

act colonoy optimisation (aco) algorithms

pheremone trails are decentalised control systems

local rules rather than top down control

# honey bee swarms

why we look as social insects? success in evo terms is the queen prodcuing more sibiliings. there is no competition, all ants are working towards the same goal. unlike humans who can be selfish. hence they are optimised 

swarm is temp home

send out scouts

on return the bees dance to share direction of information of potential new home

scout bees will respond to the dance and check out the location

if the location is agreed to be good then they will dance too

this is where the positive feedback loop comes in 

over time if the location is really good many bees will vist and many bees will dance to say it is good

bees who like it will continue to visit back and fourth

if many bees are at the location then this data tells the bees perceive as a decision of a good location

# benefits of collective behaviour

self-organisingm, no leader or central organiser

scalable, num of members can change

flexible, ccollect takes into account env and social context

fault tol, no single point of failure

for decision making:
- explore many options and collect evidence, report and vote independently
- give up on options with weak evidence through decay
- robust to indiviudal opinion, requires many/several individuals to approve a decision

# Humans

## Collective Movement in Humans

informed individuals can drive behaviour in large groups

experienments around group voting, i.e. how many marbles in a jar

cumlative votes tend to be good

bad votes get averaged out

doesn't always work through

some tasks are better for individual experts, others are better for collective reasoning

## Collective Behaviour in Machines

swarm robotics

dorigo et al 2005 swarm-bots

reasons for swarm robotics
- for science, modelling observation loop, i.e. boids and follow up experiements. simulations

- for engingerring, to achieve an outcome

swarms have fault toldernece, if one fails the task doesn't stop

scability, more robots may do a task fasts or cheaper

flexibility, perform different tasks in parrell

collective behaviour can acheive things that a single unit cant


