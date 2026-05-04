# Advanced NLP Advanced Exam Cheatsheet


## Lecical and Distribution Semantics
*Week 1 & Week 4*


### Lexical Semantics

#### Key Words

| Term | Definition | 
| :--- | :--- |
| **Ambiguity** | Most common words possess multiple senses, which dictionaries attempt to enumerate and define . |
| **Homonymy** | This refers to broad distinctions between meanings that share the same spelling/sound but have unrelated origins (e.g., plant as a living organism vs. plant as a factory) |
| **Polysemy** | This refers to fine-grained, related distinctions within a single word (e.g., book as a physical object vs. book as a set of accounts) |
| **Dictionary Variation** | Different resources (WordNet vs. Oxford) often disagree on the exact number of senses for a word due to the difficulty of drawing these boundaries |
| **Antonymy** | Words with opposite meanings. Paradoxically, antonyms are semantically very similar as they usually share all features except for one specific dimension, like temperature (hot/cold) or direction (rise/fall). |
| **Hyponymy & Hypernymy** | These capture ISA-relationships (class inclusion). A Hyponym is a subclass (e.g., poodle is a hyponym of dog). A Hypernym is a superclass (e.g., animal is a hypernym of dog). |
| **Meronymy & Holonymy** | These represent Part-Whole relationships (e.g., wheel is a meronym of car). |
| **Synsets** | The core unit of WordNet. It is a set of synonymous word senses (e.g., {plant, flora, plant life}). Each synset is associated with one distinct definition; polysemous words appear in multiple synsets. |
| **Hierarchical Organization** | Synsets are primarily connected via hyponymy, creating a tree-like structure where general concepts are at the top and specific instances are at the leaves. |
---


#### Semantic Similarity Measures


| Measure | Formula | Definition |
| :--- | :--- | :--- |
| Path Length Similarity | $sim_{path}(c_1, c_2) = \frac{1}{\text{path\_length}(c_1, c_2)}$ | Count edges between two synsets. Over 1 to turn compute the inverse where 1 is max and score decreases as you get further away | 
| Information Content |  $IC(c) = -\log P(c)$ | Based on the probability of a concept appearing in a corpus. Frequent, general concepts (like vertebrate) have high probability and low IC; rare, specific concepts (like poodle) have low probability and high IC. | 
| Concept Probability | $P(c) = \frac{\text{freq}(c)}{N}$ | The frequency of a concept $c$ is the sum of the frequencies of that concept and all of its descendants in the hierarchy. Where $N$ is the total number of concepts in the corpus (Total Corpus Size ($N$)). | 
| Lowest Common Subsumer (LCS) | $\frac{\text{freq}(LCS) + \sum \text{freq}(\text{all descendants})}{N}$ | The most specific ancestor that two concepts share. Note, the formula here is how to calculate the LCS for something that its not a leaf in the tree. It tells us that to calculate the freq, we need to take into account the freq of the entity (LCS in this case) and all of its dependents. This is why high entities have just a low IC because their freq and therefore probability is cumulative of many entities. There would be the exact "formuila" for an LCS: $LCS(c_1, c_2) = \text{argmin}_{d \in \text{anc}(c_1) \cap \text{anc}(c_2)} \text{dist}(\text{root}, d)$ | 
| Resnik | $sim_{resnik}(c_1, c_2) = IC(LCS(c_1, c_2))$ | Similarity of two concepts is determined by the information they share, represented by their LCS directly. If the most specific thing two words share is a very general concept, they aren't very similar. If their shared ancestor is very specific (high IC), they are highly similar. | 
| Lin | $sim_{lin}(c_1, c_2) = \frac{2 \times IC(LCS(c_1, c_2))}{IC(c_1) + IC(c_2)}$ | Tefines Resnik's work by normalizing the shared information by the total information contained in the two individual concepts. This provides a ratio of shared information content to total information content, resulting in a score between 0 and 1 | 
---

### Distributional Semantics
> Words occurring in similar contexts tend to have similar meanings. Unlike Lexical Semantics, which relies on human-curated dictionaries, this method "bootstraps" meaning directly from large bodies of text (corpora). In practice, this means representing a word as a mathematical vector based on the counts of other words (features) that appear near it within a defined context window. Vectors can then be "compared" using methods like Cosine Similarity. The vectors should be related because they share "facets of meaning".

| Term | Formula | Definition | 
| :--- | :--- | :--- |
| Distributional Hypothesis |  | The core hypothesis posits that words occurring in similar contexts tend to possess similar meanings. Allows for bootstrapping, a process where the meaning of an unknown word can be inferred by observing its co-occurrence with known words |
| Facets of Meaning |  | Words share different dimensions of meaning based on their roles. For example, banana and credit card both share the facet of "being eaten" if they appear as objects of the verb eat. |
| Context Windows |  | Capture features by looking at a fixed number of words ($\pm m$) around a target word. Small captures local, syntactic and functional. Large cpatures topical and thematic |
| Co-Occurance Vector |  | Once we count co-occurrences, we represent each word as a high-dimensional vector (or distributional representation) |
| Cosine Similarity | $sim(w_1, w_2) = \cos(\theta) = \frac{\vec{a} \cdot \vec{b}}{\|\vec{a}\|*\|\vec{b}\|}$ | Measure How Similar two word vectors are. Looks at angle rather than distance. Small angle, high cosine, high similarirty. A 90° angle (zero cosine) means no similarity |
| Weighting Features (PMI and PPMI) |  | Raw counts are often misleading because common words (like the or is) appear frequently with everything but carry little information |
| Pointwise Mutual Information (PMI) | $PMI(w, f) = \log \frac{P(w, f)}{P(w)P(f)}$ | Measures whether a word and a feature co-occur more often than would be expected by chance. |
| Joint Probability | $P(w, f) = \frac{\text{count}(w, f)}{N}$ | The probability that the word $w$ and the feature $f$ appear together in the same context (e.g., the same sentence or window) |
| Marginal Probability of $x$ | $P(x) = \frac{\text{count}(w)}{N}$ | How often word $w$ appears regardless of what feature it's with. |
| Positive PMI (PPMI) | $PPMI(w, f) = \max(0, PMI(w, f))$ | We rarely use raw PMI because it behaves poorly with negative numbers (it's hard to interpret what "mathematical repulsion" means for a word model). PPMI replaces all negative PMI values with 0, focusing only on the positive associations that provide meaningful semantic features. |





---

#### How to Compute PMI
1. **Build a Co-occurrence Matrix:** Create a table where rows are words and columns are features. Fill the cells with the raw frequency of co-occurrence.
2. Calculate Marginals:
    - Sum the rows to get the total frequency of each word ($w$)
    - Sum the columns to get the total frequency of each feature ($f$)
    - Sum the entire table to get the total number of observations ($N$)
3. Apply the "Ratio of Reality vs. Chance":
    - The denominator $P(w)P(f)$ represents the "Chance" model — what you'd expect if the words were independent.
    - The numerator $P(w, f)$ is the "Reality" — what actually happened in your text.
4. **Logarithm Transformation:** The $\log$ is applied so that if the words occur exactly as much as chance predicts, the result is 0. Positive values mean they are "attracted" to each other; negative values mean they "repel" each other.

> PMI measures the strength of association. If $PMI > 0$, the word and feature are semantically related (like "Doctor" and "Hospital"). If $PMI \approx 0$, their co-occurrence is purely coincidental (like "The" and "Hospital"). By breaking the formula down into Joint Probability divided by the Product of Marginals, we mathematically isolate how much the presence of one tells us about the presence of the other.

---

#### Challenges in Distributional Semantics
**Word Ambiguity:** Vectors represent the word (the string), not the sense. A vector for bow is a "mush" of its ribbon, weapon, and ship meanings.

**Semantic Relationships:** Distributional models find "related" words, but not necessarily synonyms. Antonyms often appear in identical contexts (e.g., hot and cold), making them appear highly similar.

**Sparsity (Zipf's Law):** Most words occur very rarely (Hapax Legomena). This results in massive vectors filled with zeros, making them difficult to compare.

---

## Language Modelling
*Week 2*

- n-gram: fixes history
- MLE: Uses to calculate the probabilites of words using a training corpus and calculating frequences. 

$$P(w_i \mid w_{i-(n-1)}, \dots, w_{i-1}) = \frac{freq(all\ n\ words\ together)}{freq(the\ previous\ n-1\ words)}$$

In this context, if you see the phrase "the cat sat" 10 times in your data, and 6 of those times the next word is "on," the MLE estimate for $P(on \mid the, cat, sat)$ is $6/10 = 0.6$. This is the "best guess" the model can make based solely on the evidence it has seen in its training text.

- unigram = 1 (itself), bi-gram = 2 (previous word)
- Use Logarithmic Addition instead of Products of Probabilties due to **numerical stability** and **computational efficiency**
- **Extrinsic Evaluation:** evaluate a model by applying it to a task, i.e. spelling, translation, speech recognition. You run the task and get an accuracy for each model. 
- **Intrinstic Evaluation:** measures the model's quality in **isolation**, based on its **internal properties**. goal is to see how well the model has learned the underlying patterns of the language itself rather than how well it helps a spellchecker or translator.


The best language model is one that best predicts an unseen test set, i.e. it returns the highest `P(sentences)`
- **Perplexity:**  we look at the probability it assigns to a test set of words. Essentially, perplexity is the inverse probability of the test set, normalized by the number of words. 
- A **lower** perplexity score indicates that the model is **less "surprised"** by the test data, meaning it has a better grasp of the language's structure. If **high** then the model is **"confused"** and the test data was **unexpected**.

$$PP(W) = P(w_1, w_2, w_3, ..., w_N)^{-1/N}$$

This formula can also be converted to logarithms to maintain numerical stablility:

$$PP(W) = e^{-1/N \log P(w_1, w_2, w_3, ..., w_N)}$$

Because **Perplexity** is the inverse of probability, minimising perplexity is the same as maximising probability. 

- **N-gram Generalisation:** Refer to **shannon-visualations** is the notes. Bulding a co-occurance table and chaining the outputs. 
- **Smoothing:** We due this due to sparsity. 0 freqs break calculations. We can "steal" probability mass from observed events to generalise to unobserved. Smoothing as lowering peaks or increase (or populating) the troughs.
    - Add-One Estimation (Laplace Smoothing): Record everything once.
    - Unk Token: Combined freq token for all OOV words. Can extend to bigrams. 

- **Absolute Discounting Interpolation:** Refer to notes

---

## Neural Language Modelling







## Neural Language Modelling
*Week 3*

- ealriest nn; feed-forward neural lang model; bengio; input one-hot; embedding layer, higgen layer; predict next word
- adv; able to generalise over context of similar words due to embeddings (compared to cooruance); doesn't need smoothing; can handle long hists;
- dis;
- where to get embeddings from; start one-hot
- rnns; mikoov; 
- unrolling rnn and lstms; short-term and long term memory through cell state
- Gates;
- Stacked; deep learning; diff layers indivude diff reps;
- bi-dir rnns;
- problems for word-based nmls; sparsity; embedding issues; can generaise but how well is sprase
- char level; convs; learn morpgolocial info; compose low freq words


- lstm + diagrams; gates; (same for rnn)