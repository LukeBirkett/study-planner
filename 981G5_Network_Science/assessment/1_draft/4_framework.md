# 4. Analytical Framework: Null Models in Football
This is the core "Experimental Phase" of the Master's project. Separating it into its own major section.

---

## 4.1 The Necessity of Null Models in Spatial Games
*[Introduce Null Models], [Define Null Model Value to Football Analysis], [Explain Why Null Models are Needed vs Simple League Averages]*

Establishing why baseline randomizations are required to distinguish deliberate tactical choreography from random spatial proximity.

---

Introduce what null models are from a network science theoretical perspective. base

---

### Define Null Model Value to Football Analysis
Then move onto why they would be valuable for football:

The reason we build null models is to answer whether the topplogical structure we are observing (e.g., high centrality, specific clustering, a winger acting as a hub) a deliverating meaningful featuere, or just a random byproduct of the tasks constraints. 

used to measure tacitcal intent

calculate the clustering coefficient, highly structured team that you are looking at may have a high clustering of $0.6$, If the randomized stub networks have an average clsutering of $0.2$ then we can prove that the passing triangles in the team are the result of cumulative passes, as we kept the same number of passes in the null model, they are a deliverate structural feature of the managers tactics.

---

### Explain Why Null Models are Needed vs Simple League Averages
Explain why simply comparing to league averages as a baseline is not good enough. i.e. barca have more clustering that over teams. they also have more passes. need to normalize against contraints to draw a conclusion like this

In the (contemporary, alves) research, there is no null model applications. TODO: need to validate this though prompt research. 

However, most, if not all, papers use emprical baseslines. For example researches may say team X (barca, monaco, benefica) demostate better Y propertie that the league average. 

This only tells you have something is different but it cannot tell you why it is unusual. 

Generating null models goes beyond the raw data because it allows you to separate systemic constraints (geometry, rules, and mathematics) from deliberate human strategy.

By comparing to the league, we are simplying comparing against things that may be just be different. Barcelona have more passess than most team so will have more clustering than the rest of the league. But what happen if we normalize for the number of passes and then the topologyical structure of the team. Are we able to see teams that perform with higher clustering depsite seemingly being the same? this allows us to look intro talent and/or tactics. 

In analysis we might identify a left-winger for a particular team/game who has a massive betweenness centrality score compared to the league average for all players. **The Empirical League Baseline tells you:** "This winger is a significantly bigger hub than 95% of players in the league."

However, if this team uses a 4-3-3 formation where as the majority, if not all, uses 4-4-2 then it is the underlying position contraints that may be producing this different. 

We need a position permited null model so that we can "Freeze" an exact match's structural profile. By generating new networks based on this we are essentially swapping in new players into the nodes position. If every (or most) player automically yeilds as similar property then we know it is the formation/structure rather a unique player performance. Alternative, by isolating these factors, we struggle to re-produce the property, then it is the player. 

A good way to decompose this thinking is to consider computing each players (nodes) centrality. On average, centrial midfields will dominate this category. If we were to take a midfielder and compare it to the league avergae, each one will come out in very high percentiles. However, central midfields have a 360 passing range, where as left-wingers and more like a 180 and they are constrained by the 2d plane of the pitch. We are trying to compare two things which are spatially and topolgically different. 

The suggest high be filer down to comparing players by position, and whilst this would be more valid, the issue persists that different players have differing topological constraints around which will determine their properties. Simple league based baselines do not allow us to isolate the variabiltiy produced by talent and performance vs structure. 

We need to a Spatially-Constrained Null Model to say things like: "Based on pure geometry, a player standing in this exact wide coordinate should only receive 4% of the team's passes," and your raw data shows they received 22%, your null model has exposed a massive tactical anomaly that a league average would completely smooth over and hide." 

"While empirical league baselines identify relative variance between subjects (e.g., how Barcelona differs from Getafe), they fail to isolate the underlying mechanism causing that variance. Conversely, a mathematically defined null model provides an ab initio baseline that controls for spatial, geometric, and rule-based constraints. This allows us to separate statistical artifacts born of pitch geometry or formation structure from genuine, intentional tactical anomalies."

Raw data filtering cannot: handle multi-dimensional confounding, create counterfactuals for unique contexts, and isolate structure from volume.

Furthermore, empircal data suffers from the curse of dimensionality. Lets say we want to analysis an individual match to some empirical baseline which reflects similar circumstances, i.e. by filtering to similar factors. Note, in this hypothetical we are not comparing to the league average as we recognise that it contains different underlying properties, i.e. formations, systems etc. As we filter down on the appropriate conditions we are removing data and resulting may end up with a dataset of only 3/4 matches. 

A generative null model solves this by learning and abstracting the rules of the system rathern than performing a hard filtering matching on given scenarios. 

It learns the underlying mathematical relationship between physical distance, player involvement, and pass probability across the whole season. It can then instantly generate a custom, statistically sound baseline for any combination of variables, even if that specific combination of possession, formation, and spacing has never happened before.

The biggest benefit of using Null Models is due to volumne. Working directly with network properties on empirical data we will find that all metrics like Betweeness Centrality are non-linear. They don't just measure how many times a player received the ball (In-Degree) because it entirely dependant on other players making the pass. If a team makes 900 passes per match, all centrality metric will be scaled up and behave different to a match will 300 passes. Comparing the two mere tells you that the matches were different, not anything about the centrality property itself. If you use a Null Model, you condition the simulation on the exact degree sequence or edge-count (or whatevr appraoch) of that specific match.

The null model allows you to say: "Even when we artificially scale the network to have exactly 412 passes (the exact volume of this match), the arrangement of the edges (the topology) still heavily favors the winger in a way that randomness cannot explain." It isolates structure from volume.

---

## 4.2 Limitations of Classical Network Topologies
*[Explain Why Traditional Null Models not Suitable]*

---

### Explain Why Traditional Null Models not Suitable
Explain why trad/random null models are not suitable for application to football; straw man; tactical vs spatial/constrains

The reason we build null models is to answer whether the However, there is also a "Dynamics and Probe" aspect. This is becuase the real challenge here is building an effective null model. A standard degree-preserviing configuation model won't work because the nuance of individual players and there positions means the reconstruction needs to to cater to these as constraints.

> probably a good idea to run these null models to demonstate why they don't work. the output should be complete unintelliglbe, i.e. congfig re-weighting results in freq striker to goalkeeper passes as if they were next to each toher

In these systems, nodes have physical coordinates $(x,y)$, and the probability of an edge existing is heavily influenced by the Euclidean distance between those coordinates.When you factor in pitch coordinates, you realize that a team's passing network is governed by two competing forces:
1. Tactical Intent: The intentional strategy of the coach (e.g., building up through the wings).
2. Spatial Constraints: The physical reality that shorter passes are easier to complete than longer ones.

Without a null model, you cannot separate tactical intent from spatial constraint. For example, if the two central defenders pass to each other 30 times a match, is that a brilliant tactical "tiki-tika" strategy, or is it just the baseline result of two people standing 15 meters apart with no pressure?

---

`4.2.1 Erdős–Rényi Baselines`, `4.2.2 Standard Configuration Modeling` (Discussing the issue of self-loops and directed mass-preservation in a closed 11-node space).

---

#### Erdős–Rényi (Random) Null Model: 
Take an **Erdős–Rényi (Random) Null Model** and treat it as the zero intelligence baseline. Construct networks with the same number of nodes and edges using a fixed prob. the totals stay the same the connections are randomized. 
- E.g. you take 11 nodes and the exact number of passes made in a match, or period. Rewire 400 passes completely randomly. This establishes a "baseline" team that has with zero tactical intelligence.
- Compare the Average Path Length/Clustering Coefficient ($C$) of the real network to the random/null ($C_{rand}$). If $C \gg C_{rand}$ then this statistically prove the team's triangles and properties are the result of deliberate tactical choices.
- will find nonse results that don't follow the expect patters of football

---

#### Configuration Modelling: 
Complex in directed + weighted setting. Half-edge approach. Two types of stub connectors. in-stub, out-stub. Plays have their pre-detmined statistics, 60 passes made = 60 outstubs, 10 recieved means 10 in-stubs. To build the config model you work on building out the stored weight. 
- can use a **configuration model** for preserving the exact degree sequence (the number of connections each specific node has) but randomize who they connect to through a rewiring process. (build upon ER)
- will still find nonesnese results but with some identifable features, i.e. central midfielder hubs
- config models are meant to be goldstandard for sports models
- but we need to consider the params and constructiono of a PassMap. Postions are not an arbitary perspective, they dictate the patterns and reoccuring behaviour. relationships between given players. the triangles we see. 
- Can use configs to confirm that empircal shortest lengths are tactically engingeer as the random networks will retain their hubs but loose the APL, or even small wordledness. 
- However, the the abiltiy to use this real analysis will be too limited. Yes we can confirm these network science properties but not much we can do with the domain. 
- The empirical data shows that elite teams exhibit Small-World properties and the nulls prove its existence isn't natural/force by the contraints and topological.
- That being said, these very basic baselines so have a value if they are able to recreate something. i.e. true random networks treat something we thought was a property. 

---

## 4.3 Proposed Null Model Architecture & Validation
*[Approaches for Null Models in Football], [Null Model Validation]*

The algorithmic design of your chosen null model (e.g., Directed Weighted Configuration or Weight-Shuffling) and how you validated the permutation distribution.

---

### Approaches for Null Models in Football
Walk through the various approaches and options for null models in football. What needs to be considered. We need to keep in mind that PassMap networks are directed and weighted. As well as this, we need to preserve and recreate some properties of the network that are specific and constrained to the game of football

The goal to preserve topology but also *some* totals, i.e. total passes, but randomize the inbetween steps. Could in some intstances, frame this as collecting total weight and redistributing. 

In football not all connection are made equal. A connection is a valid interacitons but the weight between two nodes is more improtant. Over the course of a game, or seaesons, there may well be a connection between every player/node. However, the merely truth of connection provides little information. It is the volume, the strength, of conneciton(s) which provides network and tractical insight. 

The most intuative way to of maintaining these relaitionship is through some understand and acknowledgment of "proximity. Football is played on a 2d-plan, the pitch is a rectange and players traverse this field (the ball has a 3rd dimension but that is not important here). Players that are physically positioned closer together, will by nature interact for frequently. A null model where the probability of a randomly generated, or rewrired, edge is a function of their distances on the pitch would allow for this constraint to be recognised in the null model. What we want to avoid is a null model where unlikely pairs of players are generated to be key passing partners, i.e a goalkeeper and a right-winger making by 20% of a teams passes with 80 yard cross field passes. By retaining these realistic footballing traits in the null, we allow our self a legitimating base like to infer statistically signifcant network properties - avoiding the null straw man arguement. 

#### Gravity Model
Borrowed from human geography and transportation economics. 

> TODO: need a good introduction and explaination of the base model that is being borrowed from. Examples and references. but keep it consice

The interaction metric (passes) between two players proportional to their overall involvement (mass) and inversely proportional to the distance between them.

The expected weight $w_{ij}$ of a directed pass from player $i$ to player $j$ is modeled as:

$$w_{ij} = k \cdot \frac{(s_i^{out})^\alpha \cdot (s_j^{in})^\beta}{f(d_{ij})}$$

- $s_i^{out}$: The total out-strength (total passes made) of player $i$.
- $s_j^{in}$: The total in-strength (total passes received) of player $j$.
- $d_{ij}$: The Euclidean distance between the average spatial centroids $(\bar{x}_i, \bar{y}_i)$ and $(\bar{x}_j, \bar{y}_j)$ of the two players over the match.
- $f(d_{ij})$: A distance-decay function, typically exponential $e^{\gamma d_{ij}}$ or power-law $d_{ij}^\gamma$.
- $k, \alpha, \beta, \gamma$: Parameters fit to your entire season's dataset via Maximum Likelihood Estimation (MLE).

To use it you would fit the parameters of a given formation and then you can $k, \alpha, \beta, \gamma$: Parameters fit to your entire season's dataset via Maximum Likelihood Estimation (MLE).

> Note, here it is scoping in the fact that the key to generating relevant datasets in the MLE of the underlying data. Which need to be encapusaled into learned parameters from which new data, and therefore networks, can be correctly generated from. 

$k, \alpha, \beta, \gamma$: Parameters fit to your entire season's dataset via Maximum Likelihood Estimation (MLE).

$$P(i \to j) = \frac{\hat{w}_{ij}}{\sum_{m,n} \hat{w}_{mn}}$$

> Basically, I think the perspective is that there is almost a "training" phase (MLE). Using a cohort of data you build up these probabiltiy distribtuions based that can be sampled on. You look at game and optain a sent of parameters which represents the formatuions (or average position). You then sample the distributions using these parameters, i.e. if I have player X whose average postion of Y, sample the prob dist of passing to player Z who has their own average position. The season data givw you an empirial distribution to sample from. Therefore, if a player have 25 passes in a match, you run a model that randomly assigns passes. Based on the position based impirtical dataset, it will build up a pass map that is reflective of the average. We can then use this to compare to the empirical data. Are they different and by how much. If we same 1000 times, do we get any that look like the empirical and what is the % of acheiving something similar. Similar might need a metric and need to be thresholding to determine similar. Most basic would be to look for hubs, what % of match are these positioned players becoming hubs. 

--- 

#### Exponential Random Graph Models (ERGMs) with Spatial Controls
ERGMs are generative, statistical models for networks. They allow you to specify macro-level structural features (like reciprocity or triangle closure) and spatial covariates, calculating the probability of seeing your exact match network.

$$P(Y = y) = \frac{1}{\kappa} \exp \left( \sum_{k} \theta_k g_k(y) + \theta_{space} \sum_{i,j} y_{ij}d_{ij} \right)$$
- $g_k(y)$: Network statistics you want to control for (e.g., total number of edges, number of reciprocal edges).
- $d_{ij}$: The spatial distance between players.
- $\theta_k$: The coefficients (weights) assigned to those structural properties.
- $\kappa$: A normalizing constant (the partition function).

You estimate the parameters ($\theta$) using Markov Chain Monte Carlo (MCMC) over your baseline matches. Once estimated, you sample hundreds of synthetic networks from this probability distribution.

**Why it works for your project: It allows you to say: "Even when controlling for formation distance and the natural tendency for football players to pass back-and-forth (reciprocity), wide players act as hubs significantly more/less than expected."**

---

#### The Spatial Configuration Model (Maximum Entropy Approach)
Soft Configuration Model adjusted for spatial constraints via Maximum Entropy. Standard configuration models break links into "stubs" and re-wire them randomly. To force space into this, you apply an optimization constraint. You want to maximize the Shannon Entropy of the graph ensemble:

$$S = -\sum_{G} P(G) \ln P(G)$$

Subject to two constraints:
1. The expected degree sequence matches the empirical network: $\langle k_i \rangle = k_i^{emp}$.
2. The expected degree sequence matches the empirical network: $\langle k_i \rangle = k_i^{emp}$.

Using Lagrange multipliers, this yields the probability of a directed link existing between $i$ and $j$:

$$p_{ij} = \frac{1}{e^{\lambda_i + \mu_j + \gamma d_{ij}} + 1}$$

You numerically solve for the hidden parameters ($\lambda_i, \mu_j, \gamma$) using the empirical degree sequence and distances. This gives you an analytical probability matrix $P$. You can directly compare your winger's empirical metrics to the theoretical distributions derived mathematically from this matrix, bypassing the need for heavy simulations.

---

> Approach 3 proves whether the player over-performed the tactical position, while Approach 1 proves whether the tactical position itself defies spatial logic.
> 
> Approach 2 was the methods expored uniquely in our lectures

---

### Null Model Validation
*"Model Validation and Calibration."*

> "To ensure the null ensemble does not serve as a 'straw man' proxy, it was validated against global topological properties. The null networks successfully reproduce the empirical team-level clustering coefficient ($p > 0.05$, KS-test) and physical pass-length distributions, confirming that any rejected null hypotheses at the node level (the wide hubs) represent genuine tactical outliers rather than systemic or geometric artifacts."

A good null model acts like a well-calibrated scientific control group. it needs to replicate the intrinsic, baseline physics of the system while stripping away the specific strategic anomaly you want to test.

The main purpose of valiation is the avoid generated networks where unlikely (or even impossible) passing pairs are created. This don't not give us any tangible baseline to compare to. 

#### Topological Distance Tests
Might be refered to as macro-scale validation. But I cant recall if that is inline with Alves definitions or just a logcial categorization. 

We need to ensure that the "Shape" of the simulated models matches the empirical data. 

However, I am not entirely clear if this is a requirement. The generated models will likely either start with an existing template from a re-wiring perpective, or be generated in accordance to the underlying data. Or maybe someting in between where empirical setups are augmented though jittering. 

Might be relevant if testing more than one generation methods. 

If exploring this route, the goal is to generated an ensenble of models N=1000. Then compare the distributions of network properties using distance metrics like Jensen-Shannon Divergence (JSD) or a simple two-sample Kolmogorov-Smirnov (KS) test.

- The total number of passes (edges) in your null graphs must exactly equal the real match. (If using a generative model like the Gravity Model, check if $\sum w_{ij}^{emp} = \sum \hat{w}_{ij}$).
- In football, passing triangles form naturally. Your null model should replicate the global clustering distribution of a season without over- or under-estimating it.

> this one feels intuatively really important. football is a game of triangles but these triangles are usually quite distinct and close range. cross field triangles would be alarming. though it not immedietly clear how to analyse clusting to figure this out. Maybe, there is someething around comparing A > B > C and checking max length, or direction.

- **Graphlet Frequency Distance (RGFD):** Check the micro-structure by counting small 3-node or 4-node subgraphs (motifs). A good spatial or formation null model should naturally reproduce local passing loops (e.g., full-back $\leftrightarrow$ central mid $\leftrightarrow$ winger) without explicitly being told to.

> Perhaps, the key to checking null models to is to contruct check that validate the norm of football. passing chanes on average progress the ball. if there is an over representation of chains that go back then this is an alarm. or if passing chains (2,3,4...) are hugely over represneted then the model isn't working. 
> 
> Someting that I hadnt considered before is tha the generative process is building the underlying data. The data distribution being samples could be something like P_1 > to which player where each player/pitch position (or both, i.e. pitch position sampled first, then position samples based on an inner distribtuion) has 

#### Straw Man Check
Whilst it is obvious that "naive" null model like a standard degree-preserving configuration model or an Erdős-Rényi random graph will not where, it is probably a good idea to generate them and compare them

This will give me a chance to demonstrate that I understrand null models and their limitations. 

I am not sure if this would be most impact full at the start of this validation section, or at the end and I think that I have appropriate null models working. 

Or even whilst generating the good null models, comparing and validating them at the same time. 

> Might be even good a good appraoch to do the null models first and use their failures to construct and guide the validation rules for the generative process

#### Distance-Decay Alignment (For Spatial Models)
If the proposed Null is a gravity model, then the spatial decay function need validating. 

Should be a little easier to validate and test against. In football, passing frequency between two nodes, drops over physical distance. 

Recall that this gravity model is adpayed from physics/geo. Things like magnets follow a cost function. 

Extract the length of every single pass in your empirical dataset and plot a probability density function (PDF) of pass lengths. Then, extract the pass lengths generated by your simulation.

The empirical pass-length curve and the simulated pass-length curve should closely overlap. If your simulated curve is shifted to the right, your distance penalty parameter ($\gamma$) is too weak, meaning your model is letting the ball fly across the pitch too easily.

> the later it being generated from the first so this should march, otherwise it means the function itself is broken. 

---

### Vague Validation Ideas
- **Pass Distance Distribution:** A null model would fail because it would produce things like 80 yard passes as the same rate as 5 year passes. 
- **Positional In-Degree Bias:** The null model would fail because it would distribute passes bildly to nodes. central midfields with disproportionately low degrees and wingers as regular hubs. 
- **Statistical Power:** We want to compare things to the null to infer statistal signficance. The null models would just be random noise, hence, any pattern founds in the empirical would flag up as statistically signficant. Where as with want a model which "selective rejects the null". The null tells us that a given finding would only occur in 1% of randomly generated models. But a seasons worth of data might show a particular player/team is acheiving it 50% of the time. 

--- 