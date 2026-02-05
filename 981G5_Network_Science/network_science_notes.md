# Week 1 - Introduction

# Week 1 Lecture 

[intro video]

[something about what is a complex system]
properties of complex systems
jet engine, might be complex depending on def
but we dont want a jet enginge to have some components of complex systems
compelx systems cant fully be understand
cant ensure we know the outcome, too complex
we are looking at comlex not complicated per say
jet enginge is complicated but we dont want it to do unknown things
complex systems loose the component of control 
complex sys = very large number of components
brain = example of complex system
neurons = lots of small bits working together
emergence is a key theme in complex systems


dynamics on network means things that happen on the network, i.e. firing
there is also dynamics of the netowrk, i.e. how many neurons there are 
these two things can mix

[module objective]
TODO: copy out slides
not a formal graph theory module, less maths
goal is to abstract real worl scenarios into network science
visual stuff 
centrality and its measures


[weekly schedule]

[assessment details]

[readings and seminar]
main text book
weekly papers


[software]
networkx, lab focus

=====

---
 
# Week 1 - Lab

[NetX Chapter 1 Offical Tutorial Notebook](981G5_Network_Science/week_1/netX_chapter_1.ipynb)
* [Offical Documentation](https://networkx.github.io/documentation/networkx-2.2/)
* [Offical Tutorial](https://networkx.github.io/documentation/networkx-2.2/tutorial.html)

[Tutorial Workthrough w/ Nodes](981G5_Network_Science/week_1/week_1_netX_tutorial.ipynb)

TODO: Explain parts of tutorial and copy out some of the additional notes. 

You can use NetworkX to construct and draw graphs that are undirected or directed, with weighted or unweighted edges. An array of functions to analyze graphs is available.

[Week 1 Lab Brief](981G5_Network_Science/week_1/week_1_lab.pdf)

[Week 1 Lab Attempt w/ Notes](981G5_Network_Science/week_1/week_1_lab.ipynb)

TODO: Finish questions

TODO: summaries content

TODO: diseminate notes






# Week 2 - Generalities 

# Week 2 - Lecture 

[1. Network Elements]
Let us learn the language of networks:
→ The components: nodes, links
→ Types of networks and representations
→ Features of nodes and links
We want to be able to talk about:
→ properties to characterize structure & behavior of networks
→ roles of networks in affecting processes occurring on network structures



[Formal Definitions]
A network or graph G has two parts: a set of N elements, called **nodes** or vertices,
and a set of L pairs of nodes, called links or **edges**. The link (i, j) joins the nodes i and
j. Two nodes are adjacent or connected or neighbours if there is a link between
them.

* this def excludes temporal nets works as i,j implies the edge exists at all times
* (didnt listen to the second one)

A network can be **undirected or directed**. A directed network is also called a digraph (relevant for netx).
In directed networks, links are called directed links and the order of the nodes in a
link reflects the direction: the link (i, j) goes from the source node i to the target node
j. In undirected networks, all links are bi-directional and the order of the two nodes in
a link does not matter.


A network can be unweighted or weighted. In a weighted network, links have
associated weights: the weighted link (i,j,w) between nodes i and j has weight w. A
network can be both directed and weighted, in which case it has directed weighted
links.



[Python NetworkX]
[undirected networks]
[directed networks]
has more functions
check predecessors and sucessors as there is a distinct order now
in a digraph some edges can still be constructed as bidirectional
(something about density of networkds, more options for nodes, spread alot fastest)
what is the sparsests network? technically a straight line but in terms of a true network, a tree
why a tree? each time you as a node you at one more possible edge
n-1 edge, n node
cannot be a net with less then n-1
cant remove any edge without making **disconnected components** (terminology)
why do we care about components and disconnected? linked to redunancy, resiliance and robustness measures, these are tested by attacking the network, interconnected
density impacs the spread of things
higher density means more reduncancy, means more resiliant to attacks/changes



[weighted networks]
weights on the edges, atributes



[bipartite networds]
no connection between elements on the same side of the network, only connected to the other side
TODO: include picture of network

In a bipartite network, there are two groups
of nodes such that links only connect nodes
from different groups and not nodes from
the same group
Examples of bipartite networks include those
that capture the relationships between
movies and stars, between songs and artists,
between classes and students, and between
products and customers.



[tree network]
deletion is the main part of definition and loweest density possible


A tree network is a special class of
undirected, connected network such that the
deletion of any one link will disconnect the
network into two components
Examples of tree networks include
phylogenetic trees, water distribution or
power grids, broadcasting networks, food
webs




[homework]
explore generators on netx 
[links on slides]
random graphs
random clusted graphs
community-based graphs
graphs with given joint degree sequence

[density and sparsity]
formula for size of undirected, max links, density
sparse definition based on density

and formula for directed, max links, density

[complete network]
every node connected to everyone
density will be 1




[facebook]
appox of sizes
N
L
d

facebook is not dense, actually sparse
most networks are sparse
this is because links scale with N
where as max sclaes with N^2
this means lager the net, the more sparse




[subnetworks]
why? interested to see details in certain area of networks

A subnetwork is a network
obtained by selecting a
subset of the nodes and all
of the links among these
nodes.

S = nx.subgraph(G, node_list)

A complete subnetwork is
called a clique

slide has a part respreenting networks are matrix




[Degree]

undirected
The degree of a node is its number of links, or neighbours.
The degree of node $i$ is typically denoted by $k_i$.

A node without neighbours is called a singleton (k=0)

G.degree(2) # returns the degree of node 2
G.degree() # dict with the degree of all nodes


In a directed network, we have:
in-degree of a node = number of incoming links k_in
out-degree of a node = number of outgoing links k_out

more about connections than neighbours

D.in_degree(4)1
D.out_degree(4)2
D.degree(4) # total degree

The degree function returns the total degree which is
the sum of both in- and out-degrees.



[average degree]
The average degree of a (undirected) network is $ $

av num of edges you have per node

We can connect network size, number of links, density, and average degree!
In undirected networks:

TODO: fill in a understand eqs from slides

[excess degree]
rewatch this section




[strength]

strength of a node, weighted degree

different from undir and dir again

str is sum of strength

dir has an in and out str

**unweigthed uses degrees, weighted uses strength**

[simplifying assumptions]
if not using temporal or something

assume single layer networkds, with single type of node and type of link

there are not self loops back tothe same node



[network repsresnation]
4 slides on this one
adjecency matrix

net rep by matrix

diags are 0 as we cant have self loops

single net allows matrix rep

TODO: fill in exact details a eqs from slide

TODO: something about the pytohn code

undirected networkds will be symetic in the matrix (equation)

undirected degres are obtained by summing cols or rows (both? clarify)

row,col for matrix notation a_ij, a_row,col

recall matmul is not reverisble, ij is not the same as ji

matrix are poor represenation for netowrks because networkds are sparse, meaning alot of space in the matrix will be empty but the memory wont be 

best representation will be an edge list (is this dictionary?)

if not efficent then why use matrix? because it has linear algebra for maths




[about adj mat and matmul] 3 slides

A*A squared, changes the view of the matrix (slides better notes)

TODO: watch this whole section again

Something about seeing triangles



DO THE WHOLE [network repsresnation] SECTION AGAIN