# Project Title Framework
- Beyond Naive Topology: A Generative Spatial Null Framework for Football Passing Networks
- Disambiguating Tactics from Geometry: 1st-Order Generative Null Models in Football Analytics

---

## 1. Introduction & Theoretical Foundation (~350 words)

### 1.1 Research Context & Problem Statement: 

The surge of Network Science in sports, contrasted with the critical baseline deficit: observed network properties are routinely interpreted as deliberate tactical achievements without verifying if they simply reflect spatial geometry or volume artifacts (Gama et al., 2026).

### 1.2 Research Objectives:
To formalize, implement, and evaluate a parsimonious, 1st-order Markovian generative null framework using open-source WSL spatiotemporal event data.

### 1.3 The PassMap Paradigm:
Formal definition of nodes ($V$) and edges ($E$) across three spatial granularities (Player-Centric, Hybrid, Pitch-Zone) adapted from Buldú et al.

---

## 2. Data Engine & Diagnostic Metric Sweep (~450 words)

### 2.1 Data Pipeline & Preprocessing:
Processing StatsBomb WSL season data ($150,000+$ passes) into directed, weighted adjacency matrices $A_{ij}$ using Python (pandas, NetworkX).

### 2.2 Metric Taxonomy (Volume vs. Variability)
Grounding evaluation metrics in domain-specific football language using Gama et al. (2026):
- **Micro/Mesoscale Workload (Centrality):** Degree, Betweenness (connective mediation), Clustering Coefficient (triangulation).
- **Micro/Mesoscale Variability (Entropy):** Node Transition Entropy (individual passing unpredictability).
- **Macroscale System Properties:** Network Density (fluidity), Heterogeneity (concentration), Average Shortest Path (circulation distance).
- **Establish a Evaluation Metric Suite:** The focus on In/Out-Degree, Betweenness Centrality, Weighted Clustering ($C_w$), and Average Shortest Path ($d$) selects the most intuitive, widely cited metrics in the literature (as confirmed by Alves et al., 2025, and Gama et al., 2026). 
    - **Degree (In/Out):** Workload and direct pass/receive volume.
    - **Betweenness Centrality:** Connective mediation (bridging tactical lines).
    - **Weighted Clustering ($C_w$):** Local combination play and local triangulation.
    - **Average Shortest Path ($d$):** Global circulation speed calculated via Dijkstra on inverted weights $l_{ij} = 1/w_{ij}$
- **Empirical Dead-End:** Select match with the highest pass volume in the WSL season. Use shortest length ($l_{ij} = 1/w_{ij}$), to explain why this distorts the network and artificially elevates centralities
- **Exposes the Sparsity Trap & Justifies Null Models:** The first approach to fix this would be to filter the he empirical season dataset for matching constraints (e.g., only high-volume matches played in a 4-3-3 formation). But the sample size will collapses.  Cite Gama et al.’s (2026) $n=2$ limitation, manual filtering causes severe data sparsity and statistical overfitting, leaving generative null models as the only mathematically viable solution.  

#### Metric Showcase
- Load a single match (highest pass volume)
- Construct the $11 \times 11$ directed, weighted adjacency matrix $A_{ij}$
- Compute and plot the diagnostic metrics (e.g., bar charts for player centralities and macro team scores).
- Compare this extreme match’s metrics against unconditioned league-wide season averages. (requires computation on every match/team)
- The team/players appear to perform in the 99th percentile across almost all metrics, but this is a mathematical artifact of total pass volume rather than proof of tactical genius.
- Attempt to normalize based off pass volumne. State sample sinze
- Attempt to normalize further based off formation. State Sample Size
- Should collapse depsite seasons worth of data
- Cite Gama et al. (2026) to state that filtering empirical datasets for granular tactical contexts destroys statistical power, leading to overfitting and an inability to distinguish tactical intent from random match-to-match noise.
- Conclude the section by stating that to evaluate whether a team's topological properties represent genuine tactical execution, we cannot rely on sparse empirical averages—we strictly require a generative spatial null model engine.

---

## 3. Literature Review: The Baseline Deficit (~450 words)

### 3.1 The "Why Networks?" Justification:
Citing systematic reviews (Alves et al., 2025; Gama et al., 2026) to prove graph metrics capture collective interaction patterns that univariate metrics (xG, total pass count) miss.

### 3.2 Dynamics ON the Network (Flow & Markovian Diffusion):
Reviewing stochastic flow research (spectral gaps, entropy rates, transition matrices $P = D^{-1}A$). 

### 3.3 The Baseline Deficit & The Sparsity Trap:
Why standard topological shuffles fail (generating physically impossible long-distance passes across 70m).

Why filtered empirical baselines fail (filtering real matches for 4-3-3 context destroys sample size, causing data sparsity and overfitting).

Citing Gama et al.'s (2026) explicit call for null models as the primary literature gap.

---

## 4. Experimental Methodology: Generative Null Engine (MVPs) (~900 words)

### 4.1 1st-Order Markovian Foundation:
Defining the memoryless assumption $P(X_{t+1} \mid X_t)$. Explaining why modeling isolated spatial pass events is a mathematically parsimonious and sufficient baseline for static $11 \times 11$ PassMaps.

### 4.2 League-Wide Positional Anchoring ($\vec{p}_k^{\text{league}}$)
Explaining why node positions are anchored to league-wide positional means rather than match-specific centroids (preventing generative overfitting and ensuring deep-dropping strikers show up as outliers). Code logic for lateral disambiguation (e.g., LCM vs. RCM).


### 4.3 Cascading Lineage of Generative MVPs:

#### MVP 1: Pass-Level Recipient Rewiring:
Fixed empirical pass vectors $(x_1, y_1) \to (x_2, y_2)$; 1st-order spatial receiver assignment using distance decay:

$$P(\text{Receiver} = k \mid \vec{x}_{\text{end}}, \text{Passer } i) = \frac{\exp(-\lambda \cdot d_k)}{\sum_{m \neq i} \exp(-\lambda \cdot d_m)}$$

---

#### MVP 2: Pass-Level; End-Location Recipient Rewiring:


---


#### MVP 3: Full Spatial Event Generation Engine:
Learning 1st-order spatial kernel distributions over $150,000+$ season passes; synthesizing start/end vectors and drawing receivers dynamically.

Note, technicially 1-3 are just one step of complexity added on each time. 2 and 3 use the same model from 1. 3 uses 1 and 2 as well as modelling end location. 

The idea is that each step loses (or retains) a fixed parameter. 

MVP just retains the formation and degrees but is the most complex to model.

The more you keep in the model, the more likely the nulls are the overfit to the input. For example, retaining pass start location encodes the players passing ability. If this is particular unique then it will be encoded into the network. The flip side is, this makes it much easier to model 

---

#### MVP 4: Volume-Controlled Sub-Network Engine:
Generating 25/50-pass incremental windows to evaluate macro-topological decay while controlling for raw pass volume (adapted from Buldú et al., 2019).

> note, I might drop this, its a bit abstract from 1-3. Although it is the closest to traditional null methods as we arent scoping down to the underlying passes, we are staying at the network level. 

---

## 5. Practical Application: Case Study & Tactical Disambiguation (~550 words)

### 5.1 Identifying the Tactical Outlier:
Selecting a real-world tactical anomaly from the StatsBomb WSL season (e.g., a deep-lying playmaker or extreme possession-based team).

> Ideally, revert back to the orginal metric 

### 5.2 Testing Against the Generative Null Distribution:
Running 1,000 synthetic null iterations through the MVP 2/3 engines to establish $95\%$ confidence bounds for Betweenness, Clustering, and Shortest Path. 

### 5.3 Tactical vs. Geometric Disambiguation:
Proving whether the target player's high centrality or low path length represents true tactical execution or is merely an expected mathematical byproduct of spatial formation layout.

---

## 6. Discussion & Conclusion (~300 words)

### 6.1 Methodological Limitations:
First-order memoryless assumptions vs. higher-order possession chains (HONs); spatial resolution constraints.

### 6.2 Concluding Remarks:
Summary of contributions to sports network science; establishing the generative null framework as a new standard for sports analytics.



