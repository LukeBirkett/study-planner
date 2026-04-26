Note that in directed networks, the average outdegree equals the average indegree, and both are equal to m/n.

The fill of a network is the proportion of edges to the total number of possible edges. The fill is used as a basic parameter in the Erd ̋os–R ́enyi random graph model (Erd ̋os & R ́enyi 1959), where it denotes the probability that an edge is present between two randomly chosen nodes, and is usually called p, which is the notation we also use in KONECT.

In a directed network, the reciprocity equals the proportion of edges for which an edge in the
opposite direction exists, i.e., that are reciprocated (Garlaschelli & Loffredo 2004).

The reciprocity has also been noted r (e.g. Szell et al. 2010). The reciprocity can give an idea of the type of network. For instance, citation networks only contain only few pairs of papers that mutually cite each other. On the other hand, an email network will contain many pairs of people who have sent emails to each other. Thus, citation networks typically have low reciprocity, and communnication networks have high reciprocity.

---

Connectivity statistics measure to what extent a network is connected. Two nodes are said to be connected when they are either directly connected through an edge, or indirectly through a path of several edges. A connected component is a set of vertices all of which are connected, and unconnected to the other nodes in the network. The largest connected component in a network is usually very large and called the giant connected component. When it contains all nodes, the network is connected

The relative size of the largest connected component equals the size of the largest connected component divided by the size of the network

We also use an inverted variant of the relative size of the largest connected component, which makes it easier to plot the values on a logarithmic scale

In directed networks, we additionally define the size of the largest strongly connected component cocos Ns. A strongly connected component is a set of vertices in a directed graph such that any node is reachable from any other node using a path following only directed edges in the forward direction.
We always have Ns ≤N.

---

The distance between two nodes in a network is defined as the number of edges needed to reach one node from another, and serves as the basis for a class of network statistics.

For instance, the well-known characterisation of networks as having the small-world property by Watts and Strogatz (1998) implies that distances between nodes in networks are typically short.


A path in a network is a sequence of incident edges, or equivalently, a sequence of nodes P =
(u0,u2,...,uk), such that (ui,ui+1) ∈E for all i ∈{0,...,k−1}. 

The number k is called the length
of the path, and will also be denoted l(P). 

In the case that a network is not connected, the distance is defined as infinite. In practice, only the largest connected component of a network may be used, making it unnecessary to deal with infinite values.

The eccentricity of a node can then be defined as the maximal distance from that node to any other node, defining a measure of non-centrality

The diameter δ of a graph equals the longest shortest path in the network (Newman 2003b). It can be equivalently defined as the largest eccentricity of all nodes.

Note that the diameter is undefined (or infinite) in unconnected networks, and thus in numbers reported for actual networks in KONECT we consider always the diameter of the network’s largest connected component.

The mean path length δm in a network is defined as as the mean distance over all node pairs, including the distance between a node and itself (Newman 2003b)

---

The distribution of degree values d(u) over all nodes u is often taken to characterize a network. Thus, a certain number of network statistics are based solely on this distribution, regardless of overall network structure. 

The simplest network statistics that depend only on the degree distribution are the number of nodes n, the number of edges m and the average degree d = 2m/n

The power law exponent is a number that characterizes the degrees of the nodes in the network.

In many circumstances, networks are modeled to follow a degree distribution power law, i.e., the number of nodes with degree n is taken to be proportional to the power n−γ, for a constant γ larger than one (Barab ́asi & Albert 1999). This constant γ is called the power law exponent. Given a network, its degree distribution can be used to estimate a value γ.

There are multiple ways of estimating γ, and thus a network does not have a single definite value of it. In KONECT, we estimate γ using the robust method given in (Newman 2006, Eq. 5)

The analysis of degrees can be generalized to pairs of nodes: What is the distribution of degrees for pairs of connected edges? In some networks, high-degree nodes are connected to other high-degree nodes, while low-degree nodes are connected to low-degree nodes. This property is called the degree assortativity (Newman 2003a), or, very often, simply the assortativity.

Inversely, in a network with dissortativity, high-degree nodes are typically connected to low-degree and vice versa.

The amount of assortativity can be measured by the Pearson correlation ρ between the degree of connected nodes.

In directed networks, we define the in-out assortativity as the Pearson correlation coefficient between in-degree and the out-degree of nodes, taking the logarithm of one plus the degree.

--- 

The term preferential attachment refers to the observation that in networks that grow over time, the probability that an edge is added to a node with d neighbors is proportional to d.

This linear relationship lies at the heart of Barab ́asi and Albert’s scale-free network model (Barab ́asi & Albert 1999), and has been used in a vast number of subsequent work to model networks, online and offline.

The scale-free network model results in a distribution of degrees, i.e., number of neighbors of individual nodes, that follows a power law with negative exponent. In other words, the number of nodes with degree d is proportional to d^−γ in these networks, for a constant γ > 1.

In basic preferential attachment, the probability that an edge attached to a vertex u is propertional to its degree d(u). 

The exponent β is a positive number, and can be measured empirically from a dataset (Kunegis et al. 2013). The value of β then determines the type of preferential attachment:
1. **Constant case β = 0.**: This case is equivalent to a constant probability of attachment, and thus this graph growth model results in networks in which each edge is equally likely and independent from other edges. This is the Erd ̋os–R ́enyi model of random graphs (Erd ̋os &
R ́enyi 1959).
2. **Sublinear case 0 < β < 1**: In this case, the preferential attachment function is sublinear. This model gives rise to a stretched exponential degree distribution (Dereich & M ̈orters 2009), whose exact expression is complex and given in (Dorogovtsev & Mendes 2002, Eq. 94).
3. **Linear case β = 1.** This is the scale-free network model of Barab ́asi and Albert (Barab ́asi & Albert 1999), in which attachment is proportional to the degree. This gives a power law degree distribution.
4. **Superlinear case β > 1.** In this case, a single node will acquire 100% of all edges asymptotically (Rudas et al. 2007). Networks with this behavior will however display power law degree distributions in the pre-asymptotic regime (Krapivsky & Krioukov 2008).

---

The term clustering refers to the observation that in almost all networks, nodes tend to form small groups within which many edges are present, and such that only few edges connected different clusters with each other.

In a social network for instance, people form groups in which almost every member known the other members.

As an example, the well-known characterisation of networks as having the small-world property by Watts and Strogatz (1998) uses the clustering coefficient as one network statistic, and states that it will be particularly small.

The main method for measuring clustering numerically is the **clustering coefficient**, of which there exist several variants.

As a general rule, the clustering coefficient measures to what extent edges in a network tend to form triangles. Since it is based on triangles, it can only be applied to unipartite networks, because bipartite networks do not contain triangles.

The number of triangles t itself as defined in Section 4.2 is however not a statistic that can be used to measure the clustering in a network, since it correlates with the size and volume of the network.

Instead, the clustering coefficients in all its variants can be understood as a count of triangles, **normalized in different ways** in order to compare several networks with it.

The **local clustering coefficient** c(u) of a node u is defined as the probability that two randomly chosen (but distinct) neighbors of u are connected.

The global clustering of a network can be computed in two ways. The first way defines it as the probability that two incident edges are completed by a third edge to form a triangle (Newman et al. 2002). This is also called the transitivity ratio, or simply the transitivity.

This variant of the global clustering coefficient has values between zero and one, with a value of one denoting that all possible triangles are formed (i.e., the network consists of disconnected cliques), and zero when it is triangle free. 

The second variant variant of the clustering coefficient uses the average of the local clustering coefficients. This second variant was historically the first to be defined. In was defined in 1998 (Watts & Strogatz 1998) and precedes the first variant by four years.

This second variant of the global clustering coefficient is zero when a graph is triangle-free, and one when the graph is a disjoint union of cliques of size at least three.

A slightly different definition of the second variant computes the average only over nodes with a degree of at least two, as seen for instance in (Bansal et al. 2008).

Because of the arbitrary decision to define c(u) as zero when the degree of c is zero or one, we recommend to use the first variant of the clustering coefficient. In the following, the extensions to the clustering coefficient we present are all based on the first variant, c

> In an undirected graph, clustering is easy: if A is friends with B and C, what is the probability B and C are also friends? It just looks for completed triangles.
> 
> However, in a directed graph (like your Bitcoin OTC network), we care about the "flow" of trust. The KONECT handbook is describing Transitive Clustering. Here is the breakdown of those terms:
> 
> #### 1. What is a "Directed 2-Path"
> Imagine a chain of three nodes where the arrows all point in the same direction:Node A $\rightarrow$ Node B $\rightarrow$ Node CThis is a "directed 2-path" because you can get from A to C by following two edges in order. In your fintech context, this is like A trusting B, and B trusting C.
> 
> #### 2. "Closed by a directed edge with the same orientation"
> For this path to be "clustered" or "closed," there must be a direct shortcut from the start to the finish that follows the same flow:
> Node A $\rightarrow$ 
> 
> Node CIf this third edge exists, you have a Transitive Triangle. It signifies that trust is "consistent"—A doesn't just trust C because B said so; A also has a direct trust relationship with C.
> 
> #### 3. Why KONECT makes this distinction
> In directed networks, you can have different types of triangles that don't imply the same thing:
> - Transitive (What you read): $A \rightarrow B, B \rightarrow C, A \rightarrow C$. This implies a hierarchical flow of trust or information.
> - Cyclic: $A \rightarrow B, B \rightarrow C, C \rightarrow A$. This implies a feedback loop or a "circle" of trust, which is structurally very different.
> 
> The "Directed Clustering" coefficient $c_{\pm}$ specifically measures the transitivity of the network.
> * High Transitive Clustering: Suggests a clear hierarchy of reputation (very common in Bitcoin OTC).
> * Low Transitive Clustering: Suggests that trust is more random and doesn't follow "the friend of my friend is my friend" logic.

For signed graphs, we may define the clustering coefficient to take into account the sign of edges. The signed clustering coefficient is based on balance theory (Kunegis et al. 2009). 

In a signed network, edges can be positive or negative. For instance in a signed social network, positive
edges represent friendship, while negative edges represent enmity. 

In such networks, balance theory stipulates than triangles tend to be balanced, i.e., that three people are either all friends, or two of them are friends with each other, and enemies with the third

On the other hand, a triangle with two positive and one negative edge, or a triangle with three negative edges is unbalanced.

In other words, we can define the sign of a triangle as the product of the three edge signs, which then leads to the stipulation that triangles tend to have positive weight. 

To extend the clustering coefficient to signed networks, we thus distinguis between balanced and unbalanced triangles, in a way that positive triangles contribute positively to the signed clustering coefficient, and negative triangles contribute negatively to it.

---

## 4.10 Signed Network Statistics
In networks that allow negative edges such as signed networks and rating networks, we may be interested in the proportion of edges that are actually negative. We call this the negativity of the network.

In directed signed networks, we can additionally compute the dyadic conflict, i.e., the propostion of node pairs connected by two oppositely oriented edges of different, compared to the total number of pairs of nodes connected by two edges of opposite orientation.

---

## 5 Matrices and Decompositions
In algebraic graph theory, a graph with n vertices is represented by an n ×n matrix called the adjacency matrix, from which other matrices can be derived.

The defined matrices can then be decomposed to reveal properties of the graph. 

The first subsection contains decompositions that apply to simple graphs. Subsequent subsections contain matrices that apply to specific types of graphs: signed, bipartite, and directed graphs.

### 5.1 Decompositions of Undirected Graphs

---

## Plots
Plots are drawn to visualize a certain aspect of a dataset. These plots can be used to compare several network visually, or to illustrate the definition of a certain numerical statistic.

### 6.1 Layout (Basic Network)
Layout plots show the nodes and edges of a graph in a way that makes features if the graph visible. Usually, this only makes sense for small graphs.18 In KONECT, we use the algorithm of Fruchterman & Reingold (1991).

### 6.2 Temporal Distribution
The temporal distributions shows the distribution of edge creation times. It is only defined for networks with known edge creation times. The X axis is the time, and the Y axis is the number of edges added during each time interval. 

We compute two plots: the distribution (bars), and the cumulative distribution (line).

### 6.3 Edge Weight and Multiplicity Distribution

### 6.4 Degree Distribution
The distribution of degree values d(u) over all vertices u characterizes the network as a whole, and is often used to visualize a network.

In particular, a power law is often assumed, stating that the number of nodes with n neighbors is proportional to n−γ, for a constant γ (Barab ́asi & Albert 1999). 

This assumption can be inspected visually by plotting the degree distribution on a doubly logarithmic scale, on which a power law renders as a straight line.

KONECT supports two different
plots: 
- The degree distribution
- The cumulative degree distribution

The degree distribution shows the number of nodes with degree n, in function of n.

> A scatter of points that meander out into the scale-free pattern

The cumulative degree distribution shows the probability that the degree of a node picked at random is larger than n, in function of n. 

> A line that arcs into the scale-free pattern

Both plots use a doubly logarithmic scale.


### 6.5 Out/Indegree Comparison
The out/indegree comparison plots show the joint distribution of outdegrees and indegrees of all nodes of directed graphs. The plot shows, for one directed network, each node as a point, which the outdegree on the X axis and the indegree on the Y axis.

> Scatter plot

### 6.6 Assortativity Plot
In some networks, nodes with high degree are more often connected with other nodes of high degree, while nodes of low degree are more often connected with other nodes of low degree. 

This property is called assortativity, i.e., such networks are said to be assortativity. 

On the other hand, some networks, are dissortative, i.e., in them nodes of high degree are more often connected to nodes of low degree and vice versa.

In addition to the assortativity ρ defined as the Pearson correlation coefficient between the degrees of connected nodes, the assortativity or dissortativity of networks may be analyse by plotting all nodes of a network by their degree and the average degree of their neighbors.

Thus, the assortativity plot of a network shows all nodes of a network with the degree on the X axis, and the average degree of their neighbors on the Y axis.

> A scatter plot that may show some sort of trend. 

## 6.7 Clustering Coefficient Distribution
In Section 4.7, we defined the clustering coefficient of a node in a graph as the propotion of that node’s neighbors that are connected, and proceeded to define the clustering coefficient as the cor- responding measure applied to the whole network.

In some case however, we may be interested in the distribution of the clustering coefficient over the nodes in the network.

For instance, a network could have some very clustered parts, and some less clustered parts, while another network could have many nodes with a similar, average clustering coefficient.

Thus, we may want to consider the distribution of clustering coefficient. 

> This distribution can be plotted as a cumulated line plot. With Local clustering coefficient (c) on the x-axis



