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
Task 1 is as a single-label, multi-class classification problem targeting instances of known but unlabelled propaganda. This tasks objective is to benchmark two non-contextual, static feature representation paradigms: high-dimensional sparse representations derived from frequency-based Bag-of-Words (BoW) modeling against low-dimensional, dense representations from pre-trained Word2Vec embeddings.

Given the lack of contextual awareness, this task explicitly evaluates Hypothesis 1 ($H_1$: The Lexical Trigger Hypothesis), interrogating whether propaganda can be reliably detected through the isolation trigger words.

# 4.1 Baseline & Experimental Floor
To calibrate model performance, an uninformative random-guessing baseline defines the task’s mathematical lower bound. For an 8-class balanced target distribution, uniform random selection yields a expected accuracy and Macro-F1 floor of $P = \frac{1}{8} = 0.125$ ($12.5\%$). To guarantee reproducibility across all experimental iterations, random state generators (Python, NumPy, PyTorch) are locked to a global seed ($\text{SEED} = 142$).  

---

## 4.2 Methodology & Architecture:

### 4.2.1 Approach 1: Sparse Bag-of-Words (BoW) Vector Representation
*Approx 482 words excluding headings, tables and latex formulas*

By representing text as high-dimensional, orthogonal count vectors, a unigram Bag-of-Words (BoW) model evaluates Hypothesis 1 ($H_1$) in its most rudimentary form. In the context of propaganda, sparse representations allow linear decision boundaries to isolate lexical triggers while minimizing feature contamination from surrounding neutral text.

Given a raw input sentence $S$, a whole-word regex tokenizer parses $S$ into a sequence of $N$ lowercase word and punctuation tokens $T = (t_1, t_2, \dots, t_N)$. Following this, tag sequences for Part-of-Speech (POS) and Named Entity Recognition (NER) are extracted across the identical sequence length $N$:

$$P = (p_1, p_2, \dots, p_N), \quad \text{where } p_i \in \mathcal{P}_{\text{universal}}$$

$$E = (e_1, e_2, \dots, e_N), \quad \text{where } e_i \in \mathcal{E}_{\text{simplified}}$$

<br>

The preliminary phase of the BoW architecture constructs a global term-frequency dictionary $\mathcal{C}_{\text{gold}}$ across the training corpus $\mathcal{D}_{\text{train}}$:
$$\mathcal{C}_{\text{gold}}(w) = \sum_{S \in \mathcal{D}_{\text{train}}} \sum_{t_i \in S} \mathbb{I}(t_i = w)$$

In propaganda corpora, rare singletons/hapax legomena, where $\mathcal{C}_{\text{gold}}(w) = 1$, consist predominantly of specific target entities or niche descriptors. Without counterfactual instances, a single occurrence of a rare political name risks the network memorizing spurious co-occurrences rather than genuine propagandist devices. To encourage regularized generalization, all singletons are mapped to an out-of-vocabulary slot ($\text{\_\_UNK\_\_}$). Similarly, ultra-frequent connective words are compiled into a custom stopword list and filtered out, yielding the active vocabulary set $\mathcal{V}_{\text{gold}}$:

$$\mathcal{V}_{\text{gold}} = \{ \text{\_\_UNK\_\_} \} \cup \{ w \in \mathcal{C}_{\text{gold}} \mid \mathcal{C}_{\text{gold}}(w) > 1 \land w \notin \text{Stopwords} \}$$

An active index dictionary then maps each valid term to an orthogonal coordinate axis $\mathcal{I}_{\text{vocab}}: w \mapsto i$, where $i \in \{0, 1, \dots, |\mathcal{V}| - 1\}$. 

<br>

To increase feature density without expanding the vector space with out-of-domain noise, a second enriched vocabulary ($\mathcal{V}_{\text{silver}}$) is constructed using synthetic LLM-generated snippets ($\mathcal{D}_{\text{silver}}$). These silver snippet do not introduce new candidate words but instead increment terms already existing in $\mathcal{C}_{\text{gold}}$:

$$\mathcal{C}_{\text{silver}}(w) = \mathcal{C}_{\text{gold}}(w) + \sum_{S \in \mathcal{D}_{\text{silver}}} \sum_{t_i \in S} \mathbb{I}(t_i = w \land w \in \mathcal{C}_{\text{gold}})$$

The synthetic snippets provide density for previously isolated singletons ($\mathcal{C}_{\text{gold}}(w) = 1$), allowing features to cross the frequency threshold ($\mathcal{C}_{\text{silver}}(w) > 1$) and shifting out of the uninformative `__UNK__` bucket into dedicated lexical dimensions.

##### Table X: Vocab Experiements
| Experimental Split Condition | Active Vocab Dim ($\|\mathcal{V}\|$) | Hapax / Singletons Cut | Structural POS Dim | Structural NER Dim | Total Input Tensor Dim |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Gold Only, Full Context** | 3,265 | 3,038 | 12 | 10 | **3,287** |
| **Silver Enriched, Full Context** | 4,002 | 2,301 | 12 | 10 | **4,024** |
| **Gold Only, Snippet Span** | 1,483 | 2,051 | 12 | 10 | **1,505** |
| **Silver Enriched, Snippet Span** | 2,415 | 1,119 | 12 | 10 | **2,437** |
---

<br>

Table X demonstrates the variability in vocabulary dimensions across the four experimental configurations ($\vert{}\mathcal{V}\vert{} \in [1,483, 4,002]$). Restricting feature extraction strictly to the tagged propaganda span ($<\text{BOS}> \dots <\text{EOS}>$) reduces the Gold vocabulary dimension by $54.6\%$ (from 3,265 down to 1,483), potentially stripping out neutral background prose and intensifying propaganda features. Conversely, integrating synthetic snippets increases feature dimensions as it reclaims lost singletons. In the "Snippet-only, Silver enrichment" experiement, hapax singletons were decreased by $45.4\%$ (from 2,051 down to 1,119) compared to "Snippet-only, Gold-only".

> TODO: include formula vocab reference: ($\vert{}V\vert{} \approx 3,000\text{D}+$)

An important feature of the pipeline emerges by tag extraction occuring prior to vocabulary filtering. Due to this, syntactic POS and semantic NER distributions preserve context even when specific token identity is lost to `__UNK__`. For any sequence $S$, token counts, POS counts, and NER counts are mapped into three discrete frequency vectors:

$$\vec{v}_{\text{vocab}}[i] = \sum_{t \in T} \mathbb{I}(\mathcal{I}_{\text{vocab}}(t) = i)$$

$$\vec{v}_{\text{pos}}[j] = \sum_{p \in P} \mathbb{I}(\mathcal{I}_{\text{pos}}(p) = j)$$

$$\vec{v}_{\text{ner}}[k] = \sum_{e \in E} \mathbb{I}(\mathcal{I}_{\text{ner}}(e) = k)$$

This means, the $\vec{v}_{\text{ner}}[k]$ vector preserves a reference to a Proper Noun, even if the specific token is mapped to the `__UNK__` token. This not only retains lost signal but for propaganda acts as a natural regularizer that encodes the intent of a targeted reference or descriptor but removes the specificity.  

These multi-channel feature vectors are finally concatenated into a single input tensor $\vec{x}_{\text{input}}$ and passed to the MLP classification head:
$$\vec{x}_{\text{input}} = \left[ \vec{v}_{\text{vocab}} \parallel \vec{v}_{\text{pos}} \parallel \vec{v}_{\text{ner}} \right] \in \mathbb{R}^{|\mathcal{V}| + |\mathcal{P}| + |\mathcal{E}|}$$

While the auxiliary vectors remain strictly invariant across all experiments ($|\mathcal{P}| = 12$ POS tags and $|\mathcal{E}| = 10$ NER tags), the vocabulary vector dynamically scales based on the experimental condition. For example, under the *Gold Only, Snippet Span* setup, the classification head receives a $1,505$-dimensional vector ($1,483 + 12 + 10$), whereas the *Silver Enriched, Full Context* setup expands the input dimension to $4,024$ ($4,002 + 12 + 10$).

---

### 4.2.2 Approach 2: Dense Word2Vec (W2V) Vector Representation
Approach 2 benchmarks static continuous word embeddings to evaluate Hypothesis 1 ($H_1$) using continuous vector space geometry.

To mitigate Zipf's Law sparsity on small propaganda corpora, Word2Vec maps semantic similarity into geometric proximity (Firth, 1957; Mikolov et al., 2013). Continuous embeddings perform implicit matrix factorization (Levy & Goldberg, 2014), sharing statistical strength across synonyms. This allows the classifier to recognize alternative wordings and generalize across synonymous rhetorical injections. Given propaganda techniques frequently manifest as localized emotive triggers, Word2Vec's local window optimization provides a superior representation for short rhetorical spans over global co-occurrence models (Baroni et al., 2014).

We deploy $300$-dimensional pre-trained Google News embeddings ($E \in \mathbb{R}^{\vert{}V_{\text{google}}\vert{} \times 300}$). To maintain strict experimental control and isolate embedding density as the sole independent variable (Sparse vs Dense), the lookup space is constrained to the active vocabulary ($\mathcal{V}_{\text{gold}}$ and $\mathcal{V}_{\text{silver}}$) of the given iteration. Nullifying Word2Vec's external OOV lookup ensures both sparse and dense paradigms operate on identical input bounds, whilst sacrificing potential generalization. For tokens outside the active vocabulary, we retain the OOV routing mechanism, yielding a normalized scalar ratio $c_{\text{unk}} \in [0, 1]$ to match the embeddings magnitude:

$$c_{\text{unk}} = \frac{1}{N} \sum_{t \in T} \mathbb{I}(t \notin \mathcal{V})$$

Sequence-level composition applies arithmetic mean-pooling over valid active tokens in $T$:

$$\vec{v}_{\text{w2v}} = \begin{cases} \frac{1}{\vert{}T_{\text{valid}}\vert{}} \sum_{t \in T_{\text{valid}}} E(t), & \text{if } \vert{}T_{\text{valid}}\vert{} > 0 \\ \vec{0}_{300}, & \text{otherwise} \end{cases}$$

The reason that this approach only addresses $H_1$ is because vector addition is commutative and therefore discards token order and compositional structure entirely. This means W2V's capacity to process the non-compositional syntactic departures prevalent in propaganda is restricted to the signal strength of individual words and their combinations only. While the W2V optimization process is localized and windowed, it produces static embeddings with an infinitely generalized notion of surroundings.

To assemble $\vec{x}_{\text{input}}$, the tagset vectors ($\vec{v}_{\text{pos}}$ and $\vec{v}_{\text{ner}}$) are $L_1$-normalized into relative probability distributions ($[0, 1]$) prior to concatenation. Again, this aligns the magnitudes with W2V embeddings, preventing unscaled integer counts from dominating loss gradients during backpropagation:

$$\tilde{\vec{v}}_{\text{pos}} = \frac{\vec{v}_{\text{pos}}}{\sum_j \vec{v}_{\text{pos}}[j]}, \quad \tilde{\vec{v}}_{\text{ner}} = \frac{\vec{v}_{\text{ner}}}{\sum_k \vec{v}_{\text{ner}}[k]}$$

The final concatenated input tensor $\vec{x}_{\text{input}}$ represents a $323$-dimensional vector passed directly to the MLP head. These dimensions are fixed across all experiments:

$$\vec{x}_{\text{input}} = \left[ \vec{v}_{\text{w2v\_300d}} \parallel c_{\text{unk}} \parallel \tilde{\vec{v}}_{\text{pos\_12d}} \parallel \tilde{\vec{v}}_{\text{ner\_10d}} \right] \in \mathbb{R}^{323}$$

##### Table X: Word2Vec Experimental Input Dimensions
| Experimental Split Condition | Vocab Dim ($\|\mathcal{V}\|$) | Hapax/Singletons Cut | Structural POS Dim | Structural NER Dim | Total Input Tensor Dim |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Gold Only, Full Context** | 301 | 3,038 | 12 | 10 | **323** |
| **Silver Enriched, Full Context** | 301 | 2,301 | 12 | 10 | **323** |
| **Gold Only, Snippet Span** | 301 | 2,051 | 12 | 10 | **323** |
| **Silver Enriched, Snippet Span** | 301 | 1,119 | 12 | 10 | **323** |

---

## 4.3 Evaluation Metrics
Although our training corpus is balanced, real-world propaganda datasets are typically highly imbalanced (Da San Martino et al., 2020). Consequently, we design an evaluation framework tailored to imbalanced test distributions. Standard accuracy is an insufficient terminal evaluation metric because it is vulnerable to masking poor minority performance behind dominant classes.

In a single-label multi-class setting across $K$ classes, Micro-averaged $F_1$ score mathematically decomposes into global accuracy, making it blind to systematic class imbalances:

$$\text{Accuracy} = \text{Micro-F}_1 = \frac{\sum_{k=1}^{K} \text{TP}_k}{\sum_{k=1}^{K} (\text{TP}_k + \text{FP}_k)}$$

where $\text{TP}_k$ and $\text{FP}_k$ represent the True Positives and False Positives for class $k$, respectively.

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

### 4.5.1 Sparse Representation Dynamics (Bag-of-Words)
The unigram Bag-of-Words framework established the top-performing terminal score across all Task 1 experiments, achieving a peak Test Macro-$F_1$ of $0.3200$ under the Full-Context, Gold Vocabulary setup. 

Analyzing performance across the internal BoW conditions illuminates key interactions between context windowing, vocabulary density, and synthetic data augmentation.

> ???

Restricting feature extraction to the target snippet span reduced the vocabulary dimension from 3,265 down to 1,483. While intended to eliminate noisy background prose, this span restriction slightly degraded test performance, dropping Macro-$F_1$ from 0.3200 to 0.3183. Surrounding sentinel context acts as a crucial density stabilizing mechanism. 

Much like structural taxonomies retain performance in low-resource settings, neutral sentinel words provide co-occurrence statistics that cushion sparse lexical space.

> Find the exact paper from the lectures about wordnet density

Expanding the vocabulary via synthetic silver snippets ($\mathcal{V}_{\text{silver}} = 4,002\text{D}$) degraded out-of-sample generalization, dropping Test Macro-$F_1$ to 0.3174. This result strongly supports Hypothesis 1 ($H_1$): propaganda techniques rely on exact lexical triggers. Generative LLM reformulations introduced subtle semantic drift, altering original word choices and corrupting the strict linear decision boundaries needed to isolate trigger tokens. 

Furthermore, while synthetic snippets supplied density to previously isolated singletons, they introduced out-of-domain noise that lost the true "domain stamp" of authentic propagandistic prose.

> would prefer this singleton point to be focused on making the vector more sprrse

### 4.5.2 Representation Bottleneck Analysis (Word2Vec)
Word2Vec underperformed the sparse Bag-of-Words baseline across every experimental permutation, suffering an average terminal drop of $\Delta 0.035$ Macro-$F_1$ and peaking at 0.2927 under Snippet, Gold. Because both paradigms shared identical classification heads, loss objectives, and auxiliary structural tagsets, this systematic failure isolates a fundamental representational bottleneck within static continuous vector spaces when applied to manipulative text.

Propaganda detection relies heavily on exact lexical choice, tone, and pragmatics rather than broad distributional semantics. By mapping terms into continuous geometric neighborhoods based on the Distributional Hypothesis, Word2Vec softens functional boundaries. In pre-trained Google News space, loaded terms and neutral equivalents, such as "regime" versus "government" or "scheme" versus "plan", share high cosine similarity. Whereas BoW keeps these terms as strictly orthogonal dimensions, allowing linear heads to reward or penalize exact triggers, Word2Vec projects them into overlapping spatial clusters.

Furthermore, because vector addition is commutative, mean-pooling weights every token in a sequence equally. However, propaganda exhibits extreme signal imbalance: approximately 90% of a sentence consists of standard syntactic prose, while only 10% contains the manipulative device. In a 15-word snippet containing one target trigger, arithmetic pooling pulls the sequence centroid 15 times harder toward generic news text, effectively washing out the directional signal of the trigger word.

Pre-trained word2vec-google-news-300 was also trained on objective journalistic text designed to minimize sensationalism. Consequently, its vector space was optimized to cluster factual concepts rather than emotional stances or rhetorical manipulation.

This representational bottleneck is confirmed by Word2Vec's training trajectory. Unlike BoW, which overfit heavily, Word2Vec exhibited severe underfitting, failing to fit even its own training set as Train Macro-$F_1$ collapsed to 0.4646 versus BoW's 0.8148. Because the network could not achieve linear separation on training data, the bottleneck lies strictly within the input feature representations rather than MLP head capacity. On a positive note, Word2Vec's tight generalization gap ($\Delta F_1 = 0.1719$) confirms that while arithmetic mean-pooling causes severe information loss, its continuous representations remain statistically stable across splits.

---


##### Table X: Experiment 1 (Full-Context, Gold Vocab) Class-Level Results

| Class / Metric | $F_1$-Score (BASE) | $F_1$-Score (BoW) | $F_1$-Score (W2V) | Precision (BASE) | Precision (BoW) | Precision (W2V) | Recall (BASE) | Recall (BoW) | Recall (W2V) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| `name_calling,labeling` | 0.13 | 0.24 | 0.19 | 0.11 | 0.28 | 0.21 | 0.15 | 0.21 | 0.18 |
| `repetition` | 0.15 | 0.33 | 0.18 | 0.14 | 0.42 | 0.33 | 0.15 | 0.28 | 0.12 |
| `causal_oversimplification` | 0.16 | 0.32 | 0.34 | 0.15 | 0.29 | 0.29 | 0.17 | 0.34 | 0.40 |
| `doubt` | 0.14 | 0.39 | 0.31 | 0.15 | 0.35 | 0.39 | 0.14 | 0.44 | 0.26 |
| `loaded_language` | 0.14 | 0.13 | 0.04 | 0.14 | 0.19 | 0.14 | 0.13 | 0.10 | 0.03 |
| `appeal_to_fear_prejudice` | 0.18 | 0.33 | 0.40 | 0.21 | 0.33 | 0.36 | 0.16 | 0.33 | 0.44 |
| `flag_waving` | 0.12 | 0.46 | 0.54 | 0.14 | 0.46 | 0.41 | 0.11 | 0.47 | 0.82 |
| `exaggeration,minimisation` | 0.09 | 0.36 | 0.26 | 0.08 | 0.28 | 0.24 | 0.10 | 0.50 | 0.30 |
| **Accuracy** | 0.14 | 0.33 | 0.33 | — | — | — | — | — | — |
| **Macro Avg** | 0.14 | 0.32 | 0.28 | 0.14 | 0.33 | 0.30 | 0.14 | 0.33 | 0.32 |
| **Weighted Avg** | 0.14 | 0.32 | 0.29 | 0.14 | 0.33 | 0.30 | 0.14 | 0.33 | 0.33 |


##### Table 6: Class-Level Diagnostic Performance Comparison (Experiment 1)
| Propaganda Class | BoW $F_1$ | W2V $F_1$ | Dominant Paradigm | Primary Representation Mechanism |
| :--- | :---: | :---: | :---: | :--- |
| **`flag_waving`** | 0.46 | **0.54** | **Word2Vec (+0.08)** | Dense clustering of national/group entities (W2V Recall = 0.82). |
| **`appeal_to_fear_prejudice`** | 0.33 | **0.40** | **Word2Vec (+0.07)** | Shared continuous geometry of threat/anxiety vocabulary. |
| **`causal_oversimplification`** | 0.32 | **0.34** | **Word2Vec (+0.02)** | Broad semantic mapping of cause-and-effect narrative structures. |
| **`doubt`** | **0.39** | 0.31 | **Bag-of-Words (+0.08)** | Discrete orthogonal triggers for questioning cues (*"allegedly"*, *"so-called"*). |
| **`exaggeration,minimisation`** | **0.36** | 0.26 | **Bag-of-Words (+0.10)** | Exact string matching for extrema modifiers (*"always"*, *"never"*). |
| **`repetition`** | **0.33** | 0.18 | **Bag-of-Words (+0.15)** | Frequency count vectors preserve duplicate token instances. |
| **`name_calling,labeling`** | **0.24** | 0.19 | **Bag-of-Words (+0.05)** | Specific epithets require exact lexical matching over soft semantics. |
| **`loaded_language`** | **0.13** | 0.04 | **Bag-of-Words (+0.09)** | Severe mean-pooling dilution washes 1-token triggers into news background ($R_{\text{w2v}}=0.03$). |


---

##### Liturature Backing: 
Our finding that mean-pooled Word2Vec ($0.2927$ Test Macro-$F_1$) underperforms sparse Bag-of-Words ($0.3200$) aligns directly with established literature in fine-grained propaganda analysis (Da San Martino et al., 2019; Cruz et al., 2019). As demonstrated in SemEval-2020 Task 11, propaganda techniques rely on localized lexical triggers that suffer severe signal dilution when averaged into static 300D document centroids (Da San Martino et al., 2020). Benchmarking feature spaces, Cruz et al. (2019) similarly confirmed that continuous vector space smoothing erases exact string matches, proving that dense representations require sequential contextualization mechanisms to isolate manipulative rhetoric effectively.

---


- Performance comparisons across the 4 conditions (Full/Snippet $\times$ Gold/Silver) relative to the Random Baseline.

- BoW beter than W2V: Macro F-1 0.32 vs 0.2927
- BoW performs best with full-context and gold vocab
- Snippet makes the sparses vector less sparse with only 1483 but vastly removes the amount of training data. This mirrors a finding from the module which used WordNet and found that data density was the key to performance. If anything, the sentinal context behaves as density. 
- The full-context, silver vocab performance worse then both gold approaches. This could be for two reasons. It backs up the H1 that the particular words used are the lexical proptriggers, and the reformulas in the silver approach hinder boundary detection. Conversely, the dim jump utp 4002 for full context, enrich, this allows for the model learn more granular info by makes the vector even more sptases. 
- Finally, the snippet, silver provides a scenario where we are lossing gold standard density and replacing it with synethic data which whislt it intended to reflect prop sentiment was never actually used to propagandist. So whilst it provides the action of data density like the full-context does, it loses strictly the true domain stamp. 
- However, the vast difference differnet becasue test f1 and train f1 suggest the approach is aggresivly overfitting and failing to genrealize.  (Train Macro-$F_1$ up to 0.8314 vs. Test 0.3174), demonstrating high memorization capacity due to high dimensionality ($>3,000\text{D}$).
- Silver enrichment provided density in training (boosting BoW train $F_1$ from $0.8148$ to $0.8314$), but caused slight performance degradation on the test set across both paradigms, likely introducing semantic drift from synthetic LLM generation.

---

W2V Macro F-1 losses on all experiements, including on macro precision and recall

Here include the differential between f1 bow - wordvec

Given our experiemntal structure, isolating just the vectors and keeping everything else the same (except hyperparameters), we can conclude that fundementally, this approach is less good at detecting propaganda technqies. 

Propaganda detection elies heavily on pragmatics, tone, and exact lexical choice, not broad lexical semantics.

The mapping distinct words to continuous, shared geometric spaces, Word2Vec "softens" the boundaries between words. 

A neutral word and a subtly biased loaded word might share a high cosine similarity in generic News Word2Vec space (e.g., "regime" vs. "government" or "scheme" vs. "plan"). BoW keeps these as completely orthogonal dimensions, allowing the linear model to punish or reward exact propaganda triggers cleanly.

The main issue probably comes from the mean-pooling. Every word in the sentence contributes equally to the single $300$-dimensional point in space. And therefore, each word is weighted equally, despite in a propaganga situation only a few words being key markers. Mean-pooling assumes uniform importance across all tokens in a sequence.

If a segment has 1 strong propaganda trigger (e.g., "tyrant") and 15 neutral news words, the arithmetic mean pulls the final document vector $15\times$ harder toward the "generic news text" cluster. The distinct directional signal of "tyrant" is effectively washed out / diluted into background noise

In propaganda, signal density is extremely skewed: $90\%$ of the sentence might be ordinary syntactic prose, while $10\%$ (or a single phrase) contains the target technique (e.g., Name Calling).

word2vec-google-news-300 was trained on standard, objective, professional news articles (Google News).
Objective news reporting intentionally minimizes loaded language and sensationalism.
Consequently, the embedding space was optimized to cluster factual concepts, entities, and standard narrative relationships—not propaganda techniques, emotional manipulation, or rhetorical stances.


Compared to BoW, Dense W2V exhibits much tighter train-test generalization gap (Train $0.4646$ vs. Test $0.2927$), suggesting less strength in overfitting. but stil overiftting but overfitting way less than bow

The fact that the model cannot even fit its own training data proves that the representational bottleneck is in the input features themselves, not in the capacity of your MLP classification head or the generalization step.

When you project a variable-length sentence with distinct lexical triggers down into a single, mean-pooled 300D vector, you cause irreversible information loss.

Because additive mean pooling compresses distinct propaganda triggers into generic news sentence centroids, the resulting 300-dimensional representations become non-separable at the input layer, preventing the MLP from learning effective decision boundaries even on seen training examples


Because the training set performance is so low, it shows that even during the optimization pass, the MLP cannot find a decision boundary to separate the classes.

On a slightly positive note, the small performance gap indicates that the mean-pooled Word2Vec representations are statistically stable. 

Unlike the Bag-of-Words baseline—which exhibited high capacity to fit the training set (achieving ~81% accuracy) before dropping on validation data due to vocabulary sparsity—the Word2Vec mean-pooling approach exhibited severe underfitting (high bias) across both splits (28.2% train vs. 20.1% validation).



##### Table X: Task 1 Experimental Results across Model Architectures and Data Splits

| Model & Experimental Condition | Vector Dims ($d_{\text{sem}}$) | Test Accuracy | Test Macro-$F_1$ | Test Macro-Precision | Test Macro-Recall | Train Accuracy | Train Macro-$F_1$ | Train Macro-Precision | Train Macro-Recall |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Random Guess Baseline** | — | 0.1618 | 0.1592 | 0.1582 | 0.1578 | — | — | — | — |
| **BoW, Full-Context, Gold Vocab** | 3,265 | 0.3333 | **0.3200** | 0.3254 | 0.3326 | 0.8149 | 0.8148 | 0.8199 | 0.8157 |
| **BoW, Snippet, Gold Vocab** | 1,483 | 0.3301 | 0.3183 | 0.3157 | 0.3305 | 0.6700 | 0.6696 | 0.6798 | 0.6712 |
| **BoW, Full-Context, Enriched Vocab** | 4,002 | 0.3269 | 0.3174 | 0.3179 | 0.3262 | 0.8319 | 0.8314 | 0.8341 | 0.8327 |
| **BoW, Snippet, Enriched Vocab** | 2,415 | 0.3236 | 0.3129 | 0.3292 | 0.3215 | 0.7529 | 0.7516 | 0.7599 | 0.7538 |
| **W2V, Full-Context, Gold Vocab** | 301 | 0.3301 | 0.2835 | 0.2962 | 0.3184 | 0.4601 | 0.4440 | 0.5118 | 0.4621 |
| **W2V, Snippet, Gold Vocab** | 301 | **0.3366** | 0.2927 | 0.2911 | 0.3274 | 0.4779 | 0.4646 | 0.5030 | 0.4808 |
| **W2V, Full-Context, Enriched Vocab** | 301 | 0.3236 | 0.2861 | 0.3076 | 0.3169 | 0.4640 | 0.4509 | 0.5084 | 0.4656 |
| **W2V, Snippet, Enriched Vocab** | 301 | 0.3074 | 0.2571 | 0.2672 | 0.3007 | 0.4826 | 0.4714 | 0.5338 | 0.4840 |




---

## 4.6 Task 1 Discussion & Error Analysis:
- Testing Hypothesis H1: Why BoW preserves local triggers while Word2Vec suffers from Vector Dilution / Signal Washing.
- Per-Class Dynamics: Severe class suppression in Loaded Language ($0.03$ recall) vs. semantic saturation in Flag Waving ($0.67$ recall).
- Bias-Variance & Feature Bottlenecks: Interpreting train/val convergence and underfitting.

---