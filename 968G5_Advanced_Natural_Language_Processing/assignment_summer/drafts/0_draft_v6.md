# 1 Introduction
Propaganda is the deliberate, systematic attempt to shape perceptions, manipulate cognitions, and direct behavior to achieve a response that furthers the desired intent of the propagandist (Jowett & O'Donnell, 2018). It involves managing collective attitudes by manipulating significant symbols (Lasswell, 1927) and using rhetorical devices to bypass rational analysis rather than relying on outright falsehoods. 

Given the velocity and volume of modern digital information, automated detection mechanisms are increasingly vital for maintaining the integrity of online discourse. This report explores automatically identifying propaganda through two core challenges: classifying known propagandistic snippets (Task 1) and jointly identifying manipulative spans and techniques within raw text (Task 2).

---

## 1.1 Problem Outline
Automating detection is challenging because the boundary between legitimate persuasion and manipulative rhetoric is highly subjective (Da San Martino et al., 2019). Historical models classified entire documents (Rashkin et al., 2017) but modern moderation requires detecting localized nuanced rhetorical shifts. Problematically, such detection must overcome significant structural irregularity as propagandists often sacrifice grammatical purity for rhetorical impact, relying on non-compositional multi-word expressions (Sag et al., 2002) and domain specific terms that present severe out-of-vocabulary challenges for traditional NLP.

---

## 1.2 Hypotheses
To guide the methodologies and experimentation, this report evaluates against two hypotheses. The success of H2 can only be achieved by context-aware implementations, whereas H1 can be represented by simple vocabulary-based approaches.

| Hypothesis | Title | Definition | 
| :--- | :--- | :--- | 
| **H1** | Lexical Trigger Hypothesis | Propaganda is defined by specific, emotionally charged trigger words. | 
| **H2** | Structural Irregularity Hypothesis | Propaganda relies on syntactic departures and non-compositionality. |

---

# 2 Related Work: Evolution of NLP Computational Methods
NLP has evolved from symbolic taxonomies like WordNet (Miller, 1995) to statistical representations rooted in the Distributional Hypothesis (Harris, 1954 and Firth, 1957). Addressing data sparsity, static word embeddings like Word2Vec (Mikolov et al., 2013) introduced dense semantic vectors. Static embeddings, however, fail to capture polysemy (Peters et al., 2018) or compositionality (Tai et al., 2015), driving innovation towards contextual sequential modeling through RNNs (Elman, 1990) and LSTMs (Hochreiter and Schmidhuber, 1997). Subsequently, Transformers (Vaswani et al., 2017) and encoders like BERT (Devlin et al., 2019) replaced recurrence with global self-attention. These models dynamically compute contextualized representations across complete sentences, allowing non-compositional phrases to be captured. Finally, contemporary NLP utilizes autoregressive Large Language Models like GPT-3 (Brown et al., 2020), shifting the modeling paradigm from task-specific fine-tuning toward in-context learning (Raffel et al., 2020).

---

# 3. Data Representation & Infrastructure
Section intro; info pertains to all tasks or mutliple approaches.

---

## 3.1 Corpus Overview
This report takes a subset of the Propaganda Techniques Corpus, created by Da San Martino et al. (2020) for SemEval-2020-Task-11 which set out to evaluate pipelines identifying and classifying manipulative spans. Our subset tracks nine propaganda techniques, including a `not_propaganda` class, across `[INSERT_NUM]`rows. The input data is a string formatted sequence of text containing within it two tags (`BOS` and `EOS`). The text between these tags has been identified as one of the 8 positive propaganda labels, while the remaining text provides neutral sentinel context.

##### Table X: Propaganda Technique Definitions According to Da San Martino et al. (2020)
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

## 3.2 Universal Pre-Processing: 
Some pre-processing took place directly on the raw, string formatted text and therefore applies to all methodologies. This mostly pertained to cleaning of digital artificacts which have no reference to the original speaker/authors intent. Also, given the original corpus (Da San Martino et al., 2020) was collected from news articles published between 2017-2019, this pre-procssing had the secondary function of removing any backdoor artifacts which may infer certain publications who are known for the spread of certain propaganda techniques. 

##### Universal Text Pre-processing Steps
| Pipeline Step | Target Pattern / Artifact | Transformation Applied | Methodological Rationale |
| :--- | :--- | :--- | :--- |
| **Whitespace Normalization** | Leading/trailing & inline whitespace | `text.strip()`, `.split()` join | Standardizes token boundaries across raw TSV parses. |
| **Escape Syntax Cleanup** | Python string escapes (`\\'`, `\\"`) | Stripped backslashes | Removes file parsing artifacts. |
| **Quote Normalization** | Curved / Smart quotes (`“`, `”`, `‘`, `’`) | Converted to flat quotes (`"`, `'`) | Unifies quote representation for tokenizers. |
| **Intra-word Apostrophes** | Contractions & Possessives | Collapsed (`won't` $\rightarrow$ `wont`) | Prevents regex tokenizer from fragmenting root words. |
| **Character Artifact Filter** | `\ / [ ] * \| @ space - . : $ # + =` | Replaced with single space | Removes markup symbols and publisher artifacts. |
| **Boundary Guard** | `<BOS>`, `<EOS>` | Standardized padding spaces | Ensures target span delimiters remain uncorrupted. |

---

## 3.3 Data Augmentation: Synthetic Data Enrichement
The training corpus has only `NUM` instances which opens the risk to severe overfitting. To mitigate this, a one-to-one generative data augmentation strategy is implemented to produce synthetic propaganda snippets. SemEval-2020 held several augmentation submission such as (Kranzlein et al., 2020) which relied on token substitution but given the competition was pre-GPT-3 (Brown et al., 2020), there are no contemporary, generative approaches. We build on the competition approaches by building a zero-shot Chain-of-Thought prompting (Kojima et al., 2022 and Wei et al., 2022) on a decoder-only Meta `Llama_3_8B` model. Temperature is set to $0.7$ to encourage syntactic reformulation and semantic drift, while the reasoning steps maintain rhetorical intent. The surrounding sentinel context is left untouched. In the methodology, the deployment of this data is refered to as "Silver", with the training data being "Gold". 

> TODO: Table of Exact Prompt and output structure

---

## 3.4 Feature Tagging 
Across all methodologies, the raw text is first segmented using a whole-word regex tokenizer. Subsequently, each token is mapped to its respective Part-of-Speech (POS) and Named-Entity Recognition (NER) tags. Inspired by the feature engineering submission by Khosla et al. (2020) for SemEval-2020 Task 11, this tagging strategy is implemented to enrich the sparse lexical space with underlying syntactic structures and entity-level target indicators.

Syntactic tagging is conducted using NLTK’s Averaged Perceptron Tagger. To prevent feature fragmentation, the native 56-category Penn Treebank tagset is mapped down to the 12-category Universal POS tagset. Reducing the feature space help to maximise data density within the categories and avoids the risk of frequency being spread to thinly across rare syntactic categories. Similarly, the NER tagging, which is executed using spaCy's `en_core_web_sm` NER pipeline, starts with 19-tag schema but contains a long tail of sparse, low-frequency entity classes which are compressed into a `MISC` slot. This mitigates the signal from high-density entity markers such as political actors, state institutions, and national groups, being diluted by sparse-category noise


##### Table X: Mapped Universal POS Tagset
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

##### Table X: Homogenized Simplified NER Tagset
| Tag | Entity Category | Frequency Strategy | Target Propaganda Signal |
| :---: | :--- | :---: | :--- |
| **`PERSON`** | People, including fictional characters | Preserved | Identifies targets of *Name Calling* & *Ad Hominem*. |
| **`ORG`** | Companies, agencies, institutions | Preserved | Captures organizational targets (*Appeal to Fear*). |
| **`GPE`** | Countries, cities, states | Preserved | High relevance to *Flag Waving* rhetoric. |
| **`NORP`** | Nationalities, religious/political groups | Preserved | Core driver of group-identity manipulation. |
| **`DATE`** / **`TIME`** | Absolute or relative dates/times | Preserved | Identifies temporal framing or urgent calls. |
| **`CARDINAL`** / **`ORDINAL`** | Numbers / Numerals | Preserved | Relates to *Exaggeration / Minimisation* statistics. |
| **`LOC`** | Non-GPE locations (mountain ranges, bodies of water) | Preserved | Geographic framing. |
| **`O`** | Outside any named entity | Preserved | Baseline background token marker. |
| **`MISC`** | `MONEY`, `EVENT`, `PERCENT`, `WORK_OF_ART`, `FAC`, `LAW`, `PRODUCT`, `LANGUAGE`, `QUANTITY` | Homogenized | Aggregates low-frequency entity classes to preserve feature density. |

---

# 4. Task 1: Propaganda Classification
Task 1 is a single-label, multi-class classification problem targeting instances of known but unlabelled propaganda. This task's objective is to benchmark two non-contextual, static feature representation paradigms: high-dimensional sparse representations derived from frequency-based Bag-of-Words (BoW) modeling against low-dimensional, dense representations from pre-trained Word2Vec embeddings.

Given the lack of contextual awareness, this task explicitly evaluates Hypothesis 1 ($H_1$: The Lexical Trigger Hypothesis) only, interrogating whether propaganda can be reliably detected through trigger words.


# 4.1 Baseline & Experimental Floor
To calibrate model performance, an unintelligent random-guessing baseline defines the mathematical lower bound. For an 8-class balanced target distribution, uniform random selection yields an expected accuracy and Macro-F1 floor of $P = \frac{1}{8} = 0.125$ ($12.5\%$). To guarantee reproducibility, the random state is set to: $\text{SEED} = 142$. This seed generation is applied globally covering any of the task's probabilistic processes (Python, NumPy, PyTorch).

---

## 4.2 Methodology & Architecture:

### 4.2.1 Approach 1: Sparse Bag-of-Words (BoW) Vector Representation
By representing text as high-dimensional, orthogonal count vectors, a unigram Bag-of-Words (BoW) model evaluates Hypothesis 1 ($H_1$) in its most rudimentary form. In the context of propaganda, sparse representations allow linear decision boundaries to isolate lexical triggers while minimizing feature contamination from surrounding neutral text.

Given a raw input sentence $S$, a whole-word regex tokenizer parses $S$ into a sequence of $N$ lowercase word and punctuation tokens $T = (t_1, t_2, \dots, t_N)$. Following this, tag sequences for Part-of-Speech (POS) and Named Entity Recognition (NER) are extracted across the identical sequence length $N$:

$$P = (p_1, p_2, \dots, p_N), \quad \text{where } p_i \in \mathcal{P}_{\text{universal}}$$

$$E = (e_1, e_2, \dots, e_N), \quad \text{where } e_i \in \mathcal{E}_{\text{simplified}}$$

<br>

The preliminary phase of the BoW architecture constructs a global term-frequency dictionary $\mathcal{C}_{\text{gold}}$ across the training corpus $\mathcal{D}_{\text{train}}$:
$$\mathcal{C}_{\text{gold}}(w) = \sum_{S \in \mathcal{D}_{\text{train}}} \sum_{t_i \in S} \mathbb{I}(t_i = w)$$

In propaganda corpora, rare singletons/hapax legomena, where $\mathcal{C}_{\text{gold}}(w) = 1$, consist predominantly of specific target entities or niche descriptors. Without counterfactual instances, a single occurrence of a rare political name risks the network memorizing spurious co-occurrences rather than genuine propagandist devices. 

To regularize generalization, all singletons are mapped to an out-of-vocabulary slot ($\text{\_\_UNK\_\_}$). Similarly, ultra-frequent connective words are compiled into a custom stopword list and filtered out, yielding the active vocabulary set $\mathcal{V}_{\text{gold}}$:

$$\mathcal{V}_{\text{gold}} = \{ \text{\_\_UNK\_\_} \} \cup \{ w \in \mathcal{C}_{\text{gold}} \mid \mathcal{C}_{\text{gold}}(w) > 1 \land w \notin \text{Stopwords} \}$$

An active index dictionary then maps each valid term to an orthogonal coordinate axis:

$$\mathcal{I}_{\text{vocab}}: w \mapsto i, \quad w \in \mathcal{V}_{\text{gold}}, \, i \in \{0, 1, \dots, \vert{}\mathcal{V}_{\text{gold}}\vert{} - 1\}$$

To increase data density without expanding the vector space with out-of-domain noise, a second enriched vocabulary ($\mathcal{V}_{\text{silver}}$) is constructed using synthetic LLM snippets ($\mathcal{D}_{\text{silver}}$) to increment existing terms in $\mathcal{C}_{\text{gold}}$:

$$\mathcal{C}_{\text{silver}}(w) = \mathcal{C}_{\text{gold}}(w) + \sum_{S \in \mathcal{D}_{\text{silver}}} \sum_{t_i \in S} \mathbb{I}(t_i = w \land w \in \mathcal{C}_{\text{gold}})$$

This raises isolated singletons ($\mathcal{C}_{\text{gold}}(w) = 1$) past the frequency threshold ($\mathcal{C}_{\text{silver}}(w) > 1$), shifting them from the __UNK__ bucket into dedicated lexical dimensions.

Table X demonstrates vocabulary dimension variability across experiments ($\vert{}\mathcal{V}\vert{} \in [1,483, 4,002]$). "Snippet-Only" experiments cause a fall in dimensions, with the "Gold Baseline" iterations acheiving a $54.6\%$ reduction (from 3,265 down to 1,483), potentially stripping out neutral background prose and intensifying propaganda features. Conversely, Enriched experiments reclaim lost singletons, with the “Silver Enriched, Snippet-Only” experiment decreasing hapax singletons by $45.4\%$ (from 2,051 down to 1,119) compared the Gold Baseline, increasing available dimensions for boundary detection.

A key feature of the pipeline emerges through the chronologically of tag extract occuring prior to  vocabulary filtering. This preserves some level of syntactic (POS) and semantic (NER) context when the token feature is lost to `__UNK__`

For any sequence $S$, token counts, POS counts, and NER counts are mapped into three discrete frequency vectors:

$$\vec{v}_{\text{vocab}}[i] = \sum_{t \in T} \mathbb{I}(\mathcal{I}_{\text{vocab}}(t) = i)$$

$$\vec{v}_{\text{pos}}[j] = \sum_{p \in P} \mathbb{I}(\mathcal{I}_{\text{pos}}(p) = j)$$

$$\vec{v}_{\text{ner}}[k] = \sum_{e \in E} \mathbb{I}(\mathcal{I}_{\text{ner}}(e) = k)$$

Meaning, for example, a reference to a low frequency Proper Noun, is preserved in the $\vec{v}_{\text{ner}}[k]$ vector. This not only retains lost signal but for propaganda acts as a regularizer that encodes the intent of a targeted reference or descriptor but removes the specificity. 

These multi-channel feature vectors are concatenated into a single input tensor $\vec{x}_{\text{input}}$ and passed to the MLP classification head:
$$\vec{x}_{\text{input}} = \left[ \vec{v}_{\text{vocab}} \parallel \vec{v}_{\text{pos}} \parallel \vec{v}_{\text{ner}} \right] \in \mathbb{R}^{|\mathcal{V}| + |\mathcal{P}| + |\mathcal{E}|}$$

While the auxiliary vectors remain strictly invariant across all experiments ($|\mathcal{P}| = 12$ POS tags and $|\mathcal{E}| = 10$ NER tags), the vocabulary vector dynamically scales based on the experimental condition $\vert{}\mathcal{V}\vert{} \in [1,483, 4,002]$ determining the final vector lengths. 

##### Table X: Vocab Experiements
| Experimental Split Condition | Active Vocab Dim ($\|\mathcal{V}\|$) | Hapax / Singletons Cut | Structural POS Dim | Structural NER Dim | Total Input Tensor Dim |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Gold Baseline, Full-Context** | 3,265 | 3,038 | 12 | 10 | **3,287** |
| **Silver Enriched, Full-Context** | 4,002 | 2,301 | 12 | 10 | **4,024** |
| **Gold Baseline, Snippet-Only** | 1,483 | 2,051 | 12 | 10 | **1,505** |
| **Silver Enriched, Snippet-Only** | 2,415 | 1,119 | 12 | 10 | **2,437** |

---

### 4.2.2 Approach 2: Dense Word2Vec (W2V) Vector Representation
Approach 2 benchmarks static continuous word embeddings to evaluate Hypothesis 1 ($H_1$) using continuous vector space geometry.

To mitigate Zipf's Law sparsity on small propaganda corpora, Word2Vec maps semantic similarity into geometric proximity (Firth, 1957; Mikolov et al., 2013). Continuous embeddings perform implicit matrix factorization (Levy & Goldberg, 2014), sharing statistical strength across synonyms. This allows the classifier to recognize alternative wordings and generalize across synonymous rhetorical injections. Given propaganda techniques frequently manifest as localized emotive triggers, Word2Vec's local window optimization provides a superior representation over global co-occurrence models (Baroni et al., 2014).

For these experiments, pre-trained $300$-dimensional Google News embeddings ($E \in \mathbb{R}^{\vert{}V_{\text{google}}\vert{} \times 300}$) are deployed. The vocabulary of this model far exceeds our corpus but to maintain strict experimental control, the lookup space is constrained to the active vocabulary ($\mathcal{V}_{\text{experiement}}$ of the given iteration. Doing this allows us to isolate embedding density as the sole independent variable (Sparse vs Dense). However, it is acknowledged that this nullifies Word2Vec's capacity to generalize by providing context to OOV features. For tokens outside the active vocabulary, we retain the OOV routing mechanism, yielding a normalized scalar ratio $c_{\text{unk}} \in [0, 1]$ to match the embeddings magnitude:

$$c_{\text{unk}} = \frac{1}{N} \sum_{t \in T} \mathbb{I}(t \notin \mathcal{V})$$

Sequence-level composition applies arithmetic mean-pooling over valid active tokens in $T$:

$$\vec{v}_{\text{w2v}} = \begin{cases} \frac{1}{\vert{}T_{\text{valid}}\vert{}} \sum_{t \in T_{\text{valid}}} E(t), & \text{if } \vert{}T_{\text{valid}}\vert{} > 0 \\ \vec{0}_{300}, & \text{otherwise} \end{cases}$$

As vector addition is commutative this approach discards token order and compositional structure entirely. This means W2V's capacity to process the non-compositional syntactic departures prevalent in propaganda is restricted to the signal strength of trigger words and their combinations. While the W2V optimization process is localized and windowed, it produces static embeddings with an infinitely generalized understanding of surroundings.

To assemble $\vec{x}_{\text{input}}$, the tagset vectors ($\vec{v}_{\text{pos}}$ and $\vec{v}_{\text{ner}}$) are $L_1$-normalized into relative probability distributions ($[0, 1]$) prior to concatenation. Again, this aligns the magnitudes with W2V embeddings, preventing unscaled integer counts from dominating loss gradients during backpropagation:

$$\tilde{\vec{v}}_{\text{pos}} = \frac{\vec{v}_{\text{pos}}}{\sum_j \vec{v}_{\text{pos}}[j]}, \quad \tilde{\vec{v}}_{\text{ner}} = \frac{\vec{v}_{\text{ner}}}{\sum_k \vec{v}_{\text{ner}}[k]}$$

The final concatenated input tensor $\vec{x}_{\text{input}}$ represents a $323$-dimensional vector passed directly to the MLP head. In contrast to BoW, the input dimensions are fixed across all experiments:

$$\vec{x}_{\text{input}} = \left[ \vec{v}_{\text{w2v\_300d}} \parallel c_{\text{unk}} \parallel \tilde{\vec{v}}_{\text{pos\_12d}} \parallel \tilde{\vec{v}}_{\text{ner\_10d}} \right] \in \mathbb{R}^{323}$$

##### Table X: Word2Vec Experimental Input Dimensions
| Experimental Split Condition | Vocab Dim ($\|\mathcal{V}\|$) | Hapax/Singletons Cut | Structural POS Dim | Structural NER Dim | Total Input Tensor Dim |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Gold Baseline, Full-Context** | 301 | 3,038 | 12 | 10 | **323** |
| **Silver Enriched, Full-Context** | 301 | 2,301 | 12 | 10 | **323** |
| **Gold Baseline, Snippet-Only** | 301 | 2,051 | 12 | 10 | **323** |
| **Silver Enriched, Snippet-Only** | 301 | 1,119 | 12 | 10 | **323** |

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

## 4.4 Hyperparameter Optimization:

### 4.4.1 Standardized MLP Classification Head
To isolate representation quality from architectural bias, all Task 1 experiments share a standardized multi-layer perceptron classification head. This network structures an input layer of $d_{\text{in}}$ nodes, a single hidden layer of $d_{\text{hidden}}$ nodes, and an 8-node output layer corresponding to the target propaganda techniques.

As each representation paradigm features a distinct semantic dimensionality, the input layer programmatically adjusts to the incoming tensor. Concatenating semantic embeddings with the POS ($\mathbf{x}_{\text{POS}} \in \mathbb{R}^{12}$) and NER ($\mathbf{x}_{\text{NER}} \in \mathbb{R}^{10}$) tag distributions yields a dynamic input dimension:

$$\mathbf{x} = [\mathbf{x}_{\text{sem}} \mathbin{\Vert} \mathbf{x}_{\text{POS}} \mathbin{\Vert} \mathbf{x}_{\text{NER}}]$$

$$d_{\text{in}} = d_{\text{sem}} + P + N$$

Grounded in the Universal Approximation Theorem (Hornik et al., 1989), the single hidden layer acts as a constrained probe to prevent overfitting while resolving non-linear decision boundaries. The forward pass applies a ReLU activation to capture non-linearity, Layer Normalization to stabilize single-instance streaming updates, Dropout regularization, and a final linear projection to output logits $\mathbf{s} \in \mathbb{R}^8$:

$$\mathbf{h} = \text{ReLU}(\mathbf{W}_1 \mathbf{x} + \mathbf{b}_1)$$

$$\mathbf{z} = \text{Dropout}(\text{LayerNorm}(\mathbf{h}), p)$$

$$\mathbf{s} = \mathbf{W}_2 \mathbf{z} + \mathbf{b}_2$$

Cross-Entropy Loss evaluates predicted logits against target labels. Keeping this downstream topology strictly uniform ensures that performance variances isolate representation geometry rather than head capacity.

---

### 4.4.2 Grid Search Strategy & Validation Split
To identify optimal convergence parameters, a systematic Cartesian grid search sweep was conducted over hidden layer capacity ($d_{\text{hidden}}$), initial learning rate ($\eta$), and dropout probability ($p$).

Tuning was executed directly on the primary training set using a deterministic 10% modulo streaming validation split. During training, every tenth instance was held out to compute internal development loss while the remaining 90% drove AdamW optimization updates. Early checkpointing saved model weights achieving the lowest internal development loss across five training epochs.

The grid search revealed that sparse Bag-of-Words architectures overfit rapidly, stabilizing optimal high-dimensional linear boundaries at 3 training epochs with higher dropout ($p = 0.5$) and a lower learning rate ($\eta = 0.0001$). Conversely, dense Word2Vec models converged more gradually, benefiting from 5 full epochs with smaller hidden capacity ($d_{\text{hidden}} = 64, \eta = 0.001, p = 0.3$).

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







Task 2

*Task 2: Build and evaluate either 2 different approaches or at least 2 variations on a single approach to detecting propaganda within a sentence. Your system should identify both the span and the propaganda technique used.*

Task 2 expands the experiment by introducing joint span detection. We frame this objective as a sequence labeling task utilizing the standard BIO (Beginning, Inside, Outside) encoding schema. Neutral sentinel tokens or non-propagandistic sentences are labeled `O`, the initial token of a propaganda span is tagged `B-`, and any subsequent internal tokens are marked `I-`. To capture structural context, each word is processed into a multi-feature representation tuple:

$$\mathbf{x}_i = (\text{Token}_i, \text{POS}_i, \text{NER}_i, \text{BIO}_i)$$

The underlying framework for Task 2 is an adaptation of the foundational CNN-BiLSTM-CRF pipeline (Ma & Hovy, 2016). This architecture partitions language analysis across three stacked layers: a character-level CNN to extract morphological features, a Bi-directional LSTM to capture sequential context, and a Conditional Random Field (CRF) (Lafferty et al., 2001) to evaluate joint sequence probabilities. By enforcing global sequence transition constraints, this CRF globally decodes outputs and resolves the label bias problem (McCallum et al., 2000) while preserving syntactic sequence integrity. 

To optimize boundary precision, we modernize the Ma and Hovy (2016) pipeline by replacing its sequential and convolutional layers with a DeBERTa encoder while retaining the CRF. First, SentencePiece tokenization bypasses character-level CNNs by decomposing OOV terms into sub-units. Second, global self-attention eliminates LSTM bottlenecks, preserving uncompressed, long-range context. Third, utilizing a domain-adapted encoder prevents overfitting on our small corpus. Finally, outlined previously, DeBERTa's disentangled strengths isolates syntactic propagandist anomalies.

The first variation of Task 2, collapses all labels into a three-tag set (`B-Propaganda`, `I-Propaganda`, `O`), maximizing data density for optimizing category-agnostic boundary detection. During inference, sequences labeled entirely `O` are categorized as `not_propaganda`

> after this the sequences with a tagged span (`B-Propaganda`, `I-Propaganda`) need to be routed to a classifer. My original plan had been to take the text to the best performing classifer from task 1. However, I don't feel like the classifers performed that well. That being said, forthe assignment performance doesn't matter. Carrying over a basic BoW model would make the pipeline easy and mitigate word count as I wouldn't have to explain the deficencies of the classifer head again. Plus, a classifer head only applies to one part of the Approach for task 2. Approach 2 doesn't have a classifer so I don't want to spend too much time for it. Alternative, we can re-used the deberta model which is being used for sequence labelling to produce representation for the predicted span which is then passed onto the MLP head. 

However, this approach means the model learns to generalize as a propaganda generalist, potentially overlooking linguistic cues that denote precise span delineations, resulting in less accurate "soft boundary" detection. Also, since the downstream classifier lacks a native `not_propaganda` state, this architecture risks cascading error propagation as any false-positive boundary detection forces an incorrect technique classification.

Note, before moving onto the second variation it would be good to be a handle on the evaluation approach. This is quite a complicated modelling appraoch meaning the eval needs to consider both the span prediction and the actual classifcaiton itselfs. 

Fundamentally, the output objective of T2 is a classification task, identical to T1, hence, the evaluation framework is carried over. The span detection element is integrated into the framework as a qualification router. Span predictions aligning with target bounds pass to the classification evaluator while misaligned spans automatically count as mis-classifications.

Given expert human annotators only align with each other 60% of the time (Da San Martino, 2020), an exact-matching mechanism ignores the linguistic subjectivity of propaganda. Sem-Eval-11 used partial intersection matching but this risks overlooking systematically skewed predictions. Our framework enforces cascading length window-based thresholds to maintain consistency between start and end prediction evaluation. This addresses "soft-boundary" predictions whilst allowing longer snippets proportional tolerance.

However, whilst I have said that the output metric is the same, I believe that its interpretation is vastly different. The performance of the span prediction bubbles upto the terminal metric. Really we are evaluating the span prediction. This is partly why I think we should carry over the BoW from Task 1. Even though the performance is poor, we know what the baseline performance should be. I think the pro and cons of this approach should be considered. 

| Span Length (Tokens) | Boundary Tolerance| Verification Rule |
| :--- | :--- | :--- |
| **$\le 5$** | 0 tokens | Predicted start and end indices must align perfectly with the gold span (Exact Match) |
| **$6\text{--}10$** | $\pm 1$ token | Start and end indices are allowed a 1-token tolerance in either direction |
| **$11\text{--}15$** | $\pm 2$ tokens | Start and end indices are allowed a 2-token tolerance in either direction |
| **$16\text{--}50$** | Step-wise scaling | Tolerance scales linearly, $+1$ token offset per 5 additional tokens. |
| **$> 50$** | $\pm 10$ tokens | Boundary tolerance caps out at a maximum window of 10 tokens. |
---

To bypass cascading errors, V2 evaluates boundaries and techniques simultaneously across a high-resolution 17-class space. While preserving technique-specific signals mitigates "soft boundary" errors, it re-introduces data sparsity and overfitting vulnerabilities. Under this multi-class paradigm, ambiguous boundary tokens are resolved during inference via the CRF's backward-flowing Viterbi trellis "breadcrumb effect":

$$V_t(j) = \max_{i} \left[ V_{t-1}(i) + \mathbf{T}_{i, j} \right] + \mathbf{E}_{t, j}$$

Highly confident technique predictions deeper within a span propagate backward through transition parameters $\mathbf{T}$, "pulling up" preceding boundary tokens into correct `B-` states. Correlating these rhetorical techniques with real-world syntactic boundaries directly tests H1.

> Include table of labels: technique x state, i.e. B-Loaded

Finally, we need a baseline method to benchmark our appraoches against. 

To guarantee our models capture genuine linguistic signals rather than exploiting positional artifacts, a language-blind topological baseline is constructed. Stripped of all semantic and vocabulary data, this framework utilizes a Multi-Layer Perceptron trained on structural features. These features capture the physical layout and rhythm of the text without exposing word meanings.

$$\mathbf{x}_{\text{topo}} = \left[ L_{\text{tokens}}, L_{\text{chars}}, \mu_{\text{len}}, \sigma^2_{\text{len}}, \text{CapRatio}, \text{PuncDensity}, \text{DigitRatio} \right]$$

The model predicts a start ($R_{\text{start}}$) and end ($R_{\text{end}}$) point for the snippet, as well as, a probability that the sequence is `not_propaganda` for which a $P(\text{prop}) < 0.5$ threshold is set. 

$$\hat{\mathbf{y}} = [P(\text{prop}), R_{\text{start}}, R_{\text{end}}]$$

> Table of features. > segment length (tokens count) > token variance (irregular word lenths, rythm, ) > punc density (text inside quotation marks for oversimplification or appeal to fear, or parenthetical statements) > segment length (characters) > caps ratio (noun desnity backdoor) > ratio (av word length) (think slogans for loaded language or flag-waving). 
> feature, sign, justification/proxy

Note, that this is an end to end pipeline that actually does no sequence labelling. It brute forces a span and classifcation prediciton using only structural and topological attributes. I actually think this really exciting and I would love to spend a lot of time on it. However, we need to balance word count and focus. What I would like to do is construct this first, appraoching it as a MVP, making it as simple as possible. If we are able to get really interesting results, I might even replace it as task 1 as it would give us some really interests stuff to write about. For example, is isn't even a sequence labelling model, but produces the same outputs. Additionally, it has no understanding of words and their meanings. Finally, it is oddly similar to variation 2 in the sense that it is an explicity end to end pipeline. 

That being said, the current proposal is probably the most sensible from a rhetorical sense. As we are taking two common variations to a sequence labelling appraoch, i.e. max data density or max labels and comparing. Additionaly, if we took forward the baseline as an appraoch we would need to find a new baseline which is already a tough problem for this task. However, whatever route we take, I think this baseline idea is interesting and gives up some nice substrate to conduct our analysis from. 

Structually, the report itself should follow the structure used for Task 1. 

---







---

# 5. Task 2: Joint Propaganda Span Detection and Classification
Task 2 expands the experimental scope from classifying isolated, pre-delimited snippets to jointly identifying manipulative text boundaries and classifying the specific techniques deployed within raw, full-sentence contexts. We frame this objective as a sequence labeling problem utilizing the standard Beginning, Inside, Outside (BIO) encoding schema. Neutral background tokens and non-propagandistic context are tagged O, the initial subword/token of a propaganda span is tagged B-, and subsequent interior tokens within the span are tagged I-.

## 5.1 Stochastic Random-Guessing Baseline
To establish an absolute mathematical lower bound and guarantee that sequence models learn authentic rhetorical patterns rather than picking up on sequence length heuristics, we implement an unintelligent, probabilistic random-guessing baseline.

For a target sequence comprising $N$ tokens $T = (t_1, t_2, \dots, t_N)$, the baseline operates via a three-step stochastic sampling procedure:

1. Existence Selection: A Bernoulli trial determines whether the sentence contains propaganda with uniform probability $P(\text{prop}) = 0.5$. Sequences assigned $P(\text{prop}) < 0.5$ are output as entirely neutral (O across all $N$ tokens, mapping to not_propaganda).

2. Span Boundary Selection: If propaganda existence is flagged, start and end token indices $(i, j)$ are drawn uniformly at random such that:

$$i \sim \text{Uniform}(1, N), \quad j \sim \text{Uniform}(i, N)$$

yielding a predicted boundary span $\hat{S} = [t_i, \dots, t_j]$.

3. Technique Categorization: A technique label $k$ is drawn uniformly from the 8 positive propaganda categories:

$$k \sim \text{Uniform}(1, 8)$$

To maintain strict reproducibility across dataset splits, the random state is pegged globally to $\text{SEED} = 142$. Evaluating this baseline through our evaluation metric defines the floor against which downstream neural architectures are benchmarked.


## 5.2 Methodological Framework: Modernized Encoder-CRF Tagger
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

## 5.3 Task 2 Experimental Variations

To evaluate how tagset granularity impacts boundary detection and technique classification, Task 2 compares two variations on the DeBERTa-CRF architecture.

### 5.3.1 Variation 1: Two-Stage Pipeline (3-Class Sequence Tagger + Span MLP Classifier)
Variation 1 decouples span boundary localization from technique classification into a sequential two-stage pipeline.
- **Stage 1 (Boundary Tagger):** A 3-class DeBERTa-CRF model predicts over a condensed BIO space: B-Propaganda, I-Propaganda, and O. Aggregating all 8 propaganda techniques into a single generic positive tag maximizes target label density, allowing the CRF transition matrix to optimize purely for span boundary localization. Sequences tagged entirely as O bypass Stage 2 and are marked as not_propaganda.
- **Stage 2 (Technique Classification Head):** For sentences containing a predicted span $\hat{S} = [t_{\text{start}}, \dots, t_{\text{end}}]$, the corresponding DeBERTa token hidden states $\mathbf{h}_i \in \mathbb{R}^{768}$ within the boundary are extracted. Arithmetic mean-pooling compresses these states into a single span representation $\mathbf{v}_{\text{span}} \in \mathbb{R}^{768}$:

$$\mathbf{v}_{\text{span}} = \frac{1}{\vert{}\hat{S}\vert{}} \sum_{i \in \hat{S}} \mathbf{h}_i$$

This pooled vector $\mathbf{v}_{\text{span}}$ passes to an MLP classification head consisting of a linear projection to 256 dimensions, ReLU activation, Layer Normalization, Dropout ($p=0.3$), and a final linear layer outputting logits over the 8 propaganda classes.

During training, Stage 2 is optimized using gold-standard target spans (teacher forcing). At inference, Stage 1 and Stage 2 execute sequentially. While isolating boundary detection simplifies sequence transitions, this pipeline architecture remains vulnerable to cascading error propagation: any false-positive span flagged by Stage 1 forces Stage 2 to assign an incorrect propaganda technique.

### 5.3.2 Variation 2: Joint End-to-End Sequence Tagging (17-Class Space)
Variation 2 eliminates cascading pipeline errors by executing span detection and technique classification simultaneously in a single pass. The model operates across a 17-class BIO tagset comprising 8 B- tags, 8 I- tags, and 1 O tag.

Under this joint paradigm, boundary disambiguation relies on the CRF's backward-flowing Viterbi trellis. During decoding, optimal sequence paths are computed recursively:

$$V_t(j) = \max_{i} \left[ V_{t-1}(i) + \mathbf{A}_{i, j} \right] + \mathbf{P}_{t, j}$$

This structure produces a "breadcrumb effect": high model confidence on technique-specific interior tokens deep within a span (e.g., I-flag_waving) propagates backward through transition parameters $\mathbf{A}$, pulling ambiguous initial boundary tokens into the corresponding B-flag_waving state. Although this eliminates pipeline error cascades, expanding the output space to 17 sparse classes increases susceptibility to overfitting.

Table 6: Complete 17-Class BIO Tagset Mapping (Variation 2)

##### Table 6: Complete 17-Class BIO Tagset Mapping (Variation 2)
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

## 5.4 Evaluation Framework: Cascading Window Qualification Router

Evaluating Task 2 requires assessing both span boundary precision and technique classification accuracy. Because human annotators exhibit subjective boundary disagreement ($\gamma = 0.60$ in Da San Martino et al., 2020), strict exact-matching penalizes minor offset variations. Conversely, simple partial token intersection risks validating severely skewed predictions.

To resolve this, we implement a Cascading Length Window-Based Qualification Router. Boundary tolerance scales dynamically based on gold span token length ($L_{\text{gold}}$). A predicted span $\hat{S} = [\hat{t}_{\text{start}}, \hat{t}_{\text{end}}]$ qualifies for technique classification evaluation if and only if both start and end offsets fall within the allowable token window $\delta(L_{\text{gold}})$ of the gold span $S_{\text{gold}} = [t_{\text{start}}, t_{\text{end}}]$:

$$\vert{}\hat{t}_{\text{start}} - t_{\text{start}}\vert{} \le \delta(L_{\text{gold}}) \quad \text{and} \quad \vert{}\hat{t}_{\text{end}} - t_{\text{end}}\vert{} \le \delta(L_{\text{gold}})$$

##### Table 7: Cascading Length Window Boundary Tolerance Thresholds
| Gold Span Length ($L_{\text{gold}}$ Tokens) | Token Tolerance ($\delta$) | Boundary Qualification Condition |
| :--- | :---: | :--- |
| **$\le 5$ Tokens** | $0$ Tokens | Exact match required ($|\hat{t} - t| = 0$)[cite: 4]. |
| **$6\text{--}10$ Tokens** | $\pm 1$ Token | Start and end offsets allowed 1-token variance[cite: 4]. |
| **$11\text{--}15$ Tokens** | $\pm 2$ Tokens | Start and end offsets allowed 2-token variance[cite: 4]. |
| **$16\text{--}50$ Tokens** | Step-wise ($+1$ per 5 tokens) | Tolerance scales linearly up to $\pm 9$ tokens[cite: 4]. |
| **$> 50$ Tokens** | $\pm 10$ Tokens | Tolerance caps out at a maximum window of 10 tokens[cite: 4]. |

---

### Terminal Metric Formulation and Diagnostic Logging
Once boundary qualification is determined, instances are routed to compute the terminal Macro-$F_1$ score across the 8 target categories: 

1. Qualified Span ($\vert{}\Delta\vert{} \le \delta$):
- If predicted technique $c_{\text{pred}} == c_{\text{gold}}$: True Positive ($\text{TP}$) for $c_{\text{gold}}$.
- If predicted technique $c_{\text{pred}} \neq c_{\text{gold}}$: False Negative ($\text{FN}$) for $c_{\text{gold}}$ and False Positive ($\text{FP}$) for $c_{\text{pred}}$.

2. Disqualified Span ($\vert{}\Delta\vert{} > \delta$ or Missed Span):
- Automatically generates a False Negative ($\text{FN}$) for $c_{\text{gold}}$
- If a hallucinated span was predicted over neutral text, running the extracted representation through the model generates a False Positive ($\text{FP}$) for $c_{\text{pred}}$.

During evaluation, prediction errors are recorded into a structured JSON log (task2_diagnostic_error_log.json). This logs whether misclassifications stem from Boundary Localization Failures (correct technique, offset outside $\delta$) or Technique Misclassification Failures (qualified boundary, wrong technique class), providing the diagnostic visibility needed for qualitative error analysis.

---

### Execution Plan for Code & Experiments

#### Step 1: Data Parsing & BIO Conversion:
- Ingest raw TSV splits (propaganda_train.tsv, propaganda_val.tsv)
- Extract <BOS> and <EOS> delimiters from input text to map character spans to token-level BIO tag sequences.
- Generate two dataset target formats:
    1. 3-Class BIO Dataset (B-Prop, I-Prop, O) for Variation 1.
    2. 17-Class BIO Dataset (B-{technique}, I-{technique}, O) for Variation 2.

#### Step 2: Stochastic Baseline Evaluation:
- Execute the uniform random span and class generator (SEED = 142).
- Run predictions through the Cascading Qualification Router to establish baseline benchmark scores.

#### Step 3: Encoder-CRF Model Training:
- Instantiate microsoft/deberta-v3-base backbones paired with linear-chain CRF decoding layers using PyTorch.
- Variation 1: Train Stage 1 tagger (3-class) using CRF Negative Log-Likelihood. Extract gold training spans, mean-pool subword representations ($\mathbf{v}_{\text{span}} \in \mathbb{R}^{768}$), and train the 8-class Stage 2 MLP head.
- Variation 2: Train the joint 17-class DeBERTa-CRF tagger end-to-end. Decoded sequences are processed via Viterbi trellis extraction during validation and inference.

#### Step 4: Qualification Evaluation & Diagnostic Export:
- Evaluate model outputs against gold test annotations via the Cascading Qualification Router.
- Calculate class-level Precision, Recall, Macro-$F_1$, and export error distributions to task2_diagnostic_error_log.json.

---

Important things to talk about: 
- Hyperparam Optimization and selections
- Distinction between span loss and eval matric
- Subword to bio position mapping using huggingface indexes and offsets
- FN and FP double count for where model get span wrong. # the model predicts a span with didnt qualify as a  # predicted something pred["technique"] on a "neutral" span # TODO: this may be a limitation if the boundary settings are not correct # misclassification: correct token boundaries, wrong label. # boundary failure: span localization missed entirely
- subword token length seqs do not exceed derberta max length
- 

5.1 Context Window Preservation Analysis
A critical bottleneck in Transformer-based sequence labeling is catastrophic truncation. If input texts exceed the architecture's maximum context window, trailing text containing active propaganda spans is permanently severed, corrupting token-to-label alignment.Rather than imposing an arbitrary, aggressive hard-cap (e.g., 256 tokens) that risks dropping samples, an empirical subword distribution analysis was conducted using the DeBERTa-v3-xsmall tokenizer. Across all 2,560 instances, sequence lengths exhibited a mean of $32.95$ subwords and an extreme 99th percentile of $101.8$ subwords. Crucially, the absolute maximum length observed was $168$ tokens. Because $100\%$ of the dataset fell well below DeBERTa's standard capacity of $512$ tokens, preserving the full context window (max_length=512) guaranteed zero information loss and total span preservation during training and evaluation.


```
    def forward(self, input_ids, attention_mask, tags=None):
        outputs = self.deberta(input_ids=input_ids, attention_mask=attention_mask)
        sequence_output = outputs.last_hidden_state     # 384 dims for each token: (batch_size, sequence_length, hidden_size)
        emissions = self.hidden2tag(sequence_output)    
        #   transformer reps into BIO confidence scores
        #   MM across each token: 384-dim token 1 and mutli by linear weights
        #   (batch_size, sequence_length, 17)
        #   outputs 17 raw, unnormalized floating-point numbers (emissions)
        #   deberta strength token belongs to 17 bio classes

        if tags is not None:
            # Training: uses the provided 'tags' to compute the Negative Log-Likelihood Loss
            loss = -self.crf(emissions, tags, mask=attention_mask.byte(), reduction='mean')
            return loss
        else:
            # Inference: Viterbi decoding to predict tags
            return self.crf.decode(emissions, mask=attention_mask.byte())
```


##### Baseline Results. 
- Really low, almost non-existent, most completely wrong
- This is to be extreme as the task is really hard and this random guess is so low
- Only qualify with span is in range + classificaiton is correct. 
- Span range allows toleranace but otherwise a fairly strict eval. No partial credit
- The extreme low result prove that the task is non-trivial
- Provides a baseline which means all learning is genuinely linguistic, there is not scope for luck

---

##### Tagger Analysis
"To isolate whether model failures stemmed from boundary localization or semantic classification, we performed a diagnostic audit on all prediction attempts:Localization Success Rate: Of all $N$ predicted spans, $X\%$ successfully qualified within the cascading tolerance window ($\pm \delta$).Conditional Technique Accuracy: Among the boundary-qualified spans, the model achieved a classification accuracy of $Y\%$ across the 8 propaganda techniques.Error Distribution: Of the total system penalties, $A\%$ were caused by boundary localization failures, $B\%$ by technique misclassifications on valid spans, and $C\%$ by hallucinated spans on neutral text."*

---

#### DEBERTA Hyper Params

Frozen:
- It acts as a static feature extractor. 
- It converts tokens to vectors, but its internal 384-dimensional representations never adapt to the propaganda dataset.
- Very fast, low GPU memory usage, but usually yields lower performance on domain-specific tasks.

Unfrozen:
- In practice for sequence tagging tasks, unfreezing DeBERTa (fine-tuning) is standard.
- To prevent breaking DeBERTa's pretrained knowledge while training the newly initialized hidden2tag and crf layers, it is common to use differential learning rates:
- Unfrozen DeBERTa (Full End-to-End Fine-Tuning)
- It adapts its internal attention weights specifically to recognize linguistic nuances of propaganda (e.g., emotional charge, logical fallacies).

Could talk about the unfronzen as DOMAIN ADPATION

Could be scope for the experiement here.

---

#### Eval TNs

Evaluation & The True Negative (TN) ExclusionIn sequence tagging tasks like propaganda span detection, neutral background tokens (O / not_propaganda) overwhelmingly outnumber active propaganda spans. Including True Negatives in primary evaluation metrics leads to severe class-imbalance distortion; for example, standard accuracy rewarding a dummy model that predicts zero spans with an artificially inflated score:

$$\text{Accuracy} = \frac{\text{TP} + \text{TN}}{\text{TP} + \text{TN} + \text{FP} + \text{FN}}$$

To measure performance strictly on target spans without rewarding trivial background predictions, models are evaluated using the $F_1$ score derived solely from Precision and Recall:

$$\text{Precision} = \frac{\text{TP}}{\text{TP} + \text{FP}}, \quad \text{Recall} = \frac{\text{TP}}{\text{TP} + \text{FN}}$$

$$F_1 = 2 \cdot \frac{\text{Precision} \cdot \text{Recall}}{\text{Precision} + \text{Recall}}$$

Because True Negatives ($\text{TN}$) are omitted from these equations, evaluation pipelines explicitly ignore joint neutral instances (continue) to prevent flooding the metrics engine with non-target tags.

---

#### DeERTA Learning Rate

DeBERTa has already been trained on billions of tokens. Large learning rates (like 1e-3 or 1e-2 used in standard MLPs) cause catastrophic forgetting, destroying DeBERTa's pre-trained language representations and causing training loss to diverge.

When fine-tuning Transformer backbones, standard empirical learning rates fall strictly within the $[1\text{e-}5, 5\text{e-}5]$ range.

As discussed previously, because model.parameters() is used here, $2 \times 10^{-5}$ is applied uniformly across both DeBERTa and the top layers (hidden2tag and crf). A common optimization refinement is using differential learning rates ($2 \times 10^{-5}$ for DeBERTa, $1 \times 10^{-3}$ for the CRF)

---

#### Why Batching is Crucial for DeBERTa + CRF
Running instance-by-instance (batch_size = 1) introduces three major problems:Extreme Noisy Gradients: A single sentence might contain unusual phrasing or an edge case. Updating weights on one sentence at a time causes wild gradient swings, making convergence noisy and unstable.GPU Underutilization (Massive Slowdown): Modern GPUs (or even CPUs) derive their speed from parallel matrix multiplication. Processing 1 sentence at a time leaves 95%+ of your hardware compute power idle.Loss Dynamics: A batch averages the loss across multiple sentences, providing a smooth, reliable gradient direction ($\nabla \mathcal{L}$) towards local minima.

---

#### Sequence Tagger Optimization & Loss Formulation
In joint sequence tagging, the model evaluates span boundaries and propaganda techniques simultaneously by mapping every token to a unified tag within a $17$-class BIO scheme (e.g., B-loaded_language, I-loaded_language, O). Given a sequence of $T$ subwords, DeBERTa and the linear head produce an emissions matrix $\mathbf{E} \in \mathbb{R}^{T \times 17}$, where $\mathbf{E}_{t, y_t}$ represents the unnormalized emission score for tag $y_t$ at position $t$. The CRF layer adds a learned transition matrix $\mathbf{A} \in \mathbb{R}^{17 \times 17}$, where $\mathbf{A}_{y_t, y_{t+1}}$ scores the likelihood of transitioning from tag $y_t$ to $y_{t+1}$. The global score $S(\mathbf{x}, \mathbf{y})$ for a target tag sequence $\mathbf{y}$ is the sum of emissions and transitions across the sentence:

$$S(\mathbf{x}, \mathbf{y}) = \sum_{t=1}^{T} \mathbf{E}_{t, y_t} + \sum_{t=1}^{T-1} \mathbf{A}_{y_t, y_{t+1}}$$

To convert this score into a probability distribution over all possible sequence paths $\mathbf{y}' \in \mathcal{Y}$, the CRF uses the Softmax function. Training optimizes the parameters by minimizing the Negative Log-Likelihood ($\mathcal{L}_{\text{CRF}}$):

$$\mathcal{L}_{\text{CRF}} = -\log P(\mathbf{y} \mid \mathbf{x}) = \log \left( \sum_{\mathbf{y}' \in \mathcal{Y}} \exp(S(\mathbf{x}, \mathbf{y}')) \right) - S(\mathbf{x}, \mathbf{y})$$

Here, the dynamic programming Forward Algorithm efficiently computes the partition function $\sum_{\mathbf{y}' \in \mathcal{Y}} \exp(S(\mathbf{x}, \mathbf{y}'))$. Minimizing $\mathcal{L}_{\text{CRF}}$ simultaneously maximizes the score of the correct span-technique sequence while penalizing invalid transitions and misclassified techniques across alternative paths. Because the loss sums token-level log-likelihoods per sentence and accumulates across the unscaled training corpus, initial loss values appear large but drop sharply as transition constraints are learned.

---

#### Task 2 Regularization & Optimization Stabilization

To prevent overfitting and maintain generalization during end-to-end fine-tuning, Task 2 incorporates regularization across the optimization, architectural, and structural levels. At the optimization level, gradient clipping ($\text{max\_norm}=1.0$) constrains backpropagation updates to prevent gradient explosion and parameter instability. To safeguard pre-trained linguistic knowledge, differential learning rates apply a conservative $2 \times 10^{-5}$ update rate to the DeBERTa backbone—preventing catastrophic forgetting—while allowing top classification layers to adapt rapidly. Structurally, the Linear-Chain CRF acts as a sequence-level regularizer by learning a $17 \times 17$ transition matrix that penalizes illegal tag sequences (such as transitioning directly from O to I-loaded_language), thereby constraining the output search space to valid span structures. Finally, built-in attention dropout within the DeBERTa backbone randomly deactivates neural connections during training passes to prevent subword feature co-adaptation.

---

#### Constrained CRF Transition Matrix Initialization

To enforce BIO sequence grammar directly within the Linear-Chain CRF, we pre-initialized its trainable transition matrix $\mathbf{A} \in \mathbb{R}^{17 \times 17}$ with hard structural constraints. Specifically, transitions originating from neutral text (O) directly into continuation tags (I-technique), as well as mid-span transitions between distinct technique types, were manually set to a large negative score ($-10\,000.0$) prior to model fine-tuning. In both training and Viterbi decoding, this penalty scales candidate sequence path scores such that illegal transitions receive a probability of virtually zero ($e^{-10000} \approx 0$). Consequently, the model is mathematically forced to initiate every predicted propaganda span strictly through a B- tag, eliminating orphaned I- sequences and ensuring output predictions conform to valid span boundaries

---

#### Why Epochs Aren't Typically Included in Hyperparameter Search Grids

In machine learning workflows, the number of epochs is rarely included in hyperparameter search grids because it simply measures time spent in optimization rather than controlling how the model learns. Treating epochs as a fixed variable in a search grid is largely redundant because Early Stopping dynamically tracks validation metrics (such as Validation Loss or Macro-$F_1$) to automatically halt training and save the optimal model checkpoint at the exact moment performance peaks. Furthermore, required epoch counts are strongly dependent downstream variables dictated by core hyperparameters like learning rate and batch size—meaning a fixed epoch limit suited for one trial might heavily underfit or overfit another. Relying on Early Stopping across trials instead of grid-searching epoch counts avoids wasting compute cycles on degraded iterations and allows the training process to halt as soon as convergence is reached.

---

#### Constraining Inter-Technique Transitions in Multi-Class BIO Tagging

While pre-initializing the CRF transition matrix $\mathbf{A} \in \mathbb{R}^{17 \times 17}$ to penalize $\text{O} \to \text{I-technique}$ transitions prevents orphaned continuation tags, homogeneous single-span datasets require an additional structural constraint to prevent mid-sequence technique drift. Without explicit restrictions, strong token-level emission logits from the DeBERTa backbone can overpower weak initial transition penalties, causing the Viterbi decoder to prematurely jump between distinct technique tags mid-span (e.g., $\text{I-doubt} \to \text{I-flag\_waving}$). To guarantee absolute sequence consistency, we enforce a strict technique-continuity rule directly within the CRF transition matrix by assigning a $-10\,000.0$ penalty to any inter-technique transition where $\text{technique}_A \neq \text{technique}_B$. While DeBERTa continues to output unconstrained contextual score distributions across all tags, this modification strictly restricts the CRF's decoding search space, ensuring that every predicted span maintains a single, unbroken technique label from its initial $\text{B-}$ tag through to its $\text{O}$ termination.

---

#### Task 2 Structure

This half of the project is much more complex and involved modelling. Could take up huge amounts of the word count if trying to analysis seperately. 

Structure the project as: Baseline to set the scene, Var2 (Integrated) as the main approach. Explain most of the details and justifications based on this impleentation

Var1, seperated, is framed as an extension as Var2. Whilst less grandular in the label portion is is an ensemble appraoch so more complicated. 

Compute Eval and Analysus on Var2 and repeat on Var1 to compare differences. 

---

#### Hyperparameter Sweep Considerations for Variation 2

To optimize the 17-class joint DeBERTa-CRF tagger while respecting strict compute constraints, we structured a minimal fidelity-based search space evaluated over 5 epochs. Given that transformer fine-tuning for sequence labeling exhibits high sensitivity to optimization dynamics, the sweep tests three distinct configurations—Conservative, Moderate, and Aggressive—varying the backbone learning rate ($1\times10^{-5}$ to $5\times10^{-5}$), linear projection and CRF head learning rates ($5\times10^{-4}$ to $2\times10^{-3}$), and simulated batch sizes via gradient accumulation ($16$ to $32$). Restricting the sweep horizon to 5 epochs provides sufficient iterations for both DeBERTa’s contextual representations and the constrained $17\times17$ CRF transition matrix to stabilize, allowing us to accurately determine the top-performing learning rate profile based on Validation Macro-$F_1$ before scaling the optimal configuration to a full 10-epoch training run. 

- Run 1 (Conservative): 1e-5 ($0.00001$)
- Run 2 (Moderate): 2e-5 ($0.00002$)
- Run 3 (Aggressive): 5e-5 ($0.00005$)

Notice how your sweep pairs the backbone LR with significantly higher head LRs ($5\text{e-}4\text{--}2\text{e-}3$)
This $1:50$ ratio between the backbone and head learning rates is optimal because:
- The Heads start from scratch: The linear projection layer and CRF transition matrix are initialized with random noise/penalties, so they need large gradient steps to quickly learn tag rules.
- The Backbone is pre-trained: DeBERTa only needs minor, delicate adjustments to align its features with the CRF emissions.


---

#### Training Loss Function

To train the joint DeBERTa-CRF architecture, the loss function evaluates sequence-level probabilities rather than independent, token-level classifications. During the forward pass, DeBERTa extracts contextual token embeddings that a linear projection layer converts into raw emission scores $\mathbf{E} \in \mathbb{R}^{T \times 17}$ for each token across all 17 BIO tags. The Linear-Chain CRF then computes the unnormalized joint score for the gold-standard tag path $\mathbf{y}$ by summing these token emissions with the transition scores from its constrained parameter matrix $\mathbf{A} \in \mathbb{R}^{17 \times 17}$. To minimize total error, the model computes the Negative Log-Likelihood (NLL) of the correct tag sequence: 

$$\mathcal{L}_{\text{CRF}} = -\log P(\mathbf{y} \mid \mathbf{X}) = -\left( \text{Score}(\mathbf{X}, \mathbf{y}) - \log \sum_{\mathbf{y}' \in \mathbf{Y}} \exp(\text{Score}(\mathbf{X}, \mathbf{y}')) \right)$$

where the partition function (the denominator sum over all valid sequences $\mathbf{Y}$) is efficiently calculated using the Forward Algorithm. During backpropagation, this NLL loss penalizes both weak token emissions from DeBERTa and invalid sequential transitions, dynamically driving gradient updates back through both the CRF transition matrix and the transformer backbone simultaneously. 

we are calculating the Negative Log-Likelihood (NLL) of the correct (gold) tag path compared to all possible paths.

The Score of any specific tag path $\mathbf{y}$ across a sentence is simply a single number calculated by summing two things together:

$$\text{Score}(\text{Sentence}, \text{Path}) = \sum \text{Token Emissions} + \sum \text{CRF Transition Scores}$$

Token Emissions (from DeBERTa + Linear Head): How strongly DeBERTa feels a specific token (e.g., token #4) belongs to a specific tag

Transition Scores (from CRF Matrix): How likely it is to move from one tag to another (e.g., moving from B-doubt to I-doubt has a high score; moving from O to I-doubt has a score of $-10\,000.0$)

In log-space math, subtracting two log-values is the exact same thing as dividing two raw probabilities:

$$\log \left( \frac{A}{B} \right) = \log(A) - \log(B)$$

So when the loss equation writes:

$$\mathcal{L}_{\text{CRF}} = - \Big( \underbrace{\text{Score}(\mathbf{X}, \mathbf{y}_{\text{gold}})}_{\text{Numerator: Gold Path Score}} - \underbrace{\log \sum_{\mathbf{y}'} \exp(\text{Score}(\mathbf{X}, \mathbf{y}'))}_{\text{Denominator: Log-Sum of ALL Possible Paths}} \Big)$$

It is literally calculating:

$$\mathcal{L}_{\text{CRF}} = -\log \left( \frac{\text{Probability of the Gold Path}}{\text{Sum of Probabilities of ALL Possible Tag Combinations}} \right)$$

1. Gold Path Score: The model calculates how good the true target path looks using DeBERTa's emissions and the CRF's transitions.  
2. All Paths Score (Partition Function): The CRF uses the Forward Algorithm to sum up the scores of every conceivable path combination (valid or invalid).  
3. The Subtraction: By taking $\text{Score}_{\text{gold}} - \text{Score}_{\text{all}}$, the loss calculates the exact probability percentage assigned to the gold path.
4. Optimization Goal: Backpropagation tries to make the Gold Path Score as high as possible while pushing down the scores of all wrong paths!

---

#### Justification for a Closed-World 8-Class Formulation

In designing the classification head for Variation 1, we deliberately restrict the taxonomy to a closed-world assumption of 8 distinct propaganda techniques, omitting an explicit not_propaganda (background/null) class. This architectural choice is driven by two theoretical and computational safeguards. First, introducing a background class creates severe semantic "weight-muddying." Because background text is inherently diverse, unstructured, and non-uniform, forcing the network to optimize gradients against a catch-all category directly conflicts with the crisp, mutually exclusive boundaries required for the 8 specific propaganda techniques, ultimately degrading feature representation learning. Second, and more importantly, the responsibility of identifying background text is already handled upstream by our 3-class boundary head (O, B-Prop, I-Prop).

By separating the sequence segmentation task (identifying where propaganda occurs via the boundary CRF) from the categorical identification task (identifying what technique it is via the 8-class MLP head), background suppression is mathematically enforced through soft-broadcast composition before ever reaching the CRF. When the boundary head assigns a token to the O (background) state, its high negative boundary scores effectively neutralize any active class outputs from the MLP head. This decoupled design keeps the MLP's decision space clean, specialized, and immune to the class-imbalance and gradient-conflict issues typical of open-world background classification.

---

#### Training the classifer head
Indirect Supervision via Global Sequence Loss in Dual-Head Architectures

In our Variation 1 dual-head architecture, the 8-class technique MLP head is trained without direct access to isolated token-level technique labels. Instead, it receives supervision indirectly through the unified 17-class sequence-level Negative Log-Likelihood (NLL) loss. During training, when the final Viterbi decoding path deviates from the gold-standard sequence, the global loss generates gradient signals that propagate backward through our broadcast addition step. This indirect feedback instructs the MLP head to adjust its internal weights so that its 8-class technique logits align with the true underlying propaganda categories. Consequently, the classification head learns its specialized tasks cooperatively, guided by the boundary head's localization anchor and optimized via the global sequence-level objective.

---

#### Justification for Hyperparameter Transferability
Carrying over the identical hyperparameter configuration (Backbone LR: $1\times10^{-5}$, Heads LR: $5\times10^{-4}$, and Batch Size: $16$) from Variation 2 to Variation 1 is methodologically justified by our shared architectural and optimization design. Because both models utilize the same pre-trained DeBERTa-v3-xsmall backbone, they share identical fine-tuning dynamics, requiring a conservative backbone learning rate to preserve pre-trained linguistic representations while allowing larger gradient steps for randomly initialized heads. Furthermore, because Variation 1's dual-head outputs are mathematically compiled into a 17-class BIO tensor that optimizes against the exact same Linear-Chain CRF loss function, the gradient backpropagation mechanics remain constant. Most importantly, holding these parameters fixed establishes a rigorous, controlled experimental framework, ensuring that any performance divergences between the two models stem solely from structural distinctions rather than optimization bias. 

> While a localized hyperparameter search for Variation 1 could theoretically optimize its dual-head capacity, holding the configuration strictly constant isolates the architectural mechanics as the sole independent variable, ensuring that any performance delta reflects true structural differences rather than tuning bias.

---


##### Random Baseline Analysis; too complex

- Demonstate that a random guess might be able to guess the technqiue. 
- even this is a conditional guess. If less than prop, then random guess on 8 techniques 
- (put together formula for this)
- Work out if conditional makes it better than random as condition is based on training split


- However, demonstate that span element is just too advances for random guessing. 
- Probably no matches but even if it did match is needs to pass the conditional guess from above
- Try and put together the formula that dictates span guess + condition technique guess

---

##### Linear Merge Option

The choice to retain a unified 17-class CRF is crucial because it preserves strict sequence-level BIO constraints across the entire dataset without decoupling the boundary detection and technique classification tasks. While multi-task learning or cascading pipelines split these responsibilities into separate, decoupled stages, maintaining a joint 17-class tagset forces the model to learn both where a propaganda span begins and ends and what specific technique it represents within a single sequence decoding framework.

To explore alternative ways of merging these tasks while still keeping the end-to-end 17-class CRF pipeline, you can replace Variation 1's rigid additive gate with a concatenation and linear projection (late fusion) approach. In this setup, the outputs of the boundary and technique heads are concatenated and passed through a trainable linear layer to map them into the 17-class emission space. Because this introduces learnable weight parameters rather than a fixed mathematical sum, backpropagation flows seamlessly from the CRF loss through the linear projection and splits across both heads simultaneously, allowing the network to dynamically learn how to combine the features end-to-end.

---

#### Hyper Sweep for Var 1
In this hyperparameter optimization pass for Variation 1, we addressed a core architectural asymmetry: while a standard linear projection head applies a single layer of transformations, our dual-head setup combines a shallow 3-class boundary projection with a deeper, multi-layer 8-class technique MLP (384 -> 64 -> 8). Treating both heads under a single unified learning rate forces components with different model capacities and convergence dynamics to update at the exact same velocity. To resolve the observed diagnostic failure—where the model successfully localized spans but misclassified techniques—we decoupled the classification layers into independent optimizer parameter groups.

We designed a random search hyperparameter sweep targeting three critical levers: boundary_lr, technique_lr, and technique_dropout. By decoupling boundary_lr (tied to the CRF transition matrix) from technique_lr, we allowed the deeper MLP to step at a different rate than the boundary detector, preventing one head from dominating or destabilizing the additive broadcast join (B_prop + Tech). Furthermore, introducing an adjustable dropout rate directly into the technique MLP provided structural regularization against overfitting on our subset data. The backbone DeBERTa learning rate was held constant at a conservative 1e-5 to protect pre-trained contextual representations.

To ensure computational efficiency without sacrificing evaluation integrity, the sweep was executed across a 10% modulo validation split (idx % 10 == 0) generated deterministically from the training set, running between 3 and 5 epochs per trial. This rapid proxy evaluation provided a reliable signal on head synchronization and generalization ability, allowing us to isolate the optimal learning rate ratio and dropout severity needed to lift multi-class F1 performance before committing to a full-scale training run.

> did a random sweep of 6 instead of full 80 perms. logical grid setup mitigate this parsesness. well specificed params

The theory behind assigning a higher learning rate to the technique head stems directly from the asymmetry in architectural capacity and learning objectives between the two components. While the boundary head is a shallow linear layer whose primary role is to detect coarse-grained span boundaries (O, B, I) using well-aligned pre-trained features, the technique head is a deeper, multi-layer MLP (384 -> 64 -> 8) with non-linear activation functions that must learn the subtle linguistic nuances of eight distinct propaganda classes entirely from scratch. Because this multi-layer structure requires a larger step size to escape flat optimization landscapes and make meaningful progress, a higher learning rate gives the technique classifier the necessary momentum to adapt, preventing it from lagging behind the already-competent boundary detector.

---

#### DeCoupling Var 1

The decision to transition Variation 1 from a single-stage, joint additive CRF into a decoupled two-stage cascading pipeline marks a critical evolution in our system architecture. Initially, Variation 1 sought to perform joint span localization and fine-grained technique classification within a unified 17-class CRF by adding the logits of a 3-class boundary head and an 8-class technique MLP. While this joint setup was theoretical and mathematically appealing—preserving a uniform 17-class CRF across all experimental variations and preventing cascading exposure bias—empirical validation revealed severe optimization pathologies. Joint decoding suffered from destructive gradient interference, where misclassifications in the deeper technique MLP generated noisy negative logits that depressed the emission matrix, causing the CRF’s Viterbi decoder to collapse into predicting background noise (O) across entire sequences.

To resolve these optimization bottlenecks, we decoupled the architecture into two specialized, single-task stages. Stage 1 operates as a dedicated span localization model utilizing a 3-class CRF (O, B-propaganda, I-propaganda). By stripping away the multi-class technique assignment, Stage 1 removes over 80% of the tagset complexity and label imbalance, allowing the sequence decoder to focus entirely on structural boundary rules and span recall. Stage 2 functions as an 8-class text classification model trained offline directly on gold-annotated propaganda spans. During inference, any span extracted by Stage 1 is sliced from the original context and passed to Stage 2, which leverages pooled span-level representations rather than unpooled, token-level hidden states.

This decoupled design addresses the fundamental representation misalignment of the joint approach. Propaganda techniques such as Causal Oversimplification or Appeal to Authority are inherently span-level semantic phenomena that cannot be accurately resolved at the individual token level. Feeding explicit text chunks into a dedicated classifier mirrors the strength of sentence-level models while providing the technique head with complete contextual focus.

While a cascading pipeline accepts the trade-off of one-way error propagation—where Stage 1 recall failures prevent Stage 2 from evaluating a missed span—this risk is vastly outweighed by the elimination of joint gradient conflicts. Decoupling the pipeline allows each network to optimize 100% of its parameter capacity on its respective sub-task, transforming an unstable joint optimization landscape into a robust, high-performing NLP system.

---

#### Var 1 Classifer Eval Upper Benchmark
"To quantify the impact of span localization errors on overall system performance, we established an Oracle Baseline by evaluating the Stage 2 DeBERTa classifier exclusively on gold-standard validation spans. The Oracle achieved an upper-bound Macro-F1 score of 0.5840, confirming that pooled subword representations effectively capture nuanced propaganda techniques when boundary noise is absent. When deployed as an end-to-end cascade with the Stage 1 3-class boundary detector, system performance dropped to 0.3120 Macro-F1 ($\Delta_{\text{degradation}} = -0.2720$). This 46.5% performance degradation is directly attributable to Stage 1 recall failures—where missed span boundaries prevent Stage 2 from evaluating valid text chunks—and empirical boundary drift disqualifying otherwise accurate technique predictions."

No Hyperparam but this is fine as param are theoretically sound and it is benchmark accross all exerpeiemts

---

#### Var 1 Span Hyperparameters:

Carrying over Variation 2’s optimal parameters into Stage 1 provided a convenient baseline, but it ignores a fundamental shift in the model's underlying learning landscape. By simplifying the task from a 17-class joint space down to a 3-class boundary tagset (O, B-Propaganda, I-Propaganda), over 80% of the class imbalance and label confusion are eliminated. In this streamlined structural localization setting, the $3 \times 3$ CRF transition matrix converges rapidly, shifting the primary learning bottleneck to DeBERTa’s ability to refine its subword representations for boundary discrimination. Consequently, the conservative learning rates and epoch counts required to stabilize the complex Variation 2 architecture likely underfit or over-regularize Stage 1. Conducting a dedicated Stage 1 hyperparameter sweep—specifically targeting the backbone-to-head learning rate ratio (backbone_lr vs. heads_lr) and batch size—is necessary to unlock the full recall potential of the standalone span detector before chaining it into the final cascading pipeline. 

---

#### Var 1 Sweep, Recall:

Action Plan: Executing the Stage 1 Sweep
Given your results, your primary tuning objective should be maximizing Span Recall without tanking Precision too severely.

Run the 9-trial grid sweep we discussed earlier (fixed batch size = 16, exploring 3 backbone LRs and 3 head LRs) using evaluate_stage1_span_detector as your fitness function. When you evaluate the trial models, look specifically for a configuration where Span Recall jumps above 0.50 to 0.60, even if precision drops slightly. In propaganda detection, catching more candidate windows is usually better because Stage 2 can filter out false positives more effectively than it can recover missed text.


---

#### Task 2: Analysis


```Task2Evaluator, evaluate_predictions()```
This method takes in lists of the gold and predicted data with the latter in the form `{"span": (start_idx, end_idx), "technique": "doubt"}`. It produces `y_true, y_pred` which are two lists compiled of `TP`, `FP`, `TN`, `FN`. (Not TN as it isn't a part of F1 calc). From this, the lists are plugged into `precision_recall_fscore_support` and `classification_report` to compute the benchmark metrics and a per-class breakdown. This pertains to our terminal metrics and the basis for model seleciton. However, robust analysis requires a more grangular insight. 

Our evaluation method is end-to-end meaning the span prediction is inclusive of the output metric. F1, Prec or Recall do note have granular insight into the relationship between the router and classifer. For example, if a span failed, it defaults as a `not_propganda` based on the evaulation framework. However, in practice we still computed a technique. It would be good to understand what % of failed spans, that had posible gold label, where still predicted correctly by the model. If the model was still above to comfortably predict using (partially) wrong then we could say the tolerance parameters were wrong and that the H1 is much stronger than we thought. This information is in our error logging system. 

In this paradigm we are looking are subset, i.e. instances that disqualified the router. If using F-1 we would call this condition F-1. However, this can be wildly misleading as the model can introduce bias into the subset. Therefore, accuracy is actually the most honest metric. By definition, the routing mechanism is focusing on propaganda instances and therefore filtering out the dominate not_propaganda class which was skewing the data before, hence, accuracy is a good metric for a balance dataset. 

Both technqiues produce a span, so the first thing to do in the results analysis is to check the qualification breakdown
- How many completely missed a span when they should have predicted one? This is import as it is likely caused by the amount of 'O' tags in the data
- The next is how many predicted a span but failed on the boundaries? The different between 3 and 17 will be interesting due the differences in data density, is one more accuracy? This could also be extensed to look at the range of wrongness, are they only just missing out or completely wrong?
- The next is how many predicted a span when there wasn't one? 
- Finally, the pipeline would develop into the composition of results for qualifying spans. In Var1 we have an upper baseline for perfect qualifer, i.e. the raw MLP head. Var1 should closely follow this in terms of its predictions on correctly qualifying instances. It wil be much more interesting to look at Var2 here, does the integrated approach impact technqiue classifcation in the isolated, qualifying subset?
- And an option peice of analysis, lets look at those spans that were predicted but failed the tolerance. If they are still able to predict the right label with an offset span then this points to the original issue that human annotators dont precisely agree on the bounds, meaning the signal might be in the span but the boundaries not truely accurate

All of these should be computed on an entire dataset level first. We will begin to scope down into class level breakdown if there is an interesting finding as the dataset elvel. 

---

Whilst the hyperparameter sweep is running, I am thinking about the analysis that I can conduct for this task 2. It should be noted that we have the evaluation metrics: F1, Recall and Precision but these are the final terminal metrics, it tells use performance but it doesn't give use granular diagnostic insight. For that I have put together this flow of ideas. It essentially focuses on the relationship between the span detector and router and the classier. Note, that for the classier, we have the true upper bound from the MLP classier trained on snippets. It shouldn't be the case that we can exceed this. However, any reduction in performance compared to this benchmark should be considered the fault of the span detector. A perfect span detector will mean the classifer performs how it did in training. The detector can let down the pipeline in a few ways: missed spans completely, failed the tolerance bounds and hallucinating spans where there isn't any. Missed and failed bounds mean the classier does not get a chance to execute and default as false negative. Halucinated spans force the classier to predict the impossible creating a false positive. Additionally, there is aspect of non-perfect qualify predictions, though I don't see this being too much of an issue. Ultimately, whilst the terminal metrics look like classification evaluations, they are entirely representative of the the detector performance as have the classifer upper bound to work from: 

---

**Step 1: Pure Detector Analysis:**
Audit 640 validation instances
1. Confirm the True Negative rate: not_propaganda $\to$ Model predicted no span.
2. Complete Miss, False Negative: Gold is active propaganda $\to$ Model predicted no span. The classifier never got to run.
3. Hallucinated Span, False Positive: Gold is not_propaganda $\to$ Model predicted a span. The classifier was forced to predict one of the 8 techniques on background noise.
4. Disqualified Boundary (Double Penalty - FP + FN): Gold is active propaganda $\to$ Model predicted a span, but missed the $\delta$-tolerance window.
5. Qualified Boundary (Successful Route - TP/FP): Gold is active propaganda $\to$ Model predicted a span within the $\delta$-tolerance window. Classifer in action, could stil get it wrong though. 

Key Insight:
- We want to see how 3 vs 17 perform in each. Does either have strengths or weaknesses. 
- A big focus on Complete Miss (FN), 'O' is the dominate feature, it could be swmamping the model and tricking it into overpredicting no span. 

---

**Step 2: Disqualified by Classifed**
In propaganda annotation, human inter-annotator agreement on exact character boundaries is historically much lower than agreement on which technique is present.

We want to breakdown the performance of predicted but disqualifed boundaries. If the model is still able to predict any then this points to boundary mistakes. The toleroence mechanism could have been tweaked here. 

---

**Step 3: Qualifed Performance**
These are the spans where the localization router did its job correctly and handed a valid window to the classifier. We have the upper bound of the classifers potential using perfectly routed spans. 

Var1 should track closely to this upper bound based on the instances it gets to compute given it is the same classifer, through data scarcity may impact variance wildly. Converesly differences could be due to spatial offsets in the predictions, i.e. within olerance but not perfact. 

Var2 is much more interesting as we are analysing whether joint optimization helps or hurts. Does forcing the backbone to learn boundaries and 8-way classification simultaneously degrade semantic accuracy? A degregation in performance could be consdiered "Task Iterference"

---

#### Task 2 Results

While decoupling span localization from technique classification in Variation 1 appears theoretically cleaner, the empirical evaluation demonstrates that it introduces a severe pipeline bottleneck. The Stage 2 classifier establishes a strong theoretical ceiling of 0.5106 Macro-F1 when provided with perfect gold boundaries. However, when deployed end-to-end with the Stage 1 span detector, performance plummets to 0.1684 Macro-F1, representing a catastrophic localization degradation ($\Delta$) of -0.3422. Because the Stage 1 detector captured only roughly $32\%$ of true propaganda spans (Span Recall: 0.3204), the downstream classifier was completely blinded to over two-thirds of active targets. In a decoupled cascade, any boundary failure or missed span defaults directly to a False Negative, permanently locking the end-to-end recall to a sub-optimal 0.1500.

In contrast, the 17-Class Integrated Joint Tagger (Variation 2) avoids this error propagation, outperforming the decoupled cascade with an end-to-end 0.2034 Macro-F1 and achieving a vastly superior Macro Precision of 0.2914 (compared to Variation 1's 0.2000). The underlying mechanism driving Variation 2's superior performance is the structural synergy between the joint BIO tagset, the Linear-Chain CRF, and the Viterbi decoding algorithm—a dynamic referred to as the "breadcrumb effect."

In Variation 1's Stage 1 tagger, the CRF only observes coarse binary transitions (O, B-Propaganda, I-Propaganda), forcing it to learn boundary decisions without any semantic understanding of what type of propaganda is present. Conversely, Variation 2 enriches every token with fine-grained technique identity (B-loaded_language, I-loaded_language, etc.). During training, the CRF transition matrix learns hard grammatical and stylistic constraints across all 17 states (such as enforcing that a B-doubt token cannot transition into an I-flag_waving token).

During inference, these technique-specific tags act as semantic "breadcrumbs" across sequence space. When DeBERTa emits weak local confidence for a boundary, the Viterbi algorithm does not evaluate localization in a vacuum. Instead, it evaluates the global probability of the entire tag sequence. Strong emission signals for a distinct technique (such as highly recognizable Flag-Waving lexical markers) help the Viterbi decoder "pull" adjacent, weaker token emissions into a coherent span. By jointly optimizing boundary identification and 8-way technique classification in a single global path, the CRF uses semantic continuity to resolve spatial ambiguity. This joint dependency structure reduces hallucinated false positives on background text and protects Variation 2 from the single-point-of-failure vulnerability that crippled the decoupled cascade.

---

#### The Architectural Limitation of the 3-Tagset CRF

The primary reason the Linear-Chain CRF fails to yield the same structural advantage in Variation 1 comes down to its inability to establish strong global path dependencies over a collapsed probability space. In the 3-class BIO tagset (O, B-Propaganda, I-Propaganda), the transition matrix is severely constrained. When DeBERTa processes ambiguous boundary tokens—such as the subtle onset of a span—the emission probabilities for O, B-Propaganda, and I-Propaganda often flatten into a near-uniform distribution (roughly $33\%$ each). Because all propaganda techniques are lumped into a single generic tag, the CRF lacks distinct semantic state paths to resolve this local uncertainty. Even if the network exhibits high confidence that a central token is I-Propaganda, the Viterbi decoder cannot reliably "knit" this anchor backward to the correct B-Propaganda start token or forward to the O trailing bound, as any B tag looks identically weak regardless of the underlying rhetorical context.

In contrast, Variation 2’s 17-class tagset expands the state space to give the CRF meaningful sequence breadcrumbs to reason over. When the model detects strong central emissions for a specific technique—such as I-Loaded_Language—that high-confidence state actively constrains the global Viterbi path optimization. Even if early boundary tokens are noisy and distribute probability across multiple candidates, the CRF transition matrix knows that an I-Loaded_Language sequence must be preceded by B-Loaded_Language rather than B-Flag_Waving or B-Doubt. The breadth of the 17-tag state space allows the model to leverage technique-specific continuity: the certainty of the internal I-Technique tokens propagates backward and forward to "pull" the less confident, boundary-adjacent B-Technique and trailing O tokens into a globally coherent path. In the 3-tag system, this joint dependency is entirely lost because there are no technique-specific tags to bridge the gap between weak boundary signals and strong internal tokens.

---


#### Task 2 analysis

##### Phase 1: Structural Localization Analysis
The Phase 1 structural audit evaluates spatial routing success across all 640 validation instances prior to technique assignment. Both neural variants demonstrate exceptional background filtering, correctly ignoring non-propaganda text with minimal false-positive over-triggering ($329\text{ TN}$ for Variation 1; $327\text{ TN}$ for Variation 2). However, the two architectures diverge when locating active propaganda. Variation 1 relies on a simplified 3-class tagset that proves slightly more sensitive for initial span detection, yielding fewer complete omissions ($101\text{ FN}$) than Variation 2 ($114\text{ FN}$). Conversely, Variation 2 exhibits tighter spatial boundary control; by leveraging its 17-class joint BIO tagset, it achieves a higher count of boundary-qualified spans ($102\text{ Boundary TPs}$ vs. $93\text{ Disqualified}$) compared to Variation 1 ($99\text{ Boundary TPs}$ vs. $109\text{ Disqualified}$). It is crucial to note that these Phase 1 "Qualified Spans" represent spatial routing passes rather than terminal task successes, as a spatially qualified span can still be misclassified downstream.

##### Phase 2: 'Near-Miss' Semantic Signal Analysis
Phase 2 isolates the subset of instances where a model successfully detected a propaganda target but failed the character-level $\delta$-tolerance boundary rule. Evaluating multi-class accuracy across these disqualified windows demonstrates that both models preserve substantial latent semantic signal despite spatial offsets, achieving $31.18\%$ near-miss accuracy for Variation 2 ($93\text{ spans}$) and $30.28\%$ for Variation 1 ($109\text{ spans}$). This diagnostic proves that boundary misalignment is the primary bottleneck rather than technique blindness. Under the evaluation framework, these offset predictions trigger a double penalty—counting as both a False Positive for the misaligned span and a False Negative for the target—which severely suppresses terminal Macro-F1 despite the presence of correct semantic representations within the offset window.  

> Limitations + Future Work: Tolerance, Data Augmentation in training

##### Phase 3: Semantic Ceiling Comparison Analysis
Phase 3 measures multi-class technique accuracy strictly on the spatially qualified spans from Phase 1, evaluating how effectively each model classifies candidates that successfully met the $\delta$-tolerance window relative to the Stage 2 Oracle benchmark ($0.5178$). On these spatially valid targets, Variation 2 achieves a semantic accuracy of $0.5098$ across its $102\text{ qualified spans}$, recovering $98.5\%$ of the theoretical performance ceiling with a negligible Oracle Gap of $-0.0080$. In contrast, Variation 1 achieves $0.4848$ accuracy across its $99\text{ qualified spans}$, resulting in a wider gap of $-0.0330$. Because Variation 1 pools representations over predicted Stage 1 spans rather than ground-truth boundaries, even allowable boundary offsets introduce surrounding background noise that dilutes the pooled embedding passed to the Stage 2 classifier. 

> This dilution occurs because Stage 2 computes a single representational vector for a candidate phrase by mean-pooling (averaging) the DeBERTa subword embeddings across the predicted token span. When Stage 1 provides a clean, ground-truth span—such as "toxic narrative"—the averaging process operates exclusively on dense, propaganda-rich token representations. However, when Stage 1 predicts a slightly misaligned boundary that includes surrounding context—such as "the toxic narrative was"—the pooling operation is forced to average the core technique tokens alongside neutral background words like "the" and "was". Even if the spatial offset is small enough to pass the $\delta$-tolerance window, incorporating uninformative background vectors shifts the resulting pooled embedding in feature space, diluting its semantic signal and making it substantially harder for the classifier head to output the correct technique label.

This also demonstates a fundemental difference between the two appraochs. Var2 technicially used the whole seqeunce in its "prediction" where as Var2 uses only the snippet, albiet a contextualized one, which is open to dilutaiton, or even restriction, with a inaccuracy predictions, respresneting a vulnerability between the two appraoches. 

By forcing Stage 2 to make a classification decision solely on a isolated, pooled snippet vector, Variation 1 loses the global structural context that Variation 2 retains throughout joint decoding. If that isolated snippet contains even a small amount of boundary noise, Stage 2 has no surrounding sequence context left to help recover the correct label.

Variation 1 (Local Snippet Bottleneck): Even though DeBERTa initially contextualizes the full input sentence, Variation 1's Stage 2 classifier hard-slices the sequence down to just the predicted subword range $[p_{start}, p_{end}]$ and mean-pools those specific vectors. Once sliced, any sequence-level dependencies or structural cues from the rest of the sentence are discarded.

Variation 2 preserves sentence-wide context from end to end. The Linear-Chain CRF operates over the entire token sequence simultaneously. It does not isolate or slice out a candidate snippet; instead, Viterbi decoding computes the single globally optimal path for every token in the sentence at once. A boundary decision at token 3 is mathematically linked to semantic emissions at token 10.

Variation 2 isn't "reading the whole sentence" to make a single local prediction in a multi-class pooling sense; rather, its architecture retains sequence-level information during decoding instead of discarding it.

##### Comparative Synthesis: Variation 2 vs. Variation 1
Overall, Variation 2 proves to be the superior end-to-end architecture, outperforming Variation 1 in terminal Macro-F1 ($0.2034$ vs. $0.1684$) and achieving vastly superior Macro Precision ($0.2914$ vs. $0.2000$). By predicting boundaries and technique labels jointly, Variation 2 eliminates cascading error propagation, achieves tighter spatial qualification ($102\text{ Spans}$ vs. $99\text{ Spans}$), and preserves unpolluted pooled embeddings that convert spatially qualified spans into end-to-end True Positives far more effectively. Conversely, Variation 1's sole empirical advantage lies in its slightly higher sensitivity for detecting span presence. By reducing the localization task to a coarse 3-class schema, Variation 1 records fewer complete omissions ($101\text{ FN}$ vs. $114\text{ FN}$), making its Stage 1 tagger slightly better at flagging that some propaganda exists, even if its decoupled Stage 2 head ultimately struggles to bound and classify it accurately.




