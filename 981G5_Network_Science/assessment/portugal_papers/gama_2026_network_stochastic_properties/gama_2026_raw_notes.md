# Linking network structures and stochastic flow properties: An exploratory Markov-spectral case study in professional football (Gama et al., 2026)

> Gama, J., Dias, G., Couceiro, M.S., Mendes, R., Mendes, R.S. and Vaz, V., 2026. Linking network structures and stochastic flow properties: An exploratory Markov-spectral case study in professional football. Proceedings of the Institution of Mechanical Engineers, Part P: Journal of Sports Engineering and Technology, p.17543371261448957.

---

## Paper Notes

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






#### A detour chain of throught about teleportation

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





---

## Integrated analytical framework: Metric summary and conceptual distinctions

"Table 1 summarises the tactical interpretations of all SNA and Markov-spectral metrics used in this study along with their status (primary vs exploratory) in relation to the research hypotheses"

All SNA metrics are considered primary, forming the established framework for analysing football passing networks

Markov-spectral metrics are exploratory, representing the novel contribution of this study.

In the SNA layer, Node Transition Entropy characterises the variability of an individual player’s pass distribution within the uPATO framework, whereas in the Markov-spectral layer the entropy rate quantifies possession-weighted uncertainty of the stochastic process on the active player network.

Accordingly, the former is a player-level distributional descriptor, while the latter is a process-level flow descriptor



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

---

> Distinguishing centrality from entropy: Centrality metrics (Degree, Betweenness, and Eigenvector) quantify how much a player participates (volume of involvement). Entropy-based metrics (Node Transition Entropy and Entropy Rate) quantify how variably they participate (diversity of passing choices). A player can have high centrality but low entropy (predictable hub) or moderate centrality but high entropy (unpredictable distributor). Both dimensions matter for tactical profiling

Tactical interpretations for SNA metrics are based on Refs. [1–6,24,25,30,34,35]

---

## Results for Networks

The following sections present the results in detail, including: (i) match networks and tactical organisation, (ii) descriptive SNA comprising micro-level analysis of individual player performance and macro-level network metrics capturing collective team behaviour

### Networks and tactical organisation
Demonstates a PassMap the Portuguese National Football Team inthe semi-final and final of the 2025 Nations League

The nodes includes all players that featured, even subs. 

Nodes in this PassMap seem to be position by role rather than an average of interaciton positions. 

The author go onto describe the game based on the PassMap, i.e. "In Match 1, the team prioritised midfield control and rapid transitions both down the wings and through the centre, employing a 1-4-2-1-3 formation:"

There includes a paragraph of interaciton breakdowns by player: "Player 3 (central defender) recorded the highest number of interactions, with 90 passes (50 made and 40 received)" 

### Descriptive social network analysis results

#### Micro Analysis

Figure 3 presents the micro-level analysis of individual player performance using centrality metrics, identifying players with the highest involvement in ball build-up, circulation, and possession maintenance. 

These figures were entirely bar graphs whereby each entry on the x-axis was a player. 

"In both matches, the data suggested that Player 3 (central defender), Player 23 (central midfielder), and Player 25 (left back) figured as central players within the passing network.

> NOTE, I had not really consdiered scoping into a single game as I was thinking on a aggregate season basis. However, this could be a really good way to example how networks can be applied to football. But also it creates an easy transition into the null model and analysis sections. I could find a game that appears to have a standout property for a given player and/or a property that appears to be unusual for a player given their position, i.e. a hub on the winger. To understand if these things are unique we need a null model baseline. 

> Although I am not actually conviced it is the best approach for the Null Model demonstrations itself. The null model will likely be built from a generative process with uses the underlying seasons wide distributions. Additionally, there will be a talking point as to why simple league baselines are not enough, i.e. they do not normalize for conditions and properties, for example pass, if they try to filter the empirical baseline then we fall foe to data sparsity. 

> That being said, a good transistion might be to start single matchs (2), try to use empirical baselines and then introduce null models. this allows me to demonstrate that I understand why we need null models. 

Degree, Closeness, Betweenness, and Eigenvector Centralities consistently positioned Player 3 (central defender) at the core of interactions. 
- Here, Betweeness is a particularly interesting property because it contains much less spikes then degree, Closeness or Eigenvector which are all pretty populated. There are just a handful of players that exhibit these spikes. Moreever, they tend to be consistent with their contibution in Betweeness over both matches. 

Eccentricity, Degree Prestige, Proximity Prestige, PageRank, Power, and Centroid Centralities further reinforced the prominence of these three players as structural hubs

Stress and Subgraph Centralities further indicated that these players participated in alternative pathways and local network structures.

**Clustering Coefficient** values suggested interactions on the wide areas, with wingers and full-backs providing lateral support

#### Macro Analysis

Figure 4 illustrates collective team performance, as captured by metrics such as Total Links, Network Density, Average Distance, Network Diameter, Network Heterogeneity, Global Centralisation, Global Prestige, Transitivity, Reciprocity, Assortativity Coefficient, and Network Transition Entropy.

Again these were all Bar Graphs but instead of players present team based metrics for each match and also a combined bar for Match 1 + Match 2

The analysis of collective performance revealed consistent patterns of interaction among players, alongside some variations between matches.

The total number of connections (Total Links) increased from 373 in Match 1 to 414 in Match 2, yielding 787 interactions overall.

Network Density remained relatively stable (0.111 in Match 1; 0.109 in Match 2; total= 0.115).

Network Diameter increased from 22.167 to 23.750 (total= 25.333).

Network Heterogeneity rose from 0.598 to 0.725 (total= 0.737).

Transitivity decreased from 6.303 to 5.094 (total= 5.783). Reciprocity increased slightly from 0.649 to 0.662 (total= 0.727). Global Centralisation increased from 0.145 to 0.231 (total= 0.200). Global Prestige remained relatively stable (0.134–0.145; total= 0.140).

The Assortativity Coefficient was negative in both matches (20.046 and 20.136; total=20.132). Moreover, Network Transition Entropy increased from 3.894 to 3.989 (total= 4.157).

> Instead of examining the network metrics between two matches, could deepdive into 1 (or more), explain the properties and how they translate into football, and then compare them to an aggreate of the whole league/seasons, including sumamry stats, i.e. min, max, average. 






---

## Markov-spectral results
A direct comparison between the insights from traditional SNA and those from the Markov-spectral layer illustrates their complementary value.

While SNA successfully identified the stable structural hubs (players 3, 3, and 25) and described macro-level cohesion (e.g. stable network density), the Markov-spectral indices quantified aspects of ball circulation that were not captured by structural metrics alone.

Together, these observations suggest that the Markovspectral framework captures stochastic flow properties of possession that complement the structural insights provided by SNA.






---

## Discussion

This study employed a multi-method approach, integrating SNA with Markov-spectral techniques, to characterise the structural and stochastic flow properties of the Portuguese National Team’s passing networks during the 2025 Nations League finals

The SNA results underscore the role of a central defender (player 3) as the main network hub, exhibiting high Degree, Betweenness, Eigenvector, and Stress Centrality, consistent with previous studies indicating that defenders can function as critical ‘‘hubs’’ during build-up phases in possession-oriented teams. [1,2] 

This observation aligns with findings that football passing networks often exhibit scale-free properties with emergent key players acting as hubs. [50]
- Yamamoto Y and Yokoyama K. Common and unique network dynamics in football games. PLoS ONE 2011; 6(12): e29638.

The presence of multiple key players (player 3, player 23, and player 25) reflects the concept of system redundancy, [2,52] a hallmark of adaptive complex systems where functionality may be maintained even if a key player’s influence is reduced. 

Such redundancy could potentially enhance the team’s robustness, as alternative playmakers might assume control if one hub is neutralised.

Collectively, these structural findings are consistent with our first hypothesis (H1), indicating that SNA can identify stable structural hubs. 

---

At the macro level, collective performance metrics indicate a balance between structural stability and observed variations.

Network Density remained relatively stable (;0.115) across matches, consistent with cohesion despite tactical variations.

However, increases in Network Heterogeneity and Global Centralisation from Match 1 to Match 2 indicate a growing concentration of interactions around key players, which may reflect enhanced offensive orchestration while potentially signalling vulnerability if central nodes are neutralised, an insight relevant for opposition scouting and tactical preparation.

Additionally, the negative Assortativity Coefficient is consistent with players tending to connect with teammates of differing characteristics, which may promote functional diversity and integration within the network, analogous to the interaction of specialised modules in complex adaptive systems. [1,4,52]

Formation adjustments from 4-2-1-3 to 4-1-2-3 shifted playmaking responsibility, as evidenced by the increased involvement of Player 23 in Match 2, illustrating the **context-dependent nature of centrality** and the adaptive redistribution of influence across the team. [7,8,53]
- > Good references for the importants of context-dependant null models vs baselines

While prior research has successfully established the Markov-chain model as a valid approximation for the growth of passing networks over time, [16] the present findings suggest that this framework’s potential extends far beyond descriptive network evolution.

> No, strictly speaking, neither of these are "Null Model papers." They are empirical modeling papers. However, your intuition is completely correct: they have built the exact mathematical architecture required to create a dynamic null model.
> 
> Both Gama et al. and Yamamoto & Narizuka use Markov chains to model the actual behavior of the football teams. They take real match data to calculate the transition probabilities (e.g., the likelihood of the ball going from Player A to Player B). They proved that if you run a Markov chain using these empirical probabilities, it accurately approximates how the team's passing network grows over time.
> 
> A true null model requires purposefully destroying specific empirical correlations to create a "baseline of randomness." To make a null model, you do not want to replicate the team's actual play; you want to see what the network would look like if the players were passing based purely on chance (or constrained only by basic rules, like spatial distance or degree sequence), stripping away tactical intent.
> 
> understanding the "growth mechanism" is a strategy for constructing a null model. You are effectively noticing that a Markov chain is the perfect engine for a dynamic null model. Gama et al. are saying they lack a baseline for their spectral gaps and entropy rates. But, as you noticed, because Yamamoto & Narizuka proved Markov chains simulate network growth well, you could easily adapt their method to build exactly what Gama et al. are asking for.
> 1. Take the Markov chain engine validated by Yamamoto & Narizuka.
> 2. Instead of feeding it the actual passing probabilities of the team, feed it a null transition matrix (e.g., every player has an equal 1/10 chance of passing to any outfield teammate, or probabilities are weighted strictly by the physical distance between players rather than tactical preference).
> 3. Run the model to grow a "null network."
> 4. Compare the spectral gap of the empirical network against this null network.
> 
> These papers are generative modeling papers. They model what is actually happening, whereas a null model paper models what would happen by chance. However, your critique is entirely valid: by establishing the Markov chain as the correct method for simulating network growth, they have handed the field the exact blueprint needed to generate robust, dynamic null models.

Complementing these structural insights, the Markov-spectral layer frames passing as a stochastic diffusion process on the active player set, yielding interpretable quantities that complement classical SNA.

This integrated perspective, which models passing as a stochastic process directly on the player network, aligns with, and substantially extends, recent approaches using Markovian models to unravel patterns in football passing sequences. [11]

---

> *Yamamoto & Narizuka (Descriptive): Their primary research goal was to answer a fundamental mathematical question: Is a Markov chain a valid way to represent a football passing network? They examined the time evolution of the networks to prove that the Markovian approximation closely matches real-world network growth. In scientific terms, this is a "descriptive" or "validating" study. They described the mechanism and proved the math fits the reality.* Their output is focused on the topology and growth of the network. They look at how nodes (players) and edges (passes) accumulate over time and whether the Markov model accurately predicts that accumulation.
> 
> *Gama et al. (Analytical): Gama and colleagues take Yamamoto’s conclusion as a starting point. Since Yamamoto proved the Markov model works, Gama et al. ask: What can the mathematical properties of this Markov model tell us about how a team actually plays? They dive into "spectral properties" (like the spectral gap) and "information theory" (like entropy rate) to analyze tactical flexibility, ball circulation speed, and unpredictability.* Their output is focused on the stochastic flow. They use the transition matrix (the probabilities of passes between specific players) to calculate abstract metrics. For example, they use the spectral gap (derived from the eigenvalues of the matrix) to measure how quickly a team can diffuse the ball across the pitch, and entropy to measure how unpredictable their passing sequences are to an opponent.

> This is exactly why Gama et al. (2026) noted that a null model is a limitation of their own paper. Gama et al. took the validated engine from Yamamoto & Narizuka and used it to calculate complex metrics (like entropy and spectral gaps). But Gama et al. realized: "We have these numbers, but we don't know what a 'normal' or 'random' number looks like." To fix that, future researchers will need to take that exact same Markov engine, apply the Null Model workflow (shuffling the data), and create the random baseline.

---

A critical contribution of this study is the demonstration of Markov-spectral metrics revealing what static SNA cannot.

While SNA successfully identified stable structural hubs and described macro-level cohesion, these metrics are inherently static, describing the aggregate pattern of who connected to whom, but not how possession flowed through time.

The Markovspectral layer addresses distinct functional questions that SNA alone cannot answer. 

First, flow dynamics: the Spectral Gap quantifies the speed of possession diffusion through the network, a property invisible to static SNA. 

Second, navigability and build-up patience: Kemeny’s Constant and MFPT reveal how efficiently possession reaches teammates and attacking targets, complementing centrality measures that only identify who is involved

Fourth, robustness and resilience: Algebraic Connectivity and von Neumann Entropy quantify structural cohesion and topological complexity, properties related to the team’s ability to maintain organisation under pressure. These dimensions are conceptually orthogonal to structural metrics and together provide a multi-layered functional profile of team behaviour that static analysis alone cannot achieve, capturing the stochastic flow properties of possession.

Analysis of the Stationary Distribution (p) confirmed that the left-back (player 25) and central midfielder (player 23) served as primary possession hubs, **corroborating SNA findings** and underscoring their crucial playmaking roles within the team’s tactical framework.
- SNA also found this player to be a hub
- In network science, when two completely different mathematical methods yield the same practical result, scientists say the findings are corroborated.
- Degree Centrality (how many total passes a player gave or received) or Betweenness Centrality (how often a player acts as a bridge between other players)
- Gama et al.’s new method didn't just count the final totals. They built a Markov transition matrix and calculated the Stationary Distribution ($\pi$).
- **In a Markov chain, if you let the ball circulate through the team's probabilistic passing network infinitely over time, the stationary distribution tells you the exact percentage of time the ball will spend with each player in the long run.**
- The math showed that if the ball kept moving indefinitely according to the team's passing habits, it would naturally pool and spend the most time at the feet of players 25 and 23.

The integration of p with MFPT provides a functional perspective on player contributions, quantifying both their centrality and the expected number of interactions required to advance the ball to key nodes. Specifically, the analysis revealed that reaching the centre-forward (player 7) required an average of 15.6 passes in Match 1, increasing to [22,2] passes in Match 2. This approach extends the evaluation of offensive progression beyond conventional metrics, [4–6,52] offering a perspective of possession efficiency and observed differences between matches.

Thus, this integrated analysis illustrates that elite football passing networks can be comprehensively characterised through the combination of structural (SNA) and stochastic flow perspectives (Markov-spectral).

The framework successfully captured both invariant hub structures and match-specific flow properties, offering a multi-layered profile of team behaviour. These findings support the utility of combining these methodological approaches for performance analysis in context, providing practitioners with insights into both organisational stability and functional dynamics.

---

## Limitations

the study focusses on a single team across only two matches of a specific tournament, which inherently limits the generalisability of the findings and prevents the detection of consistent patterns that might emerge over a larger sequence of matches.
- > I seem to recall Penn (the statsbomb recreate paper) saying a sample of 2 of often enough (for their domain) and referenced another paper that used 2

As an exploratory proof-of-concept, the sample size is appropriate for demonstrating feasibility, but statistical power is insufficient for inferential testing [41]
- Shannon CE. A mathematical theory of communication. Bell Syst Tech J 1948; 27(3): 379–423. https://doi.org/ 10.1002/j.1538-7305.1948.tb01338.x

Critically, with only two matches analysed, it is not possible to determine whether the observed variations between matches reflect genuine tactical adaptations by the team in response to different opponents and match contexts, or whether they represent normal stochastic fluctuations inherent to passing sequences in football

The observed differences in Entropy Rate, Spectral Gap, and other indices, while descriptively interesting, cannot be statistically distinguished from random match-to-match variability. This fundamental ambiguity underscores the exploratory nature of this study and highlights the necessity of replicating this analysis across a larger number of matches to establish whether such variations are systematic and meaningful, or merely incidental.

It is possible that certain network configurations may appear similar across different tactical contexts, underscoring the need for comparative validation.


Second, the analysis is based on aggregated passing networks over entire matches, which may obscure temporal fluctuations and higher-order sequences that influence tactical decisions. 

Moreover, the Markov layer should be interpreted as a parsimonious firstorder approximation of possession flow rather than as an empirically validated generative model of passing sequences


Third, the current model does not explicitly incorporate spatial coordinates or player movement trajectories, which could further elucidate how positional dynamics interact with passing structure.

Incorporating spatiotemporal data, such as mapping passes to specific field zones, would enable analysis of how network measures relate to formation and space management on the field. 

Moreover, like much of the existing literature, our focus was on offensive passing networks; future research should extend this framework to defensive interactions and transition plays, constructing analogous defensive networks to achieve a more comprehensive evaluation of team performance.

---

## Future research

Longitudinal studies tracking network and spectral evolution across an entire tournament or season would allow for a better understanding of how observed variations unfold over time and under varying competitive pressures.

Integrating spatiotemporal data would also enable the examination of the interaction between network structure and positional play, enhancing the link between structural metrics and functional outcomes.

Such comparative work is essential to establish whether the observed patterns are generalisable or context-dependent, and to build normative references for key metrics across styles and levels of play.

Future studies should also employ null models and random network comparisons to establish baselines for spectral gap, entropy rate, and other indices, enabling more robust interpretation of observed values. [45,46]
- 45. Fiedler M. Algebraic connectivity of graphs. Czech Math J 1973; 23(2): 298–305.
- 46. Chung FRK. Spectral graph theory. American Mathematical Society, 1997.

Expanding the analyses to underrepresented domains, such as women’s football or youth competitions, would also test the framework’s applicability across varying match contexts and address identified gaps in network analysis research.

This framework will help establish whether the observed between-match variations reflect consistent tactical adaptations or fall within expected stochastic fluctuations.

## Practical implications

The methodological approach moves
beyond descriptive analytics, providing stochastic flow
indicators that may inform training design, tactical preparation, and post-match analysis

 Coaching staff could
employ Entropy Rate and Spectral Gap to monitor
passing unpredictability and diffusion speed, delivering
objective measures of aspects related to tactical flexibility and ball circulation efficiency

## Conclusion

Across both matches, SNA identified a consistent core of highly connected players, namely a central defender, a central midfielder, and a left-back, who accumulated the highest levels of interaction and occupied central positions within the passing network.

At the team level, Network Density remained relatively stable between matches, while Network Heterogeneity and Global Centralisation increased in the final, indicating a greater concentration of interactions around key players.

Collectively, this study provides a methodological proof-of-concept for the integrated SNA and Markovspectral framework, demonstrating how combining structural and stochastic flow metrics can reveal observed differences, such as increased fluidity, patience, and unpredictability, that are not apparent from either perspective alone.

The approach moves beyond describing network topology to quantifying functional flow, thereby offering a multi-layered toolkit for performance analysis.


---