# 2.2 Network Topology in Football (Methodological Showcase):

> Note, somewhere between this section and 1_3 passmap, we sound mention that we are working with "average passing networks", cumuliative representation of an entire match. But mention that as Buldu (2019), these networks can be segmented to any temporal level. Buldu (2019) uses 50 pass-networks to normalize comparisons between opposing teams, and infere network properties leading upto a goal. (Or this could be more appropriate for a lit review)

I will probably scope my examples down to clustering coeffiecent, shortest path and a centrality measure (or two). Of course, degrees will be remain a component in generate

These are the simplest network metrics to port over and a have extreme intuitive football interpretations.


---

## Gama (2026, stoch) translation dict

A full suite of defining network propertiy metrics and translating to football-specific interpretations.

Additionaly, the contributed a family metric taxonomy: Centrality measures (quantifying structural workload/volume) vs. Entropy-based measures (quantifying passing variability/unpredictability).

Use their entire table in the appendex and directly references for the chose metrics. Also are a referencefor a few other metrics. 

Also in the table, create a subset verson based on my key metrics used, i.e. clustter, degree, in, out, centrality, patth

*"who participates most" and "who connects whom."* [4] [Clemente]. These reflect the volume and positional importance of contributions to the passing network.

---

**Topological scales (Buldu, 2018):**
1. The **microscale**, where the analysis is carried out at the level of nodes .i.e., the players and its role inside the network.
2. the **mesoscale**, which ranges from small motifs describing the interaction between 3 or 4 players to the detection of larger groups of players that interact most frequently between them.
3. The **macroscale**, which considers the network as a whole.

---

## Buldu 2018

**Micro-Scale (Buldu, 2018):**
- **degree**, which is the number of passes made by a player (Cotta et al., 2013).
- **eigenvector centrality**, a measure of importance obtained from the eigenvectors of the adjacency matrix (Cotta et al., 2013)
- **closeness**, measuring the minimum number of steps that the ball has to undergo from one player to reach any other in the team (López-Peña and Touchette, 2012)
- **betweenness centrality**, which accounts how many times a given player is necessary for completing the routes (made by the ball) connecting any other two players of its team (Duch et al., 2010; López-Peña and Touchette, 2012)
- **clustering coefficient**, which measures the number of “neighbors” of a player that also have passed the ball between them (i.e., the number of triangles around a player), has also been quantified to evaluate the contribution of a given player to the local robustness of the passing network (López-Peña and Touchette, 2012)

**(Micro)** Degree, Closeness, Betweenness, and Eigenvector centralities were prioritised as indicators of influence and mediation of information flow, consistent with previous football network studies. [1,2,4–6,30,35] (Gama 2026, stoch)

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

Transitivity reflects the tendency to form passing "triangles" (three-player combinations) indicative of coordinated subgroups.(Gama, 26, stoch)

---

## Buldu 2019

**Macro (Buldu, 2019):**
Passing networks, taken as whole, exhibit a small-world topology [36], typically with high clustering coefficient (i.e., a tendency to create triangles of passes between three players) when compared to a random null model [37], and where the number of steps to go from one node to any other is much lower than the number of nodes of the network [38]. 
- [36] Narizuka, T., Yamamoto, K. & Yamazaki, Y. Statistical properties of position-dependent ball-passing networks in football games. Physica A 412, 157–168 (2014).
- [37]  Cotta, C., Mora, A. M., Merelo, J. J. & Merelo-Molina, C. A network analysis of the 2010 FIFA world cup champion team play. J. Syst. Sci. Complex. 26, 21 (2013)
- [38]  Watts, D. J. & Strogatz, S. H. Collective dynamics of small-world networks. Nature 393, 440–442 (1998).

**Meso (Buldu, 2019):**
It is also possible to detect the existence of motifs [39], consisting in the overabundance of certain kinds of passes between groups of three/four players [40] or even communities of players tightly connected between them41.

**Micro (Buldu, 2019):**
we can use network motifs to characterize the role of a player in a team or even to find players (in other teams) with similar features [42]. 
- [42]  López Peña, J. & Sánchez Navarro, R. Who can replace Xavi? A passing motif analysis of football players. arXiv:1506.07768 (2015).

Importance of players in a passing network can be quantified using the betweenness or closeness parameters, which show that passing networks are prone to find a balance between all players [43] 
- [43] Gonçalves, B.  et al. Exploring team passing networks and player movement dynamics in youth association football. PLoS ONE 12, e0171156 (2017)

---

"The radius of the nodes reflects their "importantance" in the network. This could be fore example, their eigenvector centrality" (Bludu, 2019)

---

"The high number of passes unavoidably leads to passing networks with links that have higher weights and, as we will see, this fact will have consequences on the network parameters." (B, 2019)

---


## Clustering Coefficent
"Clustering coefficient C, which is related to the amount of triangles  created between any triplet of players." (Buldu, 2019)

"Clustering coefficient is an indicator of the local robustness of networks [31], since when a triangle connecting three nodes (i.e. players) exists, and a link (i.e., pass) between two nodes is lost (i.e., not possible to make the pass), there is an alternative way of reaching the other node passing through the  other two edges of the triangle." (Buldu, 2019)

"In football, the clustering coefficient mesures the triangulation between three players." (Buldu, 2019)

"The authors find Clustering is much higher in FCB. This reveals that connections between three players are more abundant than at their rivals." (Buldu, 2019)

"higher local resilience against the loss of passes (due to a higher clustering)" (Buldu, 2019)

"In general, the local **clustering coefficient** of a node i is obtained as the percentage of the nodes directly connected to it that, in turn, are connected between them. This measure can be averaged along the N nodes of the network to obtain the **average clustering coefficient**. However, when the network is weighted, we can not simply account for the number of nodes connected between them but, also, how the link weights are distributed. This is the case of passing networks, where the number of passes between pairs of players is not constant. In this way, we use the **weighted clustering coefficient** Cw(i) to measure the likelihood that neighbours of a given player i will also be connected between them [60]:" (Buldu, 2019)
- Ahnert, S. E., Garlaschelli, D., Fink, T. M. A. & Caldarelli, G. Ensemble approach to the analysis of weighted networks. Phys. Rev. E
76, 016101 (2007).

$C_w(i) = \frac{\sum_{j,k} w_{ij} w_{jk} w_{ik}}{\sum_{j,k} w_{ij} w_{ik}}$  

"where j and k are any two players of the team and wij and wik the number of passes between a third player i and both them. Finally, the clustering coefficient of the whole network is obtained by averaging Cw(i) over all players. Note that, the weighted version of the clustering coefficient characterizes the tendency of the team to form balanced triangles between players and it is a measure of local robustness." (Bludu, 2019)

---

## Average Shortest Path
"The average shortest path d is an indicator about how well connected are players inside a team. It measures the 'topological distance' that the ball must go through to connect any two players of the team." (Buldu, 2019)

Buldú et al. define the topological distance $l_{ij}$ between Player $i$ and Player $j$ as the inverse of the number of passes between them: 

$$l_{ij} = \frac{1}{w_{ij}}$$

The higher the number of passes between two players, the closer (i.e., lower) the topological distance between them is.

"since it is the ball that travels from one player to any other, it is possible to find the shortest path between any pair of players by computing the shortest topological distance between them, no matter if it is a direct connection or if it involves passing through other players of the team." (Buldu, 2019)
> This is a good point and as the "path travelled" in football its the literal movement of the so it is easier to follow. Some examples, average shortest path is an abstract notion of how close or far apart entities are. Furthermore, nodes in football are not fixed, therefore, this has a unique interpretation. 

If Xavi passes to Busquets 30 times ($w_{ij} = 30$), the topological distance between them is very small ($l_{ij} = \frac{1}{30} \approx 0.033$). They are "topologically close". If the Goalkeeper passes to the Striker only once ($w_{ij} = 1$), the direct distance is large ($l_{ij} = \frac{1}{1} = 1.0$).

"the average shortest path d of a team is just the average of the shortest path between all pairs of players" (Buldu, 2019)

"the shortest path of FCB is much lower than their rivals, which reveals that players are better connected between them." (Buldu, 2019)

lower number of steps to connect any two players of the teams (due to a lower shortest-path length) (Buldu, 2019)


"In a passing network, the shortest path length d is the minimum number of players that  must be traversed by the ball to go from one player to any other. Since passing networks are weighted (i.e., the number of passes between players is different), we have to take into account the different weights of the links, considering that, the higher the weight, the shorter the topological distance between two nodes." (Buldu, 2019)

"The topological length $l_{ij}$ of the link between two players $i$ and $j$ is defined as the inverse of the link weight, $l_{ij} = 1/w_{ij}$" (Buldu, 2019)

"When computing d for weighted networks, the shortest-path length between a pair of players may not be a direct link, since there could exist a shorter path by combining two (or more) alternative links. Therefore, we compute the minimal shortest-path pij between all pairs of players using the Dijkstra’s algorithm [61]. Next, we define the average shortest path d of the whole team" (Buldu, 2019)

$d = \frac{1}{N(N-1)} \sum_{i \neq j} p_{ij}$ 

Instead of forcing the ball to go directly from Player A to Player B over a single weak link ($l_{AB} = 1.0$), the algorithm evaluates whether an indirect path through an intermediary player is topologically shorter.

The team's macro Average Shortest Path ($d$) is the mean of these minimal topological distances across all pairs:

$$d = \frac{1}{N(N-1)} \sum_{i \neq j} p_{ij}$$

Because $l_{ij} = \frac{1}{w_{ij}}$, the value of $d$ is heavily dependent on total pass volume.  A team that completes 700 passes will naturally have smaller $l_{ij}$ values—and thus a vastly smaller Average Shortest Path ($d$)—than a team completing 300 passes, even if both teams have the exact same tactical formation. 

### 
- Low Average Shortest Path ($d$): Indicates high overall team connectivity, rapid ball circulation, and strong global interaction. The ball travels easily across the whole team through high-volume passing channels. 
- High Average Shortest Path ($d$): Indicates structural bottlenecks, isolated players, or a reliance on long, infrequent passes.


---

## Centrality 
"Fig. 3E-F show how centrality (i.e., the importance of the players inside the passing network) is distributed along the team, a metric calculated by means of the eigenvector related to the largest eigenvalue of the connectivity matrix" (Buldu, 2019)

"Figure 3E contains the average dispersion of centrality and Fig. 3F shows the highest value of a single player." (Buldu, 2019)

"In both cases, differences are not statistically significant to support evidences of a different centrality distribution between FCB and the rest of the teams" (Buldu, 2019)

"higher connectedness between the whole team, as indicated by a higher largest eigenvalue of the connectivity matrix and a higher algebraic connectivity." (Buldu, 2019)

"The highest centrality acquired by a single player and the centrality dispersion are the highest, which indicates that the importance of players in the FCB network is not evenly distributed, with one player, Xavi, being the hub of the passing networks." (Buldu, 2019)

---

"Previous research has demonstrated that cohesive network structures and well-chosen centrality metrics can illuminate performance outcomes. For example, teams with higher connectivity and balanced interaction patterns often achieve greater success. [30,35]" (Gama et al 2026, stoch)
-  [30] Pina TJ, Paulo A and Arau´jo D. Network characteristics of successful performance in association football: a study on the UEFA Champions League. Front Psychol 2017; 8: 1173. https://doi.org/10.3389/fpsyg.2017.01173
- [35] Ribeiro J, Silva P, Duarte R, et al. Team sports performance analysed through the lens of social network theory: implications for research and practice. Sports Med 2017; 47(9): 1689–1696. https://doi.org/10.1007/ s40279-017-0695-1

---

## Gama, 2025, Stoch

**(Micro)** Degree, Closeness, Betweenness, and Eigenvector centralities were prioritised as indicators of influence and mediation of information flow, consistent with previous football network studies.
-  indicators of influence and mediation of information flow, consistent with previous football network studies. [1,2,4–6,30,35]
- While some degree of conceptual overlap may exist among these metrics, [2,3,14,15] their combined presentation offers a multi-dimensional profile of individual involvement in the passing network.


>  [1] Duch J, Waitzman JS and Amaral LAN. Quantifying the performance of individual players in a team activity. PLoS ONE 2010; 5(6): e10937. https://doi.org/10.1371/journal.pone.0010937

> [2] = Gamas Systematic Review
> [3] = Alves Systematic Review
> [4] = Clemente (2017), [5] Clemente (2014), [6] Clemente (2015)

> [14] Caicedo Parada S, Lago Pen˜as C and Ortega Toro E. Passing networks and tactical action in football: a systematic review. Int J Environ Res Public Health 2020; 17(18): 6649. https://doi.org/10.3390/ijerph17186649

> [15]  Xu Y, Diaz-Cidoncha Garcia J, Sarmento H, et al. Application of social network analysis in football match analysis: a systematic review. Int J Sports Sci Coach 2025; 21(0): 548–568. https://doi.org/10.1177/17479541251377548

> [30] Pina, [35] Ribeiro


### Macro Metrics

**(Macro):** At the team level, Total Links, Network Density, Average Distance, Network Diameter, Network Heterogeneity, Global Centralisation, Global Prestige, Transitivity, Reciprocity, Assortativity Coefficient, and Network Transition Entropy were calculated to assess:
- overall team cohesion, interaction diversity, and tactical adaptability.

These metrics capture complementary aspects of collective behaviour: for example, Transitivity reflects the tendency to form passing "triangles" (three-player combinations) indicative of coordinated subgroups

Global Centralisation and Global Prestige gauge how concentrated the playmaking is through particular individuals

Network Transition Entropy quantifies the unpredictability of the team’s overall passing pattern

---

"This observation aligns with findings that football passing networks often exhibit scale-free properties with emergent key players acting as hubs. [50]" (Gama, 2026, Stoch)
- Yamamoto Y and Yokoyama K. Common and unique network dynamics in football games. PLoS ONE 2011; 6(12): e29638.