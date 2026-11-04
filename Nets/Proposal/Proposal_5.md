- *Separating Emergent Coordination from Geometric Noise: Higher-Order Spatial Markovian Null Models from Empirical Collectives to Synthetic Swarms*
- *Separating Emergent Coordination from Geometric Noise: Spatiotemporal Null Models for Auditing Swarms and Regularising Graph Neural Networks*
- Separating Emergent Coordination from Spatiotemporal Noise: Continuous Higher-Order Null Models for Auditing Swarms and Regularising Graph Neural Networks
---
#### _Abstract_
Whether evaluating human sports teams, biological collectives, or autonomous robotic swarms, decentralised multi-agent systems rely on localised, dynamic interactions to drive emergent collective behaviour. Determining whether observed interaction topologies reflect deliberate, policy-driven coordination rather than passive spatial proximity, kinematic latency, and interaction volume artefacts requires rigorous statistical benchmarking. Traditional random graph baselines (such as Erdős–Rényi $G(N,p)$ or static degree-preserving rewiring) fail in physical domains because uniform edge generation destroys physical geometry, obliterates causal time-ordering, and generates physically implausible cross-role interactions. To address this, preliminary research used association football passing networks as an empirical benchmark, engineering domain-aware spatial Markovian null models to isolate deliberate tactical motifs from baseline geometric noise.

This proposal generalises that methodological foundation across the domain boundary to synthetic multi-agent systems and Graph Neural Networks (GNNs) across three progressive phases:
1. It resolves the theoretical bottlenecks of static, memoryless baselines by formulating **continuous, higher-order ($k$-step), non-stationary spatiotemporal Markovian null models** that explicitly respect kinematic reachability envelopes and chronological event-ordering.
2. It ports this framework to cooperative Multi-Agent Reinforcement Learning (MARL) benchmarks to audit whether learned emergent communication topologies represent genuine, task-grounded coordination or temporal co-occurrence and spatial co-location artefacts.
3. It operationalises the spatiotemporal null expectation as a **differentiable inductive bias inside GNN message-passing layers**, regularising learned edge weights against trivial spatiotemporal proximity to suppress causally redundant cyclic echoes ($i \to j \to i$) and mitigate over-squashing.

---
### 1. Introduction & Core Thesis
#### 1.1 Background: Spatial Confounding in Relational Networks
Complex adaptive systems rely on continuous relational interactions to achieve system-wide coordination, efficiency, and structural robustness. Network science provides a formal framework to represent these interactions as directed, weighted graphs $G=(V,E,W)$. However, evaluating raw topological metrics in isolation is methodologically flawed. In spatially embedded systems, a network's topology is heavily dictated by interaction volume, physical boundaries, and Euclidean proximity. When agents operate within bounded metric spaces, high interaction volume and spatial co-location naturally induce short global path lengths and dense clustering. Without domain-aware statistical baselines, researchers routinely conflate passive geometric artefacts with deliberate, policy-driven coordination.

Traditional graph randomisations, such as the Erdős–Rényi $G(N,p)$ model (Erdős & Rényi, 1959; Gilbert, 1959) or degree-preserving rewiring, fail in physical domains because uniform edge generation destroys distance-decay mechanics, flattens operational workload inequality, and generates physically impossible interactions between incompatible agent roles.

To resolve these failures, my preliminary research used association football passing networks as an observable multi-agent testbed, engineering a first-order Spatial Markovian generative engine. While this first-order baseline successfully captured spatial distance decay and proved that a given measure of macro-efficiency was an artefact of volume, its memoryless and static assumptions highlighted a deeper theoretical gap: real-world collective interactions depend on sequential path history and dynamic system states$^1.
#### 1.2 Core Thesis Statement
The basis for this research is the claim$^1$ that a substantial fraction of the apparent "emergent coordination" observed in spatially embedded multi-agent networks is an unmeasured artefact of spatial density and interaction volume. By formulating higher-order, spatiotemporal Markovian null models we can statistically disentangle genuine collaborative policy from geometric noise, using these divergence signals to regularise GNN communication topologies.
#### 1.3 Research Questions
This research is guided by three progressive, domain-agnostic research questions:
- **RQ1 (Higher-Order Causal & Spatiotemporal Memory):** To what extent can continuous, higher-order ($k$-step), non-stationary spatiotemporal null models eliminate structural topological distortions in dynamic interaction networks by jointly conditioning on kinematic travel horizons, non-Poissonian burstiness, and chronologically ordered causal paths?
- **RQ2 (Auditing Emergent MARL Communication):** To what extent do emergent communication topologies in cooperative MARL reflect genuine policy-driven coordination versus passive spatiotemporal confounding induced by Euclidean proximity, volume artefacts, and temporal co-occurrence?
- **RQ3 (Differentiable Spatiotemporal De-biasing in GNNs):** How can an analytical, continuous spatiotemporal null expectation be integrated as a differentiable inductive bias within dynamic GNN message-passing layers to filter out trivial geometric proximity and suppress causally redundant, non-backtracking cyclic echoes without degrading cooperative task performance?
---
### 3. Literature Review & Theoretical Gaps
Developing valid baselines for collective multi-agent coordination requires bridging spatial network science, higher-order stochastic processes, and deep multi-agent reinforcement learning. While network science provides the diagnostic apparatus to analyse relational topologies, standard null methodologies fail when applied to physical and synthetic collectives: spatial embedding mechanically distorts graph structure, memoryless assumptions break chronological causality, and emergent communication frameworks in MARL de-prioritise heterogeneous topological auditing$^{**}$. This review outlines how these three theoretical frontiers converge, contextualising the methodological gaps this research resolves.

$^{**}$ probably need to back this last point up or rephrase it. 
#### 3.1 Spatial Network Science
While network science provides rigorous tools for analysing community structure and transmission dynamics (Watts & Strogatz, 1998; Newman, 2003; Fortunato, 2010), spatial embedding heavily confounds topology via distance decay (Barthélemy, 2011; Expert et al., 2011). In physical space, geographic proximity mechanically inflates local clustering and compresses path lengths, producing structural properties that can easily be mistaken for deliberate functional organisation$^{***}$.

$^{***}$ presented as logical point but this is the review section so should back this up
> "Because spatial embedding enforces strong distance-decay constraints, geometric proximity mechanically induces triangle formation, high local clustering, and modularity (Barthélemy, 2011; Expert et al., 2011). When dynamic interactions are projected onto static graphs without accounting for space-time interaction volumes, topological metrics systematically misattribute structural efficiency to deliberate functional organisation rather than geometric compactness (Sarnecki et al., 2016; Buldú et al., 2018).
#### 3.2 Higher-Order Markovian Memory
In spatial interaction streams, interactions are typically aggregated into standard pairwise graphs $G=(V, E, W)$. While effective for downstream diagnostics, assuming memoryless (first-order Markovian) dynamics during null model generation introduces severe structural bias. Treating sequential events as independent pairs assumes an agent's next action is conditionally independent of its trajectory, ignoring vital path dependencies and physical latency constraints (Holme & Saramäki, 2012; Scholtes et al., 2014; Lambiotte et al., 2019). When sampled without chronological conditioning, generative baselines synthesise causally impossible or unlikely transitions, producing systematically miscalibrated baseline networks.

> "In temporal interaction streams, temporal aggregation flattens chronologically ordered interactions into static weighted graphs, creating 'phantom paths' that violate physical time-ordering (Holme & Saramäki, 2012; Scholtes et al., 2014). If event $A \to B$ occurs at $t_1$ and $B \to C$ occurs at $t_0 < t_1$, static projection registers a 2-hop path $A \to B \to C$ that is physically impossible under the arrow of time. Furthermore, non-Poissonian inter-event burstiness (Karsai et al., 2011; Lambiotte et al., 2019) dictates that interaction availability is non-stationary and history-dependent."
#### 3.3 Emergent Communication and Grounding in Cooperative MARL
This geometric confounding directly mirrors a critical bottleneck in artificial Multi-Agent Systems, such as autonomous drone swarms and robotic logistics (Bettini et al., 2022). In cooperative MARL, agents learn latent communication channels alongside movement policies to coordinate decentralised behaviour (Sukhbaatar et al., 2016; Das et al., 2019). Crucially, emergent communication is evaluated almost exclusively via terminal task return rather than topological or causal message auditing (Lowe et al., 2019; Nisioti et al., 2021). As demonstrated by Lowe et al. (2019) and Eccles et al. (2019), agents frequently achieve high cooperative returns while exchanging messages that have near-zero causal influence on receiver actions—relying instead on independent spatial heuristics while broadcasting uninformative chatter. Without rigorous spatiotemporal reference baselines, standard metrics cannot distinguish whether high mutual information or dense message routing reflects genuine semantic coordination or passive spatiotemporal co-location.
#### 3.4 Over-Squashing and Inductive Bias Bottlenecks in GNN Message Passing
When communication graphs are parameterised using Graph Neural Networks (GNNs) (Jiang et al., 2020), this diagnostic failure manifests as severe architectural inefficiency. Because simulated message exchange carries no physical bandwidth cost, unconstrained GNN layers converge on dense topologies that trigger information over-squashing into fixed-size latent vectors (Alon & Yahav, 2021; Topping et al., 2022). Furthermore, dense message passing generates redundant cyclic echoes ($i \to j \to i$), violating non-backtracking flow efficiency and wasting computational capacity (Krzakala et al., 2013). Existing graph sparsification methods remain inadequate: generic $\ell_1$ penalties and edge dropout (Rong et al., 2020) prune connections without spatial context, while geometric GNNs apply rigid Euclidean distance cutoffs that sever vital long-range coordination relays. Crucially, no existing deep learning framework incorporates a continuous, spatiotemporal null expectation as a differentiable inductive bias to regularise message passing against baseline geometric proximity $^{*****}$.

$^{*****}$ Probably true for a statement this granular but conceptually things similar: Newman–Girvan/Chung–Lu configuration model, Physics-Informed GNNs

> While modularity-maximising GNN architectures subtract static, topological null expectations (e.g., Newman-Girvan configuration baselines) to isolate communities (Tsitsulin et al., 2023), and Physics-Informed GNNs enforce differential equations as soft boundary constraints (Raissi et al., 2019; Cranmer et al., 2020), neither paradigm addresses continuous spatiotemporal interaction streams. Modularity models remain discrete and static, while PINNs seek to constrain outputs to conform to deterministic physical laws rather than de-biasing internal message passing against stochastic, geometry-induced baseline routing."

> The Core GNN Modularity Paper: 
> **(Tsitsulin et al., 2023) _"Graph Clustering with Graph Neural Networks"_ (Journal of Machine Learning Research/ICML workshops)**
> This is the definitive modern paper showing how to turn the modularity matrix $B = A - P$ into an unsupervised GNN objective function, comparing it directly to Spectral Clustering and MinCut pooling.

> Differentiable Modularity Foundations: 
> **Choong et al. (2018 / 2020): _"Variational Autoencoders for Modularity-Based Community Detection"_ or _"Learning Community Structures with Modularity-Regularized Graph Embeddings"_**
> Early proofs of combining backpropagation with the Newman-Girvan null baseline matrix.

> Spatial Extensions of Modularity (The Classical Network Science Side):
> **Expert, Evans, Blondel, & Lambiotte (2011): "Uncovering space-independent community architecture in networks" (PNAS).**
> This is a landmark network science paper. They showed that standard Newman-Girvan modularity fails in spatial networks because it groups nodes together simply because they are geographically close. They formulated a **spatial null model** $P_{ij} = f(d_{ij}) k_i k_j$ to subtract geographic proximity. _(This paper is conceptually the direct non-deep-learning ancestor of your PhD)._

> **Author Note / Theoretical Clarification on Inductive Bias:**
A vital distinction must be maintained between _loss-level regularisation_ and an _internal architectural inductive bias_. While existing works in graph representation learning (e.g., differentiable modularity maximization; Choong et al., 2020; Tsitsulin et al., 2023) introduce static topological configuration models (Newman–Girvan $A - P$) as auxiliary penalty terms at the output layer, they do not intervene in the intermediate propagation mechanics. In contrast, embedding a spatiotemporal null model as an internal inductive bias means directly parameterising the message-passing transmission kernel itself (e.g., modulating attention logits or edge weights via $\alpha_{ij}(t) - \mathbb{E}_{\text{null}}[A_{ij}(t)]$). Rather than relying on a soft loss term to penalise undesirable representations post-hoc, this operation acts as an internal high-pass filter during the forward pass—structurally suppressing messages attributable to baseline kinematic diffusion and Euclidean co-location before redundant geometric noise can trigger over-squashing.

---
### 4. Preliminary Pilot Study: Proof of Concept
> **Notes/Plan:**
> - Introduce project in concise and clear way
> - demonstrate that football represents a valuable sandbox substrate to experiment on and develop frameworks
> - minimum requirements for this section are just to provide context to the limitations as these form the research questions
> - 4.1 almost entirely re-explains the points covered in the intro and lit review so maybe this entire 4.1 section isn't needed. although work package one is almost directly referencing the project.  

Spatiotemporal tracking logs of association football offer an observable, bounded empirical testbed for heterogeneous multi-agent systems (Araújo et al., 2006; Duch et al., 2010). Eleven role-constrained agents ($\vert{}V\vert{} = 11$) interact on a bounded pitch, where completed passes generate directed, weighted relational networks ($G = (V, E, W)$) under the PassMap paradigm (Buldú et al., 2018). 

![Image 1 description|215](Files/passes.png) ![Image 2 description|216](Files/passmap.png)![Image 2 description|236](Files/trad_null_triad.png)
_Figure 1: Demonstrating how a matches worth of passes are converted into a weighted, directed network_
_Figure 2: Demonstrating the absurd Transitive Triad Intensity ($I_{\text{transitive}}$) create by traditional null network establish a top-3 volume triad between the goalkeeper, striker and right midfield all operating in different sections of the pitch._
##### 4.1 Methodological Bottlenecks Defining the PhD Start Point
The pilot established that conditioning edge probabilities on 2D coordinates resolves the gross geographic distortions of Erdős–Rényi baselines. However, it revealed three critical limitations that define the thesis scope: (i) **Memorylessness ($k=1$):** it evaluates passes in isolation, ignoring multi-step causal chains; (ii) **Temporal Staticity:** it aggregates passes across match duration, ignoring temporal burstiness and phase shifts; and (iii) **Kinematic Agnosticism:** it ignores the continuous velocity and latency constraints of moving agents.

---
### 5. Proposed Methodology & Work Packages
The proposed research is structured across three sequential Work Packages designed to progressively transition from empirical collective tracking to synthetic multi-agent systems and deep learning architectures.

---
#### Work Package 1: Continuous, Higher-Order, Non-Stationary Spatiotemporal Nulls (Year 1)
Directly addressing RQ1, this package resolves the memoryless ($k=1$), static, and purely spatial limitations identified in the pilot study. WP1 generalises the spatial transition engine into a unified, continuous **spatiotemporal** generative process.
1. **Kinematic & Continuous Reachability:** To eliminate discrete pitch/grid-cell boundaries, spatial recipient selection is modelled via continuous 2D spatial density distributions conditioned on velocity-based reachable horizons ($r \le v_{\text{max}} \cdot \Delta t$), ensuring interactions satisfy physical travel-time constraints.
2. **Causal Time-Ordering & Higher-Order Memory:** To eliminate causal anomalies and memoryless bias, the transition kernel is expanded from $k=1$ to variable higher-order walks ($k \ge 2$). Recipient probabilities are conditioned on the temporal sequence and directional momentum of preceding actions, preventing chronologically reversed "phantom paths" and respecting time-respecting reachability.
3. **Non-Stationary Temporal Dynamics:** To account for time-varying environmental urgency and non-Poissonian interaction burstiness, the baseline incorporates dynamic regime-switching (e.g., scoreline urgency, possession turnover latency, and tactical phase shifts), avoiding static full-match temporal averaging.
_Deliverables:_ An open-source Python framework providing domain-aware, higher-order spatiotemporal null ensembles for tracking and event data, providing calibrated benchmarks that disentangle deliberate multi-agent coordination from baseline spatiotemporal co-location.

---
#### Work Package 2: Cross-Domain Diagnostic Auditing of Synthetic MARL Swarms (Year 2)
Directly addressing **RQ2**, this package ports the validated null framework across the domain boundary to synthetic multi-agent systems. Using continuous multi-agent simulators (e.g., VMAS), heterogeneous, role-constrained swarms will be trained under cooperative objectives across standard learned communication architectures, spanning broadcast, targeted attention, and graph-convolutional routing. During policy execution, emergent message streams will be constructed into dynamic communication graphs and audited against synthetic spatiotemporal null ensembles. By measuring standardised divergence scores ($z$-scores) across macro (path length), meso (clustering and triads), and micro (centrality hubs) properties, this audit establishes whether learned communication topologies represent genuine, task-grounded coordination or redundant bandwidth expenditure driven passively by spatial proximity and volume artefacts.
#### Work Package 3: Differentiable Spatiotemporal Null-Regularisation in GNN Layers
Directly addressing RQ3, this package operationalises the spatiotemporal null model as an internal inductive bias within deep geometric learning. While Monte Carlo graph resampling provides an effective offline auditing tool (WP1–WP2), neural representation learning requires analytical, differentiable formulations.
1. **Differentiable Null Expectation:** WP3 formulates an analytical, continuous surrogate of the spatiotemporal null model that outputs the expected edge interaction probability $\mathbb{E}_{\text{null}}[A_{ij}(t)]$ purely as a function of continuous spatial separation $\Vert{}x_i(t) - x_j(t)\Vert{}$, relative velocities, and inter-event latency $\Delta t$.
2. **Residual Message Passing:** Instead of passing messages over raw geometric or fully connected graphs, the GNN layer's attention/transmission kernel is regularised against this expectation:
   $$\tilde{A}_{ij}(t) = \text{Softmax}\Big(\text{Attention}(h_i, h_j, t) - \gamma \cdot \mathbb{E}_{\text{null}}[A_{ij}(t)]\Big)$$
   or integrated via a topological divergence loss $\mathcal{L}_{\text{topo}} = D_{\text{KL}}(A_{\text{learned}}(t) \,\Vert{}\, \mathbb{E}_{\text{null}}(t))$.
3. **Suppressing Spatiotemporal Redundancy:** By penalising interactions that convey no information beyond trivial spatio-temporal co-presence, this regulariser forces the GNN to allocate bandwidth exclusively to unexpected, high-signal coordination. Benchmarking across spatio-temporal GNN benchmarks will evaluate whether this regulariser suppresses non-backtracking cyclic echoes ($i \to j \to i$), mitigates temporal over-squashing, and maintains high performance under constrained communication bandwidth.

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

- Lowe, R., et al. (2019). _On the pitfalls of measuring emergent communication._ NeurIPS.
    
- Eccles, T., et al. (2019). _Biases for emergent communication in multi-agent reinforcement learning._ NeurIPS.
    
- Nisioti, E., et al. (2021). _Grounding emergent communication with physical interaction._