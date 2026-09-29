# Lab 2: Elementary Motion Detection & Simulation

> *This file is created with the use of AI. It takes the brief and my original work/notes from the lab and resynethised it as a revision file*

**The Goal of the Lab:** To learn how to use computational simulations to study animal behavior. Rather than just writing code to solve a software problem, biorobotics uses simulations to solve "puzzles"—probing a working system through parameter sweeps (sensitivity analysis) to understand how it works, when it fails, and why its biological counterpart evolved specific constraints.

<br>

## Task 1: Background Theory & Modeling Perception

This section establishes the biological inspiration and the mathematical models used in the simulation before any experiments are run.

<br>

---
### 1. The Biological Model: Honeybee Corridor Centering
---

When flying through narrow spaces, bees naturally maintain a trajectory down the absolute center.

**The Constraint:** Bees lack stereoscopic vision; they cannot perceive depth.

**The Solution:** They center themselves by balancing optic flow independently in each eye. Optic flow is the pattern of perceived motion on the retina when the agent or environment moves.

**The Heuristic:** If $Optic Flow_{Left} = Optic Flow_{Right}$, the bee is centered. If $Left > Right$, the bee is too close to the left wall and must steer right.

<br>

---
### 2. Modeling Perception: Elementary Motion Detectors (EMDs)
---

To model this biological vision, the simulation uses an array of simple light sensors hooked up to motion detectors.

---

**The Simple Correlator (Delay-and-Multiply):**
- Consists of two spatially separated sensors. Sensor 1 detects a visual edge, followed by Sensor 2 a moment later.

- The signal from Sensor 1 is held in a delay block. If the delay perfectly matches the travel time between the sensors, both signals hit a multiplier simultaneously, outputting a motion spike.

- **Flaw:** This model is brittle. If the agent moves too fast or too slow, the delay mismatches. It is also highly vulnerable to perceptual aliasing—being tricked by repeating patterns into calculating a completely false speed.

---

**The Superior Model: Hassenstein-Reichardt (HR) Detector:**
To fix the brittleness of the simple correlator, signal filters are added:
- **High-Pass Filters (HPFs):** The HPF forces the system to represent change. In the simple model, facing a white wall would cause the model to hallucinate motion by continuously outputting a high "1" signal. The HPF utilizes the current sensory input and the immediate past input to act as an edge detector. It spikes positively for rising edges (white-to-black) and decays to zero if the visual input is constant, ensuring no abstraction of movement in a stationary situation.

- **Low-Pass Filter (LPF):** The LPF mechanism improves and replaces the rigid Delay block. It takes the sharp spike from the HPF and smooths it out into a long sloping tail. This smoothing causes a phase shift (a delay in a signal peak). The LPF works like a leaky bucket—it stores the signal spike and distributes it over subsequent timesteps ($t+1, t+2, \dots, t+n$).

- **Signal "Smearing":** In many systems this could be considered "signal degradation," but here, this "smearing" is a feature, not a bug. It creates a "window of opportunity." Sensor 2's signal no longer needs to arrive at a perfectly exact millisecond because the Sensor 1 input is cumulative and retains its strength. The LPF allows the detector to "remember" the detection of an edge at time $t$ long enough to correlate it with a later detection, making the system robust across a much wider range of flight speeds.

---

The **Hassenstein-Reichardt (HR) detector** is fundamentally still a "Delay-and-Multiply" system at its core, but it replaces the rigid "stopwatch" delay with a more dynamic, biology-inspired signal processing pipeline.

Instead of a simple `Input -> Delay -> Multiply`, the HR model routes the signals like this:  
- **Sensor 1 (Leading/Front):** `Input` $\rightarrow$ `High-Pass Filter (HPF)` $\rightarrow$ `Low-Pass Filter (LPF)` $\rightarrow$ `Multiplier`
- **Sensor 2 (Trailing/Rear):** `Input` $\rightarrow$ `High-Pass Filter (HPF)` $\rightarrow$ `Multiplier`

---

**What does the multiplier do?**

The final stage of the EMD is to multiply the high-passed sensory input from the second sensor and the high-passed and then low-passed input from the first sensor. If the two signals are either both positive or both negative, then the output from the EMD will be positive. The output from the EMD will be negative (as occasionally in Figure 10) only when the signs of the two signals differ.

<br>

---
### 3. Open-Loop Dynamics: Sensitivity & Parameter Sweeps
---

In this task, the goal is to discover the operational limits of the HR detector by running **parameter sweeps** (testing a grid of variables) on a single eye/wall, without the bee actively steering.

This is known as **sensitivity analysis**. If a system is very sensitive to a parameter changing or a particular range of parameters then this may highlight an issue. 

One of the advantages of in silico experiments is that it is relatively easy to run a simulation many times, and from many different sets of initial conditions. This is advantageous because, when simulating a complex system, or a system with potentially complex (or even chaotic) dynamics, the way the system behaves may depend strongly on its initial conditions. In that case, the best way to get a good impression of the characteristic behaviour of the system (if it has one) is to simulate it a number of times, from an ensemble of initial conditions, and compare the results. 

> **The general approach is:**
> 1. Start with a range of parameter values, e.g. [1, 5, 7, 10] or (0 to 100)
> 2. Run a simulation for each value and record some important metric
> 3. Plot results over the range for analysis
> 
> Note, it is often better to sweep over two parameters at together as you may discover if paramters are independent or conencted in some way. 

---

**Q1: The Effect of Initial Conditions (Noise):** 

A single simulation run is unreliable. Because sensor interactions with the environment create high variance and noise, simulations must be run across an ensemble of initial conditions (e.g., 5 to 20 runs) and averaged to find the true behavioral trend.

Individual simulations may be misleading and suggest things are better than they are. We can introduce various types of noise into our simulations to test robustness.

---

**Q2. The Effect of Bee Speed (Velocity):**
- **Is there a functional range?** Yes, the detector operates in a "Goldilocks Zone"

- *Too Fast:* The sensors miss the alternating patches entirely, causing the multiplier to fire randomly (aliasing) or drop to zero.

- *Too Slow:* The visual signal decays completely in the High-Pass Filter before Sensor 2 is ever triggered, resulting in zero motion detection.

---

**Q3. The Effect of LPF Corner Frequency:** 
- **What is the LPF doing?** The LPF controls the temporal window of the memory tail.

- **High Corner Frequency:** Causes rapid signal decay (a narrow overlap window), requiring the bee to fly at high velocities to trigger the multiplier.

- **Low Corner Frequency:** Causes slow decay (a wide window), allowing the bee to detect motion at slower speeds, but risking heavily smeared data. Note, that smeared data is technically noisey data, its just that it allows the system to match better. 

<br>

---
### 4. Closed-Loop Dynamics: The Flight Controller
---

In this task, the goal is to test the actual Flight Controller. In a closed-loop scenario (where the bee is actively steering in a corridor), instantaneous EMD outputs are too erratic. The controller acts as an "adaptation layer" designed to compensate for the inherently noisy, limited biological hardware so the bee can successfully steer. The controller must smooth the data and apply steering logic.

The controller is the core engineering philosophy. It is the tool through which an engineer takes a biological algorithm and adapts it for a specific usecase. It ompensate for the fact that the underlying biological hardware (the EMDs) is inherently noisy, limited, and context-dependent.

This means these following fields are the adpations that the authors can created (engineered) to get the mechanism to work in the given domain. 

---

#### **Q1. Experiment with the window size (`window_n`):**

**Why do we need a moving average?** Instantaneous flow of the EMD fluctuates wildly. If steering were tied directly to raw spikes, the bee would attempt a micro-steering correction for every single texture change. The moving average acts as a low-pass filter for decision-making, keeping only the "gist" of the lateral drift.

The moving average window (`window_n`) acts as a low-pass filter for the bee’s decision-making system. It discards the high-frequency jitter of individual texture pulses and keeps only the "gist" of the current lateral drift.

- `Small Window:` The controller becomes hyper-reactive to instantaneous noise, resulting in frantic, jittery/zig-zagging flight paths.

- `Large Window:` The controller over-smooths the data and becomes sluggish. The bee will physically drift into a wall before the moving average registers the imbalance.

---

#### **Q2. Experiment with the margin size:**

**What is the margin?** The margin is the threshold of acceptable difference between the left and right eyes ($|Left - Right| \le margin$). 

Even with smoothing, two sensors will rarely output exactly the same value due to environmental noise and imperfect sensor calibration. If the controller had no margin, the bee would be in a constant state of "limit cycling"—perpetually steering left, then immediately right, then immediately left, never settling.

The `margin` creates a "dead zone" in the controller. It defines a "good enough" range where the bee is effectively centered.

- ***Large Margin:*** The controller accepts massive imbalances as "centered." The bee drifts lazily and fails to maintain a straight path.

- ***Small Margin:*** The bee can never perfectly satisfy the mathematical condition. The constant flow of sensor noise triggers continuous, frantic over-correction.

- ***Limit Cycling:*** Especially in slower bees, a tight margin combined with noise causes the bee to fall into a continuous, oscillating sinusoidal wave down the corridor rather than a flat line. Fast bees actually stabilize easier because the ratio of the fixed margin to the baseline noise is larger.

---

#### **Q3. Experiment with speed, with respect to margin**:

**How does speed interact with the margin?** Fast bees actually stabilize easier because the ratio of the fixed margin to the baseline noise is larger. In slower bees, a tight margin combined with noise causes the bee to fall into a continuous, oscillating sinusoidal wave down the corridor (Limit Cycling) rather than a flat line, as the controller is constantly fighting to push the signal into the margin.

---

#### **Q4. Experiment with the environment (Corridor width w)**:

**How does width affect behavior?** The physical environment mathematically dictates the sensory input based on the optic flow equation: $\mathbf{R} \propto \frac{\mathbf{V}}{\mathbf{d}}$ (Optic Flow $\propto$ Velocity / Distance).

- `Wider Corridor (Increased $d$):` Optic flow decreases. The signals become incredibly weak, making the controller unresponsive and prone to drifting.

- `Narrow Corridor (Decreased $d$):` Optic flow increases. The signals are amplified, making the bee highly reactive (or causing the EMD to break if the flow exceeds the hardware's maximum tuning threshold).

---

# Lab 2: References and Readings

### Honeybee navigation en route to the goal: visual flight control and odometry (Srinivasan, 1996)

This foundational study demonstrates how flying insects replace complex spatial mapping or stereoscopic depth perception with three elegant, low-level optic flow heuristics to control flight trajectories. First, bees execute an equidistant centering response by dynamically balancing the lateral angular velocity of visual images across both eyes, a closed-loop rule that allows them to negotiate narrow corridors without calculating physical distance metrics. Second, they automatically regulate forward flight velocity by keeping the global average of this optic flow constant, instinctively slowing down as their surroundings narrow to prevent collisions. Finally, the authors prove that the honeybee's visual odometer estimates distance by mathematically integrating the total visual motion experienced during flight. Because this odometer tracks absolute image motion across the retina rather than time or metabolic energy, it remains entirely robust against energetic fluctuations caused by headwind loads, providing a direct, low-compute strategy that serves as a core blueprint for autonomous biorobotic platforms.

> [1] Srinivasan, Mandyam V., et al. "Honeybee navigation en route to the goal: visual flight control and odometry." Journal of Experimental Biology 199.1 (1996): 237-244. 

---

### Freely flying honeybees use image motion to estimate object distance (Kirchner & Srinivasan, 1989)

This pioneering study provides the initial empirical confirmation that flying insects bypass the physical impossibility of stereoscopic depth perception—caused by close-set compound eyes—by using retinal image speed as a direct proxy for object distance. By training bees to fly through a flight tunnel with walls that could mechanically move parallel to the insects, the researchers systematically decoupled physical distance from perceived visual motion. When a wall moved in the direction of flight (reducing localized optic flow), the bees actively drifted toward it; conversely, accelerating the wall in the opposite direction (inflating optic flow) forced them to steer away. This behavior explicitly demonstrates a local, distance-agnostic centering heuristic: bees do not compute an internal metric map of space, but instead achieve stable navigation by executing a reactive sensorimotor control loop that seeks to equalize the apparent angular velocities striking each retina.

> [2] Kirchner, W. H., & Srinivasan, M. V. (1989). Freely flying honeybees use image motion to estimate object distance. Die Naturwissenschaften, 76(6), 281–282

---

### A model of visual detection of angular speed for bees (Riabinina & Philippides, 2009)

*Lab 2 simulation code derived paper*

This computational paper addresses a fundamental flaw in using standard Elementary Motion Detectors (EMDs) to model honeybee navigation. While behavioral studies show that bees extract pure angular speed from optic flow regardless of environmental patterns, basic EMD outputs are heavily distorted by spatial frequency and visual contrast. To solve this, the authors propose a dual-channel angular speed detector. By passing sensory inputs through parallel channels with different filter properties and taking the ratio of their outputs, the model effectively factors out contrast and spatial dependencies, leaving a robust estimation of true angular speed. By embodying this ratio model in a simulated agent, the authors successfully replicate the classic biological centering response and odometry behaviors. This paper serves as the direct theoretical foundation for building robust, bio-inspired robotic flight controllers using customized High-Pass and Low-Pass filters.


> [3] Riabinina, O., & Philippides, A. O. (2009). A model of visual detection of angular speed for bees. Journal of theoretical biology, 257(1), 61-72.

---

### Elementary motion detectors (Frye, 2015)

**The Necessity of Correlation:** A single photoreceptor only detects fluctuations in illumination over time; it cannot determine the direction of a moving object. Directional motion can only be detected by comparing the activity of at least two spatially separated receptors.

**The "Delay and Correlate" Architecture:** The fundamental Hassenstein-Reichardt (HR) Elementary Motion Detector (EMD) consists of two input channels, a time delay, and a nonlinear multiplier. If a visual stimulus activates Sensor 1, that signal is delayed. By the time the stimulus physically reaches Sensor 2, the delayed Sensor 1 signal and the live Sensor 2 signal converge simultaneously on the multiplier, creating a strong, directionally selective motion spike.

**Historical Origin (The Tethered Beetle):** This model was not born in a computer simulation. In the 1950s, Hassenstein and Reichardt glued a beetle to a wire, handed it a lightweight ball to clasp (making it feel like it was walking), and rotated a striped drum around it. By observing how the beetle rolled the ball in response to the moving stripes, they derived the exact mathematical predictions of the EMD model.

**The "Stripe Rate" Dichotomy (The EMD's Flaw):** A profound limitation of the basic EMD is that it encodes the temporal frequency (the rate at which stripes pass the sensor) rather than true velocity. Because of this, the pure EMD model cannot distinguish between thin stripes moving slowly and thick stripes moving quickly. (Note: This is why the Riabinina ratio model was required to extract true angular speed).

**Biological Complexity (Opponency and ON/OFF channels):** To make the basic EMD robust enough for the real world, biological circuits add layers of complexity. This includes "opponency" (subtracting the output of a left-looking EMD from a right-looking EMD to get a clear directional signal) and splitting the visual data into separate neural pathways for light increments (ON channels) and light decrements (OFF channels).

This primer outlines the history, architecture, and biological limitations of the Hassenstein-Reichardt Elementary Motion Detector (EMD). Originally derived in the 1950s by observing the walking reflexes of tethered beetles inside rotating striped drums, the core "delay and correlate" model solves the ambiguity of single-photoreceptor vision by multiplying a delayed signal from a leading sensor with a live signal from a trailing sensor. While elegant, the classical EMD suffers from a profound limitation: it encodes the temporal frequency (stripe rate) rather than true image velocity, meaning it cannot distinguish between thin patterns moving slowly and thick patterns moving quickly. To operate in natural environments, insects like Drosophila supplement this basic computation with complex neural elaborations, including separate ON/OFF luminance pathways, specific temporal delay filters, and opponent-direction subtraction to generate robust, ecologically viable motion vision.

> [4] Frye, M. (2015). Elementary motion detectors. Current Biology, 25(6), R215-R217.

--- 
