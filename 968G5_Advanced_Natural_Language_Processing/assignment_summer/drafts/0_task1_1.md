# 4. Task 1: Propaganda Classification
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
Approach 2 benchmarks continuous vector space by deploying static word embeddings. To mitigate Zipf's Law sparsity inherent to small propaganda corpora, Word2Vec maps semantic similarity into geometric proximity (Mikolov et al., 2013). By performing implicit matrix factorization (Levy & Goldberg, 2014), continuous embeddings share statistical strength across synonyms, allowing the classifier to recognize alternative phrasing and generalize across synonymous rhetorical injections. As propaganda techniques frequently manifest as localized emotive triggers, Word2Vec's local window optimization provides a superior representation over global co-occurrence models (Baroni et al., 2014).

#### 4.2.2.1 Vocabulary Constraints & Feature Normalization
For these experiments, pre-trained $300$-dimensional Google News embeddings ($\mathbf{E} \in \mathbb{R}^{\vert{}V_{\text{google}}\vert{} \times 300}$) are deployed. While the pre-trained embedding space vastly exceeds our corpus, the lookup space is strictly constrained to the active vocabulary ($\mathcal{V}_{\text{experiment}}$) of each experimental iteration. This restriction establishes strict experimental control, isolating embedding density as the sole independent variable (Sparse vs. Dense) against BoW.

For tokens falling outside the active vocabulary, the __UNK__ routing mechanism calculates a scalar ratio $c_{\text{unk}} \in [0, 1]$ to capture out-of-vocabulary density while matching embedding magnitudes:

$$c_{\text{unk}} = \frac{1}{N} \sum_{t \in T} \mathbb{I}(t \notin \mathcal{V}_{\text{experiment}})$$

Sequence-level composition applies arithmetic mean-pooling over valid active tokens in $T$:

$$\vec{v}_{\text{w2v}} = \begin{cases} \frac{1}{\vert{}T_{\text{valid}}\vert{}} \sum_{t \in T_{\text{valid}}} \mathbf{E}(t), & \text{if } \vert{}T_{\text{valid}}\vert{} > 0 \\ \vec{0}_{300}, & \text{otherwise} \end{cases}$$

Given vector addition is commutative, arithmetic mean-pooling discards token order and compositional structure. Consequently, Word2Vec's capacity to process non-compositional syntactic departures is restricted to the signal strength of isolated trigger words and their linear combinations. 

To construct the final input tensor $\vec{x}_{\text{input}}$, the structural tagset count vectors ($\vec{v}_{\text{pos}}$ and $\vec{v}_{\text{ner}}$) are $L_1$-normalized into relative probability distributions ($[0, 1]$) prior to concatenation. This aligns structural vector magnitudes with continuous embedding scales, preventing unscaled integer counts from dominating loss gradients during backpropagation:

$$\tilde{\vec{v}}_{\text{pos}} = \frac{\vec{v}_{\text{pos}}}{\sum_j \vec{v}_{\text{pos}}[j]}, \quad \tilde{\vec{v}}_{\text{ner}} = \frac{\vec{v}_{\text{ner}}}{\sum_k \vec{v}_{\text{ner}}[k]}$$

The concatenated input vector $\vec{x}_{\text{input}} \in \mathbb{R}^{323}$ is passed directly to the MLP classification head. In contrast to the variable BoW input space, the input tensor dimension remains invariant across all experimental conditions:

$$\vec{x}_{\text{input}} = \left[ \vec{v}_{\text{w2v\_300d}} \parallel c_{\text{unk}} \parallel \tilde{\vec{v}}_{\text{pos\_12d}} \parallel \tilde{\vec{v}}_{\text{ner\_10d}} \right] \in \mathbb{R}^{323}$$

###### Table X: Word2Vec Input Tensor Dimensions Across Experimental Conditions
```
| Experimental Split Condition | Active Vocab Limit ($\|\mathcal{V}\|$) | Singletons Cut | Dense W2V Dim | Structural POS Dim | Structural NER Dim | Total Input Tensor Dim |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Gold Baseline, Full-Context** | 3,265 | 3,038 | 300 (+1 $c_{\text{unk}}$) | 12 | 10 | **323** |
| **Silver Enriched, Full-Context** | 4,002 | 2,301 | 300 (+1 $c_{\text{unk}}$) | 12 | 10 | **323** |
| **Gold Baseline, Snippet-Only** | 1,483 | 2,051 | 300 (+1 $c_{\text{unk}}$) | 12 | 10 | **323** |
| **Silver Enriched, Snippet-Only** | 2,415 | 1,119 | 300 (+1 $c_{\text{unk}}$) | 12 | 10 | **323** |
```

---

## 4.3 Evaluation Metrics
Although our training corpus is balanced, real-world propaganda datasets are typically highly imbalanced (Da San Martino et al., 2020). Consequently, we design an evaluation framework tailored to imbalanced test distributions. Standard accuracy is an insufficient terminal evaluation metric because it is vulnerable to masking poor minority performance behind dominant classes.

In a single-label multi-class setting across $K$ classes, Micro-averaged $F_1$ score mathematically decomposes into global accuracy, making it blind to systematic class imbalances:

$$\text{Accuracy} = \text{Micro-F}_1 = \frac{\sum_{k=1}^{K} \text{TP}_k}{\sum_{k=1}^{K} (\text{TP}_k + \text{FP}_k)}$$

Macro-averaged $F_1$ score calculates the harmonic mean of precision and recall for each class independently before averaging them unweighted:

$$\text{Macro-P} = \frac{1}{K} \sum_{k=1}^{K} P_k, \quad \text{Macro-R} = \frac{1}{K} \sum_{k=1}^{K} R_k$$

$$\text{Macro-F}_1 = \frac{1}{K} \sum_{k=1}^{K} F_{1, k} = \frac{1}{K} \sum_{k=1}^{K} \left( 2 \cdot \frac{P_k \cdot R_k}{P_k + R_k} \right)$$

By weighting every category equally regardless of support size, Macro-$F_1$ ensures that poor performance on minority classes cannot be masked by dominant baseline predictions. Macro-$F_1$ is therefore selected as the primary terminal evaluation metric across all experimental conditions.

Finally, per-class precision, recall, and $F_1$ scores are logged to provide the granular diagnostic inference needed to analyze specific pipeline representation bottlenecks.

##### Table 3: Per-Class Diagnostic Evaluation Formulations
| Metric | Mathematical Formulation | Diagnostic Purpose in Propaganda Detection |
| :--- | :---: | :--- |
| **Class Precision ($P_k$)** | $\frac{\text{TP}_k}{\text{TP}_k + \text{FP}_k}$ | Measures false alarm rates; penalizes over-predicting dominant triggers. |
| **Class Recall ($R_k$)** | $\frac{\text{TP}_k}{\text{TP}_k + \text{FN}_k}$ | Measures detection coverage; reveals severe technique suppression (e.g., *Loaded Language* signal washing). |
| **Class $F_1$ Score ($F_{1, k}$)** | $2 \cdot \frac{P_k \cdot R_k}{P_k + R_k}$ | Provides the balanced harmonic score for technique $k$. |
---

## 4.4 Downstream Classification Architecture & Optimization
### 4.4.1 Standardized MLP Classification Head
To isolate representation quality from architectural bias, all Task 1 experiments share a standardized Multi-Layer Perceptron (MLP) classification head. This network consists of an input layer of $d_{\text{in}}$ nodes, a single hidden layer of $d_{\text{hidden}}$ nodes, and an 8-node output layer corresponding to the target propaganda techniques.

As each representation paradigm features a distinct semantic dimensionality ($d_{\text{sem}}$), the input layer programmatically adjusts to the incoming feature tensor. Concatenating the semantic embeddings with the POS ($\mathbf{x}_{\text{POS}} \in \mathbb{R}^{12}$) and NER ($\mathbf{x}_{\text{NER}} \in \mathbb{R}^{10}$) tag distributions yields a dynamic input dimension $d_{\text{in}}$:

$$\mathbf{x} = [\mathbf{x}_{\text{sem}} \mathbin{\Vert} \mathbf{x}_{\text{POS}} \mathbin{\Vert} \mathbf{x}_{\text{NER}}], \quad d_{\text{in}} = d_{\text{sem}} + 12 + 10$$

Grounded in the Universal Approximation Theorem (Hornik et al., 1989), the single hidden layer acts as a constrained probe to prevent overfitting while resolving non-linear decision boundaries. The forward pass applies a linear projection to hidden space, a ReLU activation to capture non-linearity, Layer Normalization to stabilize instance updates, Dropout regularization, and a final linear projection to emit logits $\mathbf{s} \in \mathbb{R}^8$:

$$\mathbf{h} = \text{ReLU}(\mathbf{W}_1 \mathbf{x} + \mathbf{b}_1)$$
$$\mathbf{z} = \text{Dropout}(\text{LayerNorm}(\mathbf{h}), p)$$
$$\mathbf{s} = \mathbf{W}_2 \mathbf{z} + \mathbf{b}_2$$

Model parameters are updated by minimizing multi-class Cross-Entropy Loss against ground-truth labels. Keeping this downstream classification topology strictly uniform ensures that performance variances reflect underlying representation geometry rather than head capacity.

### 4.4.2 Hyperparameter Optimization & Validation Strategy
To identify optimal convergence dynamics, a systematic Cartesian grid search sweep was conducted over hidden layer capacity ($d_{\text{hidden}}$), initial learning rate ($\eta$), and dropout probability ($p$).

Tuning was executed directly on the primary training set using a deterministic $10\%$ modulo streaming validation split ($idx \pmod{10} == 0$). During training, every tenth instance was held out to calculate internal development loss, while the remaining $90\%$ drove AdamW optimization updates. Early checkpointing retained model weights achieving the lowest validation loss across five training epochs.

The grid search revealed distinct optimization landscapes across representation types:
- **Sparse Bag-of-Words (BoW):** High-dimensional sparse vectors overfit rapidly. Optimal performance required higher hidden capacity ($d_{\text{hidden}} = 128$) paired with aggressive regularization ($p = 0.5$), a conservative learning rate ($\eta = 0.0001$), and early stopping at $3$ epochs to prevent sparse memorization.
- **Dense Word2Vec (W2V):** Lower-dimensional continuous embeddings converged more smoothly, benefiting from a compact hidden layer ($d_{\text{hidden}} = 64$), moderate dropout ($p = 0.3$), a larger learning rate ($\eta = 0.001$), and training through $5$ full epochs.

##### Table 4: Hyperparameter Search Space and Optimal Configuration Benchmarks
| Hyperparameter Parameter | Search Grid Space | BoW Optimal Value | Word2Vec Optimal Value | Methodological Rationale |
| :--- | :---: | :---: | :---: | :--- |
| **Hidden Layer Dim ($d_{\text{hidden}}$)** | $\{64, 128\}$ | $128$ | $64$ | Balances capacity against over-parameterization. |
| **Learning Rate ($\eta$)** | $\{0.005, 0.001, 0.0005, 0.0001\}$ | $0.0001$ | $0.001$ | Controls AdamW gradient update step size. |
| **Dropout Rate ($p$)** | $\{0.3, 0.5\}$ | $0.5$ | $0.3$ | Regularizes activation co-adaptation. |
| **Optimal Training Epochs** | Tested up to $5$ | $3$ | $5$ | Prevents sparse memorization versus dense undertraining. |
| **Weight Decay ($\lambda$)** | Fixed ($0.05$) | $0.05$ | $0.05$ | L2 regularization on linear weights. |
| **Optimizer** | AdamW | AdamW | AdamW | Decouples weight decay from gradient momentum. |
---

## 4.5 Experimental Results:

### 4.5.1 Bag-of-Words Results
The BoW framework produced its top-performing model under the "Gold Only, Full-Context" experiment, achieving a peak Test Macro-$F_1$ of $0.3200$. Analyzing performance across the four internal BoW configurations illuminates key interactions between context windowing, vocabulary density, and synthetic data augmentation.

The condensed, "Snippet-Only" experiments were designed to eliminate background noise and amplify propagandist trigger word signal but unilaterally degraded test performance across both Gold-Only ($0.3200$ to $0.3183$) and Enriched ($0.3174$ to $0.3129$) experiments. This indicates that surrounding neutral sentinel context serves as a crucial data-density stabilizing mechanism. 

This phenomenon directly parallels the methodological findings of Pedersen (2010), who demonstrated that computing Information Content over noisy, untagged, large-scale data outperforms sparse, highly restricted sense-tagged text. Just as Pedersen proved that raw frequency volume provides the statistical density needed to smooth over unobserved gaps, retaining full background context provides vital co-occurrence statistics that cushion sparse lexical vector spaces. 

Conversely, enriching the active feature space using synthetic LLM-generated snippets ($\mathcal{V}_{\text{silver}} = 4,002\text{D}$) degraded out-of-sample generalization: Full-Context ($0.32$ to $0.3174$) and Snippet-only ($0.3183$ to $0.3129$). Whilst theoretically, it may be perceived as having the same data densifying impact, it appears that the semantic drift introduced by the LLMs reformulation corrupted the linear decision boundaries needed to isolate trigger tokens. This result strongly supports Hypothesis 1 ($H_1$) that propaganda techniques rely on exact lexical triggers.

Additionally, the action of re-classifying singletons as active features expanded the input dimensions. Rather than meaningfully strengthening decision boundaries, this dimension jump increased vector sparsity by spreading activation mass across a vastly larger coordinate space making the linear classifier more vulnerable to memorizing spurious, out-of-domain synthetic artifacts rather than isolating authentic propagandistic devices.

All Bag-of-Words variants suffered from severe overfitting, leaving a massive generalization gap ($\Delta F_1 \approx 0.51$) between training (up to $0.8314$) and test performance. This gap stems directly from high feature dimensionality. With thousands of sparse input nodes, the multi-layer perceptron easily memorized exact word combinations from the training set rather than learning reusable rules for unseen text.

##### Table X: Task 1 Experimental Results across Model Architectures and Data Splits

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
Word2Vec underperformed the BoW appraoch across every experimental permutation, suffering an average terminal drop of $\Delta 0.035$ Macro-$F_1$ and peaking at $0.2927$ under "Gold Baseline, Snippet-Only".

Given that the experimental framework supplied both paradigms with identical classification heads, loss objectives, auxiliary structural tagsets, and active vocabulary bounds, this systematic failure isolates a fundamental representational bottleneck within static continuous vector spaces when applied to manipulative text.

Propaganda detection relies heavily on exact lexical choicses rather than broad distributional semantics. By mapping terms into geometric clusters based on the Distributional Hypothesis, Word2Vec softens linear boundaries. Loaded terms and their semential equivalents ("regime"|"government", "scheme"|"plan"), share high cosine similarity, where as, BoW presents these terms as orthogonal dimensions. These overlapping spatial clusters blur the linear boundries, reducing classification performance. 

Furthermore, sequence-level composition applies arithmetic mean-pooling over valid tokens, assigning equal weight to every token in the sequence:

$$\vec{v}_{\text{w2v}} = \frac{1}{\vert{}T_{\text{valid}}\vert{}} \sum_{t \in T_{\text{valid}}} E(t)$$

However, propaganda exhibits extreme signal imbalance. The majority of a snippet consists of standard syntactic prose, while manipulative features occupy only a small fraction of tokens. In a sequence containing a single manipulative trigger alongside neutral words, commutative mean-pooling pulls the document centroid strongly toward generic news text, effectively washing out the directional signal of the trigger word..

This mechanism directly explains why Word2Vec achieved its peak performance under the "Gold Baseline, Snippet-Only" condition ($0.2927$) rather than the Full-Context condition ($0.2835$) where BoW performed best. Restricting feature extraction to the target span removes surrounding neutral sentinel tokens ($N$), reducing the denominator in the arithmetic mean. By averaging over fewer background words, the manipulative trigger retains greater proportional weight in the final document vector, preventing severe signal dilution.

This representational bottleneck is further confirmed by Word2Vec's training trajectory. Unlike BoW, which overfit heavily, Word2Vec exhibited severe underfitting (high bias). The model failed to fit even its own training set, as Train Macro-$F_1$ collapsed to $0.4646$ compared to BoW's $0.8148$. The inability to achieve reliable linear separation on training data confirms that the performance ceiling stems directly from input feature degradation rather than MLP head capacity.

On a positive note, Word2Vec's tight generalization gap ($\Delta F_1 = 0.1719$) demonstrates that while arithmetic mean-pooling causes severe information loss, its continuous representations remain statistically stable across dataset splits.

Our finding that mean-pooled Word2Vec ($0.2927$ Test Macro-$F_1$) underperforms sparse Bag-of-Words ($0.3200$) aligns directly with established literature in fine-grained propaganda analysis (Da San Martino et al., 2019; Cruz et al., 2019). As demonstrated in SemEval-2020 Task 11, propaganda techniques rely on localized lexical triggers that suffer severe signal dilution when averaged into static 300D document centroids (Da San Martino et al., 2020). Benchmarking feature spaces, Cruz et al. (2019) similarly confirmed that continuous vector space smoothing erases exact string matches, proving that dense representations require sequential contextualization mechanisms to isolate manipulative rhetoric effectively.

---

### 4.5.3 Class-Level Diagnostic Error Analysis
To evaluate the representational trade-offs driving macro-level performance, Table X details class-level metrics for Experiment 1 (Full-Context, Gold Vocabulary). Restricting diagnostic analysis to this canonical baseline normalizes the analytical scope while directly examining how sparse versus continuous feature spaces interact with specific propaganda devices to test Hypothesis 1 ($H_1$).

The empirical results strongly support $H_1$ for structural and stylistic rhetoric. Bag-of-Words significantly outperforms Word2Vec on repetition ($F_1$ of $0.33$ vs. $0.18$) because unigram frequency vectors preserve repeated token instances, whereas commutative mean-pooling erases duplicate token signals, collapsing Word2Vec recall to $0.12$.

BoW excels on exaggeration,minimisation ($F_1$ of $0.36$ vs. $0.26$). Extrema modifiers—such as "never", "always", or "unprecedented"—act as strict, orthogonal triggers in sparse space, allowing BoW recall to surge to $0.50$ (capturing half of all target instances). In continuous Word2Vec space, vector smoothing softens these discrete, extreme modifiers toward generic degree adverbs, blurring linear decision boundaries and causing recall to drop to $0.30$.

Conversely, loaded_language illustrates severe vector dilution under arithmetic mean-pooling. Word2Vec performance collapses to an $F_1$ of $0.04$ and a recall of $0.03$. A single loaded token embedded among neutral news prose gets washed out when averaged into the document centroid. Because Macro-$F_1$ weights all categories equally, Word2Vec's complete failure on loaded_language severely penalizes its overall terminal score.

Finally, Word2Vec surpasses BoW on entity- and identity-based classes, including flag_waving ($0.54$ vs. $0.46$) and appeal_to_fear_prejudice ($0.40$ vs. $0.33$). Pre-trained Google News embeddings map nationalistic symbols and threat keywords into tight continuous clusters, producing a massive $0.82$ recall on flag_waving. Even after mean-pooling, these dense identity vectors dominate sequence centroids, enabling continuous models to capture broad entity-driven rhetoric better than sparse exact string matching.

Table X breaks down precision, recall, and $F_1$ scores at the individual technique level for the canonical baseline setup (**Experiment 1: Full-Context, Gold Vocabulary**).

##### Table X: Experiment 1 (Full-Context, Gold Vocab) Class-Level Results

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

## 5.1 Conclusion
Task 1 has systematically evaluated sparse discrete representations against static continuous vector spaces for fine-grained propaganda detection. Contradicting the general trend in NLP of dense vector superiority, empirical results demonstrated that discrete orthogonality is better suited to manipulative text detection. The unigram Bag-of-Words (BoW) ($F_1 = 0.3200$) outperformed the dense Word2Vec model ($F_1 = 0.2927$), providing strong empirical support for the Lexical Trigger Hypothesis ($H_1$).

BoW significantly dominated techniques reliant on exact feature matches, such as `repetition` ($F_1$ of $0.33$ vs. $0.18$) and `exaggeration,minimisation` ($F_1$ of $0.36$ vs. $0.26$), resulting from BoW’s orthogonal dimensions explicitly preserving token frequencies and extrema modifiers ("always", "never"). This stands in contrast to Word2Vec's continuous vector smoothing which has the effect of blurring linear boundaries and eroding rhetorical signals

Furthermore, experiments on the input context windows (Full vs Snippet), demonstrated that neutral sentinel text acts as a crucial data-density stabilizer with snippet-only representations degrading BoW performance ($0.3200 \rightarrow 0.3183$). 

---

## 5.2 Limitations
Despite providing clear diagnostic insights into feature representations, experimental and methodological constraints must be acknowledged.

First, both paradigms hit a precision ceiling ($\sim0.30\text{--}0.35$) which is structurally driven by vocabulary overlap. Much propaganda mimics journalistic prose, meaning without the capacity for any nuanced contextual awareness, common journalistic words like "danger" or "allegedly" trigger widespread false positives. 

Second, to isolate vector architecture as the independent variable, Out-of-Vocabulary (OOV) handling capacity was omitted from the Word2Vec pipeline. While methodologically necessary for parity, discarding OOV terms undoubtedly suppressed Word2Vec’s overall classification capacity.

Third, while silver dataset expansion aimed to alleviate feature sparsity, the synthetic snippets generated by LLMs lacked systematic validation. Without a human evaluation panel to verify that generative reformulations preserved authentic propagandistic intent, rather than just creating a semantically similar phrasing, the introduction of semantic drift and out-of-domain noise corrupted linear decision boundaries.

Finally, the BoW pipeline relied on raw term frequencies paired with a minimal stopword-list that removed only the six most common words. Without a global weighting mechanism like TF-IDF, the model could not dynamically down-weight ubiquitous connective words or common domain prose. As a result, non-informative terms that escaped the stopword filter retained unscaled frequency mass, adding noise to sparse vector representations.

## 5.3 Future Work
Building on the empirical findings and addressing the limitations of this benchmark, there are clear routes for future work. 

To address structural deficiencies, a hybrid crossover model could be constructed to leverage the unique strengths of both paradigms. Given that BoW excels at identifying exact orthogonal triggers while Word2Vec captures continuous entity clusters, a BoW could dynamically inform Word2Vec which lexical features to weight during sequence composition, directly mitigating the signal-diluting effect of arithmetic mean-pooling.

Fittingly, a future experiment should re-introduce OOV handling to the Word2Vec framework to evaluate whether continuous representations can bridge the performance gap to BoW when granted their native lexical coverage.

Ultimately, however, to break through the ~$0.30$ precision ceiling, future systems must move beyond static counting and average-pooling toward contextualized Transformer encoders. Self-attention mechanisms allow words to maintain a direct "line of sight" to every other token in a sequence, eliminating the mean-pooling bottleneck and providing the deep pragmatic, discourse-level, and stance-aware reasoning required to separate objective reporting from manipulative prose.

---
