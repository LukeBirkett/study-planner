The high-level approach to this project will be to interrogate the construction of null model for the usage in football, specifically applied to the PassMap paradigm in which nodes are players (or locations) and edges are interactions modelled by passes. 

The project will start by introducing the PassMap paradigm from the foundational Bludu paper(s). There are few constructions of PassMap formulations ranging from player, pitch-player and pitch-location. There will be a nessecity to introduce and demonstrate all 3 as they can be used into different way during the null construction. 

The data used for this project will be the StatsBomb open repository. We will select the latest season from one the Womens league's. Time will need to be taken to familiarise ourselves with the data structure but passes should easily identifiable. For producing the networks themsevles we will be working with NetworkX. 

Following this there will be a small liturature review. This will largely focusing network applications to football though it is permitted to overflow into general football analytics research. We will likely mention xG given it is the hollywood statistic. There has been two recently lituruature reviews from contemporary network sceince football researcher which will form the basis of this liturature review:
- Social network analysis in football: a systematic review of performance and tactical applications (Alves et al., 2025)
- Network analysis to understand variability and patterns of individual and collective behaviour in professional football: a systematic review (Gama et al., 2026)
The main goal of the liturautre review will be to justify the qustion: "Why apply networks to football"

The next step will be to demonstate how networks can be applied to football. There are a huge amount of examples apply networks to football and many papers have a section like this where they breakdown the different network metrics and how they translate into football. 

A different paper from Gama et al. (2026) has a full breakdown of metrics and translation which we will use as the basis for our section
- Linking network structures and stochastic flow properties: An exploratory Markov-spectral case study in professional football (Gama et al., 2026)

Supringsly, this seciton isn't actually the main goal of the paper therefore we need to be efficent with our word count and visualisaion. I invision a table of the most interesting metrics, i.e. centrality metrics, density, clustering coefficent, desnity, diamter, heterogeneity, Transitivity, Assortativity, as well as the distinction between micro and macro. In terms of visualisation, we are fortunate in that PassMapps are small networks, therefore, we can probably produces a page spread of 1 visualisation with X subset visuals demonstating different networks and metrics at play. Note, for this section, we will probably need to focus on just 1 paradigm of the Bludu PassMap format. 

The next section will introduce the ongoing research pertaining to interesting things happening with dynamics of the network. Gama et al. (2026) work on Stochastic flows properties is the main reference for this but there is a concrete leg of research coming from Japan, particularly including Narizuka et al. (2014), that needs to be comprehensively referenced here. 
- Narizuka, T., Yamamoto, K. and Yamazaki, Y., 2014. Statistical properties of position-dependent ball-passing networks in football games. Physica A: Statistical Mechanics and its Applications, 412, pp.157-168.

It is really important to understand that this leg of research is strictly Dynamics ON the Network, where as, my project will focus on Dynamics OF the Network and Topological aspects. However, as it turns out, the methodologies used to model the dynamics on the network are very close to those needed to being the topology for the network so can be easily adapted

Addition, these exact papers are also providing a call for Null Models in their litimations and future work sections of their papers. 

Here we need to explain Why Nulls are so difficult for football. This also leads into why the D-ON-Network research prevailed as it did because it precluded the need for Nulls, upto a point. 

This is where the main part of the project actually starts. 

First, we spend some time defining Null Models and what they are used for. Second, we implement, quickly, a set of stardard null models, clearly ackowledging why they are not suitable for PassMaps and a spatial constraint game like football. 

The final part of the project is experiementing with ways to construct null models in football, with a strong focus on applying the methodologies from the D-ON-Network research to producing viabale Null Models. 

Note, that I expect this be a highly difficult thing to produce, afterall there are no clear answers in the liturature, therefore the approach of this project should be to experiement and clear minimum viable produces (MVPs). We expect to produce the perfect Null Models, we just want to experiement with different technqiues and see what gets us where, which technqiues retain certain qualities and which fail. 

I am not quite sure yet what the correct evaluation method is a for a Null Model. How do you determin that it is acceptable? I guess it would identifying key features of Empirical networks, identifying their normal staticial range and seeing if the generated null models fit in that range. 

There may be a final leg of this project where we quickly us a null model to valid a finding from a seasons worth of data. For example, we may identify a team or player with a standout metric and then use a Null Model process to valid whether it is actually interesting or just a topoloigical likely, or possible, occurance based on a given network, which in football terms is generally detemrined by tactics or formation. 






