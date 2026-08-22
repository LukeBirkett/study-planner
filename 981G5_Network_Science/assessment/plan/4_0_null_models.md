# The Null Model Dilemma: Standard vs. Spatially Constrained
- What is a Null Model
- Why standard topological nulls fail when applied to PassMaps
- Why spatial constraints are so important

---

Gemini:
A true null model requires purposefully destroying specific empirical correlations to create a "baseline of randomness."

To make a null model, you do not want to replicate the team's actual play; you want to see what the network would look like if the players were passing based purely on chance (or constrained only by basic rules, like spatial distance or degree sequence), stripping away tactical intent.

---

"Future studies should also employ null models and random network comparisons to establish baselines for spectral gap, entropy rate, and other indices, enabling more robust interpretation of observed values. [45,46]" (Gama, 2026, stoch)
- 45. Fiedler M. Algebraic connectivity of graphs. Czech Math J 1973; 23(2): 298–305.
- 46. Chung FRK. Spectral graph theory. American Mathematical Society, 1997.


---

"However, these null models must incorporate the particular features of the system they are describing, and the Euclidean position of the nodes and temporal evolution should be taken into account (Sarzynska et al., 2016)." (Buldu, 2018) 
- This is why simple Erdős–Rényi or unconstrained topological shuffles break down as they ignore node geometry and Euclidean space.

---

"Note that this fact could be produced by the network organization or just being a consequence of having a higher number of passes, which reduces the overall topological distance of the links and, consequently, the value of $d$."
> Note, this is an important point for the need for null models 

---

#### Evaluation: Matching Football Expectations
"null models for passing networks must be as realistic as possible and include the intrinsic features of the game such as the degree distribution, length of the passes and positions of the players in the pitch." (Buldu, 2018) 
- This provides a checklist of parameters to fulfill when building an "adequate" null model. They must must preserve degree distribution (who passes), pass lengths (distance decay), and pitch positions $(\bar{x}, \bar{y})$. 
- In classical network science, "preserving the degree distribution" means keeping each node's exact number of edges (passes made and received) strictly fixed during randomization.
- For example, in rewiring approaches, if the Central Midfielder made $60$ passes and received $40$ passes in the real match, every single synthetic null network generated must give that Central Midfielder exactly $60$ outgoing and $40$ incoming passes.
- The footballing problem is that if you rewire stubs randomely, you peserve players pass volumne but create physically unlikely cominations because the rewrire ignores player coordinates $(x, y)$. 
- When Buldú et al. (2018) state that null models must include "the intrinsic features of the game such as the degree distribution", they are referring to a probabilistic or expected range constraints. 
- Sticking with the central midfield asppect, we expect them to have natually high degrees, whilst goalkeepers or goal poachers will be low(er). A valid null model cannot create unrealistic tactic roles. 
- The null process should therefore be abot matching expectation. Rather than forcing Player $i$ to have exactly $60$ passes every single time, a generative process samples from a learned probability distribution of what a player in that position/formation typically produces.

---

## The "Space-Blind" Matrix Permutation Fallacy
To establish statistical significance on single or low-sample matches, network science historically relies on matrix permutation tests (shuffling the rows and columns of a team's directed $11 \times 11$ passing matrix).

Gama et al. explicitly self-identified the core limitation of this approach: their topological model “does not explicitly incorporate spatial coordinates or player movement trajectories”.

Real-world passing frequency is heavily dictated by physical proximity. Shuffling an adjacency matrix breaks specific player links while preserving macro-volume, but it treats players as abstract, ungrounded nodes

A standard matrix permutation test creates a naive, space-blind baseline filled with physically impossible long-distance passes (e.g., expecting a Right-Back to pass to a Left-Winger as frequently as to the Right-Winger). It compares real football against an abstract topological fantasy rather than a spatially constrained physical reality.

---

## Number of Passes
As Buldu (2019) highest, we are comparing networks with the same number of nodes (11) but links with different weights (number of passes). Given the toplogical constraints of the network, this has conqueences in that the distances of two directly connected players is given by the inverse of the number of passes between them. A higher number of team passes invariable leadsd to a higher average number of connections between players. Therefore, the comparison of two networks with a different number of total degrees (passes), hinder the role played by the network topology itself. Given we cannot seperate the effect of the number of passes from the topology itself, we cannot say if the network is "better" organised. 

This entirely leads into the reason for needing null baselines, and specifically, a process to generate a suite of nulls given a particular set of topologlical inputs, i.e. total degrees, formations and therefore player roles/positions. 

---


### Small Networks Issue:
**Sports science treats Social Network Analysis (SNA)** as an advanced "box-score" indicator to correlate against wins/losses, whereas physics/network science treats networks as complex systems requiring reference ensembles.

Standard graph theory null models assume $N \to \infty$. When $N=11$, standard degree-preserving shuffles offer almost zero valid topological variations without breaking down.

Unconstrained random networks create an absurd baseline (e.g., a Goalkeeper passing to a Striker as often as a Center-Back). Because naive nulls are trivially easy to reject, sports researchers abandoned them entirely rather than building spatially constrained nulls.

---

### Perms, Empirical, Generative
Why Matrix Permutations Fail: Standard matrix shuffles preserve total pass volume but ignore spatial coordinates $(x, y)$, creating a naive baseline with physically impossible long-distance passes.  Why 

Empirical Filter Baselines Fail: Filtering real match data for specific contexts (e.g., high-passing 4-3-3 games) causes extreme data sparsity, resulting in statistical overfitting.  

Solution: A conditioned generative null model trained on season-wide event data. It synthesizes context-aware, spatially constrained null networks that isolate true tactical execution without data dilution. 

---

### Generative Process
Gama (2026) acklowledge that a **larger dataset** is needed to run resampling methods (matrix permutation) to establish a baseline and therefore determine if observed variations reflect tactical adaptations or normal match-to-match noise.

This isn't to say that they would use more matches to conduct their analysis, they used N=2 matches. Instead, the large amount of data would be used to construct a obust generative process which could be used to generate 1000 null models from which the network ppropeties of interest could be computed and the range of values recorded. 

The analtsis from the n=2 amtchs would then be compare to the range and its interest consdiered based on where it sat in the null range. if it is in the 1SD then it is just normal. 

The goal is to extract the topological/constrained baseline to make meaningful inference on the tactical/performance aspect.

