# Abstract
1. 
2. Report structure?
3. Contents/Sections outlay

---

# 1 Introduction (Word Count: 104)

Propaganda is the deliberate, systematic attempt to shape perceptions, manipulate cognitions, and direct behavior to achieve a response that furthers the desired intent of the propagandist (Jowett & O'Donnell, 2018). It involves managing collective attitudes by manipulating significant symbols (Lasswell, 1927) and using rhetorical devices to bypass rational analysis rather than relying on outright falsehoods. 

Given the velocity and volume of modern digital information, automated detection mechanisms are increasingly vital for maintaining the integrity of online discourse. This report explores automatically identifying propaganda through two core challenges: classifying known propagandistic snippets (Task 1) and jointly identifying manipulative spans and techniques within raw text (Task 2).

---

## 1.1 Problem Outline (Word Count: 78)

Automating detection is challenging because the boundary between legitimate persuasion and manipulative rhetoric is highly subjective (Da San Martino et al., 2019). Historical models classified entire documents (Rashkin et al., 2017) but modern moderation requires detecting localized nuanced rhetorical shifts. Problematically, such detection must overcome significant structural irregularity as propagandists often sacrifice grammatical purity for rhetorical impact, relying on non-compositional multi-word expressions (Sag et al., 2002) and domain specific terms that present severe out-of-vocabulary challenges for traditional NLP.

---

## 1.2 Hypotheses (Word Count: 33)

To guide the methodologies and experimentation, this report evaluates against two hypotheses. The success of H2 can only be achieved by context aware implementations, whereas H1 can be represented by simple vocabulary-based approaches.

| Hypothesis | Title | Definition | 
| :--- | :--- | :--- | 
| **H1** | Lexical Trigger Hypothesis | Propaganda is defined by specific, emotionally charged trigger words. | 
| **H2** | Structural Irregularity Hypothesis | Propaganda relies on syntactic departures and non-compositionality. |

---

# 2 Related Work: Evolution of NLP Computational Methods (Word Count: 134)

NLP has evolved from symbolic taxonomies like WordNet (Miller, 1995) to statistical representations rooted in the Distributional Hypothesis (Harris, 1954 and Firth, 1957). Addressing data sparsity, static word embeddings like Word2Vec (Mikolov et al., 2013) introduced dense semantic vectors. Static embeddings, however, fail to capture polysemy (Peters et al., 2018) or compositionality (Tai et al., 2015), driving innovation towards contextual sequential modeling through RNNs (Elman, 1990) and LSTMs (Hochreiter and Schmidhuber, 1997). Subsequently, Transformers (Vaswani et al., 2017) and encoders like BERT (Devlin et al., 2019) replaced recurrence with global self-attention. These models dynamically compute contextualized representations across complete sentences, allowing non-compositional phrases to be captured. Finally, contemporary NLP utilizes autoregressive Large Language Models like GPT-3 (Brown et al., 2020), shifting the modeling paradigm from task-specific fine-tuning toward in-context learning (Raffel et al., 2020).

---

# 3. Data Representation and System Infrastructure (Word Count: 18)

This section details the underlying dataset and feature engineering frameworks that establish the foundation for subsequent modeling methodologies. 

---

## 3.1 Corpus Overview (Word Count: 108)

Da San Martino et al. (2020) introduced SemEval-2020-Task-11 and the Propaganda Techniques Corpus to evaluate pipelines identifying and classifying manipulative spans. This report takes a subset of the corpus which was collected from news articles published between 2017-2019. Our subset contains `[INSERT_NUM]` rows across two columns: `text` and `labels`. It tracks nine classifications, utilizing eight positive propaganda techniques alongside a `not_propaganda` class. Tags (`BOS` and `EOS`) define the propaganda spans while the remaining text provides sentinel context. Cleaning was restricted to removing digital artifacts to block models from exploiting backdoor publication biases. We bypassed universally normalizing grammar, spelling, or punctuation because these anomalies may encode stylistic, rhetorical intent.

> BRING IN TABLE OF LABELS AND DEFINITIONS

---

## 3.2 Whole-Word Tokenization Pipeline (Word Count: 84)

The string formatted input was tokenized to a whole-word standard using a regex tokenzier.  Preserving words as the atomic unit allows for direct evaluation of H1. Additionally, such tokenization allows us to create a baseline vocabulary which establishes the model input space. To avoid word duplication and maintain data density, tokens were case normalised and stripped of punctuation. During vocabulary construction, a frequency-threshold was applied which mapped words appearing once (Hapax Legomena) to an `<UNK>` token, doing this mitigates data sparsity and term overfitting. 

---

## 3.3 Subword Tokenization Pipeline (Word Count: 83)

To support validating H2, we implement a subword tokenization pipeline using the native SentencePiece engine of [INSERT_DeBERTa_Base_Model] with its [INCLUDE_VOCAB_SIZE] vocabulary. This setup resolves Out-of-Vocabulary (OOV) anomalies by decomposing rare terms into frequent subword units. By transferring data sparsity from vocabulary lookups to compositional sequence layers we mitigate the impact of Hapax Legomena and circumvent the limitations of Zipf's Law. This transition to semantic compositionality is vital to prevent our models from overfitting to the localized lexical biases our restricted training corpus samples.

---

## 3.4 Feature Enrichment Tagging (Word Count: 87)

Inspired by the Khosla et al. (2020) submission, to enrich the lexical signal we transform tokens into structured tuples tracking raw words, Part-of-Speech (POS), and Named-Entity-Recognition (NER). The nltk `nltk.averaged_perceptron_tagger` is used to capture syntactic anomalies and spaCy's `en_core_web_sm` to identify targeted entities. Tagging before vocabulary pruning prevents rare words from completely collapsing into the `<UNK>` token, retaining high-level intent and regularizing against specific term overfitting. In the subword pipeline we map these features to the leading head-token of each word to prevent dampening signal through tag duplication. 

---

## 3.5 Transformer Base Model: DeBERTa (Word Count: 82)

The DeBERTa architecture (He et al., 2021) is used in both tasks as a feature extractor. Pre-trained on massive text corpora, DeBERTa provides deep linguistic representations that establish semantic foundations. Importing an initalized model mitigates overfitting risks associated with training from scratch on a restricted corpus. DeBERTa uses a disentangled attention mechanism that processes word content and relative spatial positions independently. Decoupling allows the model to isolate subtle contextual shifts and syntactic anomalies where benign vocabulary is weaponized through strategic sentence placement.

---

## 3.6 Domain Adaptation (Word Count: 80)

To align DeBERTa with our news-based corpus (Da San Martino et al., 2020), we execute unsupervised domain adaptation utilizing the AG News dataset (Zhang et al., 2015). Using Hugging Face's `AutoModelForMaskedLM`, the encoder undergoes intermediate Masked Language Modeling (MLM). Dynamically masking random tokens forces the model to predict hidden subwords, calibrating its attention maps to journalistic syntax and vocabulary. This fine-tuning maximises the chance that our downstream task heads will isolate manipulation without distraction from the varied pre-training text distribution.

---

## 3.7 Data Augmentation: Silver Data (Word Count: 90)
With only `NUM` instances risking severe overfitting, we deploy a one-to-one generative data augmentation strategy to produce synthetic propaganda snippets. We build on the pre-GPT-3 (Brown et al., 2020) SemEval-2020 pipelines which relied on token substitution (Kranzlein et al. 2020) by using a zero-shot Chain-of-Thought prompting (Kojima et al. 2022 and Wei et al. 2022) on a decoder only Meta `Llama_3_8B model`. Temperature is set to $0.7$ to encourage syntactic reformulation and semantic drift, while the reasoning steps maintain rhetorical intent. The surrounding sentinel context is left untouched.

> INSERT: A TABLE CONTAINING THE EXACT FLOW OF PROMPTS and potential output

> INSERT A TABLE HERE DEMONSTATING THE VOCAB OUTPUTS GOLD, GOLD SILVER and SUBWORD (maybe)

> the goal of silver is not to expand vocab but to prodivde density and reduce number of unked tokens. Goal is to entain features for H1 eval. 

> Table X: Vocabulary and Token Statistics across Pipelines
> Metric,Whole-Word Pipeline (Gold Only),Subword Pipeline (DeBERTa),Enriched Pipeline (Gold + Silver)
> Total Tokens,[Count],[Count],[Count]
> Unique Vocabulary Size,[Count],"30,000 (Fixed)",[Count]
> Hapax Legomena Count,[Count (approx 50%)],0,[Count]
> Most Frequent Non-Stopwords,"[e.g., Trump, President]",[Subwords],"[e.g., Trump, President]"
> 
> As illustrated in Table X, the whole-word vocabulary is heavily imbalanced, with a long tail of rare words > that risk causing frequency-based classifiers to overfit. This statistical profile justifies the data augmentation strategy detailed in Section 3.3. Note that, the inclusion of silver data does not artificially expand the vocabulary breadth, but rather injects vital co-occurrence mass to strengthen the statistical signal of these vulnerable, low-frequency lexical anchors.

---

# 4. Task Methodologies (Word Count: 49)
This section outlines the architectural frameworks deployed across both experimental tasks. Task 1 (Classification) contrasts a static Word2Vec framework against a context-aware DeBERTa Transformer to evaluate static versus dynamic sequence representations. Task 2 (Joint Detection and Classification) compares a decoupled, two-stage binary pipeline against an integrated, multi-class BIO-CRF model.

---

## 4.1 Task 1: Propaganda Technique Classification (Word Count: 27)

Task 1 is a single-label, multi-class classification problem targeting the eight positive propaganda techniques. The baseline and experimental approaches are composed to iteratively test H1 and H2.

---

### 4.1.1 Baselines & Context Experimentation (Word Count: 92)

To calibrate performance, two baselines establish empirical boundaries. An unintelligent random-guessing baseline ($P = 0.125$) defines the task's mathematical floor. An intelligent unigram Bag-of-Words (BoW) baseline represents text as sparse frequency vectors to benchmark $H_1$. If isolated keywords suffice, this unordered representation will achieve competitive accuracy, rendering deep architectures redundant. 

To evaluate contextual framing, experiments, including this BoW baseline, are constructed with a snippet-isolating and complete sentence setup. Snippet isolation concentrates local rhetorical signal but increases overfitting risks, whereas incorporating neutral sentinel context acts as a regularizer to probe global syntactic dependencies.

---

### 4.1.2 Static Word Embeddings (Word2Vec) (Word Count: 127)
To mitigate Zipf's Law sparsity, Word2Vec maps semantic similarity into geometric proximity backed by the Distributional Hypothesis. As propaganda relies on localized rhetorical injections, local window optimization is preferable to global co-occurrence models (Baroni et al., 2014). This behaves as implicit matrix factorization (Levy and Goldberg, 2014), sharing statistical strength across synonyms to regularize representations over our limited corpus and recognise alternative wordings. 

We deploy pre-trained 300-dimensional Google News embeddings which function on whole-word, thus, lacking subword tokenization, is vulnerable to OOV and discarding tokens entirely. 

Sequence-level composition relies on mean pooling and since vector addition is commutative, this bag-of-embeddings approach discards word order and syntax entirely meaning the approach behaves as an enhanced test of the H1, failing to capture the non-compositional dynamics of the H2. 


---

### 4.1.3 Context-Aware Transformers (DeBERTa) (Word Count: 100)
To interrogate H2, we deploy a bi-directional encoder-only DeBERTa architecture. Its global self-attention captures complex contextual cues by maintaining parallel token connections. We exploit DeBERTa's disentangled attention mechanism to isolate syntactic anomalies where ordinary vocabulary is weaponized in non-standard grammatical frames. This decoupled content and position representation identifies structural manipulation independently of lexical features. We freeze the domain adapted encoder base parameters during training to prevent catastrophic forgetting (French, 1999) on our small dataset. Finally, we implement snippet specific mean pooling over hidden states rather than using the `CLS` token, isolating localized rhetorical triggers which are entirely contextualized from self-attention.

---

### 4.1.4 Standardized Downstream Classification Head (Word Count: 162)
To isolate representation quality from architectural bias, all Task 1 frameworks share a standardized Multi-layer Perceptron head. This network structures an input layer of $d_{\text{in}}$ nodes, a single hidden layer of $d_{\text{hidden}}$ nodes, and an output layer of eight nodes for the propaganda techniques. Given each approach features a unique embedding space, unigram baseline ($d_{\text{sem}} = \vert{}V\vert{}$), Word2Vec ($d_{\text{sem}} = 300$), or DeBERTa ($d_{\text{sem}} = 768$), the input nodes programmatically adjust to the input dimension. Recalling that our token features are structured as tuples, we concatenate the text embedding with the POS ($\mathbf{x}_{\text{POS}} \in \mathbb{R}^P$) and NER ($\mathbf{x}_{\text{NER}} \in \mathbb{R}^N$) vectors, yielding $d_{\text{in}} = d_{\text{sem}} + P + N$:

$$\mathbf{x} = [\mathbf{x}_{\text{sem}} \mathbin{\Vert} \mathbf{x}_{\text{POS}} \mathbin{\Vert} \mathbf{x}_{\text{NER}}]$$

Grounded in the Universal Approximation Theorem (Hornik et al., 2011), the single hidden layer acts as a constrained probe to prevent overfitting while resolving complex boundaries. It applies a ReLU activation for nonlinearity, dropout regularization against parameter coadaptation, and a linear projection to target logits:

$$\mathbf{h} = \text{ReLU}(\mathbf{W}_1 \mathbf{x} + \mathbf{b}_1)$$

$$\mathbf{z} = \text{Dropout}(\mathbf{h}, p)$$

$$\mathbf{s} = \mathbf{W}_2 \mathbf{z} + \mathbf{b}_2$$

A terminal Softmax normalizes these into a valid probability distribution:

$$\sigma(\mathbf{s})_i = \frac{e^{s_i}}{\sum_{j=1}^{8} e^{s_j}}$$

Optimized via Cross Entropy Loss, keeping this downstream topology consistent isolates variances to embedding frameworks and contextual capabilities.


> need to define the number of hidden layer nodes

---

## 4.2 Task 2: Joint Detection and Classification task (Word Count: 68)
Task 2 expands the experiment by introducing joint span detection. We frame this objective as a sequence labeling task utilizing the standard BIO (Beginning, Inside, Outside) encoding schema. Neutral sentinel tokens or non-propagandistic sentences are labeled `O`, the initial token of a propaganda span is tagged `B-`, and any subsequent internal tokens are marked `I-`. To capture structural context, each word is processed into a multi-feature representation tuple:

$$\mathbf{x}_i = (\text{Token}_i, \text{POS}_i, \text{NER}_i, \text{BIO}_i)$$

---

### 4.2.1 Architectural Ancestry: The Ma and Hovy Baseline (Word Count: 81)
The underlying framework for Task 2 is an adaptation of the foundational CNN-BiLSTM-CRF pipeline (Ma & Hovy, 2016). This architecture partitions language analysis across three stacked layers: a character-level CNN to extract morphological features, a Bi-directional LSTM to capture sequential context, and a Conditional Random Field (CRF) (Lafferty et al., 2001) to evaluate joint sequence probabilities. By enforcing global sequence transition constraints, this CRF globally decodes outputs and resolves the label bias problem (McCallum et al., 2000) while preserving syntactic sequence integrity. 

---

### 4.2.2 Modernized Transformer-CRF Paradigm (Word Count: 70)
To optimize boundary precision, we modernize the Ma and Hovy (2016) pipeline by replacing its sequential and convolutional layers with a DeBERTa encoder while retaining the CRF. First, SentencePiece tokenization bypasses character-level CNNs by decomposing OOV terms into sub-units. Second, global self-attention eliminates LSTM bottlenecks, preserving uncompressed, long-range context. Third, utilizing a domain-adapted encoder prevents overfitting on our small corpus. Finally, outlined previously, DeBERTa's disentangled strengths isolates syntactic propagandist anomalies.

---

### 4.2.3 Variation 1: The Decoupled Binary Pipeline (Word Count: 95)
V1 collapses all labels into a three-tag set (`B-Propaganda`, `I-Propaganda`, `O`), maximizing data density for optimizing category-agnostic boundary detection. During inference, sequences labeled entirely `O` are categorized as `not_propaganda`, while detected spans route to Task 1's optimal model for classification.

However, this approach means the model learns to generalize as a propaganda generalist, potentially overlooking linguistic cues that denote precise span delineations, resulting in less accurate "soft boundary" detection. Also, since the downstream classifier lacks a native `not_propaganda` state, this architecture risks cascading error propagation as any false-positive boundary detection forces an incorrect technique classification.


---

### 4.2.4 Variation 2: The Integrated Multi-Class BIO-CRF Model (Word Count: 84)
To bypass cascading errors, V2 evaluates boundaries and techniques simultaneously across a high-resolution 17-class space. While preserving technique-specific signals mitigates "soft boundary" errors, it re-introduces data sparsity and overfitting vulnerabilities. Under this multi-class paradigm, ambiguous boundary tokens are resolved during inference via the CRF's backward-flowing Viterbi trellis "breadcrumb effect":

$$V_t(j) = \max_{i} \left[ V_{t-1}(i) + \mathbf{T}_{i, j} \right] + \mathbf{E}_{t, j}$$

Highly confident technique predictions deeper within a span propagate backward through transition parameters $\mathbf{T}$, "pulling up" preceding boundary tokens into correct `B-` states. Correlating these rhetorical techniques with real-world syntactic boundaries directly tests H1.

> Include table of labels

---

### 4.2.5 Unintelligent Topological Baseline (Word Count: 89)
To guarantee our models capture genuine linguistic signals rather than exploiting positional artifacts, a language-blind topological baseline is constructed. Stripped of all semantic and vocabulary data, this framework utilizes a Multi-Layer Perceptron trained on structural features. These features capture the physical layout and rhythm of the text without exposing word meanings.

$$\mathbf{x}_{\text{topo}} = \left[ L_{\text{tokens}}, L_{\text{chars}}, \mu_{\text{len}}, \sigma^2_{\text{len}}, \text{CapRatio}, \text{PuncDensity}, \text{DigitRatio} \right]$$

The model predicts a start ($R_{\text{start}}$) and end ($R_{\text{end}}$) point for the snippet, as well as, a probability that the sequence is `not_propaganda` for which a $P(\text{prop}) < 0.5$ threshold is set. 

$$\hat{\mathbf{y}} = [P(\text{prop}), R_{\text{start}}, R_{\text{end}}]$$

> Table of features. > segment length (tokens count) > token variance (irregular word lenths, rythm, ) > punc density (text inside quotation marks for oversimplification or appeal to fear, or parenthetical statements) > segment length (characters) > caps ratio (noun desnity backdoor) > ratio (av word length) (think slogans for loaded language or flag-waving). 
> feature, sign, justification/proxy

---

## 4.3 Task 1 Evaluation Methodology (Word Count: 123)
Although our training corpus is balanced, real world propaganda datasets are typically highly imbalanced (Da San Martino et al., 2020). Consequently, we design an evaluation framework tailored to imbalanced test distributions. Standard accuracy is an insufficient terminal evaluation metric because it is vulnerable to masking poor minority performance behind dominant classes. In a single-label multi-class setting, Micro-averaged-$F_1$ score mathematically decomposes into global accuracy, being blind to systematic class imbalances. Macro-averaged-$F_1$ score calculates the harmonic mean of precision and recall for each class independently before averaging them. This weights categories equally ensuring that poor performance on minority classes cannot be masked. Finally, per-class precision, recall, and $F_1$ scores are logged to provide the granular diagnostic inference needed to analyze specific pipeline failures.

#### Table X: Task 1 Evaluation and Analysis Metrics

---
| Metric | Description & Role | Mathematical Equation |
| :--- | :--- | :--- |
| **Macro-Averaged $F_1$-Score** | **Primary metric:** The unweighted arithmetic mean of all per-class $F_1$-scores ($N=8$). Penalizes poor minority-class performance. | $\text{Macro-}F_1 = \frac{1}{N} \sum_{i=1}^{N} F1_i$ |
| **Micro-Averaged $F_1$ (Accuracy)** | **Secondary metric:** Global performance across all classes. Symmetrical classification errors cause it to converge with global accuracy. | $\text{Micro-}F_1 = \text{Accuracy} = \frac{\sum_{i=1}^{N} TP_i}{\text{Total Samples}}$ |
| **Per-Class Precision** ($P_i$) | Measures classification exactness for an individual propaganda technique. | $P_i = \frac{TP_i}{TP_i + FP_i}$ |
| **Per-Class Recall** ($R_i$) | Measures classification completeness or sensitivity for an individual technique. | $R_i = \frac{TP_i}{TP_i + FN_i}$ |
| **Per-Class $F_1$-Score** ($F1_i$) | The harmonic mean of precision and recall for a single category, balancing both error types. | $F1_i = 2 \times \frac{P_i \times R_i}{P_i + R_i}$ |

---

## 4.4 Task 2: Evaluation Methodology (Word Count: 115)
Fundamentally, the output objective of T2 is a classification task, identical to T1, hence, the evaluation framework is carried over. The span detection element is integrated into the framework as a qualification router. Span predictions aligning with target bounds pass to the classification evaluator while misaligned spans automatically count as mis-classifications.

Given expert human annotators only align with each other 60% of the time (Da San Martino, 2020), an exact-matching mechanism ignores the linguistic subjectivity of propaganda. Sem-Eval-11 used partial intersection matching but this risks overlooking systematically skewed predictions. Our framework enforces cascading length window-based thresholds to maintain consistency between start and end prediction evaluation. This addresses "soft-boundary" predictions whilst allowing longer snippets proportional tolerance.

| Span Length (Tokens) | Boundary Tolerance| Verification Rule |
| :--- | :--- | :--- |
| **$\le 5$** | 0 tokens | Predicted start and end indices must align perfectly with the gold span (Exact Match) |
| **$6\text{--}10$** | $\pm 1$ token | Start and end indices are allowed a 1-token tolerance in either direction |
| **$11\text{--}15$** | $\pm 2$ tokens | Start and end indices are allowed a 2-token tolerance in either direction |
| **$16\text{--}50$** | Step-wise scaling | Tolerance scales linearly, $+1$ token offset per 5 additional tokens. |
| **$> 50$** | $\pm 10$ tokens | Boundary tolerance caps out at a maximum window of 10 tokens. |
---















<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

# Remaining Report Structure
5.1. Task 1: Technique Classification Performance
- Presentation of the macro-$F_1$, micro-$F_1$, and accuracy scores.
- Comparative matrix: Random Guessing vs. BoW Baseline vs. Word2Vec vs. Frozen DeBERTa.
- Ablation rows showing the delta between Snippet-Isolated text and Unified Sequence (Full Context) text.
- Word2Vec risking false-positive clustering that compromises precision though synoyms where only the exact term is prop

5.2 Task 2: Joint Detection and Classification Performance
- Presentation of the sequence labeling scores.
- Comparative matrix: Topological Positional Baseline vs. Variation 1 (Decoupled Binary Pipeline) vs. Variation 2 (Integrated Multi-Class BIO-CRF).
- Dual-metric reporting: Strict CoNLL Span Matching scores side-by-side with SemEval Proportional Overlap scores.

6.1. Hypothesis Testing: $H1$ (Lexical) vs. $H2$ (Structural)
- Interpret why Word2Vec or BoW succeeded or failed on specific categories. Did Word2Vec yield high Recall but terrible Precision due to context-blind synonym mapping?
- Prove $H2$ by showing how DeBERTa's disentangled attention successfully isolated techniques that rely purely on syntactic placement rather than specific keywords.

6.2. Boundary Resolution and the "Breadcrumb Hypothesis"
- Execute your Error Ablation Study for Task 2 Variation 1. Pinpoint exactly where errors cascaded (e.g., did the binary span locator pull a false-positive span, forcing the Task 1 head to invent a label?).
- Analyze the Strict vs. Proportional overlap delta. If Variation 2 crushed Variation 1 on proportional span starts, explain how the CRF transition matrix acted as a semantic anchor for fuzzy sentence boundaries.

6.3. Downstream Impact of Data Interventions
- Evaluate the real-world utility of your Domain Adaptation (AG News) and Silver Data Augmentation (Llama-3). Did they successfully stabilize parameter optimization and curb the overfitting you predicted in Chapter 3?

7. Limitations
- 7.1. Compute and Architectural Constraints: Discuss the necessity of completely freezing the DeBERTa encoder due to dataset size, and how full-parameter fine-tuning might have altered the semantic workspace if compute/data were infinite.
- 7.2. Generative Refusal Biases in Silver Data: Dive deeper into your practical discovery from Section 3.6. Because Llama-3 has strict alignment guardrails, its structural refusals or modifications to "harmful" propaganda prompts may have introduced an artificial distribution bias into your silver data.
- 7.3. Subjectivity of the Ground Truth: Address the low inter-annotator agreement ($\gamma_s$) of the base corpus and how fuzzy human definitions bound the absolute mathematical ceiling of any neural network attempting the task. I wonder if we have access to the soft bounds created by the humans if we could create a better evaluation metric using this. 
- Error propagandattion
- topological approach in t2 baseline is very interested. 0 language understand but instread working on the abstractions of language
- span detection resevered as a route, not a direct eval. sense insight resevered for the results.


8. Future Work
- 8.1. Parameter-Efficient Fine-Tuning (PEFT): Propose using LoRA (Low-Rank Adaptation) instead of freezing the encoder entirely, allowing the model to adapt its internal attention maps to propaganda without triggering catastrophic forgetting.
- 8.2. Hybrid Top-Down Ensembles: Suggest a pipeline that utilizes the Task 1 Full-Context classifier as a global sentinel to dynamically weight or gate the token-level CRF transition paths in Task 2.
- Probably something around more silver data if its performance was any good
- reverse pipeline. classify, then span detect. dependant on full segement results
- dual pipeline, ensemble

9. Conclusion
- A concise, high-impact summary restating the core research objectives, the definitive victories of context-aware architectures over static representations, and the final verdict on your underlying linguistic hypotheses.

---

####  References

Lasswell, H.D., 1927. The theory of political propaganda. American political science review, 21(3), pp.627-631.

---

Jowett, G.S. and O'donnell, V., 2018. Propaganda & persuasion. Sage publications.

---
 
Da San Martino, G., Yu, S., Barrón-Cedeno, A., Petrov, R. and Nakov, P., 2019, November. Fine-grained analysis of propaganda in news articles. In Proceedings of the 2019 conference on empirical methods in natural language processing and the 9th international joint conference on natural language processing (EMNLP-IJCNLP) (pp. 5636-5646).

---
 
Da San Martino, G., Barrón-Cedeño, A., Wachsmuth, H., Petrov, R. and Nakov, P., 2020, December. SemEval-2020 task 11: Detection of propaganda techniques in news articles. In Proceedings of the fourteenth workshop on semantic evaluation (pp. 1377-1414).

---
 
Rashkin, H., Choi, E., Jang, J.Y., Volkova, S. and Choi, Y., 2017, September. Truth of varying shades: Analyzing language in fake news and political fact-checking. In Proceedings of the 2017 conference on empirical methods in natural language processing (pp. 2931-2937).

---
 
Sag, I.A., Baldwin, T., Bond, F., Copestake, A. and Flickinger, D., 2002, February. Multiword expressions: A pain in the neck for NLP. In International conference on intelligent text processing and computational linguistics (pp. 1-15). Berlin, Heidelberg: Springer Berlin Heidelberg.

---
 
Miller, G.A., 1995. WordNet: a lexical database for English. Communications of the ACM, 38(11), pp.39-41.

---
 
Harris, Z.S., 1954. Distributional structure. Word, 10(2-3), pp.146-162.

---
 
Firth, J.R., 1957. A synopsis of linguistic theory. Studies in linguistic analysis, Special volume of the philological society/Blackwell.

---
 
Mikolov, T., Chen, K., Corrado, G. and Dean, J., 2013. Efficient estimation of word representations in vector space. arXiv preprint arXiv:1301.3781.

---
 
Elman, J.L., 1990. Finding structure in time. Cognitive science, 14(2), pp.179-211.

---
 
Hochreiter, S., 1997. Long short-term memory. Neural Computation MIT-Press.

---
 
Ma, X. and Hovy, E., 2016, August. End-to-end sequence labeling via bi-directional lstm-cnns-crf. In Proceedings of the 54th Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers) (pp. 1064-1074).

---
 
Graves, A. and Schmidhuber, J., 2005. Framewise phoneme classification with bidirectional LSTM and other neural network architectures. Neural networks, 18(5-6), pp.602-610.

---
 
Lafferty, J., McCallum, A. and Pereira, F.C., 2001. Conditional random fields: Probabilistic models for segmenting and labeling sequence data.

---
 
McCallum, A., Freitag, D. and Pereira, F.C., 2000, June. Maximum entropy Markov models for information extraction and segmentation. In Icml (Vol. 17, No. 2000, pp. 591-598).

---
 
Vaswani, A., Shazeer, N., Parmar, N., Uszkoreit, J., Jones, L., Gomez, A.N., Kaiser, Ł. and Polosukhin, I., 2017. Attention is all you need. Advances in neural information processing systems, 30.

---
 
Devlin, J., Chang, M.W., Lee, K. and Toutanova, K., 2019, June. Bert: Pre-training of deep bidirectional transformers for language understanding. In Proceedings of the 2019 conference of the North American chapter of the association for computational linguistics: human language technologies, volume 1 (long and short papers) (pp. 4171-4186).

---
 
He, P., Liu, X., Gao, J. and Chen, W., 2020. Deberta: Decoding-enhanced bert with disentangled attention. arXiv preprint arXiv:2006.03654.

---
 
Brown, T., Mann, B., Ryder, N., Subbiah, M., Kaplan, J.D., Dhariwal, P., Neelakantan, A., Shyam, P., Sastry, G., Askell, A. and Agarwal, S., 2020. Language models are few-shot learners. Advances in neural information processing systems, 33, pp.1877-1901.

---
 
Raffel, C., Shazeer, N., Roberts, A., Lee, K., Narang, S., Matena, M., Zhou, Y., Li, W. and Liu, P.J., 2020. Exploring the limits of transfer learning with a unified text-to-text transformer. Journal of machine learning research, 21(140), pp.1-67.

---
 
Tai, K.S., Socher, R. and Manning, C.D., 2015, July. Improved semantic representations from tree-structured long short-term memory networks. In Proceedings of the 53rd Annual Meeting of the Association for Computational Linguistics and the 7th International Joint Conference on Natural Language Processing (Volume 1: Long Papers) (pp. 1556-1566).

---
 
Peters, M.E., Neumann, M., Zettlemoyer, L. and Yih, W.T., 2018. Dissecting contextual word embeddings: Architecture and representation. In Proceedings of the 2018 conference on empirical methods in natural language processing (pp. 1499-1509).

---

References to add:
- LTIatCMU(SI:4) (Khosla et al., 2020)
- Team UPB(SI:5) (Paraschiv and Cercel, 2020)
- Team DoNotDistribute(SI:22) (Kranzlein et al., 2020)
- (Brown et al., 2020)



--- 

# Apdendix 

#### Propaganda Technique Definitions According to Da San Martino et al. (2020) (Word Count: 221)
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
--- x