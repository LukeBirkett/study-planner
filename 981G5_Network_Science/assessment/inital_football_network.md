
## Basic Introduction to Football Netowrks
Football (passing) netowrks are small but dense. The interest is in the dynamics and iteractions rather than the volumne of nodes - which is almost fixed. 

Approaches in sport move beyond descriptions and focus on comparisions. Teams approaches and tactics are reflected in their networks, whether that be because they are high structures or perhaps highly chaotic, direct team. 

Null models are highly effective in football - e.g. Erdős–Rényi or Configuration Model - because the networks themselve shave the benefit of being highly interpretable by looking. The number of nodes is generally fixed and the edges are limited in their variation. Therefore, providing analysis on why a randomly generated model differs to the team you are analysing is a good start. Discussion why a particular teams network properties, like high clustering, is a statistically significant and not just a result of random chance, it easy conducted high generating Null Models. 

A slightly more complex network network but naturally sports networks have interesting Temporal Dynamics. The network will evolve and change during different phases of the match. It is important to look at properties with respect to succesful. E.g. during such periods, how did given centrality measures change. 

---

## Network v Football Basic Translations:
The **degree** is the teamates a player interacts with and the **strength** (weight) would be the total volumn of the interactions. The most common and intuative version is passing networks. 

The **degree distribution** can be thought of in terms of tactics and formation. If the degree distribution is **homogenous** then most, or all players, have a similar degree, implying a decentralised system. Think about total football systems like Ajax or prime Barcelona, if 1 player is cut off the passing triangles do not stop, they friend a way through with a different cluster of players. 

Despite being small networks, we can stil see the emergence of **heavy-tails** though the prominence of playmakers and possesion retainers. A **"Hub-and-Spoke"** distribution is a common emergence in teams with a high influential central-midfielder. This node has massive degree/strength compare to the rest of the nodes. 

Due to the constraints of the network size, they cannot be scale-free as this requires $N \to \infty$ and a power-law $k^{-\gamma}$. But they can obtain **small-world** properties. Small-wordness calculated by comparing the **average path length $L$** and the **clustering coefficent** against a random random of the same size, and/or properties as mentioned before. 

**Degree assortativity** is a natural progression topic from these points. If high degree players are **disassorative** they mostly pass to players so themselves are less connected. This is indicative of the hub-and-spoke network where a highly influential player can connection directly different areas of the pitch. It is also in interest point to consider which are the low degree players in this scenario. 

Typically, over the course of a full match, the network (passing) will be a fully conntected graph, i.e. **one giant components**, as throughout the match there will likely be at least 1 pass/interaction between players. However, analysis on the **largest connect component** can be unvieled using a **thresholding** approach, or **temporal** phases where a 10 minute phase might see play concentrating in certain areas or amongst particular nodes. Refering back to the notion of comparing teams, it would be interesting to see how different thresholds affect each team. Resilient, balances teams may retain their largest compents even as the threshold raises but a fragile team will soon begin to fragment - then these fragments because they represent intra-team cliques. Where do the connection remain even as things are getting difficult and falling apart. 

---

## Using Null Models in Football:
- Take an **Erdős–Rényi (Random) Null Model** and treat it as the zero intelligence baseline. It can be construct with the same number of nodes and edges as a team or match you are analysing. Compare the Average Path Length of the real network to the null.
- Use a **configuration model** for degree preserving randomization. Take a teams network and rewire the edges. Need the pass totals the same which switch the connections making them. Compare **assortativity** are rewiring many versions. If the team becauses less assortive then maybe the real team contains a strong spine of players that constantly interact and keep the team together. It is not enough to have a 11 players to make X number of pass per match, the connections are more important. Alterantively, if you are able to match metrics between real and nulls, then that demonstrates that something isn't down to some tactic genuis, it is a byproduct of the game/match. 
- Football is played on a 2d plane. It make sense that players closer together are more likey to be connected. An interesting experiement would be to create a null model where the probability of an edge existing betwen two players is function of their average distance on the pitched. Apparently this is called a gravity model. By comparing teams networks to this baseline we can infer statistically signifcant links between players, if a a strong link appears to defies the natural geometry of the pitch.

---

## PassMap: Directed and Weighted Network
A PassMap is a directed and weighted network. This makes null models, config models and "swapping" edges a little more complex. We want to preserve the topology (connections) and the weight distribution (amount of passes). In football, not all connections are made equal. The fact a connect exists is important but the weight, or lack there of is even more important. 

An interesting experiment because be weight-shuffling. You need the skeleton of connections the same but extract all of the "weight" into a bucket. this can be then distributed across the existing skelton nodes/edges. Doing so builds up the probabilty distributions, if a random network tends to build up weight in a certain coridor then that is a function of the topology and structure, not the specific talent of the players. 

Configuration modelling also becomes much more complex in a directed weighted setting. The appraoch is to use the half-edge method. In terms of stubs each node as two types of connectors. The out-stubs representing the passes they made, i.e. the out-degrees. The in-stubs representing every pass they received, i.e. in-degrees. Plays have their pre-detmined statistics, 60 passes made = 60 outstubs, 10 recieved means 10 in-stubs. To build the config model you work on building out the stored weight. 

Once this has been completed, you have a null model, infact you will run in 100s or 1000s of times to produce many networks. This can be used to measure tacitcal intent. For example, you calculate the clustering coefficient, which is the tendency for players to form passing triangles. A highly structured team that you are looking at may have a high clustering of $0.6$. If the randomized stub networks have an average clsutering of $0.2$ then we can prove that the passing triangles in the team are the result of cumulative passes, as we kept the same number of passes in the null model, they are a deliverate structural feature of the managers tactics. The null models proved that the number of given passes didn't need to form passes, but in the team network they did. 

---



# TODO; reword

"Translating Graph Theory to the Pitch." Use the papers above to show you understand that:
1. **Degree Centrality** = A player's ball involvement.
2. **Closeness/Proximity** = A player's accessibility for a pass.
3. **Betweenness Centrality** (often mentioned in broader SNA football literature) = A player's role as a "bridge" (e.g., a central defensive midfielder connecting the defense to the attack).
4. **Clustering** = Tactical triangles and localized support play.

*A common critique from pure network scientists looking at sports research is that many papers report raw metrics (like density or clustering) without a mathematical baseline.*


**Why do we need null models**
Imagine Team A makes 600 passes vs 300 for team B. Team A will have a higher density and probably more triangles (clustering) due to volume and probability. Raw numbers therefore arent comparing tactical structure. Just measuring volume.

To determine is the density and clustering acheived at 600 passes was unique, you need to compare it to a baseline which also includes 600 passes. This is where null/random models come in. The question is, does any team that passes 600 times naturally acheive the same level of density and clustering. 

---