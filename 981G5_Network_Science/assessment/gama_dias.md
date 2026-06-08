**Related to mentions Null Models as further research:**

> "Future studies should also employ **null models and random network** comparisons to establish baselines for spectral gap, entropy rate, and other indices, enabling more robust interpretation of observed values"

> Expanding the analyses to underrepresented domains, such as women’s football or youth competitions, would also test the framework’s applicability across varying match contexts and address identified gaps in network analysis research.

---

### Abstract

SNA provides structural insights but often fails to capture the probabilistic nature of possession

This study introduces an integrated methodological framework that combines static SNA with a Markov-spectral model of ball circulation

moves beyond describing who is connected to quantifying how possession **flows through the team network** [DYNAMICS ON A NETWORK]

Use their framework to compute indices of passing uncertainty, diffusion speed, navigability, and network robustness. 

SNA identified key players as crucial hubs for ball circulation at the micro level, while indicating a cohesive team structure with adaptable macro-level properties

Markov-spectral quantification showed descriptive between-match variations, with the second match displaying higher Entropy (2.84 vs 2.77 bits/pass), suggestive of greater unpredictability, and a larger Spectral Gap (0.53 vs 0.45), indicative of faster potential diffusion of possession.

this integrated approach demonstrates the feasibility of profiling team coordination through both structural configuration and stochastic flow properties

Their Markov-spectral framework adds indivies related to assing variability, network navigability, and structural cohesion allowing for proof of concept on analysing collective performance.

---

### Introduction

Football > Networks > Nodes as players, Edges as interactions
- allows researchers to capture the emergent properties of collective behaviour and tactical organisation [2,3]
- identifying key players, team tactics, and patterns of ball circulation,[1,4–9]
- moving beyond reductionist analyses of isolated technical or tactical actions.

This perspective is aligned with a dynamic systems approach to
football, which views teams as complex, adaptive systems where performance emerges from the continuous interaction of players under multiple constraints. [10]
- [10] Araujo D, Hristovski R, Seifert L, et al. Ecological cognition: expert decision-making behaviour in sport. Int Rev Sport Exerc Psychol 2019; 12: 1–25. https://doi.org/10.1080/1750984X.2017.1349826

As highlighted by Gama et al., [2] network analysis also reveals how structural and functional coordination emerges from the patterns of interaction among players, providing metrics that may reflect team adaptability and strategic efficiency.

a methodological gap exists in quantifying the probabilistic nature of possession and its link to functional aspects of team play, such as the uncertainty inherent in passing sequences, network navigability, and systemic robustness. [11-13]

a recent systematic review of football performance analysis highlighted the need to integrate temporal aspects into network studies to fully understand team behaviour. [2,3,14,15]

---

### Prior Markov-chain modelling of Passes
"prior research has successfully established the Markov-chain model as a valid approximation for the **growth of passing networks over time** [16] and to model state transitions between field zones [17]"
- [16] Yamamoto, K. and Narizuka, T., 2018. Examination of Markov-chain approximation in football games based on time evolution of ball-passing networks. Physical Review E, 98(5), p.052314.

> CONVERSE WITH GEMINI TO UNDERSTAND IF [16] IS DYNMAICS OF A NETOWRK AND THEREFORE A NULL MODEL


- Liu T, Zhou C, Shuai X, et al. Influence of different playing styles among the top three teams on action zones in the World Cup in 2018 using a Markov state transition matrix. Front Psychol 2022; 13: 1038733. https://doi.org/ 10.3389/fpsyg.2022.1038733

Markovian processes naturally accommodate such probabilistic, time-evolving phenomena by modelling sequences of play as state transitions on a network [18]
- Norris JR. Markov chains. 2nd ed. Cambridge University Press, 1998.

### Authors Metrics that they are introducing
However, a relevant methodological gap persists: while SNA describes who is connected and identifies structural hubs, [1,2,4] and Markov models have been applied either to network growth over time [16] or to state transitions between field zones, [17] no framework has yet systematically combined structural topology with **stochastic flow metrics** to quantify real-time tactical functionality on the player network itself, such as how quickly possession diffuses (Spectral Gap), how unpredictably it circulates (Entropy Rate), or how efficiently it reaches key players (Mean First-Passage Time)

This integration gap limits the ability to move from descriptive structural analysis to explanatory profiling of tactical functionality and efficiency, a challenge recently outlined in the literature
- This is NOT the same issue that I am looking into but it is almost entirely related to the same route cause. 
- Markov Models/Zone Transiations look at the prob of the ball moving from Zone A to Zone B but tend to ignore player-to-player relationships
- If you want to use a metric like Mean First-Passage Time (MFPT) to see how efficiently a team gets the ball to Haaland, you run into the exact same trap we discussed earlier: Is Haaland's low MFPT a result of brilliant tactical design, or is it just because the midfielders pass a lot?

> "Recent literature highlights a critical methodological gap: the failure to integrate structural topology with stochastic flow metrics like Mean First-Passage Time or Entropy Rate to quantify tactical functionality [cite your snippet]. However, this paper argues that even if such stochastic metrics are applied, they remain purely descriptive without the context of a baseline. To truly move from 'descriptive profiling' to 'explanatory profiling,' these flow metrics must be evaluated against a Directed, Weighted Configuration Null Model to determine if a team's diffusive efficiency is a statistically significant tactical construct or a trivial byproduct of passing volume." -> Gemini

this study bridges this methodological gap by integrating static SNA with a dynamic Markov-spectral framework for flow properties to model ball circulation as a stochastic diffusion process on the player network.

While previous studies have applied Markov models to football passing networks, for example, to analyse network growth over time [16] or state transitions between field zones, [17] the present framework makes a distinct and novel contribution.

SNA offers a robust quantitative framework for modelling team sports by representing players as nodes and their interactions as edges within a complex network.

This methodology transcends traditional reductionist approaches that focus on isolated events, enabling the examination of emergent individual and collective behaviours, including identification of key influencers, preferred playing zones, tactical organisations, and patterns of collective behaviour.

~ end of authors goals/aims/gap in lit
---

## Network Section

### Centrality MEasures and Performance Outcomes
Previous research has demonstrated that cohesive network structures and well-chosen centrality metrics can illuminate performance outcomes. For example, teams with higher connectivity and balanced interaction patterns often achieve greater success. [30,35]
-  [30] Pina TJ, Paulo A and Arau´jo D. Network characteristics of successful performance in association football: a study on the UEFA Champions League. Front Psychol 2017; 8: 1173. https://doi.org/10.3389/fpsyg.2017.01173
- [35] Ribeiro J, Silva P, Duarte R, et al. Team sports performance analysed through the lens of social network theory: implications for research and practice. Sports Med 2017; 47(9): 1689–1696. https://doi.org/10.1007/ s40279-017-0695-1

---

### Centrality vs Entropy Measures with Network Sciecne (SNA)

Within SNA, two complementary families of metrics are distinguished


- **Centrality measures** (Degree, Betweenness, Eigenvector, Closeness, and Stress) quantify structural role and involvement level, answering 
    - *"who participates most" and "who connects whom."* [4]
    - [4] Clemente FM, Couceiro MS, Martins FML, et al. Using network metrics in soccer: a macro-analysis. J Hum Kinet
- These reflect the volume and positional importance of contributions to the passing network.


- **Entropy-based measures** (Node Transition Entropy and Network Transition Entropy) capture variability and unpredictability in passing choices, answering 
    - *"how diversely the ball is distributed" and "how difficult it is to anticipate the next pass."*
- A player may have high degree centrality by repeatedly passing to the same teammate (low entropy, predictable), while another with moderate degree but high entropy distributes passes more evenly (unpredictable, harder to defend).

"Both dimensions are necessary for a complete tactical profile"

---

### Micro Metrics

**(Micro)** Degree, Closeness, Betweenness, and Eigenvector centralities were prioritised as indicators of influence and mediation of information flow, consistent with previous football network studies.
-  indicators of influence and mediation of information flow, consistent with previous football network studies. [1,2,4–6,30,35]
- While some degree of conceptual overlap may exist among these metrics, [2,3,14,15] their combined presentation offers a multi-dimensional profile of individual involvement in the passing network.


>  [1] Duch J, Waitzman JS and Amaral LAN. Quantifying the performance of individual players in a team activity. PLoS ONE 2010; 5(6): e10937. https://doi.org/10.1371/journal.pone.0010937

> [2] = Gamas Systematic Review
> [3] = Alves Systematic Review
> [4] = Clemente (2017), [5] Clemente (2014), [6] Clemente (2015)

> [14] Caicedo Parada S, Lago Pen˜as C and Ortega Toro E. Passing networks and tactical action in football: a systematic review. Int J Environ Res Public Health 2020; 17(18): 6649. https://doi.org/10.3390/ijerph17186649

> [15]  Xu Y, Diaz-Cidoncha Garcia J, Sarmento H, et al. Application of social network analysis in football match analysis: a systematic review. Int J Sports Sci Coach 2025; 21(0): 548–568. https://doi.org/10.1177/17479541251377548

> [30] Pina, [35] Ribeiro

#### How Entropy Metrics Related to Dynamics OF and Null Models
**Node Transition Entropy** was included to capture variability in passing choices, complementing the centrality metrics. [24,25]
- Merges network science with information theory (Shannon entropy) and stochastic processes (Markov chains) to understand dynamic uncertainty.
- Trad net science tools map and analyse static structures
- Structural metrics such as egree Centrality, Betweenness Centrality
- Node Transition Entropy builds on these by looking at a random walk or a Markov chain running across the network's nodes.
- It is **DYNAMICS ON A NETWORK**
- Transiational players during a match
- The sturcture/topology of a network determines the constraints on what can take place. 
- If a node has 3 connected edges, the entropy is a measure of how evenly the flow splits among those fixed choices.
- It is used to understand diffusion, routing efficiency, and spreading phenomena
- can assess how a passing sequence moves between soccer players but nodes/network structure doesn't change. 

> Node Transition Entropy is a measure of dynamics on a network but it is often used as a diagnostic tool to study the dynamics of a network. The dynamics on a network, i.e. the passes and relantioships between players, are the building blocks of the eventual structural topology of the network (the dynamics of the network)

> While building a null model to understand how that map grows and forms is a "Dynamics of a network" task, the vehicle that builds it is a series of passes—which is a "Dynamics on a network" process.

> Node Transition Entropy (Dynamics on) is relevant to network formation (Dynamics of) due to how a PassMap is generated

> Because the network’s final topology is literally just an aggregated history of the transitions, information theory tools like Node Transition Entropy tell us about the rules of the transition choices.

---

### Macro Metrics

**(Macro):** At the team level, Total Links, Network Density, Average Distance, Network Diameter, Network Heterogeneity, Global Centralisation, Global Prestige, Transitivity, Reciprocity, Assortativity Coefficient, and Network Transition Entropy were calculated to assess:
- overall team cohesion, interaction diversity, and tactical adaptability.

These metrics capture complementary aspects of collective behaviour: for example, Transitivity reflects the tendency to form passing "triangles" (three-player combinations) indicative of coordinated subgroups

Global Centralisation and Global Prestige gauge how concentrated the playmaking is through particular individuals

Network Transition Entropy quantifies the unpredictability of the team’s overall passing pattern

---

### Contribution of Authors (SNA: Trad + Ent)
This combination of metrics allows a multi-layered understanding of collective coordination and tactical functionality, linking structural positions within the network to functional and tactical aspects of coordinated performance. By including both traditional network indices and entropy-based measures, our SNA approach captures not only who the key players are.

---

## Markov Section
This is the end of the network section where network properties are explained (**not results**)

Labelled "Markov-spectral modelling of passing networks" 

This section augments the SNA layer with a Markov- spectral model of ball circulation.

Passing interactions are represented as a finite-state, time-homogeneous Markov chain on the active player set, providing compact indices of passing variability, diffusion speed, navigability, and structural robustness.

> Just to re-iterate, this is NOT relevant for the network project

By analysing the **transition probabilities of passes as a stochastic process**, we introduce a temporal dimension to the network analysis, enabling quantification of aspects like speed of ball circulation and distribution of possession that static metrics alone cannot capture.

> "transition probabilities of passes as a stochastic process" the author is using this as a tool of for modelling the **dynamics on the network** but similar and maybe even identical methods can be used to build the network and generate the network itself (**dynamics of the network**)

For each match, a directed weighted adjacency matrix A was constructed, where each entry represents the number of passes from one player to another.

> This is literally just a PassMap but highlights that such as network can be represented as an 'adjacency matrix'

For each match, a directed weighted adjacency matrix A was constructed, where each entry represents the number of passes from one player to another. From this adjacency matrix, a row-stochastic transition matrix P was derived on the active subgraph (players with at least one outgoing pass), where each entry represents the probability that a player passes to a specific teammate. When the empirical transition matrix was not irreducible, a teleportation correction (a = 0.15) was applied to ensure irreducibility of the Markov chain.
- converting the raw passing "count" matrix into a probability transition matrix ($P$)
- they are modifying the properites of the matrix itself using its own rows
- i.e. they are using linear algebra 
- turn raw counts into probabilities by performing an operation called row-normalization to create a row-stochastic matrix
- every row in the matrix will sum up to exactly $1.0$ (or 100%)
- to get the Transition Matrix ($P$), linear algebra takes each row and divides every entry in that row by the row's total sum
- Mathematically, this is expressed as multiplying the inverse of a diagonal degree matrix ($D^{-1}$) by the adjacency matrix ($A$):
- $$P = D^{-1}A$$
- What if the Matrix is "Irreducible"?
    - In a real football match, passing networks often have "dead ends."
    - Imagine if Player 1 and Player 2 only pass to each other, and once Player 3 gets the ball, they only pass to Player 2. The ball gets trapped in a cycle between 1 and 2, and it can never get back to Player 3.
    - Mathematically, this means the matrix is reducible (or not ergodic).
    - If you run a **random walk** simulation on this, the math breaks down because the ball gets permanently stuck in a subset of the network. It means you cannot calculate a single, stable steady-state distribution for the whole team.
    - To fix this mathematical dead-end, they borrow the exact logic Google uses for its PageRank algorithm. They apply a teleportation correction.
    - The Solution: The "Teleportation Correction" ($\alpha = 0.15$)
    - They alter the probabilities so that $85\%$ of the time ($1 - \alpha$), the ball moves normally based on the real match data. But $15\%$ of the time ($\alpha = 0.15$), the ball has a tiny chance to "teleport" randomly to any player on the pitch, breaking it out of any mathematical traps.
    - $$P_{corrected} = (1 - \alpha)P + \alpha \frac{1}{N}J$$
    - By blending a tiny bit of uniform randomness ($J$) into the real transition matrix ($P$), they guarantee that every player can theoretically reach every other player. The matrix is now irreducible, meaning the Markov chain is completely stable, allowing them to calculate all those advanced spectral and flow metrics safely.
    - This value follows the standard parameter used in PageRank-based Markov processes, ensuring ergodicity while minimally perturbing the observed transition structure. [37–39]


> The "Teleportation Correction" could be a really interesting way to test a somewhat naive way to modelling footballs stocasticness. Adapting Gama et al. (2026) as a Tactical Decay" Parameter $P_{Null} = (1 - \alpha)P_{Season} + \alpha P_{Random}$, a=0 perfectly copies baseline, a=1 network is complletely random

> It unclear yet is this can be used inconjuction with the The Spatial "Gravity" Null Model, or as an alterntive. 

> In building a null model, rhe goal is to preserve certain properties of the real system (constraints) while randomizing others (tactical intent). A spatial model defines where players are likely to pass based on pitch geography, while the teleportation dictates how much tactical history vs. pure randomness influences that choice.

> $$P_{Null} = (1 - \alpha)P_{Season} + \alpha P_{Spatial}$$

> They can be used together

- $P_{Season}$: Your team's actual passing probability matrix calculated across the entire season. This preserves their core structural tendencies, positions, and player roles.
- $P_{Spatial}$: A matrix where the probability of a pass between two players is calculated strictly by the physical distance between their average season coordinates, using the gravity model ($P(i \rightarrow j) \propto 1/d_{ij}^\gamma$). This acts as the "physics engine" of your randomness.
- $\alpha$ (Alpha): Your tunable parameter that acts as a slider between Historical Strategy ($\alpha = 0$) and Pure Physical Constraint ($\alpha = 1$).

The latter needs to be tuned which could be an interest experiement for the report

> "In sports analytics, an effective null model must balance topological constraints with stochastic freedom. Because football is inherently a game of high stochasticity, a valid generative framework must prevent overfitting to historical passing configurations. By implementing a tunable parameter $\alpha$, similar to the teleportation correction found in Markov-spectral literature, we can systematically inject controlled noise into season-wide baseline matrices, thereby simulating a 'tactically uncoordinated' but structurally viable version of the team's possession flow."

IMPORTANT: this whole process brings up something in the null process that I hadn't considered. I had only thought about reproducing a method to generate an underlying pass map of individual pass. Perhaps this is unrealistic because passes happen in chains, not as isolate event. Thus trying to re-model an entire game might need be done in chains. This may be more feasible given the amount of data I have. 

This consdiers to topics of First-Order Markov Networks to Higher-Order Networks (HONs).

It is not nessecary to model on high orders, however, it is important to address this in any implementation. and even experiementing with pushing more orders in an option. 

a standard PassMap is a static, weighted adjacency matrix and therefore individual generates passes are fine. a standard PassMap is a First-Order representation. It only cares about the direct connection between Player A and Player B. It completely washes away memory.

metrics like Degree Centrality, Clustering Coefficients, or PageRank on a standard PassMap, the math itself treats the network as a collection of aggregated, isolated events.

Therefore, a null model that shuffles or generates isolated passes (like the Directed Weighted Configuration Model or your Spatial Gravity Model) is a perfectly valid baseline.

If you only generate isolated passes, your null model assumes that football has no memory. In probability theory, this is a strict first-order Markov assumption: where the ball goes next depends only on who currently has it, not on who passed it to them.

**Aproach options:**
- generate isolated passes using Spatial-Markovian model. In limitation critique this. explain sufficent due to static and metric but acknowledge that it fails to capture higher-order sequential dependencies (temporal non-stationarity).
- move from isolated to chains. but instead of generating chains, re-wire. keep the chains but shuffle the players based on spatial probabilities. generate synthetic data that preserves the "flow and length" of real football possession without having to model complex team tactics
- The Higher-Order Network (HON) Model (Advanced). Probably too advanced. 

The author then goes onto explain some of the metrics (indices) produced from this matrix but I have not taken notes of them. 

---

## Integrated analytical framework: Metric summary and conceptual distinctions

"Table 1 summarises the tactical interpretations of all SNA and Markov-spectral metrics used in this study along with their status (primary vs exploratory) in relation to the research hypotheses"

All SNA metrics are considered primary, forming the established framework for analysing football passing networks

Markov-spectral metrics are exploratory, representing the novel contribution of this study.

In the SNA layer, Node Transition Entropy characterises the variability of an individual player’s pass distribution within the uPATO framework, whereas in the Markov-spectral layer the entropy rate quantifies possession-weighted uncertainty of the stochastic process on the active player network.

Accordingly, the former is a player-level distributional descriptor, while the latter is a process-level flow descriptor



| Metric | Type | Definitions |
| :--- | :--- | :--- |
| Degree centrality | Micro | Volume of direct involvement: Quantifies how frequently a player acts as a passer, indicating workload in possession circulation and immediate availability as an outlet; high values suggest greater involvement in ball circulation. |
| Closeness centrality | Micro | Distribution speed: Assesses how quickly a player can reach (or be reached by) teammates; lower values suggest the ability to receive and distribute under time pressure; higher values may indicate peripheral positioning. |
| Stress centrality | Micro | Transitional load: Identifies players who bear the highest volume of passing traffic between sectors, indicating responsibility in maintaining possession during phase transitions; high values indicate a key role in connecting team sectors. |
| Betweenness centrality | Micro | Connective mediation: Identifies players who bridge different team sectors (defence-midfield-attack), enabling transitions and bypassing opposition pressure; high values indicate an essential role in team connectivity. |
| Degree prestige | Mirco | Solicited player: Identifies players who are most sought out by teammates during the game, as measured by the number of passes received; high values indicate they are trusted targets in possession. |
| Eigenvector centrality | Mirco | Eigenvector centrality |
| PageRank centrality | Micro | Tactical reference: Identifies players who receive passes due to their perceived importance; high values suggest teammates actively seek them out as reliable options. |
| Clustering coefficient | Mirco | Local combination play: Identifies players who favour quick passing exchanges in tight spaces; high values indicate participation in short, repetitive passing patterns. |
|  Node transition entropy | Mirco | Individual passing variability: Measures how evenly a player distributes passes among teammates. Distinction from centrality: A player may have high degree centrality (many passes) but low entropy (always passing to the same teammate—
predictable), or moderate degree but high entropy (unpredictable distribution). Captures diversity of passing choices, not volume; high values indicate unpredictable passing distribution; low values suggest predictable patterns. (think this is their own conrtribution) |
| - | - | - |
| Total links | Marco | Collective involvement: Total number of connected player pairs; reflects overall team participation in possession and interaction diversity; higher values indicate greater collective involvement. |
| Network density | Marco |  Interaction fluidity: Proportion of possible connections realised; higher density suggests quick passing options and supported play; lower density may indicate spacing or structured attacking patterns. |
| Average distance | Macro |  Structural proximity: Average path length between players; shorter distances indicate tight positioning and quick exchange potential; longer distances may suggest spacing or width. |
|  Network diameter | Macro |  Maximum reorganisation length: Longest shortest path between any two players; indicates how quickly the team can reorganise possession across extremes of the formation; smaller values suggest faster reorganisation capacity. |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |








----

### (IMPORTANT) How this paper links to mine:

- without a null model baseline, they cannot prove that their advanced tactical interpretations are actually true.
- they show that in Match 2, the team’s Entropy Rate (unpredictability) and Spectral Gap (ball circulation speed) increased.
- they make a tactical inference: Portugal played a more fluid, adaptive, and unpredictable style in the final compared to the semi-final.
- because they lack a baseline, their interpretation isn't scientifically robust
- observed changes might just be normal stochastic fluctuations (i.e., the natural noise of a football bouncing around a pitch) rather than a deliberate tactical adaptation
- Because passing networks inherently possess an underlying structure (e.g., midfielders naturally pass more than strikers), the metrics will always shift slightly from game to game by pure chance.
- "We need a randomized baseline so we can calculate a Z-score. If the real game's Entropy Rate is significantly higher than 1,000 randomized versions of that same game, only then do we have a robust interpretation that the unpredictability was a deliberate tactical blueprint, not just a random fluke".
- You want to use network properties to infer a team's tactical style—whether they are a possession-heavy team, a direct counter-attacking unit, or a highly centralized system built around a single playmaker.
- authors are doing the exact same thing, just using "stochastic flow" metrics instead of classical static metrics
- The Mathematical Baseline (Null Model) Prove: 
    - (Spectral Gap) Does the speed of ball diffusion exceed a random re-shuffling of passes? 
    - (Mean First-Passage Time (MFPT)) Is the number of passes required to reach the striker shorter/longer than a volume-based random baseline?
- Gama et al. (2026) are trying to decode tactical functionality and efficiency—they are just using advanced tools to do it.
- frame myt resaerch as the direct answer to their call for future research
- state that whether you use classical metrics (like Clustering and Centrality) or their Markovian flow metrics (like Entropy and Spectral Gaps) , no network property can be safely mapped to a tactical approach without a null model baseline to filter out the random noise of the game.

The purpose of their paper was to demonstate things like this but the null applications remain the same and just as useful as the purpose of a validating baseline
> By putting the standard results right next to the Markov-spectral results, they could make claims like: Look, if you only use standard network density, Match 1 and Match 2 look completely identical (~0.115). But look at our new metric, the Spectral Gap—it shows that the ball actually circulated much faster in Match 2 (0.530 vs 0.454).

NOTE: the structure and composition of this paper is also particularly relevant. They scope down into and give a definition/translation of each network metric into football teams. They also comprehensively use these metrics to analyse the data and have a whole Network Results section. Their paper goes onto to supplement these finding with their entrophy approaches. They mention at the end that actually null models are needed to validate the findings. My approaches would employ near enough the same research, however, instead of the entropy supplementary route, my work would flow into creating a null model. 

---

Given this research finding, I also need ot read thier systematic review:
> [2] Gama, J., Dias, G., Pereira, M., Mendes, R., Mendes, R.S., Sarmento, H. and Vaz, V., 2026. Network analysis to understand variability and patterns of individual and collective behaviour in professional football: a systematic review. International Journal of Performance Analysis in Sport, pp.1-62.

Note, G Dias is also in Alve review

> Gama, J., Dias, G., Couceiro, M.S., Mendes, R., Mendes, R.S. and Vaz, V., 2026. Linking network structures and stochastic flow properties: An exploratory Markov-spectral case study in professional football. Proceedings of the Institution of Mechanical Engineers, Part P: Journal of Sports Engineering and Technology, p.17543371261448957.

===