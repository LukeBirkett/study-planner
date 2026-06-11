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

---

**Waggle Dance:**
I little convoluted for the task at hand but may be interesting to try and port all aspects of the bee biological algo. The underlying mechanism of the waggle dance is that it makes it an ensemble model (is this hive or swarm?). Bees are initalized with different skills and perceptions allowing for a diversity of decisions which normalize to the mean accross a population. 

This could simply be ported over as some sort of voting mechanism from an an agentic perspective. However, usually in ML standards, and ensemble pertains to a fixed number of models who vote among themselves. 

THe goal of this experiement is to find low-cost, bottom-up approaches to finding a solution. If the models are lightweight and data is basic then agents produce a decision quickly. With this understanding, perhaps an genetic algoirthum approach could be taken whereby the agents are not trained but instead randomly initalised 

> Note, could be pretrained as a skeleton and weights randomized from thi starting point

The agents start running and producing votes upto a given number, if after this number there is not an answer, agents keep going until a threshold has been passed and quorum acheived. Simply identificable through pass should be easily identificable but more ambiguous ones will require more agents. 

---