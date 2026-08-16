# 1 Introduction
Propaganda is the deliberate, systematic attempt to shape perceptions, manipulate cognitions, and direct behavior to achieve a response that furthers the desired intent of the propagandist (Jowett & O'Donnell, 2018). It involves managing collective attitudes by manipulating significant symbols (Lasswell, 1927) and using rhetorical devices to bypass rational analysis rather than relying on outright falsehoods. 

Given the velocity and volume of modern digital information, automated detection mechanisms are increasingly vital for maintaining the integrity of online discourse. This report explores automatically identifying propaganda through two core challenges: classifying known propagandistic snippets (Task 1) and jointly identifying manipulative spans and techniques within raw text (Task 2).

---

## 1.1 Problem Outline
Automating detection is challenging because the boundary between legitimate persuasion and manipulative rhetoric is highly subjective (Da San Martino et al., 2019). Historical models classified entire documents (Rashkin et al., 2017) but modern moderation requires detecting localized nuanced rhetorical shifts. Problematically, such detection must overcome significant structural irregularity as propagandists often sacrifice grammatical purity for rhetorical impact, relying on non-compositional multi-word expressions (Sag et al., 2002) and domain specific terms that present severe out-of-vocabulary challenges for traditional NLP.

---

# 2 Related Work: Evolution of NLP Computational Methods
NLP evolved from symbolic taxonomies like WordNet (Miller, 1995) to statistical representations based on the Distributional Hypothesis (Harris, 1954). Static word embeddings like Word2Vec (Mikolov et al., 2013) provided dense vectors but failed to resolve polysemy (Peters et al., 2018). Sequential models like LSTMs (Hochreiter and Schmidhuber, 1997) addressed context, leading to the Transformer architecture (Vaswani et al., 2017). Encoders such as BERT (Devlin et al., 2019) replaced recurrence with self-attention to generate dynamic, contextual representations across sentences. Modern NLP relies on autoregressive language models like GPT-3 (Brown et al., 2020), shifting the dominant paradigm from fine-tuning toward in-context learning (Raffel et al., 2020).

---