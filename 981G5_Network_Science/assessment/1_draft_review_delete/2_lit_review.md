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

Below is a hybrid between a dismination of the notes from Alves (2025) and a drafting of the lit review

# Structure/Flow
*There seem to be some clear themes arise to give structure to the lit review.*

## Alves Systematic Review

The gold standard source for this liturature review pertains to systematic review written by Richardo Alves in 2025 titled: *Social network analysis in football: a systematic review of performance and tactical applications*. This review covers the key foundational papers that helped sculpt the Football Network landscape today as well as a comprehensive review of the various methods and approaches that have been deployed with the goal of unvieling the underlying performance and tactical approaches of teams, managers and players in footall. 

> "this systematic review aimed to synthesize current research using network analysis as a tool to evaluate team performance and tactical behavior."

> If time, it would be cool to knit this review and the papers into a reference/author network. 

---

## How Networks are Applied to Football
*Basic, theory, translations, paradigm (micro etc): not findings!* 

To apply Network Science to football, we represent nodes as players and edges as some sort of interaction that links 2 players (Ramos et al., 2017).

Primarily the link used is passes as this is a clearly definable, bi-lateral iteration that contains an out-node (the passer) and an in-node (the receiver) (Bludu 2018). Additionally, the purpose of a football match is to win games which occurs through scoring (more) goals of which the prelude is generally passes. Therefore, modelling this interaction should give us an understanding of the infield performance and tactical approaches taken. 

> Somewhere there should be a notational preliminaries section denoting the methematical signed for the chose network.

That being said, we could use any interaction here and we are not restrict to possesion based or attacking routed interactions. Alves mentions that defenensive based interactions are an under explored area of research. Additionally, there are many examples in the liturate of multlilayered networks, often including passing by default, whereby the subsequent layers contain altnerative interactions to provide a more rounded scope of the onfield acitons. 

Alves highlights 3 distinct levels to the research approaches taken in the liturature: micro (individual player metrics), meso (small groups of players), and macro (the entire team’s network)" (Buldú et al., 2018). 

**Micro-level** focused research refer to metrics that can be tethered to an individual player (node) and makes up 45.8% of the research themes from the 55 papers reviewed by Alves (2025). From this perspective, **centrality measures** are commonly deployed to identify players who operate as the systems tactical hubs. **Degree Centrality** simply captures the frequency of players involves in a given interaction setting, i.e. passing (Ramos et al., 2017; Buldú et al., 2018). Generally highlighting central defenders and midfielders key contributors (Peixoto et al., 2017). **Closeness centrality** allows us to identify key players who can distribute the ball to all, or the widest range, players on the pitch (Ramos et al., 2017; Ribeiro et al., 2017; Buldú et al., 2018). **Clustering coefficents** also inform us as to how well-connected a player with with other teammates and in football term this metric can be translated into infer how skilled a player in create passing triangles on the pitch (Peña and Touchette, 2012; Ramos et al., 2017; Ribeiro et al., 2017; Buldú et al., 2018).

The **Meso-level** of the paradigm is slightly less defined, "intergating both micro and macro analytical perspectives" (Alves, 2025) and because of this only makes up 4.66% of research. Largely, it can be summarised as player (node) level metrics that require significant information from over players and the rest of the team, if which the building blocks of relevant metrics and research themes are **average neighbor degree** which forms a picture of **interaction strength** between players. This leads to things such as **(dis)assortivity coefficents** which can validate the source of a high centality metric by infering weather such players are just passing amongst a centrally located spine of high degree players, or distributing the ball wider, lower degree players such as wingers (**disassortative**) (Clemente et al., 2016).

> Assortativity measures degree correlation. It assumes a certain degree distribution already exists (whether heterogeneous or homogeneous) and asks: Do nodes prefer to connect to other nodes that have a similar degree to themselves?

Finally, Avles defines Macro-level as metrics and properties that provide "an overarching perspective of the team’s collective interactions" (Alves, 2025). The review comprises of 49.6% of this type of research. 

Marco metric include things such as: 
- Total edges (interactions)
- Network density which proxies as overall team cohension depending on the interaction used
- Network diameter which tells the maxium amount of time/length it takes a team to traverse the field
- Cliques which is the frequency of specifc interaction patterns and in football is often refer to as passing triangles. Triangles are important shapes in football as they provide the angle and route to work around a single player. 
- Network heterogeneity. Heterogeneity is about who exists in the network,the diversity of the nodes' degrees. It can help to unviel whether a team contains key, conenctive hubs which knit the team together, or whether a team contains equally conenctive nodes through out [MUST BE A REFERCE FOR AJAX OR CITY HERE]. 
- (Oliveira and Gama, 2012; Clemente et al., 2016; Ribeiro et al., 2017; Ievoli et al., 2021b) [i removed some points so need to check if these are still relevant]

> "At the team level, network metrics provide an overarching view of how players are connected, offering valuable insights into the team’s tactical structure and playing style." (Alves, 2025)

Alves (2025) concluded from their review that the most frequent network properties focused on were network density, betweenness centrality, clustering coefficient, and closeness centrality.

#### Temporal Appraoches 
> Traditional network analyses often take a static approach, aggregating data across an entire match. However, football is inherently dynamic, and the use of sliding time windows (e.g., 2- or 5-m intervals) allows researchers and practitioners to examine the evolution of passing structures and detect real-time shifts in team strategy (Cao, 2023)

---

## Findings and Motivations
*there are many finding and understanding. These underpin the motivation to applying networks to football*

*more accurately a "why" apply network science to football*

"SNA offers a powerful framework to decode the complexity of football performance, evolving from static graphs to dynamic, rolesensitive, and context-rich models." (Alves, 2025)

Several studies demonstate that network structures denominated by igh density, clustering coefficients are correlated with sucessful team performance (Alves, 2025). 

"Centrality metrics, for example, offer valuable insights into how individual players contribute to collective team performance, aiding in tactical evaluations and player-specific feedback." (Alves, 2025)

There is a key theme in the liturature is deploying centrality metrics to identify key tactical players which can then be used to inform coaches tactical approaches for match or for transfer targets (Alves, 2025)

A team with an elevated clustering coefficent has a greater number of triangular connections indicating greater robustness stemming from superior ball circulation across multiple zones (Herrera-Diestra et al., 2020). 

Díaz Díaz et al. (2024) was able to use network propeties to make obersivations about players within particular teams and systems. They found that central defenders and midfielders in the Argentinian national team obtained high centrality measures, specifically, Degree Centrality and Closeness Centrality. However, they found for the standout, highly influential players, such as Leo Messi, the key metrics that they prevail in are things like Page Rank, Eigenvector Centrality, Hubs and Authority. This suggests that mearly being a hub with a high centrality does not make you a highly talented player, instead it could just be due to a players postion and the system they play in. 

Several pieces of research have observed that winning teams are characterized by higher clustering coefficients which suggests greater local interconnectivity (triangles) suggesting tactical approachs which place emphasis on short passing to nearby players is an optimal strategy (Aquino et al., 2019; Medina et al., 2021)

Similarly, obersvations have been made that high finishing, top ranking teams display "higher levels of network density, average degree, weighted degree, and clustering coefficients" (Alves, 2015, Pan et al., 2024; Clemente, 2018; Castellano and Echeazarra, 2019; McLaren and Spink, 2020)

Abstract from the result, or finishing position, itself it has been repeatedly concluced that metrics such as density and clustering coefficient translate into a tool to assess teams cohesion and (local) connections with teammates (Clemente and Martins, 2017a; McLean et al., 2018b; Immler et al., 2021; Mclean and Salmon, 2019). With authors commonly making the extended link to success (Clemente and Martins, 2017a; Immler et al., 2021).

Arriaza-Ardiles et al. (2018) highlight that whilst total counts of metrics such as passes provide the information to analyse a team. Metrics like clustering and centrality complement to the team information and contain more naunce regarding tacticts, and specifccally offensive, of the team. 

Bludu (2019) consistently found that network metrics were higher for the FC Barcelona team **compared** to rest of teams (in the league). However, they also highlight that the number of passess alone has a huge impact (benefit) on network properties. 


Herrera-Diestra et al. (2020) in their study of organization of pitch networks found that FC Barcelona were characterized by hgher number of triangles (clustering) in their networks **compared** to league rivals. Additionally, they established that Barcelona's networks were more robust as a result. 

Studies on the influences of position have concluded that central players, particularly defensive midfields and central defenders, obtain a higher degree centrality due to contributing more to the ball possesion of the team (Clemente et al., 2020)

Nath & Chowdhury (2024) found weighted edge (cumulative counts) closeness centrality measures "the proximity between players, revealing insights into coordination and network efficiency".

"practitioners can better interpret their teams “tactical patterns and understand individual players” contributions during matches" (Ribeiro et al., 2017). (Alves, 2025)

Ignoring the network propeties themselves, the resulting visualisation of the network containing a given set of interactions provides a direct visual overview of a team's stategy as evidenced by a games outputs. We can easily and quickly seen play patterns, "hot-spots" and underlying weaknesss such as dis or less connected nodes (Peña and Touchette, 2012)


High clustering coefficents have been correlated with sucsessful, competition winning teams such as Spain in the 2010 World Cup (Cotta et al., 2013). The logical pertaining that a high coefficent demonstates effective utilization of central areas, particularly though key central midfield roles.  

Network density has been shown to contain prodictive qualities for goalscoring and match outcomes, thus aiding coaches and analysts in identifiying effective tacticals and/or influential players (Grund, 2012; Pina et al., 2017)

Alves (2025) consistently found throughout their review that the liturature associates cohesive network structures with enhanced team performance. 

Multiple studies conclude that highly interconnected passing networks (is this clustering or density?) in footballs terms translate into representations of ball retention, transition plays during possesion and more offensive actions (Clemente and Martins, 2017a; Pina et al., 2017; Kawasaki et al., 2019) -> (Alves, 2025)

"Similarly, top-ranked teams displayed higher levels of network density, average degree, weighted degree, and clustering coefficients (Pan et al., 2024; Clemente, 2018; Castellano and Echeazarra, 2019; McLaren and Spink, 2020), reinforcing the link between structural connectivity and performance outcomes" -> (Alves, 2025)

That being said, the relationship between network properties and SUCESS is not universally agreed. Mclean et al. (2018a) determined that during competitions (UEFA EURO 2016 tournament), therefore charactersized by low volume of games, there was no "significant differences in passing network characteristics" between the successful and unsuccessful teams. This finding held true between group and knockout stage matches. This suggests that performance outcomes by be influenced by additional contextual and/or tactical factors not capture by passing networks alone. 

Individual networks are generally respresentations of singles games but can be aggregated into wider themes, i.e. season length, or period, or split into even smaller representations, i.e periods of games. Importantly, it is the more granular individual components that allows for the application for temporal analyses. Pan et al. (2024) conducted longitudal analyses of World Cup tournaments demonstating the themes in variations of play style affect network density. The 2018 tournament was evidenced by a prevelance of direct style of play which relfected in lower density metrics stemming from fewer connections between players in the attacking and possenal phases. Constrast this to 2022 which showed a tactical shift towards possension based aprroachs, particular among the top-tier teams, which resulted in higher density metrics (Pan et al., 2024). This can be interpretted as evidence that stylistic preferences, wherther they been influenced by competition context, domain of research (age, gender), or restrictions in a teams availbility (injuries), can and will have an impact on the network structure from which connections can be identifed with infield outcomes. In turn this should inform training design and match preparation (Armatas et al., 2022; Oliveira and Clemente, 2018)

Modern studies have revealed that when utilising a pitch-passing network paradigm for analyis, a trend whereby teams that finished at the top of the league tend to adopt more possession-oriented styles compared to lower-ranked teams (Gong et al., 2023).



---

## PassMap Paradigm

*There is a lot of focus on the interacations used to model the netowrks, specically in the notion of passing and the PassMap frame, including the spatial component.*

Whilst there are a plethora of interactions to choose from when modelling the game of football, the absolute most popular is passing. 

Most of the methods described above as done so from the perspective of the "player-passing network". [Who to Who]

This paradigm was popularized by the seminal paper(s) but Bludu (TODO: compile relevant refs). Extensions to the paradigm include: pitch-passing networks and pitch-player passing networks (Buldú et al., 2018). [Where to Where]

In the pitch-passing networks the pitch itself is split into pre-defined zones and these zones become the networks nodes. Passes that take place from one zone to another are mapped in the network. This means there is no notion of players, just zones (nodes) and passes (edges). [Who-Where to Who-Where]

The pitch-player passing network is an extension of this,
- This one is quite complicated and probably isn't what I will use
- drawing a pitch with 198 nodes and thousands of crossing lines creates an unreadable "hairball," scientists rely on three specific visual formats:
- Visual A: Multilayer Network Graphs (The "3D Layer" View)
- Visual B: The Grid Heat Matrix (Adjacency Plot)

> Passes along the match give rise to three main types of passing networks: (i) player passing networks, where nodes are the players of a team (Passos et al., 2011; Grund, 2012), (ii) pitch passing networks, where nodes are specific regions of the field connected through passes made by players occupying them (Cintia et al., 2015) or (iii) pitch-player passing networks, where nodes are a combination of a player and its position at the moment of the pass (Cotta et al., 2013; Narizuka et al., 2014).
> 
> This is Bludu 2018

> In comparison to player-based passing networks, pitch-passing networks offer a more system-level perspective on offensive behavior, revealing how collective ball movement unfolds across the field. When combined with time window analysis, this dynamic approach allows coaches and performance analysts to monitor and respond to in-game tactical changes more effectively (Cao, 2023).



COME BACK TO THIS SECTION AFTER READING BLUDU, WILL BE EASIER TO WRITE

In comparison to player-based passing networks, pitch-passing networks offer a more system-level perspective on offensive behavior, revealing how collective ball movement unfolds across the field (Alves, 2025)



Kawasaki et al., 2019 present an alternative approach to PassMaps whereby the node is player agnostic. Pass locations (passer and a receiver) are clustered into "Nodes" which represent key, or less important, passing locations. These clustered locations are then knitted into a network whereby the edges represent passes between different clusters. Properties like number of passes, total links, degree centrality, scaled connectivity and clustering coefficient are then computed. 


===

In network science nodes themselves often lack an explicity spatial property, instead being represented contingent on a given network property, or determined by the hubs that they connect to - if they are a hub then arbitariy central in the graph. 

This is a huge issue for applications in sport whereby the coordinates are a key property of the node. 

To address this, researchers have developed...

===