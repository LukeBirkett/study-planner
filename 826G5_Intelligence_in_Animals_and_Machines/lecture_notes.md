# Lecture Notes

- [Week 0 - Preliminary](#week-0---preliminary)
    - [Essential Reading](#essential-reading)
        - [Towards a bottom-up perspective on animal and human cognition](#towards-a-bottom-up-perspective-on-animal-and-human-cognition)
        - [Animal cognition](#animal-cognition)
        - [Understanding intelligence](#understanding-intelligence)
        - [Cognition, evolution, and behavior](#cognition-evolution-and-behavior)
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
---
- [Week 3 - Collective Intelligence]()
- [Week 4 - Moving Through the World]()
- [Week 5 - Navigation]()
- [Week 6 - Motor Control (Lab 4)]()
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

### Towards a bottom-up perspective on animal and human cognition
[link](./weeks/week_0/files/towards_bottom_up.pdf)

*This is an essential article which explains the key logic of the approach to intelligence that we take in this module.*

This foundational paper by Frans de Waal and Pier Francesco Ferrari (2010) argues for a paradigm shift in comparative psychology away from traditional, human-centered "top-down" frameworks.

Historically, research has focused on the "pinnacles" of mental evolution by asking binary, all-or-nothing questions—such as whether a non-human animal possesses a full "Theory of Mind," true culture, or language. The authors critique this approach for drawing arbitrary dividing lines between taxa and failing to uncover the actual mechanisms at play.

Instead, they champion a bottom-up perspective rooted in evolutionary biology and neuroscience. This approach breaks down complex, macroscopic cognitive phenomena into their modular, constituent building blocks (such as gaze-following or mirror-neuron-driven motor mapping), showing how these fundamental mechanisms are shared continuously across species and adapted to meet ecological pressures.

> De Waal, F.B. and Ferrari, P.F., 2010. Towards a bottom-up perspective on animal and human cognition. Trends in cognitive sciences, 14(5), pp.201-207.

---
 
### Animal cognition
[link](./weeks/week_0/files/animal_cognition.pdf)

*This is essential reading on the history of the study of animal behaviour. It is very short and easy to read.*

James L. Gould’s "Animal Cognition" (2004) serves as a conceptual primer that categorizes the spectrum of animal behavior to isolate what genuinely qualifies as "thinking." He structures animal capabilities into a hierarchy, starting from hardwired innate behaviors (like fixed action patterns) and moving through associative learning (conditioning), before arriving at true cognition. Gould argues that the truest indicator of animal cognition is behavioral flexibility—specifically, an organism's ability to formulate novel, real-time solutions to unique environmental problems that fall outside its evolutionary programming or past training. While acknowledging spectacular, highly complex "niche-specialist" intelligences (such as the spatial memory of food-caching birds or the navigation of honeybees), he highlights that domain-general cognitive flexibility, such as tactical deception or the tool-use seen in apes and dolphins, remains a rarer evolutionary trait.

Gould’s hierarchy mirrors the historical development of AI. Innate behaviors are equivalent to expert systems and hard-coded "If/Then" algorithms. Associative learning maps onto classic machine learning (pattern recognition based on trial and error). True cognition represents the elusive goal of Artificial General Intelligence (AGI)—the ability to abstract a concept and flexibly apply it to a completely novel scenario.

> Gould, J.L., 2004. Animal cognition. Current biology, 14(10), pp.R372-R375.

---
 
### Understanding intelligence
[link](./weeks/week_0/files/understand_intelligence_ch1.pdf)

*Chapter 1 is essential reading. Because this is an old book some of the other chapters are dated and not necessary, but Chapter 1 is still a great introduction to the problem of studying intelligence. It is written from the perspective of AI practitioners and roboticists.*

Chapter 1 of Pfeifer and Scheier’s Understanding Intelligence (2001), titled "What is Intelligence?", establishes the foundational critique of classical, symbol-processing views of mind and introduces the embodied cognitive science paradigm. The authors argue that traditional AI (often called GOFAI, or Good Old-Fashioned AI) went astray by treating intelligence purely as abstract, centralized symbol manipulation decoupled from the physical world.

Instead, they propose that intelligence is an emergent property resulting from the dynamic interaction between an organism's or machine's nervous system, its physical body, and its environment.

Chapter 1 introduces the core principle of embodiment—the idea that having a physical body with specific morphology and sensors dictates how an agent perceives and acts—and emphasizes that intelligent behavior can often be achieved through cheap, distributed interactions with the environment rather than complex, centralized mental calculations.

> Pfeifer, R. and Scheier, C., 2001. Understanding intelligence. MIT press.

---

### Cognition, evolution, and behavior
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



> Cross, F. R., Carvell, G. E., Jackson, R. R., & Grace, R. C. (2020). Arthropod intelligence? The case for Portia. Frontiers in Psychology, 11, 2573


