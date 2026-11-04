Project used Player passmaps but experiement with location and player-location networks

---

Higher-order custom chains; networks or walks?

---

Indirect edge network; this is where the edges are direct interactions like passes but instead are derived from correlations in metrics. For example, x,y coorodinates to represent players that move together. This has many pass on applications, for example working with onboarding data. Customers do not have direct interactive links but they maybe exhibit similar behaviours.

---

Network of final score lines. Idea is to represent or random walk over chains of teams final score lines. The idea outcome would be a model that is capable of predicting a teams next score line based on $N$ previous score lines: 

Node could be score lines, with edge weights denoting a connection based on what comes next, i.e. if a team wins 2-1 and 2-2 next then an interaction between 2-1 $\rightarrow$ 2-2. 

Or, the network could be higher-order network where edges co-ordinate over a chain of results, e.g. $n=4$. 

The goal will probably be to predict 0-0 so this could be converted into number of goals to mitigate data sparsity issues. or score line differential to account for win vs loss magnitudes. Could cluster groups into scorless $\mathcal{Z}$, $\mathcal{L}$ (Low-Scoring / Normal: Under 2.5), $\mathcal{H}$ (High-Scoring/Erratic: Over 3.5 goals), $\mathcal{E}$ (Extreme Volatility / Chaotic: $\ge 5$ goals)

Construct a global transition graph from all matches across 5–10 years. Then tune or walk this graph using team-specific weights or Node2Vec/random walk restarts biased toward the team's parameters.

### 3. Possible Methodologies:
**Biased Random Walks with Restart (RWR):**
- Treat the current recent score sequence as the "seed" node.
- Run a personal PageRank / Random Walk with Restart where transition probabilities are biased by match context (home advantage, opponent Elo).
- The steady-state probability vector across the target 1-step score nodes yields the final score-line probability distribution.

**Graph Embeddings (Node2Vec / Word2Vec over Walks):**
- Generate corpus of random walks over historical match chains.
- Learn low-dimensional vector embeddings for score states and teams simultaneously.
- Compute similarity or train a Softmax classifier on $\text{Embedding}(v_{\text{history}}) \cdot \text{Embedding}(\text{Team}) \to \mathbb{P}(\text{next score})$.

**Temporal Link Prediction:**
- Frame the question as: _"Given the sub-graph up to week $t$, which directed edge $u \to v$ is most likely to form at week $t+1$?"_
- Apply standard graph neural networks (e.g., DySAT or temporal GCNs) to predict edge occurrence probabilities.
--- 
### 4. Evaluation & Benchmarking
In football analytics, score-line prediction has established baseline models. To validate that network science adds predictive power, compare your results against:
- **Baseline 1 (Independent Poisson / Dixon-Coles):** The standard benchmark where goals scored and conceded are modeled via Poisson processes adjusted for low-score correlation (0-0, 1-0, 0-1, 1-1).
- **Baseline 2 (Unconditioned Empirical Frequencies):** Frequency of each score line in the target league across history (e.g., 1-1 occurs ~11% of the time, 1-0 ~10%).
- **Metric:** **Ranked Probability Score (RPS)** or **Multiclass Log-Loss** over the discrete probability distribution of score lines (not just Top-1 accuracy, which is typically low in exact score predictions).

### Recommended Next Steps to Scope the Draft
1. **Define the Node Definition:** Decide between team-relative score tuples (e.g., $+1$ GD, $2$ GF) vs. absolute scores. Team-relative vastly reduces state-space fragmentation.
2. **Collect Data:** Grab match logs from a unified dataset (e.g., `football-data.co.uk` covering 20+ seasons across European leagues).
3. **Run Exploratory Topology Analysis:** Build the global $N=1$ score network. Check if the graph has clear community structure (e.g., "low-scoring grind" clusters vs. "high-variance shootout" clusters). If topology is random/uniform, higher-order structures will be essential.


#### 1. In-Degree Centrality of the $0\text{--}0$ Node
- Identify which higher-order sequence nodes have the highest transition probability directly into $0\text{--}0$:$$P(\mathcal{Z} \mid u) = \frac{W_{u \to \mathcal{Z}}}{\sum_{v} W_{u \to v}}$$
Sort these precursor nodes $u$. If the top incoming paths consistently represent erratic or unstable sequences (e.g., $[\text{Blowout Loss}, \text{High-Scoring Draw}] \to 0\text{--}0$), the tactical "tightening up" trope is supported by the network topology.

#### 3. Null Model Significance (Configuration Model / Shuffling)
- Create null models by randomly shuffling match outcomes while preserving the marginal distribution of $0\text{--}0$s (~7% to 9% in major leagues).
- Run random walks over the empirical network vs. 1,000 randomized networks.
- Measure the **Mean First Passage Time (MFPT)** to reach state $\mathcal{Z}$ from erratic states. If empirical MFPT is significantly shorter than in the shuffled graphs, the clustering into $0\text{--}0$ is non-random.



### Way to Represent Higher-Order Chains
To preserve history across $N$ steps, you choose between two graph formulations:
#### The De Bruijn / Sequence-Node Graph (Standard Higher-Order)
The standard solution in higher-order networks is to redefine a **node as an ordered tuple of $N$ previous events**. The edges remain standard directed connections representing a 1-match step.
- **For $N = 1$ (First-order):**
    - Node: $[S_t]$
    - Edge: $[S_t] \to [S_{t+1}]$
- **For $N = 2$ (Second-order):**
    - Node: A 2-match sequence $[S_{t-1}, S_t]$
    - Edge: Shifts forward by one match, dropping the oldest:
$$[S_{t-1}, S_t] \longrightarrow [S_t, S_{t+1}]$$
**Concrete Walk Example ($N = 2$):** Suppose a team's sequence is: **Erratic ($E$) $\to$ Normal ($L$) $\to$ Goalless ($Z$)**
1. Current state node: $[E, L]$
2. The team plays a $0\text{--}0$ ($Z$).
3. Directed transition occurs:
$$[E, L] \longrightarrow [L, Z]$$
To predict whether $Z$ happens next, you simply check the edge weight from node $[E, L]$ into any node ending in $Z$ (i.e., $[L, Z]$). The sequence history is baked directly into the node identity.

#### Why don't random walks on 1st Order Networks Work?
A standard random walk on a first-order graph is strictly **Markovian (memoryless)**. When a walker sits on node $u$, the probability of moving to node $v$ depends **only** on the edge weights leaving $u$:
$$\mathbb{P}(X_{t+1} = v \mid X_t = u, X_{t-1} = w, \dots) = \mathbb{P}(X_{t+1} = v \mid X_t = u)$$
- On a **first-order graph**, the node $L$ pools together _every_ time any team was ever at $L$—whether they arrived after a 4–4 thriller, after three dull 1–0 wins, or after a standard 1–1 draw.
- The edge leaving $L \to 0\text{--}0$ reflects only the general rate at which _any_ low-scoring match is followed by a $0\text{--}0$.
- The walker **has no memory of whether it just stepped off node $C$ or node $L$**. The prior sequence is discarded the instant the walker arrives at $L$.
#### Can You Modify the Walker Instead of the Graph?
There are two primary ways to reconcile random walks with sequential memory. Both are valid, but they handle the memory in different places:
#### Method A: Higher-Order Network + Standard Random Walk
You redefine the nodes as sequences of length $N$ (e.g., node = $[C, L]$).
- The walker itself remains completely simple and standard (memoryless).
- All historical trajectory data is encoded directly into the network's topology.
- You can use all existing network metrics off the shelf (PageRank, hitting times, eigenvector centrality, stationary distributions) without modifying the mathematical definitions.
##### Method B: First-Order Network + Second-Order Walkers (e.g., Node2Vec-style)
You keep nodes as single match states ($C$, $L$, $Z$), but modify the walker's transition rule so that step $t+1$ depends on the node at step $t$ **and** the node at step $t-1$:
$$\mathbb{P}(X_{t+1} = v \mid X_t = u, X_{t-1} = w) = \pi(v \mid u, w)$$
A second-order random walk on a graph $G$ is mathematically identical to a first-order random walk on the **line graph / edge-transition graph** of $G$. In other words, you have still created a higher-order network—you’ve just hidden it inside the walker's transition tensor instead of the node labels.

Second-order walks usually only look back **1 step** ($N=2$). If you want to evaluate an $N=3$ or $N=4$ match sequence (a true "chain"), the transition tensor becomes cumbersome compared to a simple De Bruijn sequence graph.


#### The Network is the transition matrix
**The normalized adjacency matrix of a weighted directed network _is_ the transition matrix of a random walk.**
$$\mathbf{P} = \mathbf{D}^{-1}\mathbf{W}$$(Where $\mathbf{W}$ contains the edge weights, and $\mathbf{D}^{-1}$ normalizes each row by its out-degree so the probabilities sum to $1$.)

This is why it is generally advised to construct higher-order networks. As the network is self-perpetuating. It is an **Intrinsic Walk**. The edge weights directly specify the transition probabilities. The network _is_ the model. The memory lives in the network (Higher-order / De Bruijn nodes encode history). Standard 2D Matrix multiplication ($\vec{\pi}_{t+1} = \vec{\pi}_t \mathbf{P}$). Google PageRank, Markov Chains, Infomap, De Bruijn graphs.

The other way is an **Extrinsic Walk** (Agent/Physics on a Substrate). The graph is just a physical road map / topology. An external agent carries its own internal state, momentum, or rules over it. The memory lives the agent (The walker algorithm tracks its own trajectory buffer). And the maths is a Higher-order transition tensor ($\mathbf{T}_{ijk} = \mathbb{P}(k \mid j, i)$) or simulation loop. Node2Vec (hyperparameters $p, q$), physical particles with inertia/momentum, self-avoiding walks.

The Intrinsic walk retains closed-form linear algebra. With an intrinsic graph, predicting the future doesn't require simulating thousands of slow Monte Carlo agent walks. You can compute exact probabilities, mean hitting times to $0\text{--}0$, and stationary distributions directly using simple matrix operations: 
$$\vec{p}_{\text{future}} = \vec{v}_{\text{start}} \mathbf{P}^k$$
Additionally, with an intrinistic walk you loose all of the additions of a network science suite. You can't inspect the topology directly. n network science, we usually want to examine structural properties: _What are the central nodes? Are there bottlenecks? What are the network communities?_ If you use an extrinsic agent, those structural questions tell you nothing about your hypothesis because the "real" dynamics only exist inside the agent's code. If you use a **Higher-Order Network**, the topology itself answers your football questions. A community detection algorithm on the graph will naturally cluster chaotic chains together, and you can visually inspect which sequence nodes have massive inward arrows feeding directly into $0\text{--}0$.


#### How to Use the Probability Transition Matrix
The goal is to predict what happens after a _specific_ sequence of games, **you do not randomize the starting seed**. The seed is fixed to the exact real-world chain you are analyzing.

f Team A just played an erratic shootout followed by a low-scoring draw, their recent sequence is:
$$\text{Current History} = [E, L]$$
In your Higher-Order Network, the starting state is a **one-hot probability vector** $\vec{v}_0$ where the index corresponding to node $[E, L]$ equals $1$, and all other nodes equal $0$:
$$\vec{v}_0 = \big[\, 0,\; \dots,\; 0,\; \underbrace{1}_{[E, L]},\; 0,\; \dots,\; 0 \,\big]$$
### 2. Method 1: The Analytical Walk (Instant Exact Distribution)
In network science, you don't actually have to simulate individual particles stepping across edges to find where they end up. Matrix multiplication computes the exact probability distribution across all possible states simultaneously.
#### Predicting the Next Match ($t+1$)
Multiply the starting vector by the transition matrix $\mathbf{P}$:
$$\vec{v}_1 = \vec{v}_0 \mathbf{P}$$
This single vector-matrix multiplication gives you the exact probability distribution over all reachable nodes for the very next match. Any node ending in your target state $Z$ (e.g., $[L, Z]$) gives you:
$$\mathbb{P}(\text{Next game is } 0\text{--}0 \mid \text{History is } [E, L])$$
If you want to know what the team's state distribution looks like 3 games into the future:
$$\vec{v}_k = \vec{v}_0 \mathbf{P}^k$$
Powers of the transition matrix ($\mathbf{P}^k$) naturally account for all possible multi-step paths through the network.
### 3. Method 2: Monte Carlo Random Walk (Simulating Rolling Particles)
If you _do_ want to simulate actual random walks (for example, to simulate an entire upcoming season or run tournament scenarios), the process looks like this:
- **Initialize:** Place a walker at the observed seed node $u = [E, L]$.
- **Sample:** Look up row $u$ in the transition matrix $\mathbf{P}$. This row defines a discrete probability distribution over all out-edges (e.g., $60\%$ to $[L, L]$, $25\%$ to $[L, Z]$, $15\%$ to $[L, E]$).
- **Step:** Draw a random number or sample a categorical distribution to pick the next node $v$.
- **Advance:** Update the walker's position to $v$.
- **Repeat:** Continue stepping for $k$ matches.
Running $10,000$ simulated walkers from the seed node and counting where they end up produces empirical frequencies that converge to $\vec{v}_0 \mathbf{P}^k$

### 4. Beyond "Where Does It End Up?": Hitting Times
For your hypothesis, you might not just care where the walker is in exactly 1 or 2 steps. You might ask:
> _"How many games does it typically take for a team to hit a 0–0 after experiencing an erratic match?"_

This is modeled using **Mean First Passage Time (MFPT)** or **Absorption Analysis**:
1. Make your target state ($0\text{--}0$) an **absorbing state** (once a walker hits $0\text{--}0$, it stops).
2. Decompose the transition matrix into transient states $\mathbf{Q}$ and absorbing states $\mathbf{R}$:
$$\mathbf{P} = \begin{bmatrix} \mathbf{Q} & \mathbf{R} \\ \mathbf{0} & \mathbf{I} \end{bmatrix}$$
3. Compute the **Fundamental Matrix**:
$$\mathbf{N} = (\mathbf{I} - \mathbf{Q})^{-1}$$
4. The entry $\mathbf{N}_{u, :}$ directly reveals the **expected number of matches** until a $0\text{--}0$ occurs when starting from any precursor sequence $u$.
If the expected time to reach $0\text{--}0$ is significantly shorter when starting from chaotic nodes $[E, E]$ than from normal nodes $[L, L]$, you have mathematical proof that chaotic chains accelerate a regression into goalless matches.

---

#### A random walk is a process, not a null model.
A random walk is simply a dynamical engine: it traverses whatever network you feed it.
- If you feed a random walker your **real empirical transition matrix**, it is **not** behaving as a null model. It is measuring the specific, real-world flow patterns of actual football history.
- A **null model**, by contrast, is a **deliberately scrambled, randomized counterfactual network** designed to represent what the world would look like if your specific hypothesis were completely false.

You apply a null model here to answer one specific question:
> _"Is the observed probability of an erratic sequence leading to a 0–0 actually a real tactical pattern, or is it merely what you'd expect by dumb luck because 0–0s happen 8% of the time anyway?"_

To test your hypothesis, you compare the behavior of random walks on two different network substrates:
- [Real Football Matches] ──> Build Real Network (G_real) ──> P( 0-0 | [E, E] ) = 14%
- [Shuffled Football Matches] ─> Build Null Network (G_null) ──>  P( 0-0 | [E, E] ) = 8%
If the probability of hitting $0\text{--}0$ after an erratic sequence $[E, E]$ is $14\%$ on your real network, is $14\%$ high? You cannot know until you measure the same walk on a null network.

In network science, a valid null model must preserve fundamental baseline constraints (like base rates) while destroying the temporal ordering you want to test.

### Three Specific Null Models for This Problem
In network science, a valid null model must preserve fundamental baseline constraints (like base rates) while destroying the temporal ordering you want to test.
#### 1. The Sequence-Shuffling Null Model (Permutation Test)
- **What you keep:** The exact marginal frequency of each match state across the dataset (e.g., exactly $8\%$ $Z$, $52\%$ $L$, $40\%$ $E$).
- **What you destroy:** The chronological order of the matches.
- **How to build it:** Take the match log for every team and randomly shuffle the order of matches. Rebuild your higher-order transition graph $\mathbf{P}_{\text{null}}$.
- **What it tests:** Whether sequence history matters at all. If the real network gives $P(Z \mid [E, E]) = 0.14$, but across 1,000 shuffled null networks the average is $0.08 \pm 0.01$, your empirical finding is statistically significant ($p < 0.01$).
#### 2. The Configuration Model/Degree-Preserving Edge Swap
- **What you keep:** The in-degree and out-degree of every node in your graph. (Every node has the exact same total volume of traffic coming in and going out).
- **What you destroy:** The specific correlations between _which_ nodes connect to which.
- **How to build it:** Perform double-edge swaps: pick two edges $u_1 \to v_1$ and $u_2 \to v_2$, and rewire them to $u_1 \to v_2$ and $u_2 \to v_1$, repeating this thousands of times.
- **What it tests:** Whether transitions into $0\text{--}0$ are driven by local sequence motifs or just the global popularity of certain nodes.
#### 3. The First-Order Markov Null Model (Order-1 Baseline)
- **What you keep:** The real-world 1-step transitions $P(X_{t+1} \mid X_t)$.
- **What you destroy:** Any memory extending back to $t-1$ or $t-2$.
- **How to build it:** Generate synthetic match chains assuming a purely memoryless first-order process derived from the $N=1$ matrix, then fit your $N=2$ higher-order graph to those synthetic chains.
- **What it tests:** Whether a multi-game "chain" ($N \ge 2$) provides actual predictive lift over just knowing the single most recent match ($N=1$).
### Step-by-Step: How to Run the Hypothesis Test
1. **Calculate the Test Statistic on Real Data:** Run the analytical walk (or hitting time calculation) on your empirical higher-order matrix $\mathbf{P}_{\text{empirical}}$ to get your target metric:
$$T_{\text{real}} = P\big(\text{Next is } 0\text{--}0 \;\big\vert{}\; \text{Current is } [E, E]\big)$$
2. **Generate an Ensemble of Null Networks:** Shuffle the match timelines $M = 1,000$ times. For each shuffled dataset $k$, construct $\mathbf{P}_{\text{null}}^{(k)}$ and calculate:
$$T_{\text{null}}^{(k)} = P_{\text{null}}^{(k)}\big(\text{Next is } 0\text{--}0 \;\big\vert{}\; \text{Current is } [E, E]\big)$$
3. **Compute the Empirical $p$-value and $z$-score:**
$$z = \frac{T_{\text{real}} - \mu_{\text{null}}}{\sigma_{\text{null}}}$$
$$p = \frac{1}{M} \sum_{k=1}^M \mathbb{I}\Big(T_{\text{null}}^{(k)} \ge T_{\text{real}}\Big)$$
If $z > 2$ (or $p < 0.05$), you have statistically validated that teams tightening up into a goalless match following volatile sequences is a genuine network phenomenon rather than an artifact of random noise.

Precisely. If your empirical metric fails to diverge from the null distribution ($p \ge 0.05$ or $\vert{}z\vert{} < 2$), you have rejected the core hypothesis: **the chronological chain of recent match outcomes does not carry a statistically detectable signal for predicting a 0–0.**

### 1. The System is Memoryless (Markovian)
If your higher-order network ($N=2$ or $N=3$) behaves identically to a shuffled null model or a first-order model, it means:
$$\mathbb{P}(X_{t+1} = 0\text{--}0 \mid X_t, X_{t-1}) \approx \mathbb{P}(X_{t+1} = 0\text{--}0)$$
A team that just suffered a chaotic 4–3 loss is no more likely to produce a 0–0 than a team coming off any other sequence. Match outcomes are acting largely as independent trials governed by baseline league distributions.

### 2. State-Space "Smearing" (Aggregating Conflicting Archetypes)
Because you pooled all teams together to create a single macro-network, two opposing tactical behaviors might be canceling each other out:
- **The "Tighten Up" Cohort:** Underdog or pragmatic teams might indeed respond to chaos by parking the bus (increasing 0–0 likelihood).
- **The "Compounding Chaos" Cohort:** Fragile, high-pressing, or structurally flawed teams might respond to chaos with collapsed morale and further chaotic, high-scoring matches.
When blended into a single global transition matrix, their transition arrows average out, washing away the signal until the network looks indistinguishable from random noise.

### 3. Missing Interaction Substrate (Two-Sided Dynamics)
A football match is not played by one team in a vacuum; it is a collision of two distinct historical paths:
- Team A arrives with history $[E, E]$ (wants to shut the game down).
- Team B arrives with history $[H, H]$ (hyper-attacking momentum).
By tracking individual team sequences without modeling the pairwise interaction at match $t+1$, the network may lose the causal mechanism that produces a 0–0 (which typically requires _both_ managers to accept or enforce defensive rigidity).

### 4. Low Base Rate and Noise Floor
Because 0–0 is an intrinsically rare event (~7–9% of matches), it is subject to high Poisson variance. Even if a manager implements a ultra-defensive game plan to force a 0–0, a single deflected cross, penalty, or red card produces a 1–0. The network might not be failing to capture the _tactical intent_, but rather reflecting that football's low-scoring nature has too high a noise-to-signal ratio for pure score history to isolate.


In quantitative sports research, proving the **absence** of serial correlation is just as valuable as finding it.

If the test is non-significant, your project shifts from an applied prediction engine to a structural critique:
1. **Testing the "Common Sense" Pundit Fallacy:** Football media frequently asserts tropes like _"they'll tighten up after that blowout"_ or _"a bore draw was inevitable after last week."_ Showing that higher-order network walks cannot beat a sequence-shuffled null model provides quantitative proof that these narratives are cognitive biases (clustering illusions).
2. **Establishing an Empirical Bound on Memory:** It formally proves that modeling football scores as higher-order Markov/De Bruijn processes over-engineers what is fundamentally an uncoupled or first-order stochastic process.