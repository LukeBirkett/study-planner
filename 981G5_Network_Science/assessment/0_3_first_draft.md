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

## Section 1

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
















---

- Wasserman, S. & Faust, K. Social Network Analysis: Methods and Applications, (Cambridge University Press, 1994).  
- Newman, M. E. The structure of scientific collaboration networks. Proc. Natl. Acad. Sci. 98, 404–409 (2001)
- Fortunato, S. Community detection in graphs. Phys. Rep. 486, 75–174 (2010).
- Pastor-Satorras, R. & Vespignani, A. Epidemic spreading in scale-free networks. Phys. Rev. Lett. 86, 3200 (2001). 
- Barabási, A. L. The origin of bursts and heavy tails in human dynamics. Nature 435, 207 (2005) 

8.  Borgatti, S. Centrality and network flow. Social Networks 27, 55–71 (2005).  
9.  Newman, M. E. A measure of betweenness centrality based on random walks. Social Networks 27, 39–54 (2005).