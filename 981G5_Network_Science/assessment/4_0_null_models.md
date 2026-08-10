# The Null Model Dilemma: Standard vs. Spatially Constrained
- What is a Null Model
- Why standard topological nulls fail when applied to PassMaps
- Why spatial constraints are so important

---

"However, these null models must incorporate the particular features of the system they are describing, and the Euclidean position of the nodes and temporal evolution should be taken into account (Sarzynska et al., 2016)." (Buldu, 2018) 
- This is why simple Erdős–Rényi or unconstrained topological shuffles break down as they ignore node geometry and Euclidean space.

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