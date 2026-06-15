# 1 Introduction

There are 10 marks available for the introduction which are described as being for *"Does the introduction explain the task including why it is important and challenging?"*. Additionally, the brief says "It should include an introduction to the problem and the methods you have implemented". I intend to have a seperate methodolgy section(s) which explain the methods but at the end of this introduction there will be a small introduciton to methods. 

Propaganda represents a deliberate, systematic attempt to shape perceptions and direct behavior to achieve a specific intent, often through manipulative or deceptive rhetorical means.*

Note: this appears to be a direct reference from Da San Martino. I would like to source and reference my own defintion/understand of Propaganda. In Da San Martino there were lots of references to seminial defintions or components of Propaganda.

> Giovanni Da San Martino, Alberto Barron-Cedeno, Henning Wachsmuth, Rostislav Petrov, and Preslav Nakov. 2020. SemEval-2020 task 11: Detection of propaganda techniques in news articles.


In the modern digital landscape, where the velocity of information often outpaces the capacity for human moderation, the automated detection of such techniques is vital for preserving the integrity of democratic discourse.
- ThissSounds AI-ish but has the main points. Digital into, speed of into, outspace modernation. this is why we need automatical detection. Maybe mention something like community notes and flags on social media. 

This report explores the computational identification of propaganda by addressing two distinct challenges: the classification of known propagandistic snippets (Task 1) and the joint identification of spans and techniques within raw text (Task 2).

---

## 1.1 Problem Outline
Detecting propaganda is technically challenging due to the inherent subjectivity and nuance of the categories involved, such as Doubt or Causal Simplification.
- Could do with supplementing this with some references from seminal papers that have already identified that detecting progaganda is difficult

Unlike standard sentiment analysis, which focuses on overt emotional polarity, propaganda identification requires models to distinguish between informative political discourse and manipulative rhetoric.

A significant hurdle is the "off-kilter" structural quality of propagandistic language; grammatical complexity is frequently sacrificed for rhetorical "punch" or shorthand slogans.
- I wanted to focus on characteristic of propagranda to apply abstract usage of words and forgo subtle loss of correct grammar to get a point accross, often through the use of slogans that in of themselves are not strictly complete sentences. 

This introduces a specific difficulty for traditional NLP: the use of idiomatic expressions and "Multi-Word Expressions" (MWEs) that are non-compositional in nature (Sag et al., 2002).
- I really want to mention Idioms here because this is a NLP wide problem applied to a domain. Need to step non-compositionality. Also keen to get a reference. 

Furthermore, the dataset exhibits significant contains domain-specific neologisms — such as person-specific "Trump-isms" — which create Out-of-Vocabulary (OOV) challenges for static models.

---

## 1.2 Hypotheses and Experimental Framework
To investigate the linguistic "signal" that defines propaganda, this report proposes and tests two primary hypotheses:

The use of hypothesis provides the substract for design justifcations, baselines, testing/modelling goals, measures of results/evulation to comapre to, starting point for analysis, conclusion and options for further research. 

*H1: Lexical Trigger Hypothesis: Certain propaganda techniques are primarily defined by a subset of "trigger" words—abstract, emotionally charged nouns and adjectives (e.g., "radical," "traitor"). If this holds, simple Bag-of-Words (BoW) or Static Embedding approaches will achieve high classification accuracy by identifying these lexical anchors.*

*H2: Structural Irregularity Hypothesis: Propaganda is characterized by "abstract pairings" and a departure from standard syntactic norms meaning words may loose their individual context and require a naunced unstanding and acknowledgement of the exact sentence they have been used in and how they have been applied. 

---

## 1.3 Methodology Overview
To evaluate these hypotheses, I implement a tiered experimental lineage which adds linguistic complexity as the approaches develop. 

For task 1, I compare a Word2Vec (Bag-of-Embeddings) approach against a DeBERTa-based Transformer to evaluate the utility of semantic similarity versus contextualized attention. I pitch these approaches against a dual set baselines comprised of an unintelligent random guessing which gives a lower bound to build and tuned approaches from an intelligent baseline built from a Unigram BoW Classifer which provides an anchor for the H1 by which the fourthcoming approachs can be compared against. 

For Task 2, I contrast a binary-pipeline BIO approach with the winning classifer bolted on top with against an integrated Multi-class BIO-CRF model to determine if joint training on technique-specific "breadcrumbs" improves span boundary precision. By systematically comparing these models, I aim to identify whether the primary signal of propaganda lies in the individual words or the abstract relationships between them.
