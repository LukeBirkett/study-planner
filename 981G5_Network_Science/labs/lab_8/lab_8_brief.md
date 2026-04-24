# Lab class 8 Exercise Sheet


## Question 1: Exploring the impact of structure on dynamics
In the lecture “Dynamics on networks”, you were exposed to a number of models of dynamics, threshold, contagion, voter, etc. A marimo notebook was provided with example code. One important practical aspect of having dynamics on networks is to understand the role of structure on dynamics (and in question 2, and we will revisit this when we finish the lecture, how dynamics might impact structure). So, here, I am asking you to pick whichever model you like and systematically investigate the impact of structure. This means you should:
* Pick a metric by which you assess the impact of structure … For example, if you pick an epidemic, you could look at the peak number of infections. On the other hand, if you pick an opinion model, your metric might be a measure of polarization or fragmentation.
* Consider different kinds of networks. Very obviously, you could start with ER and BA (in which case what you are doing is implicitly ask what is the role played by hubs) but even the Marimo notebook lets you explore other aspects of network structure, for example, increasing the degree of the network is asking what is the role played by density (all other things being equal). You could also use small-world networks or modular networks (use SBM to construct them) in which case you are asking about the role of clustering, modularity, etc.
* Decide how to seed your network (this is an interesting question of its own)
* Run multiple realisations of the dynamics (when appropriate – i.e., is the process deterministic or stochastic?).

---

## Question 2:
I do not expect you reach this question within today’s lab class but in case… here I’m asking you to consider a scenario in which there is co-evolution of dynamics and network. What does this mean? It means that the network ‘rewires’ as a function of the dynamics on the network. You could almost think of it in terms of one of the growth models we considered previously. Except that in growth models, we rewired based on some structural consideration, e.g., either pick a node at random or pick it according to its degree. Here, the rewiring could be done according to the ‘opinion’ or ‘state’ of the neighbour. In the lecture, we will look at the following model.

We use an opinion model (revisit the lecture notes if you are unclear). Each iteration is a sweep over the nodes, synchronously or in random order For each node $𝑖$ select a random neighbour $𝑗$ with different opinion from $𝑖$:
* With probability $𝑝$, the link between $𝑖$ and $𝑗$ is rewired from 𝑖 to a randomly selected non-neighbour holding the same opinion as $𝑖$ – this is implementing a selection policy whereby you connect to people who feel the same way as you.
* With probability $1 − 𝑝$, $𝑖$ takes the opinion of $𝑗$ – this implements a process of influence whereby you change your mind according to the opinions of people you are connected to.

Implement it and see what happens. Interesting questions here include: does this ever stop? under what condition? how does that differ from what happens on a static network? You may want to consider different types of initial conditions, networks, etc…