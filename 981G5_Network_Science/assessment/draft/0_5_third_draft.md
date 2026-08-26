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

### 4.1 Metric Suite
To systematically map network properties to footballing concepts, analysis is categorized into three structural scales: Macro, Meso, and Micro (Alves et al., 2025; Gama et al., 2026). This project targets a core suite of metrics across these scales to balance theoretical rigor with clear tactical interpretation.

Macro-scale analysis evaluates global team cohesion, structural fluidity, and spatial dominance across the entire graph (Watts & Strogatz, 1998; Cintia et al., 2015). We examine overall connectivity and structural skew through Unweighted Degree Heterogeneity ($CV_k$) and Team Node Volume Variance ($\text{Var}(s_{\text{tot}})$), alongside multi-step reachability via the Global Average Shortest Path ($d$).

Meso-scale analysis assesses localized sub-graphs and multi-player combinational passing channels (López-Peña & Sánchez Navarro, 2015). We quantify positional triangle strength and progressive build-up loops using Transitive Triad Intensity ($I_{\text{transitive}}$), ranking circuits by their operational bottleneck capacity ($W_{\text{min}}$).

Micro-scale analysis evaluates individual player workload, directional asymmetry, and routing control (López-Peña & Touchette, 2012; Buldú et al., 2019). We measure phase-transition control through Betweenness Centrality ($g(i)$) based on inverted topological distance ($l_{ij} = 1/w_{ij}$).

---

### 4.2 Degree-Based Metrics 
Degree-based metrics evaluate system topology using direct, 1-hop connections, avoiding global path-traversal costs to provide a computationally efficient proxy for tactical involvement and workload distribution (Narizuka et al., 2014).

Evaluating unweighted degree across our high-volume sample network yields a Mean Unweighted Degree of $\langle k \rangle = 16.18$, indicating high overall connectivity out of a theoretical maximum bound of 20. The low Coefficient of Variation ($CV_k = 0.1724$) and near-identical Normalized Second Moment ($\langle k^2 \rangle / \langle k \rangle = 16.66$) confirm that passing lanes are widely distributed across squad positions, eliminating absolute topological bottlenecks.

However, introducing weighted metrics highlights a critical tactical distinction between unweighted structural availability and actual operational execution. The high Team Node Volume Variance ($\text{Var}(s_{\text{tot}}) = 5,681.90$) reveals that while available passing channels are widespread on paper, pass workload is heavily skewed through specific targeted players.

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

### 4.3 Average Shortest Path ($d$)
In PassMaps, edge weights ($w_{ij}$) reflect completed passes from player $i$ to player $j$. Pass volume is a stronger indicator of connectivity than physical distance so edge weights are inverted to derive a topological distance:

$$l_{ij} = \frac{1}{w_{ij}}$$

This transformation ensures high-frequency passing channels yield lower topological resistance. Using Dijkstra’s algorithm, the shortest path ($p_{ij}$) between any pair of players represents the minimal cumulative cost required to move possession through the network.

The macro-level baseline of a team's passing structure is established by the global average shortest path length ($d$), defined as:

$$d = \frac{1}{N(N-1)} \sum_{i \neq j} p_{ij}$$

Arsenal WFC demonstrates strong circulation efficiency with a global path length of $d = 0.1884$, meaning the average cost to route possession between any two arbitrary players is less than $0.20$. Low path length ($d$) is a prerequisite of the Small-World phenomenon (Watts & Strogatz, 1998). In football, it indicates an integrated network capable of rapid ball circulation. However, evaluating $d = 0.1884$ in isolation is arbitrary and cannot confirm tactical superiority. This requires some form of statistical benchmarking.

#### Figure 3: Sample Network Player In & Out Average Shortest Path Scatterplot
![an scatter plot presenting players mean out path on the y-axis and mean in on the x-axis](./figures/asp_in_out_scatter.png)

---

### 4.4 Betweenness Centrality ($g(i)$)
To evaluate which players act as essential routing, Betweenness Centrality ($g(i)$) is analysed. Moving beyond volume, betweenness measures the proportion of a network's shortest topological paths ($l_{ij} = 1/w_{ij}$) traversing a given node, identifying possession flow:

$$g(i) = \sum_{s \neq i \neq t} \frac{\sigma_{st}(i)}{\sigma_{st}}$$

where $\sigma_{st}$ represents the total shortest paths between source player $s$ and target player $t$, and $\sigma_{st}(i)$ is the number of those paths passing through player $i$.

Providing deeper inference than 1-hop volume metrics, high scores denote players through whom phase transitions depend, whereas scores of $0.0000$ mark peripheral endpoints whose exclusion does not disrupt global network routing.

In our sample network, central defenders Lotte Wubben-Moy ($g(i) = 0.3222$) and Leah Williamson ($g(i) = 0.3000$) record the highest centrality, acting as primary structural pivots during recycling and build-up phases—a finding consistent with contemporary football network literature (Alves et al., 2025).

Interpreting betweenness in football requires a key domain-specific nuance. In classic network science, high betweenness denotes a central bottleneck bridge. In football, topological distance allows a physically longer route to represent an easier, low-resistance option. Therefore, the deep lying central defenders can behave as high centrality by recycling and re-route a phase of play.

Midfielders Kim Little ($0.1778$) and Victoria Pelova ($0.1389$) follow as traditional vertically bridging central players. Conversely, front-line attackers and the goalkeeper register scores of $0.0000$, confirming their roles as terminal nodes rather than network traffic bridges.

#### Figure 5: Sample Network, Betweenness Bar Chart
![a passing network plot with node size varied by players Betweenness Centrality g(i)](./figures/bet_bar_chart.png)

---

### 4.5 Clustering: Transitive Triads ($I_{\text{transitive}}$)
To evaluate localized spatial cohesiveness and combinational dynamics across the squad, we analyze Transitive Triad Intensity ($I_{\text{transitive}}$). Standard unweighted clustering coefficients can be misleading in football because they treat all connections equally regardless of direction or volume. Transitive triads explicitly isolate progressive wall-passes and multi-option positional triangles ($A \to B \to C$ with $A \to C$), omitting backward cyclic loops ($A \to B \to C \to A$) that rarely denote tactical progression.

As passing networks are weighted by pass volume, a triad's operational strength is constrained by its weakest link:

$$W_{\text{min}} = \min(W_{AB}, W_{BC}, W_{AC})$$

By ranking individual triads by the strength of their weakest link ($W_{\text{min}}$), we isolate the specific three-player passing circuits where Arsenal most frequently established progressive combination play.

As shown in Appendix Table 7, the highest-capacity triad (Kim Little, Lotte Wubben-Moy, Leah Williamson ($W_{\text{min}} = 116.0$)) highlights a resilient central triangle anchoring initial build-up out of defense, while left-sided loops involving Steph Catley account for three of the top six most active circuits indicating an asymmetric possessional competency. Overlaying these top-capacity transitive triads onto the PassMap (Figure 6) converts a dense network into identifiable passing triangles.

#### Figure 6: Top Transitive Triad Overlay Plot
![plotting the top n triads over the top of the pass network](./figures/triad_plot.png)

---

## 5 Empirical Baseline Constraints
Tactical network analysis generally requires benchmarking against a league-wide baseline. Evaluating global average shortest path lengths ($d$) across all season matches places our sample network ($d = 0.1884$) in the top 3.41% of league efficiency, approaching the season minimum ($0.1748$) from a league mean (std) $0.3521 ± 0.1263$ .

However, networks properties are heavily dictated by edge volume and spatial topology and this match was selected as it is the league's peak pass volume outlier. Binning the pass data  exposes severe data-sparsity constraints for empirical comparisons.  Bins of 100-pass increments show that the 200–299 pass range holds $40.2\%$ of league matches (94 of 234), whereas higher volume tiers drop off rapidly: 500–599: 14 matches, 600–699: 8, and 700–799: 1, exclusively our single sample match.

Benchmarking also requires controlling for tactical formation to normalize network topology. Segmenting even the largest pass-volume bin across the 11 recorded formations reduces the primary setup (4-2-3-1) to just 29 instances and 3 formation categories carry a single instance (Appendix X). Dual filtering for pass volume and formation dilutes sample sizes to near zero. Despite using a comprehensive season-wide dataset that is large by literature standards (Gama et al., 2026), these sparsity constraints necessitate generating spatial null models to evaluate extreme networks.

#### Figure 7: League Match-Team Pass Distribution Histrogram
![histogram showng the distribution of match-team passes for league](./figures/pass_histogram.png)

---

## 6 Traditional Nulls
Traditional null models face severe domain-specific deficiencies when applied to football. Generating a network null model involves randomizing topological features while preserving select global properties, such as total edge weight or node degree. However, football passing networks are constrained by physical pitch dimensions, player positioning, and tactical behavior. Traditional null models ignore these spatial and structural realities, generating unrealistic networks characterized by unnatural cross-field connections and misplaced playmaking hubs.

---

### 6.1 Erdős–Rényi (ER) Random Model
The simplest benchmarking approach is the Erdős–Rényi random graph framework, specifically the $G(N, p)$ model (Gilbert, 1959; Erdős & Rényi, 1959). Under this formulation, $N$ nodes are connected independently with uniform probability $p$. For weighted passing networks, total pass volume ($720$ passes across $11$ nodes) is preserved, but topological structure is erased. Weights are distributed uniformly across all potential node pairs, treating all players as structural equals and discarding individual node degree constraints.

---

### 6.2 Null Network Validation
Evaluating macro-level properties confirms that random edge generation fundamentally destroys realistic football network topology (Table 8). In an Erdős–Rényi ($G(N, p)$) random model, uniform weight assignment erases operational workload inequality. Team Node Volume Variance collapses to $\text{Var}(s_{\text{tot}}) = 514.9917$ ($\sigma_{s_{\text{tot}}} \approx 22.69$ passes), homogeneously smoothing possession across all players and removing tactical playmaking hubs. Topologically, the PassMap degrades into an uninformative dense network where edge weights lack tactical variance and peripheral nodes erroneously appear as major distribution outlets.

This breakdown extends to downstream clustering. Global Mean Transitive Intensity artificially inflates ($\bar{I}_{\text{transitive}} = 708.54$), as uniform edge generation forces nearly every three-node combination into a dense cluster. Inspecting top active triads yields tactical impossibilities, such as high-capacity loops linking central forward Stina Blackstenius with defender Lotte Wubben-Moy ($69.0$ units) or goalkeeper Sabrina D’Angelo ($51.0$ units) (Appendix X). Plotting these triads (Figure X) produces non-local pitch-wide polygons, proving the spatial unviability of ER models for football networks.


#### Figure 7: ER Null Network Visual (Left) and ER Triad Network Plot (Right)
![ER null network plotted as network & ER generated triads overlayed on network](./figures/null_failure_network.png)

#### Table 8: ER Null Macro-Level Network Metrics
| Metric | Notation | ER Null | Empirical |
| :--- | :--- | :---: | :---: |
| **Team Node Volume Variance** | $\text{Var}(s_{\text{tot}})$ | 514.9917 | 5681.9008 |
| **Mean Unweighted Degree** | $\langle k \rangle$ | 15.4545 | 16.1818 |
| **Degree Variance** | $\text{Var}(k)$ | 4.0661 | 7.7851 |
| **Degree Standard Deviation** | $\sigma_k$ | 2.0165 | 2.7902 |
| **Second Moment** | $\langle k^2 \rangle$ | 242.9091 | 269.6364 |
| **Coefficient of Variation** | $CV_k$ | 0.1305 | 0.1724 |
| **Normalized Second Moment** | $\langle k^2 \rangle / \langle k \rangle$ | 15.7176 | 16.6629 |

---

## 7 Markovian Null Model
The failure of naive, traditional null models necessitates a fundamental conceptual shift. A valid null model for football passing networks cannot treat the pitch as an abstract, unconstrained graph topology, it must strictly respect the spatial, physical, and tactical realities of match play.

---

#### 7.1 Markovian Processes and Stochastic Transformations
To construct a domain-aware generative baseline, we draw upon established football network literature modeling match dynamics using stochastic processes (Narizuka et al., 2014; Gama et al., 2026) and repurpose the methodologies for null generation, shifting from modeling dynamics on a network to governing the dynamics of the network.

While existing literature predominantly applies Markov chains to fixed adjacency matrices to analyze possession diffusion, our generative task synthesizes entirely new reference graph topologies ($\mathcal{G}_{\text{null}}$). We invert this paradigm by using learned spatial transition rules as a generative engine to resample synthetic pass events before aggregating the final null network.

This inversion addresses a critical research gap. Although stochastic flow models were originally used to bypass traditional nulls, evaluating whether observed flow metrics reflect genuine tactical organization ultimately requires benchmarking against a spatially constrained null ensemble (Gama et al., 2026).

---

#### 7.1.1 Justifying First Order Markovian Processes 
A first-order Markov process assumes that state transition probabilities ($X_{t+1}$) depend strictly on the current state ($X_t$):

$$P(X_{t+1} = x \mid X_t = x_t, \dots, X_1 = x_1) = P(X_{t+1} = x \mid X_t = x_t)$$

While higher-order memory is necessary for tracking sequential possession dynamics, a first-order memoryless formulation provides a parsimonious, mathematically aligned baseline for synthesizing static PassMap topologies. Because standard $11 \times 11$ adjacency matrices aggregate matches statically—discarding temporal ordering—a first-order process matches the target format. Furthermore, Narizuka et al. (2014) demonstrated that a first-order spatial Markov process parameterised by distance decay successfully reproduces macro-level Small-World properties and truncated degree distributions without higher-order memory overhead.

---

### 7.2 Domain Requirements & Spatial Resampling Design
Buldú et al. (2018) emphasize that valid null models for football networks must maintain high domain realism by preserving physical game constraints, spatial player distributions, and pass length mechanics. To satisfy this, we propose a targeted spatial pass-recipient resampling model. Under this framework, each recorded pass's origin location, passer identity, and pitch phase are held fixed, while the recipient is systematically resampled using a first-order Markov process.

This design choice explicitly balances tactical destruction with domain validity. Retaining empirical match coordinates means actual positional occupancy zones and realistic pass-distance decay mechanics are not lost. Simultaneously, decoupling the original recipient breaks existing tactical systems and specific player-to-player relationships.

Finally, resampling recipients using spatial transition probabilities re-establishes network edges under strict physical constraints. This prevents structural anomalies, such as long-range goalkeeper-to-striker loops, while allowing central hubs to form naturally through emergent spatial proximity.


---


### 7.4 Data Corpus Engineering
To distinguish genuine tactical adaptations from match-to-match noise, our generative resampling engine is parameterized across a large-scale league dataset comprising $N = 264$ match-team instances and $89,781$ completed passes. Constructing the first-order Markovian model directly from raw event logs — rather than finalized graph topologies — ensures the resampling process inherently preserves spatial coordinates and physical game constraints.

Raw StatsBomb pitch coordinates ($120 \times 80$) are normalized to a standardized $100 \times 100$ scale and discretized into a $10 \times 10$ spatial grid of 100 uniform cells. Granular player positions are mapped into a condensed positional taxonomy (Appendix X), eliminating team-specific lateral biases while retaining essential functional roles. This spatial and positional aggregation maximizes data density per pitch cell (Appendix X), enabling the Markovian transition model to learn robust, role-based spatial transition probabilities across the dataset.

##### Figure 9: Pitch Plot Grid
![A pitch plot segmeneted into bins](./figures/pitch_grid.png)

---

### 7.5 Recipient Probability Distribution Training
Using the discretized spatial grid and condensed positional taxonomy, we compile the pass data into a 3D Spatial Probability Tensor $\mathcal{P}$ of shape $(10, 10, N_{\text{pos}})$, where $N_{\text{pos}} = 9$. Each tensor element $\mathcal{P}(r, c, p)$ records pass frequencies terminating in cell $(r, c)$ received by position $p$. To prevent zero-probability artifacts in sparse pitch zones, we apply Laplace Additive Smoothing ($\alpha = 1.0$):

$$\text{Counts}_{\text{smoothed}}(r, c, p) = \text{RawCount}(r, c, p) + 1.0$$

Normalizing these smoothed counts yields the conditional recipient probability distribution $P(\text{Position } p \mid \text{Pass Ends in Bin } (r, c))$:

$$P(p \mid r, c) = \frac{\text{Counts}_{\text{smoothed}}(r, c, p)}{\sum_{p'} \text{Counts}_{\text{smoothed}}(r, c, p')}$$

This partitions the pitch into discrete spatial sectors governing recipient likelihood. For instance, central cell $(5,5)$ assigns highest reception probabilities to central midfielders ($38.96\%$) and central defenders ($30.58\%$), while goalkeeper receptions drop to $0.11\%$ (Table 11). Sampling from these localized distributions ensures generated passes assign plausible recipients based on empirical spatial behavior.

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
For each empirical pass in the target match, the engine retains the origin, end location, and passer identity. The terminal coordinates query the learned probability tensor $P(p \mid r, c)$ to sample a recipient position, which is mapped to an active teammate. Self-passes ($A \to A$) are strictly prevented. Evaluating the resampled event stream prior to network aggregation confirms the engine successfully balances generative variance with domain realism. As detailed in Appendix X, the spatial model avoids simply reproducing the input network while strictly enforcing defensive boundaries and realistically redistributing high-volume territorial possession.

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

---


### 7.6 Sample Null Passing Network
Visual comparison of the empirical network alongside a single spatial null realization demonstrates that spatial recipient resampling produces a natural, pitch-constrained topology. Unlike the Erdős–Rényi model, the rewired graph avoids pitch-wide "hairball" artifacts while maintaining realistic player positioning and passing channels.

##### Figure 11: Empirical PassMap (Left) vs. Null PassMap(Right)
![a visual of the original network and a null generate version](./figures/resample_orig_null.png)

#### 7.6.1 Topological Degree Diagnostics
Evaluating macro-level degree properties across this single realization confirms the spatial engine synthesizes domain-valid reference networks (Table 13).

Holding passer volume ($s_i^{\text{out}}$) fixed recovers over half of empirical workload inequality ($\text{Var}(s_{\text{tot}}) = 2955.90$ vs. ER's $514.99$). This reveals passer initiative accounts for roughly 52% of workload variance, while receiver choice drives 48%.

Replacing match-specific target preferences with league-average spatial probabilities increases active density ($\langle k \rangle = 17.64$) and flattens connection variance ($CV_k = 0.1115$). The Normalized Second Moment ($17.86$) closely tracks mean degree, proving empirical origin coordinates preserve structural density without creating scale-free hub anomalies.

##### Table 13: Sample Null Macro-Level Metrics
| Metric | Empirical | ER ($G(N,p)$) | Null |
| :--- | :---: | :---: | :---: |
| **Mean Unweighted Degree ($\langle k \rangle$)** | 16.1818 | 15.4545 | 17.6364 |
| **Coefficient of Variation ($CV_k$)** | 0.1724 | 0.1305 | 0.1115 |
| **Normalized Second Moment ($\frac{\langle k^2 \rangle}{\langle k \rangle}$)** | 16.6629 | 15.7176 | 17.8557 |
| **Node Volume Variance ($\text{Var}(s_{\text{tot}})$)** | 5681.90 | 514.99 | 2955.90 |

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





