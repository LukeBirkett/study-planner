# Lecture Notes

- [Week 0 - Preliminary](#week-0---preliminary)
    - [Essential Reading](#essential-reading)
        - [Towards a bottom-up perspective on animal and human cognition (De Waal and Ferrari, 2010)](#towards-a-bottom-up-perspective-on-animal-and-human-cognition-de-waal-and-ferrari-2010)
        - [Animal cognition (Gould, 2004)](#animal-cognition-gould-2004)
        - [Understanding intelligence (Pfeifer and Scheier, 2001)](#understanding-intelligence-pfeifer-and-scheier-2001)
        - [Cognition, evolution, and behavior (Shettleworth, 2009)](#cognition-evolution-and-behavior-shettleworth-2009)
---
- [Week 1 - What is intelligence and does it need a brain?](#week-1---what-is-intelligence-and-does-it-need-a-brain)
    - [Part 1: What is Intelligence?](#part-1-what-is-intelligence)
        - [1. The Challenge of Defining Intelligence](#1-the-challenge-of-defining-intelligence)
        - [2. The "Top-Down" Approach to Intelligence](#2-the-top-down-approach-to-intelligence)
        - [3. The "Bottom-Up" Approach (Module Core Focus)](#3-the-bottom-up-approach-module-core-focus)
        - [4. Intelligence as Adaptive Behavior](#4-intelligence-as-adaptive-behavior)
    - [Part 2 - Where does behaviour come from?](#part-2---where-does-behaviour-come-from)
        - [1. The Triad of Emergence](#1-the-triad-of-emergence)
        - [2. Situatedness (The Role of the Environment)](#2-situatedness-the-role-of-the-environment)
        - [3. Embodiment (The Role of the Body)](#3-embodiment-the-role-of-the-body)
        - [4. Historical Context: Cybernetics vs. GOFAI](#4-historical-context-cybernetics-vs-gofai)
    - [Week 1 Lecture References/Readings](#week-1-lecture-referencesreadings)
        - [Clever animals and killjoy explanations in comparative psychology (Shettleworth, 2010)](#clever-animals-and-killjoy-explanations-in-comparative-psychology-shettleworth-2010)
        - [New approaches to robotics (Brooks, 1991)](#new-approaches-to-robotics-brooks-1991)
        - [Vehicles: Experiments in synthetic psychology (Braitenberg, 1986)](#vehicles-experiments-in-synthetic-psychology-braitenberg-1986)
        - [The foundations of plant intelligence (Trewavas, 2017)](#the-foundations-of-plant-intelligence-trewavas-2017)
        - [Thoughts from the forest floor: a review of cognition in the slime mould Physarum polycephalum (Reid, 2023)](#thoughts-from-the-forest-floor-a-review-of-cognition-in-the-slime-mould-physarum-polycephalum-reid-2023)
---
- [Week_2 - Unexpected Cleverness](#week_2---unexpected-cleverness)
    - [Part 1: KillJoy Prelude](#part-1-killjoy-prelude)
        - [1. The Bee vs. Rabbit Paradox (Species-Specific Predispositions)](#1-the-bee-vs-rabbit-paradox-species-specific-predispositions)
        - [2. The "Romantic" Era: Animal Minds After Darwin](#2-the-romantic-era-animal-minds-after-darwin)
        - [3. The Skeptical Turn: Moving Towards "Killjoy" Science](#3-the-skeptical-turn-moving-towards-killjoy-science)
    - [Part 2: Killjoy Framework and Applicaiton](#part-2-killjoy-framework-and-applicaiton)
        - [4. Morgan's Canon & The Killjoy Framework](#4-morgans-canon--the-killjoy-framework)
        - [5. Applying the Killjoy Framework](#5-applying-the-killjoy-framework)
    - [Part 3: Case Study](#part-3-case-study)
        - [6. Portia the Jumping Spider](#6-portia-the-jumping-spider)
    - [Part 4: Engineering Application of Killjoy](#part-4-engineering-application-of-killjoy)
        - [7. Flipping the Logic: Engineering "Killjoy" Machines](#7-flipping-the-logic-engineering-killjoy-machines)
    - [Week 2 References/Readings](#week-2-referencesreadings)
        - [Arthropod intelligence? The case for Portia (Cross et al, 2020)](#arthropod-intelligence-the-case-for-portia-cross-et-al-2020)
---
- [Week 3 - Collective Intelligence](#week-3---collective-intelligence)
    - [Part 1: Collective Behaviour](#part-1-collective-behaviour)
        - [1. Defining Self-Organisation and Collective Behaviour](#1-defining-self-organisation-and-collective-behaviour)
        - [2. Flocking and Swarming: The Boids Model](#2-flocking-and-swarming-the-boids-model)
        - [3. Stigmergy and Outsourced Intelligence](#3-stigmergy-and-outsourced-intelligence)
        - [4. Collective Decision-Making: Honeybee Swarms](#4-collective-decision-making-honeybee-swarms)
        - [5. The Adaptive Benefits of Collective Behaviour](#5-the-adaptive-benefits-of-collective-behaviour)
        - [6. Collective Intelligence in Humans](#6-collective-intelligence-in-humans)
    - [Part 2: Collective Behavior in Machines](#part-2-collective-behavior-in-machines)
        - [7. Swarm Robotics](#7-swarm-robotics)
    - [Week 3 Seminar](#week-3---seminar)
        - [Key Seminar Papers](#key-papers-for-the-seminar)
            - [Numerical cognition in honeybees enables addition and subtraction (Howard, 2019)](#numerical-cognition-in-honeybees-enables-addition-and-subtraction-howard-2019)
            - [Non-numerical strategies used by bees to solve numerical cognition tasks (Maboudi et al., 2021)](#non-numerical-strategies-used-by-bees-to-solve-numerical-cognition-tasks-maboudi-et-al-2021)
        - [Seminar Content](#seminar-content)
        - [Discussion Topic 1: The Difficulty of Stimulus Design](#discussion-topic-1-the-difficulty-of-stimulus-design)
        - [Discussion Topic 2: "Kill-joy" Explanations in Classic Studies](#discussion-topic-2-kill-joy-explanations-in-classic-studies)
        - [Discussion Topic 3: Methodological & Statistical Controls (Howard et al., 2019)](#discussion-topic-3-methodological--statistical-controls-howard-et-al-2019)
        - [Discussion Topic 4: Defining "Math" in Animals](#discussion-topic-4-defining-math-in-animals)
            - [Debate Point 1: Distinguishing "Arithmetic" from "Numerosity Discrimination"](#debate-point-1-distinguishing-arithmetic-from-numerosity-discrimination)
            - [Debate Point 2: The Requirement of Language and Symbols](#debate-point-2-the-requirement-of-language-and-symbols)
            - [Debate Point 3: The Role of Working Memory](#debate-point-3-the-role-of-working-memory)
            - [Debate Point 4: What does it mean for a bee to do math?](#debate-point-4-what-does-it-mean-for-a-bee-to-do-math)
            - [How to prove a bee is doing math?](#how-to-prove-a-bee-is-doing-math)
        - [Discussion Topic 5: Evaluating Biorobotic Models (MaBouDi et al., 2021)](#discussion-topic-5-evaluating-biorobotic-models-maboudi-et-al-2021)
            - [Debate Line 1: Can the neural network model do arithmetic?](#debate-line-1-can-the-neural-network-model-do-arithmetic)
            - [Debate Line 2: "Are you convinced?"](#debate-line-2-are-you-convinced)
            - [Debate Line 3: What are the bees actually doing?](#debate-line-3-what-are-the-bees-actually-doing)
    - [Week 3 References/Readings](#week-3-referencesreadings)
        - [Swarm intelligence in animals and humans (Krause et al., 2010)](#swarm-intelligence-in-animals-and-humans-krause-et-al-2010)
        - [Swarm Robotics:  Past, Present, and Future](#swarm-robotics--past-present-and-future)
---
- [Week 4 - Moving Through the World](#week-4---moving-through-the-world)
    - [1. J.J. Gibson and Direct Perception](#1-jj-gibson-and-direct-perception)
    - [2. The Fly as a "Gibsonian" Animal](#2-the-fly-as-a-gibsonian-animal)
    - [3. Insect-Inspired Biorobotics: Successes and Failures](#3-insect-inspired-biorobotics-successes-and-failures)
        - [Case Study I: Franceschini's Neurorobotics (Success)](#case-study-i-franceschinis-neurorobotics-success)
        - [Case Study II: The LGMD Car Collision Model (Failure/Lesson)](#case-study-ii-the-lgmd-car-collision-model-failurelesson)
    - [4. Task-Dependent Direct Perception in Humans](#4-task-dependent-direct-perception-in-humans)
    - [Week 4 References/Readings](#week-4-referencesreadings)
---
- [Week 5 - Navigation](#week-5---navigation)
    - [Week 5 Lecture Notes](#week-5-lecture-notes)
    - [Part 1: The Universal Navigational Toolkit](#part-1-the-universal-navigational-toolkit)
        - [1. Walking in a Straight Line](#1-walking-in-a-straight-line)
        - [2. Basic Sense of Direction & Learning](#2-basic-sense-of-direction--learning)
    - [Part 2: Insect Navigation (Embodiment & Situatedness)](#part-2-insect-navigation-embodiment--situatedness)
        - [1. Path Integration (PI)](#1-path-integration-pi)
        - [2. From PI to Habitual Routes](#2-from-pi-to-habitual-routes)
        - [3. Navigation by Image Matching](#3-navigation-by-image-matching)
        - [4. The Limits of Insect Navigation (Insects Insulate, Not Integrate)](#4-the-limits-of-insect-navigation-insects-insulate-not-integrate)
    - [Part 3: Big Brain Navigation (Cognitive Maps)](#part-3-big-brain-navigation-cognitive-maps)
        - [1. Combining Modalities (Etienne et al., 2004)](#1-combining-modalities-etienne-et-al-2004)
        - [2. The Neural Substrate (The Hippocampus)](#2-the-neural-substrate-the-hippocampus)
        - [3. Critique of the "Map" Metaphor](#3-critique-of-the-map-metaphor)
    - [Part 4: Robotic Navigation](#part-4-robotic-navigation)
        - [1. SLAM (Simultaneous Localisation and Mapping)](#1-slam-simultaneous-localisation-and-mapping)
        - [2. SLAM Variants & Hardware](#2-slam-variants--hardware)
    - [Week 5 References and Readings](#week-5-lecture-notes)
        - [Insect Navigation. (Graham, 2010)](#insect-navigation-graham-2010)
        - [Spatial cognition in bats and rats: from sensory acquisition to multiscale maps and navigation (Geva-Sagiv et al., 2015)](#spatial-cognition-in-bats-and-rats-from-sensory-acquisition-to-multiscale-maps-and-navigation-geva-sagiv-et-al-2015)
        - [Do animals have cognitive maps? (Bennet, 1996)](#do-animals-have-cognitive-maps-bennet-1996)
    - [Week 5 Seminar](#week-5-seminar)
        - [A simple threshold rule is sufficient to explain sophisticated collective decision-making (Robinson et al., 2011)](#a-simple-threshold-rule-is-sufficient-to-explain-sophisticated-collective-decision-making-robinson-et-al-2011)
            - [The Markov-Chain Modeling Approach](#the-markov-chain-modeling-approach)
            - [Core Linear Algebra Applications:](#core-linear-algebra-applications)
                - [Matrix Inversion: The Fundamental Matrix ($N$)](#matrix-inversion-the-fundamental-matrix-)
                - [Vector Summation: Calculating Expected Decision Time](#vector-summation-calculating-expected-decision-time)
                - [Matrix Multiplication: Absorption Probabilities ($B$)](#matrix-multiplication-absorption-probabilities-)
        - [Seminar Slides/Session](#seminar-slidessession)
            - [Part 1: Standalone Content (Background & Context)](#part-1-standalone-content-background--context)
            - [Part 2: Extracts from the Papers](#part-2-extracts-from-the-papers)
            - [Part 3: Seminar Discussion Points & Questions](#part-3-seminar-discussion-points--questions)
---
- [Week 6 - Motor Control]()
- [Week 7 - Tool Used]()
- [Week 8 - Social Intelligence]()
- [Week 9 - Seminar Only (Foundational Models)]()
- [Week 10 - Brain Size]() 

---

# Week 0 - Preliminary
This module will develop understanding of what it means for an animal or a machine to behave intelligently, and how brain and behavioural systems are adapted to enable an animal to cope effectively within its environment. 

We consider diverse aspects of intelligence including navigation and motor control, tool-use, language, memory and social skills. We ask how these are related to one another and how they are matched to the particular needs of animals and machines.

By the end of this module a successful student should be able to:
- Demonstrate a systematic understanding of the meanings of the term 'intelligence', and an ability to critically evaluate experimental data and theoretical concepts in the field
- Synthesise research in animal cognition and the engineering of artificial intelligence, critically assess how these disciplines inform one another and evaluate the appropriateness of the methodologies used to do this.
- Present a written account of specific aspects of the course subject matter based on independent reading of primary scientific and engineering literature, in the context of the wider reading of more general texts.
- Develop and argue an original hypothesis that draws from the major themes of the course.

---

## Essential Reading

### Towards a bottom-up perspective on animal and human cognition (De Waal and Ferrari, 2010)
[link](./weeks/week_0/files/towards_bottom_up.pdf)

*This is an essential article which explains the key logic of the approach to intelligence that we take in this module.*

This foundational paper by Frans de Waal and Pier Francesco Ferrari (2010) argues for a paradigm shift in comparative psychology away from traditional, human-centered "top-down" frameworks.

Historically, research has focused on the "pinnacles" of mental evolution by asking binary, all-or-nothing questions—such as whether a non-human animal possesses a full "Theory of Mind," true culture, or language. The authors critique this approach for drawing arbitrary dividing lines between taxa and failing to uncover the actual mechanisms at play.

Instead, they champion a bottom-up perspective rooted in evolutionary biology and neuroscience. This approach breaks down complex, macroscopic cognitive phenomena into their modular, constituent building blocks (such as gaze-following or mirror-neuron-driven motor mapping), showing how these fundamental mechanisms are shared continuously across species and adapted to meet ecological pressures.

> De Waal, F.B. and Ferrari, P.F., 2010. Towards a bottom-up perspective on animal and human cognition. Trends in cognitive sciences, 14(5), pp.201-207.

---
 
### Animal cognition (Gould, 2004)
[link](./weeks/week_0/files/animal_cognition.pdf)

*This is essential reading on the history of the study of animal behaviour. It is very short and easy to read.*

James L. Gould’s "Animal Cognition" (2004) serves as a conceptual primer that categorizes the spectrum of animal behavior to isolate what genuinely qualifies as "thinking." He structures animal capabilities into a hierarchy, starting from hardwired innate behaviors (like fixed action patterns) and moving through associative learning (conditioning), before arriving at true cognition. Gould argues that the truest indicator of animal cognition is behavioral flexibility—specifically, an organism's ability to formulate novel, real-time solutions to unique environmental problems that fall outside its evolutionary programming or past training. While acknowledging spectacular, highly complex "niche-specialist" intelligences (such as the spatial memory of food-caching birds or the navigation of honeybees), he highlights that domain-general cognitive flexibility, such as tactical deception or the tool-use seen in apes and dolphins, remains a rarer evolutionary trait.

Gould’s hierarchy mirrors the historical development of AI. Innate behaviors are equivalent to expert systems and hard-coded "If/Then" algorithms. Associative learning maps onto classic machine learning (pattern recognition based on trial and error). True cognition represents the elusive goal of Artificial General Intelligence (AGI)—the ability to abstract a concept and flexibly apply it to a completely novel scenario.

> Gould, J.L., 2004. Animal cognition. Current biology, 14(10), pp.R372-R375.

---
 
### Understanding intelligence (Pfeifer and Scheier, 2001)
[link](./weeks/week_0/files/understand_intelligence_ch1.pdf)

*Chapter 1 is essential reading. Because this is an old book some of the other chapters are dated and not necessary, but Chapter 1 is still a great introduction to the problem of studying intelligence. It is written from the perspective of AI practitioners and roboticists.*

Chapter 1 of Pfeifer and Scheier’s Understanding Intelligence (2001), titled "What is Intelligence?", establishes the foundational critique of classical, symbol-processing views of mind and introduces the embodied cognitive science paradigm. The authors argue that traditional AI (often called GOFAI, or Good Old-Fashioned AI) went astray by treating intelligence purely as abstract, centralized symbol manipulation decoupled from the physical world.

Instead, they propose that intelligence is an emergent property resulting from the dynamic interaction between an organism's or machine's nervous system, its physical body, and its environment.

Chapter 1 introduces the core principle of embodiment—the idea that having a physical body with specific morphology and sensors dictates how an agent perceives and acts—and emphasizes that intelligent behavior can often be achieved through cheap, distributed interactions with the environment rather than complex, centralized mental calculations.

> Pfeifer, R. and Scheier, C., 2001. Understanding intelligence. MIT press.

---

### Cognition, evolution, and behavior (Shettleworth, 2009)
[link](./weeks/week_0/files/cognition_evo_ch1.pdf)

*Chapter 1 is essential reading, it gives a very good introduction to the issues in studying animal intelligence.  The rest of the book is optional, but will give some excellent material for some of our topics. This book is ideal for students interested in behavioural ecology and/or psychology.*

Chapter 1 of Sara Shettleworth’s Cognition, Evolution, and Behavior (2009), titled "What Is Comparative Cognition About?", defines cognition broadly as the mechanisms by which animals acquire, process, store, and act on information from their environment, spanning everything from basic perception to complex decision-making. Shettleworth introduces a rigorous, evolutionary framework for studying these mental processes by integrating comparative psychology with behavioral ecology and ethology.

A central theme of the chapter is the warning against anthropocentrism and "folk psychology" expectations of intelligence; she demonstrates that highly complex, adaptive behaviors (like the precise navigation of a desert ant) are often driven by simple, specialized information-processing mechanisms rather than domain-general, human-like reasoning.

To structure the scientific analysis of these behaviors, Shettleworth champions Nikolaas Tinbergen’s four questions, emphasizing that a complete understanding of any cognitive trait requires examining its immediate mechanism, development (ontogeny), evolutionary history (phylogeny), and adaptive function.

> Shettleworth, S.J., 2009. Cognition, evolution, and behavior. Oxford university press.

---
 
<br>
<br>
<br>
<br>
<br>
<br>

# Week 1 - What is intelligence and does it need a brain?
In the first topic we will focus on definitions of intelligence, why many definitions of intelligence are anthropocentric and why we may not need to care. We then introduce a loose definition of intelligence as adaptive behaviour that is, behaviour that is useful in terms of survival and evolutionary fitness. This allows us to focus on interesting behaviour in animals, rather than definitions, and to discuss how such behaviour can come from animals with very small or even no brains as a result of the interaction of their body acting within and environment. 

#### Learning outcomes
- By the end of this week, you should be able to:
- Define intelligence in a way that is inclusive of animals.
- Explain the problems of defining intelligence in a way that ends up with semantic arguments.
- Explain where behaviour comes from and show how it ‘emerges’ from the interaction of brain, body and environment.

---

## Part 1: What is Intelligence?

### 1. The Challenge of Defining Intelligence
The central problem in comparative psychology and artificial intelligence is defining "intelligence" in a way that allows us to benchmark animals and machines against humans. In humans, intelligence is often measured via standardized tests (like IQ) or qualifications, but these anthropocentric (human-centric) metrics cannot be directly applied to other species or agents.

When researchers try to apply simplified metrics to compare species, the results often contradict human expectations:

| Type | Concept | Problem |
| :--- | :--- | :--- |
| Information Processing Speed (Hick's Law) | Hick's Law states that reaction time increases as the number of choices increases. In humans, higher IQ correlates with a shallower gradient (meaning high-IQ individuals are less slowed down by extra choices). | When tested on pigeons, their gradient is even shallower than high-IQ humans. If processing speed equals intelligence, we would have to conclude pigeons are smarter than humans, which most reject. |
| Learning Speed | Measuring how quickly different species learn simple associative tasks (e.g., associating a red light with food). | A meta-analysis showed that learning speed is inversely proportional to brain complexity (the k-index). The results ranked bees as the fastest learners, followed by quail, pigeons, rats, rabbits, and human infants last. |

*Takeaway:* Single-metric comparisons fail because they are usually rejected when humans do not come out on top, revealing our inherent biases in comparative psychology.

---

### 2. The "Top-Down" Approach to Intelligence

A common alternative to single metrics is creating a "checklist" of human-like cognitive traits (e.g., tool-use, theory of mind, numeracy, language) and looking for them in animals. This is known as the **Top-Down Approach**.

**The Problem with Top-Down:** It relies heavily on strict human definitions. When we don't find the fully-formed human trait (like complex syntax in chimpanzees), we conclude the animal lacks the intelligence.

**The Language Example:** If we define language strictly as human speech or sign language, no other animal has it. A top-down view implies language magically appeared in the evolutionary timeline just for humans. However, if we break language down into its components (turn-taking, semantic memory, social cues, listening), we see these traits are widely shared across the phylogenetic tree.

**The Trap of Semantics:** Top-down thinking leads to endless arguments about terminology rather than the biology itself.
- *Scrub Jays & Memory:* Scrub jays remember what food they hid, where they hid it, and when (knowing mealworms rot but peanuts don't). This is the exact definition of human "episodic memory." Yet, because of semantic gatekeeping, reviewers forced researchers to call it "episodic-like" memory.
- *Ants & "Teaching":* Conversely, a paper on tandem running in ants spent a third of its length arguing that the behavior should be labeled "teaching," applying a complex human cultural term to an emergent biological behavior.

---

### 3. The "Bottom-Up" Approach (Module Core Focus)
To avoid the traps of top-down thinking, this module focuses on a **Bottom-Up Approach**.

**Definition:** Instead of starting with complex human behaviors, we look for the basic, phylogenetically widespread building blocks of behavior.

**Why it matters:** We observe how simple, rudimentary behaviors piece together to create complex outputs. This perspective is vital not just for understanding evolution, but for engineering AI. If we want to build intelligent machines, we need to understand how basic mechanisms assemble into intelligent systems.

> **Key Reading:** [Clever animals and killjoy explanations in comparative psychology (Shettleworth, 2010)](./weeks/week_1/readings/lecture_referenced/shettleworth_2010_killjoy_explanations.pdf)

---

### 4. Intelligence as Adaptive Behavior
If we view intelligence through the lens of evolutionary biology, **intelligence is simply what organisms do to survive**. Evolution selects for adaptive behaviors that increase fitness; therefore, any adaptive behavior is fundamentally intelligent.

This inclusive definition reveals that intelligent outputs can emerge from highly unintelligent, simple mechanisms:

**Slime Mold (Single-Celled Cognition):** Slime molds explore their environment with tendrils to find food. In experiments, they can solve mazes and even replicate the highly optimized Tokyo suburban transport network just by naturally retracting from empty space and reinforcing pathways to nutrients. It achieves complex problem-solving without a brain.

> **Key Reading:** [Slime Mold Cognition (Reid, 2023)](./weeks/week_1/readings/weekly/slime_mould.pdf)

#### Why focus on Animals and Machines then?
While plants and single-celled organisms exhibit intelligent, adaptive behavior, this module focuses on animals because they utilize a central nervous system (sensory networks connecting to a central processor to produce motor behavior). This specific biological architecture maps directly onto how we engineer artificial neural networks and build robots, allowing for a direct cross-disciplinary comparison.

---

## Part 2 - Where does behaviour come from?
*This section deals with the specific mechanics of how behaviors emerge.*

### 1. The Triad of Emergence
Behavior does not exist in a vacuum, nor is it stored in one specific part of an organism. Instead, behavior is an emergent property that arises from the interaction of three core components:
- The Controller (Brain/Nervous System)
- The Body (Morphology/Sensors)
- The Environment

**The Car Analogy:** You cannot buy a kit car and look for the box that contains "speed." Speed does not exist in the engine or the wheels. Speed emerges only when the built car (body) is driven by a controller (driver/engine system) on an open road (environment).

In biological and artificial systems, we cannot simply "open the head" of an animal and find the one neuron responsible for a complex behavior. We must analyze how the brain, body, and environment interact.

---

### 2. Situatedness (The Role of the Environment)
Situatedness refers to how an agent's behavior is directly influenced by the environment it exists in. Complex behavior is often a reflection of a complex environment, not necessarily a complex brain.

#### Braitenberg Vehicles (Thought Experiment)
Valentino Braitenberg designed hypothetical, ultra-simple vehicles to demonstrate this. 

**Vehicle 1:** Has one motor connected to one temperature sensor. In a perfectly still, uniform environment, it moves in a boring straight line. But put it in a real lake with ripples and varying temperatures, and it moves erratically, exploring and avoiding hot spots. An observer might call it "restless" or "alive," assuming it has a complex brain, but the complexity is entirely driven by the messy environment (situatedness).

#### Herbert Simon’s Ant
An ant walking on a beach takes a highly complex, winding path. The complexity of the path is not due to a complex internal navigation algorithm; it is simply a reflection of the complex, bumpy environment the ant is situated in.

---

### 3. Embodiment (The Role of the Body)

Embodiment refers to how an agent's physical form (its sensors, actuators, and morphology) shapes its interaction with the world. A clever body design can "outsource" computation, drastically simplifying the job of the brain.

#### Braitenberg’s Vehicle 2 (Aggressor vs. Coward):
By changing the physical wiring of a simple robot with two light sensors and two wheels:

- **Crossed Wires (Aggressor):** Left sensor drives the right wheel. It turns towards the light and rams it.
- **Uncrossed Wires (Coward):** Left sensor drives the left wheel. It turns away from the light and hides.

**Takeaway:** Identical components, just arranged differently in the body, result in completely different behavioral outputs.

#### Biological Examples of Embodiment:

**Fiddler Crabs:** They live on flat mudflats (situatedness) and need to avoid tall predators (birds) while ignoring small things (other crabs). Instead of a high-resolution brain that parses complex visual data, their body solves the problem: they have low-resolution eyes on tall stalks. Anything above the horizon line is a predator; anything below is safe. The body morphology does the processing.

**Scorpions/Spiders:** Hunting on sand in the dark, they arrange their legs in a perfect circle. Because of this bodily arrangement, the leg that feels a vibration first directly points to the prey. The brain doesn't have to do complex trigonometry; the body layout solves the directional problem.

#### Robotics Example (The Beanbag Gripper):
Picking up objects is computationally heavy for a robot (it requires 3D modeling and pressure calculations). A "clever body" solution is a gripper made of a beanbag filled with coffee grounds. It presses over an object, physically deforms to the exact shape, and then a vacuum sucks the air out, creating a perfect grip without needing any brain processing.

---

#### 4. Historical Context: Cybernetics vs. GOFAI

**Grey Walter's Tortoises (Cybernetics - 1950s):** Early robots built with analogue electronics (a couple of sensors and motors). Because the light sensor was physically attached to the steering wheel, they moved in complex, lifelike helical patterns. This was an early demonstration of complex behavior emerging from a simple controller coupled with a clever body (embodiment) in the real world (situatedness).

**Shakey the Robot (GOFAI - 1970s):** "Good Old-Fashioned AI." Shakey attempted to solve navigation through pure brain power. It would take a picture, stop, build a 3D model of the world, plan a path, move slightly, and repeat. It was incredibly slow and computationally expensive because it ignored embodiment and situatedness, trying to process the entire world internally.

---

## Week 1 Lecture References/Readings

### [Clever animals and killjoy explanations in comparative psychology (Shettleworth, 2010)](./weeks/week_1/readings/shettleworth_2010_killjoy_explanations.pdf)

In this paper, Shettleworth critiques the anthropocentric bias in comparative psychology, where explaining complex animal behaviors through elementary biological mechanisms is frequently rejected as a "killjoy" approach. She observes a paradox in cognitive science: while comparative psychologists strive to prove animals possess "higher" human-like thought (e.g., insight or theory of mind), human psychologists are increasingly discovering that human behavior is heavily governed by the exact same simple, unconscious, and irrational processes observed in animals. Shettleworth advocates for a "bottom-up" paradigm that deconstructs complex abilities into basic, phylogenetically widespread building blocks—such as associative learning and responses to environmental cues. By recognizing that biological complexity often arises from simplicity, researchers can build a truly comparative psychology that accurately maps the shared cognitive mechanisms across human and non-human species.

> Shettleworth, S.J., 2010. Clever animals and killjoy explanations in comparative psychology. Trends in cognitive sciences, 14(11), pp.477-481.

---

### [New approaches to robotics (Brooks, 1991)](./weeks/week_1/readings/brooks_new_approaches_robotics.pdf)

In this foundational paper, Brooks critiques traditional "Good Old-Fashioned AI" (GOFAI) and its centralized "sense-model-plan-act" architecture, which requires heavy computation to build internal symbolic representations and struggles outside of highly controlled environments. Instead, Brooks champions a "bottom-up," behavior-based approach rooted in two core concepts: situatedness (interacting directly with the immediate environment rather than abstract models) and embodiment (leveraging physical form and real-world dynamics to simplify computation). Using his "subsumption architecture," Brooks demonstrates that robust, real-time intelligence—such as a six-legged robot navigating rough terrain—can emerge from layering simple, independent behaviors that directly connect sensors to actuators, completely bypassing the need for a central world model or complex "top-down" reasoning.

> Brooks, R.A., 1991. New approaches to robotics. Science, 253(5025), pp.1227-1232.

---

### [Vehicles: Experiments in synthetic psychology (Braitenberg, 1986)](./weeks/week_1/readings/braitenberg_1_28.pdf)

Braitenberg utilizes a series of increasingly sophisticated robotic thought experiments to demonstrate his "law of uphill analysis and downhill invention," proving that human observers systematically overestimate the cognitive complexity of an agent based purely on its behavioral output. By utilizing a strict bottom-up framework, he shows how complex, lifelike psychological traits can emerge from incredibly rudimentary sensorimotor loops coupled with real-world physics. Vehicles 1 through 3 demonstrate that basic monotonic wiring—varying from crossed or uncrossed, and excitatory or inhibitory paths—naturally produces behaviors interpreted as life, cowardice, aggression, love, and values. By advancing to nonmonotonic functions and discrete threshold devices (Vehicles 4 & 5), the agents display erratic orbits and sudden, abrupt actions that observers falsely attribute to "instinct," "intellectual calculation," and "free will". Finally, Vehicle 6 illustrates that when random mutation and environmental selection act upon these physical substrates, highly adaptive and computationally dense architectures emerge completely detached from centralized, conscious design. This text serves as a direct justification for the module’s emphasis on embodiment and situatedness, warning researchers against the top-down anthropomorphic trap.

> Braitenberg, V., 1986. Vehicles: Experiments in synthetic psychology. MIT press.

---

### [The foundations of plant intelligence (Trewavas, 2017)](./weeks/week_1/readings/trewavas_plant_intelligence.pdf)

Trewavas challenges anthropocentric definitions of cognition by framing intelligence as a decentralized, system-level capacity for problem-solving that is inextricably linked to evolutionary fitness.

By demonstrating that single cells and plants lack a brain but effectively "profit from experience," he shifts the focus of comparative cognition from specific anatomical organs to universal network architectures.

Both the nematode nervous system and cellular protein networks converge on a "rich club" core-and-periphery design, which serves as the computational framework for distributed information processing.

In plants, this is epitomized by the root cap, which dynamically integrates conflicting sensory signals (such as overriding gravity vectors to follow humidity gradients), and the cambium, which continuously assesses branch productivity to optimize resource distribution. Operating on a distinct growth-based timescale, plants navigate complex ecological spaces using volatile organic chemicals (VOCs) as an emergent language for self/non-self recognition, alongside epigenetic priming mechanisms that act as a somatic memory to handle environmental stress.


> Trewavas, A., 2017. The foundations of plant intelligence. Interface focus, 7(3).

---

### [Thoughts from the forest floor: a review of cognition in the slime mould Physarum polycephalum (Reid, 2023)](./weeks/week_1/readings/weekly/slime_mould.pdf)

Reid synthesizes decades of research on the aneural protist Physarum polycephalum to validate the basal cognition framework, proving that fundamental cognitive toolkits—sensing, navigation, memory, decision-making, and learning—evolved long before the historical emergence of nervous systems. Operating as a giant, self-organizing flow network, Physarum processes environmental data through physically coupled actin-myosin oscillators. This mechanical substrate allows the cell to calculate optimal transport networks, solve multi-attribute compensatory problems, and exhibit animal-like behavioral paradigms, including magnitude-sensitive reaction times (Weber's Law) and a reliance on the Matching Law when solving exploration-exploitation (multi-armed bandit) dilemmas. Furthermore, Physarum serves as a key example of extended cognition and cognitive niche construction by depositing extracellular slime trails that function as an externalized spatial memory to dramatically optimize foraging efficiency. While it exhibits robust non-associative learning (habituating to individual chemical repellents via intracellular chemical retention), the lack of definitive evidence for associative conditioning highlights a critical interdisciplinary debate: whether true associative processing requires a dedicated neural architecture or if its absence is merely a reflection of limited ecological pressure.

It bridges de Waal’s bottom-up view, Pfeifer & Scheier’s interactionist embodiment paradigm, and Shettleworth's warnings against anthropocentric biases, unifying them all under a single, highly operational biological model system.


> Reid, C.R., 2023. Thoughts from the forest floor: a review of cognition in the slime mould Physarum polycephalum. Animal cognition, 26(6), pp.1783-1797.

---

<br>
<br>
<br>
<br>
<br>
<br>

# Week_2 - Unexpected Cleverness
This week's lecture has two main strands. The first is a fun historical tour of how people have viewed animal intelligence in the past. From this you will see a repeating pattern of over and under estimation of the intelligence of animals. We will then look at some specific case studies of behaviour that would be seem 'intelligent' and can be described as inteligent when we use anthropomorphic terms - but we will take a "Killjoy" approach to understand how those behaviours might come about.

#### Learning Outcomes
- Explain why Darwin and his acolytes wanted to explain behaviour in anthropomorphic terms.
- Describe Morgan’s Canon and how it laid the groundwork for killjoy explanations of behaviour?
- Explain how apparent smartness in invertebrates can be explained by their embodiment, situatedness and ecological niche.

---

## Part 1: KillJoy Prelude

### 1. The Bee vs. Rabbit Paradox (Species-Specific Predispositions)
When tested on simple associative learning tasks in the lab, bees learn much faster than rabbits. Rather than indicating greater generalized intelligence, this is perfectly explained by their ecological niches (**situatedness**) and physical adaptations (**embodiment**).

**The Rabbit's Niche:** Rabbits live in environments where food (grass) is abundant. Their cognitive resources are dedicated to avoiding predators and navigating social hierarchies, not associating arbitrary cues with food.

**The Bee's Niche:** Bees must fly long distances to find patchily distributed nectar. They are evolutionary "learning machines" built specifically to associate floral colors and shapes with food profitability.

**Embodiment:** Bees possess innate attractions to certain colors (like UV blue/yellow) and have hardwired sensorimotor programs used to automatically "center" symmetrical patterns in their vision. This projects the flower onto the exact same part of their visual system every time, drastically speeding up associative learning.

**Social Speed-Accuracy Trade-off:** Because bees are social task specialists, individual foragers can afford to learn very quickly (a risky strategy). If one bee makes a learning error and dies, the colony still survives.

*Takeaway:* The impressive cognitive performance of bees in these tasks is completely explained by **species-specific predispositions combined with associative learning**.

---

### 2. The "Romantic" Era: Animal Minds After Darwin
Historically, there has been a severe tension between romantic (anthropomorphic) and skeptical (killjoy) descriptions of animal behavior.

**Darwin's Influence:** In The Descent of Man (1871), Charles Darwin argued that the difference in mind between humans and higher animals is "one of degree and not of kind". To promote the idea of evolutionary continuity, it became acceptable to use heavily anthropomorphic language to describe animal behavior.

**George Romanes and Anecdotalism (1888):** Romanes collected field anecdotes to try and verify animal intelligence. For example, he observed ants pulling a trapped nestmate from the mud and described it as "sympathetic help" and "fellow-feeling," attributing complex human emotion to what is actually a pheromone-driven instinct.

**The "Nature Fakers":** Writers like Apsley Cherry-Garrard and William Joseph Long published highly exaggerated, fanciful accounts of animal behavior (e.g., birds building mud casts for broken legs), prioritizing romantic storytelling over rigorous science.

---

### 3. The Skeptical Turn: Moving Towards "Killjoy" Science
To combat the unscientific nature of anecdotalism, comparative psychology shifted toward rigorous observation and skepticism, leading to the "killjoy" approach.

**Clever Hans (1907):** A horse that appeared to have advanced numeracy, tapping out answers to math problems. Investigator Oskar Pfungst revealed that Hans could not do math; instead, the horse was using associative learning of social cues. Hans read the unconscious bodily tension and relaxation of the human audience to know exactly when to stop tapping.

**Tony the Dog:** Tony appeared to use insightful/spontaneous problem solving to open a gate latch with his head. However, observation revealed he had accidentally bumped the latch while looking through the fence; his eventual mastery of the gate was purely the result of blind trial-and-error learning.

---

## Part 2: Killjoy Framework and Applicaiton

### 4. Morgan's Canon & The Killjoy Framework
C. Lloyd Morgan (Tony the dog's owner) formalized this skeptical approach in 1903 with Morgan's Canon:

> "In no case may we interpret an action as the outcome of the exercise of a higher mental faculty, if it can be interpreted as the exercise of one which stands lower in the psychological scale."

This acts as Ockham’s Razor for comparative psychology. It requires us to account for seemingly clever behavior using the simplest possible mechanisms.

#### The Killjoy Breakdown:
A true killjoy explanation accounts for behavior using:  
1. **Simple (Associative) Learning:** Habituation, sensitization, classical/operant conditioning, and trial-and-error learning.
2. Species-Specific Predispositions:
    - Morphological adaptations (**embodiment**).  
    - Behavioral adaptations.  
    - Adaptation to a narrow ecological niche enabling them to cope with predictable situations (**situatedness**).  

---

### 5. Applying the Killjoy Framework
**Human Language Learning:** While learning language seems incredibly complex, a killjoy account breaks it down into simple components. Humans have innate visual and auditory biases to separate objects and phonemes. Combined with a highly social ecological niche (surrounded by speaking adults), human infants use simple associative learning to link objects to specific sounds.

**Case Study: String-Pulling Bees:** In a famous experiment, bees learned to pull a string to bring a covered food disc toward them. The authors of the study claimed this was "novel tool use" and an example of "culture"
- **Killjoy account:** Walking toward a blue disc (a flower proxy) is an innate foraging behavior. The string acting as a treadmill is merely a function of the experimental setup, rather than a novel situation the bee truly understands. The apparent "tool use" is actually a mix of trial-and-error learning and social attraction (going where other bees go, which is a species-specific predisposition), rather than a purposeful, physics-based understanding of the string.

---

## Part 3: Case Study

### 6. Portia the Jumping Spider
Portia is an invertebrate with a microscopic brain (~100,000 neurons) that hunts other spiders. Anthropomorphic documentaries describe her as a "genius" capable of "3D mapping," "planning," and "strategy".

#### The Killjoy / Triadic Account of Portia:
- **The Task:** Detouring to a prey item across complex branches where she temporarily loses sight of the target.
- **Embodiment (Telescope Eyes):** Portia has huge principal eyes giving her extreme spatial acuity (comparable to a falcon) but a tiny field of view. She cannot see the whole scene at once. Instead, she rotates her retinas behind the lenses, scanning the environment in tiny slices.
- **Vicarious Trial-and-Error:** Instead of running a complex 3D mental simulation of the maze (which her brain cannot handle), she uses her body. Her slow, meticulous visual scanning along continuous lines acts as a physical substitute for locomotion.
- **Situatedness:** This visual strategy only works in her specific ecological niche—an environment made of continuous, traceable lines (twigs and branches). In dense, featureless foliage, the algorithm fails.
- **Web Strumming:** Portia can flexibly "strum" a victim's web to mimic wind (sneaking) or a trapped fly (luring). Possessing the sensory apparatus to read and produce web vibrations is an innate, standard part of the spider toolkit. She uses trial-and-error learning to figure out which innate frequency works best to manipulate specific prey

---

## Part 4: Engineering Application of Killjoy

## 7. Flipping the Logic: Engineering "Killjoy" Machines
Engineers can use the "killjoy" philosophy to build machines: what is the simplest, cheapest, lowest-computation algorithm that can succeed in a specific environment?

**The Basic/Killjoy Machine (e.g., iRobot Roomba):** Uses a tiny, simple algorithm: spiral outward, follow walls, and move randomly. It does not know what a room is or map out the space.
- **Its Niche:** Open-plan flats and hard floors. In this niche, the simple algorithm works perfectly without heavy computation.

**The Sophisticated/Anthropomorphic Machine (e.g., Ascender/Lydsto):** Uses heavy computation, dynamic visual mapping, and complex path-planning algorithms.
- **Its Niche:** Complex multi-room houses, corridors, and stairs. 

*Takeaway:* A machine (or animal) does not need an advanced, complex brain if its basic "killjoy" algorithm perfectly matches its ecological niche.

---

## Week 2 References/Readings

### Arthropod intelligence? The case for Portia (Cross et al, 2020)

This review challenges Macphail’s "null hypothesis"—which posits no differences in intelligence among non-human vertebrates—by arguing that excluding invertebrates simply due to their minute brain size is an arbitrary and limiting constraint. Using the jumping spider Portia as a model, the authors advocate for viewing intelligence (flexible problem-solving) and cognition (reliance on internal representation) as continuums across all taxa.

**Dennett’s Evolutionary Framework:** To categorize different levels of intelligence, the authors utilize Daniel Dennett's framework and classify Portia as a "Popperian Creature". Unlike "Darwinian Creatures" (which rely strictly on hard-wired evolutionary instincts) or "Skinnerian Creatures" (which rely purely on trial-and-error learning within their own lifetime), Popperian Creatures can "think before acting" by formulating plans using internal representations.

**Pre-Planned Detours:** Experimental evidence shows Portia can spontaneously select and execute complex, indirect paths to reach prey. The spider makes strategic detouring decisions from a vantage point before moving, even when the prey is removed from sight during the journey. This demonstrates an innate, yet highly flexible, capacity to plan ahead without requiring prior trial-and-error training.

**Expectancy Violation & Working Memory:** Using modified "looking time" experiments tailored to spiders, researchers proved Portia loads specific representations of its target into its working memory. If the prey's species, color, or exact quantity (e.g., 1 vs. 2 prey items) is secretly altered while Portia is completing a blind detour, the spider hesitates or aborts the attack, clearly demonstrating an expectancy violation.

**Solving Novel Confinement Problems:** Portia excels at "aggressive mimicry," deploying a trial-and-error strategy to pluck the webs of victim spiders to lure them. The authors present evidence that this domain-specific predatory proficiency translates into domain-general intelligence. When placed in a completely novel environment (an island surrounded by water), Portia successfully utilizes trial-and-error to figure out the specific escape mechanism, proving its problem-solving flexibility extends beyond its natural ecological niche.

> Cross, F. R., Carvell, G. E., Jackson, R. R., & Grace, R. C. (2020). Arthropod intelligence? The case for Portia. Frontiers in Psychology, 11, 2573

---

<br>
<br>
<br>
<br>
<br>
<br>

# Week 3 - Collective Intelligence

In Lecture 3, we will look at Collective Intelligence, looking at specific case-studies of social insect systems and the principles by which collective decision making can be implemented. We don't talk about social insects by chance. Because individual foragers from a single social insect colony are all working towards the same goal, evolution has been able to select for optimal co-operation.

Unfortunately most animals are selfish and competitive, even when in social groups. So it is no surprise that we don't see optimal decision making in human groups, even though there is sometimes the statistical evidence to suggest that it would be possible.

We will also look at some examples of swarm robotics. One of the important things here is to evaluate the properties of biological swarm systems and why they are desirable to engineers, although we can see that we are a long way from real world applications.

#### Learning Outcomes
- Define and give examples of systems that are stigmergic and/or self-organising
- Understand my collective intelligence sometimes fails, especially in human groups.
- Evaluate the properties of biological swarm systems and why they are desirable to engineers

---

- What is self-organising behaviour?
- What is stigmergy?
- What are the adaptive properties of intelligent collective decision making systems?
- What are the details of specific case-studies that show  how individual local rules lead to collective  intelligence?
- Why are self-organising principles desirable for  engineers?
- How are these implemented in swarm robotics?

---

## Part 1: Collective Behaviour

### 1. Defining Self-Organisation and Collective Behaviour
**Self-Organisation:** A process where global, system-level patterns emerge purely from numerous local interactions between lower-level components.

**Local vs. Global Information:** Individual agents operate exclusively using local information (what they can immediately sense) and execute local rules. They have no reference to, or awareness of, the overarching global pattern they are helping to create.

**Historical Misconceptions:** In the past, observers struggled to explain how complex flocking could occur without a central leader. For example, in 1931, ornithologist Edmund Selous wrongly concluded that birds must be using telepathy or "thought transference" to coordinate.

**The Golden Rule:** In true collective intelligence, the output of the group is greater and more robust than the sum of its individual parts

---

### 2. Flocking and Swarming: The Boids Model
**The Boids Model (1986):** Computer scientist Craig Reynolds proved that realistic flocking could be simulated using three simple, metric-based **local rules**:
1. **Separation:** Avoid getting too close to nearby neighbors to prevent collisions.  
2. **Alignment:** Move in the same average direction as nearby neighbors.  
3. **Cohesion:** Move towards the average position of neighbors if you are too far away.  

**Topological vs. Metric Rules:** Later 3D tracking of real starling murmurations (Ballerini et al., 2008) showed Reynolds' metric distances were slightly wrong. Instead, birds use a **topological rule**: they constantly pay attention to their nearest 6 neighbors, regardless of absolute physical distance.

**Why this works better:** During a turn, a murmuration "squishes" together and expands, which completely breaks metric distance radiuses. Paying attention to a fixed number (the nearest 6) provides an elegant, robust solution that eliminates the visual processing overload of a shifting metric environment.

**Robustness:** Topological rules are superior because they are more robust to varying flock densities. If the flock squishes together to turn or is attacked by a predator, a topological flock is much less likely to fragment than a metric one.

---

### 3. Stigmergy and Outsourced Intelligence

**Stigmergy:** Coined by Pierre-Paul Grassé, this is the coordination of agents or actions through physical traces left in the environment. This reduces the cognitive load on individual agents (e.g., humans using a written to-do list to offload memory).

**Termite Mound Building:** Termites initially drop mud pellets at random on elevated ground. These small heaps stimulate other termites to drop more pellets there (a positive feedback loop), eventually forming columns. If columns are close enough, termites start building diagonally to connect them into walls.

**Ant Pheromone Trails:** Ants leave pheromones when finding food. As more ants follow the randomly discovered shortest path, the pheromone strengthens faster, creating a positive feedback loop that draws the entire colony to the optimal route. The collective makes a highly intelligent decision, even though no individual ant consciously compared the routes.

**Ant Colony Optimisation (ACO):** These decentralized biological processes have directly inspired real-world engineering routing algorithms (e.g., telecommunications), where local nodes use data-packet speeds (virtual pheromones) to optimize network traffic without needing top-down, centralized server control.

---

### 4. Collective Decision-Making: Honeybee Swarms
**The Challenge:** When bees swarm, they are highly exposed. Scouts must find a new, permanent nest site that is fast, accurate, and has unified agreement. Social insects are perfect for this because they share 100% evolutionary alignment (no selfish competition).

> Social insects have zero internal competition because they are all sisters maximizing their mother’s fitness. This total lack of selfishness is the absolute prerequisite for the positive feedback loops and decay mechanics to achieve true optimality—unlike human groups.

**Information Sharing (Waggle Dance):** Scouts return and dance to indicate a nest location. The angle indicates direction, the duration indicates distance, and the number of circuits reflects the scout's assessment of site quality.

**Parallel Evaluation & Decay:** Multiple options are evaluated simultaneously. Scouts do not compare sites individually; they visit one site and make their own independent assessment. Crucially, scouts naturally decrease (decay) their dancing over time. If no other bees agree the site is good, the option is successfully abandoned.

**The Quorum:** If a site is good, a positive feedback loop of new scouts occurs. A scout ultimately decides the process is complete when they personally observe a "quorum" (a threshold number) of other bees physically at the nest site. This quorum balances speed and accuracy and mathematically prevents a single error-prone scout from leading the swarm astray.

--- 

### 5. The Adaptive Benefits of Collective Behaviour
Engineers and biologists prize self-organizing collective systems because they inherently possess powerful adaptive properties:
- **Self-Organising:** No leader or central organizer is required.  
- **Scalable:** The system scales effortlessly with variable numbers of individuals.  
- **Flexible:** The collective dynamically adapts to environmental obstacles via local rules.  
- **Fault Tolerant:** There is no single point of failure; if one agent breaks, the collective behavior continues.

---

### 6. Collective Intelligence in Humans
**Collective Movement:** Human crowd movement can be modeled with very simple local rules (e.g., choosing the most direct path while maintaining a distance from obstacles that ensures a minimum time-to-collision). Furthermore, a tiny, informed minority can seamlessly drive the behavior of a massive, uninformed group without the group realizing it

**Wisdom of the Crowds:** Aggregating independent group guesses (like guessing the number of marbles in a jar) is often highly accurate because individual random over- and under-estimates cancel each other out.

**Limitations of Human Crowds:**
- Crowds fail spectacularly on tasks requiring complex mathematics or non-linear logic (e.g., calculating coin-flip probabilities).
- "Crowd IQ" plateaus quickly (around 30 people). A group of 100 average people will only achieve an aggregated IQ of around 120. Therefore, on highly difficult tasks, it is always better to seek out a single expert (IQ > 135) than to rely on the crowd.

**Medical Diagnostics:** Pooling independent judgments from doctors drastically improves skin/breast cancer detection accuracy over the best individual doctor. However, this collective intelligence vanishes if the doctors are allowed to meet and discuss the diagnosis socially.

---

## Part 2: Collective Behavior in Machines

### 7. Swarm Robotics
**Engineering Goals:** Applying biological local rules to robotics promises massive fault tolerance, scalability, flexibility, and lower costs than building single complex robots.

**Kilobots (2014):** A thousand-robot swarm utilizing cheap, vibrating robots. By relying on "gradient" values passed locally from stationary seed robots, the swarm can programmatically assemble into complex 2D shapes purely through edge-following and noisy local communication.

**Robot Termites (2014):** Robots independently building 3D structures. They share identical, pre-compiled "traffic rules" and use strict short-range sensing to attach bricks based on geometric requirements.

**Current Outlook:** While swarm robotics has successfully proven biological concepts through the modeling-observation loop, there are currently no major real-world commercial applications due to lingering high costs and physical/hardware limitations.

---

<br>
<br>
<br>

## Week 3 - Seminar

This week we're going to cover 2 papers, so please read both. They're a really nice pair, and are related to your your Week 2 Unexpected Cleverness lecture.

The first one describes a study purporting to show that bees can do arithmetic and can therefore represent numbers: 

> Howard et al (2019). Numerical cognition in honeybees enables addition and subtraction

The second paper argues that numerical cognition is not needed for the bees to perform that task, and supported that argument by building a neural network model that does not have numerical cognition yet can still "do the sums": 

> Maboudi et al (2021). Non-numerical strategies used by bees to solve numerical cognition tasks

<br>

---
### Key Papers for the Seminar

#### Numerical cognition in honeybees enables addition and subtraction (Howard, 2019)

This study challenges the assumption that exact, symbolic arithmetic requires the large brain architectures of primates or humans. Using an appetitive-aversive Y-maze paradigm, researchers successfully trained free-flying honeybees to use colors as symbolic operators, where blue required the bee to "add one" element to a sample and yellow required it to "subtract one". Because the element being added or subtracted was never visually present, the bees had to successfully hold the sample quantity in their short-term working memory while applying the learned, long-term operational rule. When tested with a completely novel sample number that they had never encountered during training, the bees successfully interpolated the rules to choose the correct arithmetic outcome. This proves that insects with miniature brains are capable of true numerical cognition, suggesting that advanced mathematical processing is biologically accessible without the prerequisites of human language or culture, likely evolving as a cognitive byproduct of complex foraging demands.

---

#### Non-numerical strategies used by bees to solve numerical cognition tasks (Maboudi et al., 2021)
This paper acts as a critical counter-argument to the previous reading (Howard et al., 2019), demonstrating the intense scrutiny required when evaluating "intelligent" behavior in biorobotics and neuroethology.

This study provides a critical reassessment of numerical cognition in insects, demonstrating that what appears to be advanced arithmetic behavior is often driven by simpler, non-numerical heuristics. The authors note that in standard 2D visual tasks, the number of elements inevitably covaries with continuous physical cues like edge length, convex hull, and spatial frequency. Through behavioral experiments, they proved that when numerosity and continuous cues are set in opposition, honeybees actively abandon the number of items and base their decisions entirely on the continuous visual variables. To prove the biological plausibility of this alternative strategy, the researchers built a simple nine-neuron network model tuned exclusively to spatial frequency, with absolutely no capacity for numerical processing. Strikingly, this non-numerical model successfully reproduced complex behaviors previously hailed as proof of insect counting—including the ability to order "zero" at the bottom of a numerical continuum. Ultimately, the paper suggests that a computationally cheap "sense of magnitude" is far more primitive than a true "sense of number," serving as a stark reminder for biorobotics that complex behavior does not necessitate complex, high-level cognitive processing.

The authors urge future studies to assess all continuous cues in unrewarded tests, use cross-modal cues (like combining sound and vision), and analyze micro-behaviors (like flight paths and sequential scanning) to reveal the true algorithms animals use.

---

### Seminar Content

The seminar opens by distinguishing between **Magnitude Estimation** (a mid-level perceptual process determining "how much" of something there is, like size or density) and true **Numerical Cognition/Numerosity** (an approximate sense of exact number that allows for symbolic representation and mathematics). The subsequent discussions challenge how we can reliably test this distinction in animals.

---

### Discussion Topic 1: The Difficulty of Stimulus Design

**The Prompt:** Why will symbolic stimuli (like the printed numbers '1' and '7') often be a poor choice of stimulus for testing an animal, like a dog?

**The Context:** The slides highlight the inherent difficulty of testing numerosity without using human symbols. When researchers use arrays of dots or squares instead, they run into massive confounding variables: changing the number of items inherently changes the cumulative area, the overall bounded area, or the density of the items.

**Additional Reference Included:** Leibovich and Henik (2013) – cited regarding the visual confounds of studying numerosity.

---

### Discussion Topic 2: "Kill-joy" Explanations in Classic Studies

**The Prompts:** Can you think of a confound or a kill-joy explanation for the parrot doing math? Or not? What is going on in the monkey subtraction task?

**The Context:** The seminar looks at claims of advanced animal math. It references a study where an African Gray parrot supposedly quantified items and performed addition using vocal English labels. It also examines a study where rhesus monkeys consistently chose an occluded box containing one plum over a box containing zero plums, which the authors claimed was evidence of subtraction and representing "zero". The discussion pushes students to find the simpler, non-mathematical heuristic (like "Yummy!" food motivation) that might explain these behaviors.

**Additional References Included:**
    - Pepperberg (1994) – African Gray parrot addition study.
    - Oscar Pfungst (1907) – A deliberate reference to the scientist who debunked "Clever Hans" (the horse that supposedly did math by reading human body language)
    - Sulkowski & Hauser (2001) – Rhesus monkey subtraction study.

---

### Discussion Topic 3: Methodological & Statistical Controls (Howard et al., 2019)

**The Prompt:** When testing the bees, what does having the incorrect answer in the "Same direction" vs. the "Opposite direction" control for?

**The Context:** Reviewing the Howard et al. (2019) bee arithmetic paper, the seminar looks at the testing phase. If the math problem is $3+1$, presenting an incorrect option of $5$ (same direction) versus an incorrect option of $2$ (opposite direction) tests different cognitive failures. The discussion revolves around understanding experimental design. 

**Additional Content Included:** The slides introduce Linear Mixed Models (LMMs). They visually explain regression lines (Predictor vs. Outcome) and explain that LMMs allow researchers to combine lots of regression lines so that the model accounts for the group mean accuracy plus the individual mean accuracy of each specific bee.

---

### Discussion Topic 4: Defining "Math" in Animals

**The Prompts:**
- To conclude a non-human animal can add & subtract, what processes would you want to have demonstrated?   
- What would it mean for a bee to be able to do maths?   
- Do you need numeric representations, language or working memory to do this task?   
- How do you distinguish between numerosity discrimination & arithmetic?   

**The Context:** Guided by quotes from Howard et al., the seminar asks the class to define the philosophical and cognitive boundaries of mathematics. If an animal can solve the maze without language or complex working memory, is it doing math, or is it doing something else?

#### Debate Point 1: Distinguishing "Arithmetic" from "Numerosity Discrimination"

**The Core Debate:** Is the animal actually performing a mathematical operation, or just picking the "bigger" or "smaller" visual pattern?

**The "Pro-Arithmetic" Argument (Howard):** Numerosity discrimination is simply looking at two static piles and knowing which has more. Arithmetic requires an operator. Howard et al. argue that the bees are doing arithmetic because they are using a symbol (color) to tell them whether to actively change the value of an initial sample in their minds, demonstrating a mental manipulation of quantity.

**The "Killjoy" Counter-Argument (MaBouDi):** You can bypass arithmetic entirely by relying on continuous variables. If blue means "add" and yellow means "subtract", the bee might simply be learning the associative rule: "If blue, choose the image with more spatial frequency/edge length than the last one I saw; if yellow, choose the one with less". This is magnitude matching, not arithmetic.

---

#### Debate Point 2: The Requirement of Language and Symbols

**The Core Debate:** Can true mathematics exist without human language or culturally invented symbols (like Arabic numerals)?

**The "No Language Needed" Argument (Howard):** Howard et al. explicitly argue that human language and culture are not prerequisites for exact calculation. They demonstrate that bees can learn to use colors as abstract, symbolic representations of "+" and "-". If an animal can link an abstract visual trait to a functional operation, it is performing symbolic math.

**The Counter-Argument (Philosophical):** Without language, an animal is restricted to the limits of subitizing (the innate ability to instantly recognize small numbers from 1 to 4). If a bee cannot name a number, it cannot process large exact numbers (e.g., $15 + 1 = 16$). Therefore, what the bee is doing is a hardwired, low-level biological estimation, which lacks the infinite scalability that defines true "math."

---

#### Debate Point 3: The Role of Working Memory

**The Core Debate:** What specific mental processes must we see to conclude an animal is adding or subtracting?

**The "Working Memory" Requirement (Howard):** To prove an animal is adding, the elements to be added cannot be physically present. Howard et al. argue this was demonstrated because the bee had to hold the sample number in its short-term working memory, recall the long-term rule (blue = add 1), and compute the answer mentally while flying down the maze.

**The "Embodied/Situated" Counter-Argument:** Tying back to the core themes of the module, we know insects use "just-in-time" extraction and try to avoid heavy memory loads. An alternative explanation is that the bee is acting purely reactively. It might not be holding a "number" in its working memory at all, but rather storing a temporary sensory trace (like the intensity of the spatial frequency) and then reacting to whichever choice in the decision chamber best matches that shifted intensity.

---

#### Debate Point 4: What does it mean for a bee to do math?

**The Core Debate:** Does the concept of "math" even make sense in the ecological reality of a honeybee?

**The Ecological Advantage (Howard):** Doing math makes evolutionary sense. A bee constantly makes complex economic decisions: "Is the nectar payoff of this flower worth the energy cost of flying to it?". Howard et al. argue that the cognitive plasticity required to link visual cues to reward quantification is essentially a natural, ecological form of math.

**The Evolutionary Economy (MaBouDi / Stafford):** Evolution is notoriously lazy and cheap. Building a "math module" in the brain is computationally expensive. As MaBouDi proved with their 9-neuron model, an insect can solve these problems using a generalized, primitive "sense of magnitude" rather than a true sense of number. For a bee, doing "math" might just mean taking the path of least computational resistance to get to the most sugar.

---

#### How to prove a bee is doing math?

The cross-modal experimental design mentioned in MaBouDi et al suggests if a bee could be trained to hear 3 buzzes and then reliably select a visual image of 4 squares (when primed with blue), that would eliminate continuous visual cues (like spatial frequency) and strongly suggest a true, abstract understanding of arithmetic.

---

### Discussion Topic 5: Evaluating Biorobotic Models (MaBouDi et al., 2021)

**The Prompts:** What do you think? Are you convinced? Can the neural network model do arithmetic?   

**The Context:** The seminar introduces the MaBouDi et al. (2021) paper as an alternative, "kill-joy" explanation. It outlines how a simple neural network, encoding strictly for spatial frequency and completely blind to numerosity, can perfectly replicate the bee's performance on the addition/subtraction tasks (including using "zero"). The final discussion asks the class to synthesize both papers and decide if the neural network is "doing math" or just matching patterns, and by extension, what the bees are actually doing.

> *To tackle Discussion Topic 5 at a master's level, you need to engage directly with the synthetic power of biorobotic modeling. The core of this debate hinges on a profound computational question: If a simple, non-numerical mechanism can perfectly mimic an seemingly "advanced" cognitive behavior, what does that tell us about the nature of intelligence, the brain of the bee, and the validity of our AI models?*

---

#### Debate Line 1: Can the neural network model do arithmetic? 
This prompt forces a clash between two major philosophies of mind and computer science when evaluating MaBouDi et al.'s 9-neuron model.

**The Functionalist/Behavioral Argument ("Yes, practically"):** If an agent takes an input (a visual sample primed with a color symbol) and consistently produces the mathematically correct output (interpolating to $3+1=4$ or recognizing that $0$ is less than $1$), it is functionally computing arithmetic. Under a strict behavioral definition of intelligence (Week 1's theme: "intelligence is adaptive behavior"), how the internal weights solve the mapping is secondary to the fact that the correct relationship is successfully derived.

**The Structuralist/Cognitive Argument ("No, it's an illusion"):** True arithmetic requires an internal representation of number quantity (discrete sets) and an explicit algorithmic operation (manipulating those sets). MaBouDi's model possesses no concept of "threeness" or "fourness"; it contains only Gaussian tuning curves optimized for continuous spatial frequencies. Calling this "arithmetic" is a category error—it is simply non-linear statistical pattern regression that co-opted a mathematical shortcut.

---

#### Debate Line 2: "Are you convinced?"

This section shifts the debate to the experimenter's trap and Morgan's Canon (the principle that we should not interpret an action as the outcome of a higher cognitive faculty if it can be fairly interpreted as the outcome of a lower one).

**Why MaBouDi’s Model is Highly Convincing:** The model does not just pass basic tests; it reproduces the exact high-level transfer behaviors that Howard et al. used to "prove" advanced math—including sorting zero at the bottom of a continuum and generalizing to completely novel shapes. Because continuous visual variables (edge length, convex hull, spatial frequency) naturally covary with number count, the model exploits an environmental invariant.

**The Counter-Critique (Defending Howard et al.):** Howard et al. made intentional efforts to control for absolute surface area ($10\pm0.3\text{ cm}^2$ across all shapes). For the "kill-joy" explanation to completely hold, the bee's visual processing pathways must be proved to actively prioritize spatial frequency over edge features or pattern discrimination.

---

#### Debate Line 3: What are the bees actually doing?

This connects directly to the core themes of the entire module regarding evolutionary economy and ecological reality.

**The "Lazy Evolution" Perspective:** Evolution does not build complex calculators when a simple sensorimotor shortcut is available. If a bee's miniature brain can solve a sorting or foraging puzzle by simply letting its visual lobe filters do the heavy lifting (matching Gabor-like frequency filters to reward valences), it will use that "cheap" magnitude pathway every time. The bee is a situated agent exploiting the physical features of the visual stimuli, completely bypassing the need for abstract internal working memory stacks.

**The Dual-Mechanism Compromise:** It is possible that insects possess a primitive, approximate "sense of magnitude" used for rapid, low-compute choices, but retain the cognitive plasticity to switch to discrete counting sequences (such as using an accumulator system or scanning items sequentially) when continuous cues are completely stripped away.

---

<br>
<br>
<br>

## Week 3 References/Readings

### [Swarm intelligence in animals and humans (Krause et al., 2010)](./weeks/week_3/files/week_3_lecture_collective_behaviour.pdf)

This paper unifies comparative psychology and behavioral ecology by establishing a strict definition of Swarm Intelligence (SI): the aggregation and processing of independently acquired information through social interaction to solve a cognitive problem beyond individual capacities.
- Swarm intelligence (SI), a term coined by Gerardo Beni
- "two or more individuals independently, or at least partially independently, acquire information and these different packages of information are combined and processed through social interaction, which provides a solution to a cognitive problem in a way that cannot be implemented by isolated individuals."

The authors break down direct biological interactions, explaining optimal group navigation via the "many wrongs principle" (where averaging independent directional vectors minimizes individual cognitive error) and collective choice via quorum decision-making (balancing speed and accuracy based on threshold numbers).

Crucially, the paper maps out the strict boundaries of the "wisdom of the crowd" paradigm, drawing a sharp distinction between problems of imprecision and problems of systematic bias. While large groups excel at filtering out individual imprecision (e.g., guessing items in a jar), they fail and consolidate errors when faced with complex data structures or systemic mental traps (e.g., combinatorics), where individual expert reasoning remains mathematically superior.

Ultimately, the text highlights that while animal SI acts as an evolutionary enabler for highly interdependent individuals, human electronic platforms (like prediction markets) allow human experts to weaponize collective processing as a targeted analytical tool.

Crucially, the authors note a common misconception: a group possessing functional or identity diversity is not inherently an example of SI. True swarm intelligence only occurs when the interaction and processing between those diverse individuals generates entirely new cognitive solutions.


> Krause, J., Ruxton, G. D., & Krause, S. (2010). Swarm intelligence in animals and humans. Trends in ecology & evolution, 25(1), 28-34.

--

### Swarm Robotics:  Past, Present, and Future
This paper evaluates the progression of swarm robotics from its early biological roots in exploring stigmergy to its status as a mature engineering discipline. The authors explicitly contextualize the micro-macro problem, emphasizing the severe difficulty of compiling individual agent rules to achieve complex, guaranteed macro-level performances. To bridge the simulation-reality gap, where real-world multi-agent interactions quickly degrade controllers evolved in simulators like ARGOS, the field must prioritize standardized benchmark environments and high-fidelity modeling of short-range perception. Critically, the authors highlight that properties like fault tolerance and scalability are not automatically granted by grouping robots; they require prescriptive design. To transition swarms out of the lab and into unstructured, real-world applications (such as space missions with limited CPU capabilities, precision agriculture, or micro-scale targeted medicine), future research must transcend rigid biological metaphors. This includes embracing swarm heterogeneity, building self-organizing ad-hoc control hierarchies, leveraging deep reinforcement learning for visual information fusion, and securing communication networks against malicious agents via blockchain architectures.

> Dorigo, M., Theraulaz, G., & Trianni, V. (2021). Swarm Robotics:  Past, Present, and Future. Proceedings of the IEEE, 109(7), 1152-1165.

---

<br>
<br>
<br>
<br>
<br>
<br>

# Week 4 - Moving Through the World

Lecture 4 is about the mechanisms by which agents control "movements through the world", but the real message is about the sensory systems of an agent being at the service of behaviour. We start with a Psychologist called Gibson who wanted to think about how natural behaviours depend on easily acquired information. By focusing on the information that can be "Directly" available for the control of behaviour, one thinks about the ecologically relevant information that evolution would pick up on, rather than evolution building general purpose perceptual systems where the job is to build an internal model of the world so that behaviour can be planned internally, that would be known as Indirect Perception. 

#### Learning outcomes
- Describe how both the fly and the human can be thought of in a Gibsonian way. 
- Discuss the successes and failures of biorobotics projects inspired by insect sensori-motor circuits. 

---

**Core Theme:** Sensory systems exist at the service of behavior. Rather than building complex, internal general-purpose models of the world (Indirect Perception), agents exploit ecologically relevant information that is readily available in the environment to drive immediate action (Direct Perception).

By the end students will understand that:
1. Direct perception is a way of thinking about what information is ”in the world” and can be extracted without lots of neural processing.
2. Looking at the neural circuits in the fly, we can see how animals can be tuned to Directly Perceive task relevant information.
3. Trying to “build-in” direct perception in robots is difficult because robots have to be tuned to their sensory ecology
4. Eye movements in humans are task dependent and show how humans acquire information in a just-in-time and task dependent way.

---

## 1. J.J. Gibson and Direct Perception

The psychologist J.J. Gibson developed ecological psychology during WWII after observing that abstract intelligence/vision tests failed to predict who would be a good pilot. He realized pilots didn't use abstract physics; they relied on first-person visual feedback that directly informed them how to fly.

> “Perception of the world and of the self go together and occur only over time” (Gibson, 1978)

There are two concepts that are really important to remember and think about here:
- **Embodiment:** "Robots and animals have bodies and experience the world directly" (Brooks, 1991)
- **Situatedness:** "The agent or animal is in the world: they do not deal ith abstract descriptions but with the here and now of the world directly influencing the behaviour of the system" (Brooks, 1991). Situatedness is not just the environment itself; it is the relationship and immediate interaction between the agent and its environment. 
    - A situated system has no abstract map of the world. It is embedded in the environment and its behaviour is dynamically driven by the immediate sensory inputs. Unlike aa traditional, **non-situated** AI system, like a chess programme, which operated on an abstract description of the world. 

Embodiment and Situatedness are tightly coupled to solve problems without needing heavy computing power.

**Optic Flow:** The pattern of visual motion across the retina caused by movement. Things far away (like mountains) barely move, while things close (like trees) whizz past. Gibson realised the optic flow is the consequence of an agents movement agsinst the structure of the world.

**The Pole of Expansion:** Within an optic flow field, the single point that does not appear to move (the center of expansion) is exactly where the agent is heading. If a pilot’s desired runway does not align with the pole of expansion, the visual field itself directly tells the pilot to correct their steering.

**Invariants:** Things regarding direct perception that don't change. Properties of sensory input that are universally true regardless of the environment. (e.g., The pole of expansion always equals heading, whether you are in a forest or in space).

**Affordances:** Information in the environment that directly invites or "affords" an action. The world/environment allows actions. The ability to turn handle bars to align facing the direction with pole of expansion. 

**Resonance & Matched Filters:** The idea that nervous systems are evolutionarily wired to resonate with specific invariants. An organism doesn't need to consciously "think" about avoiding an object; its brain has dedicated neural hardware (matched filters) that fires automatically when it detects specific visual patterns. The example covered in the lecture of fly's systems are automatically tuned to extract optic flow information. 

**Time to Collision (Tau - $\tau$):** An invariant mathematical property where the expansion rate of an object's contours on the retina directly correlates with the time until impact. A diving gannet or a footballer heading a ball does not need to calculate the absolute speed or distance of the ball; they just directly perceive the expansion rate to know exactly when to brace for impact.

---

## 2. The Fly as a "Gibsonian" Animal

The fly is the ultimate model of direct perception. Its visual system is a masterclass in **outsourcing computation to local hardware**.

**The Compound Eye:** Each facet (ommatidium) acts as a single pixel.

**Local Motion Detection (EMDs):** At the second level of the brain (the Medulla), Elementary Motion Detectors calculate motion by comparing signals from adjacent pixels. If a signal hits Pixel A, gets physically delayed, and matches the real-time signal hitting Pixel B, the neuron fires. This detects local movement direction.

**Global Motion (Wide-Field Neurons):** In the deep brain (Lobula Plate), massive, physically huge neurons aggregate these local signals. These are matched filters.
- **VS Cells:** Tuned exclusively to detect specific rotational flow fields (e.g., pitch or roll).
- **H Cells:** Tuned exclusively to detect translational (forward/backward) flow fields.

**Situatedness in Neural Wiring:** In the real world, things lower down (the ground) are closer and move faster than things higher up (the sky). Accordingly, the fly's H cells (looking for forward movement) are physically wired to pay more attention to the lower visual field, while VS cells (looking for rotation) pay more attention to the upper visual field to avoid noise from the passing ground.

**Embodiment & Saccadic Flight:** Rotational movement severely contaminates optic flow. Because a fly's head is lighter than its thorax, it flies in straight lines, makes an incredibly fast, sudden turn with its head (a saccade), and lets its body catch up. This keeps its visual sensors perfectly straight for as long as possible, ensuring clean translational optic flow data. (This saccadic gaze strategy is universal across humans, crabs, and birds).

The flies embodiment is its nervous system which is physically wired to pay more attention to the lower visual field for forward translation. Its head is physically light, allowing it to turn independently of its body.

It's situatedness is the "here-and-now interaction". The fly actively exploits its physical body within that environment by executing straight flights combined with rapid head turns (saccades). Because it is situated (acting directly in the moment), it uses this specific movement style to actively keep its translational optic flow data clean and unswamped by rotation.

---

## 3. Insect-Inspired Biorobotics: Successes and Failures

Engineers attempt to "build-in" direct perception to robots. These case studies highlight the importance of designing for a specific sensory ecology.

### Case Study I: Franceschini's Neurorobotics (Success)

**Design (1990s):** A mobile robot built with a panoramic ring of analog EMDs designed to avoid collisions while moving at a fast, fixed speed (50cm/s).

**Embodiment/Hardware over Software:** Instead of using a computer to calculate complex time delays for objects passing at different angles, the engineers changed the physical spacing of the sensors. Sensors at the front were placed closer together than sensors at the side. The physical body did the math, proving Braitenberg's idea of "downhill invention".

### Case Study II: The LGMD Car Collision Model (Failure/Lesson)

Design: An AI model for cars based on the Locust’s Lobula Giant Movement Detector (LGMD), a neuron that fires right before a collision.

**The Problem:** The algorithm produced false positives, hitting the brakes for cars that were just passing by. To fix this, they had to ramp up the sensitivity so high that the model became erratic.

**The Ecological Lesson:** When scientists checked the real locust, they found the LGMD is not a general collision detector. Locusts don't care about bumping into other locusts (it doesn't hurt). The LGMD is an evolutionary matched filter specifically tuned for bird beak avoidance. A bird attacks with a sudden, late, massive expansion profile. A car expands smoothly. The robot failed because a car's sensory ecology is entirely different from a locust's predator-avoidance ecology.

---

## 4. Task-Dependent Direct Perception in Humans

Human vision is not a camera recording a 3D movie; it is an active, "just-in-time" tool that extracts only the exact information needed for the immediate physical task.

**The Eye-Mind Hypothesis:** There is no lag between what the eye fixates on and what the brain processes. Eye movements (saccades) give a direct window into cognitive processing.

**Yarbus’s Eye Tracking:** When looking at a painting, human gaze paths change completely depending on the specific question asked (e.g., "Estimate their ages" vs. "What were they doing before?").

**Sandwich Making & Walking:** In complex tasks, human eyes are always one step ahead of the hands/feet.
- **Sandwich:** Look at bread $\rightarrow$ hand moves to bread $\rightarrow$ eyes immediately jump to the butter.
- **Walking:** When crossing stepping stones, you look at where your right foot will go while your left foot is still in the air. The brain uses the visual data to set the exact physical thrust required for the pivot, then instantly discards the visual memory.

As humans, we do not pre-compute and store a massive 3d map of our terrain. Instead we are acting "just-in-time" with respect to vision. We look at the next stone whilst our opposite foot is plants and collect the minimum require info for the next step, after which we immediately discard the data. The situatedness is letting the immediate here-and-now of the world drive the motor control directly.

**"What you see is what you need" (Change Blindness):** In a VR block-sorting experiment, subjects were asked to move blocks onto a conveyor belt. While the blocks were actively being carried in the subject's hand, the researchers secretly changed the block's size or color.
- **Result:** Subjects suffered from massive change blindness, only noticing the glitch 2% of the time, even when the task explicitly required sorting by size.
- **Takeaway:** The human brain acquires information just-in-time to initiate an action, and then immediately throws it away to save memory. We do not maintain a constant, updated internal model of the world.

---

## Summary Points:

**Embodiment** is the fact that you have a physical body, meaning you experience the world directly through physical sensors and actuators rather than through virtual simulations.

**Situatedness** is the fact that you are dynamically embedded in a real world, meaning your behavior is dictated by direct, real-time responses to the immediate context around you, completely bypassing the need for a complex, abstract internal blueprint of the environment.

---

## Week 4 References/Readings

### Vision and Action (Hayhoe, 2017)

Hayhoe (2017) provides the exact cognitive and neural backing for Week 4’s assertion that sensory systems are at the service of behavior. By framing vision within statistical decision theory, she demonstrates that the human brain completely bypasses David Marr's un-situated approach of building a massive, persistent 3D model of the background world. Instead, humans act as highly purposive, situated agents. We deploy gaze to sample the environment "just-in-time" to drop local uncertainty for immediate task modules, smoothly blending these sparse visual inputs with learned spatial priors via Bayesian optimization to minimize internal memory loads and computational overhead.

> Mary M. Hayhoe (2017)“Vision and Action” Annual Review of Vision Science

---

### Vision, perception, navigation and ‘cognition’ in honeybees and applications to aerial robotics (Srinivasan, 2021)

Srinivasan (2021): Vision, Perception, Navigation and 'Cognition' in Honeybees and Applications to Aerial Robotics Srinivasan synthesizes decades of visual neuroethology to demonstrate how flying insects bypass the computational requirements of 3D environmental mapping by directly weaponizing optic flow invariants. Honeybees execute robust, autonomous behaviors using localized sensorimotor control loops—including centering heuristics (equalizing bilateral lateral velocities), distance odometry (integrating global image motion), and smooth landing strategies (maintaining a constant rate of retinal image expansion). While honeybees exhibit true minimal cognition (such as cross-modal generalization of relational concepts like "sameness" and "difference"), their behavioral efficiency is deeply anchored in embodied visual filters. For engineers, this bio-inspired paradigm resolves a major bottleneck in autonomous UAV design: by trading complex, power-hungry spatial computing hardware for simple, direct optic flow processing loops, aerial robots can navigate unstructured environments, regulate flight speeds, and prevent collisions using minimal computational overhead.


> Mandyam V. Srinivasan (2021) “Vision, perception, navigation and ‘cognition’ in honeybees and applications to aerial robotics” Biochemical and Biophysical Research Communications

---

### The role of behavioural ecology in the design of bio-inspired technology (Stafford et al, 2007)

While many researchers focus solely on the neural circuitry of insects to build robots, Stafford et al. argue that engineers often fail because they ignore the behavioural ecology—the evolutionary context—that shaped those circuits in the first place.

Stafford et al. (2007) move the conversation beyond the "black box" of neurobiology. They establish that bio-inspired technology is essentially an exercise in ecological translation.

1. **Hardware is context-dependent:** Neurons are optimized for the specific challenges of an animal’s lifestyle.
2. **Mismatch of Ecology:** When we move an algorithm from a biological organism to a robot, we are changing the environment, which breaks the algorithm's evolved assumptions.
3. **Ecological Literacy:** Success in biorobotics requires more than just copying the wiring; it requires understanding the selective pressures that "tuned" the wiring in the first place.

This paper warns against the "simplistic copying" of insect behavior. It demands that you consider whether the situatedness of the robot (its environment, speed, and sensor range) aligns with the evolutionary niche of the animal the robot is mimicking.

> Stafford et al (2007) “The role of behavioural ecology in the design of bio-inspired technology” Animal Behaviour

---

<br>
<br>
<br>
<br>
<br>

# Week 5 - Navigation

In the navigation lecture, we will look at the strategies that are common to different animals and how those strategies might be combined. The core strategies are Path Integration (PI) and view based guidance. We will then consider what behaviours would be the hallmark of an internalised Cognitive Map, we will see limitations in the navigational abilities of insects and by looking at the neural substrate of navigational abilities in mammals, we can see where in the brain complex spatial abilities might reside.

#### Learning outcomes
- Understand the basic navigation toolkit that is phylogenetically widespread and shared by most animals. 
- Think about how some animals might combine navigational information to make more complex spatial representations.
- Describe different robot navigation algorithms that do or don't rely on building maps.
 
---

## Week 5 Lecture Notes

**Defining Spatial Cognition:** Navigation is the study of how large- and small-brained animals process information to move through space and understand their locations.

**Lecture Structure:** The lecture is broken down into four parts: (1) universal components of the navigational toolkit, (2) navigation in insects, (3) how big brains combine information to build cognitive maps, and (4) how roboticists translate these ideas into navigational algorithms.

---

### Part 1: The Universal Navigational Toolkit

There are phylogenetically widespread building blocks of navigation shared across almost all animal species.

#### 1. Walking in a Straight Line
Walking in a straight line is crucial for basic survival, such as keeping a consistent heading during migration or quickly escaping a location.  

**Dung Beetles (Dacke et al., 2013):** Nocturnal dung beetles must roll their dung balls away from the main pile in a straight line as quickly as possible to stop other beetles from stealing them. If external cues (like the moon or the Milky Way's starry sky) are visible, they produce highly straight paths. If the starry sky is occluded, their paths become highly tortuous and looping.

**Humans (Souman et al., 2009):** Humans also require external cues to walk straight. In woodland experiments, subjects walked relatively straight on sunny days but walked in loops on cloudy days. Blindfolded subjects on a flat beach produced highly tortuous paths, later incorrectly justifying their wandering by claiming the wind kept changing direction (failing to realize they themselves were turning).  

---

#### 2. Basic Sense of Direction & Learning
Most animals universally possess a "sense of direction" and the ability to learn basic visual cues to return to a starting location.  

While animals can memorize what a nest looks like, this visual matching can fail in repetitive, artificial environments; for instance, von Frisch (1974) noted birds building multiple nests along an identical-looking bicycle shed.  

---

<br>
<br>

### Part 2: Insect Navigation (Embodiment & Situatedness)
Insects (e.g., Cataglyphis bicolor, Apis mellifera, Melophorus bagoti) are "navigation experts," making them ideal models for studying phylogenetically widespread building blocks of spatial cognition.  

---

#### 1. Path Integration (PI)

PI (Wehner & Wehner, 1992) allows an animal to encode its coordinates relative to its nest, enabling a direct return path without prior knowledge of the terrain. It requires a constant sense of direction and an estimate of distance/speed.

**Sense of Direction (The Sun Compass):** Santschi (1923) demonstrated that ants use the sun for direction by using a mirror to reflect the sun from the opposite side, causing the ant to instantly turn around. Dyer and Dickinson (1996) showed that bees possess innate knowledge of how the sun moves; bees kept indoors all morning still accurately adjust their afternoon waggle dances to account for the sun's morning movements.

**Estimating Distance (Walking vs. Flying):**
- **Ants (Stride Counters - Wittlinger et al., 2006):** A walking insect can monitor leg movements to measure distance. Ants with shortened legs ("stumps") underestimated their home distance, while ants with artificially lengthened legs ("stilts") overestimated it.
- **Bees (Optic Flow):** Uncertain winds mean flying insects cannot rely on motor output, so they rely on optic flow. Srinivasan et al. (2000) showed bees artificially over-estimate distance when flown down narrow, visually dense tunnels. Tautz et al. (2004) showed bees underestimate distance when flown over featureless water.

**Errors in PI:** Path Integration accumulates errors in both distance and direction. Wolf and Wehner demonstrated that an ant's search density broadens significantly as the length of the PI vector increases (e.g., 5m vs 10m vs 20m).

---

#### 2. From PI to Habitual Routes

To mitigate PI errors, individual foragers transition to learning idiosyncratic, stable routes (Wehner, Meier and Zollikofer).

**Mature Routes (Kohler and Wehner):** Experienced foragers demonstrate world knowledge through habitual routes that are independent of PI and not reliant on a rigid learned sequence of motor behaviors.

**A Universal Strategy:** We are all creatures of habit. Habitual routing is seen across taxa: Pigeons (Biro et al., 2004), Rats (Calhoun, 1963), Monkeys (Di Fiore and Suarez, 2007), Humans (Dee, 2005), and Ants (Mangan and Webb, 2012).

Animals prioritize route consistency over mathematical efficiency. Pigeons, monkeys, rats, and even humans traversing a campus will follow idiosyncratic, habitual paths rather than taking a direct, straight line ("as the crow flies"), prioritizing familiar landmarks to reduce navigational errors.

---

#### 3. Navigation by Image Matching

**The Ant's View (Graham and Cheng, 2009):** Ants possess panoramic but highly low-resolution vision (roughly 1000 pixels). They can navigate successfully using crude visual representations, such as simply tracking the height of dark objects above the horizon.

**Snapshot Homing (Zeil, 2003):** Because visual images change smoothly as an animal translates or rotates through space, the animal simply moves to make its current view match its stored memory, following the "image difference gradient".  

**Visual Compass (Wystrach et al., 2014):** Animals use views to recall actions, not places. An ant stops, visually scans by turning on the spot, and moves forward when the view matches its memory.  

**Familiarity-Based Route Navigation (Baddeley et al., 2012):** In this model, an agent inputs views to a single-layer Artificial Neural Network (ANN). Using an "Infomax" learning rule, the weights are updated to increase the familiarity of the view, completely discarding the actual image memory. To navigate, the agent visually scans the world and moves in the "most familiar" direction.  

---

#### 4. The Limits of Insect Navigation (Insects Insulate, Not Integrate)

**Wehner et al. (2006):** Ants were trained with spatially separate outbound and inbound routes. When inbound ants were displaced to a familiar point on their outbound route, they were completely lost.

Insects do not integrate their memories; they insulate them based on motivational context.  

Insect navigational memories are highly context-dependent.  If a foraging ant on her way home is picked up and placed at a highly familiar location on her outward journey, she will be completely lost. The outward and inward routes are stored as separate memories and require a motivation shift to be accessed; they are not integrated into a unified map.  

---

<br>
<br>

### Part 3: Big Brain Navigation (Cognitive Maps)
Behavior and neurophysiology suggest that vertebrates combine learned visual information with idiothetically generated information.  

---

#### 1. Combining Modalities (Etienne et al., 2004)
- Hamsters were familiarized with a visually rich arena.  
- When the arena was secretly rotated 135 degrees in the dark, hamsters used PI to return to the nest.  
- However, if given a short visual fix (lights turned on briefly), the hamsters were able to successfully reset their PI coordinates to match the visual landmarks, proving vertebrates combine visual and idiothetic information.

---

#### 2. The Neural Substrate (The Hippocampus)
John O'Keefe, May-Britt Moser, and Edvard Moser won the 2014 Nobel Prize for discovering the brain's navigation system.  

**Place Cells:** Firing is tied to visual landmarks and is specific to a location (independently of orientation), but they also maintain their firing in the dark using PI.  

**Head Direction Cells:** Encode direction independently of location.  

**Grid Cells:** Provide a hexagonal array of firing fields, with cells in different layers having different scales but the same orientation.  

**Situatedness (Geva-Sagiv et al., 2015):** A rat’s spatial cells operate largely in 2D. Because bats fly, their place cells represent 3D volumes (Azimuth × pitch × roll), showcasing how embodiment dictates neural structure.  

---

#### 3. Critique of the "Map" Metaphor
The 'cognitive map' metaphor is top-down, anthropomorphic, and fails to address behavioral output.  

**Impossible Mazes (Schnapp & Warren, 2007; Glennerster, 2016):** Human subjects are not impaired when navigating in impossible VR mazes (containing "wormholes") that geometrically cannot be mapped. 

In VR experiments containing non-Euclidean "wormholes" that magically transport subjects across a map, humans navigate the glitch flawlessly without noticing the physical impossibility, suggesting human navigation relies more on route heuristics than true geometric maps.

Furthermore, humans who successfully navigate a route are often poor at producing a drawn map of it, and these maps do not improve across years of experience.  

---

<br>
<br>

### Part 4: Robotic Navigation

How cutting-edge robot navigation algorithms combine sensory inputs.  

#### 1. SLAM (Simultaneous Localisation and Mapping)

**The Concept:** The robot senses the positions of features in the world, moves, senses them again, and updates its position estimate based on how features should have moved.  

**Bayesian Integration:** Estimates take account of sensory uncertainty; the algorithm combines probabilities (e.g., visual vs. auditory data) using Gaussian distributions to find the most likely true position.  

**Loop Closure:** As the robot moves, its positional uncertainty grows. When it recognizes a previously seen feature (loop closure), it resets its uncertainty and updates the entire map

---

#### 2. SLAM Variants & Hardware

**Monocular to LIDAR:** SLAM has evolved from single-camera systems (like Andrew Davison's monocular SLAM) to stereo vision, RGB-D, and now real-time 3D LIDAR scanning.

**Odometric SLAM:** Given a pre-built map, robots (like the Omron cleaning robot) focus on tracking their position very accurately using improved Inertial Measurement Units (IMUs) and fast visual sampling, completely bypassing the need to constantly build new maps.

**Summary:** SLAM provides a mathematical framework to integrate remote sensing and idiothetic info, but it is computationally expensive and does not explain how animals navigate. Insects prove that learning routes via procedural heuristics is much more computationally efficient.

---

## Week 5 References and Readings

### Insect Navigation. (Graham, 2010)

This comprehensive review outlines the phylogenetically widespread, bottom-up mechanisms insects use to navigate without centralized cognitive maps. Graham details how insects rely on Path Integration (PI) for basic dead reckoning, using an internal sun compass paired with embodiment-specific odometers—such as proprioceptive step-counting in walking ants and optic flow integration in flying bees. Because PI accumulates mathematical errors over distance, insects supplement it with view-based navigation, storing 2D retinotopic "snapshots" of goal locations during stereotyped learning flights. Ultimately, insects transition from PI to highly idiosyncratic, habitual routes consisting of procedural instructions and local vectors tied to specific visual landmarks. Crucially, the author highlights that insect spatial memories are strictly insulated by motivational context (e.g., inbound vs. outbound journeys) rather than integrated into a unified geometric framework, strongly challenging the notion that insects possess true cognitive maps.

> Graham (2010) Insect Navigation. Elsevier Encyclopedia of  Animal Behaviour.

---

### Spatial cognition in bats and rats: from sensory acquisition to multiscale maps and navigation (Geva-Sagiv et al., 2015)

This review paper bridges the conceptual gap between ecological studies of large-scale animal navigation and neuroscientific studies of small-scale laboratory spatial mapping. Focusing on bats and rats, the authors explore how "active sensing" mechanisms—such as the dynamic tuning of bat echolocation pulses or rat whisking rates—dictate the resolution of sensory input, which directly determines the spatial resolution of hippocampal place fields. The authors detail the allocentric neural building blocks of mammalian navigation, including place cells, grid cells, border cells, and head-direction cells. Crucially, they highlight the "mega-map" problem: standard laboratory-sized place fields cannot mathematically tile a wild animal's multi-kilometer home range. To solve this, they propose that the mammalian brain utilizes multiscale spatial representations, combining anatomical gradients (place fields scaling up 10-fold along the dorsoventral hippocampal axis) and theoretical "combinatorial grid codes" to efficiently represent vast natural environments. Finally, the paper demonstrates how situatedness shapes neural architecture, noting that 3D-flying bats possess volumetric 3D place cells and toroidal head-direction cells, unlike 2D-walking rats.


> Geva-Sagiv et al. (2015) Spatial cognition in bats and rats:  from sensory acquisition to multiscale maps and  navigation, Nature Rev. Neurosc

---

### Do animals have cognitive maps? (Bennet, 1996) 

This critical review argues that the concept of the "cognitive map" has lost its scientific utility due to contradictory definitions and a widespread failure to apply rigorous behavioral testing. While some researchers loosely define a cognitive map as any spatial representation (e.g., Gallistel), the classic and most rigorous definition (sensu Tolman, O'Keefe, and Nadel) requires an animal to demonstrate novel short-cutting between two familiar points. Bennett argues that to conclusively prove the existence of a cognitive map, researchers must first eliminate three simpler explanations for this short-cutting behavior: previous traversal of the route, path integration (dead reckoning), and the simple visual recognition of familiar landmarks from a new angle (basic route-following). Upon reviewing major spatial memory studies across insects (e.g., Gould's honeybees), birds, rodents, and primates, Bennett concludes that no experiment has successfully eliminated these "killjoy" alternatives. Consequently, he asserts there is no conclusive behavioral evidence that any animal possesses a true cognitive map, warning against the continued use of this anthropomorphic and confusing metaphor in comparative psychology.

> Bennet (1996) Do animals have cognitive maps? JEB

---

<br>
<br>

## Week 5 Seminar

We will be discussing a simple computational model describing how house hunting ants select new nest sites. The modelling paper will form the basis of your modelling report assignment (should you choose to do that), so do make sure you read it before the seminar so you get the most out of the session. We will also be working with the model in the next lab class

> Robinson, E.J., Franks, N.R., Ellis, S., Okuda, S. and Marshall, J.A., 2011. A simple threshold rule is sufficient to explain sophisticated collective decision-making. PloS one, 6(5), p.e19981.

There are also some other papers which may help you understand the above. They are not essential reading, but if you do complete the modelling assignment then I strongly recommend you read both while you are working on your coursework
- The supplementary methods for the above paper: Robinson et al (2011) - Supplementary methods
- An empirical paper that motivated the modelling paper. This introduces the behaviour that the modelling paper modelled: Robinson et al (2009). Do ants make direct comparisons?

> Robinson, E.J., Smith, F.D., Sullivan, K.M. and Franks, N.R., 2009. Do ants make direct comparisons?. Proceedings of the Royal Society B: Biological Sciences, 276(1667), p.2635.

***Note, could this be an interesting paper? Reina, A., Marshall, J.A., Trianni, V. and Bose, T., 2017. Model of the best-of-N nest-site selection process in honeybees. Physical Review E, 95(5), p.052411.***

---

<br>

### A simple threshold rule is sufficient to explain sophisticated collective decision-making (Robinson et al., 2011)

This study investigates the mechanisms behind collective decision-making in house-hunting rock ants (Temnothorax albipennis), challenging the assumption that individual scouts use complex cognitive strategies like "best-of-n" direct comparisons or quality-dependent recruitment latencies. Through Markov-chain simulations, analytical modeling, and empirical RFID tracking of individual ants, the authors demonstrate that a highly parsimonious, memoryless "threshold rule" is sufficient to account for optimal colony-level choices. Under this rule, a scout simply evaluates a nest against her own fixed internal quality threshold; if it passes, she accepts it and recruits, and if it fails, she rejects it and continues searching without remembering the rejected site. The researchers proved that apparent "comparison" and "hesitancy" behaviors observed in previous studies are merely emergent macro-level byproducts of this simple binary rule. Ultimately, the study concludes that by outsourcing the comparison process to the collective (using quorum sensing to aggregate absolute, non-comparative individual evaluations), the colony escapes the cognitive costs and irrational distractor effects associated with individual comparative evaluation, achieving a highly rational group consensus from simple, partly-informed agents.

---

**Week 2 (Morgan's Canon & Killjoy Explanations):** This paper is the ultimate application of the "killjoy" framework. Observers previously anthropomorphized the ants, assuming they were making cognitive comparisons. Robinson et al. apply Morgan's Canon to prove that a lower-level faculty (a binary threshold rule) perfectly explains the higher-level phenomenon.

**Week 3 (Collective Intelligence & Emergence):** This paper demonstrates how complex global outputs (the whole colony picking the optimal nest) emerge purely from simple, local interactions (individuals applying binary threshold rules). It highlights that group-level complexity does not require individual-level complexity.

**Week 5 (Seminar Focus):** This model serves as the foundational text for the modeling assignment. It translates biological observation into a programmable algorithm (Markov states), proving that "memoryless" systems can generate optimal spatial decision-making.


---

### The Markov-Chain Modeling Approach
In Robinson et al. (2011), the researchers abstract the cognitively complex behavior of house-hunting ants into a Markov process to evaluate the minimum computational rules required for collective decision-making.

A Markov-Chain is a memoryless system. The probability of a future state (or step) depends only the agents current state and immediate context, not on its cumuliative past history. 

This mathematical framework perfectly fits a "killjoy" explanation, as it allows the researchers to test if ants can make optimal colony-level choices without remembering or comparing previously visited nests.

---

In this model, each scouting ant is an independant instantiation of a Markov process moving through distinct behavioral states. The authors model 5 primary states (though code/analytically simplications are made):

1. **Assessing Home Site:** This is the starting state for all simulated ants. Because the old nest is destroyed and uninhabitable, its quality is set to negative infinity ($-\infty$), meaning an ant can never accept it and must immediately transition out to find a new site. 
2. **Assessing Poor Site:** The ant has randomly discovered a low-quality nest and is actively evaluating it.  
3. **Assessing Good Site:** The ant has randomly discovered a high-quality nest and is actively evaluating it.  
4. **Committed to Poor Site:** This is an absorbing state. If the poor nest happens to pass the ant's threshold (due to assessment error or a naturally low threshold), she permanently locks into this state, halts her search, and begins recruiting nestmates.  
5. **Committed to Good Site:** This is also an absorbing state. The ant has accepted the good nest, locked into this state, and begins active recruitment.  

---

An ant's progression through the Markov chain is governed by strict probability matrices based on the layout of the arena and the ant's simple threshold rule:

**The Search Phase:** If an ant is in an "Assessing" state (state 2 or 3) and the nest fails to exceed her internal threshold ($b_i + \epsilon \le a$), she transitions back to a random search to find the next nest.

**The Probability of Rediscovery ($r$):** When an ant rejects a nest and continues searching, she does not intentionally avoid it (as she has no memory). There is a fixed probability ($r$) that a randomly searching scout will accidentally rediscover and re-enter the exact same nest she just left.  

**The Jump to Commitment:** The transition from an "Assessing" state to a "Committed" state is entirely binary. If the nest quality ($b$), plus an individual assessment error ($\epsilon$), exceeds the ant's internal threshold ($a$), she enters the corresponding absorbing state. 

---

Mathematically, the simplified transitions between these states are represented in a state transition matrix ($Q$)

$$Q = \begin{pmatrix} 
(1-p)r & (1-p)(1-r) & 0 & 0 \\ 
(1-g)(1-r) & (1-g)r & 0 & 0 \\ 
p & 0 & 1 & 0 \\ 
0 & g & 0 & 1 
\end{pmatrix}$$

- $p$ = The average per-visit probability that an ant accepts the poor site.  
- $g$ = The average per-visit probability that an ant accepts the good site.  
- $r$ = The probability that a randomly searching scout rediscovers the site it has just departed.  

---

By calculating the fundamental matrix of $Q$, the researchers could analytically derive the expected number of steps (and time) required for the system to hit an absorbing "committed" state. This mathematically proved that quality-dependent hesitancy (recruitment latency) naturally emerges as a geometric side-effect of the transition steps when a single nest is available, but disappears when multiple nests compete for the memoryless ants.

---

The column-stochastic matrix is structured based on a simplified four-state Markov chain where the states are ordered as follows: (1) Assessing Poor Site, (2) Assessing Good Site, (3) Committed to Poor Site, and (4) Committed to Good Site.
- Each column represents the current state
- each row represents the next state

---

**The Individual Parameters:**
The matrix relies on three core variables, which are colony-wide averages derived from individual threshold and error distributions:  
- `$p$:` The probability that an ant accepts the poor nest on any given visit.  
- `$g$:` The probability that an ant accepts the good nest on any given visit.  
- `$r$:` The spatial probability that an ant, after rejecting a nest and wandering back into the arena, accidentally rediscovers the exact same nest she just left.
- `$(1-r)$:` The inverse probability that the searching ant wanders off and discovers the alternative nest instead.

---

**Column 1: Current State = Assessing Poor Site:**
- **Row 1: Next State = Assessing Poor Site $\rightarrow (1-p)r$** (Rejects poor, rediscovering it).  
- **Row 2: Next State = Assessing Good Site $\rightarrow (1-p)(1-r)$** (Rejects poor, switching to good).  
- **Row 3: Next State = Committed to Poor $\rightarrow p$ **(Accepts poor, transitions to commitment).  
- **Row 4: Next State = Committed to Good $\rightarrow 0$** (Cannot instantly commit to a good nest from here). 

---

**Column 2: Current State = Assessing Good Site:**
- **Row 1: Next State = Assessing Poor Site $\rightarrow (1-g)(1-r)$** (Rejects good, switching to poor).
- **Row 2: Next State = Assessing Good Site $\rightarrow (1-g)r$** (Rejects good, rediscovering it).  
- **Row 3: Next State = Committed to Poor $\rightarrow 0$** (Cannot instantly commit to a poor nest from here).  
- **Row 4: Next State = Committed to Good $\rightarrow g$** (Accepts good, transitions to commitment).  

---

**Column 3: Current State = Committed to Poor Site:**
- **Row 3: Next State = Committed to Poor Site $\rightarrow 1$** (It is an absorbing state; the ant stays permanently committed). All other rows in this column are $0$. 

---

**Column 4: Current State = Committed to Good Site:**
- **Row 4: Next State = Committed to Good Site $\rightarrow 1$** (Also an absorbing state; the ant stays permanently committed). All other rows in this column are $0$.

---

<br>
<br>
<br>

**Matrix Partitioning & Sub-Matrices:**
To analyze long-run behavior and decision speeds, the column-stochastic transition matrix $Q$ is partitioned into transient and absorbing blocks:

$$Q = \begin{pmatrix} 
T & \mathbf{0} \\ 
R & I 
\end{pmatrix}$$

---

$T$ (Transient Sub-matrix): A $2 \times 2$ matrix tracking the probabilities of a searching ant moving between active evaluation states (Assessing Poor vs. Assessing Good).

$$T = \begin{pmatrix} 
(1-p)r & (1-g)(1-r) \\ 
(1-p)(1-r) & (1-g)r 
\end{pmatrix}$$

---

$R$ (Absorbing Transition Sub-matrix): A $2 \times 2$ matrix tracking the probabilities of an actively assessing ant accepting its current site and transitioning into permanent commitment.

$$R = \begin{pmatrix} 
p & 0 \\ 
0 & g 
\end{pmatrix}$$

---

**$I$ (Identity Matrix):** Represents the absorbing commitment states; once an ant commits, the probability of remaining committed is 1.

---

**$\mathbf{0}$ (Zero Matrix):** Indicates it is impossible for a committed ant to revert to searching or assessing.

---

#### **Core Linear Algebra Applications:**

##### **Matrix Inversion: The Fundamental Matrix ($N$):**

**Function:** Calculated by subtracting the transient matrix $T$ from an identity matrix ($I$) and inverting the result:

**Interpretation:** Every entry in $N$ specifies the exact expected number of visits an ant will make to a transient evaluation state before ultimately getting absorbed into commitment.

$$N = (I - T)^{-1}$$

---

##### **Vector Summation: Calculating Expected Decision Time:**

**Function:** Summing the column entries of the Fundamental Matrix $N$ reveals the overall expected latency before an individual accepts a nest.

**Derivation of Equation (2):** Algebraically expanding this matrix inversion and column summation directly yields the paper's core latency formula:

$$\text{E}(\text{time to accept any site}) = \frac{4(1-r) + 2r(p+g) - p - g}{2((2-r)pg + (1-r)(p+g))}$$

---

##### **Matrix Multiplication: Absorption Probabilities ($B$):**

**Function:** Multiplying the transition sub-matrix $R$ by the Fundamental Matrix $N$.

**Interpretation:** Matrix B outputs the definitive mathematical probability that a colony's scouts will split and commit to the good nest versus the poor nest based on initial discovery conditions. This proves that group-level consensus can emerge automatically from an absolute, memoryless threshold rule.

$$B = R \times N$$

---

<br>
<br>

### Seminar Slides/Session

#### Part 1: Standalone Content (Background & Context)

**The "Wisdom of the Crowds":** The session introduces the concept that a collective can make better decisions than an individual. This is historically demonstrated by Francis Galton’s 1907 experiment, where a crowd at a fair guessed the weight of an ox; while individuals were wrong, the aggregated average guess (1207 lbs) was remarkably close to the true weight (1198 lbs).

**Human vs. Animal Collectives:** Studying collective decision-making in humans is difficult due to confounding variables like language, shifting biases, and varying abilities to express confidence. Therefore, studying species without language (like ants) provides a cleaner model.

**Rock Ant Ecology (Temnothorax albipennis):** These ants live in rocky cliff cavities and have highly variable "work ethics" among the workers (some idle, some specialists).

**The Migration Cycle:** When a nest is destroyed, the colony follows a strict sequence: Scouts are sent out $\rightarrow$ Quality is assessed $\rightarrow$ Workers are recruited via "tandem runs" $\rightarrow$ Once a "quorum" (threshold number of ants) is reached at the new nest, the behavior switches from slow tandem running to rapidly carrying the remaining members.

**Tandem Runs:** A distinct recruitment method where a leader ant guides a naive follower. It relies on physical contact; if the follower breaks contact with the leader's hind legs/gaster, the leader stops and waits.

---

#### Part 2: Extracts from the Papers

The seminar relies on three distinct papers by Robinson and colleagues to build the argument that individual ants do not perform complex comparisons.

---

**1. Robinson et al. (2009): Do ants make direct comparisons? (Empirical)**
- **Methodology:** 9 colonies were forced to emigrate in a 120cm arena containing one poor nest (light) and one good nest (dark/red filter). Individual ants were tracked using microscopic RFID tags.
- **Findings:** The study tracked "uninformed switching". Ants that found the near (poor) nest first often switched to searching and found the other nest. Ants that found the far (good) nest first almost exclusively stayed there. Crucially, the data showed that ants visiting both nests before recruiting did not statistically favor the good nest, heavily implying they do not make direct comparisons.

---

**2. Robinson et al. (2014): How collective comparisons emerge... (Empirical)**
- **Methodology:** Researchers used an automated solenoid door system connected to the RFID tags to physically manipulate information access. In the experimental condition, if an ant visited the good nest, the doors barred it from visiting the poor nest, forcing a "no-comparisons" environment.
- **Findings:** At the colony level, decision speed and accuracy were remarkably similar whether comparisons were allowed or artificially prevented. At the individual level, when ants were prevented from comparing, they ended up visiting the poor nest slightly more often, but the overall group choice remained robust.

---

**3. Robinson et al. (2011): A Simple Threshold Rule... (Modelling)**
- **Methodology:** The slides walk through the Markov-chain model we discussed previously. It outlines the parameters (threshold $a$, quality $b$, error $\epsilon$, and rediscovery probability $r$) and steps through the generation of the State Transition Matrix ($Q$). The goal of the paper is to test the threshold rule. 
- **Findings:** The slides present side-by-side bar charts showing that the Monte Carlo simulation perfectly reproduced the empirical stay/switch behavior from the 2009 paper. Furthermore, the simulation proved that recruitment latency (hesitation) exists when a single poor nest is presented, but naturally disappears (becomes Non-Significant) when multiple competing nests are presented together.

---

#### Part 3: Seminar Discussion Points & Questions

---

**On the 2009 Behavioral Expectations:**

> **What behaviours or patterns would you expect to see if ants make direct comparisons?**
> 
> We would expect to see mutliple visits from most ants demonstating a direct comparative strategy, excersiing working memory to store and compare nests. 
> 
> From the Ants that visited the good quality nest as their sample, we would expect a heavy indiviudal bias towards the good nest, including signficant preferentially return to and lead tandem runs to the high-quality nest, regardless of the chronological order in which the nests were discovered.
> 
> And possibly we would see the lack of single arrival decisions, i.e. arrive at the good nest and not explore anymore as the ants are seeking something to compare it to. Although this assumes the mechanism doesn't apply to long to term memory where they can compare new nests to a historical average.

<br>
<br>

> **What behaviours would you expect if they make sequential comparisons?**
> 
> Under a sequential comparison framework governed by a simple threshold rule, an individual ant is completely "memoryless". She evaluates her current nest against an absolute internal threshold without any cross-reference to previously visited sites.
> 
> If the case, we should see the production of a high baseline sample of anys leaving the poornest and continuing a random search. 
> 
> We should also see a trend whereby anys who land on the good nest randomly first instantly commit with zero switching behavior (This one important because comparison based systems would not do this)

<br>
<br>

> **What behaviours would you expect if recruitment latency determines nest selection?**
> 
> The recruitment latency hypothesis states that ants accept any nest they find but vary their "hesitation time" before recruiting based on nest quality.
> 
> If this mechanism drove nest selection, tracking individual RFID tags would reveal a clear, statistically significant difference in individual "entry-to-recruitment" durations when the nests are presented together. Scouts at the poor nest should exhibit a prolonged latency period before launching a tandem run compared to the rapid initiation shown by scouts at the good nest.
> 
> Note for Context: Robinson et al.'s 2011 Markov model beautifully demonstrated that while individual latency differences are real when options are presented separately, they statistically disappear when choices are presented together. This proves that "latency" is not an internal clock mechanism, but rather a structural byproduct of ants repeatedly rejecting and exiting a poor nest

<br>
<br>

> **Why is switching informative?**
> 
> Switching—where an ant makes an independent visit to one nest and subsequently transitions to the other—is the most informative behavioral metric because its direction and outcome break the mathematical stalemate between competing cognitive theories.
> 
> Determining if ants behaviour can be categorized switching from "Near to Far" or "Far to Near", we can isolate and infer whether it is possible for a threshold to be the applied mechanism. An extreme asymmetry (high switching from poor nests, near-zero switching from good nests) directly supports an absolute threshold rule over a relative comparison rule.
> 
> **It Isolates "Informed" vs. "Uninformed" Actions:** If ants who switch and accumulate dual-site experience show a random ($p \approx 0.99$) distribution in where they lead their subsequent tandem runs, it provides airtight evidence that the colony-level preference for the superior nest is entirely an emergent property. It proves that collective choice can be successfully executed by individuals completely devoid of comparative cognitive architecture.


---

**On the 2014 Automated Door Experiment:**
> **Any differences between real-world house-hunting and the experiment?**
> 
> The setup of the experiement itself imposed artifical environmental and physical contraints that are abstract to the natural, real-world expereiences of colony relocation. 
> 
> The experiment presents a strict choice between two isolated options. In the wild, nest choices are multi-alternative, highly complex, and embedded in a wider sensory landscape.
> 
> The experiement utilises a solenoid door system to track the RFID tags. However, in nature, space is continuous allowing an ant to wander freely between "options" without physical constraints. 
> 
> To isolate individiaul behaviour, ants are seperated and conduct their search and behaviour in isolation. RL intractations between ants provide the potential for exchange in chemical or behavioural information which we already know they are capable of in some capacity due to pheremonal trails (paper) and leading behaviour (paper). 

<br>
<br>

> **What results would you expect to see if ants do need to compare vs if they do not need to compare?**
> 
> **If individual comparisons are necessary:** Artificially barring ants from visiting both nests (the "no-comparisons" treatment) should completely break down the colony's ability to reach a correct consensus. We would expect to see a severe drop in decision accuracy (frequent colony splitting or choosing the poor nest) and a massive spike in decision time, as the individual-level constraint would directly stall the colony-level selection process.
> 
> **If individual comparisons are not necessary:** The colony should succeed regardless of individual restrictions. If collective choice is an emergent byproduct of decentralized, independent actions, then preventing individuals from cross-visiting both sites should leave the colony's global decision speed and accuracy entirely unimpaired.

<br>
<br>

> **What did the authors show, and what does this mean with respect to collective decision-making?**
> 
> What they showed: The authors proved that the colony-level decision was virtually identical across both setups. Global decision speed remained exactly the same (a median of 38 minutes for both conditions), and decision accuracy was uncompromised. At the individual level, when ants were barred from comparing, they visited the poor nest more frequently and persevered longer, yet the global outcome remained robust.
> 
> **What this means for collective decision-making:** It provides elegant empirical proof that **collective comparison can emerge without individual comparison**. Group-level cognitive complexity does not require individual-level cognitive complexity. Instead, a highly accurate "best-of-n" choice can be executed by a distributed system composed of partly informed, memoryless agents

<br>
<br>

> **What cognitive abilities are needed for "Direct comparison" versus "Evaluation against a threshold"?**
> 
> 
> | Cognitive Attribute | Direct Comparison ("Best-of-n") | Evaluation Against a Threshold |
> | :--- | :--- | :--- |
> | Memory Load | High. Requires a working memory buffer to encode, store, and recall the specific sensory attributes of Nest A while physically evaluating Nest B. | Minimal/None. Entirely memoryless; requires no storage of previously visited alternatives. |
> | Computational Complexity | High. Requires a comparative, relative evaluation algorithm to weight values against each other, calculate a difference vector, and adjust behavioral output accordingly | Low. Executes a simple, absolute binary check ($b_i + \epsilon > a$) against a pre-set internal metric. |
> | Risk of Irrationality | High. Susceptible to relative framing errors, transitivity failures, and irrational "distractor effects" when a third, irrelevant option is introduced. | Immune. Absolute evaluation means the appraisal of one option is entirely independent of what other alternatives exist in the environment |
> 

---

**On the 2011 Markov Model:**

> **How well does the model reproduce ant behaviour?**
> 
> The simple threshold model reproduces both individual- and colony-level empirical ant behavior exceptionally well, providing a highly accurate, parsimonious match to several real-world datasets:
> 
> Stay vs. Switch Asymmetry: When parameterized to a layout featuring a nearby poor nest and a distant good nest, the Monte Carlo simulations perfectly match the empirical data. It correctly reproduces the pattern where ants finding the good nest first "stay" (commit), while ants finding the poor nest first routinely "switch" to find the alternative.
> 
> Resolving the Latency Paradox: The model successfully resolves a long-standing paradox in the literature regarding recruitment latency (hesitation time). It perfectly replicates quality-dependent recruitment latency when a single nest is presented separately, but also correctly predicts that this difference completely disappears when nests are presented together.
> 
> Predicting Multi-Alternative Choices: When used to predict the outcome of the new "Three-New-Nests" experiment, the model accurately predicts the precise number of ants that split between returning to a good nest versus discovering a third equidistant option, matching real-world behavior within 95% confidence intervals.
> 



> **What cognitive abilities does it assume ants have?**
> 
> In alignment with Morgan’s Canon, the model actively strips away high-level cognitive assumptions, demonstrating that sophisticated global choices can be executed with a remarkably primitive psychological toolkit:
> 
> Absolute (Non-Comparative) Evaluation: The model assumes ants are completely memoryless regarding alternative options. Individual ants are assumed to lack a working memory buffer; they do not remember previously visited nests, they cannot hold multiple site qualities in their minds simultaneously, and they are incapable of calculating relative differences between alternatives.
> 
> A Simple Binary Rule: The only cognitive mechanism required by an individual agent is an absolute binary threshold check. The ant simply reads the objective quality of its current nest ($b_i$), factoring in a standard degree of sensory assessment noise ($\epsilon$), and checks if it exceeds a fixed internal threshold ($a$). If $b_i + \epsilon > a$, the ant enters a state of permanent commitment; otherwise, it exits and continues a entirely random spatial search. 
> 
> Post-Commitment Implementation Memory: Crucially, the paper clarifies that while the decision process itself is memoryless, real ants must transition to using spatial memory after the choice is made. Once an ant triggers its threshold and commits, it uses localized visual navigation and memory to reliably lead tandem runs back and forth to implement the colony's choice.
> 

---

# Week 6 - Motor Control