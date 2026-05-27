
## Basic Introduction to Football Netowrks
Football (passing) netowrks are small but dense. The interest is in the dynamics and iteractions rather than the volumne of nodes - which is almost fixed. 

Approaches in sport move beyond descriptions and focus on comparisions. Teams approaches and tactics are reflected in their networks, whether that be because they are high structures or perhaps highly chaotic, direct team. 

A slightly more complex network network but naturally sports networks have interesting Temporal Dynamics. The network will evolve and change during different phases of the match. It is important to look at properties with respect to succesful. E.g. during such periods, how did given centrality measures change. 

---

## Simple Assessment Lineage: Translating Network Science to the Pitch

1. **Degree Centrality**: A player's ball involvement.



2. **Closeness/Proximity**: A player's accessibility for a pass. 

> There is an intersting line of research around player positions and pass frequency to explore here. 

> Construct a baseline null model where the probablity of edges are based on the proximity of players. In theory this should be mean that the central players, likely midfielders, will have the highs degrees and potenital to be come hubs. Additionally, by simulating the construct 1000s of times, we can get a baseline of how often non-central players can become "hubs". This could then be compared to a whole season. There may be some games where less-central players become highly connected hubs. It might be easy to be watch this game and deduce said player is a talented player. However, the naive null model may tell use that through randomized topology alone, these types of players will become hub X% of the time. Comparing to a whole season we can see it elite players in genreal, or even just an indiviudal(s) exceed this average. 

3. **Betweenness Centrality**: A player's role as a "bridge" (e.g., a central defensive midfielder connecting the defense to the attack).


4. **Clustering**: Tactical triangles and localized support play.

> There is something really important here about determining what a triangle is in football. The network is small so the emergance of triangles may begin to exist all over, particular as different phases of play result in dynamic positioning where disconnected players may briefly connect. An A > B > C > A triangle might be huges important for some area of the pitch to show conenctedness, but A > C > C triangle would better demonstrate directness. 

5. **Null Models**: A tool for inferring the properties of a. given network are statistically signficiant.  A common critique from pure network scientists is that many papers report raw metrics (like density or clustering) without a mathematical baseline.

> **Why do we need null models?** Imagine Team 600 passes vs Team B 300. A will have high density and clustering (triangles) due to volume. A cluster metric in isolation cannot infer tactical structure. To determine this, you build Random/Null/Config models with 600 passes. If these models acheive the same properties naturally then they are not due to tactical means. 

---

## Network v Football Basic Translations:
The **degree** is the teamates a player interacts with and the **strength** (weight) would be the total volumn of the interactions. The most common and intuative version is passing networks. 

The **degree distribution** can be thought of in terms of tactics and formation. If the degree distribution is **homogenous** then most, or all players, have a similar degree, implying a decentralised system. Think about total football systems like Ajax or prime Barcelona, if 1 player is cut off the passing triangles do not stop, they friend a way through with a different cluster of players. 

Despite being small networks, we can stil see the emergence of **heavy-tails** though the prominence of playmakers and possesion retainers. A **"Hub-and-Spoke"** distribution is a common emergence in teams with a high influential central-midfielder. This node has massive degree/strength compare to the rest of the nodes. 

Due to the constraints of the network size, they cannot be scale-free as this requires $N \to \infty$ and a power-law $k^{-\gamma}$. But they can obtain **small-world** properties. Small-wordness calculated by comparing the **average path length $L$** and the **clustering coefficent** against a random random of the same size, and/or properties as mentioned before. 

**Degree assortativity** is a natural progression topic from these points. If high degree players are **disassorative** they mostly pass to players so themselves are less connected. This is indicative of the hub-and-spoke network where a highly influential player can connection directly different areas of the pitch. It is also in interest point to consider which are the low degree players in this scenario. 

Typically, over the course of a full match, the network (passing) will be a fully conntected graph, i.e. **one giant components**, as throughout the match there will likely be at least 1 pass/interaction between players. However, analysis on the **largest connect component** can be unvieled using a **thresholding** approach, or **temporal** phases where a 10 minute phase might see play concentrating in certain areas or amongst particular nodes. Refering back to the notion of comparing teams, it would be interesting to see how different thresholds affect each team. Resilient, balances teams may retain their largest compents even as the threshold raises but a fragile team will soon begin to fragment - then these fragments because they represent intra-team cliques. Where do the connection remain even as things are getting difficult and falling apart. 

---

## PassMap: Directed and Weighted Network
A PassMap is a directed and weighted network. This makes null models, config models and "swapping" edges a little more complex. We want to preserve the topology (connections) and the weight distribution (amount of passes). In football, not all connections are made equal. The fact a connect exists is important but the weight, or lack there of is even more important. 

An interesting experiment because be weight-shuffling. You need the skeleton of connections the same but extract all of the "weight" into a bucket. this can be then distributed across the existing skelton nodes/edges. Doing so builds up the probabilty distributions, if a random network tends to build up weight in a certain coridor then that is a function of the topology and structure, not the specific talent of the players. 

Configuration modelling also becomes much more complex in a directed weighted setting. The appraoch is to use the half-edge method. In terms of stubs each node as two types of connectors. The out-stubs representing the passes they made, i.e. the out-degrees. The in-stubs representing every pass they received, i.e. in-degrees. Plays have their pre-detmined statistics, 60 passes made = 60 outstubs, 10 recieved means 10 in-stubs. To build the config model you work on building out the stored weight. 

Once this has been completed, you have a null model, infact you will run in 100s or 1000s of times to produce many networks. This can be used to measure tacitcal intent. For example, you calculate the clustering coefficient, which is the tendency for players to form passing triangles. A highly structured team that you are looking at may have a high clustering of $0.6$. If the randomized stub networks have an average clsutering of $0.2$ then we can prove that the passing triangles in the team are the result of cumulative passes, as we kept the same number of passes in the null model, they are a deliverate structural feature of the managers tactics. The null models proved that the number of given passes didn't need to form passes, but in the team network they did. 

---

## Using Null Models in Football:

#### Erdős–Rényi (Random) Null Model
Take an **Erdős–Rényi (Random) Null Model** and treat it as the zero intelligence baseline. It can be construct with the same number of nodes and edges as a team or match you are analysing by using a a fixed probability $p$ but the connections themselves are randomly assigned. 

E.g. you take 11 nodes and the exact number of passes made in a match, or period. Rewire 400 passes completely randomly. This establishes a "baseline" team that has with zero tactical intelligence.

Compare the Average Path Length/Clustering Coefficient ($C$) of the real network to the random/null ($C_{rand}$). If $C \gg C_{rand}$ then this statistically prove the team's triangles and properties are the result of deliberate tactical choices.

#### Configuration
Random/nulls are limited on what they preserve of the empircal network, i.e. nodes, total degrees. We can use a **configuration model** for preserving the exact degree sequence (the number of connections each specific node has) but randomize who they connect to through a rewiring process.  

For Football, a pure ER is too unrealistic as it assumes all nodes are the same, where a goalkeeper will *never* make as many passes as a central midfielder. A config model allows nodes to retain their own unique properties. 

Config models are the gold standard sports null models. It is a way to prove that the empirical shortest lengths are tactically engineered passing lanes. Central midfields retain their "hubness" but randomize their actions. 

Compare **assortativity** after rewiring many versions. If the team becauses less assortive then maybe the real team contains a strong spine of players that constantly interact and keep the team together. It is not enough to have a 11 players to make X number of pass per match, the connections are more important. 

Alterantively, if you are able to match metrics between real and nulls, then that demonstrates that something isn't down to some tactic genuis, it is a byproduct of the game/match. 

> Null/Random models are used in research to prove that **elite** football teams exhibit Small-World properties. The clustering is much higher than random models as players form tight, deliberate passing triangles, above what a random baseline would produce. 


#### Proximity
Football is played on a 2d plane. It make sense that players **closer together** are more likey to be connected. 

An interesting experiement would be to create a null model where the probability of an edge existing betwen two players is function of their average distance on the pitched. Apparently this is called a gravity model. 

By comparing teams networks to this baseline we can infer statistically signifcant links between players, if a a strong link appears to defies the natural geometry of the pitch.

---

#### Micro, Meso and Macro Focuses
Alve's "Systematic Review" determines there to be 3 levels of metric in apply networks to football: Micro, Meso and Macro. 

> SNA analyses typically focus on three distinct levels: micro (individual player metrics), meso (small groups of players), and macro (the entire team’s network) (Buldú et al., 2018)

This could be conjucive to putting together a flow for the assessment. Approach, demonstate and explain the different network science concepts applied for each level. 

Then after have an exteriment section where pick 1 (or more) topics that are most interesting or easy to analyse. The experiement would be focused on generating Null/Random Model baselines to compare some real-world empirical data too. Look for trends in the metrics and try to find something that stands out. I think the distribution of hubs by area/position was a good one. Use the entire season to build up some empircal standard and then compare this to the baseline. 

---

# Idea Thoughts 1

These passing networks are very popular in the football analytics community [e.g. twiiter viz accounts, blogs, articles]. They are often part of a package produced post game to provide summary in formation on how the game went. However, whilst they are very informative and contain and provide lots of information, they feel like a one glance and move piece of analsys. You might look at the network to assess the formation and the key players (or last of influence) and then move on to looking at these aspected some where else. 

This report indents to move past using networks as a descriptive visualisation and towards utilising them as a prescriptive tool that tells us is something or someone is signficant

> Descriptive simply observes and explains what is, focusing on facts, data, and actual behavior. Prescriptive dictates what ought to be, providing rules, recommendations, and judgment

The first part of the report applies various Network Science tools and methods to demonstrate how and where they apply to the domain

The second part is an experimental phases that looks to compare empiral real-word data from X to random/null models baselines. The emprical approach build on networks as a snapshot and aggregates properties over an entire season [average, min, max, var, sd]. This enables us to use networks from temporal/longitude perspective were the way properties and nodes evolve and over time can be taken into account [pretty sure aggregation qualify as this].

By comparing random baselines, we will be able to we will be able to determine if certain properties are truely unique, impressive, standout (i.e. based on talent or tactical) or natural result of randomness imposed by the contraints of the game itself (11, pitch) and the probability distribution (something about average vs sd, does an observed state exceed 1 sd)

- distriution of hub to wider areas. are there any players, or samples that exceed what is randomly expect (theory clustering/hub/degree dist should be centered)
- small wordedness, via path lengths. there is some naunce on how to construct this and it probably needs some thresholding as a single pass from goalkeeper to striker doesn't represent a good path. but a chain through the center 10 times a match does. I also thing this will be the most interesting because it i think that there is a good chance the the constraints of the network and the fact that the network is small might make it small-worldedness by default. Even if this is the case, it means finding matches where a team is not small-world is signficant. there will probably need to be a breakdown of analysis by number of passes as volumne skews (increases) most network metrics. 
- something about centrality and clustering but not sure what yet

--- 

# Idea Thoughts 2
- lit overview of diff approaches in applying data to sports (football + other). The scope down into the different ways networks have been applied
- there needs to be a clear and defined reasons for why network science should be applied to football. there are plenty of motivation references and mostly split into prediction and tactical. 
- then move into the first part of the project demonstating how network science can be applied. taking my dataset and applying the base network principles and trying to translate what we see from the network perspective to the football/tactical perspective
- constructing directed weighted pass maps, computing degrees, analysing degree distribution, hubs, centrality measures, clustering
- send half of the project is the experiemental phases. the main approach is to construct a method of create null models in football (also demonstating why existing methods are not suitable)
- null models offer that of a baseline. we can compare some empirical finding and use the baseline(s) (because we generally generate 1000s of nulls) to determine if it is signficant or due to the underyling structures and constraints. 
- from a football perpective significant means tactical, talent or unusual. 
- the real challege of the projects will be to find a construction method that is appropriate and usuable. 
- once acheived the analysis should be quite easy. maybe even run a few expierments to produce findings. 

---

The main theme of this project is structure structure-focus. The first part of the project will be demonstrating the different properties that can be derived from the network structure. then we will be trying to build the structures and compare properties of structrures.

Potential title: Beyond Descriptive Networks: "Using Spatially-Constrained Null Models to Identify Statistically Significant Tactical Hubs in Football."

The reason we build null models is to answer whether the topplogical structure we are observing (e.g., high centrality, specific clustering, a winger acting as a hub) a deliverating meaningful featuere, or just a random byproduct of the tasks constraints. 

However, there is also a "Dynamics and Probe" aspect. This is becuase the real challenge here is building an effective null model. A standard degree-preserviing configuation model won't work because the nuance of individual players and there positions means the reconstruction needs to to cater to these as constraints.

The most likely approach will be to explore a spatially embedded null model (where the probability of a link is a function of the average distance between two players' positions) or a formation-constrained model.

---

# Possible Approches to Null Model:
The goal is to preserve the system-level properties (like total passes or formation spacing) while randomizing the player-level assignments.

## The Gravity Model
Borrowed from human geography and transportation economics. It interaction metric (passes)between two players proportional to their overall involvement (mass) and inversely proportional to the distance between them.

The expected weight $w_{ij}$ of a directed pass from player $i$ to player $j$ is modeled as:

$$w_{ij} = k \cdot \frac{(s_i^{out})^\alpha \cdot (s_j^{in})^\beta}{f(d_{ij})}$$

- $s_i^{out}$: The total out-strength (total passes made) of player $i$.
- $s_j^{in}$: The total in-strength (total passes received) of player $j$.
- $d_{ij}$: The Euclidean distance between the average spatial centroids $(\bar{x}_i, \bar{y}_i)$ and $(\bar{x}_j, \bar{y}_j)$ of the two players over the match.
- $f(d_{ij})$: A distance-decay function, typically exponential $e^{\gamma d_{ij}}$ or power-law $d_{ij}^\gamma$.
- $k, \alpha, \beta, \gamma$: Parameters fit to your entire season's dataset via Maximum Likelihood Estimation (MLE).

To use it you would fit the parameters of a given formation (gloss over but determining this would be important) and then you can $k, \alpha, \beta, \gamma$: Parameters fit to your entire season's dataset via Maximum Likelihood Estimation (MLE).

$k, \alpha, \beta, \gamma$: Parameters fit to your entire season's dataset via Maximum Likelihood Estimation (MLE). 

$$P(i \to j) = \frac{\hat{w}_{ij}}{\sum_{m,n} \hat{w}_{mn}}$$

Basically, I think the perspective is that there is almost a "training" phase (MLE). Using a cohort of data you build up these probabiltiy distribtuions based that can be sampled on. You look at game and optain a sent of parameters which represents the formatuions (or average position). You then sample the distributions using these parameters, i.e. if I have player X whose average postion of Y, sample the prob dist of passing to player Z who has their own average position. The season data givw you an empirial distribution to sample from. Therefore, if a player have 25 passes in a match, you run a model that randomly assigns passes. Based on the position based impirtical dataset, it will build up a pass map that is reflective of the average. We can then use this to compare to the empirical data. Are they different and by how much. If we same 1000 times, do we get any that look like the empirical and what is the % of acheiving something similar. Similar might need a metric and need to be thresholding to determine similar. Most basic would be to look for hubs, what % of match are these positioned players becoming hubs. 

---

## Exponential Random Graph Models (ERGMs) with Spatial Controls
ERGMs are generative, statistical models for networks. They allow you to specify macro-level structural features (like reciprocity or triangle closure) and spatial covariates, calculating the probability of seeing your exact match network.

$$P(Y = y) = \frac{1}{\kappa} \exp \left( \sum_{k} \theta_k g_k(y) + \theta_{space} \sum_{i,j} y_{ij}d_{ij} \right)$$
- $g_k(y)$: Network statistics you want to control for (e.g., total number of edges, number of reciprocal edges).
- $d_{ij}$: The spatial distance between players.
- $\theta_k$: The coefficients (weights) assigned to those structural properties.
- $\kappa$: A normalizing constant (the partition function).

You estimate the parameters ($\theta$) using Markov Chain Monte Carlo (MCMC) over your baseline matches. Once estimated, you sample hundreds of synthetic networks from this probability distribution.

**Why it works for your project: It allows you to say: "Even when controlling for formation distance and the natural tendency for football players to pass back-and-forth (reciprocity), wide players act as hubs significantly more/less than expected."**

---

## The Spatial Configuration Model (Maximum Entropy Approach)
Soft Configuration Model adjusted for spatial constraints via Maximum Entropy. Standard configuration models break links into "stubs" and re-wire them randomly. To force space into this, you apply an optimization constraint. You want to maximize the Shannon Entropy of the graph ensemble:

$$S = -\sum_{G} P(G) \ln P(G)$$

Subject to two constraints:
1. The expected degree sequence matches the empirical network: $\langle k_i \rangle = k_i^{emp}$.
2. The expected degree sequence matches the empirical network: $\langle k_i \rangle = k_i^{emp}$.

Using Lagrange multipliers, this yields the probability of a directed link existing between $i$ and $j$:

$$p_{ij} = \frac{1}{e^{\lambda_i + \mu_j + \gamma d_{ij}} + 1}$$

You numerically solve for the hidden parameters ($\lambda_i, \mu_j, \gamma$) using the empirical degree sequence and distances. This gives you an analytical probability matrix $P$. You can directly compare your winger's empirical metrics to the theoretical distributions derived mathematically from this matrix, bypassing the need for heavy simulations.

---

Approach 3 proves whether the player over-performed the tactical position, while Approach 1 proves whether the tactical position itself defies spatial logic.

---

# How to Test/Check that Null Model (Method) is Good
A good null model acts like a well-calibrated scientific control group. it needs to replicate the intrinsic, baseline physics of the system while stripping away the specific strategic anomaly you want to test.

If the null model generates networks that look completely alien to a game of football (e.g., center-backs launching 100 passes a game directly to the striker over 70 yards), the baseline is bad, and rejecting the null becomes a trivial, meaningless exercise.

## Topological Distance Tests (Macro-Scale Validation)
Need to how that the "shape" of the simulated models matches reality across non-targetted metric, i.e. if you target replicating degrees then need to check with something else. 

The approach is to generate an esemble of N=1000 null networks using the proposed methods. Compare the distibutions of network properties using distance metrics like Jensen-Shannon Divergence (JSD) or a simple two-sample Kolmogorov-Smirnov (KS) test.

- The total number of passes (edges) in your null graphs must exactly equal the real match. (If using a generative model like the Gravity Model, check if $\sum w_{ij}^{emp} = \sum \hat{w}_{ij}$).
- In football, passing triangles form naturally. Your null model should replicate the global clustering distribution of a season without over- or under-estimating it.

> this one feels intuatively really important. football is a game of triangles but these triangles are usually quite distinct and close range. cross field triangles would be alarming. though it not immedietly clear how to analyse clusting to figure this out. Maybe, there is someething around comparing A > B > C and checking max length, or direction.

- **Graphlet Frequency Distance (RGFD):** Check the micro-structure by counting small 3-node or 4-node subgraphs (motifs). A good spatial or formation null model should naturally reproduce local passing loops (e.g., full-back $\leftrightarrow$ central mid $\leftrightarrow$ winger) without explicitly being told to.

> Perhaps, the key to checking null models to is to contruct check that validate the norm of football. passing chanes on average progress the ball. if there is an over representation of chains that go back then this is an alarm. or if passing chains (2,3,4...) are hugely over represneted then the model isn't working. 
> 
> Someting that I hadnt considered before is tha the generative process is building the underlying data. The data distribution being samples could be something like P_1 > to which player where each player/pitch position (or both, i.e. pitch position sampled first, then position samples based on an inner distribtuion) has 


## The Falsification Challenge (The "Straw Man" Check)
To prove your null model is sophisticated, you should intentionally pit it against a "naive" null model (like a standard degree-preserving configuration model or an Erdős-Rényi random graph) to show how they fail where yours succeeds.

> this is really important to do in the report as it give a chance to demonstate the i understand and know about null model, explain why they won't be suitable and then show that they aren't

I am not sure what the approach for evaluating this would be. It needs the same evaluation steps as the constructed models so I guess they would evaluated at the same time. 

#### Examples:
- **Pass Distance Distribution:** A null model would fail because it would produce things like 80 yard passes as the same rate as 5 year passes. 
- **Positional In-Degree Bias:** The null model would fail because it would distribute passes bildly to nodes. central midfields with disproportionately low degrees and wingers as regular hubs. 
- **Statistical Power:** We want to compare things to the null to infer statistal signficance. The null models would just be random noise, hence, any pattern founds in the empirical would flag up as statistically signficant. Where as with want a model which "selective rejects the null". The null tells us that a given finding would only occur in 1% of randomly generated models. But a seasons worth of data might show a particular player/team is acheiving it 50% of the time. 

---

## Distance-Decay Alignment (For Spatial Models)
If the proposed Null is a gravity model, then the spatial decay function need validating. 

In football, passing frequency between two nodes, drops over physical distance. Recall that this gravity model is adpayed from physics/geo. Things like magnets follow a cost function. 

Extract the length of every single pass in your empirical dataset and plot a probability density function (PDF) of pass lengths. Then, extract the pass lengths generated by your simulation.

The empirical pass-length curve and the simulated pass-length curve should closely overlap. If your simulated curve is shifted to the right, your distance penalty parameter ($\gamma$) is too weak, meaning your model is letting the ball fly across the pitch too easily.

---

> In the methodology there can be a chapter titled "Model Validation and Calibration."
> 
> Conclude this chapter with a brief high level statement
> 
> "To ensure the null ensemble does not serve as a 'straw man' proxy, it was validated against global topological properties. The null networks successfully reproduce the empirical team-level clustering coefficient ($p > 0.05$, KS-test) and physical pass-length distributions, confirming that any rejected null hypotheses at the node level (the wide hubs) represent genuine tactical outliers rather than systemic or geometric artifacts."

---

# Empirical Baseline (League) vs Null Model Baseline
In the (contemporary, alves) research, there is not null model applications. 

However, most, if not all, papers use emprical baseslines. For example researches may say team X (barca, monaco, benefica) demostate better Y propertie that the league average. 

This only tells you have something is different but it cannot tell you why it is unusual. 

Generating null models goes beyond the raw data because it allows you to separate systemic constraints (geometry, rules, and mathematics) from deliberate human strategy.

#### Disentangling "Formation Bias" from "Tactical Intent"
Imagine during analysis we find that player X from Y team players as a left-winger but has a massive betweenness centrality score compared to the league average for all players. Clearly we have used the league data to identify that they are different. 

**The Empirical League Baseline tells you:** "This winger is a significantly bigger hub than 95% of players in the league."

However, from the network we derive the team A are using a 4-3-3 formation where as most of the league uses 4-4-2. The answer we are looking to answer is whether the play is have a standout game, or the underyling conditions are "forcing" a given property. 

By using a Position-Permuted Null Model, you can freeze that exact match's structural profile and swap the players around. If every player you shuffle into that left-winger slot automatically yields a massive centrality score, your null model has just proven that the position is the hub, not the player. If the real winger's score still eclipses the shuffled simulations, you have isolated true, individual outperformance.

> to be clear, shuffling the players means generating new network with the same underlying conditions. if the new networks show the same nodes producing the same or similar poperties then it is likely the formation (tactics) rathern than a unique performance. 

#### Controlling for the Tyranny of Geometry (Spatial Constraints)
Football is played on a bounded rectangle. Central midfielders are surrounded by 360 degrees of passing options; wingers are trapped against the touchline with only 180 degrees of options. Because of this geometric reality, central players will always dominate raw network metrics like degree centrality and page-rank over a season-long empirical average.

If you only compare your winger to the league average, they will look like a fringe player. But a Spatially-Constrained Null Model (like the Gravity Model) builds a physics-like baseline that explicitly penalizes options based on boundary constraints and player distances.

When your null model says, "Based on pure geometry, a player standing in this exact wide coordinate should only receive 4% of the team's passes," and your raw data shows they received 22%, your null model has exposed a massive tactical anomaly that a league average would completely smooth over and hide.

#### Dealing with the "Environment Variance" (No Two Games are Equal)
A empirical dataset assumes all passes are the same and therefore can be compared. Networks are highly sensitive to the prevailing curcumstances. 

**Against a Low Block:** A team might rack up 800 short, low-risk passes among defenders, sky-rocketing the team's clustering coefficient.

**In a Chaotic End-to-End Match:** The team might only make 300 direct, high-risk passes, tanking their clustering coefficient.

It's not correct to compare a choatic individual match to the league average. it will compare as being messy and unstructued. 

A Generative Null Model evaluates the match against itself. It asks: "Given that this specific match featured exactly 300 passes distributed across these exact player coordinates, what is the mathematical probability that a winger would emerge as a hub?" It calibrates the baseline to the unique context of that specific game, offering a level of precision an empirical average can never match.

---

> "While empirical league baselines identify relative variance between subjects (e.g., how Barcelona differs from Getafe), they fail to isolate the underlying mechanism causing that variance. Conversely, a mathematically defined null model provides an ab initio baseline that controls for spatial, geometric, and rule-based constraints. This allows us to separate statistical artifacts born of pitch geometry or formation structure from genuine, intentional tactical anomalies."

---

The answer comes down to three things that raw data filtering cannot do: handling multi-dimensional confounding, creating counterfactuals for unique contexts, and isolating structure from volume.

#### empirical data suffers from the curse of dimensionality
you want to compare an individual match to a baseline which reflects similar circumstances, i.e. controlling for given factors. Here you can't just look at the league averge because you would then be comparing to matches that: used diff positions, played against a diff system (low-block), played in a team with much more possion (more edges). As you filter down the dataset to get these same/similar conditions you might find yourself with a dataset of only 3/4 matches. 

The Null Model Advantage: A generative null model (like the Gravity Model or an ERGM) solves this by abstracting the rules of the system rather than matching the scenarios. It learns the underlying mathematical relationship between physical distance, player involvement, and pass probability across the whole season. It can then instantly generate a custom, statistically sound baseline for any combination of variables, even if that specific combination of possession, formation, and spacing has never happened before.

#### Generating the "Counterfactual" for a Single Match
A network is not just a collection of independent nodes; it is an interdependent system. If a winger behaves as a hub, it affects the degree centrality of the left-back, the central midfielder, and the striker simultaneously.

If you just look at the historical data of "how wingers usually perform," you are looking at an average of completely different systems. You cannot easily answer the exact counterfactual question for this specific match:

"In this exact game, given how the other 10 teammates were moving and spacing themselves, how much of our winger's high centrality was due to his teammates' positioning, and how much was due to a deliberate tactical instruction to feed him the ball?"

With Empirical Filtering, you are looking at completely different matches with different teammate positions. A generative null model freezes a given matches exact 11 player positions (coords) and simulate aleratnvie networks based on this

A position-permuted or spatially-constrained null model holds the exact geometry of that specific match completely frozen. It shuffles the network on that exact coordinate map. It tells you what is expected on that night, with those exact teammates, in those exact positions. Empirical filtering can only tell you what happens on average across the league.

#### Separating Network Structure from Event Volume
This is the most "Network Science" reason of all. Network metrics like Betweenness Centrality, PageRank, or Eigenvector Centrality are non-linear. They don't just measure how many passes a player received (In-Degree); they measure who passed it to them and how central those players are. If a team plays a match with 800 passes, all network centrality metrics will naturally scale up and behave differently than in a match with 300 passes.
- If you use an empirical baseline, you are mixing high-volume matches with low-volume matches, which warps non-linear metrics like PageRank.
- If you use a Null Model, you condition the simulation on the exact degree sequence or edge-count of that specific match.

The null model allows you to say: "Even when we artificially scale the network to have exactly 412 passes (the exact volume of this match), the arrangement of the edges (the topology) still heavily favors the winger in a way that randomness cannot explain." It isolates structure from volume.

---

> "One might argue that an empirical baseline consisting of filtered positional data (e.g., assessing a winger against the historical distribution of all wingers) is sufficient. However, empirical filtering suffers from the curse of dimensionality when controlling for compounding tactical variables (formation, possession, spacing) and fails to isolate network topology from event volume. By contrast, a generative null model allows for the construction of a true match-specific counterfactual—evaluating whether a player's network properties represent a structural anomaly given the exact, idiosyncratic spatial constraints of that specific 90-minute system."

---

> I need to read more papers to be sure of this, but from what I have read so far there are many statements like "barcelonda exhibit higher clustering than the league average". statements like this are 


---


Moving Beyond SNA: Spatially Embedded NetworksTo build an actual Network Science project for football, you have to treat it as a spatially embedded network (Buldú et al., 2018). In these systems, nodes have physical coordinates $(x,y)$, and the probability of an edge existing is heavily influenced by the Euclidean distance between those coordinates.When you factor in pitch coordinates, you realize that a team's passing network is governed by two competing forces:
1. Tactical Intent: The intentional strategy of the coach (e.g., building up through the wings).
2. Spatial Constraints: The physical reality that shorter passes are easier to complete than longer ones.

Without a null model, you cannot separate tactical intent from spatial constraint. For example, if the two central defenders pass to each other 30 times a match, is that a brilliant tactical "tiki-tika" strategy, or is it just the baseline result of two people standing 15 meters apart with no pressure?


Buldú, J. M., Busquets, J., Martínez, J. H., Herrera-Diestra, J. L., Echegoyen, I., Galeano, J., & Luque, J. (2018). Using Network Science to Analyse Football Passing Networks: Dynamics, Space, Time, and the Multilayer Nature of the Game. Frontiers in Psychology, 9, 1900. https://doi.org/10.3389/fpsyg.2018.01900
Cited by: 134

---

# Network Science vs SNA
The mathematical properties and algorithms (degree centrality, clustering coefficients, community detection) are identical, but the history, philosophy, and scope are completely different.

Social Network Analysis (SNA) is the parent disapline. Network Science is the modern, expanded evolution of that discipline.

SNA; 
- Emerged in the 1930s–1970s out of sociology, anthropology, and psychology.
- Strictly human or organizational. Focuses on friendships, corporate boards, advice networks, or political alliances.
- Historically small to medium (dozens or hundreds of nodes). Data was collected via tedious surveys or interviews.
- Theory-driven & Bottom-up: Starts with a sociological theory (e.g., "Do people with weak ties get better jobs?") and uses the network to test it.

Network Science;
- Exploded in the late 1990s out of statistical physics, computer science, and math.
- Any complex system. Includes brains (neural networks), power grids, protein interactions, and the internet.
- Massive / Big Data (thousands to billions of nodes). Data is scraped computationally.
- Data-driven & Top-down: Looks at a massive web of data, extracts the math, and looks for universal laws (e.g., scale-free networks).

When you read a domain-specific paper using SNA, and it computes betweenness centrality or density, it feels exactly like your Network Science class because Network Science absorbed the toolkit of SNA and blended it with graph theory.

However, 

In Network Science: A hub with massive degree centrality in a power grid is a structural vulnerability—if it fails, the grid blacks out.

In SNA: A hub with massive degree centrality in an office is an influential person—if they leave, organizational memory is lost.

If a paper uses the term SNA, the authors are signaling that they care deeply about the social context and human behavior. They aren't just treating people as abstract nodes; they are tying the network structure back to human agency, power dynamics, or social capital.

When researchers approach football solely through a Social Network Analysis (SNA) lens, they treat the team like an office workflow or a group of friends. They calculate classic metrics like degree centrality or density to find the "influential" player (Alves, 2025). But they miss a massive structural reality: football is a spatially constrained, dynamic physics problem disguised as a social network.

In classic SNA, if you want to know if a network structure is meaningful, you compare it to an Erdős–Rényi random graph ($G(n,p)$) or use a configuration model that shuffles edges while keeping node degrees constant.

If you randomly shuffle the passing edges of a football team using a standard configuration model, you might create a network where the left-back frequently passes directly to the right-winger over a distance of 70 meters. In reality, that pass is incredibly difficult and rarely attempted due to the physical limits of human kicking accuracy and intercepting defenders. Because standard social network null models don't account for pitch geography, sports science researchers often skip them entirely and stick to purely descriptive metrics (e.g., "The central midfielder made 40 passes").

To build an actual Network Science project for football, you have to treat it as a spatially embedded network (Buldú et al., 2018). In these systems, nodes have physical coordinates $(x,y)$, and the probability of an edge existing is heavily influenced by the Euclidean distance between those coordinates.

