# Project Title Framework
- *Generative Null Models in Football Analytics: Evaluating Topological and Spatial Constraints in Passing Networks*
- *Beyond Naive Topology: A Generative Framework for Context-Aware Null Models in Football Passing Networks*

---

## 1. Introduction & Theoretical Foundation

### 1.1 Research Context & Problem Statement:
Highlighting the surge in network applications to team sports alongside the persistent challenge of establishing statistically valid baselines ("null models") for spatial, high-dimensional games.

### 1.2 Research Objectives:
To formalize, implement, and evaluate generative null model methodologies specifically adapted to football passing networks using open-source spatiotemporal data.

### 1.3 The PassMap Paradigm:
Formal definition of nodes ($V$) and edges ($E$) across three granularities (adapted from Buldú et al.)

1. Player-Centric Networks (Nodes = Players)
2. Pitch-Player Hybrid Networks (Nodes = Players segmented by spatial zones)
3. Pitch-Location Networks (Nodes = Discretized pitch zones/spatial grids)

---

## 2. Data Engine & Foundational Network Metrics

### 2.1 Data Pipeline & Preprocessing: 
Processing StatsBomb open-data (Women’s Super League/ targeted season) using Python (`pandas`, `NetworkX`). Mapping raw event streams into directed, weighted adjacency matrices $A_{ij}$.

### 2.2 Network Topology in Football (Methodological Showcase): 
Efficient, high-density synthesis of structural metrics (drawing on Gama et al., 2026):
- **Micro/Mesoscale:** Centrality measures (Degree, Betweenness, Eigenvector), Clustering Coefficients, Transitivity.
- **Macroscale:** Network Density, Diameter, Heterogeneity, Assortativity.
- **Visual Deliverable:** A dedicated multi-panel diagnostic spread demonstrating metric behavior on a single, standardized PassMap paradigm.

---

## 3. Literature Review & Related Work

### 3.1 The "Why Networks?" Justification: 
Synthesis of recent systematic reviews (Alves et al., 2025; Gama et al., 2026) justifying graph-theoretic approaches over isolated univariate metrics (e.g., xG, total pass volume).

### 3.2 Dynamics ON the Network (Flow & Markovian Diffusion): 
Reviewing stochastic flow research, including Markovian transitions, spectral gaps, and entropy rates (Gama et al., 2026; Narizuka et al., 2014).

### 3.3 The Baseline Deficit: 
Highlighting the explicit calls in contemporary literature for robust null models to validate whether observed network features reflect true tactical intent or stochastic geometric chance.

---

## 4. The Null Model Dilemma: Standard vs. Spatially Constrained

### 4.1 Defining Null Models in Graph Theory: 
The role of baseline distributions in hypothesis testing and signal-from-noise extraction.

### 4.2 The Failure of Standard Topological Nulls:
Implementing and evaluating baseline models (e.g., Erdős–Rényi, degree-preserving configuration models, matrix permutation tests). Demonstrating why unconstrained topological shuffling generates physically impossible passing interactions on a pitch.

### 4.3 The Spatial Constraint Hurdle:
Explaining why the physical proximity of players and pitch geometry make unconstrained nulls mathematically naive in sports analytics.

---

## 5. Experimental Framework: Generative Null Model Construction (MVPs)

### 5.1 Adapting Dynamics-ON Methods to Generative Topology:
Transforming transition probability mechanics (from Markovian flow research) into generative edge-placement algorithms.

### 5.2 Iterative MVP Development:
- MVP 1: Distance-Weighted Spatial Null (gravity/exponential decay based on player positions).
- MVP 2: Formation-Conditioned / Contextual Null (incorporating team structural topology).
- MVP 3: Generative Season-Trained Null (learning multi-dimensional league distributions to prevent data sparsity/overfitting).

### 5.3 Evaluation Protocols: 
Establishing benchmark criteria for null model validity (e.g., bounded metric ranges, conservation of macro-volume, degree distribution fit, visual/spatial sanity checks).

---

## 6. Practical Application: Case Study & Validation

### 6.1 Statistical Validation of Season-Wide Outliers:
Applying the optimal generative null framework to a real-world tactical outlier identified in the season dataset (e.g., a high-performing playmaker or extreme possession style).

### 6.2 Tactical vs. Structural Disambiguation:
Proving whether the target team/player's network metrics genuinely reflect elite performance or are merely expected byproducts of their geometric formation layout.

---

## 7. Discussion & Future Directions

### 7.1 Methodological Limitations: 
First-order Markovian assumptions vs. higher-order memory, pitch discretization resolution, and teleportation parameters ($\alpha$).

### 7.2 Conclusion: 

Summary of contributions to sports network science.

---

<br>
<br>
<br>
<br>

# Core Research Themes
1. **The Spatial-Topological Conflict:** Standard network science assumes node exchangeability. In football, nodes (players) are bound by physical coordinates and pitch geometry. Reconciling abstract graph topology with spatial reality is the core theoretical tension of your work.
2. **Repurposing "Dynamics ON" for "Dynamics OF":** Taking tools originally built to study how the ball moves across a fixed graph (Markov chains, random walks, transition matrices) and flipping them to generate the graph structures themselves.
3. **Data Sparsity vs. Generative Representation:** Proving that manually filtering real-world matches (e.g., only comparing a 4-3-3 against another 4-3-3) leads to severe data dilution, whereas a generative model trained on a full season can synthesize context-aware baselines without losing statistical power.
4. **Signal vs. Structural Artifact:** Establishing whether a team's impressive network score (e.g., high Spectral Gap or Entropy) represents genuine tactical brilliance or is simply a mathematical artifact of their starting formation.

---

# Primary Goals & Deliverables
- **Primary Methodological Goal:** Develop a suite of experimental Minimum Viable Products (MVPs) for football null models, progressing from naive topological shuffles to spatially/contextually constrained generative models.
- **Primary Applied Goal:** Demonstrate a clear validation pipeline where a real-world team/player metric from a full season of StatsBomb data is evaluated against the generated null distribution to verify its statistical significance.
- **Primary Technical Deliverable:** A modular, reproducible Python codebase (pandas, NetworkX) capable of taking raw event tracking/event data and generating customized null network distributions.
- **Academic Endpoint:** A structured dissertation/paper that clearly documents where simple nulls fail, how generative spatial nulls succeed, and how future researchers should construct baselines in sports analytics.

---
