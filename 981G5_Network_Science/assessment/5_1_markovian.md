# 5.1 Adapting Dynamics-ON Methods to Generative Topology:

Markovian processes naturally accommodate such probabilistic, time-evolving phenomena by modelling sequences of play as state transitions on a network [18]
- Norris JR. Markov chains. 2nd ed. Cambridge University Press, 1998.


## First Order

Gama et al. acknowledge their framework is a "parsimonious first-order approximation" where the next pass depends only on the current ball handler, omitting sequential memory.

In the generative process, this justifies and inspires the passing generation modelling. We take the number of passes, and potentially, the start location and generate the end location. This process is probablistic, forming a probably disribution from the history of passes and using only the current location as the generation parameter, precluding any sequenal emeory. 

But while football has higher-order memory, a first-order Markovian assumption is a mathematically valid, parsimonious baseline for evaluating standard 1st-order PassMap topologies.

Furthremore, a higher-order memory is critical for flow diffusion (Dynamics ON the network) is it pertains to ongoing dynamics. However, for generating static baseline topologies (Dynamics OF the network), a first-order spatial model is a mathematically sufficient and parsimonious baseline



Narizuka et al. (2014) offer the ultimate proof: a 1st-order memoryless Markov process is sufficient to reproduce the small-world topology, clustering coefficients, and degree distributions of real football matches.

Pure scale-free networks require preferential attachment ("the rich get richer" mechanisms). Truncated gamma distributions, as Narizuka et al. proved, can be synthesized purely by a 1st-order spatial Markov process with exponential distance decay ($e^{-\beta L_j}$). 

Justifies Why Simple Erdős–Rényi Null Models Fail: Simple random graphs capture short path lengths ($l$), but completely fail to generate the high clustering ($C$) and truncated degree cutoffs seen in football. Your spatial null engine bridges this exact gap. 


---

Markovian processes naturally accommodate such probabilistic, time-evolving phenomena by modelling sequences of play as state transitions on a network [18]
- Norris JR. Markov chains. 2nd ed. Cambridge University Press, 1998.

While SNA describes who is connected and identifies structural hubs, [1,2,4] and Markov models have been applied either to network growth over time [16] or to state transitions between field zones

By analysing the **transition probabilities of passes as a stochastic process**, we introduce a temporal dimension to the network analysis, enabling quantification of aspects like speed of ball circulation and distribution of possession that static metrics alone cannot capture.

The authors are using these methods specifically as a tool to model Dynamics On the Network but the underlying logical is identical to the methods to build, generate and grow networks. 

---

### Gama (2026, Stoch) Probabiliy Matrix, Adjency matrix

"For each match, a directed weighted adjacency matrix A was constructed, where each entry represents the number of passes from one player to another."

"From this adjacency matrix, a row-stochastic transition matrix P was derived on the active subgraph (players with at least one outgoing pass), where each entry represents the probability that a player passes to a specific teammate. When the empirical transition matrix was not irreducible, a teleportation correction (a = 0.15) was applied to ensure irreducibility of the Markov chain."

The authors are converting the raw passing "counts" into a probability transition matrix ($P$). The properties are being modified using the rows they sit in, i.e. using linear algebra. The operation to achieve this is called row-normalization and it creates a row-stochastic matrix. Every row in the matrix will sum up to exactly $1.0$ (or 100%). In obtaining the Transition Matrix ($P$), linear algebra takes each row and divides every entry in that row by the row's total sum. Mathematically, this is expressed as multiplying the inverse of a diagonal degree matrix ($D^{-1}$) by the adjacency matrix ($A$): - $P = D^{-1}A$.

---

## Linear Algebra Mechanics: Row-Stochastic Matrices ($P = D^{-1}A$) (Gama, 2026)

The mathematical conversion of raw passing count matrices ($A$) into row-stochastic transition matrices ($P$) via row-normalization ($P = D^{-1}A$).

This governs ball transitions on a graph. The weights are converted intro probabilties that can be drawn from when computing flowings and where the ball may go next

The exact mathematical transformation Gama et al. used to analyze Dynamics ON the Network (calculating flow across a fixed graph) can be flipped in reverse to drive Dynamics OF the Network (synthesizing new generative null graphs)

This is the mathematical foundation for showing how a passer's outgoing options are converted into normalized probability distributions.

> This might wrap full through the PassMap Paradigm. I wonder whether it is feasible or even possible to model passes on a continous basis. Maybe it needs to be discreteized and the pitich split into buckets. I actually think this is fine for my applicaiton. In fact, one way of acheiving this might be to pre-process the actual underlying pass data into into buckets. Technically, this way, the data stays the same and the player passmap can be implemented but the exact coodinates are pushed to the centroid of the bucket. When modelling passes this way, we have a start bucket and can build a probability distribution against all the possible outbuckets. The centroid does not matter for network purpose because the network is accumualted and averaged, the small difficerence will not make a change the outout network. 

---

## What is a First-Order Markovian Process?
A First-Order Markovian Process (or a memoryless stochastic process) is a sequence of events where the probability of transitioning to the next state depends strictly and exclusively on the current state, completely ignoring the path or history of how the system arrived at that current state.

In formal probability theory, for a sequence of random variables $X_1, X_2, X_3, \dots, X_t$

$$P(X_{t+1} = x \mid X_t = x_t, X_{t-1} = x_{t-1}, \dots, X_1 = x_1) = P(X_{t+1} = x \mid X_t = x_t)$$

**The 1st-Order Assumption:** Player $i$'s decision on where to pass depends only on where Player $i$ is located on the pitch (or Player $i$'s identity). It is completely blind to whether Player $i$ received the ball from the Center-Back or the Goalkeeper.

Gama et al. (2026), a standard $11 \times 11$ PassMap is an aggregated, 1st-order directed adjacency matrix ($A_{ij}$). Because the network itself washes away sequence memory, modeling null generation as a 1st-order Markov process is a mathematically parsimonious, rigorous, and sufficient baseline.

1st-Order Markov process ($P = D^{-1}A$).

---







---

## Evaluating MVP as 1st Order

### Approach A: Pass Recipient Rewiring
Keep the empirical pass origin $(x_1, y_1)$ and end-location $(x_2, y_2)$ fixed. Draw a new receiver $j$ from a probability distribution based on player average coordinates $(\bar{x}_k, \bar{y}_k)$

This is a direct spatial extension of a 1st-order transition matrix. 

$P(\text{Receiver} = k \mid \vec{x}_{\text{end}})$, where destination space is the state, and recipient choice depends only on that spatial state.

It preserves the team's empirical passing execution (lengths/angles) while randomizing who receives it based on spatial proximity.

The state is the spatial end-coordinate $\vec{x}_{\text{end}}$. The transition probability to Receiver $k$ depends strictly on the Euclidean distance $d_k = \Vert{}\vec{x}_{\text{end}} - \vec{p}_k\Vert{}$ to the 10 candidate teammate average positions:

$$P(\text{Receiver} = k \mid \vec{x}_{\text{end}}) = \frac{\exp(-\lambda \cdot d_k)}{\sum_{m \neq \text{passer}} \exp(-\lambda \cdot d_m)}$$

> Note, my original ideal for the recipient allocation was a spatial decay process. We have the end location and we have a set of players average positions. We could take their locations compute their distance and turn all of their distrances into probabilities. Each pass draws from this and assigns a recipient. Its good because passes in a given location will be heavily assigned to the player assigned to that location but not everytime. This modells the spatial appraoch. Also central players in the average position toplogy will be suitors in most passes, therefore accruing more passes. 

My orgininal idea is a First-Order Markovian process

"the probability of transitioning to the next state depends only on the current state, and is completely blind to prior history."

1. The Current State ($X_t$): The generated pass end-location $\vec{x}_{\text{end}} = (x_2, y_2)$
2. The Next State ($X_{t+1}$): The selected recipient player $k \in \{1, \dots, 10\}$.
3. The Transition Probability:

$$P(\text{Receiver} = k \mid \vec{x}_{\text{end}}) = \frac{\exp(-\lambda \cdot d_k)}{\sum_{m \neq \text{passer}} \exp(-\lambda \cdot d_m)}$$

where $d_k = \Vert{}\vec{x}_{\text{end}} - \vec{p}_k\Vert{}$ is the Euclidean distance from the pass end-location to Player $k$'s average spatial position $\vec{p}_k = (\bar{x}_k, \bar{y}_k)$

The probability of Player $k$ receiving the ball depends strictly and exclusively on the spatial end-location of the pass $\vec{x}_{\text{end}}$ and the current static node embeddings $\vec{p}_k$

It does not care:
- Who passed the ball originally.  
- Where the ball was 2 seconds ago.  
- What sequence of passes led to this location.  

This models emergent behaviour without complex rules. Central players emergently become network hub as a byproduct of spatial geometry.

Passes landing near the touchline will almost always be awarded to the local winger/fullback due to the exponential distance penalty ($e^{-\lambda d}$) on the far-side players, but central passes remain open to stochastic competition among the central block.

$$\begin{aligned} \text{Step 1 (Pass Vector Origin/Destination):} \quad & \vec{x}_{\text{start}}, \vec{x}_{\text{end}} \sim P(\text{Pass Geometry} \mid \text{Season/Formation}) \\ \text{Step 2 (1st-Order Receiver Allocation):} \quad & \text{Receiver } k \sim \text{Softmax}\left(-\lambda \Vert{}\vec{x}_{\text{end}} - \vec{p}_k\Vert{}\right) \end{aligned}$$

- Pass end-location: $\vec{x}_{\text{end}} = (x_2, y_2)$
- Passer identity: $i$
- Teammate average positions: $\{\vec{p}_1, \vec{p}_2, \dots, \vec{p}_{10}\}$
- Euclidean distance: $d_k = \Vert{}\vec{x}_{\text{end}} - \vec{p}_k\Vert{}$

The 1st-order conditional probability distribution $P(\text{Receiver} = k \mid \vec{x}_{\text{end}}, \text{Passer } i)$ is defined as:

$$P(\text{Receiver} = k \mid \vec{x}_{\text{end}}, \text{Passer } i) =  \begin{cases}  0 & \text{if } k = i \\ \frac{\exp(-\lambda \cdot d_k)}{\sum_{m \neq i} \exp(-\lambda \cdot d_m)} & \text{if } k \neq i  \end{cases}$$

> Note, I think that the recipient player should be modelled on their position which should be allocated an average location based on the league average. This is because we want to create a baseline which is the average + variance. A team time include a striker which drops deep to reveive the ball. This will be reflected in their average position, therefore, the null models will encode it. We want this unique tactical attribute to show up against the null models. Not be a part of the nulls. This would add additional complexity when I team has two central midfielders for example, but I think we can work out these smetantics in the code

Remeber the gaol is to create a conditioned null model (which preserves global baseline rules). Note overfit to intput 

anchoring player average locations $(\bar{x}, \bar{y})$ to league-wide positional baselines rather than the team's match-specific average locations, the null model evaluates whether a player's behavior is a genuine tactical outlier or just standard positional noise.  

┌────────────────────────────────────────┐
                       │  Input Team Roster & Formation (4-3-3) │
                       │  • Player A: Central Midfielder        │
                       │  • Player B: Central Midfielder        │
                       └───────────────────┬────────────────────┘
                                           │
                                           ▼
                       ┌────────────────────────────────────────┐
                       │  Positional Disambiguation Logic        │
                       │  • Compare x/y pitch side              │
                       │  • Player A -> "LCM" (Left Midfield)   │
                       │  • Player B -> "RCM" (Right Midfield)  │
                       └───────────────────┬────────────────────┘
                                           │
                                           ▼
                       ┌────────────────────────────────────────┐
                       │  Assign League-Wide Anchor Matrix      │
                       │  LCM -> League_Mean_Coordinates["LCM"] │
                       │  RCM -> League_Mean_Coordinates["RCM"] │
                       └────────────────────────────────────────┘

---

### Approach B: Full Pass Regeneration
Given a team's formation, generate a synthetic start location $(x_1, y_1)$, sample a pass vector to an end location $(x_2, y_2)$ trained on league distributions, and draw a recipient using spatial decay.

Each pass vector is sampled independently from a 1st-order spatial density distribution $P(\vec{x}_{\text{end}} \mid \vec{x}_{\text{start}})$, followed by the spatial receiver draw $P(\text{Receiver} \mid \vec{x}_{\text{end}})$.

It solves the data sparsity problem identified by Gama et al. (2026) because it trains on $150,000+$ season-wide pass events rather than a small set of match matrices

---

### Approach C: Incremental Network-Level Edge Rewiring
Preserve nodes and degree sequences, but draw from a season probability matrix to incrementally add edge weights in batches (e.g., 25 passes at a time)

This adapts the exact sliding-window / sub-network logic seen in Buldú et al. (2019) and Gama et al. (2026). 

By generating matrices in 25- or 50-pass increments using a 1st-order transition matrix, you directly replicate Buldú's dynamic windows while controlling for possession volume.

> Note, this approach appears to include a temporal aspect, and it probably could, but my intended implemenation, each 25 is sampled from the same distribution. This is 1st order markov so it doesn't understand that the latter draws are later in time. This is a clear exmaple of where a future work/limitaiton comes in

---

I think we have a great cascading linage going form rewires, pass generation and network generation. This is a perfectly implementable, explainable experimental flow and where all steps can be modelled using the same first order markovian approach adapted from the dynamics of the network work of gama whilst retaining a parsimonious, simple modelling appraoch

(Pass-Level Rewiring $\to$ Full Event Generation $\to$ Sub-Network Generation)

A cascading 1st-Order Markovian framework, preserving the exact mathematical rigor and linear algebra foundations of Gama et al. (2026) while keeping the experimental pipeline modular and explainable.

┌──────────────────────────────────────────────┐
│         STEP 1: Pass-Level Rewiring          │
│   • Preserves empirical pass vectors         │
│   • 1st-Order Spatial Receiver Assignment    │
└──────────────────────┬───────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────┐
│       STEP 2: Full Event Pass Engine         │
│   • Generates (x1, y1) -> (x2, y2) vectors   │
│   • 1st-Order Spatial Density + Receiver Draw│
│   • Solves Data Sparsity (150k+ events)      │
└──────────────────────┬───────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────┐
│     STEP 3: Sub-Network / Window Engine      │
│   • Generates 11x11 matrices incrementally   │
│   • Controls for pass volume (e.g. 50 passes)│
│   • Evaluates macro-topological decay        │
└──────────────────────────────────────────────┘

---

### Node Transition 
**Node Transition Entropy** was included to capture variability in passing choices, complementing the centrality metrics. [24,25]

Node Transition Entropy builds on these by looking at a random walk or a Markov chain running across the network's nodes

It is **DYNAMICS ON A NETWORK**

- Transiational players during a match
- The sturcture/topology of a network determines the constraints on what can take place. 
- If a node has 3 connected edges, the entropy is a measure of how evenly the flow splits among those fixed choices.
- It is used to understand diffusion, routing efficiency, and spreading phenomena
- can assess how a passing sequence moves between soccer players but nodes/network structure doesn't change. 

> While building a null model to understand how that map grows and forms is a "Dynamics of a network" task, the vehicle that builds it is a series of passes—which is a "Dynamics on a network" process.

> Node Transition Entropy (Dynamics on) is relevant to network formation (Dynamics of) due to how a PassMap is generated

> Because the network’s final topology is literally just an aggregated history of the transitions, information theory tools like Node Transition Entropy tell us about the rules of the transition choices.

---

### Gama 2026 Markov Section
"Markov-spectral modelling of passing networks" 

Passing interactions are represented as a finite-state, time-homogeneous Markov chain on the active player set, providing compact indices of passing variability, diffusion speed, navigability, and structural robustness.

By analysing the **transition probabilities of passes as a stochastic process**, we introduce a temporal dimension to the network analysis, enabling quantification of aspects like speed of ball circulation and distribution of possession that static metrics alone cannot capture.

> the author is using this as a tool of for modelling the **dynamics on the network** but similar and maybe even identical methods can be used to build the network and generate the network itself (**dynamics of the network**)

For each match, a directed weighted adjacency matrix A was constructed, where each entry represents the number of passes from one player to another.

For each match, a directed weighted adjacency matrix A was constructed, where each entry represents the number of passes from one player to another. From this adjacency matrix, a row-stochastic transition matrix P was derived on the active subgraph (players with at least one outgoing pass), where each entry represents the probability that a player passes to a specific teammate. When the empirical transition matrix was not irreducible, a teleportation correction (a = 0.15) was applied to ensure irreducibility of the Markov chain.
- converting the raw passing "count" matrix into a probability transition matrix ($P$)
- they are modifying the properites of the matrix itself using its own rows
- i.e. they are using linear algebra 
- turn raw counts into probabilities by performing an operation called row-normalization to create a row-stochastic matrix
- every row in the matrix will sum up to exactly $1.0$ (or 100%)
- to get the Transition Matrix ($P$), linear algebra takes each row and divides every entry in that row by the row's total sum
- Mathematically, this is expressed as multiplying the inverse of a diagonal degree matrix ($D^{-1}$) by the adjacency matrix ($A$):
- $$P = D^{-1}A$$

--- 

## Naz, 2014 
Narizuka et al. propose a 1st-order Markov chain simulation

They define a state vector $a^{(t)} = [a_1^{(t)}, \dots, a_N^{(t)}]$ representing the ball-possession probability across nodes at time step $t$, evolving via $a^{(t+1)} = a^{(t)} P$. 

The transition matrix $P_{i \to j}$ is formulated as a product of two spatial factors:  

$$P_{i \to j} \propto Q_\alpha(r_{ij}) \times R_{\beta, \xi}(L_j)$$

Pass Distance Difficulty $Q_\alpha(r_{ij})$: A threshold function penalizing long passes if Euclidean distance $r_{ij} > \alpha$.

Player Positional Mobility $R_{\beta, \xi}(L_j)$: An exponential decay function penalizing Target Player $j$ based on their distance $L_j$ away from their assigned home tactical position:

$$R_{\beta, \xi}(L_j) = \begin{cases} 1 & (L_j \le \xi) \\ e^{-\beta(L_j - \xi)} & (L_j > \xi) \end{cases}$$

When this 1st-order spatial Markov engine is simulated over $t=500$ passes, the generated ball-possession probabilities $G(a)$ match the empirical truncated gamma degree distributions ($\nu \approx 0.34$) and replicate real-world clustering/path-length values.

Narizuka et al. (2014) proved that a 1st-order Markov chain driven by spatial distance decay can successfully synthesize realistic football network topologies.

---

## Spatial Decay
proposed assigning pass recipients by taking pass end-locations $(x_2, y_2)$ and calculating a distance decay draw against player positional anchors $\vec{p}_k^{\text{league}}$

Narizuka et al. (2014) provide the exact academic precedent for this mechanism. Their $R_{\beta, \xi}(L_j)$ function is a spatial exponential decay based on a player's distance from their home position. 

Citing Narizuka et al. (2014) proves that your spatial receiver allocation is not an ad-hoc heuristic, but a established statistical mechanics method.

--

## 
