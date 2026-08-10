# 2.1 Data Pipeline & Preprocessing

> Datasets, provided by Opta, consists of all passes completed along a football match by each team of the Spanish national league (“La Liga”) for the season 2009/2010. Specifically, consists of a set of 380 matches, 38 per team. For each pass, we have the information about: (i) the player who passes the ball, (ii) the player who receives the ball, (iii) the position (x and y coordinates) of the sender/receiver players and (iv) the time at which the pass was made (see Table 1 for details). Since we are concerned about the game of FCB, we focused on all matches played by this team, and analyze the passing networks of FCB and its rivals (Buldu, 2019)

To ease comparison between networks, each titular player is assigned a node at the beginning of the match. If a player is changed, the new player occupies the node of the previous player. In this way, we assure that all networks have eleven players, focusing on the structure of the network as a whole instead of the performance of isolated players. (Buldu, 2019)

"The x,y coordinates have been scaled to between 0,100 and are measured in "field units" as not all fields are the same size." (Buldu, 2019)

> Note, Alves et al. (2025) also highlight two more limitations explicitly, a severe underrepresentation of Women's Football. and An overreliance on single-match or short tournament samples rather than full-season longitudinal datasets.

Gama (2026) used a 2 game sample and observed that a a **larger dataset** is needed to run resampling methods (matrix permutation) to establish a baseline and therefore determine if observed variations reflect tactical adaptations or normal match-to-match noise.


"Expanding the analyses to underrepresented domains, such as women’s football or youth competitions, would also test the framework’s applicability across varying match contexts and address identified gaps in network analysis research." Gama, 2026, stoch