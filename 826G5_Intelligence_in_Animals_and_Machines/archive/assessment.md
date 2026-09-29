# Assessments

| Type | Link | Weighting | Words | Due |
|---|---|---|---|---|
| Modelling Report 1 | [Page](https://canvas.sussex.ac.uk/courses/34991/pages/assignment-1-details-worth-20-percent-modelling-report-option?module_item_id=1509121) | 20% | 1000 | 27 Nov | 
| Modelling Report 2 | [Page](https://canvas.sussex.ac.uk/courses/34991/pages/assignment-2-details-worth-80-percent-modelling-report-option?module_item_id=1509123) | 80% | 2500 | 15 Jan |



[The Hive Mind is a Single Reinforcement Learning
Agent.](https://arxiv.org/pdf/2410.17517)

[SEQUENTION and the Superorganism: A Timeless, Projection-Based Framework for Collective Animal Behavior](https://www.preprints.org/manuscript/202511.1039)


# Sports Data

**Idea Change and Refine:**
Original basis for the idea was a multi-agent, hierarchical approach to analysis whereby the agents employ direct biological algorithms, or systems, to identify aspects of football.

As a slight alternative I had thought about the same approach but isolated to a single type of events, likely through balls and line breaking passes, to understand if agents can be deployed to identify these passes and whether they are good or not. 

It may be the case that this is too in-depth for the project and actually side steps the approach a little bit. 

Instead, a more interesting approach may be to pick up direct the EMD algorithms and apply then to football, specifically passes. 

We could infer the ball itself to be an entity which "records" visuals like a bee flying through the air

The experiement would start by directly applying an EMD algorithm (or something else) to acheive a given task

A hypothesis will be that we may be able to draw some insight as the task is somewhat similar to biological source (need to allign the data so that is this way)

However, this is where we acknowledge that the biological algorithm evolved specific constraints based on embodiment and situatedness.

Perhaps we take some time to explain the biological algorithm and reference some important papers. Need to review whether this would be a requirement. Otherwise I could gloss over this at a high level and instead focus heavily on what an agent/system/algorithm needs to take into accoutn with respect to an environment which is a football match, what embodiement adpations would allow this algorithm to flourish and finally what aspects of situatedness are relevant here. 

These changes, or maybe even a cohort of changes, could be run through the experiement and their results tests against the baseline of the diret algorithm. The goal will be to identify some changes with bring improvement to the algo can get be explained using the princples from the lecture.

---

> Data: Need to think carefully about to how acheive this. The true way to do this would be to use tracking data and identify passes (both line breaking and just normal for constract in training data). The idea would be to then use some sort of transformation to follow the ball line and record the data horizontally to produce two lines of data which correspond to the original EMD experiment. This might prove quite advanced, if it is too much then I think an alternative can be produced using events and 360 data. The pass line and the snapshot position of the players is an adequate proxy. In fact it should produce almost an identical result in most cases. 

> I think there needs to be some justification as to 'why' conduct this experiement. We are looking for a bottom-up, low comuationally expensive way to tag different types of passes. Humans tag "pass", computer apply the detail. 

---

**EMD and Through Balls:**
EMD might actually be the perfect adaption to football and through balls. 

Something that may be indicators to identifying a through ball and its "quality":
- Number of opposition players passed
- Number of teammates passed
- How close the players being bypassed are as this is a measure of the accuracy of the pass

---

**North-ness:**
- I wonder if there is something would "north-ness". A true through ball or line breaking pass probably needs to go forward. If there is an exising bio-mechanism that tracks north-ness then this could be an ineteresting adpation - even more interesting this there is already a bee based mechanism that can be tracked. 

---

**Adaptation: Colour:**
The original EMD is very basic and an adaption probably needs to be made to identify colour

---

**Adaptation: Window Granularity:**
EMD has no persection of depth but close players should occupy more windows. Having more grandular windows will add to the accuracy of the depth measurement which is a hyperparamter that could be played around with to match the given env. It should be different to the bee experiements because the embodiement doesn't require any movement from the ball,there is no controll in this sense. But the brain controller need adquate informaiton on what it is passing. 

---

**lateral angular velocities:**
The bee experiement had a a control loop that minimized the difference in lateral angular velocities. The ball experiement doesn't need this but the **lateral angular velocities** will hold important distinctive information on pass types, and possibly their quality. 

---

**Ball Speed:**
There is something to determine or understand about ball velocity. In the bee experiement optic flow is inversely proportional to distance ($\text{Flow} \propto \frac{\text{Velocity}}{\text{Distance}}$). In the field there is no tunnel but the passing players act as temporary walls. This would have an impact on the information being passed to the brain but I am not sure that it impacts quality. It might if we are trying to model between successful and unsuccessful passes but I don't think we will be doing that. 
- There probably needs to be some sort of adapation to normalize for speed. In the given circumstance, the category or quality of a pass doesn't depend on the speed of the pass but the speed will impact the signal. 
- A slow(er) pass would result in a player being in a window for longer hence imply that the player is closer and therefore look like a better pass, or even skew the signal making a standard pass look like a line breaking one.

> Finally, the authors prove that the honeybee's visual odometer estimates distance by mathematically integrating the total visual motion experienced during flight. Because this odometer tracks absolute image motion across the retina rather than time or metabolic energy, it remains entirely robust against energetic fluctuations caused by headwind loads, providing a direct, low-compute strategy that serves as a core blueprint for autonomous biorobotic platforms.

This might be relevant, does this imply agnostic to speed? No it does not need, bee's are high sensitive to speed. Instead it this is an explanation as to how bees regulate speed without a high-level brain speedometer, using only  its visual odometer. 

The honeybee's odometer estimates distance by integrating optic flow over the duration of its flight. Optic flow is measured as an angular velocity (how many degrees of visual angle a pattern sweeps across the eye per second).

$$\text{Perceived Distance} = \int (\text{Optic Flow}) \, dt$$

Because Optic Flow is mathematically defined as $\frac{\text{Velocity}}{\text{Distance to Walls}}$ ($\mathbf{R} \propto \frac{\mathbf{V}}{\mathbf{d}}$), the bee's odometer is directly dependent on its forward speed. If a bee flies down the exact same corridor twice—once at a fast speed and once at a slow speed—the odometer will calculate the exact same distance.
- At Fast Speed: The angular velocity (optic flow) is very high, but the time ($dt$) spent flying is short.
- At Slow Speed: The angular velocity is low, but the time ($dt$) spent flying is long.

When the brain integrates these two factors over time, the speed cancels out mathematically. This is why the odometer is robust against headwinds: a headwind slows the bee's ground speed down, lengthening its travel time, but the integrated image motion matching the ground covered remains constant.

Because the bee measures visual speed rather than physical ground speed, it is completely dependent on the layout of the environment.
- If a bee flies at $1\text{ m/s}$ down a narrow tunnel, the walls are close ($d$ is small), so the optic flow is intense. The odometer accumulates distance rapidl
- If a bee flies at that same $1\text{ m/s}$ high up in the open air, the ground is far away ($d$ is massive), so the optic flow is nearly zero. The odometer registers almost no distance traveled.

The bee is far from agnostic to speed because it uses its perception of image motion to actively control its flight throttle. As Srinivasan et al. (1996) proved, honeybees try to maintain a constant, preferred rate of optic flow across their eyes.

If a bee is flying along and the corridor suddenly narrows, the closing walls cause the perceived visual speed to jump. The bee reacts immediately to this change by slowing down its physical forward velocity to bring the optic flow back to its preferred baseline.

The bee does not know its speed in miles per hour or meters per second. It is completely blind to absolute mechanical speed, but it is entirely governed by perceived visual speed. It continuously adapts its flight velocity to balance its sensory feedback loops, letting the physical structures of the environment directly drive its behavior.

> The honeybee's visual odometer is completely agnostic to absolute physical distance. The bee has absolutely no concept of "meters," "centimeters," or "inches" because it cannot calculate depth or absolute range. Instead, the odometer tracks an abstract currency: the cumulative sum of angular visual motion (optic flow) that has swept across its eyes.
> 
> Because the odometer integrates optic flow ($\text{Flow} \propto \frac{\text{Velocity}}{\text{Distance}}$), the bee calculates distance entirely based on how close objects happen to be. 
> 
> 1. The Optical Illusion of Narrowing
> 
> If a bee flies a physical distance of 10 meters down a wide canyon, the walls are far away, so the image motion ticks over very slowly. The odometer might conclude: "We have traveled 2 visual units."
> 
> If that same bee flies a physical distance of 10 meters down a narrow pipe, the walls are right next to its eyes, so the visual texture streams past furiously. The odometer will accumulate a massive signal and conclude: "We have traveled 20 visual units!"
> 
> The bee's odometer is so agnostic to distance that you can completely trick its sense of space simply by narrowing the corridor walls. In real-world experiments, bees trained to find a food dish 10 meters down a wide tunnel will stop way too early if you force them to fly through a narrow tunnel, because their odometer registers the required "visual units" much faster.
>
> In summary, the bee is highly sensitive to visual speed (optic flow), but it is entirely agnostic to physical metrics like speed and distance. It simply rides the immediate waves of visual flux, allowing the direct geometry of the here-and-now environment to dictate its steering and navigation.

---

**Waggle Dance:**
I little convoluted for the task at hand but may be interesting to try and port all aspects of the bee biological algo. The underlying mechanism of the waggle dance is that it makes it an ensemble model (is this hive or swarm?). Bees are initalized with different skills and perceptions allowing for a diversity of decisions which normalize to the mean accross a population. 

This could simply be ported over as some sort of voting mechanism from an an agentic perspective. However, usually in ML standards, and ensemble pertains to a fixed number of models who vote among themselves. 

THe goal of this experiement is to find low-cost, bottom-up approaches to finding a solution. If the models are lightweight and data is basic then agents produce a decision quickly. With this understanding, perhaps an genetic algoirthum approach could be taken whereby the agents are not trained but instead randomly initalised 

> Note, could be pretrained as a skeleton and weights randomized from thi starting point

The agents start running and producing votes upto a given number, if after this number there is not an answer, agents keep going until a threshold has been passed and quorum acheived. Simply identificable through pass should be easily identificable but more ambiguous ones will require more agents. 

---


**Data Transformation Diversity:**

As an extension of hive/swarm behaviour, the intitial transformation of the data from nodes on a 2d plane to a 1d trajory parser could also be integrated as a form of diversity. 

The extracted data would have slight variations is capture

This could include setting a param to determine the window width

Maybe something about how wide an entities view channel is. wide would include more context and thinnner less therefore potentially producing slightly different answers and being more suited to particular situations. 

If we want to link include a colour receptor then this could be subject random defect; i.e. only see black and white, inability to see certain colours. 

There could also be changes that are more analagous to machine learning principles:

Dropout, some agents miss some frames. Which could be coded as some sort of fps parameter, or miss out every x frames (windows)

---

**Single Photoreceptor:**
The key underlying research around EMD's improves the signal of a single photoreceptor which can only detects fluctuations in illumination over time; it cannot determine the direction of a moving object.

I am not sure if for a football perspective an EMD even improves on this. In the experiement this could be used as the baseline. 

A hypthosis could be that the differenital that the bee would otherwise use to navigate/realign provides a stronger signal than just simple illumination of timesteps. 

This might not be true though because for a single photo receoptor, a closer entity, stays in view for longer anyway

I guess a failed experiement is still a viable paper and allows me to demonstate underdstading of the concepts as well as explain why porting over the algo failed, even with adaptations. 

---
