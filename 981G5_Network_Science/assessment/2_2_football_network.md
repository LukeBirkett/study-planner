# 2.2 Network Topology in Football (Methodological Showcase):

> Note, somewhere between this section and 1_3 passmap, we sound mention that we are working with "average passing networks", cumuliative representation of an entire match. But mention that as Buldu (2019), these networks can be segmented to any temporal level. Buldu (2019) uses 50 pass-networks to normalize comparisons between opposing teams, and infere network properties leading upto a goal. (Or this could be more appropriate for a lit review)

I will probably scope my examples down to clustering coeffiecent, shortest path and a centrality measure (or two). Of course, degrees will be remain a component in generate

These are the simplest network metrics to port over and a have extreme intuitive football interpretations.




**Topological scales (Buldu, 2018):**
1. The **microscale**, where the analysis is carried out at the level of nodes .i.e., the players and its role inside the network.
2. the **mesoscale**, which ranges from small motifs describing the interaction between 3 or 4 players to the detection of larger groups of players that interact most frequently between them.
3. The **macroscale**, which considers the network as a whole.

---

**Micro-Scale (Buldu, 2018):**
- **degree**, which is the number of passes made by a player (Cotta et al., 2013).
- **eigenvector centrality**, a measure of importance obtained from the eigenvectors of the adjacency matrix (Cotta et al., 2013)
- **closeness**, measuring the minimum number of steps that the ball has to undergo from one player to reach any other in the team (López-Peña and Touchette, 2012)
- **betweenness centrality**, which accounts how many times a given player is necessary for completing the routes (made by the ball) connecting any other two players of its team (Duch et al., 2010; López-Peña and Touchette, 2012)
- **clustering coefficient**, which measures the number of “neighbors” of a player that also have passed the ball between them (i.e., the number of triangles around a player), has also been quantified to evaluate the contribution of a given player to the local robustness of the passing network (López-Peña and Touchette, 2012)

---

**Meso-Scale (Buldu, 2018):**
- Analysis of network motifs has shown how the overabundance of certain kinds of passes between groups of three/four players can be related to both the success of a team (Gyarmati et al., 2014) and the identification of leaders in the passing network (López Peña and Sánchez Navarro, 2015)
- Concerning the role of communities of players playing tightly connected between them, Clemente et al. (2015), related the high heterogeneity of the number of passes between players to the existence of sub-communities, which would hinder the behavior of the team as a whole. 
- Gyarmati and Anguera (2015) studied all the recurring pass sequences, relating discovered sequence patterns to teams’ playing style and strategy.

---

**Macro-Scale (Buldu, 2018):**
- The position of the network centroid has been related to the performance of the teams (the more forward, the better) and has been shown to move backwards when teams play as visitors (Bialkowski et al., 2014)
- Stretch index (mean dispersion of the players around the centroid), the surface area or the team length and width have also been used as more sophisticated metrics related to team performance (Duarte et al., 2012)
- Duch et al. (2010) designed a performance metric based on the betweenness of the players, showing how it correlated with the probability of winning a match. 
- Average degree (i.e., average number of passes) or the variability of the players’ degrees have also been proposed as proxies for evaluating team performance (Cintia et al., 2015; Pina et al., 2017).
- the small-world property (Watts and Strogatz, 1998), observed in a diversity of social, biological and technological networks, has also been reported (Narizuka et al., 2014)
- average clustering coefficient of the team has also been shown to be much higher, during a match, than in equivalent random networks, unveiling the creation of triplets between players (Cotta et al., 2013)

---