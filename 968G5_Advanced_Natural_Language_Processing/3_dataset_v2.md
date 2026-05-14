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
- Read in Dataset
- 2414 rows
- Allegedly matches standard PTC-SemEval20 training set (need to check this)

### Label Freqs
- Class Freqs show that the given dataset is quite balanced. 
- 9 labels including not_propaganda
- not_propaganda               1191
- exaggeration,minimisation     164
- causal_oversimplification     158
- name_calling,labeling         157
- loaded_language               154
- appeal_to_fear_prejudice      151
- flag_waving                   148
- repetition                    147
- doubt                         144
- *while a standard imbalance exists between propagandistic and non-propagandistic text (ratio of ~1:8), the eight specific propaganda techniques are remarkably balanced, with each containing approximately 150 instances*
- *This allows for a more controlled comparison of the Lexical Trigger Hypothesis (H1) across categories, as no single technique benefits from a disproportionately larger training signal.*
- Additionally, with respect to trigger words, an equal weighting among classes gives us adequate substrate the analysis if there are few words per label and if there any mutual prop words accross categories. 
- This creates a "pure" environment to test H1 (Lexical Trigger). Since no class has a frequency advantage, the model must rely on the specific words or structures to distinguish between them. (Should be the same for H1)


**Evaluation Considerations:**
- Macro-averaging calculates the F1-score for each class independently and then takes the unweighted mean of those scores. Every class is treated as equally important, regardless of how many samples it has.
- For a single-label multi-class task, Micro-F1 is mathematically identical to Accuracy. It provides a "false sense of security" because a model can achieve a high score by simply being very good at identifying the common not_propaganda label while failing on the rarer techniques.
- Macro-F1 vs. Micro-F1 (Accuracy): In this specific scenario, Macro-F1 and Micro-F1 will be very similar, if not identical.
- Micro F1 is always mathematically identical to Accuracy in any multi-class classification task where each instance is assigned to exactly one label.
- Every mistake the model makes is counted twice in the "Micro" calculation: once as a False Positive (the model guessed Class A but it wasn't) and once as a False Negative (the model failed to guess Class B when it should have). Because total $FP = total FN$, the formula for Micro Precision and Micro Recall becomes identical to the formula for Accuracy.Since Precision and Recall are the same, their harmonic mean (F1) is also the same value.
- Loss of "Imbalance Bias": In an imbalanced dataset, Accuracy/Micro F1 is often "misleading" because it hides poor performance on small classes. In your balanced Task 1, this bias is gone. Accuracy becomes a more "honest" metric for overall system performance.
- Even with a balanced dataset, you should still report Macro F1. Why? Because it demonstrates that you are evaluating the model's ability to treat each rhetorical technique as a distinct "specialty." It proves you aren't just looking for an easy overall score but are interrogating the model's performance on a per-technique basis.
- of a model was perfect on 4 labels but 0% on the other 4 both micro and macro would come out at 50%.
- macro has lost the advantages it has in an imbalanced setting like da san and e-val
- macro should still be the eval chose because we know these dataset by nature are imbalanced. if we want to run this model in the future with new data it will likely be imbalanced
- Imbalanced Data: Micro = High (Misleading), Macro = Low (Honest). (They diverge).
- Macro-Average F1 is the only reliable way to perform a fair "apples-to-apples" comparison between a balanced model and an imbalanced one.
- Macro F1 doesn't care how many samples were in the training set for a specific class; it only cares about the effectiveness of the model on that class during testing.

**Data Augmentation Evaluations**: 
- In the brief, I have set out a desire to produce silver data. one of the motivations was to balance the classes but clear this is not an issue anymore. 
- However, it now means that the augmentation needs to be capable of producing reliable data for each class
- Although, maybe this isn't strictly true and the results will just show it performs poorly on the silver data for certain task which would be a good thing to highlight and provides scope for future study
- This links well to the evaluation points and macro f1. this is the only metric that will allow us to comapre between models if the silver data comesout imbalanced for wahtever reason. 

**Loss Function Consdieration**:
The labels are balances but the non label is highly skewed. For training task 2, the model might be inclined to lazy guess not propaganda (?)
- I am not sure that this is an issue.
- In fact this is something that needs to be dicussed before training
- It is correct to **test** against the non_prop label? I don't think it makes sense.
- It makes sense to train against it but in terms of a metric we don't care it is gets the non-prop spans correct

--- 

### Sequence Length Analysis

#### Summary Stats for Snippet Length
- Huge disparity in mean lengths for different categories.
    - repetition (2.84), loaded language (3.57) 
    - causal_oversimplification (21.58), doubt (20.57)
    - it will be interested to see the eval matrix between these categories with similar mean lengths
    - short mean averages, and snippets in general, play into the hypothesis 1, i.e. the power is likely to be in the words themsevles.
- All categories (apart from `causal_oversimplification`) contain 1 length snippets but its counts they are comparatively a percentage. 
- Although in Repetition they make up 47% almost half of the sample.
- Interestingly, the `not_propaganda` label makes up 21% of itself sample which puts it 3rd on the list of 1 length snippets. 

#### Summary Stats for Context Length










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