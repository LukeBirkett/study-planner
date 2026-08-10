# Liturature Review
- Why Networks? System Reviews & 
    - Beyond status (xG, Passes, Bludu (2019))
    - System Reviews, What others have proved with Nets
- Dynamics ON the Network; Stochasistic Flows, Buldu Onwards, (Naz, Gama)
- Calls for Nulls; Buldu, Naz, Gama, Alves(?)

> This provides a clear end-to-end narrative

---

"We are on the way of constructing adequate null models of passing networks that are able to quantify the amount of disorder and complexity of the network topology." (Buldu, 2018)

This statement is particularly important as one of the foundational papers in this field is expicitly calling for and working on spatial contextual models. However, following this, the community took an intense "detour" into Markovian stochastic flow research, only to arrive back at the realization that flow dynamics cannot be interpreted without spatial, context-aware null models (Gama, Alves.)

Buldú et al. explicitly declared the intent to build spatial null models, but the field hit a mathematical wall: how do you randomize an $11 \times 11$ matrix while simultaneously preserving spatial geometry, formation constraints, and player degree distributions?

Because static spatial null models proved so difficult to build, researchers pivoted toward Dynamics ON the Network (How does the ball move?) — specifically Markovian stochastic processes, random walks, and spectral analysis (pioneered by Narizuka et al., 2014, and culminating in Gama et al., 2026).

By modeling ball circulation as a Markov chain with transition probabilities $P_{ij}$, researchers could compute absolute mathematical properties like Spectral Gap (propagation speed) and Entropy Rate (flow randomness). These metrics provided elegant, self-contained numbers for a team's passing speed without needing a standard topological shuffle.

As contemporary systematic reviews (Alves et al., 2025; Gama et al., 2026) have pointed out, Markovian metrics created a new baseline problem: a team's Spectral Gap or Entropy Rate is heavily dictated by their formation's physical layout.

A standard 4-3-3 formation naturally creates passing triangles that boost Spectral Gap and Entropy. **Without a spatial null model**, you cannot answer the fundamental question: Is a Spectral Gap of $0.53$ proof of elite tactical execution, or is it just the natural mathematical result of 11 players standing in a 4-3-3 shape?

This is why contemporary researchers have come full circle. They realized that Dynamics ON the network do not eliminate the need for null models—they heighten it.

---


"since the game cannot escape from the existence of stochastic forces combined with the high complexity of its intrinsic dynamics, modeling and forecasting a football match becomes a highly challenging task" (Buldu, 2018)

"distinguishing noise from determinism is an issue where Network Science can help, since it is possible to determine the level of randomness of the topology of the network and the dynamics occurring in it (e.g., how the ball moves along the network)." (Buldu, 2018)

"As explained in Sarzynska et al. (2016), the interpretation of network metrics should be referred to reference values, which can be obtained from adequate null models" (Buldu, 2018)

> Sarzynska, M., Leicht, E. A., Chowell, G., and Porter, M. A. (2016). Null models for community detection in spatially embedded, temporal networks. J. Comp. Net. 4, 363–406. doi: 10.1093/comnet/cnv027S

---
