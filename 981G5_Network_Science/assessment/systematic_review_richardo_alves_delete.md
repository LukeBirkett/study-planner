# Social network analysis in football: a systematic review of performance and tactical applications (2025)
Reivew of current landscape of Network Science in Football. Reviews 55 Studies to evaluation how network science is used to measure performance, tactical behaviour and player interactions. Highlights evolations from static graphs to dynamic models utilizing tracking data. 

[Paper](https://scholar.google.co.uk/citations?view_op=view_citation&hl=en&user=M2lgL5AAAAAJ&sortby=pubdate&citation_for_view=M2lgL5AAAAAJ:iyewoVqAXLQC) 

[Supplementary Material](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2025.1659603/full)

---

##### Contents:
1. [Football Network Basics/Topics](#football-network-basicstopics)
2. [Purpose for applying Networks to Football](#purpose-for-applying-networks-to-football)
3. [Domain (Football) Considerations](#domain-football-considerations)
4. [Other Data/Methods Applied to Football](#other-datamethods-applied-to-football)
5. [Other Sports](#other-sports)
6. [Network/Graph Theory](#networkgraph-theory)
7. [Other](#other)

---

##### References
[Ribeiro, J., Silva, P., Duarte, R., Davids, K., and Garganta, J. (2017). **Team sports performance analysed through the lens of social network theory: implications for research and practice.**](https://link.springer.com/article/10.1007/s40279-017-0695-1)
- Refernced alot in the intro
- "Previous research has demonstrated that cohesive network structures and well-chosen centrality metrics can illuminate performance outcomes. For example, teams with higher connectivity and balanced interaction patterns often achieve greater success. [30,35]" -> Gama

----

> Clemente FM, Couceiro MS, Martins FML, et al. Using network metrics in soccer: a macro-analysis. J Hum Kinet
- Author is a co-author elsewhere in the list
- Game references this author/paper as centrality measures to answer who participates most" and "who connects whom."
- These reflect the volume and positional importance of contributions to the passing network.

---



[Ramos, J. J., Lopes, R. J., Marques, P., Araújo, D., and Araujo, D. (2017). **Hypernetworks reveal compound variables that capture cooperative and competitive interactions in a soccer match**. Front. Psychol. 8:1379. doi: 10.3389/fpsyg.2017.01379](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2017.01379/full)
- Also referenced alot in the intro


[Novillo, A., Gong, B., Martinez, J. H., Resta, R., del Campo, R. L. L., and Buldu, J. M.(2024). **A multilayer network framework for soccer analysis.** Chaos Soliton. Fract. 178.doi: 10.1016/j.chaos.2023.114355](https://www.sciencedirect.com/science/article/pii/S0960077923012572?via%3Dihub)
- Probably too advanved for this assesssment but would be good to read as it appears to cover network basics in the introductions and more advanced applications including going beyond passes. 

[Buldú, J. M., Busquets, J., Martínez, J. H., Herrera-Diestra, J. L., Echegoyen, I., Galeano, J., et al. (2018). **Using network science to analyse football passing networks: dynamics, space, time, and the multilayer nature of the game.** Front. Psychol. 9:1900. doi: 10.3389/fpsyg.2018.01900](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2018.01900/full)
- Seminal/Foundational

[Buldú, J. M., Busquets, J., Echegoyen, I., and Seirul.lo, F. (2019). **Defining a historic football team: using network science to analyze Guardiola’s F.C. Barcelona.** Sci. Rep. 9:13602. doi: 10.1038/s41598-019-49969-2]()
- appears to be the bulda paper than introduced, or popularised, the pitch-passing networks spaital paradigm

[Peña, J. L., and Touchette, H. (2012). **“A network theory analysis of football strategies,”** in Proc. 2012 Euromech Physics of Sports Conference, pages 517–528, Paris,apr 2012. LEditions de l’ ’ Ecole Polytechnique. 1–6. Available online at: http://arxiv.org/abs/1206.6904](https://arxiv.org/abs/1206.6904)
- Seminal/Early paper demonstating applying networks to football
- "We showcase in this paper the use of some tools from network theory to describe the strategy of football teams"
- construct for each team a weighted and directed network in which nodes correspond to players and arrows to passes (Peña and Touchette, 2012). 
- Using different centrality measures, we can also determine the relative importance of each player in the game, the `popularity' of a player, and the effect of removing players from the game (Peña and Touchette, 2012).

[Ievoli, R., Palazzo, L., and Ragozini, G. (2021b). **On the use of passing network indicators to predict football outcomes.** Knowl. Based Syst. 222:106997. doi: 10.1016/j.knosys.2021.106997](https://www.sciencedirect.com/science/article/abs/pii/S0950705121002604?via%3Dihub)
- Take networks and their properties for **prediction** task
- Passing networks and their structural features can be used to evaluate the style of play in terms of passing behavior, analyzing and quantifying interactions among players.
- directly compute and discuss network properties, such as centralization, clustering and cliques, from a football perspective.
- some network-based variables, such as diameter and betweenness centralization, can be related to the level of offensive actions and finalizations for a team.

[Grund, T. U. (2012). Network structure and team performance: the case of English premier league soccer teams. Soc. Netw. 34, 682–690. doi: 10.1016/j.socnet.2012.08. 004](https://www.sciencedirect.com/science/article/abs/pii/S0378873312000500?via%3Dihub)
- seminal/foundational
- networks as **predictive** inputs
- "networks characterized by high intensity (controlling for interaction opportunities) and low centralization are indeed associated with better team performance."

[Pina, T. J., Paulo, A., and Araújo, D. (2017). Network characteristics of successful performance in association football. a study on the UEFA champions league. Front. Psychol. 8:1173. doi: 10.3389/fpsyg.2017.01173](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2017.01173/full)
- Again apply networks as an input to **predictions**
- Predictive aspect likely outside of the scope for my report as i will focus on properties compared to baselines
- but could be implemented as a very quick experiement.
- "networks formed by team players passing a ball in a match shows that team success is correlated with high network density and clustering coefficient, as well as with reduced network centralization"
- "nvestigated whether network density, clustering coefficient and centralization can predict successful or unsuccessful team performance."
- "A hierarchical logistic-regression model was used to predict the successfulness of the offensive plays from network density, clustering coefficient and centralization, after controlling for the effect of total passes on successfulness of offensive plays."
- breakdown match into phases and builds a network to represent that phase and its properties using as inputs to a model. (i dont think the network itself is a feature)
- "Density, but not clustering coefficient or centralization, was a significant predictor of the successfulness of offensive plays." 
- "We found a negative relation between density and successfulness of offensive plays."
- "reduced density was associated with a higher number of offensive plays, albeit mostly unsuccessful.'
- "high density was associated with a lower number of successful offensive plays (SOPs), but also with overall fewer offensive plays and “ball possession losses” before the attacking team entered the finishing zone" 


[Herrera-Diestra, J. L., Echegoyen, I., Martínez, J. H., Garrido, D., Busquets, J., Io, F., et al. (2020). Pitch networks reveal organizational and spatial patterns of Guardiola’s F.C. Barc. Chaos Soliton. Fract. 138:109934. doi: 10.1016/j.chaos.2020.109934](https://linkinghub.elsevier.com/retrieve/pii/S0960077920303337)
- This paper looks to be moving to a topic which provides and reason for applying network science which is not purely predictive of a result.
- "Pitch networks are composed of nodes consisting of particular subdivisions of the field, which are connected through links whose weight ωi,j corresponds to the number of passes made from region i to region j."
- "multi-scale analysis focused on evaluating the properties of pitch networks at different scales"
- The paper is specifically comparing 1 team to the rest of the league. this is different to my approach as I want to compare the result of the league to a baseline. i suppose in their analysis the league is the baseline but its evades being able to comfirm significance.
- "results show ... there are statistically significant differences between F.C. Barcelona and the rest of the teams of the Spanish league"
- "These differences are particularly significant at the clustering coefficient, the network average shortest-path, and the number of nodes occupied by a team for partitions with a high number of subdivisions."

[Sarmento, H., Clemente, F. M., Gonçalves, E., Harper, L. D., Dias, D., and Figueiredo, A. (2020). Analysis of the offensive process of AS Monaco professional soccer team: a mixed-method approach. Chaos Soliton. Fract. 133:109676. doi: 10.1016/j.chaos.2020.109676](https://www.sciencedirect.com/science/article/abs/pii/S0960077920300783?via%3Dihub)
- This is an analysis based piece to it aggressively demonstates how network properties are applied to football
- Might not be flective of the report I am going to write but probably good to read this for inspiration and understanding. 

[Ichinose, G., Tsuchiya, T., and Watanabe, S. (2021). Robustness of football passing networks against continuous node and link removals. Chaos Soliton. Fract. 147:110973. doi: 10.1016/j.chaos.2021.110973](file:///Users/lukebirkett/Downloads/fpsyg-16-1659603.pdf#page=13&zoom=100,70,270)
- This is an attack based study
- Was not immediately clear to me that this was an option because football networks are so small and removal only really occurs by being sent off
- But I suppose as player could be tactical removed which helps to provide a reason for conducting network analysis
- Should probably read this to see what the approaches are. 
- "a tolerance to players being marked or passes being blocked in a passing network, namely the robustness of the network, has been poorly understood so far"
- "The results show that these passing networks commonly contain hubs (key players making passes)."
- "full backs increase the robustness by often invoking a heavier emphasis on attack." 


[Nath, M. K., and Chowdhury, T. (2024). **Team performance analysis in football match using network analysis-based approach**. Soc. Netw. Anal. Min. 14:21. doi: 10.1007/s13278-023-01180-y](https://link.springer.com/article/10.1007/s13278-023-01180-y)
- "xamining each player’s ball passing interactions for assessing player performances using weighted network centrality metrics, such as closeness centrality and eigenvector centrality.
- "introduces a metric called weighted edge closeness centrality to measure the proximity between players, accounting for edge weights."


[Zhou, W., Yu, G., You, S., and Wang, Z. (2023). **An improved passing network for evaluating football team performance**. Appl. Sci. 13:845. doi: 10.3390/app13020845](https://www.mdpi.com/2076-3417/13/2/845) 
- I modern paper demonstating an approach to forming networks and using them to produce metrics and properties

---

#### Where are the Null Models?

##### Dicipline Problem
- isn't because it’s a solved problem, but rather due to a combination of disciplinary divides, structural constraints, and mathematical edge cases.
- published in sports science, performance analysis, and sports psychology journals, rather than pure physics or network science journals
- In sports science, Social Network Analysis (SNA) is largely used as an advanced descriptive tool
- Researchers use metrics like betweenness centrality, degree centrality, or density as sophisticated box-score statistics to see if they correlate with performance outcomes
- They are looking for practical coaching indicators, not testing structural hypotheses against an ensemble of randomized networks to prove topological anomalies.

##### Small Problem
- Traditional network science null models (like the Configuration Model or Erdős-Rényi graphs) rely on asymptotic behavior where the number of nodes $N \to \infty$.
- features only 11 nodes on the pitch at any given time
- When $N = 11$, degree-preserving randomization is incredibly constrained
- If you try to wire an 11-node directed, weighted graph while keeping each player's in-degree and out-degree exactly intact, the number of unique valid isomorphic variations is remarkably small.

##### The Spatial "Straw Man"
- Football networks are spatially embedded and topologically constrained. A left-back passes to a left-winger or a central defender because of pitch geometry and tactical positioning.
- If you run a classic, unconstrained null model that shuffles links globally, you create a baseline where a goalkeeper is just as likely to pass to a striker as to a center-back.
- Comparing a real match to a completely unconstrained random model creates a "straw man" argument: it is trivial to reject the null hypothesis, but it yields zero actionable tactical insight for a coach.

idea to isolate wide players acting as hubs over a season-long dataset is an excellent way to bridge the gap between pure network theory and applied sports science. It allows you to prove whether a winger's high centrality in a specific game is a genuine tactical Masterclass or simply a statistical artifact of how the opposing team pressed them.

move beyond a completely random network and build a context-aware null model.

Instead of randomizing links globally, shuffle pass frequencies only between matches that used the identical formation (e.g., a 4-3-3). This preserves the intrinsic topology of the system while testing if the specific individual's hub properties stand out against the formation's baseline.

Use the players' average $X,Y$ coordinates during the match to build a distance-decay function. Simulate a random walk where the ball moves purely based on proximity. If a wide player's real centrality is significantly higher than this spatial random walk, you have statistical proof of a deliberate tactical bottleneck.

This methodology elevates your project from a simple descriptive exercise into true statistical inference, demonstrating a deep comprehension of how network theory handles physical constraints.