# 2. Related Work
Propaganda detection has evolved from document-level binary classification (Barrón-Cedeño et al., 2019) to the more granular fragment-level identification explored in this report. This shift, popularized by Da San Martino et al. (2020) via the SemEval-2020 Task 11, addresses the need for interpretability by pinpointing specific rhetorical techniques within a sentential context.

## 2.1 The Linguistic Taxonomy of Propaganda

Propaganda aims to influence an audience's mindset to advance a specific agenda, achieving its highest efficacy when its manipulative nature goes entirely unnoticed by the reader. Computationally, detecting propaganda is uniquely challenging because it rarely manifests as a uniform, document-wide sentiment. Instead, it relies on fine-grained, localized rhetorical shifts. These shifts are executed through a diverse taxonomy of techniques, ranging from direct emotional appeals (e.g., Loaded Language, Appeal to Fear) to complex, structural logical fallacies (e.g., Straw Man, Causal Oversimplification). Consequently, a sentence might possess a completely neutral overall polarity while simultaneously harboring a highly toxic, non-compositional propagandistic span.

Historically, automated propaganda detection primarily operated at the macro-level, classifying entire news articles or sources as propagandistic, trusted, or satirical (Rashkin et al., 2017; Barrón-Cedeño et al., 2019a). However, this document-level approach lacks the interpretability required for modern digital moderation. To address this, Da San Martino et al. (2020) introduced a paradigm shift toward fine-grained analysis through the SemEval-2020 Task 11 and the curation of the Propaganda Techniques Corpus (PTC). This framework—which forms the empirical foundation of this report—reconceptualizes the problem by requiring models to jointly identify the exact boundaries of manipulative rhetoric (Span Identification) and map them to a specific pedagogical category (Technique Classification).

---

## Evolution of NLP Computational Methods
Computational linguistics has evolved from rule-based systems to self-supervised neural architectures. 

Early semantic representations relied on human-curated taxonomies like WordNet (Miller, 1995), which mapped concepts through explicit lexical relations but faced significant challenges in scalability and coverage. This lead to the adoption of Distributional Hypothesis (Firth, 1957), which posits that linguistic context, the "company that words keep", is the primary determinant of meaning. 

This paradigm shift facilitated the transition toward statistical based approaches, utilizing Bag-of-Words models and co-occurrence metrics (e.g., PPMI) to infer semantic similarity from frequency data.

To overcome the severe sparsity limitations of count-based matrices (Zipf's Law), the development of prediction-based static word embeddings like Word2Vec (Mikolov et al., 2013) and GloVe (Pennington et al., 2014) introduced dense, low-dimensional semantic representations. This allowed models to capture abstract "Semantic Clusters" rather than just exact lexical matches. However, static embeddings struggle with the Principle of Compositionality; attempting to represent entire sentences by simply adding or averaging static word vectors ignores crucial linguistic features like word order, syntax, and polysemy (where words have different senses depending on their context).

To capture sequential dependencies and compose individual words into sentence-level representations, NLP architectures shifted from fixed-window Feed-Forward Networks to recurrent structures like Recurrent Neural Networks (RNNs; Elman, 1990) and Long Short-Term Memory networks (LSTMs; Hochreiter & Schmidhuber, 1997). For sequence labelling, Ma and Hovy (2016) synthesized these technologies into a seminal end-to-end architecture. Their framework integrated character-level Convolutional Neural Networks (CNNs; Chiu & Nichols, 2016) to capture sub-word morphology and mitigate Out-of-Vocabulary (OOV) constraints, with a Bidirectional LSTM (BiLSTM; Graves & Schmidhuber, 2005) to encode sequence context from both directions. Critically, they appended a Conditional Random Field (CRF; Lafferty et al., 2001) layer to decode output sequence tags globally. By maximizing the joint probability of the entire label sequence rather than making isolated token decisions, the CRF mitigates the Label Bias Problem inherent to Maximum Entropy Markov Models (MEMMs; McCallum et al., 2000), guaranteeing structural and syntactic sequence integrity

Following this, the advent of Transformers (Vaswani et al., 2017) and pre-trained contextualized models like BERT (Devlin et al., 2019) and DeBERTa (He et al., 2020) revolutionized Natural Language Understanding. By abandoning sequential recurrence in favor of Global Self-Attention, these models dynamically resolve a word’s meaning based on its entire sentential context. This deep bidirectionality is particularly effective for identifying the "abstract pairings" and non-compositional phrases hypothesized to be central to complex manipulative rhetoric.

Finally, the contemporary NLP landscape is defined by the emergence of ultra-large generative paradigms, such as GPT-3 (Brown et al., 2020) and text-to-text frameworks like T5 (Raffel et al., 2020). These autoregressive Large Language Models (LLMs) represent a shift away from task-specific fine-tuning toward In-Context Learning, where frozen, pre-trained decoders perform complex reasoning and classification tasks guided purely by natural language prompting.

---

Elman, J.L. (1990). Finding Structure in Time. (The foundational Simple Recurrent Network paper).

Hochreiter, S., & Schmidhuber, J. (1997). Long Short-Term Memory. (The definitive LSTM paper addressing vanishing gradients).

Chiu, J.P., & Nichols, E. (2016). Named Entity Recognition with Bidirectional LSTM-CNNs. (Published concurrently with Ma & Hovy, pioneering character-level CNNs for token extraction).

Graves, A., & Schmidhuber, J. (2005). Framewise phoneme classification with bidirectional LSTM and other neural network architectures. (The classic reference for standardizing BiLSTMs).

Lafferty, J., McCallum, A., & Pereira, F.C. (2001). Conditional Random Fields: Probabilistic Models for Segmenting and Labeling Sequence Data. (The original CRF paper).

McCallum, A., Freitag, D., & Pereira, F.C. (2000). Maximum Entropy Markov Models for Information Extraction and Segmentation. (The paper that defined MEMMs and formally introduced/analyzed the Label Bias Problem).