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

## Week 1 Lecture Content

This weeks lecture is split into two half. The first half introduces the module, it covers acedemic details like the weekly sylabus, learning objectives and the assessment. The second half beings to introduce adpative systems as a topic, it introduces this notion of a closed, coupled system between an agent and its environment and how evolutionary fitness is defined by this relationship. It moves on to adpatation as a mechanism to maintian or improve fitness, as well as, delving into evolution vs learning as different methods of adapating. In addition to the lecture/slides there is a lecture summary on Canvas and a page on defining adaptive systems. 

#### Lecture Contents:

1. [Part 1 - Introduction to the Module](#part-1-introduction-to-the-module)
2. [Part 2 - Introduction to Adaptive Systems](#part-2---introduction-to-adaptive-systems)
3. [Defining Adaptive Systems](#defining-adaptive-systems)
4. [Lecture Summary](#week-1-lecture-summary)

### Part 1: Introduction to the Module

**| [File Location](825G5_Adaptive_Systems/files/week_1/week_1_lecture_introduction_to_the_module.pdf) | [Recording](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=84021c4e-5e0c-40f1-aa19-b3e101082d12) |**

Adaptive systems is extremely cross-disciplinary subject. It can be found in the sciences, engineering, artifical life, finance, politics, economics and just about anything where a system is present. However, there are broad to two reasons to study adpative systems: 
* From the scientific perspective in the persuit of knowledge. We want to understand and model natural adapative systems around us. 
* The technological/engineering perspective. The ability to make artifical adative systems for our own utility, i.e. software systems and robots. 

**Why should we study natural adative systems?** 

Generally, natural adapative systems are superior to our own. They are smarter, more agile and more dextrous. Therefore, when building our own systems, designing them based off of naturally found formations allows us to skips a lot of leg work. Some examples are: 
* Hexapod bodies for walking systems. This is insect inspired.
* Artifical NNs which are based off of brain neurons.
* Central Pattern Generators (CPG) for locomotion

**Why study the artifical ones?** Natural systems are complex and often the full information is out of reach. With articical systems we can contruct something where we have full control of the inputs and outouts. We can simulate, iterate, automate and analyse how the system works, or doesn't work. Typically, we transfer learnings from natural systems into artifical but we may (rarely) learn something in an aritfical system that can be applied to natural systems. Finally, artifical systems are modular and accessible, we can easily pickup or incorporate someone else work into our own. 

**<u>Module Structure:</u>**

10 lecture topics with one addition session for spill over. 
5 labs where we apply theories into coded, simulated systems. 6 seminars where discussions of adapative system theory and report writing takes place. 

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

**| [File Location](/Users/lukebirkett/Repos/study-planner/825G5_Adaptive_Systems/files/week_1/week_1_lecture_introduction_to_the_module.pdf) | [Recording](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=84021c4e-5e0c-40f1-aa19-b3e101082d12) |**

1. Systems and their environments
2. Timescales and relative rates of change 
3. Adaptation can be driven in many ways
4. “Adaptation” can mean either a process or a characteristic
5. Processes of adaptation take place over various timescales
6. All adaptation involves change, but not all change is adaptation

### <u> Systems and Their Environments </u>

We can often think of systems a being coupled whereby an agent(s) and environment impact one another. There is circular causality that flows to and from each agent and enviroment. Because the flows are circular, an agent can essentially have an effect on itself. It changes the env, which changes itself, and so on. 


Llosed loops are generally more interesting than open loops. They can do much more compelx things than open loops. Open loops are characteristed as systems with inflows and/or outflows. A feedforward network is an input and output system. They can do useful things but they don't have the same dynamics and closed systems. 

### <u> The fitt-est </u>

"Survival of the fittest", not actually first written by Dariwn but largely attributed. Actually written by Spencer. In first edition, Darwin wrote about how well species were fitted to their env. Fitted, a fitness as a specific term here. They do not mean the physical fitness is a muscular or cardiovascual sense, instead we mean evolutionary fitness which is a two-way relationshp between a populaiton and its environment. 

A species fitness is intrisinctly linked to the environment that it is currently in. If the env changes then so does the fitness because it is placed into a new context. 

Therefore, progress in the naturual world does not mean better, better, more complex. It means an improved fit to an environment. The idea of "progress" applies more to artificial than to natural evolution. There are many example in nature that would be "anti-progress" in terms of bigger, better, more complex.

e.g. sticlebacks over time became less armound from predators as their new envs didn't require it (possibly observed as reverse evolution). Revolution has a trade-off, more armour requires more resources. But resources of life are limited. If something can become more simple but still survive or thrive just the same then the fittness is the same. Additionally, fitness can easily go down when an env changes. It could be argued that an over armour fish is less fit because this armour comes with disadvantages.

### <u> Maintaining a Good Fit </u>

Successful systems fit well into their environemnt. A system can meant an agent, or just about anything. Often the system will adpat to maintain a good fit to an env. 

Successes or fitness is completed dependent on the context and system. Though for living systems it is generally survival. The great thing about artificial systems, or man man, is that we define these terms. 

Bateson: "the unit of survival is a flexible organism in its env". Flexible can be substituted for "capable of adapting". Coupled sys of agent and env can both change to fit changes in the other

### <u> Timescales </u>

This slide covered the notion of learning vs evoluaiton. Learning is what humans, or agents, do and aquire in their lifetime. Evolution is was changes over many lifetimes. Evolution, or atleast the perception of evolution, is often dependent on the rate of reproduction. Bacteria can evolve very fast in human life terms. 

### <u> Time </u>

Time is a repeating concept in the module. Today's main interest is "rates of changes" and "relative rates of change". 

e.g. rate of change of ecosystems. Global temperature changes compared to previous periods in time. 

Consdier the rate of change of evolution which takes many generations so may not be quick enough to keep track with ecosystem evn changes. This results in a loss of fitness and risk of non-survival

### <u> Why do Systems Adapt? </u>

To learn:
* a behaviour or action 
* how to solve a problem
* to compensate for injury or damage
* to adapt to changes in the environment

Ens are dynamic, i.e. constantly chaning, therefore unpredictable. Slow changes in environment may be adpated to by a process evolution. 

* Slow changes in enviroment may be adapted to by a process of evolution
* Faster changes and other suprises may be adpated to by learn 
* Very fact changes may be adjusted to by a process of regultions and control (which are not necessarily processes of adaption)

### Problematic Terminology

Often key concepts and words in adaptive systems have mutliple defintions. 

Defining evolution thorugh natural selection: 
* Adpatation is a central concept in biology. The word has two related meanings
1. Adaption means the evolutionary process by which, over the course of generations, organisms are altered to become improved with respect to features that affect survival or reproduction. 
2. An adpations is a characteristic of an organism that evolved by natural selection. 

Sometimes "an adapativtion" is referred to as an "adaptive trait". This causes a similar problem because when we refer to an adpative system we mean one which can adapt itself through some adaptive process; a self-adpative system. 

### Adaptation (as a process)

Examples: 
* learning in humans
* learning in aritifical neural networkds
* evolution through naturual selection

With these, there is a a mechanism which is searching for "good", or optimal. The change (adaptation) must be directied somehow. Though not all change is adaptation. 

### Adapative Traits (an adaptation)

Speed is an adv for predators and prey. Animals have adapted to be fast. A cheetah has mutli adapative traits which synergistically contribute to its speed. 

### Adpated vs Self-Adative

An adpated system, is something which is adapted by some other system or external processes - such as an evolutionary algo - to have some desirable for beneficial characteristics.
* eco-system and natural selection
* simulated env and genetic algo

> Possibly important for my idea. The environment will be a self-adpaptive system. But the farming system will be an adapted system will can be tweaked and optimized based on some metric. 

A self-adaptive system is something that has the ability to adaptive itself:
* by learning
* by changing its body through reconfiguration

On this model we are principally interesedf in:
* The self-adaptive systems which adapt themselves
* As well as the systems and proccess which can adapt other systems. 

Often our studied systems will be will be both both adpated and self-adaptive

### Not all Change is Adaption - Evolution

A process of adaptation always involves change but not all changes are adaptaiton. Genetric mutations are random but over many gnereations mutations which make organisms less likely (or more) are selected for or against. 

### Not all Change is Adaption - Learning

Like evolution, learning also must be directed by rules or algos to acheived desireable or effective results

Hebb's rule; neurons which fire together, wire together

### Summary

* An adaptation is a characteristic of a system, which is the result of a process

* But adaptation can also mean the process by which a system is adapted

* We can distinguish between systems which are self-adaptive, which means that they can adapt themselves (a process), and systems which  are adapted by other systems or external processes
• I use self-adaptive here to distinguish from adaptive, which is often 
used otherwise, e.g. in “adaptive traits” or “adaptive behaviour”
• While all processes of adaptation involve change, not all change is 
adaptation - only changes which are selected or directed according to 
some set of rules or laws can lead to adaptation
• Adaptive processes can be driven in many ways, but often the change 
involved in a system’s adaptation is prompted by changes in its 
environment
• Which kinds of adaptive processes (if any) are effective in a given 
situation or environment is determined by relative rates of change


### Week 1 Lecture Summary

[Lecture Summary](https://canvas.sussex.ac.uk/courses/34987/pages/week-1-introduction-to-adaptive-systems-2?module_item_id=1616848)

### Defining Adaptive Systems

* [Defining Adaptive Systems](https://canvas.sussex.ac.uk/courses/34987/pages/defining-adaptive-systems?wrap=1)


<br>
<br>
<br>
<br>
<br>


# [Week 2 - Systems](https://canvas.sussex.ac.uk/courses/34987/pages/week-2-systems-2?module_item_id=1617677)

#### Week 2: Contents

https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=57984111-19fc-4644-b989-b3e80107efb8



## Week 2 Lecture Content

In this lecture, we cover some basic systems theory language and concepts. Some of you may already be very familiar with these concepts, and therefore find this a very simple lecture, but that won't be the case for everyone. For this lecture, our main objective is to make sure we all know and can use the same ways of describing systems, in a non-technical way. We will start to look at more technical material on systems in later lectures, in particular in the ones related to Cybernetics.

[week 2 intro](https://canvas.sussex.ac.uk/courses/34987/pages/week-2-systems-2?module_item_id=1617677)


Learning Outcomes:
* Systems are connected sets of elements
* Systems are made up of systems 
* A systems environment is also a system 
* Systems are usuallty open, but we can model them as if they were closed. 


Lecture Outline:
1. Why use a systems approach?
2. A defintion of a system
3. Casual Connections
4. Systems and their ennvironments
5. Subsystems and supersystems
6. Overlapping systems
7. Open and closed systems

### Why use a systems approach?

The systems approach is holistic: we study whole systems. This is in constract to reductionism where people try to go down to the lowest mechanisms of a system and work those parts out. 

In order to model systems we must use abstraction to make this possible as they are too fine grained and complex. i.e. a system of human but not going down to the molecurlar level. 

The systems approach is cross-discipline. Often applies to business and finance, but also politics, biology, engineering. 

### An informal definition of a system

> “A set of elements or parts that is coherently organized and interconnected in a pattern or structure that produces a characteristic set of behaviors, often classified as its ‘function’ or ‘purpose’.” (Meadows)

**A set of elements or parts;** i.e. a robot system which is made up of parts; once set up they are all connected; Could talk about an animal and considered the organs as parts;

**organized and interconnected in a pattern of structure:** think about the arrows in a diagram, without the arrows it is not a connected system; 

**produces a characteristic set of behaviours;** we characterise systems by their output behaviours; external (that we see) or internal behaviour; 

**function or 'purpose';** fuction of an object may be what it was designed for; or it hasevolutes to

### Causal Connection

Arrows in diagrams; system elements are casually connected; can transfer: info, energy, matter; or a combo

### Systems and their environments

Definiiton systems by parititions; define a system by its boundary; where is the boundary between the thing and not thing; agents and env; a coupled agents, env relationship can be draw wit the agents embedded in the env; we may also differentitate between an agents immediate env and the whole environment. 

The agents, env coupled system is a closed loop or circular causality, where each subsystem has an effect on the other. 

### Systems and Their Parameters

Often, the pwower of a system to adapt will lie in its parameters
* Why do want to adapt the system?
* When do we want to adapt the system? Maybe upto a certain point of performence, maybe its a system that learns continuously. could be intermitted, i.e. there is a threshold to meet, if it is in the threshold is doesn't change, if it does then parameters can change to re-adapt. 
* How should we adjust the parameters?

### Subsystems

Zooming in on a system; an element in a system is often also a system itself; example a nn, is composed of layers, which are their own systems; 





# week 3

https://canvas.sussex.ac.uk/courses/34987/pages/week-3-cybernetics-and-negative-feedback-control?module_item_id=1619230


https://canvas.sussex.ac.uk/courses/34987/pages/cybernetics-resources



https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=89d90ed0-dd78-4e4f-99c3-b3ef0107dec0

https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=d7255e26-bf02-4d46-9cf9-b3f001039adb


everything of interest to us on this module was influenced by cybernetics

feedback is everything in all intelligent systems

lecture outline:
* cybernetics before cybernetics
* important of feedback
* macy meetings
* cybernetics is names
* cybernetics original of artifical neural networks
* other cyberneticians 

what did cyb lead to; ai, robotics; control theory; systems thinking; neural networkds; genetic algos; ultrastablity; autopoiesis;

father of cybernetics; norbert wiener; 

cybernetics before cybernetics; war weapons; anti-aircraft, radar, connected radar and weapon into 1 system; these feedback mechanisms also applied to nervious systems; realised these systems are common in natural world

paper: behaviour, purpose and teleology; behaviouristic account of what it means for something to have a purpose; "all goal-directed (purpose) behaviour may be considered to require negative feedback"; the system is working towards some goal; "uniform behaviouristic analysis is applicable to both machines and living organisms, regardless of the complexity ofg the behaviour"; 


2nd part

learning outcomes:
* basic principle of negative feedback control 
* negative feedback leads to stability
* stability without control 
* delays in feedback loops


metapors, or analogies; similar concepts in eng lang; analogies more useful in science; analogue electrons, derived from analogies; this is due to the relationships with anologes; dampener takes fraction out of the systeml; isomorpoism, two systems to produce the same outputs; this is the strongest type of an analogy; we dont always have perfect isomorhism between systems; think about bio objects and physical object (both are system); if they are isomorphic, then we can use experiements on the phyiscal system to say things about the biological thing; use robot as a model of an animal; 



stable and unstable equilibria; points where the system can balance; unstable will only balance if undisturbed, small changes will push it off; stable eq, these points behave v different, still remain if no change, but changes will remove it from the balance but it will return; could thinkg of it as a pendulum, pend up in unstable eq, pend down in stable eq; friciton/grav will always cause the pend to hand down; possible to turn an unstable eq to stable using a neg feedback loop; this is how humans stand up; we balance our body upright; 

cyberntic loops; weiner and co, importance of feedback; systems with feedback, elelemtsa are connected; cybers called this circular causality; 

negative feedback control; controlled system or proccess is often refered to as the plant; could be the movement of an arm, output of a factory, tradjectory of a ship; output from the plant is the controlled variable; ref signal r specifices the desired plant output, 0, the goal of the sys is to make o = r; 0 will often be variable or a pattern rather than a single value; if we take out the sensor loop then we just have a feedforward, there is no way to check that r = o; to way to acvheive control; the actual output is what is fed back to the controller so that the controller acts on the error e; e is the difference between desired and actual outputs; no sensor is perfect, there will be noise in reading the output; also there is delays in the feedback from output, sensor to controller; human acturately steeering a car based on trajecory is another type of feedback loop (DIAGRAM); controller only ever doers somrthing if the error >0, if 0 the calc is 0 so no output change;

INSERT NEG FEEDBACK CONTROL DIAGRAM

example; r = 10 and k controoler gain = 0.1

at time t=0 output o=0

in everytime step we calc 

e = r - o 
c = ke 
ot_1 = ot + ct

no noise or delay in this system

after some number of steps o ~ r, e ~ c ~ 0

variying init condition; start paramets from diff places; system should still stabilise in the same way

the very simple feedback control system that we have seen is capable of controlling or regulating system; but this is reactive not self-adaptive; does not monitor its own perforamnce; if a constrol systems params are not set correctly, it may performance badly; self-adpative systems have more than one feedback loops; at least 1 to monitor performance; 


problems with delays;there will alaways be some delay; delay causes two probs; 
* errror delay means there is some period of time where the process is in error before the controller does something; a
* a dleay in the feedback path means that the controller is always working with out of date information, and negative feedback may even turn into positive feedback


stability without control; many systems tend towards stability without control; a cample, a cup of coffee, cooling = t_c = -k(t_c = t_r); this system/equation is isomorphic to a negative feedback system; eventully t_c and t_r are the same and nothing happens

In control theoretic terms, the rooms temperature is analogous to the reference signal, and the temperature of the cup is analogous to the controlled variable
* moving away from describing physics and toward describing information flow
* In a designed control system (like a thermostat or a self-driving car), the Reference Signal is the "target" or "setpoint" provided by the user. It is the state the system should be in.
* The Room Temperature ($T_r$) acts as this dial. Because of the laws of thermodynamics, the coffee "wants" to reach the room's temperature. The room effectively "tells" the coffee what its final temperature will be.
* The Controlled Variable (also called the Process Variable) is the actual state of the system that we are measuring and trying to change. This is the Temperature of the Cup ($T_c$). It is the "output" of the system. It changes over time based on the physics of the situation.
* In a standard control system, you usually need a Controller (a computer or a person) to look at the difference between these two and decide what to do. In this "Stability without Control" example, the "Controller" is Nature.
* 

--- 

> This slide is a classic introduction to how physical processes naturally mimic control systems—specifically, a first-order linear system behaving through negative feedback.

> $$\dot{T_c} = -k(T_c - T_r)$$

* $T_c$: Temperature of the coffee (the state or controlled variable).
* $\dot{T_c}$: The rate of change of the coffee's temperature over time.
* $T_r$: Temperature of the room (the reference or setpoint).
* $k$: The thermal coupling constant (the gain).

> The negative sign is the most important part. It ensures that if the coffee is hotter than the room $(T_c > T_r)$, the rate of change is negative (it cools down). If the coffee is colder, it heats up. This is the definition of stability.

> The block diagram on the right maps this physical process into the language of cybernetics and adaptive systems:
> * The Error Signal ($\Sigma$): The summing junction calculates $T_r - T_c$. In control terms, this is the "error" between where the system is and where it "wants" to be.
> * The Gain ($k$): This represents how "aggressively" the system reacts to that error. A thick ceramic mug has a low $k$; a metal spoon in the cup might increase $k$.
> * The Integrator ($\int$): This is the physics of the cup itself. Accumulating the rate of change ($\dot{T_c}$) over time results in the actual temperature ($T_c$).

> 3. Why it's called "Stability without Control"
> This is the "aha!" moment for your module. Usually, we think of "control" as something an engineer adds (like a thermostat or a cruise control chip).

> However, this system is inherently stable because of its natural properties. There is no computer chip "deciding" to cool the coffee; the physics of the temperature gradient creates a feedback loop that forces the system toward an equilibrium ($T_c = T_r$).

> 1. The Passive Stable System (The Coffee Cup)A passive system like the one in your slide has fixed parameters.The gain ($k$) is determined by the physical properties of the mug and the liquid.It doesn't "learn" or change its behavior if the environment changes drastically.If you move the coffee to a windy room, the value of $k$ might change due to physics (convection), but the system itself isn't monitoring its performance and tuning $k$ to reach equilibrium faster.

> 2. The Adaptive System (The "Smart" Heater)An adaptive system is a "system of systems." It features a secondary loop (often called an adaptation mechanism or a parameter estimator) that monitors the primary feedback loop.Primary Loop: Maintains the temperature (like the coffee cup).Secondary Loop: Observes the error signal. If the error isn't shrinking fast enough, the secondary loop changes the parameters (like the gain $k$) of the primary loop in real-time.

---

When the rate of change of a variable is a function of that variable, then you have feedback, i.e. $\dot{T_c} = -k(T_c - T_r)$, t_c is on both sides. t_c is a function of t_c


# Summary

1. Systems with loops in their interconnections have feedback, or  circular causality
2. Negative feedback tends to lead to stability
3. Some systems are naturally stable, or self-stable
4. In control, negative feedback can be used to turn unstable points in a system’s dynamics into stable points
    * we saw that feedback control system matmmatically  may be isomorphic to a self stable system.
    * this may be an insight as to what feedback control is for. to turn an unstable system into a stable one
5. Although negative feedback tends to lead to stability, delays in  feedback loops can cause problems
6. Systems which are self-stable may be mathematically equivalent  to feedback-controlled systems! (or vice versa, e.g. see point 4)
7. Self-adaptive systems have multiple feedback loops
    * feedback loop to monitor the performence











# week 4

[Lecture Video](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=acbe3aed-b38f-4d7a-9613-b3f601088a6f)

[Robotics Resources](https://canvas.sussex.ac.uk/courses/34987/pages/robotics-resources?wrap=1)

[Weekly Page with Reading Content](https://canvas.sussex.ac.uk/courses/34987/pages/week-4-sensorimotor-behaviour-2?module_item_id=1620203)

[Braintenberg Pages to read]()

# part 1 - braitenberg vechicles

Learning Outcomes/Main Points:
* The sensorimotor loop: new, diff kind of feedback loop which cant be characterised as pos or neg; living agents,  robots, agents that act in a physical or sim phys world, all obs extranl behaviour is sensiormotor
* braitenburg becicles: a thought exper with simple sensori motor systems (lab to follow)

# agents

software; angent-based model of complex systems

this lecture focuses on sensorimotor agents

types; artificial, organism, robot; can be similuated or real. model focuses on simulated, real not really practical for module

agents are systems which act in and on their environment

most of the systems in this module are agents

# sensormotor agents 

agents are systems which acts in and on their environment

they are coupled to their env

most simple agent has a sens, controller, motor which enables them to ineracts, and potentially maniplite, their env

# braitenberg

book, Vehicles, describes a series of thought experiements involving mobile agents we might call them animats

doesnt refer to robots at all

# black box

bb arised from electrical engineering

concept, ee studing a system, no idea what happens in bb, measure inputs and output and infer what might have been happening in the box; not ideal approach as you cant scope down into how

# differential drive

braiten veh have differential drives

diff drive robot is aheeel robot where each wheel has its own motor

because it has diff motors they can drive at diff speeds

if same speed then it will go forward

if left more than right, then it will turn right. 

magnute of diff makes turn more sharp

if one wheel not moving then circle. turn on the spot without changing position

# braitenberg vehicles

we connect their motors to light sensors, either directly or through very simple controlers

different types of model behaviour:
* aggressor; hates light, wants to destroy, this is acheived by setting up the diff drive in a certain way. the left wheel is set up the right sensor, and the right wheel to the left sense. if the light is closer to the left, then the right wheel goes faster, this gives the impress of the robot chasing and going towards the light. it appears aggressive
* cowards; make the connections direct, left sens, left wheel, etc. this is gives the impression of running away from the light. 
* lover; insread of having pos connections, the sensors are set to neg; still direct connections, but as it gets closer to the light, it slows down and eveutally stops. it wants to be near the light, hence lover. basking near the light course. 

these are sensorimotor loop robots and even through the connections and rules are very basic, the cumuliative behaviour infer something much more complex. for example, a robot which loves the sun and wants to bath in it. 

braitne imagines how we might percieve these behaviours if the vehcicles were black B and we didn't know the simple rules that govern

these bechicles have no controller, it is just power and sensors. 

this veh would need an amplififer, the snensors signal needs ot be turned into a relevant motor signal

[MAPPING MODEL/env TO DIAGRAM]

# sensorimotor coupleing 

relevant for lab 1

b vehs are couples to envs

we can change (adappt) the nature of that coupling by modifying the systems parameters on the agents side 

[SENSORIMOTOR AGENT PARAMS]

can change that params to inpact y

this is not a self-adaptive sys but can be adpated (by us changing the params)

in lab, get a fully coded controller whereby we can change the params to get new behvaiour

could think of this as a NN 

[INSERT NN esqe picture]

there are inputs which are the sensor receiving light and then there are weights which goern how the network perceives the inouts

in a ff network we can play with these weights to be new haviour


if we arrange the light in interested patters, or have them moving, we can mkae bVs have in ways that appear complex

this is making the env more complex

the agent is a product of the env

behaviour is the product of interactions between brains, bodies and envs

the behav of bVs are reflexive or reactive, not adapative, to be adaptive we need a second fedeback loop that monitor performence of the veh and potentially changes the params for the vehs

# autonomy for robotics

automony has various definijtions

but work a working def in robotics (pfierfer and scheirer): 

autonomy mean independance from external control 

autonomy is not an all or nothing issue, but a matter of degree 

"controlability and capaility of acquiring one's own history are correlated: The more an agent can have its own history the less controllable it will be"

this can be itpreted as the agents internal state. this alone can make the agents behav difficult to predict and therefore to control 

controllability and autonomy are set up as opposites

given two agents A B. the less knowledge A has about B's internal state, the less A can control B. 

Autonomy of not a property of an agent but instead a property of relationships between agents

Thus, here autonomy is defined as a relationship between two systems. a property of an agent in a coupled system
---
its easy to predict Bvs when you jnow the state of the agents params

according to P and S, what is the level of autonomy BVs have?

# summary 

* We have introduced the sensorimotor loop, another example of circular causality, in the context of the “external” or observable behaviour of robots and living systems such as animals

* We have met Braitenberg’s vehicles, a thought experiment with simple sensorimotor vehicles which can act with surprisingly (apparent) complexity

* As with Braitenberg’s vehicles, all sensorimotor behaviour is the product of interactions with the environment – behaviour, and by extension intelligent behaviour, arises from the interactions
between “brain”, body and environment

* In preparation for our next lab, we have seen a way to
parameterise the behaviours of Braitenberg’s simplest vehicles

# part 2 - cybernetics and sensorimotor systems

learn/main:
* situation and embodied robotics began in cyberntics
* grey walter was very successful in this area in the 1950 but his ideas were forgotten for decades
* in 980s frustion with condtional ai lead to a new cynetrics approach: behaviour based robotics
* behaviour based robitcs are often note self-adaptive  - but we will see in later lectures they can be made self-adpative if we follow ashbys theory of ultrastable systems

in the following lab we will parameterise sensorimotor systems but in the future we will be writting algorithms which modify the parameters - making the systems self-adpative

# cyb robitics - grey walter

inventor of tortoise vehicles. like Bvs they explore their envs

slightly strange mechanism; two motors; 1 motor for forward, 2 for steering; only have a single light sense on top of head, but turns with wheel (front); 3 wheels, front steering; they have lights on them, it allows them to interact with eachother; have a bump sensor, to tell that bump occured, but no direction; 

basically it follows a light using this rotating column which contains the steering wheel and sensor. 

when it reaches the light, the column just rotaties to keep it there, but the back wheels are still going forward (?). 

their own light allows them to see other bots but also themselves in a mirror, or reflective surface. 

---

What is the difference between a feedback loop and a sensorimotor loop?

This is a nuanced distinction that sits at the heart of Embodied Cognition and Adaptive Systems. While they share the same mathematical structure (like the coffee cup on your slide), the difference lies in agency and loops.

1. The Standard Feedback Loop (The "Coffee Cup" Model)
A standard feedback loop is a unidirectional flow of information used to maintain stability. It is typically "passive" or "top-down."
* Characteristics: The system receives a signal, compares it to a setpoint, and produces an output.
* The "Passive" Nature: The coffee cup doesn't choose to cool down. The environment (the room) imposes the reference signal on the cup.
* Example: A thermostat. It measures temperature (Input) and turns on the heater (Output). The thermostat doesn't move around the room to find a warmer spot; it just sits there and reacts to the data it gets.

2. The Sensorimotor Feedback Loop (The "Braitenberg" Model)
A sensorimotor loop is bidirectional and circular. It implies that the system's actions directly change what it perceives next. In your module, this is often called "Closing the Loop" through the environment.

* Characteristics: Action and Perception are inseparable. The "Motor" part of the loop moves the "Sensor" part into a new state.
* The "Active" Nature: The system is an agent. It doesn't just process information; it seeks it.
* Example: A Braitenberg Vehicle. When the vehicle moves forward (Motor), its sensors move closer to the light source (Sensor). This changes the input, which changes the motor speed, which changes the position again.

The Key Distinction: In a standard loop, the environment acts on the system. In a sensorimotor loop, the system acts on the environment to change its own sensory input.

In an Adaptive System, the sensorimotor loop is where the "learning" happens. If a Braitenberg vehicle's motor starts to veer left because of a mechanical glitch, an adaptive sensorimotor loop will notice that the "expected" sensory change (getting closer to the light) isn't happening. It will then adjust its internal gains ($k$) to compensate for the drift.

--- 

the torts represent an early example of situations and emborded intelligent bheaviour in robots

behaviour is coming from the physical interactions

it does not come from some compelx controller which tells the robot what to do any tries to maniiplute and use the env in such as way to acheive an outcome

this work was from the 50s, when otu of fashion, and then can back in the 80s

# situatedness and embodient 

all animals and robots are situations and embodied in the sense that htye have body which detemriend how they intereact with the enviromentn 

they are situation in the environment 

but there is a deeper concept of embodiement:
* to what extend does an agent take advantage of its situatedness
* to what extend does the embodiment of the robot affect it behaviour, and is the effect for better or worse?

# umwelten

german words

parts of the env that an agent can sense andf have an effect on

some species have sense that we don't; sense electric fields; also do have the tools to manipluate them. 

other have less, i.e. tics cannot ear, they don't ignore soumd, they just can't sense it

in any given pphysical sense, there may be many umwelten; each specieis may perseive a different umwelten

