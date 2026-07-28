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
Task 2 expands the experimental scope from classifying isolated, pre-delimited snippets to jointly identifying propagandistic text boundaries and classifying the specific techniques deployed within unannotated, full-sentence contexts. We frame this objective as a sequence labeling problem utilizing the standard Beginning, Inside, Outside (BIO) encoding schema. Neutral background tokens and non-propagandistic sentences are tagged O, the initial token of a manipulative span is tagged B-, and subsequent interior tokens are tagged I-.

## 5.1 Topological Control Baseline
To establish a rigorous mathematical floor and guarantee that sequence labeling models capture genuine linguistic manipulation rather than exploiting surface-level formatting or positional artifacts, we construct a language-blind topological baseline. Stripped entirely of vocabulary features and semantic representations, this baseline processes sequences into a low-dimensional structural metric tensor $\mathbf{x}_{\text{topo}}$

$$\mathbf{x}_{\text{topo}} = \left[ L_{\text{tokens}}, L_{\text{chars}}, \mu_{\text{len}}, \sigma^2_{\text{len}}, \text{CapRatio}, \text{PuncDensity}, \text{DigitRatio} \right]$$

A lightweight Multi-Layer Perceptron (MLP) trained on $\mathbf{x}_{\text{topo}}$ outputs a predicted relative span boundary $(\hat{R}_{\text{start}}, \hat{R}_{\text{end}})$ alongside a global propaganda existence probability $P(\text{prop})$: 

$$\hat{\mathbf{y}} = \left[ P(\text{prop}), \hat{R}_{\text{start}}, \hat{R}_{\text{end}} \right]$$

Sequences with $P(\text{prop}) < 0.5$ are predicted as `not_propaganda` ($O$ across all tokens). This non-semantic control provides the empirical substrate required to verify whether downstream neural architectures learn authentic rhetorical devices or merely fit structural text rhythm.

Table 5: Topological Surface Feature Definitions and Proxies

##### Table 5: Topological Surface Feature Definitions and Proxies
| Topological Feature | Mathematical Definition | Target Rhetorical / Structural Proxy |
| :--- | :---: | :--- |
| **Token Length ($L_{\text{tokens}}$)** | Total token count per sequence | Sentence complexity and structural context volume[cite: 4]. |
| **Character Length ($L_{\text{chars}}$)** | Total character count | Sentence length normalization benchmark[cite: 4]. |
| **Mean Word Length ($\mu_{\text{len}}$)** | $\frac{L_{\text{chars}}}{L_{\text{tokens}}}$ | Proxy for vocabulary sophistication and slogan usage[cite: 4]. |
| **Length Variance ($\sigma^2_{\text{len}}$)** | Token length variance | Structural rhythm and stylistic prose irregularity[cite: 4]. |
| **Capitalization Ratio ($\text{CapRatio}$)** | $\frac{\text{Count}(\text{Uppercase})}{\text{Count}(\text{Alphabetic})}$ | Entity density and *Name Calling / Labeling* emphasis[cite: 4]. |
| **Punctuation Density ($\text{PuncDensity}$)** | $\frac{\text{Count}(\text{Punctuation})}{L_{\text{tokens}}}$ | Quotation usage in *Causal Oversimplification* or *Doubt*[cite: 4]. |
| **Digit Ratio ($\text{DigitRatio}$)** | $\frac{\text{Count}(\text{Digits})}{L_{\text{tokens}}}$ | Numerical claims in *Exaggeration / Minimisation*[cite: 4]. |

Topological FeatureMathematical DefinitionTarget Rhetorical / Structural ProxyToken Length ($L_{\text{tokens}}$)Total token count per sequenceSentence complexity and structural context volume.  Character Length ($L_{\text{chars}}$)Total character countSentence length normalization benchmark.  Mean Word Length ($\mu_{\text{len}}$)$\frac{L_{\text{chars}}}{L_{\text{tokens}}}$Proxy for vocabulary sophistication and slogan usage.  Length Variance ($\sigma^2_{\text{len}}$)Token length varianceStructural rhythm and stylistic prose irregularity.  Capitalization Ratio ($\text{CapRatio}$)$\frac{\text{Count}(\text{Uppercase})}{\text{Count}(\text{Alphabetic})}$Entity density and Name Calling / Labeling emphasis.  Punctuation Density ($\text{PuncDensity}$)$\frac{\text{Count}(\text{Punctuation})}{L_{\text{tokens}}}$Quotation usage in Causal Oversimplification or Doubt.  Digit Ratio ($\text{DigitRatio}$)$\frac{\text{Count}(\text{Digits})}{L_{\text{tokens}}}$Numerical claims in Exaggeration / Minimisation.  

## 5.2 Methodological Framework: Modernized Encoder-CRF Tagger
The foundational architecture for Task 2 adapts the classic sequence labeling pipeline of Ma and Hovy (2016). While traditional implementations stack character-level CNNs, Bi-directional LSTMs, and Linear-Chain Conditional Random Fields (CRFs), we modernize this pipeline by substituting recurrent and convolutional feature extractors with a contextualized DeBERTa Transformer encoder while retaining the linear-chain CRF layer.

This transition directly addresses the limitations observed in Task 1. First, SentencePiece subword tokenization eliminates the need for character-level CNNs by decomposing out-of-vocabulary terms into sub-units. Second, global self-attention replaces sequential LSTM recurrence, resolving information bottlenecks and preserving long-range context across full news articles. Third, DeBERTa's disentangled attention mechanism models word content and relative position on separate vectors, isolating the syntactic departures characteristic of manipulative rhetoric.

Crucially, static auxiliary features (POS and NER tags) are omitted from Task 2. While explicit feature engineering provided vital statistical density for Task 1's non-contextual Bag-of-Words and Word2Vec models, DeBERTa dynamically infers syntactic roles and entity structures through deep self-attention layers. Omitting manual tag concatenation avoids subword alignment bottlenecks and marks a clear methodological transition from explicit, rule-based feature engineering (Task 1) to implicit, self-supervised contextual representation learning (Task 2).

To enforce sequence-level validity and resolve the label bias problem inherent in local softmax predictions (McCallum et al., 2000), a CRF layer decodes the final sequence globally (Lafferty et al., 2001). Given a sequence of DeBERTa contextual representations $\mathbf{H} = (\mathbf{h}_1, \mathbf{h}_2, \dots, \mathbf{h}_N)$ and a candidate label sequence $\mathbf{y} = (y_1, y_2, \dots, y_N)$, the CRF defines a global path score $s(\mathbf{H}, \mathbf{y})$:

$$s(\mathbf{H}, \mathbf{y}) = \sum_{i=1}^{N} \mathbf{A}_{y_{i-1}, y_i} + \sum_{i=1}^{N} \mathbf{P}_{i, y_i}$$

where $\mathbf{A}$ represents the transition matrix of label-to-label emission probabilities, and $\mathbf{P}_{i, y_i}$ denotes the score emitted by DeBERTa for tag $y_i$ at position $i$. Global sequence probabilities are normalized over all possible tag paths $\mathbf{Y}$, ensuring that invalid transition structures (e.g., an I- tag immediately following an O tag) are mathematically suppressed

## 5.3 Task 2 Experimental Variations

To evaluate how tagset granularity impacts boundary detection and technique classification, Task 2 compares two variations on the DeBERTa-CRF architecture.

```
┌──────────────────────────────────────────┐
                     │          Input Sentence Tokens           │
                     └────────────────────┬─────────────────────┘
                                          │
                                          ▼
                     ┌──────────────────────────────────────────┐
                     │     DeBERTa Contextual Encoder           │
                     └────────────────────┬─────────────────────┘
                                          │
                   ┌──────────────────────┴──────────────────────┐
                   ▼                                             ▼
┌──────────────────────────────────────┐     ┌───────────────────────────────────┐
│ Variation 1: Two-Stage Pipeline      │     │ Variation 2: Joint End-to-End     │
├──────────────────────────────────────┤     ├───────────────────────────────────┤
│ Stage 1: 3-Class DeBERTa-CRF         │     │ Single DeBERTa-CRF Model          │
│          [B-Prop, I-Prop, O]         │     │ 17-Class BIO Tagset               │
│                                      │     │ [B-loaded, I-loaded, ..., O]      │
│ Stage 2: Mean-Pooled Span MLP Head   │     │                                   │
│          (Predicts 1 of 8 Techniques)│     │ Viterbi Backward Trellis Decoding │
└──────────────────────────────────────┘     └───────────────────────────────────┘
```

### 5.3.1 Variation 1: Two-Stage Pipeline (Binary Sequence Tagger + Span MLP)
Variation 1 decouples span boundary identification from technique classification into a sequential pipeline.

Stage 1 (Span Boundary Detection): The sequence is processed by a 3-class DeBERTa-CRF tagger operating over a condensed tagset: B-Propaganda, I-Propaganda, and O. Collapsing all 8 techniques into a single positive class maximizes statistical training density, optimizing the network purely for boundary localization. Sequences tagged entirely as O are routed directly as not_propaganda.

Stage 2 (Technique Classification Head): For sequences containing a predicted span ($\hat{S} = \{t_{\text{start}}, \dots, t_{\text{end}}\}$), the corresponding DeBERTa token hidden states $\mathbf{h}_i \in \mathbb{R}^{768}$ within the predicted span are extracted. Arithmetic mean-pooling compresses these contextual states into a unified span embedding $\mathbf{v}_{\text{span}} \in \mathbb{R}^{768}$:

$$\mathbf{v}_{\text{span}} = \frac{1}{\vert{}\hat{S}\vert{}} \sum_{i \in \hat{S}} \mathbf{h}_i$$

$\mathbf{v}_{\text{span}}$ is fed into an MLP classification head (Linear -> ReLU -> LayerNorm -> Dropout -> Linear) to output probabilities across the 8 target propaganda categories.

To isolate pipeline architecture as the sole independent variable, Stage 2 utilizes the exact same pre-trained DeBERTa representations as Variation 2. To prevent noisy Stage 1 predictions from degrading Stage 2 training, Stage 2 is optimized using gold-standard training spans (teacher forcing). At test time, Stage 1 and Stage 2 operate sequentially. This architecture isolates boundary detection but remains vulnerable to cascading error propagation: any false positive span identified in Stage 1 forces Stage 2 to assign an incorrect propaganda technique.

### 5.3.2 Variation 2: Joint End-to-End Sequence Tagging (17-Class Space)
Variation 2 bypasses pipeline cascading errors by executing span detection and technique classification simultaneously in a single pass. The model operates across a high-resolution 17-class BIO tagset consisting of 8 B- tags, 8 I- tags, and 1 O tag.

Under this joint paradigm, boundary disambiguation relies on the CRF's backward-flowing Viterbi trellis. During dynamic programming decoding, the highest-scoring tag path is computed recursively:

$$V_t(j) = \max_{i} \left[ V_{t-1}(i) + \mathbf{A}_{i, j} \right] + \mathbf{P}_{t, j}$$

This structure produces a "breadcrumb effect": high model confidence on technique-specific tokens deep within a span (e.g., I-flag_waving) propagates backward through transition parameters $\mathbf{A}$, pulling ambiguous initial boundary tokens into the corresponding B-flag_waving state. While this eliminates pipeline cascading errors, expanding the output space to 17 classes re-introduces data sparsity and increases susceptibility to overfitting

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

To resolve this, we implement a Cascading Length Window-Based Qualification Router. Boundary tolerance scales dynamically based on gold span token length ($L_{\text{gold}}$). A predicted span $\hat{S} = [\hat{t}_{\text{start}}, \hat{t}_{\text{end}}]$ qualifies for classification evaluation if and only if both start and end offsets fall within the allowable token window $\delta(L_{\text{gold}})$ of the gold span $S_{\text{gold}} = [t_{\text{start}}, t_{\text{end}}]$:

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

During inference, every error instance is logged into a diagnostic JSON structure tracking whether failures stem from Boundary Localization Failures (right words, wrong offsets) or Technique Misclassification Failures (qualified boundary, wrong class). This granular logging provides the diagnostic evidence needed for the experimental analysis.

---

### Execution Plan for Code & Experiments

#### Step 1: Data Preparation & Pre-processing
- Load propaganda_train.tsv and propaganda_val.tsv.
- Parse <BOS> and <EOS> tags from tagged_in_context strings to convert characters into token-level BIO labels (B-, I-, O).
- Construct two dataset variants:
    1. **3-Class Dataset (Variation 1):** Labels mapped to `B-Prop`, `I-Prop`, `O`.
    2. **17-Class Dataset (Variation 2):** Labels mapped to `B-{technique}`, `I-{technique}`, `O`.

#### Step 2: Topological Baseline Implementation (Task2TopologicalBaseline)
- Build feature extractor for $\mathbf{x}_{\text{topo}}$ (Token/char lengths, mean/variance of word lengths, cap ratio, punc density, digit ratio).
- Train PyTorch MLP to output $P(\text{prop})$ logits and boundary ratio outputs $(\hat{R}_{\text{start}}, \hat{R}_{\text{end}})$. 

#### Step 3: DeBERTa-CRF Tagger Implementation
- Load pre-trained microsoft/deberta-v3-base tokenizer and model backbone via HuggingFace transformers and pytorch-crf
- Build custom PyTorch Module combining DeBERTa sequence output layer with a Linear-Chain CRF decoding layer.
- Train Variation 1 Tagger (3-class) and Variation 2 Tagger (17-class) using Negative Log-Likelihood loss from the CRF layer.

#### Step 4: Variation 1 Stage 2 Classification Head (DebertaSpanClassifier)
Extract gold propaganda spans from training text, mean-pool their DeBERTa subword embeddings, and train a 768D $\rightarrow$ 8-class PyTorch MLP head. 

#### Step 5: Cascading Window Qualification Evaluator & Logger
Implement Python evaluator function applying the token-length tolerance logic ($\delta \in [0, 10]$).

Route predicted spans, evaluate TPs/FPs/FNs, compute terminal Macro-$F_1$, and save a structured JSON error log (task2_diagnostic_error_log.json) capturing boundary vs. technique failures. 

---