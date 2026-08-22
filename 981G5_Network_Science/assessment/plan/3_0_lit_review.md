# Liturature Review
- Why Networks? System Reviews & 
    - Beyond status (xG, Passes, Bludu (2019))
    - System Reviews, What others have proved with Nets
- Dynamics ON the Network; Stochasistic Flows, Buldu Onwards, (Naz, Gama)
- Calls for Nulls; Buldu, Naz, Gama, Alves(?)

> This provides a clear end-to-end narrative

---

## From Bludu Null to Markovian to Nulls again
"We are on the way of constructing adequate null models of passing networks that are able to quantify the amount of disorder and complexity of the network topology." (Buldu, 2018)

This statement is particularly important as one of the foundational papers in this field is expicitly calling for and working on spatial contextual models. However, following this, the community took an intense "detour" into Markovian stochastic flow research, only to arrive back at the realization that flow dynamics cannot be interpreted without spatial, context-aware null models (Gama, Alves.)

Buldú et al. explicitly declared the intent to build spatial null models, but the field hit a mathematical wall: how do you randomize an $11 \times 11$ matrix while simultaneously preserving spatial geometry, formation constraints, and player degree distributions?

Because static spatial null models proved so difficult to build, researchers pivoted toward Dynamics ON the Network (How does the ball move?) — specifically Markovian stochastic processes, random walks, and spectral analysis (pioneered by Narizuka et al., 2014, and culminating in Gama et al., 2026).

By modeling ball circulation as a Markov chain with transition probabilities $P_{ij}$, researchers could compute absolute mathematical properties like Spectral Gap (propagation speed) and Entropy Rate (flow randomness). These metrics provided elegant, self-contained numbers for a team's passing speed without needing a standard topological shuffle.

As contemporary systematic reviews (Alves et al., 2025; Gama et al., 2026) have pointed out, Markovian metrics created a new baseline problem: a team's Spectral Gap or Entropy Rate is heavily dictated by their formation's physical layout.

A standard 4-3-3 formation naturally creates passing triangles that boost Spectral Gap and Entropy. **Without a spatial null model**, you cannot answer the fundamental question: Is a Spectral Gap of $0.53$ proof of elite tactical execution, or is it just the natural mathematical result of 11 players standing in a 4-3-3 shape?

This is why contemporary researchers have come full circle. They realized that Dynamics ON the network do not eliminate the need for null models—they heighten it.

---

## Buldu Fundementals of Applying Network Science + Nulls to football
"since the game cannot escape from the existence of stochastic forces combined with the high complexity of its intrinsic dynamics, modeling and forecasting a football match becomes a highly challenging task" (Buldu, 2018)

"distinguishing noise from determinism is an issue where Network Science can help, since it is possible to determine the level of randomness of the topology of the network and the dynamics occurring in it (e.g., how the ball moves along the network)." (Buldu, 2018)

"As explained in Sarzynska et al. (2016), the interpretation of network metrics should be referred to reference values, which can be obtained from adequate null models" (Buldu, 2018)

> Sarzynska, M., Leicht, E. A., Chowell, G., and Porter, M. A. (2016). Null models for community detection in spatially embedded, temporal networks. J. Comp. Net. 4, 363–406. doi: 10.1093/comnet/cnv027S

---

#### History of Network Science to Football (Buldu, 2019):
The seminal paper by Gould and Gatrell [33], published in the late seventies, introduced the concept of passing networks associated to a football match. However, it did not obtain the relevance it deserved, both in the scientific and sports communities. More than thirty years later, the work of Duch and collaborators [34] marked the start of a decade that is witnessing how the analysis of passing networks (by means of Network Science) is unveiling crucial information about the organization, evolution and performance of football teams  and players [30]
- [33] Gould, P. & Gatrell, A. A structural analysis of a game: The Liverpool vs manchester united cup final of 1977. Soc. Netw. 2, 253–273 (1979).
- [34] Duch, J., Waitzman, J. S. & Amaral, L. A. N. Quantifying the Performance of Individual Players in a Team Activity. PLoS ONE 5, e10937 (2010).
- [30] Buldu, 2018

---

## Known Applications of Networks to Football
*What other researchers have done with Networks and what they may have found*

> This can be quickly done and bulked out use Alves systematic review and picking up the seminal/key network papers and applications.

Bludu (2019) used Network Science to compre the network organization of Guardiola’s team against a seasons worth of domenstic opponents to identify metrics with FC.Barcelona held as statistically significant different to the rest of the league, with the goal of relating the difference to Guardiola’s tactical appraoch. 
- "identifying similarities and differences at the network parameters and linking them with the particularities of Guardiola’s principles"

Buldu (2019) claims to have identified network metrics which refelcted the enhanced probability of scoring a goal including "clustering coefficient, shortest-path length, largest eigenvalue of the adjacency matrix, algebraic connectivity and centrality distribution"

"Previous literature about average passing networks has shown that they reveal information about the way a team is organized [50] and are also related with team performance [51]" (Buldu, 2019)
- [50] López-Peña, J. & Touchette, H. A network theory analysis of football strategies. In C. Clanet (ed.), Sports Physics: Proc. 2012 Euromech Physics of Sports Conference, p. 517–528, Éditions de l’École Polytechnique, Palaiseau, (ISBN 978-2-7302-1615-9) (2012). 
- [51] Cintia, P., Rinzivillo, S. & Pappalardo, L. A network-based approach to evaluate the performance of football teams. In Machine Learning and Data Mining for Sports Analytics Workshop, Porto, Portugal (2015)

Gama (2026) introduce a dual network paradigm. They use Tradaitonal Network properties as static representations, i.e. who passed to who. But then create the Markov-spectral framework to model ball circulation as a stochastic process. Here they are capturing Dynamics ON the Network to analyse speed, passing uncertainty, and diffusion. They argue to build a picture of team coordination both the structural configuration and stochastic flow properties need to be understood

Gama et al., (2026) (SR) highlight that Network Analysis "reveals how structural and functional coordination emerges from the patterns of interaction among players, providing metrics that may reflect team adaptability and strategic efficiency." 

Previous research has demonstrated that cohesive network structures and well-chosen centrality metrics can illuminate performance outcomes. For example, teams with higher connectivity and balanced interaction patterns often achieve greater success. [30,35] [Pina, Ribero]

Gama et al.’s goal of bridging static Social Network Analysis (SNA) with stochastic flow metrics (Entropy Rate, Spectral Gap, Mean First-Passage Time) to quantify how possession flows.

Gama introduced sophisticated stochastic metrics to solve descriptive limitations but ran into the same baseline trap the Bludu had called for nearly a decade earlier. 

Adding complex Markovian/spectral flow metrics does not eliminate the need for null models. Without a spatial null baseline, even high-level flow metrics remain purely descriptive.


--- 

## Lack of Nulls in the Lit and Calls
Alves et al. (2025) explicitly map out the entire methodological landscape of football network science (highlighting micro, meso, macro metrics, pitch-passing networks, and sliding time windows). Yet across all 55 reviewed studies, null model baselines, statistical reference ensembles, and generative network tests are never covered.
- while modern research has embraced dynamic tracking, pitch discretization, and ML models, the field remains overwhelmingly descriptive. Network metrics are repeatedly correlated with match outcomes without ever testing if those metric values simply arise from geometric chance or formation artifacts

> Note, Alves et al. (2025) also highlight two more limitations explicitly, a severe underrepresentation of Women's Football. and An overreliance on single-match or short tournament samples rather than full-season longitudinal datasets.

Gama et al. (2026) highlights the exact same literature gap as Alves et al. (2025): the field uses network science almost exclusively for observational and descriptive purposes.  

While researchers use complex metrics like Spectral Gap, Entropy Rates, and Algebraic Connectivity to describe team performance, none of the underlying studies evaluate whether those metric values are statistically significant compared to a spatially constrained null model.

> Recent comprehensive systematic reviews of network science in football (Alves et al., 2025; Gama et al., 2026) demonstrate a heavy reliance on macro- and micro-level metrics to describe team performance and tactical variability. However, across both reviews, there is a complete absence of generative null models or statistical baseline ensembles. Observed network properties are routinely interpreted as deliberate tactical achievements without verifying whether they simply reflect spatial geometry, player position averages, or random chance."

> Contemporary research uses network science almost exclusively as an observational tool, correlating raw metrics (such as Density, Betweenness, or Entropy) with performance outcomes without verifying if those metric values are statistically significant compared to a spatially constrained baseline. This project directly addresses this literature deficit by developing generative null models that establish true statistical inference for football passing networks.

Gama et al.  (2026) explcitiyl call for Null models. In their stochastic flow paper, they only used a sample of 2 matches and therefore conceeded that conceded that their observed variations in flow metrics "cannot be statistically distinguished from random match-to-match variability". Additionally, they said that the call for Null models is required to establish baseline boundaries. This baseline is required to separate deliberate tactical adaptations from normal stochastic match noise.

""Future studies should also employ **null models and random network** comparisons to establish baselines for spectral gap, entropy rate, and other indices, enabling more robust interpretation of observed values"" Gama et al.  (2026)

"'reflect genuine tactical adaptations... or whether they represent normal stochastic fluctuations inherent to passing sequences in football'." Gama et al.  (2026)

A null model establishes the boundaries of that normal fluctuation, providing the exact justification needed to design generative null frameworks for football analytics.

---

## Dynamics OF, Markovian, Stochastic

Gama (2026) is a key paper for the Dynamics ON the Network era which encompasses Markov chains, random walks, and spectral decomposition to measure ball movement across fixed nodes. Despite all of their interesting findings and the create of the spectral gap [need to better summarise their findings here], they only studied a 2 match sample which we conceeded lacked the statistical power to run resampling tests or prove significance. Additionally, they self-identified spatial limitation: because their Markov layer ignores spatial coordinates $(x, y)$, naive matrix permutation shuffles produce physically impossible long-distance passes. They call for null models and this reasons is specifically why we are looking into spatially constrained models.

--- 

Early studies (e.g., Yamamoto, 2010; Yamamoto & Yokoyama, 2011) claimed that football passing networks follow a power-law degree distribution $P(k) \sim k^{-\gamma}$, classifying them as scale-free networks. Narizuka et al. highlight a glaring statistical flaw: evaluating degree distributions on simple $N=11$ player graphs provides too few data points to prove a true power law. (Naz, 2014)

To solve the $N=11$ small-sample issue, Narizuka et al. introduce what Buldú et al. (2018) later formalized as the Pitch-Player Hybrid Network. The pitch is discretized into 18 spatial areas ($3 \times 6$ grid, matching official 2010 FIFA World Cup statistics). A node represents a specific player operating within a specific spatial zone. For 11 players across 18 zones, $N = 18 \times 11 = 198$ potential nodes per team.  Outcome: This expands the node count from $N=11$ to $N=198$, unlocking the statistical resolution required to fit empirical degree distributions accurately.

> Maybe explain this passparadigm sections. Reason for beyond pitch player is to increase nodes and potential for scale free

Real passing graphs exhibit short mean path lengths ($l \approx 3.3$, close to random graph baselines $l_{\text{rand}} \approx 4.4$) paired with clustering coefficients that are 10 times higher than random graphs ($C \approx 0.25$ vs. $C_{\text{rand}} \approx 0.02$)

Rather than a pure power law, empirical cumulative degree distributions $F(k)$ fit a truncated gamma distribution:

