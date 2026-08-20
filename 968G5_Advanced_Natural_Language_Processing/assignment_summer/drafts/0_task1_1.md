# 4 Task 1: Propaganda Classification
Task 1 is a single-label, multi-class classification problem targeting instances of recognised but unlabelled propaganda. Experimentally, two non-contextual, static feature representation paradigms are benchmarked: High-dimensional sparse representations derived from frequency-based Bag-of-Words (BoW) modeling against low-dimensional, dense representations from Word2Vec embeddings.

# 4.1 Baseline & Experimental Floor
For model calibration, an unintelligent random-guessing baseline defines the lower bound. For an 8-class balanced target distribution, uniform random selection yields an expected accuracy of $P = \frac{1}{8} = 0.125$ ($12.5\%$). To guarantee reproducibility, a random seed is set: $\text{SEED} = 142$.

---

## 4.2 Methodology & Architecture:

### 4.2.1 Approach 1: Sparse Bag-of-Words (BoW) Vector Representation
Propaganda frequently relies on distinct, emotionally charged trigger words. A unigram Bag-of-Words (BoW) pipeline decomposes text sequences into high-dimensional, orthogonal count vectors. By mapping terms to independent coordinate axes, count vectors record features as immutable atomic units, ensuring their presence regardless of how the vector develops.

### 4.2.2 Vocabulary Construction
The "training" phase for a BoW model involves the construction of a recognised vocabulary $\mathcal{V}_{\text{training}}$. Starting with the compilation of a global term-frequency dictionary $\mathcal{C}_{\text{gold}}(w)$, we identify and map singletons ($\mathcal{C}_{\text{gold}}(w) = 1$) to an out-of-vocabulary token (`__UNK__`). This regularizes the input space by preventing the model from memorizing highly specific entities or niche descriptors. Similarly, high-frequency connective terms are filtered from the dictionary using a custom stopword list (Appendix E). This is done to prevent neutral features overpowering trigger words. The remaining dictionary keys form the vocabulary set $\mathcal{V}_{\text{gold}}$.

$$\mathcal{V}_{\text{gold}} = \{ \text{\_\_UNK\_\_} \} \cup \{ w \in \mathcal{C}_{\text{gold}} \mid \mathcal{C}_{\text{gold}}(w) > 1 \land w \notin \text{Stopwords} \}$$

An index mapping $\mathcal{I}_{\text{vocab}}: w \mapsto i$ translates $\mathcal{V}_{\text{gold}}$ to vector coordinates $i \in \{0, \dots, \vert{}\mathcal{V}_{\text{gold}}\vert{}-1\}$, allowing a sequence of tokens to be parsed into a fixed-dimensional vector space.

### 4.2.3 Vocabulary Enrichment
The silver-augmented data (Section 3.3) is utilized to provide additional feature density and establish a secondary enriched vocabulary ($\mathcal{V}_{\text{silver}}$). This works by iterating through the synthetic snippets to increment term counts in the term-frequency dictionary $\mathcal{C}_{\text{gold}}(w)$.

Crucially, this does not introduce new terms into the vocabulary and works solely to promote singletons past the frequency threshold ($\mathcal{C}_{\text{silver}}(w) > 1$), shifting viable features out of the generic `__UNK__` and increasing the vector dimensions. This process safeguards legitimate trigger words that were regularized solely due to limited gold training corpus size.

$$\mathcal{C}_{\text{silver}}(w) = \mathcal{C}_{\text{gold}}(w) + \sum_{S \in \mathcal{D}_{\text{silver}}} \sum_{t_i \in S} \mathbb{I}(t_i = w \land w \in \mathcal{C}_{\text{gold}})$$

### 4.2.4 Auxiliary Tagsets
Auxiliary POS ($\vert{}\mathcal{P}\vert{}=12$) and NER ($\vert{}\mathcal{E}\vert{}=10$) channels are vectorized using identical term-frequency mapping. Extracted across full sequences prior to vocabulary regularization, these channels bypass singleton pruning. This guarantees structural and entity signals are retained even when lexical tokens collapse to `__UNK__`. Preserving this context captures propagandistic devices where rare vocabulary is used within distinct relational templates—such as framing a target through patterns like `[PERSON]` is `[ADJECTIVE]`.

### 4.2.5 Experimental Design
Four vocabulary configurations evaluate dataset splits ($\text{Gold}$ vs. $\text{Gold} + \text{Silver}$) against context windows ($\text{Snippet-Only}$ vs. $\text{Full-Context}$), as detailed in Table X. Restricting context to "Snippet-Only" strips neutral prose, reducing baseline vector dimensionality by $54.6\%$. Conversely, synthetic enrichment reclaims lost singletons, decreasing discarded hapax terms by $45.4\%$ and expanding active feature dimensions.

##### Table 1: Task 1 BoW Vocabulary Splits
| Experimental Split | Active Vocab ($\|\mathcal{V}\|$) | Singletons Cut | Structural POS Dim | Structural NER Dim | Total Input Tensor Dim |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Gold Baseline, Full-Context** | 3,265 | 3,038 | 12 | 10 | **3,287** |
| **Silver Enriched, Full-Context** | 4,002 | 2,301 | 12 | 10 | **4,024** |
| **Gold Baseline, Snippet-Only** | 1,483 | 2,051 | 12 | 10 | **1,505** |
| **Silver Enriched, Snippet-Only** | 2,415 | 1,119 | 12 | 10 | **2,437** |

### 4.2.6 Model Architecture
Token, POS, and NER frequencies map into three discrete count vectors:

$$\vec{v}_{\text{vocab}}[i] = \sum_{t \in T} \mathbb{I}(\mathcal{I}_{\text{vocab}}(t) = i), \quad \vec{v}_{\text{pos}}[j] = \sum_{p \in P} \mathbb{I}(\mathcal{I}_{\text{pos}}(p) = j), \quad \vec{v}_{\text{ner}}[k] = \sum_{e \in E} \mathbb{I}(\mathcal{I}_{\text{ner}}(e) = k)$$

These vectors are concatenated into a single input tensor $\vec{x}_{\text{input}}$ passed directly to an MLP classification head:

$$\vec{x}_{\text{input}} = \left[ \vec{v}_{\text{vocab}} \parallel \vec{v}_{\text{pos}} \parallel \vec{v}_{\text{ner}} \right] \in \mathbb{R}^{\vert{}\mathcal{V}\vert{} + \vert{}\mathcal{P}\vert{} + \vert{}\mathcal{E}\vert{}}$$

While structural auxiliary channels remain constant ($\vert{}\mathcal{P}\vert{}=12$, $\vert{}\mathcal{E}\vert{}=10$), the MLP input space dynamically scales ($\mathbb{R}^{1,505}$ to $\mathbb{R}^{4,024}$) based on the experimental configuration.

---

### 4.2.2 Approach 2: Dense Word2Vec (W2V) Vector Representation
To mitigate the Zipfian sparsity inherent in small propaganda corpora, Word2Vec maps semantic similarity into geometric proximity (Mikolov et al., 2013). By performing implicit matrix factorization (Levy & Goldberg, 2014), continuous embeddings share statistical strength across synonyms, allowing the classifier to recognize alternative phrasing and generalize across synonymous rhetorical injections. As propaganda techniques frequently manifest as localized emotive triggers, Word2Vec's local window optimization provides a superior representation over global co-occurrence models (Baroni et al., 2014).

#### 4.2.2.1 Word2Vec Import
Training a custom Word2Vec model on a corpus of this size would overfit embeddings to propagandistic contexts rather than standard linguistic usages. Deploying pre-trained Google News embeddings ($\mathbf{E} \in \mathbb{R}^{\vert{}V_{\text{google}}\vert{} \times 300}$) grounds words in task-agnostic meanings. This semantic baseline enables the classifier to identify manipulative language as anomalous usage patterns, improving linear separability across rhetorical techniques.

#### 4.2.2.2 Vocabulary Constraints
Using a pre-trained Word2Vec model involves mapping vocabulary terms to an embedding lookup space. To maintain strict experimental control, the lookup was restricted to the vocabulary topologies defined in Approach 1, isolating embedding density (Sparse vs. Dense) as the sole independent variable, omitting the models superior vocabulary depth.

Consequently, the pipeline retains an out-of-vocabulary (`__UNK__`) slot for rare terms, scaling it by a scalar ratio $c_{\text{unk}} \in [0, 1]$ to reflect OOV density while matching Word2Vec embedding magnitudes.

#### 4.2.2.3 Model Architecture
To construct sequence representations from word vectors, valid tokens are aggregated using arithmetic mean-pooling:

$$\vec{v}_{\text{w2v}} = \begin{cases} \frac{1}{\vert{}T_{\text{valid}}\vert{}} \sum_{t \in T_{\text{valid}}} \mathbf{E}(t), & \text{if } \vert{}T_{\text{valid}}\vert{} > 0 \\ \vec{0}_{300}, & \text{otherwise} \end{cases}$$

Given vector addition is commutative, mean-pooling discards word order and compositional syntax meaning Word2Vec's capacity to process non-compositional syntactic departures is restricted to the signal strength of isolated trigger words and their linear combinations. 

To assemble the final input tensor $\vec{x}_{\text{input}}$, the structural tagset count vectors ($\vec{v}_{\text{pos}}$ and $\vec{v}_{\text{ner}}$) are a$L_1$-normalized into relative probability distributions ($[0, 1]$), aligning to embedding magnitudes and preventing unscaled integer counts from dominating loss gradients during backpropagation:

$$\tilde{\vec{v}}_{\text{pos}} = \frac{\vec{v}_{\text{pos}}}{\sum_j \vec{v}_{\text{pos}}[j]}, \quad \tilde{\vec{v}}_{\text{ner}} = \frac{\vec{v}_{\text{ner}}}{\sum_k \vec{v}_{\text{ner}}[k]}$$

The concatenated input vector $\vec{x}_{\text{input}} \in \mathbb{R}^{323}$ is fed directly into the MLP classification head. Unlike the dynamically scaled BoW input space, this tensor dimension remains strictly invariant ($\mathbb{R}^{323}$) across all experimental conditions.

$$\vec{x}_{\text{input}} = \left[ \vec{v}_{\text{w2v\_300d}} \parallel c_{\text{unk}} \parallel \tilde{\vec{v}}_{\text{pos\_12d}} \parallel \tilde{\vec{v}}_{\text{ner\_10d}} \right] \in \mathbb{R}^{323}$$

###### Table 2: Word2Vec Input Tensor Dimensions Across Experimental Conditions
| Experimental Split | Active Vocab ($\|\mathcal{V}\|$) | Singletons Cut | Structural POS Dim | Structural NER Dim | Total Input Tensor Dim |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Gold Baseline, Full-Context** | 3,265 | 3,038 | 300 (+1 $c_{\text{unk}}$) | 12 | 10 | **323** |
| **Silver Enriched, Full-Context** | 4,002 | 2,301 | 300 (+1 $c_{\text{unk}}$) | 12 | 10 | **323** |
| **Gold Baseline, Snippet-Only** | 1,483 | 2,051 | 300 (+1 $c_{\text{unk}}$) | 12 | 10 | **323** |
| **Silver Enriched, Snippet-Only** | 2,415 | 1,119 | 300 (+1 $c_{\text{unk}}$) | 12 | 10 | **323** |

---

## 4.3 Downstream Classification Architecture & Optimization
### 4.3.1 Standardized MLP Classification Head
To isolate representation quality from architectural bias, a standardized Multi-Layer Perceptron (MLP) classification head is used throughout Task-1 and dynamically adapts to incoming feature tensors.

$$\mathbf{x} = [\mathbf{x}_{\text{sem}} \mathbin{\Vert} \mathbf{x}_{\text{POS}} \mathbin{\Vert} \mathbf{x}_{\text{NER}}], \quad d_{\text{in}} = d_{\text{sem}} + 22$$

Grounded in the Universal Approximation Theorem (Hornik et al., 1989), a single hidden layer prevents overfitting while resolving non-linear decision boundaries. The forward pass applies linear projection, ReLU activation to capture non-linearity, Layer Normalization o stabilize instance updates, Dropout regularization ($p$), and a terminal linear projection emitting 8-way logits $\mathbf{s} \in \mathbb{R}^8$:

$$\mathbf{h} = \text{ReLU}(\mathbf{W}_1 \mathbf{x} + \mathbf{b}_1)$$
$$\mathbf{z} = \text{Dropout}(\text{LayerNorm}(\mathbf{h}), p)$$
$$\mathbf{s} = \mathbf{W}_2 \mathbf{z} + \mathbf{b}_2$$

Parameters update using multi-class Cross-Entropy Loss. Maintaining this uniform topology guarantees performance variances reflect representation geometry rather than head capacity.

### 4.3.2 Hyperparameter Optimization
A grid search over 3 hyperparameters (Table 3) was conducted on a $10\%$ modulo validation split recording performance heckpoints across 5 epochs. The search revealed sparse Bag-of-Words models required higher hidden capacity ($d_{\text{hidden}} = 128$), aggressive dropout ($p = 0.5$), a conservative learning rate ($\eta = 0.0001$), and early stopping at 3 epochs to prevent sparse memorization, whereas dense Word2Vec models converged smoothly with a compact hidden layer ($d_{\text{hidden}} = 64$), moderate dropout ($p = 0.3$), a higher learning rate ($\eta = 0.001$), and full 5-epoch training.

##### Table 3: Hyperparameter Search Space and Optimal Configuration Benchmarks
| Hyperparameter Parameter | Search Grid Space | BoW Optimal Value | Word2Vec Optimal Value | Methodological Rationale |
| :--- | :---: | :---: | :---: | :--- |
| **Hidden Layer Dim ($d_{\text{hidden}}$)** | $\{64, 128\}$ | $128$ | $64$ | Balances capacity against over-parameterization. |
| **Learning Rate ($\eta$)** | $\{0.005, 0.001, 0.0005, 0.0001\}$ | $0.0001$ | $0.001$ | Controls AdamW gradient update step size. |
| **Dropout Rate ($p$)** | $\{0.3, 0.5\}$ | $0.5$ | $0.3$ | Regularizes activation co-adaptation. |
| **Optimal Training Epochs** | Tested up to $5$ | $3$ | $5$ | Prevents sparse memorization versus dense undertraining. |
| **Weight Decay ($\lambda$)** | Fixed ($0.05$) | $0.05$ | $0.05$ | L2 regularization on linear weights. |
| **Optimizer** | AdamW | AdamW | AdamW | Decouples weight decay from gradient momentum. |
---

## 4.4 Evaluation Metrics
Although our training corpus is balanced, real-world propaganda datasets are typically highly imbalanced (Da San Martino et al., 2020). Consequently, we design an evaluation framework tailored to imbalanced test distributions. Standard accuracy is an insufficient terminal evaluation metric because it is vulnerable to masking poor minority performance behind dominant classes.

In a single-label multi-class setting across $K$ classes, Micro-averaged $F_1$ score mathematically decomposes into global accuracy, making it blind to systematic class imbalances:

$$\text{Accuracy} = \text{Micro-F}_1 = \frac{\sum_{k=1}^{K} \text{TP}_k}{\sum_{k=1}^{K} (\text{TP}_k + \text{FP}_k)}$$

Macro-averaged $F_1$ score calculates the harmonic mean of precision and recall for each class independently before averaging them unweighted:

$$\text{Macro-P} = \frac{1}{K} \sum_{k=1}^{K} P_k, \quad \text{Macro-R} = \frac{1}{K} \sum_{k=1}^{K} R_k$$

$$\text{Macro-F}_1 = \frac{1}{K} \sum_{k=1}^{K} F_{1, k} = \frac{1}{K} \sum_{k=1}^{K} \left( 2 \cdot \frac{P_k \cdot R_k}{P_k + R_k} \right)$$

By weighting every category equally regardless of support size, Macro-$F_1$ ensures that poor performance on minority classes cannot be masked by dominant baseline predictions. Macro-$F_1$ is therefore selected as the primary terminal evaluation metric across all experimental conditions.

Finally, per-class precision, recall, and $F_1$ scores are logged to provide the granular diagnostic inference needed to analyze specific pipeline representation bottlenecks.

##### Table 4: Per-Class Diagnostic Evaluation Formulations
| Metric | Mathematical Formulation |
| :--- | :---: |
| **Class Precision ($P_k$)** | $\frac{\text{TP}_k}{\text{TP}_k + \text{FP}_k}$ |
| **Class Recall ($R_k$)** | $\frac{\text{TP}_k}{\text{TP}_k + \text{FN}_k}$ |
| **Class $F_1$ Score ($F_{1, k}$)** | $2 \cdot \frac{P_k \cdot R_k}{P_k + R_k}$ |
---

## 4.5 Experimental Results:

### 4.5.1 Bag-of-Words Results
The BoW framework achieved its top performance under the Gold-Only, Full-Context baseline ($\text{Macro-}F_1 = 0.3200$). Systematically evaluating variants reveals critical interactions between context scope, feature density, and synthetic data augmentation.

Restricting input to "Snippet-Only" sequences was intended to isolate emotional trigger words, yet it uniformly degraded performance across Gold ($0.3200 \to 0.3183$) and Enriched ($0.3174 \to 0.3129$) splits. Paralleling Pedersen (2010), retaining broader background text provides essential co-occurrence statistics that cushion sparse vector spaces, proving that surrounding neutral context acts as a vital data-density stabilizer.

The synthetic silver enrichment ($\mathcal{V}_{\text{silver}} = 4,002\text{D}$) consistently impaired out-of-sample generalization. Paraphrased LLM reformulations introduced semantic drift, corrupting the precise linear boundaries required to isolate authentic lexical triggers. This may support the idea that propaganda is underpinned by specific trigger words rather than generalized semantic equivalents. Furthermore, promoting singletons into active dimensions expanded vector sparsity, allowing the classifier to memorize spurious synthetic artifacts.

All BoW variants suffered from severe overfitting, exhibiting a stark generalization gap ($\Delta F_1 \approx 0.51$) between training ($0.8314$) and test evaluation ($0.3200$). High-dimensional sparse inputs allowed the MLP head to memorize exact training co-occurrences rather than learning abstract, transferable rules for unseen propaganda.

---

##### Table 5: Task 1 Experimental Results across Model Architectures and Data Splits

| Model & Experimental Condition | Vector Dims ($d_{\text{sem}}$) | Test Accuracy | Test Macro-$F_1$ | Test Macro-Precision | Test Macro-Recall | Train Accuracy | Train Macro-$F_1$ | Train Macro-Precision | Train Macro-Recall |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Random Guess Baseline** | — | 0.1618 | 0.1592 | 0.1582 | 0.1578 | — | — | — | — |
| **BoW, Gold Baseline, Full-Context** | 3,265 | 0.3333 | **0.3200** | 0.3254 | 0.3326 | 0.8149 | 0.8148 | 0.8199 | 0.8157 |
| **BoW, old Baseline, Snippet-Only** | 1,483 | 0.3301 | 0.3183 | 0.3157 | 0.3305 | 0.6700 | 0.6696 | 0.6798 | 0.6712 |
| **BoW, Silver Enriched, Full-Context** | 4,002 | 0.3269 | 0.3174 | 0.3179 | 0.3262 | 0.8319 | 0.8314 | 0.8341 | 0.8327 |
| **BoW, Silver Enriched, Snippet-Only** | 2,415 | 0.3236 | 0.3129 | 0.3292 | 0.3215 | 0.7529 | 0.7516 | 0.7599 | 0.7538 |
| **W2V, Gold Baseline, Full-Context** | 301 | 0.3301 | 0.2835 | 0.2962 | 0.3184 | 0.4601 | 0.4440 | 0.5118 | 0.4621 |
| **W2V, Gold Baseline, Snippet-Only** | 301 | **0.3366** | 0.2927 | 0.2911 | 0.3274 | 0.4779 | 0.4646 | 0.5030 | 0.4808 |
| **W2V, Silver Enriched, Full-Context** | 301 | 0.3236 | 0.2861 | 0.3076 | 0.3169 | 0.4640 | 0.4509 | 0.5084 | 0.4656 |
| **W2V, Silver Enriched, Snippet-Only** | 301 | 0.3074 | 0.2571 | 0.2672 | 0.3007 | 0.4826 | 0.4714 | 0.5338 | 0.4840 |

---

### 4.5.2 Word2Vec Results
Word2Vec underperformed the BoW baseline across all experiments, peaking at $0.2927$ Test Macro-$F_1$ under "Gold Baseline, Snippet-Only" and suffering an average terminal drop of $\Delta 0.035$. With identical heads, this differential isolates a fundamental representational bottleneck in static continuous vector spaces for propaganda detection.

Propaganda relies on exact lexical choices rather than broad distributional semantics. While BoW represents loaded terms and neutral equivalents as orthogonal dimensions, Word2Vec maps them into overlapping geometric clusters ("regime" vs. "government"), blurring linear decision boundaries.

Furthermore, arithmetic mean-pooling dilutes localized manipulative signals across surrounding neutral prose, pulling the document centroid toward generic news text. This mechanism explains why Word2Vec peaked under the Snippet-Only condition ($0.2927$) rather than Full-Context ($0.2835$). Stripping neutral background tokens reduces the averaging denominator, allowing trigger vectors to retain higher proportional weight.

Unlike BoW’s high variance, Word2Vec suffered from severe high-bias underfitting, achieving a Train Macro-$F_1$ of only $0.4646$ (vs. BoW’s $0.8148$). However, its compact generalization gap ($\Delta F_1 = 0.1719$) confirms that while mean-pooling causes severe signal loss, continuous representations maintain stable out-of-sample consistency.

---

### 4.5.3 Class-Level Diagnostic Error Analysis
Class-level performance under Experiment 1 (Full-Context, Gold) demonstrates how representation geometry directly interacts with specific propaganda techniques. BoW significantly outperforms Word2Vec on `Repetition` ($F_1 = 0.33$ vs. $0.18$) because count vectors preserve token frequency mass, whereas commutative mean-pooling erases duplicate tokens, collapsing Word2Vec recall to $0.12$. Similarly, BoW excels at `Exaggeration,Minimisation` ($F_1 = 0.36$ vs. $0.26$) because extrema modifiers ("always", "never") serve as discrete orthogonal triggers in sparse space, pushing BoW recall to $0.50$, whereas continuous smoothing softens these terms toward generic degree adverbs. On `Loaded Language`, isolated emotive triggers wash out within mean-pooled document centroids, causing Word2Vec performance to collapse ($F_1 = 0.04$, recall $= 0.03$). Conversely, Word2Vec surpasses BoW on entity-driven classes like `Flag Waving` ($F_1 = 0.54$ vs. $0.46$) and `Appeal to Fear/Prejudice` ($F_1 = 0.40$ vs. $0.33$), as Google News embeddings cluster nationalistic symbols into robust continuous concepts, yielding $0.82$ recall on `Flag Waving`.

##### Table 6: Experiment 1 (Full-Context, Gold Vocab) Class-Level Results
| Class/Technique | $F_1$ (BASE) | $F_1$ (BoW) | $F_1$ (W2V) | Precision (BoW) | Precision (W2V) | Recall (BoW) | Recall (W2V) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| `flag_waving` | 0.12 | 0.46 | **0.54** | 0.46 | 0.41 | 0.47 | **0.82** |
| `appeal_to_fear_prejudice` | 0.18 | 0.33 | **0.40** | 0.33 | 0.36 | 0.33 | **0.44** |
| `causal_oversimplification` | 0.16 | 0.32 | **0.34** | 0.29 | 0.29 | 0.34 | **0.40** |
| `doubt` | 0.14 | **0.39** | 0.31 | 0.35 | **0.39** | **0.44** | 0.26 |
| `exaggeration,minimisation` | 0.09 | **0.36** | 0.26 | **0.28** | 0.24 | **0.50** | 0.30 |
| `repetition` | 0.15 | **0.33** | 0.18 | **0.42** | 0.33 | **0.28** | 0.12 |
| `name_calling,labeling` | 0.13 | **0.24** | 0.19 | **0.28** | 0.21 | **0.21** | 0.18 |
| `loaded_language` | 0.14 | **0.13** | 0.04 | **0.19** | 0.14 | **0.10** | 0.03 |
| **Macro Average** | **0.14** | **0.32** | **0.28** | **0.33** | **0.30** | **0.33** | **0.32** |

---

# 5 Conclusion, Limitations, and Future Work
This study systematically benchmarked sparse discrete representations against static continuous vector spaces for fine-grained propaganda detection. Contradicting the general NLP paradigm favoring dense embeddings, empirical results demonstrated that discrete orthogonality is superior for isolating manipulative text. The unigram Bag-of-Words (BoW) model ($\text{Macro-}F_1 = 0.3200$) outperformed dense Word2Vec ($\text{Macro-}F_1 = 0.2927$), providing strong empirical support for power of lexical triggers and aligning with SemEval benchmarks on localized propaganda analysis (Da San Martino et al., 2020; Cruz et al., 2019). BoW dominated techniques reliant on exact string matches, such as repetition ($0.33$ vs. $0.18$) and exaggeration/minimization ($0.36$ vs. $0.26$), as orthogonal dimensions preserve token frequencies and extrema modifiers without continuous vector smoothing blurring decision boundaries. Furthermore, evaluating context windows revealed that surrounding neutral text acts as essential data-density stabilizer, with snippet-only representations consistently degrading performance.

Several methodological limitations constrained overall performance. Both paradigms hit a structural precision ceiling ($\sim 0.30\text{--}0.35$) due to vocabulary overlap, as common news terminology triggered widespread false positives without contextual awareness. Additionally, constraining Word2Vec’s lookup space to match BoW suppressed its native out-of-vocabulary generalization. Synthetic silver enrichment introduced unvalidated semantic drift, corrupting linear boundaries, while BoW’s reliance on raw counts without TF-IDF weighting allowed ubiquitous non-informative terms to retain unscaled frequency mass.

Future work could explore hybrid models that leverage BoW’s orthogonal trigger precision to dynamically weight Word2Vec sequence pooling, alongside evaluating Word2Vec with unconstrained OOV handling. Ultimately, overcoming the precision ceiling requires transitioning to Transformer encoders whose self-attention mechanisms provide the contextual, discourse-level reasoning needed to separate objective reporting from manipulative prose.

---
