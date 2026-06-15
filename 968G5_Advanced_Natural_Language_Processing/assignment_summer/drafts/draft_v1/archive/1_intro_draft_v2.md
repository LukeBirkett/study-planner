Word: 530


# 1 Introduction

Propaganda can be fundamentally understood as "the management of collective attitudes by the manipulation of significant symbols" (Lasswell, 1927), functioning not necessarily through outright falsehoods, but via manipulative rhetorical devices designed to bypass rational analysis and direct behavior (Jowett & O'Donnell, 2018). In the modern digital landscape, the sheer velocity and volume of information easily outpaces human moderation capabilities. Consequently, automated detection mechanisms—functioning similarly to, or alongside, user-driven interventions like 'community notes' and warning flags on social media platforms—are increasingly vital for maintaining the integrity of digital discourse. This report explores the computational identification of propaganda by addressing two core challenges: the classification of known propagandistic snippets (Task 1) and the joint identification of spans and techniques within raw text (Task 2).

---

## 1.1 Problem Outline

Automating this detection is inherently difficult. Unlike standard sentiment analysis, which generally maps overt emotional polarity, identifying propaganda requires distinguishing between legitimate persuasive discourse and manipulative rhetoric—a task fraught with subjectivity and nuanced boundaries (Da San Martino et al., 2019).

A significant linguistic hurdle is the structural irregularity of propagandistic language. Grammatical completeness is frequently sacrificed in favor of rhetorical "punch," often manifesting as fragmented shorthand slogans or abstract pairings of words. This presents specific challenges for traditional Natural Language Processing (NLP). Firstly, propaganda relies heavily on idiomatic phrasing and Multi-Word Expressions (MWEs) that are strictly non-compositional, meaning the intended manipulative meaning cannot be deduced simply by combining the literal definitions of the constituent words (Sag et al., 2002). Furthermore, political propaganda frequently employs domain-specific neologisms — such as person-specific slurs or "Trump-isms" — which introduce substantial Out-of-Vocabulary (OOV) challenges for static modeling approaches.

---

## 1.2 Hypotheses and Experimental Framework

To investigate the linguistic "signal" that defines propaganda—and to provide a substrate for design justifications, baseline comparisons, and error analysis—this report tests two primary hypotheses:

**H1: The Lexical Trigger Hypothesis:** Certain propaganda techniques are primarily defined by a subset of specific "trigger" words, such as highly abstract or emotionally charged nouns and adjectives (e.g., "radical," "traitor"). If this holds, simple Bag-of-Words (BoW) or static embedding approaches will achieve competitive classification accuracy by identifying these lexical anchors.

**H2: The Structural Irregularity Hypothesis:** Propaganda is characterized by a departure from standard syntactic norms and compositionality. Consequently, words lose their standard individual context and require a nuanced, contextualized understanding of the exact sentence structure and application to be accurately classified.

---

## 1.3 Methodology Overview

To evaluate these hypotheses, this report employs a tiered experimental lineage that incrementally increases linguistic complexity.

For Task 1, I compare a Word2Vec (Bag-of-Embeddings) approach against a DeBERTa-based Transformer to evaluate the utility of static semantic similarity versus dynamic contextualized attention. These approaches are evaluated against a dual set of baselines: a naïve random-guessing model to establish a lower bound, and an intelligent Unigram BoW Classifier to provide a baseline for evaluating H1.

For Task 2, I contrast a binary BIO-tagging pipeline (utilizing the highest performing classifier from Task 1) against an integrated Multi-class BIO-CRF model. By systematically comparing these models, I aim to determine if joint training on technique-specific structural "breadcrumbs" improves span boundary precision, ultimately identifying whether the primary signal of propaganda lies in individual lexical triggers or complex structural relationships.

---

> Lasswell, H.D., 1927. The theory of political propaganda. American political science review, 21(3), pp.627-631.

> Jowett, G.S. and O'donnell, V., 2018. Propaganda & persuasion. Sage publications.

> Da San Martino, G., Barrón-Cedeño, A., Wachsmuth, H., Petrov, R. and Nakov, P., 2020, December. SemEval-2020 task 11: Detection of propaganda techniques in news articles. In Proceedings of the fourteenth workshop on semantic evaluation (pp. 1377-1414).

> Sag, I.A., Baldwin, T., Bond, F., Copestake, A. and Flickinger, D., 2002, February. Multiword expressions: A pain in the neck for NLP. In International conference on intelligent text processing and computational linguistics (pp. 1-15). Berlin, Heidelberg: Springer Berlin Heidelberg.