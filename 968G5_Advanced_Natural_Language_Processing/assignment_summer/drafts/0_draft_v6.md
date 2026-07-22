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

# 3. Data Representation & Infrastructure
Section intro; info pertains to all tasks or mutliple approaches.

---

## 3.1 Corpus Overview (Word Count: )
This report takes a subset of the Propaganda Techniques Corpus, created by Da San Martino et al. (2020) for SemEval-2020-Task-11 which set out to evaluate pipelines identifying and classifying manipulative spans. Our subset tracks nine propaganda techniques, including a `not_propaganda` class, across `[INSERT_NUM]`rows. The input data is a string formatted sequence of text containing within it two tags (`BOS` and `EOS`). The text between these tags has been identified as one of the 8 positive propaganda labels, while the remaining text provides neutral sentinel context.

> BRING IN TABLE OF LABELS AND DEFINITIONS

---

## 3.2 Universal Pre-Processing: 
Some pre-processing took place directly on the raw, string formatted text and therefore applies to all methodologies. This mostly pertained to cleaning of digital artificacts which have no reference to the original speaker/authors intent. Also, given the original corpus (Da San Martino et al., 2020) was collected from news articles published between 2017-2019, this pre-procssing had the secondary goal of removing any backdoor artifcants which may infer certain publications who are known for the spread of propaganda, or certain propaganda techniques. 

> Convert into table:
>    - clear leading/trailing whitespace
>    - strip out python escape backslashes
>    - standardize quotes to flat quotes
>    - collapse intra-word apostrophes
>    - remove artifacts: \ / [ ] * | @ space - . : $ # + =
>    - ensure space around bound tags

---

## 3.3 Data Augmentation: Synthetic Data Enrichement
The training corpus has only `NUM` instances which opens the risk to severe overfitting. To mitigate this, a one-to-one generative data augmentation strategy is implemented to produce synthetic propaganda snippets. In SemEval-2020 there were several augmentation approaches submitted such as (Kranzlein et al., 2020) which relied on token substitution. Given the competition was pre-GPT-3 (Brown et al., 2020), there are no contemporary, generative approaches. We therefore build on the competition approaches by building a zero-shot Chain-of-Thought prompting (Kojima et al. 2022 and Wei et al. 2022) on a decoder only Meta `Llama_3_8B model`. Temperature is set to $0.7$ to encourage syntactic reformulation and semantic drift, while the reasoning steps maintain rhetorical intent. The surrounding sentinel context is left untouched.

The exact deployment circumstances are explained ad-hoc in the methodology or evaluation section(s) but the purpose of this data is to increase data density and reduce the frequency of singletons in frequency-based vocabularies. 

---

## 3.4 Feature Tagging 
For all methodologies, the string formatted text is initially tokenized using a whole-word regex tokenizer. From this point, the tokens are tagged with their Part-of-Speech (POS) and Named-Entity-Recognition (NER). This approach is inspired by the Khosla et al. (2020) submission and it designed to enhanced the lexical signal. 

The POS tagging is conducted using `nltk.averaged_perceptron_tagger`. This uses the incredibly granular PennTree bank tagset which holds 56 tags. Given our already small training set, this exposed the risk of spreading features tags too thinly accross a wide set of tags. Therefore, we map the tags down to the universal tagset which is comprised of only 12 standard tags, including one for punctuation ($.$) and another for unknown terms ($X$). POS tagging should be benefical in indentifying syntactic anomalies exhibited by some propaganda examples. 

> Table of tags
> self.UNIVERSAL_TAGSET = ["ADJ","ADP","ADV","CONJ","DET","NOUN","NUM","PRT","PRON","VERB",".","X"]
> create table to hold mapping, i.e. 12 tags and another column holding a list of the mapped

The NER tagging was conducted using spaCy's `en_core_web_sm` with the goal of enhancing references to targeted entities which propaganda may be directed at. This comes with a 19 tagset, however, 9 of the categories were very low frequency in the trainin corpus and were homogenized in to a 'MISC' category to maximise data density. 

> NER_TAG = [
>     'PERSON','ORG','GPE','DATE','NORP','CARDINAL','ORDINAL','TIME','LOC', 'O', 
>     # 'MONEY','EVENT','PERCENT','WORK_OF_ART','FAC','LAW','PRODUCT','LANGUAGE','QUANTITY',
>    ]

---

# 4. Task 1: Static Representation & Lexical Feature Benchmarking
- Task/Objective outline
- Interrogation of the H1 only
- Explores sparse counts vs. dense mean pooling
- (Full Context vs. Snippet)

---

## 4.1 Task Overview & Experimental Setup:
dataset splits (Full Context vs. Snippet), and metric definitions (Macro F1, Precision, Recall).

---

## 4.2 Methodology & Architecture:
- Baseline: Random Guessing, mathematical, seed

- Approach 1: Sparse Bag-of-Words (BoW) + POS/NER concatenation + MLP Head.
    - Vocab construction, gold + silver experiemental approach
    - UNK mapping, tagging preserve
    
- Approach 2: Continuous Word2Vec (300D) + Normalized POS/NER distributions + MLP Head.
    - Mean pooling, additive composition
    - Rationale for fixed vocabularies
    - No UNK, drop

Tagging before vocabulary pruning prevents rare words from completely collapsing into the `<UNK>` token, retaining high-level intent and regularizing against specific term overfitting. In the subword pipeline we map these features to the leading head-token of each word to prevent dampening signal through tag duplication. 

---

## 4.3 Hyperparameter Optimization:
- Head construction
- Grid search parameter sweeps (Learning Rate, Hidden Dimension, Dropout) for BoW and Word2Vec.
- Dev Set

---

## 4.4 Experimental Results:
- Performance comparisons across the 4 conditions (Full/Snippet $\times$ Gold/Silver) relative to the Random Baseline.

---

## 4.5 Task 1 Discussion & Error Analysis:
- Testing Hypothesis H1: Why BoW preserves local triggers while Word2Vec suffers from Vector Dilution / Signal Washing.
- Per-Class Dynamics: Severe class suppression in Loaded Language ($0.03$ recall) vs. semantic saturation in Flag Waving ($0.67$ recall).
- Bias-Variance & Feature Bottlenecks: Interpreting train/val convergence and underfitting.

---