# Project Title Framework
- Beyond Naive Topology: A Generative Spatial Null Framework for Football Passing Networks
- Disambiguating Tactics from Geometry: 1st-Order Generative Null Models in Football Analytics

┌─────────────────────────────────────────────────────────────────────────┐
│ SECTION 1: Introduction & Foundations                      ~800 words   │
├─────────────────────────────────────────────────────────────────────────┤
│ SECTION 2: Data Pipeline & Diagnostic Metric Showcase      ~350 words   │
├─────────────────────────────────────────────────────────────────────────┤
│ SECTION 3: The Literature Gap (Alves, Gama, Buldú)         ~250 words   │
├─────────────────────────────────────────────────────────────────────────┤
│ SECTION 4: 1st-Order Generative Null Engine (MVPs 1-3)     ~750 words   │
├─────────────────────────────────────────────────────────────────────────┤
│ SECTION 5: Practical Application & Case Study              ~450 words   │
├─────────────────────────────────────────────────────────────────────────┤
│ SECTION 6: Methodological Limitations & Conclusion         ~200 words   │
└─────────────────────────────────────────────────────────────────────────┘

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
---

#### 4.1. Micro-Level Execution: Case Study Analysis
**Objective:** Establish the empirical baseline calculation and visualization of our core metric suite—Degree (Unweighted/Weighted In/Out-Degree & Distribution), Betweenness Centrality, Weighted Clustering Coefficient ($C_w$), and Average Shortest Path ($d$)—on a single, high-density match network.

**Selection Criteria:** 
- Sample Choice: Select the single team-match network exhibiting the absolute highest completed pass volume across the entire $N=264$ season dataset (e.g., Arsenal WFC, Record Index 60, with $847$ total completed passes).
- Rationale: Utilizing a "maximal activity" edge case provides a stress-test for the metrics. High-volume networks push topological density, hub formation, and path lengths toward their empirical extremes, making them ideal for testing whether high metric values reflect tactical brilliance or merely raw passing volume.

**Execution & Analytical Workflow:**

Phase 1: Graph Construction & Matrix Extraction
- Isolate completed pass events for the selected match and filter to the Top-11 players by minutes played.
- Construct the directed, weighted adjacency matrix $A_{ij}$ where $w_{ij}$ represents completed passes from Player $i$ to Player $j$.
Compute player average positions $(x_i, y_i)$ on the normalized $100 \times 100$ grid to anchor spatial nodes.

Phase 2: Metric Suite Calculation

A. Degree Analysis (Node Volume & System Centralization)
- Unweighted Degrees ($k_i^{\text{in}}, k_i^{\text{out}}$): Count unique incoming and outgoing pass channels per player to measure structural breadth and connectivity.
- Weighted Degrees / Node Strengths ($s_i^{\text{in}}, s_i^{\text{out}}$): Calculate total passes received ($s_i^{\text{in}} = \sum_{j} w_{ji}$) and completed ($s_i^{\text{out}} = \sum_{j} w_{ij}$).
- Directional Asymmetry (Net Flow $\Delta s_i$ & Ratio): $\Delta s_i = s_i^{\text{out}} - s_i^{\text{in}}$
    - $\Delta s_i > 0$ (Net Exporter / Originator): Deep playmakers or central defenders initiating build-up.
    - $\Delta s_i < 0$ (Net Importer / Absorber): Strikers/wingers receiving in high-risk zones where possession terminates in shots/turnovers.
- Degree Distribution & Centralization: Evaluate team-wide degree variance and Freeman’s Degree Centralization ($C_D$) to determine if passing volume is evenly distributed or concentrated around a single playmaker.

B. Betweenness Centrality $g(i)$
- Compute shortest-path betweenness using Dijkstra’s topological distances ($l_{ij} = 1 / w_{ij}$).
- Identify structural "hubs" and critical conduits responsible for linking defensive, midfield, and attacking sectors.

> Why does this need Dijkstra’s?

C. Weighted Clustering Coefficient $C_w(i)$ & Global $C_w$
- Calculate local weighted clustering $C_w(i)$ for each player using the Ahnert et al. (2007) formulation to measure local passing triad density.
- Average across all 11 players to derive global team clustering $C_w$

D. Average Shortest Path ($d$)
- Invert weights to establish edge lengths ($l_{ij} = 1 / w_{ij}$).
- Apply Dijkstra’s algorithm to calculate the all-pairs shortest topological path matrix $p_{ij}$
- Compute global team circulation distance: $d = \frac{1}{N(N-1)} \sum_{i \neq j} p_{ij}$ 

Phase 3: Visualization & Tabular Output Layout

> Honestly, this section has gone a bit crazy. I just want to plot each metrics appropriate and analyse it. I also want to compute the relevant metrics in a table
> - Network
> - Bar Chart
> - Table

To maintain clarity, Section 4.1 will present outputs in two complementary formats:
1. Dual-Panel Spatial Visualization:
- Panel A (Spatial PassMap Overlay): Custom $100 \times 100$ vertical pitch with node size proportional to total strength ($s_i^{\text{in}} + s_i^{\text{out}}$), node color reflecting Betweenness Centrality $g(i)$, edge width scaled to pass volume $w_{ij}$, and curved arrows (connectionstyle="arc3,rad=0.15") separating directional flows.
- Panel B (Net Flow & Centrality Profile): A dual-bar chart displaying Net Pass Flow ($\Delta s_i$) alongside Betweenness Centrality $g(i)$ for all 11 players.
> t is a proposed two-part bar chart designed to give you a clear, side-by-side player profile for the 11 players in your case study match.
> . Net Pass Flow ($\Delta s_i = s_i^{\text{out}} - s_i^{\text{in}}$)
> The difference between total passes a player completes ($s_i^{\text{out}}$) and total passes a player receives ($s_i^{\text{in}}$).
> How it looks on a bar chart:
> Positive Bars ($\Delta s_i > 0$): Players who "export" or originate more ball volume than they receive (e.g., Central Defenders or Deep Midfielders initiating build-up from tackles/turnovers).
> Negative Bars ($\Delta s_i < 0$): Players who "import" or absorb ball volume (e.g., Strikers or Wingers receiving passes in high-risk attacking areas where possession usually ends in a shot, cross, or turnover).
> 2. Betweenness Centrality ($g(i)$)
> What it is: A score measuring how often a player acts as a necessary bridge on the shortest passing paths between all other pairs of players.
> How it looks on a bar chart: A positive bar height showing which players act as the primary "hubs" or connectors linking different team sectors (e.g., turning defense into attack).
> Grouping them for all 11 players allows you to immediately spot player roles and structural reliance in a single glance:
> The Deep Playmaker (e.g., Xavi / Rodri type): High positive Net Flow ($\Delta s_i > 0$) combined with high Betweenness Centrality ($g(i)$).
> The Target Forward: High negative Net Flow ($\Delta s_i < 0$) with very low Betweenness Centrality ($g(i)$).
> The Peripheral Winger: Near-zero Net Flow with low Betweenness Centrality (receives few passes, makes few passes, rarely bridges the team).

> Not sure just I like this because flow can be ambigous with football as players have high passing players also receive the ball alot. In fact they have to receive it to pass!
> However, I do like the prospect of plotting network properties on a bar chart

> Note, this bar chart appraoch can be acheived in different ways, i.e. just in degrees, vs out degrees (or even all 4, in, our, diff, cent)
> Total Volume vs. Betweenness
> Betweenness Centrality vs. Local Clustering $C_w(i)$ (Hubs vs. Triangles)

> Essentially the goal is the uncover architypes. Combinations of metrics and infer something
> Net Flow ($\Delta s_i \approx 0$): High volume in, high volume out., Betweenness ($g(i)$): Sky-high (the ball must flow through them).
> Net Flow ($\Delta s_i > 0$): Wins the ball via tackles/interceptions or takes goal kicks/free kicks, generating more passes than they receive.



Summary Table of Case Study Metrics:

Player / Metric,Position,kiin​ / kiout​,siin​ (Received),siout​ (Passed),Net Flow (Δsi​),Betweenness g(i),Clustering Cw​(i)
Player 1 (GK),Goalkeeper,...,...,...,...,...,...
Player 2 (CB),Center Back,...,...,...,...,...,...
...,...,...,...,...,...,...,...
Team Global,Macro Summary,--,Total: 720,Total: 720,Mean: 0,Max: gmax​,Global Cw​
Team d,Avg Shortest Path,d=x.xx,--,--,--,--,--

**Analytical Observation: Exposing the Interpretation Gap**
The narrative of Section 4.1 concludes by highlighting a fundamental methodological dilemma: The Interpretation Gap.

The Observed Readout: The case study demonstrates impressive raw metric values—extremely high node strengths, a low Average Shortest Path ($d$), high global weighted clustering ($C_w$), and a prominent playmaking hub with high betweenness centrality $g(i)$.

The Analytical Dilemma:
1. Is this a sign of tactical excellence? One could argue these numbers prove superior positional play, high team fluidity, and resilient passing triangles (Buldú et al., 2018; Gama et al., 2026).
2. Or is it a mathematical triviality? Because $l_{ij} = 1 / w_{ij}$, completing 847 passes automatically shrinks $l_{ij}$ and artificially depresses Average Shortest Path ($d$), while inflating $C_w$ and strength scores.

The Conclusion: Looking at a single match network in a vacuum yields zero diagnostic power. We cannot prove whether this structure represents deliberate, high-quality tactical organization or is simply the unescapable mathematical byproduct of high pass volume.

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

> This it to be demonstration section. We will take the network we are working with and try to reshufle it directly. 

To demonstrate this breakdown, consider a standard network rewiring algorithm applied to an empirical 11-player passing network:

```
[Standard Rewiring Operation]
Given edge pair (A -> B) and (C -> D):
Rewire to (A -> D) and (C -> B), preserving degree sequence (k_out, k_in).
```

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













This section can be a comprehive Null section

Define what a null model is and explain why it will help us here using Network Science terms but then lending the logic specially to football and our case study

Mention the calls for Null models in the liturature 

Quickly explain AND demonstate why traditional Nulls fail. We only have a small network so we can quickly re-wire and other trad methods of nulls to show how they fail the game of football, i.e. goalkeepr hubs, ridiculous cross field relationships. 

This is where we explain that the construct of a null needs to be spatially considersate and specifical to the rules and charactistics of the domain. 

I think section 5 should take this build up and be the place where full develop the null proposal and reference the dynamics of and markovian work found in the lituruature



Key Arguments to Frame:
- Volume $\neq$ Quality: High metric values do not inherently imply "good" or "effective" play; a team can maintain high pass density, exhibit strong hubs, and still lose.
- Emergent vs. Intentional Topology: If a metric value matches what would occur in a random network constrained only by space and node degrees, the property is an emergent mathematical feature of passing volume, not a distinct tactical signature.
- The Null Solution: To isolate true tactical intent, we must strip out volume and spatial constraints by benchmarking the empirical network against a synthetic null ensemble ($N=11$, degree-preserved, spatially consistent).









