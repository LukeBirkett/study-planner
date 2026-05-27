# Empirical Baseline (League) vs Null Model Baseline
In the (contemporary, alves) research, there is not null model applications. 

However, most, if not all, papers use emprical baseslines. For example researches may say team X (barca, monaco, benefica) demostate better Y propertie that the league average. 

This only tells you have something is different but it cannot tell you why it is unusual. 

Generating null models goes beyond the raw data because it allows you to separate systemic constraints (geometry, rules, and mathematics) from deliberate human strategy.

#### Disentangling "Formation Bias" from "Tactical Intent"
Imagine during analysis we find that player X from Y team players as a left-winger but has a massive betweenness centrality score compared to the league average for all players. Clearly we have used the league data to identify that they are different. 

**The Empirical League Baseline tells you:** "This winger is a significantly bigger hub than 95% of players in the league."

However, from the network we derive the team A are using a 4-3-3 formation where as most of the league uses 4-4-2. The answer we are looking to answer is whether the play is have a standout game, or the underyling conditions are "forcing" a given property. 

By using a Position-Permuted Null Model, you can freeze that exact match's structural profile and swap the players around. If every player you shuffle into that left-winger slot automatically yields a massive centrality score, your null model has just proven that the position is the hub, not the player. If the real winger's score still eclipses the shuffled simulations, you have isolated true, individual outperformance.

> to be clear, shuffling the players means generating new network with the same underlying conditions. if the new networks show the same nodes producing the same or similar poperties then it is likely the formation (tactics) rathern than a unique performance. 

#### Controlling for the Tyranny of Geometry (Spatial Constraints)
Football is played on a bounded rectangle. Central midfielders are surrounded by 360 degrees of passing options; wingers are trapped against the touchline with only 180 degrees of options. Because of this geometric reality, central players will always dominate raw network metrics like degree centrality and page-rank over a season-long empirical average.

If you only compare your winger to the league average, they will look like a fringe player. But a Spatially-Constrained Null Model (like the Gravity Model) builds a physics-like baseline that explicitly penalizes options based on boundary constraints and player distances.

When your null model says, "Based on pure geometry, a player standing in this exact wide coordinate should only receive 4% of the team's passes," and your raw data shows they received 22%, your null model has exposed a massive tactical anomaly that a league average would completely smooth over and hide.

#### Dealing with the "Environment Variance" (No Two Games are Equal)
A empirical dataset assumes all passes are the same and therefore can be compared. Networks are highly sensitive to the prevailing curcumstances. 

**Against a Low Block:** A team might rack up 800 short, low-risk passes among defenders, sky-rocketing the team's clustering coefficient.

**In a Chaotic End-to-End Match:** The team might only make 300 direct, high-risk passes, tanking their clustering coefficient.

It's not correct to compare a choatic individual match to the league average. it will compare as being messy and unstructued. 

A Generative Null Model evaluates the match against itself. It asks: "Given that this specific match featured exactly 300 passes distributed across these exact player coordinates, what is the mathematical probability that a winger would emerge as a hub?" It calibrates the baseline to the unique context of that specific game, offering a level of precision an empirical average can never match.

---

> "While empirical league baselines identify relative variance between subjects (e.g., how Barcelona differs from Getafe), they fail to isolate the underlying mechanism causing that variance. Conversely, a mathematically defined null model provides an ab initio baseline that controls for spatial, geometric, and rule-based constraints. This allows us to separate statistical artifacts born of pitch geometry or formation structure from genuine, intentional tactical anomalies."

---

The answer comes down to three things that raw data filtering cannot do: handling multi-dimensional confounding, creating counterfactuals for unique contexts, and isolating structure from volume.

#### empirical data suffers from the curse of dimensionality
you want to compare an individual match to a baseline which reflects similar circumstances, i.e. controlling for given factors. Here you can't just look at the league averge because you would then be comparing to matches that: used diff positions, played against a diff system (low-block), played in a team with much more possion (more edges). As you filter down the dataset to get these same/similar conditions you might find yourself with a dataset of only 3/4 matches. 

The Null Model Advantage: A generative null model (like the Gravity Model or an ERGM) solves this by abstracting the rules of the system rather than matching the scenarios. It learns the underlying mathematical relationship between physical distance, player involvement, and pass probability across the whole season. It can then instantly generate a custom, statistically sound baseline for any combination of variables, even if that specific combination of possession, formation, and spacing has never happened before.

#### Generating the "Counterfactual" for a Single Match
A network is not just a collection of independent nodes; it is an interdependent system. If a winger behaves as a hub, it affects the degree centrality of the left-back, the central midfielder, and the striker simultaneously.

If you just look at the historical data of "how wingers usually perform," you are looking at an average of completely different systems. You cannot easily answer the exact counterfactual question for this specific match:

"In this exact game, given how the other 10 teammates were moving and spacing themselves, how much of our winger's high centrality was due to his teammates' positioning, and how much was due to a deliberate tactical instruction to feed him the ball?"

With Empirical Filtering, you are looking at completely different matches with different teammate positions. A generative null model freezes a given matches exact 11 player positions (coords) and simulate aleratnvie networks based on this

A position-permuted or spatially-constrained null model holds the exact geometry of that specific match completely frozen. It shuffles the network on that exact coordinate map. It tells you what is expected on that night, with those exact teammates, in those exact positions. Empirical filtering can only tell you what happens on average across the league.

#### Separating Network Structure from Event Volume
This is the most "Network Science" reason of all. Network metrics like Betweenness Centrality, PageRank, or Eigenvector Centrality are non-linear. They don't just measure how many passes a player received (In-Degree); they measure who passed it to them and how central those players are. If a team plays a match with 800 passes, all network centrality metrics will naturally scale up and behave differently than in a match with 300 passes.
- If you use an empirical baseline, you are mixing high-volume matches with low-volume matches, which warps non-linear metrics like PageRank.
- If you use a Null Model, you condition the simulation on the exact degree sequence or edge-count of that specific match.

The null model allows you to say: "Even when we artificially scale the network to have exactly 412 passes (the exact volume of this match), the arrangement of the edges (the topology) still heavily favors the winger in a way that randomness cannot explain." It isolates structure from volume.

---

> "One might argue that an empirical baseline consisting of filtered positional data (e.g., assessing a winger against the historical distribution of all wingers) is sufficient. However, empirical filtering suffers from the curse of dimensionality when controlling for compounding tactical variables (formation, possession, spacing) and fails to isolate network topology from event volume. By contrast, a generative null model allows for the construction of a true match-specific counterfactual—evaluating whether a player's network properties represent a structural anomaly given the exact, idiosyncratic spatial constraints of that specific 90-minute system."

---

> I need to read more papers to be sure of this, but from what I have read so far there are many statements like "barcelonda exhibit higher clustering than the league average". statements like this are 


---


Moving Beyond SNA: Spatially Embedded NetworksTo build an actual Network Science project for football, you have to treat it as a spatially embedded network (Buldú et al., 2018). In these systems, nodes have physical coordinates $(x,y)$, and the probability of an edge existing is heavily influenced by the Euclidean distance between those coordinates.When you factor in pitch coordinates, you realize that a team's passing network is governed by two competing forces:
1. Tactical Intent: The intentional strategy of the coach (e.g., building up through the wings).
2. Spatial Constraints: The physical reality that shorter passes are easier to complete than longer ones.

Without a null model, you cannot separate tactical intent from spatial constraint. For example, if the two central defenders pass to each other 30 times a match, is that a brilliant tactical "tiki-tika" strategy, or is it just the baseline result of two people standing 15 meters apart with no pressure?


Buldú, J. M., Busquets, J., Martínez, J. H., Herrera-Diestra, J. L., Echegoyen, I., Galeano, J., & Luque, J. (2018). Using Network Science to Analyse Football Passing Networks: Dynamics, Space, Time, and the Multilayer Nature of the Game. Frontiers in Psychology, 9, 1900. https://doi.org/10.3389/fpsyg.2018.01900
Cited by: 134

---

# Network Science vs SNA
The mathematical properties and algorithms (degree centrality, clustering coefficients, community detection) are identical, but the history, philosophy, and scope are completely different.

Social Network Analysis (SNA) is the parent disapline. Network Science is the modern, expanded evolution of that discipline.

SNA; 
- Emerged in the 1930s–1970s out of sociology, anthropology, and psychology.
- Strictly human or organizational. Focuses on friendships, corporate boards, advice networks, or political alliances.
- Historically small to medium (dozens or hundreds of nodes). Data was collected via tedious surveys or interviews.
- Theory-driven & Bottom-up: Starts with a sociological theory (e.g., "Do people with weak ties get better jobs?") and uses the network to test it.

Network Science;
- Exploded in the late 1990s out of statistical physics, computer science, and math.
- Any complex system. Includes brains (neural networks), power grids, protein interactions, and the internet.
- Massive / Big Data (thousands to billions of nodes). Data is scraped computationally.
- Data-driven & Top-down: Looks at a massive web of data, extracts the math, and looks for universal laws (e.g., scale-free networks).

When you read a domain-specific paper using SNA, and it computes betweenness centrality or density, it feels exactly like your Network Science class because Network Science absorbed the toolkit of SNA and blended it with graph theory.

However, 

In Network Science: A hub with massive degree centrality in a power grid is a structural vulnerability—if it fails, the grid blacks out.

In SNA: A hub with massive degree centrality in an office is an influential person—if they leave, organizational memory is lost.

If a paper uses the term SNA, the authors are signaling that they care deeply about the social context and human behavior. They aren't just treating people as abstract nodes; they are tying the network structure back to human agency, power dynamics, or social capital.

When researchers approach football solely through a Social Network Analysis (SNA) lens, they treat the team like an office workflow or a group of friends. They calculate classic metrics like degree centrality or density to find the "influential" player (Alves, 2025). But they miss a massive structural reality: football is a spatially constrained, dynamic physics problem disguised as a social network.

In classic SNA, if you want to know if a network structure is meaningful, you compare it to an Erdős–Rényi random graph ($G(n,p)$) or use a configuration model that shuffles edges while keeping node degrees constant.

If you randomly shuffle the passing edges of a football team using a standard configuration model, you might create a network where the left-back frequently passes directly to the right-winger over a distance of 70 meters. In reality, that pass is incredibly difficult and rarely attempted due to the physical limits of human kicking accuracy and intercepting defenders. Because standard social network null models don't account for pitch geography, sports science researchers often skip them entirely and stick to purely descriptive metrics (e.g., "The central midfielder made 40 passes").

To build an actual Network Science project for football, you have to treat it as a spatially embedded network (Buldú et al., 2018). In these systems, nodes have physical coordinates $(x,y)$, and the probability of an edge existing is heavily influenced by the Euclidean distance between those coordinates.

---

# Using Single Match Networks Over an Entire Season


**The Temporal/Dynamic Network (Evolution):** Build networks for each match (or segment) and extract the relevant properties. Track how the metrics develop over time. The way the networks change and therefore the metric change can be analysed and explained from a football/tactical perspective. A common approach is windowing where you compute the average of something, say a team's Clustering Coefficient to see if tactical discipline spikes or dips during a losing streak.

**The "Ensemble" Network:** You could ensemble all matches from a teams seasons into one super network. This essentially creates a probability map of how a team functions - and you could frame this as a managers tactical outputs. From this you could ask "what is the teams backbone?". The supernetwork itself will be an uniterpretable hairball as all players will likely have made a pass to eachother in some way, including all swud players. You use Disparity Filter (Salience Network) to strip away the statistically insignificant edges and reveal the "Multiscale Backbone"—the core passing lanes that persist regardless of the opponent.

---

