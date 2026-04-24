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

This isn't problem involving complex situtations. Instead it requires you to think about Graph Topology and Path Theory. 

The key area for this puzzle is **Eulerian Paths**. The goal is to trace out a path without "lifting the pencil" and covering each edge only exactly once. Another way to view this latter term is that once an edge is passed, it is turned off. 

The question is asking us to specific the conditions from which this goal is possible to achieve. 

There are only really to main parameters to look at Nodes and Edges. But we can combine the two by looking at Node Degrees. 

In the end, there should be a finding that revolves around how many "odd-degree" nodes a network can have if you want to cover it in one clean circuit. 

Within this question, it is important to think about "Complete Graphs" ($K_n$). We are asked about the "sum of all pairwise distances between all pairs of stakes." If a graph is complete, then there is a pair (edge) between every single node which the circuit needs to cover exactly onces. 

The worker’s goal is not just to connect the stakes (which a tree would do); his goal is to measure every single pairwise distance (the Complete Graph). This means that touching every node is simply not good enough, you needs to traverse every edge in the complete graph. If the graph was just a tree, the worker's logic ($A \to B \to C$) would work perfectly. Because it's a complete graph, it fails for almost all $N$.

There are few different things to know, or workout, in order to know if this problem can be acheived:
* How many edges are there in a "Complete Graph" of $N$ stakes?
* Can a single path (the rope) cover every one of those edges without overlapping?
* For what value of $N$ (number of stakes) does the math actually allow an Eulerian Path?

The question states "Pairwise distances between all pairs". This seems like a complicated phrase but pairwise is just a way to respresent as edge between two specific nodes. For example if you have 3 nodes $(A, B, C)$ the pairs are $AB$, $AC$, and $BC$ and the "sum" is $AB + AC + BC$.

Based on this small example where $N=3$, is we were to use a rope of length: $AB + BC$, then the rope does not measure the sum of all pairwise distances because it is missing $AC$. Though if we use a rope of length: $AB + BC + AC$ then it does but on the condition that it ends up where it started. 

Remeber, the rules are that the "rope" must be continuous, cover evey possible edge and cannot traverse the same edge twice. There isn't anything strictly that forbids it from ending up at the begining point but it will be interesting to see if is the only possible outcome. Note, that one specific thing to highlight is that if a route coverers $AB + BC$ then it touches all nodes but not all edges.

For $N=3$, we have established that we can use a single rope that measures the sum of all pairwise distances but it will end up at the start point. In graph theory this is known as a "circuit". If we end up at a different point than we started then we have a "Path".

A graph of $N=6$ has 6 pairwise distances to measure (the 4 sides of a square plus the 2 diagonals). Additionally all four nodes have degrees of 3, the same as the $N=3$ example. 

You cannot trace a four nodes graph if just one clean pass. This is known as the Eulerian Path rule. 

To trace a graph with one rope without overlapping, you look at the degree (number of connections) of each node:
* A graph can only be traced in one go if it has zero or exactly two nodes with an odd degree.
* This is because everytime you enter and leave a node, you use 2 connections. This means to satisfy all nodes, these ones have to be the start and/or end, otherwise, completing one if the middle will end the route as you will be trapped. 

The question asks "When is it possible...?" You are looking for the values of $N$ where a Complete Graph ($K_n$) has an Eulerian Path.

In a complete graph with $N$ nodes, every node has the same degree of $d = N - 1$.

Remeber we were able to get our $N=3$ example to work. Here, there were $3$ nodes where each had a degree of $2$ (Even). Does this mean even is an alternative requirement for this problem to be solved? (And therefore if $d = N-1$ then N needs to be odd)

1. Have exactly $2$ odd degree nodes.
2. Have only even degree nodes. 

If $N=2$, the degree is 1 (2 odd nodes — Works!)
If $N=3$, the degree is 2 (0 odd nodes — Works!)
If $N=4$, the degree is 2 (3 odd nodes — Doesn't Work)
If $N=5$, the degree is 4 (0 odd nodes — Works!)

With $N=5$ every node has a degree of $4$. This is important because it means every time the we enter a node we have an an "exit" path available that hasn't been used yet.

However, one thing to note is that with $N=5$ we again find ourselve in a situation where we end up atthe starting point creating a circuit. It is only when a graph has exactly two odd-degree nodes that where you can great a "path". With a complete graph this is only possible is $N=2$ so it is a bit of a secret rule to allow for this particular case. 

This means the conditions where is it possible to "measure the sum of the pairwise distances between all pairs of stakes, by using a single rope" is: 
* If $N=2$: The worker can tie to A and C. 
* If $N=$ any odd number (3, 5, 7...): It is possible to measure all distances, but the worker would have to tie both ends of the rope to the same stake (A to A), creating a circuit.

1. If $N=2$: A simple path works.
2. If $N$ is odd ($N \ge 3$): A circuit is required (the rope starts and ends at the same stake).
3. If $N$ is even ($N > 2$): It is impossible.

---
#### Does this carry over to non-complete graphs?
Yes, the Eulerian rules are universal laws of graph topology meaning the odd rule holds true.
* If there are 0 odd nodes you can complete a circuit but you must end up where you began. 
* If there are 2 odd nodes you must begin at one and end at the other. 
* If there are more than 2 odd nodes, it is physically impossible to cover every edge exactly once with one rope, regardless of how the nodes are positioned.

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





