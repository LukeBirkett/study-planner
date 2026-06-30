# 3. Methodology & Dataset Documentation
The technical blueprint. This fulfills your "Dataset Card" requirement if you are curating data.

> for some reason this section wasn't planned to have 'HOW' Network Science. Instead that was planned for the lit review. Perhaps the lit review needs an introduction to the various ways networks can be applied to football, i.e. the types of iteractions, as well as establishiing that there needs to be a spatial compoennt for any representation, i.e. the location of the nodes is a key properties. The lit review is where Bludu and his foundational pricipals will be introduced by 3. Methoolody is where we explain the PassMap in details, i.e all of its part and the mathds, as well as how we plan to implement it given the specific data source. 

This report will conceptually be split into 2 parts. The first is curtailed within the methodology. It is a deep dive into the way that we will apply networks science into football. We will introduce the dataset to be used, the network framework we will be adopting and applying and then walking through the way the network properties can be extracted from our network and interpretted in footballing term, i.e. what is a node, what a triangle (cluster/clique) represents, what the different centrality measures are. 




The first part of this paper (part 3) will work through the various ways a PassMap network can be analysed using Network Science techniques and properties. 

This will be demonstated using real data from statsbomb. 


---

## 3.1 Data Source and Preprocessing
*[Data Source: Statsbomb], [Interactions Types (Edges)]*

Formal description of the StatsBomb event data, coordinate system, and edge definitions (e.g., event filtering criteria).

Statsbomb is a football data company which gives back to the analytics commmunity by releasing community accesible data repositories. This data is known as events data where each row...
- TODO: fill this in later. Datacard info also

As noted in Alves, there is clear overrepresentation in the liturature for mens etc. Therefore, we are using womens data for [comp] and [seasons]

---

In football, nodes represent players, of which there are generally 11 per team and 22 on the pitch into total (excluding sendings offs and injuries). Edges represent some form of interaction between players and/or oppenents. The strength (weight) is the total volumne of the interactions.

---

## 3.2 The PassMap Framework
*[PassMap Framework]*

Define the mathematical formulation of your graph (Directed, Weighted Multigraph $G = (V, E, W)$). Define how standard metrics (Degree, Clustering, Centrality) map onto footballing concepts.

---

PassMap Framework:
- Bludu
- A PassMap is a directed and weighted network

> the passmap will have been introduced in the lit review but this is the oppurtunity to apply a deep dive to the network. It is a demonstation of how we will be taking the passmap frame work and ppalying it to our data and project

--- 

## 3.3 Network Properties and Football Interpretation
*[Network Properties and Football Interpretation]*

Now that we have established the creation of a network: Network Properties and Football Interpreation

> Not much time has gone into determining the sections here or the content within them. This will become much clear after working through the reading list. That will also allow time to pick up a lot of direct references to either quote or structure the sections around. 

- **Degree Centrality**: A player's ball involvement.
- **Closeness/Proximity**: A player's accessibility for a pass. This is most important for constructing an effictive null model. 
- **Betweenness Centrality**: A player's role as a "bridge" (e.g., a central defensive midfielder connecting the defense to the attack).
- **Clustering**: Tactical triangles and localized support play. Important to define what a triangle is in football. e.g. a > b > c > a, or just any order. Volumne causing clustering without an tactical influence so want to mitigate this. 
- The **degree distribution** can be thought of in terms of tactics and formation. If the degree distribution is **homogenous** then most, or all players, have a similar degree, implying a decentralised system. Think about total football systems like Ajax or prime Barcelona, if 1 player is cut off the passing triangles do not stop, they friend a way through with a different cluster of players.
- Despite being small networks, we can stil see the emergence of **heavy-tails** though the prominence of playmakers and possesion retainers. A **"Hub-and-Spoke"** distribution is a common emergence in teams with a high influential central-midfielder. This node has massive degree/strength compare to the rest of the nodes. 
- Due to the constraints of the network size, they cannot be scale-free as this requires $N \to \infty$ and a power-law $k^{-\gamma}$. But they can obtain **small-world** properties. Small-wordness calculated by comparing the **average path length $L$** and the **clustering coefficent** against a random random of the same size, and/or properties as mentioned before. 
- **Degree assortativity** is a natural progression topic from these points. If high degree players are **disassorative** they mostly pass to players so themselves are less connected. This is indicative of the hub-and-spoke network where a highly influential player can connection directly different areas of the pitch. It is also in interest point to consider which are the low degree players in this scenario. 
- Typically, over the course of a full match, the network (passing) will be a fully conntected graph, i.e. **one giant components**, as throughout the match there will likely be at least 1 pass/interaction between players. However, analysis on the **largest connect component** can be unvieled using a **thresholding** approach, or **temporal** phases where a 10 minute phase might see play concentrating in certain areas or amongst particular nodes. Refering back to the notion of comparing teams, it would be interesting to see how different thresholds affect each team. Resilient, balances teams may retain their largest compents even as the threshold raises but a fragile team will soon begin to fragment - then these fragments because they represent intra-team cliques. Where do the connection remain even as things are getting difficult and falling apart. 


### Micro, Meso and Macro Focuses:
Alve's "Systematic Review" determines there to be 3 levels of metric in apply networks to football: Micro, Meso and Macro. 

SNA analyses typically focus on three distinct levels: micro (individual player metrics), meso (small groups of players), and macro (the entire team’s network) (Buldú et al., 2018)

> This is very football specific. Maybe introduce this at the start of 3.3. and then break properties down into each category. This will probanly work itself out with more research

---










====

To build an actual Network Science project for football, you have to treat it as a spatially embedded network (Buldú et al., 2018)

To build an actual Network Science project for football, you have to treat it as a spatially embedded network (Buldú et al., 2018). In these systems, nodes have physical coordinates $(x,y)$, and the probability of an edge existing is heavily influenced by the Euclidean distance between those coordinates.

**The Temporal/Dynamic Network (Evolution):** Build networks for each match (or segment) and extract the relevant properties. Track how the metrics develop over time. The way the networks change and therefore the metric change can be analysed and explained from a football/tactical perspective. A common approach is windowing where you compute the average of something, say a team's Clustering Coefficient to see if tactical discipline spikes or dips during a losing streak.

**The "Ensemble" Network:** You could ensemble all matches from a teams seasons into one super network. This essentially creates a probability map of how a team functions - and you could frame this as a managers tactical outputs. From this you could ask "what is the teams backbone?". The supernetwork itself will be an uniterpretable hairball as all players will likely have made a pass to eachother in some way, including all swud players. You use Disparity Filter (Salience Network) to strip away the statistically insignificant edges and reveal the "Multiscale Backbone"—the core passing lanes that persist regardless of the opponent.