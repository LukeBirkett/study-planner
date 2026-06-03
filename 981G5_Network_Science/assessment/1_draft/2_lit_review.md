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


===

## References












===

# Structure/Floe
*There seem to be some clear themes arise to give structure to the lit review.*

## Alves Systematic Review

The gold standard source for this liturature review pertains to systematic review written by Richardo Alves in 2025 titled: *Social network analysis in football: a systematic review of performance and tactical applications*. This review covers the key foundational papers that helped sculpt the Football Network landscape today as well as a comprehensive review of the various methods and approaches that have been deployed with the goal of unvieling the underlying performance and tactical approaches of teams, managers and players in footall. 

> If time, it would be cool to knit this review and the papers into a reference/author network. 

## How Networks are Applied to Football
*Basic, theory, translations, paradigm (micro etc): not findings!* 

To apply Network Science to football, we represent nodes as players and edges as some sort of interaction that links 2 players (Ramos et al., 2017).

Primarily the link used is passes as this is a clearly definable, bi-lateral iteration that contains an out-node (the passer) and an in-node (the receiver) (Bludu 2018). Additionally, the purpose of a football match is to win games which occurs through scoring (more) goals of which the prelude is generally passes. Therefore, modelling this interaction should give us an understanding of the infield performance and tactical approaches taken. 

That being said, we could use any interaction here and we are not restrict to possesion based or attacking routed interactions. Alves mentions that defenensive based interactions are an under explored area of research. Additionally, there are many examples in the liturate of multlilayered networks, often including passing by default, whereby the subsequent layers contain altnerative interactions to provide a more rounded scope of the onfield acitons. 

Alves highlights 3 distinct levels to the research approaches taken in the liturature: micro (individual player metrics), meso (small groups of players), and macro (the entire team’s network)" (Buldú et al., 2018). 

**Micro-level** focused research refer to metrics that can be tethered to an individual player (node) and makes up 45.8% of the research themes from the 55 papers reviewed by Alves (2025). This includes things like **centrality measures** whereby a nodes **degree centrality** represents the number of passes, or specified interaction, made by a player (Ramos et al., 2017; Buldú et al., 2018). **Closeness centrality** allows us to identify key players who can distribute the ball to all players on the pitch (Ramos et al., 2017; Ribeiro et al., 2017; Buldú et al., 2018). **Clustering coefficents** also inform us as to how well-connected a player with with other teammates and in football term this metric can be translated into infer how skilled a player in create passing triangles on the pitch (Peña and Touchette, 2012; Ramos et al., 2017; Ribeiro et al., 2017; Buldú et al., 2018).

The **Meso-level** of the paradigm is slightly less defined, "intergating both micro and macro analytical perspectives" (Alves, 2025) and because of this only makes up 4.66% of research. Largely, it can be summarised as player (node) level metrics that require significant information from over players and the rest of the team, if which the building blocks of relevant metrics and research themes are **average neighbor degree** which forms a picture of **interaction strength** between players. This leads to things such as **(dis)assortivity coefficents** which can validate the source of a high centality metric by infering weather such players are just passing amongst a centrally located spine of high degree players, or distributing the ball wider, lower degree players such as wingers (**disassortative**) (Clemente et al., 2016). 

Finally, Avles defines Macro-level as metrics and properties that provide "an overarching perspective of the team’s collective interactions" (Alves, 2025)

Macro 49.6)

## Findings and Motivations
*there are many finding and understanding. These underpin the motivation to applying networks to football*

Several studies demonstate that network structures denominated by igh density, clustering coefficients are correlated with sucessful team performance (Alves, 2025). 

There is a key theme in the liturature is deploying centrality metrics to identify key tactical players which can then be used to inform coaches tactical approaches for match or for transfer targets (Alves, 2025)







===

Then there are many finding and understanding. These underpin the motivation to applying networks to football

Finally, there is a lot of focus on the interacations used to model the netowrks, specically in the notion of passing and the PassMap frame, including the spatial component. 

===