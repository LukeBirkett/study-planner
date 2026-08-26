
> Include the full translation table from gama et al (2026) in the appendix.


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





#### Appendix X: The Mapping of PLayer Positions to Conddensed Position Set
POSITION_MAP_11 = {
    # Center Backs
    "Center Back": "CB",
    "Left Center Back": "CB",
    "Right Center Back": "CB",
    # Goalkeeper
    "Goalkeeper": "GK",
    # Fullbacks/Wingbacks (Left)
    "Left Back": "LB",
    "Left Wing Back": "LB",
    # Fullbacks/Wingbacks (Right)
    "Right Back": "RB",
    "Right Wing Back": "RB",
    # Defensive/Central Midfielders
    "Left Defensive Midfield": "CM",
    "Center Defensive Midfield": "CM",
    "Right Defensive Midfield": "CM",
    # Central Midfielders
    "Left Center Midfield": "CM",
    "Right Center Midfield": "CM",
    # Attacking Midfielders
    "Center Attacking Midfield": "CAM",
    "Right Attacking Midfield": "CAM",
    "Left Attacking Midfield": "CAM",
    # Strikers/Forwards
    "Center Forward": "ST",
    "Left Center Forward": "ST",
    "Right Center Forward": "ST",
    # Wide Left
    "Left Wing": "LM",
    "Left Midfield": "LM",
    # Wide Right
    "Right Wing": "RM",
    "Right Midfield": "RM",
}



### Appendix X: Original Position Count
           recipient_position  count
0            Left Center Back  11956
1           Right Center Back  10913
2                  Goalkeeper   6730
3                   Left Back   6283
4                  Right Back   5926
5     Left Defensive Midfield   5446
6    Right Defensive Midfield   4997
7              Center Forward   4469
8                   Left Wing   4315
9                  Right Wing   4103
10  Center Defensive Midfield   3532
11       Left Center Midfield   3065
12      Right Center Midfield   2987
13  Center Attacking Midfield   2729
14                Center Back   2675
15             Left Wing Back   2271
16            Right Wing Back   2077
17        Left Center Forward   1349
18       Right Center Forward   1248
19             Right Midfield   1153
20              Left Midfield   1146
21   Right Attacking Midfield    213
22    Left Attacking Midfield    198








##### Appendix X : Change in Pass Share (Empirical vs. Resampled Receptions)
| Player | Original Passes Received (Count) | Original Share (%) | Resampled Passes Received (Count) | Resampled Share (%) |
| :--- | :---: | :---: | :---: | :---: |
| Carlotte Wubben-Moy | 120 | 16.67 | 67 | 9.31 |
| Kim Little | 117 | 16.25 | 106 | 14.72 |
| Leah Williamson | 99 | 13.75 | 66 | 9.17 |
| Victoria Pelova | 92 | 12.78 | 108 | 15.00 |
| Stephanie-Elise Catley | 79 | 10.97 | 70 | 9.72 |
| Alessia Russo | 60 | 8.33 | 25 | 3.47 |
| Emily Ann Fox | 48 | 6.67 | 48 | 6.67 |
| Bethany Mead | 42 | 5.83 | 55 | 7.64 |
| Caitlin Jade Foord | 33 | 4.58 | 65 | 9.03 |
| Sabrina D’Angelo | 19 | 2.64 | 14 | 1.94 |
| Emma Stina Blackstenius | 11 | 1.53 | 96 | 13.33 |



#### Appendix X: League-Wide Striker Pass Execution Summary
| Metric | Value |
| :--- | :---: |
| Total Completed Passes | 89,781 |
| Striker Completed Passes | 4,433 |
| Percentage Completed by Strikers | 4.94% |