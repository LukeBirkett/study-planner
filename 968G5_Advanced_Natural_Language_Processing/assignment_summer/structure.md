# 4. Structure

1. [Introduction](#1-introduction)
---
2. [Related Work](#2-related-work)
    - [2.1. Dataset Exploration and EDA](#21-dataset-exploration-and-eda)
---
3. [Methodology: Task 1 (Classification)](#3-methodology-task-1-classification)
    - [Baselines](#baselines)
    - [Approach 1: Bag-of-Embeddings](#approach-1-bag-of-embeddings-1)
    - [Approach 2: Transformer Architecture](#approach-2-transformer-architecture)
    - [Hyper-parameters ](#hyper-parameters)
---
4. [Methodology: Task 2 (Span Identification)](#4-methodology-task-2-span-identification)
    - [Variation 1: The Pipeline (Binary BIO + Classifier)](#variation-1-the-pipeline-binary-bio--classifier)
    - [Variation 2: Integrated Multi-class BIO-CRF](#variation-2-integrated-multi-class-bio-crf)
    - [Theoretical Justification](#theoretical-justification)
---
5. [Results and Evaluation](#5-results-and-evaluation)
    - [5.1 Evaluation Framework and Metrics](#51-evaluation-framework-and-metrics)
    - [5.2 Task 1 Results: The Lexical vs. Semantic Battle](#52-task-1-results-the-lexical-vs-semantic-battle)
    - [5.3 Task 2 Results: Pipeline vs. Integrated Architectures](#53-task-2-results-pipeline-vs-integrated-architectures)
---
6. [Analysis and Discussion](#6-analysis-and-discussion)
    - [6.1 Decoding the "Black Box" (XAI Comparison)](#61-decoding-the-black-box-xai-comparison)
    - [6.2 Perplexity as Linguistic Proof](#62-perplexity-as-linguistic-proof)
    - [6.3 Error Analysis (Failure Modes)](#63-error-analysis-failure-modes)
---
7. [Conclusion and Further Work](#7-conclusion-and-further-work)
---
* [Strategic Tips for High Marks:](#strategic-tips-for-high-marks)
---

## 1. Introduction
Define the task of propaganda detection and explain why it is both socially important and technically challenging. 

I have two hypotheses: 
- **1. Lexical Trigger Hypothesis:** Propaganda is disproportionately over-represented by abstract "trigger" words.
- **2. Structural Irregularity Hypothesis:** Propaganda utilizes "abstract pairings" and a loss of strictly correct grammar that can be identified through sequence modeling.

---

## 2. Related Work
Briefly mention the Propaganda Techniques Corpus (Da San Martino et al., 2020) which serves as the foundation for the dataset. (?)

Discuss the evolution/lineage from Bag-of-Words to Contextualized Embeddings (BERT/DeBERTa) and the use of CRFs for sequence labeling.

---

## 2.1 Dataset Exploration and EDA


---



### 2.1.2 Data Augmentation
- part-of-speech (PoS)
- named entity (NE) 

> this result in a 3 dimensional token vector

> Team LTIatCMU(SI:4) (Khosla et al., 2020) used a multi-granular BERT BiLSTM model with additional syntactic and semantic features at the word, sentence and document level, including PoS, named entities, sentiment, and subjectivity. It was trained jointly for token and sentence propaganda classification, with class balancing. They further fine-tuned BERT on persuasive language using 10,000 articles from propaganda websites, which turned out to be important.

#### Silver Data
It would be a good idea to supplement the data by creating "silver" data. The paper is back from 2021 so they didn't have access to the strength of generative models that we do now. Therefore, an "easy" option might just be to take this route. The issue pertains to checking that the create statements are relevant and suitable which could quite an involved task itself. 

> Team ApplicaAI(SI:2) (Jurkiewicz et al., 2020) based its success on self-supervision using the RoBERTa model. They used a RoBERTa-CRF architecture trained on the provided data and used it to iteratively produce silver data by predicting on 500k sentences and retraining the model with both gold and silver data. The final classifier was an ensemble of models trained on the original corpus, re-weighting, and a model trained also on silver data. 
> 
> Team UPB(SI:5) (Paraschiv and Cercel, 2020) decided not to stick to the pre-trained models from BERT–base alone and used masked language modeling to domain-adapt it using 9M articles containing fake, suspicious, and hyperpartisan news articles. 
>
> Team DoNotDistribute(SI:22) (Kranzlein et al., 2020) also opted for generating silver data, but with a different strategy. They report a 5% performance boost when adding 3k new silver training instances. To produce them, they used a library to create near-paraphrases of the propaganda snippets by randomly substituting certain PoS words. 
> 
> Team SkoltechNLP(SI:25) (Dementieva et al., 2020) performed data augmentation based on distributional semantics. 
>
> Finally, team WMD(SI:33) (Daval-Frerot and Yannick, 2020) applied multiple strategies to augment the data such as back translation, synonym replacement and TF.IDF replacement (replace unimportant words, based on TF.IDF score, by other unimportant words).

#### Additioanal Data


> Team LTIatCMU(SI:4) (Khosla et al., 2020) ... They further fine-tuned BERT on ≥persuasive language using 10,000 articles from propaganda websites, which turned out to be important.


### 2.1.3 EDA
Reasons to do EDA:
1. Validating the hypothesis. Assumed that propaganda is over-represented by abstract "trigger" words. An EDA showing Term Frequency (TF) or N-gram distributions can provide the first piece of empirical evidence for this.
2. **Syntactic Integrity:** For Task 2, analyzing sentence lengths and span lengths justifies the use of a CRF to handle structural dependencies.

- Classes
- Frequencies
- Class imbalances. Documenting this justifies your choice of Macro-Average F1 later in the report. As well as for reference in the evaluation or analysis sections.
- N-gram analysis to confirm 'abstract' pairings in propaganda snippets
- **Sequence Lengths:** Histograms of the total sentence length vs. the propaganda snippet length.
- **Vocabulary Richness:** Top 20 most frequent words in propaganda snippets vs. non-propaganda text.
- **Stopword and POS Analysis:** Visualizing if propaganda techniques rely on certain parts of speech (e.g., a high density of adjectives in loaded_language)

---

## 3. Methodology: Task 1 (Classification)

### Baselines: 
Describe the Unigram-BoW (Pure Vocabulary) and Bi-gram BoW (Local Phrasing) setups. As well, as true non-intelligent baseline of either random guessing or single answer guesss (probably both).

### Approach 1: Bag-of-Embeddings
Detail your use of Word2Vec with Mean Pooling and an MLP classification head. Justify why you kept the MLP head constant to isolate the embedding variable.

### Approach 2: Transformer Architecture
Describe your choice of DeBERTa/RoBERTa and how you extract snippet-specific representations (e.g., pooling hidden states between `<BOS>` and `<EOS>`).

### Hyper-parameters 
Document settings for both models (e.g., vocabulary size, embedding dimensions, dropout rates, and fine-tuning epochs).

---

## 4. Methodology: Task 2 (Span Identification)

### Variation 1: The Pipeline (Binary BIO + Classifier):
Describe the "bolt-on" approach where you first detect if text is propaganda before classifying what type it is.

### Variation 2: Integrated Multi-class BIO-CRF:
Detail your "Joint Model" approach using the Ma and Hovy (BERT-CRF) architecture.

### Theoretical Justification: 
Explain the role of the Viterbi algorithm and Global Normalization in resolving "soft boundaries" and "internal signals" in propaganda spans.

---

## 5. Results and Evaluation

### 5.1 Evaluation Framework and Metrics
Justify and explain the your metrics here to demonstrate "Systematic Knowledge".
- **Task 1 (Classification):** Use **Macro-Average F1** as the primary metric. Justify this by referencing the class imbalance found in your EDA; accuracy would be misleading if the model overfits to the frequent loaded_language class. Include all of the the other metrics too for more granular analysis; i.e. accuracy, recall, precision. 
- **Task 2 (Detection & Classification):** Use the Partial Match F1-score (as per Da San Martino et al., 2020). It would be good to implement something custom here. Perhaps around blurring the boundaries and identifying a way to work out if the span starts near the boundary. 
- **Joint Score Logic:** Explain that for Task 2, a span is only considered a "match" if the label is also correct. This acts as an "on-off switch," rewarding boundary precision only when the rhetorical technique is accurately identified.

### 5.2 Task 1 Results: The Lexical vs. Semantic Battle
Present a table comparing your Unigram-BoW, Bi-gram BoW, and Word2Vec baselines against your Transformer (DeBERTa/RoBERTa).
- **Lexical Sieve:** Analyze if the Unigram-BoW performs surprisingly well on "Loaded Language," supporting your hypothesis that some propaganda is purely word-driven.
- **The Bi-gram Boost:** Compare Bi-gram BoW vs. Word2Vec. If Bi-grams win, argue that "Local Phrasing" (structure) is more important than "Semantic Similarity" (Word2Vec).

### 5.3 Task 2 Results: Pipeline vs. Integrated Architectures
This is where we evaluate your two variations: the Binary Pipeline vs. the Integrated BIO-Class (Joint) Model.

**Variation 1 (Pipeline):** Report the "Span Detection" F1 separately from the "Joint" F1. This shows if your model is a good "spotter" but a bad "labeler".

**Variation 2 (Integrated):** Showcase how the CRF layer and Global Normalization improved boundary precision.

**The "Knit" Effect:** Discuss if Variation 2 handled "soft boundaries" better by using the technique label to "pull" the span boundaries into place.

---

**Evaluation against Hypotheses:** Discuss whether the performance of Bi-gram BoW vs. Word2Vec supports your theory on "local phrasing" vs. "semantic concepts".

**Human Benchmark:** Mentioning the $\gamma$ agreement (0.6) for humans provides a professional context for your model's performance.

**Theoretical Alignment:** Try to link result back to the "Label Bias Problem," "Global Normalization," or the "Distributional Hypothesis" found in your notes.

---

## 6. Analysis and Discussion

### 6.1 Decoding the "Black Box" (XAI Comparison)
Use the interpretability tools you planned (Captum/LIME) to provide a "Feature Comparison". Use Integrated Gradients (Captum) and Attention Maps (BertViz) to compare what the BoW model "sees" versus the Transformer.
- **1D vs. 2D Importance:** Show a visualization where BoW highlights a single word (e.g., "radical") but the Transformer’s Attention Map highlights the relationship between that word and its target.
- **Validating Abstract Pairings:** Use this to prove the hypothesis that the "off-kilter" grammar of propaganda is what the Transformer is actually picking up on.

### 6.2 Perplexity as Linguistic Proof
Present the Perplexity results here.
- Compare the perplexity of propaganda snippets vs. standard text using a pre-trained model like GPT-2.
- **The Evidence:** Use high perplexity scores as empirical proof that propaganda deviates from "Standard English" norms, justifying your use of the more complex CNN-BiLSTM-CRF or Transformer architectures.

### 6.3 Error Analysis (Failure Modes)
Identify specific techniques (e.g., "Causal Simplification") where models failed and discuss the causes (e.g., data sparsity vs. lack of syntactic context).
- **Confusion Matrix Analysis:** Discuss why "Doubt" might be frequently confused with "Loaded Language".
- **Boundary Errors:** Analyze if the model failed on very short snippets (1-2 words) vs. long, complex spans.

---

## 7. Conclusion and Further Work
Summarize which hypothesis held the most weight across the experiments.

**Further Work:** Suggest more complex data augmentations (e.g., Back-Translation) or the exploration of POS-only models to further decouple words from syntactic patterns.

## Strategic Tips for High Marks:
**Academic Style:** Ensure all major technical points (like the "Label Bias Problem" or the "Distributional Hypothesis") are backed up with references from your module notes or external literature.

**The "Joint Signal" Argument:** Your plan for Variation 2 in Task 2 is a strong point of "creative thought." Devote space in the analysis to explaining how the model uses the "breadcrumbs" of specific technique tags to knit together ambiguous boundaries.

**Code Appendix:** Ensure your .ipynb or .py files are clearly commented and mirror the methods described in the report.

---