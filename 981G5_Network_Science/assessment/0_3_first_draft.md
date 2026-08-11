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

## 2. Data Engine & Foundational Network Metrics

### 2.1. 2.1 Data Pipeline, Spatial Normalization, and Roster Constraints
The primary dataset for this study is sourced from StatsBomb open-data, comprising high-resolution event logs from the FA Women's Super League (WSL) $2023/2024$ season (`competition_id: 37`, `season_id: 281`). Expanding into women's football directly addresses the critical literature deficits highlighted by Alves et al. (2025) and Gama et al. (2026), who note a severe historical overreliance on single-match or short-tournament men's samples, alongside a systemic underrepresentation of longitudinal women's football datasets.

The raw spatiotemporal event logs are not formatted as relational graphs meaning extensive preprocessing is required to map the event stream into directed, weighted adjacency matrices $A_{ij}$. 

Each completed passing event isolates four core attributes:
- The passer (source node $i$)
- The recipient (target node $j$)
- The spatial origin coordinates $(x_1, y_1)$
- The spatial destination coordinates $(x_2, y_2)$

StatsBomb records events using a standardized $120 \times 80$ yard coordinate system. To maintain spatial consistency across varied pitch dimensions and compatibility with standard soccer pitch visualization tools (such as `mplsoccer`), all spatial coordinates are rescaled and normalized to a uniform $100 \times 100$ relative grid, following established spatial normalization protocols (Buldú et al., 2019).

A significant methodological challenge in constructing match-level PassMaps involves handling player substitutions. While expanding the node count beyond 11 ($N > 11$) to include substituted players is suitable for simple visual overlays, it introduces severe structural distortions into mathematical network metrics. Late-game substitutes naturally accumulate low pass counts, generating isolated, low-degree nodes with weak edge weights that artificially distort macro-scale graph invariants like density, average path length, and clustering coefficients.

In the literature, substitution handling varies based on the underlying analytical goal. For example, Narizuka et al. (2014) and Buldú et al. (2019) maintain a rigid $N=11$ node structure by reassigning a substitute's events to the node of the starting player they replaced. While this positional inheritance maintains fixed node topologies for sequential windowing, it fails when evaluating individual player performance or fitting generative probability distributions across season-wide event logs.

To resolve this, we implement a dual-stage operational rule:
- **For Generative Model Training:** All completed passes across all players are utilized to maximize sample size and preserve underlying spatial probability kernels across the dataset's $150,000+$ passes.
- **For Match Network Construction & Baseline Evaluation:** A match network is strictly constrained to the $11$ players who recorded the highest playing time (minutes played) for that team in that match. While this truncates a small fraction of late-match pass volume, it guarantees an uncorrupted $11 \times 11$ adjacency matrix, preventing low-volume substitutes from distorting topological metrics while keeping the node set mathematically consistent.

#### Summary of Dataset Statistics (WSL 2023/2024)
*The table below outlines the core statistical properties of the curated StatsBomb dataset used across all subsequent generative and empirical evaluation pipelines:*

| Metric Category | Dataset Statistic |
| :--- | :--- |
| **Competition / Season** | FA Women's Super League (WSL) $2023/2024$ |
| **Total Matches Analyzed** | `[INSERT: e.g., 132]` |
| **Total Season Passes Recorded** | `[INSERT: e.g., 154,230]` |
| **Mean Passes per Team per Match** | `[INSERT: e.g., 425.4]` (Range: `[INSERT: e.g., 185 – 720]`) |
| **Mean Unique Players Used per Team per Match** | `[INSERT: e.g., 14.2]` (Range: `[INSERT: e.g., 11 – 16]`) |
| **Pitch Coordinate Scaling** | Rescaled from $120 \times 80$ yd to $100 \times 100$ relative grid |
| **Roster Normalization Rule** | Truncated to Top-11 minutes played per match |

{
  "competition_id" : 37,
  "season_id" : 281,
  "country_name" : "England",
  "competition_name" : "FA Women's Super League",
  "competition_gender" : "female",
  "competition_youth" : false,
  "competition_international" : false,
  "season_name" : "2023/2024",
  "match_updated" : "2026-04-11T13:05:10.794831",
  "match_updated_360" : null,
  "match_available_360" : null,
  "match_available" : "2026-04-11T13:05:10.794831"
}



---

### 2. Demonstations of PassMap Paradigm
This is where we introduce the PassMap paradigm properly. We explain the different types passmap types: player, pitch-player and location. We also need to visualize and present each.

Explain that we will only be using player paradigm

### 3. Football Network Metrics
This is where we introduce what network properties can be used in football analysis and their translations. 

We will heavily rely on liturature for this

We will include a subset table of the metrics that we explain plus a few more but include a full table in the appendix from Gama

We will then settle on suite of the most relevant metrics that we will use for the rest of the project, parrticualrly for the eval and for the next section to demonstate

(In/Out-Degree, Betweenness Centrality, Weighted Clustering $C_w$, and Average Shortest Path $d$)


### 4. Executing Network Properties
In this section we will execute our suite of metrics. 

We will scope down into a single game which will be the game with the most passes from a single team. 

We will compute either metric and visualize where possible

We will try to interpret the results logically but some the conlcusion that we have nothing to compare them to. 

We will compute the league average and range and player the game within this

Given it has so many passes we will expect the metrics to come out high

We will then explain that the empirical baseline is not a fair comparison as it compares to teams which are structurally completely different. 

Of course, hubs are more prevelant in the high pass game. 

We will them filter down to just games with high passes (some sort of range nearby)

This is will demonstrate that subset is signficantly reduced. tactical filtering causes the data sparsity trap ($n \le 2$). The subset may only be the same team from other games.

If we think that the properties stemming from high pass games are the "best"/"good", as per Buldu of Barcelona, then we need a baseline to infer this. 

If the network properties are ONLY representative of high number of passes, then it is not correct to say the properties = good, because a team can pass alot and perform poorly and loose. 

We need a way to strip out the specific tactical and performance intent from this particular same. We want a randomized baseline which retains the degrees, topology (11) and is spatially consistent to comapre the game too. 

If the game properties are jsut the same as a randomized network then they are not "good". they are just natural propertiess. 

> Note if the pass filtering does reduce the subset enough then also filter by formation

















---

- Wasserman, S. & Faust, K. Social Network Analysis: Methods and Applications, (Cambridge University Press, 1994).  
- Newman, M. E. The structure of scientific collaboration networks. Proc. Natl. Acad. Sci. 98, 404–409 (2001)
- Fortunato, S. Community detection in graphs. Phys. Rep. 486, 75–174 (2010).
- Pastor-Satorras, R. & Vespignani, A. Epidemic spreading in scale-free networks. Phys. Rev. Lett. 86, 3200 (2001). 
- Barabási, A. L. The origin of bursts and heavy tails in human dynamics. Nature 435, 207 (2005) 

8.  Borgatti, S. Centrality and network flow. Social Networks 27, 55–71 (2005).  
9.  Newman, M. E. A measure of betweenness centrality based on random walks. Social Networks 27, 39–54 (2005).