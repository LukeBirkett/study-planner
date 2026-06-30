# Linking network structures and stochastic flow properties: An exploratory Markov-spectral case study in professional football (Gama et al., 2026)

> Gama, J., Dias, G., Couceiro, M.S., Mendes, R., Mendes, R.S. and Vaz, V., 2026. Linking network structures and stochastic flow properties: An exploratory Markov-spectral case study in professional football. Proceedings of the Institution of Mechanical Engineers, Part P: Journal of Sports Engineering and Technology, p.17543371261448957.

---

#### Abstract
Authors highlight that traditional network approaches provide structual insights but failed to capture the probabilistic nature of possession. They propose a framework to work alongside network approachs that used a Markov-spectral model of ball circulation. Their aim is to moves beyond describing who is connected to quantifying how possession flows through the team network. As an outcome, they produce and create a number of new metrics and indices. 

They agree that Network Approach can be used to identify key players as hubs at the micro-level and understand team structure at the macro-level. 

They say their integrated framework allows researchers to profile a teams coordination through both structural configuration and stochastic flow properties

---

#### Null Model Limitation

This paper was read in full due to a critical entry in its 'Limitations' section: *"Future studies should also employ **null models and random network** comparisons to establish baselines for spectral gap, entropy rate, and other indices, enabling more robust interpretation of observed values"*. 

Given the authors only used a two-game sample, they conceeded that their observed variations in stochastic flow metrics 'cannot be statistically distinguished from random match-to-match variability'. They highlight that null models are required to separate deliberate tactical behavior from mathematical noise.

A random baseline would allow researchers to determine whether network variations 'reflect genuine tactical adaptations... or whether they represent normal stochastic fluctuations inherent to passing sequences in football'. A null model establishes the boundaries of that normal fluctuation, providing the exact justification needed to design generative null frameworks for football analytics."

---

#### Sample Size, Matrix Permutation (Null Model), Larger Dataset, Empirical Baseline

Gama et al. (2026) observed stochastic flow variation between games but lacked the statistical power ($n=2$) to prove significance. They acknowledged that a **larger dataset** is needed to run resampling methods (matrix permutation) to establish a baseline and therefore determine if observed variations reflect tactical adaptations or normal match-to-match noise.

Just to be clear, the way this works is you would use the large dataset to construct a robust generative process. Using this you would generate 1000s of networks and compute the properties we are interested in. This gives us a distribution/range of expected values from which an individual value can be compared against. 

This important to recognise that football networks naturally possesses a baseline structure just by being a game played on a field with 11 players (i.e. they share the same constraints), meaning metrics might look identical by chance. The goal is to extract the topological/constrained baseline to make meaningful inference on the tactical/performance aspect.

A **matrix permutation test** is an established null model methodology that works by shuffling the rows and columns of a team's passing matrix. In footballing terms, this would mean swapping players attributes and therefore links but retaining the macro-structures like total pass volume. This would create a a naive, topological null model which ignores footballs physical proximity contraints. Gama et al. admit their model ignores "spatial coordinates" meaning a blind shuffle like this would generates physically impossible long-distance interactions. A tactically valid baseline requires spatially constrained null models that weight random pass probabilities based on actual player distance.

Additionally, it might be easy to think that if we have a "large dataset" as the authors call for that we can just use the raw, empirical data appropriate baselines, i.e. league averages and distributions of given properties. However, if our goal to identify explicity tactical and performance/talent based findings, then the baselines need to be normalized to the specific constraints of the matches being analysed. 

For example, high passing patches need to be compare to other high passing matches otherwise the centrality metrics will natural be elevated. If compared to a league average, high pass matches will places teams and players in the upper percentiles. We don't need networks to tell us a team passes alot. However, we can use networks to expose and compare the tactical approaches and player talent within high passing teams. But if we use only the empirical data and filter it down we soon all foe to data sparsity, resulting in use comparing our matches to the same teams or even exact game. When we start combining this filtering appraoch with other granular constraints such as formations, even a large dataset becauses too sparse leading to statistical overfitting in analysis and comparisions. 

My idea is to solve this by leveraging season-wide data to build a conditioned generative null model framework. By learning passing distributions across an entire league, this process synthesizes thousands of customized, spatially-aware null networks. This high-volume baseline successfully isolates deliberate tactical execution from geometric byproducts without diluting the data.

---

#### Markovian and Orders

The "order" of a Markov chain defines the mathematical depth of a team's memory. Gama et al. (2026) acknowledge that their framework operates strictly as a “parsimonious first-order approximation of possession flow rather than as an empirically validated generative model of passing sequences”.  

**The 1st-Order Assumption:** Dictates that the next pass depends entirely on the player currently holding the ball. While computationally efficient for structural baselines, the authors caution this “may obscure temporal fluctuations and higher-order sequences that influence tactical decisions”.

**The Reality:** Real football consists of deliberate, conditional sequences (e.g., a midfielder's choice changes based on whether they received the ball from a center-back vs. a winger). To capture this sequential intent, the authors recommend that “future work should therefore test higher-order dependence and temporal non-stationarity using event-level ordered data”.

> NOTE: A higher-order approach is far more important for Dynamics on the Network research (modeling flow, diffusion, and tactical circulation, like Gama et al.) rather than Dynamics of the Network (where the goal is simply to generate or simulate the final structural topology).

Markovian processes naturally accommodate such probabilistic, time-evolving phenomena by modelling sequences of play as state transitions on a network [18]
- Norris JR. Markov chains. 2nd ed. Cambridge University Press, 1998.

While SNA describes who is connected and identifies structural hubs, [1,2,4] and Markov models have been applied either to network growth over time [16] or to state transitions between field zones, [17] no framework has yet systematically combined structural topology with **stochastic flow metrics** to quantify real-time tactical functionality on the player network itself, such as how quickly possession diffuses (Spectral Gap), how unpredictably it circulates (Entropy Rate), or how efficiently it reaches key players (Mean First-Passage Time)

By analysing the **transition probabilities of passes as a stochastic process**, we introduce a temporal dimension to the network analysis, enabling quantification of aspects like speed of ball circulation and distribution of possession that static metrics alone cannot capture.

The authors are using these methods specifically as a tool to model Dynamics On the Network but the underlying logical is identical to the methods to build, generate and grow networks. 

---

#### Purpose of Network Science Applied to Football 

Gama et al., (2026) (SR) highlight that Network Analysis "reveals how structural and functional coordination emerges from the patterns of interaction among players, providing metrics that may reflect team adaptability and strategic efficiency." 

SNA describes who is connected and identifies structural hubs, [1,2,4]

SNA offers a robust quantitative framework for modelling team sports by representing players as nodes and their interactions as edges within a complex network.

Previous research has demonstrated that cohesive network structures and well-chosen centrality metrics can illuminate performance outcomes. For example, teams with higher connectivity and balanced interaction patterns often achieve greater success. [30,35] [Pina, Ribero]

The authors highlight two "complementary families of metrics" within Network Science: Centrality measures and Entropy-based measures.

**Centrality measures** (Degree, Betweenness, Eigenvector, Closeness, and Stress) quantify structural role and involvement level, answering 
*"who participates most" and "who connects whom."* [4] [Clemente]. These reflect the volume and positional importance of contributions to the passing network.

**Entropy-based measures** (Node Transition Entropy and Network Transition Entropy) capture variability and unpredictability in passing choices, answering *"how diversely the ball is distributed" and "how difficult it is to anticipate the next pass."*

A player may have high degree centrality by repeatedly passing to the same teammate (low entropy, predictable), while another with moderate degree but high entropy distributes passes more evenly (unpredictable, harder to defend) (Gama et al., 2026)

---

#### Micro Metrics 

**(Micro)** Degree, Closeness, Betweenness, and Eigenvector centralities were prioritised as indicators of influence and mediation of information flow, consistent with previous football network studies. [1,2,4–6,30,35]

While some degree of conceptual overlap may exist among these metrics, [2,3,14,15] their combined presentation offers a multi-dimensional profile of individual involvement in the passing network.

---

#### Macro Metrics

**(Macro):** At the team level, Total Links, Network Density, Average Distance, Network Diameter, Network Heterogeneity, Global Centralisation, Global Prestige, Transitivity, Reciprocity, Assortativity Coefficient, and Network Transition Entropy were calculated to assess: overall team cohesion, interaction diversity, and tactical adaptability. 

Transitivity reflects the tendency to form passing "triangles" (three-player combinations) indicative of coordinated subgroups.

Global Centralisation and Global Prestige gauge how concentrated the playmaking is through particular individuals

Network Transition Entropy quantifies the unpredictability of the team’s overall passing pattern
---

#### Representation, Adjacency Matrix

"For each match, a directed weighted adjacency matrix A was constructed, where each entry represents the number of passes from one player to another."

"From this adjacency matrix, a row-stochastic transition matrix P was derived on the active subgraph (players with at least one outgoing pass), where each entry represents the probability that a player passes to a specific teammate. When the empirical transition matrix was not irreducible, a teleportation correction (a = 0.15) was applied to ensure irreducibility of the Markov chain."

The authors are converting the raw passing "counts" into a probability transition matrix ($P$). The properties are being modified using the rows they sit in, i.e. using linear algebra. The operation to achieve this is called row-normalization and it creates a row-stochastic matrix. Every row in the matrix will sum up to exactly $1.0$ (or 100%). In obtaining the Transition Matrix ($P$), linear algebra takes each row and divides every entry in that row by the row's total sum. Mathematically, this is expressed as multiplying the inverse of a diagonal degree matrix ($D^{-1}$) by the adjacency matrix ($A$): - $P = D^{-1}A$.

---

#### Football Interpretations of Network Properties

The authors put together an entire table that defines the properties, broken down into micro and macro, in football terms.

| Metric | Type | Definitions |
| :--- | :--- | :--- |
| **Degree centrality** | Micro | **Volume of direct involvement:** Quantifies how frequently a player acts as a passer, indicating workload in possession circulation and immediate availability as an outlet; high values suggest greater involvement in ball circulation. |
| **Closeness centrality** | Micro | **Distribution speed:** Assesses how quickly a player can reach (or be reached by) teammates; lower values suggest the ability to receive and distribute under time pressure; higher values may indicate peripheral positioning. |
| **Stress centrality** | Micro | **Transitional load:** Identifies players who bear the highest volume of passing traffic between sectors, indicating responsibility in maintaining possession during phase transitions; high values indicate a key role in connecting team sectors. |
| **Betweenness centrality** | Micro | **Connective mediation:** Identifies players who bridge different team sectors (defence-midfield-attack), enabling transitions and bypassing opposition pressure; high values indicate an essential role in team connectivity. |
| **Degree prestige** | Mirco | **Solicited player:** Identifies players who are most sought out by teammates during the game, as measured by the number of passes received; high values indicate they are trusted targets in possession. |
| **Eigenvector centrality** | Mirco | Eigenvector centrality |
| **PageRank centrality** | Micro | **Tactical reference:** Identifies players who receive passes due to their perceived importance; high values suggest teammates actively seek them out as reliable options. |
| **Clustering coefficient** | Mirco | **Local combination play:** Identifies players who favour quick passing exchanges in tight spaces; high values indicate participation in short, repetitive passing patterns. |
|  **Node transition entropy** | Mirco | **Individual passing variability:** Measures how evenly a player distributes passes among teammates. Distinction from centrality: A player may have high degree centrality (many passes) but low entropy (always passing to the same teammate— predictable), or moderate degree but high entropy (unpredictable distribution). Captures diversity of passing choices, not volume; high values indicate unpredictable passing distribution; low values suggest predictable patterns. (think this is their own conrtribution) |
|  |  |  |
| **Total links** | Macro | **Collective involvement:** Total number of connected player pairs; reflects overall team participation in possession and interaction diversity; higher values indicate greater collective involvement. |
| **Network density** | Macro |  **Interaction fluidity:** Proportion of possible connections realised; higher density suggests quick passing options and supported play; lower density may indicate spacing or structured attacking patterns. |
| **Average distance** | Macro |  **Structural proximity:** Average path length between players; shorter distances indicate tight positioning and quick exchange potential; longer distances may suggest spacing or width. |
| **Network diameter** | Macro |  Maximum reorganisation length: Longest shortest path between any two players; indicates how quickly the team can reorganise possession across extremes of the formation; smaller values suggest faster reorganisation capacity. |
| **Network heterogeneity** | Macro | **Interaction concentration:** Measures whether play is concentrated among a few players (high heterogeneity) or distributed more evenly (low heterogeneity). Distinction from centralisation: Heterogeneity reflects variance in involvement; centralisation reflects how much this variance is organised around specific individuals; high values indicate concentration around a few players; low values suggest balanced distribution |
| **Transitivity** | Macro | **Triangulation tendency:** Measures the proportion of triplet connections that form closed triangles; reflects capacity for quick passing combinations and small-group play; high values indicate strong smallgroup interaction capacity. |
| **Reciprocity** | Macro |  **Bidirectional exchange:** Shows balance in two-way passing between player pairs; high reciprocity suggests mutual trust and balanced distribution; low reciprocity indicates directed, progression-oriented play |
| **Global centralisation** | Macro | **Hub dependence:** Indicates whether the team relies on one or a few key players to conduct play; higher values suggest vulnerability if central players are marked out. |
| **Assortativity coefficient** | Macro | **Role-based connectivity:** Identifies whether players tend to connect with similar (positive) or different (negative) roles; negative values suggest functional integration across positional lines; positive values indicate within-role clustering |
| **Network transition entropy** | Macro | **Team-level passing unpredictability:** Global measure of how evenly passes are distributed across all possible connections. Distinction from density: Density measures how many connections exist; entropy measures how evenly those connections are used. A dense network can be predictable (low entropy) if passes concentrate on a few links; high values indicate greater unpredictability for the opposition |

> Tactical interpretations for SNA metrics are based on Refs. [1–6,24,25,30,34,35]

---


#### Network Analysis and Results

The networks that the authors constructed included all players that features in the game, including subs. 

Nodes in their PassMaps seem to be positioned by role rather than an average of interaciton positions, i.e. a left-back is always plotted in the same position. 

##### Micro Properties

The authors produces a figure for the centrality metrics which was broken down by metrics and then within the metrics by player.

Each metric was represented as a bar chart and within the visual the x-axis were the players. 

They were using the metrics to identify players with the highest involvement in ball build-up, circulation, and possession maintenance. 

Their visuals clearly shows that Player 3 (central defender), Player 23 (central midfielder), and Player 25 (left back) figured as central players within the passing network. This was because they spiked in the some of the metrics. 

> NOTE: the authors are comparing the metrics between two games. Something I could do is analyse two games as a way to introduce Network Science to football. However, a transition would need to be made to using the full season, first starting with empirical averages and baselines, then introducing and explaining the need for null model and random baselines.


