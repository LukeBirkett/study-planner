# 3. Methodology & Dataset Documentation
The technical blueprint. This fulfills your "Dataset Card" requirement if you are curating data.

---

## 3.1 Data Source and Preprocessing
*[Data Source: Statsbomb], [Interactions Types (Edges)]*

Formal description of the StatsBomb event data, coordinate system, and edge definitions (e.g., event filtering criteria).

---

The first part of this paper will work through the various ways a PassMap network can be analysed using Network Science techniques and properties. 

This will be demonstated using real data from statsbomb. 

Statsbomb is a football data company which gives back to the analytics commmunity by releasing community accesible data repositories. This data is known as events data where each row...
- TODO: fill this in later. Datacard info also

As noted in Alves, there is clear overrepresentation in the liturature for mens etc. Therefore, we are using womens data for [comp] and [seasons]
- TODO: scope this out with correct quotes

---

In football, nodes represent players, of which there are generally 11 per team and 22 on the pitch into total (excluding sendings offs and injuries). Edges represent some form of interaction between players and/or oppenents. The strength (weight) is the total volumne of the interactions.

--- 

- List though different types of interactions seen in researach (pass, def, etc)
- Mentioning mutli-layer networks
- Introduce the PassMap framework, Bludu
- Discuss the spatial compoenent
- Conclude that we will be moving forward with a pass based paradigm
- Mention that Alves highlight less dominant areas

---

## 3.2 The PassMap Framework
*[PassMap Framework], [Network Properties and Football Interpretation]*

Define the mathematical formulation of your graph (Directed, Weighted Multigraph $G = (V, E, W)$). Define how standard metrics (Degree, Clustering, Centrality) map onto footballing concepts.

---

PassMap Framework:
- Bludu
- A PassMap is a directed and weighted network

--- 

Now that we have established the creation of a network: Network Properties and Football Interpreation

- **Degree Centrality**: A player's ball involvement.
- **Closeness/Proximity**: A player's accessibility for a pass. This is most important for constructing an effictive null model. 
- **Betweenness Centrality**: A player's role as a "bridge" (e.g., a central defensive midfielder connecting the defense to the attack).
- **Clustering**: Tactical triangles and localized support play. Important to define what a triangle is in football. e.g. a > b > c > a, or just any order. Volumne causing clustering without an tactical influence so want to mitigate this. 
- The **degree distribution** can be thought of in terms of tactics and formation. If the degree distribution is **homogenous** then most, or all players, have a similar degree, implying a decentralised system. Think about total football systems like Ajax or prime Barcelona, if 1 player is cut off the passing triangles do not stop, they friend a way through with a different cluster of players.
- Despite being small networks, we can stil see the emergence of **heavy-tails** though the prominence of playmakers and possesion retainers. A **"Hub-and-Spoke"** distribution is a common emergence in teams with a high influential central-midfielder. This node has massive degree/strength compare to the rest of the nodes. 
- Due to the constraints of the network size, they cannot be scale-free as this requires $N \to \infty$ and a power-law $k^{-\gamma}$. But they can obtain **small-world** properties. Small-wordness calculated by comparing the **average path length $L$** and the **clustering coefficent** against a random random of the same size, and/or properties as mentioned before. 
- **Degree assortativity** is a natural progression topic from these points. If high degree players are **disassorative** they mostly pass to players so themselves are less connected. This is indicative of the hub-and-spoke network where a highly influential player can connection directly different areas of the pitch. It is also in interest point to consider which are the low degree players in this scenario. 
- Typically, over the course of a full match, the network (passing) will be a fully conntected graph, i.e. **one giant components**, as throughout the match there will likely be at least 1 pass/interaction between players. However, analysis on the **largest connect component** can be unvieled using a **thresholding** approach, or **temporal** phases where a 10 minute phase might see play concentrating in certain areas or amongst particular nodes. Refering back to the notion of comparing teams, it would be interesting to see how different thresholds affect each team. Resilient, balances teams may retain their largest compents even as the threshold raises but a fragile team will soon begin to fragment - then these fragments because they represent intra-team cliques. Where do the connection remain even as things are getting difficult and falling apart. 

**Micro, Meso and Macro Focuses:** Alve's "Systematic Review" determines there to be 3 levels of metric in apply networks to football: Micro, Meso and Macro. 

SNA analyses typically focus on three distinct levels: micro (individual player metrics), meso (small groups of players), and macro (the entire team’s network) (Buldú et al., 2018)

> Could bring this in during exploring the properties as subheadings. 
> 
> Or could attempt to introduce it during the final analysis phases, maybe scoping down to produce an experiement for each level. 
> 
> It might be a nessecity for the null model validation, if so it would have be to be introduced in the "how" level
> 
> Or even just both, it will likely manifested itself as connective tissue for structure and writting rather than a section to explain. 

---