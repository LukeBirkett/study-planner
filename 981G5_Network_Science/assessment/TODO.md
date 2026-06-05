1. Finish Alves Notes
2. Do PassMap Research
3. Do Null/Spatial/Markov Research


4. Null Resarch Prompt though Alves (Might be less important due to papers in 3.)







===

# Reading list


**Bottom Up, Limitations:**

> Cheng, Y.-S., Chang, A. Y.-C., & Doya, K. (2025). Information-theoretical analysis of team dynamics in football matches. Entropy, 27(3), 224. https://doi.org/10.3390/e27030224

===

**Network Metrics:**

Recent methodological advances have introduced additional network metrics such as, proximity prestige, betweenness centrality, entropy, variability, and robustness 

> (Herrera-Diestra et al., 2020; Martínez et al., 2020; Martins et al., 2020, 2021; Sarmento et al., 2020; Ichinose et al., 2021; Alves et al., 2022; Gama et al., 2020; Gonçalves et al., 2021; Medina et al., 2021).

===

**More Network Metrics**

Additional metrics such as betweenness centrality, clustering coefficient, closeness centrality, eigenvector centrality, and proximity prestige offer more nuanced insights into player influence and strategic positioning 

> (Arriaza-Ardiles et al., 2018; Buldú et al., 2019; Korte et al., 2019; Wiig et al., 2019; Martins et al., 2021; Assunção et al., 2022; Nath and Chowdhury, 2024)

===

**Robustness Testing:**

It was showed that the passing network were robust against errors but vulnerable to attacks. Despite removing the key players, Kawasaki’s network was distinct from the other teams.

> Ichinose G. Tsuchiya T. Watanabe S. (2021). Robustness of football passing networks against continuous node and link removals. Chaos Soliton. Fract. 147:110973. 10.1016/j.chaos.2021.110973

===

**Network Properties and Paper Structure (Present then Model):**

The aim of the present paper is to show how information retrieved from passing networks can have a significant impact on the match outcome. At a descriptive level, we provide useful graphic visualizations to compare teams and their individual level of connection. Therefore, we directly compute and discuss network properties, such as centralization, clustering and cliques, from a football perspective. Then, we model the probability of winning the game through four competitive machine learning models including network-based indicators as explanatory variables with a set of in-field variables.

> NOTE: this paper does containt the type of modelling I am interested in, it is a result prediction model. But the format is similar, it focuses purely on applying networks to football and the properies first, then goes onto the modelling. 

> Ievoli, R., Palazzo, L. and Ragozini, G., 2021. On the use of passing network indicators to predict football outcomes. Knowledge-Based Systems, 222, p.106997.

===

**Related to mentions Null Models as further research:**

> "Future studies should also employ **null models and random network** comparisons to establish baselines for spectral gap, entropy rate, and other indices, enabling more robust interpretation of observed values"

> Expanding the analyses to underrepresented domains, such as women’s football or youth competitions, would also test the framework’s applicability across varying match contexts and address identified gaps in network analysis research.

---

"prior research has successfully established the Markov-chain model as a valid approximation for the growth of passing networks over time [16] and to model state transitions between field zones [17]"
- Yamamoto, K. and Narizuka, T., 2018. Examination of Markov-chain approximation in football games based on time evolution of ball-passing networks. Physical Review E, 98(5), p.052314.
- Liu T, Zhou C, Shuai X, et al. Influence of different playing styles among the top three teams on action zones in the World Cup in 2018 using a Markov state transition matrix. Front Psychol 2022; 13: 1038733. https://doi.org/ 10.3389/fpsyg.2022.1038733

Markovian processes naturally accommodate such probabilistic, time-evolving phenomena by modelling sequences of play as state transitions on a network [18]
- Norris JR. Markov chains. 2nd ed. Cambridge University Press, 1998.

However, a relevant methodological gap persists: while SNA describes who is connected and identifies
structural hubs,1,2,4 and Markov models have been applied either to network growth over time16 or to state transitions between field zones,17 no framework has yet systematically combined structural topology with stochastic flow metrics to quantify real-time tactical functionality on the player network itself, such as how quickly possession diffuses (Spectral Gap), how unpredictably it circulates (Entropy Rate), or how efficiently it reaches key players (Mean First-Passage Time)

This integration gap limits the ability to move from descriptive structural analysis to explanatory profiling of tactical functionality and efficiency, a challenge recently outlined in the literature

However, a relevant methodological gap persists: while SNA describes who is connected and identifies structural hubs, [1,2,4] and Markov models have been applied either to network growth over time [16] or to state transitions between field zones, [17] no framework has yet systematically combined structural topology with stochastic flow metrics to quantify real-time tactical functionality on the player network itself, such as how quickly possession diffuses (Spectral Gap), how unpredictably it circulates (Entropy Rate), or how efficiently it reaches key players (Mean First-Passage Time). This integration gap limits the ability to move from descriptive structural analysis to explanatory profiling of tactical functionality and efficiency, a challenge recently outlined in the literature. [2,3,15]
- This is NOT the same issue that I am looking into but it is almost entirely related to the same route cause. 
- Markov Models/Zone Transiations look at the prob of the ball moving from Zone A to Zone B but tend to ignore player-to-player relationships
- If you want to use a metric like Mean First-Passage Time (MFPT) to see how efficiently a team gets the ball to Haaland, you run into the exact same trap we discussed earlier: Is Haaland's low MFPT a result of brilliant tactical design, or is it just because the midfielders pass a lot?

> "Recent literature highlights a critical methodological gap: the failure to integrate structural topology with stochastic flow metrics like Mean First-Passage Time or Entropy Rate to quantify tactical functionality [cite your snippet]. However, this paper argues that even if such stochastic metrics are applied, they remain purely descriptive without the context of a baseline. To truly move from 'descriptive profiling' to 'explanatory profiling,' these flow metrics must be evaluated against a Directed, Weighted Configuration Null Model to determine if a team's diffusive efficiency is a statistically significant tactical construct or a trivial byproduct of passing volume." -> Gemini

this study bridges this methodological gap by integrating static SNA with a dynamic Markov-spectral framework for flow properties to model ball circulation as a stochastic diffusion process on the player network.

While previous studies have applied Markov models to football passing networks, for example, to analyse network growth over time [16] or state transitions between field zones, [17] the present framework makes a distinct and novel contribution.

SNA offers a robust quantitative framework for modelling team sports by representing players as nodes and their interactions as edges within a complex network.

This methodology transcends traditional reductionist approaches that focus on isolated events, enabling the examination of emergent individual and collective behaviours, including identification of key influencers, preferred playing zones, tactical organisations, and patterns of collective behaviour.

Previous research has demonstrated that cohesive network structures and well-chosen centrality metrics can illuminate performance outcomes. For example, teams with higher connectivity and balanced interaction patterns often
achieve greater success. [30,35]
-  Pina TJ, Paulo A and Arau´jo D. Network characteristics of successful performance in association football: a study on the UEFA Champions League. Front Psychol 2017; 8: 1173. https://doi.org/10.3389/fpsyg.2017.01173
- Ribeiro J, Silva P, Duarte R, et al. Team sports performance analysed through the lens of social network theory: implications for research and practice. Sports Med 2017; 47(9): 1689–1696. https://doi.org/10.1007/ s40279-017-0695-1

Within SNA, two complementary families of metrics are distinguished
- Centrality measures (Degree, Betweenness, Eigenvector, Closeness, and Stress) quantify structural role and involvement level, answering "who participates most" and "who connects whom." [4]
    - [4] Clemente FM, Couceiro MS, Martins FML, et al. Using network metrics in soccer: a macro-analysis. J Hum Kinet
- These reflect the volume and positional importance of contributions to the passing network.

- Entropy-based measures (Node Transition Entropy and Network Transition Entropy) capture variability and unpredictability in passing choices, answering "how diversely the ball is distributed" and "how difficult it is to anticipate the next pass."
- A player may have high degree centrality by repeatedly passing to the same teammate (low entropy, predictable), while another with moderate degree but high entropy distributes passes more evenly (unpredictable, harder to defend).

(Micro) Degree, Closeness, Betweenness, and Eigenvector centralities were prioritised as indicators of influence and mediation of information flow, consistent with previous football network studies.

While some degree of conceptual overlap may exist among these metrics,2,3,14,15 their combined presentation offers a multi-dimensional profile of individual involvement in the passing network.









----

**How this paper links to mine:**

- without a null model baseline, they cannot prove that their advanced tactical interpretations are actually true.
- they show that in Match 2, the team’s Entropy Rate (unpredictability) and Spectral Gap (ball circulation speed) increased.
- they make a tactical inference: Portugal played a more fluid, adaptive, and unpredictable style in the final compared to the semi-final.
- because they lack a baseline, their interpretation isn't scientifically robust
- observed changes might just be normal stochastic fluctuations (i.e., the natural noise of a football bouncing around a pitch) rather than a deliberate tactical adaptation
- Because passing networks inherently possess an underlying structure (e.g., midfielders naturally pass more than strikers), the metrics will always shift slightly from game to game by pure chance.
- "We need a randomized baseline so we can calculate a Z-score. If the real game's Entropy Rate is significantly higher than 1,000 randomized versions of that same game, only then do we have a robust interpretation that the unpredictability was a deliberate tactical blueprint, not just a random fluke".
- You want to use network properties to infer a team's tactical style—whether they are a possession-heavy team, a direct counter-attacking unit, or a highly centralized system built around a single playmaker.
- authors are doing the exact same thing, just using "stochastic flow" metrics instead of classical static metrics
- The Mathematical Baseline (Null Model) Prove: 
    - (Spectral Gap) Does the speed of ball diffusion exceed a random re-shuffling of passes? 
    - (Mean First-Passage Time (MFPT)) Is the number of passes required to reach the striker shorter/longer than a volume-based random baseline?
- Gama et al. (2026) are trying to decode tactical functionality and efficiency—they are just using advanced tools to do it.
- frame myt resaerch as the direct answer to their call for future research
- state that whether you use classical metrics (like Clustering and Centrality) or their Markovian flow metrics (like Entropy and Spectral Gaps) , no network property can be safely mapped to a tactical approach without a null model baseline to filter out the random noise of the game.


Given this research finding, I also need ot read thier systematic review:
> [2] Gama, J., Dias, G., Pereira, M., Mendes, R., Mendes, R.S., Sarmento, H. and Vaz, V., 2026. Network analysis to understand variability and patterns of individual and collective behaviour in professional football: a systematic review. International Journal of Performance Analysis in Sport, pp.1-62.

Note, G Dias is also in Alve review

---




> Gama, J., Dias, G., Couceiro, M.S., Mendes, R., Mendes, R.S. and Vaz, V., 2026. Linking network structures and stochastic flow properties: An exploratory Markov-spectral case study in professional football. Proceedings of the Institution of Mechanical Engineers, Part P: Journal of Sports Engineering and Technology, p.17543371261448957.

===

