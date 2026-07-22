# 3. Data Representation and System Infrastructure (Word Count: 1118)
This section details the underlying dataset(s), baseline embeddings, and feature engineering protocols that establish the foundation for all subsequent modeling experiments. Task-specific integration are detailed and justified within Section 4 (Methodology).

---

## 3.1 Corpus Overview (Word Count: 135)
The dataset is a subset of the Propaganda Techniques Corpus (PTC) compiled for SemEval-2020 Task 11 (Da San Martino et al., 2020), originally harvested from news articles published between mid-2017 and early 2019. The resulting corpus contains `[INSERT_NUM]` rows across two columns: `text` and `label`. The label field tracks nine distinct classifications, utilising eight positive propaganda techniques alongside a neutral `not_propaganda` class.

Within the string-formatted text column, explicit <BOS> and <EOS> tags delineate the boundaries of active propaganda spans with text outside these markers containing non-propagandistic sentinel context. Data cleaning was restricted to removing superficial digital artifacts and HTML formatting to prevent downstream models access backdoor signals from the original publication. No universal preprocessing was applied to normalize grammar, punctuation, or spelling anomalies, as these stylistic variations frequently encode critical rhetorical intent and manipulative nuance.

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
--- 

## 3.2 Whole-Word Tokenization Pipeline (Word Count: 88)
The string formatted input was tokenized to a whole-word standard using a regex tokenzier. Preserving words as the atomic unit allows for direct evaluation of H1. Additionally, such tokenization allows us to create a baseline vocabulary which establishes the model input space. To avoid word duplication and maintain data density, tokens were case normalised and stripped of punctuation. During vocabulary construction, a frequency-threshold was applied which mapped words appearing once (Hapax Legomena) to a generic `<UNK>` token. This was done to mitigate data sparsity and risk of overfitting. 

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

## 3.5 Domain Adaptation (Word Count: 172)
A primary advantage of Transformer architectures is their capacity for domain adaptation via unsupervised fine-tuning. While baseline language models possess broad linguistic capabilities, their weights reflect a generalized text distribution. Given our corpus was collected from news sources (Da San Martino et al., 2020), the encoder is fine-tuned to a journalistic domain using the AG News dataset (Zhang et al., 2015).

The base model undergoes an intermediate unsupervised training pass using a Masked Language Modeling (MLM) objective via the Hugging Face `AutoModelForMaskedLM` abstraction. Dynamically masking random tokens forces the network to predict hidden subwords based on surrounding syntax, recalibrating DeBERTa’s internal attention maps to capture the stylistic distributions of professional journalism.

This intermediate pass directly addresses the mathematical constraints of our restricted data pool. Rather than optimizing task-specific parameters from scratch, the MLM loop leverages the structural volume of the AG News dataset to master domain-specific vocabulary, sentence lengths, and formatting layouts. This establishes a robust semantic foundation, ensuring downstream task heads isolate active ideological manipulation without distraction from baseline domain variances.

---

## 3.6 Data Augmentation: Silver Data (Word Count: 202)
With just NUM instances across eight propaganda labels, dataset scarcity risks severe overfitting on this nuanced NLP task. Over-indexing on sample terms introduces a structural bias that could jeopardize H1 regardless of architecture. To counter this, a one-to-one generative data augmentation strategy adds `NUM` instances to amplify vocabulary signals.

This aligns with SemEval-2020 Task 11, where Team UPB deployed masked language modeling (Paraschiv and Cercel, 2020) and Team DoNotDistribute gained a 5% boost via 3,000 silver instances (Kranzlein et al., 2020). Preceding causal architectures like GPT-3 (Brown et al., 2020), legacy competition frameworks were confined to encoder-based token-substitution heuristics (e.g. T5, BERT, WordNet).

Diverging from legacy methods, this framework utilizes zero-shot Chain-of-Thought prompting (Kojima et al., 2022; Wei et al., 2022) on a decoder-only LLM to reformulate syntax and capture semantic drift without altering rhetorical intent. Multi-step reasoning ensures cohesion with the unaltered sentinel context. As illustrated in Table X, the model conditions generation on contextual boundaries to mutate only the snippet, keeping the segment's meaning intact.

The pipeline deployed `Meta-Llama-3-8B` at a $0.7$ temperature to balance coherence and variability. To counter safety-alignment refusals common when prompting public LLMs with propagandistic text, a programmatic three-try re-prompting loop was integrated.

> INSERT: A TABLE CONTAINING THE EXACT FLOW OF PROMPTS

---
