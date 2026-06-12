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

## Football Network Basics/Topics
- "In football, nodes represent players, while links depict their interactions, primarily through ball passes (Ramos et al., 2017)"
    - Would be good to find some references for other popular interactions used other then passes. 
- "three distinct levels: micro (individual player metrics), meso (small groups of players), and macro (the entire team’s network)" (Buldú et al., 2018)
- At the microlevel, key centrality measures include degree centrality, represents the number of passes made by a player (Ramos et al., 2017; Buldú et al., 2018)
- eigenvector centrality, reflects a player’s status within the network (Ramos et al., 2017; Ribeiro et al., 2017)
- closeness centrality, indicates how quickly the ball circulates among players (Ramos et al., 2017; Ribeiro et al., 2017; Buldú et al., 2018)
- "Most studies demonstrated that cohesive network structures, characterized by high density, clustering coefficients, and centrality, are associated with successful team performance."
- "Centrality metrics were frequently used to identify key tactical players, typically central defenders and midfielders."
- "clustering coefficient, measures how well-connected a player is with their immediate neighbors, often reflected by the ability of players in creating triangles (Peña and Touchette, 2012; Ramos et al., 2017; Ribeiro et al., 2017; Buldú et al., 2018)"
- At the meso-level, prominent metrics include average neighbor degree, which assess interaction strength between player pairs; assortativity coefficient, identifies the frequency of interactions among highly influential players; and topological overlap, captures player groupings based on shared connections (Clemente et al., 2016)
- Lastly, macro-level analysis provides an overarching perspective of the team’s collective interactions, featuring metrics such as total links (overall interactions), network density (overall team cohesion), distance (speed of ball circulation), network diameter (maximum interaction distance), clique (frequency of specific interaction patterns), network heterogeneity (variety of connections), centralization (distribution of team interactions), and global prestige (overall prominence of the team) (Oliveira and Gama, 2012; Clemente et al., 2016; Ribeiro et al., 2017; Ievoli et al., 2021b)
- "Most of the analytical methods described above are commonly referred to as player-passing network, with focus mainly at individual analysis."
- Recent methodological developments have introduced alternative approaches, such as pitch-passing networks and pitch-player passing networks (Buldú et al., 2018)
- The pitchpassing network involves in the dividing into predefined zones, where nodes represent these zones and links the passes between them (Buldú et al., 2018)
- The pitch-player passing network, it’s a combination of a player and its position in the moment of the pass (Buldú et al., 2018). 
- The team showed a higher number of triangular connections between pitch zones, indicating greater robustness, and elevated clustering coefficient values, reflecting fluid ball circulation across multiple zones (Herrera-Diestra et al., 2020)
- For instance, Díaz Díaz et al. (2024) observed that central defenders and midfielders in the Argentinian national team displayed high connectivity metrics such as Degree Centrality and Closeness Centrality, while highly influential players like Messi were the most frequently recruited, presenting higher values in Page Rank, Eigenvector Centrality, Hubs and Authority
- Recent methodological advances have introduced additional network metrics such as, proximity prestige, betweenness centrality, entropy, variability, and robustness (Herrera-Diestra et al., 2020; Martínez et al., 2020; Martins et al., 2020, 2021; Sarmento et al., 2020; Ichinose et al., 2021; Alves et al., 2022; Gama et al., 2020; Gonçalves et al., 2021; Medina et al., 2021).
- "studies were categorized (Figure 6) according to the analytical level employed: Macrolevel analysis (49.6), Micro-level analysis (45.8%) and Mesolevel analysis (4.66%) (integrating both micro and macro analytical perspectives)."
- "most frequently used were network density, betweenness centrality, clustering coefficient, and closeness centrality, which are predominantly associated with macro-level or team-level perspective"
- "In contrast, indegree and outdegree metrics—commonly associated to the passing interactions—were frequently employed to assess the individual roles and contributions of players within the team’s passing network"
- "winning teams have shown greater local interconnectivity (as indicated by higher clustering coefficients) suggesting a strategic emphasis on shortpassing sequences among proximate players (Aquino et al., 2019; Medina et al., 2021)"
- "Similarly, top-ranked teams displayed higher levels of network density, average degree, weighted degree, and clustering coefficients (Pan et al., 2024; Clemente, 2018; Castellano and Echeazarra, 2019; McLaren and Spink, 2020)"
- "Key metrics such as density and clustering coefficient have been consistently used to assess overall team cohesion and the extent to which players maintain local connections with teammates (Clemente and Martins, 2017a; McLean et al., 2018b; Immler et al., 2021; Mclean and Salmon, 2019)
- "Successful teams tend to exhibit higher engagement in subgroups and greater overall connectivity (Clemente and Martins, 2017a; Immler et al., 2021)
- Guardiola’s teams, for instance, have demonstrated higher density values, which have been associated with prolonged ball possession and intricate passing sequences (Immler et al., 2021)
- At the player level, centrality metrics are commonly used to identify individuals who serve as tactical hubs. Degree centrality captures the frequency of a player’s involvement in passing exchanges and often highlights central defenders and midfielders as dominant contributors (Peixoto et al., 2017). 
- Additional metrics such as betweenness centrality, clustering coefficient, closeness centrality, eigenvector centrality, and proximity prestige offer more nuanced insights into player influence and strategic positioning (Arriaza-Ardiles et al., 2018; Buldú et al., 2019; Korte et al., 2019; Wiig et al., 2019; Martins et al., 2021; Assunção et al., 2022; Nath and Chowdhury, 2024)
- "defensive midfielders showed a higher proportion of betweenness centrality in the 1-4-2-3-1 formation, indicating their enhanced role as intermediaries in linking play (McLean et al., 2018b)"
- "Traditional network analyses often take a static approach, aggregating data across an entire match. However, football is inherently dynamic, and the use of sliding time windows (e.g., 2- or 5-m intervals) allows researchers and practitioners to examine the evolution of passing structures and detect real-time shifts in team strategy (Cao, 2023). Combined with graph distance measures, this approach provides a clearer view of how network structure adapts across different phases of play."
- A recognized limitation of classic network models is their lack of spatial specificity. To address this, a growing number of studies have introduced pitch-passing networks, which incorporate spatial dimensions by dividing the field into multiple zones (nodes) and quantifying the volume of passes between them (links) (Buldú et al., 2019; Herrera-Diestra et al., 2020; Gong et al., 2023; Novillo et al., 2024)
- In comparison to player-based passing networks, pitch-passing networks offer a more system-level perspective on offensive behavior, revealing how collective ball movement unfolds across the field
- Arriaza-Ardiles et al., 2018 [KEY FINDING(s)] The total number of connections (passes and receptions) provides information to analyse the team. Metrics like, clustering and centrality, complement the information about the offensive play of the team.
- Yamamoto & Narizuka, 2018, To investigate the growth of the passing network through the time, according to the Markov-chain [KEY FINDING(s)] Teams with fewer number of passes tends to have greater error (transition probability). The team performance tends to be lower if the weighted passing network is highly centralized.
- McHale & Relton, 2018, To identify the key players in a football team. [KEY FINDINGS]  It has been shown a model that can predict the probability of success of a pass in different areas of the pitch. The use of centrality measures can help to identify key players of a given team.
- Kawasaki et al., 2019, To create a passing network based on the measurement of the pass position (Number of passes, total links, degree centrality, scaled connectivity and clustering coefficient), [KEY FINDINGS]
- The nodes’ location was determined by clustering the positions of a passer and a receiver with respect to successful asses. The edges indicated the passes between different clusters. The network metrics analysed in this study indicate the relative level of the number of successful passes.
- Korte et al., 2019, To identify dominant intermediary players, applying a play-by-play network. (Flow centrality, flow betweenness, weighted betweenness) The central defenders were identified as dominant and intermediary players in unsuccessful plays. And central midfielders are intermediary players in successful plays.
- The network metrics were higher in FC Barcelona’s team compared to the rest of the teams. The number of passes benefits the network properties. Buldú et al., 2019
- Herrera-Diestra et al., 2020, To analyse the organization of the pitch networks of FC Barcelona (2009-2010), (Pitch networks, clustering coefficient), The results indicated that the number of triangles of the pitch networks were higher in Barcelona team compared to rivals. Barcelona’s passing network was more robust than the rivals
- Clemente et al., 2020, To analyse the variations of the network centrality between playing positions and, the influence of the teams scoring status on playing position, The defensive midfielders had greater levels of degree prestige, being considered the most recruited by the teammates. The defensive midfielder and central defenders had the greater values of degree centrality contributing more for the ball possession of the team.
- Ichinose et al., 2021, To analyse the robustness of a passing network (Average degree, average distance, average clustering coefficient, robustness, change of diameter, algebraic connectivity and largest cluster change) It was showed that the passing network were robust against errors but vulnerable to attacks. Despite removing the key players, Kawasaki’s network was distinct from the other teams.
- Ievoli et al., 2021a, To determine if network properties and performance indicators are crucial for the match outcome: Network variables like diameter, betweenness centralization, can be related to the level of the offensive actions and finalizations of a team.
- Nath & Chowdhury, 2024, To combine social network analysis with position-specific football metrics to analyse the team and players performance: Through player factor we can identify the key players in each match. Winning teams showed high median values in player factor, which indicate the contribution of top performing players. Weighted edge closeness centrality measures the proximity between players, revealing insights into coordination and network efficiency.
- 

#### Purpose for applying Networks to Football
- "practitioners can better interpret their teams “tactical patterns and understand individual players” contributions during matches (Ribeiro et al., 2017).
- "Social Network Analysis (SNA) has emerged as a crucial and complementary framework, offering unique insights into the dynamic patterns of interpersonal coordination within and between football teams (Ribeiro et al., 2017; Alves et al., 2022)"
- "SNA offers a powerful framework to decode the complexity of football performance, evolving from static graphs to dynamic, rolesensitive, and context-rich models."
- The resulting network or graph provides a direct visual inspection of a team's strategy, from which we can identify play pattern, determine hot-spots on the play and localize potential weaknesses (Peña and Touchette, 2012)
- high clustering coefficients can indicate effective utilization of central areas, notably by central midfielders, as exemplified by Spain’s successful tactics in the 2010 FIFA World Cup (Cotta et al., 2013)
- Metrics like network density are **predictive** of goal-scoring potential and overall team success, aiding coaches and analysts in identifying effective game models and influential players (Grund, 2012; Pina et al., 2017)
- SNA applied to training exercises has revealed that teams composed of more skilled players exhibit higher levels of network cohesion and connectivity, enabling tailored adjustments to training methodologies (Machado et al., 2021; McHale and Relton, 2018)
- "This integrative method has proven particularly insightful in case studies, e.g., FC Barcelona, which exhibited distinct patterns compared to other teams in La Liga." talking about Buldú, 2018 and pitch-player passing network. 
- "SNA has become central to football research, particularly regarding collective tactical actions"
- "Its growing adoption underscores not only theoretical significance but also substantial practical utility, informing tactical decisions, training practices, and overall performance optimization."
- "this systematic review aimed to synthesize current research using network analysis as a tool to evaluate team performance and tactical behavior."
- "A consistent finding throughout the literature is the positive association between cohesive network structures and enhanced team performance." 
- "Multiple studies highlight that teams with highly interconnected passing networks tend to demonstrate superior ball retention, fluid transitions during possession, and more effective offensive actions (Clemente and Martins, 2017a; Pina et al., 2017; Kawasaki et al., 2019)"
- "Similarly, top-ranked teams displayed higher levels of network density, average degree, weighted degree, and clustering coefficients (Pan et al., 2024; Clemente, 2018; Castellano and Echeazarra, 2019; McLaren and Spink, 2020), reinforcing the link between structural connectivity and performance outcomes"
- "However, the relationship between network metrics and success is not universally straightforward. For instance, Mclean et al. (2018a) indicated no significant differences in passing network characteristics between successful and unsuccessful teams, nor between group and knockout stage performances in the UEFA EURO 2016 tournament. This suggests that performance metrics may be influenced by additional contextual or tactical factors." 
- "At the team level, network metrics provide an overarching view of how players are connected, offering valuable insights into the team’s tactical structure and playing style."
- "For instance, longitudinal analyses of World Cup tournaments have demonstrated how variations in style affect network density. In 2018, a more direct style of play was evident, reflected by lower density values, suggesting fewer connections between players. By contrast, the 2022 World Cup showed a shift towards a possessionbased style among top-tier teams, characterized by higher density metrics (Pan et al., 2024).
- "Such findings suggest that stylistic preferences—shaped by competition context, age, or gender—can influence network structure, which in turn should inform training design and match preparation (Armatas et al., 2022; Oliveira and Clemente, 2018)."
- "findings imply that subtle modifications to tactical systems can influence the prominence and effectiveness of certain positions. Coaches can use this information to align tactical choices with the technical profiles and strengths of their players, thereby enhancing team cohesion and performance."
- pitch-passing networks have revealed that teams finishing at the top of league tables tend to adopt more possession-oriented styles compared to lower-ranked teams (Gong et al., 2023).
- In comparison to player-based passing networks, pitch-passing networks offer a more system-level perspective on offensive behavior, revealing how collective ball movement unfolds across the field. When combined with time window analysis, this dynamic approach allows coaches and performance analysts to monitor and respond to in-game tactical changes more effectively (Cao, 2023).
- Key findings: high density = fewer posession losses, low densiy = more offension play (but also unsussesful), top teams = high values of network metris and robustness.
- "Centrality metrics, for example, offer valuable insights into how individual players contribute to collective team performance, aiding in tactical evaluations and player-specific feedback." 
- "tools now enable realtime assessment of passing networks, allowing practitioners to monitor how structural dynamics evolve throughout a match." 


##### Domain (Football) Considerations
- Like any other approach, SNA metrics requires careful contextualization with established situational variables known to influence football performance such as, match status, quality of opponent, time windows, match location and tactical systems (Mclean et al., 2018a; Praça et al., 2019; Aquino et al., 2020; Pan et al., 2024; Mclean et al., 2019)
- winning contexts tend to increase the prominence of midfielders, wingers and forwards within the network structure, reflecting with greater involvement in maintaining possession and creating offensive opportunities (Praça et al., 2019)

> i wonder if this is important from the perspective of create null model baselines, or it a full aggregation is the correct baseline. 

- "tactical systems also play a crucial interpretative role in the analysis of network metrics. Aquino et al. (2019) reported that the 1-4-2-3-1 tactical system was associated with higher macro- and micro-level network metrics when compared to the 1-4-4-2 and 1-4-3-3 tactical systems, suggesting greater cohesion and structural connectivity"

- "emerging evidence suggests that tactical systems can significantly shape both teamlevel and positional network structures. For example, teams operating in a 1-4-2-3-1 formation have been found to exhibit higher values in both micro and macro-level network metrics when compared to those using 1-4-4-2 or 1-4-3-3 systems, indicating greater cohesion and structural connectivity (Aquino et al., 2019).

-  contemporary studies increasingly employ machine learning, multilayer networks, and real-time data collection technologies (e.g., GPS and multi-camera systems) (Korte et al., 2019; Ievoli et al., 2021a; Pan et al., 2024; Ievoli et al., 2021b; Zhang et al., 2018). 

- Furthermore, several studies reported tactical shifts in response to match status. Praça et al. (2019) found that teams tended to adopt a more direct playing style when leading, while those trailing often favored a possession-based approach (reflected in changes at the microstructural level). These adaptations highlight the dynamic nature of team strategies and their **influence on network properties** (Vivés et al., 2018; McLean et al., 2017; Yamamoto and Narizuka, 2018; Zhao and Zhang, 2020).

- A player’s prominence in the network is ultimately a function of the
team’s tactical configuration and the demands of their specific role
(Clemente et al., 2019; Alves et al., 2022).





##### Other Data/Methods Applied to Football
- "advancements in technology and the continuous evolution of tactical knowledge by coaches, analysts, and researchers have significantly increased the variety and sophistication of methods and metrics used to evaluate team performance (Sarmento et al., 2022)"
- These developments have facilitated the integration of numerous performance indicators and holistic scientific methodologies, essential for objectively analyzing both individual and collective behaviors in modern football (Ribeiro et al., 2017; Sarmento et al., 2022; Mehta et al., 2024)
- researchers have cautioned against over interpreting network metrics in isolation. Aquino et al. (2019) emphasized that performance success can emerge from a variety of tactical models, and thus variability in both macro- and microlevel network measures is not uncommon
- "The integration of event data (e.g., passes, shots) with positional data (e.g., player coordinates) presents an opportunity to generate more sophisticated and actionable insights, both at the individual and collective levels."

##### Other Sports
- "in basketball it was identified that unpredictability and connectedness across players was associated with better performance (Fewell et al., 2012)"
- "In water-polo, through team analysis it was possible to understand attacking strategies and performance outcomes (Passos et al., 2011)"
- "Even in motorsport drivers and professional golfers was possible to analyze the relationship between status and its influence on performance (Bothner et al., 2012)" 

##### Network/Graph Theory
- Originally rooted in sociology and anthropology, SNA is an interdisciplinary approach that emerged in the 1930s (Wäsche et al.,2017)
- grounded in Graph Theory, a mathematical discipline used to examine relationships within groups of actors or organizations (“nodes”) interconnected through ties or links (Rice and YoshiokaMaxwell, 2015)
- SNA has since been successfully applied across diverse fields including business, epidemiology, and organizational studies to understand complex interaction systems (Wäsche et al., 2017)
- 


##### Other
- "there remains an overrepresentation of elite men’s football and offensive phases, with limited focus on defensive networks, youth categories, and women’s football"
- "Future research should adopt longitudinal designs, multi-layer network approaches, and closer collaboration with practitioners to enhance the operational utility of network insights in coaching and performance analysis."
- "While tactical formations are a central aspect of football strategy, relatively few studies have explicitly examined their influence on network metrics."
- "Future research should aim to integrate more detailed tactical descriptors, such as pressing strategies, width utilization, or defensive compactness, into network analyses. Doing so would strengthen the connection between empirical findings and applied coaching practice, offering deeper, context-sensitive insights for optimizing performance."
- "Incorporating a broader range of samples, including different age groups and female athletes, could reveal important variations in network behaviors and offer a more inclusive understanding of tactical patterns across different footballing contexts."
- "Second, only a small number of studies analyzed data from an entire season for a single team. As previously noted by CaicedoParada et al. (2020), analyzing full-season data is essential to identify longitudinal fluctuations in network structures and tactical dynamics."
- "many studies rely on limited sample sizes, often based on single-match analyses, which restrict the ability to detect broader tactical trends or structural consistencies."
- Another critical gap in the literature is the predominant focus on offensive network patterns. 
- 


---

##### References
[Ribeiro, J., Silva, P., Duarte, R., Davids, K., and Garganta, J. (2017). **Team sports performance analysed through the lens of social network theory: implications for research and practice.**](https://link.springer.com/article/10.1007/s40279-017-0695-1)
- Refernced alot in the intro


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