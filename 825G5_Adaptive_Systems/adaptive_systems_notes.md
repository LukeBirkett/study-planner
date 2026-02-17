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

#### <u> Systems and Their Environments </u>

We can often think of systems a being coupled whereby an agent(s) and environment impact one another. There is circular causality that flows to and from each agent and enviroment. Because the flows are circular, an agent can essentially have an effect on itself. It changes the env, which changes itself, and so on. 


Llosed loops are generally more interesting than open loops. They can do much more compelx things than open loops. Open loops are characteristed as systems with inflows and/or outflows. A feedforward network is an input and output system. They can do useful things but they don't have the same dynamics and closed systems. 

#### <u> The fitt-est </u>

"Survival of the fittest", not actually first written by Dariwn but largely attributed. Actually written by Spencer. In first edition, Darwin wrote about how well species were fitted to their env. Fitted, a fitness as a specific term here. They do not mean the physical fitness is a muscular or cardiovascual sense, instead we mean evolutionary fitness which is a two-way relationshp between a populaiton and its environment. 

A species fitness is intrisinctly linked to the environment that it is currently in. If the env changes then so does the fitness because it is placed into a new context. 

Therefore, progress in the naturual world does not mean better, better, more complex. It means an improved fit to an environment. The idea of "progress" applies more to artificial than to natural evolution. There are many example in nature that would be "anti-progress" in terms of bigger, better, more complex.

e.g. sticlebacks over time became less armound from predators as their new envs didn't require it (possibly observed as reverse evolution). Revolution has a trade-off, more armour requires more resources. But resources of life are limited. If something can become more simple but still survive or thrive just the same then the fittness is the same. Additionally, fitness can easily go down when an env changes. It could be argued that an over armour fish is less fit because this armour comes with disadvantages.

#### <u> Maintaining a Good Fit </u>

Successful systems fit well into their environemnt. A system can meant an agent, or just about anything. Often the system will adpat to maintain a good fit to an env. 

Successes or fitness is completed dependent on the context and system. Though for living systems it is generally survival. The great thing about artificial systems, or man man, is that we define these terms. 

Bateson: "the unit of survival is a flexible organism in its env". Flexible can be substituted for "capable of adapting". Coupled sys of agent and env can both change to fit changes in the other

#### <u> Timescales </u>

This slide covered the notion of learning vs evoluaiton. Learning is what humans, or agents, do and aquire in their lifetime. Evolution is was changes over many lifetimes. Evolution, or atleast the perception of evolution, is often dependent on the rate of reproduction. Bacteria can evolve very fast in human life terms. 

#### <u> Time </u>

Time is a repeating concept in the module. Today's main interest is "rates of changes" and "relative rates of change". 

e.g. rate of change of ecosystems. Global temperature changes compared to previous periods in time. 

Consdier the rate of change of evolution which takes many generations so may not be quick enough to keep track with ecosystem evn changes. This results in a loss of fitness and risk of non-survival

#### <u> Why do Systems Adapt? </u>

To learn:
* a behaviour or action 
* how to solve a problem
* to compensate for injury or damage
* to adpat to changes in the environment

### Week 1 Lecture Summary

[Lecture Summary](https://canvas.sussex.ac.uk/courses/34987/pages/week-1-introduction-to-adaptive-systems-2?module_item_id=1616848)

### Defining Adaptive Systems

* [Defining Adaptive Systems](https://canvas.sussex.ac.uk/courses/34987/pages/defining-adaptive-systems?wrap=1)

# Week 2

# Week 2 Lecture





# Week 2 Seminar

leverage_points by donna meadows





# Week 3 Lecture





# Week 3 - Seminar










# Lab 0 Negative Feedback

This lab has 3 main aims:
1. To see negative feedback control in action, and to get some feel for both its power and its limitations.
2. To introduce you to the PID controller, which is relatively simple but still far superior to the controller we saw in lectures.
3. To introduce you to Pymunk, a relatively simple and easy to use physics engine for Python. Perhaps some of you will consider using it in assignments.

#### A PID negative feedback controlled pendulum, with an external disturbance affecting the pendulum

![PID System](labs/lab0_feedback_control/inverted_pendulums.png "Project Architecture")

Figure 1 shows a negative feedback controlled pendulum, with a style of diagram that is familiar to you from lectures, but which has the addition of a disturbance which affects the pendulum. **The angle of the pendulum is the controlled variable**. 

We can set the code to either use a reference angle of $\frac{\pi}{2} radians$, so that the pendulum will stand upright, in the inverted position (if the controller is effective). Or alternatively, we can set the controller to use a time-varying reference signal, so that the pendulum exhibits cyclic motion.

In the code for this lab, the disturbance is a randomly varying force applied to the free end of the pendulum in the x-axis only. This means that it has most effect when the pendulum is vertically aligned.

You will also notice that the system diagram shows a different controller to the one covered in lectures. In lecture examples, the controller was a simple proportional controller, where the output from the controller is proportional (linearly) to the error. 

The controller in Figure 1 is a proportional-integral-derivative (PID) controller. In effect, this controller is three controllers in parallel and one of them is the proportional controller. 

The third controller is a derivative controller, and its output is proportional to the derivative of the error with respect to time. The derivative component of the PID controller can prevent overshoot, as the derivative (i.e. how the error is changing over time) has predictive power. 

The integral component, on the other hand, captures information about the history of the error, and can be used to eliminate steady-state errors, where a controller otherwise fails to "catch up" to the reference signal. 

Setting the parameters of the PID controller can be a bit tricky (or at least is easy to get wrong), especially the gain for the integral controller - if any of the gains are too large, the controller can become unstable, but this is especially the case for the integral gain.

The controller is defined as follows: $c(t) = K_p e(t) + K_i \int_{0}^{t} e(\tau) d\tau + K_d \frac{de(t)}{dt}$

Where $K_p, K_i, K_d$ are the gains for the proportional, integral and derivative terms, respectively, and is a dummy time variable.

For simulation (in Sandbox, in this case), we discretise the equation to:

$$c(t) = K_p e(t) + K_i \sum_{\tau=0}^{t} e(\tau)\Delta t + K_d \frac{e(t)-e(t-1)}{\Delta t}$$


where $\Delta t$ is the duration of a simulation time step, and the derivative term can only be evaluated for $t >= 1$

**Types of controllers:**
* If we set $K_i = K_d = 0$, then we have the proportional controller which we are already familiar with.
* If only $K_i = 0$ then we have a PD (proportional-derivative) controller, 
* If only $K_d = 0$ then we have a PI (proportional-integral) controller. 

**Understanding the Controllers:**
* Proportional ($K_p$): "The further I am from the target, the harder I should push." (The Present)
* Integral ($K_i$): "I’ve been slightly off-target for a long time; I need to add a little extra push to close the gap." (The Past)
* Derivative ($K_d$): "I’m approaching the target very fast; I should slow down now so I don't overshoot." (The Future)

Both of these last controllers are quite commonly used, as they are more stable than the PID controller under certain circumstances. In this lab, we will only use the **proportional** and **proportional-derivative** controller variants, as I was unable to create a scenario with this particular simulation where the integral controller component was beneficial, although a future lab with a slightly more interesting and challenging system will use the full PID controller. 

In this diagram, we can think of the controller as being the computational part of the system. The pendulum system includes the motor that the controller specifies the angular velocity (rather than a level of supplied energy or torque) for. This is due to the fact that the physics engine that we are using here, Pymunk, only has one type of motor, which is effectively already feedback-controlled to produce a constant angular velocity - the motor can slow down or stall, e.g. if its maximum torque is insufficient to lift the pendulum, but we don't have access to or control over the instantaneous level of torque.

#### Playing with the System

Feel free to play with the code if you want to, but you can do quite a lot just by modifying the parameters in the parameter file shown in Figure 1. These parameters are:

* `proportional_gain`: The proportional controller gain, or amplification/attenuation factor, denoted $k$ in the Lecture 3.2 slides, but $K_p$ here.
* `integral_gain`: The integral controller gain, denoted $K_i$.
* `derivative_gain`: The derivative controller gain, denoted $K_d$.
* `disturbance_strength`: The scale of disturbing forces. If this is set to 0, then there will be no disturbances.
* `pattern`: This parameter determines whether the reference signal for the controller is fixed or varies periodically. Set to $0$
 for fixed, and to $1$ for periodic.
* `mass`: Sets the mass of the ball on the end of the pendulum (note: this is not the full mass of the pendulum - its bar also has some small mass which we can't adjust from here)
* `main_plot`: This parameter determines whether or not the plot shown in Figure 2 is displayed. Set to $1$
 to display the plot and to $0$ to not display it. 

#### Limitation 1: Not enough force

Video 1 shows the system as you'll find it when you first run the code. The controller has a fixed reference point, and so the goal of the complete closed-loop system is for the pendulum to stand in the inverted position. Although the motor will run at a constant speed, until our controller changes it, the motor has a limit on how much torque (angular force) it can deliver. Here, the mass of the pendulum is so large that the motor fails.

Try increasing the gain of the controller and see if the pendulum will stand, as in Video 2. I'll be very surprised if you will find any gain for which this will be the case, but physics engines can do strange things - if this works, please let me know!



#### Stability through control

Try decreasing the mass of the pendulum, and find the point at which the motor torque becomes sufficient to lift the pendulum and produce plots like the ones shown in Figure 3. 

#### Figure 3: The main plot output from our simulation.

Figure 3 shows the main plot of our simulation outputs. This corresponds to the behaviour shown in Video 2. You may notice a similarity between the plots for the angle of the pendulum and the error. You may also notice what is known as overshoot in the pendulum angle plot: before the pendulum stabilises, it goes past the reference point and then bounces back. The noise and disturbance plots aren't relevant here, because the disturbance scale has been set to zero. The plots are coloured in such a way as to indicate time - not necessary for plots where time is on one axis, but useful in the interpretation of phase portraits. Notice where the lines end in the phase portraits. What does it signify for trajectories in phase space to converge on points like these, and why do the trajectories converge on those particular points?

* **Pendulum Angle**: This is the position of the pendulum in Radians. $1.57$ Radians ($\pi/2$) is exactly 90° (north) and $-1.57$ for -90° (south)
* Angle phase portrait 
* Error phase portrait
* Zero mean brown noise
* Disturbance 
* Error

Try to find a value for the `derivative_gain` parameter which will lead to the pendulum stabilising as quickly as possible without overshoot.

#### Additional Experimentation

Experiment with combinations of appropriate or too high proportional and derivative controller gains, a fixed or periodic reference signal, and various levels of disturbance (try 0, 1, 2, 3 at first for disturbance levels)

* In each case, try to explain what you are observing. Is the system behaving in a way which seems realistic and can be explained in terms of the physics and parameters, or is the Pymunk physics engine producing strange behaviours?
* In every case, look at the plots, especially the phase portraits, and see how they change.
    * If you could not see the animation of the pendulum's motion, what could you tell about the system's behaviour from just the phase portraits?
* Try a disturbance level of 50 or even higher.
    * This is to highlight the limitations of physics engines, and Pymunk specifically - they can all behave strangely, often (but not exclusively) due to the injection of too much energy, as in this case. Actually, in my (fairly limited) experience, Pymunk fails quite gracefully in comparison to some physics engines, where systems are more likely to literally explode rather than just stretch under similar circumstances. 





#### Initial Run

When running initially running the code as it comes, the pendulum starts pointing south and it push up hard on the left handside. It reaches just above level and swings back down. It doesn't quite return to south and then is pushed back up the left where it also doesn't return to the same height as before. This pattern repeats where each swing the low and high points become less extreme. Eventually, the pendulum settles pointing south west. This is the point whereby the motor strength it enough to hold the pendulum and resist it from falling into gravities desired position of handing south. 

The code is set up with `controller = FeedbackController(..., ref_value=1 * math.pi/2)`, this means the target and therefore the error is conditions to 90 degrees, i.e. straight north. 

In the add_pendulum function, the ball is placed at box_offset + Vec2d(150, -50). Because gravity in your space is set to (0.0, -900.0) (straight down), the pendulum starts hanging downwards.

In the run, the pendulum exhibits pulsing behaviour. Infact the motor/controller, which is a proporitonal controller, is constant but it is programmed to changed its output based on the error. This means as the pendulum is shot up, it power reduces and the mass of the pendulum is able to swing it back down. As it approaches south, the motor increases, this is what causes the oscilations. 

A Proportional controller’s output is $K_p \times \text{error}$. As the pendulum gets closer to the top, the error gets smaller. Eventually, the error is so small that the resulting motor speed isn't strong enough to overcome gravity. 

The goal is to have the pendlum stand up right, this is why the motor responds to the error, otherwise, it would continually push the pendulum over the taget. 

Essentially, if the Proportional Gain ($K_p$) is too low, the motor doesn't have enough strength to swing the pendulum and its mass all the way up. Eventually, it gets stuck where the motor's effort perfectly balances out the pull of gravity.

The output of the motor is governed by the `proportional_gain` $(K_p), the target and the current angle: `motor.rate = controller.step(dt, ang, target)`

$$\text{Motor Rate} = K_p \times (\text{Target} - \text{Current Angle})$$


```
proportional_gain: 10
integral_gain: 0
derivative_gain: 0
disturbance_strength: 0
pattern: 0
mass: 100
main_plot: 1
```







--- 

Start Small: Lower the mass until the pendulum can actually move.

Find the Wobble: Increase proportional_gain until it reaches the top but wobbles back and forth (oscillates).

Dampen it: Slowly increase derivative_gain to kill those wobbles.

Stress Test: Once it's stable, crank up the disturbance_strength to see if your controller can fight off the "random wind" acting on the pendulum.

---

Lower the Mass: Change mass: 100 to mass: 2 or 5. This is the most effective way to see the controller actually succeed.

Increase $K_p$: If you want to keep the mass high, try proportional_gain: 100 or higher. However, be careful—high gains with high mass often lead to "Limitation 1" mentioned in your brief (the system becomes jerky or unstable).

Add $K_d$: Once you get it to move, it will likely swing wildly past the top. Change derivative_gain to something like 5 or 10 to "dampen" that swing so it stays at the top.

---


1. Try increasing the gain of the controller and see if the pendulum will stand, as in Video 2. I'll be very surprised if you will find any gain for which this will be the case, but physics engines can do strange things - if this works, please let me know!

2. Try decreasing the mass of the pendulum, and find the point at which the motor torque becomes sufficient to lift the pendulum and produce plots like the ones shown in Figure 3.

Swings over and then starts to swing wildly and pick up speed in a postitive feedback loop. Need to explain why and breakdown chart outputs.

3. Try to find a value for the derivative_gain parameter which will lead to the pendulum stabilising as quickly as possible without overshoot.

This works but I don't fully understand the mechanism behind derivative_gain

While Proportional gain is like a spring that pulls harder the further you are from the goal, Derivative gain is like adding "friction" or "damping"—but a very smart kind of friction.

The derivative term doesn't care where the pendulum is. It only cares about how fast it is moving. In your code, it calculates the "change in error" over "change in time" ($\frac{de}{dt}$).
* Proportional ($K_p$): Reacts to the Present error.
* Derivative ($K_d$): Predicts the Future by looking at the current velocity.

Imagine you are driving a car toward a red light:
* If you only used Proportional control, you would keep your foot on the gas until the moment you reached the white line. By then, you'd be going too fast and would sail right into the middle of the intersection.
* Derivative control is like seeing the line approaching and applying the brakes before you get there.

FeedbackController.step() function, the $K_d$ part of the formula is:
$$K_d \times \frac{Error_{current} - Error_{previous}}{\Delta t}$$

When the pendulum is moving fast toward the target: The error is shrinking rapidly. The derivative becomes a negative value.

The Result: This negative value subtracts from the motor power. Even though the Proportional term is still screaming "GO!", the Derivative term is saying "SLOW DOWN!"

The Outcome: The pendulum "glides" into the upright position and stops dead at 90° instead of swinging past it.

. Why it makes the "Pulse" disappearWhen you only had $K_p$, the system kept overshooting, falling back, and overshooting again (the pulsing).When you add $K_d$:As the pendulum swings up, $K_d$ creates a "counter-torque" that fights the momentum.It removes energy from the system (specifically, it removes kinetic energy).In your Phase Portrait, you will see the circles stop looping and instead spiral tightly into a single point.


So just to be clear the proportion control and derivate controller and acting against each other the whole time. It just that at the top, pointing north, there exists a point whereby the prop control has no power, i.e. exact north, this means there is no power to push it beyond the target, however, the derivative still has the calculation from the previous movement meaning it stops the momentum from taking it over?

You’ve almost perfectly captured the intuition, but there is one subtle, brilliant distinction to make regarding that moment at the "Top."

Think of it like a tug-of-war between two different types of logic:

Not quite. They are only acting against each other when the pendulum is moving toward the target. 

 As the pendulum swings UP toward North, $K_p$ is pulling it Up, and $K_d$ is pushing Down (braking). Here, they fight.

 If the pendulum starts to fall AWAY from North, the error starts getting bigger. Now, $K_p$ pulls Up to fix it, and $K_d$ also pushes Up to stop the falling motion. In this case, they actually work together to catch the pendulum.

 At $90^\circ$ exactly, Error = 0, so $K_p \times 0 = 0$. The "Gas Pedal" is at zero.

 It doesn't actually use a "memory" of previous power, but rather the current velocity.

If the pendulum reaches North but is still moving (it has momentum), the Derivative term sees that "Velocity is not zero."

It calculates: "We are at the target, but we are moving at 5 m/s! Apply -5 units of force immediately!"

The Result: It cancels out the kinetic energy exactly as you reach the goal.


3. The "Steady-State" Problem (The "Catch")Here is the part that usually trips students up: Once the pendulum is perfectly still and perfectly North, both $K_p$ and $K_d$ are zero.$K_p$ is 0 because the error is 0.$K_d$ is 0 because the velocity is 0.So why doesn't it just fall immediately?In a perfect simulation with no gravity, it would stay there. But because gravity is pulling it down, the moment it leans even $0.001^\circ$ away from North:Error appears ($K_p$ kicks in).Velocity appears ($K_d$ kicks in).The "North" position becomes a Dynamic Equilibrium. The controller is constantly making tiny, microscopic adjustments. It looks "settled" to your eye, but if you looked at the data, the motor is likely vibrating at a high frequency to keep it balanced.

Summary of the "Top" Logic:Proportional ($K_p$): "Are we there yet?" (Power based on Distance).Derivative ($K_d$): "How fast are we arriving?" (Power based on Speed).When you combine them, $K_d$ "eats" the momentum that $K_p$ created, allowing the pendulum to arrive at North with Zero Velocity.



```
proportional_gain: 10
integral_gain: 0
derivative_gain: 1
disturbance_strength: 0
pattern: 0
mass: 75
main_plot: 1
```





Basically, get the balance to move past north and then use the deriviate_gain to correct for this

**Would you like to try adding a "Disturbance" in your YAML file now to see how the $K_d$ term helps the pendulum "recover" when something knocks it off balance?**


THEN MOVE INTO ADDITIONAL EXPERIMENTS


