



# 1 Introduction
> problem outline, 10 marks (10%): Does the introduction explain the task including why it is important and challenging?

- What is propaganda detection?
- What is propaganda?
- Why is it detecting and undertanding it now so important?
- What makes it difficult to identify?

- Technically challenging due to the inherent subjectivity and nuance of the 9 categories involved
- Unlike standard sentiment analysis, propaganda detection requires models to distinguish between informative political discourse and manipulative rhetoric.
- Identifying an "off-kilter" structural quality in the text, where grammatical complexity is sacrificed for rhetorical punch or "shorthand" slogans.
- The use of idioms, or idioms like behavior, which is a well known problem in all NLP (reference for this?)
- Prop types may be low freq 
- Prop types may be named after a specific person that they are so rare, i.e. trump-isms (reference for this?)

This report addresses two distinct yet interrelated challenges: identifying the specific propaganda technique used in a known snippet (Task 1) and the joint identification of both the boundaries and the technique within raw text (Task 2).

> TODO: should there be an brief outline of the methods used? there doesn't seem to be any reference of this in the "problem outline"

Lay out hypotheses. These provide some substrate to justify design approach against as well as provide a reference point for evaluation and analysis: 
1. *H1: **Lexical Trigger Hypothesis:** I hypothesize that certain propaganda techniques are disproportionately represented by a specific subset of "trigger" words—abstract, emotionally charged nouns and adjectives (e.g., "radical," "traitor," "freedom")—that allow for high classification accuracy using simple Bag-of-Words (BoW) or Static Embedding approaches.*
2. *H2: **Structural Irregularity Hypothesis:** Beyond individual words, I hypothesize that propaganda is characterized by "abstract pairings" and a departure from strictly correct grammar. This "lossy" syntax serves to increase emotional resonance, but creates linguistic patterns that can only be captured through sequence modeling (e.g., Bi-LSTM-CRF) and contextualized attention mechanisms (e.g., Transformers).*
- I am not sure that I agreee with this later part. in fact i think these disinctions are so abstract that something as basic and freq based as a bi-gram maybe enough. hence the motivation for my baseline

> DOES IT MATTER THAN THE HYPOS POTENTIAL CONTRADICT? 

By testing these hypotheses across both tasks, this report aims to determine if the "signal" of propaganda lies within the words themselves or within the unique, often irregular, relationships between them.

> These hypotheses started off a mostly theories. The first theory was the propaganda detection is primarily led by vocabulary. The second theory was that propganda is also characterised by abstract language structure that deviates from the normal. as its most basic rhetoric this can be phrased as "abstract pairing". I tried to rephase this as hypothesis but I am not sure I can the exact scientific and testable nature encapsualed in my hypothesis yet. However, it should be noted that these two theories/hypotheses lead to the construction of the two baselines, BOW and BOW-BiGram and each set the basis for appraoch 1 and 2 in task 1. Approach 1 is a bag-of-embeddings (WORD2VEC) which follows on from the vocabulary point. Approach 2 is a transformer approach which full explores the structural route. 

---

# 2 Related Work 
> Doesn't appear to be a section directly marked for this so keep it brief. Comprehensive collection of references would be good

- Da San Martino et al., 2020
- This paper is the foundation for the dataset in this assessment
- Do we need anymore propaganda related stuff? i.e. seminal studies or paper defining what propaganda is. Modern studies, recent topics. Da San Martino et al., 2020 has lots of stuff like this so i could pick through and find appropriate references that way


- Discus the lineage of methods to tackle such tasks from a empirical stand points. Brief mentioning the methods and their advancements along with relevant references. However, this section should brief but densly informatative. 
- BoW
- Embeddings (Word2Vec)
- NNs, RNN, LTSMS, Unidirectional
- Transformers; BERT and then generative
- CRFs, Viterbi

# 3 The Dataset
> Again not really any direct sections for this or the EDA work but it is important for coherent evaulation, analysis and conclusions later on. 
> 
> If any Silver data is created or augmentation takes place then this could be considered as the "method"
> 
> method, 25 marks: Is there a clear description of the proposed methods for tackling the tasks? Do the proposed methods seem sensible? Novel or more interesting methods may score highly here (if well-described) but methods will not necessarily gain more marks simply by being more ambitious.

- Dataset introduction
- Train, test split
- Number of instances
- Labels and defintions (taken from Da San Martino et al., 2020)
- Examples of each one
- 

## EDA
- Reasson for doing EDA
- Classes
- Frequencies
- Class imbalances. Documenting this justifies your choice of Macro-Average F1 later in the report. As well as for reference in the evaluation or analysis sections.
- N-gram analysis to confirm 'abstract' pairings in propaganda snippets
- **Sequence Lengths:** Histograms of the total sentence length vs. the propaganda snippet length.
- **Vocabulary Richness:** Top 20 most frequent words in propaganda snippets vs. non-propaganda text.
- **Stopword and POS Analysis:** Visualizing if propaganda techniques rely on certain parts of speech (e.g., a high density of adjectives in loaded_language)

## Data Enrichment 
- part-of-speech (PoS)
- named entity (NE) 

> this result in a 3 dimensional token vector

Possible additionals:
- Sentiment

> Team LTIatCMU(SI:4) (Khosla et al., 2020) used a multi-granular BERT BiLSTM model with additional syntactic and semantic features at the word, sentence and document level, including PoS, named entities, sentiment, and subjectivity. It was trained jointly for token and sentence propaganda classification, with class balancing. They further fine-tuned BERT on persuasive language using 10,000 articles from propaganda websites, which turned out to be important.

These additions are probably strictly "method" changes however i think it reads better to have a "dataset" section like this. a good marker should identify that these are method based considerations, plus i can and will directly refer to them from method sections. additionally, i want to make sure that all models have access to these enrichments if appropirate.

Are there any over possible additional enrichments that could be good? I have put Sentiment as we have previous already referenced this plus there was a team that used this in their Da San Martino submission. That being said, I am not sure I will use this as we already have alot of components already. However, I do think it would be really valuble for short length snippets. There are some examples of propaganda that would really benefit from external information and the Sentiment is low hanging fruit

## Data Augmentation
- Silver data; It would be a good idea to supplement the data by creating "silver" data. There a huge number of successful examples from the Da San Martino. The paper is back from 2021 so **they didn't have access to the strength of generative models that we do now**. Therefore, an "easy" option might just be to take this route. 

There appear to be a few obvious appropaches: 
- set up a prompt to paraphrase long(er) peices propaganda
- set up a prompt to re-phrase the propaganda snippet using synonyms
- set up a prompt rephrase the sentinal context
- set up a method to produce more of an under represent lablled. 

Can you think of any other approaches? it would be good justify them directly against NLP princples and concepts. 

However, doing this would provide a new issue in confirming that the newly generate data is appropriate. I suppose that the results itself could handle this. If the model performs poorly on the silver data then this is an area for future work. 

> Here are some team method descriptions from Da San Martino:
> 
> Team ApplicaAI(SI:2) (Jurkiewicz et al., 2020) based its success on self-supervision using the RoBERTa model. They used a RoBERTa-CRF architecture trained on the provided data and used it to iteratively produce silver data by predicting on 500k sentences and retraining the model with both gold and silver data. The final classifier was an ensemble of models trained on the original corpus, re-weighting, and a model trained also on silver data. 
> 
> Team UPB(SI:5) (Paraschiv and Cercel, 2020) decided not to stick to the pre-trained models from BERT–base alone and used masked language modeling to domain-adapt it using 9M articles containing fake, suspicious, and hyperpartisan news articles. 
>
> Team DoNotDistribute(SI:22) (Kranzlein et al., 2020) also opted for generating silver data, but with a different strategy. They report a 5% performance boost when adding 3k new silver training instances. To produce them, they used a library to create near-paraphrases of the propaganda snippets by randomly substituting certain PoS words. 
> 
> Team SkoltechNLP(SI:25) (Dementieva et al., 2020) performed data augmentation based on distributional semantics. 
>
> Finally, team WMD(SI:33) (Daval-Frerot and Yannick, 2020) applied multiple strategies to augment the data such as back translation, synonym replacement and TF.IDF replacement (replace unimportant words, based on TF.IDF score, by other unimportant words).

Are there any any other easy data augmention tasks we can do? and entire silver data set feels quite signifcant plus it allows us to compare results with and with the augmentatiom so i don't think we need to do too much else. But if there are some standard augmentations that should take place in an NLP task like this we should do them

## Additional/External Data
- Task 1 involves using a BERT model which would benefit from pre-training probably. Although even if it doesn't it gives me a chance to talk about and justifying pre-trainining from a design perpective. 
- Da San Martino et al., 2020 mention that for the  PTC-SemEval20 corpus "we retrieved a sample of news articles from the period starting in mid-2017 and ending in early 2019". Therefore I think we can justify using a large news corpus as it matches the input. 
- We could use one of the large google new corpora such as conll2003 although I would prefer one which is more modern. Possibly overlapping the time fram of Da San Martino, or simply just modern. 
- If I take a type of BERT base model, apply trainng to a new corpora, and then fine-tune against the training set, is the news corpora training pre-trianing or fine-tuning. 
- Another thing, I just remembers the training set is only 2.5k rows (labelled). this isn't much so I think an external pre-trained set is required for this task. Also thing that this isn't much for supervised triaing so we will need it all for the classifcation tasks, meaning we probably take fine-tuning on the training set, what do you think?


> Team LTIatCMU(SI:4) (Khosla et al., 2020) ... They further fine-tuned BERT on ≥persuasive language using 10,000 articles from propaganda websites, which turned out to be important.