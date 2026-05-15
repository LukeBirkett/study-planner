# 3. Data Characterization and Representation Strategy
The follow section(s) are dedicated to introducing, explaining and exploring the underlying training data set. 

3.1 introduces the corpus and its features
3.2 explains any data enrichment executed
3.3 conduct eda
3.4 explains any data augmentation 
3.5 decribes the includsion of any external data not related to the training corpus

---

## 3.1 Corpus Overview
The dataset supplied for this report appears to be a subset or inspired by the Propaganda Techniques Corpus (PTC) created by Da San Martino et al. (2020) for the SemEval-2020 Task 11. Our dataset contains 2414 rows and uses a 8 labels which are taken directly from the Da San Martino et al. (2020) paper as well as an additional `not_propaganda` label, making 9 in total. In additional to the labels, each instance holds a sequence containing a propaganda snippet delimited by <BOS> and <EOS> markers. This structure means that we have access to both the "propaganda" marked language as well as its sentinal context. 

1. flag waving
2. appeal to fear prejudice
3. causal simplification
4. doubt
5. exaggeration,minimisation
6. loaded language
7. name calling,labeling
8. repetition
9. not propaganda

> provide examples of instances (raw)

The data was cleaning, focusing on digital artifacts that do not represent any intended context from the write/speaker themselves. However, all grammar, spelling variations and punctuation was left in as the context of this tasks this demonstates meaning and intent. 

The original source of data from da san martin was collected from a "sample of news articles from the period starting in mid-2017 and ending in early 2019." therefore due to the formal nature of the news outlets we can rely on the understanding that the typography used is intentional. 

the cleaned sequence itself was tokenized using the nltk package and the index bounds of the propaganda tags extracted and stored as a tuple allow for the sequence and snippet to be accessed ad-hoc. 

---

## 3.3 Feature Enrichment & Representation
Prior to executing even basic EDA the time was taken to enrich the dataset through the means of POS and Named Enity tagging. 

This was important to do at this stage as we have already outline two key hypothesis which are heavily dependent on the structure and meaning of language itself. EDA probably won't enable to confirm our hypos but it would give us the chance to revist them if results needed. Furthmore, it would be of benefit to the flow of the paper for EDA to be conducted on these tags too. 

Outside of EDA, the dataset was entriched with these tags do give the tasks, particularly task 2 span idenrification, a better chanced of acheiving the desired goals. Propaganda spans frequently align with specific syntatic boundaries such as noun phrases. Or as suggested in H2, potentially pertain to their own unique synatic boundaries which will make them identifying these unique passages of text easier. Additioanlly, a method described later known as CRF relies on just tags to enforce its "rules". 

**POS:** tagged using nltk `averaged_perceptron_tagger` and applied to each sequence in full; snippet + context

**Named Entity:** tagged using spacy, "en_core_web_sm"

A short check was executed to ensure that the lengths of that tagged sequences align to the length of the full sequence to ensure there are not mistakes that the 3 can later being joined together as a 3-tesnor.

> Team LTIatCMU(SI:4) (Khosla et al., 2020) used a multi-granular BERT BiLSTM model with additional syntactic and semantic features at the word, sentence and document level, including PoS, named entities, sentiment, and subjectivity. It was trained jointly for token and sentence propaganda classification, with class balancing. They further fine-tuned BERT on persuasive language using 10,000 articles from propaganda websites, which turned out to be important.

> aare there any more pos or ner references from da san?

---

## 3.3 Exploratory Data Analysis (EDA)
To motivate the architectural choices in Section 4, a comprehensive EDA was performed.

### EDA Checklist

#### Phase 1: Distribution & Sequence EDA
1. [ ] **Class Imbalance Check:** Visualize the count of each label and the total data instances. 
2. [ ] **The "Snippet-to-Sentence" Ratio:** What percentage of the full_sequence is actually the snippet
3. [ ] **Sequence Length Density:** Plot the distribution of all_tokens lengths vs. snippet lengths.
4. [ ] **Summary Statistics for Snippet Length:** Mean, min, max, etc
5. [ ] **Summary Statistics for Context Length:** Mean, min, max, etc
6. [ ] **Distribution of Context Left vs Right:** Do any of the classes exhibit a skew for context on onside? this also tell us if any classes as a bias for the snipper position, i.e. at the end after rhetoric buildup where the context will be very important.
#### Phase 2: Lexical & Morphological EDA (H1 Testing)
7. [ ] **POS Tag Distribution (Heatmap):** Compare the frequency of POS tags (JJ, NNP, VB, etc.) within the snippets for each label.
8. [ ] **Proper Noun Analysis (NER):** Identify which entities (PERSON, ORG, GPE) appear most often within snippets.
9. [ ] **Unique N-Gram Analysis:** What are the top 2-word or 3-word phrases that only appear in specific propaganda classes? This probably wont be possible given the lack of data in each class but failure to produce good bi-grams or tri-grams means that such techniques will not be justifable later in the modelling phases, so important to highlight this now. 
#### Phase 3: Structural & Positional EDA (H2 Testing)
10. [ ] **Relative Position Analysis:** Calculate start_idx / len(all_tokens). Plot this for each label.
#### Phase 4: Correlation & Complexity
11. [ ] **Label Confusion (Theoretical):** Identify which labels share the most common words/POS tags.
12. [ ] **Vocabulary Growth (Heaps' Law):** How many new words are introduced as you see more examples of a specific label?

---



## 3.4 Data Augmentation & Domain Adaptation

### Augmentation (Silver Data):*
To increase the training volume, 3,000 "silver" instances were generated via Back-Translation and GPT-4 paraphrasing of under-represented classes.
> not sure that I plan to use back-translation
> 
> On Training Set Size (2.5k): You are correct; 2,500 rows is very small for a Transformer. This makes your "External Data" and "Augmentation" sections the most important parts of your report for justifying why your model didn't just overfit to specific keywords.

> Team ApplicaAI(SI:2) (Jurkiewicz et al., 2020) based its success on self-supervision using the RoBERTa model. They used a RoBERTa-CRF architecture trained on the provided data and used it to iteratively produce silver data by predicting on 500k sentences and retraining the model with both gold and silver data. The final classifier was an ensemble of models trained on the original corpus, re-weighting, and a model trained also on silver data. 
> 
> Team UPB(SI:5) (Paraschiv and Cercel, 2020) decided not to stick to the pre-trained models from BERT–base alone and used masked language modeling to domain-adapt it using 9M articles containing fake, suspicious, and hyperpartisan news articles. 
>
> Team DoNotDistribute(SI:22) (Kranzlein et al., 2020) also opted for generating silver data, but with a different strategy. They report a 5% performance boost when adding 3k new silver training instances. To produce them, they used a library to create near-paraphrases of the propaganda snippets by randomly substituting certain PoS words. 
> 
> Team SkoltechNLP(SI:25) (Dementieva et al., 2020) performed data augmentation based on distributional semantics. 
>
> Finally, team WMD(SI:33) (Daval-Frerot and Yannick, 2020) applied multiple strategies to augment the data such as back translation, synonym replacement and TF.IDF replacement (replace unimportant words, based on TF.IDF score, by other unimportant words).



### Domain Adaptation:
To address the small 2.5k row constraint, a DeBERTa model was subjected to intermediate fine-tuning on a 10,000-article news corpus from 2017–2019, ensuring the model's base weights are adapted to the specific linguistic era of the Da San Martino dataset.

> On Pre-training vs. Fine-tuning: If you take a base BERT model and train it on a general news corpus before your specific task, that is called Domain Adaptation or Intermediate Fine-Tuning. The final pass on your 2.5k rows is Task-Specific Fine-tuning.
> 
> Need to work out the exact external dataset
