# Related Work
Propaganda detection has evolved from document-level binary classification (Barrón-Cedeño et al., 2019) to the more granular fragment-level identification explored in this report. This shift, popularized by Da San Martino et al. (2020) via the SemEval-2020 Task 11, addresses the need for interpretability by pinpointing specific rhetorical techniques within a sentential context.

---

## Evolution of Computational Methods
This section should essentially be a quick summary of the growth of approaches as outlined by the lecture content. This section can mention methods that are not proposed to be included in this report because the idea of the build a picture of the development of computation methods that are used in NLP. However, there is no need to go into detail one liners and appopriate references are sufficent. Note, we are not justifying the reasons why we have selected certain methods, this will happen in a later section. However, this section provides a buidling block of information that can be refered back to in later section, or at least it builds up understanding and knowledge for the reader. 

Early approaches to such tasks relied on Bag-of-Words (BoW) models using lexical frequency and n-gram patterns. 

There should be some mention of dictionaries and things like WordNet

The development of static word embeddings like Word2Vec (Mikolov et al., 2013) introduced dense semantic representations, allowing models to capture "Semantic Clusters" rather than just exact lexical matches.

Incuding something about the need to compose words into sentence represnetations. 

For sequence labeling (Task 2), the seminal work of Ma and Hovy (2016) established the CNN-BiLSTM-CRF architecture as the standard for end-to-end identification. By combining character-level CNNs for morphological awareness with a Conditional Random Field (CRF) layer, this architecture mitigates the Label Bias Problem through Global Normalization, ensuring structural integrity across the BIO-tag sequence.
- Note, i dont want to start for "task 2" this is just an abstract outline of the tech. if anything this should be broken down into cnn, bilstms, crf with references to their seminal researchs and how they aplpy to nlp and loosely to our taks. 

Finally, the advent of Transformers (Vaswani et al., 2017) and contextualized models like BERT (Devlin et al., 2019) and DeBERTa (He et al., 2020) has revolutionized NLU. These models utilize Self-Attention to resolve a word’s meaning based on its entire sentential context, which is particularly effective for identifying the "abstract pairings" hypothesized to be central to manipulative rhetoric.*

At the end here we need into a quick introduce to ultra model paradigms 

---