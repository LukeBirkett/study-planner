# 3. Data Representation & Infrastructure

## 3.1 Corpus Overview
This report takes a subset of the Propaganda Techniques Corpus, created by Da San Martino et al. (2020) for SemEval-2020-Task-11 which set out to evaluate pipelines identifying and classifying manipulative spans. Our subset tracks nine propaganda techniques, including a `not_propaganda` class, across `[INSERT_NUM]`rows. The input data is a string formatted sequence of text containing within it two tags (`BOS` and `EOS`). The text between these tags has been identified as one of the 8 positive propaganda labels, while the remaining text provides neutral sentinel context. Appendix A details technique definitions according to Da San Martino et al. (2020).

---

## 3.2 Universal Pre-Processing
Raw text was cleaned prior to tokenization to standardize text and strip digital artifacts or publication-specific formatting. This removes noise and prevents models from exploiting publisher-specific stylistic backdoors. See Appendix B. 

---

## 3.3 Data Augmentation: Synthetic Data Enrichement
The training corpus has only `NUM` instances which opens the risk to severe overfitting. To mitigate this, a one-to-one generative data augmentation strategy is implemented to produce synthetic propaganda snippets. SemEval-2020 held several augmentation submission such as (Kranzlein et al., 2020) which relied on token substitution but given the competition was pre-GPT-3 (Brown et al., 2020), there are no contemporary, generative approaches. We build on the competition approaches by building a zero-shot Chain-of-Thought prompting (Kojima et al., 2022 and Wei et al., 2022) on a decoder-only Meta `Llama_3_8B` model. Temperature is set to $0.7$ to encourage syntactic reformulation and semantic drift, while the reasoning steps maintain rhetorical intent. The surrounding sentinel context is left untouched. In the methodology, the deployment of this data is refered to as "Silver", with the training data being "Gold". 

> TODO: Table of Exact Prompt and output structure

---

## 3.4 Feature Tagging 
In Task 1, an input sequence of $N$ whole tokens $T = (t_1, t_2, \dots, t_N)$ is mapped to parallel Part-of-Speech (POS) and Named-Entity Recognition (NER) tag sequences to enrich lexical representations with syntactic and entity-level signals (Khosla et al., 2020) and enforcing strict 1-to-1 sequence length alignment ($\vert{}T\vert{} = \vert{}P\vert{} = \vert{}E\vert{} = N$):

$$P = (p_1, p_2, \dots, p_N), \quad \text{where } p_i \in \mathcal{P}_{12}$$

$$E = (e_1, e_2, \dots, e_N), \quad \text{where } e_i \in \mathcal{E}_{9}$$

Syntactic tagging uses NLTK’s `averaged_perceptron_tagger`, mapping the Penn Treebank tagset down to the 12-category Universal POS tagset $\mathcal{P}_{12}$ (Appendix C). Named-Entity tagging uses spaCy’s `en_core_web_sm` while compressing low-frequency entity classes into a `MISC` slot, reducing the space to 9 categories $\mathcal{E}_{9}$ (Appendix D). Compressing tag spaces prevents sparse classes forming uninformative vector dimensions, reducing overfitting risk on rare entity types.

---