#  5.2 Iterative MVP Development:

My current iteration of though comes to this:

---
## Re-Wiring
A **generative re-wiring**. Preseves the nodes, structure and spatial attributes but re-wires passes on a learned generative process which is built from distance only. This could be a single probabilty distribution or an advanced generative process. 

I am not actually sure this works. It is a direct failrure of the standard null models. Recall that the network is weighted and directed. That weight is accumulated from many passed from A to B. Redirecting that entire edge is a flaw process. 

We could think about re-wiring the individual passes. We could take every pass that occured from node A and use a generative process to determine where the pass could do. The issue here is that the locations of the pass begining and end point is not the same at the nodes in the network. The nodes are an average. Therefore, the rewiring process becomes high convoluate. A rewired pass gets potentially a new end location and new receive, or the end location stays fixed and the receiver is regenerated. 

That being said, whilst this feels complicated is probably is a good approach for null modelling. This is because the rewiring process, whether it be player or location+player, will be drawn to the average. If we have a team, or player, who is performing above average, or in an unsual way, the re-wiring iterations will "loose" that particular tend, or alteast for most null iterations, therefore we will be able to say if something is unique/interest

The issue here is whether to rewired recipient or just pass and recipeient. 

Recipient only is the most analagous to a re-wire but it contradicts all spatial considersations we have previously been thinking about, in fact, we may even cover it in the examples of why re-wiring doesn't work. 

If we "rewire" passes and recipient then we aren't really re-wiring, this is full generative process that preserves degrees (out-degrees) and formations

In fact, I think we have just stumbled into the narative as to how we logically end up with a generative appraoch which is explained below:

---

## Full Generative Process on Passes
A **full generative process** which is learnt a seasons worth of passing data. The null models involve generating a match of passing data and constructing a network. This isn't an easy process. Producing the passes themselves might actually be quite easy, but there is the added complexity of the paradigm. We need to model players, or locations, depending on the paradigm. It is likely that we need to start with a formation. Given a 4-3-3 and a teams total degrees (passes) to preserve, we take the positions and generate likely pass totals for each player. The next stage of the pipeline is then to iterative through each player and generate their passes. The model will generate a start location, end location and player passed to.

Important design decisions need to be made here. The player passed to need to be contextualised to the current team, formation and positions. It is easy to generate a start and end location of a pass. The player passed to need to be a valid position based on the formation. this could either be integrated into the model, or a player could be assigned afterwards drawing from a another prob dist, i.e. based on the 10 players and the end (and possibly the start location), who is the most likely recipient. 

Note, that we only model the out-degree passes. This is intentional. We want the process to produce **in-degrees** that represent the league. Over many iterations, robust null model will produce the "average" results. This should be, on average, the centreal players who we expect to be hubs will be modelled as such. But the generative processes will inject variance as to what is possible, giving us a range of baselines results to compare any findings to. Additionally, this give us a dependant variable to test our Null Modelling appraoch against. We can train the generative proccess on a training set from the season and test it on a validation test. We want to produce a depth of realistic null models that the validation set sits within. 

If our eval metrics are:
- Clustering
- Average Path Length
- Centrality

We require an approach in-degree generative process to keep these metrics realistic

---

## Generative Process on Complete Networks
Note, there is one more option and that is a full generative approach on a network itself. We take the topology (formation) and degrees. And based on this, generate a weighted, directed network based on these parameters, trained on the full seasons data. 

This works in the exact same way. It should still be spatially constrained as the networks that the process is trained on are themselves inherently spatially constraints. 

Futhermore, it is likely a much easier model to produce, there is less data considerations. 

The problem may arise due to sparsity. In the full generative process, we are modelling the spatial aspect of passes. We have access to a full seasons work of data which is thousands of passes for locations all over the pitch. 

If we are modelling on networks, the input space is restricted to the number of games * 2. 

This wildly restricts the training space which risks the chance of overfitting. 

Overfitting is a massive problem here because the model may encode uniqiue/unlikely networks as normal. Therefore, when we go to conduct our analysis and compare things to the baseline. The model may produce may Null Models which themselves exhibit interesting/unique properties and therefore fail as a Null Baseline

---

Ultiimately, whether we choose to model and test both of these appraoches depends how are we doing on time and word count. 

If we are short on time, then the appraoch will be to explain this derivation and why we skipped over a network generative appraoch in faviour of a unerlying pass modelling appraoch. 

---

    ┌──────────────────────────────────────────────┐
    │          Standard Network Rewiring           │
    │  (Edge-level swap: Direct Failure)           │
    └──────────────────────┬───────────────────────┘
                           │
                           ▼
    ┌──────────────────────────────────────────────┐
    │    YOUR IDEA 1: Pass-Level Rewiring          │
    |  (Rewire individual pass vectors, not edges) │  <-- MVP 1 (Distance-Weighted)
    └──────────────────────┬───────────────────────┘
                           │
                           ▼
    ┌──────────────────────────────────────────────┐
    │   YOUR IDEA 2: Direct Network Generation     │
    │  (Generate 11x11 Matrix directly)            │  <-- MVP 2 
    |   (Formation-Conditioned)                    |
    │  *Risk: Data Sparsity (N_matches * 2)        │
    └──────────────────────┬───────────────────────┘
                           │
                           ▼
    ┌──────────────────────────────────────────────┐
    │   YOUR IDEA 3: Event-Level Pass Engine       │
    │  (Generates Pass Vectors -> Aggregates)      │  <-- MVP 3 
    |   (Generative Season-Trained)                |
    │  *Solves Sparsity using 100,000s of events   │
    └──────────────────────────────────────────────┘

---

- MVP 1: Distance-Weighted Spatial Null (gravity/exponential decay based on player positions).
- MVP 2: Formation-Conditioned / Contextual Null (incorporating team structural topology).
- MVP 3: Generative Season-Trained Null (learning multi-dimensional league distributions to prevent data sparsity/overfitting).

---

## Option 1: Generative Pass-Level Rewiring (MVP 1, "Distance-Weighted")
Edge-level rewiring (entire weighted link $w_{ij}$) fails because it treats a multi-pass connection as an atomic block

Rewiring individual passes is better, but node locations are averages $(\bar{x}, \bar{y})$, while pass start/end locations vary.

Rewiring individual pass events by sampling a recipient based on distance decay functions ($e^{-\lambda d}$) is mathematically sound and forms the perfect baseline (MVP 1: Distance-Weighted Spatial Null)

If you only rewire the recipient, the pass geometry is ignores. If you change both both the pass end-location and the recipient, the process moves from rewiring to event-level generation.

You could potentially just rewire recipients. If a team has a unique tactic appraoch and set of players, they may produce unsual networks and passing patterns. A generative, recipient rewire will force these connection take to the most expected and therefore highlight interesting findings. 

This is a pretty niche application. It would uncover tactical appraoches where players have rotational roles and find themselves receiving the ball in locations more commonly suited to players denominated in other roles. 

I had previously discard this approach but now I think it is actually quite interesting given the prevelance of rotational roles, i.e. inverted wing backs. 

I also think it is an appraoch which is destined to fail in some way. I either expect it to re-wire into networks which break evaluation. Or on a more technical aspect, fail the modelling process. I may be too difficult to learn a viable re-wiring process that doesn't overfit to the training data. 

A failure is a good thing and gives us interesting content to write about. 

---

## Option 2: Direct Matrix Generation (MVP 2, "")
Train a model to output an $11 \times 11$ directed, weighted adjacency matrix directly, conditioned on formation and total pass count.

Training on match matrices severely restricts the training dataset size ($N_{\text{matches}} \times 2$), leading to overfitting where unique tactical quirks are falsely learned as "normal baseline behavior."

This is the exact statistical hurdle Gama et al. (2026) faced. A single season of a 12-team league yields only 132 matches (264 matrices). A model trained on 264 matrices will overfit and generate "nulls" that encode specific team biases rather than true baseline randomness.

> In their case study evaluating the Portuguese National Team, Gama et al. calculated compelling variations in stochastic flow properties between matches. But their dataset was only 2 matches, n=2. Standard resampling methods—such as bootstrap confidence intervals or matrix permutation tests—require a sufficient sample space to build stable uncertainty estimates. With $n=2$, permuting or bootstrapping match-level metrics yields no statistical power. The authors explicitly acknowledged that without a larger baseline, it was impossible to prove whether the observed variations between the two matches represented genuine tactical adaptations by the coach or simply standard stochastic noise inherent to football passing sequences.

> The solution is to get more data but as you add more data you create more sparisty. To evaluate if a teams passing network is unqiue, you cannot benchmark a 4-3-3 possession team against a 5-4-1 deep counter-attacking block. You need to compare to simialr baselines. If you filter these datasets to highly specific constraints the sample size collapses again. 

> Relying on a tiny subset of real-world matches causes the baseline to overfit to the unique, random quirks of those few specific games rather than capturing a true "normal" range.

> Gama et al. left the field with an unresolved paradox: Resampling requires high data volume, but filtering empirical data for tactical context destroys data volume.

---

## Full Event-Level Generative Engine (MVP 3)

Train a generative model on a full season of raw event-level pass data (hundreds of thousands of passes). The engine generates pass origin $(x_1, y_1)$, pass destination $(x_2, y_2)$, and infers the recipient based on player formation/positional geometry.

This solves data sparsity, instead of training on 264 matrices, the model trains on ~150,000 individual pass events.

Preserves Out-Degrees, Models In-Degrees: By fixing the starting passer and total pass volume, you force the model to emergently generate the in-degree distribution (who becomes the hub/playmaker).

As noted earlier, generating raw pass events allows you to project the synthetic data onto Tier 1 (Player), Tier 2 (Hybrid), or Tier 3 (Pitch) paradigms with zero preprocessing conflict.

---

### Summary
Step 1: The Rewiring Dead-End. Explain why edge-level rewiring fails (destroys spatial geometry) and why pass-level rewiring devolves into full event generation.Step 2: The Direct Network Generation Trap. Explain why training a model directly on $11 \times 11$ matrices suffers from severe data sparsity ($N = 264$) and statistical overfitting.Step 3: The Event-Level Solution. Introduce your final generative architecture: training on $150,000+$ raw pass events, generating spatial pass vectors, assigning receivers via positional proximity, and aggregating the result into a context-aware null matrix.

---

## How to Generate the Recipient
The model generates a pass end-location $(x_2, y_2)$

The recipeient is  calculating a softmax probability over all 10 teammates based on their average pitch positions $(\bar{x}_k, \bar{y}_k)$ and a distance decay parameter

$$P(\text{Receiver} = k) = \frac{e^{-\lambda \Vert{}\vec{x}_{\text{end}} - \vec{x}_k\Vert{}}}{\sum_{m \neq \text{passer}} e^{-\lambda \Vert{}\vec{x}_{\text{end}} - \vec{x}_m\Vert{}}}$$

> Note, this is not refined enough. The model trained is team agnostic. Each team as 11 players but each team has difference players. Therefore, the model, or a model, seens to learn assignment abilities using the pass coordinates and the average location of the 10 other players. 

> In fact I am still not sure how this would work. If the model outputs the 10 logit probability distribution, how do we link this back to 10 players on the team? For every iteration, the 10 players will have a unique average location, which is essentially their ID also. How does the softmax link back to this? are the 10 player coordinates inputs for the model?

### Option 1: Naive appraoch (Distance Decay)

In the null iteration you have to start by generating 11 players, with spatial average coordinates based on their assigned formation and therefore position. 

For each generateed pass, you ahve an end location. The player is drawn from a prob distrubtion which is weighted by their euclidean distance from the pass end. Players average location to the ball are most likely but any can be drawn. 

Pure spatial appraoch

### Option 2: Learned Appraoch 
Machine learning model to assign receiver. 

Inputs = pass

but also player attributes

Likely appraoch:
- A vector of vectors
- Each vector the 10 possible recipients
- [distance from ball, role]
- output is logit for 10 players

still not reallty sure how to train this

> The modelled process fell incredibly. involved and that in terms of complexity, might take over the project. I quite like the idea of using a pure spatial approach. At some point in the generative process we need to generate 11 nodes and their average locations and assign positions. Therefore, after we have generated passes, we can us the pass end location and the players average location to compute euclidean distance and compute these distances into a probability distribution. We draw from this distribution whereby closer players are more likely to be assigned. For example, a pass ending in the middle of the pitch is more like to be assigned to a central midfield but is could be assign to any player. Conversely, due to the central midfields average position, they are high(er) but the probably distribution for most passes and therefore over the course of the match will be assigned more. 

> Avoids complex neural trianing

> project scope realistic, clean, and fully reproducible

> avoiding architectural creep

> Isotropic Distance Decay Function

> Do not need to train a model to know who central players are. Their central placement in the env a nd the patial distribution naturally forces the distance decay function to assign them a higher baseline probability across 500+ passes in a match.

> this is emergant behaviour. They naturally emerge as the network hubs (high in-degree and high centrality) purely as a mathematical byproduct of pitch geometry.

> Note, drawing from a continuous probability distribution rather than using a deterministic "nearest neighbor" rule. This injects realistic match variance

> A pass landing near the penalty spot is most likely assigned to the striker, but it could occasionally be drawn by a late-running midfielder.

> Isolates the generative proccess to the passes only where the pass data is vast

- Generated pass end-location: $\vec{x}_{\text{end}} = (x_2, y_2)$
- Set of 10 candidate teammate average positions for match $m$: $\{\vec{p}_1, \vec{p}_2, \dots, \vec{p}_{10}\}$
- Euclidean distance: $d_k = \Vert{}\vec{x}_{\text{end}} - \vec{p}_k\Vert{}_2$

The conditional probability $P(\text{Receiver} = k \mid \vec{x}_{\text{end}})$ is defined as:$$P(\text{Receiver} = k) = \frac{\exp(-\lambda \cdot d_k)}{\sum_{m \neq \text{passer}} \exp(-\lambda \cdot d_m)}$$

- $\lambda$ is a single hyperparameter representing spatial decay friction (calibrated easily from season-wide data by fitting real pass end-locations to real receiver distances).
- A higher $\lambda$ forces passes to almost always land on the closest player; a lower $\lambda$ increases spatial randomness.

> "To maintain a parsimonious experimental architecture and avoid statistical overfitting, receiver assignment was formulated as a non-parametric spatial decay process rather than a multi-class neural classification head. By conditioning receiver probabilities on the Euclidean distance $d_k$ between the generated pass end-location $(x_2, y_2)$ and the static node embeddings $(\bar{x}_k, \bar{y}_k)$ of the 10 teammates, receiver assignment emerges as a direct function of pitch geometry. This guarantees that spatial proximity dictates pass targeting while preserving team-agnostic transferability, preventing complex model parameters from obscuring the underlying topological baseline."

Calibrating $\lambda$: We can outline a quick 5-line Python script using your StatsBomb dataset to find the optimal $\lambda$ value for the WSL season.

---


Structuring Section 5.2 (Iterative MVP Development): We can write out the text explaining how you progress from naive shuffles $\to$ pass-level rewiring $\to$ this spatial distance-decay pass engine.

1. Pass Re-Wire, Recipient Player Only: This takes the fully established topology and re-wired the in-degree, receiving player only. This produces Null Baseslines which model the expected behaviour of players based on their assigned position. Players like Harry Kane who are strikers but drop deep to receive passes will show up when compare to Baseslines as unique as they break the expected in-degree patterns. Similarly, free flowing positional players like inverted full-backs will show up. 

2. Pass Re-Wire, Recipient Player + Pass End Location. This takes the fully established topology and re-wires the in-degree of the receiving player but it allows for variance in the passing players passing "ability". Elite passers like Trent will execute passing from a Right-Back position that most will not. Therefore, a Null Baseline will genreally produce passes equivelant to the average right-back, highlight Trent as unique. Note, this approach also obtain the same leverage as 1. meaning the behaviour of the receiving player will also have an influence. This isn't ideal and we would prefer to isolate the variables. We could model the recipiet probably distribution for each team/match and therefore the baseline would keep the in-degree behaviour fixed. However, the plan was to build the probabiltiy distributions on a season/league level, utilising all the data. It is undecided wether we will keep it this way for parsimonious or build a probably distribution for each team. Probably the form and explcititly explain this as a limitation. 

3. Pass Regeneration. Recipient Player, Pass Start and End Location. Still starting with and presevering the topology and degrees but regenerating the entire set of passes. Each player will have their position defined and number of degree (pass), though we can add some variance into the degrees. An iterative process will loop through N pass and generate a start location, from which an end location will be generated. This is vastly more complex than the previous method but fortunate we have a lot of data so the distributions should be robust. Finally, there will need to be a player allocated to the passed. We should be able to port over the allocation model from the previous 1 and 2. 

4. Network Regeneration. The closest to a tranditonal approach. We are working with the network directly and re-wiring the edges through a modelled, generative appraoch. If we have time, a 2-step approach might be good heere. THe first appraoch would be to re-generate a players out-degree edges. THe probably with this is that the learning data is much lower and furthermore the variance in results so much more impactful. THe generative process might overfit and just reproduce the same networks due to data sparsity. Conversely, a suprious generation, i.e. a heavily passing midfield converting 200 passes orginally to its central partner to a goalkeeper represents the exact issue we were trying to avoid. A more approriate appraoch might be a distributed appraoch where we genreate the out-edges in batches, i.e. 25, 50, 75, 100 at a time and build up the edges. 