*Separating Emergent Coordination from Geometric Noise: Higher-Order Spatial Markovian Null Models from Empirical Collectives to Synthetic Swarms*
#### _Abstract_
Decentralised multi-agent systems (MAS)—from human teams and biological collectives to autonomous robotic swarms—rely on localised, dynamic interactions to drive emergent collective behaviour. However, evaluating whether observed interaction topologies reflect deliberate, policy-driven coordination rather than passive spatial proximity and volume artefacts requires rigorous statistical benchmarking. Traditional random graph baselines (such as Erdős–Rényi $G(N,p)$) fail in spatially embedded domains because uniform edge generation destroys physical geometry, flattens workload inequality, and produces implausible cross-role interactions. To address this, my preliminary research used association football passing networks ($N = 89,781$ events) as an empirical benchmark, engineering domain-aware spatial null models to isolate deliberate tactical coordination from baseline geometric noise. This proposal generalises that methodological foundation across the domain boundary to synthetic multi-agent systems.

The research executes across three progressive phases: First, it resolves the theoretical bottlenecks of static, memoryless baselines by formulating continuous, higher-order ($k$-step), non-stationary spatiotemporal Markovian null models. Second, it ports this framework to cooperative Multi-Agent Reinforcement Learning (MARL) benchmarks to audit whether learned communication topologies represent genuine coordination or spatial co-location artefacts. Finally, it derives a closed-form, differentiable surrogate of the spatiotemporal null expectation to act as a topological regulariser within Graph Neural Network (GNN) message-passing layers, pruning redundant cyclic loops and enforcing bandwidth-efficient routing.

---
### 1. Introduction & Core Thesis
#### 1.1 Background: Spatial Confounding in Relational Networks
Complex adaptive systems rely on continuous relational interactions to achieve system-wide coordination, efficiency, and structural robustness. Network science provides a formal framework to represent these interactions as directed, weighted graphs $G=(V,E,W)$. However, evaluating raw topological metrics in isolation is methodologically flawed. In spatially embedded systems, a network's topology is heavily dictated by interaction volume, physical boundaries, and Euclidean proximity. When agents operate within bounded metric spaces, high interaction volume and spatial co-location naturally induce short global path lengths and dense clustering. Without domain-aware statistical baselines, researchers routinely conflate passive geometric artefacts with deliberate, policy-driven coordination.

Traditional graph randomisations, such as the Erdős–Rényi $G(N,p)$ model (Erdős & Rényi, 1959; Gilbert, 1959) or degree-preserving rewiring, fail in physical domains because uniform edge generation destroys distance-decay mechanics, flattens operational workload inequality, and generates physically impossible interactions between incompatible agent roles.

To resolve these failures, my preliminary research used association football passing networks ($N = 89,781$ events) as an observable multi-agent testbed, engineering a first-order Spatial Markovian generative engine. While this first-order baseline successfully captured spatial distance decay and proved that macro-efficiency was an artefact of volume, its memoryless and static assumptions highlighted a deeper theoretical gap: real-world collective interactions depend on sequential path history and dynamic system states.
#### 1.2 Core Thesis Statement
The central thesis of this research is that a substantial fraction of the apparent "emergent coordination" observed in spatially embedded multi-agent networks is an unmeasured artefact of spatial density and interaction volume. By formulating higher-order, spatiotemporal Markovian null models—validated first on empirical human interaction streams and ported to synthetic MARL swarms—we can statistically disentangle genuine collaborative policy from geometric noise, using these divergence signals to regularise GNN communication topologies.
#### 1.3 Research Questions
This research is guided by three progressive, domain-agnostic research questions:
- **RQ1 (Higher-Order Relational Memory):** To what extent can temporally conditioned, higher-order random walk generators resolve the topological distortions of memoryless baselines in systems where interaction availability is history-dependent?
- **RQ2 (Auditing Emergent MARL Communication):** To what extent do learned communication topologies in cooperative MARL reflect genuine policy coordination versus passive geometric confounding induced by spatial proximity and interaction volume?
- **RQ3 (Differentiable Topological Regularisation in GNNs):** Can statistical divergence metrics derived from spatiotemporal null distributions act as differentiable inductive biases within GNN message-passing layers to suppress redundant cyclic bandwidth and enforce parsimonious routing?
---
### 3. Literature Review & Theoretical Gaps
The theoretical foundation of this project bridges spatial network science, higher-order temporal dynamics, and multi-agent reinforcement learning (MARL). While existing literature predominantly applies stochastic processes to fixed graphs to analyse diffusion (_dynamics on the network_), this research transposes that analytical paradigm: it leverages continuous spatial transition probabilities and temporal history to generate reference graph topologies (_dynamics of the network_). Doing so addresses three interrelated gaps across network science and artificial intelligence.
#### 3.1 Spatial Network Science
Network science provides a mature mathematical toolkit for analysing community structure, contagion cascades, and small-world efficiency (Wasserman, 1994; Watts & Strogatz, 1998; Newman, 2003; Fortunato, 2010). However, when networks are embedded in physical space, topological structure is heavily confounded by geometric distance decay (Barthélemy, 2011; Expert et al., 2011). Spatial proximity naturally inflates local clustering and compresses path lengths, creating topological features that can easily be mistaken for deliberate functional organisation.
#### 3.2 Higher-Order Markovian Memory
In spatial network analysis, interaction streams are typically aggregated into standard pairwise graphs $G=(V, E, W)$ to evaluate structural properties. While this pairwise projection is effective for downstream diagnostic analysis, assuming memoryless (first-order Markovian) dynamics during null model generation introduces severe structural bias. When a generative baseline treats sequential events as independent pairs, an agent's next action is sampled as conditionally independent of its preceding trajectory. Seminal work in temporal and higher-order network science demonstrates that physical interaction streams contain critical path dependencies and latency constraints that memoryless edge-sampling distorts (Holme & Saramäki, 2012; Scholtes et al., 2014; Lambiotte et al., 2019).

When interactions are sampled without chronological causality, an event $B \to C$ can be stochastically linked to $A \to B$ even if it would occur earlier in a stream or outside a physically plausible response window (Scholtes et al., 2014). Furthermore, static baselines assume stationary transition probabilities across entire observation windows, ignoring dynamic regime shifts that alter state spaces over time.

Resolving this does not require abandoning the standard relational graph, but rather upgrading the generative null process that produces the reference benchmark. By uniting continuous spatial density estimation (Expert et al., 2011) with higher-order, time-respecting random walk generators (Lambiotte et al., 2019) into a unified spatiotemporal null framework, synthetic event streams can be generated where each transition is constrained by preceding $k$-step history and causal availability. Projecting these realistic synthetic streams back into standard pairwise graphs provides calibrated reference distributions, ensuring that observed network properties are benchmarked against physically viable baselines rather than memoryless artefacts.
#### 3.3 Emergent Communication & GNN Message-Passing in MARL
This challenge of distinguishing deliberate coordination from spatial confounding is not unique to empirical collectives; it represents a critical, unresolved bottleneck in artificial Multi-Agent Systems (MAS). In domains such as autonomous drone swarms, robotic logistics, and distributed sensor grids, heterogeneous agents must learn to coordinate over dynamic communication graphs under strict geometric and bandwidth constraints (Bettini et al., 2022).

In cooperative MARL, agents learn latent communication protocols end-to-end alongside spatial movement policies (Sukhbaatar et al., 2016; Foerster et al., 2016; Lowe et al., 2017). Early broadcast architectures like CommNet (Sukhbaatar et al., 2016) rely on uniform message averaging, creating dense, all-to-all "hairball" topologies. To induce selective communication, attentional architectures like TarMAC (Das et al., 2019) and IC3Net (Singh et al., 2019), alongside Graph Neural Network (GNN) frameworks such as DGN (Jiang & Lu, 2018; Jiang et al., 2020), model the swarm as a dynamic graph where message edges are gated via soft-attention weights or spatial proximity thresholds (e.g., metric $k$-nearest neighbours).

Despite these architectural advances, contemporary MARL suffers from a fundamental evaluation gap: emergent communication is assessed almost exclusively via terminal task reward rather than topological auditing. As demonstrated by Lowe et al. (2019) and Nisioti et al. (2021), high task returns frequently mask degenerate or ungrounded communication channels. In practice, agents routinely solve cooperative tasks via independent spatial heuristics while broadcasting uninformative noise across the learned relational graph.

Compounding this diagnostic deficit is an operational bottleneck: because message exchange in simulation is typically costless, unconstrained GNN layers converge on dense, over-communicative topologies (Foerster et al., 2016; Singh et al., 2019). These un-regularised graphs induce information bottlenecks via over-squashing (Alon & Yahav, 2021; Topping et al., 2022) and generate redundant cyclic message loops governed by non-backtracking spectral properties (Krzakala et al., 2013).

Existing mitigation strategies remain blunt: generic graph sparsifiers apply indiscriminate $L_1$ weight penalties or uniform edge dropout (Rong et al., 2020; Zheng et al., 2020), while spatial GNNs enforce rigid metric cutoffs (such as radial basis functions or geometric radius discs). These mechanisms fail in heterogeneous collectives because they cannot distinguish between necessary long-range coordination (such as an aerial relay signalling a distant ground rover) and redundant short-range chatter. Crucially, no existing framework leverages a role-conditioned, spatiotemporal null distribution to separate intentional, policy-driven message passing from baseline geometric proximity.
- [TODO: Review all papers, understand abstract, intro and conclusions/findings]
---
### 4. Preliminary Pilot Study: Proof of Concept
#### 4.1 Bounded Empirical Substrate & Combinatorial Sparsity
In applied complex systems research, spatiotemporal tracking logs of association football serve as an observable, bounded empirical testbed for heterogeneous multi-agent dynamics (Araújo et al., 2006; Duch et al., 2010). Eleven role-constrained agents ($\vert{}V\vert{} = 11$) interact continuously across a bounded 2D Euclidean pitch, where completed passes form directed, weighted relational edges ($G = (V, E, W)$) under the PassMap paradigm (Pollard & Reep, 1997; Buldú et al., 2018, 2019; Peña & Touchette, 2012; Cintia et al., 2015; Arriaza-Ardiles et al., 2018; Alves et al., 2025; Gama et al., 2026a). The empirical foundation of this doctoral proposal was developed during a preliminary master's study evaluating collective dynamics across the 2023/2024 FA Women’s Super League (WSL), using open-source event data from StatsBomb comprising 132 matches, 264 team networks, and 89,781 completed passes.

A central motivation was addressing the combinatorial curse of dimensionality that cripples empirical benchmarking in sports analytics. Real-world match topologies cannot simply be benchmarked against cross-season averages because interaction density, tactical formations, and spatial constraints vary dramatically between games. Discretising the season corpus reveals severe data sparsity: within the modal volume tier of 200–299 passes (accounting for 40.2% of matches), partitioning across recorded formations reduces the primary tactical system (4-2-3-1) to only 29 instances, while high-volume regimes exceeding 700 passes contain a single match across the entire season. To test whether observed network properties reflected deliberate tactical policy or passive spatial co-location, the pipeline was deployed on this extreme volume outlier, wherein Arsenal WFC completed 720 passes against Bristol City. Traditional random graph baselines failed completely within this spatially embedded regime: an Erdős–Rényi $G(N, p)$ model (Erdős & Rényi, 1959; Gilbert, 1959) destroyed physical pitch geometry, collapsed operational workload variance ($\text{Var}(s_{\text{tot}})$ fell from 5,681.90 to 514.99), and synthesized tactically impossible interactions, such as establishing the goalkeeper and central striker as primary passing partners ($W_{\min} = 51.0$).
##### 4.2 Multi-Scale Diagnostic Suite
Observed team topologies were audited across three structural scales to translate graph-theoretic properties into functional multi-agent coordination principles (Alves et al., 2025; Gama et al., 2026a). At the macro scale, global integration and workload skew were evaluated using the Average Shortest Path length ($d$) calculated via Dijkstra's algorithm over inverted edge weights ($l_{ij} = 1/w_{ij}$), which represent topological resistance, alongside Team Node Volume Variance ($\text{Var}(s_{\text{tot}})$) and degree heterogeneity ($CV_k$). At the meso scale, combinational passing channels were quantified through directed Transitive Triad Intensity ($I_{\text{transitive}}$), which isolates progressive multi-agent combinations ($A \to B \to C$ supported by $A \to C$) constrained by their weakest link capacity ($W_{\min} = \min(w_{AB}, w_{BC}, w_{AC})$), explicitly separating progressive routing from non-productive cyclic oscillations ($A \to B \to C \to A$) (Peña & Navarro, 2015). At the micro scale, tactical mediation and phase-transition distribution hubs were identified via Weighted Betweenness Centrality ($g(i)$).
##### 4.3 Repurposing Markovian Flow for Generative Spatial Nulls
While existing sports network literature predominantly applies Markov chains to static empirical adjacency matrices to model possession diffusion _on_ a fixed graph (Narizuka et al., 2014; Gama et al., 2026b), this research inverted that paradigm by using learned spatial transition rules to govern the generative dynamics _of_ the network itself. Standard pitch coordinates ($120 \times 80$ yards) were normalized to a $100 \times 100$ scale and discretised into a $10 \times 10$ uniform grid, while player roles were condensed into a 9-class positional taxonomy ($N_{\text{pos}} = 9$) to eliminate lateral bias and maximise sampling density per cell. A 3D Spatial Probability Tensor $\mathcal{P}(r, c, p)$ was parameterised across the season corpus using Laplace additive smoothing ($\alpha = 1.0$) to estimate conditional recipient likelihoods $P(\text{Role } p \mid \text{Grid Bin } (r, c))$. Synthetic null event streams were generated by holding empirical passer identities, origin coordinates, and destination cells fixed, while resampling recipients from $P(p \mid r, c)$ under a strict self-pass restriction.

Benchmarking the outlier match against an $N = 1,000$ Monte Carlo spatial null ensemble yielded three foundational empirical results. First, holding passer initiative fixed recovered 55% of empirical workload variance ($\text{Var}(s_{\text{tot}}) = 3,117.38$ versus an empirical 5,681.90), establishing that sender initiative accounts for roughly half of possession centralisation, while receiver selection drives the remaining 45%. Second, the empirical global shortest path length ($d = 0.1884$) fell comfortably within the spatial null’s 95% confidence interval ($\bar{d}_{\text{null}} = 0.1932$, $\text{CI}_{95\%}: [0.1732, 0.2120]$, $z = -0.43$), demonstrating that rapid ball circulation was an inevitable mathematical by-product of executing over 700 actions in bounded space rather than an indicator of elite tactical design. Third, meso- and micro-scale benchmarking successfully separated deliberate policy from passive spatial density: progressive build-up triads ($z = +3.83$), left-flank overload combinations ($z = +5.67$), central defensive distribution pivots ($z = +2.73$ and $+2.85$), and dropping striker linkage ($z \in [+1.84, +2.78]$) significantly exceeded null bounds. Conversely, high-volume central recycling loops ($W_{\min} = 69.0$, $z = -0.28$) matched null expectations ($\bar{W} = 71.53$) exactly, proving that raw central passing volume was an uninformative artefact of localized spatial player density

_(Figure 1: Erdős–Rényi baseline vs. Empirical PassMap vs. Generative Spatial Null expectation across Macro, Meso, and Micro dimensions.)_

##### 4.4 Methodological Bottlenecks Defining the PhD Scope
While the pilot demonstrated that spatial null models can isolate deliberate coordination from geometric noise, its reliance on a first-order, statically aggregated framework exposed three theoretical bottlenecks that delineate the boundaries of the preliminary study and establish the operational objectives of this doctoral research.

**The Memoryless Bottleneck ($k=1$).** Treating interactions as conditionally independent pairwise transitions ($P(X_{t+1} \mid X_t)$) ignores causal path history and physical momentum (Holme & Saramäki, 2012; Scholtes et al., 2014; Lambiotte et al., 2019). When an interaction sequence is resampled without trajectory memory, downstream edges are sampled independently of preceding build-up vectors. In physical multi-agent collectives, an agent's reception and subsequent transmission are constrained by prior orientation and velocity. Enforcing memoryless generation flattens multi-hop combinational motifs ($A \to B \to C$) and permits synthetic sequences that violate chronological causality.

**Stationary Temporal Aggregation and Spatial Discretisation.** Aggregating interaction logs across an entire match window assumes stationary transition dynamics, ignoring tactically driven regime shifts, scoreline contingencies, and agent substitutions. Furthermore, discretising the continuous pitch into a fixed $10 \times 10$ grid introduces artificial boundary discontinuities between adjacent cells. The structural consequence of these combined assumptions was evident in the striker pass-share anomaly: because deep offensive grid cells carry high season-average forward occupancy, the stationary null model artificially inflated an isolated striker's expected reception share from an empirical 1.53% to 13.33%.

**Coupling to Empirical Origins and Observational Logs.** By design, the pilot conditioned recipient selection on empirical passer identities, timestamps, and origin coordinates. While this conservative formulation was essential for partitioning passer initiative from receiver choice in a retrospective case study, it restricts the generative engine to _resampling_ observed data streams rather than _generating_ autonomous multi-agent trajectories. The framework could audit human collective behaviour retrospectively, but it could not be applied interactively to synthetic multi-agent systems where agents dynamically discover communication policies during execution.

Crucially, addressing these bottlenecks does not require discarding standard relational graphs. While the generative engine must operate in a higher-order, time-respecting, and continuous regime ($k \ge 2$) to preserve physical causality during stream synthesis, the resulting reference ensembles can be projected directly back into standard directed graphs ($G = (V, E, W)$). This preserves topological comparability with observed communication graphs while ensuring that the baseline distributions represent physically viable dynamics rather than memoryless artefacts.

---
### 5. Proposed Methodology & Work Packages
The research is structured across three progressive Work Packages (WPs) over a four-year timeline, scaffolding my existing expertise in empirical spatial network science (`pandas`, `networkx`, `scipy`) into MARL simulation and geometric deep learning (`PyTorch Geometric`)
#### Work Package 1: Continuous, Higher-Order, Non-Stationary Spatial Nulls (Year 1)
**Methodological Execution.** WP1 resolves the discretisation and memoryless bottlenecks identified in the pilot. Using tracking corpora as an empirical testbed, the discrete $10 \times 10$ spatial grid is replaced with continuous 2D Kernel Density Estimation (KDE) over the metric domain to eliminate artificial cell-boundary thresholds. To account for path dependency, the transition kernel is expanded to incorporate variable-order Markovian memory ($k \ge 2$), formalised as $P(X_{t+1} \mid X_t, \dots, X_{t-k+1}, \Delta t)$ (Lambiotte et al., 2019). This transition kernel conditions recipient and spatial destination selection on the causal history of the previous $k$ relational actions within a time-lagged window $\Delta t$. To resolve the distortion caused by stationary aggregation, temporal sliding windows and regime-switching Hidden Markov Models (HMMs) are integrated into the pipeline, dynamically adjusting transition probabilities based on active agent availability, operational phase, and emergent environmental state.

**Validation & Evaluation Plan.** Synthetic interaction streams produced by the higher-order engine will be evaluated against empirical hold-out matches. Validation metrics include Kullback–Leibler (KL) divergence across resulting degree distributions, weighted adjacency matrix correlations ($\bar{r}$), and motif recovery rates. Specifically, this phase tests what proportion of empirical meso-scale transitive intensity ($I_{\text{transitive}}$) is attributable to true high-level tactical coordination once continuous spatial density and $k$-step trajectory history are controlled.
#### Work Package 2: Cross-Domain Diagnostic Auditing of Synthetic MARL Swarms (Year 2)
**Methodological Execution.** WP2 ports the validated continuous, higher-order null framework from human trajectory data to continuous 2D and 3D synthetic multi-agent systems. Using vectorized simulators—specifically VMAS (Bettini et al., 2022) and PettingZoo—heterogeneous, role-constrained swarms (such as scout-communicator-forager tasks) will be trained under cooperative objectives. Standard communication architectures will serve as benchmarks, spanning mean-field broadcasting (CommNet; Sukhbaatar et al., 2016), targeted soft-attention routing (TarMAC; Das et al., 2019), and graph convolutional communication (DGN; Jiang et al., 2020).

**Evaluation Plan.** Emergent communication streams generated during policy execution will be converted into dynamic interaction graphs and benchmarked against an $N = 1,000$ Monte Carlo spatiotemporal null ensemble. By computing standardized divergence scores,

$$z = \frac{M_{\text{learned}} - \mu_{\text{null}}}{\sigma_{\text{null}}}$$

for graph metrics across macro ($d, \text{Var}(s_{\text{tot}})$), meso ($I_{\text{transitive}}$), and micro ($g(i)$) scales, learned communication channels can be audited. This audit establishes whether learned message routing represents genuine, policy-grounded multi-agent coordination ($\vert{}z\vert{} \ge 1.96$) or redundant bandwidth expenditure driven by physical co-location and spatial proximity ($\vert{}z\vert{} < 1.96$).
#### Work Package 3: Differentiable Null-Regularisation in GNN Layers (Year 3)
**Analytical Formulation & Differentiability.** While Monte Carlo graph resampling provides exact reference distributions for post-hoc diagnostic auditing (WP2), discrete sampling operations cannot be integrated into backpropagation during neural network training. WP3 derives a closed-form, differentiable surrogate of the spatial null expectation. Given a Graph Neural Network’s continuous communication adjacency matrix $\mathbf{A} \in [0, 1]^{N \times N}$ and the continuous spatial null transition kernel $\mathbf{P}^{\text{null}} \in [0, 1]^{N \times N}$, the expected transitive motif intensity can be computed analytically via matrix trace formulations:

$$\mathbb{E}[I_{\text{transitive}}] \propto \text{Tr}\left(\mathbf{A}^2 \mathbf{A}^T\right) = \mathbf{1}^T \left(\mathbf{A} \odot \mathbf{A}^2\right) \mathbf{1}$$

where $\odot$ denotes the element-wise Hadamard product. Here, $(\mathbf{A}^2)_{ik} = \sum_j A_{ij} A_{jk}$ quantifies the capacity of 2-hop directed walks ($i \to j \to k$), while multiplying element-wise by $A_{ik}$ verifies the existence of the closing progressive chord ($i \to k$). In regimes requiring discrete edge sampling, the Gumbel-Softmax (Concrete) relaxation (Jang et al., 2017; Maddison et al., 2017) is applied over $\mathbf{P}^{\text{null}}$ to maintain continuous gradient flow.

**Auxiliary Loss Formulation.** The closed-form divergence between the GNN’s latent adjacency matrix and the spatial null expectation is formulated as an auxiliary loss term:

$$\mathcal{L}_{\text{topo}} = \left\Vert{} \mathbb{E}_{\text{GNN}}[I_{\text{motif}}] - \mathbb{E}_{\text{null}}[I_{\text{motif}}] \right\Vert{}_2^2$$

This loss penalises message passing when it merely mirrors passive spatial proximity or default role density ($\vert{}z\vert{} < 1.96$), or when it forms non-backtracking cyclic loops ($A \to B \to C \to A$) that consume communication channel bandwidth without aiding task performance (Krzakala et al., 2013). Conversely, it encourages sparse, progressive feed-forward combinations ($A \to B \to C$ with $A \to C$).

**Evaluation and Ablation Plan.** Implemented in PyTorch Geometric, the proposed framework will be benchmarked against unconstrained GNN communication baselines, $L_1$-regularised sparse graphs (Rong et al., 2020), and heuristic distance-thresholded topologies across three criteria:
1. _Episodic Task Reward:_ Final task performance in complex multi-agent cooperative tasks.
2. _Bandwidth Efficiency:_ Reduction in edge density and suppression of redundant cyclic message traffic.
3. _System Robustness:_ Zero-shot resilience to agent dropout and communication channel disruption, evaluating whether the induced topology maintains resilient routing backbones without reliance on over-squashed, all-to-all communication channels (Alon & Yahav, 2021; Topping et al., 2022).
####  Summary Timeline
- **Year 1:** Complete cohort training in MARL/GNNs; engineer continuous KDE and higher-order temporal spatial null models on empirical tracking data (WP1).
- **Year 2:** Port spatial tensor and multi-scale diagnostic suite to synthetic MARL swarms (_VMAS_/_PettingZoo_); publish comparative audit of empirical vs. synthetic collective topology (WP2).
- **Year 3:** Formulate differentiable spatial null regularisers ($\mathcal{L}_{\text{topo}}$) in GNN communication layers; benchmark bandwidth efficiency and swarm robustness (WP3).
- **Year 4:** Synthesise cross-domain findings and complete doctoral dissertation.
---
### 6. Ethical Considerations & Resource Feasibility
1. **Public-Figure PII, Licensing, and Domain Equity (WP1):** The empirical validation phase utilises the open-access StatsBomb corpus for the 2023/2024 FA Women's Super League. All data is derived from publicly broadcast events under the StatsBomb User Agreement, carrying zero risk of disclosing private or medical information. Centring baseline validation on women's sport directly addresses the systemic underrepresentation of women's datasets in quantitative complex systems literature (Alves et al., 2025; Gama et al., 2026b), and all released tensors will adhere to FAIR data principles.
2. **Dual-Use Mitigation (WP2 & WP3):** Research into decentralised swarm coordination carries potential dual-use defense implications. To ensure responsible innovation, all synthetic MARL evaluations will be strictly confined to cooperative civilian benchmarks (decentralized search-and-rescue, environmental monitoring, and warehouse logistics).
3. **Computational Budget & Carbon Footprint:** Because $N=1,000$ Monte Carlo resampling is computationally expensive during neural training, formulating the closed-form analytical matrix surrogate in WP3 eliminates inner-loop sampling overhead, drastically reducing GPU training hours and carbon footprint.
---
### 7. Consolidated Bibliography
- Alon, U., & Yahav, E. (2021). On the bottleneck of graph neural networks and its practical implications. _International Conference on Learning Representations (ICLR)_.
    
- Alves, R., Dias, G., Nunes, N. A., Querido, S. M., & Vaz, V. (2025). Social network analysis in football: a systematic review of performance and tactical applications. _Frontiers in Psychology_, 16, 1659603.
    
- Araújo, D., Davids, K., & Hristovski, R. (2006). The ecological dynamics of decision making in sport. _Psychology of Sport and Exercise_, 7(6), 653–676.
    
- Arriaza-Ardiles, E., Martín-González, J., Zuniga, M., Sánchez-Flores, J., De Saa, Y., & García-Manso, J. M. (2018). Applying graphs and complex networks to football metric interpretation. _Human Movement Science_, 57, 236–243.
    
- Barthélemy, M. (2011). Spatial networks. _Physics Reports_, 499(1–3), 1–101.
    
- Battiston, F., Cencetti, G., Iacopini, I., Latora, V., Lucas, M., Patania, A., et al. (2020). Networks beyond pairwise interactions: Structure and dynamics. _Physics Reports_, 874, 1–92.
    
- Benson, A. R., Gleich, D. F., & Leskovec, J. (2016). Higher-order organization of complex networks. _Science_, 353(6295), 163–166.
    
- Bettini, M., Kortvelesy, R., Blumenkamp, J., & Prorok, A. (2022). VMAS: A Vectorized Multi-Agent Simulator for Collective Robot Learning. _Distributed Autonomous Robotic Systems (DARS)_.
    
- Buldú, J. M., Busquets, J., Martínez, J. H., Herrera-Diestra, J. L., Echegoyen, I., Galeano, J., et al. (2018). Using network science to analyse football passing networks: Dynamics, space, time, and the multilayer nature of the game. _Frontiers in Psychology_, 9, 1900.
    
- Buldú, J. M., Busquets, J., Echegoyen, I., & Seirul·lo, F. (2019). Defining a historic football team: Using Network Science to analyze Guardiola's FC Barcelona. _Scientific Reports_, 9(1), 13602.
    
- Das, A., Gervet, T., Romoff, J., Batra, D., Parikh, D., Rabbat, M., & Pineau, J. (2019). TarMAC: Targeted multi-agent communication. _International Conference on Machine Learning (ICML)_.
    
- Duch, J., Waitzman, J. S., & Amaral, L. A. N. (2010). Quantifying the performance of individual players in a team activity. _PLoS ONE_, 5(6), e10937.
    
- Erdős, P., & Rényi, A. (1959). On Random Graphs I. _Publicationes Mathematicae Debrecen_, 6, 290–297.
    
- Expert, P., Evans, T. S., Blondel, V. D., & Lambiotte, R. (2011). Uncovering space-independent communities in spatial networks. _Proceedings of the National Academy of Sciences (PNAS)_, 108(19), 7663–7668.
    
- Foerster, J., Assael, I. A., de Freitas, N., & Whiteson, S. (2016). Learning to communicate with deep multi-agent reinforcement learning (DIAL). _Advances in Neural Information Processing Systems (NeurIPS)_.
    
- Fortunato, S. (2010). Community detection in graphs. _Physics Reports_, 486(3–5), 75–174.
    
- Gama, J., Dias, G., Pereira, M., Mendes, R., Mendes, R. S., Sarmento, H., et al. (2026a). Network analysis to understand variability and patterns of individual and collective behaviour in professional football: A systematic review. _International Journal of Performance Analysis in Sport_, 1–62.
    
- Gama, J., Dias, G., Couceiro, M. S., Mendes, R., Mendes, R. S., & Vaz, V. (2026b). Linking network structures and stochastic flow properties: An exploratory Markov-spectral case study in professional football. _Proc. IMechE, Part P: Journal of Sports Engineering and Technology_.
    
- Gilbert, E. N. (1959). Random Graphs. _The Annals of Mathematical Statistics_, 30(4), 1141–1144.
    
- Holme, P., & Saramäki, J. (2012). Temporal networks. _Physics Reports_, 519(3), 97–125.
    
- Jang, E., Gu, S., & Poole, B. (2017). Categorical reparameterization with Gumbel-Softmax. _International Conference on Learning Representations (ICLR)_.
    
- Jiang, J., Dun, C., Huang, T., & Lu, Z. (2020). Graph convolutional reinforcement learning (DGN). _International Conference on Learning Representations (ICLR)_.
    
- Krzakala, F., Moore, C., Mossel, E., Neeman, J., Sly, A., Zdeborová, L., & Zhang, P. (2013). Spectral redemption in clustering sparse networks. _PNAS_, 110(52), 20935–20940.
    
- Lambiotte, R., Rosvall, M., & Scholtes, I. (2019). From networks to optimal higher-order models of complex systems. _Nature Physics_, 15(4), 313–320.
    
- Lowe, R., Wu, Y., Tamar, A., Harb, J., Abbeel, P., & Mordatch, I. (2017). Multi-agent actor-critic for mixed cooperative-competitive environments (MADDPG). _Advances in Neural Information Processing Systems (NeurIPS)_.
    
- Lowe, R., Foerster, J., Boureau, Y. L., Pineau, J., & Dauphin, Y. (2019). On the pitfalls of measuring emergent communication. _International Conference on Autonomous Agents and MultiAgent Systems (AAMAS)_.
    
- Maddison, C. J., Mnih, A., & Teh, Y. W. (2017). The Concrete distribution: A continuous relaxation of discrete random variables. _International Conference on Learning Representations (ICLR)_.
    
- Narizuka, T., Yamamoto, K., & Yamazaki, Y. (2014). Statistical properties of position-dependent ball-passing networks in football games. _Physica A_, 412, 157–168.
    
- Newman, M. E. (2003). The structure and function of complex networks. _SIAM Review_, 45(2), 167–256.
    
- Nisioti, E., Mahaut, M., Oudeyer, P. Y., & Moulin-Frier, C. (2021). Grounding emergent communication in multi-agent reinforcement learning. _arXiv preprint_.
    
- Peña, J. L., & Navarro, R. S. (2015). Who can replace Xavi? A passing motif analysis of football players. _arXiv preprint arXiv:1506.07768_.
    
- Rong, Y., Huang, W., Xu, T., & Huang, J. (2020). DropEdge: Towards deep graph convolutional networks on node classification. _International Conference on Learning Representations (ICLR)_.
    
- Scholtes, I., Wider, N., Pfitzner, R., Garas, A., Tessone, C. J., & Schweitzer, F. (2014). Causality-driven slow-down and speed-up of diffusion in non-Markovian temporal networks. _Nature Communications_, 5(1), 5024.
    
- Singer, P., Helic, D., Taraghi, B., & Strohmaier, M. (2014). Detecting memory and structure in human navigation patterns using Markov chain models of varying order. _PLoS ONE_, 9(7), e102070.
    
- Singh, A., Jain, T., & Sukhbaatar, S. (2019). Learning when to communicate at scale in multiagent cooperative and competitive tasks (IC3Net). _ICLR_.
    
- Sukhbaatar, S., Szlam, A., & Fergus, R. (2016). Learning multiagent communication with backpropagation (CommNet). _Advances in Neural Information Processing Systems (NeurIPS)_.
    
- Topping, J., Di Giovanni, F., Chamberlain, B. P., Dong, X., & Bronstein, M. M. (2022). Understanding over-squashing and bottlenecks on graphs via curvature. _International Conference on Learning Representations (ICLR)_.
    
- Watts, D. J., & Strogatz, S. H. (1998). Collective dynamics of 'small-world' networks. _Nature_, 393(6684), 440–442.
    
- Zheng, C., Zong, B., Cheng, W., Song, D., Ni, J., Yu, W., et al. (2020). Robust graph representation learning via neural sparsification. _International Conference on Machine Learning (ICML)_.