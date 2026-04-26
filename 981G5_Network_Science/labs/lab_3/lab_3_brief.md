# Lab class 3 Exercise Sheet
Preliminary: If you haven’t completed last weeks’ lab class, I would suggest you do so. In particular, please make sure you have attempted the final question. If you have completed the worksheet, please proceed with the questions below.

1. [Question 1](#question-1)
2. [Question 2](#question-2)

---

# Question 1:
> On a construction site, some stakes have been hammered into the ground. As you watch, a worker ties a rope to one of the stakes and then runs it around another stake, some distance away, pulling it tight. When you ask the worker what they are doing, they say, ‘See, I need to run a cable from stake A over there, via stake B, here, to stake C all the way over there. So I tie this rope to A, wind it around B and then tie the end to C. This way I know how long a cable I need to buy.’ 
> 
> This makes you wonder: When is it possible to measure the sum of the pairwise distances between all pairs of stakes, by using a single rope in this way?

---

This isn't a problem involving complex situtations. Instead it requires you to think about **Graph Topology** and **Path Theory**. 

The key area for this puzzle is **Eulerian Paths**. The goal is to trace out a path without "lifting the pencil" and covering each edge only exactly once. Another way to view this latter term is that once an edge is passed, it is turned off. 

The question is asking us to **specific the conditions** from which this goal is possible to achieve. 

There are only really two main parameters to look at **Nodes** and **Edges**. But we can combine the two by looking at **Node Degrees**. 

In the end, there should be a finding that revolves around how many "odd-degree" nodes a network can have if you want to cover it in one clean circuit. 

Within this question, it is important to think about **"Complete Graphs"** ($K_n$). We are asked about the **"sum of all pairwise distances between all pairs of stakes."** If a graph is complete, then there is a pair (edge) between every single node which the circuit needs to cover exactly onces. 

The worker’s goal is not just to connect the stakes (which a tree would do); his goal is to measure every single **pairwise distance** (the **Complete Graph**). This means that touching every node is simply not good enough, you needs to traverse every edge in the complete graph. If the graph was just a tree, the worker's logic ($A \to B \to C$) would work perfectly. Because it's a complete graph, it fails for almost all $N$.

There are few different things to know, or workout, in order to know if this problem can be acheived:
* How many edges are there in a "Complete Graph" of $N$ stakes?
* Can a single path (the rope) cover every one of those edges without overlapping?
* For what value of $N$ (number of stakes) does the math actually allow an Eulerian Path?

The question states **"Pairwise distances between all pairs"**. This seems like a complicated phrase but pairwise is just a way to respresent as edge between two specific nodes. For example if you have 3 nodes $(A, B, C)$ the pairs are $AB$, $AC$, and $BC$ and the "sum" is $AB + AC + BC$.

Based on this small example where $N=3$, if we were to use a rope of length: $AB + BC$, then the rope does not measure the sum of all pairwise distances because it is missing $AC$. Though if we use a rope of length: $AB + BC + AC$ then it does but on the condition that it ends up where it started. 

Remeber, the rules are that the "rope" must be continuous, cover evey possible edge and cannot traverse the same edge twice. There isn't anything strictly that forbids it from ending up at the begining point but it will be interesting to see if is the only possible outcome. Note, that one specific thing to highlight is that if a route coverers $AB + BC$ then it touches all nodes but not all edges.

For $N=3$, we have established that we can use a single rope that measures the sum of all pairwise distances but it will end up at the start point. In graph theory this is known as a **circuit**. If we end up at a different point than we started then we have a **Path**.

A graph of $N=4$ has **6 pairwise distances** to measure (the 4 sides of a square plus the 2 diagonals). Additionally all four nodes have **degrees of 3**.

You cannot trace a four nodes graph if just one clean pass. This is known as the **Eulerian Path rule**. 

To trace a graph with one rope without overlapping, you look at the degree (number of connections) of each node:
* A graph can only be traced in one go if it has **zero or exactly two nodes** with an **odd degree**.
* This is because everytime you enter and leave a node, you use 2 connections. This means to satisfy all nodes, these ones have to be the start and/or end, otherwise, completing one if the middle will end the route as you will be trapped. 

The question asks "When is it possible...?" You are looking for the values of $N$ where a Complete Graph ($K_n$) has an Eulerian Path.

In a complete graph with $N$ nodes, every node has the same degree of $d = N - 1$.

Remeber we were able to get our $N=3$ example to work. Here, there were $3$ nodes where each had a degree of $2$ (Even). Does this mean even is an alternative requirement for this problem to be solved? (And therefore if $d = N-1$ then N needs to be odd)

### Two Conditions for Solvability
1. Have exactly $2$ odd degree nodes.
2. Have only even degree nodes. 

> * If $N=2$, the degree is 1 (2 odd nodes — Works!)
> * If $N=3$, the degree is 2 (0 odd nodes — Works!)
> * If $N=4$, the degree is 3 (3 odd nodes — Doesn't Work)
> * If $N=5$, the degree is 4 (0 odd nodes — Works!)

With $N=5$ every node has a degree of $4$. This is important because it means every time the we enter a node we have an an **exit path** available that hasn't been used yet.

However, one thing to note is that with $N=5$ we again find ourselve in a situation where we end up at the starting point creating a **circuit**. It is only when a graph has exactly **two odd-degree nodes** that where you can great a **path**. With a complete graph this is only possible is $N=2$ so it is a bit of a secret rule to allow for this particular case. 

This means the conditions where is it possible to "measure the sum of the pairwise distances between all pairs of stakes, by using a single rope" is: 
* **If $N=2$:** The worker can tie to A and C. 
* **If $N=$ any odd number (3, 5, 7...):** It is possible to measure all distances, but the worker would have to tie both ends of the rope to the same stake (A to A), creating a **circuit**.

> **If $N$ is even ($N > 2$):** It is impossible.

---
#### Does this carry over to non-complete graphs?
Yes, the Eulerian rules are universal laws of graph topology meaning the odd rule holds true.
* If there are 0 odd nodes (**i.e. all even nodes**) you can complete a **circuit** but you must end up where you began. 
* If there are **2 odd nodes** you must begin at one and end at the other creating a path. 
* If there are **more than 2 odd nodes**, it is physically impossible to cover every edge exactly once with one rope, regardless of how the nodes are positioned.

---

<br>
<br>
<br>
<br>
<br>

---

# Question 2:
> ---
>
> In this exercise, I want you to pick two networks from one of the repositories mentioned in the
first lecture. Make sure that these networks are from different domains:
> 
> ---
> 
> * **Social network** (e.g., Facebook, Twitter, or collaboration networks)
> * **Biological network** (e.g., Protein-protein interactions)
> * **Technological network** (e.g., Internet topology, power grid)
> 
> ---
> 
> * [ICON - Colorado Index of Complex Networks](https://icon.colorado.edu/)
> * [SNAP - Stanford Large Network Dataset Collection](https://snap.stanford.edu/data/)
> * [Network Repository. An Interactive Scientific Network Data Repository.](https://networkrepository.com/index.php)
> * [The KONECT Project](http://konect.cc/)
> * [BCT - The Brain Connectivity Toolbox](https://sites.google.com/site/bctnet/datasets-and-demos)
> * [STRING - Protein-Protein Interaction Networks](https://string-db.org/)
> * [BioGRID - Biological General Repository for Interaction Datasets](https://thebiogrid.org/)
> * [Aminer Citation and Co-Authorship Network](https://cn.aminer.org/data)
> * [CAIDA - Center for Applied Internet Data Analysis](https://www.caida.org/catalog/datasets/overview/)
> * [OSM - Open Street Maps](https://www.openstreetmap.org/query?lat=50.86734&lon=-0.08607)
> * [WIOD - World Input Output Database](https://www.rug.nl/ggdc/valuechain/wiod/)
> * [Movie Lens Dataset](https://grouplens.org/datasets/movielens/)
> 
> ---
> 
> Pick networks with roughly the same number of nodes. Preserving density here might not be particularly helpful so do feel free to pick networks of interest even if they have a very different number of edges for the same number of nodes
> 
> Download those two networks then write code to compute and visualize their k-core structure. What do you see and what does it tell you about those networks?
> 
> Next, write code to iteratively ‘attack’ the network such that at each iteration you delete a node, either picking it randomly or picking it according to some metric of your choice (e.g., degree is a common one but you could pick another one, e.g., betweenness centrality). At each iteration (including before the first removal), calculate the size of the largest connected component.
> 
> Plot the curve that shows the size of the largest connected component against the size of the network. Compare the curves when picking nodes at random vs picking nodes according to your metric. What does it tell you about the network? And how does that change depending on the network?
>
> ---

## Rewrite of Lab Steps
1. **Selection:** Choosing two networks (e.g., one Social and one Biological) from the provided repositories that have a similar number of nodes ($N$), even if their edge counts ($E$) differ.
2. **K-core Analysis:** Writing code to compute and visualize the $k$-shell/k-core decomposition (similar to the **Kitsak et al.** paper we summarized) to identify the "inner core" of each network.
3. **Robustness Testing (Attack Simulation):** Implementing an iterative node removal process. This involves two strategies:
    - **Random Attack:** Removing nodes at random (simulating failure).
    - **Targeted Attack:** Removing nodes based on a centrality metric like degree or betweenness (simulating a malicious attack).

> At each stage of the attack, including step 0 before any attacks, we need to track the size of the **Largest Connected Component (LCC)** in order to see how quickly the network fragments.

---

## Output Task: Plotting the LCC
Plot the curve that shows the size of the largest connected component against the size of the network. 
* Compare the curves when picking nodes at random vs picking nodes according to your metric. 
* What does it tell you about the network? 
* How does that change depending on the network?

> Plotting the LCC decay curves and interpreting what these results reveal about the resilience and topology of the two chosen domains (e.g., scale-free vs. random-like properties).

---

## Network Providers

### KONECT
The Koblenz Network Collection (KONECT) is a comprehensive, open-source project designed to facilitate systematic research in network science and web mining. Managed by the University of Koblenz–Landau, it hosts a massive repository of over 1,300 network datasets spanning diverse categories such as social networks, trust systems, and technological infrastructures.

What sets KONECT apart is its high level of pre-computed analytical depth; for nearly every dataset, the project provides interactive visualizations, degree distribution plots, and a vast array of graph statistics like clustering coefficients and diameter. This "batteries-included" approach allows researchers to evaluate the structural properties of a network directly on the website before downloading the raw data.

Furthermore, the project maintains a dedicated GNU Octave/MATLAB toolbox and a detailed **"Handbook of Network Analysis,"** making it an ideal pedagogical resource for mastering the transition from theoretical concepts to computational application.

* **Diverse Taxonomies:** There is a [categories page](http://konect.cc/categories/) which breaks down the broad topic of the 1300 networks. 
* **Pre-computed k-shell:** Since Question 2 asks for $k$-core structure, you can actually use the KONECT website to "preview" the $k$-shell plots for potential networks to ensure they show interesting features before you write your code.
* **Standardized Format:** Most datasets are available in a simple edge-list format, which works seamlessly with NetworkX in Python.

--

## Selecting A Network
The high-level approach in selecting two networks will be to select based on a pre-concieved notion of expected structure:

### Network A (Scale-Free):
A social or **citation** network These usually have **hubs** and are robust to random failure but very sensitive to targeted degree-based attack.

### Network B (Mesh or Grid-like):
A power grid or road network (infastructure). These are often more "homogeneous." The difference between a random attack and a targeted attack is much smaller here than in Network A.

---

## Evaluating/Scouting a Potential Network
1. **Node Count ($N$):** Look for $1,000$ to $10,000$ nodes. Anything smaller is too simple; anything larger might make the Betweenness Centrality code run for hours.
2. **Edge Count ($E$):** Check the density. A very sparse network might fragment too quickly to make a good plot.
3. **Format:** Look for `.edge`, `.csv`, or `.txt` (Edge Lists). These are the easiest to load into Python using NetworkX.

---

## Scale-Free Network: Bitcoin/Finance/Lending
Financial Networks, particularly modern tech-based ones, tend to mimic scale-free networks. For example, with respect to credit, there tends to be a naturally flocking to reputable entities. New people/entities looking for credit are more likely to connect with (and rate) these established hubs rather than a random node, i.e. just a person down the pub.This is a classic example of Preferential Attachment. Due to this, you will likely see a very high-degree "core" in the $k$-shell analysis of these networks. When you "attack" the network by removing high-degree hubs, the Largest Connected Component (LCC) will likely plummet rapidly, showing that the "credit-worthiness" of the entire system relies on a few key players. If you were modeling systemic risk in a banking network, you'd treat it as a scale-free network. You’d want to know: "If Lehman Brothers (a hub) fails, does the whole LCC collapse?"

In a FinTech ecosystem, a provider like Stripe (payments), Plaid (data aggregation), or AWS (infrastructure) acts as a high-degree hub. Hundreds of smaller "Neo-banks" or apps connect to these few hubs. This creates a scale-free structure that is very efficient but has a single point of failure: if Plaid's API goes down, thousands of independent apps lose their ability to function. An outage at one identity-verification API can "de-link" hundreds of fintechs from their customers, effectively "shattering" the connected market

### [Bitcoin OTC](http://konect.cc/networks/soc-sign-bitcoinotc/)
The Bitcoin OTC (Over-The-Counter) dataset is one of KONECT’s most famous "Web of Trust" networks, representing a who-trusts-whom system among users of the Bitcoin OTC marketplace. Because Bitcoin users are pseudonymous, this platform was created to allow traders to rate one another to mitigate the risk of fraud in peer-to-peer transactions.

> Source: S. Kumar, F. Spezzano, V.S. Subrahmanian, C. Faloutsos. [Edge Weight Prediction in Weighted Signed Networks](https://cs.stanford.edu/~srijan/wsn/). IEEE International Conference on Data Mining (ICDM), 2016.

#### Dataset Overview
* **Nodes:** 5,881 users (traders).
* **Edges:** 35,592 ratings.
* **Network Type:** Directed, Weighted, and Signed.
* **Domain:** Social / Trust & Financial.

#### Key Structural Features
* **Signed Weighted Edges:** Unlike simple "friend" networks, each edge carries a score from -10 (total distrust) to +10 (total trust). This makes it a rare example of a "signed" network where negative ties (distrust) are explicitly recorded. Approximately 89% of the ratings are positive.
* **The "Reputation Hub" Effect:** The network exhibits a strong scale-free degree distribution. In a credit-like environment, successful traders act as "hubs" with thousands of incoming positive ratings, while risky or new users have very few.
* **Temporal Nature:** Each rating is timestamped, allowing researchers to study how reputation evolves over time or how a "trust cascade" might form when a previously trusted hub is suddenly flagged as fraudulent.

Because it relies on a few highly reputable hubs to maintain the "integrity" of the marketplace, it is structurally robust to the random removal of users but extremely fragile to a targeted attack. If you remove the top 5% of the most-trusted hubs, the "connected component" of trust will likely shatter, as those hubs are the only bridges connecting different sub-communities of traders.

The resilience of the Bitcoin OTC network isn't just about connectivity; it’s about Opinion Dynamics. If the 'hubs' are removed, the 'Voter Model' of trust fails because there are no longer enough bridges to facilitate a consensus on who is a 'good' trader.

> Note, in a Directed graph, there is a difference between a "Weakly" and "Strongly" Connected Component. For this lab, using the Weakly Connected Component (treating edges as bidirectional) is usually the standard way to visualize fragmentation.

---





<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>



# why grid
n contrast, infrastructure networks (like the Power Grid or Internet Topology) are often more constrained by physical or logical distance.

Why it's "Grid-like": You can't connect a power station in New York directly to a house in London. Connections are expensive and physically limited. This results in a more "homogeneous" degree distribution—most nodes have a similar number of connections.

In your Lab: When you attack this network, the LCC will likely decay much more slowly. Because there aren't massive "hubs" holding everything together, removing one node doesn't isolate half the network. The random attack and targeted attack curves will often look much more similar to each other than they would in the Bitcoin network.

Operational Risk: If you were modeling the resilience of your payment API servers, you'd treat it as a technological grid. You’d want to know: "How many servers can fail randomly before our customers lose connectivity?"

This perspective on the "intertwined mesh" of FinTech is incredibly insightful because it highlights a shift from Institutional Risk to Structural Risk.

In traditional finance, we often looked at "too big to fail" banks (nodes with massive balance sheets). In FinTech, the vulnerability often shifts to "too connected to fail" providers (nodes with massive API traffic or critical data dependencies).

Mesh/Grid (The Interbank Network): Traditional interbank lending or settlement systems often look more like a mesh. Because banks have multiple redundant bilateral agreements to move money, the network can be more resilient to the failure of a single non-hub node.

On KONECT, look for categories like Infrastructure or Physical. A great counterpoint would be:
- Power Grid (e.g., US Power Grid): Very homogeneous.
- Open Street Maps (OSM) Road Networks: These are almost planar (2D), meaning hubs are physically impossible (a road intersection can't have 1,000 connections).

#### 1. US Power Grid (The Classic Choice)
* Nodes: 4,941
* Edges: 6,594
* Why it works: This is the gold standard for "non-scale-free" networks. It is a physical infrastructure network where most nodes (substations) have a very low degree (2 or 3). You won't find massive "hubs" like you did in Bitcoin OTC.
* Expectation: The LCC will decay very similarly for both random and targeted attacks because there are no "super-nodes" to target.

#### 2. Euro Road Network (The "Spatial" Choice)
- Nodes: 1,177 (Slightly smaller, but very "clean")
- Edges: 1,417
- Why it works: Roads are restricted by geography. An intersection can only have so many roads meeting at it. It is almost planar, meaning it looks like a literal grid.
- Expectation: High resilience to targeted attacks. Even if you "destroy" a major city intersection, there are usually bypasses and side-streets that keep the network connected.

#### Internet Topology (AS-733) (The "Technological" Choice)
- Nodes: ~3,000 to 6,000 (varies by timestamp)
- Edges: ~10,000+
- Why it works: This represents the Autonomous Systems (AS) that make up the internet. While it does have hubs, they are often governed by different rules than social hubs. It’s a great "middle ground" between a pure grid and a social network.

---


Computational Warning: You mentioned Betweenness Centrality. Just a heads-up: while Degree Centrality is instant, Betweenness takes significantly longer. If the code is slow, Degree Centrality is a perfectly valid and common metric for the "Targeted Attack" portion of this exercise.

1. Normalization: When you plot the LCC, plot the y-axis as the percentage of the original network size ($LCC / N_{original}$) and the x-axis as the percentage of nodes removed. This ensures that even if your two networks have slightly different $N$, their curves are directly comparable.
2. Centrality Dictionaries: For your targeted attack, compute your metric (like degree) once at the start of each iteration.

> Self-Correction: In a professional simulation, you'd "re-calculate" the degree of the remaining nodes after each removal, but for a lab, calculating the "Initial Degree Rank" once at the start is usually acceptable and much faster.

3. Visualization: For the $k$-core part, try color-coding the nodes by their $k$-shell index. In Bitcoin OTC, you should see a "dense nucleus" of high-reputation traders in the center.


