# Lab 2: Elementary Motion Detection & Simulation

*this file is created with the use of AI. It takes the brief and my original work/notes from the lab and resynethised it as a revision file*

**Core Theme:** Using computational simulations to study animal behavior. Rather than just writing code to solve a problem, biorobotics uses simulations to solve "puzzles"—probing a working system through parameter sweeps (sensitivity analysis) to understand how it works, when it fails, and why its biological counterpart evolved specific constraints.

## 1. The Biological Model: Honeybee Corridor Centering

When flying through narrow spaces, bees naturally maintain a trajectory down the absolute center.

**The Constraint:** Bees lack stereoscopic vision; they cannot perceive depth.

**The Solution:** They center themselves by balancing optic flow independently in each eye. Optic flow is the pattern of perceived motion on the retina when the agent or environment moves.

**The Heuristic:** If $Optic Flow_{Left} = Optic Flow_{Right}$, the bee is centered. If $Left > Right$, the bee is too close to the left wall and must steer right.

## 2. Modeling Perception: Elementary Motion Detectors (EMDs)

To model this biological vision, the simulation uses an array of simple light sensors hooked up to motion detectors.

---

**The Simple Correlator (Delay-and-Multiply):**
- Consists of two spatially separated sensors. Sensor 1 detects a visual edge, followed by Sensor 2 a moment later.
- The signal from Sensor 1 is held in a delay block. If the delay perfectly matches the travel time between the sensors, both signals hit a multiplier simultaneously, outputting a motion spike.
- **Flaw:** This model is brittle. If the agent moves too fast or too slow, the delay mismatches. It is also highly vulnerable to perceptual aliasing—being tricked by repeating patterns into calculating a completely false speed.

---

**The Superior Model: Hassenstein-Reichardt (HR) Detector:**
To fix the brittleness of the simple correlator, signal filters are added:
- **High-Pass Filters (HPFs):** Act strictly as edge detectors. They spike positively for rising edges (white-to-black) and negatively for falling edges, decaying to zero if the visual input is constant. It should be noted that this isn't strictly a filter on the same input, instead it utilises the current sensory input and the immediate past input.
- **Low-Pass Filter (LPF):** Applied to the front sensor. It smooths out the sharp HPF spikes and introduces a phase shift (delay). This broadens the signal's "tail," creating a wider temporal window for the multiplier to successfully overlap the signals across a range of speeds.

---

The **Hassenstein-Reichardt (HR) detector** is fundamentally still a "Delay-and-Multiply" system at its core, but it replaces the rigid "stopwatch" delay with a more dynamic, biology-inspired signal processing pipeline.

Instead of a simple `Input -> Delay -> Multiply`, the HR model routes the signals like this:  
- **Sensor 1 (Leading/Front):** `Input` $\rightarrow$ `High-Pass Filter (HPF)` $\rightarrow$ `Low-Pass Filter (LPF)` $\rightarrow$ `Multiplier`
- **Sensor 2 (Trailing/Rear):** `Input` $\rightarrow$ `High-Pass Filter (HPF)` $\rightarrow$ `Multiplier`

---

#### High Pass Logic
The High-Pass filter forces the system/input to represent change. In the simple model, if faced with an entirely white wall the model would hallicunate motion by continuously outputting a high $1$ signal even if stationary. When a visual pattern transitions from white to black (a rising edge), the input value sharply jumps. The HPF works upon this changing value and outputs a large "spike". In a stationary sitution, there is not change and therefore no abstraction of movement.

---

#### Low Pass Logic
The LPF mechanism is what improves and replaces the rigid Delay block. In the simple model, the delay is a hard timer. If the bee goes slightly fasters or slower then Sensor 2's signal will miss the delayed Sensor 1 signal entirely, and the multiplier outputs nothing. This means there is no EMD differential for the bee to respond to. 

The LPF takes a sharpe spike from the HPF and smoothes it out into a long sloping tails. Smoothing casues something called a phase shift which is a delay in a signal peak. Just to be clear, the LPF works like a bucket, it stores the signal spike and distributes it over subsequent timesteps $t+1, t+2, \dots, t+n$. Additionally, this now means that the Sensor 2 signal doesn't need to arrive at a perfectly exact millisecond because the Sensor 1 input is cumulative and retains its strength. This makes the system robust across a much wider range of flight speeds.

---

#### Signal "Smearing"
In a lot of systems this could be considered as inducing noise and causing "signal degradation". However, in the context of motion detection, this "smearing" is a feature, not a bug. By distributing the signal from time $t$ across multiple future time stamps, the LPF creates a "window of opportunity" to match with Sensor 2. The multiplier (the HR detector) only cares if it sees a signal from Sensor 1 AND Sensor 2 simultaneously. The LPF allows the detector to "remember" the detection of an edge at time $t$ for long enough to correlate it with a later detection at time $t+n$, effectively bridging the gap between two different timestamps.

---

## 3. Open-Loop Dynamics: Sensitivity & Parameter Sweeps

By running parameter sweeps (testing a grid of variables), we discover the operational limits of the HR detector.

---

**The Effect of Initial Conditions (Noise):** A single simulation run is unreliable. Because sensor interactions with the environment create high variance and noise, simulations must be run across an ensemble of initial conditions (e.g., 5 to 20 runs) and averaged to find the true behavioral trend.

---

**The Effect of Velocity ("The Goldilocks Zone"):**
- *Too Fast:* The sensors miss the alternating patches entirely, causing the multiplier to fire randomly (aliasing) or drop to zero.
- *Too Slow:* The visual signal decays completely in the High-Pass Filter before Sensor 2 is ever triggered, resulting in zero motion detection.

---

**The Effect of LPF Corner Frequency:** The LPF controls the temporal window.
- **High Corner Frequency:** Causes rapid signal decay (a narrow overlap window), requiring the bee to fly at high velocities to trigger the multiplier.
- **Low Corner Frequency:** Causes slow decay (a wide window), allowing the bee to detect motion at slower speeds, but risking heavily smeared data. Note, that smeared data is technically noisey data, its just that it allows the system to match better. 

---

## 4. Closed-Loop Dynamics: The Flight Controller

In a closed-loop scenario (where the bee is actively steering in a corridor), instantaneous EMD outputs are too erratic. The controller must smooth the data and apply steering logic.

The controller the core engineering philosophy, the flight controller is an "adaptation layer" designed to compensate for the fact that the underlying biological hardware (the EMDs) is inherently noisy, limited, and context-dependent.

This means these following fields are the adpations that the authors can created (engineered) to get the mechanism to work in the given domain. 

---

**Moving Average Window (`window_n`):**
Because instantaneous flow of the EMD fluctuates wildly, the bee calculates a rolling average of recent optic flow. If the bee’s steering were tied directly to these raw spikes, the bee would attempt to make a micro-steering correction for every single texture change. 

The moving average window (`window_n`) acts as a low-pass filter for the bee’s decision-making system. It discards the high-frequency jitter of individual texture pulses and keeps only the "gist" of the current lateral drift.

- `Small Window:` The controller becomes hyper-reactive to instantaneous noise, resulting in frantic, jittery/zig-zagging flight paths.
- `Large Window:` The controller over-smooths the data and becomes sluggish. The bee will physically drift into a wall before the moving average registers the imbalance.

---

**Margin Size & Limit Cycling:**
The margin is the threshold of acceptable difference between the left and right eyes ($|Left - Right| \le margin$).

Even with smoothing, two sensors will rarely output exactly the same value due to environmental noise and imperfect sensor calibration. If the controller had no margin, the bee would be in a constant state of "limit cycling"—perpetually steering left, then immediately right, then immediately left, never settling.

The `margin` creates a "dead zone" in the controller. It defines a "good enough" range where the bee is effectively centered.

- *Large Margin:* The controller accepts massive imbalances as "centered." The bee drifts lazily and fails to maintain a straight path.
- *Small Margin:* The bee can never perfectly satisfy the mathematical condition. The constant flow of sensor noise triggers continuous, frantic over-correction.
- *Limit Cycling:* Especially in slower bees, a tight margin combined with noise causes the bee to fall into a continuous, oscillating sinusoidal wave down the corridor rather than a flat line. Fast bees actually stabilize easier because the ratio of the fixed margin to the baseline noise is larger.

---

**Environmental Geometry (Corridor Width):**
The physical environment mathematically dictates the sensory input based on the optic flow equation: $\mathbf{R} \propto \frac{\mathbf{V}}{\mathbf{d}}$ (Optic Flow $\propto$ Velocity / Distance).
- `Wider Corridor (Increased $d$):` Optic flow decreases. The signals become incredibly weak, making the controller unresponsive and prone to drifting.
- `Narrow Corridor (Decreased $d$):` Optic flow increases. The signals are amplified, making the bee highly reactive (or causing the EMD to break if the flow exceeds the hardware's maximum tuning threshold).

---

