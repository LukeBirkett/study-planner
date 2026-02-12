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




# Week 3 Lecture

textbook second chapter

think about structure of networks and important concepts

[outline]
chapter 2 small words [TODO write down slide structure] rewatch video and take downs of topic introductions

things that are similar tend to group together. also a social phenom

[bird of a feather]

similar things tends to group togoether; like minded people, similar people

wont go into quantifying this yet (later lecture) but ...

how to measure?  how connected entities are compared to other entities; quant way to measure; distance; steps from one another; however still very expensive to compute this; can just calculate the distance between two nodes as there are many routes often; shortest path possible; this depends on type of network, i.e. weighted edges; physical shortest distances may not be the fastest; however this is all too expensive to calc; focus needs to be on density of connections to the "same" type; prob that node connects to same type; dont need to consider path this way

friends of friends connected is clusters; counting the triangles; this is not measuring similar people directly

degree = number of connections

[assortativity]

[THERE IS A PAPER REFERENCED HERE, if interested in network science then should read if possible, foundational paper]

[rewatch slides]

how does assoc emerge; 
1. selection or self-selection process; homopily; you like people who are like yourself; (has a opposite word too); neurons that has similar reactions to the same input; human cells die so need several that know and do the same thing; brain is backed up by redundancy and re[sometihng]; similar ndoes become connected; social sciences this is very common topic, think social media and echo chambers; homopily causes echo chambers and radicalness, bias reinforced; 

2. influece can also be a way that connectivity occurs; not just together because of similar but there is something that pulls you into a network/cluster; 

do similarity incudes links or do links incudes similarity? i.e. yourr env is what influecnes you, exposed to a particualr group, does this influece you? this is related to coevolution and adativness. 

assoc is not ness a good thing, echo chamoers

[degree assortativity]

look at this alot in net science. aka degree correlation; de-assorative is the oppos, assoc means similars group; degree assoc means group with people that has similar degrees (connections); 

right is de-assoc, low degree codes are only connecting to central high degree nodes; doesnt mean disconnected; think hub and spoke;

assoc means nodes connected to nodes with similar number of connected; how be variable within a net; have a mix of high and low degree nodes, but will only connected to similar nodes; think brain highly connects but body less degees, more direct; core-perihperhy structre (this was in bold, what does it mean?); hubs in the core (again, what does this mean?)

degree is calc some sort of a degree correlation

core-periphery with huges in core. "rich club" or social networds with key central figures. 

[assoc in networkx]
 measure correlation bbetween the degree and the average degree of the direct neighbours of a given node
TODO INCLUDES FORMILAS; there is two; 

first calc degree (number) of neighbours of a given node; dot product matmult; a_ji is the connection, k is either the weight or 1 (check this?)

second; average degree of neighbours of a node with a degree of X

if i have degree x, the average degree of my neighbours is x

followed by peasron correlation

TODO UNPACK NETX code

[Paths; Definitions]

unpack from slides

pathl seq of links to go from source to target; there paty not be a paths

cylce; closed path, source and taget node are the same, loop

simple path; no traversing the same link more than ones; we will only deal with simple paths

path length; num of links; could also be based on weights

[euler circa 1736]

[SHORTEST PATH]

between two nodes; min length, there may be more than one; in weighted networkds, weights may mean distance; 

shortest path length is a the metric for teh shrotest path, akak distances. undefined or initite is there is no root.

[APL and Diameter]

diameter is the longest shortest path length, or max of the shortest path lengths accross nodes; shortest path length =. of two nodes; diameter looks at all possible pairs of nodes, which is the longest in the network?; this gives a measure of the total size of the network; need to look at the shortest paths to give us this measure, otherwise we could just mkae arbitarily huge routes; number = you cannot find a longer path that will need to be traversed, any pair will be this or less; 

TODO INCLUDE EQUATION OF DIAMETER

Average Path Length (APL) average of the shortest path length accorss all pairs of nodes. 

TODO TO DIFF EQUATIONS FOR UNDIR VS DIR NETWORKS

big issue here if there is an undefinied path; netx will highlight this as a diconnected network; could exclused all connected elements; solution is to do the harmonic means

TODO equation but also understand the intution as to why we make this change with repect to the above topic. harminc mean is a ratio; the infinate dstance becomes 0, we can get rid of disconnected components; average of iverse and invert again; 

looking as inverse of distance has a name and paper, measure of network efficency; TODO RE WATCH THIS EXPLANATION; something about inf becoming 0;

TODO UNPACK NETOWRKX OPTIOND (REWATCH SLIDES)

[connectedness and components]

net is conn if there is a path between any two nodes

if not then disconnected

MISSED SOME TERMINOLOGT ON FIRST SLIDE

a dir net can be strongly connected or weakly connected

strongly is triangles, a pass between any pair

notion of in-component and out-component

nodes that are connected to a network but you cannot go to, this in-component. i.e. a node on the edge that has a direction that goes into the network, i..e you cant get to do, cant go back; node can reach S nodes,  but S node cannot reach the start node; 

out-compent as connect nodes that cannot go to the S but S can go to

NETWORKX CODE TO UNPACK

[trees]

tree is a connected network with out cycles, friends of friends cannot exists, N-1 links; sparsest way of building network;

with a tree, you can pick any node to be the root and it retrains its hierachical structure; nets can be reorganised; root has no parents, leaves ahve no children; 

[finding shortest paths]

algo; breadth-first search; not a tree becasue it has cycles (loops); start from source node, doesn't matter which one but probably start from root; as above, any can be root; first list neighbours at same depth; then iterative to next layer; 

[breadth-first search]

TODO DIDNT LIST TO ANY OF THIS, REFOLLOW SECTION AND MAKE NOTES

[social distance]

how closer or far, is is apl

acedeic coauthoriship networks; how connected are authors, how far away;

Paul Ardos; 500 coauthor; is a hub in a coauthorship network; SOMETING ABOUT SMALL NUMBERS, REVIST

[six degrees of kevin bacon]

shorts paths, hubs have short paths; 

[small worlds]

social networks trned to have very short paths

six degress of sperationl any two people are at most 6 people away; 

[milgrams experiement]

PAPER TO READ

take rand people, give them a tatget; send letter to people that might bring you closer to x person or place; see how many steps to get to x; only 26% Mmade it; av steps were 6; range 3-12;

yahoo repeated with email in 2003; approx 4-7

facebook; uni milan; 

[short paths]

what do we mean by short paths, when can we call a path short?

depends on size of network; fast within network; observe erela between alp and net wise

apl is short when it grows very slowly with the size of the network

LOG EQUATION

[small worlds]

most irl will be small worlds

type of structure that might not be so short? hubs create short routes if the hubs are connected; a lattice strcture will not be short; or a grid like nyc; 

[friend of a friend]

the presence of triangles

often use with social becuase friends are often friends of friends also

direct networks are a bit more complicated. transitivity; may have a triangle but all 3 arent actually connected;

[clustering coefficent]

measure num of trianges that a node actually has relative to how many it could have

clust coeff is the fract of pairs of the nodes neighbours that are connected to each other

NEED TO FOLLOW THIS SLIDE, LECTURE VIDEO and EQUATION BETTER

xs