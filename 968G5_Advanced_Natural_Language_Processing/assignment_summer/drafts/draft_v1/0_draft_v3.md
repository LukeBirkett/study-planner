# 1 Introduction
Propaganda involves managing collective attitudes by manipulating significant symbols (Lasswell, 1927), using rhetorical devices to bypass rational analysis rather than relying on outright falsehoods (Jowett & O'Donnell, 2018). 

Given the velocity and volume of modern digital information, automated detection mechanisms are increasingly vital for maintaining the integrity of online discourse. 

This report explores automatically identifying propaganda through two core challenges: classifying known propagandistic snippets (Task 1) and jointly identifying manipulative spans and techniques within raw text (Task 2).

## 1.1 Problem Outline and Academic Context
Automating this detection is difficult due to the subjective boundary between legitimate persuasion and manipulative rhetoric (Da San Martino et al., 2019). Historically, detection operated at the macro-level, classifying entire documents (Rashkin et al., 2017). However, this lacks the interpretability required for modern moderation; propaganda rarely manifests as uniform sentiment, instead relying on localized, fine-grained rhetorical shifts.

Addressing this, Da San Martino et al. (2020) introduced SemEval-2020 Task 11 and the Propaganda Techniques Corpus (PTC), requiring models to identify exact manipulative span boundaries and map them to categories. A significant hurdle in this fine-grained detection is propaganda's structural irregularity. Examples frequently sacrifice grammatical completeness for rhetorical impact, relying heavily on non-compositional Multi-Word Expressions (MWEs) (Sag et al., 2002) and domain-specific words and expressions, introducing substantial Out-of-Vocabulary (OOV) challenges for traditional Natural Language Processing (NLP).

## 1.2 Hypotheses and Methodology
To investigate the linguistic signal that defines propaganda, this report evaluates two primary hypotheses using a tiered experimental lineage:

**H1: The Lexical Trigger Hypothesis:** Propaganda is primarily defined by specific, emotionally charged "trigger" words. If true, simple Bag-of-Words (BoW) or static embedding models will achieve competitive accuracy.

**H2: The Structural Irregularity Hypothesis:** Propaganda relies on syntactic departures and non-compositionality, requiring nuanced, contextualized understanding of sentence structure.

For Task 1, I compare a static Word2Vec approach against a dynamic DeBERTa Transformer, benchmarked against a random-guessing lower bound and an intelligent Unigram BoW baseline. For Task 2, I contrast a binary BIO-tagging pipeline (with the best performing classifer from Task 1 bolted on) against an integrated Multi-class BIO-CRF model. This systematically determines if joint training on structural context improves span boundary precision over identifying individual lexical triggers.

# 2 Related Work
## 2.1 Evolution of NLP Computational Methods
Computational linguistics has shifted from rigid symbolic taxonomies like WordNet (Miller, 1995) to statistical models based on the Distributional Hypothesis (Harris 1954; Firth, 1957), which infers semantic similarity from linguistic context.

To overcome the sparsity of count-based matrices, static word embeddings like Word2Vec (Mikolov et al., 2013) introduced dense semantic representations. However, static word embeddings struggle with the Principle of Compositionality, failing to capture word order (Tai et al., 2015) and polysemy (Peters et al., 2018). Consequently, architectures evolved to capture sequential dependencies using Recurrent Neural Networks (Elman, 1990) and LSTMs (Hochreiter & Schmidhuber, 1997). For sequence labeling, Ma and Hovy (2016) integrated character-level CNNs to mitigate OOV constraints with Bidirectional LSTMs (Graves & Schmidhuber, 2005). Crucially, they utilized a Conditional Random Field (Lafferty et al., 2001) layer to decode output tags globally, mitigating the Label Bias Problem inherent in locally-normalized models (McCallum et al., 2000) and preserving syntactic sequence integrity.

More recently, Transformers (Vaswani et al., 2017) and pre-trained models like BERT (Devlin et al., 2019) and DeBERTa (He et al., 2020) replaced recurrence with Global Self-Attention. These models dynamically resolve word meaning based on complete sentential context—highly effective for identifying the non-compositional phrases central to manipulative rhetoric. Finally, contemporary NLP is increasingly defined by autoregressive Large Language Models (LLMs) like GPT-3 (Brown et al., 2020), representing a shift away from task-specific fine-tuning toward In-Context Learning (Raffel et al., 2020).

---

#### References

Lasswell, H.D., 1927. The theory of political propaganda. American political science review, 21(3), pp.627-631.

Jowett, G.S. and O'donnell, V., 2018. Propaganda & persuasion. Sage publications.

Da San Martino, G., Yu, S., Barrón-Cedeno, A., Petrov, R. and Nakov, P., 2019, November. Fine-grained analysis of propaganda in news articles. In Proceedings of the 2019 conference on empirical methods in natural language processing and the 9th international joint conference on natural language processing (EMNLP-IJCNLP) (pp. 5636-5646).

Da San Martino, G., Barrón-Cedeño, A., Wachsmuth, H., Petrov, R. and Nakov, P., 2020, December. SemEval-2020 task 11: Detection of propaganda techniques in news articles. In Proceedings of the fourteenth workshop on semantic evaluation (pp. 1377-1414).

Rashkin, H., Choi, E., Jang, J.Y., Volkova, S. and Choi, Y., 2017, September. Truth of varying shades: Analyzing language in fake news and political fact-checking. In Proceedings of the 2017 conference on empirical methods in natural language processing (pp. 2931-2937).

Sag, I.A., Baldwin, T., Bond, F., Copestake, A. and Flickinger, D., 2002, February. Multiword expressions: A pain in the neck for NLP. In International conference on intelligent text processing and computational linguistics (pp. 1-15). Berlin, Heidelberg: Springer Berlin Heidelberg.

Miller, G.A., 1995. WordNet: a lexical database for English. Communications of the ACM, 38(11), pp.39-41.

Harris, Z.S., 1954. Distributional structure. Word, 10(2-3), pp.146-162.

Firth, J.R., 1957. A synopsis of linguistic theory. Studies in linguistic analysis, Special volume of the philological society/Blackwell.

Mikolov, T., Chen, K., Corrado, G. and Dean, J., 2013. Efficient estimation of word representations in vector space. arXiv preprint arXiv:1301.3781.

Elman, J.L., 1990. Finding structure in time. Cognitive science, 14(2), pp.179-211.

Hochreiter, S., 1997. Long short-term memory. Neural Computation MIT-Press.

Ma, X. and Hovy, E., 2016, August. End-to-end sequence labeling via bi-directional lstm-cnns-crf. In Proceedings of the 54th Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers) (pp. 1064-1074).

Graves, A. and Schmidhuber, J., 2005. Framewise phoneme classification with bidirectional LSTM and other neural network architectures. Neural networks, 18(5-6), pp.602-610.

Lafferty, J., McCallum, A. and Pereira, F.C., 2001. Conditional random fields: Probabilistic models for segmenting and labeling sequence data.

McCallum, A., Freitag, D. and Pereira, F.C., 2000, June. Maximum entropy Markov models for information extraction and segmentation. In Icml (Vol. 17, No. 2000, pp. 591-598).

Vaswani, A., Shazeer, N., Parmar, N., Uszkoreit, J., Jones, L., Gomez, A.N., Kaiser, Ł. and Polosukhin, I., 2017. Attention is all you need. Advances in neural information processing systems, 30.

Devlin, J., Chang, M.W., Lee, K. and Toutanova, K., 2019, June. Bert: Pre-training of deep bidirectional transformers for language understanding. In Proceedings of the 2019 conference of the North American chapter of the association for computational linguistics: human language technologies, volume 1 (long and short papers) (pp. 4171-4186).

He, P., Liu, X., Gao, J. and Chen, W., 2020. Deberta: Decoding-enhanced bert with disentangled attention. arXiv preprint arXiv:2006.03654.

Brown, T., Mann, B., Ryder, N., Subbiah, M., Kaplan, J.D., Dhariwal, P., Neelakantan, A., Shyam, P., Sastry, G., Askell, A. and Agarwal, S., 2020. Language models are few-shot learners. Advances in neural information processing systems, 33, pp.1877-1901.

Raffel, C., Shazeer, N., Roberts, A., Lee, K., Narang, S., Matena, M., Zhou, Y., Li, W. and Liu, P.J., 2020. Exploring the limits of transfer learning with a unified text-to-text transformer. Journal of machine learning research, 21(140), pp.1-67.

Tai, K.S., Socher, R. and Manning, C.D., 2015, July. Improved semantic representations from tree-structured long short-term memory networks. In Proceedings of the 53rd Annual Meeting of the Association for Computational Linguistics and the 7th International Joint Conference on Natural Language Processing (Volume 1: Long Papers) (pp. 1556-1566).

Peters, M.E., Neumann, M., Zettlemoyer, L. and Yih, W.T., 2018. Dissecting contextual word embeddings: Architecture and representation. In Proceedings of the 2018 conference on empirical methods in natural language processing (pp. 1499-1509).

---