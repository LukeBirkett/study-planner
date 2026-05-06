Enormous graphs are classifcal representation of Network Science but profound insights can come from small but dense networks where the quality and frequency of interactions matter more than the sheer volume of nodes.

---

High level approaches: 
- Don't just describe, compare. Compare a highly structured team (like 2011 Barcelona) against a highly chaotic, direct team.
- Use Null Models. Generate Erdős–Rényi or Configuration Model graphs with the same number of nodes/edges as your football network. Show that the football network’s properties (like high clustering) are statistically significant and not just a result of random chance.
- Temporal Dynamics. Look at how the network evolves during a match. Does the network become more or less centralized as the game reaches the 80th minute?

---

In a football network, the **degree** is the number of unique teammates a player interacts with, while the strength (weighted degree) is the total volume of those interactions.

**Degree Distribution:** In a "Total Football" system (like Ajax or prime Barcelona), the distribution is **Homogeneous**. Every player has a similar degree because the system is decentralized.

**Heavy-Tails:** In a "Star-based" system (e.g., a team built entirely around a single playmaker), you see a **Heavy-Tail** or "Hub-and-Spoke" distribution. One node has a massive degree/strength, while the others are significantly lower.

Strictly speaking, an 11-node network cannot be "Scale-Free" (which requires $N \to \infty$ and a power-law $k^{-\gamma}$), but it can be **Small-World**.

**Small-Worldness:** You calculate this by comparing the **Average Path Length ($L$)** and the **Clustering Coefficient ($C$)** of the team against a random graph (Erdős–Rényi) of the same size.

**The Insight:** High clustering + short paths = a highly efficient team where information (the ball) moves rapidly between any two nodes.

**Degree Assortativity:** Do high-degree players (midfielders) mostly pass to other high-degree players (**Assortative**), or do they "feed" low-degree players like strikers (**Disassortative**)?

**Multiplex Assortativity:** This is the big one. If you have a Passing Layer and a Defensive Layer, you measure **Pearson Correlation** between a node's degree in Layer A and its degree in Layer B.
- High Inter-layer Assortativity: The "Workhorses" (e.g., Rodri) who are hubs in both layers.
- Low Inter-layer Assortativity: Tactical specialists (e.g., Haaland) who are hubs in the attack but "ghosts" in the defensive network.

In a football match, you almost always have a **Fully Connected Graph** (one Giant Component), because every player is eventually connected to the ball. However, the LLC becomes interesting if you apply a **Threshold**.
- **Percolation Analysis:** Imagine you only keep edges where players shared more than 5 passes. As you raise this threshold, the network starts to fragment.
- **The Question:** At what "Passing Weight" does the team's LLC break apart?
    - A resilient team stays as one LLC even at high thresholds (everyone is connected to everyone).
    - A fragile team fragments quickly into "islands" (e.g., the defense is a clique, the attack is a clique, but the bridge between them is weak).

Instead of just saying "the network is assortative," you can say: "The team exhibits high disassortativity, suggesting a hierarchical structure where central midfielders act as distributors to peripheral attackers, making the system efficient but susceptible to targeted attacks on the midfield hubs."

---

"Bottom-Up Structural Deconstruction" of a football match.

By starting with the "atoms" of the game (individual passes) and building up to "complex molecules" (multiplex layers), you aren't just analyzing a game; you are validating the entire field of Network Science using football as your laboratory.

#### Phase 1: The Monolayer (The "Anatomy" of a Team)
Start with the simplest form: a directed, weighted passing network of a single high-profile match (e.g., a Champions League Final).
- **The Dataset Card:** You describe your scraping/parsing of event data.
- **The "Intuition" Check:** Fans say "everything goes through the holding midfielder." You prove it by showing a heavy-tailed strength distribution where that player is the primary hub.
- **The Nuance:** Apply **k-core decomposition**. This identifies the "engine room" of the team—the sub-graph of players who are all intensely connected to each other, excluding the "peripheral" strikers or keepers.

#### Phase 2: Resilience and Fragmentation (The "Stress Test")
This is where you move from description to **Structural Analysis**.
- **Concept:** Percolation and Targeted Attacks.
- **The Experiment:** Mathematically "remove" the player with the highest **Betweenness Centrality**.
- **The "Intuition" Check:** Fans call this "marking a player out of the game." You quantify the damage by measuring the increase in **Average Path Length** — showing how much harder it becomes for the ball to travel from defense to attack without that bridge.

#### Phase 3: The Multiplex (The "Synthesis")
Now, you "knit" the layers together. You introduce a second layer: **Defensive Cover**.
- **The Layer:** An edge exists between two players if they successfully "switched" markers or covered for each other's vacated space.
- **Concept:** Inter-layer Assortativity.
- **The "Intuition" Check:** We often say a team is "disconnected"—great going forward but a mess at the back.
- **The Science:** You prove this by showing low degree correlation between the Passing Layer and the Defensive Layer. If the same players aren't hubs in both, the team lacks "Tactical Synchronicity."


#### Phase 4: Dynamics as a Probe (The "Searchlight")
Finally, use a process like **Random Walks** to reveal hidden structures.
- **Concept:** Community Detection (e.g., Louvain Method).
- **The Experiment:** Run a random walk on the passing network to see where the ball "gets stuck."
- **The Result:** The algorithm might naturally find "triangles" (e.g., the Left-Back, Left-Winger, and Left-Midfielder). This reveals the **Functional Modules** of the team that exist independently of their starting positions on paper.

---

- **Clarity (25%):** It tells a story of increasing complexity.
- **Soundness (30%):** You aren't just using one tool; you are using the entire toolkit (Centrality, k-core, Percolation, Multiplexing).
- **Insight (30%):** You are taking "pundit-speak" (e.g., "They lost their shape") and giving it a mathematical definition (e.g., "The network underwent a phase transition into fragmented components").

---

In Network Science, a null model helps you answer the "So What?" question. If you find that a team has a high Clustering Coefficient, is that because they are tactically brilliant, or is it just a mathematical necessity because every player is forced to pass to their nearest neighbors?

### 1. The Erdős–Rényi (Random) Null Model
This is the "Zero-Intelligence" baseline. You create a random graph with the same number of nodes ($N=11$) and the same number of edges ($L$) as your football team.
- **The Test:** Compare the Average Path Length of the real team to the random graph.
- **The Insight:** If the real team’s path length is significantly shorter than the random version, you have identified a Small-World property. It proves the team’s structure is optimized for speed of ball movement beyond what would happen by chance.

### 2. The Configuration Model (Degree-Preserving Randomization)
This is much more sophisticated. You take your team's network and "rewire" the edges. If Player A had 50 passes and Player B had 10, the rewired network keeps those exact totals, but swaps who they passed to.
- **The Test:** Compare the Assortativity of the real network vs. 1,000 rewired versions.
- **The Insight:** If the real team is more "Assortative" (stars passing to stars) than the null models, you’ve proven that the "chemistry" between top players is a deliberate tactical choice, not just a byproduct of them being on the pitch a long time.

### 3. Spatial Null Models (The "Geometry" Check)
Football is played on a 2D plane. Naturally, a Left Back is more likely to pass to a Left Winger simply because they are 10 meters apart.
- **The Test:** Create a null model where the probability of an edge existing between two players is purely a function of their average distance on the pitch (Gravity Model).
- **The Insight:** This allows you to find "Hidden Links." If two players pass to each other way more than the spatial null model predicts (e.g., a cross-field diagonal ball from a Right Back to a Left Winger), that edge is "statistically significant." It represents a tactical instruction that defies the natural geometry of the pitch.

---

### Implementing the "Z-Score"
To put this into your report, you wouldn't just show a picture. You would calculate a Z-score for a metric (like the Clustering Coefficient $C$):

$$Z = \frac{C_{real} - \langle C_{null} \rangle}{\sigma_{null}}$$

- If $Z > 2$, the tactical structure you found is highly significant.
- If $Z \approx 0$, the team's "network" is effectively random noise.

If you analyze a game and find that "the midfielders are central," a cynical marker might say "well, obviously." But if you use a **Configuration Null Model** to show that their centrality is 3 standard deviations higher than expected given their total pass volume, you have moved from "stating the obvious" to "statistical proof of tactical intent."

--- 

### Using a Configuration Null Model to show that their centrality is 3 standard deviations higher than expected given their total pass volume
To achieve this, you are essentially performing a Permutation Test. You want to prove that a player's importance isn't just because they "touched the ball a lot," but because of how they were integrated into the specific topology of the team.

Imagine each player has "stubs" (half-edges) representing their total passes. You cut all the passes in the middle and start tying the stubs together at random. This preserves the "volume" (pass counts) but destroys the "tactical intent" (who they chose to pass to).

Using a library like NetworkX, the process looks like this:
1. **Calculate the Observed Metric:** Measure the Centrality ($C_{obs}$) for your player of interest (e.g., Eigenvector Centrality) in the real match network.
2. **Generate the Ensemble:** Use a loop to create 1,000 randomized versions of your network using the directed_configuration_model or by repeatedly "swapping" edges.
3. **Collect Null Metrics:** In each of those 1,000 random networks, calculate the centrality for that same player. This gives you a Null Distribution.
4. **Statistical Comparison:** Calculate the Mean ($\mu$) and Standard Deviation ($\sigma$) of that distribution.

**Calculating the Z-Score:** The Z-score is your "Master’s level" proof. It tells you how many standard deviations the real tactical role is away from a "randomly wired" role with the same volume.

$$Z = \frac{C_{obs} - \mu_{null}}{\sigma_{null}}$$
- **If $Z > 3$:** There is a less than 0.3% chance this player's centrality happened by accident. You can confidently claim this player is a **Tactical Pivot** — their importance is a result of specific coaching instructions or exceptional spatial awareness, not just being "the guy who gets the ball."
- **If $Z \approx 0$:** The player is just a "Volume Recycler." They have high centrality only because they have a high pass count, but they aren't doing anything structurally unique with those passes.

In a Configuration Model, the math might accidentally suggest a player passes to themselves. In a real football network, this is impossible.
- **Correction:** When generating your null models, you must "clean" the graph to remove self-loops and ensure it remains a **simple directed graph**. Most Network Science libraries have a simplify() function or a flag to prevent this during rewiring.

> "While Rodri had the highest pass volume, his Eigenvector Centrality produced a Z-score of +3.42 against a degree-preserving Configuration Null Model ($n=1000$). This indicates that his structural importance to the team's progression exceeds what would be expected from his raw activity levels alone, suggesting a deliberate tactical centralization of the build-up phase through his node."

---

## Applying a Config Model to a Directed and Wighted Network, i.e. PassMap
In a basic network, you just swap edges. In a **weighted** network, you have to preserve two things: the topology (who is connected to whom) and the **weight distribution** (how many passes each player made).

### The "Strength-Preserving" Rewiring
In football, we don't just care about the existence of a link; we care about the **strength** (the number of passes). To create a null model here, you use a **Weight-Shuffling** approach.
- **Step A:** You keep the "skeleton" of the network exactly as it is (who passed to whom stays the same).
- **Step B:** You take all the weights (the number of passes on every edge) and put them in a "bucket."
- **Step C:** You redistribute those weights randomly across the existing edges.
- **The Insight:** This tells you if the intensity of certain passing lanes (like a specific "Left-Back to Left-Winger" connection) is significant, or if the team just spreads its total passing volume randomly across its usual shape.

### 2. The Directed Configuration Model (The "Stubs" Method)
If you want to randomize the **structure** while keeping the player's total activity constant, you use the "Half-Edge" or "Stub" method. This is more rigorous for a Master's level paper.

Imagine each player node has two types of "connectors" sticking out of them:
- **Out-Stubs:** Representing every pass they made (Out-degree).
- **In-Stubs:** Representing every pass they received (In-degree).

The Process:
- **Deconstruct:** You literally "break" every pass in the match. If Rodri made 60 passes, he now has 60 "Out-Stubs" hanging off him. If Haaland received 10 passes, he has 10 "In-Stubs."
- **Reconnect:** You randomly pick one Out-Stub and one In-Stub from the entire team and tie them together to form a completed pass.
- **Constraints:** You program the model to reject "Self-loops" (passing to oneself) and, usually, to ensure it remains a directed graph.

### 3. Handling the "Weight" in the Configuration Model
Since a passing map is essentially a **Multigraph** (multiple edges between the same two nodes), the Configuration Model handles weights naturally:
- In the randomizing process, you might end up picking an Out-Stub from Player A and an In-Stub from Player B five times.
- In your final Null Network, that becomes a **Weighted Edge** with a value of 5.

### 4. Why this matters for your Analysis
When you "unpack" this in your report, you are testing **Tactical Intent**.

If you calculate the **Clustering Coefficient** (the tendency for players to form passing triangles):
- **Real Network:** High Clustering (e.g., $0.6$)
- **Null Model:** If the 1,000 randomized "Stub" networks have an average clustering of $0.2$.
- **Interpretation:** You have proven that "Triangles" in this team aren't just a result of players passing a lot; they are a **deliberate structural feature** of the manager's tactics. The "stubs" could have connected in a way that didn't form triangles, but in the real match, they did.

---

## How to describe this in your "Dataset Card" or Methodology:
You should specify that you used a "Directed Weighted Configuration Model." This shows you understand that:
1. Direction matters (A passing to B is not the same as B passing to A).
2. Volume matters (Weight).
3. Individual activity levels must be preserved (Degree Sequence).


