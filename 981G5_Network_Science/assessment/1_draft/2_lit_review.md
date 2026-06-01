# 2. Literature Review
This positions your work within existing academic research.

## 2.1 Network Science in Sports Analytics
*[Networks Applied to Other Sports], [How Network Science Applied to Football]*

Reviewing how graph theory has been used in basketball, hockey, and previous iterations of football "passing maps".

> Initially, I had lost track of and was confused as to why 'HOW' would be includes here as intituaitve how makes sense for methology where it can be also demonstated and explained mathmetically. 

> However, it makes how the Lit review here. 

> Here the different ways networks have been applied to football can be explained, i.e. different types of interactions. 

> The underlying pricciples that needs to be presented in the sports networks, i.e. spatially constained. 

> The foundations and seminal papers can be introduced, i.e bludu. 

> And can we can probably cover the different applications of networks to fooball, i.e. tactical or predicticve mostly, this also blends into 'WHY' which is covered in the intro, but that will likely be more for sematically explainining the motivations, maybe the references can be applied and lsited here. 

> can talk about network science applied to OTHER sports. This may work well as an intro to the lit review, or at the end. 

---

> I THINK THIS SECTION WILL BECOME CLEAR AFTER DISEMINATING AVLES NOTES AND CONDUCTING THE NULL RESEARCH


- List though different types of interactions seen in researach (pass, def, etc)
- Mentioning mutli-layer networks
- Introduce the PassMap framework, Bludu
- Discuss the spatial compoenent
- Conclude that we will be moving forward with a pass based paradigm
- Mention that Alves highlight less dominant areas

> All of this stuff makes sense for the lit review, not the methodology. We are establishing was exists in the lit and then in the method we are scope down into specific bits, i.e. spatital, passes, bludu, womens, and demonstating a deep dive into how to apply. 

===

To build an actual Network Science project for football, you have to treat it as a spatially embedded network (Buldú et al., 2018). In these systems, nodes have physical coordinates $(x,y)$, and the probability of an edge existing is heavily influenced by the Euclidean distance between those coordinates.

**The Temporal/Dynamic Network (Evolution):** Build networks for each match (or segment) and extract the relevant properties. Track how the metrics develop over time. The way the networks change and therefore the metric change can be analysed and explained from a football/tactical perspective. A common approach is windowing where you compute the average of something, say a team's Clustering Coefficient to see if tactical discipline spikes or dips during a losing streak.

**The "Ensemble" Network:** You could ensemble all matches from a teams seasons into one super network. This essentially creates a probability map of how a team functions - and you could frame this as a managers tactical outputs. From this you could ask "what is the teams backbone?". The supernetwork itself will be an uniterpretable hairball as all players will likely have made a pass to eachother in some way, including all swud players. You use Disparity Filter (Salience Network) to strip away the statistically insignificant edges and reveal the "Multiscale Backbone"—the core passing lanes that persist regardless of the opponent.


