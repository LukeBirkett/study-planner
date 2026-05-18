# Related Work
*Propaganda detection has evolved from document-level binary classification (Barrón-Cedeño et al., 2019) to the more granular fragment-level identification explored in this report. This shift, popularized by Da San Martino et al. (2020) via the SemEval-2020 Task 11, addresses the need for interpretability by pinpointing specific rhetorical techniques within a sentential context.*

> is this reference also mentioned in Da San Martino et al. (2020)? need to go back a check because they can a similar exerpt to this that can be adpated

---

## 2.1 Defining the Domain
*Propaganda is classically defined by Jowett and O'Donnell (2018) as a systematic attempt to manipulate perceptions to achieve a specific intent.

Unlike misinformation, which focuses on truth values, propaganda is defined by its persuasive techniques, such as Loaded Language or Flag Waving.*

> There probably needs to be a reference to justify misinformation distinction, or at least a definitions. 

*A core challenge in this domain is the presence of Multi-Word Expressions (MWEs) and non-compositional idioms, which Sag et al. (2002) identify as a persistent difficulty for standard syntactic parsers.*

> This is repeat of introduction

> Not sure if this section works too tell. need to review at the at end and decide if it is required or wether the intro covers it. 

---

## 2.2 Evolution of Computational Methods
*Early approaches to such tasks relied on Bag-of-Words (BoW) models using lexical frequency and n-gram patterns.*

> such tasks is quite vague

> Surely there must be some appropriate references here. 

*The development of static word embeddings like Word2Vec (Mikolov et al., 2013) introduced dense semantic representations, allowing models to capture "Semantic Clusters" rather than just exact lexical matches.*

> Mention something about bag-of- so it explicilty follows from the last bow point

*For sequence labeling (Task 2), the seminal work of Ma and Hovy (2016) established the CNN-BiLSTM-CRF architecture as the standard for end-to-end identification. By combining character-level CNNs for morphological awareness with a Conditional Random Field (CRF) layer, this architecture mitigates the Label Bias Problem through Global Normalization, ensuring structural integrity across the BIO-tag sequence.*

> i dont want to start for "task 2" this is just an abstract outline of the tech. if anything this should be broken down into cnn, bilstms, crf with references to their seminal researchs and how they aplpy to nlp and loosely to our taks. 

> its good that label bias and global normalization is mention

> in the actual method sections there will be a more details break down and justification for the methods used. this seciton is more of a very basic lit review

*Finally, the advent of Transformers (Vaswani et al., 2017) and contextualized models like BERT (Devlin et al., 2019) and DeBERTa (He et al., 2020) has revolutionized NLU. These models utilize Self-Attention to resolve a word’s meaning based on its entire sentential context, which is particularly effective for identifying the "abstract pairings" hypothesized to be central to manipulative rhetoric.*

> This whole section would benefit from being refined once the project is finished as it needs to talk directly about the tech used in the project

---