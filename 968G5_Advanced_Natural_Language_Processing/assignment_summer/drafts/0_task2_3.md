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
Task 2 expands the experimental scope from classifying known, unlabelled instances of propaganda to jointly identifying manipulative text boundaries and classifying the specific techniques deployed within raw sequences. This objective is framed as a token-level sequence labeling task utilizing the Beginning, Inside, Outside (BIO) encoding schema.

Formally, given an input sequence of $N$ tokens $\mathbf{x} = (x_1, x_2, \dots, x_N)$, the model learns a mapping function $f: \mathbf{x} \to \mathbf{y}$ to predict a sequence of target tags $\mathbf{y} = (y_1, y_2, \dots, y_N)$ from a label space $y_i \in \mathcal{Y}$:

- $y_i = \text{O}$ for neutral, non-propagandistic context.
- $y_i = \text{B}$ for the initial triggering propaganda token.
- $y_i = \text{I}$ for interior span tokens.

Table 1 demonstrates a sequence translation using the input sentence: "The mainstream media is spreading \<BOS> **blatant lies** \<EOS> about the policy."

### Table 1: BIO Tagged Sequence
| Index ($i$) | Token ($x_i$) | Character Range | Status | BIO Tag ($y_i$) |
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
The methodologies for Task 2 are derived as variations of an adapted, modernized CNN-BiLSTM-CRF framework (Ma and Hovy, 2016)

### 1.1 From Classical BiLSTM-CRF to Modernized Transformer-CRF
Ma and Hovy’s (2016) classical sequence-tagging framework combined character-level CNNs for morphological extraction, Bidirectional LSTMs for contextual dependencies, and a Conditional Random Field (CRF) decoder to enforce valid tag transitions. Applied to propaganda detection, this architecture captures manipulative superlative affixes (e.g., -est), long-range rhetorical framing, and structural constraints. Crucially, the CRF enables high-confidence interior tokens to resolve ambiguous span boundaries. This dynamic is formalized as the "breadcrumb effect" and mitigates noisy annotation boundaries (Da San Martino et al., 2019).

This project modernizes the classical baseline by replacing sequential and convolutional layers with a pre-trained DeBERTa encoder while retaining terminal CRF global decoding. This architectural shift yields four core advantages. SentencePiece tokenization natively standardizes subword morphology, eliminating the need to train dedicated character-CNNs. Global self-attention replaces recurrency to prevent context decay. Fine-tuning pre-trained representations mitigates catastrophic overfitting on small corpora. Finally, DeBERTa’s disentangled attention decouples content from relative position. This grants the model the spatial awareness needed when neutral vocabulary is weaponized through strategic placement.

To benchmark this modernized pipeline, we evaluate two architectural variations: a Decoupled Two-Stage Tagger (Variation 1) and an Integrated Multi-Class BIO-CRF Pipeline (Variation 2).

## 2. Architecture Variation 2: The Integrated Multi-Class BIO-CRF Model
Variation 2 frames propaganda detection as a single-stage, end-to-end joint sequence labeling task, learning span boundaries and technique classifications simultaneously. This is achieved by expanding the 17-state BIO schema, joining `B-` and `I-` prefixes with technique suffixes plus a neutral `O` state (Appendix F):

$$\mathcal{Y}_{17} = \{\text{O}\} \cup \{\text{B-}k \mid k \in \mathcal{T}\} \cup \{\text{I-}k \mid k \in \mathcal{T}\}$$

This granular label space optimizes boundaries and techniques in tandem. Tag expansion enhances the "breadcrumb effect" during decoding. Instead of collapsing uncertain boundaries into an uninformative ~50/50 binary split, probability mass is dispersed across technique states. When a small boundary mass aligns with a high-confidence interior token, the CRF transition matrix leverages that semantic linkage to pull ambiguous boundary tokens into coherent spans.


### 2.1 Model Architecture & Forward Pass
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

### 2.2 Hyperparameter Search & Optimization Strategy
To prevent gradient instability, the pipeline uses differential learning rates with AdamW. Co-training pre-trained DeBERTa alongside randomly initialized linear projection and CRF layers creates an optimization imbalance where standard CRF learning rates ($10^{-3}$) risk destroying encoder features, whereas typical transformer rates ($10^{-5}$) stall CRF convergence.

A hyperparameter search across three configurations identified optimal bounds, with the conservative setup (Run 1) achieving the lowest loss (NLL = $3.7016$).

##### Table 2: Variation 2 Hyperparameter Configurations
| Parameter Configuration | Backbone LR ($\eta_{\text{base}}$) | Heads LR ($\eta_{\text{head}}$) | Batch Size ($B$) | Dev Loss (CRF NLL) |
| :--- | :---: | :---: | :---: | :---: |
| **Run 1 (Conservative)** | **1e-5** | **5e-4** | **16** | **3.7016** *(Selected)* |
| **Run 2 (Moderate)** | 2e-5 | 1e-3 | 16 | 4.0252 |
| **Run 3 (Aggressive)** | 5e-5 | 2e-3 | 32 | 4.2202 |

This differential scheme preserves DeBERTa's representations for subtle rhetorical cues while enabling the CRF to rapidly learn structural transitions. Micro-batching ($B=16$) prevents loss saturation on background `O` tokens, while AdamW weight decay ($0.01$) and gradient clipping ($\le 1.0$) stabilize CRF optimization against heavy transition penalties. The production model was trained for 10 epochs under Run 1 parameters.

---

## 3. Architecture Variation 1: Decoupled, Two-Stage Tagger
Variation 1 adopts a modular pipeline that decouples propaganda detection into two specialized sub-networks:
1. **Stage 1 (Span Localization Tagger):** A 3-class sequence tagger ($\mathcal{Y}_3 = \{\text{O}, \text{B-Propaganda}, \text{I-Propaganda}\}$) trained exclusively to identify propagandistic boundaries within full-sentence context.
2. **Stage 2 (Technique Classifier Head):** An independent Multi-Layer Perceptron (MLP) that mean-pools subword embeddings from Stage 1’s predicted spans and categorizes them into one of eight rhetorical techniques.

$$\mathcal{Y}_3 = \{\text{O}, \text{B-Propaganda}, \text{I-Propaganda}\}$$

Collapsing techniques into a 3-class target maximizes positive label density, enabling Stage 1 to learn robust spatial boundaries without fragmentation from rare sub-classes. Stage 2 then acts as a specialized domain expert, optimizing rhetorical features independently of sequence constraints. However, this decoupling creates a single-point failure bottleneck, where early Stage 1 boundary errors permanently limit downstream Stage 2 performance.

### 3.1 Model Architecture & Forward Pass
Stage 1 employs a DeBERTa-CRF architecture (Section 2), restricting emissions to $\mathbf{E} \in \mathbb{R}^{N \times 3}$ and transitions to $\mathbf{A} \in \mathbb{R}^{3 \times 3}$. When Stage 1 detects an active span, Stage 2 re-encodes the sentence into token representations $\mathbf{H} \in \mathbb{R}^{N \times 384}$, slices the sequence to predicted indices $[p_{\text{start}}, p_{\text{end}}]$, and isolates the target vectors. This slicing is done to intensify the core propaganda signal and strip away uninformative neutral text that has already been contextualized by DeBERTa’s self-attention layers.

The sliced embeddings are mean-pooled into a fixed 384-dimensional vector $\mathbf{h}_{\text{pooled}}$:

This pooled embedding is processed through a two-layer MLP classification head:

$$\mathbf{z} = \text{Linear}_{64 \to 8}\Big(\text{Dropout}\Big(\text{LayerNorm}\Big(\text{ReLU}\Big(\text{Linear}_{384 \to 64}(\mathbf{h}_{\text{pooled}})\Big)\Big)\Big)\Big)$$

The initial projection ($384 \to 64$) compresses dense noise, ReLU introduces non-linear decision boundaries, Layer Normalization stabilizes small-batch variance ($B=16$), and Dropout ($p=0.3$) prevents topic memorization. If no span is detected ($p_{\text{start}} = -1$), the pipeline defaults to neutral text, bypassing Stage 2.


### 3.2 Hyperparameter Search & Optimization Strategy
#### 3.2.1 Stage 2 Head Training & Performance Ceiling
Stage 2 was trained exclusively on gold-standard spans to isolate technique classification from localization errors. Keeping DeBERTa frozen to retain linguistic baseline, the MLP head ($\theta_{\text{MLP}}$) was optimized with multi-class Cross-Entropy loss ($\mathcal{L}_{\text{CE}}$) using AdamW ($\text{LR} = 10^{-3}, B = 16$) over 10 epochs:

$$\mathcal{L}_{\text{CE}}(\theta_{\text{MLP}}) = -\sum_{k=1}^{8} y_{k} \log \hat{y}_{k}$$

Evaluated on validation gold spans, Stage 2 established a performance ceiling of $0.5106$ Macro-$F_1$ ($0.5178$ Accuracy), benchmarking the maximum theoretical classification performance given $100\%$ spatial localization.

#### 3.2.2 Stage 1 Hyperparameter Grid Search
Stage 1 (Sequence Labeller) parameters ($\theta_{\text{S1}}$) were trained by minimizing negative log-likelihood ($\mathcal{L}_{\text{CRF}}$) over 3-class space $\mathcal{Y}_3$:

$$\mathcal{L}_{\text{CRF}}(\theta_{\text{S1}}) = -\log \left( \frac{\exp(S(\mathbf{x}, \mathbf{y}^*))}{\sum_{\mathbf{y}' \in \mathcal{Y}_3^{N}} \exp(S(\mathbf{x}, \mathbf{y}'))} \right)$$

A grid-search across learning rates evaluated Viterbi paths against ground-truth spans using length-adaptive $\delta$-tolerance routing. Trial 9 achieved top spatial performance ($0.3834$ Span-$F_1$).

##### Table 3: Stage 1 Hyperparameter Search Results
```
Tuning Trial | Backbone LR (ηbase​) | Heads LR (ηhead​)Span Precision | Span Recall | Standalone | Span-F1 | 
| :--- | :--- | :--- | :--- | :--- | :--- |
| Trial 1 | 5e-6 | 3e-4 | 0.4327 | 0.2395 | 0.3083 |
| Trial 4 | 1e-5 | 3e-4 | 0.4140 | 0.2492 | 0.3111 |
| Trial 6 | 1e-5 | 1e-3 | 0.4415 | 0.2686 | 0.3340 |
| Trial 9 **(Selected)** | 3e-5 | 1e-3 | 0.4924 | 0.3139 | 0.3834 |
```

The final system couples both stages: Stage 1 extracts span bounds via Viterbi decoding under Trial 9 parameters, and Stage 2 classifies active spans into 8-way technique predictions.

---

## 4. Stochastic Random-Guessing Baseline
To establish a mathematical lower bound and confirm that neural models learn authentic rhetorical patterns rather than length heuristics, we implement a probabilistic baseline operating via a three-step stochastic sampling procedure:
1. A Bernoulli trial determines propaganda existence using the training set's positive label distribution $P$. Sentences flagged as clean return all `O` tags.
2. If propaganda is flagged, start and end indices $(i, j)$ are drawn uniformly at random:

$$i \sim \text{Uniform}(1, N), \quad j \sim \text{Uniform}(i, N)$$

3. A technique $k$ is drawn uniformly across the 8 categories:$$k \sim \text{Uniform}(1, 8)$$

$$k \sim \text{Uniform}(1, 8)$$

This generates a triple $(1, [i, j], k)$, mapping tokens to BIO tags. For example, in a 5-token sequence where $(i=2, j=3, k=\text{Loaded})$, token $t_2$ maps to `B-Loaded`, $t_3$ to `I-Loaded`, and remaining tokens to `O`. Evaluated via our test suite, this establishes our benchmark performance floor.

---

## 5. Evaluation Framework 
Evaluating propaganda sequence labeling requires balancing spatial boundary precision with multi-class technique classification. To establish an interpretable benchmark, our evaluation engine combines adaptive boundary routing, penalized error scoring, and a diagnostic audit.

### 5.1 Cascading Boundary Qualification Router
Human annotators often disagree on propaganda bounds (Da San Martino, 2020). To accommodate minor offsets without masking severe misalignment, predicted spans $(p_{\text{start}}, p_{\text{end}})$ are evaluated against gold spans $(g_{\text{start}}, g_{\text{end}})$ using a length-adaptive tolerance window ($\delta$).

##### Table 4: Length-Adaptive Boundary Tolerance ($\delta$)
| Span Length (Tokens) | Boundary Tolerance ($\delta$) | Verification Rule |
| :--- | :--- | :--- |
| **$\le 5$** | 0 tokens | Predicted start and end indices must align perfectly with the gold span (Exact Match) |
| **$6\text{--}10$** | $\pm 1$ token | Start and end indices are allowed a 1-token tolerance in either direction |
| **$11\text{--}15$** | $\pm 2$ tokens | Start and end indices are allowed a 2-token tolerance in either direction |
| **$16\text{--}50$** | Step-wise scaling | Tolerance scales linearly, $+1$ token offset per 5 additional tokens. |
| **$> 50$** | $\pm 10$ tokens | Boundary tolerance caps out at a maximum window of 10 tokens. |
---

Active predicted spans passing the gate ($\vert p_{\text{start}} - g_{\text{start}} \vert \le \delta$ and $\vert p_{\text{end}} - g_{\text{end}} \vert \le \delta$) become spatially qualified. Correct technique predictions yield a True Positive (TP) and incorrect techniques yield a misclassification. Spans failing $\delta$-tolerance receive a double penalty—scored simultaneously as a False Positive (hallucination) and a False Negative (omission).

### 5.2 Primary Optimization Metric: Macro-Weighted F1
Continuing from Task 1 (Section 4.4), terminal performance is evaluated using the standard Macro-$F_1$ score averaged across the eight active propaganda categories $\mathcal{T}$:

$$\text{Macro-F1} = \frac{1}{\vert{}\mathcal{T}\vert{}} \sum_{k \in \mathcal{T}} \frac{2 \cdot P_k \cdot R_k}{P_k + R_k}$$

Because predicted spans must pass through the boundary router before technique evaluation, localization failures directly penalize $P_k$ and $R_k$. Consequently, higher Macro-$F_1$ scores inherently reflect superior spatial boundary routing alongside accurate technique classification. Due to this joint dependency on spatial qualification, Task 1 and Task 2 Macro-$F_1$ metrics are not directly comparable. Task 1's metric evaluates classification over fixed pre-delimited spans, Task 2's measures end-to-end joint span detection and classification.

### 5.3 Diagnostic Audit Architecture
To isolate spatial localization errors from downstream semantic misclassifications, a three-phase audit is executed across model outputs. First, the structural localization Audit categorizes sequence predictions (Stage 1) into True Negatives, Omissions, Hallucinations, Disqualified Near-Misses, or Qualified Spans to evaluate boundary isolation capabilities. Second, the near-miss Analysis evaluates technique accuracy exclusively on the subset of disqualified spans to test whether spatially misaligned predictions still maintain semantic awareness. Finally, the ceiling gap analysis compares multi-class technique accuracy on qualified spans against the ceiling model, quantifying the exact performance degradation caused by boundary noise and embedding offsets.

---

## 6. Results & Discussion
This section presents empirical performance across the stochastic random baseline, Architecture Variation 1 (Decoupled), and Architecture Variation 2 (Integrated). Evaluated on the test split ($N = 640$ sentences; $309$ positive instances) using our length-adaptive boundary routing ($\delta$), performance is reported across Macro Precision, Recall, and $F_1$.

### 6.1 Baseline Performance
A stochastic random-guessing baseline established the empirical lower bound, sampling span presence via the training prior ($52.19\%$) while drawing token bounds and techniques uniformly at random. The baseline achieved a terminal Macro-$F_1$ of $0.0027$ (Precision: $0.0026$, Recall: $0.0028$). Out of $334$ active predictions across $640$ validation sentences, only $11$ spans satisfied $\delta$-tolerance routing, with zero correct technique assignments. 

This near-zero floor highlights the extreme combinatorial complexity of joint sequence tagging. In propaganda detection, arbitrary span extraction almost universally fails because manipulative phrases are tightly embedded within neutral syntactic prose. Thus, non-trivial neural performance directly reflects learned linguistic representations rather than stochastic spatial alignment.

### 6.2 Terminal Results 
End-to-end evaluation demonstrates that Variation 2 (Integrated) outperforms both the baseline and Variation 1 (Decoupled) across all primary metrics. Variation 2 achieved a terminal Macro-$F_1$ of $0.2034$, exceeding Variation 1 ($0.1684$) by $3.5$ percentage points ($+20.8\%$ relative improvement).

Variation 2’s substantial advantage in Macro Precision ($0.2914$ vs. $0.2000$) reflects its capacity to suppress false-positive hallucinations on neutral background text. Jointly optimizing boundaries and techniques within a unified 17-state CRF allows interior technique signals (e.g., `I-Loaded`) to refine span edges, avoiding the single-point localization bottleneck that limits Variation 1. Furthermore, Variation 2 demonstrated a superior Macro Recall ($0.1698$ vs. $0.1500$). Given the extreme sparsity of manipulative text relative to surrounding neutral text, this $1.98$ percentage point absolute gain enables the integrated tagger to discover $\sim 13\%$ more total propaganda targets ($40$ vs. $35$ targets across $640$ validation sentences).

##### Table 6: Baseline, Variation 1, and Variation 2 Terminal Results
| Pipeline Variant | Macro Precision | Macro Recall | Terminal Macro-F1 |
| :--- | :---: | :---: | :---: |
| **Random-Guessing Baseline** | 0.0026 | 0.0028 | 0.0027 |
| **Variation 1 (Decoupled Cascade)** | 0.2000 | 0.1500 | 0.1684 |
| **Variation 2 (17-Class Joint Tagger)** | **0.2914** | **0.1698** | **0.2034** |

### 6.3 Class-Level Results
Per-class metrics reveal key representational trade-offs across individual propaganda techniques. Variation 2 achieves higher $F_1$ scores across five of the eight categories, driven by substantial precision gains across almost all classes, most notably on `name_calling,labeling` ($0.50$ vs. $0.21$) and `appeal_to_fear_prejudice` ($0.32$ vs. $0.15$).

Both architectures performed best on structural and explicit categories like `causal_oversimplification` ($F_1 = 0.36$ for both variants), where overt logical connectors ("because of", "led to") form clear contextual triggers. Conversely, `flag_waving` represents the sole category where Variation 1 outperformed Variation 2 ($F_1 = 0.32$ vs. $0.20$). Because nationalistic rhetoric relies on multi-word entity phrases ("our glorious nation"), Stage 1's generic 3-class tagger isolates extended spatial boundaries effectively without suffering from multi-class state fragmentation.

The integrated 17-class schema yields its most dramatic improvement on `exaggeration,minimisation`, driving $F_1$ from $0.04$ to $0.19$ via a nearly 7-fold increase in Recall ($0.03 \to 0.20$). Extrema modifiers ("unprecedented", "disaster") act as immediate spatial anchors when boundary and technique states are jointly decoded. Conversely, short, implicit triggers like `loaded_language` ($F_1 = 0.04$ vs. $0.10$) and `repetition` ($F_1 = 0.11$ vs. $0.08$) remain severely challenging. Isolated emotive words frequently fail length-adaptive $\delta$-tolerance checks ($L \le 5$ requires an exact token match) whenever surrounding neutral adverbs are slightly over-predicted.

##### Table 7: Class-Level Performance Across Pipeline Variants
| Propaganda Technique | Support | Var 1 Precision | Var 1 Recall | Var 1 F1 | Var 2 Precision | Var 2 Recall | Var 2 F1 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **flag_waving** | 45 | 0.33 | 0.31 | **0.32** | 0.29 | 0.16 | 0.20 |
| **appeal_to_fear_prejudice** | 43 | 0.15 | 0.14 | 0.14 | **0.32** | **0.19** | **0.24** |
| **causal_oversimplification** | 35 | 0.39 | **0.34** | **0.36** | **0.42** | 0.31 | **0.36** |
| **doubt** | 43 | 0.22 | 0.16 | 0.19 | **0.32** | **0.23** | **0.27** |
| **loaded_language** | 39 | 0.09 | 0.03 | 0.04 | **0.10** | **0.10** | **0.10** |
| **name_calling,labeling** | 34 | 0.21 | **0.15** | 0.17 | **0.50** | 0.12 | **0.19** |
| **repetition** | 40 | 0.17 | **0.05** | **0.11** | **0.20** | **0.05** | 0.08 |
| **exaggeration,minimisation** | 30 | 0.06 | 0.03 | 0.04 | **0.18** | **0.20** | **0.19** |
| **Macro Average** | 309 | 0.20 | 0.15 | 0.17 | **0.29** | **0.17** | **0.20** |

### 6.4 Diagnostic Analysis & Error Interpretation
To isolate spatial localization errors from downstream semantic misclassifications, we execute the three-phase diagnostic audit established in Section 5.3 across model outputs.

#### Phase 1: Structural Localization Audit
The Structural Localization Audit evaluates raw background filtering and boundary isolation by categorizing validation sentence predictions into five discrete routing states.

The audit reveals that Variation 2’s performance edge is heavily driven by hallucination suppression ($12.7\%$ vs. $33.5\%$) and superior spatial qualification ($42.7\%$ vs. $32.0\%$). While both models filter pure background text well ($\sim 98\%$ TN), Variation 1 suffers from severe over-generation in Stage 1, producing $111$ hallucinated spans that pass to Stage 2 and trigger downstream false positives.

##### Table 8: Structural Localization Audit Across Pipeline Variants
| Localization Category | Description / Routing Condition | Variation 1 (Decoupled) | Variation 2 (Integrated) |
| :--- | :--- | :---: | :---: |
| **True Negatives (TN)** | Clean background correctly predicted as neutral (`O`) | 322 / 331 (97.3%) | 325 / 331 (98.2%) |
| **Complete Omissions (FN)** | Active propaganda target entirely missed (predicted `O`) | 148 / 309 (47.9%) | 122 / 309 (39.5%) |
| **Hallucinations (FP)** | Neutral background incorrectly tagged as propaganda | 111 / 331 (33.5%) | 42 / 331 (12.7%) |
| **Disqualified Near-Misses** | Target detected but failed $\delta$-tolerance boundary check | 62 / 309 (20.1%) | 55 / 309 (17.8%) |
| **Qualified Spans** | Target detected AND satisfied $\delta$-tolerance check | 99 / 309 (32.0%) | 132 / 309 (42.7%) |

#### Phase 2: Near-Miss Semantic Signal Analysis
Near-miss spans locate the core manipulative phrase but fail the strict length-adaptive $\delta$-tolerance window (e.g., extending a 3-token loaded_language span by two adjacent neutral adverbs). Under our evaluation protocol, these receive a double penalty (scored simultaneously as FP and FN).

Evaluating technique classification accuracy exclusively on these disqualified near-miss spans reveals that Stage 2 achieved $42.3\%$ multi-class accuracy (and Variation 2 achieved $46.1\%$). This confirms that models frequently possess correct semantic awareness of propaganda techniques, but get penalized due to boundary drift. Because human annotators exhibit low inter-annotator agreement on exact character offsets (Da San Martino et al., 2019), strict spatial evaluation understates the true semantic capability of the underlying representations.

#### Phase 3: Ceiling Gap Analysis
The Ceiling Gap Analysis measures multi-class technique accuracy on spatially qualified spans against an Oracle model (Stage 2 evaluated on $100\%$ gold spans, achieving an Oracle Macro-$F_1$ Ceiling of $0.5106$).

When evaluated strictly on qualified spans, Variation 2 operates within $0.0986$ $F_1$ points of the Oracle Ceiling, whereas Variation 1 exhibits a larger qualification gap ($-0.1656$). When accounting for unmitigated boundary omissions and hallucinations end-to-end, the total localization degradation gap expands to $-0.3072$ for Variation 2 and $-0.3422$ for Variation 1. This demonstrates that while feature noise degrades technique classification on valid spans by $\sim 10\text{--}16\%$, early spatial omissions and boundary disqualifications account for the remaining $\sim 30\text{--}34\%$ collapse in end-to-end performance.

##### Table 9: Ceiling & Performance Gap Summary
| Pipeline Evaluation Setup | Primary Metric | Primary Score | Gap vs. Oracle Ceiling ($\Delta$) |
| :--- | :--- | :---: | :---: |
| **Oracle Ceiling Model (Gold Spans)** | Multi-Class Macro-$F_1$ | **0.5106** | — |
| **Variation 2 Spatially Qualified Subset** | Qualified Technique $F_1$ | **0.4120** | **-0.0986** |
| **Variation 1 Spatially Qualified Subset** | Qualified Technique $F_1$ | **0.3450** | **-0.1656** |
| **Variation 2 Terminal End-to-End** | Joint Macro-$F_1$ | **0.2034** | **-0.3072** |
| **Variation 1 Terminal End-to-End** | Joint Macro-$F_1$ | **0.1684** | **-0.3422** |


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