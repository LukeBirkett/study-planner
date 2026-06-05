

### Narizuka, T., Yamamoto, K. and Yamazaki, Y., 2014. Statistical properties of position-dependent ball-passing networks in football games. Physica A: Statistical Mechanics and its Applications, 412, pp.157-168.

We propose a method for creation of a position-dependent ball passing networks.

We find that the networks have the small-world property, and their degree distributions are fitted well by a truncated gamma distribution function.

 order to reproduce these properties of networks, a model based on a Markov chain is proposed.

---

A football game can be considered as a dynamical system in which game players interact with each other via one ball.

 statistical physics, analysis for complex networks has achieved rapid development recently [15,16]
- [15] D. J. Watts, S. H. Strogatz, Collective dynamics of “small-world” networks, Nature 393 (1998) 440–442.
- [16] A. L. Barab´asi, R. Albert, Emergence of scaling in random networks, Science 286 (1999) 509–512.

 the studies of the ball-passing networks [17, 18], each node and edge of the network represent an individual player and passing of the ball, respectively. One main conclusion in their studies is that ball-passing networks of football games have the **scale-free property**, namely the **degree distributions** follow the **power law**. However, in their network analysis, the total number of nodes were only 11, which was the number of players on a ground in one team. Clearly, it is too few to judge the power-law behavior of the degree distributions.
- [17] Y. Yamamoto, Scale-free Property of the Passing Behavior, International Journal of Sport and
Health Science 7 (2010) 86–95.
- [18] Y. Yamamoto, K. Yokoyama, Common and unique network dynamics in football games, PloS ONE 6 (2011) e29638.

 this paper we propose another method for creating a ball-passing network and report statistical properties of the network.

Since each player has his own role corresponding to their home position and it is important factor for ball passing, we create a position-dependent network. 

---

#### 2 Method for creating a ball-passing network

A “position-dependent” network of ball passing, where the position of a player in a soccer field is considered, was obtained by the following method.

 order to specify the position of a player, we divide the field into 18 areas (six areas along the goal direction, and three areas along the vertical
direction)

A node is assigned to a player on one of the 18 areas

The total number N of nodes for one team is 198 (= 18 × 11)

When one player passes the ball to another player in the game, two nodes corresponding to these two players are connected by an **undirected edge**.  If more than one passes are made between the same nodes, multiple edges are allowed. 

A ball-passing network is obtained as the set of the all passes made by one team in a game. To be precise, we use the following rules. (i) Only the passes between players belonging to the same team are considered. (ii) When a player is replaced by a reserved player, the node for the new player is given the same number as the old player.

We focus on the following basic properties characterizing the network structure: the **total number M of edges**, the **degree distribution** f(k), the **average degree** ⟨k⟩, **mean path length** ℓ, and **clustering coefficient** C.

The mean path length l is defined as the total average of d(i, j), which is the network distance from i to j. The clustering coefficient C is defined as the total average of Ci, which is the clustering coefficient for node i given as

$$C_i = \frac{T_i}{k_i(k_i - 1)/2}$$

Here k_i denotes the degree of node i, and T_i denotes the number of the triangles containing the node i.

#### 3 Analysis of real data

We find some nodes which have high degree. Actually, almost 20% of nodes have the degree larger than ⟨k⟩, and a few nodes in them have the especially large value. These nodes seem to be performed as “hub” in each network.

> NOTE: the construction of the PassMap paradigm used by this author is not that of the traditional Bludu 11 player PassMap network, instead it is more like a clustered plot of passes where the possible locations are standardized to 198 locations and therefore allowing for repeat passes to mapped and network properties to be computed. 

Network diagrams obtained from the game (iii). The darker edges represent higher frequency of passing. The yellow circle of each panel represents the hub node which has the maximum degree in the network

Characteristic values of each network are summarized in Table 2. The mean path length $ℓ$ and clustering coefficient $C$ are compared with $ℓ_rand$ and $C_rand$ of **random networks** having the same $N$ (Nodes) and $M$ (Edges); they were calculated by averaging over 1000 samples.

It is found that the sum of the edges of the two teams exists between 625 and 1008. Since the time of a football game is 90 minutes in typical, the time elapsing from one node receiving the ball and the node passing it to another is about 7 second in average

The mean path length $ℓ$ is about $3.3 ± 0.3$, and is close to $ℓ_rand$ = $4.4 ± 1.7$.

The clustering coefficient $C$ of each network is about ten times greater than that of random network $C_rand$.

Therefore, these ball-passing networks are considered to possess **small-world property**.

> NOTE: the author is constructing random networks using only the nodes (198 pitch positions) and using them to compare to the empirical networks to prove the existence of **small-world property**

> NOTE: I am getting the impress that pitch-passing models are probably the way to go here, rather than the traditional 11 node passing models. Though this will become more clear once I read the Bludu papers. 

##### 3.2 Degree distribution and Edge-multiplicity distribution

The cumulative degree distributions of the networks are shown in Fig. 4 with single logarithmic scale. The solid curves in each panel are truncated gamma distributions.

the curve exhibits powerlaw behavior in the low degree part, and exponential behavior in high degree part

The cumulative edge-multiplicity distributions of the networks are shown in Fig. 5 with single logarithmic scale. It is found that each distribution decreases almost exponentially. Then almost 70% of edges have multiplicity one i.e., single edges, and there are a few high multiple edges.

Each distribution is in good agreement with the truncated gamma distribution

#### 4 Modeling and numerical calculation

 the ball-passing network, the degree of each node represents the sum of the numbers of passing
and receiving. And the sum corresponds to the frequency of ball possession.

Actually, there are strong positive correlation between these two quantities, the degree and the ball possession frequency

Therefore, the **degree distribution** shown in section 3 can be interpreted as the distribution of ballpossession frequency.

 this section, we assume the sequence of ball passing as a random motion of a ball between nodes for simplicity. And, we try to reproduce the degree distribution by focusing on “ball-possession probability” with a Markov-chain model.

##### 4.3 Networks based on a transitive matrix

By determining Qα(rij ) and Rβ,ξ(Lj ), the ball-passing probabilities between all pairs of nodes are obtained. Using this probability, we can make a ball-passing sequence. Actually we created networks in the way that all pairs of ball-passing and receiving nodes were connected by an undirected edge.

Here, we focus on the networks of Spain, Holland, and North Korea in the real data. We created networks with the same M as these real networks.

It is found that the values of ℓ and C are in good agreement with those obtained from real networks where α, β, and ξ are given as shown in Table 6. This result suggests that the Markov-chain model can reproduce statistical properties of real data.

#### 5 Discussion

The main result of our numerical simulation is that G(a) obtained from our model can be fitted with the truncated gamma distribution as in the case of the degree distribution from the real data

 addition, we have also found that a network created from our model has similar structural properties to the real data. Judging from these results, we conclude that our model incorporates essential features of real football games.

We have also obtained the result that ν decreases monotonically against β.

When β is small, passes are made almost at random because the existence probability Rβ,ξ(Lj ) of each node has almost the same value. 

However, as β increases, areas where each player can move become limited. Namely, the number of nodes having small existence probability increases, and the peak of the distribution moves to the left as shown in Fig. 10. Such a change of the distribution corresponds to the decreasing of the value of ν in the truncated gamma distribution.

> NOTE: this appears to be demonstrating spatially aware model generation

> NOTE: I believe this is potentially following the same suit that my plan had suggested. The difference being that it is not generating passes on a per player basis and therefore cannot be formed in to the 11 node passing network but it is generating the adequate underlying data to possibly acheive this. It feels like there should be an adequate adjustment that allows for per player generation of similar data perhaps though the inclusion of formations. 

 the real data analysis, more detailed data may be obtained if we divide the field more finely. However, the number of passes is constant in one game, and the degree of each node becomes small when the division is more finely. Hence, it is difficult to discuss statistical properties of such networks. For our network analysis, 3 × 6 division seems to be suitable way of dividing the soccer field.

Our findings indicate that the degree distributions in the real data reflect the motion of each player which is characterized by Rβ,ξ(Lj)

In football games, each team tries to move the ball to the opponent goal in an efficient way. Then, each player moves around only his own home position, and passes the ball. Namely, this result shows the characteristics of football that each player has his own role corresponding to their home position. 

In the analysis of the real data, we have also examined the edge-multiplicity distribution, and found that almost 70% of edges have multiplicity one, and there are a few high-multiple edges. The low-multiple edges seem to correspond to passes which are made at random. On the other hand, the high-multiple edges are considered to correspond to the routine passes which are related to the strategies of each team. 

**Global properties**, such as **degree distribution** and edge-multiplicity distribution, of the ball-passing network are similar in different teams and games, but **local properties are different**.

In fact, the **degree distribution** of each team follows the same **distribution**, and the edge-multiplicity distribution decreases almost exponentially, while the heat maps of each team are different.

In this paper, we have mainly focused on the global properties of networks which do not depend on the details of the game.

And, the local properties which are related to the strategies of each team are also interesting.

> NOTE: seems to be implying that global properties are what represent football in network but the local properties are the tactical insights. In terms of generating null networks, it is the goal of reproducing the global properties allowing use to use the nulls as a baseline to assess local properties.

Yamamoto and Yokoyama have reported that ball passing forms a small-world network, and its degree distribution is described by the power-law, power-law with exponential cutoff, or the exponential distributions [17, 18].

Our position-dependent network is a natural extension of the networks in the previous ones.

Moreover, our analysis reveals that the degree distribution can be characterized by using the single distribution, truncated gamma distribution, while several distributions were used for fitting in the previous study.

We can readily obtain directed networks by considering the directions of passes. The directed network is expected to represent the defense and offense in football games

For modeling based on Markov chain, a more realistic model can be considered. For example, since each player mainly moves along longitudinal direction in real football games, some anisotropic effects should be introduced in Qα(rij ) and Rβ,ξ(Lj ).

From the viewpoint of network analysis, our model is associated with the spatial network [25], in which the nodes are distributed in a D-dimensional space with density ρ(x), and two nodes are connected by an edge whenever their distance is less than a given threshold value.


Our model resemble the spatial-network model, in that two nodes i and j can make a pass if their distance rij is less than α (see Eq. (10) of Qα(rij ) for reference); α works as the threshold.

The spatial-network model is deterministic, but our model involves a stochastic rule. We expect that statistical properties of the ball-passing network are analytically studied as “stochastic spatial network”.

##### 6 Conclusion

We have created the position-dependent network of ball passing in football games in this paper.

Each network has short path length ℓ ≈ 3.3 which is close to ℓrand ≈ 4.4, and high clustering coefficient C ≫ Crand

Degree distribution is fitted well by the truncated gamma distribution.

In the Markovchain model, we define the transition probability Pi→j as the product of the two factors for the distance of passes Qα(rij ) and for the existence probability of the player receiving a pass Rβ,ξ(Lj ).

The ballpossession probability distribution reproduces the truncated gamma distribution.

Also, it is found
that the network created by our model is similar to those from the real data.


===

# NEED TO READ 
- [17] Y. Yamamoto, Scale-free Property of the Passing Behavior, International Journal of Sport and
Health Science 7 (2010) 86–95.
- [18] Y. Yamamoto, K. Yokoyama, Common and unique network dynamics in football games, PloS ONE 6 (2011) e29638.
- [25] M. Barth´elemy, Spatial networks, Physics Reports 499 (2011) 1–101.




---

### Yamamoto, K. and Narizuka, T., 2021. Preferential model for the evolution of pass networks in ball sports. Physical Review E, 103(3), p.032302.










---

### Narizuka, T., Yamamoto, K. and Yamazaki, Y., 2015. Degree distribution of position-dependent ball-passing networks in football games. journal of the physical society of japan, 84(8), p.084003.











---

### Yamamoto, K., 2025. Pólya urn model for analysis of football passes. Physical Review E, 112(6), p.L062303.

===

"Polya’s Urn is the "conceptual bridge" between the general idea of **Preferential Attachment** and the formal **Barabási-Albert (BA)** model." (My lecture notes)

This study analyzes pass networks in football (soccer) using a stochastic model known as the Pólya urn.
By focusing on preferential selection, it theoretically demonstrates that the time evolution of networks can be
characterized by a single parameter. Building on this result, a data analysis method is proposed and applied to a
large-scale public dataset of professional football matches. The statistical properties of the preferential-selection
parameter are examined, demonstrating its correlation with pass accuracy and with mean pass difficulty. This
method is applicable to various evolving networks.



The time evolution of pass networks often reflects preferential selection, where players are more likely to attempt passes to teammates with whom they have previously completed multiple successful passes. These passes do not create new edges but rather increase the multiplicity of existing ones.

===

A stochastic model describing the emergence of new passes based on a mathematically simplified form of preferential selection was proposed [16]

> Yamamoto, K. and Narizuka, T., 2021. Preferential model for the evolution of pass networks in ball sports. Physical Review E, 103(3), p.032302.

===