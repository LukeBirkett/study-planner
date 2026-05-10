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