# The 3 PassMap Paradigms (Buldú Framework)

"For each match, a directed weighted adjacency matrix A was constructed, where each entry represents the number of passes from one player to another." (Gama et al (2026, Stochasitc))


## Tier 1: Classical Player-Centric Network
*Introduced by Buldú et al. (2018)*

**Graph Definition:** $G = (V, E, W)$

**Nodes ($V$):** The 11 starting players on the pitch ($\vert{}V\vert{} = 11$). Each node is a player Identity (e.g., #8 Midfielder)

**Edges ($E$) & Weights ($W$):** A directed, weighted edge $w_{ij}$ represents the total number of completed passes from Player $i$ to Player $j$ during a given timeframe ($A \to B$).

"we are concerned about the analysis of football matches and, specifically, the way players interact with each other by passing the ball, ultimately creating what is known as a football passing network." (Bludu, 2019)

"Passing networks are constructed from the observation of the ball exchange between players, where network nodes (or vertices) are football players and links (or edges) account for the number of passes between any two players of a team." (Bludu, 2019)

"This way, we can construct football passing networks, weighted and unidirectional, which in turn are spatially embedded [30–32]" (Bludu, 2019)

"In the figure, nodes (i.e., players) are placed in the average position from where their passes were made and the width of the links is proportional to the number of passes made between players"


---

This type of networks can be implemented in two steps: 1.1 Spatially Blind or 1.2 Spaital Context. 

The **spatially-blind implementation** is simplest representation in football analytics. It works on a pure topological standard, modelling the movement of the ball from one player to another. It allows for the abstract modelling of stochastic transitions (the probability of moving from node to node) across the adjacency matrix $A_{ij}$. Note, it has no understand of where the ball and players are on the pitch, just that interactions are taking place. 

Micro Metric examples include Degree Centrality (how many passes a player receives/makes), Betweenness Centrality (a player's role as a bridge), or an individual player's Clustering Coefficient (passing triangles formed with immediate neighbors).

Macro Metrics examples include Network Density (overall connectedness of the team), Spectral Gap (speed of team-wide ball circulation), Entropy Rate (predictability of overall passing flow), and Network Diameter.

While all of these metrics work mathematically on space-blind matrices, their interpretation in football is deeply flawed without spatial context. Two nodes may have a high clustering coefficent as they are physically close to each other, i.e. Left-Back, Left-Midfielder. If we want to evaluate whether a metric is significant, we need to compare the empirical network to a spatially constrained null model(s). If the same metric commonly occurs in the null(s) then it is a topolgoical/spatial/geographic quality, not unique to performance or deliberate tactical execution. 

The **spatially-aware implemenation** builds on this paradigm by utilizing coordinate data, usually pass start/end locations but also average touch positions. The average positions are atteched to the nodes as attributes, allowing for spatially accurate plotting of nodes on a pitch. The network matrix itself does not record where on the pitch that specific pass started or landed. Passes are still just recorded simply as an edge $w_{AB} + 1$. 

Note, in terms of classical network metrics, i.e. centrality, clustering, entrophy rate, this spaital attribute does not change anything and is purely visual. The math is completely blind to whether Player A is 5 meters or 50 meters away from Player B. This means the $11 \times 11$ adjacency matrix ($A_{ij}$) itself contains zero spatial information and only records who passed to who and how many times. 

However, this additional insight, particular when utilizing directly from the raw pass data, can be used to go beyond standard topological metrics by creating spatially explicit graph metrics. For example, you can weight edges by physical distance $d_{ij}$. A 40-meter cross field switch that connects two distant nodes carries a vastly different physical cost and tactical weight than a 5-meter lay-off, even if both count as $1$ pass in a traditional matrix. Inherently, the nodes obtaining spatial context also means the edges have. 

Most importantly for this project, even if we are just focusing on the classical, topological metrics, the spatial coordinate attributes serve as a conditioning variaible for null models. Without spatial coordinates, a traditional null model may assume every player can pass to every other player with abstract, equal likelihood, leading to naive topological shuffles in the space-blind matrix. Spatial coordinates provide a physical baseline needed to build a generative spatial null model, for example, the likely positions of nodes can be learned or spatially aware pass likelihoods. 

The static average $(x, y)$ coordinates can be used calculate physical distance between players (e.g., Euclidean distance) and weight the probability of a random pass occurring.

A spatial null model would take the space-blind $11 \times 11$ matrix and conditions its random pass probabilities on the spatial coordinates $(\bar{x}, \bar{y})$ of the players, making the baseline space-aware without needing to expand the matrix into a multi-node hybrid graph. 

---
| Metric Scale | Level | Core Definition & Focus | Key Examples / Scope |
| :--- | :--- | :--- | :--- |
| **Micro Metrics** | Node / Edge | Focuses on individual network components to quantify individual roles, influence, and localized interactions. | Specific player actions, individual passing links |
| **Mesoscale** | Sub-group | Analyzes clusters, sub-networks, or localized units within the team. | Midfield trio passing dynamics, left-flank chemistry |
| **Macro Metrics** | System / Network | Summarizes the entire network into a single global value to quantify team structure, cohesion, stability, and collective ball circulation. | All 11 players across the full team network |

*Defined in the network analysis reviews by Alves (2025) and Gama (2026).*

---

## Tier 2: Pitch-Player Hybrid Network (Multilayer / Zone-Player)
*Primary Source: Buldú et al. (2019) — Guardiola’s FC Barcelona Study*

Graph Definition: $G = (V_{PK}, E, W)$

Nodes ($V_{PK}$): A composite node representing Player $P$ located inside Pitch Zone $K$. The pitch is discretized into a grid (e.g., $3 \times 3$, $4 \times 6$, or $5 \times 3$ zones). If a player operates across 4 different zones during a match, they generate 4 distinct nodes in the network.

Edges ($E$) & Weights ($W$): Directed edge $w_{(P_1, K_1) \to (P_2, K_2)}$ representing a pass initiated by Player 1 in Zone 1 and completed to Player 2 in Zone 2.

In this paradigm Buldu cpatures tactical positioning alongside passing choices. It captures where players stood in discrete form when they passed. It explicity tries player identity to physical pitch coordinates.

---

## Tier 3: Pure Pitch-Location Network (Grid / Territory Graph)
*Primary Source: Buldú et al. (2018)*

Graph Definition: $G = (K, E, W)$

Nodes ($K$): Discretized sub-regions or spatial cells of the pitch (e.g., 18 or 24 spatial zones), completely independent of player identities.

Edges ($E$) & Weights ($W$): Directed ball flow from Zone $K_A$ to Zone $K_B$, regardless of who made or received the pass.

This paradigm abstracts away human identity entirely to map the geometric routing of the ball. It is pure geogrpahy baseline and therefore decomposes whether ball progression is dictacted by pitch geography/topology or tactical instructure. 

---

## Methodology: Tier 1

While all three paradigms capture valid dimensions of team organization, the rest of the report will focus strictly on the Tier 1: Player Passing Network paradigm. This form of network is by far the most popular in the liturature (Cotta et al., Duch et al., Grund, and Gama et al., 2026, Alves et al., 2025) allowing for deeper interpretation. Additionally, is it the most intuative to visualise as it plots the 11 players we expect to see in a game. This pertains to the fact that is it the least processed and closest relation to the underlying raw pass data. Pitch-Player and Pitch require ample pre-processing to convert the pass data into discrete bins, of which themselves there is no widely agreed standard (Camerino et al., 2012; Narizuka et al., 2014; Arriaza-Ardiles et al., 2018). 

Finally, it is hypothesized that a likely candidate pipeline that will produce strong results will dervive from a generative process that models the underlying passes. Whilst all paradigms are compliled from the same pass data, Tier 1 requires the fewest preprocessing steps, but also, elementinates ambiguit on what what the generative process should model. For examle, should a generative process buidling pitch  networks model the true underlying passes, or the processed location-to-location passes from the chose discrete bins. 

The player passing networks with node attributes $(\bar{x}, \bar{y})$ allow Tier 1 to remain spatially aware without requiring grid discretization. Tier 1 serves as the optimal baseline for generative null models because it operates at the exact resolution of player tactical assignments.  

Limitations: 
- Player passing networks are vulnerable to matrix sparsity. The continuous resolution may entail and impossible task for the generative processes to model adequately, leading to bias and underrepresentation in less frequent passing zones. This would be a issue for micro-level metrics which identify interesting properties for players who operate in wider, fringe locations. The discrete nature of the pitch passing paradigm could maximise data density and therefore the confidence of the underlying generative model. Although it should be noted that we have access to a whole seasons worth of data, potentially even more, so this risk may be mitigated to an extent. 

---

#### Subs

**Gama, 2026:** The networks that the authors constructed included all players that features in the game, including subs. Nodes in their PassMaps seem to be positioned by role rather than an average of interaciton positions, i.e. a left-back is always plotted in the same position. 

--