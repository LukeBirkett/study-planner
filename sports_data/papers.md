# Football Data Related Papers

1. [From Broadcast to Minimap: Achieving State-of-the-Art SoccerNet Game State Reconstruction (Golovkin et al., 2025)](#from-broadcast-to-minimap-achieving-state-of-the-art-soccernet-game-state-reconstruction-golovkin-et-al-2025)
---
2. [Actions Speak Louder Than Goals: Valuing Player Actions in Soccer (Decroos et al., 2019)](#actions-speak-louder-than-goals-valuing-player-actions-in-soccer-decroos-et-al-2019)
---
3. [Beyond Scouting: A Deeper Data Dive into Football (Spearman, 2018)](#beyond-scouting-a-deeper-data-dive-into-football-spearman-2018)
---
4. [A public data set of spatio-temporal match events in soccer competitions (Pappalardo et al. 2019)](#a-public-data-set-of-spatio-temporal-match-events-in-soccer-competitions-pappalardo-et-al-2019)
---

<br>
<br>
<br>

## From Broadcast to Minimap: Achieving State-of-the-Art SoccerNet Game State Reconstruction (Golovkin et al., 2025)
*Creating own data*

This paper works on the SoccerNet dataset. Instead of using pure math/physics interpolation like Penn, it uses a deep learning pipeline to look at broadcast video, automatically calibrate the pitch lines, detect the players, and map them onto a 2D 2D coordinate system ("minimap") (Shi et al., 2022). It deals heavily with player re-identification when players leave and re-enter the TV screen.

> Golovkin, V., Nemtsev, N., Shandyba, V., Udin, O., Kasatkin, N., Kononov, P., Afanasiev, A., Ulasen, S. and Boiarov, A., 2025. From Broadcast to Minimap: Achieving State-of-the-Art SoccerNet Game State Reconstruction. In Proceedings of the Computer Vision and Pattern Recognition Conference (pp. 6028-6038).

<br>
<br>

---

## "Actions Speak Louder Than Goals: Valuing Player Actions in Soccer" (Decroos et al., 2019)
*Seminal paper on next event prediction*

This paper introduced VAEP (Valuing Actions by Estimating Probabilities). It is the gold standard for how to take discrete event data (like StatsBomb) and use machine learning to predict what happens next. Penn uses similar logic to determine the intent of a player between snapshots.

> Decroos, T., Bransen, L., Van Haaren, J. and Davis, J., 2019, July. Actions speak louder than goals: Valuing player actions in soccer. In Proceedings of the 25th ACM SIGKDD international conference on knowledge discovery & data mining (pp. 1851-1861).

<br>
<br>

---

## "Beyond Scouting: A Deeper Data Dive into Football" (Spearman, 2018)
*Foundational physics based spatial model*

Written by William Spearman (the former lead data scientist at Liverpool FC), this created the concept of Pitch Control. It calculates which player will reach a ball first based on their current velocity and physics. Penn’s paper uses these exact physics boundaries (maximum running speed, acceleration constraints) to interpolate the missing paths between StatsBomb 360 frames (Penn et al., 2023).

> Spearman, W., 2018, February. Beyond expected goals. In Proceedings of the 12th MIT sloan sports analytics conference (pp. 1-17).

<br>
<br>

---

## A public data set of spatio-temporal match events in soccer competitions (Pappalardo et al. 2019)

A derivation of WyScout event data. Purpose of the paper was to tackle reproducibility and standardization in football analytics. 

> Pappalardo, L., Cintia, P., Rossi, A., Massucco, E., Ferragina, P., Pedreschi, D. and Giannotti, F., 2019. A public data set of spatio-temporal match events in soccer competitions. Scientific data, 6(1), p.236.

<br>
<br>

---