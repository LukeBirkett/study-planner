# 5.3 Evaluation Protocols: 

The eval metrics should be the ones focused on in 2.2
- Clustering
- Average Path Length
- Centrality

> Note, may the evaluation itself will pertain to these metrics. But there will be an analysis section which looks are granular details, i.e. where are the hubs distributed, are we seeing inrealistic long passes, are we seeing unrelaistic pairs. 


This is a very basic and rudimentary comment but I get the impression that the key to evaluating football networks may some from less traditional network properties. 

The basis will be to preserve the exists of nodes and edges and structurally preserve node degrees. Though I think add some level of variable/noise into the degrees will be valid. 

The "rewriring" proccess (whatever this may be) will need to therefore generate network properties that follow suit of football. 

In terms of network properties like clusters, we can compute an empirical range which it should fall in, but more metrics are the point of interest, we want to see how certain metrics fluctuate. 

Therefore, the key will be to evaluate null models against footballing principles encoded into networks. 

This may entail evaluting the goalkeepers role and freq of passes

In may be looking into cross field passes and therefore unlikely relatioships in the network. 

However, we need to be care nots to bound the eval too deeply. Strikers are seldom hubs, but they could be in a unique system or talents player. We don't want to discard nulls which produces striker hubs but there should be a range of prevelance. 

We have a ful lseasons data, something like 400 games with 2 team per game. For all metrics, both traditional and domain specific, we can produces a full suite of empirical summary statistics to evaluate our nulls against. 

If we produce 1000 nulls how does the summary compare

---

## Modeling Out-Degrees to Generate In-Degrees:
In football, a coach/player chooses when and where to pass (out-degree behavior). Who receives the ball (in-degree) is an emergent property of spatial positioning and opponent pressure.

Evaluating whether your generated in-degree distributions match empirical validation sets gives you an immediate goodness-of-fit metric for your null model.

---

## Justifying the 3 Metrics:
Alves et al. (2025) provide frequency metrics on what the field actually uses:
- Macro-level: Network Density and Clustering Coefficients dominate team-level cohesion studies.
- Micro-level: In-degree, Out-degree, and Betweenness Centrality dominate individual/hub identification.

Density, Weighted Clustering, Betweenness Centrality, and Shortest Path—these are the exact standard metrics highlighted by the 2025 review.

---

## Gama (2026)

They find that entral defenders and midfielders consistently act as structural hubs. This is clear justifcaiton for an evaluation or analysis check to interpret the results of the null null distributions.

--- 

## (Naz, 2014)
Narizuka et al. (2014) explicitly prove that football passing networks exhibit small-world properties, but they firmly reject the claim that they are scale-free.  

In network science, a graph is "small-world" (Watts & Strogatz, 1998) if it satisfies two conditions when compared to an equivalent random graph:

Short Mean Path Length ($l \approx l_{\text{rand}}$): The ball can travel between any two nodes in very few steps.  

High Clustering Coefficient ($C \gg C_{\text{rand}}$): Nodes have a strong tendency to form dense, interconnected local triangles.

Narizuka et al. measured real match data and found:  

Path length $l \approx 3.3$, which is very close to a random graph ($l_{\text{rand}} \approx 4.4$).  

Clustering $C \approx 0.25$, which is roughly 10 times higher than a random graph ($C_{\text{rand}} \approx 0.02$).  Because $l$ is small and $C$ is massive, football passing networks cleanly satisfy the definition of a small-world network.

A network is "scale-free" (Barabási & Albert, 1999) if its degree distribution follows a pure Power Law ($P(k) \sim k^{-\gamma}$). This implies the existence of extreme "super-hubs" with unlimited capacity, like the World Wide Web or airport flight paths.

Early football studies (Yamamoto, 2010; Yamamoto & Yokoyama, 2011) claimed passing networks were scale-free.

The Sample-Size Flaw: Previous papers tried to fit a power law on standard $N=11$ player graphs. Fitting a heavy-tailed distribution on only 11 data points is statistically invalid.

By expanding the graph to $N=198$ nodes using pitch zones, Narizuka et al. showed that the degree distribution does not go on infinitely like a power law. At high degrees, the distribution drops off sharply because players have physical limitations—time, pitch boundaries, and human fatigue prevent a player or zone from having 1,000 passes. 

Instead of a power law, they proved the degree distribution is accurately fitted by a Truncated Gamma Distribution ($f(k) \propto k^{\nu-1} e^{-k/\lambda}$):  Power-law behavior at low degrees ($\nu \approx 0.34$): Captures local passing choices.  Exponential cutoff at high degrees ($\lambda$): Captures the physical and spatial limits of football.

---


addition, we have also found that a network created from our model has similar structural properties to the real data. Judging from these results, we conclude that our model incorporates essential features of real football games. (Naz, 2014)

" seems to be implying that global properties are what represent football in network but the local properties are the tactical insights. In terms of generating null networks, it is the goal of reproducing the global properties allowing use to use the nulls as a baseline to assess local properties." Naz