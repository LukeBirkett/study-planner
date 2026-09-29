# Week 4 Notes - Moving Through the World

direct perception is way of thinking about what information is in the world and extracted without lots of neural processing

evidence this by looking at neural circuits in flys

build in direct perception in robots

#### JJ Gibson

optic flows in trainee pilots

pattern of flow on the retina

direction perception

invariant - properties of sensory input that are always true 

afforadances - 

resonance - brain is tunes to resonate with particular environmental pattersns

our visual system is wired up to efficently extract optic flow information

#### the fly

a gibsonian animal

large neurons

flys have wide field eyes where each pannel is processed as a pixel/input

retina > eletrical pulse

lamina > edge deteiction, normailsation, still just pixels

medulla > location motion detection, more interesting computations, comporared to neighbouring "pixels"

lobula > extract global patterns

a flying needs to deteect local and global information

but the global is most important

the flys big neurons are in the lobula

there are certain neurons that fire in responses to optic flows that represent undesirable body positions when flying, i.e. tells a fly to adjust

these patterns are matched automatrically, without thought

this is situatedness: ecological tuning of matched filters

tuned to the details of the environment 

rotation caused a really strong signal 

a strategy of determining the structure of the world via direct perception via minimal rotation

i.e. with humans, glaze stays fixed for periods but eyes and head can move in complex ways to determine this

#### insect inspired biorobtic case studies

optic flow based collision avoidance case studies

# case study 1 - franceschini

robot is mobile compound eye with panoramic 1d array of photodetectors

anologue measures local motion signals using correlation types emd

elementary motion detetectors

in natural it tends to be easy to copy/repeat things in a parrell

uses emds to avoid obstacles

moves at fixed speed of 50cm/s

fixed speed allows to delay eye signal and react at distance of 30cm away

#### Case Study 2 - LGMD a match filter for collision

a neuron for locusts to avoid obstables 

only fires when obst getting close

lobula giant movement detector

fires are similar time collection for different stimuli

hypo was is it a general purpose collision detector

basis is too look at how edges in the world are expanding 

paper made an NN implementation of the neuron

couldnt originally replicate locust behaviour of avoiding all collisions

turns out the locust also made the same mistakes on the dataset

the stimuli were not reflective of the locust stimuli, i.e. predactors

authors were confused as to how locusts to able to avoid eachother but avoid predators

turns out that they don't avoid other locusts

the way they avoud birds is by reacting as late as possible, particularly the beak

the NN was trying to be trained on car collisions, this has no relationship to the hard wiring of locusts neurons

cars are not the same sensory ecology as avoiding prediation

when modelling something must cosndier the stimuli and enviroment

#### task dependant vision and direct perception in humans


