# Advanced Natural Language Processing (968G5): Assessed Coursework

Format Submit a single zip file containing 1 pdf and an appendix of your code (which may be a `.ipynb` or a `.py` file)

**Word count Expected:** 8 pages (approx. 3000 words; absolute max 5000 words) plus figures, references and code appendix.

1. [Practical assignment (3000 words): Propaganda Detection](#1-practical-assignment-3000-words-propaganda-detection)
    - [1.1 Data Setup](#11-data-setup)
        - [1.1.1 Label Column](#111-label-column)
        - [1.1.2 Sequence Column](#112-sequence-column)
    - [1.2 Tasks](#12-tasks)
        - [Task 1: Build and evaluate at least 2 different approaches to classifying the propaganda technique](#task-1-build-and-evaluate-at-least-2-different-approaches-to-classifying-the-propaganda-technique)
        - [Task 2: Build and evaluate either 2 different approaches or at least 2 variations on a single approach to detecting propaganda within a sentence.](#task-2-build-and-evaluate-either-2-different-approaches-or-at-least-2-variations-on-a-single-approach-to-detecting-propaganda-within-a-sentence)
    - [1.3 Resources and Academic Integrity](#13-resources-and-academic-integrity)
    - [1.4 Report Format and Structure](#14-report-format-and-structure)
2. [2. Marking Criteria and Requirements](#2-marking-criteria-and-requirements)
    - [Table 1: Breakdon of Marks](#table-1-breakdon-of-marks)
    - [Table 2: Marking Scale](#table-2-marking-scale)
3. [3. Planning](#3-planning)
    - [Hypothesis](#hypothesis)
    - [Task 1: Classifcation Ideas](#task-1-classifcation-ideas)
        - [BoW Baseline](#bow-baseline)
        - [Approach 1: Bag-of-Embeddings](#approach-1-bag-of-embeddings)
        - [Approach 2: BERT-based Transformer](#approach-2-bert-based-transformer)
        - [Possible Lineage](#possible-lineage)
        - [Task 1 Evaluation](#task-1-evaluation)
    - [Task 2: Sequence Labeling Ideas](#task-2-sequence-labeling-ideas)
        - [Task 2 Evaluation](#task-2-evaluation)
    - [Data Augmentation Options](#data-augmentation-options)
    - [Potential Ideas](#potential-ideas)
        - [Custom Soft Bounary Snipper Evaluation Method](#custom-soft-bounary-snipper-evaluation-method)
        - [POS Tag Only Model](#pos-tag-only-model)
        - [Perplexity as proof of hypothesis](#perplexity-as-proof-of-hypothesis)
        - [Task 1 Feature Comparison Analyis](#task-1-build-and-evaluate-at-least-2-different-approaches-to-classifying-the-propaganda-technique)
4. [4. Structure](#4-structure)
    - [1. Introduction]()
    - [2. Related Work]()
        - [2.1 Dataset Exploration and EDA]()
    - [3. Methodology: Task 1 (Classification)]()
        - [Baselines: ]()
        - [Approach 1: Bag-of-Embeddings]()
        - [Approach 2: Transformer Architecture]()
        - [Hyper-parameters]()
    - [4. Methodology: Task 2 (Span Identification)]()
        - [Variation 1: The Pipeline (Binary BIO + Classifier):]()
        - [Variation 2: Integrated Multi-class BIO-CRF:]()
        - [Theoretical Justification: ]()
    - [5. Results and Evaluation]()
    - [6. Analysis and Discussion]()
    - [7. Conclusion and Further Work]()
    - [Strategic Tips for High Marks:]()

# 1. Assignment: Propaganda Detection

## 1.1 Data Setup

You are provided with a zipfile `propaganda_dataset`. This includes 2 files with identical format: one for training and one for testing. Each file is in tab-separated-value (tsv) format with 2 columns as illustrated below.

| label | sentence |
| :--- | :--- |
| `flag_waving` | I want to get `<BOS>`our soldiers`<EOS>` out. |
| `not_propaganda` | Our older measure of `<BOS>`American Worker Displacement`<EOS>` understated the problem. |
---

### 1.1.1 Label Column

The first column contains a `label` from a set of 9 possibilities which are:
1. `flag_waving`
2. `appeal_to_fear_prejudice`
3. `causal_simplification`
4. `doubt`
5. `exaggeration`,`minimisation`
6. `loaded_language`
7. `name_calling`,`labeling`
8. `repetition`
9. `not_propaganda`

The first 8 labels are all propaganda techniques and are a subset of those identified in the Propaganda Techniques Corpus (Da San Martino et al., 2020). 

The final label `not_propaganda` indicates that no propaganda has been identified in the text. 

---

### 1.1.2 Sequence Column

The second column contains a `sentence` or chunk of text where the propaganda technique has been identified (or no propaganda has been identified in the case of `not_propaganda`).

Note the use of additional tokens `<BOS>` and `<EOS>` which indicate the beginning and end of the `snippet` or span of text (within the sentence) which is actually annotated with the given propaganda technique.

In the first example above, the `snippet` or span of text “our soldiers” has been identified as an example of `flag_waving` in the context of the sentence “I want to get our soldiers out.

---

## 1.2 Tasks

### Task 1: Build and evaluate at least 2 different approaches to classifying the propaganda technique 
... which has been used in a `snippet` or span of text which is known to be propaganda. 

As input, your system might take a snippet of propaganda `AND` its sentential context. The output should be the propaganda technique used.

---


### Task 2: Build and evaluate either 2 different approaches or at least 2 variations on a single approach to detecting propaganda within a sentence. 
Your system should identify both the span and the propaganda technique used.

---

In this assignment you are expected to complete both tasks above and investigate different approaches for each. 

The approaches used for task 2 may be the same, related or completely different to the approaches used in task 1. 

Your solution does not need to be novel.

It does not matter how well your method(s) perform. 

However, your methods should be clearly described, any hyper-parameters (either fixed, varied or optimised) should be discussed and there should be a clear comparison of the approaches with each other — from theoretical, practical and empirical perspectives. 

If you are unsure whether your approaches are sufficiently different to each other then you should discuss this with one of the TAs. 

For example, two different bag-of-words classifiers do not count as 2 different approaches. Neither do 2 different large language models. These count as variations on a single approach.

---

## 1.3 Resources and Academic Integrity
You have been provided with the training and test data for this task with the assignment. You may (and are expected to) use any of the code that you have developed throughout the labs. This includes code provided to you in the exercises or solutions. You may use any other resources to which you have access. You may also download other resources from the Internet and make use of any Python libraries with which you are familiar. All code that you use (libraries, lab solutions and open source code) should be properly accredited within your code base and within your report e.g., “my function for X is adapted from code available at Y”

Generative and other AI tools may be used in an assistive capacity in this assignment. This includes assistance with coding and with proof-reading. Please include a statement on the title page of your assignment stating whether or not AI has been used in any way, and if so, which tool(s) has been used and in what way.

## 1.4 Report Format and Structure
Your report should be in the style of an academic paper

It should include an introduction to the problem and the methods you have implemented.

It should contain a brief discussion of related work in the area but the focus here should be on your practical work rather than producing a comprehensive literature review.

Also, make sure you describe your solution and not just the theoretical background of the approach. For example, the theoretical background on how word embeddings are learnt using word2vec might be useful to motivate your approach but does not constitute a description of your method to solving the task using word2vec — there are many ways word2vec can be used to provide a solution and it is this that you should focus on in the description of your method.

You should also make sure you discuss any hyper-parameter settings - both those which you have decided to fix and any which you are investigating. 

Justify your design decisions.

You should discuss and justify the method of evaluation.

You should provide your results and compare them with any baselines.

You should also provide some analysis of errors — do the approaches make the same or different mistakes and can you comment on the types or causes of errors being made?

You should end with your conclusions and areas for further work. 

You should also submit your code as an appendix.

Your report (including figures and bibliography but not including code appendix) should be no longer than 8 sides (3000 words of text plus figures and bibliography). 

Your code in the appendix should be clearly commented.

# 2. Marking Criteria and Requirements
This coursework will be marked out of 100. Marks will not be awarded simply for how well your system does or for programming wizardry. Marks will be awarded for clearly evaluating possible solutions to the tasks set out above.

Table 1 shows the number of marks available for each requirement.

### Table 1: Breakdon of Marks

| Requirement | Max Mark | Interpretation | 
| :--- | :--- | :--- |
| problem outline | 10 | Does the introduction explain the task including why it is important and challenging? |
| method | 25 | Is there a clear description of the proposed methods for tackling the tasks? Do the proposed methods seem sensible? Novel or more interesting methods may score highly here (if well-described) but methods will not necessarily gain more marks simply by being more ambitious. |
| hyper-parameter settings | 10 | Within each proposed method, are there any hyper-parameter settings which are being fixed or explored? Are these clearly explained? |
| results and evaluation | 25 | Have a reasonable number of results been produced? Is the method of evaluation stated, explained and justified? Are results clearly presented (in a table and/or a graph!)? |
| analysis | 10 | Is there an analysis of errors of the methods? Are there particular types of input which one or both methods do badly at? |
| conclusion | 5 | Are sensible conclusions drawn throughout the work? Is the final conclusion sensible and consistent? |
| further work | 5 | Are there sensible suggestions for further work to do in this area. These might include improvements to the methods, other methods or other applications of the methods. |
| academic style | 5 | Is the report written in the style of a research paper? Are major points backed up with references? Is the report well-written and well-structured? |
| code appendix | 5 | Is the code in the appendix clear and correct? The appendix should comprise a separate code file or files (typically `.ipynb` or `.py`) in the zip file (which also contains the pdf of the report) |


For each requirement, the following scale will be used when deciding the number of marks awarded.

### Table 2: Marking Scale

---
| Grade Range | Description | 
| :--- | :--- |
| 70%-100% | Excellent. Shows very good understanding supported by evidence that the student has gone beyond what was taught by extra study or creative thought. Work at the top-end of this range is of exceptional quality. |
| 60%-69% | Very competent. Substantially complete and correct knowledge but not going beyond what was taught. |
| 55%-59% | Competent. Minor gaps in knowledge but reasonable understanding of fundamental concepts |
| 50%-54% | Borderline. Significant gaps in knowledge but some understanding of fundamental concepts |
| 30%-49% | Inadequate. Work is seriously flawed, displaying inadequate knowledge, major lack of understanding, irrelevance or incoherence. |
| 0%-29% | Nothing relevant submitted. |
---

# 3. Planning
The sections below represent a high-level plan of the content do be executed in the assignment. In their current form them are essentially a rambling of thoughts and concepts. However, they do hold the key idea from which the assignment will be driven from and scope for acheived good marks. 

## Hypothesis 
In approaching this assignment I want to outline some hypothesis early on. I see this as a strong approach as it provides me with some level of substrate to justify my design decisions on and some naravite to compare against in the evaluation and analysis sections. 

Firstly, I have a hypothesis that propagandist methods are highly reliant on the usage of particular words. These words are quite abstract and therefore are dispropotionaly over represented in proganga snippets. Therefore, I hypothesise that simple Bag-of-Word approachs may be highly affective for classifing propaganda labels, at least for some or most labels. 

Furthermore, as an extension of this hypothesis, I believe that the structure of language is another key identifiable feature in propaganda. Propaganists will use sentenes that appear to be linguistically and grammatically correct from a quick glance but when analysed are slightly off-kilter. For example, "Build the Wall and make Mexico Pay for It" is missing the grammar and structure that you would expected from a political and formal statement, it is almost written in in-formal shorthand. However, extending from the first hypothesis, I expect that the patterns are so abstract that the naunce can be identified simply by the unusual word pairings which are created by the loss of strictly correct grammar. Therefore, I hypthosesis that you can get most of the way there as using bag-of-words approaches, or at least something closely related to bag-of-words, i.e. word2vec (bag-of-embeddings), or a bi-gram adjsuted BoW.

Many propaganda techniques—like Loaded Language or Name Calling—rely heavily on specific lexical triggers ("traitor," "radical," "freedom-fighter") where word order matters less than the sheer presence of the "emotionally charged" word.


## Task 1: Classifcation Ideas
Task 1 is a Mutli-Label Classification Task and we need to build and evaluate two different appraoches. In input pertains to an identified snippet of propaganda as well as some surrounding context, i.e. a sentence where a portion of it is direct considered some type of propaganda. 

### BoW Baseline
Carrying on from the hypothises, it seems like a good approach would be to use a pure BoW approach as a "classical" baseline. Using it as a baseline would mean that technically it isn't one of the 2 methods built and evaluated but instead gives us a measure of how well we can identify propaganda is we essentially "do nothing". 

A BoW appraoch treats the snippet (and its context if we chose to use both) as an unordered collection of words, ignoring syntax but focusing on the presence of "trigger" words and their combinations of such. 

There are two main approaches to representing the sparse vector, either frequency counts or TF-IDF scores. Given that we are using it as a baseline, it might make sense to use a frequency approach, otherwise it may seem like we are trying to sneak in a 3 model to build and evalaute.

The baseline model could be run twice, one with just the snippet and the other with the snippet + winder sentinal context. 

We then pass these vectors into MLP head classifier to determine the label. We need to establish a "vocab" plus a way to handle unknown tokens so that we can create a fixed length vector to be plugged into the MLP. 

An alterntive idea could be to extend the frequency/td-idf to bi-grams to give us a baseline of the second hypthesis as bi-grams will give us a handle of sentence structure meaning the abstract pairing can be better analysed. 

It should be noted that whilst our hypothesis are focused on words, pairings and language structure, we recognise that context definitely matters when it comes to propagana, its just we think that a huge amount of weight can go into the bizzare choice of words and their combinations, hence, BoW may give a strong baseline for classifcation. 

**Baseline 1:** BoW (Freq or Tf-Idf)
**Baseline 2:** BOW Bi-Gram

---

### Approach 1: Bag-of-Embeddings
BoW treats words as atomic units but we can advance this to a Static Embedding Pooling approach (GloVe/Word2Vec). 

Comparing Unigram-BoW, Bi-gram BoW, and Word2Vec (Bag-of-Embeddings) we can systematically peel back the layers of what makes a propaganda classifier work.

The standard approach for Word2Vec is to pick up a pre-trained model such as Google News Word2Vec. This is because it takes billions of words to train a model where as our corpus is too small to generate anything meaningful from scratch. You treat the model as a static dictionary. You look up the vector for each word in your propaganda dataset. It has seen almost every word in the English language. It "knows" that "liberty" and "freedom" are similar because it read them in thousands of newspapers. It represents "Standard English." If propaganda uses a word in a very specific, non-standard way (e.g., a "dog whistle" or a specific political slang), a pre-trained model might miss that nuance because its vector was averaged out over billions of neutral sentences. There is an approach to fine-tuning W2V that could be exploreed. In Python (using the `Gensim` library), this involves loading the model, calling `build_vocab` with `update=True`, and then running the train method on your new data.

Word2Vec uses pre-trained dense vectors to capture **semantic similarity**. For every word in the propaganda snippet Word2Vec embedding. Combine these into a single "sequence vector" using **Additive Composition** (summing or averaging the vectors to find the centroid). 

Feed the resulting fixed-length vector into a standard Multi-Layer Perceptron (MLP). It makes sense to stick with an MLP for consistency between baselines and approaches. 

Note, this is will a **"bag-of"** approach as it still ignores word order. It is trained by looking at a surround window but that doesn't mean it learns the synactic rules. It is an advancement on BoW as it understands that words are similar based on their embeddings, where as BoW does not. 

An embedding approach will lower the potential for overfitting compared to BoW which a sprase vector whereby high dimension values are prone to overfitting. Word2Vec creates a dense vector (usually 300) which forces the model to generalize across a smaller, more meaningful feature set, which acts as a form of implicit regularization.

The Word2Vec should improve the models Recall. This is because a BoW is hypersensitive to key words. If it sees a unseen word or synonym it cannot identify that as the same sentiment. Higher recall means it caputure for of the progaganda that exists. However, it may produce lower Precision if there are examples where a specific word in a specific context is the propaganda itself, meaning a synonymn is incorrect. 

**Comparison 1 (Bi-gram vs. Unigram):** If Bi-grams perform better, you have proven that propaganda isn't just about words, it's about phrasing and structure.

**Comparison 2 (Bi-gram vs. Word2Vec):** This is the most interesting. Bi-grams have order but no semantic flexibility. Word2Vec has semantic flexibility but no order. If **Bi-grams win:** Structure is more important than synonyms for this task. **If Word2Vec wins:** Vocabulary breadth is the dominant signal.

"In my Word2Vec baseline, I treat the snippet as a Bag-of-Embeddings. While Word2Vec vectors capture semantic similarity via the distributional hypothesis (the 'window' method used during pre-training), they remain static. This means the model cannot distinguish between different senses of a word or recognize how a specific 'abstract pairing' in a propaganda snippet changes the meaning of its constituent words. This limitation justifies the transition to Contextualized Embeddings (BERT/DeBERTa), which use self-attention to generate token representations that are aware of the unique, often irregular, structure of the input sentence."

| Approach | Primary "Knowledge" | Hypothesis being tested | 
| Unigram-BoW | Pure Vocabulary | "Propaganda is just about specific bad words." | 
| Bi-gram BoW | Local Phrasing | Local Phrasing | 
| Word2Vec | Semantic Concepts | "Propaganda is about the meaning of the words, regardless of the exact synonym used." | 

Word2Vec is a sophisticated extension of the Pure Vocabulary route (BoW). If we see that it beats the uni-gram approach then we know that there is some value in these contexual vectors providing knowledge on similarity. However, if it fails to beat the Bi-gram BoW we know that structure is the more pressing matter. 

Word2Vec is a justified design route due to the **Distributional Hypothesis:** "You shall know a word by the company it keeps." Unigram-BoW is a surface-level application of the hypothesis. W2V is the "latent" application of the same hypothesis. It uses the same vocabulary but compresses that "company" into a dense vector space.

We are moving from Explicit Vocabulary (BoW) to Latent Semantic Vocabulary (Word2Vec). Both are still fundamentally "bags" because they don't care about the specific order of words in your current sentence, only the general meaning of the words themselves.

Additoinally, You can justify Word2Vec as a way to fix the primary weakness of the "Pure Vocabulary" approach: **Lexical Sparsity**. By using a "Bag-of-Embeddings," you are testing the hypothesis that **Semantic Concepts** are the true signal for propaganda, not specific strings of characters. Word2Vec is "vocabulary-plus"—it’s the same "no-structure" approach but with a built-in thesaurus derived from millions of other documents.

|  | Pure Vocabulary (Unordered) | Structured Phrasing (Ordered) |
| :--- | :--- | :--- |
| Discrete/Sparse | Baseline 1: Unigram-BoW | Baseline 2: Bi-gram BoW |
| Dense/Distributed | Extension: Word2Vec (Bag-of-Embeddings) | High-Tech: Transformers (Contextualized) |

"If Word2Vec outperforms Unigram-BoW, it proves that propaganda relies on Semantic Clusters (e.g., any word relating to 'patriotism') rather than fixed 'trigger words.' However, if Bi-gram BoW outperforms Word2Vec, it suggests that the local structure (the 'abstract pairings') is actually more important than semantic flexibility."

**Word2Vec's "Knowledge":** It has Global knowledge of word meanings from its massive pre-training, but Zero knowledge of the current sentence's structure.

**Bi-gram's "Knowledge":** It has Zero global knowledge (it doesn't know "freedom" = "liberty"), but it has Local knowledge of the current sentence's syntax.

The BoW and Word2Vec approaches should have the same classficaiton head so we can isolate the impact of the variables, not the arcitecture. 

By keeping the classification head identical — for example, a Multi-Layer Perceptron (MLP) with one hidden layer — we ensure that the only variable being tested is the Input Representation.

Word2Vec embeddings are designed to be used with neural layers. An MLP can learn non-linear relationships between the 300 dimensions of a Word2Vec vector.

**How to align them:** Use a standard Linear -> ReLU -> Dropout -> Linear -> Softmax head. The only thing that changes is the input dimension of the first linear layer (e.g., 5000 for BoW vs. 300 for Word2Vec).

---

### Approach 2: BERT-based Transformer
A transformer based model is the gold standard for sequence classifcation utilizing deep contextualized embeddings and that do account for word order. BERT uses **self-attention** to allow every word to "pay attention" to every other word, resolving the meaning of the snippet based on the context. Trasformers make use of **transfer learning** and pre-trained model. A decision will need to be made on whether to **freeze or fine-tune** the base models weights. Again, a classifcation head will be added to do the predicition this should be a MLP for consistency. 

An important decision is needed to be made within a BERT model on how to compile the **sequence level representation**. By definition BERT models create a `CLS` summary token but depending on how the input processed, this could be of the entire sentence. Not just the snippet. One method might be to extract the hidden states for only the tokens located between the <BOS> and <EOS> markers and pass their average (or max) to the classification head. This could force the model to focus on the snippet words, but through the self-attention mechanism these tokens are aware of the wider context. Could just experienment with both. 

Also, BERT alternatives often drop "Next Sentence Prediction" (NSP) and focus on better masking, RoBERTa or DeBERTa would be more "modern" choices than the original BERT. DeBERTa in particular uses a "disentangled attention" mechanism that might be very good at picking up those "unusual word pairings". A decision needs to be made on the exact model. 

> DeBERTa (Decoding-enhanced BERT with disentangled attention). It is a more advanced version of BERT that separates the "content" of a word from its "relative position."

There can be a disuccision of BERT-style (Encoder) vs GPT-style (Decoder) when discussing "Transformers" in justifying this particular design choise. GPT models are autoregressive, they see text from left-to-right. BERT models are are bidirectional. Every token can "attend" to every other token in the sequence simultaneously. Propaganda often relies on contextual framing. A word might seem innocent until you reach the end of the sentence and see the "target" it is attacking, hence, giving BERT the architectural advantage.

The field distinguishes between Natural Language Understanding (NLU) and Natural Language Generation (NLG). Encoders (BERT/RoBERTa/DeBERTa) are designed for NLU. Their entire objective during training is to create the richest possible mathematical representation of a static piece of text. Decoders (GPT/Llama) are designed for NLG. Their objective is to predict the next token. To make a GPT model classify, you have to "force" it (either through prompting or adding a classification head to the last token).

There are several evaluation metrics to take into account but possibly an important one is Macro-Average F1. Propaganda datasets are typically very unbalanced, macro-averaging ensures your model is penalized if it ignores rare but important categories like "Causal Simplification" in favor of the more common "Loaded Language".

### Possible Lineage
- **Baseline (BoW/Bi-grams):** Establish your hypothesis. "I suspect lexical choices are the primary signal."
- **Modern Baseline (Word2Vec/GloVe):** Move from words to "concepts" (Distributional Semantics).
- **High-Tech (Transformer + Interpretability):** Use the big model to see if the "contextual nuance" actually adds anything over the BoW approach.

### Task 1 Evaluation
In such multi-class problems, "Accuracy" can be a trap due to class imbalance.

**Macro-Average F1 (Primary Metric):** This is the most "Masters-level" metric for this task. Because propaganda techniques like "Loaded Language" are far more common than "Causal Simplification," a model could achieve high accuracy by simply ignoring the rare classes. Macro-averaging treats every class as equally important, forcing your model to be a "specialist" in all 9 categories.

**Confusion Matrix:** Beyond single numbers, a confusion matrix is vital for your report's "Empirical Perspective". It will show you which techniques are being confused—for example, does your BoW model struggle to distinguish "Name Calling" from "Loaded Language"?.

**Micro-Average F1 vs. Accuracy:** Your notes highlight that for single-label multi-class tasks, Micro-F1 is mathematically identical to Accuracy. In your report, you can demonstrate technical depth by explaining why Micro-F1 provides a "false sense of security" by letting dominant classes hide failures in the "long tail" of rare propaganda techniques.


## Task 2: Sequence Labeling Ideas
Span identification is a **Sequence Labeling** task (where you assign a label to every single token, e.g., using BIO tagging: Beginning, Inside, Outside).

This is where the LSTM — and specifically the CRF (Conditional Random Field) layer—shines. We can implement the Ma and Hovy architecture (CNN + Bi-LSTM + CRF) as a "global sequence labeling task" rather than just a series of independent word classifications. 

**Label Bias Problem** occurs because a standard Transformer or a simple RNN makes "local" decisions for each word, i.e. "I need to label this token right now, what is it". However, a CRF looks at the entire sequence of tags. It "knows," for example, that an "Inside-Propaganda" tag cannot mathematically follow a "Not-Propaganda" tag.

"For Task 1, I leveraged the Self-Attention mechanism of a Transformer to validate my hypothesis regarding lexical triggers and abstract pairings. For Task 2, I transitioned to a Recurrent architecture (Bi-LSTM) coupled with a Probabilistic Graphical Model (CRF) to handle the structural dependencies inherent in span identification."

We can argue that identifying where propaganda starts and ends is a matter of local syntax and morphology (perfect for Bi-LSTMs and character-level CNNs), whereas identifying what kind of propaganda it is requires global semantics (perfect for Transformers).

Instead of predicting if a word is propaganda in isolation, a CRF looks at the entire sequence of labels. It calculates the probability of the entire tag sequence at once. Propaganda spans are continuous. A CRF "knows" that a "Propaganda-Inside" tag cannot follow a "Not-Propaganda" tag without a "Propaganda-Beginning" tag first. 

The "Ma and Hovy" Architecture (CNN-BiLSTM-CRF) is the "gold standard" architecture for sequence labeling and it tackles our "grammatical irregularity" hypothesis at three different levels:
- **Level 1: Character-level CNN:** This handles "morphological irregularities." If a propaganda snippet uses weird prefixes, suffixes, or misspelled "shouty" words, the CNN picks up on the character patterns that word-level models miss.
- **Level 2: Bi-LSTM:** This captures the "flow." It sees how a word's meaning is influenced by the words before and after it, identifying the "abstract pairings" you mentioned.
- **Level 3: CRF Layer:** As mentioned above, this ensures the output is a valid, coherent span rather than a "stuttering" prediction of random tags.

Our hypothesis about "loss of strictly correct grammar" is a major selling point for using the Character-level CNN component of the Ma and Hovy architecture.

"While a standard Word-BoW would struggle with the grammatical irregularities and OOV (Out-of-Vocabulary) tokens prevalent in propaganda, the CNN-BiLSTM-CRF architecture (as per Ma and Hovy) allows for sub-word awareness. This ensures that even if a propaganda technique manifests as a grammatically broken slogan, the character-level features can still trigger a span detection."

- **Input Representation:** Convert your sentences into BIO Tagging format (B-Prop, I-Prop, O).
- **The Model:** Use a Bi-LSTM to encode the sequence and a CRF to decode the tags.
- **The Twist:** Add Character Embeddings to the input to handle the "linguistic irregularities" you're interested in.

**Feature Enrichment: POS and NER Tagging:** Propaganda spans often align with syntactic boundaries (like Noun Phrases). Adding POS tags to your Bi-LSTM-CRF helps the model learn that a span is likely to end after a noun or a punctuation mark, providing the "structural discipline" your notes mention.

The obvious starting point of Task 2 would be to create a **bolt-on pipeline** where Model A finds the span and Model B classifies it, of which Model B could be the best performing model from Task 1

However, this could be extended to an **integrated approach** where the model both identifies the span but also type too.

**The Integrated Choice: Multi-class Sequence Labeling (BIO-Class):** Expand the tag set to include the prop type. This is a very different paradigm because the model must learn the "boundaries" and the "type" simultaneously. You transform the task into an 18-class problem (9 techniques $\times$ {Beginning, Inside} + 1 "Outside" tag).
- `B-LoadedLanguage`, `I-LoadedLanguage`
- `B-FlagWaving`, `I-FlagWaving`
- `O` (Not propaganda)

The CRF becomes even more important here because it ensures tag level consistency. It prevents a snippet from flowing between propaganda states. The CRF will identify based on the whole sequence what the correct tag is, even if at some tokens in isolation the model predicts a change in tag.

"I moved to a Joint Sequence Labeling architecture (Multi-class BIO-CRF). I argue that this is superior to a 'bolt-on' pipeline because the model learns that certain linguistic structures (like 'abstract pairings') are not only indicators of where propaganda is but what kind it is, allowing for a mutually reinforcing learning signal."

In NLP research, this is often framed as the Pipeline vs. Joint Learning debate. By comparing these two, you aren't just building a model; you are conducting a structural experiment on how a model "perceives" propaganda.

**Variation 1: The Pipeline Approach (Binary BIO + Classification Head):** In this variation, you treat the problem as two distinct steps. **Step 1 (Span Detection):** A model (like a Bi-LSTM or BERT) is trained with simple B, I, O tags. It doesn't care what the propaganda is, only where it is. **Step 2 (Technique Classification):** Once a span is identified, it is "cropped" and passed to your Task 1 classification head to assign one of the 9 labels. **Pros:** The span detector has more data per tag because all 8 propaganda techniques are grouped into a single B or I class. This usually makes the "spotting" more robust. **Cons: Error Propagation.** If Step 1 misses the span or gets the boundary wrong, Step 2 is set up for failure. The classifier never gets to "see" the sentence unless the detector lets it.

**Variation 2: The Integrated Approach (Multi-class BIO)** In this variation, you expand your tagset to include the technique within the tag itself (e.g., B-Loaded, I-Loaded, B-Doubt, I-Doubt, O). **Pros:** Joint Signal. This is where your "unusual word pairings" hypothesis gets a boost. The model might realize that the word "radical" is likely to be the B (Beginning) of a Loaded_Language span. The specific "texture" of the technique helps the model find the boundaries. **Cons:** Data Sparsity. Instead of training on thousands of B tags, the model now only has a few hundred for rarer classes like Causal_Simplification.

Based on the Ma and Hovy Architecture we use the CNN-BiLSTM-CRF architecture for both variations.
- In Variation 1, the CRF layer only manages 3 tags (B, I, O).
- In Variation 2, the CRF manages 17 tags ($8 \times 2 + 1$).

**The Label Bias Problem & CRF (Week 5):** This is a key discussion point. In Variation 2, the CRF layer is doing heavy lifting. It uses Global Normalization to ensure that a B-Loaded tag isn't immediately followed by an I-Doubt tag. Discussing how the CRF maintains "structural integrity" across the 17 tags will show great technical depth.

**Global vs. Local Normalization:** You can argue that Variation 1 relies on Local decisions (find span, then classify), whereas Variation 2 uses Global sequence optimization to find the most likely "path" of techniques through the sentence.

The hypothesis about "linguistic irregularities" and "loss of grammar" is actually a strong argument for Variation 2 (Integrated). Because "grammatical loss" looks different depending on the technique. Exaggeration might use many superlatives and adverbs, while Repetition looks like a stuttering pattern. An Integrated Model can learn these specific "irregularity signatures" for each class. An Integrated Model can learn these specific "irregularity signatures" for each class.

In your report, you should explicitly compare the F1-score of these two. If Variation 1 has better Detection (finding the span) but Variation 2 has better Joint Accuracy (finding the span + the right label), you have a brilliant "Empirical Perspective" to write about. You can conclude by discussing whether "seeing the technique" actually helps the model "find the words."

> I am really interested by this variation 2 approach. By expanding the tags to capture each propaganda tags we are labelling each token from quite a wide range of options. This provides are huge amount of signal to generate. For each token we can generate a probability for each possible tag. From which the model(s) can determine the correct sequence. I think this will be particularly good for propaganda snippet wheres the boundaries are more "soft" and the true signal are in the middle of the snippet as the model can generate lower probabilties for possible tags but then high probabilities for the middle tags. Is it the CRF that goes back a connects these probablities to find the best and correct span? I seem to recall other things like beam search and viterbi algorithm from the lectures that seem conceptually similar but i think it is CRF which is the correct method here
- while the neural network (Bi-LSTM or Transformer) gives the "raw signal" for each word, it is the CRF — and specifically the Viterbi Algorithm — that turns those individual guesses into a mathematically coherent span.
- My lecture notes mention the "Label Bias Problem" in MEMMs and identify the CRF as the solution.
- A standard Softmax layer makes a local decision for every word. If a word looks 51% like `B-Loaded_Language` and 49% like `O` (Outside), it picks `B-Loaded`. It doesn't care if the previous word was also a `B-Loaded` (which is grammatically impossible—you can't have two "Beginnings" in a row without an "Inside").
- The CRF layer adds a Transition Matrix. This matrix learns that: B-Loaded $\rightarrow$ I-Loaded is very likely. O $\rightarrow$ I-Loaded is impossible ($P=0$). B-Loaded $\rightarrow$ B-NameCalling is impossible.

**Viterbi vs. Beam Search: How we find the path:**
- **Viterbi Algorithm:** This is the "exact" algorithm used by the CRF to find the global maximum probability path. It works like a trellis. It calculates every possible path through the sentence and finds the one that has the highest combined score (Emission Score from the LSTM + Transition Score from the CRF). **For your Task 2, Viterbi is the correct algorithm**.
- **Beam Search:** This is a "heuristic" (best-guess) version. It's usually used in Generative models (like T5) or Machine Translation. Because the number of possible sentences a model could generate is infinite, Viterbi is too slow, so Beam Search just keeps the "Top K" best paths at each step.

**Solving your "Soft Boundaries" problem:** The hypothesis about the "true signal in the middle" is exactly why a CRF is superior for propaganda detection: 
- **The Middle Peak:** Suppose you have a phrase: "vicious radical extremists".
- **The Signals:** A Bi-LSTM might be very confident that "radical" is `I-Loaded_Language` (High probability), but it's unsure about "vicious" (Soft boundary).
- **The CRF Logic:** The CRF "sees" the high-confidence `I-tag` in the middle. Because the "rule-book" (Transition Matrix) says an `I-tag` must be preceded by a `B-tag`, the CRF will "pull up" the probability of "vicious" being a `B-Loaded_Language` tag to complete the sequence.

"In Variation 2, I implemented a CRF layer on top of the Bi-LSTM to address the **Label Bias** Problem identified in my notes. While the Bi-LSTM provides local emission features for each token, the CRF utilizes the Viterbi algorithm to find the globally optimal tag sequence. This is particularly beneficial for propaganda snippets with ambiguous boundaries; the CRF allows a high-confidence signal from the core of a manipulative phrase to 'inform' the labeling of the surrounding tokens, ensuring structural integrity across the 17-class tagset."

- The Model: Bi-LSTM + CRF (The architecture).
- **The Objective:** Maximize the probability of the entire sequence (Global Normalization).
- **The Algorithm:** Viterbi (The mathematical "pathfinder" used during inference to get the best BIO sequence).
- **The Benefit:** It prevents "impossible" sequences and helps smooth out the soft boundaries you are concerned about.

> Can you explain to me more this statement: **The Objective:** Maximize the probability of the entire sequence (Global Normalization). Is the model trained based on the final global view? or does the model train the individual components and piece them together?
Yes, the model is trained based on the final global view. In a modern architecture like the Bi-LSTM-CRF (Ma and Hovy), the model is trained end-to-end. The loss function doesn't care if the model got an individual word right; it cares how likely the entire correct sequence was compared to every other possible sequence. 

**Local Normalization (e.g., Softmax / Bi-LSTM alone):** Imagine you are at a buffet. At every station, you pick the dish that looks best in that moment without thinking about what you already have on your plate. The model calculates a probability for each word individually: $P(y_1|x) \times P(y_2|x) \times P(y_3|x)$. It might pick "Steak" for the main course and "Red Wine" for dessert because they both had high individual probabilities, even though they don't go together. This is the Label Bias Problem mentioned in your notes. 

**Global Normalization (e.g., CRF):** Imagine you are ordering a "Tasting Menu." You don't pick individual dishes; you pick a sequence that has been designed to flow together perfectly. The model assigns a "score" to the entire path of labels. It then compares the score of the correct path against the sum of scores of all possible paths in the universe of that sentence. You want the correct path to have a massive "share" of the total probability pie.


**How the model is trained: "The Global View"**
1. **Emission Scores (The LSTM):** The Bi-LSTM looks at each word and says, "Based on the text, I think word #3 is 80% likely to be 'I-Loaded_Language'."
2. **Transition Scores (The CRF):** The CRF layer has a matrix that says, "Regardless of the text, it is 0% likely that 'B-Doubt' follows 'B-Loaded_Language'."
3. **The Combination:** The model adds these two scores together to get a "Path Score."
4. **The Loss Function (Negative Log-Likelihood):** During training, the computer calculates the score for the "Gold Standard" (the correct labels). It then uses an algorithm called the Forward Algorithm to calculate the sum of scores of every possible path (the "Partition Function").
5. **The Update:** Backpropagation then updates everything at once. It updates the CRF's transition rules and the Bi-LSTM's word-understanding features to make that one global correct path stand out more.

Because the model is trained on the global view, it learns Linguistic Logic. If the model is trained "Locally," and it sees a word that looks like propaganda, it might tag it. But if it's trained "Globally," it learns that propaganda usually comes in "clusters" or "shapes."

**The "Middle-Out" effect:** If the Bi-LSTM is 99% sure the middle of a sentence is I-Loaded_Language, the Global Normalization training forces the model to find a way to "get into" and "get out of" that state legally. It effectively teaches the model to look for the Beginning (B-) and End of the "vibe" of the propaganda, rather than just identifying "bad words."

**Viterbi vs. Training:** It’s important to distinguish the Training Phase from the Prediction Phase: 
- **Training:** We use the Forward Algorithm to calculate the probability of the entire correct sequence relative to all others. We update the weights so the correct sequence is the "winner."
- **Prediction (Inference):** We use the Viterbi Algorithm to actually find that winner.

"By employing Global Normalization via a CRF layer, the model is trained to maximize the likelihood of the entire gold-standard sequence. This end-to-end training allows the Bi-LSTM to learn feature representations that are specifically optimized for the structural constraints of the propaganda tagset, ensuring that the 'soft boundaries' of snippets are resolved by the global context rather than isolated, local token decisions."

> Just to scope into a really specific point, I think one of the reasons the integrated sequence model, i.e. B-Loaded, B-Repetition, will performs so well is being the Global Normalisation has a wider range of tags to draw signal from. The model may not be confident that a tag itself is B-Loaded but can apply a lower probably however 4 tags down it predicts that a tag is heavily I-Loaded, i.e .90%, therefore a Global View should be able to go back a knit together that the previous tag was the beginning.
> 
> This is in contrast to the pipeline approach which whilst still has the benefit of the global view does not have the same access to the probability distribution. The model needs to predict B, I, O meaning it can't leave as many breadcrumbs to refer to later

The density of the information signal. You are essentially describing why "Joint Models" often outperform "Pipelines" in complex tasks like this. Integrated Model (Variation 2) provides a much richer "trail" for the model. 
- In the Pipeline (Binary BIO): The model is effectively colorblind. It sees every propaganda snippet as the same "gray" B or I tag. If it is 4 tokens deep into a span, it knows it’s in some propaganda, but it doesn't know which one. Because it lacks that specific identity, it cannot use the unique linguistic patterns of that specific technique to help resolve the boundaries.
- In the Integrated Model (Multi-class BIO): The model has 9 different "colors." If it sees a massive signal for I-Repetition (due to the "stuttering" nature of the text), it can use that specific "Repetition-signature" to look back at the ambiguous start. It knows that a B-Repetition is more likely to be a repeated word than a B-FlagWaving. By having more granular tags, you are giving the model more specific constraints to latch onto.
- The way the CRF "knits" this together is through the Viterbi Algorithm during inference and the Forward-Backward Algorithm during training.
- The model doesn't just look at the probabilities (Emissions) for word $T$; it looks at the Transition Matrix between every possible tag.
- Transition Signal: In a Binary model, the matrix only has to learn $O \to B \to I$.
- Transition Signal in Integrated: The matrix learns that $B\text{-Loaded} \to I\text{-Loaded}$ is high, but $B\text{-Loaded} \to I\text{-Repetition}$ is zero.
- When your model finds that 90% confident I-Loaded tag 4 words down, the Viterbi Trellis calculates the "cheapest" (most likely) path to get there. Even if the words at the beginning of the span had a low "Emission" probability (meaning the Bi-LSTM wasn't sure), the CRF's "Transition" probability acts like a magnet, pulling the path toward the correct B-Loaded tag because it is the only legal way to reach that 90% confident I- tag.

In your report, you can contrast your two variations using the Label Bias Problem from your notes:
- **Variation 1 (Pipeline):** Is susceptible to a version of label bias where the detector makes a "safe" binary decision but ignores the specific rhetorical nuances that define the span's length.
- **Variation 2 (Integrated):** Uses Global Normalization to ensure the technique and the span are structurally locked.

**Why this supports your "Soft Boundaries" Hypothesis** Propaganda often "fades in." A sentence might start normally and slowly become manipulative. The Bi-LSTM (the "bottom" of your model) might struggle with these fading edges. The CRF (the "top" of your model) uses the "Breadcrumbs" left by the Integrated tags to say: "I know the heart of this is definitely 'Appeal to Fear,' so mathematically, the 'fade-in' words must be the beginning of that specific fear-span."

This is a much stronger "Global View" than the pipeline, which just sees a generic "Propaganda" label and lacks the specific category signal to "knit" the soft edges together effectively.

Strategic Report Tip: Frame this as "Mutual Information." By predicting the technique and the span simultaneously, the model uses the technique to help find the span, and the span to help find the technique. This synergy is exactly why Joint Models are the "high-tech" choice.


## Task 2 Evaluation
Naturally, this evaluation stage will be more complex. This is because span evalation is more naunced and less directly but also because the brief tells us that the model should predict both the span and the label, meaning both need to be evaluated. 

Task 2 is more complex because it requires identifying the exact start and end of the propaganda. This is typically handled via IOB (Inside, Outside, Beginning) encoding.

Da San Martino (2020) paper mention that "Span Identification" (SI) is evaluated using a partial match F1-score. A "True Positive" is only counted if the model gets the boundary exactly right. Gives partial credit for overlapping spans, acknowledging that the exact start/end of a manipulative phrase can be subjective.

In the original SemEval task that this assignment is based on (and mentioned in your notes regarding the Da San Martino paper), the primary metric is a Partial Match F1-score. Instead of a binary "correct or incorrect," it calculates the overlap between your predicted span ($S_p$) and the ground truth span ($S_t$).

**Token-Level vs. Span-Level:** While you might calculate F1 for every token (B, I, O), the assignment asks to "identify the span". You should evaluate based on full spans. If your model predicts "New York" but the truth is "New York City," a token-level metric might say you are 66% correct, but a strict span-level metric would count this as a False Positive.

**The $\gamma$ (Gamma) Agreement (Theoretical Note):** For your report, you can reference the $\gamma$ agreement (mentioned as 0.6 in your notes) as a **benchmark** for human performance. This demonstrates that you understand the inherent difficulty and subjectivity of the task.

"identify both the span and the propaganda technique used"

In Task 2, you are essentially "blind" and must perform Joint Span and Technique Identification.

For Task 2, because you are required to identify both the span and the label, your evaluation strategy should be more nuanced than Task 1.

To get a top grade, you shouldn't just provide one number; you should provide a Joint Metric for the overall performance and Diagnostic Metrics to see where the system is breaking down.

**1. The "Joint" Metric (The Official Score):** In the original SemEval task that this assignment is based on the primary metric is a Partial Match F1-score. Instead of a binary "correct or incorrect," it calculates the overlap between your predicted span ($S_p$) and the ground truth span ($S_t$). One possible approach for a joint score could be to use the label as an on-off switch, if the label is correct then the original partial match eval takes place and contributed to the metric, otherwise 0. It rewards "near misses" in boundaries (e.g., catching "radical left" instead of "the radical left") while strictly penalizing errors in the propaganda technique.

**2. The "Diagnostic" Split (Two Separate Methods):** Even if your final score is one number, your report should definitely evaluate them separately to show your "Empirical Understanding." You can treat this as a "Failure Analysis."
- **Span-only Evaluation (Detection):** Ignore the 9 techniques for a moment and turn all propaganda labels into a binary Propaganda tag. Metric: Use Precision/Recall for Spans. Purpose: This tells you if your model is good at "smelling" propaganda. If your Recall is high but your Joint F1 is low, it means your model knows where the trouble is, but it's terrible at identifying the specific technique.
- **Method B: Label-only Evaluation (Classification)** This should carry over from the methods used on the Task 1, however, there needs to be an approach, probably a threshold, to decide which spans to evaluate. Take only the spans that the model correctly identified (using a threshold, e.g., $>50\%$ overlap) and calculate the classification accuracy for those specific snippets.
 
**3. Token-Level vs. Span-Level Evaluation:** In terms of the span itself there are a few different ways to appraoch it. We could tag the token of the span with their propaganda label. This would be useful given we are going the BIO tagging route as we can just compare token tags. 
- Span-level (Correct): You group the tokens into full "entities" (spans). If the ground truth has one span of 5 words, and your model predicts 4 of those words, that is one partial match, not four correct tokens.


## Data Augmentation Options
- Vary/Randomize Span End/Start to create soft boundries
- Create not_propaganda examples which has a partial snipped of prop
- Generative methods to create alternative constructions of prop snippets:
    - Paraphrase (shorten)
    - Synonymn
    - Increase length?
- Supplement with external dataset?

> Comparing models trained on words vs pos tags. I have a hypothesis/theory that propaganda can be decomposed down into abstract usage of language. Words are a clear signal of this but they are not the true underlying signal. For example, "fight fight fight" invokes emotions and is clearly propaganda. But it is the chaining of 3 verbs that is the true signal. In fact, focusing on the words themselves likely leads to overfitting but it believes that fight and its repetation are the propaganda itself but "conquer conquer conquer" is also the same technqiue. 

**Back-Translation (Linguistic Paraphrasing):** Translate a propaganda sentence from English to another language (e.g., German or French) and then back to English. This creates a paraphrase that maintains the core "propaganda meaning" but changes the syntax and word choice. **Hypothesis Link:** If your BoW model fails on the back-translated version but your Transformer succeeds, you have proven that the Transformer is picking up on the abstract sentiment rather than just "trigger words."

**Snippet Shifting:** Propaganda labels are often sensitive to the "boundaries" of the snippet. You can augment the data by slightly expanding or shrinking the <BOS> and <EOS> tags. This teaches the model to be robust. It ensures the model doesn't just "overfit" to the exact span provided but understands the core area of the manipulative language.

**External Data:** use the Propaganda Techniques Corpus (PTC)—which the assignment mentions as the source—to perform "Intermediate Fine-Tuning."
- 1.  Take a raw BERT model.
- 2.  Fine-tune it on the entire PTC corpus (which is much larger).
- 3.  "Continue" fine-tuning on your specific assignment dataset.

This demonstrates Transfer Learning and Domain Adaptation. You can argue in your report: "To enrich the model's understanding of manipulative rhetoric, I performed a two-stage fine-tuning process, leveraging the broader PTC corpus as a source for domain-specific pre-training before specializing on the provided task data."



## Potential Ideas
In this section I have a collect ideas that I may or may not integrate into the report itself. Often in places they are supplementary peices so will depend on how much time I have.

---

### Custom Soft Bounary Snipper Evaluation Method
An evaluation method that treats the start and end of the spans as "softer" as even humans only agree 60% of the time on exact spans. Perhaps they have less weight on the edges but the middle tokens provide more weight. Might need to be dynamic based on length of snippet as 3 word long snippet are probably all propaganda terms. However, it is likely the case that some, or even many, propaganda examples are heavily weighted towards the start for end. Maybe this will be uncovered by the attention heatmaps and I can add this point as a pointer for "future" research

---

### POS Tag Only Model
Comparing models trained on words vs pos tags. I have a hypothesis/theory that propaganda can be decomposed down into abstract usage of language. Words are a clear signal of this but they are not the true underlying signal. For example, "fight fight fight" invokes emotions and is clearly propaganda. But it is the chaining of 3 verbs that is the true signal. In fact, focusing on the words themselves likely leads to overfitting but it believes that fight and its repetation are the propaganda itself but "conquer conquer conquer" is also the same technqiue. Therefore, we take a classifcation model, or even the sequence labeller, and apply the models on just the pos tags (no words), what sort of result do we get?

---

### Perplexity as proof of hypothesis
At the start we introduced some hypotheses based on word use and structure. It appears that we may be able to Perplexity to justify these. Perplexity evaluates Language Models (NLG), not Classifiers (NLU). But we could use Perplexity as a diagnostic tool to unveil the theory that propaganda has "loss of strictly correct grammar" or "unusual word pairings."

1. Take a pre-trained language model (like GPT-2 or BERT’s masked likelihood).
2. Calculate the perplexity of the Propaganda Spans vs. the Non-Propaganda text. Or even words, bi-grams, tri-grams or sub-snippets. 
3. The Goal: If the hypothesis is correct, the "Standard English" model should have significantly higher perplexity on the propaganda snippets than on the normal sentences.

"To empirically test my hypothesis that propaganda is characterized by linguistic irregularities, I conducted a perplexity analysis using a pre-trained GPT-2 model. I found that the average perplexity for propaganda spans was 42% higher than for non-propaganda text. This higher 'surprise' factor suggests that the language used in these techniques deviates from standard syntactic norms, justifying my use of complex architectures like DeBERTa to capture these non-linear patterns."

---

### Task 1 Feature Comparison Analyis
I am not sure where this piece of work should go, also it may be an extra if I have time rather than a staple of the project. However, between MLP classification heads and transforers attention there exists a way to compare the methods with respect to the hypthothesis. We can use feature attribution and attention maps to identify which words were important. If both methods are light up the same words we know that hypothesis 1 is true to some extent but we may be able to use the attention map from task 2 to demonstrate that it is not enough. 

Since the BoW and Word2Vec models use an MLP Classification Head, we can use **Feature Attribution** to see which words "pushed" the model toward a specific label.

With an MLP, you can use Integrated Gradients (`Captum` library). This will tell is which word vectors in the "bag" contributed most to the final Softmax probability.

I think for this sort of analysis we need to scope down to the individual sentence though I am not 100% sure about this. it may be the case that we can aggregate over the whole corpus. 

`e.g., "The betrayal of our sovereignty is complete"`

The Baseline View (1D Importance):
- **BoW/Word2Vec Output:** Likely see high "heat" on the nouns: betrayal and sovereignty.
- **The Interpretation:** The model says: "I see two 'bad' words, so this is propaganda." It doesn't care that they are linked; it just sees the counts.

The Transformer View (2D Attention): 
- **Transformer Output:** Using an attention map (like BertViz), you can see not just that betrayal is important, but that the Attention Head for `loaded_language` is firing specifically on the relationship between betrayal and sovereignty.
- **The Interpretation:** The model says: "The fact that 'betrayal' is applied to 'sovereignty' is what makes this flag-waving or loaded language."

To get the best grade, use LIME or SHAP as the "bridge." These tools can be applied to any model (BoW, W2V, or Transformer).
1. Explain the BoW: "LIME shows that for the sentence X, the BoW model relies 90% on the single token 'traitor'."
2. Explain the Transformer: "LIME shows the Transformer also values 'traitor', but the Attention Map reveals that the model is actually attending to the lack of a modifier, confirming the 'abstract/lossy grammar' hypothesis."

"While the BoW and Word2Vec baselines successfully identified the 'trigger' tokens (confirming the lexical hypothesis), they were unable to capture the relational context. The Transformer's attention maps demonstrated that the classification was not merely triggered by the word 'American', but by its syntactic proximity to 'displacement' in a non-standard grammatical construct. This confirms that propaganda identification requires the modeling of intra-sequence relationships that 'bag' methods inherently discard."

**For the "Heatmaps":** Captum (for Integrated Gradients on all models).

**For the "Connections":** BertViz (to see the lines connecting words in the Transformer).

**For the "Global Importance":** ELI5 (excellent for showing which words a BoW model likes).

For the assignment, using these interpretability tools on the MLP-based Word2Vec and BoW models allows us to prove that even without "Attention," your simpler models are picking up on the same linguistic triggers as the Transformer.

**Feature Attribution: Integrated Gradients (The Gold Standard):** Integrated Gradients solves this by calculating the "integral of the gradients" along the path from a blank input (baseline) to your actual sentence. It assigns a "contribution score" to each input feature (the Word2Vec dimensions or BoW counts). You can aggregate these scores back to the word level. You get a heatmap that says: "Word X contributed 40% to the model's decision that this was 'Loaded Language'."

"To maintain experimental consistency, I utilized a 2-layer MLP as the classification head for all non-transformer baselines. This allowed me to directly compare the utility of Sparse Discrete features (BoW) against Dense Distributed features (Word2Vec) without the architectural bias of different learning algorithms.

There exists a clear bridge to the BoW Hypothesis through Transformer Interpretability (XAI). Use SHAP (SHapley Additive exPlanations) or LIME to generate "heatmaps" of which words the Transformer is "looking at" when it makes a prediction. You can then compare these heatmaps to your BoW results. If the Transformer's "important words" are the same as your BoW's "high-weight words," you’ve proven that propaganda is largely lexical. If the Transformer is looking at the connections between words (the attention heads), you’ve discovered where BoW fails. "Query, Key combinations for attention" Visualizing these attention scores is a direct application of that theory.

It is much easier to extract Attention Maps from BERT. You can literally print a grid showing how much the word "America" (in your example) is attending to the word "Great." This allows you to scientifically prove or disprove your hypothesis that propaganda is "abstract" or "irregular." Because GPT models are usually significantly larger and use "causal masking," interpreting the internal "logic" of a classification decision is far more mathematically opaque.

In the context of Transformers, "Heatmaps" generally refer to two distinct things: **Feature Attribution** (which words are important?) and **Attention Maps** (which words are talking to each other?). 

**Feature Maps (1D):** This visualizes a "score" for every single word in your propaganda snippet. A high score means that word was a major factor in the model choosing a specific label. **Tool:** Captum (specifically the IntegratedGradients or LayerIntegratedGradients method). Run the same snippet through your BoW (TF-IDF) model and your Transformer. Extract the top-weighted words from your BoW model (e.g., coefficients in Logistic Regression) and overlay them with the heatmap from the Transformer. If both models highlight the exact same "trigger" words (e.g., "radical", "freedom", "betrayal"), you have scientific evidence that your BoW hypothesis was correct: the model is primarily relying on lexical cues (specific words) rather than complex sentence structure.

**Attention Maps (2D Heatmap):** This is a grid that shows how much "attention" the model paid to the relationship between every pair of words. **Tool:** BertViz.Input a propaganda sentence where the grammar is "lossy" or the pairings are abstract (e.g., "America Great" vs "Make America Great Again"). Look for "strong lines" (high attention) between words that shouldn't normally be connected in standard English grammar. This is where you can outperform your BoW/Bi-gram model. While a Bi-gram BoW can only see words right next to each other, a Transformer can see an "unusual pairing" even if the words are at opposite ends of the sentence. If your heatmap shows a massive attention spike between two abstract concepts, you've identified a "propaganda feature" that BoW would be blind to.

TODO: ARE HEATMAPS A CUMULATIVE TOOL, I.E. WHOLE CORPUS, OR JUST PER UNIT BASIS?

Model-Agnostic Explanations: LIME & SHAP
These are "wrapper" methods that don't care how the model works internally. They treat the MLP as a black box but poke it repeatedly to see how it reacts.

LIME (Local Interpretable Model-agnostic Explanations): It takes your propaganda sentence, creates slight variations of it (by removing words), and sees how the MLP’s prediction changes. If removing "betrayal" causes the flag_waving probability to drop from 90% to 10%, LIME identifies "betrayal" as the critical feature.

SHAP (SHapley Additive exPlanations): Based on game theory, it fairly distributes the "credit" for a prediction among all the words in the sentence. It is mathematically very robust and great for academic papers.

Baseline (BoW + MLP): Use LIME to show that the model is "Trigger Happy"—it only looks at the word "soldiers."

Transformer: Use Attention Maps and LIME to show that the model looks at "soldiers" in relation to the verb "get out."

The Conclusion: "While the MLP is often viewed as a black box, feature attribution via LIME reveals that it relies primarily on isolated lexical cues. In contrast, the Transformer’s attention mechanism validates my hypothesis that propaganda is encoded in the syntactic relationship between words, a nuance the MLP-based baselines consistently overlooked."

Captum (Library): The best library for Integrated Gradients in PyTorch.

LIME / SHAP (Libraries): Very easy to use with scikit-learn or Keras models.

ELI5 (Explain Like I'm Five): A library specifically designed to show text importance heatmaps for black-box classifiers.

---

# 4. Structure

1. [Introduction](#1-introduction)
2. [Related Work](#2-related-work)
    - [2.1. Dataset Exploration and EDA](#21-dataset-exploration-and-eda)
3. [Methodology: Task 1 (Classification)](#3-methodology-task-1-classification)
    - [Baselines](#baselines)
    - [Approach 1: Bag-of-Embeddings](#approach-1-bag-of-embeddings-1)
    - [Approach 2: Transformer Architecture](#approach-2-transformer-architecture)
    - [Hyper-parameters ](#hyper-parameters)
4. [Methodology: Task 2 (Span Identification)](#4-methodology-task-2-span-identification)
    - [Variation 1: The Pipeline (Binary BIO + Classifier)](#variation-1-the-pipeline-binary-bio--classifier)
    - [Variation 2: Integrated Multi-class BIO-CRF](#variation-2-integrated-multi-class-bio-crf)
    - [Theoretical Justification](#theoretical-justification)
5. [Results and Evaluation](#5-results-and-evaluation)
    - [5.1 Evaluation Framework and Metrics](#51-evaluation-framework-and-metrics)
    - [5.2 Task 1 Results: The Lexical vs. Semantic Battle](#52-task-1-results-the-lexical-vs-semantic-battle)
    - [5.3 Task 2 Results: Pipeline vs. Integrated Architectures](#53-task-2-results-pipeline-vs-integrated-architectures)
6. [Analysis and Discussion](#6-analysis-and-discussion)
    - [6.1 Decoding the "Black Box" (XAI Comparison)](#61-decoding-the-black-box-xai-comparison)
    - [6.2 Perplexity as Linguistic Proof](#62-perplexity-as-linguistic-proof)
    - [6.3 Error Analysis (Failure Modes)](#63-error-analysis-failure-modes)
7. [Conclusion and Further Work](#7-conclusion-and-further-work)
* [Strategic Tips for High Marks:](#strategic-tips-for-high-marks)

## 1. Introduction
**Problem Outline:** Define the task of propaganda detection and explain why it is both socially important and technically challenging (e.g., the subtlety of "Loaded Language" vs. the structural "off-kilter" nature of political slogans).

**Hypotheses:** Formally state your two core hypotheses:
- **1. Lexical Trigger Hypothesis:** Propaganda is disproportionately over-represented by abstract "trigger" words.
- **2. Structural Irregularity Hypothesis:** Propaganda utilizes "abstract pairings" and a loss of strictly correct grammar that can be identified through sequence modeling.

---

## 2. Related Work
Briefly mention the Propaganda Techniques Corpus (Da San Martino et al., 2020) which serves as the foundation for your dataset.

Discuss the evolution from Bag-of-Words to Contextualized Embeddings (BERT/DeBERTa) and the use of CRFs for sequence labeling.

## 2.1 Dataset Exploration and EDA
Reasons to do EDA:
1. Validating the hypothesis. Assumed that propaganda is over-represented by abstract "trigger" words. An EDA showing Term Frequency (TF) or N-gram distributions can provide the first piece of empirical evidence for this.
2. **Syntactic Integrity:** For Task 2, analyzing sentence lengths and span lengths justifies the use of a CRF to handle structural dependencies.


- Classes
- Frequencies
- Class imbalances. Documenting this justifies your choice of Macro-Average F1 later in the report. As well as for reference in the evaluation or analysis sections.
- N-gram analysis to confirm 'abstract' pairings in propaganda snippets
- **Sequence Lengths:** Histograms of the total sentence length vs. the propaganda snippet length.
- **Vocabulary Richness:** Top 20 most frequent words in propaganda snippets vs. non-propaganda text.
- **Stopword and POS Analysis:** Visualizing if propaganda techniques rely on certain parts of speech (e.g., a high density of adjectives in loaded_language)

---

## 3. Methodology: Task 1 (Classification)

### Baselines: 
Describe the Unigram-BoW (Pure Vocabulary) and Bi-gram BoW (Local Phrasing) setups. As well, as true non-intelligent baseline of either random guessing or single answer guesss (probably both).

### Approach 1: Bag-of-Embeddings
Detail your use of Word2Vec with Mean Pooling and an MLP classification head. Justify why you kept the MLP head constant to isolate the embedding variable.

### Approach 2: Transformer Architecture
Describe your choice of DeBERTa/RoBERTa and how you extract snippet-specific representations (e.g., pooling hidden states between `<BOS>` and `<EOS>`).

### Hyper-parameters 
Document settings for both models (e.g., vocabulary size, embedding dimensions, dropout rates, and fine-tuning epochs).

---

## 4. Methodology: Task 2 (Span Identification)

### Variation 1: The Pipeline (Binary BIO + Classifier):
Describe the "bolt-on" approach where you first detect if text is propaganda before classifying what type it is.

### Variation 2: Integrated Multi-class BIO-CRF:
Detail your "Joint Model" approach using the Ma and Hovy (CNN-BiLSTM-CRF) architecture.

### Theoretical Justification: 
Explain the role of the Viterbi algorithm and Global Normalization in resolving "soft boundaries" and "internal signals" in propaganda spans.

---

## 5. Results and Evaluation

### 5.1 Evaluation Framework and Metrics
Justify and explain the your metrics here to demonstrate "Systematic Knowledge".
- **Task 1 (Classification):** Use **Macro-Average F1** as the primary metric. Justify this by referencing the class imbalance found in your EDA; accuracy would be misleading if the model overfits to the frequent loaded_language class. Include all of the the other metrics too for more granular analysis; i.e. accuracy, recall, precision. 
- **Task 2 (Detection & Classification):** Use the Partial Match F1-score (as per Da San Martino et al., 2020). It would be good to implement something custom here. Perhaps around blurring the boundaries and identifying a way to work out if the span starts near the boundary. 
- **Joint Score Logic:** Explain that for Task 2, a span is only considered a "match" if the label is also correct. This acts as an "on-off switch," rewarding boundary precision only when the rhetorical technique is accurately identified.

### 5.2 Task 1 Results: The Lexical vs. Semantic Battle
Present a table comparing your Unigram-BoW, Bi-gram BoW, and Word2Vec baselines against your Transformer (DeBERTa/RoBERTa).
- **Lexical Sieve:** Analyze if the Unigram-BoW performs surprisingly well on "Loaded Language," supporting your hypothesis that some propaganda is purely word-driven.
- **The Bi-gram Boost:** Compare Bi-gram BoW vs. Word2Vec. If Bi-grams win, argue that "Local Phrasing" (structure) is more important than "Semantic Similarity" (Word2Vec).

### 5.3 Task 2 Results: Pipeline vs. Integrated Architectures
This is where we evaluate your two variations: the Binary Pipeline vs. the Integrated BIO-Class (Joint) Model.

**Variation 1 (Pipeline):** Report the "Span Detection" F1 separately from the "Joint" F1. This shows if your model is a good "spotter" but a bad "labeler".

**Variation 2 (Integrated):** Showcase how the CRF layer and Global Normalization improved boundary precision.

**The "Knit" Effect:** Discuss if Variation 2 handled "soft boundaries" better by using the technique label to "pull" the span boundaries into place.

---

**Evaluation against Hypotheses:** Discuss whether the performance of Bi-gram BoW vs. Word2Vec supports your theory on "local phrasing" vs. "semantic concepts".

**Human Benchmark:** Mentioning the $\gamma$ agreement (0.6) for humans provides a professional context for your model's performance.

**Theoretical Alignment:** Try to link result back to the "Label Bias Problem," "Global Normalization," or the "Distributional Hypothesis" found in your notes.

---

## 6. Analysis and Discussion

### 6.1 Decoding the "Black Box" (XAI Comparison)
Use the interpretability tools you planned (Captum/LIME) to provide a "Feature Comparison". Use Integrated Gradients (Captum) and Attention Maps (BertViz) to compare what the BoW model "sees" versus the Transformer.
- **1D vs. 2D Importance:** Show a visualization where BoW highlights a single word (e.g., "radical") but the Transformer’s Attention Map highlights the relationship between that word and its target.
- **Validating Abstract Pairings:** Use this to prove the hypothesis that the "off-kilter" grammar of propaganda is what the Transformer is actually picking up on.

### 6.2 Perplexity as Linguistic Proof
Present the Perplexity results here.
- Compare the perplexity of propaganda snippets vs. standard text using a pre-trained model like GPT-2.
- **The Evidence:** Use high perplexity scores as empirical proof that propaganda deviates from "Standard English" norms, justifying your use of the more complex CNN-BiLSTM-CRF or Transformer architectures.

### 6.3 Error Analysis (Failure Modes)
Identify specific techniques (e.g., "Causal Simplification") where models failed and discuss the causes (e.g., data sparsity vs. lack of syntactic context).
- **Confusion Matrix Analysis:** Discuss why "Doubt" might be frequently confused with "Loaded Language".
- **Boundary Errors:** Analyze if the model failed on very short snippets (1-2 words) vs. long, complex spans.

---

## 7. Conclusion and Further Work
Summarize which hypothesis held the most weight across the experiments.

**Further Work:** Suggest more complex data augmentations (e.g., Back-Translation) or the exploration of POS-only models to further decouple words from syntactic patterns.

## Strategic Tips for High Marks:
**Academic Style:** Ensure all major technical points (like the "Label Bias Problem" or the "Distributional Hypothesis") are backed up with references from your module notes or external literature.

**The "Joint Signal" Argument:** Your plan for Variation 2 in Task 2 is a strong point of "creative thought." Devote space in the analysis to explaining how the model uses the "breadcrumbs" of specific technique tags to knit together ambiguous boundaries.

**Code Appendix:** Ensure your .ipynb or .py files are clearly commented and mirror the methods described in the report.

---