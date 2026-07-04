
* [1 Introduction]()
    - [1.1 Problem Outline and Academic Context]()
    - [1.2 Hypotheses and Methodology]()
---
* [2 Related Work: Evolution of NLP Computational Methods]()
---
* [3. Data Characterization and Representation Strategy]()
    - [3.1 Corpus Overview]()
    - [3.2 Feature Enrichment: Tagging]()
    - [3.3 Data Augmentation: Silver Data]()
    - [3.4 Full Silver Approach]()
    - [3.5 Domain Adaptation]()
    - [3.6 Vocabulary Specification and Exploratory Analysis]()
        * [3.6.1 The Whole-Word Pipeline (BoW & Word2Vec)]()
        * [3.6.2 The Subword Pipeline (DeBERTa)]()
        * [3.6.3 Corpus Empirical Characteristics (EDA)]()
---
* [4. Task Methodologies]()
    - [4.1. Task 1: Propaganda Technique Classification]()
        * [4.1.1 Baselines]()
            - [4.1.1.1 Unintelligent Baseline (Uniform Random Guessing)]()
            - [4.1.1.2 Intelligent Baseline (Unigram Bag-of-Words)]()
            - [4.1.1.3 Snippet vs Sentinel Context]()
            - [4.1.1.4 Tagging Tokens]()
        * [4.1.2 Standardized Classification Head]()
        * [4.1.3. Classification Approach 1: Word2Vec]()
            - [4.1.3.1 Implementation]()
* []()
* []()
* []()
* []()
* []()
* []()






---

# 1 Introduction
Propaganda involves managing collective attitudes by manipulating significant symbols (Lasswell, 1927), using rhetorical devices to bypass rational analysis rather than relying on outright falsehoods (Jowett & O'Donnell, 2018). Given the velocity and volume of modern digital information, automated detection mechanisms are increasingly vital for maintaining the integrity of online discourse. This report explores automatically identifying propaganda through two core challenges: classifying known propagandistic snippets (Task 1) and jointly identifying manipulative spans and techniques within raw text (Task 2).

---

## 1.1 Problem Outline and Academic Context
Automating this detection is difficult due to the subjective boundary between legitimate persuasion and manipulative rhetoric (Da San Martino et al., 2019). Historically, detection operated at the macro-level, classifying entire documents (Rashkin et al., 2017). However, this is largely inappropriate for contemporary moderation as propaganda rarely manifests as a uniform, document-wide sentiment, instead relying on localized, fine-grained rhetorical shifts.

Addressing this, Da San Martino et al. (2020) introduced SemEval-2020 Task 11 and the Propaganda Techniques Corpus (PTC), requiring models to identify exact manipulative span boundaries with text segments and map them to known propaganda categories. 

A significant hurdle in this fine-grained detection is propaganda's structural irregularity. Examples frequently sacrifice grammatical completeness for rhetorical impact, relying heavily on non-compositional Multi-Word Expressions (MWEs) (Sag et al., 2002) and domain-specific words or expressions, introducing substantial Out-of-Vocabulary (OOV) challenges for traditional Natural Language Processing (NLP).

---

## 1.2 Hypotheses and Methodology
To investigate the linguistic signal that defines propaganda, this report evaluates two primary hypotheses using a tiered experimental lineage:

| Hypothesis | Title | Definition | 
| :--- | :--- | :--- | 
| **H1** | Lexical Trigger Hypothesis | Propaganda is primarily defined by specific, emotionally charged "trigger" words. If true, simple Bag-of-Words (BoW) or static embedding models will achieve competitive accuracy. | 
| **H2** | Structural Irregularity Hypothesis | Propaganda relies on syntactic departures and non-compositionality, requiring nuanced, contextualized understanding of sentence structure. Therefore static approachs will not perform well and context aware methods will be required for good performance | 
---

For Task 1, I compare a static Word2Vec approach against a dynamic DeBERTa Transformer, benchmarked against a random-guessing lower bound and a baseline "intelligent" Unigram BoW baseline. For Task 2, I contrast a binary BIO-tagging pipeline (with the best performing classifer from Task 1 bolted on) against an integrated Multi-class BIO-CRF model. This systematically determines if joint training on structure and context improves span boundary precision over identifying individual lexical triggers for span start and end points.

---

# 2 Related Work: Evolution of NLP Computational Methods
Computational linguistics has shifted from rigid symbolic taxonomies like WordNet (Miller, 1995) to statistical models based on the Distributional Hypothesis (Harris 1954; Firth, 1957), which infers semantic similarity from linguistic context.

To overcome the sparsity of count-based matrices, static word embeddings like Word2Vec (Mikolov et al., 2013) introduced dense semantic representations. However, static word embeddings struggle with the Principle of Compositionality, failing to capture word order (Tai et al., 2015) and polysemy (Peters et al., 2018). Consequently, architectures evolved to capture sequential dependencies using Recurrent Neural Networks (Elman, 1990) and LSTMs (Hochreiter & Schmidhuber, 1997). For sequence labeling, Ma and Hovy (2016) integrated character-level CNNs to mitigate OOV constraints with Bidirectional LSTMs (Graves & Schmidhuber, 2005). Crucially, they utilized a Conditional Random Field (Lafferty et al., 2001) layer to decode output tags globally, mitigating the Label Bias Problem inherent in locally-normalized models (McCallum et al., 2000) and preserving syntactic sequence integrity.

More recently, Transformers (Vaswani et al., 2017) and pre-trained models like BERT (Devlin et al., 2019) and DeBERTa (He et al., 2020) replaced recurrence with Global Self-Attention. These models dynamically resolve word meaning based on complete sentential context—highly effective for identifying the non-compositional phrases central to manipulative rhetoric. Finally, contemporary NLP is increasingly defined by autoregressive Large Language Models (LLMs) like GPT-3 (Brown et al., 2020), representing a shift away from task-specific fine-tuning toward In-Context Learning (Raffel et al., 2020).

---

# 3. Data Characterization and Representation Strategy
The follow section(s) are dedicated to introducing, explaining and exploring the underlying training data set. 

While several subsections in this segment intersect with methodological design, this section focuses strictly on defining implementation protocols and high-level theoretical motivations. Their task-dependent integration into the modelling frameworks is detailed and justified within Section 4 (Methodology). This setup establishes Section 3 as a decoupled repository of data representations and feature engineering strategies, serving as a foundation for later experimental reference.

---

## 3.1 Corpus Overview
The dataset supplied for this report is a "subset" of the Propaganda Techniques Corpus (PTC) created by Da San Martino et al. (2020) for the SemEval-2020 Task 11. In these original papers, the data was collected from a "sample of news articles from the period starting in mid-2017 and ending in early 2019."

Our corpus contains 2414 rows and 2 columns: `text` and `label`. 

The `text` field contains the passage of text which is formatted as a string. Within each string there are <BOS> and <EOS> markers which contain the snippet of text which may or may not be evidence of propaganda. 

The `label` field contains the category for which the snippet has been determined to be. There are 8 labels which are taken directly from the Da San Martino et al. (2020) paper as well as an additional `not_propaganda` label, making 9 in total. 

The text outside the tags is not itself considered to be a tagged as the snippets given label and is instead just the sentinal context pertaining to the snippet and/or the wider source of the text. 

The table below contains the 9 labels from the dataset, their definition according to Da San Martino et al. (2020) and example taken directly from the training data. 

#### TABLE
| Label | Definition | Example |
| :--- | :--- | :--- |
| `flag_waving` |  |  |
| `appeal_to_fear_prejudice` |  |  |
| `causal_simplification` |  |  |
| `doubt` |  |  |
| `exaggeration,minimisation` |  |  |
| `loaded_language` |  |  |
| `name_calling,labeling` |  |  |
| `repetition` |  |  |
| `not_propaganda` |  |  |

> need to get the definitions from Da San Martino et al. (2020)

Light data cleaning was carried out which focused on removing digital artifacts that do not represent any intended context from the write/speaker themselves. 

However, all grammar, spelling variations and punctuation were left as this demonstates meaning and intent. Additionally, as the source is news outlets we can assume a higher level of rigour with respect to grammar and punctuation, or lack there of where appropriate. 

> Tokenization used, other preprocessing steps, possibly EDA seciton. 

---

## 3.2 Feature Enrichment: Tagging
In various places throughout the task, the text was enriched by tagging the tokens, specifically with their part-of-speech (POS) and Named Entity. For each entry in the sequence a tuple holds the original token, POS and Named entity tag. 

POS tagging involves assigning each token its grammatical class. Sequences were tagged using `nltk.averaged_perceptron_tagger` which comprised of <include_number_of_tags>. Aside from traditional benefits such as word disambiusation, POS tags will be useful in identifying linguistic irregularities which are so prevelant in propaganda, particularly in the composition or sequence of tags used.

Named entity tagging involves assigning qualifying tokens their representative nouns. Sequences were tagged using ` spacy.en_core_web_sm` which comprised of <include_number_of_tags>. Propagandists often target People, Places and Known Entities to weight on the emotional cues of their audience. A the dataset is small, most references will likely only come up once or a few times. Resulting, any the exact word will either be lost to the `UNK` token or provide extremely weak or misleading signal to the model. For example, should a training corpus only include references to a Noun in a single propaganda category only then a frequency-based model may be prone to overfitting, performing poorly in the test set where this particular word occurs. 

The decision was made not to include Sentinment Tagging as whilst some techniques are explicity in their sentiment, others invoken a more nuaunced approach to their manipulation, including constrating examples found in the same categories. For more subtle propaganda instances, sentiment features may work to infact muddy the signal in pointing the models towards and given interpretation of the words and missing the underlying message.

Our decision to include feature tagging as a component follows successful entries in Da San Martino et al. (2020) SemEval-2020 Task 11 such as Team LTIatCMU(SI:4) (Khosla et al., 2020) who enhanced their BERT BiLSTM model with additional syntactic and semantic features. 

---

## 3.3 Data Augmentation: Silver Data

Excluding the majority `not_propaganda` class, the dataset contains only <NUM> instances distributed across 8 categories. This data scarcity significantly increases the risk of overfitting and poor generalization to unseen text. Furthermore, if certain snippet terms are overrepresented within the training sample, the models may over-index on lexical structures, introducing a structural bias which jeaporadises H1 irrespective of downstream architecture design choices. 

To mitigate these risks, the training data is expanded via a one-to-one data augmentation strategy. By pairing each original instance with an LLM-generated synthetic counterpart, the approach introduces an additional <NUM> training instances, amplifying the signal of known vocabulary words. 

This approach follows several methodologies submitted in the Da San Martino et al. (2020) SemEval-2020 Task 11 such as Team UPB(SI:5) (Paraschiv and Cercel, 2020) who used a masked language modeling method to produce synthetic data and Team DoNotDistribute(SI:22) (Kranzlein et al., 2020) who generated an additional 3k new silver training instances resulting in a 5% performance boost. 

Crucially, however, the SemEval-2020 Task 11 evaluation framework hails was introduced in late 2019 and published December 2020 (Da San Martino et al., 2020).

This timeline either entirely preceeds or just intersects to release of the autoregressive Large Language Model (LLM) paradigm, introduced via the foundational GPT-3 architecture in mid-2020 (Brown et al., 2020)

Therefore, the leading benchmarks at the time of the SemEval-2020 Task 11 were encoder-only masked language models (e.g., BERT) or early encoder-decoder frameworks (e.g., T5) and as such the text augmentation methods submitted during the competition were predominantly to localized token-substitution heuristics. 

> include an example of a reference and team here, i think there was a team which used WordNet. Also try to find an example of a more technical silver data generation approach. 

By utilising the contemporary tools availble, this report diverges from the techniques submitted and introduces a "novel" (compared to competition) augmentation strategy leveraging zero-shot prompting via a decoder-only causal LLM. 

This generative approach is superior as it allows us to move away from techniques such as back-translation or random part-of-speech substitution and instead capatures semantic drift or reformulates the synatic structure whilst maintaining the same intended meaning. 

To govern this generation, the pipeline leverages a multi-step Chain-of-Thought (CoT) prompting framework (Wei et al., 2022). By forcing the model to explicitly reason through intermediate linguistic steps, the CoT mechanism guarantees that the newly generated synthetic snippet maintains strict grammatical alignment and logical cohesion with the surrounding, unaltered sentential context.

---

#### 3.4 Full Silver Approach 
> Put this into the appendix or Diseminate into Tables
> Possibly summary paragraph + table + full outline in Appendix

> come back to this once implementation is coded but below is highlight appraoch. 

Start with full training set and remove the `not_propaganda` instances as these are already the majority field and we do not have enough information about how these instances were collects and false snippets decided. The exact model used was the open source `Meta-Llama-3-8B`. It should be noted that many open-source and private LLMs struggle with this task as they have safeguards to not participate in propaganda and offensive language/slurs. However, the hostel version from <model_provider> has less restrictions and the generation was programmed to re-prompt if the model refused to output the correct content. 

- tempurature was set to 0.7 to encourage variabliltiy in generative
- chain of thought helper function to retain prompt context in the context window
- prompts are not kept in the window to reduce risk of prompt confusion in the CoT
- prompt 1: given the snippet and asked to reword 
- job as linguistics expert to reword given text
- told that text is labelled it X but cannot be given label description because it breaks models terms, i.e. engaging in hateful or prop
- "Generate 3 alternatives to the snippet that serve the same purpose as guided by the label definition."
- Use a range of lexical semantics: synonyms for intensity, hypernyms for generalization, or paraphrasing.
- temp 0.7 to help with this and collect a range of ideas. 
- told to explain suitablitiy of each suggestion

- prompt 2: given the left and right context that surrounds the snippet
- asked to review 3 generative options to see if they still make sense given the immediate surrounds
- if they don't to suggest something new
- p2 used to be two seperate prompts by conbined to reduce run time

- prompt 3: based on the reason in the previous 2 context windows, select the best snippet
- told to ensure it is:   
    - 1. Rhetorically powerful ({label})
    - 2. Grammatically perfect within the context.
    - 3. Distinct from the original.
- told to output the snippet in a mask between tags: <final_output> INSERT SNIPPET HERE </final_output>
- STOP: Do not write anything else after the closing tag.

- post proseccing in python is applied to try and extract the generate snipper
- regex looking between the tags <final_output> </final_output>
- a few catches
- if the output snipper is exactly the same as the input snippet then cot is re-run, upto 3 times (2 retry + orig)
- sometimes the model failed on the mask and hallicunates the left/right context within the tags
- regex used to strip this out
    - also strip out over lap of 15 letters or more
- if failure to produce tags or anyting in the tags then run again
- some instances (count) of 1st failure but never more than 1

- output snippet is put into the same format at the gold set: left cont <bos> snippet <eos> right context
- this way anything that happens to the gold can be applied to the silver

- batch processed in 100s with back up
- logged to check failures
- jioned to gold dataset at the end by matching index
- saved as extrnal filex

---

## 3.5 Domain Adaptation
To address the small 2.5k row constraint, a DeBERTa model <need_exact_model> was  fine-tuned on a 10,000-article news corpus from 2017–2019, ensuring the model's base weights are adapted to the specific linguistic era of the Da San Martino dataset.

> come back to this once recoded.
> i belive this needds to go here because is it used in Task 1 and T2 and I don't want to explain it twice.

---

## 3.6 Vocabulary Specification and Exploratory Analysis
To establish the model input spaces, the dataset was processed through two distinct tokenization pipelines tailored to the requirements of the competing hypotheses, as well as, standardizing the input for our chosen task methodologies.

## 3.6.1 The Whole-Word Pipeline (BoW & Word2Vec)
To support the evaluation of H1, a whole-word regex tokenizer was implemented to preserve the whole, discrete lexical unit. Applying a frequency-threshold, words appearing only once (Hapax Legomena) were mapped to a generic `<UNK>` token to mitigate data sparsity. Note, that prior to constructing any vocabularies, the tokens were POS and NER tagging meaning the `<UNK>` retain their tags.

> NEED TO APPLY PUNCUATION REMOVAL AND CAP LOWER CASE NORAMLISATIONS. This is exclusively for Word2Vec but do it for BoW to keep experiment constistent.

## 3.6.2 The Subword Pipeline (DeBERTa)
Conversely, to support the evaluation of H2, text sequences were processed using DeBERTa’s native SentencePiece tokenizer. This is a form of subword tokenization which bypasses the OOV problem entirely by breaking unseen or rare words into frequently occurring sub-units, ensuring open-vocabulary coverage without relying on manual feature tags.

Note, that the input to the SentencePiece tokenizer is not already tokenized whole words like would be the case with a WordPiece pipline, thus unfortunetly is not a measureable extension of the whole word tokenziation. Instead, This approach treats the entire text input as a raw, continuous byte stream, handling whitespaces as a distinct, visible symbol. 

Despite this divergence in processing, we are still able to retain the tagged (POS + NER) tuple structure with our SentencePiece components. This is acheived by mapping the resulting subword indices back to the whole-word POS and NER tags. The are two key approaches to mapping whole-word tags to pieices: Head-Token where only the first piece holds the tag or Label Duplication where all pieces hold the tag. Given this project works with text segments which are splits into a tagged snippet and sentinal context, the latter of Label Duplication was chose as the distributed tagging can be acheived though BIO. This avoids, or reduces, the possibily of a model thinking a snippet ends mid-word. This is particularly relevant for propaganda whereby users may construct "fake" words which are a mixture of existing words <can_i_find_an_example_of_this>. 

> quickly explain how this was done: Hugging Face transformers, load DeBERTa, PyTorch, Fast Tokenizers, pass string to tokenizer, `return_offsets_mapping=True`, subwords preserve dynamic index map pointing back to the original characters, word_ids() = list same list as subword tokens, Special tokens (like [CLS], [SEP], or padding) are mapped to None, Subwords belonging to the first word are mapped to 0, Subwords belonging to the second word are mapped to 1, and so on, loop through words_ids, if valid int, use into to look up corresponding whole-word POS or NER tag from the SpaCy/NLTK list.

Note that SentencePiece operating using a fixed, pre-defined vocabulary of universally frequent character chunks selected and optimized during large-scale pre-training. This setup allows the processing of unseen or low-frequency domain word through systematically compositing its pre-initalized vocabuluary to represent the given words. This means rebulding the word as known sub-units, or at its most extreme, by its individual root characters. 

These individual constituent components are selected as the vocabulary appear repeatedly across other contexts in the corpus, the subword pipeline completely eliminates hapax legomena from the statistical profile. By shifting the burden of data sparsity from the vocabulary layer to the structural sequence layer, Transformers entirely bypass the constraints of Zipf’s Law.

> what is the siz of the "vocab" i used?

For clarity, when we say that SentencePiece eliminates Hapax, we are not saying that the training corpus will provide instances of all 30k vocab components. Instead we are saying that these tokenization methods and the subsequent models that used these pieces represent a shift in paradigm away from atomic, count-based vocabulary constraints toward compositional, sequence-level representations which build up the contextual meaning of an input. This is imensely important for project with a small training corpus whereby co-corruence weighted models risk overfitting based on the specific sample bias of the given training population. 

## 3.6.3 Corpus Empirical Characteristics (EDA)

The structural divergence between these pipelines highlights the extreme data sparsity dictated by Zipf's Law within this corpus.

Table X: Vocabulary and Token Statistics across Pipelines

Metric,Whole-Word Pipeline (Gold Only),Subword Pipeline (DeBERTa),Enriched Pipeline (Gold + Silver)
Total Tokens,[Count],[Count],[Count]
Unique Vocabulary Size,[Count],"30,000 (Fixed)",[Count]
Hapax Legomena Count,[Count (approx 50%)],0,[Count]
Most Frequent Non-Stopwords,"[e.g., Trump, President]",[Subwords],"[e.g., Trump, President]"

As illustrated in Table X, the whole-word vocabulary is heavily imbalanced, with a long tail of rare words that risk causing frequency-based classifiers to overfit. This statistical profile justifies the data augmentation strategy detailed in Section 3.3. Note that, the inclusion of silver data does not artificially expand the vocabulary breadth, but rather injects vital co-occurrence mass to strengthen the statistical signal of these vulnerable, low-frequency lexical anchors.

---

# 4. Task Methodologies
This section details the architectural frameworks implemented to evaluate the underlying linguistic hypotheses and outlines the theoretical justifications governing their design choices.

For Task 1 (Classification), a static Word2Vec framework is contrasted against a DeBERTa Transformer to evaluate the relative utility of utility of static semantic similarity versus dynamic, self-attentive sequence representations.

For Task 2 (Joint Detection and Classification), a decoupled, binary pipeline utilizing the optimal sequence classifier from Task 1 is pitted against an integrated Multi-class BIO-CRF model. This systematic comparative analysis isolates whether the primary rhetorical signal of propaganda resides within localized lexical triggers or within the complex, non-compositional structural relationships distributed across the wider sentence.

---

## 4.1. Task 1: Propaganda Technique Classification

Task 1 is a single-label, multi-class classification problem targeting the eight distinct propaganda techniques. This task excludes the `not_propaganda` class which subsequently also eliminates any significant class-imbalance. 

To systematically evaluate the Lexical Trigger Hypothesis ($H1$) against the Structural Irregularity Hypothesis ($H2$), I implement a tiered lineage of models, starting with frequency-based baselines, progressing to semantic concept modeling (Word2Vec), and concluding with contextualized attention mechanisms (Transformers).

---

### 4.1.1 Baselines

To calibrate model performance and establish reference boundaries, two distinct baselines are constructed.

---

#### 4.1.1.1 Unintelligent Baseline (Uniform Random Guessing)
This unintelligent baseline assigns a uniform probability ($P = 0.125$) to each of the eight categories. It establishes the mathematical floor for the task. Any trained framework that fails to substantially outperform this boundary indicates a failure to extract transferable signal from the corpus, pointing to severe model degradation, non-sensical architecture, or catastrophic overfitting.

---

#### 4.1.1.2 Intelligent Baseline (Unigram Bag-of-Words)
This baseline uses raw frequency counts to represent text segments as high-dimensional, sparse vectors, entirely discarding syntactic arrangement. The unigram model serves as the primary empirical benchmark for evaluating the Lexical Trigger Hypothesis ($H1$). If propaganda techniques can be identified strictly via the isolated presence of emotionally charged keywords, this unordered representation will achieve competitive accuracy, rendering the complexity of the chosen task methodologies redundant. 

---

#### 4.1.1.3 Snippet vs Sentinel Context
To explicitly test the necessity of contextual framing, both the Bag-of-Words baseline and the neural frameworks are subjected to an ablation experiment across a staggered text constraint:

1. **Snippet-Isolated:** The input sequence is truncated strictly to the tokens residing within the <BOS> and <EOS> boundaries.
2. **Unified Sequence:** The model evaluates the complete sentence string, capturing the full sentential context surrounding the manipulative fragment.

Comparing these two dimensions measures whether local lexical choices provide sufficient signal for technique identification, or whether wide contextual framing is structurally mandatory.

Furthermore, this structure will be retained accross all of the classification tasks approaches and thus the intra-approach differences in performance may provide insight as to successes and failrures. 

--- 

#### 4.1.1.4 Tagging Tokens
To prevent the frequency-based unigram baseline from overfitting to highly specific proper nouns, it leverages the tuple-structured token representations defined in Section 3.2. Rare and Out-of-Vocabulary (OOV) tokens occurring below a set frequency threshold are collapsed into generalized abstraction tokens `<UNK>` augmented with their Part-of-Speech (POS) and Named Entity Recognition (NER) tags (e.g., UNK_PROPN_PERSON).

While the exact textual string does not prevail in these sparse contexts, this token-substitution strategy ensures the model retains abstract grammatical and semantic footprints. For example, if a snippet uses a rare, person-specific slur paired with a derogatory adjective, the exact tokens collapse, but the underlying structure—an adjective targeting a recognized individual (UNK_ADJ modifying UNK_PROPN_PERSON)—carries through. Though this structural footprint is heavily diluted within an unordered frequency matrix, it provides a counterfactual for the neural models; because unigrams are inherently devoid of sequential or self-attentive ordering rules, they establish the absolute limit of what can be inferred via lexical frequency alone.

---

### 4.1.2 Standardized Classification Head

To isolate the performance of the word representations themselves, all neural models in Task 1 share a standardized downstream Classification Head consisting of a Multi-Layer Perceptron (MLP) coupled with a final Softmax activation layer.

To transform individual token vectors into a unified sequence representation prior to classification, the tokens are aggregated via a mean-pooling layer to standardize the dimensional input into the head.

This pooled representation is passed to a fully connected linear layer. To introduce the non-linear decision boundaries necessary for capturing complex rhetorical patterns, a Rectified Linear Unit (ReLU) activation function ($g(z) = \max(0, z)$) is applied.

To mitigate the risk of co-adaptation and overfitting within the dense layers, a Dropout regularization layer is introduced, which randomly masks a parameterized percentage of activations during training forward-passes.

Finally, a Softmax layer normalizes the raw output logits into a valid probability distribution over the eight target categories:

$$\sigma(\mathbf{z})_i = \frac{e^{z_i}}{\sum_{j=1}^{8} e^{z_j}}$$

The network parameters are optimized iteratively via backpropagation using Cross-Entropy Loss to calculate the prediction error relative to the gold labels.

By keeping this classification head mathematically and architecturally constant across BoW Baseline, Word2Vec and DeBERTa implementations, the experimental framework isolates the embedding variable.

Any observed empirical variances can therefore be strictly attributed to the semantic density and contextual flexibility of the upstream embeddings rather than architectural bias.

---

### 4.1.3. Classification Approach 1: Static Word Embeddings (Word2Vec)

Zipf's Law describes how word usage in natural language is inherently uneven, resulting in a long tail of rare words. This poses a major challenge for frequency-based approaches, as the resulting vectors or matrices are highly sparse, leaving the vector space mostly empty (filled with zeros). To mitigate this severe data sparsity, we need architectures which transition to mapping language into dense, continuous vector spaces whereby conceptual similarity corresponds to geometric proximity. 

This aligns with the framework of Distributional Semantics which is built upon the Distributional Hypothesis (Harris, 1954; Firth, 1957) suggesting that meaning is derived from linguistic context.

Traditional approaches within this framework relied on mathematical tools such as SVD to extract semantics from global document co-occurrence analysis. However, propaganda primarily manifests as localized rhetorical shifts rather than document-wide macro-sentiments, therefore, vectors designed to predict local context are vastly preferable (Baroni et al., 2014).

Word2Vec (Mikolov et al., 2013) implements a local window-based optimization which is distinctly well-suited for extracting relevant manipulative signals. It utilizes gradient descent to adjust randomly initalized dense token vectors based on their surrounding linguistic neighbors. 

Through backpropagation, words sharing similar statistical environments are nudged into close geometric proximity, forming dense semantic clusters. This process, which functions mathematically as implicit matrix factorization (Levy & Goldberg, 2014), acts as a powerful regularizer. It allows the model to share statistical strength across synonyms, enhancing generalization capabilities which is critical given the limited size of the training corpus.

To evaluate entire sequences, the individual token vectors are aggregated into a single sequence representation via additive composition, specifically mean pooling. However, because vector addition is commutative, this Bag-of-Embeddings approach inherently erases all word order, syntax, and structural modifications. Furthermore, while Word2Vec utilizes context during pre-training, the resulting static embeddings remain entirely context-blind at inference. Consequently, this architecture operates as an advanced "vocabulary-plus" paradigm. It is structurally incapable of evaluating the non-compositional dynamics required by the Structural Irregularity Hypothesis (H2) and serves strictly as an enhanced test for the Lexical Trigger Hypothesis (H1).

A notable operational limitation of this framework is its vulnerability to Out-of-Vocabulary (OOV) terms. Because Word2Vec relies on a fixed vocabulary and lacks the subword tokenization mechanisms utilized by contemporary models (e.g., BPE or WordPiece), unseen tokens are completely omitted from the compositional sequence. This represents a localized loss of signal compared to the intelligent baseline's robust POS/NER augmented abstraction. 

Empirically, the semantic generalization capabilities of this continuous space are expected to yield a higher Recall than the unigram baseline by successfully matching unseen synonymous triggers. Conversely, the inability to isolate syntactic structure risks causing false-positive clustering among topically related but non-propagandistic terms, which threatens to degrade overall Precision.

---

#### 4.1.3.1 Implementation
This is a vocabulary based model with <NUM_of_WORDs_IN_MODEL> whereby each word is represented by a 300-dimensional dense vector <?>. 

I utilize pre-trained Google News Word2Vec embeddings to leverage general-world knowledge of semantic similarity. 

> Return to this once coded.

----















### 4.1.3. Classification Approach 1: DeBERTa










































---

####  References

Lasswell, H.D., 1927. The theory of political propaganda. American political science review, 21(3), pp.627-631.

---

Jowett, G.S. and O'donnell, V., 2018. Propaganda & persuasion. Sage publications.

---
 
Da San Martino, G., Yu, S., Barrón-Cedeno, A., Petrov, R. and Nakov, P., 2019, November. Fine-grained analysis of propaganda in news articles. In Proceedings of the 2019 conference on empirical methods in natural language processing and the 9th international joint conference on natural language processing (EMNLP-IJCNLP) (pp. 5636-5646).

---
 
Da San Martino, G., Barrón-Cedeño, A., Wachsmuth, H., Petrov, R. and Nakov, P., 2020, December. SemEval-2020 task 11: Detection of propaganda techniques in news articles. In Proceedings of the fourteenth workshop on semantic evaluation (pp. 1377-1414).

---
 
Rashkin, H., Choi, E., Jang, J.Y., Volkova, S. and Choi, Y., 2017, September. Truth of varying shades: Analyzing language in fake news and political fact-checking. In Proceedings of the 2017 conference on empirical methods in natural language processing (pp. 2931-2937).

---
 
Sag, I.A., Baldwin, T., Bond, F., Copestake, A. and Flickinger, D., 2002, February. Multiword expressions: A pain in the neck for NLP. In International conference on intelligent text processing and computational linguistics (pp. 1-15). Berlin, Heidelberg: Springer Berlin Heidelberg.

---
 
Miller, G.A., 1995. WordNet: a lexical database for English. Communications of the ACM, 38(11), pp.39-41.

---
 
Harris, Z.S., 1954. Distributional structure. Word, 10(2-3), pp.146-162.

---
 
Firth, J.R., 1957. A synopsis of linguistic theory. Studies in linguistic analysis, Special volume of the philological society/Blackwell.

---
 
Mikolov, T., Chen, K., Corrado, G. and Dean, J., 2013. Efficient estimation of word representations in vector space. arXiv preprint arXiv:1301.3781.

---
 
Elman, J.L., 1990. Finding structure in time. Cognitive science, 14(2), pp.179-211.

---
 
Hochreiter, S., 1997. Long short-term memory. Neural Computation MIT-Press.

---
 
Ma, X. and Hovy, E., 2016, August. End-to-end sequence labeling via bi-directional lstm-cnns-crf. In Proceedings of the 54th Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers) (pp. 1064-1074).

---
 
Graves, A. and Schmidhuber, J., 2005. Framewise phoneme classification with bidirectional LSTM and other neural network architectures. Neural networks, 18(5-6), pp.602-610.

---
 
Lafferty, J., McCallum, A. and Pereira, F.C., 2001. Conditional random fields: Probabilistic models for segmenting and labeling sequence data.

---
 
McCallum, A., Freitag, D. and Pereira, F.C., 2000, June. Maximum entropy Markov models for information extraction and segmentation. In Icml (Vol. 17, No. 2000, pp. 591-598).

---
 
Vaswani, A., Shazeer, N., Parmar, N., Uszkoreit, J., Jones, L., Gomez, A.N., Kaiser, Ł. and Polosukhin, I., 2017. Attention is all you need. Advances in neural information processing systems, 30.

---
 
Devlin, J., Chang, M.W., Lee, K. and Toutanova, K., 2019, June. Bert: Pre-training of deep bidirectional transformers for language understanding. In Proceedings of the 2019 conference of the North American chapter of the association for computational linguistics: human language technologies, volume 1 (long and short papers) (pp. 4171-4186).

---
 
He, P., Liu, X., Gao, J. and Chen, W., 2020. Deberta: Decoding-enhanced bert with disentangled attention. arXiv preprint arXiv:2006.03654.

---
 
Brown, T., Mann, B., Ryder, N., Subbiah, M., Kaplan, J.D., Dhariwal, P., Neelakantan, A., Shyam, P., Sastry, G., Askell, A. and Agarwal, S., 2020. Language models are few-shot learners. Advances in neural information processing systems, 33, pp.1877-1901.

---
 
Raffel, C., Shazeer, N., Roberts, A., Lee, K., Narang, S., Matena, M., Zhou, Y., Li, W. and Liu, P.J., 2020. Exploring the limits of transfer learning with a unified text-to-text transformer. Journal of machine learning research, 21(140), pp.1-67.

---
 
Tai, K.S., Socher, R. and Manning, C.D., 2015, July. Improved semantic representations from tree-structured long short-term memory networks. In Proceedings of the 53rd Annual Meeting of the Association for Computational Linguistics and the 7th International Joint Conference on Natural Language Processing (Volume 1: Long Papers) (pp. 1556-1566).

---
 
Peters, M.E., Neumann, M., Zettlemoyer, L. and Yih, W.T., 2018. Dissecting contextual word embeddings: Architecture and representation. In Proceedings of the 2018 conference on empirical methods in natural language processing (pp. 1499-1509).

---

References to add:
- LTIatCMU(SI:4) (Khosla et al., 2020)
- Team UPB(SI:5) (Paraschiv and Cercel, 2020)
- Team DoNotDistribute(SI:22) (Kranzlein et al., 2020)
- (Brown et al., 2020)
