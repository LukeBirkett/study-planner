# Using network science to analyse football passing networks: Dynamics, space, time, and the multilayer nature of the game

> Buldú, J.M., Busquets, J., Martínez, J.H., Herrera-Diestra, J.L., Echegoyen, I., Galeano, J. and Luque, J., 2018. Using network science to analyse football passing networks: Dynamics, space, time, and the multilayer nature of the game. Frontiers in psychology, 9, p.1900.

This is the baseline (opinion) paper where the authors introduced passing networks as a directed, weighted digraph and explicitly identified the limitation that creating robust null models accounting for spatial and temporal constraints remains an open challenge.

---

**How to capture football in Network form:**
"Under this framework, the organization of a team can be considered as the result of the interaction between its players, creating passing networks, which are directed (i.e., links between players go in one direction), weighted (the weight of the links is based on the number of passes between players), spatially embedded (i.e., the Euclidean position of the ball and players is highly relevant) and time evolving (i.e., the network continuously changes its structure)."

---

**Types of Passing Networks:**
"Passes along the match give rise to three main types of passing networks: 
1. player passing networks, where nodes are the players of a team (Passos et al., 2011; Grund, 2012), 
2. pitch passing networks, where nodes are specific regions of the field connected through passes made by players occupying them (Cintia et al., 2015) or 
3. pitch-player passing networks, where nodes are a combination of a player and its position at the moment of the pass (Cotta et al., 2013; Narizuka et al., 2014)."

---

**Topological scales:**
1. The **microscale**, where the analysis is carried out at the level of nodes .i.e., the players and its role inside the network.
2. the **mesoscale**, which ranges from small motifs describing the interaction between 3 or 4 players to the detection of larger groups of players that interact most frequently between them.
3. The **macroscale**, which considers the network as a whole.

---

**Micro-Scale:**
- **degree**, which is the number of passes made by a player (Cotta et al., 2013).
- **eigenvector centrality**, a measure of importance obtained from the eigenvectors of the adjacency matrix (Cotta et al., 2013)
- **closeness**, measuring the minimum number of steps that the ball has to undergo from one player to reach any other in the team (López-Peña and Touchette, 2012)
- **betweenness centrality**, which accounts how many times a given player is necessary for completing the routes (made by the ball) connecting any other two players of its team (Duch et al., 2010; López-Peña and Touchette, 2012)
- **clustering coefficient**, which measures the number of “neighbors” of a player that also have passed the ball between them (i.e., the number of triangles around a player), has also been quantified to evaluate the contribution of a given player to the local robustness of the passing network (López-Peña and Touchette, 2012)

---

**Meso-Scale:**
- Analysis of network motifs has shown how the overabundance of certain kinds of passes between groups of three/four players can be related to both the success of a team (Gyarmati et al., 2014) and the identification of leaders in the passing network (López Peña and Sánchez Navarro, 2015)
- Concerning the role of communities of players playing tightly connected between them, Clemente et al. (2015), related the high heterogeneity of the number of passes between players to the existence of sub-communities, which would hinder the behavior of the team as a whole. 
- Gyarmati and Anguera (2015) studied all the recurring pass sequences, relating discovered sequence patterns to teams’ playing style and strategy.

---

**Macro-Scale:**
- The position of the network centroid has been related to the performance of the teams (the more forward, the better) and has been shown to move backwards when teams play as visitors (Bialkowski et al., 2014)
- Stretch index (mean dispersion of the players around the centroid), the surface area or the team length and width have also been used as more sophisticated metrics related to team performance (Duarte et al., 2012)
- Duch et al. (2010) designed a performance metric based on the betweenness of the players, showing how it correlated with the probability of winning a match. 
- Average degree (i.e., average number of passes) or the variability of the players’ degrees have also been proposed as proxies for evaluating team performance (Cintia et al., 2015; Pina et al., 2017).
- the small-world property (Watts and Strogatz, 1998), observed in a diversity of social, biological and technological networks, has also been reported (Narizuka et al., 2014)
- average clustering coefficient of the team has also been shown to be much higher, during a match, than in equivalent random networks, unveiling the creation of triplets between players (Cotta et al., 2013)

---




"since the game cannot escape from the existence of stochastic forces combined with the high complexity of its intrinsic dynamics, modeling and forecasting a football match becomes a highly challenging task"

"distinguishing noise from determinism is an issue where Network Science can help, since it is possible to determine the level of randomness of the topology of the network and the dynamics occurring in it (e.g., how the ball moves along the network)."

"We are on the way of constructing adequate null models of passing networks that are able to quantify the amount of disorder and complexity of the network topology." 

"As explained in Sarzynska et al. (2016), the interpretation of network metrics should be referred to reference values, which can be obtained from adequate null models" 

> Sarzynska, M., Leicht, E. A., Chowell, G., and Porter, M. A. (2016). Null models for community detection in spatially embedded, temporal networks. J. Comp. Net. 4, 363–406. doi: 10.1093/comnet/cnv027S

"However, these null models must incorporate the particular features of the system they are describing, and the Euclidean position of the nodes and temporal evolution should be taken into account (Sarzynska et al., 2016)." 

"null models for passing networks must be as realistic as possible and include the intrinsic features of the game such as the degree distribution, length of the passes and positions of the players in the pitch."







"Concerning the dynamics along the network, recent approaches using Markovian models could be a starting point to unravel hidden patterns in the passing sequences of a team (López Peña, 2014) but must include the particular features of players’ movements and their ability of decision."









"topology is only one dimension of the analysis of passing networks and at least other two must be included to have a complete picture: space and time" 

"The translation of passes into **pitch or pitch-player** networks seems to be a promising complementary vision of the game, despite the information loss about the players’ behavior" 







"topology is only one dimension of the analysis of passing networks and at least other two must be included to have a complete picture: space and time" 

"Time is another dimension traditionally overlooked when constructing passing networks."

"the analysis of passing networks must take into account its continuous evolution in time and space"

"as shown in Duarte et al. (2012), entropy decreases as the game evolves, which is attributed to the fatigue of the players."

"In addition, collective behaviors decrease in complexity/irregularity during the time periods, accompanied with an increase of the deviations from the mean tendency." 

"Network’s density, heterogeneity and centralization also show differences between the 1st and 2nd part of a match (Clemente et al., 2015)." 

"However, it is common to average along the whole match (Gonçalves et al., 2017), or even along a competition (López-Peña and Touchette, 2012; Gyarmati et al., 2014), obtaining a network that can be informative about the general behavior of a team but excludes the unavoidable fluctuations during a match."

"Therefore, the passing network of a team must be analyzed in combination with the network of the opponent (Narizuka et al., 2014)."









---

Author(s) do not propose or create a method in this paper

They address it as an active limitation and an open challenge in the field.

"We are on the way of constructing adequate null models of passing networks that are able to quantify the amount of disorder and complexity of the network topology."

They explain that a good null model cannot just be a standard random network configuration; it must incorporate specific spatial and temporal constraints of a real football match (such as player positions on the pitch, pass lengths, and degree distributions).

---

Instead of introducing a single "all-in-one" standard null model for passing networks, their strategy shifted toward using alternative mathematical structures—specifically Entropy models and Pitch-Passing frameworks—to separate actual tactical intent from random noise.

---