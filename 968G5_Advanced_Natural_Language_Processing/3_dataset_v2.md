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

## 3.2 Feature Enrichment & Representation
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

## 3.4 Data Augmentation (Silver Data)
Excluding the the not_propaganda labels, there are only 1223 labels spread across 8 categories with approx 160 labels in each. 

For NLP standards this is not a huge amount of data meaning that any models are prones to overfitting to the limited signals. 

This is particularly true if we are to consider H1 which hypos it is the words that are most important for unveiling propaganda. if certain words are over represented in this subset then any most will almost be foreced to overfit on the test set. 

Therefore we take the route of data augmentation, specifically though the route of generating a 1-to-1 silver dataset, increase the training set by another 1223. This additional data will be refered to as the silver set

from the da san eval:
- Team ApplicaAI(SI:2) (Jurkiewicz et al., 2020) They used a RoBERTa-CRF architecture trained on the provided data and used it to iteratively produce silver data by predicting on 500k sentences and retraining the model with both gold and silver data.
- Team UPB(SI:5) (Paraschiv and Cercel, 2020) used masked language modeling to domain-adapt it using 9M articles containing fake, suspicious, and hyperpartisan news articles
- Team DoNotDistribute(SI:22) (Kranzlein et al., 2020) also opted for generating silver data, but with a different strategy. They report a 5% performance boost when adding 3k new silver training instances. To produce them, they used a library to create near-paraphrases of the propaganda snippets by randomly substituting certain PoS words. 
- Team SkoltechNLP(SI:25) (Dementieva et al., 2020) performed data augmentation based on distributional semantics.
 
However, this paper was released in Dec 2020. Meaning it either completely pre-dated or intersected with the LLM revolution

*The timeline of the SemEval-2020 competition completely predated or actively collided with the release of the foundational GPT-3 paper, "Language Models are Few-Shot Learners" (Brown et al., 2020).*

*The training data for Task 11 was released in late 2019, and the actual evaluation/competition period concluded in March 2020 (Spala et al., 2020). Participants wrote and submitted their system description papers around April and May 2020.*

*The GPT-3 Release (May 28, 2020): The landmark GPT-3 paper was first uploaded to arXiv on May 28, 2020 (Brown et al., 2020).*

*In early 2020, the undisputed kings of NLP benchmarks were encoder-only masked language models like BERT and RoBERTa, or encoder-decoder architectures like T5.*

*In early 2020, the undisputed kings of NLP benchmarks were encoder-only masked language models like BERT and RoBERTa, or encoder-decoder architectures like T5.* 

Therefore, we take a route not demonstated in the original sa san paper 

Zero-shot, need reference, also compare to few-shot which needs a refernce too

Zero-shot more approprate as propganda has less strict rules passing in a example might force the model to think that this particular few short examples are what it needs to do

Chain of thought, mutlistep process to alternate the data

the goal is change the snippet, the propaganda itself. however, this is usually part of a wider context (not always)

therefore it is not as simple as changing the snippet blindly..

> move onto explaining the approach in full

- We start with the full dataset and remove the not_prop field. this is because task 1 only focuses prop labelled and for task 2, not_prop is alrady the majority category, plus we do not have enough info about how the not_prop in our particular dataset is collect. it could be bias and hence gneerative based on it would be bias also. 
- model chosen was `Meta-Llama-3-8B`
- it is open-course 
- fast and cheap but bigger models better
- was not localled run due to hardware constraints but it could have been
- local model of `dolphin-llama3` was chosen which is a community based model with less constaints
- many standard models struggle with this task because they are programmed to not participate in prop etc
- that said, the hostteled version of Meta-Llama-3-8B togerher ai is less restricted
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
- saved as extrnal file


# TODO: needs to enrich silver and then run base similarty EDA. 
# TODO: probably just basic pos and EDA composition 

---

## 3.5 Domain Adaptation
To address the small 2.5k row constraint, a DeBERTa model was subjected to intermediate fine-tuning on a 10,000-article news corpus from 2017–2019, ensuring the model's base weights are adapted to the specific linguistic era of the Da San Martino dataset.

> On Pre-training vs. Fine-tuning: If you take a base BERT model and train it on a general news corpus before your specific task, that is called Domain Adaptation or Intermediate Fine-Tuning. The final pass on your 2.5k rows is Task-Specific Fine-tuning.
> 
> Need to work out the exact external dataset
