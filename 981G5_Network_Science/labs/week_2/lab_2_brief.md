# Lab class 2 Exercise Sheet

Preliminary: If you haven’t completed last weeks’ lab class, I would suggest you do so. If you have completed it, please proceed with the questions below.

## Question 1:
You have a random graph with a mean degree of 4 and a mean excess degree of 4. You then decide to remove all nodes of degree 0 and 1. Do you expect the mean excess degree to go up or down? (hint: remember the definition of excess degree)

## Question 2:
Keeping in mind the definition of excess degree, an interesting question is the relationship between mean degree and mean excess degree for a given network. Do you expect it to be generally lower?

Think about it a little bit then write code to generate the following 3 networks:
* Regular network (nx.random_regular_graph(d, n)) with mean degree 4, i.e., all nodes
have exactly degree 4.
* Erdos-Renyi random network (nx.erdos_renyi_graph(n, p)) also with mean degree 4. We will study this model in more detail very shortly but for now all you need to know is that that in an ER network, the mean degree ⟨𝑘⟩ is given by 𝑝(𝑁 − 1) where 𝑝 is the probability of a node being connected and 𝑁 is the size of the network. So set 𝑝 so that the ⟨𝑘⟩ can be expected to be 4.

* Barabasi-Albert random network (nx.barabasi_albert_graph(n, m)) also with mean degree 4. We will also study this model in more detail. Here ensuring the mean degree is 4 is a bit tricky. For the purpose of this exercise, simply set the parameter 𝑚 to 2. This parameter has to be an integer so this will not be exact (see below).

Then, write functions to extract the mean degree and mean excess degrees for all 3 networks.
What do you notice regarding the relationship between mean degree and mean excess degree?
If you want to convince yourself, repeat the experiment a number of times to get mean and
standard deviation.

## Question 3:
A network has a mean degree of 4 and a mean excess degree of 6, then half the nodes are removed at random. What is your expectation for the mean degree and mean excess degree after the nodes have been removed? Before using any code, try to predict the answer. Once you have your prediction, use code above to check whether your prediction is correct. To be clear, you will not get a network with a mean degree of 4 and a mean excess degree of 6, but using those 3 networks, you will learn that the impact is identical between all 3 types of networks. Now, to get better results, make the networks suﬀiciently large (the larger, the better).

## Question 4: Programming exercise
In the next lecture, we will introduce a property called “degree assortativity”, which, put simply, is a measure of the tendency of nodes to connect to other nodes with similar degree. Practically, degree assortativity is calculated using the assortativity coeﬀicient 𝑟, which ranges from -1 (perfect disassortativity) to +1 (perfect assortativity), with 0 indicating no correlation. To calculate the degree assortativity of a network G, use `nx.degree_assortativity_coefficient(G)`. In this exercise, I am asking you to write code to generate your own low- and high-assortativity networks (say with 100 nodes, i.e., I am not interested in a small hand-designed graph). Feel free to come up with your own approach but one idea might be to start from some kind of random network (and here you might want to pick a suitable form of random graph depending on whether you want high or low assortativity) and then do some rewiring to tune the assortativity up or down. 

(hint: the principle of a rewiring algorithm is that you will pick two pairs of nodes, one that is connected by an edge and one that isn’t, and then, delete the existing edge and add a new edge if it will either increase or decrease assortativity)