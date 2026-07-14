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
With just `NUM` instances across eight propaganda labels, dataset scarcity risks severe overfitting on this nuanced NLP task. Over-indexing on sample terms introduces a structural bias that could jeopardize H1 regardless of architecture. To counter this, a one-to-one generative data augmentation strategy adds `NUM` instances to amplify vocabulary signals.

This aligns with SemEval-2020 Task 11, where Team UPB deployed masked language modeling (Paraschiv and Cercel, 2020) and Team DoNotDistribute gained a 5% boost via 3,000 silver instances (Kranzlein et al., 2020). Preceding causal architectures like GPT-3 (Brown et al., 2020), legacy competition frameworks were confined to encoder-based token-substitution heuristics (e.g. T5, BERT, WordNet).

Diverging from legacy methods, this framework utilizes zero-shot Chain-of-Thought prompting (Kojima et al., 2022; Wei et al., 2022) on a decoder-only LLM to reformulate syntax and capture semantic drift without altering rhetorical intent. Multi-step reasoning ensures cohesion with the unaltered sentinel context. As illustrated in Table X, the model conditions generation on contextual boundaries to mutate only the snippet, keeping the segment's meaning intact.

The pipeline deployed `Meta-Llama-3-8B` at a $0.7$ temperature to balance coherence and variability. To counter safety-alignment refusals common when prompting public LLMs with propagandistic text, a programmatic three-try re-prompting loop was integrated.

> INSERT: A TABLE CONTAINING THE EXACT FLOW OF PROMPTS

---

















---

# 4. Task Methodologies
This section outlines the architectural frameworks deployed across both experimental tasks. Task 1 (Classification) contrasts a static Word2Vec framework against a context-aware DeBERTa Transformer to evaluate static versus dynamic sequence representations. Task 2 (Joint Detection and Classification) compares a decoupled, two-stage binary pipeline against an integrated, multi-class BIO-CRF model.

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

### 4.1.4 Standardized Downstream Classification Head (Word Count: 191)

To isolate representation quality from architectural bias, all Task 1 frameworks share an identical Multi-Layer Perceptron (MLP) head. Element-wise mean pooling standardizes variable-length token sequences into a uniform semantic centroid $\mathbf{x} \in \mathbb{R}^{d_{\text{in}}}$, matching each architecture’s native dimensionality: unigram ($d_{\text{in}} = \vert{}V\vert{}$), Word2Vec ($d_{\text{in}} = 300$), and DeBERTa ($d_{\text{in}} = 768$).

Grounded in the Universal Approximation Theorem (Hornik et al., 1989), a single hidden layer acts as a constrained probe, preventing overfitting on our restricted dataset while resolving complex boundaries. It applies a ReLU activation for non-linearity, dropout regularization against parameter co-adaptation, and a linear projection to target logits:

$$\mathbf{h} = \text{ReLU}(\mathbf{W}_1 \mathbf{x} + \mathbf{b}_1)$$

$$\mathbf{z} = \text{Dropout}(\mathbf{h}, p)$$

$$\mathbf{s} = \mathbf{W}_2 \mathbf{z} + \mathbf{b}_2$$

Here, $\mathbf{W}_1$ and $\mathbf{b}_1$ project the centroid into a $d_{\text{hidden}}$-dimensional space, $p$ is the dropout rate, and $\mathbf{W}_2 \in \mathbb{R}^{8 \times d_{\text{hidden}}}$ maps the regularized features to the eight class logits. A terminal Softmax normalizes these into a valid probability distribution:

$$\sigma(\mathbf{s})_i = \frac{e^{s_i}}{\sum_{j=1}^{8} e^{s_j}}$$

Optimized via Cross-Entropy Loss against the gold labels, keeping this downstream topology mathematically constant guarantees that empirical variances stem strictly from the upstream embeddings' semantic and contextual capacities.

---









## 4.2 Task 2: Joint Detection and Classification
Task 2 expands the experimental framework from sequence classification to a joint sequence labeling and token-level classification paradigm. Utilizing the standard BIO (Beginning, Inside, Outside) encoding format, tokens representing neutral sentinel contexts are tagged as `O`, while the start and continuation of propagandistic spans are labeled `B-` and `I-` respectively. Each word is represented as a dense, multi-feature tuple capturing its raw linguistic token, Part-of-Speech (POS) tag, Named Entity Recognition (NER) boundary, and target BIO state.

---

### 4.2.1 Architectural Ancestry: The Ma & Hovy Baseline
To ground our sequence labeling methodology, we adapt the foundational end-to-end framework introduced by Ma and Hovy (2016). As illustrated in Figure 4.1, this classical architecture partitions sequence processing across three hierarchically stacked layers:
1. **Character-Level CNN:** Extracts sub-word morphological regularities (e.g., capitalization, prefixes, suffixes) to build robustness against out-of-vocabulary terms.
2. **Bidirectional LSTM:** Processes word-token sequences forward and backward to capture global sentential context and long-range dependencies.
3. **Conditional Random Field (CRF) Decoder:** Models joint tag probabilities across the entire sequence rather than making isolated token decisions, enforcing logical state transitions (e.g., preventing illegal O to I- transitions).

---

### 4.2.2 Modernized Transformer-CRF Paradigm
To optimize boundary precision and structural resolution, we modernize the Ma and Hovy (2016) pipeline by substituting the sequential and convolutional layers with a deep Transformer encoder (DeBERTa) while maintaining the global decoding properties of the terminal CRF layer. This structural shift provides distinct advantages for propaganda detection.

First, SentencePiece tokenization (Section 3) bypasses the character-level CNN by decomposing out-of-vocabulary terms into subword units, mitigating data sparsity. Second, global self-attention eliminates LSTM-induced context decay, giving tokens a parallel, uncompressed line of sight across the sequence to capture long-range rhetorical patterns. Third, using the domain-adapted DeBERTa backbone (Section 3) leverages a pre-trained linguistic worldview, preventing the overfitting risks of training recurrent architectures from scratch on restricted data. Finally, DeBERTa's disentangled attention decouples token content from relative spatial position. This spatial decoupling directly tests the Structural Irregularity Hypothesis ($H_2$) by allowing the architecture to isolate ordinary vocabulary weaponized purely through anomalous syntactic placement.

---

### 4.2.3 Variation 1: The Decoupled Binary Pipeline
To isolate span detection from classification, Variation 1 collapses the eight target classes into a simplified three-tag set: `B-Propaganda`, `I-Propaganda`, and `O`.

By mapping all neutral text and non-propagandistic sentences to `O`, this formulation maximizes training-data density to establish highly generalized boundary-detection heuristics. 

> What? the density is about `B-Propaganda`, `I-Propaganda`,

If a sequence yields entirely `O` tags, it is directly cataloged as non-propagandistic. Otherwise, the extracted span is routed to the optimal Task 1 classifier for technique assignment.

Predicated on a derivative of the Lexical Trigger Hypothesis ($H_1$), this pipeline assumes that propaganda detection is a lexical-first task, wherein general rhetorical manipulation manifests through distinct, category-agnostic word choices

> Why?

While optimizing boundary-detection data density, this decoupling introduces a high risk of cascading error propagation. Because the downstream Task 1 classifier lacks a native non-propagandistic output dimension, any false-positive boundary extraction by the binary first stage mathematically forces an incorrect technique classification.

---

## 4.2.4 Variation 2: The Integrated Multi-Class BIO-CRF Model
Variation 2 integrates span extraction and technique classification into a single forward pass across a high-resolution 17-class space (eight techniques mapped to `B-` and `I-` prefixes, plus a global `O` tag).

Grounded in the Structural Irregularity Hypothesis ($H_2$), this model expands token representations by compounding DeBERTa embeddings with the POS and NER features defined in Section 3.2, aligning rhetorical patterns with real-world syntactic boundaries.

To resolve the label bias problem inherent in independent, local Softmax choices, a terminal CRF layer performs global sequence optimization. It utilizes emission scores $E$ from the encoder alongside a learned transition matrix $T$ to evaluate the joint probability of the output tag sequence $Y$ given input sequence $X$:

$$P(Y\vert{}X) = \frac{\exp\left(\sum_{i=1}^{n} T_{y_{i-1}, y_i} + \sum_{i=1}^{n} E_{i, y_i}\right)}{Z(X)}$$

Where $Z(X)$ is the normalizing partition function and $n$ is the sequence length. During inference, the model leverages a "breadcrumb effect" via backward-flowing Viterbi trellis optimization:

$$V_t(j) = \max_{i} \left[ V_{t-1}(i) + T_{i, j} \right] + E_{t, j}$$

Under this paradigm, highly confident technique-specific classifications deeper within a span mathematically pull up ambiguous boundary tokens into their correct preceding $B$-states. This sequence-level dependency directly tests whether syntactic structure and global transition dynamics are necessary to resolve highly ambiguous span edges.

---





















> 4.3 Experimental Setup and Evaluation Framework
> 4.3.1 Classification Metrics (Macro vs Micro $F_1$ justification)
> 4.3.2 Sequence Labeling Metrics (Strict CoNLL vs SemEval Proportional Overlap justification)
"Your system should identify both the span and the propaganda technique used"
> 4.3.3 The Topological Positional Baseline (Your language-blind control group)

















































## 4.2 Task 2: Joint Detection and Classification task (Word Count: 158)
Task 2 transitions the experimental scope from sequence classification to joint span detection and token-level classification. We frame this objective as a sequence labeling task utilizing the standard BIO (Beginning, Inside, Outside) encoding schema. Neutral sentinel tokens or non-propagandistic sentences are labeled `O`, the initial token of a propaganda span is tagged `B-`, and any subsequent internal tokens are marked `I-`. To capture structural context, each word is processed into a multi-feature representation tuple:

$$\mathbf{x}_i = (\text{Token}_i, \text{POS}_i, \text{NER}_i, \text{BIO}_i)$$

We modernize the classical CNN-BiLSTM-CRF baseline (Ma & Hovy, 2016; Section 4.2.1) into a Transformer-CRF paradigm (Section 4.2.2) to evaluate two competing variations. Variation 1 (Section 4.2.3) deploys a decoupled, two-stage binary pipeline that isolates general span boundaries before running our Task 1 classifier to test the lexical-first assumptions of $H_1$. Conversely, Variation 2 (Section 4.2.4) utilizes an integrated 17-class BIO-CRF model to evaluate $H_2$, predicting spans and specific propaganda techniques simultaneously in a single forward pass.

---

### 4.2.1 Architectural Ancestry: The Ma and Hovy Baseline (Word Count: 81)
To ground our sequence labeling, we adapt the foundational CNN-BiLSTM-CRF pipeline (Ma & Hovy, 2016). This classic architecture partitions language analysis across three stacked layers: a character-level CNN to extract morphological features for orthographic anomaly detection ($H_2$), a Bidirectional LSTM to capture bidirectional sequential context, and a terminal Conditional Random Field (CRF) to evaluate joint sequence probabilities. By enforcing global sequence-transition constraints, the CRF mitigates the "soft boundary" dilemma of ambiguous propaganda span edges. This classical framework serves as our ancestral baseline.

---

### 4.2.2 Modernized Transformer-CRF Paradigm (Word Count: 163)
To optimize boundary precision and structural resolution, we modernize the Ma and Hovy (2016) pipeline by substituting its convolutional and sequential layers with a deep DeBERTa encoder while retaining the global sequence-decoding properties of the terminal CRF. This transition replaces sequential recurrent bottlenecks with a parallelized, transfer-learning framework highly calibrated to our restricted corpus. Specifically, SentencePiece tokenization natively decomposes out-of-vocabulary terms into frequent subwords, bypassing the need for a separate character-level CNN. Concurrently, global self-attention eliminates LSTM-induced context decay, ensuring every token maintains an uncompressed, parallel line of sight across the entire sequence to capture long-range rhetorical patterns. Furthermore, utilizing our pre-trained, domain-adapted encoder (Section 3.6) provides a robust linguistic initialization that prevents the severe overfitting risks of training recurrent networks from scratch. Finally, DeBERTa’s disentangled attention decouples token content from relative spatial coordinates. This spatial decoupling directly validates the Structural Irregularity Hypothesis ($H_2$), allowing the architecture to isolate manipulative anomalies where ordinary, high-frequency vocabulary is weaponized purely through non-standard syntactic placement.

---

### 4.2.3 Variation 1: The Decoupled Binary Pipeline (Word Count: 85)
V1 collapses all labels into a three-tag set (`B-Propaganda`, `I-Propaganda`, `O`), maximizing data density for optimizating category-agnostic boundary detection. During inference, sequences labeled entirely `O` are categorized as `not_propaganda`, while detected spans route to Task 1's optimal model for classification.

However, this approach means the model learns to generalize as a propaganda generalist, potentially overlooking linguistic cues that denote precise span deliniations, resulting in less accurate "soft boundary" detection. Also, since the downstream classifier lacks a native `not_propaganda` state, this architecture risk cascading error propagation as any false-positive boundary detection forces an incorrect technique classification.

---

### 4.2.4 Variation 2: The Integrated Multi-Class BIO-CRF Model (Word Count: 88)
To bypass cascading errors, V2 evaluates boundaries and techniques simultaneously across a high-resolution 17-class space. While preserving technique-specific signals mitigates "soft boundary" errors, it re-introduces data sparsity and overfitting vulnerabilties. Under this multi-class paradigm, ambiguous boundary tokens are resolved during inference via the CRF's backward-flowing Viterbi trellis "breadcrumb effect":

$$V_t(j) = \max_{i} \left[ V_{t-1}(i) + \mathbf{T}_{i, j} \right] + \mathbf{E}_{t, j}$$

Highly confident technique predictions deeper within a span propagate backward through transition parameters $\mathbf{T}$, "pulling up" preceding boundary tokens into correct `B-` states. Correlating these rhetorical techniques with real-world syntactic boundaries directly tests the Structural Irregularity Hypothesis ($H_2$).

> Include table of labels

---

### 4.2.7 Unintelligent Topological Baseline (Word Count: 142)
To guarantee our models capture genuine linguistic signals rather than exploiting positional dataset artifacts, we implement a language-blind topological baseline. Stripped of all semantic and vocabulary data, this framework utilizes a highly regularized Multi-Layer Perceptron (MLP) trained strictly on a seven-dimensional structural profile:

$$\mathbf{x}_{\text{topo}} = \left[ L_{\text{tokens}}, L_{\text{chars}}, \mu_{\text{len}}, \sigma^2_{\text{len}}, \text{CapRatio}, \text{PuncDensity}, \text{DigitRatio} \right]$$

> Table of features. > segment length (tokens count) > token variance (irregular word lenths, rythm, ) > punc density (text inside quotation marks for oversimplification or appeal to fear, or parenthetical statements) > segment length (characters) > caps ratio (noun desnity backdoor) > ratio (av word length) (think slogans for loaded language or flag-waving). 
> feature, sign, justification/proxy

These features capture the physical layout, rhythm, and orthographic geography of the text without exposing word meanings. This isolates whether the dataset contains hidden length or layout biases.

To serve as a joint benchmark, the MLP's terminal Sigmoid layer outputs a joint vector:

$$\hat{\mathbf{y}} = [P(\text{prop}), R_{\text{start}}, R_{\text{end}}]$$

If $P(\text{prop}) < 0.5$, the sequence is designated not_propaganda. Otherwise, the boundary ratios map to token indices, and the extracted span routes to our static Task 1 classifier. Holding this downstream head constant isolates the span-learning variable, proving whether propaganda detection requires genuine semantic comprehension ($H_1, H_2$) or can be cracked via dataset geometry.

---






















---

### 4.1.5. Task 1: Evaluation Approach and Metrics Justification

To rigorously benchmark the performance of the classification models and provide a clear, empirical foundation for testing the core hypotheses, this report establishes a multi-tiered validation matrix.

While the overarching dataset is heavily skewed by the dominant not_propaganda class, Task 1 filters the corpus to evaluate only the remaining positive labels, as the objective is to classify known instances of propaganda.

In this isolated subset, the remaining eight categories exhibit a mostly balanced distribution.

However, because historical literature on fine-grained propaganda detection typically features severely skewed class distributions (Da San Martino et al., 2020), it is vital to design an evaluation methodology that remains robust across both balanced and imbalanced contexts.

##### Task 1: Primary Optimization Metric: Macro-Averaged $F_1$-Score

The primary evaluation objective for Task 1 is the Macro-Averaged $F_1$-score.

Macro-averaging treats every individual propaganda technique category as equally important, calculating performance metrics completely independent of the underlying sample volumes.

Mathematically, computing the $F_1$-score for each category independently and taking their arithmetic mean forces the models to demonstrate genuine proficiency across all eight techniques.

$$\text{Macro-}F_1 = \frac{1}{8} \sum_{i=1}^{8} F1_{\text{class}_i}$$

This metric acts as a crucial architectural safeguard. If a model performs excellently on high-frequency semantic cues but completely fails on a rare structural fallacy technique, the macro-$F_1$ score will drop severely, effectively punishing the network for neglecting minority classes.

Consequently, it remains the gold standard for scientific research and model comparison.

##### Task 1: Secondary Metric: Micro-Averaged $F_1$-Score and Accuracy Alignment

To evaluate global system robustness, the Micro-Averaged $F_1$-score is tracked concurrently.

In a single-label, multi-class framework, because every classification error simultaneously generates a False Positive for the predicted class and a False Negative for the true label, the Micro-$F_1$ metric converges to become mathematically identical to global Accuracy: 

$$\text{Micro-}F_1 = \text{Accuracy} = \frac{\sum_{i=1}^{8} TP_i}{\text{Total Samples}}$$

Because the Task 1 sub-corpus is balanced, the Macro-$F_1$ and Accuracy (Micro-$F_1$) metrics will track closely in tandem, as no single category skews the global mean. Under these controlled conditions, the model cannot artificially inflate its score by over-predicting a single dominant category.

However, tracking both remains structurally important to highlight a model's error distribution. While Accuracy cares exclusively about global True Positives ($\sum TP$) regardless of where the mistakes occur, Macro-$F_1$ computes the harmonic mean of Precision and Recall per class before averaging.

Because the harmonic mean heavily penalizes extreme imbalances between Precision and Recall, Macro-$F_1$ and Accuracy can slightly split even under perfect class balance if a model yields asymmetrical error rates across specific categories.

##### Task 1: Granular Per-Class Diagnostics

To prevent the evaluation from collapsing into a single condensed metric, the evaluation suite extracts a separate Precision, Recall, and $F_1$-score for each of the eight propaganda techniques individually.

This granular, per-label breakdown serves as a vital diagnostic tool for the forthcoming Results and Error Analysis sections.

Rather than evaluating the architectures as monoliths, this per-class decomposition allows for localized interrogation of model behavior.

For instance, it provides the precise empirical substrate needed to differentiate our approaches: testing whether Word2Vec’s continuous space artificially inflates Recall at the expense of Precision due to context-blind synonym mapping, or whether DeBERTa's bidirectional self-attention successfully isolates the structural irregularities of more complex, non-compositional techniques.

> NOTE, there is a really interesting result that impacts task 2. In the second tasks we need to identify the span and label. If the models are better at identify the label with the entire sentence then this has impacts for the approaches taking in task 2. If we can label the sequence better using the raw segement, then this information can be used to guide the sequence tagging for the span. 

---


---

### 4.2.6 Task 2 Evaluation

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

# Remaining Report Structure
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
- Error propagandattion
- topological approach in t2 baseline is very interested. 0 language understand but instread working on the abstractions of language


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