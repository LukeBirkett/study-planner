# Project Title Framework
- Beyond Naive Topology: A Generative Spatial Null Framework for Football Passing Networks
- Disambiguating Tactics from Geometry: 1st-Order Generative Null Models in Football Analytics

┌──────────────────────────────────────────────────────────┐
│ SECTION 1: Introduction & Foundations                    │
├──────────────────────────────────────────────────────────┤
│ SECTION 2: Data Pipeline & Diagnostic Metric Showcase    │
├──────────────────────────────────────────────────────────┤
│ SECTION 3: The Literature Gap (Alves, Gama, Buldú)       │
├──────────────────────────────────────────────────────────┤
│ SECTION 4: 1st-Order Generative Null Engine (MVPs 1-3)   │
├──────────────────────────────────────────────────────────┤
│ SECTION 5: Practical Application & Case Study            │
├──────────────────────────────────────────────────────────┤
│ SECTION 6: Methodological Limitations & Conclusion       │
└──────────────────────────────────────────────────────────┘

## SECTION 1: Introduction & Foundations

Network Science is an intuitive, problem-driven framework for modeling complex systems, abstracting real-world interactions into formal structures of nodes and links to evaluate both system-wide graph topology and the dynamic processes flowing across it.

Its applications are highly versatile and have been successfully deployed across a wide spectrum of domains. For instance, network science is frequently used to identify influential individuals within social and organizational systems through the quantification of high-degree hubs and structural centralities that locate key playmakers, broadcasters, or bottlenecks (Wasserman & Faust, 1994; Newman, 2001; Rodrigues, 2019). Beyond individual metrics, it provides the tools to detect modular community structures, uncovering functional sub-groups or "echo chambers" where elements connect more densely to one another than to the broader network (Fortunato, 2010). Furthermore, the framework enables the modeling of spreading cascades, such as the propagation of biological epidemics or information cascades, revealing how structural features like heavy-tailed degree distributions dictate whether a contagion fizzles out locally or reaches a global tipping point (Pastor-Satorras & Vespignani, 2001; Barrat et al., 2008). Network science also allows researchers to evaluate systemic robustness and degree assortativity across ecological and infrastructure systems, determining how complex architectures withstand random failures versus targeted attacks (Lusseau, 2003; Newman, 2003).

By abstracting disparate domain interactions into shared topological representations, network science moves away from a reductionist, isolationist view of individual components. Instead, it offers a universal toolkit to uncover the emergent organizational principles governing the collective behavior of modern complex systems.

This report focuses exclusively on the application of Network Science to sport (Araújo et al., 2006), specifically football, a field-based, team sport (Duch et al., 2010). Traditional football analysis relies primarily on terminal, individual performance indicators such as passes completed, goals scored, or advanced modeled parameters like Expected Goals (xG; Pollard & Reep, 1997; [xG Reference]), which assigns a probabilistic value to shot quality using historical spatial event data. However, an isolationist perspective is fundamentally flawed because football functions as a complex adaptive system (Buldú et al., 2019). The success of a team cannot be truly understood through isolated individual metrics alone, but is instead determined by the emergent structure derived from continuous individual and collective behaviors and on-pitch tactical organization (Gama et al., 2026).

To analyze a system through network science, a domain problem must first be decomposed into a discrete set of nodes and edges. Intuitively, in football, the players of a single team are modeled as nodes ($N=11$), expanding to $N=22$ when incorporating opposition players, or $N=23$ if treating the ball itself as a distinct entity. Edges represent the relational interactions connecting these nodes. However, football represents a complex, multi-layered system where abstract interactions occur continuously. Many of these interactions lack a discrete physical contact event, manifesting instead through spatial control and positional coordination.

To overcome this, completed passes offer a highly pragmatic and objective interaction metric. A completed pass physically connects two teammates (Player A $\rightarrow$ Player B), serving as a discrete event that encodes tactical intent, team strategy, and the structural constraints imposed by the game environment. The representation of teammates as nodes and completed passes as directed edges is known as the PassMap paradigm (Buldú et al., 2018). While several variations of this framework exist — which will be detailed and visualized in Section 1.3: The PassMap Paradigm — the output network is fundamentally a weighted, directed graph where edge weights reflect cumulative passing volume between player pairs.

There are numerous ways this emergent PassMap network can be decomposed into structural metrics and flow dynamics, as explored in Section 2.2: Metric Taxonomy. However, evaluating raw network properties in isolation — or comparing them directly across unconditioned match samples — provides limited diagnostic value. Graph metrics are inherently shaped by their underlying topological and domain-specific constraints. To validate whether an observed network property is statistically significant, it must be evaluated against an appropriate null model baseline — a randomized or generative reference network that preserves structural constraints (such as density or degree sequences) while destroying specific organizational patterns to isolate true signal from random chance.

Gama et al. (2026) demonstrated that while modern sports analytics can compute advanced network properties and stochastic flow metrics, these values remain purely descriptive without reference distributions. Without a statistical baseline, analysts cannot determine whether match-to-match variations in a team’s network structure reflect deliberate tactical execution or mere stochastic noise. Constructing a valid null network in football presents a unique challenge due to the game's strict spatial constraints. A meaningful baseline must reconcile random graph generation with physical pitch geometry, player movement boundaries, and spatial proximity — a challenge detailed in Section 3.3: The Baseline Deficit & The Sparsity Trap. 

Ultimately, this project serves as a direct response to the explicit calls in recent literature for generative, spatially constrained null models capable of establishing robust statistical baselines in football analytics (Gama et al., 2026).

---

## SECTION 2: Data Pipeline, PassMap Paradigm Foundational Metric

### 2.1 Data Pipeline, Spatial Normalization, and Roster Constraints
The dataset comprises StatsBomb event logs from the 2023/2024 FA Women's Super League (WSL; competition_id: 37, season_id: 281). Focusing on women's football directly addresses literature deficits regarding the overreliance on short men's samples and the systemic underrepresentation of longitudinal women's datasets (Alves et al., 2025; Gama et al., 2026).

Raw spatiotemporal event logs are non-relational and must be transformed into directed, weighted adjacency matrices $A_{ij}$. For our PassMap framework, we isolate completed passes using four attributes:

As mentioned, we are focusing on PassMap paradigm, meaning the only events we want are completed passes. From the pass event payload, we extract there core attributes:
- Passer (source node $i$)
- Recipient (target node $j$)
- Origin $(x_1, y_1)$
- Destination $(x_2, y_2)$

StatsBomb's $120 \times 80$ yard coordinates are rescaled to a $100 \times 100$ relative grid to normalize across varying pitch dimensions (Buldú et al., 2019).

Constructing match networks requires resolving player substitutions. Assigning a substitute's events to the replaced starter (Narizuka et al., 2014; Buldú et al., 2019) obscures individual performance. Conversely, expanding the node count ($N > 11$) introduces low-volume, isolated nodes that distort macro-scale graph invariants like density and clustering coefficients.

To resolve this, we apply a dual-stage rule:
- For the generative null modelling, all completed passes across all players are utilized to maximize sample size and preserve underlying spatial probability kernels across the dataset's $NUM$ passes. 
- For Match Network Construction, constrain the network to the top 11 players by minutes played per match. This discards minimal late-game pass volume while ensuring a mathematically consistent $11 \times 11$ matrix free from substitute-induced topological distortion.

#### Summary of Dataset Statistics (WSL 2023/2024)
*The table below outlines the core statistical properties of the curated StatsBomb dataset used across all subsequent generative and empirical evaluation pipelines:*

| Metric Category | Dataset Statistic |
| :--- | :--- |
| **Competition / Season** | FA Women's Super League (WSL) $2023/2024$ |
| **Total Matches** | `132` |
| **Total Team Network** | `264` |
| **Total Season Passes Recorded** | `105,262` |
| **Mean Passes per Team per Match** | `399` (Range: `120-847`) |
| **Mean Unique Players Used per Team per Match** | `15.1` (Range: `12-16`) |
| **Pitch Coordinate Scaling** | Rescaled from $120 \times 80$ yd to $100 \times 100$ relative grid |
| **Roster Normalization Rule** | Truncated to Top-11 minutes played per match |

---

### 2. Demonstrations of the PassMap Paradigm
> **Note:** This section is likely way to long for the current project scope. Too much time and space is spent defining paradigms that we don't use. I expect in the final draft I will only use the detailed explanation of the Player paradigm. The others I will still make a concise reference to and either remove the detail explanations, or move to the appendix. 

In this project, team organization across entire football matches is modeled using the PassMap paradigm popularized by Buldú et al. (2018). Irrespective of the specific formulation used, a passing network is defined fundamentally as a directed, weighted graph:

$$G = (V, E, W)$$

Here, the edges ($E$) represent completed passes, and the edge weights ($W$) quantify the accumulated total frequency of passes directed from node $i$ to node $j$ over a given observation window—in this study, a full 90-minute match.

While the edge mechanics remain uniform across passing network formulations, the underlying definition of the node set ($V$) varies fundamentally depending on the analytical objective. Buldú et al. categorize these into three distinct paradigms: Player Networks, Player-Pitch Networks, and Pitch Networks.

---

#### 2.1. Player Networks
In a standard Player Network, the node set corresponds directly to the eleven starting players on the pitch ($\vert V \vert = 11$), where each node represents a unique player identity (e.g., name, shirt number, or tactical position).

In its most basic implementation, a Player Network is topologically abstract and devoid of spatial context. However, a widespread convention is to append spatial $(x, y)$ coordinates to each node, calculated as the player's average position on the pitch during the match.

While assigning mean positional coordinates leaves traditional topological network metrics unchanged, it significantly enhances visual interpretability and establishes a continuous baseline for spatial considerations. 

> -->[Insert Example: Player Network]

> -->[Insert Example: Raw Passes Plotted on a Pitch]

---

#### 2.2. Player-Pitch Networks

The Player-Pitch Network segments the playing surface into a discrete grid, defining composite nodes that represent a specific Player $P$ located within a specific Pitch Zone $K$. A player generates a unique node in every grid zone where they execute or receive a pass.

Popularized by Buldú et al. (2019), this hybrid paradigm captures dynamic tactical positioning alongside passing decisions by measuring discrete spatial movement. 

Narizuka et al. (2014) leveraged this framework to scale up the available node count significantly beyond eleven. This increase in data density allowed them to re-evaluate prior claims that football passing networks exhibit scale-free properties (Yamamoto & Yokoyama, 2011). By expanding the network via spatial discretization, Narizuka et al. concluded that passing networks actually adhere to a Gamma distribution rather than a power law.

---

#### 2.3. Pitch-Location Networks
Formulated as $G = (K, E, W)$ (Buldú et al., 2018), Pitch Networks abstract away player identity entirely to map the spatial and geometric routing of the ball across the field. 

The node set ($K$) comprises discretized sub-regions or spatial cells (e.g., 18 or 24 grid zones) regardless of who occupies them. 

By isolating space from player identity, this approach acts as a purely geographic baseline, helping to decompose whether ball progression is driven by pitch topology/geography or by specific tactical instructions.

---

#### 2.4 Selection and Rationale for the Player Passing Paradigm
While all three paradigms capture valid and complementary dimensions of team organization, this project focuses strictly on the Player Passing Network paradigm. This selection is guided by several analytical considerations:

1. **Literature Precedent & Interpretability:** Player-only networks are by far the most predominant representation in football analytics literature (e.g., Cotta et al.; Duch et al.; Grund; Gama et al., 2026; Alves et al., 2025), offering established benchmarks and deeper theoretical interpretation.
2. **Visual Intuition & Data Proximity:** Mapping eleven discrete players yields the most intuitive visualization of team structure. Because it retains the direct mapping of starting lineups, it remains closest to the raw, unmanipulated pass event data.
3. **Avoidance of Arbitrary Discretization:** Both Player-Pitch and Pitch-Only networks require extensive spatial pre-processing to bin event data into spatial cells. Crucially, there is no consensus standard in the literature regarding optimal pitch segmentation or grid sizing (Camerino et al., 2012; Narizuka et al., 2014; Arriaza-Ardiles et al., 2018).

> **Note on Data Density & Sparsity:**
> Discrete spatial binning is often utilized as a smoothing technique to combat data sparsity in short timeframes. Because this study utilizes full-season data, artificial spatial discretization is less necessary to achieve statistical power. However, it is worth noting that while continuous positional representations avoid arbitrary binning choices, they introduce a different form of matrix sparsity, potentially biasing analysis in less frequently used passing channels. Spatial binning concepts will therefore be re-introduced in the [NULL MODELLING SECTION].

---

### 3. Football Network Metrics
The application of Network Science to football transforms positional passing data into structural models, allowing tactical dynamics to be analyzed through mathematical properties (López-Peña & Touchette, 2012). Rather than evaluating players in isolation, passing networks treat players as nodes and completed passes as directed, weighted edges (Cotta et al., 2013).

To systematically map network properties to footballing concepts, researchers broadly categorize analysis across three structural scales: Micro-scale, Meso-scale, and Macro-scale (Alves et al., 2025; Gama et al., 2026). A comprehensive mapping of network properties to their football equivalents is detailed in Appendix A (adapted from Gama et al., 2026), with a core subset outlined in Table 3.1.

#### 3.1 The Multi-Scale Network Framework

##### Micro-Scale Analysis
At the micro-scale, the focus rests on individual nodes (players). The most fundamental micro-metric is Degree, which measures raw passing volume: In-Degree represents passes received, while Out-Degree measures passes completed (Cotta et al., 2013).

Beyond raw volume, micro-scale metrics evaluate structural influence. Betweenness Centrality identifies players who act as crucial conduits, controlling the flow of passes between different sectors of the pitch (López-Peña & Touchette, 2012). Nodes with high centrality act as tactical "hubs" (Buldú et al., 2019). Identifying player's network characteristics is pivotal for tactical profiling and recruitment—allowing clubs to identify structural equivalents across leagues (Peña & Navarro, 2015).

##### Meso-Scale Analysis
Meso-scale analysis broadens this lens to evaluate sub-structures—typically combinations involving 3 to 4 players (cliques or triads). It measures how localized sub-groups interact and identifies localized leadership within passing channels (López-Peña & Sánchez Navarro, 2015). Highly heterogeneous meso-structures can indicate structural dysfunctions, such as isolated players who fail to integrate into broader build-up play (Clemente et al., 2015).

##### Macro-Scale Analysis
Macro-scale metrics evaluate the network as an integrated whole, reducing a team's global spatial-tactical signature into singular, comparable metrics. Features like Network Density, Global Centrality, and the Small-World Property summarize team cohesion, structural fluidity, and spatial dominance (Watts & Strogatz, 1998; Cintia et al., 2015). Successful teams often exhibit macro-level properties reflecting high connectivity and balanced interaction patterns (Pina et al., 2017; Ribeiro et al., 2017).

---

#### 3.2 Focus Metrics: Selection & Formal Definitions
To evaluate tactical performance without overwhelming the analysis with redundant properties, this project scopes down to four core metrics: Degree Distributions, Betweenness Centrality, Weighted Clustering Coefficient ($C_w$), and Average Shortest Path ($d$). These metrics balance intuitive football interpretations with theoretical rigor.

##### Table X; Subset Metrics
Scale,Network Science Property,Footballing Translation,Key Reference
Micro,In/Out-Degree,Individual passing volume (passes received vs. passes made),Cotta et al. (2013)
Micro,Betweenness Centrality,Player importance in ball progression and linking team sectors,López-Peña & Touchette (2012)
Meso,Subgraph / Triads,"Local passing combinations (e.g., passing triangles)",Clemente et al. (2015)
Macro,Average Shortest Path (d),Overall team ball circulation efficiency and topological distance,Buldú et al. (2019)
Macro,Weighted Clustering (Cw​),Local passing robustness and tactical small-world property,Ahnert et al. (2007)

##### 3.2.1 Node Degree and Degree Distribution
In network science, the degree $k_i$ of a node $i$ represents the total number of edges connected to it. In directed, weighted football networks, this is split into:
- In-Degree ($k_i^{\text{in}}$): Sum of passes received by Player $i$.
- Out-Degree ($k_i^{\text{out}}$): Sum of completed passes made by Player $i$.

Degree serves as a baseline proxy for involvement. Analyzing degree distribution across a team exposes structural biases—such as over-reliance on a single playmaker (a long-tailed degree distribution) versus equitable, distributed playmaking across the unit (Narizuka et al., 2014).

##### 3.2.2 Betweenness Centrality
Formalized by Freeman (1977), Betweenness Centrality measures the fraction of all shortest paths passing through a given node. For a node $i$, it is defined as:

$$g(i) = \sum_{s \neq i \neq t} \frac{\sigma_{st}(i)}{\sigma_{st}}$$

where $\sigma_{st}$ is the total number of shortest paths from node $s$ to node $t$, and $\sigma_{st}(i)$ is the number of those paths that pass through node $i$.

In football terms, Betweenness Centrality quantifies how vital a player is in bridging different areas of the pitch (e.g., transitioning defense into attack). High betweenness centrality identifies the operational "hubs" of a team—players like Xavi Hernandez in historic FC Barcelona teams, through whom the majority of progressive possession flows (Buldú et al., 2019). Removing a player with high betweenness centrality severely disrupts a team's structural connectivity.

##### 3.2.3 Weighted Clustering Coefficient ($C_w$)
In unweighted networks, the local Clustering Coefficient $C_i$ measures the ratio of actual edges between a node's neighbors to the maximum possible edges between them, capturing local density (triangles). However, because passing networks are densely connected and heavily weighted by pass frequency, an unweighted metric fails to capture tactical nuance.

Following Ahnert et al. (2007) and Buldú et al. (2019), we utilize the Weighted Clustering Coefficient ($C_w$):

$$C_w(i) = \frac{\sum_{j,k} w_{ij} w_{jk} w_{ik}}{\sum_{j,k} w_{ij} w_{ik}}$$

where $w_{ij}$, $w_{jk}$, and $w_{ik}$ represent the edge weights (pass counts) between Player $i$ and neighboring players $j$ and $k$. The global weighted clustering coefficient $C_w$ is the mean across all players $N$:

$$C_w = \frac{1}{N} \sum_{i=1}^{N} C_w(i)$$

Triangles form the foundation of positional football tactics (e.g., Guardiola’s positional play). $C_w$ quantifies the tendency of players to form strong, balanced passing triads. Formally, high local clustering indicates local robustness: if an opposing defense blocks a direct passing route between Player $i$ and Player $j$, an indirect route through Player $k$ remains open, making the network resilient against defensive pressure (López-Peña & Touchette, 2012). When $C_w$ is significantly higher than that of an equivalent random network, the system exhibits the Small-World property (Watts & Strogatz, 1998; Narizuka et al., 2014).

##### 3.2.4 Average Shortest Path ($d$)
The Average Shortest Path measures the global efficiency of information or ball transport across the entire network. In a passing network, distance is topological rather than metric.

Buldú et al. (2019) define the topological distance $l_{ij}$ between Player $i$ and Player $j$ as the inverse of pass frequency:

$$l_{ij} = \frac{1}{w_{ij}}$$

Thus, a higher volume of passes between two players reduces their topological distance ($l_{ij} \to 0$). The shortest topological path $p_{ij}$ between any two players is calculated using Dijkstra’s Algorithm. The team's overall Average Shortest Path ($d$) is given by:

$$d = \frac{1}{N(N-1)} \sum_{i \neq j} p_{ij}$$

Average Shortest Path reflects team-wide ball circulation efficiency. A low $d$ value indicates seamless ball movement where any player can reach any other player through high-volume, established passing channels. Conversely, a high $d$ indicates structural bottlenecks, isolated positional units, or reliance on rare, long passes.

> Important Analytical Note: Because $l_{ij} = \frac{1}{w_{ij}}$, absolute values of $d$ are heavily dependent on raw passing volume. A high-possession team completing 700 passes will naturally yield a far lower $d$ than a low-possession team completing 300 passes, even if both share an identical tactical layout. To isolate tactical structure from absolute volume, values of $d$ (and $C_w$) must be evaluated against null models (randomized network baselines) in subsequent empirical evaluations.

---

### 4. Executing Network Properties

#### 4.1 Degree Analysis & Baseline Heterogeneity
At the individual level, Carlotte Wubben-Moy ($248$) and Kim Little ($240$) anchored the team's build-up play, recording the highest total volumes ($s_{tot}$) and maintaining net positive passing flows, which underlines their role as primary distributors. A clear positional hierarchy emerges across the squad: defensive units (the center-backs and defensive midfielders) generated the highest pass volumes and positive net flows ($\Delta s_i > 0$), while attacking players operated in much higher-pressure zones. This is reflected in the lower pass ratios of Alessia Russo ($0.72$), Bethany Mead ($0.88$), and Stina Blackstenius ($0.73$), who served as target receivers rather than distributors. Notably, goalkeeper Sabrina D’Angelo registered the highest Pass Ratio ($1.37$), reflecting a direct distribution pattern focused on playing out into the higher phases of possession.

> Lets make this even more simple by explaining that a player can only have a positive flow if they win the pass or take passes from set players, i.e. goal kickers. 

> Maybe extend the focus on the Wubben-Mo and Little to look at their degrees as this is more network specific

At the macro level, the unweighted degree and node volume statistics reveal a clear structural dichotomy: while the team’s passing network exhibits high topological uniformity, the actual distribution of possession volume is heavily centralized around key hubs. The mean unweighted degree ($\langle k \rangle = 16.18$) reflects the directed nature of the network, where a theoretical maximum total degree of $20$ exists for an 11-player squad ($k = k_{\text{in}} + k_{\text{out}}$). An average total degree of $16.18$ indicates an extremely dense network ($\approx 81\%$), where the average player exchanges passes with approximately 8 out of their 10 available teammates. Furthermore, the low degree variance ($\text{Var}(k) = 7.7851$) and low Coefficient of Variation ($CV_k = 0.1724$) demonstrate high topological homogeneity. This is further corroborated by the Normalized Second Moment ($\frac{\langle k^2 \rangle}{\langle k \rangle} = 16.6629$), which closely matches the mean degree; in network theory, a second-moment ratio near the mean confirms that degree fluctuations across the graph are minimal and that passing channels are evenly distributed across the pitch.

> - If $CV_k \approx 0$, the network is homogeneous (e.g., regular grid). 
> - If $CV_k > 1$ or $\frac{\langle k^2 \rangle}{\langle k \rangle} \gg \langle k \rangle$, the network exhibits strong degree heterogeneity (e.g., scale-free networks with hub structures).
> I would like to include some more formulas, particularly $\frac{\langle k^2 \rangle}{\langle k \rangle} \gg \langle k \rangle$

> **Mean Degree ($\langle k \rangle$):** $\langle k \rangle = \frac{1}{N} \sum_{i=1}^N k_i$
> **Coefficient of Variation ($CV_k$):** Measures relative variance around the mean. Higher values indicate higher degree heterogeneity. $CV_k = \frac{\sigma_k}{\langle k \rangle} = \frac{\sqrt{\langle k^2 \rangle - \langle k \rangle^2}}{\langle k \rangle}$
> **Normalized Second Moment/Degree Variance Ratio ($\frac{\langle k^2 \rangle}{\langle k \rangle}$):** Quantifies the propensity for heavy-tailed behavior and plays a crucial role in epidemic thresholds and robust connectivity. $\frac{\langle k^2 \rangle}{\langle k \rangle} = \frac{\frac{1}{N} \sum_{i=1}^N k_i^2}{\langle k \rangle}$

However, this structural democracy contrasts sharply with the team's pass-volume execution. While unweighted degrees show that almost all players are connected to one another, the massive Node Volume Variance ($\text{Var}(s_{\text{tot}}) = 5681.90$) proves that pass volume is distributed with extreme inequality. While peripheral players and central playmakers may maintain similar numbers of unique passing partners, the actual workload ($s_{\text{tot}}$) is funneled through a select few tactical anchors. Ultimately, this baseline analysis demonstrates the limits of unweighted degree metrics: while $CV_k$ confirms that structural passing avenues remain broadly open, it fails to capture the heavy volumetric dependency on core hubs. This limitation directly justifies the need for our subsequent suite of advanced, weighted network metrics to properly evaluate flow, centrality, and system vulnerability.

> Also stress that we are still looking at very grnaular data whereby we are having to pick up many different metrics and calcualtions to form analysis. We are clear terminal metrics to evaluate by, otherwise, we may as well invest heavily in a in-person scouts and do this all manually by scouting experts

> **Previous Transition Draft Pargraph:**
> "While unweighted degree analysis provides an intuitive baseline of player involvement and channel availability, it struggles to capture the weighted intensity and directional flow of modern possession football. Attempting to artificially extend basic degree moments into weighted variants quickly leads to a fragmentation of metrics. This limitation directly motivates the deployment of our advanced metric suite (Betweenness Centrality, Weighted Clustering Coefficient, and Average Shortest Path Length) to rigorously model indirect flow, local clustering, and global efficiency."
> - If you try to adapt every basic statistical moment (mean, variance, second moment, $CV_k$) to account for in-strength, out-strength, total volume, and edge weights, your exploratory section becomes bloated with 15–20 superficial variation tables before you've even touched core graph theory.
> - By demonstrating that standard, unweighted degree metrics ($\langle k \rangle$, $CV_k$, etc.) flatten the nuance of a passing network (e.g., showing near-homogeneous degree counts because almost every outfield player connects with every other at least once), you explicitly justify why advanced metrics are necessary.

##### Player-Level Degree Metrics (Arsenal WFC)

| Player | Position | $k_{in}$ (In-Degree) | $k_{out}$ (Out-Degree) | $s_{in}$ (Passes Rec.) | $s_{out}$ (Passes Comp.) | Total Volume ($s_{tot}$) | Net Flow ($\Delta s_i$) | Pass Ratio ($s_{out} / s_{in}$) |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Carlotte Wubben-Moy | Left Center Back | 9 | 10 | 120 | 128 | 248 | 8 | 1.07 |
| Kim Little | Left Defensive Midfield | 10 | 9 | 117 | 123 | 240 | 6 | 1.05 |
| Leah Williamson | Right Center Back | 8 | 10 | 99 | 103 | 202 | 4 | 1.04 |
| Victoria Pelova | Right Defensive Midfield | 9 | 8 | 92 | 87 | 179 | -5 | 0.95 |
| Stephanie-Elise Catley | Left Back | 9 | 9 | 79 | 81 | 160 | 2 | 1.03 |
| Alessia Russo | Center Attacking Midfield | 9 | 9 | 60 | 43 | 103 | -17 | 0.72 |
| Emily Ann Fox | Right Back | 7 | 8 | 48 | 52 | 100 | 4 | 1.08 |
| Bethany Mead | Right Wing | 9 | 8 | 42 | 37 | 79 | -5 | 0.88 |
| Caitlin Jade Foord | Left Wing | 8 | 7 | 33 | 32 | 65 | -1 | 0.97 |
| Sabrina D’Angelo | Goalkeeper | 5 | 5 | 19 | 26 | 45 | 7 | 1.37 |
| Emma Stina Blackstenius | Center Forward | 6 | 6 | 11 | 8 | 19 | -3 | 0.73 |
---

##### Macro Metrics Summary Table
| Metric Name | Mathematical Notation | Output Value | Primary Tactical Inference |
| :--- | :---: | :---: | :--- |
| **Team Node Volume Variance** | $\text{Var}(s_{\text{tot}})$ | **5681.9008** | High pass-volume inequality; possession is funneled through key hubs. |
| **Mean Unweighted Degree** | $\langle k \rangle$ | **16.1818** | Dense network topology ($\approx 81\%$), averaging $\approx 8$ active passing partners per player. |
| **Degree Variance** | $\text{Var}(k)$ | **7.7851** | Low variance in connection counts across the squad. |
| **Degree Standard Deviation** | $\sigma_k$ | **2.7902** | Minimal dispersion around the average channel count. |
| **Second Moment** | $\langle k^2 \rangle$ | **269.6364** | Second-order moment reflecting expected degree squared. |
| **Coefficient of Variation** | $CV_k$ | **0.1724** | Low degree heterogeneity ($17.2\%$); passing options are evenly distributed. |
| **Normalized Second Moment** | $\frac{\langle k^2 \rangle}{\langle k \rangle}$ | **16.6629** | Ratio near $\langle k \rangle$ confirms a near-regular, homogeneously connected graph. |
---

#### 4.2 Average Shortest Path
In a weighted passing network, edge weights ($w_{ij}$) denote the volume of completed passes from player $i$ to player $j$. To evaluate topological distance, pass volume is inverted to establish edge cost ($l_{ij} = \frac{1}{w_{ij}}$), meaning high-frequency passing channels yield near-zero topological resistance. Using Dijkstra’s algorithm, the shortest path ($p_{ij}$) represents the minimal cumulative cost required to route possession between any two players. Calculating the global average shortest path length ($d$) provides a macro-level measure of team-wide circulation efficiency:

$$d = \frac{1}{N(N-1)} \sum_{i \neq j} p_{ij}$$

Shortest path lengths serve as the foundational building block for path-based graph theory. While direct pass volume measures immediate local throughput, shortest paths capture multi-step, systemic reachability across the entire pitch. By evaluating path lengths at both the global level ($d$) and the player level—via mean outward distance ($d_{\text{out}}$) and mean inward distance ($d_{\text{in}}$) — we assess how smoothly possession flows through the network and identify which players operate as accessible distribution hubs versus isolated terminal outlets.

For Arsenal WFC, the global average shortest path length of $d = 0.1884$ topological units indicates a highly efficient, tightly connected passing network capable of circulating possession across the squad with minimal resistance. 

Because topological edge distance is calculated as the reciprocal of pass volume ($l_{ij} = 1/w_{ij}$), the average shortest path length ($d$) is not bounded on a rigid $0$ to $1$ scale, but rather scales inversely with pass frequency. In this framework, a path distance of $1.0$ corresponds to a single-pass link, whereas $d = 0.1884$ represents an average pairwise path resistance equivalent to over $5.3$ completed passes per route ($\frac{1}{0.1884} \approx 5.31$). While a comprehensive WSL league-wide baseline would provide absolute relative rankings across teams, an internal value of $d = 0.1884$ confirms that Arsenal’s network is free of high-resistance bottlenecks or disconnected sub-graphs, maintaining a dense, high-volume flow of possession across the squad."

> I am not sure I understand ($\frac{1}{0.1884} \approx 5.31$), even after a convo with gemeini but its important that I clarify this. 

At the individual level, the defensive foundation — Carlotte Wubben-Moy ($d_{\text{out}} = 0.1066$), Kim Little ($d_{\text{out}} = 0.1092$), and Leah Williamson ($d_{\text{out}} = 0.1106$) — records the lowest outward path lengths. This confirms that Arsenal’s build-up is heavily anchored in the backline and deep midfield, where these primary initiators can distribute the ball to any teammate across fewer, higher-volume topological steps than any other players.

The spatial breakdown also highlights a slight left-flank bias, as Wubben-Moy, Little, and Steph Catley ($d_{\text{out}} = 0.1229$) maintain shorter path lengths than their right-sided counterparts (Pelova and Fox), indicating that the left channel serves as the primary engine for ball progression. 

Conversely, central attacking midfielder Alessia Russo exhibits an inverted flow dynamic ($d_{\text{out}} = 0.1893 > d_{\text{in}} = 0.1760$), acting as a target receiver between the lines who is easily reached by the team but redistributes along more specialized attacking routes. 

Finally, center-forward Stina Blackstenius operates as a structural outlier ($d_{\text{out}} = 0.5664$, $d_{\text{in}} = 0.3391$). Her high path distances reflect her role as a traditional box-finishing target operating under heavy opposition pressure—functioning as the ultimate endpoint of possession rather than an active link in the team's circulation chain.

> There is probably some lituruature we could tie in. Many researchers, i think gama, found center backs and defensive mids to be key hubs. the systematic reviews of alves should give us some references here. For the little and woy finding we could say this mirrors the liturature. 

> the center-forward aspect also points to football being a low scoring game and therefore the scoring players are marked out of the game. the oppposiing tactics are not modelled directly in this research project but they are analagous to network attacks, i.e. the links are cut off, the other team does not want to see this connect happen, particular not in the areas which the center forward operates which the passmap shows to be high up the putch. 

> NOTE, we only really spoke about out degrees, only mentioning in degrees alongside out degrees. I wonder if there is any direct in degree insight here? I suppose it is largely the same story as out degree but out degree is much more intuative to understand as it is the length of the chains when starting from one player. In degrees is the terminal in bound routes from all other players. 

**Global Average Shortest Path Length ($d$):** 0.1884 topological units

##### Global Team Circulation Distance ($d$) — Arsenal WFC
| Player | Position | Mean Outward Path Length ($d_{\text{out}}$) | Mean Inward Path Length ($d_{\text{in}}$) |
| :--- | :--- | :---: | :---: |
| Carlotte Wubben-Moy | Left Center Back | 0.106572 | 0.133478 |
| Kim Little | Left Defensive Midfield | 0.109245 | 0.134141 |
| Leah Williamson | Right Center Back | 0.110634 | 0.142160 |
| Stephanie-Elise Catley | Left Back | 0.122852 | 0.148014 |
| Victoria Pelova | Right Defensive Midfield | 0.133628 | 0.149998 |
| Emily Ann Fox | Right Back | 0.158090 | 0.185738 |
| Sabrina D’Angelo | Goalkeeper | 0.165501 | 0.243296 |
| Alessia Russo | Center Attacking Midfield | 0.189276 | 0.176048 |
| Caitlin Jade Foord | Left Wing | 0.203468 | 0.208797 |
| Bethany Mead | Right Wing | 0.206961 | 0.211849 |
| Emma Stina Blackstenius | Center Forward | 0.566421 | 0.339130 |
---

#### 4.3 Betweenness Centrality ($g(i)$)
Building directly upon the all-pairs shortest paths ($p_{ij}$) established in the previous section, Betweenness Centrality measures the extent to which a specific player ($i$) acts as a critical structural bridge or "tollbooth" across the team's passing network. Using Dijkstra’s topological distances ($l_{ij} = 1/w_{ij}$), the betweenness centrality $g(i)$ is formulated as:

$$g(i) = \sum_{s \neq i \neq t} \frac{\sigma_{st}(i)}{\sigma_{st}}$$

Where $\sigma_{st}$ represents the total number of shortest paths between source player $s$ and target player $t$, and $\sigma_{st}(i)$ is the number of those efficient routes that must physically pass through player $i$.

In tactical graph theory, betweenness centrality shifts focus from pure passing volume to network control and vulnerability. While a player might not dominate total touches, a high betweenness score indicates that possession from across the pitch must frequently route through them to transition successfully between defensive and attacking phases. Conversely, nodes with a score of $0.0000$ operate at the structural periphery, meaning minimal team-wide traffic relies on them for routing.

The distribution of betweenness centrality scores across the squad reveals a stark structural division between Arsenal WFC’s deep build-up anchors and their advanced final-third outlets. Central defenders Carlotte Wubben-Moy ($0.3222$) and Leah Williamson ($0.3000$) heavily dominate the network, occupying over $62\%$ of the total betweenness centrality across the pitch. In tactical terms, this establishes the center-back pairing as the ultimate "tollbooth" of Arsenal’s system: virtually every multi-step possession sequence required to connect isolated sectors of the pitch must physically route through them.

> This almost certainly represents a tactical decision. Center backs are often the first link from a phase of player starting form a goalkick, therefore there is ample data density of chains going through the center backs. This means, they have ample chance to become part of shortest chain. 

> Conversely, it represents a tactic decison to play out from the back. In this in constract to going long and direct which would almost certainly result in shortest chains. Wait, this isn't correct that here topologcial distance is modeled by frequency, therefore, the logic is still tactical. Because arsenal are a high possesion team, they are constant re-cycling and retaining possension, returning the ball back to their centerbacks to start again. Resultingly, these deep players obtain high frequency of passes and are therefore consdiered "short" routes. In this sense, these players being part of the short routes represent their availablity to continue possension as well as their influence being part of global chains, i.e. the ball being at their feet could end up anywhere on the pitch in a short(er) amount of "time"

In midfield, Kim Little ($0.1778$) and Victoria Pelova ($0.1389$) handle secondary bridging duties alongside left-back Steph Catley ($0.1222$). While these players help facilitate progression through the central and left-flank channels, their lower betweenness scores relative to the center-backs demonstrate that possession flow in the second phase is distributed across multiple avenues rather than relying on a single, vulnerable bottleneck.

Most strikingly, every player in the forward and advanced units—including central attacking midfielder Alessia Russo, both wingers (Caitlin Foord and Beth Mead), right-back Emily Fox, striker Stina Blackstenius, and goalkeeper Sabrina D’Angelo—registered a betweenness score of $0.0000$. In graph theory, this zero-betweenness tier proves that these players sit entirely at the structural periphery of the passing network. They function exclusively as the terminals and endpoints of possessional chains rather than intermediate routing hubs, highlighting a clear tactical boundary where the backline and central midfield dictate structural ball circulation while the frontline focuses on final-third execution.

> it should be notes that the goalkeeper being 0 shows us that the CBs being high is not due to their depth but instead the tactical naunce of possesion flowing through the CBs

> NOTE, remove all references of graphy theory. Focus only on saying "Network Science". 


```
================================================================================
Part 2: Betweenness Centrality Analysis - Arsenal WFC
================================================================================
                                          Position  Betweenness Centrality g(i)
Player                                                                         
Carlotte Wubben-Moy               Left Center Back                     0.322222
Leah Williamson                  Right Center Back                     0.300000
Kim Little                 Left Defensive Midfield                     0.177778
Victoria Pelova           Right Defensive Midfield                     0.138889
Stephanie-Elise Catley                   Left Back                     0.122222
Sabrina D’Angelo                        Goalkeeper                     0.000000
Emma Stina Blackstenius             Center Forward                     0.000000
Alessia Russo            Center Attacking Midfield                     0.000000
Emily Ann Fox                           Right Back                     0.000000
Caitlin Jade Foord                       Left Wing                     0.000000
Bethany Mead                            Right Wing                     0.000000
```
---

#### 4.4 Weighted Clustering Coefficient ($C_w(i)$ & Global $C_w$)
While path lengths and betweenness centrality evaluate macro-level circulation and systemic bottlenecks across the entire graph, the Weighted Clustering Coefficient ($C_w$) shifts focus to local neighborhood density and triangular cohesiveness. In spatial network theory, local passing triads ($i \to j \to k \to i$) represent the core mechanism for press-resistant ball retention, wall passes, and numerical overloads. Evaluating local clustering answers a fundamental tactical question: To what extent does a player participate in tightly bound, multi-partner combination loops rather than direct, linear passing sequences?

> We can reference heavily Buldu's work with Barcelona here. 

##### 4.4.1 Framework Scoping
To evaluate local passing cohesiveness without the distortions of classical network metrics, this section adopts a progressive, bottleneck-weighted triad workflow tailored to spatial football dynamics.

Traditional network clustering measures closed, cyclical loops ($i \to j \to k \to i$). However, these cycles fail to capture progressive football build-up and suffer from spatial boundary biases that penalize wide players operating in restricted corridors. 

Additionally, pure cyclical triangles in football do not means much. We want to see players using triangles to reach a third player and we want to measure the density of passing triangles to identifical working sub groups, but we don't care about pure circles. 

While standard network theory relies on closed, cyclical loops ($i \to j \to k \to i$) to calculate local clustering, this classical formulation presents a fundamental misalignment with football tactics. In possessional dynamics, the primary objective of a passing triangle is not to recycle the ball endlessly back to its origin, but to establish progressive support, wall-pass combinations, and alternative routes to bypass opposition pressing lines.

This leads the framework to evaluating combination structures — such as wall-passes and support triangles — where an originator ($A$) links to a target ($C$) both directly and via an intermediate support option ($B$).

A forward-moving transitive triad—where Player $A$ passes to Player $B$, who then finds Player $C$, while Player $A$ also maintains a direct line to Player $C$ ($A \to B \to C$ and $A \to C$)—represents a highly effective tactical overload, yet standard cyclic clustering assigns it a score of zero.

To account for tactical flow, each 3-player combination is weighted by its weakest passing link, ensuring that a passing sequence is evaluated only as fluid as its lowest-volume channel.

Finally, individual player scores are computed by summing the minimum capacities across all active transitive triads in which a player participates, effectively mapping their integration into the team's overarching build-up engine room.

> Does this retain the matrix cube trick? 

To align our network model with spatial realities on the pitch, we transition to a Total Directed Triad Intensity approach. By evaluating all functional 3-player combinations (incorporating both transitive/progressive channels and cyclical loops) weighted by their minimum channel throughput, this refined metric eliminates structural pitch-boundary penalties and accurately quantifies a player's ability to participate in press-resistant, multi-option passing combinations.

Focusing purely on forward-moving, line-breaking combinations, we eliminate cyclical loops to isolate Transitive Triads ($i \to j \to k$ with $i \to k$). In tactical graph theory, a transitive triad measures a player’s ability to participate in multi-option passing structures where an originator ($i$) can reach a target ($k$) both directly and via an intermediate wall-pass or support option ($j$).

For any given 3-player subset $\{i, j, k\}$, a transitive triad exists if all three directed links ($i \to j$, $j \to k$, $i \to k$) are active. To enforce the bottleneck principle—where a combination play is only as fluid as its weakest passing channel—the intensity of a transitive triad is dictated by its minimum edge weight (channel throughput capacity):

$$I_{\text{transitive}}(i, j, k) = \min \left( w_{ij}, w_{jk}, w_{ik} \right)$$

For each player $i$, their Transitive Triad Intensity ($I_{\text{transitive}}(i)$) is the sum of minimum capacities across all active transitive triads where player $i$ acts as either the originator ($i$), the intermediate wall-pass option ($j$), or the final progressive receiver ($k$):

$$I_{\text{transitive}}(i) = \sum_{\{j, k\} \in \mathcal{N}(i)} \max_{\text{perms}} \left( \min(w_{ij}, w_{jk}, w_{ik}) \right)$$

The team-wide Global Transitive Triad Intensity ($I_{\text{team}}$) is the unweighted mean across all 11 players:

$$I_{\text{team}} = \frac{1}{N} \sum_{i=1}^{N} I_{\text{transitive}}(i)$$

The following script iterates through all unique 3-player combinations ($N = 11 \implies \binom{11}{3} = 165$ potential triplets), evaluates all 6 directed transitive permutations ($a \to b$, $b \to c$, $a \to c$), and aggregates total progressive triad participation scores for each player.

NOTE: the coded implementation specifically looks at clusters that link two players using a second. i.e. a and c with a b included. e.g. w_ab = W[a, b], w_bc = W[b, c], w_ac = W[a, c]. It does not care about c -> a or c -> b. This is because we are looking at clusters, i.e. passing groups, that facilitate linkage. this is a footballing appplication. 

By stripping out cyclical loops and evaluating pure transitive triads ($A \to B \to C$ with $A \to C$), we measure a player's ability to participate in multi-option, forward-moving combinations. Rather than tracking how often the ball cycles backward to its origin, $I_{\text{transitive}}$ quantifies the volume and throughput of progressive wall-passes, line-breaking support options, and alternative passing lanes.


##### Results

##### Team Level (The Macro View)
Focusing on tactical aggregation, roster composition, dynamic pairings, or team-wide identity. This answers how these cluster archetypes combine to impact collective output or performance.

The team-wide Global Transitive Triad Intensity of $I_{\text{team}} = 582.55$ pass units demonstrates a high collective capacity for structured, multi-receiver ball progression through central and half-space channels.


##### Player Level (The Micro View):
Focusing on individual profiles, player traits, positional roles, or specific performance metrics. This tells you who a player is and why they belong in a particular bucket.

By transitioning from classical cyclic clustering to Pure Transitive Triad Intensity ($I_{\text{transitive}}$), our network model shifts from measuring backward possession recycling to isolating high-value, forward-moving tactical combinations ($A \to B \to C$ and $A \to C$). 

Expressed directly in cumulative pass throughput units — where each 3-player wall-pass or progressive triad is weighted by its bottleneck-constrained minimum channel volume ($\min(w_{AB}, w_{BC}, w_{AC})$) — a player’s score reflects their total integrated participation across all overlapping 3-player progression units. 

Consequently, the team-wide global metric ($I_{\text{team}} = 582.55$) does not represent a percentage bound between $0$ and $1$, but rather functions as the structural baseline dividing Arsenal’s progressive engine room from its specialized final-third executors. 

Players operating well above this baseline—led by central double-pivots Kim Little ($1069.0$) and Victoria Pelova ($927.0$), alongside central defenders Carlotte Wubben-Moy ($864.0$) and Leah Williamson ($814.0$)—form an integrated core responsible for virtually all multi-option line-breaking combinations across the pitch.

Conversely, the sharp drop-off seen in wide outlets (Mead at $450.0$, Foord at $275.0$) and central striker Stina Blackstenius ($95.0$) confirms a clear tactical boundary where Arsenal’s central spine builds multi-receiver passing structures to bypass opposition pressure, while advanced attackers operate as terminal receivers tasked with 1-on-1 isolation and direct box execution.

**The Double-Pivot as the Transitive Engine:**
Our understanding of Kim Little ($1069.0$) and Victoria Pelova ($927.0$). They heavily dominate the squad in transitive intensity, proving that their primary tactical function is providing the crucial intermediate wall-pass option ($B$) that allows deep defenders ($A$) to bypass pressing lines and find advanced attackers ($C$).

**Deep Build-Up Originators:**
Central defenders Carlotte Wubben-Moy ($864.0$) and Leah Williamson ($814.0$) form the second highest tier. Their high transitive scores indicate that when they play progressive passes into midfield or the wings, they consistently maintain a secondary direct channel to the target receiver, ensuring built-in redundancy during first-phase progression.

**Alessia Russo’s Key Linking Role:**
Alessia Russo ($641.0$) ranks significantly higher in transitive intensity than any other attacking or wide player. Operating in central attacking midfield, Russo actively drops into intermediate pockets to receive wall-passes and lay possession off to advancing wingers (Beth Mead, $450.0$) or full-backs (Steph Catley, $645.0$).

**Frontline Terminal Isolation:**
As expected in a transitive model, wide forward Caitlin Foord ($275.0$) and center-forward Stina Blackstenius ($95.0$) rank at the bottom of the outfield players. Because Blackstenius operates on the shoulder of the last defender, she acts as a final-third receiver rather than a multi-pass facilitator, meaning few progressive sequences originate from or route through her to a third teammate.

Unlike normalized ratio metrics bounded strictly between $0$ and $1$, Transitive Triad Intensity ($I_{\text{transitive}}$) is expressed in cumulative pass throughput units. For any functional 3-player progressive combination ($A \to B \to C$ and $A \to C$), the algorithm evaluates its capacity as the bottleneck-constrained minimum pass count across its three active channels ($\min(w_{AB}, w_{BC}, w_{AC})$), subsequently awarding this capacity score to all three participating players. Because central playmakers sit at the intersection of numerous overlapping spatial units, their total score reflects the sum of throughput capacities across dozens of simultaneous 3-player combinations. Consequently, absolute values (such as Kim Little’s squad-leading $1069.0$ units relative to the team global average of $582.55$) should be interpreted as cumulative progressive capacity: scores above $900$ denote central playmaking engines involved in nearly all team progression loops, mid-tier scores ($500–900$) highlight key sectoral originators and link players, while low scores ($< 150$) isolate terminal endpoints and specialized target receivers.

<!--
| Player | Position | Transitive Triad Intensity ($I_{\text{transitive}}$) | Tactical Role Profile |
| :--- | :--- | :---: | :--- |
| Kim Little | Left Defensive Midfield | 1069.0 | Primary Transitive Engine / Progression Pivot |
| Victoria Pelova | Right Defensive Midfield | 927.0 | Secondary Transitive Engine / Link Playmaker |
| Carlotte Wubben-Moy | Left Center Back | 864.0 | Deep Build-Up Originator |
| Leah Williamson | Right Center Back | 814.0 | Deep Line-Breaking Originator |
| Stephanie-Elise Catley | Left Back | 645.0 | Left-Flank Overload Partner |
| Alessia Russo | Center Attacking Midfield | 641.0 | Second-Phase Attacking Link |
| Emily Ann Fox | Right Back | 514.0 | Right-Flank Progression Link |
| Bethany Mead | Right Wing | 450.0 | High-Width Wall-Pass Receiver |
| Caitlin Jade Foord | Left Wing | 275.0 | Wide Isolation Outlet |
| Sabrina D’Angelo | Goalkeeper | 114.0 | Rest-Defense Safety Option |
| Emma Stina Blackstenius | Center Forward | 95.0 | Terminal Penetration Target |
-->

##### Triad Level/The Clusters Themselves (The Meso View):
Focusing on the clusters, their centroids, boundaries, and mathematical validity (e.g., silhouette scores, cluster size, overlap). This defines what the distinct archetypes or profiles actually are across your dataset.

Transitive triads ($A \to B \to C$ alongside $A \to C$) measure a team's capacity for progressive ball circulation, wall-passes, and line-breaking combination plays. Because each triad's capacity is constrained by the minimum throughput across its three active channels ($\min(w_{AB}, w_{BC}, w_{AC})$), these top 10 results reveal the primary, press-resistant passing circuits that drive Arsenal WFC's build-up play.

Kim little is in 7 of the top 10. This tell use that her volumne is distributed through different sub-communities. 5 as the taget, 2 as the intermediary. Little acts as the essential linkage between deep central defenders (Wubben-Moy, Williamson) and intermediate facilitators (Pelova, Russo). She ensures Arsenal can cycle possession through central areas while maintaining direct forward lines.

The top two triads contain Carlotte Wubben-Moy ↔ Kim Little showing us they work as be units in an abstract sub-comminity and involves over players beyond them. they facilitiate the movement of the ball often. Steph Catley (Left Back), Wubben-Moy (Left Center Back), and Kim Little form a dense, high-volume overload triangle on the left side of the pitch. This allows Arsenal to comfortably play out from the back under pressure along the left touchline.

Central defenders Carlotte Wubben-Moy (present in 6 of top 7 triads) and Leah Williamson (present in triads 1, 5, 7, and 8) establish a highly **redundant** base. When passing out from defence, Wubben-Moy and Williamson do not rely on single linear passes; they consistently form 3-player structures with Little or Pelova, giving the passer two distinct receiving options.

Asymmetric Progression: Left vs. Right Flank: Left-flank and deep-left circuits dominate the highest-capacity ranks (110+ units). Right-sided progression through Emily Ann Fox (Right Back) appears only in Rank 8 and Rank 10 (55.0 and 51.0 units). This indicates that while Arsenal's left side is used for heavy, high-volume build-up, the right flank is utilized more selectively as a secondary or switching outlet.

Absence of Final-Third Attackers; Only one triad features a central attacking midfielder (Alessia Russo at Rank 9 with 51.0 units), and no top-10 triads feature primary wingers or strikers (e.g., Mead, Foord, Blackstenius). This demonstrates a clear structural split: Arsenal uses a tightly connected 5-to-6 player unit (defenders and double-pivot midfielders) to construct play and break lines, before releasing the ball into advanced areas where attackers operate in 1v1 situations or direct finishing roles rather than continuous 3-player loops.

```
================================================================================
Top 10 Active Transitive Triads
================================================================================
     Player 1 (Origin/Target) Player 2 (Intermediate) Player 3 (Target/Origin)  Total Capacity (Pass Units)
Rank                                                                                                       
1                  Kim Little     Carlotte Wubben-Moy          Leah Williamson                        116.0
2      Stephanie-Elise Catley              Kim Little      Carlotte Wubben-Moy                        111.0
3      Stephanie-Elise Catley              Kim Little          Victoria Pelova                         76.0
4                  Kim Little     Carlotte Wubben-Moy          Victoria Pelova                         69.0
5                  Kim Little         Victoria Pelova          Leah Williamson                         67.0
6      Stephanie-Elise Catley     Carlotte Wubben-Moy          Victoria Pelova                         65.0
7         Carlotte Wubben-Moy         Victoria Pelova          Leah Williamson                         60.0
8             Victoria Pelova         Leah Williamson            Emily Ann Fox                         55.0
9                  Kim Little           Alessia Russo          Victoria Pelova                         51.0
10                 Kim Little         Victoria Pelova            Emily Ann Fox                         51.0
```

> TODO: PRESENT THE POLYGON PLOT

---

##### Summary Table of Case Study Metrics:
Player / Metric,Position,kiin​ / kiout​,siin​ (Received),siout​ (Passed),Net Flow (Δsi​),Betweenness g(i),Clustering Cw​(i)
Player 1 (GK),Goalkeeper,...,...,...,...,...,...
Player 2 (CB),Center Back,...,...,...,...,...,...
...,...,...,...,...,...,...,...
Team Global,Macro Summary,--,Total: 720,Total: 720,Mean: 0,Max: gmax​,Global Cw​
Team d,Avg Shortest Path,d=x.xx,--,--,--,--,--

> TODO: Not sure I will build this table. If I do itll probably go in the appendix

---

#### 4.2 Analytical Observation: Exposing the Interpretation Gap*
Quickly explains a fundamental methodological dilemma: **The Interpretation Gap.**

**The Observed Readout:** The case study demonstrates impressive raw metric values—extremely high node strengths, a low Average Shortest Path ($d$), high global weighted clustering ($C_w$), and a prominent playmaking hub with high betweenness centrality $g(i)$.

**The Analytical Dilemma:**
1. Is this a sign of tactical excellence? One could argue these numbers prove superior positional play, high team fluidity, and resilient passing triangles (Buldú et al., 2018; Gama et al., 2026).
2. Or is it a mathematical triviality? Because $l_{ij} = 1 / w_{ij}$, completing 847 passes automatically shrinks $l_{ij}$ and artificially depresses Average Shortest Path ($d$), while inflating $C_w$ and strength scores.

**The Conclusion:** Looking at a single match network in a vacuum yields zero diagnostic power. We cannot prove whether this structure represents deliberate, high-quality tactical organization or is simply the unescapable mathematical byproduct of high pass volume.

This dilemma directly justifies moving to Section 4.2 (Macro Empirical Baselines) to see if comparing this match against the broader league distribution provides the necessary context.

---

#### 4.2. Macro-Level Context: Empirical League Baselines & The Sparsity Trap
To evaluate whether an observed match network exhibits genuine tactical structure, we must first attempt to contextualize its metrics against an empirical baseline. To test the validity of empirical benchmarking, we isolate a core macro-level network property: Global Average Shortest Path ($d$). We compute team-level passing networks across the entire empirical dataset ($N=264$ team-match instances across 132 games) to construct a league-wide reference distribution.

┌─────────────────────────────────────────────────────────────────────────┐
│                      THE EMPIRICAL BASELINE DILEMMA                     │
├─────────────────────────────────────────────────────────────────────────┤
│ 1. Raw League Baseline (N=264)  ──► Conflates high & low volume teams   │
│                                     (Apples-to-Oranges Comparison)      │
│                                                                         │
│ 2. Volume Sub-Filter (800-899)  ──► Sample collapses to n=1 match       │
│                                     (The Pass Volume Sparsity Trap)     │
│                                                                         │
│ 3. Tactical Formation Filter   ──► Splits modal bins across 11 setups   │
│    (300-399 Pass Range)             (The Tactical Heterogeneity Trap)   │
└─────────────────────────────────────────────────────────────────────────┘

##### 1. The Pass Volume Bias
Topological distance in a passing network is defined as the inverse of pass frequency ($l_{ij} = 1/w_{ij}$). Consequently, raw average shortest path lengths ($d$) are inherently coupled with absolute pass volume: completing a higher volume of passes naturally compresses topological edge costs across the graph.

As shown in Figure 1, there is a strong inverse relationship between total team passes and $d$. Our case study match represents an extreme outlier in pass volume, ranking in the top $1\%$ of the dataset with $847$ completed passes. Correspondingly, its global shortest path ($d = 0.1884$) ranks $10^{\text{th}}$ out of $264$ networks (placing it in the top $3.41\%$ most topologically efficient matches).

While this confirms that pass volume broadly dictates the bounds of $d$, the variance present within individual volume bands indicates that topological efficiency is not purely deterministic. However, comparing a high-possession network directly against a raw league distribution dominated by low-possession or defensively direct teams creates a fundamental "apples-to-oranges" conflation.

##### 2. The Data Sparsity Trap
To eliminate volume bias, the logical next step is to filter the empirical dataset to matches with comparable pass volumes. However, as demonstrated in Figure 2, the empirical distribution of team passes is heavily right-skewed and centered around modal match dynamics.

Attempting to construct a volume-controlled baseline around our case study ($800\text{--}899$ passes) triggers the Data Sparsity Trap: the bin contains exactly $1$ match—our case study itself. Even expanding the contextual window highlights severe sample decay across non-modal tiers ($100\text{--}199$ passes: $n=7$; $600\text{--}699$ passes: $n=13$; $700\text{--}799$ passes: $n=3$).

##### 3. The Tactical Heterogeneity Dilemma
Even where empirical volume appears sufficient, contextual filtering collapses under tactical heterogeneity. The modal league bin ($300\text{--}399$ passes) contains $88$ team-match instances ($33.33\%$ of the dataset), seemingly offering an adequate empirical sample size.

However, a valid control group must also account for tactical spatial alignment (formation topology). Different tactical formations impose distinct spatial constraints and passing preferences; for instance, a compact $4\text{-}4\text{-}2$ emphasizes direct vertical progression, whereas a $4\text{-}3\text{-}3$ or $4\text{-}2\text{-}3\text{-}1$ naturally encourages triangular passing clusters.

When we decompose the $300\text{--}399$ pass bin by starting formation, the $88$ matches fragment across $11$ distinct tactical setups:
- $4\text{-}2\text{-}3\text{-}1$: $n = 23$ ($26.14\%$)
- $3\text{-}4\text{-}3$: $n = 19$ ($21.59\%$)
- $3\text{-}5\text{-}2$: $n = 12$ ($13.64\%$)
- $4\text{-}1\text{-}4\text{-}1$: $n = 11$ ($12.50\%$)
- $4\text{-}3\text{-}3$: $n = 9$ ($10.23\%$)
- Other Formations: $n = 14$ ($15.90\%$)

Filtering simultaneously for both pass volume and tactical formation collapses even the most data-rich empirical bins into statistically fragile sub-samples.

Furthermore, while our dataset is robust ($N=264$ team-matches across a full 22-game season), many sports network studies operate under severe data constraints, often analyzing only a handful of fixtures (Gama et al., 2026)

Finally, while this demonstration focuses on a single macro-level metric ($d$), the sparsity problem compounds exponentially for micro-level, player-based properties (such as Betweenness Centrality or In-Degree). Player metrics require distributing data across specific tactical positions ($11$ positions per team), multiplying the degree of fragmentation and rendering empirical baselines entirely unviable for rigorous hypothesis testing. 

This systemic failure of empirical controls directly dictates the necessity of Spatially-Constrained Generative Null Models. Rather than searching for rare empirical matches that match a team's volume and formation, generative nulls synthesize randomized reference ensembles that natively preserve a team's exact edge weights and degree sequences while testing for genuine tactical organization.


##### Figure 1. Total Passes vs. Global Shortest Path
![Total Passes vs. Global Shortest Path](URL_or_file_path "Optional Hover Title")

##### Figure 2. Pass Distribution
![Pass Distribution](URL_or_file_path "Optional Hover Title")

---

### 5. Null Modelling

#### 5.1. Conceptual Pivot: The Necessity of Synthetic Null Models
Given empirical match data cannot simultaneously provide volume control and statistical power, evaluating passing networks against unconditioned league distributions remains fundamentally flawed. The only mathematically viable solution is to transition from observational controls to Generative Synthetic Null Models.

In network science, a null model constructs a randomized reference ensemble ($\mathcal{G}_{\text{null}}$) designed to preserve low-level graph invariants—such as total edge weight ($W$), node count ($N$), or exact degree sequences ($k_i$) — while systematically destroying higher-order structural organization. Across broader network science literature, raw topological measures are widely recognized as uninformative unless evaluated against randomized reference configurations (Maslov & Sneppen, 2002; Newman, 2010).

In the specific context of sports graphs, Buldú et al. (2018) — citing Sarzynska et al. (2016) — explicitly argue that passing network metrics must be interpreted relative to reference values derived from domain-appropriate null models. They frame null models as the essential mathematical mechanism to quantify structural order versus stochastic disorder, stressing that a realistic baseline must preserve game-specific constraints such as degree distributions, pass lengths, and player roles. This includes preserving both physical spatial coordinates on the pitch and functional player roles—ensuring, for example, that a goalkeeper's distribution profile is not artificially transformed into that of a central playmaker.

This conceptual pivot aligns directly with Gama et al. (2026), who demonstrated that even advanced dynamic indices remain vulnerable to the exact same limitation: without a null model, observed structural variations cannot be distinguished from random match fluctuations or raw pass-volume artifacts. Consequently, Gama et al. (2026) explicitly call for randomized null benchmarks as an absolute requirement for football network analysis.

However, standard topological nulls (such as Erdős–Rényi graphs or unconstrained degree rewiring) fail in sports analytics because they treat the pitch as an abstract, non-spatial graph. As spatial network theory confirms, spatial embeddedness fundamentally dictates connection probability (Barthélemy, 2011); ignoring pitch geometry and distance decay inevitably misinterprets physical spatial constraints as tactical anomalies.

Therefore, to construct a valid benchmark, Section 6 introduces a Spatially-Constrained Generative Null Model — a generative engine that reconciles network randomization with pitch geography, player positional density surfaces, and physical spatial decay.

---

##### 5.2 The Failure of Traditional Topological Nulls in Football
Standard network null models—such as the Erdős–Rényi random graph $G(N, p)$ or the Degree-Preserving Rewiring Model (Configuration Model)—fail when applied to football passing networks because they treat the playing surface as an abstract metric-free topology. When applied directly to aggregated pass matrices, unconstrained rewiring algorithms generate either complete structural collapse or severe combinatorial deadlocks.

###### Table 1. Graph-Theoretic Comparison: Empirical Baseline vs. Traditional Topological Null Models


##### 1. Erdős–Rényi $G(N, p)$: Global Homogenization & Spurious Structure
The $G(N, p)$ baseline assumes uniform connection probability across all player pairs while preserving total pass volume ($W=847$). As shown in Table 1, this unconstrained approach completely erases team structure:
- Collapse of Volume Hierarchy: In empirical matches, central distributors handle vast pass volumes relative to peripheral outlets, producing extreme strength variance ($\text{Var}(s_{\text{tot}}) = 5681.90$). By scattering passes uniformly, $G(N, p)$ collapses strength variance by $97\%$ ($\text{Var}(s_{\text{tot}}) = 171.72$), turning a tactical hierarchy into an artificially flat graph.
- Degree Homogenization: The $G(N, p)$ model compresses degree variance down to $2.26$ ($CV_k$ drops from $0.17$ to $0.09$), forcing every player toward an unrealistically uniform connectivity profile centered around $\langle k \rangle \approx 16.91$.
- Spurious Triad Inflation: Lacking spatial distance decay, the model connects distant player pairs across the pitch with equal probability. Scattering $847$ passes across all available channels activates dozens of cross-pitch player triplets that exchange zero passes in real match play, artificially inflating Global Transitive Triad Intensity from $582.55$ to $844.36$ (+45%).

##### 2. Whole-Edge Rewiring: Deceptive Metrics & The Small-Graph Deadlock
Unlike $G(N, p)$, the Whole-Edge Rewired Null Model (directed Configuration Model) appears to perform well at first glance. Because it explicitly preserves each player's directed degree sequence ($k_i^{\text{in}}, k_i^{\text{out}}$), its unweighted degree metrics ($\langle k \rangle = 16.18$, $CV_k = 0.17$) match the empirical baseline almost perfectly, and it recovers $88.5\%$ of the empirical strength variance ($\text{Var}(s_{\text{tot}}) = 5033.36$).

However, these "acceptable" numbers mask a fundamental methodological deadlock: Degrees-of-Freedom Collapse on Small Micro-Graphs.

Classical configuration models assume large, sparse networks ($N \to \infty, p \to 0$). In an $11$-player graph, there are only $N(N-1) = 110$ possible directed channels. Because elite passing networks activate 60% to 70% of these channels, the space of valid degree-preserving reconfigurations shrinks to near zero. When attempting 2-edge swaps ($A \to B, C \to D \implies A \to D, C \to B$), the vast majority of proposed swaps are rejected because the candidate target channels ($A \to D, C \to B$) already exist in the empirical network.

Consequently, degree-preserving rewiring fails due to three core limitations:
1. Topological Stagnation: Rather than constructing a randomized reference ensemble ($\mathcal{G}_{\text{null}}$), the algorithm becomes combinatorially locked, outputting a slightly perturbed version of the empirical graph rather than a genuine synthetic baseline.
2. Disruption of Spatial Cooperation: On the few occasions where high-volume edge vectors successfully swap, they do so without spatial awareness. Swapping a heavy build-up channel (e.g., 40 passes between goalkeeper and central defender) to a distant receiver generates severe spatial paradoxes—such as direct, high-frequency goalkeeper-to-striker links—which breaks localized tactical triangles and drops Transitive Triad Intensity down to $513.00$ ($-11.9\%$).
3. Inability to Model Synthetic Counterfactuals: Because the model merely re-encodes the specific match's degree sequence, it cannot simulate how an "average league team" would structure play under similar volume or spatial conditions.

##### 3. Conceptual Shift: From Single-Match Swapping to League-Wide Generative Nulls
This methodological failure highlights a critical scope requirement for sports graph analytics. Unlike social networks or web graphs—where single monolithic networks are analyzed in isolation—football network analysis evaluates discrete, low-node-count realizations ($N=11$) sampled from a broader underlying domain.

We do not wish to randomize the isolated 11-node graph of a single match. Rather, our goal is to model the generalized spatial and structural properties of the league season as a baseline reference. While an individual match graph contains only 11 nodes, our full dataset comprises 264 match networks across the season.

A valid null model must therefore move away from rigid, single-match edge-swapping and transition toward a Spatially-Constrained Generative Engine. Section 6 introduces this framework—a generative model that captures league-wide positional density surfaces, distance decay functions, and tactical role constraints to produce true synthetic reference ensembles.

---

## 6. League-Wide Generative Null

> "However, these null models must incorporate the particular features of the system they are describing, and the Euclidean position of the nodes and temporal evolution should be taken into account (Sarzynska et al., 2016)." — Buldú et al. (2018)

### 6.1 The Conceptual Pivot: Requirements for a Valid Football Null
The failure of unconstrained topological rewiring necessitates a fundamental conceptual shift. A valid null model for football passing networks cannot treat the pitch as an abstract graph topology; it must respect the spatial, physical, and tactical realities of match play.

To serve as a meaningful benchmark, a synthetic null process must satisfy three core domain requirements:
- Spatial Coordinates & Distance Decay: Passing probability must be parameterized by spatial origin $(x_i, y_i)$ and target $(x_j, y_j)$, enforcing physical pitch boundaries and the exponential decay of pass completion over distance.
- Positional Density & Spatial Occupancy: The null must reflect the spatial probability density of where players actually operate on the pitch rather than treating nodes as fixed points or abstract indices.
- Domain & Phase Dynamics: The null process must maintain realistic tactical relationships, preserving the directional vectors of possession (progression versus retention) and the natural asymmetry of positional pairings.

Without incorporating these physical and tactical dimensions, downstream detection of team "complexity," "efficiency," or "style" remains an artifact of raw spatial distribution rather than collective organization.

### 6.2 Evaluating Null Realism: From Rigid Matching to Probabilistic Expectations
Buldú et al. (2018) emphasize that null models for passing networks must maintain high realism by incorporating intrinsic features of the game, including degree distributions, pass lengths, and spatial player positions. In classical graph theory, preserving degree distribution requires holding each node's exact number of incoming ($k_i^{\text{in}}$) and outgoing ($k_i^{\text{out}}$) edges strictly fixed during randomization. However, as established in Section 5, forcing an $11 \times 11$ football graph to maintain exact empirical pass counts while swapping edges creates severe combinatorial deadlocks and generates physically impossible spatial vectors, such as high-frequency 70-yard channels between goalkeepers and advanced attackers.

A domain-aware null model reinterprets degree preservation as matching probabilistic domain expectations rather than rigid point values. Instead of forcing a central midfielder to complete exactly 60 passes in every synthetic realization, a valid generative framework samples from a learned probability distribution governing what a player in that specific tactical position and formation typically produces. In this paradigm, outgoing volume ($s^{\text{out}}$) reflects intentional tactical choices, whereas incoming volume ($s^{\text{in}}$) emerges naturally from spatial occupancy, receiver availability, and opponent pressure.

> off track

To determine whether a generated null ensemble ($\mathcal{G}_{\text{null}}$) provides a valid baseline, we evaluate it against both macro-level topological benchmarks and domain-specific footballing constraints. As demonstrated by Narizuka et al. (2014) and surveyed by Alves et al. (2025), real football passing graphs exhibit distinct Small-World properties (Watts & Strogatz, 1998) without following scale-free power laws. Real match networks maintain high local clustering ($C \approx 0.25$) due to localized tactical triangles (e.g., fullback, winger, and central midfielder), alongside short average path lengths ($l \approx 3.3$) that facilitate rapid pitch traversal. Furthermore, because human physical limits, match duration, and pitch boundaries prevent infinite hub growth, valid degree distributions follow a Truncated Gamma Distribution ($f(k) \propto k^{\nu-1} e^{-k/\lambda}$) rather than an unbounded heavy-tailed power law.

Consequently, candidate generative models must satisfy a lightweight four-part terminal evaluation suite before downstream tactical inference can occur. First, the synthetic ensemble must achieve topological alignment by reproducing empirical Small-World clustering and path length bounds ($C_{\text{null}} \approx C_{\text{empirical}}$ and $l_{\text{null}} \approx l_{\text{empirical}}$), avoiding both Erdős–Rényi graph flattening ($C \to 0$) and scale-free hub explosion. Second, the generated networks must preserve degree heterogeneity, maintaining realistic volume variance between primary playmakers and peripheral outlets while respecting upper degree cutoffs. Third, the model must enforce functional role realism, ensuring that central defenders and deep midfielders act as primary structural hubs (Gama et al., 2026) while preventing "Goalkeeper-Centric Hub Paradox" anomalies. Finally, the pass generation engine must incorporate physical spatial vector bounding, applying exponential distance decay to suppress impossible cross-pitch connections between non-adjacent pitch sectors.

> 1. Metric(s) to measure small world. if we can reuse our metrics from earlier that would be great
> 2. Use the degree analysis heterogeneity on hetro from earlier. maybe something to do with player ratios ranges (volume agnostic)
> 3. could use betwenees to record what the position distribution of hubs is. variance is fine but the nulls shouldnt produce extreme, i.e. 1000 nulls 25% has hubs at left back when the league ratio was approx 5%
> 4. Not sure how to do this yet. I think it should be at the network level. record the length of each edge and its weight. produce a table which bins the length and produces a distribution of weight. do this for empirical and null generated
> A. Rememeber this process is new. we don't have to have robust evalution framework, we will just build bull process and "evaluate" them by conducting this analysis. A conclusion and future work will call for a comprehensive and robust evaluation framework for football nulls, i.e. what qualifys and null network for football, what is good enough. 

### 6.3 The Generative Framework: Scaling to Event-Level Resampling
Generating a robust baseline requires scoping back from the aggregated $11 \times 11$ network matrices to the underlying event-level pass distributions. As Gama et al. (2026) highlight, establishing a true statistical baseline to distinguish genuine tactical adaptations from normal match-to-match noise requires leveraging a larger dataset to construct a generative resampling engine.

Instead of rewiring a single match network in isolation, our framework utilizes a full season dataset comprising 264 matches ($N = 264$). By training on this broader event-level corpus, the generative process constructs underlying spatial and tactical probability distributions. From these learned distributions, the engine samples thousands of synthetic pass realizations ($\mathcal{G}_{\text{null}}$).

Each empirical match network can then be benchmarked directly against the generated null ensemble range. Observed topological properties that fall within expected variance (e.g., within $\pm 1\,\text{SD}$) represent standard spatial/tactical expectations, whereas significant deviations expose true collective team organization.

### 6.4 Mathematical Foundations: Markovian Processes and Stochastic Transformations
To construct a spatially considerate and domain-aware generative baseline, we draw upon a mature lineage of football network literature that models match dynamics through stochastic processes. Pioneer works in this domain—most notably Narizuka et al. (2014) and Gama et al. (2026)—demonstrate that sequence transitions and possession flows across a pitch are inherently Markovian. However, adapting these stochastic models for null generation requires an explicit methodological transition: flipping models designed for studying dynamics on a network into generative engines that govern the dynamics of the network.

#### 1. The "Dynamics-ON" to "Dynamics-OF" Paradigm Inversion
A foundational distinction in spatial network science is the separation between processes operating on a graph versus processes constructing the graph itself:
- Dynamics ON the Network: Existing literature predominantly uses Markov chains to model how possession diffuses across a static, pre-existing passing graph. In this framework, the adjacency matrix $A$ is held fixed, and linear algebra transformations quantify ball circulation speed, spatial navigation, and possession transition probabilities between players or pitch zones (Gama et al., 2026; Narizuka et al., 2014).
- Dynamics OF the Network: In contrast, our generative task requires synthesizing brand-new baseline graph topologies ($\mathcal{G}_{\text{null}}$).

We invert this analytical paradigm. Rather than applying transition probabilities to calculate stochastic flow over an established network, we utilize learned spatial and tactical transition rules as the generative engine that samples, places, and grows synthetic pass events. Once this synthetic event corpus is generated, its resulting network is constructed and aggregated normally.

EXISTING LITERATURE (Dynamics ON)           OUR GENERATIVE NULL (Dynamics OF)
┌─────────────────────────────────┐         ┌─────────────────────────────────┐
│ Empirical Adjacency Matrix (A)   │         │ Event Corpus & Spatial Rules    │
└────────────────┬────────────────┘         └────────────────┬────────────────┘
                 │                                           │
                 ▼                                           ▼
┌─────────────────────────────────┐         ┌─────────────────────────────────┐
│ Markovian Transition Prob. P    │         │ Spatial & Receiver Draw Rules, Transition Probabilities P(j|i)   │
└────────────────┬────────────────┘         └────────────────┬────────────────┘
                 │                                           │
                 ▼                                           ▼
┌─────────────────────────────────┐         ┌─────────────────────────────────┐
│ Quantify Possession Diffusion   │         │ Generate Synthetic Pass Data &  │
│ & Stochastic Flow               │         │ Construct Null Network (G_null) │
└─────────────────────────────────┘         └─────────────────────────────────┘



This inversion addresses a methodological loop in recent literature. While stochastic flow models were originally developed in part to bypass traditional network nulls by treating transition properties as self-baselining, researchers now recognize that evaluating whether observed flow properties (such as diffusion speed or structural robustness) reflect tactical organization requires benchmarking them against an underlying spatial null model (Gama et al., 2026).

#### 2. Justifying the First-Order Memoryless Assumption
A stochastic process follows a first-order Markov chain if the transition probability to the next state $X_{t+1}$ depends strictly and exclusively on the current state $X_t$, operating completely blind to prior sequence history (Norris, 1998):

$$P(X_{t+1} = x \mid X_t = x_t, X_{t-1} = x_{t-1}, \dots, X_1 = x_1) = P(X_{t+1} = x \mid X_t = x_t)$$

In passing generation terms, the first-order assumption dictates that a passer’s target choice depends solely on the current spatial state or passer identity, irrespective of who passed them the ball two seconds prior.

While higher-order memory is undeniably crucial for capturing multi-step possession sequences and complex tactical patterns (Dynamics ON), a first-order memoryless model is mathematically sufficient, parsimonious, and optimal for synthesizing static PassMap topologies (Dynamics OF):
1. Topological Alignment with Aggregated PassMaps: An aggregated $11 \times 11$ match PassMap naturally compresses temporal sequence memory into a static directed matrix ($A_{ij}$). Because the target graph representation itself washes away sequential order, modeling null graph generation as a first-order Markov process maintains complete structural consistency with the network data.
2. Empirical Proof of Topological Sufficiency: Narizuka et al. (2014) provided mathematical proof that a first-order spatial Markov process—driven purely by exponential spatial distance decay ($e^{-\beta L_j}$)—is fully capable of synthesizing the macro-level small-world topology, high clustering coefficients ($C$), and Truncated Gamma degree distributions characteristic of real match networks. It achieves this without requiring complex preferential attachment mechanisms or higher-order sequential rules.

---

### 6.5 Null Methodologies

Ideally, there will be 3 null approaches that cascade in depth and connect to each other. I would like to construct, benchmark and evaluate each - word limit permitting. 

#### "Player Recipient Rewire"
The first will be a "Player Recipient Rewire". Here we will take the passes of a given network. The goal will be operate a "reshuffling" process on the recipient player only. 

To do this we will need to work with the all the passes in the dataset. We will extract the end location only and look at the position of players that received the ball. We will chop the pitch up into bins (undecided on the ganularity) and produce a frequence count for every position in that location. Prior to this we will need to build an understand of all the position that exist in the dataset, we may need to map some very similar positions into homogenous cateogries, i.e. left wing back to left back, but this decision will be based on volumne and if there are any rare categrorys. Using this, we will model the probability distribution for every position in the every pitch bin. This distribution is all we need to conduct the null modelling. We take the team/match pass data and we iterate through every pass, we take the end location of the pass, identify the bin it fall in and draw from the distribution give us a position. we then map this position to the most suited player in the team. i.e. the rewire draws and leftback so we assign that to the teams left back. there is an issue here pertaining to matching positions. we have a few options, we either take the frequence counts for each bin, delete the positions that the team doesn't have, and then generate prob distributions from this. Or we map to the most appropriate player, although this requires some thinking. I think the former is the safest. The only thing we need to think about is for teams that have more than one player of the same position, i.e. striker, I am not sure what the correct thing to do here is. I think if we draw a striker and split 50/50 then maybe we are obscuring the true probaility, although actually if there are two players occupy the same positon maybe this is correct, they cant both be recieive the ball in the same place. Ultimately this approach is useful because it entirely retains the network structure, we rewires players behaviour based on the parameter of the team and its topology. This allows us to identify truely unique players performance, i.e. harry kane is striker who drops deep and receives lots of passes. Most strikers don't do this and just focus on goalscoring as per our arsenal network. Therefore, in a rewire, which is based on the league averages for position, unique and great players behaviour will be wiped out. Therefore, when analysising such a network and comparing them to the nulls, clear inference can be made on the player level to say if a metric, maybe a centrality metric is unique. On the other hand, it entirely encodes/retains the exact topology of the basenetwork, it encodes the passing players behaviour and the whole teams interations, the network itself will barely change aside from vastly unique players. It will be similar to the rewiring appraoch expect it will enitrely encode player roles and spatial permeter (given the passes don't change). 













Create an average recipient location for every position on the field.

Ensure that each player on the pitch has a unique position. 

Map their position to the average position to obtain average coordinates.

Use these average coordinates to compute Euclidean distance from the pass end and convert into probs.

For each pass, draw the next (potentially same) recipient from the probably distribution.

Use this to re-wire and randoize to createcrste nulls

I think there needs to be an additional step here. A location only step will over allocate passes to less likely players. For example, strikers do not receive many passes. But passes in the box will be overly allocated to strikers.
1. This might be sorted but the lack of lacks into the box.
2. Instead of using Euclidean distance, segment the pitch into bins. Each bin holds a prob dist of each position receiving the balls. For each end location, draw from the bin and this is the rewire.
3. This also has the benefit of being much quicker at inference as the computation has already been done.

---

Similar thing for end location, though probably simpler. Take the start location and create a probability distribution of where the pass could end. 

If we want to be really accurate here, the prob distribution would again be split by player position, though this may not be required.

I think we can justify using all passes to model the output location. This way we maximise data.

Different positions pass differently, even in the same locations, but maybe this works well for a null models.

Additionally, because we are using so much pass data, invariably the locations should average the dominate positions. I.e. in the left back position, the passes will be dominated by left backs, or nearby players. Of course there will be others in that location who are fundamentally different, the law of averages should regress to the mean, also unique passes from out of position players increase the variance for our prob distributions and make it more realistic.

---

Finally, for generating the pass start location, this should be computed using the position of the player. This way we can say, we have a lift back with 60 passes, draw from the probability  distribtuon to see where these 60 could come front, then iterative over the end and recipient distributions to be an entirely shuffled network

---
