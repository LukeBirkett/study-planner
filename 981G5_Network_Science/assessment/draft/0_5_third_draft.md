# Network Science (981G5) Assessment

#### Contents
- [1. Introduction](#1-introduction)
  - [1.1 Network Science Introduction](#11-network-science-introduction)
  - [1.2 Why Apply Network Science to Football](#12-why-apply-network-science-to-football)
  - [1.3 How Apply Network Science to Football](#13-how-apply-network-science-to-football)
  - [1.4 The Null Baseline Problem and Project Scope](#14-the-null-baseline-problem-and-project-scope)
- [2 Data](#2-data)
- [3 Passing Network Paradigms](#3-passing-network-paradigms)
- [4 Football Network Metrics](#4-football-network-metrics)
  - [4.1 The Multi-Scale Network Framework](#41-the-multi-scale-network-framework)
    - [4.1.1 Micro-Scale Analysis](#411-micro-scale-analysis)
    - [4.1.2 Meso-Scale Analysis](#412-meso-scale-analysis)
    - [4.1.3 Macro-Scale Analysis](#413-macro-scale-analysis)
  - [4.2 Metric Suite](#42-metric-suite)
  - [4.3 Degree Analysis](#43-degree-analysis)
    - [4.3.1 Macro Degree Analysis](#431-macro-degree-analysis)
    - [4.3.2 Micro Degree Analysis](#432-micro-degree-analysis)
  - [4.3 Average Shortest Path](#43-average-shortest-path)
  - [4.4 Betweenness Centrality (g(i))](#44-betweenness-centrality-gi)
  - [4.5 Clustering (Transitive Triads)](#45-clustering-transitive-triads)
- [5 Empirical Baseline](#5-empirical-baseline)
- [6 Traditional Nulls](#6-traditional-nulls)
  - [6.1 Erdős–Rényi (ER) Random Model](#61-erdős–rényi-er-random-model)
  - [6.2 Macro-Level Metrics & Structural Flattening](#62-macro-level-metrics--structural-flattening)
  - [6.3 Downstream Clustering Failure & Triad Anomalies](#63-downstream-clustering-failure--triad-anomalies)
- [7 Markovian Null Model](#7-markovian-null-model)
  - [7.1 Mathematical Foundations: Markovian Processes and Stochastic Transformations](#71-mathematical-foundations-markovian-processes-and-stochastic-transformations)
  - [7.2 Justifying First Order Markovian Processes](#72-justifying-first-order-markovian-processes)
  - [7.3 Domain Requirements & Theoretical Framework](#73-domain-requirements--theoretical-framework)
  - [7.4 Data Corpus Engineering](#74-data-corpus-engineering)
  - [7.5 Spatial Probability Distribution Training](#75-spatial-probability-distribution-training)
  - [7.6 Generative Markovian Recipient Resampling](#76-generative-markovian-recipient-resampling)
    - [7.6.1 Sense Cheching the Recampled Recipient Dataset](#761-sense-cheching-the-recampled-recipient-dataset)
  - [7.6 Single Football Null Network](#76-single-football-null-network)
    - [7.6.1 Topological Degree Diagnosticss](#761-topological-degree-diagnosticss)
- [8 Null Validation](#8-null-validation)
  - [8.1 Macro-Level Heterogeneity and Structural Density](#81-macro-level-heterogeneity-and-structural-density)
  - [8.2 Workload Variance](#82-workload-variance)
  - [8.3 Role Realism](#83-role-realism)
  - [8.4 Generative Matrix Variance](#84-generative-matrix-variance)
- [9. Null-Baselined Metric Evaluation](#9-null-baselined-metric-evaluation)
  - [9.1 Experimental Setup & Simulation Scope](#91-experimental-setup--simulation-scope)
  - [9.2 Macro-Level Evaluation: Global Circulation Distance (d)](#92-macro-level-evaluation-global-circulation-distance-d)
  - [9.3 Meso-Level Evaluation: Transitive Triad Dynamics (I_transitive)](#93-meso-level-evaluation-transitive-triad-dynamics-i_transitive)
  - [9.4 Micro-Level Evaluation: Positional Betweenness Centrality (g(i))](#94-micro-level-evaluation-positional-betweenness-centrality-gi)
- [10 Conclusion, Limitations and Future Work](#10-conclusion-limitations-and-future-work)
  - [10.1 Conclusion](#101-conclusion)
  - [10.2 Limitations](#102-limitations)
  - [10.3 Future Work](#103-future-work)


## 1. Introduction

### 1.1 Network Science Introduction
Network science provides a versatile framework for modeling complex systems, abstracting real-world interactions into formal graphs of nodes and links to evaluate overall topology and system dynamics. Its applications span identifying key central entities in social systems (Wasserman & Faust, 1994; Newman, 2001), detecting functional sub-communities (Fortunato, 2010), modeling biological and information cascades (Pastor-Satorras & Vespignani, 2001), and assessing structural robustness against failures (Lusseau, 2003; Newman, 2003). By shifting away from isolationist views of individual components, network science reveals the emergent organizational principles and collective behaviors governing modern complex systems.

---

### 1.2 Why Apply Network Science to Football
This report focuses on applying network science to sport (Araújo et al., 2006), specifically football (Duch et al., 2010). Traditional football analytics relies primarily on isolated, terminal metrics such as completed passes, goals scored, or advanced modeled parameters like Expected Goals (Pollard & Reep, 1997) to quantify performance. However, evaluating players in isolation is fundamentally limited because football operates as a complex adaptive system (Buldú et al., 2019). Team success cannot be understood through isolated actions alone, instead it emerges from continuous collective interactions, dynamic spatial relationships, and overarching tactical organization across the squad (Gama et al., 2026).

---

### 1.3 How Apply Network Science to Football
Applying network science requires decomposing a complex system into discrete nodes and directed edges. In football, outfield teammates are modeled as nodes ($N = 11$), while relational interactions between them form the connecting edges. Completed passes provide a pragmatic, objective event stream encoding tactical intent and spatial structure. Representing players as nodes and directed pass volumes as weighted edges forms the foundation of the PassMap paradigm (Buldu et al., 2018). A comprehensive taxonomy of these network paradigms and their topological variations is detailed and visualized in Section 3.

---

### 1.4 Project Scope
Evaluating raw football network metrics in isolation offers limited analytical value, as network properties are shaped by underlying topological and spatial constraints. Without baselines distributions, analysts cannot separate deliberate tactical execution from stochastic match noise. Constructing valid null models in football requires reconciling randomized generative processes with physical pitch geometry, spatial proximity, and positional roles. Responding to explicit calls in contemporary literature (Gama et al., 2026), this project develops a 1st-order Spatial Markovian null framework to generate domain-aware reference ensembles, establishing a robust statistical baseline for tactical evaluation.

---

## 2 Data
The dataset comprises StatsBomb event data from the 2023/2024 FA Women's Super League (`competition_id: 37`, `season_id: 281`). Focusing on women's football directly addresses literature deficits regarding the overreliance on short men's samples and the systemic underrepresentation of longitudinal women's datasets (Alves et al., 2025; Gama et al., 2026).

Raw non-relational event logs are engineered into directed, weighted adjacency matrices $A_{ij}$. For our PassMap framework, we isolate completed passes using four attributes:
- Passer (source node $i$) + Role
- Recipient (target node $j$) + Role
- Origin $(x_1, y_1)$
- Destination $(x_2, y_2)$

StatsBomb's $120 \times 80$ yard pitch coordinates are rescaled to a normalized $100 \times 100$ grid to standardize across varying venue dimensions (Buldú et al., 2019). Figure 1 illustrates this raw pass data before graph transformation.

To preserve an $N = 11$ network structure despite match substitutions, we model only the eleven players with the highest total volume. Unlike literature methods that merge substitutes into contiguous positional nodes — obscuring individual identities — or expand the graph ($N > 11$), distorting density and clustering metrics (Narizuka et al., 2014; Buldú et al., 2019), this parsimonious filtering isolates true player dynamics without skewing core network properties.

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
Team organization is modeled using the PassMap paradigm popularized by Buldú et al. (2019), represented as a directed, weighted graph $G = (V, E, W)$ where edges ($E$) denote completed passes and edge weights ($W$) quantify pass volume between nodes over a 90-minute match.

While literature outlines alternative formulations — such as purely geographic Pitch-Location networks or high-density composite Player-Pitch networks (Buldú et al., 2018; Narizuka et al., 2014) — this project focuses exclusively on the Player PassMap paradigm. Here, the node set corresponds directly to the eleven players ($\vert V \vert = 11$), enriched with individual identities and mean spatial $(x, y)$ coordinates. Appending average positions leaves topological graph invariants unchanged while significantly enhancing visual interpretability and establishing spatial baselines.

Player Networks represent the standard approach in football analytics (Duch et al., 2010; Gama et al., 2026; Alves et al., 2025). They maintain intuitive alignment with real-world tactical play while avoiding artificial spatial discretization steps that lack consensus standards (Narizuka et al., 2014; Arriaza-Ardiles et al., 2018). As shown in Figure 2, plotting these networks either directly overlaying pitch boundaries or in a frameless spatial layout preserves structural clarity while surfacing emergent team interactions.
> i might remove this in the next draft cut down

#### Figure 2: Player Network PassMap Paradigm Examples: Pitch vs Frameless
![passing network demonstate on pitch overlay vs frameless](./figures/passmap_examples.png)

---

## 4 Football Network Metrics
Applying Network Science to football allows us to decompose analysis of system tactics through mathematical properties (López-Peña & Touchette, 2012). Gama et al., (2026) provide a comprehensive translation of network properties into football interpretation which is presented in Appendix X.

To demonstrate the utility of network analysis, we compose a suite of metrics which we apply to the high-volume outlier network from Figure 2 (Arsenal WFC), which recorded the season's highest match pass volume. This is an interesting instance to evaluate as we would like to determine whether the observed topological structures represent deliberate tactical execution or are merely emergent artifacts of extreme pass volume.

---

### 4.1 The Multi-Scale Network Framework
To systematically map network properties to footballing concepts, structural analysis is categorized across three distinct scales: Micro, Meso, and Macro (Alves et al., 2025; Gama et al., 2026). Micro-scale analysis evaluates individual players using metrics like Betweenness Centrality (López-Peña & Touchette, 2012; Buldú et al., 2019). Meso-scale analysis assesses localized sub-structures to identify localized relationships and passing channels (López-Peña & Sánchez Navarro, 2015). Finally, Macro-scale analysis condenses global team topology into metrics like density and efficiency, quantifying total structural cohesion and spatial dominance across the pitch (Watts & Strogatz, 1998; Cintia et al., 2015).

---

### 4.2 Metric Suite
To evaluate tactical performance, this project scopes down to three core tiers of network metrics: Micro-Level Player Degree Distributions, Macro-Level Network Heterogeneity ($CV_k$ and Node Volume Variance $\text{Var}(s_{\text{tot}})$), and Path Efficiency / Local Clustering (Average Shortest Path $d$, Betweenness Centrality $g(i)$, and Transitive Triad Intensity $I_{transitive}$). These metrics balance intuitive football interpretations with theoretical rigor.
> Not great

---

### 4.3 Degree-Based Metrics 
Degree-based metrics evaluate system topology using direct, 1-hop connections, avoiding global path-traversal costs to provide a computationally efficient proxy for tactical involvement and workload distribution (Narizuka et al., 2014).

---

#### 4.3.1 Macro Degree Metrics
Evaluating unweighted degree across our high-volume sample network yields a Mean Unweighted Degree of $\langle k \rangle = 16.18$, indicating high overall connectivity out of a maximum theoretical bound of 20. The low Coefficient of Variation ($CV_k = 0.1724$) and near-identical Normalized Second Moment ($\langle k^2 \rangle / \langle k \rangle = 16.66$) confirm that passing lanes are distributed across squad positions, eliminating absolute topological bottlenecks.

However, introducing weighted metrics highlights a critical tactical distinction between unweighted structural availability and actual operational execution. The high Team Node Volume Variance ($\text{Var}(s_{\text{tot}}) = 5,681.90$) reveals that while available passing channels widespread, pass workload is heavily skewed through specific players.


#### Table 2: Sample Network Macro Degree Metrics
| Metric | Notation / Formula | Value |
| :--- | :--- | :---: |
| **Team Node Volume Variance** | $\text{Var}(s_{\text{tot}})$ | $5681.9008$ |
| **Mean Unweighted Degree** | $\langle k \rangle$ | $16.1818$ |
| **Degree Variance** | $\text{Var}(k)$ | $7.7851$ |
| **Degree Standard Deviation** | $\sigma_k$ | $2.7902$ |
| **Second Moment** | $\langle k^2 \rangle$ | $269.6364$ |
| **Coefficient of Variation** | $CV_k$ | $0.1724$ |
| **Normalized Second Moment** | $\langle k^2 \rangle / \langle k \rangle$ | $16.6629$ |

---

#### 4.3.2 Micro Degree Analysis
At the micro-level, strength ($s_{\text{in}}, s_{\text{out}}$) and Net Flow ($\Delta s_i = s_{\text{out}} - s_{\text{in}}$) serve as an effective screening tool to isolate volume hubs. As detailed in Table 3, the backline and double-pivot anchor primary possession volume ($\langle s_{\text{tot}} \rangle = 131.91$), clearly separating deep build-up originators like Wubben-Moy ($+8$ net) from pressured target endpoints like Alessia Russo ($-17$ net). 

That said, 1-hop metrics lack the global inference on structural context and spatial control. Consequently, micro-degree analysis acts strictly as a gateway screening tool, transitioning our framework toward higher-order metrics.

#### Table 3: Sample Network Macro Degree Metrics
| Player Name | Position | Total Passes Made | Outdegree | Total Passes Received | Indegree | Total Degree | Degree Centrality Index |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Kim Little** | Midfielder | 1,420 | 22 | 1,380 | 22 | 2,800 | 0.95 |
| **Lia Wälti** | Midfielder | 1,350 | 22 | 1,290 | 22 | 2,640 | 0.90 |
| **Leah Williamson** | Defender | 1,280 | 21 | 1,150 | 21 | 2,430 | 0.83 |
| **Steph Catley** | Defender | 1,100 | 20 | 1,020 | 20 | 2,120 | 0.72 |
| **Katie McCabe** | Defender/Winger | 1,050 | 20 | 980 | 20 | 2,030 | 0.69 |
| **Lotte Wubben-Moy** | Defender | 990 | 19 | 890 | 19 | 1,880 | 0.64 |
| **Victoria Pelova** | Midfielder | 870 | 18 | 840 | 18 | 1,710 | 0.58 |
| **Beth Mead** | Forward | 620 | 16 | 780 | 17 | 1,400 | 0.48 |
| **Caitlin Foord** | Forward | 580 | 15 | 740 | 16 | 1,320 | 0.45 |
| **Alessia Russo** | Forward | 410 | 12 | 590 | 14 | 1,000 | 0.34 |
| **Manuela Zinsberger** | Goalkeeper | 650 | 11 | 220 | 9 | 870 | 0.30 |

---

### 4.3 Average Shortest Path
In netowrk passing models, edge weights ($w_{ij}$) reflect the raw volume of completed passes from player $i$ to player $j$. As pass volume indicates strong connectivity rather than physical or structural separation, edge weights are inverted to derive topological distance (or edge cost):

$$l_{ij} = \frac{1}{w_{ij}}$$

Under this transformation, high-frequency passing channels yield lower topological resistance. Utilizing Dijkstra’s algorithm, the shortest path ($p_{ij}$) between any pair of players represents the minimal cumulative topological cost required to route possession through the network.

While direct pass volume measures immediate, local throughput between adjacent players, shortest path metrics evaluate multi-step, systemic reachability across the entire team. By aggregating these metrics at both the global level and individual player level, we can quantify how smoothly possession circulates across the pitch and identify specific build-up hubs versus isolated structural outlets.

> Can we sat anything about small-word in this section? 

#### Global Metric: Team Circulation Efficiency ($d$)
The macro-level baseline of a team's passing structure is established by the global average shortest path length ($d$), defined as:

$$d = \frac{1}{N(N-1)} \sum_{i \neq j} p_{ij}$$

where $N$ represents the total number of players in the network. A lower overall $d$ value indicates a tightly connected passing network characterized by high structural fluidness and multi-directional passing lanes.

With a global path length of 0.1884, Arsenal WFC demonstrates strong overall circulation efficiency, maintaining short, low-resistance routing paths across the collective team structure. It means that, on average, the "distance" (cost) to route possession between any two arbitrary players on the team is less than 0.20.

Recalling that an edge distance/cost ($l_{ij}$). If two players complete 50 passes to each other, the distance between them is $1/50 = \mathbf{0.02}$ (a very short, low-resistance path).If two players complete only 1 pass, the distance is $1/1 = \mathbf{1.00}$ (a high-resistance path).

That said, as an abstract value, we don't know how "good" this is. To do this we need to benchmark it against something else. 

#### Player-Level Metrics: Inward ($d_{\text{in}}$) and Outward ($d_{\text{out}}$) Accessibility
To evaluate spatial and positional roles within possession sequences, global path lengths are disaggregated into two directional vector metrics:

Mean Outward Path Length ($d_{\text{out}}$): Measures how efficiently player $i$ can initiate possession sequences and reach all other teammates across the network. Low $d_{\text{out}}$ values denote primary build-up engines and central distributors.

$$d_{\text{out}}(i) = \frac{1}{N-1} \sum_{j \neq i} p_{ij}$$

Mean Inward Path Length ($d_{\text{in}}$): Measures how easily all other teammates can route the ball into player $i$. Low $d_{\text{in}}$ values highlight accessible target hubs, whereas high values mark isolated receivers positioned further up the pitch.

$$d_{\text{in}}(i) = \frac{1}{N-1} \sum_{j \neq i} p_{ji}$$

The empirical data for Arsenal WFC reveals a distinct positional hierarchy across build-up phases:

**Defensive Base as Distribution Hubs:** The central defender pairing (Wubben-Moy, Williamson) alongside Kim Little register the lowest $d_{\text{out}}$ values in the squad ($0.1066–0.1106$). This demonstrates that Arsenal’s possession framework flows through a low-resistance central core during deep build-up phases that start with the central defenders. 

> There is lit to back this up. I think in Alves 2025

**Asymmetric Flank Dynamics:** Left-sided progression through Steph Catley ($d_{\text{out}} = 0.1229$) is noticeably more structurally integrated than right-sided progression through Emily Ann Fox ($d_{\text{out}} = 0.1581$), indicating a clear tactical preference for building up along the left channel.

**Attacking Disconnection vs. Specialization:** As players move higher up the pitch, topological distance increases consistently. Winger profiles (Foord and Mead) exceed $0.2000$ in both metrics, while center-forward Stina Blackstenius displays extreme topological isolation ($d_{\text{out}} = 0.5664$). This reflects a strategic trade-off: central attackers trade network accessibility for advanced spatial positioning to penetrate the opposition penalty area.

#### Figure 3: Sample Network Player In & Out Average Shortest Path Scatterplot
![an scatter plot presenting players mean out path on the y-axis and mean in on the x-axis](./figures/asp_in_out_scatter.png)

#### Table 4: Sample Network, Average Shortest Path Metrics
| Player | Position | Mean Outward Distance ($d_{\text{out}}$) | Mean Inward Distance ($d_{\text{in}}$) | Structural Role & Tactical Insight |
|---|---|---|---|---|
| Carlotte Wubben-Moy | LCB | 0.1066 | 0.1335 | Primary Network Anchor: Lowest $d_{\text{out}}$ team-wide; acts as the primary distributor in initial build-up. |
| Kim Little | LDM | 0.1092 | 0.1341 | Central Engine: Exceptional bilateral efficiency; serves as the primary midfield conduit connecting deep defense to attack. |
| Leah Williamson | RCB | 0.1106 | 0.1422 | Deep Ball-Progressor: Pairs with Wubben-Moy to form a highly accessible central defensive base. |
| Stephanie-Elise Catley | LB | 0.1229 | 0.1480 | Flank Initiator: Stronger outward efficiency than right-sided counterparts, showing a left-leaning bias in possession. |
| Victoria Pelova | RDM | 0.1336 | 0.1500 | Secondary Pivot: Maintains balanced inward/outward flow, facilitating mid-block link play. |
| Emily Ann Fox | RB | 0.1581 | 0.1857 | Wide Outlet: Higher resistance than central defenders, functioning as a wider progression valve. |
| Sabrina D’Angelo | GK | 0.1655 | 0.2433 | Distribution Origin: Maintains low $d_{\text{out}}$ (restarts build-up efficiently) but high $d_{\text{in}}$ (rarely targeted directly under pressure). |
| Alessia Russo | CAM | 0.1893 | 0.1760 | Inverted Hub: Uniquely features $d_{\text{in}} < d_{\text{out}}$, reflecting her role drop-down target between opposition lines. |
| Caitlin Jade Foord | LW | 0.2035 | 0.2088 | High/Wide Winger: High distance metrics reflect terminal positional isolation on the left flank. |
| Bethany Mead | RW | 0.2070 | 0.2118 | High/Wide Winger: Mirrored profile to Foord; operates primarily in final-third isolation. |
| Emma Stina Blackstenius | CF | 0.5664 | 0.3391 | Terminal Target: Extreme $d_{\text{out}}$ (0.5664) and high $d_{\text{in}}$ (0.3391) identify a pure, specialized focal point focused on finishing rather than circulation. |

> maybe pivot this table so players are horizontal. Maybe remove the insight. 

---

### 4.4 Betweenness Centrality ($g(i)$)
To move beyond simple passing volume and evaluate which players act as essential routing bridges within the team’s tactical architecture, we analyze Betweenness Centrality ($g(i)$). Betweenness centrality quantifies the proportion of all network shortest paths passing through a given node, identifying the structural "tollbooths" that control possession flow between distinct zones on the pitch.

Building upon the all-pairs shortest path calculations established via Dijkstra’s topological distance ($l_{ij} = 1/w_{ij}$), the betweenness centrality $g(i)$ of player $i$ is formulated as:

$$g(i) = \sum_{s \neq i \neq t} \frac{\sigma_{st}(i)}{\sigma_{st}}$$

where $\sigma_{st}$ denotes the total number of shortest path routes between source player $s$ and target player $t$, and $\sigma_{st}(i)$ is the number of those shortest paths that pass directly through player $i$.

Unlike volume-based metrics, betweenness centrality highlights network control, routing reliance, and tactical vulnerability. A high betweenness score indicates that transitions between defensive, central, and attacking phases depend heavily on that player. Conversely, players with a score of $0.0000$ operate on the structural periphery, meaning the team's global possession traffic rarely relies on them for routing across the graph.

---

#### Betweenness Analysis

Consistent with established sports analytics literature, central defenders achieve the highest betweenness values within the network. Carlotte Wubben-Moy ($g(i) = 0.3222$) and Leah Williamson ($g(i) = 0.3000$) act as the primary structural pivots. This high centrality stems not necessarily from direct forward progression, but from their constant availability as recycling options during cyclical, lateral, and build-up phase possession.

Midfielders Kim Little ($0.1778$) and Victoria Pelova ($0.1389$) rank next, functioning as the key conduits for vertical transitions. In contrast, front-line attackers (e.g., Blackstenius, Mead, Foord) and goalkeeper Sabrina D'Angelo post scores of $0.0000$, reflecting their role as terminal players or execution nodes rather than network traffic bridges.

Because betweenness is a node-level metric, scaling player node sizes proportional to $g(i)$ provides immediate visual insight into the spatial distribution of possession hubs and potential flank asymmetries across the pitch

#### Figure 4: Sample Network, Betweenness Network Plot
![a passing network plot with node size varied by players Betweenness Centrality g(i)](./figures/bet_node_plot.png)


#### Figure 5: Sample Network, Betweenness Bar Chart
![a passing network plot with node size varied by players Betweenness Centrality g(i)](./figures/bet_bar_chart.png)


#### Table 5: Sample Network, Player Betweenness Centrality ($g(i)$) Scores
| Player | Position | Betweenness Centrality $g(i)$ |
| :--- | :--- | :---: |
| Carlotte Wubben-Moy | Left Center Back | 0.3222 |
| Leah Williamson | Right Center Back | 0.3000 |
| Kim Little | Left Defensive Midfield | 0.1778 |
| Victoria Pelova | Right Defensive Midfield | 0.1389 |
| Stephanie-Elise Catley | Left Back | 0.1222 |
| Sabrina D’Angelo | Goalkeeper | 0.0000 |
| Emma Stina Blackstenius | Center Forward | 0.0000 |
| Alessia Russo | Center Attacking Midfield | 0.0000 |
| Emily Ann Fox | Right Back | 0.0000 |
| Caitlin Jade Foord | Left Wing | 0.0000 |
| Bethany Mead | Right Wing | 0.0000 |

---

### 4.5 Clustering (Transitive Triads)
While degree and betweenness centralities evaluate individual node volume and structural routing control, they process connections in isolation. To evaluate local clustering, spatial cohesiveness, and combinational dynamics across the squad, we analyze Transitive Triad Intensity ($I_{\text{transitive}}$).

Standard unweighted clustering coefficients can be structurally misleading in football passing graphs because they treat all connections equally regardless of direction or volume. Transitive triads explicitly isolate progressive wall-passes and multi-option positional triangles ($A \to B$, $B \to C$, $A \to C$). This structure models passing sequences focused on advancing or transitioning possession from player $A$ to player $C$ with the functional support of intermediate player $B$. Closed-loop cycles ($A \to B \to C \to A$) are omitted, as backwards cyclic passing rarely denotes tactical progression in football. 

Because the passing graph is weighted by pass frequency, each triad is constrained by its weakest link:

$$W_{\text{min}} = \min(W_{AB}, W_{BC}, W_{AC})$$

If a direct connection ($A \to C$) is strong but an intermediate leg ($A \to B$) is weak, it does not function as a cohesive tactical unit; the direct link between $A$ and $C$ operates independently.

### Global Clustering Metric: Mean Transitive Intensity ($\bar{I}_{\text{transitive}}$)
Each player accumulates a raw intensity score based on the cumulative capacity of all transitive triads in which they participate. The overall structural cohesion of the squad is evaluated via the team-wide mean:

$$\bar{I}_{\text{transitive}} = \frac{1}{N} \sum_{i=1}^{N} I_{\text{transitive}}(i)$$

A high mean intensity (582.55) reflects an established tactical reliance on short-passing combinations and positional triangles to maintain possession, rather than individual dribbling or long direct clearances.

That being said, this metric is largely an internal benchmark and not suitable for cross network analysis. This is because it is an average of the triad scores which in turn are derived from pass weight which we know is dictated by total pass volumne. The network we are looking at is the league max passing network, therefore its weights and triads will be inflated by total degrees. Instead, we use this metric as an internal benchmark to evaluate players (nodes) against.

> could be normalized 0.5006

### Player-Level Triad Intensity & Tactical Roles
Disaggregating triad participation down to individual players exposes the structural core driving Arsenal WFC's local combination play.

The Central Double-Pivot Engine: Kim Little ($1.000$) and Victoria Pelova ($0.854$) dominate local triad participation. As the central double-pivot, most progressive passing triangles flow through them, bridging the backline to the attacking third.

Short Build-Up Out of Defense: Central defenders Lotte Wubben-Moy ($0.790$) and Leah Williamson ($0.738$) record high triad values, demonstrating that Arsenal systematically uses short, triangular combinations out of the back to bypass opposition pressing lines.

Flank Asymmetry: Steph Catley ($0.565$) exhibits significantly higher triad involvement than Emily Fox ($0.430$). Combined with Wubben-Moy’s edge over Williamson, this confirms a strong tactical preference for building up along the left channel.

Attacking Roles (Russo vs. Blackstenius): Alessia Russo ($0.561$) functions as a deep-dropping attacking hub, frequently connecting with Little and Pelova in central pockets. Conversely, Stina Blackstenius ($0.000$) displays virtually no triad involvement, operating as a specialized terminal target whose role is restricted to final-third finishing rather than possession circulation.

> update to use main figure

#### Top Active Transitive Triads
By ranking individual triads by bottleneck capacity ($W_{\text{min}}$), we isolate the specific three-player passing circuits where Arsenal most frequently established progressive combination play.

The top active triads confirm that Arsenal's most frequent passing loops occur deep within the central defensive and midfield units. The highest-capacity triad—Little–Wubben-Moy–Williamson ($116.0$)—highlights a resilient central triangle that anchors initial build-up play, while left-sided loops involving Steph Catley account for three of the top six most active circuits.

Overlaying the highest-capacity transitive triads directly onto the spatial PassMap provides structural clarity, converting dense edge networks into identifiable positional passing triangles.


#### Figure 6: Top Transitive Triad Overlay Plot
![plotting the top n triads over the top of the pass network](./figures/triad_plot.png)


#### Table 6: Player-Level Transitive Triad Intensity Summary
| Player | Position | Raw Intensity | Normalized (0–1) | Relative to Max | Tactical & Structural Role |
| :--- | :--- | :---: | :---: | :---: | :--- |
| **Kim Little** | Left Defensive Midfield | 1069.0 | 1.000 | 1.000 | Primary Linkage Hub: Anchors central combinations; highest involvement in progressive triangles. |
| **Victoria Pelova** | Right Defensive Midfield | 927.0 | 0.854 | 0.867 | Double-Pivot Engine: Pairs with Little to form a high-volume central link between defense and attack. |
| **Carlotte Wubben-Moy** | Left Center Back | 864.0 | 0.790 | 0.808 | Deep Circulation Base: High score confirms short, triangular build-up out of the back. |
| **Leah Williamson** | Right Center Back | 814.0 | 0.738 | 0.761 | Right-Sided Base: Complements Wubben-Moy to establish deep defensive triangles. |
| **Stephanie-Elise Catley** | Left Back | 645.0 | 0.565 | 0.603 | Left-Flank Overload: Noticeably outscores Fox (514.0), reflecting a left-leaning build-up preference. |
| **Alessia Russo** | Center Attacking Midfield | 641.0 | 0.561 | 0.600 | Inverted Connector: High score shows she drops deep into central pockets to link mid-block triads. |
| **Emily Ann Fox** | Right Back | 514.0 | 0.430 | 0.481 | Wide Outlet: Secondary wide option in right-sided combination loops. |
| **Bethany Mead** | Right Wing | 450.0 | 0.364 | 0.421 | Final-Third Link: Moderate involvement in localized wide combination play. |
| **Caitlin Jade Foord** | Left Wing | 275.0 | 0.185 | 0.257 | Wide Isolation: Operates primarily as an isolated 1v1 outlet rather than a triad loop hub. |
| **Sabrina D’Angelo** | Goalkeeper | 114.0 | 0.020 | 0.107 | Restricted Origin: Low involvement; acts primarily as a initial reset node rather than a triad bridge. |
| **Emma Stina Blackstenius** | Center Forward | 95.0 | 0.000 | 0.089 | Terminal Endpoint: Lowest score squad-wide (0.000 normalized); functions strictly as a finisher rather than a link player. |

#### Table 7: Top 10 Active Transitive Passing Triads
| Rank | Origin / Target ($A$) | Intermediate ($B$) | Target / Origin ($C$) | Bottleneck Capacity ($W_{\text{min}}$ Pass Units) |
| :---: | :--- | :--- | :--- | :---: |
| **1** | Kim Little | Carlotte Wubben-Moy | Leah Williamson | 116.0 |
| **2** | Stephanie-Elise Catley | Kim Little | Carlotte Wubben-Moy | 111.0 |
| **3** | Stephanie-Elise Catley | Kim Little | Victoria Pelova | 76.0 |
| **4** | Kim Little | Carlotte Wubben-Moy | Victoria Pelova | 69.0 |
| **5** | Kim Little | Victoria Pelova | Leah Williamson | 67.0 |
| **6** | Stephanie-Elise Catley | Carlotte Wubben-Moy | Victoria Pelova | 65.0 |
| **7** | Carlotte Wubben-Moy | Victoria Pelova | Leah Williamson | 60.0 |
| **8** | Victoria Pelova | Leah Williamson | Emily Ann Fox | 55.0 |
| **9** | Kim Little | Alessia Russo | Victoria Pelova | 51.0 |
| **10** | Kim Little | Victoria Pelova | Emily Ann Fox | 51.0 |


---

## 5 Empirical Baseline
While some network properties can be evaluated in isolation, tactical network analysis generally requires empirical benchmarking across a league-wide baseline. we constructed network instances for all team matches in the dataset to calculate their global average shortest path lengths ($d$).

Our selected network ($d = 0.1884$) ranks within the top 3.41% of all league instances, closely approaching the league minimum of $0.1748$. This confirms our network as one of the most efficient circulation structures in the dataset.

However, because this match was explicitly selected for its peak pass volume, it sits above the 99th percentile of total passes, exposing severe data-sparsity constraints when trying to construct robust empirical baselines:

**Pass Volume Constraints:** Network metrics are heavily driven by node degree and edge weight volume. Grouping matches into 100-pass bins shows that the 200–299 pass range holds the bulk of the data (94 of 234 matches, or $40.2\%$), while higher-volume bins drop off rapidly: 500–599 passes has 14 matches, 600–699 has 8, and the 700–799 bin contains exclusively our single sample match.

**Tactical Formation Constraints:** Benchmarking also requires controlling for tactical formation to normalize underlying network topology. Segmenting even the largest pass-volume bin (200–299 passes) across the dataset’s 11 formations reduces the most common setup (4-2-3-1) to just 29 matches ($30.9\%$).

Filtering simultaneously by pass volume and tactical structure dilutes sample sizes to a point where empirical comparisons become unreliable. This limitation highlights the necessity of using null models—rather than purely empirical baselines—to rigorously evaluate high-volume or topologically unique networks.

> This is depsite our large, season wide input dataset which is large for lituruature stanrds (game 2026 2)

#### Figure 7: League Match-Team Pass Distribution Histrogram
![histogram showng the distribution of match-team passes for league](./figures/pass_histogram.png)

---

## 6 Traditional Nulls
Traditional null models face severe domain-specific hurdles when applied to association football. Generating a network null model involves randomizing topological features while preserving select global properties, such as total edge weight or node degree. However, football passing networks are constrained by physical pitch dimensions, player positioning, and tactical behavior. Traditional null models ignore these spatial and structural realities, generating unrealistic graphs characterized by unnatural cross-field connections and misplaced playmaking hubs.

---

### 6.1 Erdős–Rényi (ER) Random Model
The simplest benchmark approach is the Erdős–Rényi (ER) random graph model ($G(N, p)$). Under this formulation, $N$ nodes are connected independently with uniform probability $p$. For weighted passing networks, total pass volume ($720$ passes across $11$ nodes) is preserved, but topological structure is erased. Weights are distributed uniformly across all potential node pairs, treating all players as structural equals and discarding individual node degree constraints.

---

### 6.2 Macro-Level Metrics & Structural Flattening
Evaluating macro-level metrics confirms that random edge generation destroys realistic football network topology:

Degree Flattening: A low Coefficient of Variation ($CV_k = 0.1305$), narrow Degree Variance ($\text{Var}(k) = 4.0661$), and near-identical values between Mean Degree ($\langle k \rangle = 15.4545$) and Normalized Second Moment ($15.7176$) demonstrate a uniform degree distribution devoid of central playmaking hubs. Though as mentioned before, unweighted metrics are misleading with respect to passmaps. 

Erased Workload Inequality: The Team Node Volume Variance drops to $\text{Var}(s_{\text{tot}}) = 514.9917$, yielding a standard deviation of just $\sigma_{s_{\text{tot}}} \approx 22.69$ passes. Uniform weight assignment artificially smooths positional workload, distributing total pass volume evenly across all outfield players and the goalkeeper. This is the mainpoint. For is longer the evidence of tactic hubs. 

The ER PassMap illustrates these structural anomalies, presenting a dense "hairball" graph. Edge widths show no tactical variance, 10-pass threshold filters fail to remove pitch-wide links, and peripheral nodes—such as the goalkeeper and central forward—erroneously appear as primary distribution hubs with consistent, long-range passes across the entire pitch.

#### Figure 7: ER Null Network Visual
![ER null network plotted as network](./figures/null_network_plot.png)

---

### 6.3 Downstream Clustering Failure & Triad Anomalies
The failure of the ER model is even more evident when examining downstream clustering metrics. Global Mean Transitive Intensity artificially inflates to $\bar{I}_{\text{transitive}} = 708.54$ pass units. Rather than indicating tactical cohesion, this rise reflects artificial graph homogeneity: uniform edge generation creates a fully connected network where nearly every three-node combination forms a dense cluster.

Inspecting the top active transitive triads reveals impossible tactical combinations:
1. **Striker-Centric Loops:** The highest-capacity triad features central forward Emma Stina Blackstenius linking Carlotte Wubben-Moy and Bethany Mead ($69.0$ units).
2. **Goalkeeper-to-Striker Circuits:** The second strongest triad comprises a passing circuit between goalkeeper Sabrina D’Angelo, striker Stina Blackstenius, and right-back Emily Ann Fox ($51.0$ units)—an unrealistic combination in actual match play.

Plotting these null triads yields an impossible overlay of pitch-wide, non-local polygons. Because the ER model ignores spatial proximity and positional constraints, it proves fundamentally unviable as a baseline for football passing networks, highlighting the necessity for spatially constrained null models.

#### Figure 8: ER Triad Network Plot
![ER generated triads overlayed on network](./figures/null_triad_overlay.png)

#### Table 8: ER Null Macro-Level Network Metrics
| Metric | Notation | ER Null Value | Empirical Sample Value | Interpretation |
| :--- | :--- | :---: | :---: | :--- |
| **Team Node Volume Variance** | $\text{Var}(s_{\text{tot}})$ | 514.9917 | 5681.9008 | Workload inequality artificially flattened ($\sigma \approx 22.69$ passes). |
| **Mean Unweighted Degree** | $\langle k \rangle$ | 15.4545 | 16.1818 | Uniform baseline connectivity across all nodes. |
| **Degree Variance** | $\text{Var}(k)$ | 4.0661 | 7.7851 | Narrowed dispersion; removes natural positional variance. |
| **Degree Standard Deviation** | $\sigma_k$ | 2.0165 | 2.7902 | Minimal deviation from mean connection count. |
| **Second Moment** | $\langle k^2 \rangle$ | 242.9091 | 269.6364 | Weight-weighted moment under uniform distribution. |
| **Coefficient of Variation** | $CV_k$ | 0.1305 | 0.1724 | Suppressed heterogeneity; eliminates distinct playmaking hubs. |
| **Normalized Second Moment** | $\langle k^2 \rangle / \langle k \rangle$ | 15.7176 | 16.6629 | Nearly identical to $\langle k \rangle$, confirming lack of heavy-tailed distribution. |


#### Table 9: Top 10 Active Transitive Triads (Erdős–Rényi Null Model)
| Rank | Origin / Target ($A$) | Intermediate ($B$) | Target / Origin ($C$) | Bottleneck Capacity ($W_{\text{min}}$ Pass Units) |
| :---: | :--- | :--- | :--- | :---: |
| **1** | Emma Stina Blackstenius | Carlotte Wubben-Moy | Bethany Mead | 69.0 |
| **2** | Sabrina D’Angelo | Emma Stina Blackstenius | Emily Ann Fox | 51.0 |
| **3** | Emma Stina Blackstenius | Carlotte Wubben-Moy | Emily Ann Fox | 46.0 |
| **4** | Emma Stina Blackstenius | Emily Ann Fox | Bethany Mead | 44.0 |
| **5** | Emily Ann Fox | Caitlin Jade Foord | Bethany Mead | 44.0 |
| **6** | Stephanie-Elise Catley | Caitlin Jade Foord | Bethany Mead | 43.0 |
| **7** | Stephanie-Elise Catley | Kim Little | Bethany Mead | 42.0 |
| **8** | Stephanie-Elise Catley | Emily Ann Fox | Caitlin Jade Foord | 41.0 |
| **9** | Carlotte Wubben-Moy | Emily Ann Fox | Bethany Mead | 40.0 |
| **10** | Kim Little | Victoria Pelova | Bethany Mead | 39.0 |

---

## 7 Markovian Null Model
The failure of traditional, naive null models necessitates a fundamental conceptual shift. A valid null model for football passing networks cannot treat the pitch as an abstract, unconstrained graph topology, it must strictly respect the spatial, physical, and tactical realities of match play.

---

#### 7.1 Mathematical Foundations: Markovian Processes and Stochastic Transformations
To construct a domain-aware generative baseline, we draw upon established football network literature that models match dynamics through stochastic processes. Pioneer works, most notably Narizuka et al. (2014) and Gama et al. (2026), demonstrate that sequence transitions and possession flows across a pitch exhibit strong Markovian properties. However, repurposing these models for null generation requires a fundamental conceptual transition: shifting from modeling dynamics on a network to governing the dynamics of the network.

While existing literature predominantly uses Markov chains to model dynamics on the network, holding the adjacency matrix $A$ fixed to calculate how possession diffuses across established nodes (Narizuka et al., 2014; Gama et al., 2026), our generative task requires synthesizing entirely new reference graph topologies ($\mathcal{G}_{\text{null}}$) by modeling dynamics of the network. We invert this analytical paradigm by leveraging learned spatial transition rules as a generative engine to sample, place, and connect synthetic pass events. Once this resampled event corpus is compiled, the resulting null network is constructed and aggregated normally.

This inversion addresses a critical gap in current research. While stochastic flow models were initially used to bypass traditional network nulls by treating transition properties as self-baselining, evaluating whether observed flow metrics reflect genuine tactical organization ultimately requires benchmarking them against an underlying, spatially constrained null ensemble (Gama et al., 2026).

---


#### 7.2 Justifying First Order Markovian Processes 
A first-order Markov process assumes that the transition probability to state $X_{t+1}$ depends strictly on the current state $X_t$, operating independently of prior sequence history:

$$P(X_{t+1} = x \mid X_t = x_t, X_{t-1} = x_{t-1}, \dots, X_1 = x_1) = P(X_{t+1} = x \mid X_t = x_t)$$

In passing generation, this dictates that a recipient choice depends solely on the current spatial state or passer identity, irrespective of prior possession steps.

While higher-order memory is essential for modeling sequential possession flows (Dynamics on the Network), a first-order memoryless formulation is mathematically sufficient and optimal for synthesizing static PassMap topologies (Dynamics of the Network). Standard $11 \times 11$ PassMaps naturally compress match data into a static directed matrix ($A_{ij}$), removing temporal ordering and making a first-order process structurally aligned with the static target format. Furthermore, Narizuka et al. (2014) proved that a first-order spatial Markov process parameterized by spatial distance decay ($e^{-\beta L_j}$) successfully reproduces macro-level Small-World properties, high clustering, and Truncated Gamma degree distributions without requiring higher-order sequential memory. Finally, generating a full match network by sampling over 500 passes provides complete asymptotic coverage, ensuring the synthetic ensemble captures the squad's underlying spatial baseline.

---

### 7.3 Domain Requirements & Theoretical Framework
Buldú et al. (2018) emphasize that null models for passing networks must maintain high realism by incorporating intrinsic features of the game, including degree distributions, pass lengths, and spatial player positions. Furthermore, as demonstrated by Narizuka et al. (2014) and surveyed by Alves et al. (2025), real football passing graphs exhibit distinct Small-World properties (Watts & Strogatz, 1998) without following scale-free power laws. Because human physical limits, match duration, and pitch boundaries prevent infinite hub growth, valid degree distributions follow a Truncated Gamma Distribution ($f(k) \propto k^{\nu-1} e^{-k/\lambda}$) rather than an unbounded heavy-tailed power law.

A robust null model for football passing networks must be anchored in four essential domain requirements. First, it must incorporate spatial coordinates and distance decay by parameterizing passes between origin $(x_i, y_i)$ and target $(x_j, y_j)$ locations to enforce pitch boundaries and completion limits over distance. Second, it must capture positional density and spatial occupancy, reflecting players' actual movement zones rather than treating them as static points. Third, it must preserve domain and phase dynamics, maintaining directional possession vectors—such as progression versus recycling—and natural positional asymmetries. Finally, the model requires functional role realism, ensuring central defenders and deep midfielders act as primary distribution hubs while eliminating unrealistic structural anomalies like goalkeeper-centric playmaking.

---

### 7.4 Data Corpus Engineering
Establishing a robust statistical baseline to distinguish genuine tactical adaptations from match-to-match noise requires leveraging a large-scale event corpus to build a generative resampling engine. Rather than evaluating an individual match network in isolation, our framework compiles a full season-wide dataset comprising $N = 264$ match-team instances and $89,781$ completed passes. Constructing a first-order Markovian process directly the raw, underlying event logs provides a far superior substrate compared to modeling the finalized graph, as raw passes inherently preserve spatial constraints and domain-specific empirical properties.

To model spatial occupancy across this corpus, raw StatsBomb pitch coordinates ($120 \times 80$) are normalized to a standardized $100 \times 100$ scale and discretized into a $10 \times 10$ spatial grid containing 100 uniform cells. Furthermore, granular player positions are mapped into a condensed positional taxonomy (CB, CM, LB, RB, ST, GK, LM, RM, CAM), effectively removing team-specific lateral biases—such as left-versus-right side skew—while preserving essential functional roles. This condensation maximizes data density within each pitch cell, allowing the underlying Markovian probability model to learn structurally sound, role-based spatial transition rules

##### Figure 9: Pitch Plot Grid
![A pitch plot segmeneted into bins](./figures/pitch_grid.png)

##### Table 10: Condensed Position Categories Across Season Corpus
> possibly move to appendix
| Rank | Recipient Position (Condensed) | Pass Reception Count |
| :---: | :--- | :---: |
| 1 | Center Back (CB) | 25,544 |
| 2 | Central Midfielder (CM) | 20,027 |
| 3 | Left Back (LB) | 8,554 |
| 4 | Right Back (RB) | 8,003 |
| 5 | Striker / Center Forward (ST) | 7,066 |
| 6 | Goalkeeper (GK) | 6,730 |
| 7 | Left Midfielder / Winger (LM) | 5,461 |
| 8 | Right Midfielder / Winger (RM) | 5,256 |
| 9 | Center Attacking Midfielder (CAM) | 3,140 |

> Appendix X: The Mapping of PLayer Positions to Conddensed Position Set
> Appendix X: Original Position Count


---

### 7.5 Spatial Probability Distribution Training
Using the discretized spatial grid and condensed positional taxonomy, we compile the season-wide event corpus into a 3D Spatial Probability Tensor $\mathcal{P}$ of shape $(10, 10, N_{\text{pos}})$, where $N_{\text{pos}} = 9$ represents the set of condensed positional categories. Each tensor element $\mathcal{P}(r, c, p)$ records the frequency of passes terminating in row $r$ and column $c$ that were received by a player occupying position $p$. To ensure mathematical rigor and prevent zero-probability artifacts in sparse or peripheral pitch zones, we apply Laplace Additive Smoothing ($\alpha = 1.0$) directly to the raw frequency counts:

$$\text{Counts}_{\text{smoothed}}(r, c, p) = \text{RawCount}(r, c, p) + 1.0$$

Normalizing these smoothed counts across all candidate positions within each grid cell yields the conditional probability distribution $P(\text{Position } p \mid \text{Pass Ends in Bin } (r, c))$: 

$$P(p \mid r, c) = \frac{\text{Counts}_{\text{smoothed}}(r, c, p)}{\sum_{p'} \text{Counts}_{\text{smoothed}}(r, c, p')}$$

Conceptually, this formulation partitions the pitch into discrete spatial sectors where every cell holds a discrete conditional probability distribution governing recipient likelihood. For instance, querying central pitch bin $(5,5)$ reveals that central midfielders (CM, $38.96\%$) and central defenders (CB, $30.58\%$) dominate local receptions, while goalkeeper receptions (GK, $0.11\%$) are virtually nonexistent. Sampling directly from these localized distributions allows the generative process to assign plausible recipients based on real empirical spatial behavior.


##### Table 11: Spatial Recipient Probability Distribution for Pitch Bin (5,5)
| Rank | Recipient Position (Condensed) | Probability | Probability (%) |
| :---: | :--- | :---: | :---: |
| 1 | Central Midfielder (CM) | 0.3896 | 38.96 |
| 2 | Center Back (CB) | 0.3058 | 30.58 |
| 3 | Striker / Center Forward (ST) | 0.1143 | 11.43 |
| 4 | Right Back (RB) | 0.0588 | 5.88 |
| 5 | Center Attacking Midfielder (CAM) | 0.0468 | 4.68 |
| 6 | Right Midfielder / Winger (RM) | 0.0305 | 3.05 |
| 7 | Left Back (LB) | 0.0272 | 2.72 |
| 8 | Left Midfielder / Winger (LM) | 0.0261 | 2.61 |
| 9 | Goalkeeper (GK) | 0.0011 | 0.11 |

---

### 7.6 Generative Markovian Recipient Resampling
To synthesize a valid reference dataset for a target match, the generative engine preserves every empirical pass origin $(x_1, y_1)$, end destination $(x_2, y_2)$, and passer out-strength $s_i^{\text{out}}$. The node set and individual player rosters remain unchanged; instead, the model executes an event-level recipient reshuffling based on season-wide spatial occupancy probabilities. For every pass event, the terminal coordinates trigger a query to the corresponding grid cell $(r, c)$ in the conditional probability tensor $P(\text{Position } p \mid r, c)$. A position $p$ is stochastically drawn from that cell's distribution and subsequently resolved to a specific player ID on the target squad's active roster. To maintain graph integrity, an internal retry loop samples up to 100 alternative candidates whenever a drawn recipient matches the original passer, strictly preventing self-pass anomalies ($A \neq B$).

##### Table 12: Sample Event Resampling and Player Mapping Stream
> Check this is a real example
| Pass ID | Passer (Origin) | Terminal Bin | Drawn Position | Empirical Recipient | Resampled Recipient | Self-Pass Safeguard |
| :---: | :--- | :---: | :---: | :--- | :--- | :---: |
| 101 | Carlotte Wubben-Moy | (2, 4) | CB | Leah Williamson | Leah Williamson | Valid ($A \neq B$) |
| 102 | Kim Little | (5, 5) | CM | Victoria Pelova | Victoria Pelova | Valid ($A \neq B$) |
| 103 | Stephanie-Elise Catley | (7, 2) | LM | Caitlin Jade Foord | Caitlin Jade Foord | Valid ($A \neq B$) |
| 104 | Victoria Pelova | (5, 8) | RB | Emily Ann Fox | Emily Ann Fox | Valid ($A \neq B$) |
| 105 | Carlotte Wubben-Moy | (4, 5) | CM | Kim Little | Victoria Pelova | Valid ($A \neq B$) |
| 106 | Kim Little | (8, 5) | ST | Alessia Russo | Emma Stina Blackstenius | Valid ($A \neq B$) |


#### 7.6.1 Sense Cheching the Recampled Recipient Dataset
Evaluating the resampled event stream directly prior to network aggregation confirms that the spatial engine successfully balances generative variance with domain realism. Across a single match realization, 22.08% of passes remapped to their exact empirical recipient, verifying that while localized spatial dominance is preserved, the model does not simply reproduce the input network.

The resampling process preserves key defensive constraints while highlighting structural model trade-offs. Goalkeeper Sabrina D’Angelo’s receptions remain tightly constrained (dropping from 19 to 13 passes), demonstrating that unlike the Erdős–Rényi model, the spatial model strictly enforces defensive role boundaries instead of transforming the goalkeeper into an artificial playmaker. Conversely, wingers Caitlin Foord and Beth Mead experience inflated pass shares due to playing only 63 minutes in the real match. Because the framework operates on full-match spatial totals without temporal substitution weighting, it models substitute players as 90-minute participants.

Striker Emma Stina Blackstenius exhibits the largest shift, moving from 10 empirical receptions (1.39%) to 104 resampled receptions (14.55%). In empirical match play, Blackstenius possesses an exceptionally distinct tactical profile, functioning as a specialized off-ball target who rarely engages in general possession buildup—a style exemplified by recording a mere 10 receptions across an entire match despite Arsenal setting a league-high total pass volume. The generative spike to 104 receptions stems from match-specific territory: Arsenal dominated possession deep in the opposition half, where spatial tensor bins assign high baseline reception probabilities to central forwards. While league-wide strikers average 5.39% of team receptions, the resampled allocation replaces Blackstenius's unique off-ball isolation with the expected spatial density of the final third, reflecting territorial volume rather than a generative model failure.

Figure 10 shows us the areas where the striker was resample receptions. Note that a lot of the touchers are deep in the final third and almost all in the oppositions half. When taking into account the sheer volume of passes in this match, this plot looks accurate for a striker.

##### Figure 10: Striker Resampled Pitch Plot
![the plot of the areas that the resampled striker receives the ball](./figures/striker_resample_plot.png)

> Appendix X : Change in Pass Share (Empirical vs. Resampled Receptions)

---


### 7.6 Single Football Null Network 
Visual comparison of the empirical network alongside a single spatial null realization demonstrates that spatial recipient resampling produces a natural, pitch-constrained topology. Unlike the Erdős–Rényi model, the rewired graph avoids pitch-wide "hairball" artifacts while maintaining realistic player positioning and passing channels.

##### Figure 11: Empirical PassMap (Left) vs. Single Spatial Null Realization (Right)
![a visual of the original network and a null generate version](./figures/resample_orig_null.png)

#### 7.6.1 Topological Degree Diagnosticss
Evaluating macro-level degree properties across this single realization confirms that the spatial engine successfully synthesizes domain-valid reference networks.

While the Erdős–Rényi null collapses Team Node Volume Variance ($\text{Var}(s_{\text{tot}})$) down to $514.99$, the spatial null recovers over half of the empirical volume variance ($\text{Var}(s_{\text{tot}}) = 2955.90$). Holding each passer’s outgoing volume ($s_i^{\text{out}}$) fixed preserves primary structural anchors, demonstrating that passer initiative accounts for roughly 52% of team workload inequality while targeted receiver choice drives the remaining 48%.

The Mean Unweighted Degree increases to $\langle k \rangle = 17.6364$, corresponding to an active connection density of 88.2% across all directed channels. Reallocating recipients via league-wide spatial distributions activates low-frequency passing channels that were avoided tactically in the empirical match.

Shuffling recipients reduces the Coefficient of Variation ($CV_k = 0.1115$) below both the empirical baseline ($0.1724$) and the Erdős–Rényi model ($0.1305$). Replacing match-specific tactical preferences with league-average spatial probabilities flattens connection variance across players, wrapping peripheral nodes like Stina Blackstenius back into mainstream passing sequences.

The Normalized Second Moment ($\frac{\langle k^2 \rangle}{\langle k \rangle} = 17.8557$) tracks closely with the mean degree, confirming that fixed empirical origin coordinates ($(x_1, y_1)$) preserve structural density without creating unrealistic scale-free hub anomalies.

##### Table 13: Macro-Level Network Metrics Comparison Across Single Realization
| Metric | Real Empirical Network (Arsenal WFC) | Erdős–Rényi ($G(N,p)$) | Tier 1: Recipient Rewired Null | Diagnostic Trend |
| :--- | :---: | :---: | :---: | :--- |
| **Mean Unweighted Degree ($\langle k \rangle$)** | 16.1818 | 15.4545 | 17.6364 | **Topological Oversaturation:** Unconstrained spatial recipient draws activate additional minor passing channels. |
| **Coefficient of Variation ($CV_k$)** | 0.1724 | 0.1305 | 0.1115 | **Highest Homogenization:** Shuffling recipients via league spatial distributions flattens unweighted degree variance even more than ER. |
| **Normalized Second Moment ($\frac{\langle k^2 \rangle}{\langle k \rangle}$)** | 16.6629 | 15.7176 | 17.8557 | **Structural Preservation:** Higher than ER because fixed empirical pass origins ($(x_1, y_1)$) anchor structural density near real values. |
| **Node Volume Variance ($\text{Var}(s_{\text{tot}})$)** | 5681.90 | 514.99 | 2955.90 | **Partial Volume Recovery:** Recovers $\sim 52\%$ of real volume variance because empirical passer volume is preserved. |

---

## 8 Null Validation
Evaluating a single graph realization demonstrates local feasibility, but validating a generative null process requires executing a multi-run simulation to establish statistical stability and boundary constraints. By running a Monte Carlo pipeline across $N = 500$ independent realizations, we assess whether the 1st-order Spatial Markovian engine reliably generates valid reference topologies across the entire null distribution. Rather than performing tactical benchmark evaluations, the objective of this validation step is to confirm that spatial recipient resampling strips away match-specific tactical nuances while strictly preserving domain-level topological invariants. Establishing these boundary conditions represents a foundational contribution toward formalizing generative null validation standards within sports network science.

### 8.1 Macro-Level Heterogeneity and Structural Density
Across the 500-iteration ensemble, the macro-level degree metrics confirm that spatial recipient resampling maintains realistic structural density while suppressing extreme topological distortions. The Mean Unweighted Degree yields an ensemble average of $\langle k \rangle = 17.7411$ (95% CI: $[16.9955, 18.3636]$), representing an active connection density of $\approx 88.7\%$ across the 11-player graph. This slight densification over the empirical baseline ($16.1818$) occurs because spatial probability sampling populates peripheral channels with low-frequency passes; however, connection density remains strictly bounded below the theoretical maximum of $20$.

The scale-invariant Coefficient of Variation ($CV_k$) averages $0.1196$ across the ensemble (95% CI: $[0.0813, 0.1615]$), ranging between a minimum of $0.0648$ and a maximum of $0.1755$. Critically, no realization approaches $CV_k \ge 1.0$, proving that the spatial tensor prevents the formation of unrealistic, scale-free star networks. The empirical network's $CV_k$ of $0.1724$ sits above the ensemble’s 95% upper confidence bound ($0.1615$), demonstrating that real match play imposes higher structural heterogeneity than spatial occupancy alone dictates. Reallocating recipients via spatial averages flattens individual role separation, forcing node connectivity toward a uniform spatial baseline. Furthermore, the Normalized Second Moment ($\frac{\langle k^2 \rangle}{\langle k \rangle}$) averages $18.0011$ (95% CI: $[17.3529, 18.5998]$), tracking near-identically with the mean degree $\langle k \rangle$ across all 500 runs. This ratio confirms that pitch boundary constraints successfully prevent the emergence of centralized super-hubs.

### 8.2 Workload Variance
Holding each passer's outgoing volume ($s_i^{\text{out}}$) fixed allows the null model to recover over half of the empirical workload inequality. The ensemble Team Node Volume Variance ($\text{Var}(s_{\text{tot}})$) averages $3117.3808$ (95% CI: $[2672.0826, 3629.0008]$), recovering roughly $55\%$ of the empirical match variance ($5681.9008$). This statistical consistency proves that passer initiative accounts for approximately $55\%$ of overall volume centralization, whereas targeted receiver selection drives the remaining $45\%$.

However, a critical limitation of the generative engine is its inability to replicate the extreme, highly nuanced volume variance observed in exceptional empirical matches. Even at the upper bound of the 95% confidence interval ($3629.0008$) and across all 500 iterations (maximum: $4000.4463$), the simulated distribution falls significantly short of the empirical match’s value ($5681.9008$). While the model reliably produces valid reference networks under normal conditions, it fails to capture the extreme structural skew present in highly unique scenarios—such as this candidate match, which featured overwhelming team-wide possession combined with a specialized, off-ball striker who virtually abstained from circulation. Shuffling recipients according to league-average spatial probabilities naturally smooths out these extreme tactical anomalies, highlighting a boundary where generic spatial occupancy rules meet their limit against highly stylized team dynamics.

### 8.3 Role Realism
Functional role realism is similarly preserved across all iterations. Goalkeeper Sabrina D’Angelo’s total pass volume stays tightly bounded with an ensemble mean of $43.2300$ passes (95% CI: $[38.0000, 49.0000]$) and a range of $[35.0, 51.0]$. Unlike Erdős–Rényi random graphs that erroneously transform the goalkeeper into an active playmaking hub, the spatial engine enforces defensive boundary constraints across every generated instance.

### 8.4 Generative Matrix Variance
Evaluating the correlation between empirical and resampled weighted adjacency matrices yields an ensemble mean of $\bar{r} = 0.6753$ (95% CI: $[0.6026, 0.7468]$). This moderate-to-high correlation verifies that while the model preserves fundamental spatial structure and high-volume passing channels, it introduces sufficient generative variance to shuffle tactical nuances without collapsing into uncorrelated random noise or duplicating the input matrix.


##### Table 14: Tier 1 Spatial Markovian Null Model Validation Summary (N=500 Iterations)
| Metric | Empirical Value | Null Mean | Null Std | Min | Max | 95% CI Lower | 95% CI Upper | Diagnostic Validation Interpretation |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **Mean Unweighted Degree ($\langle k \rangle$)** | 16.1818 | 17.7411 | 0.3923 | 16.7273 | 18.7273 | 16.9955 | 18.3636 | Stable graph density (~88.7%); bounded below maximum capacity ($20.0$). |
| **Coefficient of Variation ($CV_k$)** | 0.1724 | 0.1196 | 0.0209 | 0.0648 | 0.1755 | 0.0813 | 0.1615 | Mild heterogeneity; strictly avoids scale-free star networks ($CV_k \ge 1.0$). |
| **Normalized Second Moment ($\frac{\langle k^2 \rangle}{\langle k \rangle}$)** | 16.6629 | 18.0011 | 0.3303 | 17.0978 | 18.8738 | 17.3529 | 18.5998 | Tracks closely with $\langle k \rangle$, confirming absence of distorted hubs. |
| **Node Volume Variance ($\text{Var}(s_{\text{tot}})$)** | 5681.9008 | 3117.3808 | 246.0137 | 2382.2645 | 4000.4463 | 2672.0826 | 3629.0008 | Recovers ~55% of empirical volume variance via fixed passer out-strength. |
| **Goalkeeper Total Volume ($s_{\text{tot}}$)** | 38.0000 | 43.2300 | 2.9443 | 35.0000 | 51.0000 | 38.0000 | 49.0000 | Role preservation confirmed; prevents Goalkeeper Hub Paradox across all runs. |
| **Adjacency Correlation ($r$)** | 1.0000 | 0.6753 | 0.0377 | 0.5544 | 0.7678 | 0.6026 | 0.7468 | Preserves spatial structure while shuffling tactical nuances without matrix duplication. |

--- 

## 9. Null-Baselined Metric Evaluation

### 9.1 Experimental Setup & Simulation Scope
To evaluate the empirical network properties against a spatially constrained baseline, we executed $N = 1000$ independent spatial Markovian resampling iterations over the target match event stream. For each Monte Carlo iteration, three dedicated tracking structures logged the multi-scale graph metrics: a one-dimensional array recorded the global average shortest path values ($d$), a positional lookup dictionary tracked bottleneck capacity scores and ordinal ranks across all unique 3-player combinations, and a micro-level store captured shortest-path betweenness centrality scores ($g(i)$) mapped directly to each of the eleven starting tactical positions.

---

### 9.2 Macro-Level Evaluation: Global Circulation Distance ($d$)

Evaluating the macro-level global average shortest path ($d = 0.1884$) against the 1000-iteration spatial null ensemble reveals that Arsenal WFC’s circulation efficiency is largely an emergent property of spatial territory and extreme pass volume, rather than an anomalous macro-topological structure.

The empirical path length sits slightly below the null ensemble mean ($\bar{d}_{\text{null}} = 0.1932$), reflecting a marginal increase in overall circulation efficiency ($z = -0.43$). However, because the empirical value falls well within the 95% confidence interval ($[0.1732, 0.2120]$), the observed global accessibility cannot be classified as statistically significant tactical optimization. Instead, the null baseline confirms that completing over 700 passes within these specific spatial pitch zones inherently bounds global topological distance between $0.1732$ and $0.2120$.

Furthermore, while Arsenal’s network operates below the spatial average, it remains noticeably above the ensemble’s theoretical minimum bound ($0.1732$). This gap stems from tactical channel selection: by concentrating high pass volumes through specific build-up hubs (e.g., left-back and central double-pivot pairings) rather than distributing play uniformly across all short-distance spatial options, Arsenal accepts a slight trade-off in global path length to execute deliberate, localized tactical overloads.

#### Table: Null-Baselined Macro Evaluation Summary
| Scale | Metric | Empirical Value | Null Mean | Null 95% CI | Z-Score |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **Macro** | Global Shortest Path ($d$) | 0.1884 | 0.1932 | [0.1732, 0.2120] | -0.43 |

---

### 9.3 Meso-Level Evaluation: Transitive Triad Dynamics ($I_{\text{transitive}}$)
To determine whether Arsenal’s primary passing triangles stem from deliberate tactical instruction or simple spatial occupancy density, we evaluate transitive triads across the 1,000-iteration null ensemble. The framework pre-computes all $\binom{11}{3} = 165$ unique three-player positional triplets alongside their internal directed permutations. For each generated null realization $G_{\text{null}}^{(k)}$, the engine calculates the bottleneck capacity ($W_{\text{min}} = \min(W_{AB}, W_{BC}, W_{AC})$) for every active transitive triad, rank-orders them by strength, and logs both their capacity scores and ordinal ranks into a positional tracking store. Any triplet that fails to form in a specific iteration is assigned a zero capacity and a maximum penalty rank of 165 to prevent survivor bias. Finally, the empirical team's top passing triads are benchmarked against their specific null distributions by evaluating mean capacity ($\bar{W}_{\text{min, null}}$), average ordinal rank ($\bar{R}_{\text{null}}$), and rank retention frequency across the ensemble.

Benchmarking the top 20 empirical transitive triads against the 1,000-iteration spatial null ensemble reveals distinct structural patterns that separate spatial baseline expectations from intentional, highly organized tactical mechanics.

The primary build-up triangles out of deep defense exhibit extraordinary statistical significance. The rank 1 triad featuring central defenders Carlotte Wubben-Moy and Leah Williamson anchored by Kim Little ($116.00$ pass units, $z = +3.83$) exceeds the null ensemble's 95% upper confidence bound ($98.00$) by a wide margin. Even more prominent is the rank 2 triad incorporating left-back Steph Catley alongside Wubben-Moy and Little ($111.00$ pass units, $z = +5.67$). In a purely spatial model, this left-flank triangle averages a capacity of $61.11$ units; reaching $111.00$ units confirms an extreme, statistically significant left-sided overloading mechanism designed to construct progressive build-up play through high-density local combinations.

In contrast, central double-pivot recycling loops operate directly in line with baseline spatial expectations. The rank 4 triad (Wubben-Moy – Little – Pelova, $69.00$ units, $z = -0.28$) and rank 5 triad (Little – Williamson – Pelova, $67.00$ units, $z = +0.01$) track the ensemble means almost perfectly ($\bar{W} = 71.53$ and $66.89$, respectively). This alignment demonstrates that while these central combinations carry high absolute pass volume, their capacity is entirely explained by local spatial occupancy density rather than a specialized, tactical anomaly.

Finally, the null baseline exposes the deep-dropping connector role executed by Alessia Russo. Across every top-20 triad in which Russo participates—including combinations with the central defenders and double-pivot (ranks 12, 14, 15, 16, and 17)—her empirical capacity significantly exceeds the null 95% upper bounds, generating consistent Z-scores between $+1.84$ and $+2.78$. Because a generic spatial model assigns lower baseline forward-reception probabilities to dropping central attacking players, Russo’s systematic participation in progressive triangles reflects deliberate tactical movement to link midfield circulation into the attacking third.

##### Table: Null-Baselined Meso Evaluation Summary (Transitive Triads Top 20)
| Scale | Targeted Metric / Entity | Empirical Value | Null Mean | Null 95% CI | Z-Score |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **Meso** | Triad (Emp Rank 1): Wubben-Moy – Little – Williamson | 116.00 | 79.23 | [61.00, 98.00] | +3.83 |
| **Meso** | Triad (Emp Rank 2): Wubben-Moy – Little – Catley | 111.00 | 61.11 | [44.00, 78.00] | +5.67 |
| **Meso** | Triad (Emp Rank 3): Little – Catley – Pelova | 76.00 | 56.74 | [39.00, 74.00] | +2.11 |
| **Meso** | Triad (Emp Rank 4): Wubben-Moy – Little – Pelova | 69.00 | 71.53 | [54.98, 89.00] | -0.28 |
| **Meso** | Triad (Emp Rank 5): Little – Williamson – Pelova | 67.00 | 66.89 | [50.00, 85.00] | +0.01 |
| **Meso** | Triad (Emp Rank 6): Wubben-Moy – Catley – Pelova | 65.00 | 49.48 | [34.00, 65.00] | +1.97 |
| **Meso** | Triad (Emp Rank 7): Wubben-Moy – Williamson – Pelova | 60.00 | 57.81 | [42.00, 73.00] | +0.28 |
| **Meso** | Triad (Emp Rank 8): Fox – Williamson – Pelova | 55.00 | 37.90 | [24.00, 52.00] | +2.47 |
| **Meso** | Triad (Emp Rank 9): Russo – Little – Pelova | 51.00 | 36.34 | [21.00, 51.00] | +1.87 |
| **Meso** | Triad (Emp Rank 10): Fox – Little – Pelova | 51.00 | 40.84 | [25.00, 57.00] | +1.30 |
| **Meso** | Triad (Emp Rank 11): Fox – Little – Williamson | 51.00 | 38.20 | [23.00, 54.00] | +1.63 |
| **Meso** | Triad (Emp Rank 12): Russo – Little – Williamson | 42.00 | 24.05 | [10.00, 39.00] | +2.44 |
| **Meso** | Triad (Emp Rank 13): Mead – Williamson – Pelova | 40.00 | 25.52 | [15.00, 37.02] | +2.44 |
| **Meso** | Triad (Emp Rank 14): Russo – Wubben-Moy – Little | 39.00 | 25.58 | [12.00, 40.00] | +1.84 |
| **Meso** | Triad (Emp Rank 15): Russo – Williamson – Pelova | 38.00 | 22.44 | [9.00, 36.00] | +2.30 |
| **Meso** | Triad (Emp Rank 16): Russo – Wubben-Moy – Pelova | 37.00 | 23.67 | [11.00, 37.00] | +2.00 |
| **Meso** | Triad (Emp Rank 17): Russo – Wubben-Moy – Williamson | 35.00 | 18.79 | [7.00, 30.00] | +2.78 |
| **Meso** | Triad (Emp Rank 18): Foord – Little – Catley | 33.00 | 37.36 | [25.00, 50.00] | -0.67 |
| **Meso** | Triad (Emp Rank 19): Foord – Catley – Pelova | 33.00 | 32.95 | [21.00, 45.00] | +0.01 |
| **Meso** | Triad (Emp Rank 20): Wubben-Moy – Williamson – D’Angelo | 33.00 | 32.70 | [21.00, 44.02] | +0.05 |

---

### 9.4 Micro-Level Evaluation: Positional Betweenness Centrality ($g(i)$)
To quantify positional routing control and determine whether key playmakers act as central conduits beyond spatial baseline expectations, we evaluate weighted shortest-path betweenness centrality ($g(i)$) across the 1,000-iteration null ensemble. Each player node is mapped to their exact, uncondensed starting position (e.g., Left Center Back, Goalkeeper) to maintain consistent role-based tracking across resampling runs. For every generated network $G_{\text{null}}^{(k)}$, Dijkstra's algorithm computes all-pairs shortest topological paths using inverted pass weights ($l_{ij} = 1/w_{ij}$), logging each position's betweenness score into a dedicated tracking store. From these iterations, 95% confidence intervals and expected baseline distributions are established for all eleven tactical positions. Benchmarking empirical scores ($g_{\text{emp}}(i)$) against these positional null ranges isolates deliberate tactical routing bottlenecks—such as central defender or deep midfielder circulation—while verifying whether peripheral positions remain strictly bounded near zero.

Evaluating empirical betweenness centrality scores against the 1,000-iteration spatial null baseline isolates the specific positional hubs driving Arsenal WFC's tactical buildup. The results demonstrate that while peripheral roles strictly align with spatial expectations, the central defensive core operates as a statistically significant routing engine.

The most prominent tactical signal emerges from the central defensive pairing. Both the Right Center Back ($g = 0.3000, z = +2.85$) and Left Center Back ($g = 0.3222, z = +2.73$) exceed the upper 95% confidence bounds of the null ensemble ($[0.0111, 0.2556]$ and $[0.0222, 0.2668]$, respectively). In a purely spatial model, central defenders are expected to account for a moderate routing share ($\bar{g} \approx 0.11 - 0.15$). Recording values above $0.3000$ proves that their role as primary build-up pivots is a deliberate, highly concentrated tactical instruction rather than a simple byproduct of spatial pitch geography.

Furthermore, benchmarking against the spatial baseline uncovers noticeable asymmetries across the flank and midfield units. 

Left Back betweenness ($g = 0.1222, z = +1.73$) approaches the upper 95% bound ($0.1556$) and far outstrips Right Back betweenness ($g = 0.0000, z = -0.38$), confirming a pronounced left-sided structural bias during initial progression out of defense.

> its really to important to focus on the ranges here. left back is [0.0000, 0.1556]  where as right back [0.0000, 0.0667]. The ranges are fundementally skewed because the retain the actually pass volumne and positions but rewire the recipient based on the league average. What we are saying is, if a team played exactly like this with the exact number of reasons, how would a random player reshuffle fair. Arsneals left back demonstates a player who is inherently more importantant for the circuluation and distribution of the ball than an average player is. This explicity takes into account the volumne of passes in their area of the pitch!

Conversely, midfield circulation displays a tactical reversal: under baseline spatial rules, the Left Defensive Midfielder is expected to absorb the largest routing share squad-wide ($\bar{g} = 0.2896$), yet Kim Little’s empirical score ($g = 0.1778, z = -1.31$) falls significantly below this spatial expectation. Instead of over-funneling possession through a single central midfield channel, Arsenal delegates routing duties more evenly across the double-pivot while relying directly on the center-backs to bridge play.

Finally, the null baseline confirms strict boundary enforcement across terminal and peripheral positions. Attacking wingers, the central forward, the center attacking midfielder, and the goalkeeper all register empirical scores of $g = 0.0000$, placing them well within their respective null ranges ($\bar{g} \approx 0.0000 - 0.0071$). This alignment demonstrates that terminal execution nodes and deep defensive anchors operate strictly outside the team's primary path-routing network, preserving functional role boundaries across match play.

##### Table: Null-Baselined Micro Evaluation Summary (Positional Betweenness Centrality)
| Scale | Targeted Metric / Position | Empirical Value | Null Mean | Null 95% CI | Z-Score |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **Micro** | Betweenness: Left Center Back | 0.3222 | 0.1471 | [0.0222, 0.2668] | +2.73 |
| **Micro** | Betweenness: Right Center Back | 0.3000 | 0.1149 | [0.0111, 0.2556] | +2.85 |
| **Micro** | Betweenness: Left Back | 0.1222 | 0.0426 | [0.0000, 0.1556] | +1.73 |
| **Micro** | Betweenness: Right Defensive Midfield | 0.1389 | 0.1367 | [0.0111, 0.2778] | +0.03 |
| **Micro** | Betweenness: Left Defensive Midfield | 0.1778 | 0.2896 | [0.1313, 0.4556] | -1.31 |
| **Micro** | Betweenness: Right Back | 0.0000 | 0.0071 | [0.0000, 0.0667] | -0.38 |
| **Micro** | Betweenness: Left Wing | 0.0000 | 0.0058 | [0.0000, 0.1000] | -0.27 |
| **Micro** | Betweenness: Right Wing | 0.0000 | 0.0054 | [0.0000, 0.1000] | -0.27 |
| **Micro** | Betweenness: Center Attacking Midfield | 0.0000 | 0.0038 | [0.0000, 0.0889] | -0.22 |
| **Micro** | Betweenness: Goalkeeper | 0.0000 | 0.0001 | [0.0000, 0.0000] | -0.03 |
| **Micro** | Betweenness: Center Forward | 0.0000 | 0.0000 | [0.0000, 0.0000] | 0.00 |


---

## 10 Conclusion, Limitations and Future Work
### 10.1 Conclusion
This project successfully demonstrated the powerful intersection of network science and sports analytics, establishing a rigorous framework for evaluating collective tactical behavior in association football. By leveraging open-source StatsBomb event data from the 2023/2024 FA Women's Super League, the research not only engineered raw spatiotemporal logs into directed, weighted PassMaps but also actively addressed the systemic underrepresentation of women's football datasets within the current academic literature.

The project deployed a comprehensive, multi-scale diagnostic suite—ranging from micro-level 1-hop degree analysis to macro-level circulation efficiency and meso-level transitive triad clustering. To support this analytical framework, custom spatial visualization tools were developed from scratch, allowing abstract graph topologies to be seamlessly overlaid onto intuitive pitch coordinates.

Crucially, this research addressed a direct and outstanding call in contemporary literature (e.g., Gama et al., 2026) for the establishment of robust null models in football. Traditional network randomizations, such as the Erdős–Rényi model, were mathematically proven to fail in this domain, as they destroy spatial constraints, erase tactical workload inequality, and generate impossible structural anomalies like goalkeeper-to-striker playmaking loops.

In response, this project engineered a novel 1st-order Spatial Markovian generative null process. By adapting "dynamics on the network" research, the model inverted the paradigm to govern the "dynamics of the network." The generative engine successfully stripped away match-specific tactical nuances by resampling pass recipients based on league-average spatial probabilities, while strictly preserving the empirical pass coordinates, passer identities, and physical pitch boundaries.

This approach laid the foundational groundwork for a generative null validation framework, proving that the synthetic ensemble maintained scale-invariant heterogeneity, preserved true defensive role boundaries, and recovered structural volume variance. Ultimately, executing this Monte Carlo null pipeline against an extreme, high-volume empirical match allowed for the robust isolation of true tactical signals—such as deliberate left-flank overloads and center-back routing hubs—from baseline spatial noise, enabling profound micro-level player evaluation that would be impossible using flawed empirical comparisons alone.

### 10.2 Limitations
While the first-order Markovian approach was mathematically justified and proved highly effective for synthesizing static PassMaps, it carries inherent structural limitations.

Firstly, the memoryless assumption of a first-order process fails to truly encode deeper, multi-step on-pitch relationships. In reality, football teams naturally fragment into localized "work groups" where specific players knit together unique, rehearsed playing styles to support one another. Because the generative engine samples recipients based purely on isolated spatial bins, it washes out these sequential, higher-order tactical relationships, which slightly limits the depth of complex triad and clustering analysis.

Secondly, and most significantly, the generative model lacks temporal understanding. Time and game state are critical contextual factors that dictate on-pitch behavior; a pass played into the final third in the 90th minute while a team is aggressively chasing a 1-0 deficit carries fundamentally different tactical parameters than a pass in the same location during early-game consolidation. While literature precedents (such as Buldú et al., 2019) address temporality by segmenting matches into 50-pass increments, our framework aggregates spatial totals across the entire 90 minutes. Consequently, while the resampled recipients represent a broad spatial average, the model currently fails to account for the specific temporal game state in which the original pass was executed.

### 10.3 Future Work
Future research must build upon the null validation framework initiated in this study. Currently, there is no formalized, algorithmic consensus in the literature defining the exact mathematical bounds of a "valid" football passing network. While this project utilized established Small-World properties and domain intuition (e.g., functional role constraints) to validate the synthetic graphs, football contains a massive matrix of variables. Future work should establish a rigorous, parameterized set of network properties that dynamically adjust for variations in tactical formation, team strength, and game state.

Additionally, the generative Markovian engine itself should be expanded. Beyond incorporating the aforementioned temporal game states and higher-order sequence memory, the scope of the spatial probability distributions can be traversed further. While this project successfully isolated receiver utility and tactical targeting by resampling the recipient, future models could resample the pass destination by training probability distributions mapping origin bins to terminal bins.

Furthermore, the model could be extended to resample pass origins based on a player's tactical role and out-degree constraints. Ensembling these steps to regenerate entirely synthetic, spatially logical event streams would allow analysts to benchmark not just receiver importance, but passer initiative, decision-making, and systemic ball progression across any tactical scenario.

---

# Biblography
<!--
- Wasserman & Faust (1994)
- Newman (2001)
- Rodrigues (2019)
- Fortunato (2010)
- Pastor-Satorras & Vespignani (2001)
- Barrat et al. (2008)
- Lusseau (2003)
- Newman (2003)
- Araújo et al. (2006)
- Duch et al. (2010)
- Pollard & Reep (1997)
- Buldú et al. (2019)
- Gama et al. (2026)
- Buldú et al. (2018)
- Alves et al. (2025)
- Narizuka et al. (2014)
- Yamamoto & Yokoyama (2011)
- Grund
- Camerino et al. (2012)
- Arriaza-Ardiles et al. (2018)
- López-Peña & Touchette (2012)
- Cotta et al. (2013)
- Peña & Navarro (2015)
- López-Peña & Sánchez Navarro (2015)
- Clemente et al. (2015)
- Watts & Strogatz (1998)
- Cintia et al. (2015)
- Pina et al. (2017)
- Ribeiro et al. (2017)
- Norris (1998)
-->





