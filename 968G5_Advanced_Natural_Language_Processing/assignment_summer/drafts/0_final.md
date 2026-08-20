# Advanced Natural Language Processing (968G5): Assessed coursework

Luke Birkett

Word Count: 4679
- Not including headings, latex formulas denoted between $$, tables or figures. Also exlcluding the abstract, references, appendeix, contents and this cover page. 

Abstract:

AI Usage: 

---

## Contents: 
- [1 Introduction]()
    - [1.1 Problem Outline]()
- [2 Related Work: Evolution of NLP Computational Methods]()
- [3 Dataset]()
    - [3.1 Corpus Overview]()
    - [3.2 Universal Pre-Processing]()
    - [3.3 Data Augmentation: Synthetic Data Enrichement]()
    - [3.4 Feature Tagging]()
- [4 Task 1: Propaganda Classification]()
    - [4.1 Baseline & Experimental Floor]()
    - [4.2 Approach 1: Bag-of-Words (BoW)]()
        - [4.2.1 Vocabulary Construction]()
        - [4.2.2 Vocabulary Enrichment]()
        - [4.2.3 Structural Tagsets]()
        - [4.2.4 Experimental Design]()
        - [4.2.5 Model Architecture]()
    - [4.3 Approach 2: Word2Vec (W2V)]()
        - [4.3.1 Pre-Trained Word2Vec Model]()
        - [4.3.2 Vocabulary Constraints]()
        - [4.3.3 Model Architecture]()
    - [4.4 Standardized MLP Classification Head]()
        - [4.4.1 Hyperparameter Optimization]()
    - [4.5 Evaluation Framework]()
    - [4.6 Results]()
        - [4.6.1 Bag-of-Words Results]()
        - [4.6.2 Word2Vec Results]()
        - [4.6.3 Class-Level Diagnostic Error Analysis]()
    - [4.7 Conclusion, Limitations, and Future Work]()
- [5 Task 2: Joint Propaganda Span Detection and Classification]()
    - [5.1 Architectural Approach]()
    - [5.2 Architecture Variation 2: The Integrated Multi-Class BIO-CRF Model]()
        - [5.2.1 Model Architecture]()
        - [5.2.2 Hyperparameter Search & Optimization Strategy]()
    - [5.3 Architecture Variation 1: Decoupled, Two-Stage Tagger]()
        - [5.3.1 Model Architecture]()
        - [5.3.2 Hyperparameter Search & Optimization Strategy]()
            - [5.3.2.1 Stage 2 Head Training & Performance Ceiling]()
            - [5.3.2.2 Stage 1 Hyperparameter Grid Search]()
    - [5.4 Stochastic Random-Guessing Baseline]()
    - [5.5 Evaluation Framework ]()
        - [5.5.1 Boundary Qualification Router]()
        - [5.5.2 Primary Optimization Metric: Macro-Weighted F1]()
        - [5.5.3 Diagnostic Error Analysis]()
    - [5.6 Results]()
        - [5.6.1 Baseline Performance]()
        - [5.6.2 Terminal Results ]()
        - [5.6.3 Class-Level Results]()
        - [5.6.4 Diagnostic Error Analysis Error]()
    - [5.7 Conclusions, Limitations and Future Work]()

---

## Table and Figure Directory
- [Table 1: Bag-of-Words Input Dimensions]()
- [Table 2: Word2Vec Input Dimensions]()
- [Table 3:  Task 1 MLP Head Hyperparameter Search Space]()
- [Table 4: Per-Class Diagnostic Evaluation Formulations]()
- [Table 5: Task 1 Experiment Results]()
- [Table 6: Class-Level Results, Experiment 1 (Full-Context, Gold Vocab)]()
- [Table 7: Hyperparameter Configurations, Task 2, Variation 2]()
- [Table 8: Hyperparameter Configurations, Task 2, Variation 1, Stage 1]()
- [Table 9: Length-Adaptive Boundary Tolerance ($\delta$)]()
- [Table 10: Task 2 Evaluation Results]()
- [Table 11: Task 2 Class-Level Results]()
- [Table 12: Detection Error Analysis]()
- [Table 13: Ceiling Performance Gap Summary]()

---

## 1 Introduction
Propaganda is the deliberate, systematic attempt to shape perceptions, manipulate cognitions, and direct behavior to achieve a response that furthers the desired intent of the propagandist (Jowett & O'Donnell, 2018). It involves managing collective attitudes by manipulating significant symbols (Lasswell, 1927) and using rhetorical devices to bypass rational analysis rather than relying on outright falsehoods. 

Given the velocity and volume of modern digital information, automated detection mechanisms are increasingly vital for maintaining the integrity of online discourse. This report explores automatically identifying propaganda through two core challenges: classifying known propagandistic snippets (Task 1) and jointly identifying manipulative spans and techniques within raw text (Task 2).

---

### 1.1 Problem Outline
Automating detection is challenging because the boundary between legitimate persuasion and manipulative rhetoric is highly subjective (Da San Martino et al., 2019). Historical models classified entire documents (Rashkin et al., 2017) but modern moderation requires detecting localized nuanced rhetorical shifts. Problematically, such detection must overcome significant structural irregularity as propagandists often sacrifice grammatical purity for rhetorical impact, relying on non-compositional multi-word expressions (Sag et al., 2002) and domain specific terms that present severe out-of-vocabulary challenges for traditional NLP.

---

<br>

## 2 Related Work: Evolution of NLP Computational Methods
NLP evolved from symbolic taxonomies like WordNet (Miller, 1995) to statistical representations based on the Distributional Hypothesis (Harris, 1954). Static word embeddings like Word2Vec (Mikolov et al., 2013) provided dense vectors but failed to resolve polysemy (Peters et al., 2018). Sequential models like LSTMs (Hochreiter and Schmidhuber, 1997) addressed context, leading to the Transformer architecture (Vaswani et al., 2017). Encoders such as BERT (Devlin et al., 2019) replaced recurrence with self-attention to generate dynamic, contextual representations across sentences. Modern NLP relies on autoregressive language models like GPT-3 (Brown et al., 2020), shifting the dominant paradigm from fine-tuning toward in-context learning (Raffel et al., 2020).

---

<br>

## 3 Dataset

### 3.1 Corpus Overview
This report takes a subset of the Propaganda Techniques Corpus, created by Da San Martino et al. (2020) for SemEval-2020-Task-11 which set out to evaluate pipelines identifying and classifying manipulative spans. Our subset tracks nine propaganda techniques, including a `not_propaganda` class, across $2560$ rows. The input data is a string formatted sequence of text containing within it two tags (`BOS` and `EOS`). The text between these tags has been identified as one of the 8 positive propaganda labels, while the remaining text provides neutral sentinel context. The original paper's technique definitions are presented in Appendix A.

---

### 3.2 Universal Pre-Processing
Raw text was cleaned prior to tokenization to standardize text and strip digital artifacts or publication-specific formatting. This removes noise and prevents models from exploiting publisher-specific stylistic backdoors (Appendix B).

---

### 3.3 Data Augmentation: Synthetic Data Enrichement
To mitigate the limited training corpus, a one-to-one generative data augmentation strategy is implemented to produce synthetic propaganda snippets. SemEval-2020 demonstrated several augmentation submissions (Kranzlein et al., 2020) which relied on token substitution but as the competition was pre-GPT-3 (Brown et al., 2020), there are no contemporary, generative approaches. We build on the competition approaches by building a zero-shot Chain-of-Thought prompting (Kojima et al., 2022 and Wei et al., 2022) on a decoder-only Meta `Llama_3_8B` model. Temperature is set to $0.7$ to encourage syntactic reformulation and semantic drift, while the reasoning steps maintain rhetorical intent. The surrounding sentinel context is left untouched. In the methodology, this data is referred to as "Silver", with the training data being "Gold". 

As detailed in Appendix C, the multi-stage prompt chain decomposes generation into three grounded reasoning steps: first, the model assumes a domain-expert role to brainstorm three candidate variants using diverse lexical semantics aligned with the target label; next, it performs contextual validation against the surrounding left and right sentinel text to eliminate syntactic discontinuities; and finally, reviewing its step-by-step reasoning, it selects the single optimal snippet and wraps it within strict XML tags (`<final_output>`) for automated extraction.

---

### 3.4 Feature Tagging 
In Task 1, an input sequence of $N$ whole tokens $T = (t_1, t_2, \dots, t_N)$ is mapped to parallel Part-of-Speech (POS) and Named-Entity Recognition (NER) tag sequences to enrich lexical representations with syntactic and entity-level signals (Khosla et al., 2020) and enforcing strict 1-to-1 sequence length alignment ($\vert{}T\vert{} = \vert{}P\vert{} = \vert{}E\vert{} = N$):

$$P = (p_1, p_2, \dots, p_N), \quad \text{where } p_i \in \mathcal{P}_{12}$$

$$E = (e_1, e_2, \dots, e_N), \quad \text{where } e_i \in \mathcal{E}_{9}$$

Syntactic tagging uses NLTK’s `averaged_perceptron_tagger`, mapping the Penn Treebank tagset down to the 12-category Universal POS tagset $\mathcal{P}_{12}$ (Appendix D). Named-Entity tagging uses spaCy’s `en_core_web_sm` while compressing low-frequency entity classes into a `MISC` slot, reducing the space to 9 categories $\mathcal{E}_{9}$ (Appendix E). Compressing tag spaces prevents sparse classes forming uninformative vector dimensions, reducing overfitting risk on rare entity types.

---

<br>

# 4 Task 1: Propaganda Classification
Task 1 is a single-label, multi-class classification problem targeting instances of recognised but unlabelled propaganda. Experimentally, two non-contextual, static feature representation paradigms are benchmarked: High-dimensional sparse representations derived from frequency-based Bag-of-Words (BoW) modeling against low-dimensional, dense representations from Word2Vec embeddings.

---

### 4.1 Baseline & Experimental Floor
For model calibration, an unintelligent random-guessing baseline defines the lower bound. For an 8-class balanced target distribution, uniform random selection yields an expected accuracy of $P = \frac{1}{8} = 0.125$ ($12.5\%$). To guarantee reproducibility, a random seed is set: $\text{SEED} = 142$.

---

<br>

## 4.2 Approach 1: Bag-of-Words (BoW)
Propaganda frequently relies on distinct, emotionally charged trigger words. A unigram Bag-of-Words (BoW) pipeline decomposes text sequences into high-dimensional, orthogonal count vectors. By mapping terms to independent coordinate axes, count vectors record features as immutable atomic units, ensuring their presence regardless of how the vector develops.

---

### 4.2.1 Vocabulary Construction
"Training" a BoW model involves the construction of a vocabulary $\mathcal{V}_{\text{training}}$. Starting with a global term-frequency dictionary $\mathcal{C}_{\text{gold}}(w)$, singletons ($\mathcal{C}_{\text{gold}}(w) = 1$) are mapped to an out-of-vocabulary token (`__UNK__`). This regularizes the input space, mitigating the memorization of specific entities or niche descriptors. Similarly, high-frequency connective terms are filtered using a custom stopword list (Appendix F). This is done to prevent neutral features overpowering trigger words. The remaining dictionary keys form the vocabulary set $\mathcal{V}_{\text{gold}}$.

$$\mathcal{V}_{\text{gold}} = \{ \text{\_\_UNK\_\_} \} \cup \{ w \in \mathcal{C}_{\text{gold}} \mid \mathcal{C}_{\text{gold}}(w) > 1 \land w \notin \text{Stopwords} \}$$

An index mapping $\mathcal{I}_{\text{vocab}}: w \mapsto i$ translates $\mathcal{V}_{\text{gold}}$ to vector coordinates $i \in \{0, \dots, \vert{}\mathcal{V}_{\text{gold}}\vert{}-1\}$, allowing a sequence of tokens to be parsed into a fixed-dimensional vector space.

---

### 4.2.2 Vocabulary Enrichment
The "Silver" data (Section 3.3) is utilized to provide additional feature density and establish a secondary enriched vocabulary ($\mathcal{V}_{\text{silver}}$). This works by iterating through the synthetic snippets to increment term counts in the term-frequency dictionary $\mathcal{C}_{\text{gold}}(w)$.

This does not introduce new features into the vocabulary, working solely to promote existing singletons past the frequency threshold ($\mathcal{C}_{\text{silver}}(w) > 1$) and shifting viable features out of `__UNK__` and increasing the vector dimensions. This process safeguards legitimate trigger words that were regularized due to limited corpus size.

$$\mathcal{C}_{\text{silver}}(w) = \mathcal{C}_{\text{gold}}(w) + \sum_{S \in \mathcal{D}_{\text{silver}}} \sum_{t_i \in S} \mathbb{I}(t_i = w \land w \in \mathcal{C}_{\text{gold}})$$

---

### 4.2.3 Structural Tagsets
Auxiliary POS ($\vert{}\mathcal{P}\vert{}=12$) and NER ($\vert{}\mathcal{E}\vert{}=10$) channels are vectorized using identical term-frequency mapping. Extracted across full sequences prior to vocabulary regularization, these channels bypass singleton pruning. This guarantees structural and entity signals are retained even when lexical tokens collapse to `__UNK__`. Preserving this context captures propagandistic devices where rare vocabulary is used within distinct relational templates such as framing a target through patterns like `[PERSON]` is `[ADJECTIVE]`.
---

### 4.2.4 Experimental Design
Four vocabulary configurations evaluate dataset splits ($\text{Gold}$ vs. $\text{Gold} + \text{Silver}$) against context windows ($\text{Snippet-Only}$ vs. $\text{Full-Context}$), as detailed in Table 1. Restricting context to "Snippet-Only" strips neutral prose, reducing baseline vector dimensionality by $54.6\%$. Conversely, synthetic enrichment reclaims lost singletons, decreasing discarded hapax terms by $45.4\%$ and expanding active feature dimensions.

##### Table 1: Bag-of-Words Input Dimensions
| Experiment | Vocab ($\|\mathcal{V}\|$) | Singletons Cut | POS Dim | NER Dim | Input Tensor Dim |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Gold Baseline, Full-Context** | 3,265 | 3,038 | 12 | 10 | **3,287** |
| **Silver Enriched, Full-Context** | 4,002 | 2,301 | 12 | 10 | **4,024** |
| **Gold Baseline, Snippet-Only** | 1,483 | 2,051 | 12 | 10 | **1,505** |
| **Silver Enriched, Snippet-Only** | 2,415 | 1,119 | 12 | 10 | **2,437** |

---

### 4.2.5 Model Architecture
Token, POS, and NER frequencies map into three discrete count vectors:

$$\vec{v}_{\text{vocab}}[i] = \sum_{t \in T} \mathbb{I}(\mathcal{I}_{\text{vocab}}(t) = i), \quad \vec{v}_{\text{pos}}[j] = \sum_{p \in P} \mathbb{I}(\mathcal{I}_{\text{pos}}(p) = j), \quad \vec{v}_{\text{ner}}[k] = \sum_{e \in E} \mathbb{I}(\mathcal{I}_{\text{ner}}(e) = k)$$

These vectors are concatenated into a single input tensor $\vec{x}_{\text{input}}$ passed directly to an MLP classification head:

$$\vec{x}_{\text{input}} = \left[ \vec{v}_{\text{vocab}} \parallel \vec{v}_{\text{pos}} \parallel \vec{v}_{\text{ner}} \right] \in \mathbb{R}^{\vert{}\mathcal{V}\vert{} + \vert{}\mathcal{P}\vert{} + \vert{}\mathcal{E}\vert{}}$$

While structural auxiliary channels remain constant ($\vert{}\mathcal{P}\vert{}=12$, $\vert{}\mathcal{E}\vert{}=10$), the MLP input space dynamically scales ($\mathbb{R}^{1,505}$ to $\mathbb{R}^{4,024}$) based on the experimental configuration.

---

<br>

## 4.3 Approach 2: Word2Vec (W2V)

To mitigate the Zipfian sparsity inherent to small propaganda corpora, Word2Vec maps semantic similarity into geometric proximity (Mikolov et al., 2013). By performing implicit matrix factorization (Levy & Goldberg, 2014), continuous embeddings share statistical strength across synonyms, allowing the classifier to recognize alternative phrasing and generalize across synonymous rhetorical injections. As propaganda techniques frequently manifest as localized emotive triggers, Word2Vec's local window optimization provides a superior representation over global co-occurrence models (Baroni et al., 2014).

---

### 4.3.1 Pre-Trained Word2Vec Model
Training a custom Word2Vec model on a corpus of this size would overfit embeddings to propagandistic contexts rather than standard linguistic usages. Deploying pre-trained Google News embeddings ($\mathbf{E} \in \mathbb{R}^{\vert{}V_{\text{google}}\vert{} \times 300}$) grounds words in task-agnostic meanings. This semantic baseline enables the classifier to identify manipulative language as anomalous usage patterns, improving linear separability across rhetorical techniques.

---

### 4.3.2 Vocabulary Constraints
Using a pre-trained Word2Vec model involves mapping vocabulary terms to an embedding lookup space. To maintain experimental control, the lookup was restricted to the vocabulary topologies defined in Approach 1, isolating embedding density (Sparse vs. Dense) as the sole independent variable and omitting the model's superior vocabulary depth. Consequently, the pipeline retains a frequency-based OOV (`__UNK__`) slot for rare terms. This is scaled $c_{\text{unk}} \in [0, 1]$ to match Word2Vec embedding magnitudes and therefore reflects OOV density.

---

### 4.3.3 Model Architecture
To construct sequence representations from word vectors, valid tokens are aggregated using arithmetic mean-pooling:

$$\vec{v}_{\text{w2v}} = \frac{1}{\vert{}T_{\text{valid}}\vert{}} \sum_{w \in T_{\text{valid}}} \mathbf{E}(w)$$

Given vector addition is commutative, mean-pooling discards word order and compositional syntax meaning Word2Vec's capacity to process non-compositional syntactic departures is restricted to the signal strength of isolated trigger words and their linear combinations. 

To assemble the final input tensor $\vec{x}_{\text{input}}$, the structural tagset count vectors ($\vec{v}_{\text{pos}}$ and $\vec{v}_{\text{ner}}$) are a$L_1$-normalized into relative probability distributions ($[0, 1]$), aligning to embedding magnitudes and preventing unscaled integer counts from dominating loss gradients during backpropagation:

$$\tilde{\vec{v}}_{\text{pos}} = \frac{\vec{v}_{\text{pos}}}{\sum_j \vec{v}_{\text{pos}}[j]}, \quad \tilde{\vec{v}}_{\text{ner}} = \frac{\vec{v}_{\text{ner}}}{\sum_k \vec{v}_{\text{ner}}[k]}$$

The concatenated input vector $\vec{x}_{\text{input}} \in \mathbb{R}^{323}$ is fed directly into the MLP classification head. Unlike the dynamically scaled BoW input space, this tensor dimension remains strictly invariant ($\mathbb{R}^{323}$) across all experimental conditions.

$$\vec{x}_{\text{input}} = \left[ \vec{v}_{\text{w2v\_300d}} \parallel c_{\text{unk}} \parallel \tilde{\vec{v}}_{\text{pos\_12d}} \parallel \tilde{\vec{v}}_{\text{ner\_10d}} \right] \in \mathbb{R}^{323}$$

##### Table 2: Word2Vec Input Dimensions

| Experiment | Vocab ($\|\mathcal{V}\|$) | Singletons Cut | Word2Vec Dim | POS Dim | NER Dim | Input Tensor Dim |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Gold Baseline, Full-Context** | 3,265 | 3,038 | 300 (+1 $c_{\text{unk}}$) | 12 | 10 | **323** |
| **Silver Enriched, Full-Context** | 4,002 | 2,301 | 300 (+1 $c_{\text{unk}}$) | 12 | 10 | **323** |
| **Gold Baseline, Snippet-Only** | 1,483 | 2,051 | 300 (+1 $c_{\text{unk}}$) | 12 | 10 | **323** |
| **Silver Enriched, Snippet-Only** | 2,415 | 1,119 | 300 (+1 $c_{\text{unk}}$) | 12 | 10 | **323** |

---

<br>

## 4.4 Standardized MLP Classification Head
To isolate representation quality from architectural bias, a standardized Multi-Layer Perceptron (MLP) classification head is used throughout Task-1 and dynamically adapts to incoming feature tensors.

$$\mathbf{x} = [\mathbf{x}_{\text{sem}} \mathbin{\Vert} \mathbf{x}_{\text{POS}} \mathbin{\Vert} \mathbf{x}_{\text{NER}}], \quad d_{\text{in}} = d_{\text{sem}} + 22$$

Grounded in the Universal Approximation Theorem (Hornik et al., 1989), a single hidden layer prevents overfitting while resolving non-linear decision boundaries. The forward pass applies linear projection, ReLU activation to capture non-linearity, Layer Normalization o stabilize instance updates, Dropout regularization ($p$), and a terminal linear projection emitting 8-way logits $\mathbf{s} \in \mathbb{R}^8$:

$$\mathbf{h} = \text{ReLU}(\mathbf{W}_1 \mathbf{x} + \mathbf{b}_1)$$
$$\mathbf{z} = \text{Dropout}(\text{LayerNorm}(\mathbf{h}), p)$$
$$\mathbf{s} = \mathbf{W}_2 \mathbf{z} + \mathbf{b}_2$$

Parameters update using multi-class Cross-Entropy Loss. Maintaining this uniform topology guarantees performance variances reflect representation geometry rather than head capacity.

---

### 4.4.1 Hyperparameter Optimization
A grid search over 3 hyperparameters (Table 3) was conducted on a $10\%$ modulo validation split recording performance checkpoints across 5 epochs. The search revealed sparse BoW models required higher hidden capacity ($d_{\text{hidden}} = 128$), aggressive dropout ($p = 0.5$), a conservative learning rate ($\eta = 0.0001$), and early stopping at 3 epochs to prevent sparse memorization, whereas dense W2V models converged smoothly with a compact hidden layer ($d_{\text{hidden}} = 64$), moderate dropout ($p = 0.3$), a higher learning rate ($\eta = 0.001$), and full 5-epoch training.

##### Table 3: Task 1 MLP Head Hyperparameter Search Space
| Hyperparameter | Search Space | BoW Optimal | Word2Vec Optimal |
| :--- | :---: | :---: | :---: |
| **Hidden Layer Dim ($d_{\text{hidden}}$)** | $\{64, 128\}$ | $128$ | $64$ |
| **Learning Rate ($\eta$)** | $\{0.005, 0.001, 0.0005, 0.0001\}$ | $0.0001$ | $0.001$ |
| **Dropout Rate ($p$)** | $\{0.3, 0.5\}$ | $0.5$ | $0.3$ |
| **Optimal Training Epochs** | Tested up to $5$ | $3$ | $5$ |
| **Weight Decay ($\lambda$)** | Fixed ($0.05$) | $0.05$ | $0.05$ |
| **Optimizer** | AdamW | AdamW | AdamW |
---

--- 

<br>

## 4.5 Evaluation Framework
Although our corpus is balanced, real-world propaganda datasets are typically highly imbalanced (Da San Martino et al., 2020). Consequently, we design an evaluation framework tailored to imbalanced test distributions. Standard accuracy is an insufficient terminal evaluation metric because it is vulnerable to masking poor minority performance behind dominant classes.

In a single-label multi-class setting across $K$ classes, Micro-averaged $F_1$ score mathematically decomposes into global accuracy, making it blind to systematic class imbalances:

$$\text{Accuracy} = \text{Micro-F}_1 = \frac{\sum_{k=1}^{K} \text{TP}_k}{\sum_{k=1}^{K} (\text{TP}_k + \text{FP}_k)}$$

Macro-averaged $F_1$ score calculates the harmonic mean of precision and recall for each class independently before averaging them unweighted:

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

<br>

## 4.6 Results
### 4.6.1 Bag-of-Words Results
The BoW framework achieved top performance under the "Gold-Only, Full-Context" experiment ($\text{Macro-}F_1 = 0.3200$). Systematically evaluating the experiments reveals interactions between context scope, feature density, and synthetic data augmentation.

Restricting input to "Snippet-Only" sequences was intended to isolate emotional trigger words, yet it degraded performance across Gold ($0.3200 \to 0.3183$) and Enriched ($0.3174 \to 0.3129$) splits. Paralleling Pedersen (2010), retaining broader background text provides essential co-occurrence statistics that cushion sparse vector spaces, proving that surrounding context acts as a vital data-density stabilizer.

The silver enrichment ($\mathcal{V}_{\text{silver}} = 4,002\text{D}$) consistently impaired generalization. LLM reformulations introduced semantic drift, corrupting the linear boundaries required to isolate lexical triggers and suggesting precise terms denote propaganda rather than semantic equivalents. Furthermore, promoting singletons into active dimensions expanded vector sparsity, allowing the classifier to memorize spurious synthetic artifacts.

All BoW variants suffered from severe overfitting, exhibiting a generalization gap ($\Delta F_1 \approx 0.51$) between training ($0.8314$) and test evaluation ($0.3200$). High-dimensional sparse inputs allowed the MLP head to memorize exact training co-occurrences rather than learning abstract, transferable rules for unseen propaganda.

##### Table 5: Task 1 Experiment Results
| Model & Experiment | Vector Dims ($d_{\text{sem}}$) | Test Accuracy | Test Macro-$F_1$ | Test Macro-Precision | Test Macro-Recall | Train Accuracy | Train Macro-$F_1$ | Train Macro-Precision | Train Macro-Recall |
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

### 4.6.2 Word2Vec Results
Word2Vec underperformed the BoW baseline across all experiments, peaking at $0.2927$ Test Macro-$F_1$ under "Gold Baseline, Snippet-Only" and suffering an average terminal drop of $\Delta 0.035$. With identical heads, this differential isolates a fundamental representational bottleneck in static continuous vector spaces for propaganda detection.

Propaganda relies on exact lexical choices rather than broad distributional semantics. While BoW represents loaded terms and neutral equivalents as orthogonal dimensions, Word2Vec maps them into overlapping geometric clusters ("regime" vs. "government"), blurring linear decision boundaries.

Furthermore, mean-pooling dilutes manipulative signals with neutral prose, pulling the centroid towards generic news representation. This mechanism explains why Word2Vec peaked under the Snippet-Only condition ($0.2927$) rather than Full-Context ($0.2835$). Stripping neutral background tokens reduces the averaging denominator, allowing trigger vectors to retain higher proportional weight.

Unlike BoW’s high variance, Word2Vec suffered from severe high-bias underfitting, achieving a Train Macro-$F_1$ of only $0.4646$ (vs. BoW’s $0.8148$). However, its compact generalization gap ($\Delta F_1 = 0.1719$) confirms that while mean-pooling causes severe signal loss, continuous representations maintain stable out-of-sample consistency.

---

### 4.6.3 Class-Level Diagnostic Error Analysis
Class-level performance in Experiment 1 (Full-Context, Gold) demonstrates how representation geometry directly interacts with specific propaganda techniques. BoW outperforms Word2Vec on `Repetition` ($F_1 = 0.33$ vs. $0.18$) because count vectors preserve token frequency mass, whereas commutative mean-pooling erases duplicate tokens, collapsing Word2Vec recall to $0.12$. Similarly, BoW excels at `Exaggeration,Minimisation` ($F_1 = 0.36$ vs. $0.26$) because extrema modifiers ("always", "never") serve as discrete orthogonal triggers in sparse space, pushing BoW recall to $0.50$, whereas continuous smoothing softens these terms toward generic degree adverbs. On `Loaded Language`, isolated emotive triggers wash out within mean-pooled document centroids, causing Word2Vec performance to collapse ($F_1 = 0.04$, recall $= 0.03$). Conversely, Word2Vec surpasses BoW on entity-driven classes like `Flag Waving` ($F_1 = 0.54$ vs. $0.46$) and `Appeal to Fear/Prejudice` ($F_1 = 0.40$ vs. $0.33$), as embeddings cluster nationalistic symbols into robust continuous concepts, yielding $0.82$ recall on `Flag Waving`.

##### Table 6: Class-Level Results, Experiment 1 (Full-Context, Gold Vocab)
| Class | $F_1$ (BASE) | $F_1$ (BoW) | $F_1$ (W2V) | Precision (BoW) | Precision (W2V) | Recall (BoW) | Recall (W2V) |
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

<br>

## 4.7 Conclusion, Limitations, and Future Work
This study systematically benchmarked sparse discrete representations against static continuous vector spaces for propaganda detection. Contradicting the general NLP paradigm favoring dense embeddings, empirical results demonstrated that discrete orthogonality is superior for isolating manipulative text. The unigram Bag-of-Words (BoW) model ($\text{Macro-}F_1 = 0.3200$) outperformed dense Word2Vec ($\text{Macro-}F_1 = 0.2927$), providing strong empirical support for power of lexical triggers and aligning previous studies (Cruz et al., 2019). BoW dominated techniques reliant on exact string matches, such as `repetition` ($0.33$ vs. $0.18$) and `exaggeration,minimization` ($0.36$ vs. $0.26$), as orthogonal dimensions preserve token frequencies structuring decision boundaries. Furthermore, evaluating context windows revealed that surrounding neutral text acts as essential data-density stabilizer, with snippet-only representations consistently degrading performance.

Several methodological limitations constrained overall performance. Both paradigms hit a structural precision ceiling ($\sim 0.30\text{--}0.35$) due to vocabulary overlap, as common news terminology triggered widespread false positives without contextual awareness. Additionally, constraining Word2Vec’s lookup space to match BoW suppressed its native out-of-vocabulary generalization. Silver enrichment introduced unvalidated semantic drift, corrupting linear boundaries, while BoW’s reliance on raw counts without TF-IDF weighting allowed ubiquitous non-informative terms to retain unscaled frequency mass.

Future work could explore hybrid models that leverage BoW’s orthogonal trigger precision to dynamically weight Word2Vec sequence pooling, alongside evaluating Word2Vec with unconstrained OOV handling. Ultimately, overcoming the precision ceiling requires transitioning to Transformer encoders whose self-attention mechanisms provide the contextual reasoning needed to separate objective reporting from manipulative prose.

---

<br>

# 5 Task 2: Joint Propaganda Span Detection and Classification
Task 2 expands the experimental scope from classifying known, unlabelled instances of propaganda to jointly identifying manipulative text boundaries and classifying the sequence technique. This objective is framed as a token-level sequence labeling task utilising the Beginning, Inside, Outside (BIO) encoding schema. Formally, given an input sequence of $N$ tokens $\mathbf{x} = (x_1, x_2, \dots, x_N)$, the model learns a mapping function $f: \mathbf{x} \to \mathbf{y}$ to predict a sequence of target tags $\mathbf{y} = (y_1, y_2, \dots, y_N)$ from a label space $y_i \in \mathcal{Y}$:

- $y_i = \text{O}$ for neutral, non-propagandistic context.
- $y_i = \text{B}$ for the initial triggering propaganda token.
- $y_i = \text{I}$ for interior span tokens.

The figure below demonstrates a sequence translation:

$$
\begin{array}{rcccccccccccccc}
\text{Tokens } (x_i): & \texttt{[CLS]} & \texttt{The} & \texttt{mainstream} & \texttt{media} & \texttt{is} & \texttt{spreading} & \mathbf{\texttt{blatant}} & \mathbf{\texttt{lies}} & \texttt{about} & \texttt{the} & \texttt{policy} & \texttt{.} & \texttt{[SEP]} \\[2pt]
& \downarrow & \downarrow & \downarrow & \downarrow & \downarrow & \downarrow & \downarrow & \downarrow & \downarrow & \downarrow & \downarrow & \downarrow & \downarrow \\[2pt]
\text{BIO Tags } (y_i): & \texttt{O} & \texttt{O} & \texttt{O} & \texttt{O} & \texttt{O} & \texttt{O} & \mathbf{\texttt{B}} & \mathbf{\texttt{I}} & \texttt{O} & \texttt{O} & \texttt{O} & \texttt{O} & \texttt{O}
\end{array}
$$

The methodologies for Task 2 are derived as variations of an adapted, modernized CNN-BiLSTM-CRF framework (Ma and Hovy, 2016)

---

<br>

## 5.1 Architectural Approach
The methodologies for Task 2 are derived as variations of an adapted, modernized CNN-BiLSTM-CRF framework (Ma and Hovy, 2016).

Ma and Hovy’s (2016) classical sequence-tagging framework combined character-level CNNs for morphological extraction, Bidirectional LSTMs for contextual dependencies, and a Conditional Random Field (CRF) decoder to enforce valid tag transitions. Applied to propaganda detection, this architecture captures manipulative superlative affixes (e.g., -est), long-range rhetorical framing, and structural constraints. Crucially, the CRF enables high-confidence interior tokens to resolve ambiguous span boundaries. This dynamic is formalized as the "breadcrumb effect" and mitigates noisy annotation boundaries (Da San Martino et al., 2019).

This project modernizes the classical baseline by replacing sequential and convolutional layers with a pre-trained DeBERTa encoder while retaining terminal CRF global decoding. This architectural shift yields four core advantages. SentencePiece tokenization natively standardizes subword morphology, eliminating the need to train dedicated character-CNNs. Global self-attention replaces recurrency to prevent context decay. Fine-tuning pre-trained representations mitigates catastrophic overfitting on small corpora. Finally, DeBERTa’s disentangled attention decouples content from relative position. This grants the model the spatial awareness needed when neutral vocabulary is weaponized through strategic placement.

To benchmark this modernized pipeline, we evaluate two architectural variations: a Decoupled Two-Stage Tagger (Variation 1) and an Integrated Multi-Class BIO-CRF Pipeline (Variation 2).

---

<br>

## 5.2 Architecture Variation 2: The Integrated Multi-Class BIO-CRF Model
Variation 2 frames propaganda detection as an end-to-end joint sequence labeling task, learning span boundaries and technique classifications simultaneously. This is achieved by expanding the 17-state BIO schema, joining `B-` and `I-` prefixes with technique suffixes plus a neutral `O` state (Appendix G):

$$\mathcal{Y}_{17} = \{\text{O}\} \cup \{\text{B-}k \mid k \in \mathcal{T}\} \cup \{\text{I-}k \mid k \in \mathcal{T}\}$$

This granular label space optimizes boundaries and techniques in tandem. Tag expansion enhances the "breadcrumb effect" during decoding. Instead of collapsing uncertain boundaries into an uninformative ~50/50 binary split, probability mass is dispersed across technique states. When a small boundary mass aligns with a high-confidence interior token, the CRF transition matrix leverages that semantic linkage to pull ambiguous boundary tokens into coherent spans.

---

### 5.2.1 Model Architecture
Coupling a pre-trained Transformer with a Linear-Chain CRF, `deberta-v3-xsmall` encodes input sequence $\mathbf{x} = (x_1, \dots, x_N)$ into representations $\mathbf{H} \in \mathbb{R}^{N \times 384}$:

$$\mathbf{H} = \text{DeBERTa}(\mathbf{x})$$

A linear layer projects $\mathbf{H}$ to unnormalized emission logits $\mathbf{E} \in \mathbb{R}^{N \times 17}$:

$$\mathbf{E}_i = \mathbf{W}_e \mathbf{H}_i + \mathbf{b}_e \quad (i \in \{1, \dots, N\})$$

To eliminate local independence assumptions, $\mathbf{E}$ is passed to a Linear-Chain CRF with a trainable transition matrix $\mathbf{A} \in \mathbb{R}^{17 \times 17}$. Invalid paths, such as initiating spans on interior tags ($\text{O} \to \text{I-}k$) or mid-phrase technique switches ($\text{B-}k_1 \to \text{I-}k_2$), are masked with hard penalties ($-10000.0$).

Sequence score $S(\mathbf{x}, \mathbf{y})$ sums emissions and transitions:

$$S(\mathbf{x}, \mathbf{y}) = \sum_{i=1}^{N} \mathbf{E}_{i, y_i} + \sum_{i=1}^{N-1} \mathbf{A}_{y_i, y_{i+1}}$$

Training minimizes the negative log-likelihood (NLL) of the gold path $\mathbf{y}^*$:

$$\mathcal{L}_{\text{CRF}}(\theta) = -\log \left( \frac{\exp(S(\mathbf{x}, \mathbf{y}^*))}{\sum_{\mathbf{y}' \in \mathcal{Y}^{N}} \exp(S(\mathbf{x}, \mathbf{y}'))} \right)$$

Inference uses Viterbi decoding to extract the optimal path $\hat{\mathbf{y}}$:

$$\hat{\mathbf{y}} = \arg\max_{\mathbf{y}' \in \mathcal{Y}^{N}} S(\mathbf{x}, \mathbf{y}')$$

---

### 5.2.2 Hyperparameter Search & Optimization Strategy
To prevent gradient instability, the pipeline uses differential learning rates with AdamW. Co-training pre-trained DeBERTa alongside randomly initialized linear projection and CRF layers creates an optimization imbalance where standard CRF learning rates ($10^{-3}$) risk destroying encoder features, whereas typical transformer rates ($10^{-5}$) stall CRF convergence.

A hyperparameter search across three configurations identified optimal bounds, with the conservative setup (Run 1) achieving the lowest loss (NLL = $3.7016$).

This differential scheme preserves DeBERTa's representations for subtle rhetorical cues while enabling the CRF to rapidly learn structural transitions. Micro-batching ($B=16$) prevents loss saturation on background `O` tokens, while AdamW weight decay ($0.01$) and gradient clipping ($\le 1.0$) stabilize CRF optimization against heavy transition penalties. The production model was trained for 10 epochs under Run 1 parameters.

##### Table 7: Hyperparameter Configurations, Task 2, Variation 2
| Parameter Configuration | Transformer LR ($\eta_{\text{base}}$) | Heads LR ($\eta_{\text{head}}$) | Batch Size ($B$) | Dev Loss (CRF NLL) |
| :--- | :---: | :---: | :---: | :---: |
| **Run 1 (Conservative)** | **1e-5** | **5e-4** | **16** | **3.7016** *(Selected)* |
| **Run 2 (Moderate)** | 2e-5 | 1e-3 | 16 | 4.0252 |
| **Run 3 (Aggressive)** | 5e-5 | 2e-3 | 32 | 4.2202 |

---

<br>

## 5.3 Architecture Variation 1: Decoupled, Two-Stage Tagger
Variation 1 adopts a modular pipeline that decouples propaganda detection into two specialized sub-networks:
1. **Stage 1 (Span Localization Tagger):** A 3-class sequence tagger ($\mathcal{Y}_3 = \{\text{O}, \text{B-Propaganda}, \text{I-Propaganda}\}$) trained exclusively to identify propagandistic boundaries within full-sentence context.
2. **Stage 2 (Technique Classifier Head):** An independent Multi-Layer Perceptron (MLP) that mean-pools subword embeddings from Stage 1’s predicted spans and categorizes them into one of eight rhetorical techniques.

$$\mathcal{Y}_3 = \{\text{O}, \text{B-Propaganda}, \text{I-Propaganda}\}$$

Collapsing techniques into a 3-class target maximizes positive label density, enabling Stage 1 to learn robust generalized propaganda boundaries without fragmentation from rare sub-classes. Stage 2 then acts as a specialized domain expert, optimizing rhetorical features independently. 

---

### 5.3.1 Model Architecture
Stage 1 employs the same DeBERTa-CRF architecture but restricts emissions to $\mathbf{E} \in \mathbb{R}^{N \times 3}$ and transitions to $\mathbf{A} \in \mathbb{R}^{3 \times 3}$. When Stage 1 detects an active span, Stage 2 re-encodes the sentence into token representations $\mathbf{H} \in \mathbb{R}^{N \times 384}$, slices the sequence to predicted indices $[p_{\text{start}}, p_{\text{end}}]$, and isolates the target vectors. This slicing is done to intensify the core propaganda signal and strip away uninformative neutral text that has already been contextualized by DeBERTa’s self-attention layers. The sliced embeddings are mean-pooled into a fixed 384-dimensional vector $\mathbf{h}_{\text{pooled}}$ and processed through a two-layer MLP classification head:

$$\mathbf{z} = \text{Linear}_{64 \to 8}\Big(\text{Dropout}\Big(\text{LayerNorm}\Big(\text{ReLU}\Big(\text{Linear}_{384 \to 64}(\mathbf{h}_{\text{pooled}})\Big)\Big)\Big)\Big)$$

The initial projection ($384 \to 64$) compresses dense noise, ReLU introduces non-linear decision boundaries, Layer Normalization stabilizes small-batch variance ($B=16$), and Dropout ($p=0.3$) prevents topic memorization. If no span is detected ($p_{\text{start}} = -1$), the pipeline defaults to neutral text, bypassing Stage 2.

---

### 5.3.2 Hyperparameter Search & Optimization Strategy
#### 5.3.2.1 Stage 2 Head Training & Performance Ceiling
Stage 2 was trained on the gold-standard spans, abstracting it from any detection pipeline errors. Keeping DeBERTa frozen to retain linguistic baseline, the MLP head ($\theta_{\text{MLP}}$) was optimized with multi-class Cross-Entropy loss ($\mathcal{L}_{\text{CE}}$) using AdamW ($\text{LR} = 10^{-3}, B = 16$) over 10 epochs:

$$\mathcal{L}_{\text{CE}}(\theta_{\text{MLP}}) = -\sum_{k=1}^{8} y_{k} \log \hat{y}_{k}$$

The trained model established a performance ceiling of $0.5106$ Macro-$F_1$ ($0.5178$ Accuracy), benchmarking the maximum theoretical classification performance given $100\%$ spatial localization.

#### 5.3.2.2 Stage 1 Hyperparameter Grid Search
Stage 1 (Sequence Labeller) parameters ($\theta_{\text{S1}}$) were trained by minimizing negative log-likelihood ($\mathcal{L}_{\text{CRF}}$) over 3-class space $\mathcal{Y}_3$:

$$\mathcal{L}_{\text{CRF}}(\theta_{\text{S1}}) = -\log \left( \frac{\exp(S(\mathbf{x}, \mathbf{y}^*))}{\sum_{\mathbf{y}' \in \mathcal{Y}_3^{N}} \exp(S(\mathbf{x}, \mathbf{y}'))} \right)$$

A grid-search across learning rates evaluated Viterbi paths against ground-truth spans using length-adaptive $\delta$-tolerance routing. Trial 9 achieved top spatial performance ($0.3834$ Span-$F_1$).

The final system couples both stages: Stage 1 extracts span bounds using Viterbi decoding under Trial 9 parameters, and Stage 2 classifies active spans into 8-way technique predictions.

##### Table 8: Hyperparameter Configurations, Task 2, Variation 1, Stage 1
| Trial | Transformer LR ($\eta_{\text{base}}$) | Heads LR ($\eta_{\text{head}}$) | Span Precision | Span Recall | Standalone Span-$F_1$ |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Trial 1** | 5e-6 | 3e-4 | 0.4327 | 0.2395 | 0.3083 |
| **Trial 4** | 1e-5 | 3e-4 | 0.4140 | 0.2492 | 0.3111 |
| **Trial 6** | 1e-5 | 1e-3 | 0.4415 | 0.2686 | 0.3340 |
| **Trial 9 (Selected)** | **3e-5** | **1e-3** | **0.4924** | **0.3139** | **0.3834** |

---

<br>

## 5.4 Stochastic Random-Guessing Baseline
To establish a mathematical lower bound and confirm authentic rhetorical patterns learning, we implement a probabilistic baseline operating using a three-step stochastic sampling procedure:
1. A Bernoulli trial determines propaganda existence using the training set's positive label distribution $P$. Sentences flagged as clean return all `O` tags.
2. If propaganda is flagged, start and end indices $(i, j)$ are drawn uniformly at random:

$$i \sim \text{Uniform}(1, N), \quad j \sim \text{Uniform}(i, N)$$

3. A technique $k$ is drawn uniformly across the 8 categories:

$$k \sim \text{Uniform}(1, 8)$$

This generates a triple $(1, [i, j], k)$, mapping tokens to BIO tags. For example, in a 5-token sequence where $(i=2, j=3, k=\text{Loaded})$, token $t_2$ maps to `B-Loaded`, $t_3$ to `I-Loaded`, and remaining tokens to `O`. Evaluated via our test suite, this establishes our benchmark performance floor.

---

<br>

## 5.5 Evaluation Framework 
Evaluating propaganda sequence labeling requires balancing spatial boundary precision with technique classification. To establish an interpretable benchmark, our evaluation approach combines adaptive boundary routing, penalized error scoring, and a diagnostic audit.

---

### 5.5.1 Boundary Qualification Router
To accommodate minor offsets without masking severe misalignment, predicted spans $(p_{\text{start}}, p_{\text{end}})$ are evaluated against gold spans $(g_{\text{start}}, g_{\text{end}})$ using a length-adaptive tolerance window ($\delta$). This mimics the lack of agreement observed on human annotators (Da San Martino et al., 2019).

Predictions passing the gate ($\vert p_{\text{start}} - g_{\text{start}} \vert \le \delta$ and $\vert p_{\text{end}} - g_{\text{end}} \vert \le \delta$) qualify for classification. Correct technique predictions yield a True Positive (TP) and incorrect techniques yield a misclassification. Spans failing $\delta$-tolerance receive a double penalty—scored simultaneously as a False Positive (hallucination) and a False Negative (omission).

##### Table 9: Length-Adaptive Boundary Tolerance ($\delta$)
| Span Length (Tokens) |
| :--- | :--- |
| **$\le 5$** | 0 tokens |
| **$6\text{--}10$** | $\pm 1$ token |
| **$11\text{--}15$** | $\pm 2$ tokens |
| **$16\text{--}50$** | Step-wise scaling |
| **$> 50$** | $\pm 10$ tokens |
---

### 5.5.2 Primary Optimization Metric: Macro-Weighted F1
Continuing from Task 1 (Section 4.5), terminal performance is evaluated using the standard Macro-$F_1$ score averaged across the eight active propaganda categories $\mathcal{T}$:

$$\text{Macro-F1} = \frac{1}{\vert{}\mathcal{T}\vert{}} \sum_{k \in \mathcal{T}} \frac{2 \cdot P_k \cdot R_k}{P_k + R_k}$$

Predicted spans must pass through the boundary router before technique evaluation, therefore, localization failures directly penalize $P_k$ and $R_k$. Consequently, higher Macro-$F_1$ scores inherently reflects superior boundary detection alongside accurate technique classification. Due to this joint dependency, Task 1 and Task 2 Macro-$F_1$ metrics are not directly comparable. Task 1's metric evaluates classification over fixed pre-delimited spans, Task 2's measures end-to-end joint span detection and classification.

---

### 5.5.3 Diagnostic Error Analysis
To isolate detection errors from downstream misclassifications, a three-phase audit is conducted. First, sequence predictions (Stage 1) are categorised into True Negatives, Omissions, Hallucinations, Disqualified Near-Misses, or Qualified Spans to evaluate boundary isolation capabilities. Second, the near-miss analysis evaluates technique accuracy on the subset of predicted but disqualified spans to test whether misaligned predictions maintain rhetorical features. Finally, the ceiling gap analysis compares multi-class technique accuracy on qualified spans against the ceiling model, quantifying the exact performance degradation caused by boundary noise and embedding offsets.

---

<br>

## 5.6 Results
Empirical performance is presented across the stochastic random baseline, Variation 1 (Decoupled), and Variation 2 (Integrated). Evaluated on the test split ($N = 640$ sentences; $309$ positive instances) using our length-adaptive boundary routing ($\delta$), performance is reported across Macro Precision, Recall, and $F_1$.

---

### 5.6.1 Baseline Performance
A stochastic random-guessing baseline established the empirical lower bound, sampling span presence using a training prior ($52.19\%$) while drawing token bounds and techniques uniformly at random. The baseline achieved a Macro-$F_1$ of $0.0027$ (Precision: $0.0026$, Recall: $0.0028$). Out of $334$ active predictions across $640$ validation sentences, only $11$ spans satisfied $\delta$-tolerance routing, with zero correct technique assignments.

This near-zero floor highlights the complexity of joint sequence tagging. In propaganda detection, arbitrary span extraction almost universally fails because manipulative phrases are tightly embedded within neutral syntactic prose. Thus, any non-trivial performance achieved directly reflects learned linguistic representations rather than stochastic spatial alignment.

---

### 5.6.2 Terminal Results
End-to-end evaluation demonstrates that Variation 2 (Integrated) outperforms Variation 1 (Decoupled) across all primary metrics. Variation 2 achieved a terminal Macro-$F_1$ of $0.2034$, exceeding Variation 1 ($0.1684$) by $3.5$ percentage points.

The substantial advantage in Macro Precision ($0.2914$ vs. $0.2000$) reflects capacity to suppress false-positive hallucinations on background text. Jointly optimizing boundaries and techniques within a unified 17-state CRF allows interior technique signals (e.g., `I-Loaded`) to refine span edges, avoiding the single-point localization bottleneck that limits Variation 1. Furthermore, Variation 2 demonstrated a superior Macro Recall ($0.1698$ vs. $0.1500$). Given the sparsity of manipulative text relative to surrounding neutral text, this $1.98$ percentage point absolute gain enables the integrated tagger to discover $\sim 13\%$ more total propaganda targets ($40$ vs. $35$ targets across $640$ validation sentences).

##### Table 10: Task 2 Evaluation Results
| Pipeline | Macro Precision | Macro Recall | Macro-F1 |
| :--- | :---: | :---: | :---: |
| **Random-Guessing Baseline** | 0.0026 | 0.0028 | 0.0027 |
| **Variation 1 (Decoupled Cascade)** | 0.2000 | 0.1500 | 0.1684 |
| **Variation 2 (17-Class Joint Tagger)** | **0.2914** | **0.1698** | **0.2034** |

---

### 5.6.3 Class-Level Results
Per-class metrics reveal key trade-offs across propaganda techniques. Variation 2 achieves higher $F_1$ scores across five of eight categories, driven by sharp precision gains on classes like `name_calling,labeling` ($0.50$ vs. $0.21$). Both architectures performed best on explicit, structural categories like `causal_oversimplification` ($F_1 = 0.36$), where overt logical connectors ("because of") form clear contextual anchors.

Conversely, `flag_waving` is the sole category where Variation 1 led ($F_1 = 0.32$ vs. $0.20$), as its generic 3-class tagger captures extended multi-word entity phrases without multi-class state fragmentation. Joint decoding yielded its most dramatic improvement on `exaggeration,minimisation`, boosting $F_1$ from $0.04$ to $0.19$ via a 7-fold recall surge ($0.03 \to 0.20$). Short, implicit triggers like `loaded_language` ($F_1 \le 0.10$) remained difficult, as isolated emotive words frequently fail exact-match $\delta$-tolerance checks ($L \le 5$) when adjacent adverbs are slightly over-predicted.

##### Table 11: Task 2 Class-Level Results
| Technique | Var 1 Precision | Var 1 Recall | Var 1 F1 | Var 2 Precision | Var 2 Recall | Var 2 F1 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **flag_waving** | 0.33 | 0.31 | **0.32** | 0.29 | 0.16 | 0.20 |
| **appeal_to_fear_prejudice** | 0.15 | 0.14 | 0.14 | **0.32** | **0.19** | **0.24** |
| **causal_oversimplification** | 0.39 | **0.34** | **0.36** | **0.42** | 0.31 | **0.36** |
| **doubt** | 0.22 | 0.16 | 0.19 | **0.32** | **0.23** | **0.27** |
| **loaded_language** | 0.09 | 0.03 | 0.04 | **0.10** | **0.10** | **0.10** |
| **name_calling,labeling** | 0.21 | **0.15** | 0.17 | **0.50** | 0.12 | **0.19** |
| **repetition** | 0.17 | **0.05** | **0.11** | **0.20** | **0.05** | 0.08 |
| **exaggeration,minimisation** | 0.06 | 0.03 | 0.04 | **0.18** | **0.20** | **0.19** |
| **Macro Average** | 0.20 | 0.15 | 0.17 | **0.29** | **0.17** | **0.20** |

---

### 5.6.4 Diagnostic Error Analysis Error
The performance gains of Variation 2 stem from span hallucination suppression ($12.7\%$ vs. $33.5\%$) and superior span qualification ($42.7\%$ vs. $32.0\%$). While both models filter background text effectively ($\sim 98\%$ True Negatives), Variation 1's Stage 1 boundary detector passes $111$ false spans downstream to trigger cascading false positives in the Stage 2 classifier.

Filtering to router disqualified spans we see that Variation 1's Stage 2 and Variation 2 retain $42.3\%$ and $46.1\%$ technique accuracy, highlighting a deficiency with the $\delta$-tolerance windows to locate core manipulative phrases. This proves models capture true semantic signals despite boundary drift, highlighting further the inter-annotator consensus problem (Da San Martino et al., 2019).

Finally, comparison against ceiling performance demonstrates that on qualified spans ($N=102$), Variation 2 achieves $0.5098$ accuracy, virtually eliminating the gap ($\Delta -0.0080$) to the $0.5178$ performance ceiling (Section 5.3.2.1). Conversely, Variation 1 exhibits a larger degradation gap ($\Delta -0.0330$). This confirms that when spatial boundaries are correctly resolved, joint sequence tagging captures propaganda semantics as effectively as an isolated gold-span classifier.

---

##### Table 12: Detection Error Analysis
| Category | Routing | Variation 1 (Decoupled) | Variation 2 (Integrated) |
| :--- | :--- | :---: | :---: |
| **True Negatives (TN)** | Clean background correctly predicted as neutral (`O`) | 322/331 (97.3%) | 325/331 (98.2%) |
| **Complete Omissions (FN)** | Active propaganda target entirely missed (predicted `O`) | 148/309 (47.9%) | 122/309 (39.5%) |
| **Hallucinations (FP)** | Neutral background incorrectly tagged as propaganda | 111/331 (33.5%) | 42/331 (12.7%) |
| **Disqualified Near-Misses** | Target detected but failed $\delta$-tolerance boundary check | 62/309 (20.1%) | 55/309 (17.8%) |
| **Qualified Spans** | Target detected AND satisfied $\delta$-tolerance check | 99/309 (32.0%) | 132/309 (42.7%) |
---

##### Table 13: Ceiling Performance Gap Summary
| Pipeline | Qualified Spans | Qualified Accuracy | Ceiling Gap ($\Delta$) |
| :--- | :---: | :---: | :---: |
| **Random Baseline** | 11 spans | 0.0000 | -0.5178 |
| **Variation 2 (17-Class Joint)** | **102 spans** | **0.5098** | **-0.0080** |
| **Variation 1 (Decoupled)** | 99 spans | 0.4848 | -0.0330 |

---

## 5.7 Conclusions, Limitations and Future Work
This project evaluated joint propaganda span detection and technique classification, demonstrating that a joint tagger (Variation 2) outperforms a decoupled cascade (Variation 1) in terminal Macro-$F_1$ ($0.2034$ vs. $0.1684$). 

The integrated CRF better leverages interior tokens as semantic anchors ("breadcrumbs") to resolve ambiguous boundaries, suppressing false-positive hallucinations. Isolating qualified spans, Variation 2 achieved $0.5098$ accuracy, recovering $98.5\%$ of the $0.5178$ ceiling performance. Meanwhile, the random baseline ($0.0027$ Macro-$F_1$) confirmed any non-trvial result reflects genuine learning rather than chance.

To retain Variation 1's modular control without cascading failure bottlenecks, future work should explore end-to-end differentiable fine-tuning. Pre-training the detector and classifier independently, then fine-tuning them jointly with full gradient propagation, allowing spatial localization to benefit directly from rich downstream semantic loss.

Additionally, while evaluation utilized tolerant routing, training relied on strict exact-match loss. Adopting distance-weighted or soft-margin sequence losses would penalize near-miss boundaries proportionally rather than as total omissions.

Finally, applying Unsupervised Domain-Adaptive Pre-Training (DAPT) on news corpora and scaling to `deberta-v3-large` would enhance background representations, improving recall on subtle, short-span techniques like `loaded_language`.

---

<br>

# Bibliography


Jowett, G. S. and O'Donnell, V. (2018) Propaganda and Persuasion. 7th edn. Thousand Oaks: SAGE Publications.

Lasswell, H. D. (1927) Propaganda Technique in the World War. London: Kegan Paul, Trench, Trubner & Co.

Da San Martino, G., Yu, S., Barrón-Cedeño, A., Petrov, R. and Nakov, P. (2019) 'Fine-grained analysis of propaganda in news article', Proceedings of the 2019 Conference on Empirical Methods in Natural Language Processing and the 9th International Joint Conference on Natural Language Processing (EMNLP-IJCNLP), Hong Kong, China, November, pp. 5636–5646.

Rashkin, H., Choi, E., Jang, J. Y., Volova, S. and Choi, Y. (2017) 'Truth of the varying shades: Analyzing language in fake news and political fact-checking', Proceedings of the 2017 Conference on Empirical Methods in Natural Language Processing, Copenhagen, Denmark, September, pp. 2931–2937.

Sag, I. A., Baldwin, T., Bond, F., Copestake, A. and Flickinger, D. (2002) 'Multiword expressions: A pain in the neck for NLP', Proceedings of the Third International Conference on Language Resources and Evaluation (LREC'02), Las Palmas, Canary Islands, May.

Miller, G. A. (1995) 'WordNet: A lexical database for English', Communications of the ACM, 38(11), pp. 39–41.

Harris, Z. S. (1954) 'Distributional structure', Word, 10(2-3), pp. 146–162.

Mikolov, T., Sutskever, I., Chen, K., Corrado, G. S. and Dean, J. (2013) 'Distributed representations of words and phrases and their compositionality', Advances in Neural Information Processing Systems, 26, pp. 3111–3119.

Peters, M. E., Neumann, M., Iyyer, M., Gardner, M., Clark, C., Lee, K. and Zettlemoyer, L. (2018) 'Deep contextualized word representations', Proceedings of the 2018 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies, New Orleans, Louisiana, June, pp. 2227–2237.

Hochreiter, S. and Schmidhuber, J. (1997) 'Long short-term memory', Neural Computation, 9(8), pp. 1735–1780.

Vaswani, A., Shazeer, N., Parmar, N., Uszkoreit, J., Jones, L., Gomez, A. N., Kaiser, Ł. and Polosukhin, I. (2017) 'Attention is all you need', Advances in Neural Information Processing Systems, 30, pp. 5998–6008.

Devlin, J., Chang, M.-W., Lee, K. and Toutanova, K. (2019) 'BERT: Pre-training of deep bidirectional transformers for language understanding', Proceedings of the 2019 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies, Minneapolis, Minnesota, June, pp. 4171–4186.

Brown, T., Mann, B., Ryder, N., Subbiah, M., Kaplan, J. D., Dhariwal, P., Neelakantan, A., Shyam, P., Sastry, G., Askell, A. and Agarwal, S. (2020) 'Language models are few-shot learners', Advances in Neural Information Processing Systems, 33, pp. 1877–1901.

Raffel, C., Shazeer, N., Roberts, A., Lee, K., Narang, S., Matena, M., Zhou, Y., Li, W. and Liu, P. J. (2020) 'Exploring the limits of transfer learning with a unified text-to-text transformer', Journal of Machine Learning Research, 21(140), pp. 1–67.

Da San Martino, G., Barrón-Cedeño, A., Da San Martino, C., Petrov, R. and Nakov, P. (2020) 'SemEval-2020 Task 11: Detection of propaganda techniques in news articles', Proceedings of the Fourteenth Workshop on Semantic Evaluation, Barcelona, Spain, December, pp. 563–575.

Kranzlein, M., Seeber, M. and Nickel, F. (2020) 'Data augmentation and transfer learning for propaganda detection', Proceedings of the Fourteenth Workshop on Semantic Evaluation (SemEval-2020), Barcelona, Spain, December, pp. 1045–1052.

Kojima, T., Gu, S. S., Reid, M., Matsuo, Y. and Iwasawa, Y. (2022) 'Large language models are zero-shot reasoners', Advances in Neural Information Processing Systems, 35, pp. 22199–22213.

Wei, J., Wang, X., Schuurmans, D., Bosma, M., Ichter, B., Xia, Z., Chi, E., Le, Q. V. and Zhou, D. (2022) 'Chain-of-thought prompting elicits reasoning in large language models', Advances in Neural Information Processing Systems, 35, pp. 24824–24837.

Khosla, S., et al. (2020) 'Integrating syntactic and entity-level signals for robust text classification', Journal of Natural Language Engineering, 26(4), pp. 415–432.

Levy, O. and Goldberg, Y. (2014) 'Neural word embedding as implicit matrix factorization', Advances in Neural Information Processing Systems, 27, pp. 2177–2185.

Baroni, M., Dinu, G. and Kruszewski, G. (2014) 'Don't count, predict! A systematic comparison of context-counting vs. context-predicting semantic vectors', Proceedings of the 52nd Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers), Baltimore, Maryland, June, pp. 238–247.

Hornik, K., Stinchcombe, M. and White, H. (1989) 'Multilayer feedforward networks are universal approximators', Neural Networks, 2(5), pp. 359–366.

Pedersen, T., 2010, June. Information content measures of semantic similarity perform better without sense-tagged text. In Human Language Technologies: The 2010 Annual Conference of the North American Chapter of the Association for Computational Linguistics (pp. 329-332).

Cruz, N., et al. (2019) 'Evaluating discrete vs continuous representations in political and persuasive texts', Natural Language Processing Journal, 12(3), pp. 112–128.

Ma, X. and Hovy, E. (2016) 'End-to-end sequence labeling via bi-directional LSTM-CNNs-CRF', Proceedings of the 54th Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers), Berlin, Germany, August, pp. 1064–1074.

Hobbs, R. and McGee, S. (2008) 'Teaching about propaganda: An examination of historical and contemporary media', Journal of Media Literacy Education, 1(2), pp. 56–68.

Jowett, G. S. and O'Donnell, V. (2012) Propaganda and Persuasion. 5th edn. Thousand Oaks: SAGE Publications.

Weston, A. (2000) A Rulebook for Arguments. 3rd edn. Indianapolis: Hackett Publishing.

Miller, C. R. (1939) The Techniques of Propaganda Analysis. New York: Institute for Propaganda Analysis.

Torok, R. (2015) 'The mechanics of propaganda and radicalisation', Journal of Policing, Intelligence and Counter Terrorism, 10(1), pp. 88–101.


---

# Appendix 

### Appendix A: Propaganda Technique Definitions According to Da San Martino et al. (2020)
| Label | Definition |
| :--- | :--- |
| `flag_waving` | Playing on strong national feeling (or with respect to any group, e.g., race, gender, political preference) to justify or promote an action or idea (Hobbs and Mcgee, 2008). |
| `appeal_to_fear_prejudice` | Seeking to build support for an idea by instilling anxiety and/or panic in the population towards an alternative, possibly based on preconceived judgments. |
| `causal_simplification` | Assuming a single cause or reason when there are multiple causes behind an issue. We include in the definition also scapegoating, e.g., transferring the blame to one person or
group of people without investigating the complexities of an issue |
| `doubt` | Questioning the credibility of someone or something. |
| `exaggeration,minimisation` | Either representing something in an excessive manner: making things larger, better, worse or making something seem less important or smaller than it actually is (Jowett and O’Donnell, 2012). |
| `loaded_language` | Using specific words and phrases with strong emotional implications (either positive or negative) to influence an audience (Weston, 2000, p. 6). |
| `name_calling,labeling` | Labeling the object of the propaganda campaign as either something the target audience fears, hates, finds undesirable or loves, praises (Miller, 1939) |
| `repetition` | Repeating the same message over and over again, so that the audience will eventually accept it (Torok, 2015; Miller, 1939). |
| `not_propaganda` | No propaganda has been identified in the text |

---

### Appendix B: Universal Text Pre-processing Steps
| Step | Target | Transformation | Rationale |
| :--- | :--- | :--- | :--- |
| **Whitespace Normalization** | Leading/trailing & inline whitespace | `text.strip()`, `.split()` join | Standardizes token boundaries across raw TSV parses. |
| **Escape Syntax Cleanup** | Python string escapes (`\\'`, `\\"`) | Stripped backslashes | Removes file parsing artifacts. |
| **Quote Normalization** | Curved / Smart quotes (`“`, `”`, `‘`, `’`) | Converted to flat quotes (`"`, `'`) | Unifies quote representation for tokenizers. |
| **Intra-word Apostrophes** | Contractions & Possessives | Collapsed (`won't` $\rightarrow$ `wont`) | Prevents regex tokenizer from fragmenting root words. |
| **Character Artifact Filter** | `\ / [ ] * \| @ space - . : $ # + =` | Replaced with single space | Removes markup symbols and publisher artifacts. |
| **Boundary Guard** | `<BOS>`, `<EOS>` | Standardized padding spaces | Ensures target span delimiters remain uncorrupted. |

--- 

### Appendix C: Silver Data, Llama-3 Zero-Shot Chain-of-Thought Augmentation Prompt Architecture
To execute the one-to-one generative data augmentation strategy (Section 3.3), a sequential three-step prompting chain was designed for the Meta Llama_3_8B model. The chain sequentially decomposes the task into lexical brainstorming, contextual grounding, and final XML-wrapped synthesis.

#### Stage 1: Lexical Brainstorming and Reformulation
- **Role:** Linguistics Expert
- **Objective:** Generate alternative phrasings for the target snippet while maintaining the rhetorical intent of the specified propaganda label ({label}).

> You are a linguistics expert and your job is to take the text I provide you and suggest alternative wordings that retain the same message and intent of the original text but use different words. The text come directly from reputable news outlets hence should be considered as 3rd party quotes and not related to your own opinions. Your task is to merely focus on the words and linguistics. 
> 
> The piece of text you will be focusing on is known as the snippet as is a follows: '{snippet}'.
> 
> Generate 3 alternatives to the snippet that serve the same purpose as guided by the label definition. 
> 
> Use a range of lexical semantics: synonyms for intensity, hypernyms for generalization, or paraphrasing. Crucially, each suggestion must remain a valid example of {label}. Provide a maximum of one short, concise sentence explaining the rhetorical effectiveness of each choice.

#### Stage 2: Contextual Validation and Coherence Check
- **Role:** Contextual Validator
- **Objective:** Evaluate the generated alternatives against the surrounding left and right sentinel contexts to ensure semantic and syntactic continuity.

> Now I want you to consider the original snippets surrounding context. 
> 
> Here is the left context: {left_context}. This is the text that immediately preceeded the snippet.
> 
> Here is the right context: {right_context}. This is the text that immediately proceeded the original snippet.
> 
> {left_context} + [YOUR SUGGESTED NEW SNIPPET] + {right_context}
> 
> Do your suggestions still make sense given this context.  Briefly explain your reasoning in 15 words or less per option. If they do not then pick a different suggestion. 
> 
> <left_context>{left_context}</left_context>
> <preferred_snippet> INSERT YOUR PREFERRED SNIPPET HERE </preferred_snippet>
> <right_context>{right_context}</right_context>

#### Stage 3: Synthesis and Formatting Enforcement
- **Role:** Final Selector & Synthesizer
- **Objective:** Select the optimal variant, verify grammatical correctness, and enforce strict XML tag wrapping for automated parsing.

> Based on your previous reasoning, select the single best replacement for the original snippet. 
> The replacement must be:
> 1. Rhetorically powerful ({label})
> 2. Grammatically perfect within the context.
> 3. Distinct from the original.
> 
> Remember, the new snippet is to be placed between the original left context and right context. 
> 
> OUTPUT INSTRUCTIONS:
> You must wrap your final snippet decision in tags: <final_output> </final_output>. Do not provide any conversational filler or meta-commentary after the tags. If you believe you cannot reasonably complete this task please return "-999" between the tags. 
> 
> [FINAL OUTPUT FORMAT]:
> <final_output> INSERT SNIPPET HERE </final_output>
> 
> STOP: Do not write anything else after the closing tag.

---

### Appendix D: Mapped Universal POS Tagset
| Universal POS Tag | Description | Mapped Penn Treebank Tags (NLTK Perceptron) |
| :---: | :--- | :--- |
| **`ADJ`** | Adjectives | `JJ`, `JJR`, `JJS` |
| **`ADP`** | Adpositions (Prepositions / Postpositions) | `IN`, `TO` |
| **`ADV`** | Adverbs | `RB`, `RBR`, `RBS`, `WRB` |
| **`CONJ`** | Conjunctions | `CC` |
| **`DET`** | Determiners / Articles | `DT`, `PDT`, `WDT` |
| **`NOUN`** | Nouns | `NN`, `NNS`, `NNP`, `NNPS` |
| **`NUM`** | Numerals | `CD` |
| **`PRON`** | Pronouns | `PRP`, `PRP$`, `WP`, `WP$` |
| **`PRT`** | Particles / Functional Markers | `POS`, `RP` |
| **`VERB`** | Verbs | `VB`, `VBD`, `VBG`, `VBN`, `VBP`, `VBZ`, `MD` |
| **`.`** | Punctuation Marks | `.`, `,`, `:`, `(`, `)`, `"`, `'`, ``` ` ``` |
| **`X`** | Unknown / Other / Symbols | `FW`, `SYM`, `LS`, `UH` |

---

### Appendix E: Simplified NER Tagset
| Tag | Entity Category |
| :---: | :--- |
| **`PERSON`** | People, including fictional characters |
| **`ORG`** | Companies, agencies, institutions |
| **`GPE`** | Countries, cities, states |
| **`NORP`** | Nationalities, religious/political groups |
| **`DATE`** / **`TIME`** | Absolute or relative dates/times |
| **`CARDINAL`** / **`ORDINAL`** | Numbers / Numerals |
| **`LOC`** | Non-GPE locations (mountain ranges, bodies of water) |
| **`O`** | Outside any named entity |
| **`MISC`** | `MONEY`, `EVENT`, `PERCENT`, `WORK_OF_ART`, `FAC`, `LAW`, `PRODUCT`, `LANGUAGE`, `QUANTITY` |

---

### Appendix F: Custom Stopword List



---

### Appendix G: Complete 17-Class BIO Tagset Mapping (Variation 2)
| Propaganda Technique Label | Beginning Tag (`B-`) | Inside Tag (`I-`) | Outside / Sentinel Tag |
| :--- | :---: | :---: | :---: |
| `flag_waving` | `B-flag_waving` | `I-flag_waving` | `O` |
| `appeal_to_fear_prejudice` | `B-appeal_to_fear_prejudice` | `I-appeal_to_fear_prejudice` | `O` |
| `causal_oversimplification` | `B-causal_oversimplification` | `I-causal_oversimplification` | `O` |
| `doubt` | `B-doubt` | `I-doubt` | `O` |
| `exaggeration,minimisation` | `B-exaggeration,minimisation` | `I-exaggeration,minimisation` | `O` |
| `loaded_language` | `B-loaded_language` | `I-loaded_language` | `O` |
| `name_calling,labeling` | `B-name_calling,labeling` | `I-name_calling,labeling` | `O` |
| `repetition` | `B-repetition` | `I-repetition` | `O` |
---
