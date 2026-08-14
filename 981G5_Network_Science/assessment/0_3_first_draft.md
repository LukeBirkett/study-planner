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

> **Previous Transition:**
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

To compute clustering in a directed, heavily weighted passing network, we adopt the formulation by Ahnert et al. (2007). Edge weights ($w_{ij}$) are first normalized against the maximum observed passing weight in the team ($w_{\max}$):

$$\tilde{w}_{ij} = \frac{w_{ij}}{w_{\max}} \in [0, 1]$$

For player $i$, the local weighted directed clustering coefficient $C_w(i)$ measures the intensity of directed triangles containing $i$, normalized by the maximum possible directed topological triplets that player $i$ could form:

Where:
- $\tilde{W}$ is the normalized weighted adjacency matrix.
- $\tilde{W}^{1/3}$ represents an element-wise geometric transformation ($\tilde{w}_{ij}^{1/3}$) that penalizes triangles containing a weak link.
- $d_i^{\text{tot}} = d_i^{\text{in}} + d_i^{\text{out}}$ is the total unweighted degree (unique incoming and outgoing passing channels) for player $i$.
- $d_i^{\leftrightarrow}$ represents the number of reciprocal (bilateral) passing channels connected to player $i$.

The team-wide Global Weighted Clustering Coefficient ($C_w$) is computed as the unweighted mean across all $N = 11$ players:

$$C_w = \frac{1}{N} \sum_{i=1}^{N} C_w(i)$$

Translating directed, weighted triad formulas into computational code requires careful linear algebra handling to preserve topological accuracy:

**Max-Weight Normalization ($\tilde{w}_{ij} = w_{ij} / w_{\max}$):**
Normalizing by the single highest edge weight across the graph ensures that all transformed weights fall cleanly into the range $[0, 1]$. This prevents raw pass counts (e.g., $128$ passes between center-backs vs. $8$ passes to a forward) from generating arbitrarily large unbounded values, bounding $C_w(i)$ appropriately.

**The "Matrix Cube Trick" ($\tilde{W}^3_{ii}$) & Geometric Weighting:**
In algebraic graph theory, raising an adjacency matrix to the $3^{\text{rd}}$ power ($A^3$) computes the exact number of $3$-step closed walks starting and ending at node $i$. By applying an element-wise cube root ($\tilde{w}_{ij}^{1/3}$) before matrix multiplication, the calculation computes the geometric mean of the three edge weights in each triangle ($\sqrt[3]{\tilde{w}_{ij} \tilde{w}_{jk} \tilde{w}_{ki}}$). Tactically, this enforces a strict constraint: a passing triangle is only as strong as its weakest link. If two players exchange $50$ passes, but the third link involves only $1$ pass, the geometric mean severely penalizes the triad score. Symmetrizing $S = \tilde{W}^{1/3} + (\tilde{W}^T)^{1/3}$ captures all $8$ possible directional orientations of a directed triangle, with the factor $\frac{1}{8}$ ($0.125$) correcting for symmetry expansion.

**Maximum Topological Triplet Denominator:**
The denominator measures the maximum potential directed triangles player $i$ could form given their unweighted connectivity. The term $2 \left[ d_i^{\text{tot}} (d_i^{\text{tot}} - 1) - 2 d_i^{\leftrightarrow} \right]$ accounts for directed edge permutations while subtracting reciprocal edges ($d_i^{\leftrightarrow}$) to prevent double-counting two-way passing channels. This ensures that player scores reflect actual triangular density relative to their physical neighborhood size.

<!--
| Player | Position | Local Weighted Clustering $C_w(i)$ |
| :--- | :--- | :---: |
| Victoria Pelova | Right Defensive Midfield | 0.0297 |
| Kim Little | Left Defensive Midfield | 0.0287 |
| Leah Williamson | Right Center Back | 0.0262 |
| Carlotte Wubben-Moy | Left Center Back | 0.0259 |
| Emily Ann Fox | Right Back | 0.0239 |
| Stephanie-Elise Catley | Left Back | 0.0224 |
| Alessia Russo | Center Attacking Midfield | 0.0193 |
| Sabrina D’Angelo | Goalkeeper | 0.0178 |
| Bethany Mead | Right Wing | 0.0161 |
| Caitlin Jade Foord | Left Wing | 0.0148 |
| Emma Stina Blackstenius | Center Forward | 0.0085 |
-->

The team-wide Global Weighted Clustering Coefficient of $C_w = 0.0212$ demonstrates that Arsenal WFC’s possession structure operates primarily as an expansive, direct progression network rather than a heavily localized overload system. Rather than repeatedly cycling the ball within tight $3$-player loops, ball movement flows via direct distribution routes connecting the defensive origin to the attacking periphery.

To accurately interpret the team-wide global value of $C_w = 0.0212$, two crucial mathematical features of the Ahnert et al. (2007) formulation must be highlighted. First, the metric is strictly directional and cycle-dependent, measuring only fully closed, sequential passing loops ($i \to j \to k \to i$). It does not count static spatial triangles or transitive forward progressions where the ball flows to an advanced receiver via two separate paths ($i \to j \to k$ and $i \to k$) without returning to the originator. If any single leg of a directed 3-player circuit is absent—such as a winger receiving from the backline but never passing back into the build-up—that loop contributes zero to the score. Second, because the algorithm applies an element-wise geometric mean ($\sqrt[3]{\tilde{w}_{ij} \tilde{w}_{jk} \tilde{w}_{ki}}$) to max-normalized edge weights, the calculation severely penalizes unbalanced passing volumes. Even when a physical triangle exists, if two legs carry high pass volumes (e.g., $100$ passes) but the return leg is negligible (e.g., $1$ pass), the geometric mean suppresses the triad score toward zero. Consequently, a global score of $C_w = 0.0212$ (representing just $\approx 2.1\%$ of theoretical maximum density) mathematically proves that Arsenal operates an expansive, vertically oriented progression network: once possession advances into forward channels, it is converted into direct attacking actions rather than recycled in continuous 3-player loops.

The standard Ahnert et al. (2007) denominator normalizes player $i$'s local triangle count against the maximum theoretical directed triplets player $i$ could form with all of their active neighbors across the entire pitch:

$$\text{Standard Denominator} = 2 \left[ d_i^{\text{tot}}(d_i^{\text{tot}} - 1) - 2d_i^{\leftrightarrow} \right]$$

Because an active outfield player connects with 8–10 different teammates across a match, this denominator scales quadratically with their total degree ($d_i^{\text{tot}}$

A Left Back (e.g., Steph Catley) might form dense, highly efficient passing triangles on the left flank with the Left Center Back (Wubben-Moy), Left Midfielder (Kim Little), and Left Winger (Foord). However, because Catley also has weak, long-range, or occasional connections to the Right Center Back (Williamson), Right Back (Fox), and Right Winger (Mead), the standard formula expects her to also form passing triangles with those right-sided players!When she naturally does not form triangles across the pitch, the standard denominator massively dilutes her local score, driving all player values down into the $0.01 - 0.03$ range.

> "A critical consideration when interpreting player-level local clustering ($C_w(i)$) in spatial sports networks is the influence of positional boundaries on graph denominators. Standard network theory normalizes local triad counts against all possible edge permutations across a player's entire unweighted neighbor set ($d_i^{\text{tot}}$). In a football network, this creates an inherent spatial bias:A flank player—such as Steph Catley ($C_w(i) = 0.0224$) or Emily Fox ($C_w(i) = 0.0239$)—operates within a bounded 180-degree spatial corridor. While they may participate in dense, highly efficient passing triads with their immediate left-sided partners (Left Center-Back, Left Midfielder, Left Winger), the standard denominator penalizes them for failing to construct cross-pitch triads with right-sided players with whom they maintain only occasional direct contact.Consequently, the player-level $C_w(i)$ values should not be read as absolute percentages of local overload efficiency, but rather as relative indicators of spatial centrality. Central double-pivots (Pelova and Little) achieve the highest scores ($0.0297$ and $0.0287$) because their central spatial footprint permits 360-degree triad formation, whereas wide and advanced players experience structural metric suppression due to the spatial segregation of modern tactical formations."

At the individual level, a clear positional gradient emerges from deep to advanced zones:

**The Double-Pivot Overload Hubs:** Victoria Pelova ($C_w(i) = 0.0297$) and Kim Little ($0.0287$) record the highest local clustering scores across the squad. Operating in central midfield, Pelova and Little act as the primary facilitators of triangular passing combinations, consistently forming $3$-player recycling loops with the central defenders and full-backs to bypass opposition pressing traps.

**Defensive Circuit Stability:** Central defenders Leah Williamson ($0.0262$) and Carlotte Wubben-Moy ($0.0259$), alongside full-backs Emily Fox ($0.0239$) and Steph Catley ($0.0224$), form the second cluster of local density. This proves that Arsenal’s backline maintains secure, multi-option passing structures during early build-up rather than relying on isolated long-ball clearances.

**Attacking Isolation in the Final Third:** Moving into advanced areas, clustering values decay rapidly: central attacking midfielder Alessia Russo ($0.0193$), wide forwards Beth Mead ($0.0161$) and Caitlin Foord ($0.0148$), and center-forward Stina Blackstenius ($0.0085$) record the lowest triad densities. In the final third, possessional dynamics shift away from multi-pass triangular loops toward direct $1$-on-$1$ take-ons, crossing opportunities, and shot generation. Blackstenius's minimal score ($0.0085$) further reinforces her tactical role as an off-the-ball box finisher operating entirely detached from the team's build-up triangles.

> Truthlly, I don't think this the correct approach to analysing clustering. In football, we don't care about a complete circular triangle, we care about the existence of the triangle as it allows players reach a blocked player via another. 


While standard network theory relies on closed, cyclical loops ($i \to j \to k \to i$) to calculate local clustering, this classical formulation presents a fundamental misalignment with football tactics. In possessional dynamics, the primary objective of a passing triangle is not to recycle the ball endlessly back to its origin, but to establish progressive support, wall-pass combinations, and alternative routes to bypass opposition pressing lines. A forward-moving transitive triad—where Player $A$ passes to Player $B$, who then finds Player $C$, while Player $A$ also maintains a direct line to Player $C$ ($A \to B \to C$ and $A \to C$)—represents a highly effective tactical overload, yet standard cyclic clustering assigns it a score of zero. To align our network model with spatial realities on the pitch, we transition to a Total Directed Triad Intensity approach. By evaluating all functional 3-player combinations (incorporating both transitive/progressive channels and cyclical loops) weighted by their minimum channel throughput, this refined metric eliminates structural pitch-boundary penalties and accurately quantifies a player's ability to participate in press-resistant, multi-option passing combinations.

> we dropped cyclical loops. it basically doesn't mean anything in football expect for maybe identifying tika takq tactics

Focusing purely on forward-moving, line-breaking combinations, we eliminate cyclical loops to isolate Transitive Triads ($i \to j \to k$ with $i \to k$). In tactical graph theory, a transitive triad measures a player’s ability to participate in multi-option passing structures where an originator ($i$) can reach a target ($k$) both directly and via an intermediate wall-pass or support option ($j$).

For any given 3-player subset $\{i, j, k\}$, a transitive triad exists if all three directed links ($i \to j$, $j \to k$, $i \to k$) are active. To enforce the bottleneck principle—where a combination play is only as fluid as its weakest passing channel—the intensity of a transitive triad is dictated by its minimum edge weight (channel throughput capacity):

$$I_{\text{transitive}}(i, j, k) = \min \left( w_{ij}, w_{jk}, w_{ik} \right)$$

For each player $i$, their Transitive Triad Intensity ($I_{\text{transitive}}(i)$) is the sum of minimum capacities across all active transitive triads where player $i$ acts as either the originator ($i$), the intermediate wall-pass option ($j$), or the final progressive receiver ($k$):

$$I_{\text{transitive}}(i) = \sum_{\{j, k\} \in \mathcal{N}(i)} \max_{\text{perms}} \left( \min(w_{ij}, w_{jk}, w_{ik}) \right)$$

The team-wide Global Transitive Triad Intensity ($I_{\text{team}}$) is the unweighted mean across all 11 players:

$$I_{\text{team}} = \frac{1}{N} \sum_{i=1}^{N} I_{\text{transitive}}(i)$$

The following script iterates through all unique 3-player combinations ($N = 11 \implies \binom{11}{3} = 165$ potential triplets), evaluates all 6 directed transitive permutations ($a \to b$, $b \to c$, $a \to c$), and aggregates total progressive triad participation scores for each player.

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

By stripping out cyclical loops and evaluating pure transitive triads ($A \to B \to C$ with $A \to C$), we measure a player's ability to participate in multi-option, forward-moving combinations. Rather than tracking how often the ball cycles backward to its origin, $I_{\text{transitive}}$ quantifies the volume and throughput of progressive wall-passes, line-breaking support options, and alternative passing lanes.

The team-wide Global Transitive Triad Intensity of $I_{\text{team}} = 582.55$ pass units demonstrates a high collective capacity for structured, multi-receiver ball progression through central and half-space channels.

By transitioning from classical cyclic clustering to Pure Transitive Triad Intensity ($I_{\text{transitive}}$), our network model shifts from measuring backward possession recycling to isolating high-value, forward-moving tactical combinations ($A \to B \to C$ and $A \to C$). Expressed directly in cumulative pass throughput units—where each 3-player wall-pass or progressive triad is weighted by its bottleneck-constrained minimum channel volume ($\min(w_{AB}, w_{BC}, w_{AC})$)—a player’s score reflects their total integrated participation across all overlapping 3-player progression units. Consequently, the team-wide global metric ($I_{\text{team}} = 582.55$) does not represent a percentage bound between $0$ and $1$, but rather functions as the structural baseline dividing Arsenal’s progressive engine room from its specialized final-third executors. Players operating well above this baseline—led by central double-pivots Kim Little ($1069.0$) and Victoria Pelova ($927.0$), alongside central defenders Carlotte Wubben-Moy ($864.0$) and Leah Williamson ($814.0$)—form an integrated core responsible for virtually all multi-option line-breaking combinations across the pitch. Conversely, the sharp drop-off seen in wide outlets (Mead at $450.0$, Foord at $275.0$) and central striker Stina Blackstenius ($95.0$) confirms a clear tactical boundary where Arsenal’s central spine builds multi-receiver passing structures to bypass opposition pressure, while advanced attackers operate as terminal receivers tasked with 1-on-1 isolation and direct box execution.

**The Double-Pivot as the Transitive Engine:**
Moving from cyclic clustering to transitive triad intensity completely transforms our understanding of Kim Little ($1069.0$) and Victoria Pelova ($927.0$). They heavily dominate the squad in transitive intensity, proving that their primary tactical function is not looping possession backward, but providing the crucial intermediate wall-pass option ($B$) that allows deep defenders ($A$) to bypass pressing lines and find advanced attackers ($C$).

**Deep Build-Up Originators:**
Central defenders Carlotte Wubben-Moy ($864.0$) and Leah Williamson ($814.0$) form the second highest tier. Their high transitive scores indicate that when they play progressive passes into midfield or the wings, they consistently maintain a secondary direct channel to the target receiver, ensuring built-in redundancy during first-phase progression.

**Alessia Russo’s Key Linking Role:**
Alessia Russo ($641.0$) ranks significantly higher in transitive intensity than any other attacking or wide player. Operating in central attacking midfield, Russo actively drops into intermediate pockets to receive wall-passes and lay possession off to advancing wingers (Beth Mead, $450.0$) or full-backs (Steph Catley, $645.0$).

**Frontline Terminal Isolation:**
As expected in a transitive model, wide forward Caitlin Foord ($275.0$) and center-forward Stina Blackstenius ($95.0$) rank at the bottom of the outfield players. Because Blackstenius operates on the shoulder of the last defender, she acts as a final-third receiver rather than a multi-pass facilitator, meaning few progressive sequences originate from or route through her to a third teammate.

Unlike normalized ratio metrics bounded strictly between $0$ and $1$, Transitive Triad Intensity ($I_{\text{transitive}}$) is expressed in cumulative pass throughput units. For any functional 3-player progressive combination ($A \to B \to C$ and $A \to C$), the algorithm evaluates its capacity as the bottleneck-constrained minimum pass count across its three active channels ($\min(w_{AB}, w_{BC}, w_{AC})$), subsequently awarding this capacity score to all three participating players. Because central playmakers sit at the intersection of numerous overlapping spatial units, their total score reflects the sum of throughput capacities across dozens of simultaneous 3-player combinations. Consequently, absolute values (such as Kim Little’s squad-leading $1069.0$ units relative to the team global average of $582.55$) should be interpreted as cumulative progressive capacity: scores above $900$ denote central playmaking engines involved in nearly all team progression loops, mid-tier scores ($500–900$) highlight key sectoral originators and link players, while low scores ($< 150$) isolate terminal endpoints and specialized target receivers.


> TODO: STRIP OUT THIS WHOLE SECTION ITS STARTED WITH ONE CLUSTERING APPROACH BUT IT WASNT APPROPRAITE. FIND A WAY TO EXPLAIN THIS FINDING IN A CONCISE WORD COULD. THEN PROPERLY EXPLAIN THE NEW APPRAOCH. ANALYSE THE RESULTS AND USE THE POLYGON PLOT TO DEMONSTATE

> BASELINE GLOBAL NUMBER, PLAY LEVEL NUMBERS SCALED AGAINST BASELINE can be higher as they are in many trinagles where the passes overlap, TALK ABOUT THE ORDER TRIAD LIST, WHAT THE TRIPLETS MEAN and PLOT ON PITCH








---

Phase 2: Metric Suite Calculation

B. Betweenness Centrality $g(i)$
- Compute shortest-path betweenness using Dijkstra’s topological distances ($l_{ij} = 1 / w_{ij}$).
- Identify structural "hubs" and critical conduits responsible for linking defensive, midfield, and attacking sectors.

C. Weighted Clustering Coefficient $C_w(i)$ & Global $C_w$
- Calculate local weighted clustering $C_w(i)$ for each player using the Ahnert et al. (2007) formulation to measure local passing triad density.
- Average across all 11 players to derive global team clustering $C_w$

D. Average Shortest Path ($d$)
- Invert weights to establish edge lengths ($l_{ij} = 1 / w_{ij}$).
- Apply Dijkstra’s algorithm to calculate the all-pairs shortest topological path matrix $p_{ij}$
- Compute global team circulation distance: $d = \frac{1}{N(N-1)} \sum_{i \neq j} p_{ij}$ 

Phase 3: Visualization & Tabular Output Layout

The goal here is to put together simple, visual workflow. After computing the metrics, we want to plot then and/or put them into a table. This allows any written analysis to be clear and consice using this visual content as reference. 

The main visual tool should be networks, bar charts or tables. 

1. **Spatial PassMaps:** Custom $100 \times 100$ vertical pitch with node size proportional to total strength ($s_i^{\text{in}} + s_i^{\text{out}}$), node color reflecting Betweenness Centrality $g(i)$, edge width scaled to pass volume $w_{ij}$, and curved arrows (connectionstyle="arc3,rad=0.15") separating directional flows.
2. **Bar Charts:** This is a great oppurtunity to show how networks themselves are the analytical tool, not the fact they can be visualised themselves. We take the networks/adj matrics, compute metrics and then present the network property metrics on a bar chart. We can take a pair of properties, or even more, and the goal is goal is the uncover architypes: Combinations of metrics and infer something. A simple idea could be a dual-bar chart displaying Net Pass Flow ($\Delta s_i$) alongside Betweenness Centrality $g(i)$ for all 11 players, where net flow is: ($\Delta s_i = s_i^{\text{out}} - s_i^{\text{in}}$). The difference between total passes a player completes ($s_i^{\text{out}}$) and total passes a player receives ($s_i^{\text{in}}$). Pairing these we could see a few different types of players. i.e. Positive Bars ($\Delta s_i > 0$): Players who "export" or originate more ball volume than they receive (e.g., Central Defenders or Deep Midfielders initiating build-up from tackles/turnovers)., Negative Bars ($\Delta s_i < 0$): Players who "import" or absorb ball volume (e.g., Strikers or Wingers receiving passes in high-risk attacking areas where possession usually ends in a shot, cross, or turnover)The Deep Playmaker (e.g., Xavi / Rodri type): High positive Net Flow ($\Delta s_i > 0$) combined with high Betweenness Centrality ($g(i)$). Doing this allows us to immediately spot player roles and structural reliance in a single glance. This is a key tool for performance analysis for coaching or player identification or recuitment. However, there are many suitable groups of metrics we could use: Total Volume vs. Betweenness, Betweenness Centrality vs. Local Clustering $C_w(i)$ (Hubs vs. Triangles), but I think a strong approach is to use a network property like centrality with simple degees based properties, i.e in, out, diff, tota.
> I think I'll actually just plot all my suite metrics + 1 degree based.
3. **Summary Table of Case Study Metrics:** The final is a metric table shich can be split down by player + team


##### Summary Table of Case Study Metrics:
Player / Metric,Position,kiin​ / kiout​,siin​ (Received),siout​ (Passed),Net Flow (Δsi​),Betweenness g(i),Clustering Cw​(i)
Player 1 (GK),Goalkeeper,...,...,...,...,...,...
Player 2 (CB),Center Back,...,...,...,...,...,...
...,...,...,...,...,...,...,...
Team Global,Macro Summary,--,Total: 720,Total: 720,Mean: 0,Max: gmax​,Global Cw​
Team d,Avg Shortest Path,d=x.xx,--,--,--,--,--
---

**Analytical Observation: Exposing the Interpretation Gap**
The narrative of Section 4.1 concludes by highlighting a fundamental methodological dilemma: **The Interpretation Gap.**

**The Observed Readout:** The case study demonstrates impressive raw metric values—extremely high node strengths, a low Average Shortest Path ($d$), high global weighted clustering ($C_w$), and a prominent playmaking hub with high betweenness centrality $g(i)$.

**The Analytical Dilemma:**
1. Is this a sign of tactical excellence? One could argue these numbers prove superior positional play, high team fluidity, and resilient passing triangles (Buldú et al., 2018; Gama et al., 2026).
2. Or is it a mathematical triviality? Because $l_{ij} = 1 / w_{ij}$, completing 847 passes automatically shrinks $l_{ij}$ and artificially depresses Average Shortest Path ($d$), while inflating $C_w$ and strength scores.

**The Conclusion:** Looking at a single match network in a vacuum yields zero diagnostic power. We cannot prove whether this structure represents deliberate, high-quality tactical organization or is simply the unescapable mathematical byproduct of high pass volume.

This dilemma directly justifies moving to Section 4.2 (Macro Empirical Baselines) to see if comparing this match against the broader league distribution provides the necessary context.

---

#### 4.2. Macro-Level Context: Empirical League Baselines
**Objective:** Test whether evaluating the single match against the global empirical distribution ($N=234$) provides meaningful context.

**Execution:**
- Compute the same suite of network properties across all 234 match networks in the dataset.
- Map the case study match onto the full league distributions (e.g., box plots or KDE distribution curves showing mean, range, and percentiles).

**Analytical Observation:** Confirm that the selected match sits at the upper extreme for properties like density and hub strength. However, critique this baseline: comparing a high-possession/high-pass game against low-possession or defensively counter-attacking matches conflates fundamentally different tactical structures.

---

#### 4.3. Tactical Sub-Filtering & The Data Sparsity Trap
**Objective:** Attempt to refine the empirical baseline by controlling for tactical context (e.g., filtering for high pass volume and/or matching tactical formations).

Demonstration of the Trap:
- Apply strict contextual filters (e.g., passes $> X$, formation $= 4\text{-}3\text{-}3$).
- Show that sub-setting drastically reduces the available sample size ($n \le 2$), often leaving only the same team across a couple of fixtures.

**Methodological Conclusion:** Empirical sub-baselines fail because real-world match data suffers from the Data Sparsity Trap. You cannot build a statistically robust empirical control group without introducing confounding structural differences.

---

#### 4.4. Conceptual Pivot: The Necessity of Synthetic Null Models
**Objective:** Formalize the requirement for randomized, spatial null baselines as the solution to the network evaluation problem.

##### 4.4.1. Defining the Baseline: What is a Null Model?
In network science, a null model is a generative framework designed to produce a family of randomized graphs ($\mathcal{G}_{\text{null}}$) that preserve selected low-level topological properties of an empirical network ($G$)—such as node count ($N$), total edge weight ($W$), or degree sequence ($k_i$)—while systematically destroying higher-order structural patterns.

By comparing the empirical network against this randomized ensemble, researchers can perform hypothesis testing to determine whether an observed structural feature (e.g., high clustering coefficient, central hub formation, or motif frequency) is a non-trivial emergent property of system design or merely a statistical artifact of lower-level constraints.

In the context of football analytics, passing networks are frequently evaluated using unconstrained network metrics (e.g., eigenvector centrality, modularity, or passing entropy). However, without a null baseline, assessing whether a team's passing structure reflects genuine tactical intent or merely compulsory spatial proximity becomes impossible. A null model isolates tactical signal from structural noise.

##### 4.4.2. Calls for Domain-Aware Nulls in the Literature
The necessity of null baselines in spatial and sports networks is well-documented:
- **Separating Randomness from Design:** Network science literature emphasizes that raw topological measures are uninformative without comparison against randomized configurations (Maslov & Sneppen, 2002; Newman, 2010).
- **Accounting for Spatial Embeddedness and Baseline References:** Buldú et al. (2018) emphasize that network metrics must be interpreted relative to reference values derived from adequate null models. They explicitly argue that to be realistic, passing network nulls must incorporate the intrinsic, spatial, and topological constraints of the game—specifically player positions on the pitch, pass lengths, and the degree distribution—in order to accurately quantify disorder and structural complexity without treating physical constraints as anomalies.

> Buldú et al. (2018) specifically cite Sarzynska et al. (2016) to state that "the interpretation of network metrics should be referred to reference values, which can be obtained from adequate null models".

> Game-Specific Parameters: They explicitly list what a realistic football null model must preserve: degree distribution, length of passes, and player positions on the pitch.

> Quantifying Order vs. Noise: They frame null models as the mathematical mechanism to "determine the level of randomness of the topology" and "quantify the amount of disorder and complexity" in passing networks.

- **The Full-Circle Moment in Football Analytics:** Serving as a primary theoretical catalyst for this project, Gama et al. (2026) represent a full-circle realization in football network literature. While historical efforts shifted toward complex Markov-spectral dynamics in an attempt to capture possession flow beyond static SNA, Gama et al. (2026) demonstrate that higher-order dynamic indices (e.g., Entropy Rate, Spectral Gap, Kemeny's Constant) remain vulnerable to the same fundamental limitation: without a null model, observed structural or stochastic variations cannot be distinguished from random match fluctuations or raw pass-volume artifacts. Consequently, Gama et al. (2026) explicitly call for randomized null benchmarks as an absolute requirement for passing network analysis as a whole
- **Spatial Network Theory:** Expert consensus in spatial graph analysis (Barthélemy, 2011) confirms that spatial embeddedness fundamentally governs link probability. A model that ignores distance decay will inevitably treat normal physical constraints as structural anomalies.

##### 4.4.3. The Failure of Traditional Topological Nulls in Football
Standard network null models—such as the Erdős–Rényi random graph $G(N, p)$ or the Degree-Preserving Rewiring / Configuration Model—fail when applied to football passing networks because they treat the pitch as a topological abstraction rather than a physical, bounded metric space.

> This it to be demonstration section. We will take the network we are working with and try to reshufle it directly using the traditional/classical/basic Null appraoches. They will be easily fail infact, most iterations we try should be complete failures but we will run the models several times to get extreme examples which we can present and talk about here.. 

When applied to passing data, this unconstrained edge-swapping produces structurally absurd dynamics:
- **The "Goalkeeper-Centric Hub" Paradox:** Standard rewiring preserves total passes made and received by each player ($k_in, k_out$). Because goalkeepers and central defenders exchange numerous short passes in modern build-up play, rewiring redistributes these edges across the entire vertex set. The goalkeeper suddenly acquires high-frequency direct passing connections to the opposition penalty box, acting as a hyper-central playmaker.
- **Physically Impossible Geometries:** In a real match, pass completion probability decays exponentially with distance, pitch boundary constraints, and opposition pressure. Standard topological nulls ignore spatial coordinates ($(x, y)$), routinely generating networks dominated by 70-yard diagonal passes and extreme cross-pitch loops executed with equal probability to a 5-yard lateral lay-off.
- **Violation of Dynamic Phase Flow:** Football passes follow a directional directional vector toward the opponent's goal. Topological rewiring breaks the natural forward/backward sequence, creating unnatural closed-loop passes between attackers and deep defenders that violate tactical logic.

> There is also something about violating relationships which isn't quite the same are geometries. Because the pass map models accumuclated passes, it's not that a cross field relationships represent cross field passes but it could be that is violates where the player tends to operate. A players node locaiton is their average possition on the pitch, and in our case is modelled by pass average pass location. A striker and goalkeeper can pass to eachother, however, this being a heavy link violates their positioning. This is still spatially considerate but just a little different to "Physically Impossible Geometrie". 

> Recall that we have in and out degree. This may make it easier to explain some of the points. Also, in and out degree tend to work in pairs. Either that 2 players tend to pass alot between each other, or there is a clear tactic relationship between two players, i.e. a crossing winger will pass in the strikers path but the reverse link will not happen much as most strikers don't contributing to passing play much and they tend to be the highest terminal player hence rarely have anyone to pass forward to

Null Model Type,Preserved Parameters,Fatal Flaw in Football Context
"Erdős–Rényi G(N,p)","Node count N, Edge probability p",Uniform connection probability completely destroys team structure and spatial positioning.
Configuration Model,Exact degree sequence ki​,Preserves pass counts but generates physically impossible pass vectors and nonsensical player roles.
Distance-Decay Null,Pass distance distribution P(d),"Accounts for pass length but ignores pitch geography, field boundaries, and player spatial zones."

##### 4.4.4. The Conceptual Pivot: Requirements for a Valid Football Null
Because classic topological models fail, we establish a core conceptual pivot: A valid null model for football passing networks must be spatially considerate, rule-constrained, and domain-aware.

To construct a meaningful benchmark, a synthetic null baseline for football must explicitly account for three non-negotiable physical constraints:
1. **Spatial Coordinates & Pitch Boundaries:** Passing probability must be parameterized by spatial origin $(x_i, y_i)$ and target $(x_j, y_j)$, enforcing physical spatial bounds.
2. **Occupancy & Positional Vectors:** The null must reflect the spatial probability density of where players actually operate on the pitch rather than treating nodes as fixed points or abstract indices.
3. **Domain Dynamics:** The null must respect directional flow (progression vs. retention) and phase transition constraints innate to the game.

> These explainations are a bit fluffy and sound AI generate. I will rewrite this stating that null models must reflect the spatial and physics relaties of football. But also that shuffling must also be aware of the domain, maintaining realistic relationships and tactical nuances (progressions, retension, positions)

> Note as of this section, we haven't introduce the concept of scoping back from the aggregated network and working with the underling pass data to produce a viabale null network. Therefore, 

Without incorporating these spatial and tactical dimensions into the null baseline, any downstream detection of tactical "complexity," "efficiency," or "style" remains a artifact of raw spatial distribution rather than collective team organization.

Transition to Section 5: Having established the theoretical necessity and spatial criteria for a football null model, Section 5 presents our formal mathematical framework: a Spatially-Constrained Markovian Null Model that generates randomized passing baselines conditioned on pitch geography, player density surfaces, and transition probabilities.

---