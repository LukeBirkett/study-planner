# Task 2: Joint Propaganda Span Detection and Classification
Task 2 expands the experimental scope from classifying isolated, pre-delimited snippets to jointly identifying manipulative text boundaries and classifying the specific techniques deployed within raw, full-sentence sequences. This objective is framed as a token-level sequence labeling task utilizing the Beginning, Inside, Outside (BIO) encoding schema.

Formally, given an input sequence of $N$ subword tokens $\mathbf{x} = (x_1, x_2, \dots, x_N)$, the model learns a mapping function $f: \mathbf{x} \to \mathbf{y}$ to predict an aligned sequence of target tags $\mathbf{y} = (y_1, y_2, \dots, y_N)$, where each $y_i \in \mathcal{Y}$. Under the BIO formulation, the label space $\mathcal{Y}$ assigns tokens as follows:

- $y_i = \text{O}$ for neutral background tokens and non-propagandistic context.
- $y_i = \text{B-}k$ for the initial subword/token triggering a propaganda span of technique $k \in \mathcal{T}$.
- $y_i = \text{I-}k$ for subsequent interior tokens extending an active span of technique $k$.

To demonstrate how a raw sequence translates into aligned BIO vectors for model training, consider the input sentence: "The mainstream media is spreading <BOS> blatant lies <EOS> about the policy."

Assuming a target span of "blatant lies" labeled with the technique Name_Calling,Labeling, the subword tokenization and tag alignment operate as follows:

| Sequence Index ($i$) | Raw / Subword Token ($x_i$) | Character Range | Alignment Status | BIO Tag Target ($y_i$) |
| :--- | :--- | :--- | :--- | :--- |
| $x_1$ | `[CLS]` | Special | Bvoundary Marker | `O` |
| $x_2$ | `The` | [0:3] | Background Text | `O` |
| $x_3$ | `mainstream` | [4:14] | Background Text | `O` |
| $x_4$ | `media` | [15:20] | Background Text | `O` |
| $x_5$ | `is` | [21:23] | Background Text | `O` |
| $x_6$ | `spreading` | [24:30] | Background Text | `O` |
| $x_7$ | **`blatant`** | [31:38] | **Span Onset** | **`B-name_calling,labeling`** |
| $x_8$ | **`lies`** | [39:42] | **Span Continuation** | **`I-name_calling,labeling`** |
| $x_9$ | `about` | [43:47] | Background Text | `O` |
| $x_{10}$ | `the` | [48:51] | Background Text | `O` |
| $x_{11}$ | `policy` | [52:54] | Background Text | `O` |
| $x_{12}$ | `.` | [54:55] | Background Text | `O` |
| $x_{13}$ | `[SEP]` | Special | Boundary Marker | `O` |

---

## Flow and Structure of Task 2

> "Section 4.1 formalizes the joint span detection and technique classification task under the BIO encoding schema and establishes the modernized DeBERTa-CRF architectural framework, contrasting it with traditional CNN-BiLSTM-CRF sequence taggers. Section 4.2 details the structural implementations of our two primary model variants: the two-stage decoupled cascading pipeline (Variation 1) and the 17-class integrated joint tagger (Variation 2). Section 4.3 outlines the non-linguistic stochastic random-guessing baseline utilized to establish an empirical performance floor. Section 4.4 introduces our evaluation framework, detailing the length-adaptive boundary qualification router ($\delta$), the penalized scoring logic, and the three-phase diagnostic audit architecture. Finally, Sections 4.5 and 4.6 present the comparative empirical results and a deep diagnostic synthesis analyzing structural localization, latent semantic signals, and feature dilution across both pipeline variants."

---

## Architectural Approach
The methodology for Task 2 constructs two modelling variations based off an adaptation of the CNN-BiLSTM-CRF framework introduced by Ma and Hovy (2016). 

To start, we need to understand why this foundational framework was so influential. The authors were able to acheive robust performance by leveraging a three-tiered hierarchical processing pipeline:
- A Convolutional Neural Network (CNN) works at the atomic unit, character-level as a localized feature extractor to capture sub-word morphological patterns. 
- A Bidirectional Long Short-Term Memory (Bi-LSTM) network then processes the word sequence in both directions to map long-range contextual dependencies and sentinal context.
- A Conditional Random Field (CRF) decoder evaluates the joint probability of the entire tag sequence, using a learned transition matrix to enforce global structural logic

When applied to the task of propaganda detection, this general-purpose framework offers key theoretical advantages. First, the character-level CNN allows the model to detect morphological and orthographic irregularities common in manipulative language. A common example would be superlative affixes (`-est`, `-st`) used to amplify rhetorical framing, e.g. best, worst, greatest. Second, the Bi-LSTM's contextual sequence representation allows the network to recognize how earlier lexical choices alter the manipulative tone of subsequent words without being immediate neighbours. Finally, if our propaganda snippets are to be modelled using a BIO paradigm then the CRF can enforce transitions from `B-` to `I-`/`O`, or prohibit illegal transitions such as initiating a second `B-` tag mid-span.




## Architectural Ancestry: The Ma and Hovy Baseline

> Merge Architectural Ancestry and Modernized Transformer-CRF Paradigm directly into Methodological Framework

This methodology adapts the architectural lineage of the foundational CNN-BiLSTM-CRF framework introduced by Ma and Hovy (2016). This classical sequence labeling blueprint achieves its end-to-end efficacy by partitioning language analysis across three specialized, hierarchically stacked processing layers:

**Character-Level Convolutional Neural Network (CNN):** Operates as a localized feature extractor that scans the constituent characters of words to isolate sub-word morphological regularities. This layer detects capitalization patterns, prefixes, and suffixes, providing a vital signal for identifying the irregular linguistic and orthographic formatting hypothesized in $H2$

**Bidirectional LSTM (Bi-LSTM):** Processes the sequence of word tokens sequentially from both forward and backward directions. By maintaining dual hidden states, this recurrent network captures sentence-level contextual flow and maps long-range dependencies across the sequence.

**Conditional Random Field (CRF) Decoder:** Functions as the terminal sequence predictor. Instead of calculating isolated token judgments, the CRF layer implements global normalization to evaluate the joint probability of the entire output tag sequence. It utilizes a learned Transition Matrix to enforce structural logic over the predicted labels, systematically preventing illegal sequence breaks (such as a continuation tag I- following an outside tag O)

This classic configuration is uniquely suited to handling the "soft boundary" dilemma inherent in propaganda span identification. The deep recurrent layer identifies high-confidence semantic cues within the core of a manipulative fragment, while the CRF layer utilizes its transition parameters to "knit" those signals back to the highly ambiguous beginning (B-) and trailing edges of the targeted text frame.

---

## Modernized Transformer-CRF Paradigm

To optimize boundary precision and structural resolution, I modernize the Ma and Hovy (2016) pipeline by substituting the sequential and convolutional layers with a deep Transformer encoder (DeBERTa) while keeping the global decoding properties of the terminal CRF layer intact. This structural shift is justified by four concise engineering advantages directly calibrated to the constraints of the propaganda corpus:

1. SentencePiece tokenization completely bypasses the need for a separate character-level CNN. By decomposing rare, out-of-vocabulary (OOV) terms into frequent, universally known subword chunks, the model resolves vocabulary-level data sparsity and eliminates the need for manual feature-extraction networks.
2. LSTMs compress text sequentially, introducing an information bottleneck vulnerable to sequential context decay and recency bias. Conversely, global self-attention calculates a parallel, all-to-all sequence matrix, giving every token a direct, uncompressed line of sight to every other token. This is critical for capturing the abstract, long-range word pairings that denote manipulative rhetorical intent.
3. Training deep recurrent models from scratch on our limited dataset is infeasible due to catastrophic overfitting risks. Utilizing a massive Transformer backbone tapers this constraint by introducing a pre-trained linguistic worldview, which is structurally adapted to our target era via the intermediate Domain Adaptation news corpus (Section 3.5)
4. While LSTMs fuse word semantics and sequence location together, DeBERTa utilizes Disentangled Attention to evaluate content and relative position independently. This decoupled spatial awareness is highly effective for validating the Structural Irregularity Hypothesis ($H2$), allowing the architecture to isolate manipulative phrases where ordinary vocabulary is weaponized purely through anomalous syntactic placement.

---


## Methodological Framework: Modernized Encoder-CRF Tagger
The foundational architecture for Task 2 modernizes the classic sequence labeling pipeline of Ma and Hovy (2016). While traditional implementations stack character-level CNNs, Bi-directional LSTMs, and Linear-Chain Conditional Random Fields (CRFs), our implementation substitutes recurrent and convolutional feature extractors with a contextualized DeBERTa-v3-base Transformer encoder while retaining the linear-chain CRF layer.

┌─────────────────────────────────────────────────────────────────────────┐
│                          Input Sentence Tokens                          │
└────────────────────────────────────┬────────────────────────────────────┘
                                     │
                                     ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                    DeBERTa-v3-base Subword Encoder                      │
└────────────────────────────────────┬────────────────────────────────────┘
                                     │
                 ┌───────────────────┴───────────────────┐
                 ▼                                       ▼
┌─────────────────────────────────┐     ┌─────────────────────────────────┐
│  Variation 1: Two-Stage Tagger  │     │ Variation 2: Joint End-to-End   │
├─────────────────────────────────┤     ├─────────────────────────────────┤
│ Stage 1: 3-Class DeBERTa-CRF    │     │ Single DeBERTa-CRF Tagger       │
│          [B-Prop, I-Prop, O]    │     │ 17-Class BIO Space              │
│                                 │     │ [B-loaded, I-loaded, ..., O]    │
│ Stage 2: Extracted Span Mean-   │     │                                 │
│          Pooled 768D MLP Head   │     │ Viterbi Trellis Backward        │
│          (Predicts 1 of 8 Class)│     │ Decoding                        │
└─────────────────────────────────┘     └─────────────────────────────────┘

This transition directly resolves representation bottlenecks observed in static feature models:
- **Subword Processing:** DeBERTa’s SentencePiece tokenization eliminates out-of-vocabulary (OOV) terms by decomposing rare words into subword units. Subword tags are aligned back to word-level boundaries by assigning the BIO tag to the first subword token and masking non-initial subword transitions during loss computation.
- **Global Self-Attention:** Dynamic self-attention replaces sequential LSTM recurrence, resolving long-range context compression and capturing dependencies across complete sentences.
- **Disentangled Attention:** DeBERTa models token content and relative spatial position on separate vectors, allowing the network to isolate non-compositional syntactic departures characteristic of manipulative rhetoric.

In contrast to Task 1, explicit static auxiliary features (POS and NER tags) are omitted. DeBERTa implicitly models syntactic dependencies and named entities within its self-attention heads. Omitting manual feature concatenation prevents subword alignment bottlenecks and marks a transition to implicit, contextual representation learning.

To resolve the label bias problem inherent in standard local softmax classification (McCallum et al., 2000), a Linear-Chain CRF layer globally decodes sequences (Lafferty et al., 2001). Given sequence contextual hidden states $\mathbf{H} = (\mathbf{h}_1, \mathbf{h}_2, \dots, \mathbf{h}_N)$ from DeBERTa and a candidate tag path $\mathbf{y} = (y_1, y_2, \dots, y_N)$, the CRF calculates a path score $s(\mathbf{H}, \mathbf{y})$:

$$s(\mathbf{H}, \mathbf{y}) = \sum_{i=1}^{N} \mathbf{A}_{y_{i-1}, y_i} + \sum_{i=1}^{N} \mathbf{P}_{i, y_i}$$

where $\mathbf{A}_{y_{i-1}, y_i}$ represents the learnable transition probability from tag $y_{i-1}$ to tag $y_i$, and $\mathbf{P}_{i, y_i}$ denotes the emission logit produced by DeBERTa for tag $y_i$ at position $i$. Optimizing the Negative Log-Likelihood ($\mathcal{L}_{\text{CRF}} = -\log P(\mathbf{y} \mid \mathbf{H})$) suppresses syntactically invalid sequence transitions (e.g., an I- tag directly following an O tag).

---

### 4.2.3 Architecture Variation 1: Decoupled Cascading Pipeline
Architecture Variation 1 adopts a modular, two-stage decoupled pipeline for propaganda detection and classification. Rather than forcing a single network to perform boundary detection and multi-class technique identification simultaneously, Variation 1 separates the objective into two specialized sub-tasks:

1. **Stage 1 (Span Localization):** A 3-class sequence tagger trained exclusively to identify the presence and token boundaries of propagandistic text within full sentences.
2. **Stage 2 (Technique Classification):** A contextualized span-pooled classifier trained to map localized token sequences to one of eight rhetorical techniques.

While this decoupled architecture offers clear conceptual separation and allows each stage to be optimized independently, it introduces a single-point failure bottleneck, where Stage 1 localization errors directly limit downstream classification performance.

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

This sequential execution introduces two severe empirical failure modes that crippled Variation 1's performance

###### 1. Cascading Recall Lock (The Single-Point Bottleneck)
Because Stage 1's span recall was capped at $\sim 32\%$ on the validation set, over two-thirds of active propaganda spans were completely missed during Stage 1 decoding. In a decoupled cascade, any missed span immediately defaults to a False Negative. Stage 2 is never invoked for these instances, permanently blinding the downstream classifier and locking Variation 1's end-to-end recall to 0.1500

##### 2. Feature Dilution via Boundary Offsets
When Stage 1 predicts a span that is slightly misaligned (e.g., predicting "the toxic narrative was" instead of the gold target "toxic narrative"), Stage 2 is forced to mean-pool the core technique tokens alongside neutral background words. Incorporating uninformative background vectors shifts the resulting pooled embedding in feature space, diluting its semantic signal and making it substantially harder for the classification head to assign the correct technique label.

As a direct result of these cascading failure points, Variation 1's end-to-end performance plummeted from its 0.5106 Oracle Ceiling to a terminal 0.1684 Macro-F1, representing a catastrophic localization degradation ($\Delta$) of -0.3422

--- 

### 4.2.4 Variation 2: The Integrated Multi-Class BIO-CRF Model
Architecture Variation 2 addresses the propaganda identification task through a single-stage, end-to-end joint sequence labeling framework. In contrast to cascading or decoupled pipelines that separate span localization from technique classification, Variation 2 unifies boundary detection and 8-way rhetorical technique classification into a single global decoding pass. By learning spatial boundary cues and semantic technique markers simultaneously within a shared representation space, Variation 2 eliminates the compounding error propagation inherent to multi-stage cascades.

#### 1. Unified 17-Class Label Space & Structural Constraints
Variation 2 frames joint span detection and classification as a single-stage sequence tagging problem under an expanded BIO schema. Rather than collapsing labels into a binary indicator, the target label space $\mathcal{Y}_{17}$ incorporates all eight rhetorical techniques directly into the spatial tagset:

$$\mathcal{Y}_{17} = \{\text{O}\} \cup \{\text{B-}k \mid k \in \mathcal{T}\} \cup \{\text{I-}k \mid k \in \mathcal{T}\}$$

Formally, $\mathcal{Y}_{17}$ represents the union of a single background/outside tag (O), eight technique-specific onset tags ($\text{B-}k$), and eight technique-specific continuation tags ($\text{I-}k$) for every technique $k$ in the technique vocabulary $\mathcal{T}$.

To guarantee that the decoder outputs syntactically valid sequences, hard structural transition constraints are enforced inside the linear-chain CRF layer. Unconstrained sequence models often suffer from label bias, predicting invalid sequence transitions such as entering a span directly on an interior tag (O $\to$ I-doubt) or switching techniques mid-span (B-flag_waving $\to$ I-loaded_language). We mask these invalid paths by assigning a heavy negative transition penalty ($-10000.0$) directly to the CRF transition matrix $\mathbf{A}$, effectively reducing the probability of illegal sequence transitions to zero during Viterbi decoding.

> This set-builder notation simply states that the 17-class tagset contains $1$ Outside tag (O), plus $8$ Beginning tags (B-k), plus $8$ Inside tags (I-k) for each technique $k$ in the technique set $\mathcal{T}$.

##### TComplete 17-Class BIO Tagset Mapping (Variation 2)
| Propaganda Technique Label | Beginning Tag (`B-`) | Inside Tag (`I-`) | Outside / Sentinel Tag |
| :--- | :---: | :---: | :---: |
| `flag_waving` | `B-flag_waving` | `I-flag_waving` | `O` |
| `appeal_to_fear_prejudice` | `B-appeal_to_fear_prejudice` | `I-appeal_to_fear_prejudice` | `O` |
| `causal_simplification` | `B-causal_simplification` | `I-causal_simplification` | `O` |
| `doubt` | `B-doubt` | `I-doubt` | `O` |
| `exaggeration,minimisation` | `B-exaggeration,minimisation` | `I-exaggeration,minimisation` | `O` |
| `loaded_language` | `B-loaded_language` | `I-loaded_language` | `O` |
| `name_calling,labeling` | `B-name_calling,labeling` | `I-name_calling,labeling` | `O` |
| `repetition` | `B-repetition` | `I-repetition` | `O` |
---

> Combine the formula, text description, and table into a single cohesive sub-section.

where $\mathcal{T}$ represents the set of eight target propaganda techniques (flag_waving, appeal_to_fear_prejudice, causal_oversimplification, doubt, loaded_language, name_calling,labeling, repetition, and exaggeration,minimisation)

To enforce grammatical and structural validity during sequence decoding, hard BIO transition constraints are baked directly into the model's sequence layer. Specifically, transition penalties ($-\infty$ represented numerically as $-10000.0$) are assigned to illegal state transitions:
1. Invalid Span Entry: Direct transitions from background text (O) to an interior span tag (I-$k$) are strictly forbidden.
2. Mid-Span Technique Switching: Transitions from an active span tag (B-$k_1$ or I-$k_1$) to an interior tag of a different technique (I-$k_2$, where $k_1 \neq k_2$) are forbidden. 

> This is talking about the crf hardcoded rules but we have't really explained that very well.

> Briefly explain why hard penalties ($-10000.0$) are necessary: without them, an unconstrained CRF or linear head can output illegal transitions like O $\to$ I-doubt or B-flag_waving $\to$ I-loaded_language, creating broken span boundaries.

#### 2. Model Architecture & Forward Pass
The network architecture couples a pre-trained Transformer encoder with a Linear-Chain Conditional Random Field (CRF) layer.  

[Input Subword Sequence x]
        │
        ▼
[DeBERTa-v3-xsmall Encoder] ──> Extracts 384-D contextual token representations
        │
        ▼
[Linear Projection Layer]   ──> Projects 384-D states to 17 emission logits
        │
        ▼
[Linear-Chain CRF Layer]    ──> Enforces 17-class BIO transition constraints
        │
        ▼
[Viterbi Path Decoding]     ──> Emits globally optimal tag sequence y*

#### Contextual Subword Encoding
Given an input text sequence, the text is tokenized into $N$ subwords $\mathbf{x} = (x_1, x_2, \dots, x_N)$ using the DeBERTa-v3-xsmall SentencePiece tokenizer. The tokenized sequence is passed through the pre-trained DeBERTa encoder to generate sequence hidden states $\mathbf{H} \in \mathbb{R}^{N \times 384}$:  

$$\mathbf{H} = \text{DeBERTa}(\mathbf{x})$$

#### Emission Projection
A trainable linear projection layer transforms the 384-dimensional contextualized token embeddings into unnormalized emission logits $\mathbf{E} \in \mathbb{R}^{N \times 17}$ across the 17 BIO states: 

$$\mathbf{E}_i = \mathbf{W}_e \mathbf{H}_i + \mathbf{b}_e \quad \text{for } i \in \{1, \dots, N\}$$

where $\mathbf{W}_e \in \mathbb{R}^{17 \times 384}$ and $\mathbf{b}_e \in \mathbb{R}^{17}$

#### Linear-Chain CRF Layer & Global Sequence Decoding
Rather than making independent token-level softmax decisions, the emission matrix $\mathbf{E}$ is fed into a Linear-Chain CRF. The CRF maintains a trainable transition matrix $\mathbf{A} \in \mathbb{R}^{17 \times 17}$, where $\mathbf{A}_{i,j}$ models the probability of transitioning from tag $i$ to tag $j$ across adjacent token positions.

The score of a target tag sequence $\mathbf{y} = (y_1, y_2, \dots, y_N)$ given token sequence $\mathbf{x}$ is defined as the sum of emission and transition scores:

$$S(\mathbf{x}, \mathbf{y}) = \sum_{i=1}^{N} \mathbf{E}_{i, y_i} + \sum_{i=1}^{N-1} \mathbf{A}_{y_i, y_{i+1}}$$

During training, the loss function minimizes the negative log-likelihood of the gold tag sequence $\mathbf{y}^*$

$$\mathcal{L}_{\text{CRF}}(\theta) = -\log P(\mathbf{y}^* \mid \mathbf{x}) = -\log \left( \frac{\exp(S(\mathbf{x}, \mathbf{y}^*))}{\sum_{\mathbf{y}' \in \mathcal{Y}^{N}} \exp(S(\mathbf{x}, \mathbf{y}'))} \right)$$

During inference, global sequence decoding is executed via the Viterbi algorithm to extract the globally optimal tag path $\hat{\mathbf{y}}$:

$$\hat{\mathbf{y}} = \arg\max_{\mathbf{y}' \in \mathcal{Y}^{N}} S(\mathbf{x}, \mathbf{y}')$$

#### 3. The "Breadcrumb Effect" Mechanism
A core architectural advantage of Variation 2 is its ability to establish strong global path dependencies via the 17-class state space—a dynamic referred to as the breadcrumb effect.

In a standard 3-class boundary detector (O, B-Prop, I-Prop), the transition space is collapsed. When DeBERTa emits weak or ambiguous confidence for a boundary token (e.g., distributing probability evenly across O, B-Prop, and I-Prop), the CRF transition matrix lacks semantic context to resolve the ambiguity.

In Variation 2, technique-specific tags act as semantic "breadcrumbs" across sequence space:
- Strong emission signals for highly recognizable lexical markers of a technique (e.g., a confident I-flag_waving tag on central tokens) constrain the allowable global path.
- Because the CRF transition matrix enforces that I-flag_waving must be preceded by B-flag_waving rather than another technique or invalid transition, the Viterbi decoder uses high-confidence interior tokens to "pull" adjacent, weaker token emissions into a spatially coherent span.
- By jointly optimizing boundary identification and 8-way technique classification in a single global decoding pass, Variation 2 reduces hallucinated false positives on background text and protects the system from single-point boundary failures.

#### 4. Hyperparameter Search & Optimization Strategy
To prevent gradient instability when fine-tuning a Transformer backbone alongside a linear projection and CRF head, Variation 2 utilizes differential learning rates via the AdamW optimizer.

##### Search Space & Sweep Setup
A hyperparameter sweep was executed over 5 epochs using a 10% modulo internal validation split across three primary training regimes:  

Parameter ConfigBackbone LR (ηbase​)Heads LR (ηhead​)Batch Size (B)Dev Loss (CRF NLL)
Run 1 (Conservative)1e-5  5e-4  16  3.7016 (Selected)  
Run 2 (Moderate)2e-5  1e-3  16  4.0252  Run 3 (Aggressive)5e-5  2e-3  32  4.2202  

##### Final Model Configuration
The conservative configuration (Run 1) was selected, as it prevented early divergence in the CRF transition matrix and yielded the lowest internal negative log-likelihood. The final model was trained for 10 epochs using simulated batching ($B=16$) via gradient accumulation:  
- Encoder Backbone: DeBERTa-v3-xsmall ($\text{LR} = 1\times 10^{-5}$)
- Projection & CRF Heads: Linear Projection + torchcrf.CRF ($\text{LR} = 5\times 10^{-4}$) 
- Gradient Clipping: Max norm $\le 1.0$ 
- Loss Function: Negative Log-Likelihood (CRF NLL)
- Optimizer: AdamW ($\text{weight\_decay} = 0.01$) 

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




