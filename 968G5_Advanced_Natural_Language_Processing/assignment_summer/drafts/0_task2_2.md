# Task 2: Joint Propaganda Span Detection and Classification
- [1. Architectural Approach](#1-architectural-approach)
    - [1.1 CNN-BiLSTM-CRF Framework](#11-cnn-bilstm-crf-framework)
    - [1.2 Modernization Updates](#12-modernization-updates)
- [2. Architecture Variation 2: The Integrated Multi-Class BIO-CRF Model](#2-architecture-variation-2-the-integrated-multi-class-bio-crf-model)
    - [2.1 Model Architecture & Forward Pass](#21-model-architecture--forward-pass)
    - [2.2 Hyperparameter Search & Optimization Strategy](#22-hyperparameter-search--optimization-strategy)
- [3. Architecture Variation 1: Decoupled, Two-Stage Tagger](#3-architecture-variation-1-decoupled-two-stage-tagger)
    - [3.1 Model Architecture & Forward Pass](#31-model-architecture--forward-pass)
    - [3.2 Hyperparameter Search & Optimization Strategy](#32-hyperparameter-search--optimization-strategy)
        - [3.2.1 Stage 2 Head Training & The Oracle Ceiling](#321-stage-2-head-training--the-oracle-ceiling)
        - [3.2.2 Stage 1 Hyperparameter Grid Search](#322-stage-1-hyperparameter-grid-search)
        - [3.2.3 Final Decoupled Pipeline](#323-final-decoupled-pipeline)
- [4. Stochastic Random-Guessing Baseline](#4-stochastic-random-guessing-baseline)
- [5. Evaluation Framework ](#5-evaluation-framework)
    - [5.1 Cascading Boundary Qualification Router](#51-cascading-boundary-qualification-router)
    - [5.2 Primary Optimization Metric: Macro-Weighted F1](#52-primary-optimization-metric-macro-weighted-f1)
    - [5.3 Three-Phase Diagnostic Audit Architecture](#53-three-phase-diagnostic-audit-architecture)
- [6. Results](#6-results)
    - [6.1 Baseline Performance](#61-baseline-performance)
    - [6.2 Comparative Primary Model Benchmark](#62-comparative-primary-model-benchmark)
    - [6.3 Sub-Component Benchmarks & Theoretical Ceilings](#63-sub-component-benchmarks--theoretical-ceilings)
- [7. Conclusions, Limitations and Future Work](#7-conclusions-limitations-and-future-work)
    - [7.1 Key Conclusions](#71-key-conclusions)
    - [7.2 System Limitations](#72-system-limitations)
    - [7.3 Future Work](#73-future-work)

---

# Task 2: Joint Propaganda Span Detection and Classification
Task 2 expands the experimental scope from classifying isolated, pre-delimited snippets to jointly identifying manipulative text boundaries and classifying the specific techniques deployed within raw, full-sentence sequences. This objective is framed as a token-level sequence labeling task utilizing the Beginning, Inside, Outside (BIO) encoding schema.

Formally, given an input sequence of $N$ subword tokens $\mathbf{x} = (x_1, x_2, \dots, x_N)$, the model learns a mapping function $f: \mathbf{x} \to \mathbf{y}$ to predict an aligned sequence of target tags $\mathbf{y} = (y_1, y_2, \dots, y_N)$, where each $y_i \in \mathcal{Y}$. Under the BIO formulation, the label space $\mathcal{Y}$ assigns tokens as follows:

- $y_i = \text{O}$ for neutral background tokens and non-propagandistic context.
- $y_i = \text{B}$ for the initial subword/token triggering a propaganda span.
- $y_i = \text{I}$ for subsequent interior tokens extending an active span.

Table X demonstrate how a raw sequence translates into aligned BIO vectors for model training, consider the input sentence: "The mainstream media is spreading \<BOS> **blatant lies** \<EOS> about the policy."

### Table X: BIO Tagged Sequence
| Sequence Index ($i$) | Raw / Subword Token ($x_i$) | Character Range | Alignment Status | BIO Tag Target ($y_i$) |
| :--- | :--- | :--- | :--- | :--- |
| $x_1$ | `[CLS]` | Special | Boundary Marker | `O` |
| $x_2$ | `The` | [0:3] | Background Text | `O` |
| $x_3$ | `mainstream` | [4:14] | Background Text | `O` |
| $x_4$ | `media` | [15:20] | Background Text | `O` |
| $x_5$ | `is` | [21:23] | Background Text | `O` |
| $x_6$ | `spreading` | [24:30] | Background Text | `O` |
| $x_7$ | **`blatant`** | [31:38] | **Span Onset** | **`B`** |
| $x_8$ | **`lies`** | [39:42] | **Span Continuation** | **`I`** |
| $x_9$ | `about` | [43:47] | Background Text | `O` |
| $x_{10}$ | `the` | [48:51] | Background Text | `O` |
| $x_{11}$ | `policy` | [52:54] | Background Text | `O` |
| $x_{12}$ | `.` | [54:55] | Background Text | `O` |
| $x_{13}$ | `[SEP]` | Special | Boundary Marker | `O` |
---

## Flow and Structure of Task 2
Mock structure:
> "Section 4.1 formalizes the joint span detection and technique classification task under the BIO encoding schema and establishes the modernized DeBERTa-CRF architectural framework, contrasting it with traditional CNN-BiLSTM-CRF sequence taggers. Section 4.2 details the structural implementations of our two primary model variants: the two-stage decoupled cascading pipeline (Variation 1) and the 17-class integrated joint tagger (Variation 2). Section 4.3 outlines the non-linguistic stochastic random-guessing baseline utilized to establish an empirical performance floor. Section 4.4 introduces our evaluation framework, detailing the length-adaptive boundary qualification router ($\delta$), the penalized scoring logic, and the three-phase diagnostic audit architecture. Finally, Sections 4.5 and 4.6 present the comparative empirical results and a deep diagnostic synthesis analyzing structural localization, latent semantic signals, and feature dilution across both pipeline variants."

---

## 1. Architectural Approach
The methodology for Task 2 constructs two modelling variations based off an adaptation of the CNN-BiLSTM-CRF framework introduced by Ma and Hovy (2016). 

### 1.1 CNN-BiLSTM-CRF Framework
To understand the lineage of this approach, it is vital to examine why Ma and Hovy's baseline was so influential. The authors achieved robust sequence tagging by leveraging a three-tiered hierarchical processing pipeline:
- A Convolutional Neural Network (CNN) operates at the character0level as a localized feature extractor to capture sub-word morphological patterns.
- A Bidirectional Long Short-Term Memory (Bi-LSTM) processes the word sequence in both directions to map long-range contextual dependencies and sentinal context.
- A Conditional Random Field (CRF) decoder evaluates the joint probability of the entire tag sequence, using a learned transition matrix to enforce global structural logic.

> Convert to a clear paragraph

When applied to propaganda detection, this general-purpose framework offers key theoretical advantages. First, the character-level CNN allows the model to detect morphological irregularities common in manipulative language—such as superlative affixes (`-est`, `-st`) used in terms like *greatest* or *worst* to amplify rhetorical framing. Second, the Bi-LSTM's sequence representations capture non-local dependencies, allowing the network to recognize how earlier lexical choices subtly alter the manipulative tone of subsequent words across distant sequence spans. Third, when modeling propaganda fragments under a BIO schema, the CRF transition matrix enforces valid tag sequences (such as `B-` $\to$ `I-` or `I-` $\to$ `O`) while strictly prohibiting illegal transitions, such as initiating an overlapping `B-` tag mid-span. Finally, precise propaganda span delimitation remains highly disputed even among expert annotators (Da San Martino et al., 2019), making boundary identification exceptionally difficult. Under BIO sequence labeling, each token produces an emission distribution across candidate tags. The CRF leverages these parameters to let high-confidence interior tokens pull adjacent, lower-signal boundary predictions into a spatially coherent span—a dynamic formalized in this project as the "breadcrumb effect."

### 1.2 Modernization Updates
This project builds on this established framework through a modernization update by substituting the sequential and convolutional layers with a deep Transformer encoder (DeBERTa) while keeping the global decoding properties of the terminal CRF layer.  

This modernized update introduces four core architectural advantages over the classical baseline. First, SentencePiece tokenization eliminates the character-level CNN by decomposing out-of-vocabulary terms into subwords, resolving data sparsity without dedicated feature-extraction sub-networks. Second, global self-attention replaces sequential LSTM recurrence, providing direct all-to-all sequence connectivity that mitigates the context decay experienced by recurrency and ensures capture of long-range dependencies underlying manipulative rhetoric. Third, replacing a recurrent model trained from scratch with a pre-trained Transformer limits the risk catastrophic overfitting on the limited training data we have byleveraging the models broad linguistic representations. Finally, DeBERTa’s disentangled attention mechanisms evaluate token content and relative spatial position on separate vectors, granting the model the decoupled spatial awareness needed to isolate manipulative phrases where neutral vocabulary is weaponized through syntactic placement.

To evaluate this modernized pipeline, we experiment with two architectural variations: a Decoupled Two-Stage Tagger (Variation 1) and an Integrated Multi-Class BIO-CRF Pipeline (Variation 2).

## 2. Architecture Variation 2: The Integrated Multi-Class BIO-CRF Model
This approach addresses the propaganda identification task through a single-stage, end-to-end joint sequence labeling framework. That is to say, the sequence labelling learns both boundary detection and technique classification simultaneously. 

This achieved through an expanded, granular BIO schema, incorporating all eight rhetorical techniques directly into the spatial tagset. Here, both the `B-` and `I-` tagset are joined with a suffix containing a propaganda technique, i.e. `B-Loaded`. Resulting in 8 B-Tags, 8-Tags and single O-Tag. 

$$\mathcal{Y}_{17} = \{\text{O}\} \cup \{\text{B-}k \mid k \in \mathcal{T}\} \cup \{\text{I-}k \mid k \in \mathcal{T}\}$$

This granular formulation is particularly well-suited for propaganda detection because, while rhetorical techniques share underlying manipulative intent, their linguistic signatures remain distinct. By expanding the label space to 17 states, the CRF optimizes spatial boundaries and technique classifications in tandem rather than collapsing semantic distinctions into a binary indicator. Crucially, this wide probability distribution enhances the "breadcrumb effect" during sequence decoding. In a collapsed 3-class BIO schema, ambiguous boundary predictions often collapse into an uninformative ~50/50 split between neutral text and propaganda. In a 17-class schema, however, an uncertain prediction is dispersed across multiple technique states. When a small probability mass (e.g., $0.15$) aligns with a high-confidence technique prediction further along the sequence (e.g., a strong interior `I-loaded_language` token), the CRF's transition matrix uses that semantic linkage to pull the ambiguous boundary token into a spatially coherent span, substantially improving boundary detection.

##### Table X: Complete 17-Class BIO Tagset Mapping (Variation 2)
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

### 2.1 Model Architecture & Forward Pass
Adapting the modernized Ma and Hovy (2016) framework, this pipeline couples a pre-trained Transformer encoder with a Linear-Chain Conditional Random Field (CRF) layer. An input sequence $\mathbf{x} = (x_1, \dots, x_N)$ tokenized via SentencePiece is encoded by `deberta-v3-xsmall` into contextual representations $\mathbf{H} \in \mathbb{R}^{N \times 384}$:

$$\mathbf{H} = \text{DeBERTa}(\mathbf{x})$$

A linear projection maps $\mathbf{H}$ to unnormalized emission logits $\mathbf{E} \in \mathbb{R}^{N \times 17}$ across the 17 BIO states, where $\mathbf{W}_e \in \mathbb{R}^{17 \times 384}$ and $\mathbf{b}_e \in \mathbb{R}^{17}$:

$$\mathbf{E}_i = \mathbf{W}_e \mathbf{H}_i + \mathbf{b}_e \quad (i \in \{1, \dots, N\})$$

To prevent label bias and eliminate local softmax independence, $\mathbf{E}$ passes to a Linear-Chain CRF featuring a trainable transition matrix $\mathbf{A} \in \mathbb{R}^{17 \times 17}$. To enforce valid syntax, invalid paths—such as span onset on interior tags ($\text{O} \to \text{I-}k$) or mid-phrase technique switches ($\text{B-}k_1 \to \text{I-}k_2$)—are masked with hard penalties ($-10000.0$).

The score $S(\mathbf{x}, \mathbf{y})$ for tag sequence $\mathbf{y}$ combines emission and transition scores:

$$S(\mathbf{x}, \mathbf{y}) = \sum_{i=1}^{N} \mathbf{E}_{i, y_i} + \sum_{i=1}^{N-1} \mathbf{A}_{y_i, y_{i+1}}$$

Training minimizes the negative log-likelihood (NLL) of the gold path $\mathbf{y}^*$ over path space $\mathcal{Y}^N$:

$$\mathcal{L}_{\text{CRF}}(\theta) = -\log \left( \frac{\exp(S(\mathbf{x}, \mathbf{y}^*))}{\sum_{\mathbf{y}' \in \mathcal{Y}^{N}} \exp(S(\mathbf{x}, \mathbf{y}'))} \right)$$

Inference uses Viterbi decoding to extract the globally optimal sequence $\hat{\mathbf{y}}$:

$$\hat{\mathbf{y}} = \arg\max_{\mathbf{y}' \in \mathcal{Y}^{N}} S(\mathbf{x}, \mathbf{y}')$$

### 2.2 Hyperparameter Search & Optimization Strategy
To prevent gradient instability and catastrophic forgetting during optimization, Architecture Variation 2 employs a differential learning rate schedule whilst deploying the AdamW optimizer.

Co-training a massive pre-trained Transformer alongside randomly initialized linear projection and CRF layers creates a severe optimization imbalance. Standard learning rates for the CRF convergence ($10^{-3}$ to $10^{-4}$) risk destroying DeBERTa's pre-trained representations, whereas typical transformer rates ($10^{-5}$) would stall the convergence of the initialized heads. 

To identify optimal optimization bounds, a hyperparameter search was executed over 5 epochs using a 10% modulo internal validation split across three training setups. The conservative configuration (Run 1) yielded the lowest negative log-likelihood (NLL = $3.7016$), preventing early divergence in the CRF layer while steadily lowering training loss.

##### Table X
| Parameter Configuration | Backbone LR ($\eta_{\text{base}}$) | Heads LR ($\eta_{\text{head}}$) | Batch Size ($B$) | Dev Loss (CRF NLL) |
| :--- | :---: | :---: | :---: | :---: |
| **Run 1 (Conservative)** | **1e-5** | **5e-4** | **16** | **3.7016** *(Selected)* |
| **Run 2 (Moderate)** | 2e-5 | 1e-3 | 16 | 4.0252 |
| **Run 3 (Aggressive)** | 5e-5 | 2e-3 | 32 | 4.2202 |

This optimization setup is specifically tailored to the domain of propaganda detection. Staggered learning rates preserve DeBERTa’s pre-trained contextual representations for subtle rhetorical cues while enabling the CRF to rapidly learn the structural transition matrix. Micro-batching ($B = 16$) provides frequent parameter updates that prevent the loss from oversaturating on dominant background text class `0`. Finally, combining AdamW weight decay ($0.01$) with gradient clipping ($\le 1.0$) stabilizes CRF optimization against heavy transition penalties while preventing the encoder from overfitting to high-frequency journalistic terminology that underpins this corpus.

The final production model was trained for 10 epochs under the conservative Run 1 configuration, utilizing negative log-likelihood (CRF NLL) loss and gradient accumulation to ensure stable joint convergence across all 17 BIO sequence states.

---

## 3. Architecture Variation 1: Decoupled, Two-Stage Tagger
In contrast to the single-stage joint decoding pass of Variation 2, Architecture Variation 1 adopts a modular, two-stage pipeline for propaganda detection and classification. Rather than forcing a single network to perform spatial boundary localization and multi-class technique identification simultaneously, Variation 1 decouples the task into two specialized sub-networks:

1. **Stage 1 (Span Localization Tagger):** A 3-class sequence tagger trained exclusively to identify the presence and boundaries of propagandistic text within full-sentence context. The target space collapses into three discrete BIO states. Non-propaganda background text is assigned the `O` tag, the onset token of any propaganda phrase is tagged `B-Propaganda`, and interior tokens extending the span are tagged `I-Propaganda`.
2. **Stage 2 (Technique Classifier Head):** An independent Multi-Layer Perceptron (MLP) classifier head that mean-pools subword embeddings extracted from Stage 1's predicted candidate spans and categorizes them into one of eight rhetorical techniques.

This decoupled architecture offers distinct theoretical advantages grounded in data density and task specialization. By collapsing all eight fine-grained propaganda techniques into a generic binary target space ($\mathcal{Y}_3$), Stage 1 maximizes positive label density across the sequence labeling dataset, enabling the tagger to build a robust generalized representation of manipulative text versus neutral background context without being fragmented by rare technique sub-classes. Furthermore, isolating the downstream classification head allows Stage 2 to act as a dedicated domain expert, optimizing rhetorical feature boundaries independently of spatial sequence constraints. Nevertheless, this two-stage division creates an inherent single-point failure bottleneck, where early Stage 1 localization omissions or boundary offsets permanently constrain the downstream performance of Stage 2.

$$\mathcal{Y}_3 = \{\text{O}, \text{B-Propaganda}, \text{I-Propaganda}\}$$

### 3.1 Model Architecture & Forward Pass
Stage 1 employs a DeBERTa-CRF sequence tagging architecture that follows the exact structural topology, contextual subword encoding, linear projection, and global CRF decoding operations formalized in Equations (1)–(5) of Section 4.2.4 for Variation 2.

The primary architectural distinction lies in the target emission dimension: Stage 1 restricts the projection matrix to a 3-class emission matrix $\mathbf{E} \in \mathbb{R}^{N \times 3}$ and evaluates transitions via a reduced 3-class transition matrix $\mathbf{A} \in \mathbb{R}^{3 \times 3}$.

When Stage 1 identifies an active span, Stage 2 executes a contextualized span-pooling operation. Stage 2 re-encodes the entire input sentence through DeBERTa to produce contextualized token representations $\mathbf{H} \in \mathbb{R}^{N \times 384}$. Following this, the sequence of representations is sliced to the exact indices of the predicted span $[p_{\text{start}}, p_{\text{end}}]$. This is done to intensify the core propaganda signal and strip away uninformative neutral text that has already been contextualized by DeBERTa’s self-attention layers.

The remaining contextualized vectors are then isolated and mean-pooled into a single 384-dimensional span representation $\mathbf{h}_{\text{pooled}}$:

$$\mathbf{h}_{\text{pooled}} = \frac{1}{p_{\text{end}} - p_{\text{start}} + 1} \sum_{i=p_{\text{start}}}^{p_{\text{end}}} \mathbf{H}_i$$

Mean-pooling serves as a length-invariant representational interface, condensing candidate phrases of arbitrary length into a fixed-size 384-dimensional vector optimized for downstream dense classification.

This pooled embedding is fed through a specialized two-layer Multi-Layer Perceptron (MLP) classification head:

$$\mathbf{z} = \text{Linear}_{64 \to 8}\Big(\text{Dropout}\Big(\text{LayerNorm}\Big(\text{ReLU}\Big(\text{Linear}_{384 \to 64}(\mathbf{h}_{\text{pooled}})\Big)\Big)\Big)\Big)$$

The MLP head architecture is engineered to balance feature compression with regularization. The initial linear projection ($384 \to 64$) maps dense 384-dimensional embeddings down to a compact 64-dimensional feature subspace, forcing out uninformative background noise. The ReLU introduces non-linear decision boundaries required to highlight subtle rhetorical techniques, while Layer Normalization stabilizes gradient variance across small-batch training ($B=16$). Dropout ($p=0.3$) regularizes the dense layer, preventing the classifier from memorizing frequent journalistic vocabulary and ensuring the head generalizes across unseen news topics. Finally, the terminal layer maps the normalized features to 8-way technique logits $\mathbf{z} \in \mathbb{R}^8$.

If Stage 1 predicts no active span ($p_{\text{start}} = -1$), the pipeline short-circuits and defaults to `not_propaganda` without invoking Stage 2, preserving computational efficiency on clean context.

### 3.2 Hyperparameter Search & Optimization Strategy
To properly optimize Variation 1 and establish a theoretical upper bound for Stage 2, training and hyperparameter tuning were divided into two isolated protocols:

#### 3.2.1 Stage 2 Head Training & The Oracle Ceiling
To ensure the Stage 2 classifier learned clean technique representations without being degraded by early Stage 1 prediction errors, Stage 2 was trained exclusively on gold-standard propaganda spans extracted from the training corpus. DeBERTa parameters were completely frozen, updating only the parameters of the MLP head ($\theta_{\text{MLP}}$) using multi-class Cross-Entropy loss:

$$\mathcal{L}_{\text{CE}}(\theta_{\text{MLP}}) = -\sum_{k=1}^{8} y_{k} \log \hat{y}_{k}$$

where $y_k \in \{0, 1\}$ represents the one-hot gold technique indicator and $\hat{y}_k = \text{softmax}(\mathbf{z})_k$ is the predicted probability for technique $k$. The classification head was optimized via AdamW ($\text{LR} = 1\times 10^{-3}$, $B = 16$) over 10 epochs. Freezing the backbone prevented gradient instability and memorization of political vocabulary during head optimization. When evaluated on validation gold spans, Stage 2 established an Oracle Ceiling of 0.5106 Macro-F1 (and 0.5178 Accuracy), representing the maximum theoretical performance Variation 1 could achieve under perfect ($100\%$) spatial localization.

#### 3.2.2 Stage 1 Hyperparameter Grid Search
Stage 1 parameters ($\theta_{\text{S1}}$) were trained by minimizing the sequence Negative Log-Likelihood ($\mathcal{L}_{\text{CRF}}$) over the collapsed 3-class BIO space ($\mathcal{Y}_3$):

$$\mathcal{L}_{\text{CRF}}(\theta_{\text{S1}}) = -\log P(\mathbf{y}^* \mid \mathbf{x}) = -\log \left( \frac{\exp(S(\mathbf{x}, \mathbf{y}^*))}{\sum_{\mathbf{y}' \in \mathcal{Y}_3^{N}} \exp(S(\mathbf{x}, \mathbf{y}'))} \right)$$

where $\mathbf{y}^* \in \mathcal{Y}_3^N$ represents the gold 3-class target path (O, B-Propaganda, I-Propaganda) and $S(\mathbf{x}, \mathbf{y})$ evaluates combined emission and 3-class transition scores.

To identify optimal optimization bounds for spatial boundary detection, a grid search was conducted across Transformer learning rates ($\eta_{\text{base}} \in \{5\times 10^{-6}, 1\times 10^{-5}, 3\times 10^{-5}\}$) and head learning rates ($\eta_{\text{head}} \in \{3\times 10^{-4}, 5\times 10^{-4}, 1\times 10^{-3}\}$) over 3 training epochs.

While parameters were updated via $\mathcal{L}_{\text{CRF}}$ during backward passes, hyperparameter selection was guided by evaluating decoded Viterbi paths against ground-truth spans using the length-adaptive $\delta$-tolerance boundary router. Trial 9 achieved the highest standalone spatial performance (0.3834 Span-F1), balancing boundary precision ($0.4924$) and recall ($0.3139$).

##### Table X: 
```
Tuning Trial | Backbone LR (ηbase​) | Heads LR (ηhead​)Span Precision | Span Recall | Standalone | Span-F1 | 
| :--- | :--- | :--- | :--- | :--- | :--- |
| Trial 1 | 5e-6 | 3e-4 | 0.4327 | 0.2395 | 0.3083 |
| Trial 4 | 1e-5 | 3e-4 | 0.4140 | 0.2492 | 0.3111 |
| Trial 6 | 1e-5 | 1e-3 | 0.4415 | 0.2686 | 0.3340 |
| Trial 9 **(Selected)** | 3e-5 | 1e-3 | 0.4924 | 0.3139 | 0.3834 |
```
---

#### 3.2.3 Final Decoupled Pipeline
The final production system couples the independently optimized Stage 1 tagger and Stage 2 classifier. Stage 1 was trained for 10 epochs under the winning Trial 9 configuration ($\eta_{\text{base}} = 3\times 10^{-5}$, $\eta_{\text{head}} = 1\times 10^{-3}$, $B = 16$), utilizing gradient accumulation and gradient clipping ($\le 1.0$) to ensure stable convergence across 3-class CRF transition paths. During end-to-end inference, an input sentence is processed sequentially: Stage 1 executes Viterbi decoding to predict candidate token span bounds $[p_{\text{start}}, p_{\text{end}}]$. If an active span is detected ($p_{\text{start}} \neq -1$), Stage 2 re-encodes the sentence, mean-pools subword vectors across $[p_{\text{start}}, p_{\text{end}}]$, and outputs an 8-way technique prediction. If Stage 1 detects no active span ($p_{\text{start}} = -1$), the pipeline short-circuits and assigns a neutral `not_propaganda` label, bypassing Stage 2 entirely.

---

## 4. Stochastic Random-Guessing Baseline
To establish an absolute mathematical lower bound and guarantee that sequence models learn authentic rhetorical patterns rather than picking up on sequence length heuristics, we implement an unintelligent, probabilistic random-guessing baseline.

For a target sequence comprising $N$ tokens $T = (t_1, t_2, \dots, t_N)$, the baseline operates via a three-step stochastic sampling procedure:
1. A Bernoulli trial determines whether the sentence contains propaganda with uniform probability $P(\text{prop}) = P$. Sequences assigned $P(\text{prop}) P$ are output as entirely neutral (`O` across all $N$ tokens, mapping to `not_propaganda`). $P$ is determined by the split of positive instances vs `not_propaganda` of the training set. 
2. If propaganda existence is flagged, start and end token indices $(i, j)$ are drawn uniformly at random yielding a predicted boundary span $\hat{S} = [t_i, \dots, t_j]$.

$$i \sim \text{Uniform}(1, N), \quad j \sim \text{Uniform}(i, N)$$

3. A technique label $k$ is drawn uniformly from the 8 positive propaganda categories, mimicing the random baseline appraoch from Task 1:

$$k \sim \text{Uniform}(1, 8)$$

The output of this process yeilds a 3-part vector containing a propagdana route and stand and end indices where qualifiying. Information means a given tokenized sequence can be tagged with its appropriate BIO representation. 

> Include an example going from vector and sequence to bio

From here, we can evaluate the sequences using our evaluation suite, defining the floor against which downstream neural architectures are benchmarked.

---

## 5. Evaluation Framework 
Evaluating joint propaganda span detection and technique classification requires balancing strict spatial boundary precision with multi-class semantic correctness. In sequence labeling tasks where spans are detected dynamically within full sentences, standard token-level evaluation metrics often obscure whether an error was caused by a spatial boundary offset, a total span miss, or a technique misclassification. To establish a rigorous, interpretable benchmark, our evaluation framework incorporates explicit boundary-qualification routing, penalized error scoring, and a multi-phase diagnostic audit.

### 5.1 Cascading Boundary Qualification Router
Evaluating localized propaganda spans presents a structural challenge: human annotators often disagree on exact character-level boundaries, yet downstream classification heavily depends on capturing the core semantic phrase. Standard exact-match metrics overly penalize minor boundary offsets, while soft overlap metrics can mask severe over-prediction. To address this, our evaluation engine implements a length-adaptive tolerance window ($\delta$). For any gold propaganda span of character length $L$, the maximum allowable boundary deviation $\delta$ is determined dynamically across distinct length tiers, assigning a single-character offset tolerance for short spans ($L \le 5$), two to three character offsets for medium spans ($6 \le L \le 15$), an incrementally increasing tolerance for long spans ($16 \le L \le 50$), and a hard cap of twelve character offsets for extended spans ($L > 50$).


##### Table X: 
| Span Length (Tokens) | Boundary Tolerance| Verification Rule |
| :--- | :--- | :--- |
| **$\le 5$** | 0 tokens | Predicted start and end indices must align perfectly with the gold span (Exact Match) |
| **$6\text{--}10$** | $\pm 1$ token | Start and end indices are allowed a 1-token tolerance in either direction |
| **$11\text{--}15$** | $\pm 2$ tokens | Start and end indices are allowed a 2-token tolerance in either direction |
| **$16\text{--}50$** | Step-wise scaling | Tolerance scales linearly, $+1$ token offset per 5 additional tokens. |
| **$> 50$** | $\pm 10$ tokens | Boundary tolerance caps out at a maximum window of 10 tokens. |
---

Using this adaptive tolerance, every predicted span $(p_{\text{start}}, p_{\text{end}})$ is evaluated against its corresponding ground-truth span $(g_{\text{start}}, g_{\text{end}})$ across four distinct evaluation scenarios. A True Negative (TN) is recorded when the gold sentence contains background text (not_propaganda) and the model correctly predicts no active span. Conversely, a False Positive (FP - Hallucination) occurs when the gold sentence is background text but the model predicts an active propaganda span. A False Negative (FN - Omission) represents an instance where the sentence contains a gold propaganda target but the model predicts background text (O).  

When both gold and predicted spans are active, the system executes a Boundary Qualification Gate to verify whether $\vert{}p_{\text{start}} - g_{\text{start}}\vert{} \le \delta$ and $\vert{}p_{\text{end}} - g_{\text{end}}\vert{} \le \delta$. A span that satisfies these conditions is deemed spatially qualified and becomes eligible for technique classification. If the predicted technique matches the gold label, it records a True Positive (TP); otherwise, it records a misclassification error. Conversely, if either boundary fails the $\delta$-tolerance check, the instance is spatially disqualified and receives a double penalty. It is scored simultaneously as a False Positive (for hallucinating a span in an invalid location) and a False Negative (for missing the true target span). This double penalty ensures that models cannot artificially pad precision or recall with poorly aligned boundaries.

### 5.2 Primary Optimization Metric: Macro-Weighted F1
To account for class imbalance across the eight propaganda techniques and prevent dominant majority classes from skewing performance, the primary benchmark metric is Macro-F1 Score, calculated strictly across the active propaganda categories $\mathcal{T}$ while excluding background not_propaganda tokens:

$$\text{Macro-F1} = \frac{1}{\vert{}\mathcal{T}\vert{}} \sum_{k \in \mathcal{T}} \frac{2 \cdot P_k \cdot R_k}{P_k + R_k}$$

In this formulation, $P_k$ and $R_k$ represent the class-specific precision and recall for technique $k$.  

> This writeup is a bit wrong and misleading. Utlimately, after the routing, the task becomes identifcal to Task 1 so the same terminal metric can be carried over. This does not mean task 1 and task 2 be directly compared, but it does mean for all task 2 appraochs, the performance of the routing will inherently represented in the terminal metrics. A better router = a better metric. 

While terminal evaluation relies on the standard Macro-F1 score averaged across the eight active propaganda categories $\mathcal{T} = \{1, \dots, 8\}$, the interpretation of this metric differs fundamentally from Task 1. In Task 1, evaluation operated on static, pre-delimited snippets where candidate boundaries were guaranteed. In Task 2, Macro-F1 functions as a joint end-to-end performance metric. Because predicted spans must pass through the cascading boundary router prior to technique evaluation, localization failures (complete omissions or disqualified offsets) directly penalize the precision ($P_k$) and recall ($R_k$) denominators for technique $k$:

$$\text{Macro-F1} = \frac{1}{\vert{}\mathcal{T}\vert{}} \sum_{k \in \mathcal{T}} \frac{2 \cdot P_k \cdot R_k}{P_k + R_k}$$

Consequently, a model cannot achieve a competitive Macro-F1 score through strong technique classification alone; superior performance on this metric inherently reflects superior spatial boundary routing.

### 5.3 Three-Phase Diagnostic Audit Architecture
While terminal Macro-F1 provides a clean scalar for leaderboard ranking, it obscures the exact mechanism behind a model's operational performance. To isolate localized spatial errors from downstream semantic classification errors, our framework executes a three-phase diagnostic audit across all model variants.

Phase 1 conducts a Structural Localization Audit across the five primary routing states. By categorizing every validation row into True Negatives, Complete Omissions, Hallucinations, Disqualified Near-Miss Spans, or Qualified Spans, this phase isolates pure background filtering capability from active target localization.

Phase 2 performs a "Near-Miss" Semantic Signal Analysis by examining the subset of disqualified spans that successfully located propaganda but failed the $\delta$-tolerance window. Evaluating multi-class accuracy strictly across these offset spans measures whether a failing model was semantically blind or merely spatially misaligned. 

Finally, Phase 3 executes a Semantic Ceiling and Oracle Gap Comparison by measuring multi-class technique accuracy exclusively on the spatially qualified subset. These results are evaluated against an Oracle Benchmark consisting of a Stage 2 classifier evaluated on gold spans. The resulting Oracle Gap quantifies the exact performance degradation caused by embedding noise and boundary offsets, providing complete visibility into pipeline bottlenecks.

---

## 6. Results
This section presents the primary empirical performance metrics across all evaluated pipeline variants. To benchmark model performance on Task 2, we evaluate the stochastic random baseline alongside the two primary neural architectures: Architecture Variation 1 (Decoupled Cascade) and Architecture Variation 2 (17-Class Integrated Joint Tagger). All models are evaluated on the validation dataset ($N = 640$ total sentences, containing $309$ active propaganda targets) using character-level length-adaptive boundary tolerance routing ($\delta$). Performance is reported using Macro Precision, Macro Recall, and Macro-F1 Score calculated strictly across the eight active propaganda techniques.  

> Add an explilcity code cell to the notebook to pull these stats and make sure they are correct

### 6.1 Baseline Performance
To establish an empirical lower bound for joint span detection and classification, an independent stochastic random-guessing baseline was executed on the validation set. The baseline utilized the empirical prior probability of propaganda presence calculated from the training set ($\sim 52.19\%$) to decide whether to predict an active span or assign a neutral not_propaganda sentence label. When triggering an active prediction, span start and end token indices were selected uniformly at random across sequence length, and a technique label was randomly sampled from the eight target categories.

The random-guessing baseline achieved a terminal Macro-F1 score of 0.0027 (Macro Precision: 0.0026, Macro Recall: 0.0028). Across 640 validation instances, the baseline routed 306 sentences ($47.81\%$) to the neutral background category and 334 sentences ($52.19\%$) to active span predictions. Out of the 334 active random span guesses, only 11 predictions successfully met the character-level $\delta$-tolerance boundary window. However, zero of these spatially qualified guesses assigned the correct propaganda technique label, resulting in zero end-to-end True Positives across all eight techniques.  

This extremely low result does not represent a failire of a baseline but instead informs that infact almost any level of performance is the result of learning. The task itself is so complexity that there barely exists a viable chance of luckily getting correct predictions.

### 6.2 Comparative Primary Model Benchmark
End-to-end evaluation demonstrates that Architecture Variation 2 (17-Class Integrated Joint Tagger) substantially outperforms both the stochastic baseline and Architecture Variation 1 (Decoupled Cascade). Variation 2 achieved a terminal Macro-F1 score of 0.2034, outperforming Variation 1 (0.1684) by 3.5 percentage points.Beyond Variation 2's notable advantage in Macro Precision (0.2914 vs. 0.2000)—which reflects its capacity to suppress false-positive hallucinations on clean background text—the joint architecture also demonstrates a vital advantage in Macro Recall (0.1698 vs. 0.1500). In an imbalanced propaganda corpus where manipulative language is subtle and sparse, a $1.98\%$ absolute increase in recall represents a crucial practical improvement, enabling the system to successfully discover ~13% more total propaganda targets across the evaluation set than the decoupled cascade.


##### Table X
```
| Pipeline Variant | Macro Precision | Macro Recall | Terminal Macro-F1 |
Random-Guessing Baseline 0.0026  0.0028  0.0027  
Variation 1 (Decoupled Cascade) 0.2000  0.1500  0.1684  
Variation 2 (17-Class Joint Tagger) 0.2914  0.1698  0.2034  
```

Per-class breakdowns reveal significant performance variance across individual rhetorical techniques. Both neural models achieved their highest F1 scores on causal_oversimplification ($0.36$ for both variants) and flag_waving ($0.32$ for Variation 1; $0.20$ for Variation 2). Conversely, fine-grained implicit techniques such as loaded_language proved severely challenging for both architectures, yielding low terminal F1 scores ($0.04$ for Variation 1; $0.10$ for Variation 2) primarily due to low boundary recall on short, subtle lexical spans.


##### Table X
```
Propaganda Technique | Support | Var 1 Precision | Var 1 Recall | Var 1 F1 | Var 2 Precision | Var 2 Recall | Var 2 F1 | 
flag_waving | 45 0.33  0.31  0.32  0.29  0.16  0.20  
appeal_to_fear_prejudice | 43  0.15  0.14  0.14  0.32  0.19  0.24  
causal_oversimplification | 35  0.39  0.34  0.36  0.42  0.31  0.36  
doubt | 43  0.22  0.16  0.19  0.32  0.23  0.27  
loaded_language | 39  0.09  0.03  0.04  0.10  0.10  0.10  
name_calling,labeling | 34  0.21  0.15  0.17  0.50  0.12  0.19  
repetition | 40  0.17  0.05  0.11  0.20  0.05  0.08  
exaggeration,minimisation | 30  0.06  0.03  0.04  0.18  0.20  0.19  
Macro Average | 309  0.20  0.15  0.17  0.29  0.17  0.20  
```

### 6.3 Sub-Component Benchmarks & Theoretical Ceilings
To contextualize the end-to-end cascading degradation in Variation 1, the individual pipeline components were evaluated in isolation. Evaluating the Stage 1 3-class DeBERTa-CRF span detector purely on spatial localization within the allowable $\delta$-tolerance window yielded a standalone Span-F1 Score of 0.3815 (Span Precision: 0.4714, Span Recall: 0.3204). Out of 309 active targets, Stage 1 successfully qualified 99 spans, completely missed 210 targets, and hallucinated 111 invalid spans.

Conversely, the Stage 2 contextualized span-pooled classifier was evaluated independently using 100% ground-truth gold spans to establish the upper theoretical performance ceiling. When provided with perfect spatial boundaries, the Stage 2 classifier achieved an Oracle Macro-F1 Ceiling of 0.5106 (Oracle Accuracy: 0.5178, Precision: 0.5228, Recall: 0.5150). 

Connecting the tuned Stage 1 span detector to the Stage 2 classifier caused end-to-end performance to plummet from 0.5106 to 0.1684 Macro-F1, representing a severe localization degradation gap ($\Delta$) of -0.3422.

```
Component/Evaluation Setup | Evaluation Target | Macro Precision | Macro Recall | Primary Score |
Stage 1 Span Detector (Standalone) | Spatial Boundaries Only | 0.4714  0.3204  0.3815 (Span-F1)  
Stage 2 Oracle Classifier (Gold Spans) | Technique Labels Only | 0.5228  0.5150  0.5106 (Oracle Macro-F1)  
Variation 1 End-to-End Cascade | Joint Span & Technique | 0.2000  0.1500  0.1684 (Terminal Macro-F1)
```  
---

## 7. Conclusions, Limitations and Future Work
This project investigated joint propaganda span detection and rhetorical technique classification by comparing a two-stage decoupled cascading architecture (Variation 1) against a single-stage 17-class integrated joint tagger (Variation 2). The empirical results and multi-phase diagnostic audits demonstrate that unifying spatial localization and multi-class technique identification within a single global sequence decoding pass offers substantial structural and semantic advantages over cascading pipelines.

### 7.1 Key Conclusions
Architecture Variation 2 proved superior to Architecture Variation 1 across terminal performance (0.2034 vs. 0.1684 Macro-$F_1$) and Macro Precision (0.2914 vs. 0.2000), validating that joint optimization effectively suppresses false-positive span hallucinations on background text. This advantage stems from the structural dynamics of both models. Decoupling span localization from technique classification in Variation 1 creates a single-point failure bottleneck where Stage 1's standalone span recall ceiling ($\sim 31.39\%$) effectively caps end-to-end recall at 0.1500, while Stage 1 boundary offsets cause feature dilution during mean-pooling that degrades downstream classification accuracy. Conversely, expanding Variation 2's BIO label space to 17 states enables high-confidence interior tokens (`I-technique`) to act as semantic "breadcrumbs." The linear-chain CRF transition matrix uses these strong interior signals to "pull" weaker, ambiguous boundary tokens (`B-technique`) into spatially coherent spans without discarding surrounding sentence context.

On spatially qualified spans that successfully passed the length-adaptive $\delta$-tolerance window, Variation 2 achieved a semantic classification accuracy of 0.5098, recovering $98.5\%$ of the theoretical Stage 2 Oracle Ceiling (0.5178 Accuracy / 0.5106 Macro-$F_1$) and confirming that joint decoding preserves semantic representations cleanly when spatial boundaries align. Finally, the stochastic random-guessing baseline achieved a terminal Macro-$F_1$ of 0.0027 with zero end-to-end True Positives, proving the complexity of Task 2 and confirming that downstream neural gains represent authentic linguistic learning rather than heuristic exploitation.

---

### 7.2 System Limitations
The evaluation framework presents notable structural limitations. The length-adaptive boundary qualification router ($\delta$) enforces a double penalty on disqualified near-miss spans, scoring misaligned predictions simultaneously as a False Positive and a False Negative. Consequently, Phase 2 diagnostic audits revealed that both models retained significant latent semantic understanding across disqualified spans ($\sim 30\text{--}31\%$ near-miss technique accuracy), but minor character-level boundary deviations heavily suppressed terminal Macro-$F_1$, obscuring instances where the network correctly identified the underlying rhetorical technique.

Representation vulnerabilities and class imbalance further constrained performance. In Variation 1, slicing subword representations across slightly misaligned Stage 1 spans incorporates uninformative neutral context words (e.g., "the", "was"), diluting the core propaganda representation and creating an architectural vulnerability for short, delicate spans. Furthermore, both architectures struggled on subtle, implicit techniques such as loaded_language ($F_1 \le 0.10$), where brief rhetorical triggers yield low boundary recall without specialized feature injection.

---

### 7.3 Future Work
To address the disconnect between rigid BIO sequence labeling and human annotator boundary variance, future work should explore distance-weighted or soft-margin loss functions during training. Incorporating a continuous distance-penalty metric into the sequence loss function would explicitly train the network to prefer near-miss boundary predictions over complete span omissions.

> Note, eval metric allows for tolerence but training loss was strict on exact matching
> An exact-match training loss provides a crisp, uncompromised optimization gradient that forces the network to learn strict sequential grammar and precise start-stop boundaries without settling for sloppy approximations. However, its primary drawback is extreme optimization aggressiveness: it penalizes a 1-character boundary offset just as severely as a complete span omission, ignoring near-miss semantic signals and causing gradient instability when training on subjective text where human annotators themselves disagree on exact boundaries.

Model scaling and pre-training offer additional avenues for improvement. Executing Unsupervised Domain-Adaptive Pre-Training (DAPT) on a large corpus of standard news and opinion articles prior to fine-tuning would expose the DeBERTa backbone to broad newsroom syntax, strengthening its baseline representation of neutral journalistic prose so that manipulative rhetorical departures become more salient. Scaling the underlying encoder from deberta-v3-xsmall to deberta-v3-large would also likely improve absolute F1 scores across fine-grained classes like loaded_language. Finally, to preserve the modular task separation of Variation 1 without suffering from single-point cascading failures, future research could implement an end-to-end differentiable multi-task architecture where separate boundary and technique heads have their logits combined via late fusion and decoded through a single sequence loss function.

---