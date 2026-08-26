

#### Appendix DTable 4: Sample Network, Average Shortest Path Metrics
| Player | Position | Mean Outward Distance ($d_{\text{out}}$) | Mean Inward Distance ($d_{\text{in}}$) | Structural Role & Tactical Insight |
|---|---|---|---|---|
| Carlotte Wubben-Moy | LCB | 0.1066 | 0.1335 | Primary Network Anchor: Lowest $d_{\text{out}}$ team-wide; acts as the primary distributor in initial build-up. |
| Kim Little | LDM | 0.1092 | 0.1341 | Central Engine: Exceptional bilateral efficiency; serves as the primary midfield conduit connecting deep defense to attack. |
| Leah Williamson | RCB | 0.1106 | 0.1422 | Deep Ball-Progressor: Pairs with Wubben-Moy to form a highly accessible central defensive base. |
| Stephanie-Elise Catley | LB | 0.1229 | 0.1480 | Flank Initiator: Stronger outward efficiency than right-sided counterparts, showing a left-leaning bias in possession. |
| Victoria Pelova | RDM | 0.1336 | 0.1500 | Secondary Pivot: Maintains balanced inward/outward flow, facilitating mid-block link play. |
| Emily Ann Fox | RB | 0.1581 | 0.1857 | Wide Outlet: Higher resistance than central defenders, functioning as a wider progression valve. |
| Sabrina D’Angelo | GK | 0.1655 | 0.2433 | Distribution Origin: Maintains low $d_{\text{out}}$ (restarts build-up efficiently) but high $d_{\text{in}}$ (rarely targeted directly under pressure). |
| Alessia Russo | CAM | 0.1893 | 0.1760 | Inverted Hub: Uniquely features $d_{\text{in}} < d_{\text{out}}$, reflecting her role drop-down target between opposition lines. |
| Caitlin Jade Foord | LW | 0.2035 | 0.2088 | High/Wide Winger: High distance metrics reflect terminal positional isolation on the left flank. |
| Bethany Mead | RW | 0.2070 | 0.2118 | High/Wide Winger: Mirrored profile to Foord; operates primarily in final-third isolation. |
| Emma Stina Blackstenius | CF | 0.5664 | 0.3391 | Terminal Target: Extreme $d_{\text{out}}$ (0.5664) and high $d_{\text{in}}$ (0.3391) identify a pure, specialized focal point focused on finishing rather than circulation. |
> maybe pivot this table so players are horizontal. Maybe remove the insight. 
---

#### Table 5: Sample Network, Player Betweenness Centrality ($g(i)$) Scores
| Player | Position | Betweenness Centrality $g(i)$ |
| :--- | :--- | :---: |
| Carlotte Wubben-Moy | Left Center Back | 0.3222 |
| Leah Williamson | Right Center Back | 0.3000 |
| Kim Little | Left Defensive Midfield | 0.1778 |
| Victoria Pelova | Right Defensive Midfield | 0.1389 |
| Stephanie-Elise Catley | Left Back | 0.1222 |
| Sabrina D’Angelo | Goalkeeper | 0.0000 |
| Emma Stina Blackstenius | Center Forward | 0.0000 |
| Alessia Russo | Center Attacking Midfield | 0.0000 |
| Emily Ann Fox | Right Back | 0.0000 |
| Caitlin Jade Foord | Left Wing | 0.0000 |
| Bethany Mead | Right Wing | 0.0000 |

---

#### Figure 4: Sample Network, Betweenness Network Plot
![a passing network plot with node size varied by players Betweenness Centrality g(i)](./figures/bet_node_plot.png)

---


#### Table 7: Top 10 Active Transitive Passing Triads
| Rank | Origin / Target ($A$) | Intermediate ($B$) | Target / Origin ($C$) | Bottleneck Capacity ($W_{\text{min}}$ Pass Units) |
| :---: | :--- | :--- | :--- | :---: |
| **1** | Kim Little | Carlotte Wubben-Moy | Leah Williamson | 116.0 |
| **2** | Stephanie-Elise Catley | Kim Little | Carlotte Wubben-Moy | 111.0 |
| **3** | Stephanie-Elise Catley | Kim Little | Victoria Pelova | 76.0 |
| **4** | Kim Little | Carlotte Wubben-Moy | Victoria Pelova | 69.0 |
| **5** | Kim Little | Victoria Pelova | Leah Williamson | 67.0 |
| **6** | Stephanie-Elise Catley | Carlotte Wubben-Moy | Victoria Pelova | 65.0 |
| **7** | Carlotte Wubben-Moy | Victoria Pelova | Leah Williamson | 60.0 |
| **8** | Victoria Pelova | Leah Williamson | Emily Ann Fox | 55.0 |
| **9** | Kim Little | Alessia Russo | Victoria Pelova | 51.0 |
| **10** | Kim Little | Victoria Pelova | Emily Ann Fox | 51.0 |


#### Table 6: Player-Level Transitive Triad Intensity Summary
| Player | Position | Raw Intensity | Normalized (0–1) | Relative to Max | Tactical & Structural Role |
| :--- | :--- | :---: | :---: | :---: | :--- |
| **Kim Little** | Left Defensive Midfield | 1069.0 | 1.000 | 1.000 | Primary Linkage Hub: Anchors central combinations; highest involvement in progressive triangles. |
| **Victoria Pelova** | Right Defensive Midfield | 927.0 | 0.854 | 0.867 | Double-Pivot Engine: Pairs with Little to form a high-volume central link between defense and attack. |
| **Carlotte Wubben-Moy** | Left Center Back | 864.0 | 0.790 | 0.808 | Deep Circulation Base: High score confirms short, triangular build-up out of the back. |
| **Leah Williamson** | Right Center Back | 814.0 | 0.738 | 0.761 | Right-Sided Base: Complements Wubben-Moy to establish deep defensive triangles. |
| **Stephanie-Elise Catley** | Left Back | 645.0 | 0.565 | 0.603 | Left-Flank Overload: Noticeably outscores Fox (514.0), reflecting a left-leaning build-up preference. |
| **Alessia Russo** | Center Attacking Midfield | 641.0 | 0.561 | 0.600 | Inverted Connector: High score shows she drops deep into central pockets to link mid-block triads. |
| **Emily Ann Fox** | Right Back | 514.0 | 0.430 | 0.481 | Wide Outlet: Secondary wide option in right-sided combination loops. |
| **Bethany Mead** | Right Wing | 450.0 | 0.364 | 0.421 | Final-Third Link: Moderate involvement in localized wide combination play. |
| **Caitlin Jade Foord** | Left Wing | 275.0 | 0.185 | 0.257 | Wide Isolation: Operates primarily as an isolated 1v1 outlet rather than a triad loop hub. |
| **Sabrina D’Angelo** | Goalkeeper | 114.0 | 0.020 | 0.107 | Restricted Origin: Low involvement; acts primarily as a initial reset node rather than a triad bridge. |
| **Emma Stina Blackstenius** | Center Forward | 95.0 | 0.000 | 0.089 | Terminal Endpoint: Lowest score squad-wide (0.000 normalized); functions strictly as a finisher rather than a link player. |

---
