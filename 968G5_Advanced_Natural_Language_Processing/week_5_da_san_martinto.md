# ANLP/E Seminar Week 5: Propaganda Detection

Da San Martino et al. (2020) introduce a competition to detect and classify propaganda techniques in text. When reading this paper, do not be overly concerned with the different systems which took part in the competition. You will learn about the best-performing methods (transformer-based approaches including BERT) in a few weeks time. For now, we will focus on the overall idea of propaganda detection, the two tasks introduced in this paper (span identification and technique classification), the dataset and the evaluation metrics. Once you have read the paper, consider the following questions.


1. What do you understand by the term propaganda and why might it be important to develop systems which can automatically detect propaganda in text?

2. Why is automatic propaganda detection difficult?


3. Give examples of 3 different propaganda techniques being used in text. Explain why this is propaganda.


4. What textual features might be useful to help a system detect propaganda?


5. Describe the pipeline proposed by the paper for propaganda identification. Can you think of any alternatives? What advantages / disadvantages are there of each?


6. How was the PTC-SemEval20 corpus collected and annotated? What do you understand by “the $γ$ agreement on the annotated articles is on average 0.6”?


7. How do the authors evaluate systems on the span identification task?


8. Micro-average F1 is used to evaluate systems on the technique classification task. The authors state that for a single-label task, this is equivalent to accuracy. Explain


9. Outline one method which could be used to carry out span identification.


10. Outline one method which could be used to carry out techniques classification.


11. Systems were evaluated for span identification on both the development set and the test set. Why do you think the results are not the same on both?


12. What is the predominant propaganda technique found in the corpus? If a system labelled every propaganda snippet with this label, how would it do? What do you think of the system results for techniques classification (Table 6)?
















---

# Paper Copy and Paste Notes

## Abstract

We present the results and the main findings of SemEval-2020 Task 11 on Detection of Propaganda Techniques in News Articles.

The task featured two subtasks. Subtask SI is about Span Identification: given a plain-text document, spot the specific text fragments containing propaganda.

Subtask TC is about Technique Classification: given a specific text fragment, in the context of a full document, determine the propaganda technique it uses, choosing from an inventory of 14 possible propaganda techniques.

In this paper, we present the task, analyze the results, and discuss the system submissions and the methods they used. For both subtasks, the best systems used pre-trained Transformers and ensembles


# Introduciton 

Propaganda aims at influencing people’s mindset with the purpose of advancing a specific agenda.

Propaganda is most successful when it goes unnoticed by the reader, and it often takes some training for people to be able to spot it.

Most previous work has performed analysis at the document level only (Rashkin et al., 2017;Barron-Cedeno et al., 2019a) or has analyzed the general patterns of online propaganda (Garimella et al., 2015; Chatfield et al., 2015).

SemEval-2020 Task 11 offers a different perspective: a fine-grained analysis of the text that complements existing approaches and can, in principle, be combined with them.

Prop techniques ... which range from leveraging on the emotions of the audience —such as using loaded language or appeals to fear— to using logical fallacies —such as straw men (misrepresenting someone’s opinion), hidden ad-hominem fallacies, and red herring (presenting irrelevant data). 

Our goal is to facilitate the development of models capable of spotting text fragments where propaganda techniques are used

Subtask SI (Span Identification): Given a plain-text document, identify those specific fragments that contain at least one propaganda technique. (This is a binary sequence tagging task.)

Subtask TC (Technique Classification): Given a propagandistic text snippet and its document context,
identify the propaganda technique used in that snippet. (This is a multi-class classification problem.)

Input > Task 1: Span Identification > Task 2: Technique Classification > Output


**Section 2:** introduces the propaganda techniques we considered in this shared task. 

**Section 3:** describes the organization of the task, the corpus and the evaluation measures. 

**Section 4:** An overview of the participating systems is given.

**Section 5:** Discusses the evaluation results. 

**Section 6:** Related work is described.

**Section 7:** draws some conclusions, and discusses some directions for future work


# 2 Propaganda and its Techniques

Propaganda comes in many forms, but it can be recognized by its persuasive function, sizable target audience, the representation of a specific group’s agenda, and the use of faulty reasoning and/or emotional appeals (Miller, 1939).

Whereas the definition of propaganda is widely accepted in the literature, the set of propaganda techniques considered, and to some extent their definition, differ between different scholars (Torok, 2015).

For instance, Miller (1939) considers seven propaganda techniques, whereas Weston (2000) lists at least 24 techniques, and the Wikipedia article on the topic includes 67.1 Below, we describe the propaganda techniques we consider in the task: a curated list of fourteen techniques derived from the aforementioned studies. We only include techniques that can be found in journalistic articles and can be judged intrinsically, without the need to retrieve supporting information from external resources.

For example, we do not include techniques such as card stacking (Jowett and O’Donnell, 2012b, p. 237), since it would require comparing multiple sources.

Note that our list of techniques was initially longer than fourteen, but we decided, after the annotation phase, to merge similar techniques with very low frequency in the corpus.

---

1. Loaded language. Using specific words and phrases with strong emotional implications (either positive or negative) to influence an audience (Weston, 2000, p. 6).

2. Name calling or labeling. Labeling the object of the propaganda campaign as either something the target audience fears, hates, finds undesirable or loves, praises (Miller, 1939).

3. Repetition. Repeating the same message over and over again, so that the audience will eventually accept it (Torok, 2015; Miller, 1939).

4. Exaggeration or minimization. Either representing something in an excessive manner: making things larger, better, worse or making something seem less important or smaller than it actually is (Jowett and O’Donnell, 2012b, pag. 303).

5. Doubt. Questioning the credibility of someone or something.

6. Appeal to fear/prejudice. Seeking to build support for an idea by instilling anxiety and/or panic in the population towards an alternative, possibly based on preconceived judgments

7. Flag-waving. Playing on strong national feeling (or with respect to any group, e.g., race, gender, political preference) to justify or promote an action or idea (Hobbs and Mcgee, 2008)

8. Causal oversimplification. Assuming a single cause or reason when there are multiple causes behind an issue. We include in the definition also scapegoating, e.g., transferring the blame to one person or group of people without investigating the complexities of an issue.

9. Slogans. A brief and striking phrase that may include labeling and stereotyping. Slogans tend to act as emotional appeals (Dan, 2015)

10. Appeal to authority. Stating that a claim is true simply because a valid authority or expert on the issue supports it, without any other supporting evidence (Goodwin, 2011). We include in this technique the special case in which the reference is not an authority or an expert, although it is referred to as testimonial in the literature (Jowett and O’Donnell, 2012b, pag. 237).

11. Black-and-white fallacy, dictatorship. Presenting two alternative options as the only possibilities, when in fact more possibilities exist (Torok, 2015). Dictatorship is an extreme case: telling the audience exactly what actions to take, eliminating any other possible choice.

12. Thought-terminating clich ́e. Words or phrases that discourage critical thought and meaningful discussion on a topic. They are typically short, generic sentences that offer seemingly simple answers to complex questions or that distract attention away from other lines of thought (Hunter, 2015, p. 78).

13. Whataboutism, straw man, red herring. Here we merge together three techniques, which are
relatively rare taken individually: (i) Whataboutism: Discredit an opponent’s position by charging them with hypocrisy without directly disproving their argument (Richter, 2017). (ii) Straw man: When an opponent’s proposition is substituted with a similar one, which is then refuted instead of the original (Walton, 2013). Weston (2000, p. 78) specifies the characteristics of the substituted proposition: “caricaturing an opposing view so that it is easy to refute”. (iii) Red herring: Introducing irrelevant material to the issue being discussed, so that everyone’s attention is diverted away from the points made (Weston, 2000, p. 78).

14. Bandwagon, reductio ad hitlerum. Here we merge together two techniques, which are relatively rare taken individually: (i) Bandwagon. Attempting to persuade the target audience to join in and take the course of action because “everyone else is taking the same action” (Hobbs and Mcgee, 2008). (ii) Reductio ad hitlerum: Persuading an audience to disapprove an action or idea by suggesting that it is popular with groups hated in contempt by the target audience. It can refer to any person or concept with a negative connotation (Teninbaum, 2009).

---

We provided the definitions, together with some examples and an annotation schema, to professionalannotators, and we asked them to manually annotate selected news articles

The annotators worked with an earlier version of the annotation schema, which contained eighteen techniques (Da San Martino et al., 2019b). 

As some of these techniques were quite rare, which could cause data sparseness issues for the participating systems, for the purpose of the present SemEval-2020 task 11, we decided to get rid of the four rarest techniques.

# 3 Evaluation Framework

The SemEval 2020 Task 11 evaluation framework consists of the PTC-SemEval20 corpus and the evaluation measures for both the span identification and the technique classification subtasks. We describe the organization of the task in Section 3.3; here, we focus on the dataset, the evaluation measure, and the organization setup

In order to build the PTC-SemEval20 corpus, we retrieved a sample of news articles from the period starting in mid-2017 and ending in early 2019. 

we selected 13 propaganda and 36 non-propaganda news media outlets, as labeled by Media Bias/Fact Check,3 and we retrieved articles from these sources. We deduplicated the articles on the basis of word n-gram matching (Barr  ́on-Cede  ̃no and Rosso, 2009), and we discarded faulty entries, e.g., empty entries from blocking websites.

The annotation job consisted of both spotting a propaganda snippet and, at the same time, labeling
it with a specific propaganda technique.

We ran the annotation in two phases: (i) two annotators labeled an article independently, and (ii) the same two annotators gathered together with a consolidator to discuss dubious instances, e.g., spotted only by one annotator, boundary discrepancies, label mismatch, etc. This protocol was designed after a pilot annotation stage, in which a relatively large number of snippets had been spotted by one annotator only.

We evaluated the quality of the annotation process in terms of γ agreement (Mathet et al., 2015) between each of the annotators and the final gold labels. The γ agreement on the annotated articles is on average 0.6; see (Da San Martino et al., 2019b) for a more detailed discussion of inter-annotator agreement.

It is worth noting that a number of
propaganda snippets of different classes overlap. Hence, the number of snippets for the span identification subtask is smaller (e.g., 1,405 for the span identification subtask vs. 1,790 for the technique classification subtask on the test set).

The full collection of 536 articles contains 8,981 propaganda text snippets,belonging to one of the above-described fourteen classes.

We can see that, by a large margin, the most
common propaganda technique in our news articles is Loaded Language, which is about twice as frequent as the second most frequent technique: Name Calling or Labeling.

Whereas these two techniques are among the ones that are expressed in the shortest spans, other propaganda techniques such as Exaggeration, Causal Oversimplification, and Slogans tend to be the longest.

## 3.2 Evaluation Measures

**Subtask SI** 

Evaluating subtask SI requires us to match text spans. Our SI evaluation function gives credit to partial matches between gold and predicted spans.

$$P(S,T) = \frac{1}{|S|} \cdot \sum_{d \in D} \sum_{s \in S_d, t \in T_d} \frac{|(s \cap t)|}{|t|}$$

$$R(S,T) = \frac{1}{|T|} \cdot \sum_{d \in D} \sum_{s \in S_d, t \in T_d} \frac{|(s \cap t)|}{|s|}$$

---

1. The Symbols$s \cap t$ (Intersection): This represents the overlap. It refers to the set of character indices that are present in both the predicted span ($s$) and the gold span ($t$). * $| \dots |$ (Cardinality/Magnitude): This denotes the length (number of characters) of that set.$|s \cap t|$ is the number of characters where your prediction and the gold truth overlap.$|t|$ is the total number of characters in the gold span. 

2. Reading the MathYou asked if we are comparing lengths and dividing by $|t|$. Yes, but specifically, you are calculating the percentage of the gold span that your prediction managed to cover.The inner part of the formula $\frac{|(s \cap t)|}{|t|}$ works like this:Find the overlap: If the gold span is indices $[10, 20]$ (length 11) and your prediction is $[15, 25]$, the intersection $s \cap t$ is $[15, 20]$ (length 6).Calculate the ratio: You divide that overlap (6) by the gold length (11). Your "score" for that specific pair is ~0.54.

3. The Nested Summation ($\sum \sum$)The formula looks intimidating because of the double Sigma ($\sum$), but it’s just a fancy way of saying "total everything up":Inner Sum ($\sum_{t \in T_d}$): For a single prediction $s$, look at every gold span $t$ in that article and see how much they overlap.Outer Sum ($\sum_{d \in D}$): Do this for every article in your dataset.The Multiplier ($\frac{1}{|S|}$): Finally, divide the grand total by the total number of predicted spans ($|S|$). This turns your total overlap "points" into an average precision score across the whole dataset.

4. Precision vs. Recall (The Denominator)
There is a very subtle but crucial difference between the two formulas in your image:
* Precision (1): Divides the overlap by $|t|$ (the gold length). It asks: "Of the truth I was supposed to find, how much did my specific prediction capture?"
* Recall (2): Divides the overlap by $|s|$ (your predicted length). It asks: "Of the prediction I made, how much of it was actually correct?"

Quick Correction: Usually, Precision is "correct / predicted" and Recall is "correct / gold." In this specific paper, the authors appear to have swapped the standard naming convention or adapted it for "partial credit." In traditional NLP, Formula (1) looks more like a Recall calculation because it is normalized by the "Gold" set $T$

---

We define Eq. (1) to be zero when |S| = 0 and Eq. (2) to be zero when |T| = 0.

Notice that the predicted spans may overlap, e.g., spans s3 and s4 in Figure 4. Therefore, in order for Eq. 1 and Eq. 2 to get values lower than or equal to 1, all overlapping annotations, independently of their techniques, are merged first. For example, s3 and s4 are merged into one single annotation, corresponding to s4.

Finally, the evaluation measure for subtask SI is the F1 score, defined as the harmonic mean between
P(S,T) and R(S,T):

$$F_1(S,T) = 2 \cdot \frac{P(S,T) \cdot R(S,T)}{P(S,T) + R(S,T)}$$



**Subtask TC**

Given a propaganda snippet in an article, subtask TC asks to identify the technique in it.

Since there are identical spans annotated with different techniques (around 1.8% of the total annotations),
formally this is a multi-label multi-class classification problem.

However, we decided to consider the
problem as a single-label multi-class one, by performing the following adjustments:
* (i) whenever a span is
associated with multiple techniques, the input file will have multiple copies of such fragments and
* (ii) the evaluation function ensures that the best match between the predictions and the gold labels for identical spans is used for the evaluation

In other words, the evaluation score is not affected by the order in which the predictions for identical spans are submitted.

The evaluation measure for subtask TC is micro-average $F_1$

Note that as we have converted this into a single-label task, micro-average F1 is equivalent to Accuracy (as well as to Precision and to Recall).

## 3.3 Task Organization