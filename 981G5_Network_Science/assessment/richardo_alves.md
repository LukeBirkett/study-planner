# Richardo Alves
- contemporary researcher. compare to Buldú who is foundational. 
- tactic systems and match outcomes (states) impacting the network metrics

| Title | Author | Year | Link |
| :--- | :--- | :--- | :--- |
| Social network analysis in football: a systematic review of performance and tactical applications | Richardo Alves | 2025 | [Link](https://scholar.google.co.uk/citations?view_op=view_citation&hl=en&user=M2lgL5AAAAAJ&sortby=pubdate&citation_for_view=M2lgL5AAAAAJ:iyewoVqAXLQC) |
| Positional Influence in Football Passing Networks: An Analysis of the Tactical Systems and Match Outcomes | Richardo Alves | 2025 | [link](https://scholar.google.co.uk/citations?view_op=view_citation&hl=en&user=M2lgL5AAAAAJ&sortby=pubdate&citation_for_view=M2lgL5AAAAAJ:R-LXmdHK_14C) |
| Exploring team dynamics through network analysis: A season review of an elite Portuguese soccer team | Richardo Alves | 2025 | [link](https://scholar.google.co.uk/citations?view_op=view_citation&hl=en&user=M2lgL5AAAAAJ&sortby=pubdate&citation_for_view=M2lgL5AAAAAJ:dAp6zn-oMfAC) |
| Network analysis of offensive dynamics in a Portuguese first division football team: insights from the 2020-2021 season | Richardo Alves | 2025 | [link](https://scholar.google.co.uk/citations?view_op=view_citation&hl=en&user=M2lgL5AAAAAJ&sortby=pubdate&citation_for_view=M2lgL5AAAAAJ:pQTOvowfQioC) |  

---

<br>
<br>
<br>

#### Social network analysis in football: a systematic review of performance and tactical applications (2025)
Reivew of current landscape of Network Science in Football. Reviews 55 Studies to evaluation how network science is used to measure performance, tactical behaviour and player interactions. Highlights evolations from static graphs to dynamic models utilizing tracking data. 

**Findings:**
- Cohesive network structures are strongly correlated with successful performance.
- Central defenders and midfielders are consistently identified as the key tactical hubs
- Mens football and offensive phases are underepresented
- Defensive networks, youth, and women's football underrepresented

**Base Network Science Applications:**
- what constitutes a "Node" (players, or sometimes pitch zones) and an "Edge/Tie" (passes)
- discusses looking at networks at the individual level (micro), small group formations (meso), and whole-team structures (macro).
- discusses moving away from static match-long adjacency matrices toward dynamic time-window analysis and how structures evolve minute-by-minute or phase-by-phase

---

<br>
<br>
<br>

#### Positional Influence in Football Passing Networks: An Analysis of the Tactical Systems and Match Outcomes (2025)
micro-level (individual player) metric. analyzes how different starting formations (1-4-1-4-1, 1-4-3-3, 1-3-4-3) and match outcomes (win, loss, draw) influence a player's prominence in the passing network based on their position on the pitch.

**Key Findings:**
- Central defenders consistently exhibit the highest structural importance across almost all formations.
- Strikers and wingers display greater "offensive positioning influence" specifically in 1-4-3-3 and 1-3-4-3 systems.
- In matches that the team won, wingers exhibited significantly higher "Degree Prestige" (they were targeted more often by teammates) compared to matches that were lost.

**Base Network Science Applications:**
- Directed graphs through player-to-player interactions
- Degree centrality (out-degree) used measure how many passes a player makes (representing their role as a distributor).
- Degree prestiage (in-degree) used to measure how many passes a player receives (representing their role as a target/focal point).
- Proximity Prestige (in-closeness centrality) A measure of how easily a node can be reached by all other nodes in the network. In football, high proximity prestige for a striker means the rest of the team can transition the ball to them efficiently.

---

<br>
<br>
<br>

#### Exploring team dynamics through network analysis: A season review of an elite Portuguese soccer team (2025)
macro-level metrics of an entire team across a 34-match season. aims to see how the holistic shape of the team’s passing network changes based on tactical systems and whether they win or lose

**Key Findings:**
- Network density was significantly higher in lost matches. Domain interpetation might be that seem was stick to safe, repetitive passing patterns. 
- Matches won were characterized by higher clustering coefficients, indicating effective localized triangles and a more interconnected team effort.
- Tactical systems altered network density (how many passes happened), but not clustering (the localized cohesion remained stable regardless of the formation).

**Base Network Science Concepts Applied:**
- Adjacency Matrices for constructing mathematical tables to quantify player interconnections prior to visualizing the graph.
- Network Density via the ratio of actual connections (passes between specific players) to the total possible connections. (e.g., Did everyone pass to everyone, or did the team only use half their potential connections?).
- Clustering Coefficient (Transitivity): A textbook concept measuring the tendency of nodes to cluster together. In football, if Player A passes to Player B, and Player B passes to Player C, how likely is it that Player C passes back to Player A? High clustering represents strong "triangles" on the pitch, a staple of possession-based football (like Pep Guardiola's Tiki-Taka).

---

<br>
<br>
<br>

#### Network analysis of offensive dynamics in a Portuguese first division football team: insights from the 2020-2021 season (2025)

phase-analysis. applying network science exclusively to sequences of play that resulted in a shot on goal. Instead of looking at every pass in the match, it filters the network to only observe successful offensive build-ups.

**Key Findings:**
- By isolating offensive chains, the study identified 914 crucial intra-team interactions leading to shots over the season.
- A specific central midfielder and a forward emerged as the absolute key nodes in these specialized sub-networks.
- The overall structure (density and clustering) of these offensive networks remained stable; there were no significant statistical drops in team cohesion between the first and second halves of the season.

**Base Network Science Concepts Applied:**
- Network Filtering/Sub-graphs: extract a specific sub-network (shot-creating actions) from a massive, noisy global network (all match passes) to find signal-in-the-noise.
- Hub Identification: Using metrics to find the "critical nodes."
- Network Stationarity: Assessing whether the statistical properties of a network remain stable over time (comparing the first half of a season to the second).

---



