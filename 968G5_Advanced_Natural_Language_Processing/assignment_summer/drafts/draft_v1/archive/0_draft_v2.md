# 1 Introduction

Propaganda can be fundamentally understood as "the management of collective attitudes by the manipulation of significant symbols" (Lasswell, 1927), functioning not necessarily through outright falsehoods, but via manipulative rhetorical devices designed to bypass rational analysis and direct behavior (Jowett & O'Donnell, 2018). In the modern digital landscape, the sheer velocity and volume of information easily outpaces human moderation capabilities. Consequently, automated detection mechanisms—functioning similarly to, or alongside, user-driven interventions like 'community notes' and warning flags on social media platforms—are increasingly vital for maintaining the integrity of digital discourse. This report explores the computational identification of propaganda by addressing two core challenges: the classification of known propagandistic snippets (Task 1) and the joint identification of spans and techniques within raw text (Task 2).

## 1.1 Problem Outline and Academic Context
Automating this detection is inherently difficult because it requires distinguishing between legitimate persuasive discourse and manipulative rhetoric — a task fraught with subjectivity and nuanced boundaries (Da San Martino et al., 2019).

Historically, automated propaganda detection primarily operated at the macro-level, classifying entire news articles or sources as propagandistic, trusted, or satirical (Rashkin et al., 2017; Barrón-Cedeño et al., 2019a). However, this document-level approach lacks the interpretability required for modern moderation because propaganda rarely manifests as a uniform, document-wide sentiment. Instead, it relies on fine-grained, localized rhetorical shifts. A sentence might possess a completely neutral overall polarity while simultaneously harboring a highly toxic propagandistic span, ranging from direct emotional appeals (e.g., Loaded Language) to complex structural logical fallacies (e.g., Straw Man, Causal Oversimplification).

To address this, Da San Martino et al. (2020) introduced a paradigm shift toward fine-grained analysis through the SemEval-2020 Task 11 and the curation of the Propaganda Techniques Corpus (PTC). This framework—which forms the empirical foundation of this report—reconceptualizes the problem by requiring models to jointly identify the exact boundaries of manipulative rhetoric and map them to specific pedagogical categories.

A significant linguistic hurdle in executing this fine-grained detection is the structural irregularity of propagandistic language. Grammatical completeness is frequently sacrificed in favor of rhetorical "punch," often manifesting as fragmented shorthand slogans or abstract pairings of words. This presents specific challenges for traditional Natural Language Processing (NLP). Firstly, propaganda relies heavily on idiomatic phrasing and Multi-Word Expressions (MWEs) that are strictly non-compositional, meaning the intended manipulative meaning cannot be deduced simply by combining the literal definitions of the constituent words (Sag et al., 2002). Furthermore, political propaganda frequently employs domain-specific neologisms—such as person-specific slurs or "Trump-isms"—which introduce substantial Out-of-Vocabulary (OOV) challenges for static modeling approaches.

## 1.2 Hypotheses and Experimental Framework

To investigate the linguistic "signal" that defines propaganda—and to provide a substrate for design justifications, baseline comparisons, and error analysis—this report tests two primary hypotheses:

**H1: The Lexical Trigger Hypothesis:** Certain propaganda techniques are primarily defined by a subset of specific "trigger" words, such as highly abstract or emotionally charged nouns and adjectives (e.g., "radical," "traitor"). If this holds, simple Bag-of-Words (BoW) or static embedding approaches will achieve competitive classification accuracy by identifying these lexical anchors.

**H2: The Structural Irregularity Hypothesis:** Propaganda is characterized by a departure from standard syntactic norms and compositionality. Consequently, words lose their standard individual context and require a nuanced, contextualized understanding of the exact sentence structure and application to be accurately classified.

## 1.3 Methodology Overview

To evaluate these hypotheses, this report employs a tiered experimental lineage that incrementally increases linguistic complexity.

For Task 1, I compare a Word2Vec (Bag-of-Embeddings) approach against a DeBERTa-based Transformer to evaluate the utility of static semantic similarity versus dynamic contextualized attention. These approaches are evaluated against a dual set of baselines: a naïve random-guessing model to establish a lower bound, and an intelligent Unigram BoW Classifier to provide a baseline for evaluating H1.

For Task 2, I contrast a binary BIO-tagging pipeline (utilizing the highest performing classifier from Task 1) against an integrated Multi-class BIO-CRF model. By systematically comparing these models, I aim to determine if joint training on technique-specific structural "breadcrumbs" improves span boundary precision, ultimately identifying whether the primary signal of propaganda lies in individual lexical triggers or complex structural relationships.

---

# 2 Related Work

## 2.1 Evolution of NLP Computational Methods

Computational linguistics has evolved from rigid symbolic systems to self-supervised neural architectures. Early semantic representations relied on human-curated taxonomies like WordNet (Miller, 1995), which mapped concepts through explicit lexical relations but faced significant challenges in scalability and coverage. The field subsequently adopted the Distributional Hypothesis (Harris, 1954; Firth, 1957), which posits that linguistic context is the primary determinant of meaning. This paradigm shift facilitated the transition toward statistical approaches, utilizing Bag-of-Words (BoW) models and co-occurrence metrics (e.g., PPMI) to infer semantic similarity from frequency data.

To overcome the severe sparsity limitations of count-based matrices (Zipf's Law), the development of prediction-based static word embeddings like Word2Vec (Mikolov et al., 2013) and GloVe (Pennington et al., 2014) introduced dense, low-dimensional semantic representations. This allowed models to capture abstract "Semantic Clusters" rather than just exact lexical matches. However, static embeddings struggle with the Principle of Compositionality; attempting to represent entire sentences by simply adding or averaging static word vectors ignores crucial linguistic features like word order, syntax, and polysemy (where words have different senses depending on their context).

To capture sequential dependencies and compose individual words into sentence-level representations, NLP architectures shifted from fixed-window Feed-Forward Networks to recurrent structures like Recurrent Neural Networks (RNNs; Elman, 1990) and Long Short-Term Memory networks (LSTMs; Hochreiter & Schmidhuber, 1997). For sequence labelling, Ma and Hovy (2016) synthesized these technologies into a seminal end-to-end architecture. Their framework integrated character-level Convolutional Neural Networks (CNNs; LeCun et al., 1998; Chiu & Nichols, 2016) to capture sub-word morphology and mitigate Out-of-Vocabulary (OOV) constraints, with a Bidirectional LSTM (BiLSTM; Graves & Schmidhuber, 2005) to encode sequence context from both directions. Critically, they appended a Conditional Random Field (CRF; Lafferty et al., 2001) layer to decode output sequence tags globally. By maximizing the joint probability of the entire label sequence rather than making isolated token decisions, the CRF mitigates the Label Bias Problem inherent to Maximum Entropy Markov Models (MEMMs; McCallum et al., 2000), guaranteeing structural and syntactic sequence integrity.

Following this, the advent of Transformers (Vaswani et al., 2017) and pre-trained contextualized models like BERT (Devlin et al., 2019) and DeBERTa (He et al., 2020) revolutionized Natural Language Understanding. By abandoning sequential recurrence in favor of Global Self-Attention, these models dynamically resolve a word’s meaning based on its entire sentential context. This deep bidirectionality is particularly effective for identifying the "abstract pairings" and non-compositional phrases hypothesized to be central to complex manipulative rhetoric.

Finally, the contemporary NLP landscape is defined by the emergence of ultra-large generative paradigms, such as GPT-3 (Brown et al., 2020) and text-to-text frameworks like T5 (Raffel et al., 2020). These autoregressive Large Language Models (LLMs) represent a shift away from task-specific fine-tuning toward In-Context Learning, where frozen, pre-trained decoders perform complex reasoning and classification tasks guided purely by natural language prompting.

---
