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

## Architectural Approach
The methodology for Task 2 constructs two modelling variations based off an adaptation of the CNN-BiLSTM-CRF framework introduced by Ma and Hovy (2016). 

### CNN-BiLSTM-CRF Framework 
To understand the lineage of this approach, it is vital to examine why Ma and Hovy's baseline was so influential. The authors achieved robust sequence tagging by leveraging a three-tiered hierarchical processing pipeline:
- A Convolutional Neural Network (CNN) operates at the character0level as a localized feature extractor to capture sub-word morphological patterns.
- A Bidirectional Long Short-Term Memory (Bi-LSTM) processes the word sequence in both directions to map long-range contextual dependencies and sentinal context.
- A Conditional Random Field (CRF) decoder evaluates the joint probability of the entire tag sequence, using a learned transition matrix to enforce global structural logic.

> Convert to a clear paragraph

When applied to propaganda detection, this general-purpose framework offers key theoretical advantages. First, the character-level CNN allows the model to detect morphological irregularities common in manipulative language—such as superlative affixes (`-est`, `-st`) used in terms like *greatest* or *worst* to amplify rhetorical framing. Second, the Bi-LSTM's sequence representations capture non-local dependencies, allowing the network to recognize how earlier lexical choices subtly alter the manipulative tone of subsequent words across distant sequence spans. Third, when modeling propaganda fragments under a BIO schema, the CRF transition matrix enforces valid tag sequences (such as `B-` $\to$ `I-` or `I-` $\to$ `O`) while strictly prohibiting illegal transitions, such as initiating an overlapping `B-` tag mid-span. Finally, precise propaganda span delimitation remains highly disputed even among expert annotators (Da San Martino et al., 2019), making boundary identification exceptionally difficult. Under BIO sequence labeling, each token produces an emission distribution across candidate tags. The CRF leverages these parameters to let high-confidence interior tokens pull adjacent, lower-signal boundary predictions into a spatially coherent span—a dynamic formalized in this project as the "breadcrumb effect."

### Modernization Updates
This project builds on this established framework through a modernization update by substituting the sequential and convolutional layers with a deep Transformer encoder (DeBERTa) while keeping the global decoding properties of the terminal CRF layer.  

This modernized update introduces four core architectural advantages over the classical baseline. First, SentencePiece tokenization eliminates the character-level CNN by decomposing out-of-vocabulary terms into subwords, resolving data sparsity without dedicated feature-extraction sub-networks. Second, global self-attention replaces sequential LSTM recurrence, providing direct all-to-all sequence connectivity that mitigates the context decay experienced by recurrency and ensures capture of long-range dependencies underlying manipulative rhetoric. Third, replacing a recurrent model trained from scratch with a pre-trained Transformer limits the risk catastrophic overfitting on the limited training data we have byleveraging the models broad linguistic representations. Finally, DeBERTa’s disentangled attention mechanisms evaluate token content and relative spatial position on separate vectors, granting the model the decoupled spatial awareness needed to isolate manipulative phrases where neutral vocabulary is weaponized through syntactic placement.

> compress these into two tight paragraphs or a single bulleted list that directly contrasts CNN -> SentencePiece, BiLSTM -> Self-Attention, and Static/RNN -> DeBERTa Disentangled Attention.

To evaluate this modernized pipeline, we experiment with two architectural variations: a Decoupled Two-Stage Tagger (Variation 1) and an Integrated Multi-Class BIO-CRF Pipeline (Variation 2).


### The Integrated Multi-Class BIO-CRF Model
This approach addresses the propaganda identification task through a single-stage, end-to-end joint sequence labeling framework. That is to say, the sequence labelling learns both boundary detection and technique classification simultaneously. 

This achieved through an expanded, granular BIO schema, incorporating all eight rhetorical techniques directly into the spatial tagset. Here, both the `B-` and `I-` tagset are joined with a suffix containing a propaganda technique, i.e. `B-Loaded`. Resulting in 8 B-Tags, 8-Tags and single O-Tag. 

$$\mathcal{Y}_{17} = \{\text{O}\} \cup \{\text{B-}k \mid k \in \mathcal{T}\} \cup \{\text{I-}k \mid k \in \mathcal{T}\}$$

This granular formulation is particularly well-suited for propaganda detection because, while rhetorical techniques share underlying manipulative intent, their linguistic signatures remain distinct. By expanding the label space to 17 states, the CRF optimizes spatial boundaries and technique classifications in tandem rather than collapsing semantic distinctions into a binary indicator. Crucially, this wide probability distribution enhances the "breadcrumb effect" during sequence decoding. In a collapsed 3-class BIO schema, ambiguous boundary predictions often collapse into an uninformative ~50/50 split between neutral text and propaganda. In a 17-class schema, however, an uncertain prediction is dispersed across multiple technique states. When a small probability mass (e.g., $0.15$) aligns with a high-confidence technique prediction further along the sequence (e.g., a strong interior `I-loaded_language` token), the CRF's transition matrix uses that semantic linkage to pull the ambiguous boundary token into a spatially coherent span, substantially improving boundary detection.

##### Complete 17-Class BIO Tagset Mapping (Variation 2)
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

#### Model Architecture & Forward Pass
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

#### Hyperparameter Search & Optimization Strategy
To prevent gradient instability and catastrophic forgetting during optimization, Architecture Variation 2 employs a differential learning rate schedule whilst deploying the AdamW optimizer.

Co-training a massive pre-trained Transformer alongside randomly initialized linear projection and CRF layers creates a severe optimization imbalance. Standard learning rates for the CRF convergence ($10^{-3}$ to $10^{-4}$) risk destroying DeBERTa's pre-trained representations, whereas typical transformer rates ($10^{-5}$) would stall the convergence of the initialized heads. 

To identify optimal optimization bounds, a hyperparameter search was executed over 5 epochs using a 10% modulo internal validation split across three training setups. The conservative configuration (Run 1) yielded the lowest negative log-likelihood (NLL = $3.7016$), preventing early divergence in the CRF layer while steadily lowering training loss.

| Parameter Configuration | Backbone LR ($\eta_{\text{base}}$) | Heads LR ($\eta_{\text{head}}$) | Batch Size ($B$) | Dev Loss (CRF NLL) |
| :--- | :---: | :---: | :---: | :---: |
| **Run 1 (Conservative)** | **1e-5** | **5e-4** | **16** | **3.7016** *(Selected)* |
| **Run 2 (Moderate)** | 2e-5 | 1e-3 | 16 | 4.0252 |
| **Run 3 (Aggressive)** | 5e-5 | 2e-3 | 32 | 4.2202 |


This optimization setup is specifically tailored to the domain of propaganda detection. Staggered learning rates preserve DeBERTa’s pre-trained contextual representations for subtle rhetorical cues while enabling the CRF to rapidly learn the structural transition matrix. Micro-batching ($B = 16$) provides frequent parameter updates that prevent the loss from oversaturating on dominant background text class `0`. Finally, combining AdamW weight decay ($0.01$) with gradient clipping ($\le 1.0$) stabilizes CRF optimization against heavy transition penalties while preventing the encoder from overfitting to high-frequency journalistic terminology that underpins this corpus.

The final production model was trained for 10 epochs under the conservative Run 1 configuration, utilizing negative log-likelihood (CRF NLL) loss and gradient accumulation to ensure stable joint convergence across all 17 BIO sequence states.

---

## Architecture Variation 1: Decoupled, Two-Stage Tagger
In contrast to the single-stage joint decoding pass of Variation 2, Architecture Variation 1 adopts a modular, two-stage pipeline for propaganda detection and classification. Rather than forcing a single network to perform spatial boundary localization and multi-class technique identification simultaneously, Variation 1 decouples the task into two specialized sub-networks:

1. **Stage 1 (Span Localization Tagger):** A 3-class sequence tagger trained exclusively to identify the presence and boundaries of propagandistic text within full-sentence context. The target space collapses into three discrete BIO states. Non-propaganda background text is assigned the `O` tag, the onset token of any propaganda phrase is tagged `B-Propaganda`, and interior tokens extending the span are tagged `I-Propaganda`.
2. **Stage 2 (Technique Classifier Head):** An independent Multi-Layer Perceptron (MLP) classifier head that mean-pools subword embeddings extracted from Stage 1's predicted candidate spans and categorizes them into one of eight rhetorical techniques.

This decoupled architecture offers distinct theoretical advantages grounded in data density and task specialization. By collapsing all eight fine-grained propaganda techniques into a generic binary target space ($\mathcal{Y}_3$), Stage 1 maximizes positive label density across the sequence labeling dataset, enabling the tagger to build a robust generalized representation of manipulative text versus neutral background context without being fragmented by rare technique sub-classes. Furthermore, isolating the downstream classification head allows Stage 2 to act as a dedicated domain expert, optimizing rhetorical feature boundaries independently of spatial sequence constraints. Nevertheless, this two-stage division creates an inherent single-point failure bottleneck, where early Stage 1 localization omissions or boundary offsets permanently constrain the downstream performance of Stage 2.

$$\mathcal{Y}_3 = \{\text{O}, \text{B-Propaganda}, \text{I-Propaganda}\}$$

### Model Architecture & Forward Pass
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

### Hyperparameter Search & Optimization Strategy
To properly optimize Variation 1 and establish a theoretical upper bound for Stage 2, training and hyperparameter tuning were divided into two isolated protocols:

#### 1. Stage 2 Head Training & The Oracle Ceiling
To ensure the Stage 2 classifier learned clean technique representations without being degraded by early Stage 1 prediction errors, Stage 2 was trained exclusively on gold-standard propaganda spans extracted from the training corpus. DeBERTa backbone parameters were completely frozen, updating only the parameters of the MLP head using AdamW ($\text{LR} = 1\times 10^{-3}$, $B = 16$) over 10 epochs. When evaluated on validation gold spans, Stage 2 established an Oracle Ceiling of 0.5106 Macro-F1 (and 0.5178 Accuracy), representing the maximum possible performance Variation 1 could achieve under perfect ($100\%$) spatial localization.


#### 2. Stage 1 Hyperparameter Grid Search
Stage 1 was independently tuned via a grid search across transformer learning rates ($\eta_{\text{base}} \in \{5\times 10^{-6}, 1\times 10^{-5}, 3\times 10^{-5}\}$) and head learning rates ($\eta_{\text{head}} \in \{3\times 10^{-4}, 5\times 10^{-4}, 1\times 10^{-3}\}$) over 3 training epochs. Evaluating purely on boundary localization accuracy within the allowable $\delta$-tolerance window yielded the optimal configuration:

- Backbone LR ($\eta_{\text{base}}$): $3\times 10^{-5}$
- Heads LR ($\eta_{\text{head}}$): $1\times 10^{-3}$
- Micro-Batch Size ($B$): $16$
- Stage 1 Standalone Benchmark: 0.3834 Span-F1 (Precision: $0.4924$, Recall: $0.3139$)

> Wait how did we optimize on the boundaries? what was the loss function?

```
Tuning Trial | Backbone LR (ηbase​) | Heads LR (ηhead​)Span Precision | Span Recall | Standalone | Span-F1 | 
| :--- | :--- | :--- | :--- | :--- | :--- |
| Trial 1 | 5e-6 | 3e-4 | 0.4327 | 0.2395 | 0.3083 |
| Trial 4 | 1e-5 | 3e-4 | 0.4140 | 0.2492 | 0.3111 |
| Trial 6 | 1e-5 | 1e-3 | 0.4415 | 0.2686 | 0.3340 |
| Trial 9 (Selected) | 3e-5 | 1e-3 | 0.4924 | 0.3139 | 0.3834 |
```


---


#### 1. Stage 1: 3-Class Span Detection Tagger
##### Label Space & BIO Encoding
Stage 1 simplifies the sequence labeling objective by collapsing all eight propaganda techniques into a generic binary target space $\mathcal{Y}_3 = \{\text{O}, \text{B-Propaganda}, \text{I-Propaganda}\}$. Non-propaganda background text is assigned the O tag, the onset token of any propaganda phrase is tagged B-Propaganda, and all interior tokens within the span are tagged I-Propaganda.  

##### Model Architecture
Stage 1 employs a DeBERTa-CRF sequence tagging architecture identical in structural topology to Variation 2, but restricted to a 3-class emission projection:


```
[Input Subword Sequence x]
        │
        ▼
[DeBERTa-v3-xsmall Encoder] ──> Extracts 384-D contextual token representations
        │
        ▼
[Linear Projection Layer]   ──> Projects 384-D states to 3 emission logits
        │
        ▼
[Linear-Chain CRF Layer]    ──> Enforces 3-class BIO transition constraints
        │
        ▼
[Viterbi Path Decoding]     ──> Emits token span indices [p_start, p_end]
```

To prevent invalid sequence predictions, hard structural constraints are applied to the 3-class CRF transition matrix $\mathbf{A} \in \mathbb{R}^{3 \times 3}$, penalizing illegal transitions (such as $\text{O} \to \text{I-Propaganda}$) with a score of $-10000.0$.

#### 2. Stage 2: Contextualized Span-Pooled Classifier
##### Architecture & Feature Pooling
Stage 2 consists of a specialized classifier head operating on top of a frozen DeBERTa-v3-xsmall backbone. Unlike standard sentence classifiers that only process isolated snippets, Stage 2 encodes the full sentence sequence to preserve complete surrounding context.

Given an input sequence $\mathbf{x}$ and a candidate token span $[p_{\text{start}}, p_{\text{end}}]$ provided by Stage 1, Stage 2 extracts the last hidden layer representations $\mathbf{H} \in \mathbb{R}^{N \times 384}$ from DeBERTa. The subword vectors within the specified span range are sliced and mean-pooled into a single 384-dimensional representation $\mathbf{h}_{\text{pooled}}$:

$$\mathbf{h}_{\text{pooled}} = \frac{1}{p_{\text{end}} - p_{\text{start}} + 1} \sum_{i=p_{\text{start}}}^{p_{\text{end}}} \mathbf{H}_i$$

This pooled embedding is passed through a two-layer Multi-Layer Perceptron (MLP) classification head featuring Layer Normalization, Dropout ($p=0.3$), and ReLU activations: 

$$\mathbf{z} = \text{Linear}_{64 \to 8}\Big(\text{Dropout}\Big(\text{LayerNorm}\Big(\text{ReLU}\Big(\text{Linear}_{384 \to 64}(\mathbf{h}_{\text{pooled}})\Big)\Big)\Big)\Big)$$

The output logits $\mathbf{z} \in \mathbb{R}^8$ yield the predicted multi-class distribution across the eight propaganda techniques.

```
[Full Input Sentence Encodings H]
                 │
┌──────────────┴──────────────┐
│ Slices Range [p_start, p_end]│  ──> Extracts candidate subword vectors
  └──────────────┬──────────────┘
                 ▼
  [Mean-Pooling Layer]              ──> Compresses span to 384-D vector h_pooled
                 │
                 ▼
  [Dense Linear (384 ──> 64)]       ──> Reduces feature dimensionality
                 │
                 ▼
  [ReLU + LayerNorm + Dropout]      ──> Applies non-linearity & regularization
                 │
                 ▼
  [Dense Linear (64 ──> 8)]         ──> Emits 8-way technique logits
```

##### 3. Training Strategy & Oracle Benchmark
To properly evaluate Variation 1 and establish a theoretical ceiling for Stage 2, training and validation were divided into two isolated protocols:

###### Stage 2 Head Training & The Oracle Ceiling
To ensure the Stage 2 classifier learned optimal technique representations without being degraded by early Stage 1 prediction errors, Stage 2 was trained exclusively on gold propaganda spans extracted from the training set. The DeBERTa backbone parameters were completely frozen, updating only the parameters of the MLP classification head using AdamW ($\text{LR} = 1\times 10^{-3}$, $\text{batch\_size} = 16$). 

When evaluated on ground-truth gold spans from the validation set, this Stage 2 classifier established a Theoretical Oracle Ceiling of 0.5106 Macro-F1 (and 0.5178 Accuracy). This benchmark represents the maximum possible performance Variation 1 could achieve if Stage 1 exhibited perfect ($100\%$) span localization.

###### Stage 1 Hyperparameter Tuning
Stage 1 was independently tuned via a grid search across backbone learning rates ($\eta_{\text{base}} \in \{5\times 10^{-6}, 1\times 10^{-5}, 3\times 10^{-5}\}$) and head learning rates ($\eta_{\text{head}} \in \{3\times 10^{-4}, 5\times 10^{-4}, 1\times 10^{-3}\}$) over 3 training epochs. Evaluating purely on boundary localization accuracy within the allowed $\delta$-tolerance window yielded the optimal Stage 1 configuration:
- Backbone LR ($\eta_{\text{base}}$): $3\times 10^{-5}$
- Heads LR ($\eta_{\text{head}}$): $1\times 10^{-3}$
- Batch Size ($B$): $16$
- Stage 1 Standalone Benchmark: 0.3834 Span-F1 (Precision: 0.4924, Recall: 0.3139)

##### 4. End-to-End Cascading Mechanics & The Bottleneck Effect
During end-to-end inference, Variation 1 operates sequentially

```
[Raw Input Sentence]
           │
           ▼
  [Stage 1 Span Detector]     ──> Predicts token bounds [p_start, p_end] via 3-class Viterbi
           │
     ┌─────┴────────────────────────┐
     │ Was an active span predicted?│
     └─────┬──────────────────┬─────┘
        No │                  │ Yes
           ▼                  ▼
  [Predict 'not_propaganda'] [Stage 2 Classifier] ──> Mean-pools [p_start, p_end] & emits technique
```


--- 






















## Stochastic Random-Guessing Baseline
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











## Evaluation Framework 
Evaluating joint propaganda span detection and technique classification requires balancing strict spatial boundary precision with multi-class semantic correctness. In sequence labeling tasks where spans are detected dynamically within full sentences, standard token-level evaluation metrics often obscure whether an error was caused by a spatial boundary offset, a total span miss, or a technique misclassification. To establish a rigorous, interpretable benchmark, our evaluation framework incorporates explicit boundary-qualification routing, penalized error scoring, and a multi-phase diagnostic audit.

### Cascading Boundary Qualification Router
Evaluating localized propaganda spans presents a structural challenge: human annotators often disagree on exact character-level boundaries, yet downstream classification heavily depends on capturing the core semantic phrase. Standard exact-match metrics overly penalize minor boundary offsets, while soft overlap metrics can mask severe over-prediction. To address this, our evaluation engine implements a length-adaptive tolerance window ($\delta$). For any gold propaganda span of character length $L$, the maximum allowable boundary deviation $\delta$ is determined dynamically across distinct length tiers, assigning a single-character offset tolerance for short spans ($L \le 5$), two to three character offsets for medium spans ($6 \le L \le 15$), an incrementally increasing tolerance for long spans ($16 \le L \le 50$), and a hard cap of twelve character offsets for extended spans ($L > 50$).

| Span Length (Tokens) | Boundary Tolerance| Verification Rule |
| :--- | :--- | :--- |
| **$\le 5$** | 0 tokens | Predicted start and end indices must align perfectly with the gold span (Exact Match) |
| **$6\text{--}10$** | $\pm 1$ token | Start and end indices are allowed a 1-token tolerance in either direction |
| **$11\text{--}15$** | $\pm 2$ tokens | Start and end indices are allowed a 2-token tolerance in either direction |
| **$16\text{--}50$** | Step-wise scaling | Tolerance scales linearly, $+1$ token offset per 5 additional tokens. |
| **$> 50$** | $\pm 10$ tokens | Boundary tolerance caps out at a maximum window of 10 tokens. |
---

> check table reflects the actual rules

Using this adaptive tolerance, every predicted span $(p_{\text{start}}, p_{\text{end}})$ is evaluated against its corresponding ground-truth span $(g_{\text{start}}, g_{\text{end}})$ across four distinct evaluation scenarios. A True Negative (TN) is recorded when the gold sentence contains background text (not_propaganda) and the model correctly predicts no active span. Conversely, a False Positive (FP - Hallucination) occurs when the gold sentence is background text but the model predicts an active propaganda span. A False Negative (FN - Omission) represents an instance where the sentence contains a gold propaganda target but the model predicts background text (O).  

When both gold and predicted spans are active, the system executes a Boundary Qualification Gate to verify whether $\vert{}p_{\text{start}} - g_{\text{start}}\vert{} \le \delta$ and $\vert{}p_{\text{end}} - g_{\text{end}}\vert{} \le \delta$. A span that satisfies these conditions is deemed spatially qualified and becomes eligible for technique classification. If the predicted technique matches the gold label, it records a True Positive (TP); otherwise, it records a misclassification error. Conversely, if either boundary fails the $\delta$-tolerance check, the instance is spatially disqualified and receives a double penalty. It is scored simultaneously as a False Positive (for hallucinating a span in an invalid location) and a False Negative (for missing the true target span). This double penalty ensures that models cannot artificially pad precision or recall with poorly aligned boundaries.

### Primary Optimization Metric: Macro-Weighted F1
To account for class imbalance across the eight propaganda techniques and prevent dominant majority classes from skewing performance, the primary benchmark metric is Macro-F1 Score, calculated strictly across the active propaganda categories $\mathcal{T}$ while excluding background not_propaganda tokens:

$$\text{Macro-F1} = \frac{1}{\vert{}\mathcal{T}\vert{}} \sum_{k \in \mathcal{T}} \frac{2 \cdot P_k \cdot R_k}{P_k + R_k}$$

In this formulation, $P_k$ and $R_k$ represent the class-specific precision and recall for technique $k$.  

> This writeup is a bit wrong and misleading. Utlimately, after the routing, the task becomes identifcal to Task 1 so the same terminal metric can be carried over. This does not mean task 1 and task 2 be directly compared, but it does mean for all task 2 appraochs, the performance of the routing will inherently represented in the terminal metrics. A better router = a better metric. 

While terminal evaluation relies on the standard Macro-F1 score averaged across the eight active propaganda categories $\mathcal{T} = \{1, \dots, 8\}$, the interpretation of this metric differs fundamentally from Task 1. In Task 1, evaluation operated on static, pre-delimited snippets where candidate boundaries were guaranteed. In Task 2, Macro-F1 functions as a joint end-to-end performance metric. Because predicted spans must pass through the cascading boundary router prior to technique evaluation, localization failures (complete omissions or disqualified offsets) directly penalize the precision ($P_k$) and recall ($R_k$) denominators for technique $k$:

$$\text{Macro-F1} = \frac{1}{\vert{}\mathcal{T}\vert{}} \sum_{k \in \mathcal{T}} \frac{2 \cdot P_k \cdot R_k}{P_k + R_k}$$

Consequently, a model cannot achieve a competitive Macro-F1 score through strong technique classification alone; superior performance on this metric inherently reflects superior spatial boundary routing.

### Three-Phase Diagnostic Audit Architecture
While terminal Macro-F1 provides a clean scalar for leaderboard ranking, it obscures the exact mechanism behind a model's operational performance. To isolate localized spatial errors from downstream semantic classification errors, our framework executes a three-phase diagnostic audit across all model variants.

Phase 1 conducts a Structural Localization Audit across the five primary routing states. By categorizing every validation row into True Negatives, Complete Omissions, Hallucinations, Disqualified Near-Miss Spans, or Qualified Spans, this phase isolates pure background filtering capability from active target localization.

Phase 2 performs a "Near-Miss" Semantic Signal Analysis by examining the subset of disqualified spans that successfully located propaganda but failed the $\delta$-tolerance window. Evaluating multi-class accuracy strictly across these offset spans measures whether a failing model was semantically blind or merely spatially misaligned. 

Finally, Phase 3 executes a Semantic Ceiling and Oracle Gap Comparison by measuring multi-class technique accuracy exclusively on the spatially qualified subset. These results are evaluated against an Oracle Benchmark consisting of a Stage 2 classifier evaluated on gold spans. The resulting Oracle Gap quantifies the exact performance degradation caused by embedding noise and boundary offsets, providing complete visibility into pipeline bottlenecks.

---













## Evaluation Results
This section presents the primary empirical performance metrics across all evaluated pipeline variants. To benchmark model performance on Task 2, we evaluate the stochastic random baseline alongside the two primary neural architectures: Architecture Variation 1 (Decoupled Cascade) and Architecture Variation 2 (17-Class Integrated Joint Tagger). All models are evaluated on the validation dataset ($N = 640$ total sentences, containing $309$ active propaganda targets) using character-level length-adaptive boundary tolerance routing ($\delta$). Performance is reported using Macro Precision, Macro Recall, and Macro-F1 Score calculated strictly across the eight active propaganda techniques.  

> Add an explilcity code cell to the notebook to pull these stats and make sure they are correct

### Baseline Performance
To establish an empirical lower bound for joint span detection and classification, an independent stochastic random-guessing baseline was executed on the validation set. The baseline utilized the empirical prior probability of propaganda presence calculated from the training set ($\sim 52.19\%$) to decide whether to predict an active span or assign a neutral not_propaganda sentence label. When triggering an active prediction, span start and end token indices were selected uniformly at random across sequence length, and a technique label was randomly sampled from the eight target categories.

The random-guessing baseline achieved a terminal Macro-F1 score of 0.0027 (Macro Precision: 0.0026, Macro Recall: 0.0028). Across 640 validation instances, the baseline routed 306 sentences ($47.81\%$) to the neutral background category and 334 sentences ($52.19\%$) to active span predictions. Out of the 334 active random span guesses, only 11 predictions successfully met the character-level $\delta$-tolerance boundary window. However, zero of these spatially qualified guesses assigned the correct propaganda technique label, resulting in zero end-to-end True Positives across all eight techniques.  

This extremely low result does not represent a failire of a baseline but instead informs that infact almost any level of performance is the result of learning. The task itself is so complexity that there barely exists a viable chance of luckily getting correct predictions.

### Comparative Primary Model Benchmark
End-to-end evaluation demonstrates that Architecture Variation 2 (17-Class Integrated Joint Tagger) substantially outperforms both the stochastic baseline and Architecture Variation 1 (Decoupled Cascade). Variation 2 achieved a terminal Macro-F1 score of 0.2034, outperforming Variation 1 (0.1684) by 3.5 percentage points.Beyond Variation 2's notable advantage in Macro Precision (0.2914 vs. 0.2000)—which reflects its capacity to suppress false-positive hallucinations on clean background text—the joint architecture also demonstrates a vital advantage in Macro Recall (0.1698 vs. 0.1500). In an imbalanced propaganda corpus where manipulative language is subtle and sparse, a $1.98\%$ absolute increase in recall represents a crucial practical improvement, enabling the system to successfully discover ~13% more total propaganda targets across the evaluation set than the decoupled cascade.


```
| Pipeline Variant | Macro Precision | Macro Recall | Terminal Macro-F1 |
Random-Guessing Baseline 0.0026  0.0028  0.0027  
Variation 1 (Decoupled Cascade) 0.2000  0.1500  0.1684  
Variation 2 (17-Class Joint Tagger) 0.2914  0.1698  0.2034  
```

Per-class breakdowns reveal significant performance variance across individual rhetorical techniques. Both neural models achieved their highest F1 scores on causal_oversimplification ($0.36$ for both variants) and flag_waving ($0.32$ for Variation 1; $0.20$ for Variation 2). Conversely, fine-grained implicit techniques such as loaded_language proved severely challenging for both architectures, yielding low terminal F1 scores ($0.04$ for Variation 1; $0.10$ for Variation 2) primarily due to low boundary recall on short, subtle lexical spans.

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

### 1.3 Sub-Component Benchmarks & Theoretical Ceilings
To contextualize the end-to-end cascading degradation in Variation 1, the individual pipeline components were evaluated in isolation. Evaluating the Stage 1 3-class DeBERTa-CRF span detector purely on spatial localization within the allowable $\delta$-tolerance window yielded a standalone Span-F1 Score of 0.3815 (Span Precision: 0.4714, Span Recall: 0.3204). Out of 309 active targets, Stage 1 successfully qualified 99 spans, completely missed 210 targets, and hallucinated 111 invalid spans.

Conversely, the Stage 2 contextualized span-pooled classifier was evaluated independently using 100% ground-truth gold spans to establish the upper theoretical performance ceiling. When provided with perfect spatial boundaries, the Stage 2 classifier achieved an Oracle Macro-F1 Ceiling of 0.5106 (Oracle Accuracy: 0.5178, Precision: 0.5228, Recall: 0.5150). Connecting the tuned Stage 1 span detector to the Stage 2 classifier caused end-to-end performance to plummet from 0.5106 to 0.1684 Macro-F1, representing a severe localization degradation gap ($\Delta$) of -0.3422.

```
Component/Evaluation Setup | Evaluation Target | Macro Precision | Macro Recall | Primary Score |
Stage 1 Span Detector (Standalone) | Spatial Boundaries Only | 0.4714  0.3204  0.3815 (Span-F1)  
Stage 2 Oracle Classifier (Gold Spans) | Technique Labels Only | 0.5228  0.5150  0.5106 (Oracle Macro-F1)  
Variation 1 End-to-End Cascade | Joint Span & Technique | 0.2000  0.1500  0.1684 (Terminal Macro-F1)
```  
---




