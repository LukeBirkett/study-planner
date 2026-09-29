# Week 3 - Seminar

This week we're going to cover 2 papers, so please read both. They're a really nice pair, and are related to your your Week 2 Unexpected Cleverness lecture.

The first one describes a study purporting to show that bees can do arithmetic and can therefore represent numbers: 

> Howard et al (2019). Numerical cognition in honeybees enables addition and subtraction

The second paper argues that numerical cognition is not needed for the bees to perform that task, and supported that argument by building a neural network model that does not have numerical cognition yet can still "do the sums": 

> Maboudi et al (2021). Non-numerical strategies used by bees to solve numerical cognition tasks

<br>

---

## Numerical cognition in honeybees enables addition and subtraction (Howard, 2019)

This study challenges the assumption that exact, symbolic arithmetic requires the large brain architectures of primates or humans. Using an appetitive-aversive Y-maze paradigm, researchers successfully trained free-flying honeybees to use colors as symbolic operators, where blue required the bee to "add one" element to a sample and yellow required it to "subtract one". Because the element being added or subtracted was never visually present, the bees had to successfully hold the sample quantity in their short-term working memory while applying the learned, long-term operational rule. When tested with a completely novel sample number that they had never encountered during training, the bees successfully interpolated the rules to choose the correct arithmetic outcome. This proves that insects with miniature brains are capable of true numerical cognition, suggesting that advanced mathematical processing is biologically accessible without the prerequisites of human language or culture, likely evolving as a cognitive byproduct of complex foraging demands.

---

## Non-numerical strategies used by bees to solve numerical cognition tasks (Maboudi et al., 2021)
This paper acts as a critical counter-argument to the previous reading (Howard et al., 2019), demonstrating the intense scrutiny required when evaluating "intelligent" behavior in biorobotics and neuroethology.

This study provides a critical reassessment of numerical cognition in insects, demonstrating that what appears to be advanced arithmetic behavior is often driven by simpler, non-numerical heuristics. The authors note that in standard 2D visual tasks, the number of elements inevitably covaries with continuous physical cues like edge length, convex hull, and spatial frequency. Through behavioral experiments, they proved that when numerosity and continuous cues are set in opposition, honeybees actively abandon the number of items and base their decisions entirely on the continuous visual variables. To prove the biological plausibility of this alternative strategy, the researchers built a simple nine-neuron network model tuned exclusively to spatial frequency, with absolutely no capacity for numerical processing. Strikingly, this non-numerical model successfully reproduced complex behaviors previously hailed as proof of insect counting—including the ability to order "zero" at the bottom of a numerical continuum. Ultimately, the paper suggests that a computationally cheap "sense of magnitude" is far more primitive than a true "sense of number," serving as a stark reminder for biorobotics that complex behavior does not necessitate complex, high-level cognitive processing.

The authors urge future studies to assess all continuous cues in unrewarded tests, use cross-modal cues (like combining sound and vision), and analyze micro-behaviors (like flight paths and sequential scanning) to reveal the true algorithms animals use.

---

## Seminar Content

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