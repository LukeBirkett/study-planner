# 1 Introduction

*Propaganda represents a deliberate, systematic attempt to shape perceptions and direct behavior to achieve a specific intent, often through manipulative or deceptive rhetorical means.* 

> this appears to be a direct reference from Da San Martino. I would like to source and reference my own defintion/understand of Propaganda. In Da San Martino there were lots of references to seminial defintions or components of Propaganda.

---

*In the modern digital landscape, where the velocity of information often outpaces the capacity for human moderation, the automated detection of such techniques is vital for preserving the integrity of democratic discourse.*

> Sounds AI-ish but has the main points. Digital into, speed of into, outspace modernation. this is why we need automatical detection. Maybe mention something like community notes and flags on social media. 

---

*This report explores the computational identification of propaganda by addressing two distinct challenges: the classification of known propagandistic snippets (Task 1) and the joint identification of spans and techniques within raw text (Task 2).*

---

## 1.1 Problem Outline
*Detecting propaganda is technically challenging due to the inherent subjectivity and nuance of the categories involved, such as Doubt or Causal Simplification.*

> Probably put this into my own words with such as examples that come to my head. Could also look for a reference here.

*Unlike standard sentiment analysis, which focuses on overt emotional polarity, propaganda identification requires models to distinguish between informative political discourse and manipulative rhetoric.*

> Good to compare to a different NLP technique, i.e. sentiment analysis, are there any early papers that try to apply sentiment analysis for propaganda?

*A significant hurdle is the "off-kilter" structural quality of propagandistic language; grammatical complexity is frequently sacrificed for rhetorical "punch" or shorthand slogans.*

> These were my words originally. I wanted to focus on the abstract usage of words and the seemingly subtle loss of grammar to get a point accross, often through the use of slogans. 

*This introduces a specific difficulty for traditional NLP: the use of idiomatic expressions and "Multi-Word Expressions" (MWEs) that are non-compositional in nature (Sag et al., 2002).*

> I really want to mention Idioms here because this is a NLP wide problem applied to a domain. Need to step non-compositionality. Also keen to get a reference. 

*Furthermore, the dataset exhibits significant class imbalance and contains domain-specific neologisms—such as person-specific "Trump-isms"—which create Out-of-Vocabulary (OOV) challenges for static models.*

> This was my point OOV and "trumpisms", could like to get a reference for this.
>
> I am not aware yet if our exact dataset is imbalanced 

---

## 1.2 Hypotheses and Experimental Framework
*To investigate the linguistic "signal" that defines propaganda, this report proposes and tests two primary hypotheses:*

> the use of hypothesis provides the substract for design justifcations, baselines, testing/modelling goals, measures of results/evulation to comapre to, starting point for analysis, conclusion and options for further research. 

*H1: Lexical Trigger Hypothesis: Certain propaganda techniques are primarily defined by a subset of "trigger" words—abstract, emotionally charged nouns and adjectives (e.g., "radical," "traitor"). If this holds, simple Bag-of-Words (BoW) or Static Embedding approaches will achieve high classification accuracy by identifying these lexical anchors.*

*H2: Structural Irregularity Hypothesis: Propaganda is characterized by "abstract pairings" and a departure from standard syntactic norms. This "lossy" syntax serves to increase emotional resonance, creating linguistic patterns that can only be captured through sequence modeling (e.g., Bi-LSTM-CRF) and contextualized attention mechanisms (e.g., Transformers).*

> I am not sure about the later statement. I think the question is how advanced the model need to be to capture these linguistic deviations. Can a single bi-gram cpaure via pairs or do we need to something that can attain to the whole sequence, i.e. its not just immiedate pairing but sequences where early and late words find themselves in unusual pairs. 
> 
> The loss of strictly correct language structure and grammar. The built the wall is a somewhat a correct statement but it is lacking the connective structure of a true sentence. 

---

## 1.3 Methodology Overview
*To evaluate these hypotheses, I implement a tiered experimental lineage. I establish a "Pure Vocabulary" baseline using Unigram-BoW and an "Ordered Phrasing" baseline using Bi-gram BoW. For the classification tasks, I compare a Word2Vec (Bag-of-Embeddings) approach against a DeBERTa-based Transformer to evaluate the utility of semantic similarity versus contextualized attention. For Task 2, I contrast a binary-pipeline approach with an integrated Multi-class BIO-CRF model to determine if joint training on technique-specific "breadcrumbs" improves span boundary precision. By systematically comparing these models, I aim to identify whether the primary signal of propaganda lies in the individual words or the irregular relationships between them.*

> This will be to be written at the end but it looks like a good template