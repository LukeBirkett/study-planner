# Lecture Notes

- [Week 0 - Preliminary](#week-0---preliminary)
    - [Essential Reading](#essential-reading)
        - [Towards a bottom-up perspective on animal and human cognition](#towards-a-bottom-up-perspective-on-animal-and-human-cognition)
        - [Animal cognition](#animal-cognition)
        - [Understanding intelligence](#understanding-intelligence)
        - [Cognition, evolution, and behavior](#cognition-evolution-and-behavior)
---

- [Week 1 - What is intelligence and does it need a brain?]()
- [Week_2 - Unexpected Cleverness]()
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

> [**Key Reading:** Slime Mold Cognition (Reid, 2023)](./weeks/week_1/readings/weekly/slime_mould.pdf)

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

#### 5. Final Module Takeaways (Week 1)
- Defining intelligence is hard, especially when benchmarking animals against humans.
- Top-down (anthropocentric) definitions widen the evolutionary gap and lead to semantic arguments.
- The biological, bottom-up definition is inclusive: intelligence is adaptive behavior.
- To understand or engineer intelligent behavior, we must examine the continuous interaction between the Brain, the Body, and the Environment.

---