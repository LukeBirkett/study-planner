# Week 1
A First Course in Network Science


# Week 2
#### Chapter 1(?)
#### [Scott L. Feld (1991) – Why Your Friends Have More Friends Than You Do](./files/week_2/Feld-FriendsFriends-1991.pdf)
This is the "Friendship Paradox" paper, tt is a sociology paper, not physics or math. Feld explains the sociological implications of the Mean Excess Degree. He demonstrates that because popular people (hubs) belong to more social circles, they are disproportionately represented when you look at anyone’s list of friends.


# Week 3 
Chapter 2


#### [Mixing patterns in networks](https://journals.aps.org/pre/abstract/10.1103/PhysRevE.67.026126)

This paper, "Mixing patterns in networks" (2003), was written by Mark Newman, one of the most influential figures in modern Network Science. If the Feld (1991) paper from Week 2 was the "sociology" behind the Friendship Paradox, this Newman paper is the "physics and math" behind why nodes choose specific types of partners.

This paper is the source of the **Assortativity Coefficient** ($r$). When you use `nx.degree_assortativity_coefficient(G)` in your lab, you are literally running the code for the formula Newman derived in this paper. He essentially took the **Pearson Correlation Coefficient** from statistics and "mapped" it onto graph theory.

Newman’s paper explains why some networks are more robust than others. He argues that assortative networks (where hubs link to hubs) are more resilient to accidental failure because the core of the network is so tightly "cliquey." In contrast, disassortative networks are fragile because if you remove the central hub, all the small "spokes" it was connected to immediately become disconnected from the rest of the world.

> It is recommended to skim the introduction and look at the tables but maybe not an entire read

---

#### [J. Travers & S. Milgram, An Experimental Study of the Small World Problem](https://www.jstor.org/stable/2786545?origin=crossref)

This is the famous "Six Degrees of Separation" study. While Stanley Milgram is often associated with it, this 1969 paper with Jeffrey Travers is the formal, data-heavy write-up of the experiment.

The paper describes a social experiment where "starter" individuals in Nebraska and Kansas were asked to send a folder to a "target" person (a stockbroker in Boston). The catch was that they could only send it to someone they knew on a first-name basis who they thought might be closer to the target.

#### Key Findings:
* **The "Six Degrees" Number:** Of the chains that reached the target, the average length was roughly 5.2 to 6.2 intermediate acquaintances.
* **The Completion Rate:** Interestingly, the majority of chains (about 80%) actually failed to reach the target. The "six degrees" only applies to the successful ones.
* **Social Homing:** People were surprisingly good at directed searching; they didn't just pass the folder randomly, they moved it toward the target’s geography or profession.
* **The Funnel Effect:** Many different chains ended up passing through the same few "super-connectors" (hubs) right before reaching the target.

This paper provides the empirical evidence for why we study Average Path Length ($\langle \ell \rangle$). It proves that even in a massive, uncoordinated social network, the "effective distance" between any two people is remarkably small. In your module, this acts as the real-world justification for the formula:

$$\langle \ell \rangle \sim \log N$$

It is recommended to read the "Results" and "Discussion" sections but skip the methodology. Use this paper to understand the human element of the "Small World" property. It bridges the gap between the Breadth-First Search (BFS) algorithm you are learning and how humans actually navigate social structures.

---

# Week 4
Book Chapter: 3

#### [F. A. Rodrigues, Network centrality: An introduction. (2019)]()
This is the source of the centrality visualizations in the notes. It is designed as a pedagogical (teaching) guide rather than a research paper. 

It provides a very clean, mathematical comparison of the "Big Four" centralities: Degree, Closeness, Betweenness, and Eigenvector. It explains the "Walk-based" vs. "Path-based" logic—essentially asking if importance comes from being on a shortest route or just being "near" important people.

It has some good graphs and visuals for the centrality measures but isn't work reading. 

---

#### [A. Saxena & S. Iyengar, Centrality Measures in Complex Networks: A Survey. (2020)]()
This is a massive, comprehensive catalog. It is much more technical and "computer-science" heavy than Rodrigues. 

It goes far beyond the basics. It covers centrality in Multilayer Networks (where nodes are connected in different ways, like being "friends" on Facebook but "colleagues" on LinkedIn) and Temporal Networks (where centrality changes over time). It also discusses the computational complexity (the $O$ notation) of calculating these measures. 

It is an excellent resource if you are writing a Master's dissertation and need to find a very specific, obscure metric, but for a weekly module, it will likely overwhelm you with too much information.

---

# Week 5 
Book Chapter: 4


#### P. Erdős and A. Rényi, "On Random Graphs I", Publicationes Mathematicae (1959).
In 1959, Erdős and Rényi defined a random graph by taking a fixed number of nodes ($N$) and a fixed number of edges ($M$), then choosing a graph uniformly at random from all possible graphs with those parameters. This is the $G(n, m)$ model.

At roughly the same time (1959), Edgar Gilbert proposed the model where every edge is chosen independently with a probability ($p$). This is the $G(n, p)$ model.


