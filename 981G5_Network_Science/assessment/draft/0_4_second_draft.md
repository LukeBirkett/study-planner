# Network Science (981G5) Assessment

**Project Goals and Scope:**
The purpose of this project is to begin the research into establishing an appropriate framework for constructing null models in football, or any field based sport for that matter. Football matches can be represented as networks by taking on-field interactions between two players A -> B and constructing these as the basis for edge. A common example, which is the basis for this project, is passed with the output referred to as a PassMap. The game of football and PassMaps presents a particular challenge for null generative processes due to the physical constraints and domain nuances. The game is played within a pitch which means the spatial coordinates are constrained and the onfield actions are bound by the realism of physics, i.e. the ball can only travel in a reasonable way. Additionally, the game has a purpose to score in the opposing goes, hence, nodes and edge inputs must behave in a way which is representative of the way the game is (currently) played. Buldu (2018) is the seminal paper that formalized the PassMap paradigm(s). Here they stated that Null models were close to being constructed and were integrated for the baselining of networking properties. However, the Football network science researchers took a different route, focusing their efforts on Markovian dynamics on the network lineages which were deemed to be self-baseline as probabilistic representation of dynamics. This lead to the construct of advanced dynamic network metrics such as spectral gap and .. (Gama et al. 2026). However, the literature has come full circle and researchers (Gama et al. 2026) are once again actively calling for the construction of null models in football so that they can benchmark their advanced metrics. This project takes the first step in building out such null processes specifically for football. To do this, we actually pick up directly the markovian process which have been utilised to model dynamics on the network and adapt them to establish representation of the dynamics of the network. Building these underlying representations allows a generative process to reproduce null networks which maintains certain network properties, destroy the remaining properties but retain the spatial and domain qualities of the game of football. Specifically, we construct a 1st order Markovian process which models a probability distribution of likely role/position recipient of passes based on a league wide average of 89,000 passes from the 22/23 WSL seasons. This allows us to take a match-team worth of existing passes and run a resampling process which shuffles the pass receivers. This process retains the number of degrees and each nodes out degrees whilst shuffling recipient players in-degrees. By retaining the underlying pass (who makes the pass, where it starts and where it ends) the domain considerations of football is kept intact, i.e. the purpose of the teams actions. Additionally, all spatial aspects are retained recalling that passes compile into network edges. Learning the markovian process from empirical league-data encoded realistic tactic behaviours which by definition will be physically accurate. Shuffling recipients essentially destroys the tactical or performance nuance of a given network. Therefore, the null models retain network properties but contain network properties which are samples from the league average allowing the statistical range of network properties to behave as a benchmarking tool for empirical network analysis. Upon construction a null process, we validate it using degree analysis to determine if the metrics represent a football network or not. The focus is on heterogeneity, node roles and adj matrix similarity. Additionally, we demonstrate by traditional null approaches, e.g. ER, are fundamentally flawed for football. At the start of the project we demonstrate that network properties can be used for football analysis and translate such properties in football terms. After constructing our null process, we attempt to use it to baseline the network. Related to this, we also demonstrate that despite having a season's worth of data, empirical statistical baselines are flawed and nulls are required. Finally, this paper does not claim to have invented the framework for constructing nulls in football. This topic is very complicated and if it has an easy approach it would be documented. As it stands, there are no examples in the literature of constructing a null model in football. The basis of this project comes from Buldu’s (2018) introduction of the need of null in football and Gama et al. (2026) contemporary call for nulls.

---

┌──────────────────────────────────────────────────────────┐
│ SECTION 1: Introduction & Foundations                    │
├──────────────────────────────────────────────────────────┤
│ SECTION 2: Data Pipeline & Diagnostic Metric Showcase    │
├──────────────────────────────────────────────────────────┤
│ SECTION 3: The Literature Gap (Alves, Gama, Buldú)       │
├──────────────────────────────────────────────────────────┤
│ SECTION 4: 1st-Order Generative Null Engine (Recipient)  │
├──────────────────────────────────────────────────────────┤
│ SECTION 5: Practical Application & Case Study            │
├──────────────────────────────────────────────────────────┤
│ SECTION 6: Methodological Limitations & Conclusion       │
└──────────────────────────────────────────────────────────┘

---

## 1. Introduction

### 1.1 Network Science Introduction
Network Science is an intuitive, problem-driven framework for modeling complex systems, abstracting real-world interactions into formal structures of nodes and links to evaluate both system-wide graph topology and the dynamic processes flowing across it.

Its applications are highly versatile and have been successfully deployed across a wide spectrum of domains. For instance, network science is frequently used to identify influential individuals within social and organizational systems through the quantification of high-degree hubs and structural centralities that locate key playmakers, broadcasters, or bottlenecks (Wasserman & Faust, 1994; Newman, 2001; Rodrigues, 2019). Beyond individual metrics, it provides the tools to detect modular community structures, uncovering functional sub-groups or "echo chambers" where elements connect more densely to one another than to the broader network (Fortunato, 2010). Furthermore, the framework enables the modeling of spreading cascades, such as the propagation of biological epidemics or information cascades, revealing how structural features like heavy-tailed degree distributions dictate whether a contagion fizzles out locally or reaches a global tipping point (Pastor-Satorras & Vespignani, 2001; Barrat et al., 2008). Network science also allows researchers to evaluate systemic robustness and degree assortativity across ecological and infrastructure systems, determining how complex architectures withstand random failures versus targeted attacks (Lusseau, 2003; Newman, 2003).

By abstracting disparate domain interactions into shared topological representations, network science moves away from a reductionist, isolationist view of individual components. Instead, it offers a universal toolkit to uncover the emergent organizational principles governing the collective behavior of modern complex systems.

---

### 1.2 Why Apply Network Science to Football
This report focuses exclusively on the application of Network Science to sport (Araújo et al., 2006), specifically football, a field-based, team sport (Duch et al., 2010). Traditional football analysis relies primarily on terminal, individual performance indicators such as passes completed, goals scored, or advanced modeled parameters like Expected Goals (xG; Pollard & Reep, 1997; [xG Reference]), which assigns a probabilistic value to shot quality using historical spatial event data. However, an isolationist perspective is fundamentally flawed because football functions as a complex adaptive system (Buldú et al., 2019). The success of a team cannot be truly understood through isolated individual metrics alone, but is instead determined by the emergent structure derived from continuous individual and collective behaviors and on-pitch tactical organization (Gama et al., 2026).

---

### 1.3 How Apply Network Science to Football
To analyze a system through network science, a domain problem must first be decomposed into a discrete set of nodes and edges. Intuitively, in football, the players of a single team are modeled as nodes ($N=11$), expanding to $N=22$ when incorporating opposition players, or $N=23$ if treating the ball itself as a distinct entity. Edges represent the relational interactions connecting these nodes. However, football represents a complex, multi-layered system where abstract interactions occur continuously. Many of these interactions lack a discrete physical contact event, manifesting instead through spatial control and positional coordination.

To overcome this, completed passes offer a highly pragmatic and objective interaction metric. A completed pass physically connects two teammates (Player A $\rightarrow$ Player B), serving as a discrete event that encodes tactical intent, team strategy, and the structural constraints imposed by the game environment. The representation of teammates as nodes and completed passes as directed edges is known as the PassMap paradigm (Buldú et al., 2018). While several variations of this framework exist — which will be detailed and visualized in Section 1.3: The PassMap Paradigm — the output network is fundamentally a weighted, directed graph where edge weights reflect cumulative passing volume between player pairs.

There are numerous ways this emergent PassMap network can be decomposed into structural network properties and flow dynamics. In 
Section 2.2: Metric Taxonomy, we analyse 1-hop degrees-level metrics to infer insight on a given team-match network but also devel into more avanced properties, Average Shortest Path (Section X), Betweenness Centrality (Seciton X) and Clustering (Section X), to provide inference on how network properties can be used to produce in-depth on-field analysis that might otherwise take a team of high skilled scouts and analyst to conver. 
> Needs polishing

---

### 1.4 The Null Baseline Problem and Project Scope
> needs better heading
However, evaluating raw network properties in isolation — or comparing them directly across flawed empirical baselines (Section X) — provides limited diagnostic value. Properties are inherently shaped by their underlying topological and domain-specific constraints. To validate whether an observed network property is statistically significant, it must be evaluated against an appropriate null model baseline, which we define as a randomized or generative reference network that preserves structural constraints (e.g. degrees, desity, degree sequences) while destroying specific organizational patterns to isolate true signal from random chance.

Gama et al. (2026) demonstrated that while modern sports analytics can compute advanced network properties and stochastic flow metrics, these values remain purely descriptive without reference distributions. Without a statistical baseline, analysts cannot determine whether match-to-match variations in a team’s network structure reflect deliberate tactical execution or mere stochastic noise. Constructing a valid null network in football presents a unique challenge due to the game's strict spatial constraints. A meaningful baseline must reconcile random generative process with physical pitch geometry, expected player movement behaviours, and spatial proximity.

In their seminal paper introducing the PassMap paradigms, Buldu et al. (2018) stated that Null models were a requirement for football analysis and their production of a valid null framework was imminent. However, football's network science research lineage took a heavy turn toward "dynamic on the network" focused work (include exmaples and reference). They've processes were thought to preclude the requirement for null baselines as the probabilsitic mechanisms were self evaluating. That said, the lituruature that has ultiamtely come full circle and recognised that these advanced, dynamical proccess too need robust null baselines to infer value. Hence, this project serves as a direct response to the explicit calls in recent literature for generative, spatially constrained null models capable of establishing robust statistical baselines in football analytics (Gama et al., 2026).
> needds polishing
> appears to repeat slightly in p2 and p3

---

## 2 Data
The dataset comprises StatsBomb event data from the 2023/2024 FA Women's Super League (`competition_id: 37`, `season_id: 281`). Focusing on women's football directly addresses literature deficits regarding the overreliance on short men's samples and the systemic underrepresentation of longitudinal women's datasets (Alves et al., 2025; Gama et al., 2026).

Raw spatiotemporal event logs are non-relational and must be transformed into directed, weighted adjacency matrices $A_{ij}$. For our PassMap framework, we isolate completed passes using four attributes:

As mentioned, we are focusing on PassMap paradigm, meaning the only events we want are completed passes (`event_type: pass`). From the pass event payload, we extract core attributes:
- Passer (source node $i$)
- Recipient (target node $j$)
- Origin $(x_1, y_1)$
- Destination $(x_2, y_2)$

StatsBomb's $120 \times 80$ yard coordinates are rescaled to a $100 \times 100$ relative grid to normalize across varying pitch dimensions (Buldú et al., 2019). Figure 1 demonstrates what this raw pass data looks like prior to network construction. 

An on field team comprised of 11 players (nodes), however, football allows for substitutions meaning more than 11 can participate in the game ($N > 11$). Prominent examples in the liturature assign replacment players as contigous entitys to retain 11 nodes but this obscures individual behavour (Narizuka et al., 2014; Buldú et al., 2019). Conversely, expanding the node count ($N > 11$) introduces low-volume, isolated nodes that distort network invariants like density and clustering coefficients. We opt of a parsimonous approach we just model the 11 most used players in a match. The limitation of this approach is that is discards a small proporiton of the data but this is unlikely to significantly impact network characterstics. 

#### Figure 1: Raw Pass Plotting for 1 Match: Sub-plot 1 Indivudal player vs Sub-plot 2 Whole Team
![Raw passes plotted by individual player and entire team](./figures/raw_passes.png)

#### Table 1: Summary of Dataset Statistics (WSL 2023/2024)
| Metric Category | Dataset Statistic |
| :--- | :--- |
| **Competition / Season** | FA Women's Super League (WSL) $2023/2024$ |
| **Total Matches** | `132` |
| **Total Team Network** | `264` |
| **Total Season Passes Recorded** | `105,262` |
| **Mean Passes per Team per Match** | `399` (Range: `120-847`) |
| **Mean Unique Players Used per Team per Match** | `15.1` (Range: `12-16`) |
> this table needs a review. I think the passes have changed. 

---

## 3 Passing Network Paradigms
In this project, team organization across entire football matches is modeled using the PassMap paradigm popularized by Buldú et al. (2019). Fundementally, this is a directed, weighted network where the edges ($E$) represent completed passes, and the edge weights ($W$) quantify the accumulated total frequency of passes directed from node $i$ to node $j$ over a given observation window—in this study, a full 90-minute match.

$$G = (V, E, W)$$

The authors introduces 3 tiers of PassMap paradigms: Player Networks, Player-Pitch Networks, and Pitch Networks. In these paradigms the definition of edges remains the same but the abstract of the node changes. For this project we will be focusing only on the Player PassMap paradigm where the node set corresponds directly to the eleven players on the pitch ($\vert V \vert = 11$). This allows for nodes to appended with attributed containing the unique player identity (e.g., name, shirt number, or tactical position). In its most basic implementation, a Player Network is topologically abstract and devoid of spatial context. However, a widespread convention is to append spatial $(x, y)$ coordinates to each node, calculated as the player's average position on the pitch during the match. While assigning mean positional coordinates leaves traditional topological network metrics unchanged, it significantly enhances visual interpretability and establishes a continuous baseline for spatial considerations. 

Figure 2 demonstates two visualisation examples of the same PassMap network. The left sub-plot demonstates the network overlayed on a football pitch. The nodes and pitch are develop with consistent coordinate systems so meaning it allows us to infer true average player positions. This is helpful for understanding node and sub-communitity relationships. However, the density of the plot obscured edge visability, which for small network ($N=11$) is a useful analysis tool. The sub-plot abstract the network from the pitch but retains the nodes spatial coodinates. As the network is not constrained, we can plot it bigger and better see the network and its emergent relationships.

The other paradigms are not used in this project but for referece: 
- Pitch-Location Networks are formuled as $G = (K, E, W)$ (Buldú et al., 2018) and abstract away players entirely, establising the node set ($K$) as discretized sub-regions of the pitch. This approach acts as a purely geographic baseline, helping to decompose whether ball progression is driven by pitch topology/geography or by specific tactical instructions.
- Player-Pitch Network (Buldú et al., 2019) segments pitch also but defines composite nodes that represent a specific Player $P$ located within a specific Pitch Zone $K$. A player generates a unique node in every grid zone where they execute or receive a pass. This hybrid paradigm captures dynamic tactical positioning alongside passing decisions by measuring discrete spatial movement. It also vastly scales up the number of nodes. Narizuka et al. (2014) leveraged this increase node density to re-evaluate prior claims that football passing networks exhibit scale-free properties (Yamamoto & Yokoyama, 2011). By expanding the network via spatial discretization, Narizuka et al. concluded that passing networks actually adhere to a Gamma distribution rather than a power law.

Player Networks are used for this project because they are the most dominant representation in football analytics literature (Duch et al.; Grund; Gama et al., 2026; Alves et al., 2025) allowing for deeper theoretical interpretation, they are the most intutative to visually inspect as they remain the closest to the visual game of football and they avoid the requirement to add an additional pre-processing spatial discretization step, of which there is no consensus standard in the literature to go by (Camerino et al., 2012; Narizuka et al., 2014; Arriaza-Ardiles et al., 2018)

#### Figure 2: Player Network PassMap Paradigm Examples: Pitch vs Frameless
![passing network demonstate on pitch overlay vs frameless](./figures/passmap_examples.png)

---

## 4 Football Network Metrics
The application of Network Science to football transforms positional passing data into structural models, allowing tactical dynamics to be analyzed through mathematical properties (López-Peña & Touchette, 2012). Rather than evaluating players in isolation, passing networks treat players as nodes and completed passes as directed, weighted edges (Cotta et al., 2013).

To systematically map network properties to footballing concepts, researchers broadly categorize analysis across three structural scales: Micro-scale, Meso-scale, and Macro-scale (Alves et al., 2025; Gama et al., 2026). A comprehensive mapping of network properties to their football equivalents is detailed in Appendix A (adapted from Gama et al., 2026), with a core subset outlined in Table X.

### 4.1 The Multi-Scale Network Framework

#### 4.1.1 Micro-Scale Analysis
At the micro-scale, the focus rests on individual nodes (players). The most fundamental micro-metric is Degree, which measures raw passing volume: In-Degree represents passes received, while Out-Degree measures passes completed (Cotta et al., 2013).

Beyond raw volume, micro-scale metrics evaluate structural influence. Betweenness Centrality identifies players who act as crucial conduits, controlling the flow of passes between different sectors of the pitch (López-Peña & Touchette, 2012). Nodes with high centrality act as tactical "hubs" (Buldú et al., 2019). Identifying player's network characteristics is pivotal for tactical profiling and recruitment—allowing clubs to identify structural equivalents across leagues (Peña & Navarro, 2015).

#### 4.1.2 Meso-Scale Analysis
Meso-scale analysis broadens this lens to evaluate sub-structures—typically combinations involving 3 to 4 players (cliques or triads). It measures how localized sub-groups interact and identifies localized leadership within passing channels (López-Peña & Sánchez Navarro, 2015). Highly heterogeneous meso-structures can indicate structural dysfunctions, such as isolated players who fail to integrate into broader build-up play (Clemente et al., 2015).

#### 4.1.3 Macro-Scale Analysis
Macro-scale metrics evaluate the network as an integrated whole, reducing a team's global spatial-tactical signature into singular, comparable metrics. Features like Network Density, Global Centrality, and the Small-World Property summarize team cohesion, structural fluidity, and spatial dominance (Watts & Strogatz, 1998; Cintia et al., 2015). Successful teams often exhibit macro-level properties reflecting high connectivity and balanced interaction patterns (Pina et al., 2017; Ribeiro et al., 2017).

---

### 4.2 Metric Suite
To evaluate tactical performance without overwhelming the analysis with redundant properties, this project scopes down to three core tiers of network metrics: Micro-Level Player Degree Distributions (including weighted in/out-strength $s_{in}, s_{out}$ and Net Flow $\Delta s_i$), Macro-Level Network Heterogeneity ($CV_k$ and Node Volume Variance $\text{Var}(s_{\text{tot}})$), and Path Efficiency / Local Clustering (Average Shortest Path $d$, Betweenness Centrality $g(i)$, and Transitive Triad Intensity $I_{transitive}$). These metrics balance intuitive football interpretations with theoretical rigor.

> Include the full translation table from gama in the appendix.

##### Table X: Metrics Suite
> Place holder table, needs updating with actually focus. May be moved to appendex.
| Metric Name | Mathematical Definition / Concept | Primary Application in Football Network Analysis | Tactical & Analytic Interpretation | Key Limitations / Caveats |
| :--- | :--- | :--- | :--- | :--- |
| **Pass Subgraph Density** | $D = \frac{2E}{V(V-1)}$ where $E$ is observed passes and $V$ is subset nodes | Measuring connectivity density within specific sub-units (e.g., left-flank trio, midfield pivot). | Indicates how tightly integrated a subset of players is in ball circulation; high values signify localized combination play. | Sensitive to subset size ($V$); does not account for pass directional quality, distance, or pressure. |
| **Subnetwork Clustering Coefficient** | $C_i = \frac{2 e_i}{k_i(k_i - 1)}$ averaged across subset nodes $i$ | Evaluating local triangulation and passing triangles within a positional sector. | Higher values reflect strong local support networks and frequent triangular passing structures, crucial for positional play (*Juego de Posición*). | High clustering can sometimes reflect redundant lateral/backward passing rather than progressive play. |
| **Sub-network Flow Centrality (Subset Betweenness)** | Fraction of shortest weighted passing paths passing through a specific subset $S \subset V$ | Identifying sector-level bottlenecks and key transitional hubs (e.g., central midfield block). | Quantifies how heavily a specific unit acts as a bridge between defense, flanks, and attack during buildup sequences. | Heavily dependent on team passing volume; can overvalue frequent short passes over rare line-breaking passes. |
| **Eigenvector Centrality (Subset Aggregation)** | $\lambda x_i = \sum_{j \in S} A_{ij} x_j$ restricted to subset interactions | Measuring influential passing clusters (e.g., double pivot + attacking midfielder). | Identifies whether a player is connected to *other highly connected players* within a specific tactical subgroup. | Susceptible to dominant possession styles; skewing toward high-volume passing teams regardless of efficiency. |
| **Sub-Graph Modularity ($Q_{sub}$)** | $Q = \sum_{i=1}^{c} \left( e_{ii} - a_i^2 \right)$ calculated for tactical modules | Detecting natural passing cliques or tactical clusters (e.g., wing-back + winger + interior). | Assesses whether a team operates via distinct tactical "silos" or exhibits fluid, total-team connectivity across sectors. | Threshold selection for community detection algorithms (e.g., Louvain) can alter identified subset boundaries. |
| **Pass Reciprocity (Dyadic / Triadic)** | $r = \frac{\sum_{i \neq j} (A_{ij} - \bar{A})(A_{ji} - \bar{A})}{\sum_{i \neq j} (A_{ij} - \bar{A})^2}$ within subset | Evaluating two-way passing interactions between key pairings (e.g., CB-CB, W-FB). | High reciprocity demonstrates strong two-way dynamic partnerships and balance in spatial buildup. | High dyadic reciprocity can indicate structural stagnation or an inability to break forward lines. |

---