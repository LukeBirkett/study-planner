1. Separating Emergent Architecture from Geometric Noise: Higher-Order Spatial Markovian Null Models for Heterogeneous Autonomous Swarms
2. Separating Coordination from Spatial Noise: Higher-Order Generative Null Models for Emergent Multi-Agent Communication
3. Separating Emergent Architecture from Geometric Noise: Higher-Order Spatial Null Models from Empirical Collectives to Synthetic Swarms
4. Separating Emergent Architecture from Geometric Noise: Higher-Order Spatial Markovian Null Models for Heterogeneous Multi-Agent Swarms
---
### 1. Introduction
Complex adaptive systems—whether biological, social, or artificial—rely on localised, dynamic interactions to give rise to emergent collective behaviours. In both empirical human collectives and synthetic Multi-Agent Systems (MAS), network science offers a formal framework to represent these interactions as directed, weighted relational networks $G=(V,E,W)$, enabling the rigorous evaluation of system-wide coordination, efficiency, and structural robustness.

However, evaluating raw topological metrics in isolation is fundamentally methodologically flawed. A networks topology is heavily dictated by interaction volume, spatial boundaries and physics. When agents operate within bounded Euclidean spaces, high interaction volume and spatial proximity naturally induce short global path lengths and dense clustering. Without rigorous, domain-aware statistical baselines, researchers conflate passive geometric and volume artefacts with deliberate, policy-driven coordination.

Traditional graph randomisation, such as the Erdős-Rényi $G(N,p)$ model or standard degree-preserving rewiring, fail in spatially embedded domains because uniform edge generation destroys physical geometry, flattens operational workload inequality, and generates implausible cross-role node interactions. 

The motivation for this doctoral proposal builds directly on an empirical master’s project that engineered a first-order Spatial Markovian generative null model for association football. This proposal seeks to build on this work using spatiotemporal sports analytics as an empirical bridge into synthetic Multi-Agent Reinforcement Learning (MARL) and Graph Neural Network (GNN) communication architectures.

This research is guided by three progressive central research questions:
- **RQ1 (Advancing the Empirical Substrate):** How can a first-order spatial resampling engine be expanded into a continuous, higher-order ($k$-step), temporally conditioned Markovian null framework capable of generating full synthetic event streams that adjust for shifting system states and sequential memory?
  [Footnote 1: Is this the correct phrasing for RQ1. It is derived directly from the finding/limitations of the project but might be more powerful question phrased as an agnostic network science point.]
- **RQ2 (Bridging to Artificial Multi-Agent Systems):** When porting this spatial null framework from empirical sports networks to synthetic MARL environments, to what extent are emergent agent communication topologies genuinely policy-driven versus passive artefacts of spatial proximity and interaction volume?
- **RQ3 (Topological Regularisation in GNNs):** Can statistical divergence metrics derived from these spatial null baselines (such as Mesoscale transitive triad $z$-scores) be integrated into GNN communication layers to penalise redundant cyclic message-passing and enforce bandwidth-efficient spatial routing?

---
### 2. Thesis Statement and Literature Review
#### Thesis Statement
This research posits that much of the apparent "emergent coordination" observed in spatially embedded multi-agent networks is an unmeasured artifact of spatial density and interaction volume. By formulating higher-order, non-stationary Spatial Markovian null models—validated first on empirical human collectives and subsequently ported to synthetic MARL swarms—we can statistically isolate genuine collaborative policy from geometric noise and use these divergence signals to regularize GNN communication topologies.

#### Literature Review
Network science provides a mature mathematical toolkit for decomposing complex systems into discrete nodes and relational links, enabling the study of community structures, contagion cascades, and small-world efficiency (Wasserman, 1994; Watts & Strogatz, 1998; Newman, 2001, 2003; Pastor-Satorras & Vespignani, 2001; Lusseau, 2003; Fortunato, 2010). In applied complex systems research, association football serves as a gold-standard empirical laboratory for spatial multi-agent dynamics (Araújo et al., 2006; Duch et al., 2010). Operating as a bounded, adversarial complex adaptive system, eleven heterogeneous, role-constrained agents ($\vert{}V\vert{}=11$) interact continuously across a 2D coordinate space. Moving beyond isolated terminal metrics like Expected Goals (Pollard & Reep, 1997), the "PassMap" paradigm popularized by Buldú et al. (2018, 2019) and expanded across contemporary literature (Peña & Touchette, 2012; Cintia et al., 2015; Peña & Navarro, 2015; Arriaza-Ardiles et al., 2018; Alves et al., 2025; Gama et al., 2026a) models players as nodes and completed passes as directed, weighted edges.

Despite extensive descriptive work, contemporary systematic reviews highlight a critical methodological deficit: the lack of domain-valid null models to benchmark observed network properties against stochastic match noise (Buldú et al., 2018; Gama et al., 2026b). While Narizuka et al. (2014) and Gama et al. (2026b) demonstrated that spatial Markov processes parameterized by distance decay capture possession diffusion and small-world properties, existing literature overwhelmingly applies Markov chains to _fixed_ adjacency matrices to study flow dynamics _on_ the network rather than generative dynamics _of_ the network.

Crucially, this empirical problem is directly isomorphic to contemporary challenges in artificial Multi-Agent Systems—such as autonomous drone swarms, warehouse robotics, and decentralized sensor grids—where heterogeneous agents coordinate under strict geometric and bandwidth constraints. In MARL and GNN-based communication architectures **[INSERT CITATIONS: e.g., Sukhbaatar et al., 2016 (CommNet); Jiang & Lu, 2018 (DGN); Das et al., 2019 (TarMAC)]**, agents learn latent message-passing topologies alongside spatial movement policies. However, current AI literature evaluates emergent communication primarily through terminal task reward rather than rigorous topological auditing **[INSERT CITATIONS: e.g., Lowe et al., 2017; Nisioti et al., 2021]**. Consequently, unconstrained GNN layers frequently converge on dense "hairball" topologies or redundant cyclic message loops that waste bandwidth by conflating spatial co-location with communicative necessity.

#### Originality and Expected Contributions
This project bridges empirical spatial network science and synthetic multi-agent learning across three original contributions:
1. It resolves the memoryless and static-aggregation bottlenecks of first-order spatial network baselines by introducing higher-order ($k$-step), temporally conditioned Markovian generative models **[INSERT CITATION: e.g., Lambiotte et al., 2019 on higher-order networks]**.
2. It leverages women's professional football (FA Women's Super League) as an intuitive, data-rich empirical substrate, directly addressing the systemic underrepresentation of women's datasets in quantitative complex systems literature (Alves et al., 2025; Gama et al., 2026b).
3. It establishes the first cross-domain diagnostic and regularization pipeline capable of pruning spatial noise from GNN communication layers in autonomous swarms.

> TODO: insert 5–7 citations in the bracketed placeholders covering MARL communication and GNN message passing. A supervisor in AI/Complex Systems will look at this paragraph to verify you understand the target domain (Years 2–3) just as well as the source domain (Year 1).

---
### 3. Theoretical Framework
The theoretical rationale for this proposal rests on the intersection of **multi-scale spatial network diagnostics** and **generative Markovian baseline theory**, developed and validated during preliminary MSc research on the 2023/2024 FA Women’s Super League (132 matches; 264 team networks; 89,781 completed passes)

#### Multi-Scale Topological Diagnostics
To evaluate collective coordination in any bounded multi-agent system, network topology must be decomposed across three structural scales (Alves et al., 2025; Gama et al., 2026a):
- **Macro-Scale (Global Circulation & Centralization):** Quantifies system-wide integration via the Global Average Shortest Path ($d = \frac{1}{N(N-1)}\sum_{i \neq j} p_{ij}$) using inverted edge weights ($l_{ij} = 1/w_{ij}$) to measure topological resistance, alongside Team Node Volume Variance ($\text{Var}(s_{\text{tot}})$) and Unweighted Degree Heterogeneity ($CV_k$).
- **Meso-Scale (Combinational Motifs):** Standard unweighted clustering coefficients fail in directed weighted networks by treating all triangles equally. Instead, we isolate **Transitive Triad Intensity** ($I_{\text{transitive}}$), capturing feed-forward multi-agent combinations ($A \rightarrow B \rightarrow C$ with $A \rightarrow C$) constrained by their weakest link ($W_{\min} = \min(W_{AB}, W_{BC}, W_{AC})$), explicitly separating progressive routing from redundant cyclic loops ($A \rightarrow B \rightarrow C \rightarrow A$).
- **Micro-Scale (Routing Pivots):** Evaluates phase-transition mediation via Weighted Betweenness Centrality ($g(i) = \sum_{s \neq i \neq t} \frac{\sigma_{st}(i)}{\sigma_{st}}$), identifying critical routing conduits across functional zones.

#### Generative Spatial Markovian Nulls vs. Unconstrained Random Graphs
Because empirical multi-agent datasets suffer from severe combinatoric sparsity when filtering by volume and formation, statistical benchmarking requires generative null models. However, applying an Erdős-Rényi $G(N,p)$ baseline (Gilbert, 1959; Erdős & Rényi, 1959) to a high-volume empirical outlier network (Arsenal WFC, 720 completed passes) proved its complete domain unviability: uniform weight assignment collapsed workload variance ($\text{Var}(s_{\text{tot}})$ dropped from an empirical 5681.90 to 514.99), artificially inflated mean transitive intensity ($\overline{I}_{\text{transitive}} = 708.54$), and generated physically impossible pitch-wide triads linking the goalkeeper and central striker.

To resolve this, preliminary work inverted traditional Markovian flow modeling. Discretizing normalized $100 \times 100$ coordinates into a $10 \times 10$ spatial grid and mapping agents into a condensed 9-role taxonomy ($N_{\text{pos}} = 9$), a 3D Spatial Probability Tensor $\mathcal{P}(r,c,p)$ was trained across the season corpus using Laplace smoothing ($\alpha = 1.0$) to establish the conditional reception probability $P(p \mid r, c)$. Holding empirical origin coordinates and sender identities fixed to preserve initiative workload ($s_i^{\text{out}}$), the engine resampled recipients across a $N=1,000$ Monte Carlo simulation pipeline, yielding three theoretical insights that frame this PhD:
1. **Partitioning Initiative vs. Target Selection:** Fixing sender origins recovered 55% of empirical workload variance ($\text{Var}(s_{\text{tot}}) = 3117.38$ vs. 5681.90), proving that sender initiative drives roughly half of network centralization while targeted receiver selection drives the remaining 45%.
2. **Macro-Efficiency as a Volume Artifact:** The empirical global shortest path ($d = 0.1884$) sat entirely within the spatial null’s 95% confidence interval ($\overline{d}_{\text{null}} = 0.1932$, CI: $[0.1732, 0.2120]$, $z = -0.43$), proving that rapid global circulation was a passive inevitability of completing 700+ interactions in bounded space rather than tactical superiority.
3. **True Architecture Resides at Meso and Micro Scales:** Benchmarking against the spatial null isolated statistically significant coordination signatures—including left-flank overloading triads ($z = +5.67$), deep build-up triangles ($z = +3.83$), and central defensive routing pivots ($z = +2.73$ and $z = +2.85$)—while exposing high-volume central recycling loops as mere spatial density expectations ($z = -0.28$).

#### Theoretical Bottlenecks Motivating the PhD
While effective for static aggregations, this first-order framework ($P(X_{t+1} = x \mid X_t = x_t)$) revealed three theoretical limitations: (1) a **memoryless bottleneck** that evaluates edges in isolation and washes out sequential $k$-step combinations ($A \rightarrow B \rightarrow C$); (2) **static temporal aggregation**, which ignores scoreline state shifts and player substitutions (e.g., artificially inflating resampled pass shares for 63-minute wingers and distorting isolated striker receptions from 1.53% to 13.33%); and (3) **fixed origin coordinates**, which prevent full synthetic trajectory generation. Overcoming these three bottlenecks provides the theoretical bridge to audit dynamic, continuous-time artificial swarms

---
### 4. Methodology
The research methodology is structured across three progressive Work Packages (WPs) over a four-year doctoral timeline, scaffolding existing expertise in empirical spatial network science (`pandas`, `networkx`, `scipy`) into MARL simulation and geometric deep learning.

---
#### Work Package 1: Higher-Order, Non-Stationary Spatial Nulls (Year 1)
**Methodological Execution:** Using the FA WSL spatiotemporal corpus and multi-competition tracking datasets as a rapid-prototyping sandbox, I will replace discrete $10 \times 10$ grid binning with continuous 2D Spatial Kernel Density Estimation (KDE) to eliminate boundary artifacts. The transition tensor $\mathcal{P}$ will be expanded to incorporate 2nd- and 3rd-order Markovian memory ($P(X_{t+1} \mid X_t, \dots, X_{t-k+1})$), conditioning recipient and destination sampling on prior $k$-step interaction chains.

**Temporal & State Conditioning:** I will introduce sliding temporal windows and Hidden Markov Model (HMM) regime-switching to adjust transition probabilities for active agent availability (eliminating substitution distortions) and shifting system states.

**Analysis Plan:** Synthetic event streams will be evaluated against empirical hold-out matches using Kullback-Leibler (KL) divergence on degree distributions, adjacency matrix correlations ($\overline{r}$), and motif recovery rates to quantify how much meso-scale variance ($I_{\text{transitive}}$) is explained by 2nd- and 3rd-order sequential memory versus 1st-order spatial proximity.

---
#### Work Package 2: Auditing Emergent Coordination in Synthetic Agent Swarms (Year 2)
**Methodological Execution:** The validated higher-order spatial null engine will be ported from 2D sports PassMaps to continuous 2D/3D MARL benchmark environments (e.g., PettingZoo, VMAS, Multi-Agent Particle Environments) featuring heterogeneous, role-constrained agents (e.g., scout-communicator-forager swarms).

**Analysis Plan:** During and after MARL policy training, emergent communication graphs will be extracted and benchmarked against a $N=1,000$ Monte Carlo spatial null ensemble across Macro ($d, \text{Var}(s_{\text{tot}})$), Meso ($I_{\text{transitive}}$), and Micro ($g(i)$) scales. Calculating standardized divergence scores ($z = \frac{M_{\text{empirical}} - \mu_{\text{null}}}{\sigma_{\text{null}}}$) will statistically partition learned communication policies into true strategic routing ($\vert{}z\vert{} \ge 1.96$) versus passive spatial co-location artifacts ($\vert{}z\vert{} < 1.96$).

---
#### Work Package 3: Null-Regularized GNN Communication Architectures (Year 3)
**Methodological Execution:** Building on the diagnostic audit of WP2, I will formulate a differentiable analytical approximation of the spatial null baseline to act as a topological regularizer within GNN message-passing layers (implemented in PyTorch Geometric).

**Analysis Plan:** The auxiliary loss term will penalize edges participating in redundant cyclic loops ($A \rightarrow B \rightarrow C \rightarrow A$) or falling within baseline spatial noise ($\vert{}z\vert{} < 1.96$), while rewarding statistically significant feed-forward transitive triads ($W_{\min}$). Performance will be analyzed via ablation studies comparing unconstrained GNNs, $L_1$-sparsified GNNs, and Spatial-Null-Regularized GNNs across three metrics: (1) cumulative episodic task reward, (2) message-passing bandwidth efficiency (edge sparsity), and (3) zero-shot robustness to agent dropout.

---
#### Summary Timeline
- **Year 1:** Complete cohort training in MARL/GNNs; engineer continuous KDE and higher-order temporal spatial null models on sports event/tracking data (WP1).
- **Year 2:** Port spatial tensor and multi-scale diagnostic suite to synthetic MARL swarms; publish comparative study on empirical vs. synthetic collective topology (WP2).
- **Year 3:** Integrate spatial null divergence regularizers into GNN communication layers; benchmark bandwidth efficiency and swarm robustness (WP3).
- **Year 4:** Synthesize cross-domain findings and complete doctoral dissertation.
---
### 5. Ethical Considerations
This research involves two distinct data domains—empirical human sports logs and synthetic multi-agent simulations—each carrying specific ethical considerations:
1. **Public-Figure PII and Open-Source Licensing (WP1):** The empirical phase utilizes the StatsBomb Open Data corpus for the 2023/2024 FA Women's Super League. While this dataset contains public-figure Personally Identifiable Information (player names, positional roles, and match appearance logs), all data is derived from publicly broadcast professional sporting events distributed under the open-access StatsBomb User Agreement. It carries zero risk of disclosing sensitive personal, medical, or private-life information. All engineered network datasets and probability tensors will adhere strictly to FAIR data principles (Findable, Accessible, Interoperable, Reusable).
2. **Domain Equity and Algorithmic Bias (WP1):** Quantitative sports science suffers from a historic overreliance on men's professional datasets. Centering empirical baseline development on women's football promotes open-source equity in sports analytics while ensuring that learned spatial transition tensors account for domain-specific tactical profiles.
3. **Autonomous Swarm Safety and Environmental Impact (WP2 & WP3):** While synthetic MARL simulations involve no human subjects, research into decentralized swarm coordination carries potential dual-use implications (e.g., defense applications). To ensure responsible innovation, all synthetic environments will be strictly confined to cooperative civilian benchmarks (such as decentralized search-and-rescue, environmental monitoring, and warehouse logistics). Furthermore, because Monte Carlo resampling and MARL training are computationally intensive, analytical approximations of the spatial null will be prioritized in WP3 to minimize GPU training hours and reduce the project's carbon footprint.
---
### 6. Bibliography
### Foundational & Empirical Sources (Cited from Preliminary Work)

Alves, R., Dias, G., Nunes, N. A., Querido, S. M., & Vaz, V. (2025). Social network analysis in football: a systematic review of performance and tactical applications. _Frontiers in Psychology_, 16, 1659603.

Araújo, D., Davids, K., & Hristovski, R. (2006). The ecological dynamics of decision making in sport. _Psychology of Sport and Exercise_, 7(6), 653–676.
    
Arriaza-Ardiles, E., Martín-González, J., Zuniga, M., Sánchez-Flores, J., De Saa, Y., & García-Manso, J. M. (2018). Applying graphs and complex networks to football metric interpretation. _Human Movement Science_, 57, 236–243.
    
Buldú, J. M., Busquets, J., Martínez, J. H., Herrera-Diestra, J. L., Echegoyen, I., Galeano, J., et al. (2018). Using network science to analyse football passing networks: Dynamics, space, time, and the multilayer nature of the game. _Frontiers in Psychology_, 9, 1900.
    
Buldú, J. M., Busquets, J., Echegoyen, I., & Seirul·lo, F. (2019). Defining a historic football team: Using Network Science to analyze Guardiola's FC Barcelona. _Scientific Reports_, 9(1), 13602.
    
Cintia, P., Rinzivillo, S., & Pappalardo, L. (2015). A network-based approach to evaluate the performance of football teams. In _Machine Learning and Data Mining for Sports Analytics Workshop_, Porto, Portugal.
    
Duch, J., Waitzman, J. S., & Amaral, L. A. N. (2010). Quantifying the performance of individual players in a team activity. _PLoS ONE_, 5(6), e10937.
    
Erdős, P., & Rényi, A. (1959). On Random Graphs I. _Publicationes Mathematicae Debrecen_, 6, 290–297.
    
Fortunato, S. (2010). Community detection in graphs. _Physics Reports_, 486(3–5), 75–174.
    
Gama, J., Dias, G., Pereira, M., Mendes, R., Mendes, R. S., Sarmento, H., et al. (2026a). Network analysis to understand variability and patterns of individual and collective behaviour in professional football: A systematic review. _International Journal of Performance Analysis in Sport_, 1–62.
    
Gama, J., Dias, G., Couceiro, M. S., Mendes, R., Mendes, R. S., & Vaz, V. (2026b). Linking network structures and stochastic flow properties: An exploratory Markov-spectral case study in professional football. _Proceedings of the Institution of Mechanical Engineers, Part P: Journal of Sports Engineering and Technology_.
    
Gilbert, E. N. (1959). Random Graphs. _The Annals of Mathematical Statistics_, 30(4), 1141–1144.
    
Lusseau, D. (2003). The emergent properties of a dolphin social network. _Proceedings of the Royal Society B: Biological Sciences_, 270(Suppl 2), S186.
    
Narizuka, T., Yamamoto, K., & Yamazaki, Y. (2014). Statistical properties of position-dependent ball-passing networks in football games. _Physica A: Statistical Mechanics and its Applications_, 412, 157–168.
    
Newman, M. E. (2001). The structure of scientific collaboration networks. _Proceedings of the National Academy of Sciences_, 98(2), 404–409.
    
Newman, M. E. (2003). The structure and function of complex networks. _SIAM Review_, 45(2), 167–256.
    
Pastor-Satorras, R., & Vespignani, A. (2001). Epidemic spreading in scale-free networks. _Physical Review Letters_, 86(14), 3200.
    
Peña, J. L., & Touchette, H. (2012). A network theory analysis of football strategies. _arXiv preprint arXiv:1206.6904_.
    
Peña, J. L., & Navarro, R. S. (2015). Who can replace Xavi? A passing motif analysis of football players. _arXiv preprint arXiv:1506.07768_.
    
Pollard, R., & Reep, C. (1997). Measuring the effectiveness of playing strategies at soccer. _Journal of the Royal Statistical Society Series D: The Statistician_, 46(4), 541–550.
    
Wasserman, S. (1994). _Advances in social network analysis: Research in the social and behavioral sciences_ (Vol. 171). Sage.
    
Watts, D. J., & Strogatz, S. H. (1998). Collective dynamics of 'small-world' networks. _Nature_, 393(6684), 440–442.

### Potential Sources to Add for Target PhD Domains (Spatial Networks, MARL & GNNs)

**Spatial & Higher-Order Network Nulls:**
    - _Expert, P., Evans, T. S., Blondel, V. D., & Lambiotte, R. (2011)._ Uncovering space-independent communities in spatial networks. _PNAS_, 108(19), 7663–7668. _(Essential citation for separating spatial distance decay from true topological structure—directly mirrors your spatial null philosophy)._
    - _Lambiotte, R., Rosvall, M., & Scholtes, I. (2019)._ From networks to optimal higher-order models of complex systems. _Nature Physics_, 15(4), 313–320. _(Directly supports your WP1 transition from 1st-order memoryless graphs to $k$-step higher-order Markov chains)._
        
**Emergent Communication in MARL & GNNs:**
    - _Sukhbaatar, S., Fergus, R., et al. (2016)._ Learning multiagent communication with backpropagation (CommNet). _Advances in Neural Information Processing Systems (NeurIPS)_.
    - _Das, A., Gervet, T., Romoff, J., Batra, D., Parikh, D., Rabbat, M., & Pineau, J. (2019)._ TarMAC: Targeted multi-agent communication. _International Conference on Machine Learning (ICML)_.
    - _Jiang, J., & Lu, Z. (2018)._ Learning attentional communication for multi-agent cooperation (DGN). _arXiv preprint arXiv:1805.07733_. _(Uses Graph Convolutional Networks for MARL communication—ideal target architecture for your WP3 regularizer)._
    - _Bettini, M., Kortvelesy, R., Blumenkamp, J., & Prorok, A. (2022)._ VMAS: A Vectorized Multi-Agent Simulator for Collective Robot Learning. _Distributed Autonomous Robotic Systems (DARS)_. _(Since you explicitly mentioned VMAS in WP1, cite the Prorok Lab's paper here)._
---
