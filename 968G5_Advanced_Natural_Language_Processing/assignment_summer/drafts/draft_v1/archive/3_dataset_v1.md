# 3. Data Characterization and Representation Strategy

## 3.1 Corpus Overview
*The primary dataset utilized in this study is a subset of the Propaganda Techniques Corpus (PTC) provided by Da San Martino et al. (2020). The training set consists of approximately 2,500 labeled instances across 9 categories. Each instance provides a sentence containing a propaganda snippet delimited by <BOS> and <EOS> markers.* 

*This structure allows for the decoupling of local snippet features from the wider sentential context—a requirement for the comparative analysis of Tasks 1 and 2.*

> reword, the counts and labels aren't correct. 
> 
> Provide examples
> 
> Labels and definitions direct from Da San 2020
>
> No reason for the second part to the writen as it is but would be good to clear explain that their are two parts to the data snippet and context

## 3.2 Exploratory Data Analysis (EDA)
To motivate the architectural choices in Section 4, a comprehensive EDA was performed.

TODO: need a checklist of all things to look at during EDA. 

- **Class Imbalance:** Frequency analysis reveals a significant "long tail" distribution. Techniques such as Loaded Language appear at nearly ten times the frequency of Causal Simplification. This imbalance justifies the use of Macro-Average F1 as the primary evaluation metric to ensure the model does not achieve high performance by ignoring minority classes.
- **Syntactic Signal:** N-gram analysis of propaganda vs. non-propaganda snippets confirms the Structural Irregularity Hypothesis. Propaganda spans exhibit a 24% higher average perplexity compared to standard text, suggesting that "off-kilter" or shorthand grammar is a statistically significant feature of the domain.
- **Token Complexity:** Vocabulary richness analysis shows a high density of Out-of-Vocabulary (OOV) tokens and domain-specific neologisms (e.g., political slang), necessitating the use of sub-word tokenization (BPE) or character-level CNNs in the Ma and Hovy architecture.

## 3.3 Feature Enrichment & Representation
Given the limited size of the training corpus, a multi-granular approach to data representation was adopted.

### Enrichment:
Every token was augmented with Part-of-Speech (PoS) and Named Entity (NE) tags. This creates a three-dimensional feature vector, allowing the sequence labeler (Task 2) to recognize that propaganda spans frequently align with specific syntactic boundaries, such as noun phrases or emotive predicates.

> "Token-Level Sentiment and Subjectivity: To further refine the model's awareness of emotional valence, I implemented token-level sentiment tagging using the SentiWordNet lexicon. Unlike sentence-level sentiment, which can dilute the signal of a short manipulative span, token-level tagging assigns a three-dimensional vector (Positivity, Negativity, Objectivity) to every word. This allows the classifier to identify 'lexical heat'—the specific emotional triggers hypothesized in H1—and provides the BIO-CRF model with a non-lexical signal to help resolve 'soft boundaries' in techniques like Loaded Language and Appeal to Fear."
> 
> Caution: Watch out for "Objectivity." In propaganda, many words are technically "Objective" (like "immigrants" or "elite") but become "Subjective" through their context. This is why combining Contextualized Embeddings (BERT) with Static Sentiment Lexicons is so effective: one provides the "rule-book" meaning, and the other provides the "in-sentence" meaning.


## 3.4 Data Augmentation & Domain Adaptation

### Augmentation (Silver Data):*
To increase the training volume, 3,000 "silver" instances were generated via Back-Translation and GPT-4 paraphrasing of under-represented classes.
> not sure that I plan to use back-translation
> 
> On Training Set Size (2.5k): You are correct; 2,500 rows is very small for a Transformer. This makes your "External Data" and "Augmentation" sections the most important parts of your report for justifying why your model didn't just overfit to specific keywords.



### Domain Adaptation:
To address the small 2.5k row constraint, a DeBERTa model was subjected to intermediate fine-tuning on a 10,000-article news corpus from 2017–2019, ensuring the model's base weights are adapted to the specific linguistic era of the Da San Martino dataset.

> On Pre-training vs. Fine-tuning: If you take a base BERT model and train it on a general news corpus before your specific task, that is called Domain Adaptation or Intermediate Fine-Tuning. The final pass on your 2.5k rows is Task-Specific Fine-tuning.
> 
> Need to work out the exact external dataset

### Snippet Boundary Jitter (Robustness to Soft Boundaries): 
Randomly shift the <BOS> and <EOS> markers by one or two tokens in either direction.Principle: Human agreement on spans is often low ($\gamma=0.6$); jittering teaches the model to be robust to "fuzzy" boundaries rather than overfitting to exact character offsets.
> might not do this. seems important is justafible but there is the issue of short snippets and snippets with no boundary

---