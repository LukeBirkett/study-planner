# Advanced Natural Language Processing (968G5): Assessed Coursework

Format Submit a single zip file containing 1 pdf and an appendix of your code (which may be a `.ipynb` or a `.py` file)

**Word count Expected:** 8 pages (approx. 3000 words; absolute max 5000 words) plus figures, references and code appendix.

## 1. Practical assignment (3000 words): Propaganda Detection

You are provided with a zipfile `propaganda_dataset`. This includes 2 files with identical format: one for training and one for testing. Each file is in tab-separated-value (tsv) format with 2 columns as illustrated below.

| label | sentence |
| :--- | :--- |
| flag_waving | I want to get <BOS>our soldiers <EOS> out. |
| not propaganda | Our older measure of <BOS>American Worker Displacement <EOS> understated the problem. |

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

The second column contains a `sentence` or chunk of text where the propaganda technique has been identified (or no propaganda has been identified in the case of `not_propaganda`).

Note the use of additional tokens `<BOS>` and `<EOS>` which indicate the beginning and end of the `snippet` or span of text (within the sentence) which is actually annotated with the given propaganda technique.

In the first example above, the `snippet` or span of text “our soldiers” has been identified as an example of `flag_waving` in the context of the sentence “I want to get our soldiers out.

### Your tasks are as follows:
1. Build and evaluate at least 2 different approaches to classifying the propaganda technique which has been used in a `snippet` or span of text which is known to be propaganda. As input, your system might take a snippet of propaganda `AND` its sentential context. The output should be the propaganda technique used.
2. Build and evaluate either 2 different approaches or at least 2 variations on a single approach to detecting propaganda within a sentence. Your system should identify both the span and the propaganda technique used.

In this assignment you are expected to complete both tasks above and investigate different approaches for each. The approaches used for task 2 may be the same, related or completely different to the approaches used in task 1. Your solution does not need to be novel.

It does not matter how well your method(s) perform. 

However, your methods should be clearly described, any hyper-parameters (either fixed, varied or optimised) should be discussed and there should be a clear comparison of the approaches with each other — from theoretical, practical and empirical perspectives. 

If you are unsure whether your approaches are sufficiently different to each other then you should discuss this with one of the TAs. 

For example, two different bag-of-words classifiers do not count as 2 different approaches. Neither do 2 different large language models. These count as variations on a single approach.

### 1.1 Resources and Academic Integrity
You have been provided with the training and test data for this task with the assignment. You may (and are expected to) use any of the code that you have developed throughout the labs. This includes code provided to you in the exercises or solutions. You may use any other resources to which you have access. You may also download other resources from the Internet and make use of any Python libraries with which you are familiar. All code that you use (libraries, lab solutions and open source code) should be properly accredited within your code base and within your report e.g., “my function for X is adapted from code available at Y”

Generative and other AI tools may be used in an assistive capacity in this assignment. This includes assistance with coding and with proof-reading. Please include a statement on the title page of your assignment stating whether or not AI has been used in any way, and if so, which tool(s) has been used and in what way.

### 1.2 Report
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

## 2 Marking Criteria and Requirements
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






























<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

# Ideas
- tf-idf but on bigrams rather than unigrams. context definetly matters when it comes to propaganda but surely a huge amount of weight goes into the bizzare choice of words and well the combinations of these bizzare words with other, potentially normal words. Therefore a BoW approach much actually suffice. However, in a basic BoW approach, it is far too easy for a model to become fixed on these "target" words results in a model which is too "trigger happy". but using bi-grams we some contextual context but importantly we are amplifing the linguistic irregularities of propaganda. "make america great again" appears to somewhat make sense as a sentence (not really) but scoping down into the even just bi-grams things become increasily abstract. i.e. "america great", it is difficult to form cohertent sentences where that makes sense. it is lacking punctuation, connective words. etc. 

---

The first task is a classification task with multiple classes. 

The key approach to tackling this task is to apply architecture that takes the input sequences and applies something in order to take the character based works into something rich that a classifer can use to predict from.

At a high level I think it would be interesting to take two approaches. One which is a Bag-of-Words approach and another which uses contextual embeddings. 

Bag-of-Words may seem quite a basic approach to take but I have a hypothesis that the use of language in propaganda is so abstract that merely the particular words, and combination of words, themselves can enable an adequate approach to classifcation. 

The other method is slightly contingent on what I wish to get out of the model. I would like to use this as a chance to work more advanced modern methods specifcally transformers.

---

Label augmentation: 
1. Stagger the Start and End tags
2. Create spans that include a partial span (probably as not propaganda)
3. Take the gold label spans and create alternative versions using similar words. This still be important for the evaluation method (maybe? perhaps contextualised embeddings should be able to generalise to this anyway, could be better for an analysis piece)
- Could give a generative process. 

---

CLS (or not) token approach. Need to justify and dicussion given approach. Try and make it relevant to task. Perhaps something about propaganda being vague and often related to divergances from typical langugage structure. Not sure which type of token would be best for this but try to back it up using emprical references

---

Micro vs marco average need to feature somewhere and a discussion around its difference and what will be better for the task. 

---

Apply BLEU to wordpeice and justify it being an inbetween of chrF and BLEU. Subword BLEU, shouldn't already empiracally be thing. it achieves many of the same goals as chrF—such as handling out-of-vocabulary words and capturing morphological similarities—but there are key differences in granularity and mathematics that make them behave differently. 

chrF is still more account as it can caputre spelling variation and mistakes as well as very granular morphological details that may, or may not, be consdiered by the chose wordpeice tokenizer. 
- Because chrF operates on every character sequence, it is significantly more robust to typos or transliteration differences (e.g., "center" vs. "centre")

Because chrF includes Recall, it rewards the model for including all the necessary characters/information from the reference, whereas BLEU is more focused on making sure what is there is correct.
- Im not sure Recall is actually nessecary for propaganda. It may make the model overfit. we want to capture the intent not the words. 

I am undecided whether spelling variation is required for progaganda. on the one hand, these are often formal statement thus will use formal "correct" language. on the other hand, propagandists tend to make up their own language rules but think these apply more to the structure rather than the words themselves.

---

Limitations of crF or BLEU positives

- it applies the same weight to every character, where as we know some chars, or parts of words, are more inportant. 
- chrF, a model might get a high score by getting the suffixes and prefixes of several words right while failing to produce the correct root meaning of the sentence.
- Interpretability for Humans: Humans naturally think in terms of words. When a researcher sees a BLEU score, they can intuitively understand it as "the model got roughly $X\%$ of the words right"
-  An F-score based on character $n$-grams is a more abstract mathematical value that is harder to visualize in terms of real-world fluency.
- Standardization and Comparison: Since BLEU has been the "industry standard" since 2002, almost every paper published in the last two decades uses it.
- For languages like English, which have very little morphology (few suffixes/prefixes), the gap between BLEU and chrF is much smaller. In these cases, the simplicity of BLEU is often sufficient.
- Sensitivity to Word Order: Because BLEU uses 4-grams, it is very strict about word order. In some applications, getting the exact word order right is more important than capturing morphological roots, making BLEU a stricter (and therefore safer) judge. **This might be important for Propaganda**
- BLEU applies for weight (by proxy) to content words. if a content word is missed not only does the unigram break but so does all of the n-grams. chrF can word around the content words and retain the structure. No partial credit

chrF++ is an enhanced version of the chrF metric. While the original chrF only considers character $n$-grams, chrF++ adds word $n$-grams to the calculation to get the "best of both worlds."It was introduced specifically because researchers found that while character-level matching is great for morphology, adding a small amount of word-level information significantly improves the metric's correlation with human judgment.

If you only look at characters, you might miss "macro" structures. By adding word $n$-grams:Word Order: It becomes slightly more sensitive to word-level reordering that might not be captured clearly by character substrings.Semantic Anchor: It ensures that the model is actually getting the specific tokens correct, not just producing sequences of characters that look like words

---

WordPeice BLEU vs chrF++

BLEU; hard boundaries, relies on external tokenizer

chrF; soft boundaries

Wordpiece BLEU is primarily Precision-oriented. It asks: "Of the tokens the model produced, how many are in the reference?" It uses a "Brevity Penalty" to stop the model from just outputting one correct word.

chrF++ is an F-score, which balances Precision and Recall. It explicitly asks: "Did the model produce all the characters/words found in the reference?" This makes it much more sensitive to "missing" information than BLEU is.

Because chrF++ adds word $n$-grams back into the character-based score, it actually acts like a weighted ensemble:The character part acts as a "morphological safety net" (catching stems and suffixes).The word part acts as a "semantic anchor" (ensuring the overall word-level fluency is there).

---

Difference in interpretation:

If you see a high chrF++ score but a low BLEU score, it usually indicates that your model is "directionally" correct but lacks polish:

Interpretation: The model has captured the correct stems and semantic roots (high character recall), but it is failing on specific word-choice or exact phrasing (low word-precision).

Task Application: This is common in Low-Resource Translation. It means the model has learned the "gist" of the language but hasn't mastered the specific grammar or idiomatic tokens yet.

Conversely, if you have a high BLEU but lower-than-expected chrF++:

Interpretation: The model is "playing it safe." It is producing short, exact phrases it is sure about (high precision), but it might be missing a lot of the required detail or content from the reference (low recall).

---

2. Analysis & Testing Evaluation (Precision/Recall/BLEU)

Evaluation in the form of Precision, Recall, F-score, or chrF is generally performed on a held-out Test Set. You are correct that this is for Analysis. This is evaluation for the human researcher. It translates the model's raw probabilities into meaningful performance scores. Unlike loss, which looks at the "soft" probabilities, these metrics look at the "hard" decisions (the final predicted tags or words).

---

3. The "Bridge" Metrics: Perplexity
As seen in your lab, Perplexity acts as a bridge between these two worlds.

It is mathematically derived directly from the Log Probability (Loss) of a corpus.

However, it is used as a final Evaluation Metric to compare different models (e.g., Unigram vs. Bigram) because it is more interpretable for humans than raw negative log-likelihood.

---

Theme of interpretability:
- Attention Map
- Key Words
- BLEU over chrF