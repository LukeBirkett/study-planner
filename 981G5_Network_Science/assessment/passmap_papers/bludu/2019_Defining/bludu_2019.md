# Defining a historic football team: Using Network Science to analyze  Guardiola’s F.C. BarcelonaJ

> Buldú, J.M., Busquets, J., Echegoyen, I. and Seirul. lo, F., 2019. Defining a historic football team: Using Network Science to analyze Guardiola’s FC Barcelona. Scientific reports, 9(1), p.13602.

---

### Abstract:
"the organization of football teams and their performance have been unveiled using metrics coming from Network Science,  where a team is considered as a complex network whose nodes (i.e., players) interact with the aim of overcoming the opponent network."

"Here, we combine the use of different network metrics to extract the particular signature of the F.C. Barcelona coached by Guardiola, which has been considered one of the best teams along football history."

"We have first compared the network organization of Guardiola’s team with their opponents along one season of the Spanish national league, identifying those metrics with **statistically significant differences** and relating them with the Guardiola’s game."

"Next, we have focused on the temporal nature of football passing networks and calculated the evolution of all network properties along a match, instead of considering their average."

"In this way, we are able to identify those network metrics that enhance the probability of scoring/receiving a goal, showing that not all teams behave in the same way and how the organization Guardiola’s F.C. Barcelona is different from the rest,  including its clustering coefficient, shortest-path length, largest eigenvalue of the adjacency matrix, algebraic connectivity and centrality distribution"

---

### Network Science to Football:
"Using such an approach, it is possible (i) to identify the most influential individuals of a social network [6–11], (ii) to detect the existence of communities of people and the common interests that tie them more tightly than individuals in other communities [12–14], (iii) to explain the propagation of rumors/diseases [15–18] or (iv) to analyze the bursting activity of individuals when communicating with others [19]"

The areas of application and systems under study are as diverse as (i) on-line social networks (e.g., Facebook or Twitter) [20–25], (ii) interactions between companies and shareholders [26,27], (iii) crime networks [28], (iv) collaborations between scientists [1,11], or (v) scaling laws in cities

"here we are concerned about the analysis of football matches and, specifically, the way players interact with each other by passing the ball, ultimately creating what is known as a football passing network."

Passing networks are constructed from the observation of the ball exchange between players, where network nodes (or vertices) are football players and links (or edges) account for the number of passes between any two players of a team.

This way, we can construct football passing networks, weighted and unidirectional, which in turn are spatially embedded [30–32]

---

### History of Network Science Football

The seminal paper by Gould and Gatrell [33], published in the late seventies, introduced the concept of passing networks associated to a football match. However, it did not obtain the relevance it deserved, both in the scientific and sports communities. More than thirty years later, the work of Duch and collaborators [34] marked the start of a decade that is witnessing how the analysis of passing networks (by means of Network Science) is unveiling crucial information about the organization, evolution and performance of football teams  and players [30]
- [33] Gould, P. & Gatrell, A. A structural analysis of a game: The Liverpool vs manchester united cup final of 1977. Soc. Netw. 2, 253–273 (1979).
- [34] Duch, J., Waitzman, J. S. & Amaral, L. A. N. Quantifying the Performance of Individual Players in a Team Activity. PLoS ONE 5, e10937 (2010).
- [30] Buldu, 2018

---

### Network Properties Applied to Football (Scales)

**Macro:**
Passing networks, taken as whole, exhibit a small-world topology [36], typically with high clustering coefficient (i.e., a tendency to create triangles of passes between three players) when compared to a random null model [37], and where the number of steps to go from one node to any other is much lower than the number of nodes of the network [38]. 
- [36] Narizuka, T., Yamamoto, K. & Yamazaki, Y. Statistical properties of position-dependent ball-passing networks in football games. Physica A 412, 157–168 (2014).
- [37]  Cotta, C., Mora, A. M., Merelo, J. J. & Merelo-Molina, C. A network analysis of the 2010 FIFA world cup champion team play. J. Syst. Sci. Complex. 26, 21 (2013)
- [38]  Watts, D. J. & Strogatz, S. H. Collective dynamics of small-world networks. Nature 393, 440–442 (1998).

**Meso:**
It is also possible to detect the existence of motifs [39], consisting in the overabundance of certain kinds of passes between groups of three/four players [40] or even communities of players tightly connected between them41.

**Micro:**
we can use network motifs to characterize the role of a player in a team or even to find players (in other teams) with similar features [42]. 
- [42]  López Peña, J. & Sánchez Navarro, R. Who can replace Xavi? A passing motif analysis of football players. arXiv:1506.07768 (2015).

Importance of players in a passing network can be quantified using the betweenness or closeness parameters, which show that passing networks are prone to find a balance between all players [43] 
- [43] Gonçalves, B.  et al. Exploring team passing networks and player movement dynamics in youth association football. PLoS ONE 12, e0171156 (2017)

---

### Buldu (2019) Reasons and Approach to applying networks to football:
we are going to use Network Science to provide a different perspective of FCB style of playing, a perspective focused on the organization of FCB passing networks and their differences with the rest of the teams paying in the Spanish national league.

First, we will obtain passing networks for the 380 matches of the 09/10 season

Next, we will analyze the differences between Guardiola’s team and the rest of Spanish teams, identifying similarities and differences at the network parameters and linking them with the particularities of Guardiola’s principles.


we will discuss the influence of the temporal fluctuations of the network parameters along a match and will propose a temporal analysis of passing networks. With this aim, we will introduce the concept of 50-pass networks and recalculate all network parameters at different moments of the match, giving special attention to scored received goals.

our results show that (i) passing networks unveil additional information not contained in the average network and, in addition, (ii) temporal analysis highlights some of the particular features of Guardiola’s game.

---

#### Average Passing Networks

Figure 1 shows an example of a football passing network, in this case the aver-
age network of FCB against Real Madrid in the season 2009/2010. Note that links are unidirectional (from player 
A to player B) and weighted according to the number of passes between players.

In the figure, nodes (i.e., players) are placed in the average position from where their passes were made and the width of the links is proportional to the number of passes made between players

The x,y coordinates have been scaled to between 0,100 and are measured in "field units" as not all fields are the same size. 

The radius of the nodes reflects their "importantance" in the network. This could be fore example, their eigenvector centrality. 

The authors obtained match-level averages passnetworks for Barcelonda entire 09/10 laliga seasons (38 matches) along with their opponents network for each match.

The input to the network are all passes and positions along the match. 

Previous literature about average passing networks has shown that they reveal information about the way a team is organized [50] and are also related with team performance [51]
- [50] López-Peña, J. & Touchette, H. A network theory analysis of football strategies. In C. Clanet (ed.), Sports Physics: Proc. 2012 Euromech Physics of Sports Conference, p. 517–528, Éditions de l’École Polytechnique, Palaiseau, (ISBN 978-2-7302-1615-9) (2012). 
- [51] Cintia, P., Rinzivillo, S. & Pappalardo, L. A network-based approach to evaluate the performance of football teams. In Machine Learning and Data Mining for Sports Analytics Workshop, Porto, Portugal (2015)


---

#### Classic Metrics vs Network Based Metrics

The authors produced Figure 2 which compaired 8 different parameters obtained for FCB and its rivals.

Four of them are classics, non-network metrics:
- (a) the number of passes L, 
- (b) the number of shots to goal $M_shots$
- (c) the number of goals $M_goals$ 
- (d) the number of points $M_points$ (at the end of the season)

All of these metrics no not require the construct of networks. Althoug hnumber of passes is technically an input to the network

The other 4 parameters of Fig. 2 are related to the spatial properties of the networks: 
- (e) x-coordinate of the network centroid 〈X 
- (f) y-coordinate of the network centroid 〈Y 
- (g) dispersion of the position of the players around the network centroid $NC_disp$  
- (h) average ratio between the passing distance parallel and perpendicular to the opponent’s goal 〈Δy〉/〈Δx〉. Obtained as the ratio between the total length 〈Δy〉 of the y-coordinate of all passes divided by the total length 〈Δx〉 of the x-coordinate, both distances in field units

*Direction x is towards the goal, while direction y is parallel to the opponents goal*

The figure plots a bar for each metric. The left for FCB and right for opponents

These are season wide metrics so the FCB is averaged with itself where as the opponsents are averaged across each team (19*2). This is justified because the goal is to observe differences between the FCB and all other teams.

As baseline, the stats show FCB pass much more than their opps which is refelctive of their tactical approach. 

The high number of passes unavoidably leads to passing networks with links that have higher weights and, as we will see, this fact will have consequences on the network parameters.

The 〈X〉 and 〈Y〉 average coordinates of all passes made during the match define the network centroid (or the network center of mass)

FCB played closer to the opponents goal (〈X〉FCB > 〈X〉rivals), while no differences are found at the〈Y〉coordinate indicating no preference for any of the sides of the pitch

the dispersion of the position of the players around the centroid (see Methods) is slightly higher for FCB, which indicates that the area covered by the initial position of the passes made by all players is wider 

the ratio of advance 〈Δy〉/〈Δx〉, which is an indicator of the direction of the passes of a team, since the Δy = y2 − y1 of a pass is the difference between the y-coordinates at the final (y2) and initial points (y1) of a pass, while Δx is defined, accordingly, for the x-coordinate.

FCB has a ratio of advance much higher than the rivals, which reveals that passes are more parallel to the opponent’s goal than the rest of the teams. 

Note that this metric is independent from the number of passes, and it is an indicator of how “direct” the game of a team is. Clearly, FCB is not concerned about advancing directly towards the goal, but on moving the ball in parallel, probably to find the most adequate moment to advance.

---

### Structural Network Metrics

#### Clustering coefficient
Clustering coefficient C, which is related to the amount of triangles  created between any triplet of players. 

Clustering coefficient is an indicator of the local robustness of networks [31], since when a triangle connecting three nodes (i.e. players) exists, and a link (i.e., pass) between two nodes is lost  (i.e., not possible to make the pass), there is an alternative way of reaching the other node passing through the  other two edges of the triangle.

In football, the clustering coefficient mesures the triangulation between three players.

The authors find Clustering is much higher in FCB. This reveals that connections between three players are more abundant than at their rivals.

#### Average Shortest Path
The average shortest path d is an indicator about how well connected are players inside a team.

It measures the “topological distance” that the ball must go through to connect any two players of the team.

Since the links of the passing networks are weighted with the number of passes, the topological distance of a given link is defined as the inverse of the number of passes

The higher the number of passes between two players, the closer (i.e., lower) the topological distance between them is

since it is the ball that travels from one player to any other, it is possible to find the shortest path between any pair of players by computing the shortest topological distance between them, no matter if it is a direct connection or if it involves passing through other players of the team.
> This is a good point and as the "path travelled" in football its the literal movement of the so it is easier to follow. Some examples, average shortest path is an abstract notion of how close or far apart entities are. Furthermore, nodes in football are not fixed, therefore, this has a unique interpretation. 

the average shortest path d of a team is just the average of the shortest path between all pairs of players

the shortest path of FCB is much lower than their rivals, which reveals that players are better connected between them. 

Note that this fact could be produced by the network organization or just being a consequence of having a higher number of passes, which reduces the overall topological distance of the links and, consequently, the value of $d$.

#### largest eigenvalue λ1 of the connectivity matrix A
comparison between the largest eigenvalue λ1 of the connectivity matrix A (also known 
as the weighted adjacency matrix), whose elements aij contain the number of passes between players i and j [31]

The largest eigenvalue has been used as a quantifier of the network strength [53] since it increases with the number of nodes and links
- Aguirre, J., Papo, D. & Buldú, J. M. Successful strategies for competing networks. Nat. Phys. 9, 230 (2013).

As expected (due to the high number of passes), the largest eigenvalue λ1 of FCB is much higher than the corresponding values of its rivals. This metric reveals the higher robustness of the passing network of Guardiola’s team, which indicates that an eventual loss of passes would have less consequences in F.C. Barcelona than in the rest of the teams

#### centrality
Fig. 3E-F show how centrality (i.e., the importance of the players inside the passing network) is distributed along the team, a metric calculated by means of the eigenvector related to the largest eigenvalue of the connectivity matrix

Figure 3E contains the average dispersion of centrality and Fig. 3F shows the highest value of a single player.

In both cases, differences are not statistically significant to support evidences of a different centrality distribution between FCB and the rest of the teams

---

### Temporal 

difference (in network properties) may be interpreted as a consequence of the higher number of passes between Barcelona players, which could lead to statistically significant differences in a diversity of network metrics, namely, a reduction of the average shortest path d and an increase of the clustering coefficient C, largest eigenvalue λ1 and algebraic connectivity λ2

In view of these results, two questions must be addressed before any interpretation: 
- (i) Is just the number of passes behind the differences of the network parameters? and 
- (ii) is it enough to look at the average values of the network metrics?

On the one hand, we are going to define passing networks as non-static entities, thus evolving in time, and we will track the evolution of their parameters. 

On the other hand, we are going to exclude the importance of the number of passes, in order to just focus on the topological organization of the networks. 

Note that 50-pass networks contain exactly the same number of passes for both teams and, thus, any difference between network metrics can not be attributed to the total number of passes. In addition, also note that metrics evolve in time and their values can be related to a certain moment of the match. However, it is also important to remark that the time required to construct a 50-pass network can differ from team to team.

---

### Discussion: What Networks tell us about FCB.

Ising Network Science to analyze football passing networks gives a new perspective that allows distinguishing between different teams and relating network properties to the teams particular style of playing

we have made use of these metrics to characterize the passing networks of Guardiola’s Barcelon

When passing networks are constructed as a simple addition of all passes made between players during the match, statistically significant differences between the passing networks of FCB and its rivals arise.
> This a good one for "Why apply networks" because it explains the utility of going from raw passes to networks

The clustering coefficient, the shortest-path, the largest eigenvalue of the connectivity matrix and the algebraic connectivity, always have “better” values in the Catalan team. The term “better” refers to the fact that differences in these network properties are related with a higher local resilience against the loss of passes (due to a higher clustering), a lower number of steps to connect any two players of the teams (due to a lower shortest-path length) and a higher connectedness between the whole team, as indicated by a higher largest eigenvalue of the connectivity matrix and a higher algebraic connectivity.

#### Looking Beyond Differences in Network Properties
number of passes made by FCB is fundementally much higher

advance ratio, measuring the percentage of distance that the ball advances parallel to the opponent’s goal is also much higher. note this is not related to num of pass and therefore not obvious impact on a network

But the number of passes has, indeed, crucial consequences on any quantitative analysis using Network Science.

The fact that we are comparing networks with the same number of nodes (eleven) but links with different weights (number of passes) has unavoidable consequences on the network parameters.

For example, since the “topological” distance between two directly connected players is given by the inverse of the number of passes between them, the higher the average number of passes of a team, the lower topological distance between their players.
> This honestly might be the key scope for the entire project. We need something beyond empricial data which can disentangle number of pass from network properties and null baseslines allow us to do that. 

Comparing the properties of two networks with different number of passes hinders the role played by the network topology itself, i.e., we can not say that a network is better organized, since we can not separate the effect of the number of passes (“quantity”) from that of the topology of the network (“quality”). 

### Results:

1. It is the team that requires the shortest time to construct 50-pass networks, and this time remains unaltered when scoring/receiving a goal
2. It is the team with the highest advance ratio (i.e., the team that plays the most horizontal to the opponent’s goal) and this metric is specially high before scoring a goal, 
3. The dispersion of the players around the network centroid is the lowest but significantly increases before receiving a goal
4. The clustering coefficient is higher when receiving goal than when a goal is scored
5. The shortest-path is one of the lowest and does not depend on scoring/receiving a goal, 
6. The largest eigenvalue of the adjacency matrix, measuring the strength of the network is the largest, and significantly increases before receiving a goal, 
7. The algebraic connectivity, measuring the cohesion between groups of players, decreases before receiving a goal (i.e., the interplay between groups is reduced), 
8. The highest centrality acquired by a single player and the centrality dispersion are the highest, which indicates that the importance of players in the FCB network is not evenly distributed, with one player, Xavi, being the hub of the passing networks.

---

### Average Limitations
Computing the parameters related to the average passing networks gives interesting, but limited, information about the way a team is organized.

---

### Metric Definitions

In general, the local **clustering coefficient** of a node i is obtained as the percentage of the nodes directly connected to it that, in turn, are connected between them. This measure can be averaged along the N nodes of the network to obtain the **average clustering coefficient**. However, when the network is weighted, we can not simply account for the number of nodes connected between them but, also, how the link weights are distributed. This is the case of passing networks, where the number of passes between pairs of players is not constant. In this way, we use the **weighted clustering coefficient** Cw(i) to measure the likelihood that neighbours of a given player i will also be connected between them [60]:
- Ahnert, S. E., Garlaschelli, D., Fink, T. M. A. & Caldarelli, G. Ensemble approach to the analysis of weighted networks. Phys. Rev. E
76, 016101 (2007).

$C_w(i) = \frac{\sum_{j,k} w_{ij} w_{jk} w_{ik}}{\sum_{j,k} w_{ij} w_{ik}}$  

where j and k are any two players of the team and wij and wik the number of passes between a third player i and both them. Finally, the clustering coefficient of the whole network is obtained by averaging Cw(i) over all players. Note that, the weighted version of the clustering coefficient characterizes the tendency of the team to form balanced triangles between players and it is a measure of local robustness.

---

In a passing network, the shortest path length d is the minimum number of players that  must be traversed by the ball to go from one player to any other. Since passing networks are weighted (i.e., the number of passes between players is different), we have to take into account the different weights of the links, considering that, the higher the weight, the shorter the topological distance between two nodes. 

The topological length $l_{ij}$ of the link between two players $i$ and $j$ is defined as the inverse of the link weight, $l_{ij} = 1/w_{ij}$

When computing d for weighted networks, the shortest-path length between a pair of players may not be a direct link, since there could exist a shorter path by combining two (or more) alternative links. Therefore, we compute the minimal shortest-path pij between all pairs of players using the Dijkstra’s algorithm [61]. Next, we define the average shortest path d of the whole team

$d = \frac{1}{N(N-1)} \sum_{i \neq j} p_{ij}$ 














