# 1.1 Research Context & Problem Statement

This section should be quick, concise and direct. We are breifly to introduce Network Science and its wide scope of application. Then we can scope into football specifically representing a hugely complex system which cannot be understood by analyzing individual players in isolation, but rather through the emergent structure of their collective interactions. We then briefly move into explaining how football can be constructed as a network, however, remembering that we have section 1.3 PassMap Paradigm to go this in detail, therefore, here we want to be brief, possibly directly referencing a seminal paper and denoting that section 1.3 is coming to explain this more concretely. We may also explain that network properties translate into tactic interpreations but we also have a full section for this in 2.2 Network Topology in Football, therefore, the same considerations need to be applied. Finally, we introduce the reasons for the this paper is to introduce spatially context aware Nulls are robust baselines to validate findings and determine whether they are unique or due to the topological, spatial and domain constains of football. 

In fact, now that I have written this out, I see that the same utility of this section will be function a high-level outline of the report. It explains what we are doing, why and the goal of the paper but the detail is limited and throughout there are references made to the sections that pertain to the in-depth explantions, i.e. 
- How football becomes a network is 1.3
- The network properties becoming tactical inference is 2.2
- The null considersations are 4

---

**This is a high-level Network Science based exerpt as to why we use Network Science for anything:**
"Using such an approach, it is possible (i) to identify the most influential individuals of a social network [6–11], (ii) to detect the existence of communities of people and the common interests that tie them more tightly than individuals in other communities [12–14], (iii) to explain the propagation of rumors/diseases [15–18] or (iv) to analyze the bursting activity of individuals when communicating with others [19]"
- Would be a good introduction to the project which then meanders into applying Network Science to football
- Complex systems theory suggests that a football team cannot be understood by analyzing individual players in isolation, but rather through the emergent structure of their collective interactions. 

---

**How to capture football in Network form (Buldu, 2018):**
"Under this framework, the organization of a team can be considered as the result of the interaction between its players, creating passing networks, which are directed (i.e., links between players go in one direction), weighted (the weight of the links is based on the number of passes between players), spatially embedded (i.e., the Euclidean position of the ball and players is highly relevant) and time evolving (i.e., the network continuously changes its structure)."

"the organization of football teams and their performance have been unveiled using metrics coming from Network Science,  where a team is considered as a complex network whose nodes (i.e., players) interact with the aim of overcoming the opponent network." (Buldu, 2019)

Under this framework, team organization is represented through passing networks that are directed (passes have an origin and destination), weighted (edge strength reflects pass volume), spatially embedded (governed by pitch geometry and Euclidean distance), and time-evolving (fluctuating continuously over 90 minutes). (Gemini)

---

Gama et al. (2026) to show that while modern analytics can compute advanced stochastic flow metrics (like Spectral Gap or Entropy Rate), these metrics are currently trapped in a purely descriptive state

without reference distributions, researchers cannot determine whether variations in a team’s network performance reflect deliberate tactical adaptations or normal stochastic match-to-match noise.

This project is a direct response to Gama et al.’s explicit limitation call for null models to establish baseline distributions for these metrics

---

allows researchers to capture the emergent properties of collective behaviour and tactical organisation [2,3] (Gama, 2026, stoch)
- Gama J, Dias G, Pereira M, et al. Network analysis to understand variability and patterns of individual and collective behaviour in professional football: a systematic review. Int J Perform Anal Sport.

Identifying key players, team tactics, and patterns of ball circulation [1,4–9] (Gama et al. 2026, stoch)

Moving beyond reductionist analyses of isolated technical or tactical actions (Gama et al 2026, stoch)


This perspective is aligned with a dynamic systems approach to
football, which views teams as complex, adaptive systems where performance emerges from the continuous interaction of players under multiple constraints. [10]
- [10] Araujo D, Hristovski R, Seifert L, et al. Ecological cognition: expert decision-making behaviour in sport. Int Rev Sport Exerc Psychol 2019; 12: 1–25. https://doi.org/10.1080/1750984X.2017.1349826

As highlighted by Gama et al., [2] network analysis also reveals how structural and functional coordination emerges from the patterns of interaction among players, providing metrics that may reflect team adaptability and strategic efficiency.


This methodology transcends traditional reductionist approaches that focus on isolated events, enabling the examination of emergent individual and collective behaviours, including identification of key influencers, preferred playing zones, tactical organisations, and patterns of collective behaviour. (Gama et al 2026)