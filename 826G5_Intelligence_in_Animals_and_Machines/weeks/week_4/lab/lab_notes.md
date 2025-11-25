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

The HPF allows for decay and phasing of a signal as it apporaches and passes. In the simple EMD, signal is oeither on or off. The mechanism does this by detecting edges. It does not change the temporal different between sensors (lag)

### What does the Low Pass Filter do?

LPF smooths and phase shifts the signal. Phase shift may give the signals more overlap. There is a param to control this. The smaller the param, the larger the smoothing and pase-shift efect. 

### What does the mutlipler do?

Recall, S1(H,L) and S2(H) are passed to a mutliplier. This gives the strength of the match. If both are higher then the signal will be very high. If they are opposites then the EMD will be negative.

## Task 2 Download the Code

## Task 3 - Run a Parameter Sweep

The advantage of "in silico" experiements is that you can run the simulation many times with different starting conditions. Complex systems tend to depend heavily on the initial conditions. Best way to unpack and learn the behaviour of a compled system is to simulate many times from an ensemable of intital conditions and compare results.

We can investigate this systematically by performing a parameter sweep. A parameter sweep is a methodical technique used in modeling, simulation, and optimization to test a system's behavior across a range of input values for one or more parameters. The primary goal is to understand the sensitivity of the system's output (or performance) to changes in its inputs, and to identify optimal or critical parameter settings.

### Parameter sweeps are essential for:
- Optimization: Finding the best configuration for a system.
- Robustness Analysis: Determining how resilient a system is to variations in its environment or inputs.
- Validation: Confirming that a model behaves as expected across its entire intended operational space.

In our experiment, we can investigate this systemmatically by performing a parameter sweep. We will run a simulation many times while manipulating a parameter in order to see how robust or stable the behaviour of a system is. Or when it breaks.

### Key things to examine are:
- How strongly the system depends on parameter values
- How combinations of parametetrs work together

This is known as **sensitivity analysis**. If a system is very sensitive to a parameter changing or a particular range of parameters then this may highlight an issue

### The general approach is:
1. Start with a range of parameter values, e.g. [1, 5, 7, 10] or (0 to 100)
2. Run a simulation for each value and record some important metric
3. Plot results over the range for analysis

Note, it is often better to sweep over two parameters at together as you may discover if paramters are independent or conencted in some way. 

### Robustness 

Individual simulations may be misleading and suggest things are better than they are. We can introduce various types of noise into our simulations to test robustness.

### Getting Started with the Code

The script is `vel_vs_lp_fc.py`. It initalizes a simulated agent based on a bee. It flies in a striaght line parallel to a vertically alligned wall with alternative stripes. The bee has sensors which detect patterns in view as either 1 (black) or 0 (white). If all parameters are set to false (default) then it will sweep over two parameter lists for velocity and corner frequency (this is the param for low-pass filter). If the outut is higher then more motion is detected

- line 119: Patch Height, `patch_h = 20`
- line 134-140: `single_run`, `sweep_vels`, `sweep_fcs`, `mutli_vels`. These are all boolean and false by default. 

### Comprehensive vs Resolution Trade off

Ideally we want to make the resolution as rich and detailed as possible: `v_n` & `l_n` (these are the param lists to loop through). But may be very time and comutationally expensive. Although PCs are fast and cabable today so this is not as much of an issue. 

### Tasks:

Experiment with simulations by sweeping over parameters and graps how simulation ouputs change with parameters

#### 1. Effect of Initial Conditions

`lines 151-121`, if `single_run = true` (134)

#### 2. Effect of Bee Speed

Run a 1D parameter sweep over velocity (fixing LPF corner frequency). Code that control this found in `lines 214-233`, `elif sweep_vels`

Increasing bee velocity seems increase average correlation but reduce smoothness of the line. More simiulations might be needed to average out the noise.  Also means it has an optimial delay time

#### 3. The Effect of LPF Corner Frequency

1D sweep for LPF with fixed velocity, `lines 235-254`

- 0 LPF has very little correlation
- Rapidly increases almost vertically until 5
- then drops and very slowly trails out
- If the filter is lower then it is more smooth
- If higher then less smooth, it lets through more of the HPF without changing it

- 0 has flat signal hence no correlation. It introduces and very long temporal delay
- Large LPF values will introduce almost no delay

The sudden rise and peak of the LPF parameter implies that it has an optimial level that we can fix at and focus on exploring other paramters in the ystem

The peak is where the LPF is allowing the temporary delay to exactly match. It is the optimla point for the volocity fixed at. 

## Task 4: Simulating Corridor Centering Bees

Scripted used `bee_corridor.py`

In task 3, we simulated 1 wall + pair of sensors. Task we implement the full experiement. A pair of sensor on each side of the agent and a wall each side.

- Real Honey bees centre their flight trajectories in the corridor/tunnel by balancing the optic flow on two side of their visual fields
- For out simulated bee. If the average outputs of the EMD are equal then the bee must be flying in the center. If the outputs are unbalanced then the bee should steer towards the lower EMD to rebalance itself. In the code, the walls are technically visual only. The "bee" could fly through them if it wanted it, though it is programmed not to

Recall that is it Kirchner and Srinivasan hypothesis that bees centre themsevles when flying through a corridor or tunnel using optic flow on the two sides of their visual fields. The simulated bee should be capable of this because it has two sensors with associated EMDs on each side of its body. Though the behaviour requires the parameters to be set well

In inputs to the system are very simple:
- 4 binary signals
- 2 sensors on each EMD
- Input to sensor is either white or black

If the signals from the EMDs are equal then the bee must be flying in the middle of the corridor. If the average output is higher on the left than the right, then the bee shoud steer more to the right. Being higher on the left then it must be closer to the wall meaning the signals between black and white will be closer due to perspective

### The Code

#### Moving Averages

Under the parameter sweeps we took the average EMD output from all of the interations simulations. For a real-time implementation, we need to know how much optic flow the EMD is detecting right now. Actually, in practice, we want to get an idea of what the optic flow decected has been like recently. This is because the instantaneous output of an EMD can vary greatly. An easy solution is to use a moving average of a recent (short) time window. When using a moving average, the window is the most recent interval of time. The effect of a moving average is much like the smooth effect of an LPF. A small moving average window does not average much as the result will be more similar to the instantaneous output of an EMD.If the window is too large, then the signals will be smoothed too much and the system will be not recognise EMD changes quick enough meaning it is respond slowly, lagged o r just not at all

Window size is one of the parameters we are going to investigate and is set by `window_n` on `line 102`

`controller = OpticFlowController(vel=50, margin=0.0075, window_n=200)`


#### The Controller

The bee's controller has very simple principles:
- If the bees average EMD outputs are close enough together then the bee will just fly forward
- "Close Enough" is determined by `margin` also on `line 102` with the `OpticFlowController()`
- If the EMD is greater on the left, then the bee will steer right
- If the EMD is great on the right, then the bee will steer left
- The angle by which steering takes place is set on `line 59`, `d`

The controller has 3 parameters will are set in `OpticFlowController()` on `line 102`:
- `vel`: the bee's linear speed, which will be constant over the entire simulation
- `margin`: the margin within which the EMDs' average values are considered similar enough for the bee to be in the centre of the corridor
- `window_n`: the number of simulation steps which will be used in computing the moving averages of the EMD outputs.

#### Ensemble of initial conditions

- The number of times a simulation is run is set with `n` on `line 85`
- Every simulation will start at the same y-coordinate in space
- But the x-coordinate will vary each time (lateral space)
- This is so we can confirm that the results are robust as there isn't some specially starting sweet spot that allows for certain behaviour and completions
- The path taken during each path will be plot on the graph in a different colour
- The bee traverses foward in the y-direciton using angle changes to center itself

# The Tasks

The main aim of the task is to investigate the idea that corridor centring can occur by balancing optic flow. We want to play with and test things with the hope of understanding how the system works. Also to know its limits: how does it work, and how, when and why does it fail?

## Interpretting the Starting Output 

 Staring point, `vel = 50`, `margin = 0.0075`, `window_n 200= `

 There are 5 plots to look at:
 - Average Output
 - Sensor Output
 - Correlator Output
 - Bee Heading (Radians)
 - Bee Trajectories

### Average Output

The "Controller correlator moving averages" is the filtered and actionable Optic Flow signal. It respresents the bee's interpetation of **average** visual motion from the walls. Offically, the Optic Flow is the direct signal from the EMD which has the fundemental function of measuring motion/Optic Flow. If a bee's velocity is constant `vel = 50` then the **magniute of the Optic Flow is inversely proporitional to the distance from the wall**. Hence, the EMD signal (magnitutde) can be used to proxy closness to the wall. The Moving Average is the filtered **instantanous output** of the EMD. The raw signal would be too noisy for governing control and movements. The moving average smooths out the abruptness of the white and black signals, leaving behind a stable underlying signal that reflects average perceived visual motion where by the average is calculate by a size of `window_n`. This is the true optic flow which a controller can use for steering decisions. 

This plot only shows the **last** [N-1] simulation. It respresents the only reliable indicator of a bee's success and it is the inputs used to determine the bee's heading direction. A moving average is calculated for both `left` and `right` sensor with the differential between them being used to determine behaviour. The `margin` is a buffer where the differential tells the bee just to fly forward up the y-axis. 

The bee has an internal desire to balance the optic flows. If they are not balanced then it uses its steering behaviour to balance them. A bee travelling diagonally is impacting its optic flow. The lab between sensing the black/white strips becomes less when travelling in the direction of a wall, and more when travelling away. 

The raw EMD output in Plot 3 is related to this plot but instead is shows us that it is too noisy and spikey for steering. The Controller Correlator Moving Averages are an average of N=`window_n` previous instantaneous EMD outputs. The moving average filters out the noise and provides a stable signal that represents the average perceived motion on that side. As the value is a time stepped average, it will have a lag when adapting to new stimuli, it is this feature that provides the agent with stability. 

A higher Average Optic flow tells the bee is is closer to a wall, and lower that is it further away. The bee never actually knows how far away a wall is, just the imbalance between optic flow signals. 

The `margin` is used to manage the imperfect nature of the control loop, allowing the system to acheive practical stability instead of changing impossible perfection. Recall that the bee's steering is a simple on-off system, not a smooth tailored action. Because the steering is aggressive a correction is likely to overshoot points of perfect balance. The final "balanced" behaviour is known as Limit Cycling and the space within the `margin` is called a "dead zone". Without a margin the controller would demand perfect equality ($\mathbf{R_{Left\ Mean} = R_{Right\ Mean}}$) but there is noise in the any system so this will never happen even if the balancing mechanism was perfect. 

The bee essentially has two behavioural mechanisms:
- "Perfect Convergence" ($\mathbf{R_{L} = R_{R}}$): This is the condition that triggers the "Fly Straight" command ($\mathbf{\pi/2}$ radians).
- "Fly Straight" Command: This command means zero turning effort (no new lateral velocity). It does not stop the existing diagonal coasting movement that was already in progress from the previous turn.

```
# Code snippet from bee_corridor.py (Controller logic)
if abs(left_mean - right_mean) < self.margin:
    # 1. Fly Straight
    heading = math.pi/2
elif left_mean > right_mean:
    # 2. Steer Left (Optic flow on left is greater -> Left wall is closer)
    heading = math.pi/2 + d
else:
    # 3. Steer Right (Optic flow on right is greater -> Right wall is closer)
    heading = math.pi/2 - d
```

#### What are we actually seeing in Plot 1?

It is the history of both left and right means at each point in time. It is the filtered Optical Flow as induced by the High-Pass and Low-Pass filtered. It can be thought of as the output of a temporal filter being applied to the signals of Plot 3 which itself with its extreme osciallations is too noisey to respond responably to. Plot 1 reveals the stable underlying Optic Flow signal that accurately reflects the bee's distances from the wall. The height of each line ay any point t is proporitional to the Optic Flow on each side. Recall, that in the default run, the walls themselves are identical meaning any different in percieved flow is caused by distance from the wall. The Averaged Output depends on distance since Optic Flow. The relationship is inverse so a higher Average Output means a smaller (closer) distance from the wall and a Lower Average Output means the wall is further away (large distance value). 

#### Results in The Default Run

To start the we see a complete mismatch in terms of the bee's centeredness. The bee's control logic is very simple, eleminate the different between the two moving averages. We see this happen almost straight away but to an imperfect degree, that is to say the looks pretty similar but not exact. This is where the `margin` comes in, if the differece is not within the margin the bee continues correcting. This results in a feedback loop whereby the bee is continually correcting resulting in an Overshoot Effect. Remember, the bee's signal is an Moving Average, meaning that the very first point that the bee meets the centre will be lost to group voting-esqe nature of the average. It will overshoot the centre and start to correct in the opposite direction to compensate. This can be validated in Bee Heading plot that shows the first change in movement after the inital flow of sustain corrections is in the opposite direction, not vertically up the y-axis which would be the case if the bee had centered. You can also see it very slighly in this Moving Average plot as `t=7` where the very slight peaks which from blue (left) to orange (right). Depending on the parameters, the bee will switch between its corrections before it settles into the `margin` and starts to oscillate gently in each direction to keep itself centered. 

![Original Controller Correlator Moving Average Plot](../../labs/IAM_Sussex_labs/lab2/original_corridor_run/Figure_6_Controller_Correlator_Moving_Average.png)

### Sensor output

The "curves" in these grapgs are perfectly stepped jumps with only horizontal and vertical lines. The front and back sensor lines are almost perfectly matched given the resolution of the graph. This stepped structure is given because the signal output is either 0 or 1 (white or black). 

![Original Right Sensor Outputs](../../labs/IAM_Sussex_labs/lab2/original_corridor_run/Figure_5_Right_Sensor_Outputs.png)
![Original Left Sensor Ouputs](../../labs/IAM_Sussex_labs/lab2/original_corridor_run/Figure_4_Left_Sensor_Outputs.png)

### Correlator Outputs

The systems mechanism relies on the relationship between Optic Flow (speed of the world) and the distance to an object (wall). The magnitutde of the EMD output ${\mathbf{R}}$  is proportional to the Optic Flow ($\omega$) (angular velocity) of the visual pattern across the sensor.  

The Optic Flow ($\omega$) is dependant on the forward velocity ($\mathbf{V}$) and the distance ($\mathbf{d}$) to the wall: $$\mathbf{R} \propto \omega \propto \frac{\mathbf{V}}{\mathbf{d}}$$

If the wall is closer, ${\mathbf{d}}$ is smaller and therefore $\mathbf{R}$ (EMD) is higher. If the wall is further away, ${\mathbf{d}}$ is bigger and therefore $\mathbf{R}$ (EMD) is lower.

The goal is to make the optic flow from each sensor equal (enough). The magnitude output of the EMD, which is the same as the Optic Flow, must match (enough) on each sensor.  In the code, there is a left (blue) and right (orange) line which is the instantanous for each sensor. The output of each EMD is called the collelator as it combines the lagged stimulis. The plot mostly shows spikes but has some diagonal lines which is where the bee is redirecting its trajectory. 

The green line is just the right minus left, the instantaneous differental between sensors, or control error. It is the raw, unfiltered difference in percieved optic flow. Calculated on `line 146` using `np.array(bee.controller.right_corr.outputs) - np.array(bee.controller.left_corr.outputs)`.  A positive peak means at time `t` the right side has a stronger instantaneous flow (closer wall), suggesting a need to steer left. A negative trough means the left side had a stronger instantaneous flow (closer wall), suggesting a need to steer right.

Clearly, this graph is too noisey and erractic for the bee to safely coordinate against. The point of this plot to tells us why the bee actually increase used something more like the Moving Average (Plot 1). 

This plot whilst oscilates between positive and negative because of the environment comprising of only white and black signals. Since the colours are switching the outputs oscilate. The bee cannot use this and instead operates on the Moving Average with smooth out the oscilations allowing the be to react slower and more deliberately.

Ignoring the switching of the spikes in this plot, the magnitude of the spikes start off large start before decaying over time as the bee centers itself. 

![Original Instantaneous Correlators Output](../../labs/IAM_Sussex_labs/lab2/original_corridor_run/Figure_3_Correlators_Output.png)

### Bee Heading (Radians)

This plot shoes the bee's steering deicsions at each time point in radians based on the output of EMD controller differentials. It is the bee's instantaneous direction of travel (its heading angle) measured in radians. The middle red dashed line is given by $\mathbf{\pi / 2}$ radians. It shows the direction perfectly up the y-axis. In this system, the bee only have 3 directions, left, right or centre. This is why the graph is stepped like so. Once the bee has centered it can enter a phase called active centering where it coodinates a pattern of alternating direction switches to keep it in the `margin`. The fact that it makes any direction change, other than centre/straight, means that it is momentary falling out of the `margin`. If the solution has N=10 runs then the graph shows only the final bees simulation results.

![Original Bee Heading](../../labs/IAM_Sussex_labs/lab2/original_corridor_run/Figure_2_Bee_Heading.png)

### Bee Trajectories

This plot compiles the exact path, in terms of y-axis and a-axis coordinates, that each bee simulation took. 

In these plots, the y-axis is distance travelled, not time as it is in all the others. That being said, velocity is fixed at 50 units per second and $T = \frac{\text{Distance}}{\text{Velocity}} = \frac{1400 \text{ units}}{50 \text{ units/second}} = \mathbf{28 \text{ seconds}}$. The number of timesteps ($N$) is the total time divided by the simulation's time step size (dt), which is set to 0.01 seconds: $N = \frac{T}{dt} = \frac{28 \text{ seconds}}{0.01 \text{ seconds/timestep}} = \mathbf{2800 \text{ timesteps}}$. Therefore, the simulation actually runs for roughly 2800 timesteps to cover the 1400 units of distance, not 1400 timesteps. 

In the simulations, "data" is captured upto a certain distance, i.e. when they get to a certain mark in corridor. In this plot they all reach the same distance even if they took different or less optimal paths. A plot with more diagonals will have a longer path and therefore taken longer to get to the same distance. Conversely, a straighter path will be quicker and have a shorter route. Controller sets the bee's linear speed (vel) to a constant value (50) throughout the entire simulation $\mathbf{\text{Time} = \frac{\text{Total Distance Traveled}}{\text{Constant Velocity}}}$. A wobbly bee, that travels a longer total path, must take more time to complete the corridor than a straight-flying bee, even though they both reach the same final $y$-coordinate.

![Original Bee Trajectories](../../labs/IAM_Sussex_labs/lab2/original_corridor_run/Figure_1_Bee_Trajectories.png)


## 1. Experiment with the window size for the moving average.

**How small or large does it need to be to make the controller fail?**

**Does it fail in the same way for very large and very small windows, or do they cause different problems? Why?**

`line 102` changing `window_n` in `OpticFlowController()`

<details> <summary><code>window_n = 200</code></summary>
1. Mismatch start, closely align, high spikes, decay and settle
2. Matched, oscillating steps
3. Large alternating spikes, decay and settle
4. Period of alternativing zigzags, periods of 1 direction, final gentle adjustments with straght sections
</details>

<details> <summary><code>window_n = 190</code></summary>
 Appears to be very sensitive to the number of windows. At a loss of 10 windows, the moving average match capability is vastly reduced. It still have the coordination of matching but the difference is clearly off. Additionally, at smaller values, the smooth effect is depreciated. There are fluttering, short-term spikes within the seconds themsevles.

The bee heading doesn't look too illogical. It goes through chunks of single direction corrections. Within the chunks, the bee is not that stable in its actions. It rapidly switches between turning and perfectly straight and these changes are not uniformly spaced

The initial trajectory paths don't look too disimilar the mid range of the journeys looks much less stable. It would appear that the bees are continually over shooting the centre's margin and having to recorrect. Those over time this correction continues and the overshooting is much less sevre and more like Limit Cycling, although no bees every fly perfectly straight
</details>


<details> <summary><code>window_n = 180</code></summary>

Similar, more erratic bee headings and never truly centreing.

</details>


<details> <summary><code>window_n = 160, 150</code></summary>

Absurdly better performance, bee centres much quicker, uses fewer turns and all bees truely centre

Aquires behaviour of long diagonal periods

</details>


<details> <summary><code>window_n = 140</code></summary>
 Seems to fall out of this "perfect" behavior. The moving average looks more like n=200

The bee heading behaviour is new. Initially it rapidly oscialtes between left and right before settling into directional chunks. but it looses the clean diagonal behaviour, the chunk use rapid shifting from a directionl side to just straight

The beginging phase looks similar to n=200, jaggedly centering. but this window size never truely centres. It has longer-term overshooting waves which are comrised of rapid, non=smooth trajectories
</details>


<details> <summary><code>window_n = 130</code></summary>
 Similr to 130 but regains ability to center more clearly
</details>


<details> <summary><code>window_n = 120</code></summary>
falls back into a window of much better performance similar to 160, 150
</details>

<details> <summary><code>window_n = 100</code></summary>
 very similar to n=200
</details>

<details> <summary><code>window_n = 75</code></summary>
Seems to quickly lock onto periods of strong corrections resulting in centering quickly

The centering is never truely straight but the Limit Cycling is very tight around the centre
</details>

<details> <summary><code>window_n = 50</code></summary>
 very similar to 75
</details>

<details> <summary><code>window_n = 40</code></summary>
a strange jagged arcing correction in the initial phase not see in any other windows but centers clearly in the mid range and in many cases perfectly
</details>

<details> <summary><code>window_n = 30</code></summary>
Very rapid direction shifting through out the paths. Unusual curves and kinks in the paths but generally centers to very tight Limit Cycling range. Although the lines are centered, they are not straight, maintining long flows in the curves on top of the short term jaggedness
</details>

<details> <summary><code>window_n = 20</code></summary>
Very rapid direction shifting through out the paths. Often the long-term trend doesn't appear to be aheading towards the centre. Though often corrects, somehow appearing somewhat near the centre at the end of the timesteps (1400). Though it never in any form travels but the y-axis.
</details>

<details> <summary><code>window_n = 10 </code></summary>
behaviour is broken, entirely veers off to the side out of the plots view. 
</details>


### How to Intepret this Behaviour?

What we have essentitally done here is a parameter sween for the moving average window size for the Hassenstein-Reichardt Detector (HRD) model. The agent's performance appears to rally through periods of improvement with degragation period inbetween before eventually breaking at the lower `window_n` values. 

We can observe that the performance isn't degrading linearly. This type of behaviour is consistent with the nature of control systems - espeically those using filtering and feedback loops. This is a non-linear feedback system.

A moving average window is a low-pass, temoral filter on the noisy, instantaneous EMD ouput. It allows the system to produce a smooth, actional input for use by the controller. 

At small window_w vaues (e.g. 20-40) the filter has less or weak impact. The outputted avergae singal is still noisey and prone to spikes. As a result, the controller engages on radpid Bee Heading direction changes and obtains behaviour of veering off and loosing a desirable trend. 

At large values, the filter is strong giving a very smooth signal. However, this introduces time lags whereby the average smooths why instantaneous information that would be valuable for centering movements. The bee is more responding to where it has been rather than where it is. This creates that long cycle overshooting behaviour where it has to gentle limit cycle to keep itself in the margin. It is perputially correcting on outdate informaiton. 

There appear to be some optimal window's (e.g., 160, 150, 120, 75). These are the poitns where the window was large enought to filter out the high frequency noise but small enough to avoid excessive time lag that destabilize the control ability. These regions are characteristics by learning the ability to travel in long diagonal directions followed by travelling perfectly straight or tight and stable Limit Cycling. 

The key here seems to be balancing the time constraights of the visual input with the moving average. We can call this harmonic matching. The instantaneous EMD output is an oscillating signal whereby the frequency and amplitude depend on the wall pattern, velocity and distance from the wall. Resultingly, there will be a pre-detmerined average time that is takes for the bee to cycle through a patter (white-black). If the window size correlates the the number of time steps then we can interpret this as effectively cancelling out the noisy oscialating signal leading to much cleaner and stable signal for the controller to work from. This is why we can see large improvements in behaviour as we traverse the window lengths, instead of a linear decrease in peformance. Conversely, instead of smoothing, the windows may actually be inducing noise, or cutting of good signals from being accessed in whole. 

When setting the window size, there is a trade-off between smoothing out noise and introducing a time lag. This balance will almost certainly be dependant on other parameters such as velocity and the setup of the walls. 

#### Dominant Oscillation Frequency
Sometimes the underlying pattern, i.e. rapidly switching between white and black, is called a dominant oscillation frequency:
- Bee Velocity ($\mathbf{V}$): How fast the bee is flying forward.
- Stripe Width ($\mathbf{w_{stripe}}$): The width of the black and white stripes.
- Distance to Wall ($\mathbf{d}$): How far the bee is from the wall.

$$\mathbf{f_{osc}} \propto \frac{\text{Angular Velocity}}{\text{Stripe Width}} \propto \frac{\mathbf{V}}{\mathbf{d} \cdot \mathbf{w_{stripe}}}$$

A Moving Average can be known as a type of finite impulse response (FIR) filter. 

There is something called the first 'null' or zero-point frequency point, where $f_s$ is the signal samples:

$$\mathbf{f_{null}} = \frac{f_s}{\mathbf{N}}$$

If the value of N is perfectly poise it can completely cut off and nullify a singal. Imagine 2 time steps passed where the agent crosses a white (1) and black (-1) stimuli. If averaged over a window of 2 the signal is 0. This helps to explain the periods for substantial improvement as we decrease the in-window, e.g. when we moved from 170 to 160. 

Each simulation will be characterised by periods of wall-induced oscialisation determined by the fixed velocity, corridor dimensions and patters. The result will be that full cycles occur when a given number of simulation steps have occured. When the window_n matches this number, the controller will be fed high quality, clean signals during the run, resulting in good centering behaviour and direct diagonal paths. 

## 2. Experiment with the margin size.

How small or large does it need to be to make the controller fail? 

Does it fail in the same way for very large and very small margins, or do they cause different problems? Why?

`line 102` changing `margin` in `OpticFlowController()`

Starting value is `0.0075` and the `window_n=200`

### 0.0075 <- Starting Parameter value
- Agents start with clear approach to repathing towards center
- Some sense of diagonal travel but jagged in nature with many turns
- Agents tend to reach some sense of "centre" around step 600
- Some fly stright but the y-axis but others limit cycle
- The limit cycling is noticable but fairly narrow

<details> <summary><code>Decreasing The Margin Value</code></summary>

#### margin = 0.005
- Inital repath phase is similar to 0.0075
- Some concept of centre is reaching earlier at approx 350
- No agents fly straight vertically up the y-axis
- All agents limit cycle
- The limit cycling is much wider than 0.0075
- Consistently overshooting the margin and having to correct
- But then always overshooting the correction too
- Feedback loop is too delayed for the small target

#### margin = 0.0025
- Converge to some notion of centre very soon around 300
- The period after the inital centre is characterised by a wave rather than any sense of straight
- The wave breaks out into a wider version of limit cycling
- Some limit cycles arent oscilating around the centre. Often spending an extended amount of time on one side of the margin before switching back over
- Some agents do lock onto a vertical path. Though they all happen at different y-axis and a-axis values

#### margin = 0.001
- Same as 0.0025 but even more extreme
- The convergance into divergance can also be seen in the moving average lines

</details>

<details> <summary><code>Increasing The Margin Value</code></summary>

#### margin = 0.01
- Similar re-pathing start to 0.0075 
- Quickly find a concept of centre around 400
- Very short period of limit cycling
- At 500 all agents reach a perfectly straight vertical path
- Though there is a breadth of x-axis finished on

#### margin = 0.025
- Converge to centre at 500 but no limit cycling.
- all agents find perfectly centred and fly straight
- Alot of spacing between x-axis paths

#### margin = 0.05
- No centering
- Agents zig zag momentarily before just flying straight from near enough where ever they started


</details>

### Analysis

The margin parameter is what determines the dead zone where agents fly vertically

Decreasing the margin value results in instability and high sensitivity. The agents struggle to find the dead zone and the lagged feedback loop means they are constantly overshooting it. 

As the target becomes smaller, the demands on the system for perfection are increasing. The result is increased sensitivty of optic flow perceptions. Small changes in Optic Flow result in differential values that switch the sign of `right_mean - left_mean` from which heading direction is determined. This results in aggressive steering which in turn causes the overshoots

The underlying window is set to 200 which is a fairly large window. It allows for smoothing but also induces a time lag. By the time the moving average of `right_mean - left_mean` has signal to the bee to move, it is already too late, causing an overshoot and the requirement for a correction, which will also be signaled late. 

The default margin showed some pretty accurate and robust behaviour. The bees were able to centre themselves and often meet the dead zone. Increasing the margin improved on this behaviour, acheiving centre more efficently. 

However, as the margin become too big the controller lots the ability to generate signals and shutdown, eventually the bees just few straight from where ever they started.

As the increase the margin, the controller gains more tolerance to error. This allows it to find or settle for some notion of centre, even if it isn't truely the centre. A margin which is too large leads to inaccuracy

Where as decreasing the margin causes instability with over exagurated levels of correction and wide limit cycling due to oversensitivity and time lags.


## 3. Experiment with speed

**For higher and lower speeds, repeat steps 1 and 2.**

**How do the different combinations of parameters combine to affect the bee's behaviour?**

**Are there speeds that break the corridor centring response? If so, is this a problem for the theory/model or not**


- Default: OpticFlowController(vel=50, margin=0.0075, window_n=200) -> vel=75

### Experimental Notes

<details> <summary><code>Increasing the Velocity</code></summary>

#### Increase vel to 75

OpticFlowController(vel=75, margin=0.0075, window_n=200)

- Increase vel from 50 to 75
- Increase to 75 appears to induce the mid-range wave effect that we saw when decreasing the margin
- This might make sense when increasing the velocity because the position change per direction change is increased.
- This means that the feedback loop, which causes the overshooting, is amplified causing mutliple overshoots that in the long term trend look like a wave.
- Despite the short wave period, all agents found a route to travel directly straight up the y-axis. No limit cycling took place around the margin. I am not sure how to explain this

#### Increase vel to 100

- This creates entirely new behaviour.
- Instead of repathing from the start, all agents zigzag around their starting point before hitting a strong diagonal and reaching a point where they all fly vertical straight.
- The x-axis values of each agent are pretty spread out. The spread almost looks wider than the margin if this is possible. It is wider that the default runs Limit cyling

</details>


<details> <summary><code>Decreasing the Velocity</code></summary>
 
#### Decrease vel to 25

- Appears to vastly improve performance.
- All bee's repath in diagonal trends to the centre
- All bee's tightly limit cycle around the centre
- Does appear to be a slight wobble in 'straight' trajectory
- I am not sure why faster bees can meet a vertical path but slower bees limit cycle tightly

#### Decrease vel to 10

- Very similar to before in terms of behaviour and performance. However, all bees meet a vertical path this time
- Also, the simulations took much longer to run

</details>

## Analysis

Velocity is the main parameter in determining Optic Flow meaning the bee's mechanism is fundementally changed by altering this parameter.

$$\mathbf{R} \propto \frac{\mathbf{V}}{\mathbf{d}}$$

- High Velocity ($\mathbf{V}$): Increases the Optic Flow $\mathbf{R}$
- Low Velocity ($\mathbf{V}$): Decreases the Optic Flow $\mathbf{R}$


<details> <summary><code>Increasing the Velocity</code></summary>

### Initial Rapid Zig-Zagging

Increasing the velocity means that the baseline perceived Optic Flow signals are increased. Even slight changes in perception are amplifed and fed into the $\mathbf{R_{Left} - R_{Right}}$ calcuations. This is what causes the initial zig-zagging and wave behaviour. The controller is off-center by a large amount and is aggressively steering and trying to rapidly correct but the amplified signals are causing an overcorrection. Additionally, the `window_n` is still building up cumulative windows here meaning the first 200 steps will be disproportionately noisy, reactive with less time lag as they arent averaged by 200 windows yet.  

### Vertical Flying, Residual Error and Margin

Once the smoothing effect of the 200 windows has kicked in we see a new behaviour in the system which makes it appear more "accurate". Technically, the system becomes better at flying straight, not truely centering which is why we see a spread of vertical paths on the x-axis. 

This observation is derived from the interaction between the **residual error** and `margin`. 

Recall, that our smoothing mechanism isn't perfect. Noise is caused by the frequencies of white-black and black-white oscilations as demonstrated in Plot 3. The Moving Average helps to smooth and normalise the magnitude of the signals but the `window_n` is unlikely to perfectly match the frequency timestep, e.g. A window might average 200 timesteps but it only takes 160 to move over white-black-white black meaning averaged signal is incomplete and contains un-actionable **noise**. 

Initally, it might be easy to think that increase the velocity will amplify the noise. However, it actually increases the functionality of the moving average. By moving faster, more frequencies will be taken in as stimuli and the same window will now be averaging over more timesteps. The un-actionable, partial signals are now connected to the rest of their signal and the new partial signals now represents a smaller relative size to the overall signal received is averaged

For example, lets image the `window_n = 200` picks up a signal of `white-black-partial white`. With high velocity it may pick up `white-black-white-black-white-black-part white`. This means the evidence to determine actions from is much higher compared to the residual noise which tells us nothing. Additionally, the partial signal, the noise, is now seen against a backdrop of 6 full colour signals meaning it is obsurces less of the underyling signal. 

Then, once the smoothing has kicked in and some of the time lagged oscillations/waves/cycling has taken place, the agent should be faced with a `left_average` and `right_average` that are remarkably similar. Similar because the signal is very strong and therefore accurate.  

At a high enough velocity, the residual error can be knocked down to it's floor. This is the lowest level that the error can reach meaning the noise is reduced to it minimum. If this floor is lower than the margin, which is an absolute value not relative, then a will functioning controller will be able to match the left and right signals with ease and find the dead zone where it can fly straight

If the `margin` dictates the systems capacity to tolerate noise then stronger, more accurate Optic Flow signals with cause the prevailing noise to be less. 

### Vertical Spread, Less Precise

An interesting piece of behavour here is that a high-speed system is categorically less accurate at finding the absolute centre because its movements are less precise. The increase in velocity means that any change in direction pushes the agent further than before. This is why we see a spread of vertical paths setlted on. 

The form of stability that I high-speed system takes is in its ability to find a stable enough path by matching signals which are strong and of high information quality from the improved Optic Flow signal.

</details>



<details> <summary><code>Decreasing the Velocity</code></summary>

### Weak Signals, Less Freqiences, Worse Infomation
Decreasing the velocity has the opposite effect, a weakening off the Optic Flow signal. In almost all instances we can expect to receive a small error in the signal because there isn't enough information to be gathered by the sensors. Even if the bee is widly off centre, the error will be comparatively small to previous simulations. The Moving Average window is seeing less frequencies, this is less information encoded. 

### Error to Steering Ratio
Additionally, we have a new parameter interaction to account for. Error to steering/direction ratio. The steering is a limited, fixed system. This means the direction changes are perceived more aggressive inrelation to the information given to the controller. Weak signals turn the same as a strong signals. This is known as a low-speed system with a high-gain (correction) amplifier. A smaller error will lead to an aggressive correction.

### Low-Speed, Gentle Stability, Narrow Limit Cycling
However, the low-speed system does itself counter act this. Because the velocity is lower, the distance travelling in the redirection will be shorter. Leading to stability in gentleness. The combination of all these parts is what gives way to the narrow Limit Cycling. At lower velocities, the agents has enough signal to accurately and often diagonally centre itself. But when it gets to the centre its averaged windows are subject to noise and lag. Additionally, the magnitude of the error is small due to the weak signals. In conjunction with a small margin, the error can hover around the margin, and the noise slowly is able to easy the agent outside of the margin with help of the time lag. Eventually, the agent reactions to this redirection the path back intowards the margin. 

### Perpetual Overshooting
This is where the disproportionately strong steering reactions come in. The error will be tiny but the redirection set it in a direction that will not just bring it back inside the margin but overshoot it and meanser outside of the marign on the other side. Due to the weak error and lag, it will be too late before the agent realised this and the same process will perpetually repeat, giving away to Limit Cycling. The cyling will be very narrow due to the low velocity, it will not veer to far off centre but it does not have the mechanism or information to avoid the overshooting

</details>

### Summary

- Fast bees have a small error through signal strength and therefore accuracy.
- Slow bees have a small error through weak signal and there inaccuracy
- Fast bees accuracy find the vertical path
- Slow bees luckily find the margin, hence can fall out and have limit cycle around

The high-speed system is "easier" to stabilize because the ratio of the fixed margin to the residual noise is larger than in the low-speed case, where the controller is constantly fighting to push the signal into the margin.

## 4. Experiment with the environment

Try making the corridor wider or more narrow, by increasing or decreasing w on line 90 of the script.

How does changing the width of the corridor affect the bee's behaviour? Why?


