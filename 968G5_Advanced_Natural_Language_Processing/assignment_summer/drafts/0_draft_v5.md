# 1 Introduction (Word Count: 104)
Propaganda is the deliberate, systematic attempt to shape perceptions, manipulate cognitions, and direct behavior to achieve a response that furthers the desired intent of the propagandist (Jowett & O'Donnell, 2018). It involves managing collective attitudes by manipulating significant symbols (Lasswell, 1927) and using rhetorical devices to bypass rational analysis rather than relying on outright falsehoods. 

Given the velocity and volume of modern digital information, automated detection mechanisms are increasingly vital for maintaining the integrity of online discourse. This report explores automatically identifying propaganda through two core challenges: classifying known propagandistic snippets (Task 1) and jointly identifying manipulative spans and techniques within raw text (Task 2).

---

## 1.1 Problem Outline and Academic Context (Word Count: 145)
Automating this detection is difficult due to the subjective boundary between legitimate persuasion and manipulative rhetoric (Da San Martino et al., 2019). 

Historically, detection operated at the macro-level, classifying entire documents (Rashkin et al., 2017). However, this is largely inappropriate for contemporary moderation as propaganda rarely manifests as a uniform, document-wide sentiment, instead relying on localized, fine-grained rhetorical shifts.

Addressing this, Da San Martino et al. (2020) introduced SemEval-2020 Task 11 and the Propaganda Techniques Corpus (PTC), requiring researchers to construct pipelines which identify manipulative span boundaries within text segments and map them to a propaganda technique label space. 

A significant hurdle in this fine-grained detection is propaganda's structural irregularity. Examples frequently sacrifice grammatical completeness for rhetorical impact, relying heavily on non-compositional Multi-Word Expressions (MWEs) (Sag et al., 2002) and domain-specific words or expressions, introducing substantial Out-of-Vocabulary (OOV) challenges for traditional Natural Language Processing (NLP).

---

## 1.2 Hypotheses (Word Count: 61)
To guide the methodologies and experimentation, this report evaluates aginst two hypotheses:

| Hypothesis | Title | Definition | 
| :--- | :--- | :--- | 
| **H1** | Lexical Trigger Hypothesis | Propaganda is defined by specific, emotionally charged "trigger" words. | 
| **H2** | Structural Irregularity Hypothesis | Propaganda relies on syntactic departures and non-compositionality. |

The success of H2 can only be acheived by context aware implementations, where as, H1 can be fufulled by simple vocabulary-based approaches. 

---

## 1.3 Report Structure
UNF

---

# 2 Related Work: Evolution of NLP Computational Methods (Word Count: 187)
NLP has evolved from symbolic taxonomies like WordNet (Miller, 1995) to statistical representations rooted in the Distributional Hypothesis (Harris, 1954; Firth, 1957). To address data sparsity, static word embeddings like Word2Vec (Mikolov et al., 2013) introduced dense semantic vectors. However, static embeddings fail to capture polysemy (Peters et al., 2018) or compositionality (Tai et al., 2015), driving an evolution toward sequential modeling via RNNs (Elman, 1990) and LSTMs (Hochreiter & Schmidhuber, 1997). For sequence labeling, Ma and Hovy (2016) integrated character-level CNNs to mitigate out-of-vocabulary constraints with BiLSTMs (Graves & Schmidhuber, 2005) and a Conditional Random Field (CRF) layer (Lafferty et al., 2001). This CRF globally decodes outputs, resolving the label bias problem (McCallum et al., 2000) while preserving syntactic sequence integrity.

Subsequently, Transformers (Vaswani et al., 2017) and encoders like BERT (Devlin et al., 2019) and DeBERTa (He et al., 2020) replaced recurrence with global self-attention. These models dynamically compute contextualized representations across complete sentences, effectively isolating non-compositional phrases. Finally, contemporary NLP utilizes autoregressive Large Language Models (LLMs) like GPT-3 (Brown et al., 2020), shifting the modeling paradigm from task-specific fine-tuning toward in-context learning (Raffel et al., 2020).

---





# 3. Data Representation and System Infrastructure (Word Count: 1118)
This section details the underlying dataset(s), baseline embeddings, and feature engineering protocols that establish the foundation for all subsequent modeling experiments. Task-specific integration are detailed and justified within Section 4 (Methodology).

---

## 3.1 Corpus Overview (Word Count: 135)
The dataset is a subset of the Propaganda Techniques Corpus (PTC) compiled for SemEval-2020 Task 11 (Da San Martino et al., 2020), originally harvested from news articles published between mid-2017 and early 2019. The resulting corpus contains `[INSERT_NUM]` rows across two columns: `text` and `label`. The label field tracks nine distinct classifications, utilising eight positive propaganda techniques alongside a neutral `not_propaganda` class.

Within the string-formatted text column, explicit <BOS> and <EOS> tags delineate the boundaries of active propaganda spans with text outside these markers containing non-propagandistic sentinel context. Data cleaning was restricted to removing superficial digital artifacts and HTML formatting to prevent downstream models access backdoor signals from the original publication. No universal preprocessing was applied to normalize grammar, punctuation, or spelling anomalies, as these stylistic variations frequently encode critical rhetorical intent and manipulative nuance.

---

## 3.2 Whole-Word Tokenization Pipeline (Word Count: 88)
The string formatted input was tokenized to a whole-word standard using a regex tokenzier. Preserving words as the atomic unit allows for direct evaluation of H1. Additionally, such tokenization allows us to create a baseline vocabulary which establishes the model input space. To avoid word duplication and maintain data density, tokens were case normalised and stripped of punctuation. During vocabulary construction, a frequency-threshold was applied which mapped words appearing once (Hapax Legomena) to a generic `<UNK>` token. This was done to mitigate data sparsity and risk of overfitting. 

---

## 3.3 Subword Tokenization Pipeline (Word Count: 164)
To validate the Structural Irregularity Hypothesis ($H2$), a reverse vocabulary and tokenization pipeline is implemented. A pre-initalized vocabulary is imported via [INSERT_DeBERTa_Base_Model] and has a [INCLUDE_VOCAB_SIZE]. During training and inference, the raw string inputs are processed using DeBERTa's native SentencePiece tokenizer engine.

This vocabulary represents a statistical mixture of whole words, subword units, and atomic root characters that were derived from a multi-billion-word pre-training corpus as universally frequent character chunks.

This framework resolves Out-of-Vocabulary (OOV) anomalies by decomposing rare or unseen terminology into sub-units. Further, it nullifies the impact of Hapax Legomena by transferring the burden of data sparsity from the vocabulary layer to the compositional sequence layer, successfully circumventing the structural constraints of Zipf’s Law.

While framed under tokenization for comparative readability,, this approach represents a shift in paradigm away from count-based vocabulary constraints toward compositional representations which build up meaning. For a project restricted by a small training input, this architecture is vital to avoid overfitting to the localized vocabulary sample biases inherent in a small population.

> Table X: Vocabulary and Token Statistics across Pipelines
> Metric,Whole-Word Pipeline (Gold Only),Subword Pipeline (DeBERTa),Enriched Pipeline (Gold + Silver)
> Total Tokens,[Count],[Count],[Count]
> Unique Vocabulary Size,[Count],"30,000 (Fixed)",[Count]
> Hapax Legomena Count,[Count (approx 50%)],0,[Count]
> Most Frequent Non-Stopwords,"[e.g., Trump, President]",[Subwords],"[e.g., Trump, President]"
> 
> As illustrated in Table X, the whole-word vocabulary is heavily imbalanced, with a long tail of rare words > that risk causing frequency-based classifiers to overfit. This statistical profile justifies the data augmentation strategy detailed in Section 3.3. Note that, the inclusion of silver data does not artificially expand the vocabulary breadth, but rather injects vital co-occurrence mass to strengthen the statistical signal of these vulnerable, low-frequency lexical anchors.

---

## 3.4 Feature Enrichment Tagging (Word Count: 170)
To augment the lexical signal, tokens are transformed into structured tuples tracking raw words, Part-of-Speech (POS) tags, and Named Entity Recognition (NER) statuses, drawing inspirational from Team LTIatCMU (Khosla et al., 2020). POS mapping via `nltk.averaged_perceptron_tagger` (Penn Treebank) exposes the syntactic irregularities typical of computational rhetoric, while the NER layer utilizes spaCy's en_core_web_sm to isolate targeted figures, organizations, or locations weaponized to exploit audience vulnerabilities.

Proper nouns often appear as singletons which Section 3.2’s pruning rules would collapse into a generic` <UNK>` token, erasing their semantic utility. Tagging tokens prior to pruning ensures the sequence retains broad entity intent. This conversion from sparse, low-frequency tokens to dense entity categories acts as a structural regularizer, enabling models to generalize rhetorical patterns without overfitting to specific word.

While computed on whole words, these tags map to the subword pipeline by anchoring exclusively to the leading head token of a segmented word. This target allocation preserves the contextual signal without introducing structural noise or tag duplication across subword components (`APPENDIX X`)

---

## 3.5 Transformer Base Model: DeBERTa (Word Count: 187)
A primary feature extraction engine utilized across the modeling pipelines for both Task 1 and Task 2 is the DeBERTa (Decoding-enhanced BERT with disentangled attention) language model architecture (He et al., 2021). 

As a large-scale, open-source transformer network pre-trained on massive multi-billion-word text corpora, DeBERTa encapsulates deep, generalized linguistic representations and syntactic patterns. By importing this pre-trained base model, the task approaches inherit a highly sophisticated semantic foundation.

Architecturally, DeBERTa is uniquely suited to capturing manipulative text due to its disentangled self-attention mechanism. Unlike traditional transformer variants that merge a token's semantic content and absolute position into a single vector, DeBERTa calculates attention weights by processing word content and relative sequence positions independently. This empowers the network to isolate non-standard syntactic anomalies, subtle contextual shifts, and emotional framing where ordinary, benign vocabulary is weaponized through strategic placement within a sentence.

Furthermore, deploying a deep, pre-trained model resolves the severe mathematical constraints imposed by our limited training dataset volume. Training deep models from scratch on a restricted corpus introduces a risk of catastrophic overfitting, as the network's optimization quickly prioritizes memorizing localized sample biases over learning generalizable abstractions.

---

## 3.6 Domain Adaptation (Word Count: 172)
A primary advantage of Transformer architectures is their capacity for domain adaptation via unsupervised fine-tuning. While baseline language models possess broad linguistic capabilities, their weights reflect a generalized text distribution. Given our corpus was collected from news sources (Da San Martino et al., 2020), the encoder is fine-tuned to a journalistic domain using the AG News dataset (Zhang et al., 2015).

The base model undergoes an intermediate unsupervised training pass using a Masked Language Modeling (MLM) objective via the Hugging Face `AutoModelForMaskedLM` abstraction. Dynamically masking random tokens forces the network to predict hidden subwords based on surrounding syntax, recalibrating DeBERTa’s internal attention maps to capture the stylistic distributions of professional journalism.

This intermediate pass directly addresses the mathematical constraints of our restricted data pool. Rather than optimizing task-specific parameters from scratch, the MLM loop leverages the structural volume of the AG News dataset to master domain-specific vocabulary, sentence lengths, and formatting layouts. This establishes a robust semantic foundation, ensuring downstream task heads isolate active ideological manipulation without distraction from baseline domain variances.

---

## 3.7 Data Augmentation: Silver Data (Word Count: 202)
With just NUM instances across eight propaganda labels, dataset scarcity risks severe overfitting on this nuanced NLP task. Over-indexing on sample terms introduces a structural bias that could jeopardize H1 regardless of architecture. To counter this, a one-to-one generative data augmentation strategy adds `NUM` instances to amplify vocabulary signals.

This aligns with SemEval-2020 Task 11, where Team UPB deployed masked language modeling (Paraschiv and Cercel, 2020) and Team DoNotDistribute gained a 5% boost via 3,000 silver instances (Kranzlein et al., 2020). Preceding causal architectures like GPT-3 (Brown et al., 2020), legacy competition frameworks were confined to encoder-based token-substitution heuristics (e.g. T5, BERT, WordNet).

Diverging from legacy methods, this framework utilizes zero-shot Chain-of-Thought prompting (Kojima et al., 2022; Wei et al., 2022) on a decoder-only LLM to reformulate syntax and capture semantic drift without altering rhetorical intent. Multi-step reasoning ensures cohesion with the unaltered sentinel context. As illustrated in Table X, the model conditions generation on contextual boundaries to mutate only the snippet, keeping the segment's meaning intact.

The pipeline deployed `Meta-Llama-3-8B` at a $0.7$ temperature to balance coherence and variability. To counter safety-alignment refusals common when prompting public LLMs with propagandistic text, a programmatic three-try re-prompting loop was integrated.

> INSERT: A TABLE CONTAINING THE EXACT FLOW OF PROMPTS

---

















---

# 4. Task Methodologies
This section outlines the architectural frameworks deployed across both experimental tasks. Task 1 (Classification) contrasts a static Word2Vec framework against a context-aware DeBERTa Transformer to evaluate static versus dynamic sequence representations. Task 2 (Joint Detection and Classification) compares a decoupled, two-stage binary pipeline against an integrated, multi-class BIO-CRF model.


> 4.1 Task 1: Propaganda Technique Classification (Baselines, Word2Vec, DeBERTa, heads)
> 4.2 Task 2: Joint Detection and Classification (BIO parsing, Decoupled vs Integrated)
> 4.3 Experimental Setup and Evaluation Framework
> 4.3.1 Classification Metrics (Macro vs Micro $F_1$ justification)
> 4.3.2 Sequence Labeling Metrics (Strict CoNLL vs SemEval Proportional Overlap justification)
"Your system should identify both the span and the propaganda technique used"
> 4.3.3 The Topological Positional Baseline (Your language-blind control group)

---

## 4.1 Task 1: Propaganda Technique Classification

Task 1 is as a single-label, multi-class classification problem targeting the eight positive propaganda techniques. This task serves as the empirical foundation to test the explanatory power of the Lexical Trigger Hypothesis ($H1$) against the Structural Irregularity Hypothesis ($H2$).

---

### 4.1.1 Baselines & Context Experimentation (Word Count: 93)

To calibrate performance, two baselines establish empirical boundaries. An unintelligent random-guessing baseline ($P = 0.125$) defines the task's mathematical floor. An intelligent unigram Bag-of-Words (BoW) baseline represents text as sparse frequency vectors to benchmark the Lexical Trigger Hypothesis ($H_1$). If isolated keywords suffice, this unordered representation will achieve competitive accuracy, rendering deep architectures redundant. To evaluate contextual framing, all qualifying approaches compare a snippet-isolated setup against the complete sentence. Snippet isolation concentrates local rhetorical signal but increases overfitting risks, whereas incorporating neutral sentinel context acts as a regularizer to probe global syntactic dependencies.

---

### 4.1.2 Static Word Embeddings (Word2Vec) (Word Count: 202)
To bypass Zipf's Law sparsity, Word2Vec (Mikolov et al., 2013) projects semantic similarity into geometric proximity via the Distributional Hypothesis (Harris, 1954; Firth, 1957). Since propaganda manifests as localized rhetorical injections rather than global topics, local window optimization is preferable to global co-occurrence models (Baroni et al., 2014). This optimization behaves as implicit matrix factorization (Levy & Goldberg, 2014), sharing statistical strength across synonyms to regularize representations over our limited corpus.

Sequence-level composition relies on mean pooling. With vector addition being commutative, this Bag-of-Embeddings approach discards word order and syntax. Although context-aware during pre-training, these are static embeddings remain context-blind at inference. This is a "vocabulary-plus" paradigm that is structurally incapable of capturing the non-compositional dynamics underlying the Structural Irregularity Hypothesis ($H_2$), serving strictly as an enhanced test of the Lexical Trigger Hypothesis ($H_1$).

We deploy pre-trained, 300-dimensional Google News embeddings, applying case normalization and punctuation removal to maximize vocabulary alignment. Without subword tokenization, the model is highly vulnerable to Out-of-Vocabulary (OOV) errors as unseen tokens are discarded entirely, sacrificing the abstract POS/NER footprints preserved by the baseline. Empirically, Word2Vec should yield higher Recall than the baseline by resolving synonymous triggers, but its context-blindness risks false-positive clustering on neutral text, compromising Precision.

---

### 4.1.3 Context-Aware Transformers (DeBERTa) (Word Count: 173)
To test the Structural Irregularity Hypothesis ($H_2$), we deploy the bidirectional, encoder-only DeBERTa architecture introduced in Section 3.5. Unlike recurrent models limited by context decay, global self-attention (Vaswani et al., 2017) maintains uncompressed, parallel token connections to capture the dual-contextual cues vital for detecting subtle rhetorical framing.

Rather than redefining DeBERTa's mechanics, we exploit its disentangled attention mechanism (Section 3.5) to isolate syntactic anomalies. Propaganda typically weaponizes ordinary vocabulary within non-standard grammatical frames, thus, DeBERTa's decoupled content and position representations allow the model to identify structural manipulation independently of raw lexical features.

Leveraging our domain-adapted encoder (Section 3.6), we freeze its base parameters during task training. This preserves DeBERTa's pre-trained linguistic worldview while mitigating catastrophic forgetting (French, 1999) on our small target dataset, leaving only the downstream classification head (Section 4.1.4) to optimize.

Finally, we reject the default [CLS] token, which prioritizes global semantic summaries. Instead, we implement snippet-specific mean pooling over the span's hidden feature states, isolating the concentrated rhetorical trigger while preserving the bidirectional sentence-level context.

---

### 4.1.4 Standardized Downstream Classification Head

To isolate representation quality from architectural bias, all Task 1 frameworks share an identical Multi-Layer Perceptron (MLP) head. Element-wise mean pooling standardizes variable-length token sequences into a uniform semantic centroid $\mathbf{x} \in \mathbb{R}^{d_{\text{in}}}$, matching each architecture’s native dimensionality: unigram ($d_{\text{in}} = \vert{}V\vert{}$), Word2Vec ($d_{\text{in}} = 300$), and DeBERTa ($d_{\text{in}} = 768$).

Grounded in the Universal Approximation Theorem (Hornik et al., 1989), a single hidden layer acts as a constrained probe, preventing overfitting on our restricted dataset while resolving complex boundaries. It applies a ReLU activation for non-linearity, dropout regularization against parameter co-adaptation, and a linear projection to target logits:

$$\mathbf{h} = \text{ReLU}(\mathbf{W}_1 \mathbf{x} + \mathbf{b}_1)$$

$$\mathbf{z} = \text{Dropout}(\mathbf{h}, p)$$

$$\mathbf{s} = \mathbf{W}_2 \mathbf{z} + \mathbf{b}_2$$

Here, $\mathbf{W}_1$ and $\mathbf{b}_1$ project the centroid into a $d_{\text{hidden}}$-dimensional space, $p$ is the dropout rate, and $\mathbf{W}_2 \in \mathbb{R}^{8 \times d_{\text{hidden}}}$ maps the regularized features to the eight class logits. A terminal Softmax normalizes these into a valid probability distribution:

$$\sigma(\mathbf{s})_i = \frac{e^{s_i}}{\sum_{j=1}^{8} e^{s_j}}$$

Optimized via Cross-Entropy Loss against the gold labels, keeping this downstream topology mathematically constant guarantees that empirical variances stem strictly from the upstream embeddings' semantic and contextual capacities.

---



























---

### 4.1.5. Evaluation Approach and Metrics Justification

To rigorously benchmark the performance of the classification models and provide a clear, empirical foundation for testing the core hypotheses, this report establishes a multi-tiered validation matrix.

While the overarching dataset is heavily skewed by the dominant not_propaganda class, Task 1 filters the corpus to evaluate only the remaining positive labels, as the objective is to classify known instances of propaganda.

In this isolated subset, the remaining eight categories exhibit a mostly balanced distribution.

However, because historical literature on fine-grained propaganda detection typically features severely skewed class distributions (Da San Martino et al., 2020), it is vital to design an evaluation methodology that remains robust across both balanced and imbalanced contexts.

##### Primary Optimization Metric: Macro-Averaged $F_1$-Score

The primary evaluation objective for Task 1 is the Macro-Averaged $F_1$-score.

Macro-averaging treats every individual propaganda technique category as equally important, calculating performance metrics completely independent of the underlying sample volumes.

Mathematically, computing the $F_1$-score for each category independently and taking their arithmetic mean forces the models to demonstrate genuine proficiency across all eight techniques.

$$\text{Macro-}F_1 = \frac{1}{8} \sum_{i=1}^{8} F1_{\text{class}_i}$$

This metric acts as a crucial architectural safeguard. If a model performs excellently on high-frequency semantic cues but completely fails on a rare structural fallacy technique, the macro-$F_1$ score will drop severely, effectively punishing the network for neglecting minority classes.

Consequently, it remains the gold standard for scientific research and model comparison.

##### Secondary Metric: Micro-Averaged $F_1$-Score and Accuracy Alignment

To evaluate global system robustness, the Micro-Averaged $F_1$-score is tracked concurrently.

In a single-label, multi-class framework, because every classification error simultaneously generates a False Positive for the predicted class and a False Negative for the true label, the Micro-$F_1$ metric converges to become mathematically identical to global Accuracy: 

$$\text{Micro-}F_1 = \text{Accuracy} = \frac{\sum_{i=1}^{8} TP_i}{\text{Total Samples}}$$

Because the Task 1 sub-corpus is balanced, the Macro-$F_1$ and Accuracy (Micro-$F_1$) metrics will track closely in tandem, as no single category skews the global mean. Under these controlled conditions, the model cannot artificially inflate its score by over-predicting a single dominant category.

However, tracking both remains structurally important to highlight a model's error distribution. While Accuracy cares exclusively about global True Positives ($\sum TP$) regardless of where the mistakes occur, Macro-$F_1$ computes the harmonic mean of Precision and Recall per class before averaging.

Because the harmonic mean heavily penalizes extreme imbalances between Precision and Recall, Macro-$F_1$ and Accuracy can slightly split even under perfect class balance if a model yields asymmetrical error rates across specific categories.

##### Granular Per-Class Diagnostics

To prevent the evaluation from collapsing into a single condensed metric, the evaluation suite extracts a separate Precision, Recall, and $F_1$-score for each of the eight propaganda techniques individually.

This granular, per-label breakdown serves as a vital diagnostic tool for the forthcoming Results and Error Analysis sections.

Rather than evaluating the architectures as monoliths, this per-class decomposition allows for localized interrogation of model behavior.

For instance, it provides the precise empirical substrate needed to differentiate our approaches: testing whether Word2Vec’s continuous space artificially inflates Recall at the expense of Precision due to context-blind synonym mapping, or whether DeBERTa's bidirectional self-attention successfully isolates the structural irregularities of more complex, non-compositional techniques.

> NOTE, there is a really interesting result that impacts task 2. In the second tasks we need to identify the span and label. If the models are better at identify the label with the entire sentence then this has impacts for the approaches taking in task 2. If we can label the sequence better using the raw segement, then this information can be used to guide the sequence tagging for the span. 

---























## 4.2 Task 2: Joint Detection and Classification task

**Brief:** *Build and evaluate either 2 different approaches or at least 2 variations on a single approach to detecting propaganda within a sentence. Your system should identify both the span and the propaganda technique used.*

> IMPORTANT: IT HASNT BEEN OUTLINED IN THE T2 DRAFT YET BUT IN T1 WE EXPERIEMENT WITH CONTEXT + SNIPPET VS SNIPPET ONLY. WE HAVE THE CHANCE TO DO THIS AGAIN IN THIS TASK IN SLIGHTLY DIFFERENT WAY.

> T1 THE DECISION WAS ABOUT WHETHER TO TRAIN ON WHICH TYPE.

> HOWEVER T2 WE CAN RUN THE CLASSIFER (VAR 1) ON THE FULL SEGMEMENT VS SNIPPET.

> THIS IS IMPORTANT BECAUSE IT BUILDS IN A POTENTIAL SAFEGUARD AGAINST ERROR PROPAGATION. 

> PICK UP TWO MODELS FROM T1. BEST PERFORMING SNIPPET, BEST PERFORMING FULL. CAN EXPLORE THE INSTANCES WHERE THE TWO DISAGREE. DOES THE FULL DISAGREE WHEN THERE IS AN ERROR WITH THE SPAN

> MAYBE THIS IS AN EXTENSION FOR THE RESULTS RATHER THAN EVAL ONLY


Task 2 expands the report scope from single-label sequence classification (Task 1) to a joint sequence labeling and classification paradigm.

Fundementally, the task is a token-level Sequence Labeling task which will utilize the BIO (Beginning, Inside, Outside) encoding format. 

This means the corpus text undergoes some data preprocessing. Tokens which represent the sentinal tokens or `not_propaganda` snippets are tagged with `O`. The first token within a propaganda snippet is tagged with `B-` and any following tokens within the snippet are tagged with `I-`.

Standard BIO frameworks do not model an end tag hence the the last token in the snippet would be identified by a transition from `I-` to `O` (or `B-`to `O` for 1 word snipets)

To clarify, in this task, each token is represented as a tuple which holds the following:
- Token
- POS Tag
- NER Tag
- BIO Tag

To initalize the methodology of approaches for this task, I start with and adapt the foundational Ma and Hovy (2016) CNN-Bi-LSTM-CRF architecture into a modernized Transformer-CRF framework.

From which I derive two competing variations.

The first is a two-stage architecture that isolates span boundaries using a minimal, data-dense three-tag binary set before passing the extracted fragments to the optimal classifier from Task 1. 

Semantically, this approach navigates a deriviative of our original H1. The model will be trained to identify language that is uniquely propagandist but without any notion of the techique exhibited. Hence, it is predicated on the idea that it is the words themselves that hold the true signal to identify propaganda. 

The second variation is an integrated mutli-class BIO-CRF model that maps text segments across an expanded token-tagging space which sees the baseline BIO tags combined with propagand techniques. Hencefourth, integrating the classifcation and span detection into a single forward pass.

This approach interogates H2 as it relies heavily on the combination of tokens and tags to detmine a final prediciton. This will be explained in more detail in [LATER SECTION]

---

### 4.2.1 Architectural Ancestry: The Ma and Hovy Baseline

This methodology adapts the architectural lineage of the foundational CNN-BiLSTM-CRF framework introduced by Ma and Hovy (2016). This classical sequence labeling blueprint achieves its end-to-end efficacy by partitioning language analysis across three specialized, hierarchically stacked processing layers:

**Character-Level Convolutional Neural Network (CNN):** Operates as a localized feature extractor that scans the constituent characters of words to isolate sub-word morphological regularities. This layer detects capitalization patterns, prefixes, and suffixes, providing a vital signal for identifying the irregular linguistic and orthographic formatting hypothesized in $H2$

**Bidirectional LSTM (Bi-LSTM):** Processes the sequence of word tokens sequentially from both forward and backward directions. By maintaining dual hidden states, this recurrent network captures sentence-level contextual flow and maps long-range dependencies across the sequence.

**Conditional Random Field (CRF) Decoder:** Functions as the terminal sequence predictor. Instead of calculating isolated token judgments, the CRF layer implements global normalization to evaluate the joint probability of the entire output tag sequence. It utilizes a learned Transition Matrix to enforce structural logic over the predicted labels, systematically preventing illegal sequence breaks (such as a continuation tag I- following an outside tag O)

This classic configuration is uniquely suited to handling the "soft boundary" dilemma inherent in propaganda span identification. The deep recurrent layer identifies high-confidence semantic cues within the core of a manipulative fragment, while the CRF layer utilizes its transition parameters to "knit" those signals back to the highly ambiguous beginning (B-) and trailing edges of the targeted text frame.

---

### 4.2.2 Modernized Transformer-CRF Paradigm

To optimize boundary precision and structural resolution, I modernize the Ma and Hovy (2016) pipeline by substituting the sequential and convolutional layers with a deep Transformer encoder (DeBERTa) while keeping the global decoding properties of the terminal CRF layer intact. This structural shift is justified by four concise engineering advantages directly calibrated to the constraints of the propaganda corpus:

1. SentencePiece tokenization completely bypasses the need for a separate character-level CNN. By decomposing rare, out-of-vocabulary (OOV) terms into frequent, universally known subword chunks, the model resolves vocabulary-level data sparsity and eliminates the need for manual feature-extraction networks.
2. LSTMs compress text sequentially, introducing an information bottleneck vulnerable to sequential context decay and recency bias. Conversely, global self-attention calculates a parallel, all-to-all sequence matrix, giving every token a direct, uncompressed line of sight to every other token. This is critical for capturing the abstract, long-range word pairings that denote manipulative rhetorical intent.
3. Training deep recurrent models from scratch on our limited dataset is infeasible due to catastrophic overfitting risks. Utilizing a massive Transformer backbone tapers this constraint by introducing a pre-trained linguistic worldview, which is structurally adapted to our target era via the intermediate Domain Adaptation news corpus (Section 3.5)
4. While LSTMs fuse word semantics and sequence location together, DeBERTa utilizes Disentangled Attention to evaluate content and relative position independently. This decoupled spatial awareness is highly effective for validating the Structural Irregularity Hypothesis ($H2$), allowing the architecture to isolate manipulative phrases where ordinary vocabulary is weaponized purely through anomalous syntactic placement.

---

### 4.2.3 Variation 1: The Decoupled Binary Pipeline

This approach optimizes boundary detection data density by collapsing all eight propaganda categories into a single three-tag binary set containing `B-Propaganda`, `I-Propaganda`, and `O`.

During data preprocessing, the single token immediately succeeding the <BOS> marker is designated as B-Propaganda, while subsequent internal tokens are labeled I-Propaganda.

All sentential context outside these markers is mapped to O, and for not_propaganda sentences, every token is systematically labeled O.

During testing, text blocks returning entirely O tags bypass the secondary classifier and are cataloged directly as not_propaganda.

Collapsing labels maximizes the available training volume and isolates generic manipulative deviations from standard text, yet it blends distinct rhetorical signatures into a propaganda generalist. This lack of granular resolution introduces the risk of soft boundaries with blurred start and end coordinates. Furthermore, it creates a vulnerability to cascading error propagation where if the binary detector extracts a false-positive neutral text span, the downstream Task 1 classifier, which lacks a native `not_propaganda` output neuron is mathematically forced to assign an incorrect propaganda technique.

--- 

### 4.2.4 Variation 2: The Integrated Multi-Class BIO-CRF Model

The second variation evaluates span boundaries and technique classifications simultaneously across a high-resolution 17-class space comprised of eight positive techniques mapped to beginning and inside transitions plus a single global O tag.

To neutralize the label bias problem inherent in locally normalized independent Softmax token choices, a terminal Conditional Random Field (CRF) layer performs global sequence optimization.

This architecture combines localized token probabilities from the DeBERTa encoder (Emission Scores, $E$) with a learned structural rule-book (Transition Matrix, $T$) to score the conditional probability of the entire joint label sequence path:

$$P(Y|X) = \frac{\exp\left(\sum_{t=1}^{T} T_{y_{t-1}, y_t} + \sum_{t=1}^{T} E_{t, y_t}\right)}{Z(X)}$$

While expanding the tagset introduces data sparsity, it preserves technique-specific footprints to counter soft boundary bugs. Ambiguous boundary tokens trigger the breadcrumb effect; when the encoder identifies a high-confidence semantic core deeper in the span, the Viterbi algorithm executes a backward-flowing dynamic programming trellis optimization:

$$V_t(j) = \max_{i} \left[ V_{t-1}(i) + T_{i, j} \right] + E_{t, j}$$

The structural parameters of certain core tokens mathematically pull up the joint probabilities of preceding boundary words, forcing them into their correct technique-specific B- states.

This technique-specific resolution is further enhanced by compounding token vectors with the Part-of-Speech and Named Entity Recognition tags defined in Section 3.2. This allows the integrated model to correlate distinct propaganda techniques with real-world syntactic boundaries, such as matching a span of loaded_language to a noun phrase closure. Ultimately, the breadcrumb effect optimizes precision at span starts, while the combination of syntactic tags and transition matrix parameters stabilizes span endpoints.

---

### 4.2.5 Implementation

Code, packages, hyperpara, NN settings, epochs, loss equation. 


> Initialize your single, frozen DeBERTa base model.
> 
> For Task 1: Attach your MLP Classification Head, train only those head weights, and save them.
> 
> For Task 2 (Variation 1): Attach a 3-dimensional Linear Projection layer + a Binary CRF layer, and train only those new decoder weights. To run step two of the decoupled pipeline, you simply load your saved Task 1 classification head and pass the extracted span through it.
> 
> For Task 2 (Variation 2): Attach a 17-dimensional Linear Projection layer + a Multi-class CRF layer, and train only that decoder network.

---

### 4.2.6 Evaluation

For the classification component repeat Task 1 approach


Main differential issue is that Task 2 Span Identification includes the `not_propaganda` class hence O (Outside) tags will be vastly dominatant in the input space. 


A span could be taken as an an atomoic unit as is the approach in Named Entity Recognition (NER) metric rules (like the CoNLL-2003 standard). A predicted span is registered as a True Positive (TP) if, and only if, its exact start token index, its exact end token index. Additionally, this could be combined to evaluating the span and classfication in tandem, i.e. TP if span and classifcation are exactly correct. A single span misalignment causes a False Positive. This metric is highly punitive, but it is necessary for checking whether your model captures the true core of a rhetorical device without bleeding into neutral sentences.

The alternative is a proportional overlap evaluation which was the SemEval standard approach. Propaganda spans have highly ambiguous, subjective boundaries ("soft boundaries"), exact word-for-word matching can hide actual model capabilities.

> There is something here the claim in Da San Martino (2019) SemEval and in constructing the training data, human annotators only agreed on something 60% of the time.

>  In their foundational work, Da San Martino et al. (2019) documented that initial inter-annotator agreement for exact propaganda span boundaries yielded remarkably low Gamma values ($\gamma_s$ falling between $0.24$ and $0.34$). This required a rigorous multi-phase consolidation process with expert linguists just to establish a viable ground truth.  

> By highlighting this in your evaluation section, you provide a bulletproof academic justification for running both Strict and Proportional Overlap metrics. Exact matching (CoNLL style) is an excellent benchmark for measuring strict structural engineering discipline, but it is fundamentally at odds with the linguistic reality of the problem. If human experts struggle to isolate where a sequence of Loaded Language begins or ends, penalizing a neural network with a score of zero for capturing $90\%$ of a subjective boundary hides its true capability.


If a model captures $90\%$ of a massive Appeal to Fear span, it shouldn't be penalized with a score of zero. The SemEval-2020 Task 11 framework resolves this through a custom character- or token-level overlap function. 

For a predicted span $S$ and a gold span $T$, precision and recall are calculated as continuous functions of their intersection: 

$$P(S, T) = \frac{|S \cap T|}{|S|} \quad \text{and} \quad R(S, T) = \frac{|S \cap T|}{|T|}$$

Conditional rule: 
- If the predicted technique label matches the gold technique label, the model receives a partial score matching the exact percentage of token overlap ($|S \cap T|$).
- If the predicted technique label is wrong, the overlap score automatically collapses to zero, even if the boundary indices were a perfect match.

> This is the SemEval approach. I am not sure if I want to take this approach. Infact, I want to seperate the two evaluations as this way the eval can be built around Var 1 and exteneded to Var 2. Building an eval strictly for Var 2 risks excluding Var 1. 

This decoupled approach allows us to perform an isolated Error Ablation Study. Because the tasks are split into two independent modules, you can track exactly where the pipeline failed:
1. Calculate the binary span-level $F_1$ score after Step 1 (the 3-tag model) to evaluate your baseline boundary locator.
2. Calculate the classification accuracy of Step 2 (the Task 1 head) conditioned only on correctly identified spans.


Because the integrated pipeline executes detection and classification simultaneously, its errors cannot be separated. The transition matrix and the Viterbi trellis optimize the tag path globally, meaning a drop in technique confidence can cause the model to shift or shrink the physical span boundaries.

Comparing the Strict Span Metric against the Proportional Overlap Metric across both variations will explicitly test the Breadcrumb Hypothesis: if the Integrated model scores significantly higher on the Proportional Overlap metric at span boundaries, you have empirical proof that technique classification context helps anchor fuzzy sequence start points.

> I want to conduct both the strict and partial span evals. 

> There is something around the classification eval that needs to be integrated into the span eval though. Because maybe if the class is wrong then the span will be too so it is pointless evaluating it. This will become much clearer after Task 1 is done. If the model is robust and performs well then we know that a classification error is a big problem and hence should problem includes a rejection mechanism to the span eval. 

> Once you finish evaluating Task 1, you will get a clear view of its output logit confidence distributions. If the model is robust, it will yield highly polarized probabilities for genuine categories. This allows you to implement a Confidence Gate as a rejection mechanism: if the maximum Softmax probability from the Task 1 classifier falls below a calculated threshold (e.g., $<0.65$), the system rejects the prediction and retroactively flattens the extracted tokens back to the O state. This prevents cascading false positives and gives Variation 1 a fighting chance against the integrated model.

> Your strategy to track both strict and partial span evaluations creates a perfect empirical test for your core hypotheses. Because Variation 1 compresses all signals into a generic anomaly bucket, it treats all propaganda structurally the same. Variation 2 maintains separate identities for each technique, relying on the CRF's transition matrix to guide the Viterbi algorithm.
>
> If your final results show that Variation 2 outperforms Variation 1 on the Proportional Overlap metric—specifically at the start points of the spans—you will have strong empirical evidence for your Breadcrumb Hypothesis. It will prove that the model's global optimization path benefits from technique-specific semantic profiles to successfully navigate ambiguous sentence boundaries.




---

# 4.2.7 SPAN BASELINES

prove that your Transformer-CRF engine is genuinely learning complex sentence structures rather than exploiting background noise.

I want to do take a generative or probability distribution approach. I want to essentially generate a guess as to where the snippet will be.

We can take the training data and build two probability distributions start point and end point. 

For each training sample we draw from the distribution and obtain a start and end point

There will be to be some rule based checks to ensure the snippet doesnt exceed the segmenet bounds

There needs to be some sort of determinant to change the distribution based on the input segmeent length, i.e. long segmenets draw from a longer distribution. I am not to sure how to do this yet

In fact, an alternative way to build this could simply to be to construct a NN to predict the snap start and end. 

The input is topological the characteristics, i.e. length, and the output is the start and end 

However, it is important that this baseline has no recognition of the words or language used. It should essentially decompose to relying on the probability distribution of the training data. possibly with some regulaization and noise to avoid overfitting

In data science, this is known as a Topological Positional Prior Baseline or a Language-Blind Statistical Prior.

By designing a baseline that is completely blind to words, grammar, and semantics, you create a perfect control group for your dataset. If this baseline scores a decent $F_1$, it means the dataset contains a hidden positional or structural shortcut (e.g., human annotators or the dataset builders naturally tended to select segments where propaganda always lands right in the middle, or propaganda spans always scale perfectly with paragraph length). Proving or disproving this bias will give you massive points in your report's Discussion section.


Possible to do via probabilty distribtion or NN model

NN will be more deterministic (depending on hyperparams), alt will be probablistic

building a tiny, language-blind Multi-Layer Perceptron (MLP) is very clean.

[Input Vector: Sequence Length]
               │
               ▼
   [Dense Layer + ReLU + Dropout]  <── Noise/Regularization to prevent memorization
               │
               ▼
     [Dense Output Layer]
               │
               ▼
       [Sigmoid Activation]
               │
               ▼
[Output Vector: (Start Ratio, End Ratio)]

A single continuous scalar (or a small tensor holding [total_tokens, total_characters, average_word_length]). Crucially, no text embeddings or vocabulary matrices are attached.

Hidden Layers: One or two small linear layers (e.g., 32 hidden units) using a ReLU activation.

The Regularization/Noise Layer: Inject a high Dropout rate (e.g., p=0.4) and apply severe L2 weight decay in your optimizer. This forces the neural network to learn the smooth, generalized global trend of the dataset rather than memorizing exact specific sentence lengths.

Output Layer: Two neurons passed through a Sigmoid activation function, ensuring the outputs are continuous ratios between $0.0$ and $1.0$: $\hat{y} = [R_{\text{predicted\_start}}, R_{\text{predicted\_end}}]$.

You train this network using standard Mean Squared Error (MSE) loss against the true normalized start and end ratios of your training set.

When a test sample is passed through the MLP, it outputs two numbers between 0 and 1. You convert them back to hard integers using the test sentence length ($L_{\text{test}}$):

1. $\text{Start Token} = \text{round}(R_{\text{predicted\_start}} \times L_{\text{test}})$
2. $\text{End Token} = \text{round}(R_{\text{predicted\_end}} \times L_{\text{test}})$
3. The Logical Check Gate: Because the model has no built-in awareness that an end point must succeed a start point, your python script runs a final structural check:

" Unintelligent Topological Baseline."

"To ensure that downstream neural networks are capturing genuine linguistic and contextual signals rather than exploiting positional dataset artifacts, this report implements a language-blind Topological Baseline. By training a severely regularized MLP strictly on sequence lengths to output normalized span coordinate boundaries, this framework establishes the statistical baseline performance attainable purely through data-distribution geography."This approach is highly rigorous, avoids the trap of using a word dictionary lookup, and directly isolates whether the task truly requires context awareness ($H2$) or if it can be partially cracked by simple dataset geometry.

---










5.1. Task 1: Technique Classification Performance
- Presentation of the macro-$F_1$, micro-$F_1$, and accuracy scores.
- Comparative matrix: Random Guessing vs. BoW Baseline vs. Word2Vec vs. Frozen DeBERTa.
- Ablation rows showing the delta between Snippet-Isolated text and Unified Sequence (Full Context) text.

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

8. Future Work
- 8.1. Parameter-Efficient Fine-Tuning (PEFT): Propose using LoRA (Low-Rank Adaptation) instead of freezing the encoder entirely, allowing the model to adapt its internal attention maps to propaganda without triggering catastrophic forgetting.
- 8.2. Hybrid Top-Down Ensembles: Suggest a pipeline that utilizes the Task 1 Full-Context classifier as a global sentinel to dynamically weight or gate the token-level CRF transition paths in Task 2.
- Probably something around more silver data if its performance was any good

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