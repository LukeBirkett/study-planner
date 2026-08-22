The original 2018 Buldú paper framed the foundational challenges of analyzing football passing networks.

Regarding Null Models, they do not propose or create a new method for null models. Instead, they address it as an active limitation and an open challenge.

They recognise the need for null models as a tool to "quantify the amount of disorder and complexity of the network topology".

They explain that a good null model cannot just be a standard random network configuration; it must incorporate specific spatial and temporal constraints of a real football match (player positions on the pitch, pass lengths, and degree distributions)

In later papers, Buldi and trhe wider working group actively tackled the challenges surrounding random network comparisons, spatial constraints, and unpredictability in subsequent research.

However, they do not produce. single null model approach for passing network. Infact, their approach was abstract from traditional models in the sense that they produced alternative mathematical structures—specifically Entropy models and Pitch-Passing frameworks—to separate actual tactical intent from random noise.

Null models do not account for physical players on field positioning. To work through this, they introduced pitch-passing networks where nodes represent designated spatial regions of the pitch rather than individual players.

This transfer of entity from players to spaces they ground the network in Euclidean space, embedding physical constraints into the network design itself.

This allowed them to measure a team's actual "identifiability" and style of play against random variations without needing a decoupled spatial null model

In a later 2020 paper, "Node and Network Entropy—A Novel Mathematical Model for Pattern Analysis of Team Sports Behavior," (Martínez et al., 2020 ), the working group address the disorder and complexity" problem they raised in 2018. However, rather than generating randomized networks to test against, they used Markov chains to mathematically calculate the Relative Transition Entropy of passing and receiving behaviors.

This localized framework measures the exact statistical probability of a player choosing to pass to a specific teammate versus any other. Higher entropy values directly pinpointed unpredictable, complex passing sequences, successfully isolating chaotic noise from structured team tactics.

In "Spatial and Temporal Entropies in the Spanish Football League," explicitly solved the "disorder and complexity" problem by treating the weighted directed passing networks as Markov chains. Their contributions included computing permutation entropy and statistical complexity over time-evolving rolling network windows. This allowed the researchers to quantify the exact fluctuations of a team's network parameters. By tracking the complexity of these fluctuations, they bypassed the need for an external baseline null model, relying instead on the internal temporal dynamics of the match to differentiate randomness from deterministic game strategies. 

These entropy- and Markov chain-based frameworks "supersede" the requirement for a traditional null model because they shift the entire scientific question from structural comparison to mathematical uncertainty.

In network science, a traditional null model (like an Erdős–Rényi random graph or a configuration model) is used to answer the question: "Is this network structure special, or would it happen by pure random chance?" However, as Buldú’s team noted in 2018, building an external model that randomizes football passes while strictly enforcing the laws of physics, match time, and player positioning is incredibly difficult.

The later papers solved this by using Information Theory (Entropy) and Stochastic Modeling, which bypasses the need for a generative null model in three main ways:
- Trad null models build a completely seperate network to compare against. Conversely, Entropy (Shannon, Permutation, or Transition Entropy) is a model-free, self-contained mathematical metric. It measures the inherent randomness, predictability, or disorder directly within the real data. By calculating the entropy of a team's passing network over time, researchers get a value where 0 means perfect, rigid predictability (the team is running a deterministic, clockwork play) and 1 means maximum chaos (the team is playing purely randomly). The metric carries its own absolute bounds, eliminating the need to build a fake, randomized network baseline.
- **Differentiating Noise via Statistical Complexity:** In the 2020 Spatial and Temporal Entropies paper, the researchers paired permutation entropy with a metric called statistical complexity to track how network structures fluctuate across dynamic match windows. A standard null model struggles to capture how chaos shifts over 90 minutes. By pairing entropy with complexity, the math can naturally identify when a structural change in the network is just random fluctuations (noise) or a highly complex, deliberate tactical shift (signal). It isolates tactical intent internally rather than measuring deviation from an external random graph.  
- **Transition Matrices and Inherent Probabilities:** By utilizing Markov Chains, a weighted passing network is treated as a matrix of transition probabilities. Instead of generating thousands of random synthetic networks to see if a specific passing sequence is statistically significant, you measure the Relative Transition Out-Entropy of the individual players. If a midfielder has five passing options but consistently passes to one specific forward, the transition entropy drops significantly. The math highlights the deliberate tactical choices directly out of the data's own probability distribution, rendering a structural null model redundant.

**Summary:** Traditional null models ask: "Does this network look random?" The newer entropy approaches ask: "How much active choice and predictability exists within this sequence?" By measuring the internal information density of the game, the math inherently accounts for the randomness without needing a separate synthetic benchmark.

Furthermore, you do not loose the ability to measure network topology metrics like centrality when swapping out a traditional random null model for an entropy-based framework. 

It is important to remember, the method, i.e. entropy or Markov chains, doesn't change the structure of the data. We are still building the exact same directed, weighted passing network where nodes are players and edges are passes. Because the network structure remains intact, you can still mathematically calculate any standard topological metric. 

Entropy Measures the Distribution of Centrality. Instead of replacing centralities, entropy is often applied directly to them. In network science, you can calculate Node Centrality Entropy. This measures how evenly distributed a metric (like betweenness centrality) is across the entire team over time.

**Low Centrality Entropy:** The centrality is heavily concentrated in one or two players (e.g., a single dominant playmaker like a deep-lying midfielder). The team has a high structural dependency on specific individuals.

**High Centrality Entropy:** Centrality is evenly distributed across all 11 players. The team’s passing structure is highly decentralized, meaning if one player is marked out of the game, the system easily adapts.

When we treat passing networks as a Markov chain, we are assigning transition probabilities to the edges. This allows for a "Markovian" View of Centrality and actually allows for more accurate versions of centrality known Random Walk Centrality or Steady-State Probability. 

Standard centrality measures assume a pass can just flow anywhere across a graph uniformly. A Markovian framework calculates how likely a ball is to end up at a specific player's feet based on real game probabilities. A player's "centrality" in this context reflects their true tactical prominence in sustaining possession, factoring in the team's localized habits.

When we implement markovian approaches, we aren't discarding network topology but instead changing how you validate it.

Instead of saying, "Player X has a high betweenness centrality compared to a random fictional graph," you can now say, "Player X has a high betweenness centrality, and the low transition entropy proves this is a highly deliberate, predictable tactical pipeline rather than random game noise."

During the lecture content we studied the shift from Modularity Maximisation to the Stochastic Block Model (SBM). This is the exact same philosophical leap we are seeing in the football passing networks liturature. In both the lecture and the research, the network science is moving away from the "traditional" null model (building a fake, randomized graph to compare against) and moving toward probabilistic, entropy-based mathematical frameworks to avoid overfitting and capture the true complexity of the system.

The lecture states the Modularity (Q) is almost always a bad idea because it lacks statistical regularization and "massively overfit[s] empirical data". This is analagous to how football researchers realized standard random graphs couldn't capture pitch dynamics. 

In the lecture, we shift to Stochastic Block Model (SBM) to avoid the issues associated with Modularity Maximisation. Instead of building a single randomized graph to act as a baseline, the SBM treats the network as a probability distribution.

Instead of asking, "Does this community have more edges than a random graph?" the SBM asks, "Given this structure, what is the exact probability matrix that a node in Block A connects to a node in Block B?". This is highly analogous to the Markov chain transition probabilities used in the newer football papers.

In the Gama (2026) paper they say *"Future studies should also employ null models and random network comparisons to establish baselines for spectral gap, entropy rate, and other indices, enabling more robust interpretation of observed values."* 

At first glance, this may feel like a backtrack on the initial premise that we should be move on from traditional null models because they are to rigid and ignore footballs physical realities. Afterall, the shift to Markov chains and entropy to bypass this. 

However, the true premise of Gamas suggestion is to evolute what a null model means in the domain context. They are not suggestion a revert back to traditional null models or simple random graphs. They are highlighting a specific limitation of using pure entropy and spectral metrics in isolation: the lack of a baseline.

In older methods like Modularity ($Q$), the null model is baked directly into the equation. We literally subtract a randomized "configuration model" from the real data to see if a community exists. The problem is that standard random graphs are terrible representations of football matches, so baking them into the core equation forces false patterns and overfits the data.

When researchers use Markov chains, transition matrices, or spectral gaps, they are measuring the dynamics on the network using self-contained probability. The math doesn't require subtracting a fake graph. It simply calculates the inherent predictability or flow of the possession.

This is where Gama's quote comes in. Let's say you calculate the Entropy Rate of a team's passing network, and you get a value of $2.4$. As this was born using a Markov approach, it is mathematically pure and not corrupted by a a bad Erdős-Rényi random graph. 

But here is the problem: Is 2.4 high or low? * Does 2.4 mean the team is incredibly unpredictable and fluid? Or does 2.4 mean they are panicking and passing randomly? 

What is the entropy rate of 11 guys just kicking the ball completely at random while constrained to a football pitch? Is it 3.0? Is it 5.0?

When Gama asks for "null models and random network comparisons," they are not asking to go back to the basic models that ignore spatial constraints. They are asking for advanced, domain-specific baselines to benchmark their new metrics.

They are essentially saying: "Now that we have these great metrics like spectral gap and entropy rate, we need to program a simulation of 'random football' (e.g., players passing based purely on distance, or degree-preserving random walks) to find out what the spectral gap of a truly random team is. Only then can we compare our real teams against it to see how structured their tactics truly are."

The research trajectory: 
1. Using bad null models to define structure.
2. Skipping null models entirely (using Markov/Entropy) to get pure mathematical measurements.
3. Realizing we need better null models purely to benchmark and interpret those new mathematical measurements.

I could build a project around evaluating why traditional null models fail in spatial sports data, how Markov chains capture the dynamics, and theoretically propose what a "good" football baseline model would actually need to look like.

The intial flow would start the same as all of my plans/ideas. Introduce the passing network, plot your dataset, and extract basic metrics (Degree, Betweenness, Eigenvector). 

Explain the problem with empirical baselines. Comparing a team's centrality to a league average is flawed because tactical systems dictate topology. A possession-heavy team will always look structurally different from a counter-attacking team.

Introduce standard network null models (Erdős–Rényi, Configuration Model). Use examples such as athe goalkeeper example to hihglight their failures. Traditional models are purely topological, they ignore the physical laws of Euclidean space, rendering them useless for spatial sports. Relying on standard topological maximization without proper constraints will massively overfit empirical data.

Then move ont the shift to dynamics (Markov and Entropy). 

**The Markov Chain:** Explain how treating the network as a transition matrix solves the goalkeeper problem. By relying on empirical transition probabilities, the model naturally encodes spatial realities (players only pass to who they can actually reach).

**Entropy as a Measure:** Demonstrate how calculating the transition entropy allows you to measure the predictability and structure of a team without ever needing a fake, randomized graph. You are measuring the internal chaos of the system.

Finally, the project comes "full-circle". Entropy gives you a pure mathematical number, but without a baseline, you cannot tell if that number represents tactical genius or pure random panic. 

Theoretically outline what a "good" football null model needs. It must preserve degree distributions, but it must also encode spatial friction (the probability of a pass existing must decay as distance increases).

This links back to the lecture content on Stochastic Block Model (SBM), which could be used as a baseline. If you group the pitch into spatial blocks (Defense, Midfield, Attack), the SBM can mathematically dictate that edges between the Defense block and Attack block have a strictly constrained probability. This creates a random network that actually obeys the laws of a football pitch.

Furthermore, to me after reading Narizuka (2014) and Gama (2026), it really did seem to me like there was a clear through to constructing a null model.

To build a network, all you actually need is a map of passes. what I mean by this is a literally list of passes: the passing player, the passes starting x,y and the passes ending x,y and the receiving player. This type of data is often plots to see a players distribution of passes. We then turn this into passing network through our desired method.

The Markov process could be adapted into a generative process where we create a new match of passes by sampling from the probability distributions. Once we have a new match of passes, we can create a network. and we can repeat this 1000s of times to get null model baselines. 

This is Monte Carlo simulation via generative Markov models. Instead of treating the Markov probabilities merely as a measurement (like Narizuka or Gama did), we can use them as an engine to simulate thousands of synthetic football matches.

This perfectly answers Gama's call for a robust baseline, and it entirely circumvents the spatial flaws of the configuration model.

By taking a real pass map and extracting the probability of Player A passing to Player B (constrained by their spatial zones), we are creating a transition matrix.

By "running" this matrix thousands of times, we are doing a Monte Carlo simulation.

Because the transition matrix is built on real pitch data, the 1000 generated matches will naturally obey the spatial laws of football and the specific formation of the team.

If we extract the network metrics (like centrality or spectral gap) from those 1000 synthetic matches, we have just created a statistically rigorous null distribution. We can finally say: "Barcelona's real-world entropy is 2.4, which sits in the top 5% of my 1,000 generated spatial baselines, proving their tactics are deliberately complex rather than random."

One thing to consider, most of the Markov models in the research model just one step, this is known as the Markov Property or memorylessness. The idea that the next state depends only on the current state, completely ignoring the history of how the system got there.

This means they do not capture chains of passes for the flows of a match. If we were to generate a match of passes, they could not be plotted into phases of play as the passes would not match up, there could not be a pass 1 or pass 2 etc. However, I think this could be a good first step and actually leaves a create set of talking points for the discussion, conlusion and future work part

In football terms, if a center-back passes to a midfielder, a 1st-order Markov model just looks at the midfielder's overall passing probabilities. It doesn't "remember" that the ball just came from the defense, which means it might just simulate the midfielder passing right back to the center-back, failing to capture progressive, multi-pass phases of play.

This is both something to highlight as a strength and weakness. While a 1st-order Markov generative model successfully controls for spatial and formation constraints, it fails to capture tactical momentum. Propose that future work should utilize 2nd-order or higher-order Markov chains (where the probability of the next pass is dictated by the current and the previous pass) to generate realistic, multi-pass phases of play.


> **1. The Problem:** Traditional network null models fail in football because they ignore space.
> 
> **2. The Innovation:** Use empirical Markov transition matrices as a generative engine to simulate 1000 synthetic pass maps that do respect spatial/formation constraints.
> 
> **3. The Application:** Build networks from these synthetic matches to create a robust baseline for advanced metrics (answering Gama's 2026 call to action).
> 
> *4. *The Critique:** Evaluate the "memoryless" limitation of your 1st-order model and point toward higher-order Markov models for future temporal analysis.

IMPORTANT: to effectly model a sampling process we need to down the spatial approach. The key paradigms in the liturature are pitch passing, player passing and pitch-player passing. All of these are foundational frameworks from the Buldú group’s early work formalized exactly how to split space and identity.

I need to full read and diseminate these papers in order to determine the best fit for me. 

**Player-Passing Paradigm:** Players are nodes. Edges are pass frequency between players. The spatial element is largely abstracted. When visualized, players are placed at a single fixed coordinate representing their average position on the pitch during the match. This tells you who is interacting, but it completely ignores where on the pitch those interactions happened - or at least it averages them out. 

**Pitch-Passing Paradigm:** Fixed geometric zones of the field. The pitch is divided into a grid (e.g., a $5 \times 5$ or $8 \times 8$ grid of cells). Ball movement from Zone X to Zone Y. The players identify is entirely abstracted. The only thing tracked is how the ball flowed between these spaces. This directly highlights a team's "corridors of play" and spatial biases (e.g., heavily relying on the left flank).

**Pitch-Player Passing Paradigm:** A combination of the player's identity and their location at the moment of the pass (e.g., Node 1 = "Busquets in Defensive Third", Node 2 = "Busquets in Middle Third"). The pass connecting a specific player in a specific zone to the receiver. This allows a player to exist as multiple nodes across the network, capturing how a player's tactical role shifts depending on where they move on the pitch.

---

Note, that the desire for Null Models in both tradition network metrics and markov/entropy methods pertains to the same concept of a Null Model. 

Tranditional measures look at a static representation of a network. A traditional structural null model tries to answer: "Is player X’s centrality unique, or would a random shuffling of the same number of total edges result in this centrality?"

Metrics like entropy rate or spectral gap measure the flow of probability across the network. A model-free calculation gives you an exact number for how chaotic or ordered that flow is. However, without a baseline, you don't know what that number means. A null model here answers: "What would the entropy rate look like if a team moved the ball with zero tactical intent, but still obeyed the laws of physical space?"

If the route to creating these null models is a generative one, then the output and be used for both appraoches. That is using a transition probability matrix to simulate 1,000 completely synthetic football matches. The simulated matches can be used to benchmark both types of metrics. 

Turn each synthetic match into a standard static passing network and calculate traditional centrality metrics (creating a structural null distribution).

Calculate the spectral gaps and entropy rates across those same matches (creating a dynamic null distribution). Remember that spectral gap and entropy rate are fundamentally mathematical measurements of flow across a transition matrix. Because the generative model creates synthetic data step-by-step, we are dealing with Markov chains.

The simulation engine runs 1,000 times. Each individual run simulates a single match by sampling sequentially from your spatial probability matrix (e.g., Player 1 $\rightarrow$ Player 4 $\rightarrow$ Player 7). At the end of each run, you are left with a raw string of, say, 500 simulated passes.

For Match #1 of your 1,000 synthetic games, you count the passing pairs to build an $11 \times 11$ raw passing matrix. You then normalize the rows so they sum to 1. This turns the raw passing network into an empirical Markov Transition Matrix ($P$), where each cell $P_{ij}$ represents the exact probability that player $i$ passes to player $j$.

Once you have the transition matrix $P$ for Synthetic Match #1, you calculate its unique stationary distribution vector, $\pi$ (which represents the long-term probability of the ball being at any given player's feet).  

Using $\pi$ and $P$, you plug them into the standard Shannon entropy rate formula: 

$$\mathcal{H} = -\sum_{i} \pi_i \sum_{j} P_{ij} \log P_{ij}$$

This gives you a single number—the Entropy Rate—which measures the overall randomness of the ball's flow in that specific synthetic match.

Using the same transition matrix $P$ from Synthetic Match #1, you compute its eigenvalues ($\lambda$). By mathematical law, the largest eigenvalue ($\lambda_1$) of a transition matrix is always exactly 1. 

You find the second largest eigenvalue ($\lambda_2$). The Spectral Gap ($\Delta \lambda$) is calculated as: 

$$\Delta \lambda = 1 - \lambda_2$$

In Markov chain theory, the inverse of the spectral gap dictates the mixing time—how fast a system reaches equilibrium. In football, a small spectral gap indicates tactical "bottlenecks" (the ball gets stuck in defensive loops and struggles to transition), whereas a large spectral gap means the ball moves fluidly across the entire team.

You repeat Steps 2 to 4 for all 1,000 synthetic matches. You will end up with:
- A list of 1,000 synthetic Entropy Rates.
- A list of 1,000 synthetic Spectral Gaps.

When you plot these as a histogram, you have officially created your dynamic null distributions.

Now that you have the baseline histogram from your 1,000 simulated games, you take the actual, real-world match data from your team, compute its real entropy rate and real spectral gap, and drop it onto the histogram.

This lets you do true statistical significance testing. If your real team's spectral gap lands far outside the middle of your generated baseline distribution, you have mathematically proven that the team’s ball-circulation speed is an intentional, highly organized tactical fingerprint, rather than just an inevitable consequence of their spatial formation.

One of the key innovations of this frameowrk is that the generative model handles the heavy lifting for both approaches: trad and entrophy. 

The generative model simulates 1,000 matches, with each match consisting of a step-by-step sequence of passes.

To calculate a traditional metric like Betweenness Centrality, we don't need a fluid probability matrix, we just need a standard Weighted, Directed Adjacency Matrix ($A$).

For Synthetic Match #1, you aggregate the simulated pass sequence into an $11 \times 11$ matrix where the cell $A_{ij}$ is simply the total count of how many times Player $i$ passed to Player $j$.

Using a Python library like NetworkX, you feed the matrix $A$ into your chosen centrality algorithm (making sure to account for edge weights and direction). This gives you an 11-element vector representing the centrality score for every single player position in that specific synthetic match.

Pool the Centrality Metrics to Create the Structural Null. Because you are tracking positions (e.g., Center Back, Midfielder, Striker), you isolate the position you are interested in. Let's say you want to evaluate the Defensive Midfielder. 

You loop through all 1,000 synthetic matrices, calculate the centrality dictionary for each, and extract the Defensive Midfielder's score. You append these 1,000 scores into a single list.

You take the real-world match data, build the real-world passing network, and calculate the Defensive Midfielder's actual centrality score.

Finally, you drop that real score onto the histogram generated by your 1,000 synthetic matches. 

If the real score is inside the bulk of the histogram: The midfielder's high involvement is not special; it is an inevitable consequence of the team's formation, short-passing philosophy, and spatial layout on the pitch.

If the real score is a massive outlier: The midfielder's high centrality is a deliberate tactical instruction—they are acting as a vital playmaker to a degree that far exceeds what spatial randomness would dictate.

One thing that we need to keep in consideration is modelling relevant structural and domain properties into the generative process. This is the exact reason we need Null baselines over empirical baselines - and also the issue with traditional random graphs. Network metrics mathematically are driven by raw counts and degrees. Any baseline must presever or control for these features to that the final interpretation isolates tactical intent rather than trivial statistics.

**Pass Count:** The easiest and maybe most important to account for is pass count. At its highest level, this accounts for fixing the total pass count during the simulation phase. Though at more grandular levels it could be fixed by area or position. 

If the real team has a highly centralized midfielder, we are comparing them to 1,000 fake matches where the team also made 542 total passes. Any spike in the real midfielder's centrality is now proven to be a structural choice, not just a byproduct of a high-passing game.

However, to build a truly robust, space-aware football null model, we can inject additional domain rules and constraints into the generative engine.

Out-Degree and In-Degree Constraints are important. In football, a goalkeeper or center-back naturally initiates more passes than a striker due to the phase of the game. If your null model lets a striker distribute as many passes as a midfielder, your centrality baselines will be skewed. 

Instead of just sampling from a blanket team matrix, you can enforce degree-preserving sampling. You can constrain the generative loop so that once the "Striker" node receives and distributes a maximum number of simulated passes matching their real-world quota (or a percentage of it), the model shifts the ball back down the pitch. This forces the synthetic matches to maintain realistic positional volume.

Additionally, a generative process born from real game data should be spatially aware but there is also the option to weight the transition probabilities using a spatial distance decay function. The laws of physics dictate that short passes have a much higher success rate than long passes. However, this parameter may also be tuned to represent the tendency of teams to short or long pass. 

When the simulation is at Player $A$ (at coordinate $x_1, y_1$), the probability of selecting Player $B$ (at $x_2, y_2$) is multiplied by a negative exponential function of the Euclidean distance between them: 

$$P(\text{pass}) \propto e^{-\gamma \cdot \text{distance}}$$

By introducing this spatial friction penalty ($\gamma$), the generative engine will naturally favor shorter, realistic passes, meaning the ball will organically circulate through defense, midfield, and attack, rather than randomly teleporting across the pitch.

Furthermore, it should be understoof that a unique set of null models should be generated for each piece of analysis, i.e. each game. A blanket "league-wide" or "general purpose" null model is a massive methodological trap. If you rely on a single generic distribution of 1,000 synthetic matches for an entire season or league, you completely undermine the purpose of a spatial-Markov null model.

In network science, a valid null model changes only the feature you are testing (in this case, tactical intention and complex organization) while freezing everything else as an invariant baseline.

Let's say Match A is a game where your team plays against a low block, completes 700 passes, and holds 70% possession.

Match B is against a high-pressing team where your team only manages 350 passes and operates strictly on the counter-attack.

If you test both matches against a league baseline that averages 450 passes per game, the math breaks down. Match A's real metrics will look artificially complex simply because the team passed the ball more, while Match B's metrics will look deceptively poor just because the total volume was lower. Your 1,000 synthetic matches must be constrained strictly to the exact pass count ($N$) of the match you are measuring to guarantee a fair test.

The underlying engine of your generative model is the spatial or positional transition matrix. Teams constantly alter their systems depending on the opponent:

In Game 1, they might play a 4-3-3 with a deep playmaking defensive midfielder.

In Game 2, they might shift to a 3-5-2 with two wide wing-backs and a double-pivot in midfield.

Because the physical coordinates and passing pathways of the players completely change between these games, the baseline "random" flow of the ball changes too. A 3-5-2 naturally creates different structural loops and spatial bottlenecks than a 4-3-3. To test if a team executed their 3-5-2 with deliberate tactical efficiency, your null model must simulate 1,000 games of players passing randomly within a 3-5-2 spatial footprint.

---

There are several options for training the generative model. Many markov process in the liturature will lean from a single match, or even a colleciton of a teams matches. 

I want to train my models on the entire season of data from every team to learn the "physics and culture" of the entire league.

It learns that, regardless of who is playing, passing from the Center Back to the Fullback is highly probable, whereas a vertical pass from a Center Back into the crowded center of the box is rare. 

This type of generative model can still have its specifc match constraints imposed on the synthetic generation, i.e. 500 passes. This way, the null distribtion resprests: 

"What does a completely generic, tactically neutral match in this league look like if it lasted for exactly 500 passes?"

By comparing a specific match or a single team's collection of matches against this League Null Baseline, you can make profound statements about a team's status in the football ecosystem:

Isolating Identity: If you plot a season's worth of matches for Manchester City against this baseline, you might find that their real network entropy is permanently sitting in the bottom 2% of the league's null distribution (meaning they are hyper-structured and predictable compared to the generic league).

Spotting Over-Performance: If a mid-table team suddenly plays a match where their spectral gap shoots into the top 1% of your universal baseline, you have statistical proof that they achieved a level of fluid ball circulation that completely breaks the standard "gravity" of the league. You can confidently state: "This was an extraordinary tactical performance, not just an ordinary game of football."

Because you are training on all teams, you cannot use player names as your nodes (since Messi doesn't play for Arsenal, etc.). Your transition matrix must use Positions (e.g., Node 1 = Left Back, Node 2 = Defensive Midfielder) or Pitch Zones (from Buldú's Pitch-Passing paradigm).

If you use Positions, your dataset will naturally aggregate the collective behavior of every Left Back in the league over a year, creating the ultimate generalized blueprint of how a "standard" football team functions spatially.

"Macroscopic Evaluation of Football Micro-Dynamics."

> This might open the scope for a new paradigm pitch-position. Although, this may actually be captured under one of the existing paradigms. 

The Limitation of Local Models: Match-specific null models only tell you if a team was organized relative to their own limitations that day. They cannot tell you if the team is playing at an elite league standard.

The Value of the Universal Null: By aggregating the entire league, your null model acts as a "control group" representing the baseline background noise of the sport. Any deviation from this baseline is an undeniable indicator of distinct tactical style or acute performance spikes.

> It feels quite ironic that the same methodology (markov/entropy) that was meant to improve upon and remove the need for traditional null models is that same tools that we will use to construct spatial constrained null models from which we can validate the findings of the new methodology and also simultaneous use the null models in the same way we would have used an appropriate null model 

Originally, researchers like Buldú, Narizuka, and Gama looked at traditional structural null models, saw how poorly they represented the physical restrictions of football, and said: "Let's discard external null models entirely and use Markov chains and Information Theory to measure the internal properties of a match directly."

But by doing that, they unintentionally built the perfect mathematical simulator. By treating an entire league's passing history as a stochastic (probabilistic) engine, you can flip that engine on its head. Instead of using it to analyze a match, you use it as a generative model to spawn thousands of realistic, alternative synthetic matches that perfectly mimic the structural "gravity" and spatial boundaries of real football.

you are using the generative Markov null models to validate the Markov metrics themselves.Without this generative baseline, an entropy rate of $2.4$ is just a floating mathematical abstraction. By using the Markov engine to simulate 1,000 baseline games, calculating the entropy rate of those games, and comparing your real match against it, you are using a Markov process to prove whether a Markov measurement is statistically significant. It is entirely self-referential, yet mathematically flawless.

The final twist is that by taking this route, you have inadvertently saved the traditional network metrics (like centralities) that the newer literature threatened to leave behind.

Traditional network scientists wanted to use configuration models to test centrality, but the "goalkeeper-teleporting-the-ball-to-the-winger" flaw ruined it. By passing your 1,000 generative Markov-simulated matches through a static aggregated lens, you suddenly produce a structural null model that finally works. You are using the dynamic tools to heal the structural tools.

The Conflict: Traditional structural null models failed sport analytics due to spatial ignorance. Dynamic entropy metrics tried to replace them but left us without an interpretive baseline.

The Resolution: Your framework takes the very mechanism of the dynamic metrics (Markov transition probabilities), scales it up to a league-wide macro-level, and transforms it into a generative baseline engine.

The Unified Field Theory: This single engine simultaneously creates a flawless benchmark for the new dynamic metrics and corrects the fatal spatial flaws of the traditional structural metrics.

