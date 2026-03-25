# Advanced Natural Language Proccessing Notes (Spring 26)

This is the main file for the Advanced Natural Language Proccessing module taken in Spring 26. It will act as the location for note taking accross all mediums, i.e. lectures, videos, labs and additional readings, as well as a directory for file locations. It will be recorded chronologically with a section for each week. 

Advanced Natural Language Processing focuses on the application of data-driven and machine learning methods which have transformed the field of Natural Language Processing over the past couple of decades.  It does build on foundations provided by the level 7 Applied Natural Language Processing module. Students will develop their knowledge and understanding of key topics including word vector space models of semantics, language modelling, contextualised word embeddings, large language models, generative language models and their applications. 

Seminars will provide in-depth discussion of research papers related to the key topics and also general issues that arise when developing natural language processing tools, including: evaluation and reliability, data smoothing techniques; domain adaptation; supervised vs unsupervised learning; and transfer learning. 

Labs will provide the opportunity for students to improve their python programming skills, experiment with some off-the-shelf technology and develop research skills.

#### Learning Outcomes
* Demonstrate a systematic knowledge and understanding of key challenges in the field of natural language processing (NLP) and critical awareness of current approaches to tackling these challenges.
* Critically analyse state-of-the-art NLP technologies and critically assess their application to novel problems involving large quantities of realistic data.
* Critically evaluate the effectiveness of an approach through the design and application of suitable experiments.
* Synthesise and critically assess state-of-the-art technologies for a given NLP problem based on primary scientific literature.

The textbook is [Speech and Language Processing](https://web.stanford.edu/~jurafsky/slp3/) by Dan Jurafsky and James H. Martin


# Table of Contents
1. [Week 1 - Lexical and Distributional Semantics Revisited](#week-1---lexical-and-distributional-semantics-revisited)
2. [Week 2 - Language Modelling w/ N-grams](#week-2---language-modelling-with-n-grams)
3. [Week 3 - Neural Networks and Neural Language Modelling](#week-3---neural-language-models)
4. [Week 4 - Word Embeddings]()
5. [Week 5 - Applications in NLP]()
6. [Week 6 - Machine Translation]()
7. [Week 7 - Pre-Trained Large Language Models]()
8. [Week 8 - Transfer Learning with Pre-Train Large Language]()
9. [Week 9 - ]()
10. [Week 10 - ]()
11. [Week 11 - ]()

--- 

# [Week 1 - Lexical and Distributional Semantics Revisited](https://canvas.sussex.ac.uk/courses/35245/pages/week-1-introduction-2?module_item_id=1546317)

This week is for reviewing the core concepts from lexical semantics and distributional semantics. It will essentially be a revision session from the Applied Natural Language Processing module from last year. The topics covered will be:
* Word sense ambiguity
* WordNet
* Lexical semantic relations
* Semantic similarity
* Measuring Information Content
* Vector space representations based on context
* (Positive) Pointwise Mutual Information (PPMI)
* Cosine similarity
* Challenges in distributional semantics

#### Week 1: Contents

1. [Lecture](#week-1---lecture)
3. [Seminar](#week-1---seminar)
4. [Additional Readings](#week-1---additional-readings)

## Week 1 - Lecture 

| [Slides](/Users/lukebirkett/Repos/study-planner/968G5_Advanced_Natural_Language_Processing/files/week_1/week_1_lecture_lexical_distributional_semantics.pdf) | [Lecture Video Part 1](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=c7d2751c-0820-4e87-8b8d-acb400db8436&start=1.23467) | [Lecture Video Part 2](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=15631590-2d19-4dcd-98bf-acb400db95f6&start=0) |

## Week 1 - Seminar 

* [Seminar Session](#week-1---seminar-session)
* [Seminar Reading](#week-1---seminar-session)

### Week 1 - Seminar Session 

| [Seminar Questions](files/week_1/week_1_seminar_questions.pdf) | [Seminar Slides]()

This seminar session was a mix of mild lecturing before breaking out into small groups to discuss questions. After which as a whole class we would put forward answers. In this section I will put down the questions and some notes for the answers. 

**Prompt: Imagine you have been given a set of 1000 
documents, each of which have been annotated as 
relevantor irrelevant to a particular topic.  Your 
task is to build a classifier which can assign the 
correct label (relevantor irrelevant) to a previously 
unseen document.  How would you go about doing 
this?**

In my group we discussed pre-processing, identifying words and their sense, naive bayes as an approach to unpack frequeniques and probablities and finally we spoke about feature vectors from a linear algebra perspective. 

---

### Document Classification using Naive Bayes

Here, documents are respected as a bag-of-words where the features are the observed words. There is no notion of order meaning the structure of sentances is lost. NB selected a class/label based on the cumulative probabilites of the feature vector that respresents the document. 

$$y = \text{argmax}_y P(y) \prod_{i=1}^{n} P(x_i \mid y)$$

It is important to remember Naive Bayes is a similifiation of Bayes Rule. To simplifiy the model we assume that features, the words, are all indepent, i.e. the use of one word does not increase or decrease the use of a another, this is how we end up with our bag-of-words srtucture. Clearly this is not true but it makes the formula mathematically possible, allowing us to compute at least something. 

---

### Towards More Intelligent NLP

This slide highlights that a Naive Bayes approach to NLP is a little too basic. It treats word tokens as atomic building blocks but obscures too much of the characteristics required for human understanding of language: the meaning. Meaning is generally inferred through words relationships with other words and/or their similarity to other words. This notion is the basis for Lexical Semnatics which is the focus of this weeks content. 

---

### Seminar 1.1 Questions

**1. Give an example of lexical ambiguity**: These are words that are spelt exactly the same but have different senses. 

**2. Give an example of lexical variation**: These are different words that mean the same thing/sense

**3. What is a WordNet synset?** a WordNet synset (short for "synonym set") is a group of words that mean the same thing in a specific context.

* **What does the number of synsets that a word form occurs in tell us?**: This is a measure of its polysemy, i.e. its multiple meanings.
* **What does the size of a synset tell us?** The "size" of a synset refers to the number of lemmas (individual word forms) that are grouped together within it. While the number of synsets for a word tells you about ambiguity, the size of a single synset tells you about lexical density and synonymy. If a sense has many different words for it then this may be a culturally important word that is used often, or something that requires different words to represent an emotional context. Additionally, a large sysnet might imply that the word is high-level and broad. A sysnset with only 1 word is monosemous, these words are very specific and can only ever mean 1 thing. 
* **How are synsets connected?** Synsets are linked in a semantic network of Hyponymy and Hypernymy. This is hiearchical structure which denotes an "Is-A" relationship. Hypernym (Superordinate): A more general term. (Furniture is a hypernym of Chair). Hyponym (Subordinate): A more specific term. (Oak is a hyponym of Tree)


**4. Describe 2 ways WordNet can be used to calculate the 
similarity of 2 concepts?  Which is the best way and how do you know?** 

The two main ways of using WordNet are PathLength and Information Content. 

PathLength is a distance based metric with traverses edges and counts the shortest route from one term to another. It introduces the concept of a Lowest Common Subsumer (LCS) which is the lowest (first) mutual Hypernymy that two terms share. Shorter paths are assumed to be more similar words. 

The other measure, Information Content is considered to be node based. It assumes that the similarity of two concepts depends on how much "information" they share. It requires the addition of an external corpus to popualiton the statistics. The "Information Content" of a concept is based on its frequency in a large body of text. Rare, specific words (like Pomeranian) have high IC, while common, general words (like Entity) have low IC. There are many different IC metrics each with their own pros and cons. 

The Information Content (IC) measures (specifically Lin or Jiang-Conrath) are generally considered superior to simple Path-Based measures. However, this something with a trade-off which is generally linked to data robustness and specifically data sparisty. Language is naturally sparse and miss values often lead to formulas failing. 

---

### Seminar 1.2 Questions

**1. What is the distributional hypothesis?** 

The Distributional Hypothesis is a foundational concept in linguistics and Natural Language Processing (NLP) that suggests the meaning of a word is determined by the words that frequently appear around it.

**2. Explain how distributional semantics might help us in another application e.g. document classification**

Distribution semantics allows us to transfer learnings from one application to the next and fill in missing information based on contextual clues. We may on know the exact meaning on a rare type of drink. However, we may see that is used similar to beer, also an alchoholic drink. By applying distribution demantics to a very large corpus we can learn that the rare drink is similar to beer even if the specific training sample wasn't able to tell us that. 

**3. In traditional distributional semantics (aka vector 
semantics), how is the association between 2 words often 
measured?** 

Note that there is a different between association and similartity. **Similarity** refers to words that share the same features or occupy the same spot in a hierarchy. These words are often "substitutable"—you could swap one for the other in a sentence and the basic meaning would remain intact. **Association** (also called Relatedness) refers to words that "go together" in the real world. They don't look or act alike, but they frequently appear in the same context or sequence. They are not substitutable.

To measure Association we need to look at the words around a word. Frequency and/or simple conditional probability do not capture the intuition that some features are more informative than others. "the" and "is" appear relatively frequently with all of the word so their contribution to similarity should be smaller. They do not provide any specificity. PMI measures the amount of information gained by seeing a word and a feature together. A feature which co-occurs with a target word more than we would expect (if words and features occurred independently) has more weight in the similarity calculation.

**4. In traditional distributional semantics, how is the similarity between 2 words often measured?**

The main method is to compare two vectors using cosine similarity. he more similar two words are, the  smaller the angle θ between their  vectors will be.

---

## Week 1 - Additional Readings

### <u> Vector Semantics </u>
The additional readings for this week are based on Vector Semantics:

* <u> [Chapter 5 of Jurafsky and Martin](files/week_1/week_1_add_read_vector_semantics_chapter_5.pdf) </u> sections 5.1-5 4 
* <u> [Lecture 3 of Jurafsky and Martin](files/week_1/week_1_add_read_vector_semantics_lecture_3.pdf) </u>

---

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>


# [Week 2 - Language Modelling with n-grams](https://canvas.sussex.ac.uk/courses/36171/pages/week-slash-topic-2-language-modelling-with-n-grams?module_item_id=1602169)

This week we will be looking at n-gram language models.  In particular, we will be looking at:
* why build language models?
* how to evaluate language models?
* perplexity
* generation
* generalisation and smoothing

#### Week 2: Contents

1. [Lecture](#week-2---lecture)
2. [Seminar](#week-2---seminar)
4. [Additional Readings](#week-2---additional-readings)

## Week 2 - Lecture

| [Lecture Slides](files/week_2/week_2_lecture_slides.pdf) |

This week we are looking at **Probabilitic Language Models**. This includes: n-gram modelling and their evaluation methods (perplexity), generation and generalisation.

* [Why do we want to be able to assign a prob to a sentence?](#why-do-we-want-to-be-able-to-assign-a-prob-to-a-sentence)
* [Probability language modelling](#probability-language-modelling)
* [Chain Rule for Probabilties ](#chain-rule-for-probabilties)
* [N-gram Language Model](#n-gram-language-model)
* [Lanugage Model Evaluation](#lanugage-model-evaluation)
* [Perplexity](#perplexity)
* [Part 2: Generalisation in n-Gram Models](#part-2-generalisation-in-n-gram-models)
* [Toy Example](#toy-example)
* [Unknown Words (Token)](#unknown-words-token)
* [Absolute Discounting](#absolute-discounting)

---

### Why do we want to be able to assign a prob to a sentence?

The starting desire to acheive this comes form machine translation. If we wish to translate a sequence of tokens from source to other language then we want to select the most probable sequence in the target. 

However, the sentence, or words, chosen need to follow the cultural rules of a language. Semantically, there may be several phrases whereby the choice of words results in a high probability. i.e. high winds and large winds but the former is much more likely in action. If we derive our probabilites from large corpuses then the statistics will tell us that high winds is a much more common phases. 

This desire to assign probabilities to tokens, or sequence of tokens, also applies to spelling corrections. By detailing the probability of sentences, we can work out which spelling/usage of a word if most likely and therefore more probable to be the correct spelling. 

This concept is most easy to think about within the topic of speech recognition. A computer can parse sounds into words but we have many words, sounds and prases that in terms of pure noise, sounds the same but mean completely different things. Merely constructing sounds from the entire lexicon can result in an unintelligence sentence. A real sentence will be distinguished by its probability: `P("I saw a van") > P(eyes awe of an)`.

This was the motivation for early language modelling

---

### Probability language modelling

What is a probabilistic language model? It has the goal of computing 1 of 2 things:
* Compute the probability of a sentence as represented by a sequences of words: $P(W) = P(W_1,W_2,...,W_n)$
* Or the related but different task of computing the probability of an upcoming word given an input of a sequence of words: $P(W_5|W_1, W_2, W_3, W_4)$

If a model does either of these tasks, it is a language mnodel (LM).

---

### Chain Rule for Probabilties 

Conditional probability is given by: $P(B|A) = \frac{P(A, B)}{P(A)}$. 

It defines the probability of event B occurring, given that event A has already happened. We want to find the probability of $B$ in a world where $A$ has already happened. The solution to computing this is to find the overlap where both happen and normailze it against the total size of $A$
* $P(B|A)$: The probability of $B$ given $A$.
* $P(A, B)$: The joint probability (the chance that both $A$ and $B$ happen).
* $P(A)$: The probability of event $A$ happening on its own.

By multiplying both sides by $P(A)$ you get:

$$P(A, B) = P(A)P(B|A)$$

This is a fundamental rule used to find the probability of a sequence of events. It tells us that the probability of both $A$ and $B$ occurring is the probability that $A$ occurs, multiplied by the probability that $B$ occurs given that $A$ occurred.

In other words, to find the chance of two things happening together, you multiply the probability of the first event by the probability of the second event given the first has already occurred.

The Naive Bayes formula is essentially a clever rearrangement of this Product Rule. It takes the probability of a "Class" and "Features" happening together and flips them around to predict the class based on the features.

This can be extended to many more variables where each new event is dependant on everything that came before it:

$$P(A, B, C, D) = P(A)P(B|A)P(C|A, B)P(D|A, B, C)$$

For any number of variables $n$, the joint probability is the product of each variable conditioned on all previous ones: 

$$P(x_1, x_2, \dots, x_n) = P(x_1)P(x_2|x_1)P(x_3|x_1, x_2) \dots P(x_n|x_1, \dots, x_{n-1})$$

This logic can easily be applied to sentances whereby each most recent word in the sentence depends on the entirety of the sentence that came before. 

---

### Estimating Probabilities

The issue we run into here is data sparsity. As the sentence continues and the length of the dependant chain grows, the probability that the exact sentence has occured before starts to become extremely unlikely and our results will be unreliable. 

---

### Markov Assumptions

To fix sparsity in n-grams we use Markov Assumptions. Here, we simplying the dependency criteria from the entire previous chain to orders. The most common is first-order Markov Chains whereby each newest word depends only on the previous word. This 1 previous state is considered to be a proxt for the entire previous sentence, for the previous state will occur given a specific set of previous states, i.e. the context of the sentence. This is an assumption of independence whereby all previous context is held intrinsically in the state. In practice, we know this isn't true but it is a simple assumption that allows us to calculate some sort of probability. The markov model can be extended in its orders. A second order model allows each words to look at the previous 2. 

---

### N-gram Language Model

 Calculating the probability of a word based on every preceding word is computationally difficult, or even impossible, the N-gram model introduces a simplifying assumption:
 * It fixes the history and only considers $n$ words at a time: the current word ($w_i$) and the previous $n-1$ words.
 * Maximum Likelihood Estimation (MLE): The model estimates these probabilities by looking at a training corpus and calculating frequencies. In statistics, Maximum Likelihood Estimation is a method of estimating the parameters of a model that makes the observed data "most probable."

 $$P(w_i \mid w_{i-(n-1)}, \dots, w_{i-1}) = \frac{freq(all\ n\ words\ together)}{freq(the\ previous\ n-1\ words)}$$

 This formula represents the "training" phase of the model. It is the way the computer calculates the probability of a specific word appearing based on the context of the words that came right before it.

In this context, if you see the phrase "the cat sat" 10 times in your data, and 6 of those times the next word is "on," the MLE estimate for $P(on \mid the, cat, sat)$ is $6/10 = 0.6$. This is the "best guess" the model can make based solely on the evidence it has seen in its training text.

---

### Unigram Model

This is the most simplistic type of n-gram model whereby `n=1`. It doesn't look at any previous words meaning probabilites are all independent, i.e. words have probabilities which get chained together: `P("he fell over) = P(he) * P(fell) * P(over)`

This approach is very simple but atlest it gives an estimate which can be used as a baseline for further comparison.

$$P(w_1, w_2, w_3, \dots, w_k) = \prod_{i=1}^{k} P(w_i)$$

---

### Bigram Model

A bigram model is a first order markov model meaning that each word in a given sentence depends on the previous word:

`P("then we hovered") = P("then|start") * P("he|then") * P("hovered|he") * P("over|hovered")`

---

### Trigrams and Beyond

This logic pravails for any `n` number of terms to look back on. Rememeber `n=1` is a unigram which only looks at itself, so `n>1` looks back `n-1` terms. e.g. trigrams (3), quadrigrams (4), 5-grams (5). Higher terms will be able to capture more long range association dependencies but the models will be become more sparse and unreliable.

---

### Products of Probabilties

When calculating the probability of a long sequence (like a sentence in an N-gram model), we prefer logarithmic addition over raw multiplication for two main technical reasons: numerical stability and computational efficiency.

Probabilites are always betwene 0 and 1, this means when you mutliple many probabilites together, like the chain rules, the result is a tiny output which quickly becomes infinitesimally small. Computers cannot represent numbers this small with high precision, leading to a "floating-point underflow" where the computer simply rounds the result down to zero.

By taking the logarithm, these tiny probabilities are converted into manageable negative numbers (e.g., $log(0.0001) = -4$). Adding these values avoids the precision "death" that occurs with multiplication. 

Addtionally, from a hardware perspective, computers are generally faster at performing addition than multiplication, especially when dealing with billions of calculations in modern AI models.

In Maximum Likelihood Estimation (MLE), the goal is to find the parameters that maximize the probability of the data. Since the $log(x)$ function is monotonically increasing, the value of $x$ that maximizes the probability is the same value that maximizes the log of that probability. 

$$log(a \times b) = log(a) + log(b)$$

---

### Lanugage Model Evaluation

We want to be able to evaluate how good a language model is. The outputs need to be determined as good or bad sentences. Real sentences, that is grammatically and plausible sentences, should be assigned higher probabilities than "fake' ones.

---

### Extrinsic Evaluation

This is where you evaluate a model by applying it to a task, i.e. spelling, translation, speech recognition. You run the task and get an accuracy for each model. 
* How many words spelt correctly.
* How many translations correct. 

The issues with this approach is that it is time consuming to set up the conditions for such an experiement and even then there are other factors which may affects the task. The language model is not tested in isolation. 

---

### Intrinstic Evaluation

While extrinsic evaluation measures a model's performance on a final, real-world task, intrinsic evaluation measures the model's quality in isolation, based on its internal properties. 

Intrinsic evaluation tests a language model on a specific sub-task that is independent of any external application. The goal is to see how well the model has learned the underlying patterns of the language itself rather than how well it helps a spellchecker or translator.

A models parameters are trainined on a training set and then tested/evaluated on a test set. We are checking the probabilities applied to sentences. Does the model assign higher probabilties to seen sentences vs unseen?

---

### Perplexity

To evaluate any model we need a metrix. The best language model is one that best predicts an unseen test set, i.e. it returns the highest `P(sentences)`. A common metric used for language models is Perplexity.

To calculate the Perplexity, we look at the probability it assigns to a test set of words. Essentially, perplexity is the inverse probability of the test set, normalized by the number of words.

A lower perplexity score indicates that the model is less "surprised" by the test data, meaning it has a better grasp of the language's structure. If high then the model is "confused" and the test data was unexpected.

$$PP(W) = P(w_1, w_2, w_3, ..., w_N)^{-1/N}$$

This formula can also be converted to logarithms to maintain numerical stablility:

$$PP(W) = e^{-1/N \log P(w_1, w_2, w_3, ..., w_N)}$$

Because Perplexity is the inverse of probability, minimising perplexity is the same as maximising probability. 


## Part 2: Generalisation in n-Gram Models

### Toy Example

In this example we will be a example built from a very small corpus which highlights a n-grams inability to generalise. 

A bigram is a good type of model to demonstrate this as we can represent this infomration as a tabular table/matrix. Recall, that a bigram is the probability a word coming up given the previous word. Given this, we can represent the previous word along the x-axis and the possble next word along the y-axis. Note that, the entire corpus' tokens will be entered on both the x and y axis. 

| $P(w_2\|w_1)$ | _ST. | I | They | like | want | to | cook | eat | Chinese | dinner | Indian | food | _END |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| _ST. | 0 | 2/3 | 1/3 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| I | 0 | 0 | 0 | 1/2 | 1/2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| They | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| like | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| want | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| to | 0 | 0 | 0 | 0 | 0 | 0 | 1/3 | 2/3 | 0 | 0 | 0 | 0 | 0 |
| cook | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| eat | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1/2 | 1/2 | 0 | 0 |
| Chinese | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 |
| dinner | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
| Indian | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 |
| food | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |

From here we can use these probabilites to chain into sentences. 

--- 

### Generation 

Once approach to sentence generation is to use the shannon-visualations to analyse possible sentences. The flow starts with the opening tag and then given this start looks and what is possible to come next give the edvidence in the corpus and the associated probabilities. From this distribution, you select a word, usually the one with the highest probabilities. You repeat this process and this is how you generate new sentences. 

---
### Approximating Shakespeare

We can generate sentence based on a corpus using the probabilies computed by different n-grams:

| gram | text | 
| :--- | :--- |
| 1 | To him swallowed confess hear both. Which. Of save on train for are ay device and rote life have
| 2 | What means, sir. I confess she? then all sorts, he is trim, captain."
| 3 | This shall forbid it should be branded, if renown made it empty."
| 4 | King Henry. What! I will go seek the traitor Gloucester. Exeunt some of the watch. A great banquet serv’d in; - It cannot be but so.

Has the n-grams increase it starts to increasing sounds like Shakespear. However, there is a problem. The reason it seems like this is because it is Shakespear. There is no generalisation, the 4-gram begins to pick up and reproduce chains of sentences as they exist in the text. This is because as the n-gram context window increase, the instances of the exact 3 chained example become increasly limited and often only include the one instnce that a particle set of words was used in. 

Shakespeare used $884,647$ tokens from a total vocabulary of $29,066$. With this vocabulary size, there is 840 million possible bigrams but only 300k approx actually occured in the corpus. This means 99.96% of bigrams did not occur. 

The way we are constructing the model and using it to generate sentences means that only the bigrams that occured in the traning data can be generated.

---

### Overfitting

N-grams only work well for word prediction if the test corpus looks like the training copurus. Note that, in the context of n-grams, the test corpus is just the present, i.e. what is being generated. The idea is to see if the probabilities learned during training actually apply to new, real-world sentences. We want to see if the model can accurately predict the next word in the test set based on what it learned in the training set. 

If the test corpus contains a word sequence that never appeared in the training corpus (e.g., training had "bright sun" but test has "bright neon"), the N-gram model will mathematically assign it a probability of zero. Without advanced "smoothing" techniques, the model effectively breaks because it assumes that sequence is impossible. In almost all applications this will be the case as language is sparse. This is all an issue because models need to be robust and hold the ability to generalise on unseen data. For language, one of the main symptoms to fix is avoid 0 counts and probabilties for data not seen in the training set.

Any n-gram with a 0 count in the training set means that we assign a 0 probability to it in the test set, if it comes up. A 0 probability means that we cannot calculate perplexity. We need to somehow assign a probabiltiy mass to unseen instances. 

---

### Smoothing Intuition

When we have sparse statistics, we can steal probabiltiy mass from observed events to generalise to unobserved events. This can be described as smoothing the counts because we are lowering the peaks and increasing (or just populating) the troughs.

---

### Add-One Estimation (Laplace Smoothing)

The intuition here is to pretend we saw each word one more time than we did. We just add on one to each count. It can be useful for some applications where the number of zeros isn't so huge. But for n-grams and language models, it is barely used. Assigning too much mass to unseen co-occurances leads to massive unwiedly models. The model becomes too large and complex. Recall that shakepear has 840 mill bigrams but only 300k used. Adding mass to nearly 839 million biagrams is too extreme.  

---

### Unknown Words (Token)

This the approach for language models. We need to account for words that appear in the test set but not the training set - and also those that appear in the train but not the test. First, we can focus on the words in the training set that we beleive are least likely to be in the test set. These will be the lowest frequency words. Here, we can just freeze/fix to vocabulary and only take the `n` top words (based on some criterea, i.e. volumne or just top `n`). For the rest of the entries, we create the `<unk>` token. We treat this token as the marker for out of vocab words. We can count it and use the counts to assign a probability to OOV words. If something is not in the vocab then it is assigned to `<unk>`. 

---

### Unseen Bigrams

The `<unk>` token allows us to estimate the probability of seeing an OOV in the test set. But it can also allow us to estimate the probability of seeing bi-grams which includes an `<unk>` token. But it does not help us in estimating the probability of two in-vocab words which have note been seen together.

---

### Absolute Discounting

Subtract a little from each bigram count in order to save probabiltiy mass for unseen events. Church and Gale (1991) did an experiement where they took a newswire corpus of 22 million words which they split into train and test sets. They looked as each bigram count in the trianing set and compared it to its average bi-gram count in the test set. They notice a relationship where the count in the test corpus is 0.75 lower in the test set.

---

### Absolute Discounting Interpolation

What is did it take `d` from each bigram count. `d` is a param that can be set but often 0.75 is used. Each time we discount a bigram $c(w_2|w_1)$, we add that discount to a dummy token lamda $Lc(L|w_1)$. We convert this count into a probabiltiy distribution as before, calculaing probabiltiy estimates for bigrams. 

How do we then use these outputs? When we want to estimate a new word, we lookup the observed discounted probability of a word given the previous $P_d(w_2|w_1)$ and add the lamda given the previous word $P_d(L|w_1)$ 

$$P_e(w_2|w_1) = P_d(w_2|w_1) + P_d(\lambda|w_1) \times P(w_2)$$

The intituion of this formula can be described as: "Start with the specific evidence we have for this pair ($w_1, w_2$). If that evidence is weak or zero, add a 'safety net' based on how common $w_2$ is in general."

The main reason we use the original formula is to handle the case where the bigram count is zero. If $P_d(w_2|w_1) = 0$, the formula simplifies to $P_d(\lambda|w_1) \times P(w_2)$. You still get a positive number.

---

<br>
<br>
<br>
<br>


## Week 2 - Seminar

### 2.1 Questions

The best language model is one that best predicts an unseen test set, i.e. returns the highest $P(sentences)$. Perplexity is the inverse probability of the test set, normalised by the number of words:

This is the standard definition of Perplexity ($PP$) for a sequence of words $W$:

$$PP(W) = P(w_1, w_2, w_3, ..., w_N)^{-1/N}$$

The second is the equivalent calculation using the log-probability (which is how computers actually calculate it to avoid tiny numbers):

$$PP(W) = e^{-1/N \log P(w_1, w_2, w_3, ..., w_N)}$$

If the Training Corpus is how the model "learns," Perplexity is the "grade" it gets when it encounters the Test Corpus. Perplexity is a measure of uncertainty. A lower perplexity means the model is less "perplexed" (more confident) by the test data. A perplexity of $10$ means that every time the model predicts the next word, it is as confused as if it had to choose randomly between 10 equally likely words. 

We use the inverse ($P^{-1}$) because we want a better model (higher probability) to have a lower score. If the probability of a sentence is high, the perplexity is low.

We take the $N$-th root (or multiply by $1/N$ in the log version) so that the length of the sentence doesn't unfairly penalize the score. This allows you to compare the perplexity of a 5-word sentence against a 100-word essay.

Using $e$ and $\log$ is a mathematical "trick." Multiplying many small probabilities (like $0.0001 \times 0.002...$) results in numbers so small that computers can't handle them (underflow). Adding logs is computationally "safer" and yields the same result.

## 2.2 Questions 

### Explain how a bigram language model can be used to generate possible sequences of tokens.

A bigram language model generates text by treating word prediction like a chain reaction. Because a bigram only "looks back" at the single previous token, it uses the probability $P(w_n | w_{n-1})$ to decide what comes next.

The Shannon-Visualisation method says to start with a random bigram. You then choose the next bigram based on this probability using the most recent token. If there are a range of possible tokens which follow the current token, then sample from this distribution, usually taking the highest token. Continue in a iterative loop until you hit then end token. 

---

### What does OOV stand for?  How do we smooth a language model with respect to OOV tokens?

We smoothing using the `<unk>` token to handle OOV tokens. We only return the top `n` common words and turn less commmon tokens into the `<unk>` token. Add one smoothing is not good for language models as the number of parameters to populate is too vast. 

Why throw away information? rare information means that we don't know much about it, at least interms of freq/probabiltiy setting. By modelling the `<unk>` token, we gather a better understanding of how rare words work in language, even if we loose the specifics. We can indentify the words that preceed or suceed rare words and identify the structure of sentence with rare word usage. 

---

### Name 2 different methods for smoothing the probabilities of combinations of tokens.  Explain one of them.

* Absolute discounting
* Stupid Backoff

Used for web scale lang models; If a higher-order n-gram has a zero count then simply "back-off", i.e. if 4 gram has 0 but the 3-gram as a count, then used that take prob scaled by a fixed param, i.e. 0.4 (lamdba sign).

$$S(w_i|w_{i-k+1}^{i-1}) = \begin{cases}
\frac{\text{count}(w_{i-k+1}^i)}{\text{count}(w_{i-k+1}^{i-1})} & \text{if count}(w_{i-k+1}^i) > 0 \
\lambda S(w_i|w_{i-k+2}^{i-1}) & \text{otherwise}
\end{cases}$$

---

<br>
<br>
<br>

## Paper: The Microsoft Research Sentence Completion Challenge (Zweig and Burges, 2011)


### How was the dataset created? How and why were the incorrect answers selected in the way they were?

* Step 1: seed sents;
* Step 2: generate alternatives, 30, using a n-gram model, remove extreme (obvious) sentence to retain hard questions
* Step 3: human grooming, prune 30 down to 4 alts, prune with respect to rules

---

### How does simple 4-gram model work?

Paper talks about simple vs smooth 4-gram. 
* simple model; look at bi, tri and quad gram and assign points with word existed in either types; scoring approach in n-gram matches,
* smooth model; prob of word give previous words; actual implementation, calculating product of probs; good turing smoothing method used.

---

### Explain the method based on latent semantic analysis similarity.  Why do you think this does better than the n-gram methods?

This is similar distributional sematic methods. The construction of the vectors builds a cooccurance vector for each word in the sentence. The target word has context with all over words in the sentence. 

---

<br>
<br>
<br>

# Week 2 - Addtional Readings

* Jurafsky and Martin Chapter 3 [N-gram Language Models]

---

<br>
<br>
<br>
<br>
<br>


# [Week 3 - Neural Language Models](https://canvas.sussex.ac.uk/courses/36171/pages/week-slash-topic-3-neural-networks-and-neural-language-models)

* Feed Forward Networks
* Recurrent (RNN)
* Long-Short Term Memory (LSTM)
* Convolutional (CNN)
* Word-based vs Character Based

#### Week 3: Contents

1. [Lecture](#week-4-lecture)
2. [Seminar](#week-3-seminar)
2. [Paper](#week-3-paper-discussion)
4. [Additional Readings](#week-4-additional-reading)

## Week 3: Lecture

* [Part 1 - Neural Networks](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=d1dda4d7-c0c6-4018-b756-b3e500fb35fb)
* [Part 2 - RNN/LSTM/GRU](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=9cae7217-e9c9-4e3f-894b-b3e800b7d5cc&start=0)
* [Part 3 - CNNs](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=06ed8e74-ae66-4085-8d4d-b3e800be5350&start=0)

---

# Part 1 - Neural Networks

While traditional n-gram models rely on discrete counts and the Markov assumption, Neural Language Models (NLMs) represent words in a continuous, high-dimensional vector space. At a high level, the architecture focuses on transforming input tokens into dense embeddings, which are then processed through hidden layers to capture non-linear relationships. By using a Feed-Forward structure, the network learns to predict the next token by projecting the context into a "hidden" space, effectively bypassing the data sparsity issues that plague n-grams. In this module, the focus remains on how these architectures—specifically the Softmax output and Cross-Entropy Loss—allow the model to assign probabilities to sequences in a way that generalizes to unseen data.

---

## Neural Unit

The fundamental building block of the network is the neuron (or unit). It performs two distinct operations: a linear transformation followed by a non-linear activation. 

The unit first calculates the weighted sum ($z$) of its inputs. This is represented mathematically as the dot product of the input vector and the weight vector, plus a bias term:

$$z = \mathbf{w} \cdot \mathbf{x} + b$$

The output ($y$) is produced by passing the sum $z$ through a non-linear activation function ($g$ or $\sigma$):

$$y = g(z)$$

This output then serves as the input for the next layer in the network. Without this non-linear step, the entire neural network would collapse into a simple linear regression model, regardless of how many layers are added.

---

## Feedforward Network 

In a Feed-Forward Network (FFN), information flows in one direction: from the input layer, through one or more hidden layers, to the output layer. There are no cycles or loops in this architecture, distinguishing it from the Recurrent Neural Networks (RNNs) we see later in the module.

* Input Layer: Represents the raw data (e.g., word embeddings).
* Hidden Layers: Where the "learning" happens. These layers extract increasingly abstract features from the input.
* Output Layer: Produces the final prediction (e.g., the probability of the next word).
* Fully Connected (Dense): In a standard FFN, every unit in layer $i$ is connected to every unit in layer $i+1$. Each connection has its own weight.

Each hidden layer $h$ can be represented as a vector calculation. If $\mathbf{x}$ is our input, the first hidden layer is:
$$\mathbf{h} = g(\mathbf{W}\mathbf{x} + \mathbf{b})$$

For Language Modelling, the output layer typically has a size equal to the entire Vocabulary ($V$). To turn the raw output values (logits) into probabilities that sum to 1, we use the Softmax function:
$$\sigma(\mathbf{z})_i = \frac{e^{z_i}}{\sum_{j=1}^{|V|} e^{z_j}}$$

This allows us to interpret the output as $P(w_t \mid \text{context})$, where the index with the highest probability is our predicted word.

---

## Training Neural Networks

Training is the process of adjusting the network's weights and biases so that its predictions match the "ground truth" labels in the training data. In NLP, this usually means predicting the actual next word in a sentence.

To improve, the network needs a mathematical measure of how "wrong" its current predictions are. This is the Loss Function ($J$).

For language modelling, we use Cross-Entropy Loss (often referred to as Negative Log-Likelihood). If the model predicts a probability $P(w)$ for the correct word, the loss for that single instance is:

$$L = -\log P(w)$$

* If the model is confident and correct ($P \approx 1$), the loss is near 0.
* If the model is wrong or uncertain ($P \approx 0$), the loss becomes very large.
* The goal of training is to minimize the average loss across the entire training corpus.

Once we have the loss, we use Gradient Descent to update the parameters. This happens in three repeating steps:
1. Forward Pass: Compute the prediction and the resulting loss.
2. Backward Pass (Backpropagation): Use the chain rule from calculus to calculate the gradient—the partial derivative of the loss with respect to every weight in the network ($\frac{\partial J}{\partial W}$). This tells us which direction to "nudge" the weights to decrease the loss.
3. Update: Adjust the weights in the opposite direction of the gradient, scaled by a Learning Rate ($\alpha$): $W = W - \alpha \frac{\partial J}{\partial W}$

In practice, we don't update the weights after every single word (Stochastic Gradient Descent) because it's noisy and slow. Instead, we use Mini-batch Gradient Descent, where we calculate the average loss for a small group of sentences (e.g., 32 or 64) and perform one update step.

---

## Feed-Forward Neural Language Model (Bengio et al., 2003)

This model treats language modeling as a supervised learning task: predicting the next word $w_t$ given a fixed-length history of $n-1$ words.

#### Architecture & Process
1. **Input:** A sequence of words (e.g., a 3-word window: $w_{t-3}, w_{t-2}, w_{t-1}$).
2. **Projection Layer (Embeddings):** Each word is initially a high-dimensional "one-hot" vector. The model multiplies these by a shared weight matrix $C$ to produce a dense, lower-dimensional embedding vector.
3. **Concatenation:** These embedding vectors are concatenated into a single large input vector for the hidden layer.
4. **Hidden Layer:** A standard fully connected layer with a non-linear activation (usually tanh). This layer learns the "contextual interactions" between the input words.
5. **Output Layer (Softmax):** The final layer has a size equal to the vocabulary ($|V|$). It outputs a probability distribution over all possible next words.

$$P(w_t | w_{t-1}, \dots, w_{t-n+1})$$

#### Advantages vs. Disadvantages

| Feature, | Neural Language Model (NLM) | n-gram Models | 
| :--- | :--- | :--- | 
| Generalization | High. Similar words (e.g., "dog" and "cat") have similar embeddings, so the model knows they appear in similar contexts. | Low. Treats words as atomic units; "dog" and "cat" are as different as "dog" and "refrigerator." | 
| Smoothing | Not needed. The model maps words into a continuous space; there are no "zero counts", only lower probabilities. | Essential. Required to handle unseen word combinations (Laplace, Kneser-Ney). |
| Context | Can handle slightly longer histories than n-grams (though still fixed). | Becomes exponentially sparse as n increases. |
| Training Speed | Slow. Backpropagation and softmax over a huge vocabulary are computationally expensive. | Fast. Simple counting and division. | 

The "Hypothesis Space" Intuition: Unlike n-grams, which look for exact matches, the NLM moves into a "feature space." If the model has seen "The cat sat on the...", it can predict "mat" for "The dog sat on the..." because it recognizes that "cat" and "dog" occupy similar positions in the embedding space.

#### The Limitations of the Bengio Model

The primary limitation is the Fixed Window. Even though it's better than an n-gram, it still uses a "Markov-style" assumption where it only looks at the previous $n$ words. It cannot "remember" a subject introduced at the beginning of a long paragraph. In a Feed-Forward network, the input layer size is hard-coded into the weight matrix. You could just make the inital input size very large but as you increase the window size, the number of weights in the first hidden layer explodes. Also, the most subtle but critical issue is that with a concatenated vector, the model treats "Position 1" and "Position 2" as completely different sets of weights. The model may learn structurally that "The" is a common word at $w_t-1$ but it needs to learn this again for all positions. 

---

<br>
<br>


# Part 2 - RNN/LSTM/GRU

## Simple Recurrent Network

While Feed-Forward Neural Networks (FFNNs) offer a significant leap over n-grams through dense embeddings and better generalization, they are fundamentally limited by a fixed-length context window. In natural language, dependencies often span far beyond the previous three or four words. To address this, we transition to Recurrent Neural Networks (RNNs). Unlike FFNNs, which process an entire window of text as a single static input, RNNs process language sequentially. By maintaining an internal "hidden state" that is updated at every time step, these models create a persistent memory of the past, allowing them to handle variable-length inputs and potentially capture long-range dependencies that a fixed window would simply miss.

Key Shifts: 
* From Fixed to Variable: Moving away from hard-coded window sizes to architectures that can process any number of tokens.
* From Concatenation to Recurrence: Instead of stacking word vectors side-by-side, we feed the output of the previous step back into the network alongside the current word.
* The Vanishing Gradient Problem: Identifying why "Vanilla" RNNs struggle with long-term memory and how LSTMs and GRUs use specialized "gates" to protect and maintain information over time.

## Recurrent Neural Networks (RNN)

An RNN is essentially a Feed-Forward network that "loops." At each time step $t$, the network takes two inputs: the current word $x_t$ and its own previous hidden state $h_{t-1}$.

#### Advantages

* Sequential Memory: The hidden layer acts as a "summary" or "bottleneck" of the previous context.
* Variable Length: Unlike the Bengio model, the same weights ($U, V, W$) are used regardless of sentence length.
* Parameter Sharing: The model learns the meaning of a word once, and that knowledge is applied no matter where the word appears in the sequence.

#### Disadvantages

* The Vanishing Gradient Problem: During backpropagation, the gradient is multiplied by the weight matrix repeatedly. If weights are small, the gradient shrinks to zero, meaning the model "forgets" the start of long sentences.
* While it can theoretically remember everything, in practice, $h_t$ is heavily biased toward the most recent words.

---

## RNN Language Model (Mikolov et al., 2013)

Mikolov’s implementation formalized how RNNs could be used for large-scale language modelling. The "memory" is stored in the hidden layer, which serves as a distributed representation of the history.

To compute the state of an RNN at any time step $t$, we use the following formulas:

#### 1. The Hidden Layer ($h_t$)
The hidden state is a concatenation of the current input and the previous context, passed through a non-linear activation (usually $tanh$ or $sigmoid$):
$$h_t = \sigma(W x_t + U h_{t-1} + b)$$
* $W$: Weights for the input-to-hidden connections.
* $U$: Weights for the hidden-to-hidden (recurrent) connections.
* $b$: Bias vector.

#### 2. The Output Layer ($y_t$)
The raw output (logits) is calculated from the current hidden state:
$$a_t = V h_t + c$$
* $V$: Weights for the hidden-to-output connections.
* $c$: Output bias.

#### 3. The Probability Distribution ($\hat{y}_t$)
Finally, we apply Softmax to get the probability of every word in the vocabulary:
$$\hat{y}_t = \text{softmax}(a_t)$$

#### 4. Distributed Representations in RNNs
One of the coolest things about the Mikolov model is that the matrix $W$ (the input weights) essentially becomes a lookup table for word embeddings. As the model learns to predict the next word, it naturally groups similar words together in the vector space because they lead to similar hidden states.

---

## Long Short-Term Memory (LSTM)

The core innovation of the LSTM is the Cell State ($C_t$), which acts as a "long-term memory" conveyor belt running through the top of the units. While the standard RNN squashes all information through a single $tanh$ layer, the LSTM uses gates to surgically add or remove information from the cell state.

Every LSTM unit at time $t$ considers:
* $x_t$: The current input (the current word embedding).
* $h_{t-1}$: The short-term memory (hidden state from the previous step).
* $C_{t-1}$: The long-term memory (cell state from the previous step).

#### The Gating Mechanism
Each gate uses a Sigmoid ($\sigma$) activation function. Because sigmoid outputs are between 0 and 1, they act as "valves":
* 0: Close the gate (forget/block everything).
* 1: Open the gate (keep/pass everything).

#### The Forget Gate ($f_t$)
It looks at $x_t$ and $h_{t-1}$ and decides which bits of the long-term memory ($C_{t-1}$) are no longer relevant.
* Formula: $f_t = \sigma(W_f \cdot [h_{t-1}, x_t] + b_f)$
* Example: If the sentence subject changes from singular to plural, the forget gate might "erase" the singular verb constraint.

#### The Input Gate ($i_t$) & Candidate State ($\tilde{C}_t$)
This gate decides what new information to store in the cell state.
1. The Input Gate ($\sigma$) decides which values to update.
2. The Candidate State ($tanh$) creates a vector of new potential values to add to the state.
3. The Update: These are multiplied and then added to the cell state.
    * Crucial Point: Because we add rather than multiply, the gradient can flow back through time much more easily, solving the vanishing gradient problem.

#### The Output Gate ($o_t$)

This gate decides what the next Hidden State ($h_t$) should be. It takes the current cell state, runs it through a $tanh$ (to keep values between -1 and 1), and multiplies it by the output gate’s sigmoid filter.

The result $h_t$ is used for the current prediction and passed to the next cell as short-term memory.

---

## Stacked RNNs (Deep RNNs)

In a Stacked RNN, the output (hidden state $h_t$) of one RNN layer is not used to predict a word immediately; instead, it becomes the input for the next RNN layer above it.

#### Why Stack?
* Hierarchical Abstraction: Just as CNNs learn edges before shapes, stacked RNNs learn different levels of linguistic abstraction.
    * Lower layers tend to capture lower-level syntax (parts of speech, local morphology).
    * Higher layers tend to capture more abstract semantic concepts and long-range structure.
* Increased Capacity: Stacking allows the model to learn more complex functions. Most modern systems use at least 2 to 4 layers.

--- 

## Bidirectional RNNs (Bi-RNN)

A standard RNN is "causal"—it only knows about the past. However, for many NLP tasks (like Part-of-Speech tagging or Named Entity Recognition), the future context is just as important as the past.

Example: In the sentence "The bank was flooded," you don't know if "bank" is a financial institution or a river bank until you see the word "flooded."

A Bidirectional RNN consists of two independent hidden layers:
* Forward Pass: Processes the sequence from left to right ($w_1, w_2, \dots, w_n$).
* Backward Pass: Processes the sequence from right to left ($w_n, w_{n-1}, \dots, w_1$).

At each time step $t$, the hidden states from both directions are concatenated (joined together) to form the final representation:
$$h_t = [h_t^{\text{forward}} ; h_t^{\text{backward}}]$$

Constraint: You cannot use a Bidirectional RNN for generative language modeling (predicting the next word) because the "backward" pass would effectively "cheat" by seeing the word you are trying to predict. They are best for tasks where the entire sentence is available at once.

---

<br>
<br>

# Part 3 - CNNs

In previous sections, we treated words as the "atomic" units of language. However, this creates a massive problem for Out-of-Vocabulary (OOV) words or rare morphological variants (e.g., "unapologetically"). If the model hasn't seen that specific word enough times in training, its embedding will be poor.

Convolutional Neural Networks (CNNs) offer a solution by shifting the focus from words to characters. By using CNNs to "scan" the characters within a word, the model can learn to recognize sub-word patterns like prefixes, suffixes, and stems, allowing it to build a meaningful representation for words it has never seen before.

---

## Convolutions in NLP
Originally designed for computer vision to detect edges and shapes, CNNs in NLP are used to detect local features in a sequence.

#### How it Works
* Filters (Kernels): A filter is a small matrix of weights that slides over the input. In NLP, the input is usually a matrix of character embeddings.
* Width of the Filter: Instead of a 2D square (like in images), NLP filters usually have a fixed width equal to the embedding dimension and a variable height (e.g., 2, 3, or 4 characters).
* A height of 3 is effectively looking for character n-grams (trigrams).
* Feature Maps: As the filter slides down the word, it performs a mathematical operation (dot product) to produce a "feature map"—a list of scores showing where a specific pattern (like "-ing") was detected.

#### Max Pooling
After the convolution, we are left with many scores. We usually only care if a feature was present, not necessarily where it was. Max-over-time pooling takes the single highest value from the feature map. This makes the model position-invariant—it recognizes the "ing" feature regardless of whether it's in the middle or end of the string.

#### Stacking Convolutional Layers

In a CNN, stacking means feeding the output of one convolutional layer as the input to a second (or third) convolutional layer.

Think of it as a hierarchy of understanding: instead of just looking at the raw characters, the model starts looking at the "features of features."

---

## Kernel Functions 

In Natural Language Processing, Kernels (also called Filters) are the actual "detectors" within the convolutional layer. They are the matrices of weights that the network learns during training to identify specific patterns in the character or word sequences.

A kernel is a small window of weights. In a character-level CNN, the kernel usually has a width that matches the size of the character embeddings and a height that defines the "window size" (the number of characters it looks at simultaneously).
* Height 2: Looks for bigrams (e.g., "th", "re", "ed").
* Height 3: Looks for trigrams (e.g., "ing", "pre", "ion").
* Height 5+: Looks for longer root words or complex morphemes.

As the kernel slides over the input matrix, it performs a pointwise multiplication between its own weights and the input values, then sums them up to produce a single value.

$$z = \sum (Weights \times Inputs) + bias$$

If the characters in the current window match the pattern the kernel has "learned" to look for, the resulting score will be high. If they don't match, the score will be low or negative.

Unlike traditional NLP, where we might manually define "suffixes" or "prefixes," a CNN learns these kernels through backpropagation:
1. Initialization: At the start of training, kernels are filled with random numbers (noise).
2. Feedback: If the model fails to predict a word because it didn't recognize a plural "-s", the loss function sends a signal back.
3. Optimization: The weights inside the kernels are adjusted so that, next time, they "fire" more strongly when they see that specific character pattern.

A single kernel can only detect one specific type of feature. In practical applications like the Kim et al. (2016) paper, the model uses hundreds or even thousands of kernels of varying heights. This allows the model to simultaneously detect a vast array of linguistic features, from simple plurals to complex semantic markers.

## Advantages of Character-Aware Neural Language Models

Character-aware models (like the CNN-LSTM architecture) provide a powerful middle ground between purely word-based models and character-only models. By looking "inside" the word, the model gains several key advantages:

#### Sub-word Morphological Awareness:

Traditional models treat "run" and "running" as completely unrelated tokens. A character-aware model, however, recognizes the shared "run" stem.

Suffixes/Prefixes: The model learns that "-ing" often denotes a present participle or that "un-" denotes negation.

Syntactic Clues: Even if the model doesn't know the root of a word, seeing an "-ly" ending allows it to predict that the word is an adverb, which helps constrain the possible grammatical structure of the sentence.

#### Superior Handling of Sparse and OOV Data
Sparsity is the "enemy" of NLP. Character-level features act as a safety net:
* Low-Frequency Words: If a word appears only twice in a 1-million-word corpus, a word-level model cannot learn a good embedding for it. A character-aware model uses its knowledge of the word's components (derived from more frequent words) to build a reliable representation.
* Out-of-Vocabulary (OOV): When the model hits a word it has never seen before, it doesn't just return a generic <UNK> token. It "reads" the characters and builds a vector on the fly based on the morphemes it recognizes.

#### Robustness to Noise
Human language is messy, especially on the web.
* Misspellings: If a user writes "definitly" instead of "definitely," a word-level model fails. A character-CNN will see that 90% of the characters match the pattern for "definitely" and can still produce a nearly identical vector.
* Slang & Variations: It can handle creative emphasis (e.g., "yesssssss") by recognizing the core "yes" feature within the string.

#### Parameter Efficiency
In a standard NLM, the input embedding matrix grows linearly with the vocabulary size ($|V| \times \text{dimension}$). For a 100k word vocabulary, this is massive.
* In a character-aware model, you only store embeddings for a small set of characters (usually ~100–250).
* The "knowledge" of words is stored in the CNN kernels, which are much smaller than a massive word-lookup table.

---

<br>
<br>
<br>
<br>
<br>
<br>


## Week 3: Seminar

### Part 1 Questions

#### 1. In ML, is a loss function the same as an objective function?

As loss function is a type of objecive function. You minimise a loss function. But you could use a reward function which you wish to maximise. Often used interchangably. 

---

#### 2. Explain how a bigram model of language could be built with a feed-forward neural network?

A network with 2 inputs, the current word and the previous. Each word one hot encoded.

---

#### 3. What is the difference between a one-hot encoding of a word and a word embedding?

One-hot encoding: A sparse, high-dimensional vector (size of vocabulary) where only one index is 1 and the rest are 0. It treats words as atomic units with no mathematical relationship (the distance between any two words is identical).

Word embedding: A dense, low-dimensional vector (e.g., 300 dimensions). It captures semantic similarity; words used in similar contexts are placed closer together in the vector space.

---

#### 4. What will a neural language model typically do with OOV words?

Most word-level NLMs map all Out-of-Vocabulary words to a special <UNK> token. During training, the model learns an embedding for <UNK> by replacing rare words in the training set with it. At test time, any unknown word is treated as this generic token. Character-aware models (like Kim et al.) avoid this by building the representation from characters instead.

---

#### 5. If a combination of words is seen at test time which has not  been seen before, what will happen?

Unlike n-gram models, which would return a zero probability (and infinite perplexity) without smoothing, a Neural LM will still calculate a non-zero probability. This is because the model operates on the similarity of embeddings. If it has seen "eat a burger" and "eat a sandwich," and it encounters the unseen "eat a taco," it uses the fact that "taco" is semantically similar to "burger/sandwich" to make a reasonable prediction.

---

### Part 2 Questions

#### 1. What is an RNN and what advantage(s) does it have over a FF-NN (particularly when applied to language modelling)?

An RNN is a network where the hidden state is fed back into itself at the next time step.
* Advantage 1: It can process variable-length inputs.
* Advantage 2: It maintains a recurrent memory of the entire prior context rather than being limited to a fixed-size window.

---

#### 2. What is an LSTM?

A Long Short-Term Memory network is a specialized RNN designed to solve the vanishing gradient problem. it uses a "cell state" and three gates (forget, input, output) to regulate the flow of information, allowing it to remember dependencies over much longer sequences than a standard RNN.

---

#### 3. How might 2 RNNs be used in the same network?

Stacked RNNs: One RNN layer sits on top of another; the hidden states of the first act as inputs for the second to learn hierarchical features.

Bidirectional RNNs: Two separate RNNs process the text (one forward, one backward), and their hidden states are concatenated to capture both left and right context.

---

#### 4. What is a CNN?

A Convolutional Neural Network uses sliding "filters" (kernels) to extract local features from an input (like character n-grams within a word). In NLP, it is often paired with max-pooling to identify the most important features regardless of their position.

---

#### 5. Why might it  be useful to have character based language models rather than word based language models?

Morphological Awareness: They learn sub-word patterns (prefixes/suffixes).

No OOV Problem: They can represent any word as long as it's made of known characters.

Efficiency: They require a much smaller input vocabulary (e.g., 256 characters vs. 100k+ words).

---

# Week 3: Paper Discussion

#### Character aware neural language models (Kim et al. 2016)

The paper "Character-Aware Neural Language Models" (Kim et al., 2016) presents a shift in architecture by moving away from traditional word-level embeddings. Instead, it utilizes a CNN to extract features directly from characters, which are then passed through a Highway Network and into an LSTM for sequence modeling. The primary contribution of the paper is proving that a model can achieve state-of-the-art performance with 60% fewer parameters than word-level models while effectively solving the Out-of-Vocabulary (OOV) problem. It is particularly effective for morphologically rich languages (like Arabic or Russian) because the character-level CNN naturally captures sub-word structures like prefixes and suffixes that word-level models simply treat as distinct, unrelated tokens.

The Pipeline: Characters $\rightarrow$ Convolutional Layer $\rightarrow$ Max-over-time Pooling $\rightarrow$ Highway Network $\rightarrow$ LSTM.

In the context of the Kim et al. (2016) paper, a Highway Network is a specialized type of neural layer that sits between the CNN (which extracts character features) and the LSTM (which handles the sequence). Inspired by LSTMs, Highway Networks use gating mechanisms to control the flow of information. In deep networks, as you add more layers, it becomes harder for the "raw" signal from the input to reach the deeper parts of the model (and harder for gradients to flow back during training). In the character-aware model, the CNN output might be quite "noisy." The Highway Network helps refine this output before it reaches the LSTM.

--- 

#### 1. What problem with using n-gram models is addressed by the use of neural language models? Why is it not completely addressed? How might character-aware models help?

The problem with n-gram models is Sparsity and assigning 0 probability to unseen sequences. Neural language models solve this by generalizing via word embeddings. Similar words share similar context meaning an unknown words meaning can be infer through the context of the sentence in the latent space.  

Basic NN's are not a complete solution because Rare and OOV words still have poor or no embeddings. The following solution to this is character-aware models. They build representations from sub-word units, allowing the model to "guess" meanings of unknown words based on their structure.

---

#### 2. Why are LSTMs generally preferred over vanilla RNNs in language modelling?

Vanilla RNNs suffer from vanishing gradients, making them "forget" long-term dependencies. LSTMs use gates to protect the cell state, allowing them to capture dependencies over much longer distances.

---

#### 3. In a character-level CNN, what is the purpose of a filter or kernel? How many filters do they state are typically used in NLP applications? How many do the authors use in each of their small and large architectures?

* Purpose: To detect character n-grams (features) like "-ing" or "pre-".
* NLP Typical: Hundreds or thousands.
* Authors' use: 1,100 filters in the small model; 5,250 in the large model (using widths 1–7).

In the Kim et al. (2016) architecture—and most character-level CNNs used for word representations—the filters are not stacked on top of each other. Instead, they run in parallel. Think of it as a "wide" architecture rather than a "deep" one.

When the authors say they use 1,100 filters, they mean that 1,100 different "detectors" are all looking at the same raw input (the character embeddings of the word) at the same time.

1. Multiple Sizes: They use filters of different heights (widths 1 through 7).
    * Width 1 filters look at single characters.
    * Width 3 filters look at trigrams (like "ing").
    * Width 7 filters look at long sequences (like "ness-ly").
2. Multiple Features: For each size (e.g., width 3), they don't just have one filter; they have hundreds. One might learn to look for "ing", another for "pre", another for "the", and so on.

Since they aren't stacked, how does the model use all 1,100 outputs? Each filter slides over the word and produces a feature map. Max-pooling is applied to every single feature map, extracting one "best" score from each filter. All 1,100 "best" scores are concatenated (joined end-to-end) to form one single, long vector. 

This long vector is what represents the word. It is then passed through the Highway Layer and finally into the LSTM.

In Computer Vision, we stack layers because a "nose" is made of "lines," and a "face" is made of "noses." In character-level NLP, words are usually too short for that kind of deep hierarchy to be useful. It is much more effective to have many different-sized "specialists" (parallel filters) looking for various sub-word patterns simultaneously.

---

#### 4. How is the character-level CNN incorporated into the overall architecture of the RNN-LM?

The CNN replaces the standard word-lookup table. The CNN processes characters $\rightarrow$ max-pools into a fixed vector $\rightarrow$ passes through a Highway Network $\rightarrow$ this vector is used as the input $x_t$ for the LSTM at each time step.

---

#### 5. How are OOV words handled in these experiments? What potential improvement could the authors have made and why didn’t they do it?

the CNN builds a vector based on the word's characters. 

They still used a word-level Softmax at the output. A character-level output (predicting the next word character-by-character) would have completely removed the fixed vocabulary limit, but it is computationally much harder.

---

#### 6. Which model(s) performs best in the optimization experiments on the Penn Treebank?

The LSTM-Char (their model) outperformed word-level LSTMs and was comparable to models with far more parameters. It specifically achieved the best results when the parameter count was kept small.

---

#### 7. Why do the authors expect the performance gains to be more in other languages such as Arabic than in English? Are their expectations met in the experimental results?

Arabic is morphologically rich (many prefixes/suffixes/internal changes). English is relatively simple.

Yes. The performance gains on morphologically rich languages (Arabic, Czech, Russian) were much larger than the gains on English.

---

#### 8. What advantages does the authors’ model have over the MLBL model of Botha and Blunsom (2014)?

The MLBL model required explicit morphological preprocessing (breaking words into morphemes first). The Kim et al. model is end-to-end; it learns to identify these features automatically from raw characters without an external linguist tool.

---

#### 9. What observations can you make of the nearest neighbours of ‘richard’ using each of the word representations?

Word-level: Finds semantic neighbors (other names like 'edward').

Char-level: Finds orthographic neighbors (words that look the same, e.g., 'richards', 'richardson').

Kim et al. Model: It successfully combines both, finding names that are both semantically and structurally similar.

---

#### 10. What are the main conclusions of the paper? Are you convinced?

Conclusion: Sub-word information is sufficient for high-quality language modeling and drastically reduces parameter counts.

Critique: It’s convincing because the model excels where word-level models fail (OOV/Rich morphology), though it is slower to train due to the extra CNN steps.

---

## Week 3: Additional Reading

* [Jurafsky and Martin Chapter 6: Neural Networks](https://web.stanford.edu/~jurafsky/slp3/6.pdf)
* [Jurafsky and Martin Chapter 13: RNNs and LSTMs](https://web.stanford.edu/~jurafsky/slp3/13.pdf)


---

<br>
<br>
<br>
<br>
<br>
<br>

# [Week 4 - Lexical and Distributional Semantics 2](https://canvas.sussex.ac.uk/courses/36171/pages/week-slash-topic-4-word-embeddings)

Week 4 marks a fundamental pivot in the module. Previously, we looked at distributional semantics through the lens of sparse co-occurrence matrices—counting how often words appear near one another and using metrics like PPMI to weight them. However, as Zipf’s Law dictates, language is naturally sparse; the vast majority of words appear so infrequently that our counts are often unreliable or zero.

This week, we explore two major solutions to this "Curse of Sparsity." First, we look at Dimensionality Reduction (LSA, SVD, NMF), which attempts to compress massive, sparse matrices into dense "concept" spaces. Second, we dive into Neural Word Embeddings (Word2Vec, GloVe). Unlike traditional models that count everything first, these models predict words in a local context, learning dense, fixed-dimensional vectors that capture remarkably complex semantic and syntactic analogies through simple vector arithmetic. We conclude by looking at Compositionality: how we can combine these individual word vectors to represent the meaning of entire phrases and sentences.

#### Week 4: Contents

1. [Lecture](#week-4-lecture)
2. [Seminar](#week-4-seminar)
4. [Paper](#week-4-paper)
4. [Additional Readings](#week-4-additional-reading)

## Week 4: Lecture

* https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=353c47a5-1230-4ffa-b59c-b3ef010c79b0&start=0
* https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=75f1da88-d5ed-48f5-9451-b3ef0116d27c&start=0 

This week returns to the core principles of Lexical Semantics (word senses and hierarchical relationships) and Distributional Semantics (inferring meaning from context). While Week 1 focused on measuring similarity through vector space models and association via Pointwise Mutual Information (PMI), we now address the persistent challenge of sparsity that plagued both n-gram models and traditional count-based distributional models.

The transition from "counting" to "predicting" represents a shift from sparse, high-dimensional matrices to dense, low-dimensional Neural Word Embeddings. This evolution allows us to move beyond simple word-sense identification and bootstrap richer semantic representations that capture both similarity (paradigmatic/interchangeable words) and association (syntagmatic/co-occurring words) within a unified, optimized vector space.

---

## Challenges for Distributional Similarity Measures

1. Mixture of Senses (Polysemy); Traditional word vectors (i.e. hot one) are global—they collapse all meanings of a word into a single point in space. If a word like "bank" has two distinct senses (financial vs. river), its vector will be a mathematical "average" of both. The nearest neighbors of "bank" might include both "money" and "river," creating a blurred representation that doesn't accurately reflect either sense in a specific context.
2. Mixture of Relationships: Distributional similarity is a "blind" metric; it knows two words are related but doesn't know how. Cosine similarity cannot distinguish between different lexical relations. Synonyms: Big/Large (Interchangeable). Hyponyms: Dog/Animal (Is-a relationship). The model treats "relatedness" as a monolith, making it difficult to perform tasks that require specific logic (like entailment).
3. Data Sparsity & Zipf’s Law: This is the most significant technical challenge for traditional models. According to Zipf’s Law, most words are rare (Hapax Legomena). If a word only appears once or twice, we do not have enough "contextual evidence" to build a reliable vector.  In a sparse matrix, a value of $0$ doesn't necessarily mean two words never go together; it usually just means we haven't seen them together yet. Sparse vectors lead to unreliable similarity scores for all but the most frequent words.

PPMI is the metric used to weight the features within a Distributional Similarity model. 
1. The Framework: Distributional Similarity (the "Distributional Hypothesis" that words with similar contexts have similar meanings).
2. The Representation: A Co-occurrence Matrix, where rows are target words and columns are context words.
3. The Weighting (PPMI): Raw counts are misleading (e.g., the word "the" co-occurs with everything). Positive Pointwise Mutual Information (PPMI) is the specific measure of Association used to give high scores to "informative" context words and low scores to uninformative ones.
4. The Comparison (Cosine Similarity): Once you have the PPMI-weighted vectors, you use Cosine Similarity to measure how Similar the two words are.

Raw counts are biased toward frequent words. PPMI asks: "How much more do these two words co-occur than we would expect if they were just paired at random?". PPMI is a "count-based" sparse measure.

---

## Sparsity

In Natural Language Processing, sparsity refers to the statistical "void" created by the vast number of rare words in any given corpus. Using the Google News corpus as a case study (320 million tokens across 82,000 types), a simple mathematical average suggests a mean frequency of roughly 3,900 occurrences per word. However, because language follows Zipf’s Law rather than a normal distribution, this mean is highly misleading. In reality, word frequencies do not cluster around a central average with a small standard deviation; instead, a few "power words" (like the, is, of) appear millions of times, while the vast majority of words appear only a handful of times or even just once (Hapax Legomena). This results in co-occurrence matrices that are mostly filled with zeros, making it mathematically difficult to calculate similarity for most of the vocabulary.

---

## Zipf's Law

Zipf's Law is the empirical observation that in any large corpus of natural language, the frequency of a word is inversely proportional to its rank in the frequency table. It is a specific type of Power Law distribution

If we rank all words in a corpus by their frequency ($r=1$ for the most common, $r=2$ for the second most common, etc.), the frequency ($f$) of a word is approximately:

$$f \propto \frac{1}{r}$$

This implies that the product of a word's frequency and its rank is roughly constant: $f \times r \approx C$.

Key Characteristics
* The 80/20 Rule: A very small number of words (the "heads") account for the vast majority of tokens in a text. For example, the top 100 words typically make up about 50% of any English corpus.
* The Long Tail: The majority of the "vocabulary types" (the unique words) occur very rarely.
* Hapax Legomena: These are words that appear only once in a corpus. In a typical large dataset, Hapax Legomena make up approximately 50% of the entire vocabulary.

#### Consequences for Distributional Semantics
Zipf's Law is the mathematical reason why distributional models suffer from extreme sparsity:
* Empty Vectors: For the 50% of words that appear only once, we have almost zero contextual evidence. Their 82k-dimensional co-occurrence vectors will be almost entirely zeros.
* Unreliable Statistics: We cannot distinguish if a $0$ in a PPMI matrix means two words are semantically incompatible or if we simply haven't seen them together yet because they are both in the "tail."
* The Failure of the Mean: Because word distribution is not a "Normal Distribution," the "average frequency" is a useless metric. We cannot use standard Gaussian statistics to understand word behavior.
* Note: On a log-log plot (log frequency vs. log rank), Zipf's Law appears as a straight line with a slope of approximately $-1$. If the line is straight, the data follows a Power Law.

---

## Solutions to Sparsity 

To tackle the solutions to sparsity, we need to distinguish between simply "fixing the math" (Smoothing) and "redrawing the map" (Dimensionality Reduction).

### I. Smoothing: "Filling the Gaps"

The intuition behind smoothing is to redistribute probability mass. We assume that a zero count in our data doesn't mean "impossible," but rather "unobserved due to limited data."

#### 1. Add-One (Laplace) Smoothing

We simply add 1 to every possible co-occurrence count. 

In a vocabulary of 82k, there are $82,000^2$ (approx. 6.7 billion) possible pairs. If we only observe a few million pairs, Add-One assigns a massive amount of "fake" probability mass to the billions of unseen pairs. This "washes out" the real signal, making every word look equally similar to every other word.

#### 2. Distributional Smoothing (Dagan et al., 1994)

Instead of adding a flat "+1", we use a word's neighbors to estimate its missing values.

If "aardvark" and "snort" never co-occur, but "aardvark" is very similar to "pig" (which does co-occur with "snort"), we can "borrow" some of that probability.

$$P_{smooth}(w_2 \mid w_1) = \sum_{w' \in S(w_1)} \text{sim}(w_1, w') \times P(w_2 \mid w')$$

Where $S(w_1)$ is the set of words similar to $w_1$. We take a weighted average of how $w_1$'s neighbors behave.

Why do it both ways ($w_1|w_2$ and $w_2|w_1$)? Because the relationship isn't necessarily symmetrical. "Snort" might be a very specific feature for "aardvark" and "pig," but "aardvark" is just one of many things that can "snort." We average both to get a stable estimate of their association

### II. Dimensionality Reduction: "Finding the Essence"

Rather than trying to fill a 82,000-dimensional matrix, we transform the data into a dense, lower-dimensional space (e.g., 300 dimensions). This forces the model to ignore noise and find latent (hidden) patterns.

#### 1. PCA (Principal Component Analysis)
Goal: Find the axes (Principal Components) along which the data varies the most.

Intuition: If you have a 3D cloud of data shaped like a pancake, PCA realizes that the "thickness" of the pancake is less important than its "width" and "length." It flattens the 3D data into 2D while losing as little information as possible.

#### 2. SVD (Singular Value Decomposition)
This is the engine behind Latent Semantic Analysis (LSA).It factorizes the PPMI matrix into three matrices: $X = U \Sigma V^\top$.By keeping only the top $k$ singular values, we effectively "merge" dimensions that behave similarly. If "doctor" and "physician" have almost identical co-occurrence patterns, SVD will collapse them into the same latent "medical" dimension.

#### 3. NNMF (Non-Negative Matrix Factorization)
Constraint: All values must be non-negative ($\ge 0$).

Advantage: Unlike SVD (which can have negative values that are hard to interpret), NNMF results in a "parts-based" representation. It builds a word's meaning by adding components together.

Example: "Apple" = (0.5 $\times$ Fruit) + (0.3 $\times$ Red) + (0.2 $\times$ Technology). This makes the dimensions much more interpretable for humans.

---

## Latent Semantic Analysis (LSA)

LSA (Deerwester et al., 1990) is a technique in distributional semantics that uncovers the hidden ("latent") relationships between words by analyzing which documents or contexts they appear in.

#### The Input: The Term-Context Matrix ($X$)

We start with a large matrix where rows represent unique words (types) and columns represent contexts (traditionally whole documents, but can be paragraphs or sliding windows). The cell values are usually transformed frequencies. If using documents, `tf-idf` is standard; if using local word-windows, `PPMI` is preferred.

#### The Mechanism: Singular Value Decomposition (SVD)

SVD is the mathematical engine of LSA. It decomposes the large, sparse matrix $X$ into the product of three specific matrices:
$$X \approx W \cdot S \cdot P^\top$$

* $W$ (Word/Term Matrix): Each row is a dense vector representing a word. This is our "reduced dimension" word embedding.
* $S$ (Singular Values): A diagonal matrix that acts as the "weights" for the new dimensions. The values are sorted by importance.
* $P^\top$ (Context/Document Matrix): Represents the documents in the new reduced space.

#### The "Trimming" Process (Dimensionality Reduction)
To achieve a "concept space," we don't keep all the dimensions. If our original matrix has 50,000 dimensions, we might keep only the top $k$ (e.g., 300). By ignoring the smaller singular values in $S$, we effectively remove noise.This forces the model to merge synonyms. If "physician" and "doctor" appear in similar medical documents, SVD will map them to the same latent "medical" dimensions.

As you noted, $W, S,$ and $P$ are found using Eigendecomposition. The singular values in $S$ are the square roots of the eigenvalues, and the columns of $W$ and $P$ are the eigenvectors. This is why LSA is often referred to as a "spectral" method.

#### Why LSA was a Breakthrough
* Synonymy: It solves the problem where a search for "physician" fails to find a document containing only the word "doctor."
* Global Context: Unlike Word2Vec (which looks at immediate neighbors), LSA looks at the global distribution across the entire corpus.

#### SVD and LSA

SVD is the mathematical tool, while LSA is the application of that tool to language.

SVD is a general matrix factorization algorithm used in many fields (physics, signals, geometry). It takes any rectangular matrix and breaks it into three parts. It doesn't care if the numbers represent word counts, pixels in an image, or sensor data from a telescope.

LSA is the specific pipeline used in NLP that utilizes SVD. It includes the linguistic "prep work" before and after the math.

* Step 1 (Pre-SVD): Creating the Term-Document matrix.
* Step 2 (The Weighting): Applying tf-idf or PPMI to the raw counts (SVD on raw counts usually performs poorly because "the" and "and" dominate the variance).
* Step 3 (The SVD): Running the actual matrix factorization.
* Step 4 (The Truncation): Choosing the value of $k$ (the number of dimensions to keep) to filter out "noise" and capture "concepts."
* Step 5 (Post-SVD): Using the resulting vectors for tasks like document similarity or synonym detection.

You can apply SVD to a image to compress it—that is called Image Compression, not LSA. You only call it LSA when you apply SVD to a weighted word-context matrix to find "Latent Semantics" (hidden meanings).

---

## NNMF

NMF is a variation of matrix factorization that imposes a strict constraint: all values in the decomposed matrices must be non-negative ($\ge 0$). While SVD is a "subtractive" model, NMF is a purely "additive" model.

In SVD (and LSA), dimensions are allowed to be negative. This allows for mathematical elegance (orthogonality), but it is semantically confusing. To represent the word "Apple," SVD might take a "Fruit" component and subtract a "Tropical" component. Humans don't naturally define concepts by what they aren't. A negative value in a semantic vector (e.g., $-0.4$ on a "finance" dimension) is nearly impossible for a linguist to explain.

NMF operates on the Additive Property. To reconstruct the original data, the model can only add components together—never subtract them. To represent "Apple," the model adds a bit of "Fruit," a bit of "Red," and a bit of "Crunchy." This mirrors human cognition. We see objects as a collection of "parts" or features.

#### Benefits of NMF in Distributional Semantics

Sparsity and Clarity: Because NMF is forced to use only additions, it naturally pushes many values toward zero. This creates "clean" dimensions where only a few words have high scores. If you look at an NMF dimension, you might see ball, goal, score, team—it is immediately obvious that this dimension represents "Sports."

Topic Modeling: Because the dimensions are so interpretable, NMF is frequently used for Topic Modeling. Each latent dimension acts as a "topic" that a document can be composed of.

Psychological Plausibility: The idea that we build meaning by combining positive features (rather than subtracting abstract ones) is more aligned with how humans categorize the world.

While NMF is more interpretable, it is not as mathematically unique as SVD. SVD has one "perfect" solution; NMF is solved iteratively and can result in slightly different dimensions depending on how you initialize the math.

---

## Using these methods

#### The Advantages (The "Why")
Massively reduce dimensions: You are taking a vocabulary of 82,000 (which is impossible for most computers to process efficiently in a single matrix) and squashing it down to 300. This is a 99.6% reduction in size.

Capture similarities in occurrences: Because these methods look at the entire matrix at once, they notice that "cat" and "dog" are similar because they both appear with "pet," "fur," and "food," even if "cat" and "dog" never appear in the same sentence.

#### The Disadvantages (The "Why Not")

Comp expensive to obtain the vectors: Calculating the SVD or NNMF of an $82,000 \times 82,000$ matrix is a massive task for a CPU/GPU. It requires huge amounts of RAM and time. Note: The "vectors are the more efficient part" means that once you have the 300-dim vectors, they are fast to use—but getting them in the first place is the bottleneck.

Impossible to interpret/interrogate dimensions: This is the "Black Box" problem. In a 300-dimension SVD space, you might look at Dimension 42 and ask, "What does this represent?" The answer is usually a mess of numbers. It’s not "The Sport Dimension"; it’s a mathematical slice of variance that has no human linguistic label. (NNMF tries to fix this, but it’s still not perfect).

Too Complex: These are "Global" methods. If you add one new word or one new document to your corpus, you theoretically have to re-run the entire math on the whole matrix to get updated vectors. They aren't "online" or flexible like neural networks.

---

## From One-Hot to Embeddings: The Neural Mechanism

#### 1. The One-Hot Encoding (The Input)

To feed a word into a Neural Network, we must first turn it into a vector. We use One-Hot Encoding, a vector of size $V$ (Vocabulary size) where every entry is $0$ except for the index representing that specific word, which is $1$. The problem is that one-hot vectors are huge (e.g., 82,000 dimensions) and "hollow." They contain no info about meaning. The vector for "cat" is just as different from "dog" as it is from "spaceship."

#### 2. The "Embedding Layer" (The Selection)

When you multiply a One-Hot vector by a weight matrix $W$, something special happens mathematically: you are simply selecting one row of that matrix.

$$[0, 0, 1, 0, 0] \times \begin{bmatrix} w_{1,1} & w_{1,2} \\ w_{2,1} & w_{2,2} \\ \mathbf{w_{3,1}} & \mathbf{w_{3,2}} \\ w_{4,1} & w_{4,2} \end{bmatrix} = [\mathbf{w_{3,1}, w_{3,2}}]$$

This "switches on" a specific column or row in the network. Instead of processing 82,000 zeros, the network immediately pulls out a small, dense vector (e.g., 300 dimensions). Crucially, these weights are not fixed; they are the parameters the model optimizes during training.

#### 3. Embeddings as a "By-Product"

Originally, researchers built Neural Language Models to predict the next word in a sequence. However, they noticed that to perform that task well, the network had to learn meaningful representations in its hidden layers.
* The Task: Predict $w_{t+1}$ given $w_t$.The Result: Words that appear in similar contexts (like "pizza" and "burger") end up having very similar weights in the matrix so the network can make similar predictions for both.
* The Discovery: We can throw away the "prediction" part of the network and just keep the Weight Matrix. 
* This matrix is our Lookup Table of word embeddings.

An embedding is just a learned weight. We start with a random vector for every word, and through backpropagation, the network nudges those numbers until "cat" and "dog" are mathematically close to each other because it helps the network predict the surrounding words more accurately.

---

## Recurrent Neural Network Language Model (RNN-LM)
This 2013 NAACL paper explains how to use an RNN to predict the next word, whereas Word2Vec (the later 2013 paper) simplifies things to just learn embeddings. It is not Word2Vec, though it is from the same author (Mikolov et al NAACL 2013) and is the prelude to W2V. Think of this model as a "chain" where each link knows what happened in the previous link. 

The paper "Recurrent Neural Network Based Language Model" (Mikolov et al., 2013) is a seminal work that fundamentally challenged the long-standing dominance of $n$-gram models in Natural Language Processing. The authors proposed an architecture that uses a Recurrent Neural Network (RNN) to model language, where the probability of the next word is conditioned not just on a fixed window of previous words, but on a "hidden state" that acts as a continuous memory of the entire preceding context. By projecting words into a dense embedding space (the $U$ matrix) and allowing information to cycle through the hidden layer via a recurrent weight matrix ($W$), the model learns to represent words as continuous vectors. This allows the system to achieve a level of generalization impossible for $n$-grams; if the model learns that "dog" and "cat" are semantically similar, it can naturally assign a high probability to "the cat sat" even if it has only ever seen "the dog sat" in its training data.

The significance of this paper lies in its solution to the curse of dimensionality and the sparsity problem. While traditional $n$-gram models grow exponentially in complexity as the context window increases and struggle with "zero-count" sequences, Mikolov’s RNN-LM maintains a constant number of parameters and uses "distributed representations" to smooth the probability space. This work demonstrated that neural networks could achieve significantly lower perplexity (a measure of how well the model predicts a sample) than state-of-the-art smoothed $n$-grams. Furthermore, it laid the essential groundwork for the subsequent "word2vec" revolution by proving that the internal weights learned by these networks (the word embeddings) captured deep, multi-dimensional semantic and syntactic relationships that could be used in almost every other NLP task.

---

## Word2Vec 

While the RNN-LM was groundbreaking, it was slow. The "recurrence" (the $W$ matrix that handles memory) is computationally expensive because it forces the model to process words strictly one by one. In the follow-up 2013 paper, Mikolov realized that if our primary goal is just to get great word embeddings, we don't actually need a "memory" of the whole sentence. We just need to look at immediate neighbors.

The transition is a move toward radical simplification. By removing the recurrent hidden layer, the model becomes a "shallow" neural network. This allows it to be trained on massive datasets (billions of words) in a fraction of the time.

Instead of an RNN reading a sentence from start to finish, Word2Vec uses a fixed-length context window.
* You define a radius (e.g., +/- 2 words).
* As you slide this window across the corpus, the "Center" word is your Target, and the words around it are your Context.

One of the most important technical details of this system is that every word has two representations:
* $v_w$ (Input/Context Vector): Used when the word is part of the "neighboring" context.
* $u_w$ (Output/Target Vector): Used when the word is the "target" being predicted.

Why? It makes the math much cleaner. During training, we are essentially trying to align these two vectors so that if "cat" often appears near "purred," the Context Vector for cat and the Target Vector for purred have a high dot product.

---

## The Two Architectures
This logic branches into two distinct models: CBOW and Skip-gram.

#### CBOW (Continuous Bag of Words)
"Predict the center from the surroundings."
1. Input: One-hot vectors of all context words in the window.
2. Projection: Pull the context embeddings from the Input Matrix ($W$) and average them.
3. Output: Multiply that average by the Target Matrix ($W'$) to get raw scores for the whole vocab.
4. Softmax: Convert scores to probabilities.
5. Loss: Compare the probability of the actual target word (e.g., "sat") to the model's guess using Cross-Entropy.
6. Backprop: Nudge the vectors in both $W$ and $W'$ to reduce the error.

#### Skip-gram (The Inverse)
"Predict the surroundings from the center." This is often called the "harder" task, which usually results in better embeddings for rare words.
* Input: The one-hot vector for one target word.
* Projection: Pull just one embedding vector.
* Output: Try to predict multiple context words independently.
* Logic: If I give you the word "sat," the model has to learn that "cat," "on," and "the" are all high-probability neighbors.

---

## Why this works (The "Softmax" Goal)
We are not subtracting vectors during training. We are comparing probability distributions.

If the model predicts a 60% chance for "sat" ($0.6$), the "Signal" for backpropagation is the 40% error ($1.0 - 0.6$). The gradient descent process then travels back into the weights:
* It strengthens the connection between the context words and "sat."
* It weakens the connection between those context words and everything else (like "airplane").

---

## Summary of RNN to Word2Vec
By simplifying the RNN into these window-based architectures, Word2Vec achieved:
* Speed: Could be trained on the 100-billion-word Google News dataset.
* Linear Relationships: The surprising discovery that $Vec(\text{"King"}) - Vec(\text{"Man"}) + Vec(\text{"Woman"})$ resulted in a vector very close to $Vec(\text{"Queen"})$.

---

## Why Word2Vec Replaced LSA/SVD
By 2013, Latent Semantic Analysis (LSA) was the industry standard. It was mathematically sound, but it struggled with the sheer scale of the internet. Mikolov’s Word2Vec didn't just offer better vectors; it offered a more scalable way to learn.

#### Computational Efficiency (Local vs. Global)
* LSA (Global): To run LSA, you must first build a Global Co-occurrence Matrix. If your vocabulary is 100,000 words, you need a $100,000 \times 100,000$ matrix. Running SVD on a matrix of this size is "memory-heavy" and computationally "expensive." If you add one new document to your corpus, you theoretically have to re-run the entire math for the whole matrix.
* Word2Vec (Local): Word2Vec is Stream-based. It only ever looks at 5–10 words at a time (the sliding window). It doesn't need to see the whole corpus to start learning. This means it can be trained on billions of words using a standard computer, whereas LSA would crash due to memory limits.

#### The Discovery of Linear Analogies
The most famous reason for Word2Vec’s success was the discovery that its vector space preserved Relational Logic.
* LSA is great at Topical Association (knowing that Paris and France are related).
* Word2Vec captures Specific Directions. Because it predicts words in local slots, it maps the "step" from a Country to its Capital as a consistent vector direction.
* This allowed for the famous vector arithmetic: $\vec{v}(King) - \vec{v}(Man) + \vec{v}(Woman) \approx \vec{v}(Queen)$. LSA rarely achieves this level of precise geometric regularity.

#### Scalability and "Online" Learning
* Scale: Because Word2Vec is a neural network, it scales linearly with the size of the data. You can feed it 100 billion words from Google News, and it just keeps getting better.
* Flexibility: Word2Vec is an "Online" model. You can take a model pre-trained on Wikipedia and "fine-tune" it on medical journals. You don't have to start from scratch. With LSA, incorporating new data into an existing "concept space" is mathematically much more difficult.

---

## Skip Gram: Different Approach to Training and Labels

If the standard "Softmax" flow is a Multi-class Classification (predicting 1 word out of 80,000), then Negative Sampling is a Binary Classification (predicting if a pair is "Real" or "Fake").

Instead of asking "What is the next word?", we ask: "Is word $C$ likely to show up near word $T$?"
* Positive Samples: Words that actually appear in the window together (e.g., Paris and France). We want the model to output 1 (Yes).
* Negative Samples: Words randomly picked from the dictionary (e.g., Paris and Puddle). We want the model to output 0 (No).

To make the math work, every word has two identities: 
* Target Embedding ($v_w$): Used when the word is the "Center."
* Context Embedding ($u_w$): Used when the word is a "Neighbor."

The model starts with random numbers and iteratively shifts the vectors:
* Increase Similarity: If a pair is Positive, we maximize their Dot Product. This moves the target and context vectors closer together in space.
* Decrease Similarity: If a pair is Negative, we minimize their Dot Product. This pushes the vectors away from each other.

The objective is to maximize the probability of the actual context words ($w_{pos}$) and minimize the probability of the $k$ random negative words ($w_{neg}$):

$$\mathcal{L} = \log \sigma(v_{target} \cdot u_{pos}) + \sum_{i=1}^{k} \log \sigma(-v_{target} \cdot u_{neg_i})$$

Wait, why use $\sigma$ (Sigmoid)? The Sigmoid function takes any dot product and squashes it between 0 and 1. This turns a mathematical score into a "probability of being a real neighbor."

#### Why this is "Hard to Understand"
The confusion usually stems from the fact that we are training two matrices ($W$ and $W'$) simultaneously. After training is finished, we usually throw away the Context Matrix ($W'$) and only use the Target Matrix ($W$) as our final word embeddings.

---

## Glove (Pennington et al 2014)

To understand GloVe (Global Vectors), you have to see it as the "peace treaty" between the two worlds we’ve discussed: the Global Matrix Factorization of LSA and the Local Context Prediction of Word2Vec.

Pennington et al. (2014) argued that both previous methods were flawed. LSA uses global statistics but is bad at analogies; Word2Vec is great at analogies but "wastes" data because it only looks at local windows and ignores how often words appear across the whole corpus.

> GloVe: Global Vectors for Word Representation

GloVe’s core insight is that ratios of co-occurrence probabilities are the true carriers of meaning, not just the raw counts.

GloVe tries to solve the matrix factorization problem ($X = FC^\top$) but does so using a weighted least squares objective.
* $X$: A global word-word co-occurrence matrix (counts how many times word $i$ appears in the context of word $j$ across the entire corpus).
* $F$: Focal/Target embeddings.
* $C$: Context embeddings.
* The Goal: Find vectors such that their dot product equals the log of their co-occurrence count: $w_i \cdot \tilde{w}_j \approx \log(X_{ij})$.

#### Why Ratios Matter (The "Ice" vs. "Steam" Example)
This is the "aha!" moment of the GloVe paper. Consider the relationship between "Ice," "Steam," and a probe word "Water":
1. $P(\text{water} \mid \text{ice})$ is high.
2. $P(\text{water} \mid \text{steam})$ is high.
3. The ratio $\frac{P(\text{water} \mid \text{ice})}{P(\text{water} \mid \text{steam})}$ is close to 1 (since water is related to both).

Now consider the probe word "Solid":
1. $P(\text{solid} \mid \text{ice})$ is high.
2. $P(\text{solid} \mid \text{steam})$ is low.
3. The ratio $\frac{P(\text{solid} \mid \text{ice})}{P(\text{solid} \mid \text{steam})}$ is very large.

GloVe is designed so that the vector differences capture these ratios. This is why it is so good at analogies—the math is explicitly built to preserve these proportional relationships.

In LSA, rare co-occurrences (noise) and extremely frequent ones ("the", "and") carry too much weight. GloVe introduces a weighting function that: 
1. Caps the influence of very frequent words (so "the" doesn't dominate).
2. Ignores zeros (so sparse data doesn't break the model).
3. Gives more weight to pairs that appear together more often, but only up to a point.

#### GloVe vs. Word2Vec
In Word2Vec, the model might see "Ice" and "Water" together 1,000 times and think they are related.
In GloVe, the model looks at the ratio: How much more often does "Ice" appear with "Solid" compared to how often "Steam" appears with "Solid"? It is this contrast between words across the entire dataset that creates the high-precision vector space GloVe is famous for.

## Correlation with Human Judgement

In the paper "Don’t count, predict! A systematic comparison of context-counting vs. context-predicting semantic vectors" (Baroni et al., 2014), researchers wanted to settle a debate: Is it better to build a giant table and count word overlaps (PPMI/LSA), or is it better to use the Word2Vec approach of predicting neighbors?

Baroni compared two main types of models:
* Count-based: Traditional distributional models that use PPMI weighting and sometimes SVD (like LSA). These models literally "count" frequencies across the whole corpus.
* Predict-based: Neural models like Word2Vec (Skip-gram/CBOW). These models "predict" the context in which a word appears.

The study found that predict-based models (Word2Vec) consistently outperformed count-based models across almost all tasks. These tasks included:
* Synonym detection: Finding which word is most similar to a target.
* Concept categorization: Grouping "apple" and "pear" as fruits.
* Analogy solving: The $King - Man + Woman = Queen$ tests.

The "Human Judgement" part of your note refers to Intrinsic Evaluation. To see if a model is "good," we compare its mathematical similarity scores to human scores.

The Test: Humans are asked to rate word pairs (e.g., "How similar are Cup and Mug on a scale of 1–10?").

The Metric: Researchers use Spearman’s Rank Correlation. If the humans rank Cup/Mug as very similar and Cup/Cloud as very different, and the model’s vector distances show the exact same ranking, the model has a high correlation with human judgment.

The Result: Baroni showed that Word2Vec vectors "aligned" with human intuition much more closely than the old PPMI counting methods.

Your note "dont bother counting just predict cooccurences" captures the radical conclusion of the paper. It suggested that the neural "prediction" task is a more powerful way to extract meaning than raw statistical counting.

The neural network acts as a smarter filter—it ignores the noise and focuses on the underlying semantic "slots" that words fill, which is closer to how humans perceive meaning.

## What is Specical About Word2Vec and Glove

This section refers to the landmark paper "Neural Word Embedding as Implicit Matrix Factorization" (Levy & Goldberg, 2014).

Before this paper, people thought Word2Vec worked because of "neural magic." Levy and Goldberg proved that Word2Vec wasn't doing anything mathematically "new"—it was actually just a very efficient way of doing Matrix Factorization on a PPMI matrix.

The reason Word2Vec seemed better than the old counting methods wasn't the neural network itself; it was the hyperparameters (the settings) used during training. The authors showed that if you apply these same "tricks" to traditional PPMI/SVD models, the old models perform just as well as Word2Vec.

These hyperparameters are the real reason Word2Vec and GloVe outperform basic counting.

#### 1. Dynamic Context Window
Instead of treating all words in a window ($+/- 5$) equally, the model weights them by distance. Words closer to the target get more weight than words further away. This captures the intuition that immediate neighbors are more semantically relevant.

#### 2. Subsampling
Frequent words like "the" or "and" carry very little information but appear constantly. Subsampling randomly removes these words from the training data, forcing the model to focus on more meaningful relationships (like "coffee" and "cup").

#### 3. Deleting Rare Words
Words that appear only once or twice are mostly noise (spelling mistakes, rare names). By deleting them entirely before building the context windows, you reduce the size of the vocabulary and stop the model from trying to learn "nonsense" patterns.

#### 4. Context Distribution Smoothing (CDS)
When calculating PMI, the "negative" impact of frequent words is often too strong. CDS raises the context word frequencies to a power (usually $0.75$), which effectively "boosts" the probability of rare contexts and prevents common words from dominating the math.

#### 5. Negative Sampling / Shifted PMI
As you noted, this shifts the PMI values by a constant $k$. Mathematically: $PMI(w,c) - \log(k)$. This acts as a filter. It ensures that the model only considers a context "important" if its association is significantly higher than a random baseline.

#### 6. Combining Word and Context Vectors
In Word2Vec/GloVe, every word ends up with two vectors (Target $W$ and Context $W'$). Levy and Goldberg found that simply adding these two vectors together ($W + W'$) often produces a better, more robust embedding than just using one.

#### 7. Eigenvalue Weighting in SVD
In traditional SVD (LSA), we often treat all "latent dimensions" equally. This trick suggests weighting the dimensions by their singular values (the eigenvalues). It helps the model prioritize the "strongest" semantic signals over the weaker ones.

---

## Disadvantages of Low-Density (Dense) Representations

#### Lack of Interpretability (The "Black Box")
In a traditional co-occurrence matrix, if Dimension 405 has a high value, you can look it up and see it represents the word "banana." You know exactly why two words are similar. In a 300-dimensional Word2Vec space, Dimension 42 doesn't have a name. It is a mathematical abstraction. You cannot "interrogate" the vector. If the model says "Doctor" and "Hospital" are similar, you can't easily ask it which specific feature led to that conclusion. The meaning is "distributed" across all 300 dimensions.

#### Non-Determinism (The "Random" Factor)
Because Word2Vec and GloVe use Neural Optimization (Gradient Descent), they are non-deterministic. Every time you start training, the vectors are initialized with different random numbers. The model "descends" a loss landscape. Depending on where it starts, it might get stuck in a different "valley" (local minimum) each time. It can never be 100% sure it found the "perfect" global minimum. If you train the exact same model on the exact same data twice, you will get two different sets of vectors.

#### Incomparability
Because of this non-determinism, you cannot compare two different runs directly. If you train a model on 1990s news and another on 2020s news, you can't just subtract the vectors to see how the word "Amazon" has changed. The "coordinate systems" are completely different; Dimension 1 in the first run might correspond to Dimension 200 in the second. You would need to use a technique called Procrustes Alignment to "rotate" one space to match the other before comparing. 

#### The "Silver Lining" of Non-Determinism
Stability as a Proxy for Truth: If you run the model 10 times with 10 different random seeds, and "nurse" is a top-5 neighbor of "doctor" in all 10 runs, you can be statistically confident that the relationship is "real" and not just a fluke of the random initialization. If a neighbor only appears in 1 out of 10 runs, it's likely just noise.

---

## Compositional Distributional Semantics

This is the "final boss" of distributional semantics: Compositionality. While we have mastered representing individual words, language is built on phrases and sentences. How do we mathematically combine two vectors into one?

The core question is: If we have $\vec{u}$ (male) and $\vec{v}$ (nurse), what is $\vec{p}$ (male nurse)? Mitchell and Lapata (2008) introduced two primary models for this.

#### Option 1: Intersective (Multiplicative) Composition
This model assumes a feature is only relevant if it is associated with all parts of the phrase.
* Intuition: "Male nurse" is the intersection of "maleness" and "nursing.
* "Formula: $\vec{p} = \vec{u} \odot \vec{v}$ (Pointwise Multiplication).
* The Math: For each dimension $i$, $p_i = u_i \times v_i$.
* The Problem: Pointwise multiplication is "aggressive." If a feature has a $0$ in the "male" vector but a high value in "nurse," the result is $0$.
* Result: As you add more words (e.g., "young male nurse"), the vector becomes sparser and tends toward zero, eventually losing all information.

#### Option 2: Additive Composition
This model assumes a feature is relevant if it is associated with any part of the phrase.
* Intuition: A "male nurse" inherits features from both "male" and "nurse."
* Formula: $\vec{p} = \vec{u} + \vec{v}$ (Vector Addition).
* The Math: For each dimension $i$, $p_i = u_i + v_i$.
* The "Centroid" Problem: As you add more and more words (e.g., a whole paragraph), the vector tends toward the geometric center of the entire semantic space. It becomes a "generic" vector that is slightly related to everything but specifically describes nothing.
* Fix: Often, we use a weighted addition or re-normalization to keep the vector length manageable.

---

## Challenges of Compositional Models
Even with complex math, these simple operations struggle with the nuances of human language:

#### Non-Compositional Phrases (Idioms)
"Kick the bucket" does not mean the addition of "kicking" + "buckets." Distributional models that rely on composition will completely fail on metaphors and idioms because the meaning of the whole is not the sum of its parts.

#### Word Order (The "Bag of Words" Problem)
Vector addition and multiplication are commutative.

* $\vec{v}(\text{dog}) + \vec{v}(\text{bites}) + \vec{v}(\text{man})$
* $\vec{v}(\text{man}) + \vec{v}(\text{bites}) + \vec{v}(\text{dog})$

The resulting vector is identical, even though one is a common occurrence and the other is news. Simple composition ignores the vital information found in syntax and word order.

#### Negation and Function Words
How do you represent "not"? If you add "not" to "happy," you get a vector that is still very close to "happy" (since they share many contexts). Logic requires "not happy" to be the opposite or an inversion, but simple vector math doesn't handle logical operators well.

---

## Evaluation: How do we know it worked?
Evaluation moves from word similarity to Sentence/Phrase Similarity.

Intrinsic: Human Similarity Judgments. We ask humans to rate the similarity of "male nurse" and "doctor." We then see if our composed vector for "male nurse" has a high cosine similarity to "doctor."

Extrinsic (Application-based): Paraphrase Detection. Can the model tell that "The boy ate the apple" and "The fruit was consumed by the child" mean the same thing? If the composed vectors for both sentences are close together, the model is successful.

--- 

# Composition Summary 

Compositionality in distributional semantics explores how to mathematically combine individual word vectors to represent the meaning of phrases or sentences. Additive composition ($u + v$) treats the resulting phrase as a union of features, where a "male nurse" inherits characteristics from both "male" and "nurse"; however, this approach risks "diluting" the meaning into a generic centroid as more words are added. Conversely, intersective or multiplicative composition ($u \odot v$) acts as a filter, retaining only the features shared by all words in the phrase. While this captures specific overlaps well, it often leads to "sparsity," where the vector quickly collapses toward zero. Despite these methods, compositionality remains a major challenge because simple vector algebra struggles to account for word order ("man bites dog" vs. "dog bites man"), logical negation, and non-compositional idioms like "kick the bucket," where the total meaning is not found in the sum of its parts.

--- 

<br>
<br>
<br>

## Week 4: Seminar

The seminar was largely a recover of the lecture content 

## Week 4: Paper 

> Linguistic Regularities in Continuous Space Word Representations by Mikolov, Yih, and Zweig (2013)

This 2013 paper (by Mikolov, Yih, and Zweig) is the one that really "sold" word embeddings to the world. While the other Mikolov papers focus on the speed and the RNN architecture, this specific paper focuses on the linguistic beauty of the vector space. Before this paper, word vectors were evaluated based on how well they helped a model predict the next word (perplexity). This paper proposed a much more exciting idea: word vectors actually capture human-like reasoning. The authors showed that vectors aren't just arbitrary points; they encode linguistic relationships as geometric offsets (vectors).

The paper proved that semantic and syntactic relationships are represented by consistent vector distances.The Logic: If you take the vector for "King" and subtract the vector for "Man", you are left with a "royalty" vector. If you add that to "Woman", the result is closest to the vector for "Queen".The Formula: $V(Queen) \approx V(King) - V(Man) + V(Woman)$

#### 1. What are the main findings of this paper? Are you convinced?

The paper demonstrates that word representations learned by neural network language models (specifically RNNs) capture consistent linguistic regularities as linear vector offsets. By using a new analogy-based evaluation ($A:B :: C:D$), the authors show that relationships like verb tense or capital cities are encoded geometrically, allowing for vector arithmetic such as $King - Man + Woman \approx Queen$. This is a convincing shift in evaluation because it moves beyond simple similarity to prove that the model captures structured, relational knowledge.

#### 2. What do the authors claim is the main advantage of using distributed representations of words (aka. embeddings) over classical n-gram language models?

The primary advantage is the ability to generalize to unseen sequences by mapping words into a continuous, dense vector space. While classical n-grams suffer from sparsity—having no information about word sequences not explicitly seen in the training data—embeddings "smooth" the space so that semantically similar words (e.g., "sapphire" and "azure") share similar coordinates. This allows the model to assign high probabilities to novel phrases based on their components' proximity to known examples, effectively solving the "zero-count" problem and reducing perplexity.

#### 3. What is meant by a syntactic analogy? Give some examples of your own. Use some examples to explain why word2vec embeddings might be good at capturing syntactic regularities. Do you think the same would apply to other distributional word representations?

A syntactic analogy relates to the grammatical form of words, such as "walking : walk :: climbing : climb." Word2Vec captures these because words with the same grammatical suffix or tense appear in nearly identical functional contexts (e.g., following auxiliary verbs like "is" or "was"), leading to parallel vector offsets for specific rules like pluralization or tense. While traditional models like LSA often "wash out" these subtle cues by using large context windows, newer models like FastText improve on this further by representing words as bags of character n-grams, allowing them to calculate syntactic positions even for rare or unseen word forms.

#### 4. What is meant by a semantic analogy? Give some examples of your own. Use some examples to explain why word2vec embeddings might be good at capturing semantic regularities. Do you think the same would apply to other distributional word representations?

A semantic analogy captures conceptual relationships and real-world knowledge, such as "London : England :: Paris : France." Word2Vec excels here because the vector "jump" between a country and its capital represents a specific semantic direction that remains consistent across the entire space. While earlier global models like LSA are better at broad topical association (grouping "doctor" with "hospital"), they often lack the fine-grained directional precision of Word2Vec or GloVe, the latter of which was explicitly engineered to preserve these relational ratios in its global statistics.

#### 5. Explain the vector offset method used to answer an analogy question. In particular, what happens when no word exists at the predicted position?

The vector offset method solves analogies by calculating the displacement between two words ($\vec{v}(B) - \vec{v}(A)$) and adding it to a third ($\vec{v}(C)$) to predict the position of the fourth. Because the resulting coordinate exists in a continuous space, it rarely lands exactly on a pre-existing word vector; instead, the model performs a nearest-neighbor search using cosine similarity to find the closest word in the vocabulary. To ensure meaningful results, the input words $A, B,$ and $C$ are typically excluded from the search results to avoid the model simply returning the starting words.

# 6. What do you think of the results for identifying syntactic regularities? Is answering more than 1 in 3 questions correctly a good result? Are there any obvious trends in the results?

Answering more than 1 in 3 questions (approx. 33%–40% in this early paper) was a significant breakthrough at the time, as previous models often performed near 0% on such precise relational tasks. A clear trend in the results is that syntactic regularities are often easier for these models to capture than semantic ones, as grammatical rules (like pluralization) are applied more consistently across the corpus than world-knowledge relationships, which can be affected by data sparsity or polysemy.


# 7. Do you think the comparisons with other methods are fair? Why do the authors use a different test set when comparing with Collobert & Weston (2008) and Mnih & Hinton (2009)? Does this test set appear to be easier or harder than the original one?

The comparisons are somewhat limited because the authors had to use different test sets for models like Collobert & Weston (2008) to accommodate the original researchers' specific vocabulary and training constraints. This second test set is generally considered easier than the original because it often features more common words and simpler relationships. While this makes a direct "head-to-head" comparison difficult, it was a necessary compromise to evaluate different architectures that weren't trained on the same massive Google News datasets.

# 8. What do you think of the results for identifying semantic regularities? Why are results given for
Semantic results are reported using Spearman’s Rank Correlation and MaxDiff Accuracy because semantic similarity is often subjective and continuous rather than binary. Spearman’s Rank measures how well the model’s similarity ordering aligns with human intuition (e.g., ranking "cat/dog" higher than "cat/spoon"), while MaxDiff asks the model to identify the most and least similar pairs in a set. This provides a more nuanced view of the model’s conceptual "common sense" than a simple correct/incorrect accuracy score used for rigid syntactic rules.

---

<br>
<br>
<br>
<br>
<br>
<br>

# [Week 5 - Applications in NLP](https://canvas.sussex.ac.uk/courses/36171/pages/week-slash-topic-5-applications-in-nlp)

The ultimate goal of language modeling is rarely just to calculate the probability of a string of words or to find the mathematical distance between two vectors; rather, these models serve as the foundational engine for real-world applications. By treating language as a sequence of discrete units, we can apply different computational frameworks to solve diverse problems: Sequence Classification allows us to categorize entire documents (such as detecting sentiment or spam), while Sequence Labelling enables us to interrogate the internal structure of a sentence (such as identifying parts of speech or named entities). This week, we transition from theoretical word representations to practical architectures, exploring how traditional Bayesian methods like Hidden Markov Models (HMMs) have paved the way for modern, high-performance neural pipelines. Understanding these applications now provides the necessary grounding for when we eventually substitute these basic models with more advanced Transformer-based architectures in the coming weeks.

#### Week 5: Contents

1. [Lecture](#week-5-lecture)
2. [Seminar](#week-5-seminar)
3. [Paper](#week-5-paper)
4. [Additional Readings](#week-5-additional-reading)

---

## Week 5: Lecture

## Applications of Language Modelling

In a couple of weeks we will move into more advanced transformer based models, but first we are going to delve into the applications of language modelling and why we are interested in lanaguage modelling. If we can build a solid grounding in the applications, we should be able to substitue in our advanced models from the applications we have set up using more basic approaches. 

We are rarely interested in estimating the probability of a serquence of words as the end product, or even the similarity of a pair of words. We use these are parts of a wider goal. 

## Week 5 Overview 

Application types: for almost all app we will think of the input as a seq of words; with classifcication we want to label the whole sequence; with seq label, we want to label the words, normally from a pre-existing list of labels, i.e. word type gammar; transduction, simlar to label, translate input to output seq, though doesn't need to be same length, i.e. diff langs have diff lengths, doesn't need to be one to one labelling; seq gen: take on input seq and output another seq, i.e. a sumamry of a doc, similar to trans but different contect

approachs: traditional, language models, more advanced models; how out avs models slot it

* [Part 1: Sequence Classifciaiton](#part-1-sequence-classifciaiton)
* [Part 2: Sequence Labelling](#part-2-sequence-labelling)

## Part 1: Sequence Classification

Sequence classification is the cornerstone of many practical NLP tasks. In this section, we move from understanding individual words to making high-level decisions about entire blocks of text.

#### What is Sequence Classification?

In sequence classification, we take an input sequence of words—which could be a tweet, a product review, or an entire legal document—and map it to a single label. The term "sequence" is used because it imposes no constraints on the length or type of the text; the model simply processes a string of tokens as a unit.

* Sentiment Analysis: (e.g., Positive, Negative, Neutral)
* Topic Labeling: (e.g., Sports, Finance, Politics)
* Spam Detection: (e.g., Spam, Not Spam)
* Relevance: Determining if a document matches a specific query.

Before we train a model, we define the label space (the possible outputs). This determines the type of classification we are performing:
* Binary Classification: Choosing between two mutually exclusive classes (e.g., Spam or Not Spam).
* Multi-class Classification: Choosing one class from a set of three or more (e.g., classifying a news article as either "Technology," "Health," or "Business").

We can also distinguish between how the model "makes" its decision:
* Hard Classification: The model makes a final, definitive choice, placing the sequence into a single "bucket."
* Soft Classification: The model outputs a probability distribution across all possible classes (e.g., 60% Hate Speech, 30% Offensive, 10% Neutral). This is much more common in modern NLP, as it accounts for the fact that a long document might touch on multiple topics to varying degrees.

#### How do we represent the sequence?
To classify text, the computer needs to turn that sequence of words into a numerical format. We will explore three main ways to do this:
* The Traditional Approach (BoW): Counting word occurrences and ignoring order.
* Composition of Embeddings: Adding or averaging word vectors (Word2Vec/GloVe) to find a "centroid" for the document.
* Neural Models: Using RNNs or LSTMs to build a representation that respects word order.

#### The Subtle Different Betwween Word2Vec and Neural Models
The fundamental difference lies in how word order and context are handled: Composition of Embeddings (such as averaging or summing) is a "bag-of-words" approach that treats words as independent units, meaning the sentence "man bites dog" would result in the exact same vector as "dog bites man" because simple addition ignores sequence. In contrast, Neural Models like RNNs or LSTMs process words sequentially, using a mathematical "hidden state" that updates at each step to maintain a memory of what came before. This allows the neural approach to be order-aware and contextual, meaning it can distinguish between different meanings of the same word based on its position in the sentence, whereas simple composition merely calculates the "semantic center" of the vocabulary used.

Word2Vec is a neural model used to create the embeddings, but "Composition" is how you use them later. We use a neural network (like Word2Vec) to learn that the word "bank" should be represented by a specific vector. During this stage, it does use a context window to learn that meaning. Once the training is done, we "freeze" that vector and throw the neural network away. We are left with a static dictionary of vectors. Now you want to classify the sentence "I went to the bank.":
* If you choose Composition, you just grab the frozen vectors for those five words and add them together. You are no longer using a neural network; you are just doing simple math on the "output" of a previous neural network.
* If you choose a Neural Model (RNN/LSTM), you feed those frozen vectors into a new moving neural network that reads them one by one.

The Key Distinction: "Static" vs. "Dynamic"
* Composition is Static: It treats the word "bank" as the same fixed vector regardless of the other words in your specific sentence. The "context" was used to create the vector months ago, but it isn't being used to process the sentence right now.
* Neural Models (RNNs) are Dynamic: They re-evaluate the context of every word as they read your sentence in real-time. The vector for "bank" is modified by the "memory" of the word "river" that the model just read two tokens ago.

Summary: Word2Vec uses a context window to define a word's identity, but an RNN uses a sequential approach to define a word's specific role in a sentence.

This in phase of research, pre-transformers, the progression was to train Word2Vec on a large unlabled corpus and then feed the word embeddings into another RNN/LSTM. The RNN doesn't have to learn what "bank" or "river" means from scratch; it already knows their general identities. Its only job is to learn how those words interact in a specific sequence to determine a label (like Sentiment or Topic). This second step is in leiu of doing composition on the derived vectors. 

---







## Sequence Classification: Evalulation

Now that we have these two ways to classify (the "Smoothie" Additive method or the "Chef" Neural method), how do we decide which one is better? We use a set of metrics that look beyond just "Accuracy."

#### Evaluation: Precision, Recall, and F1

In classification, Accuracy (Total Correct / Total Samples) can be a "trap," especially if your classes are imbalanced (e.g., if 99% of your emails are NOT spam, a model that always guesses "Not Spam" is 99% accurate but totally useless).

To fix this, we use the Confusion Matrix to track four metrics:
* True Positives (TP): We said it was Spam, and it was.
* False Positives (FP): We said it was Spam, but it was a normal email (The "Annoyance").
* False Negatives (FN): We said it was normal, but it was Spam (The "Failure").
* True Negatives (TN): We said it was normal, and it was.

---
| Metric | Formula | Intuition |
| :--- | :--- | :--- |
| Precision | TP+FPTP​ | When the model says it's Spam, how often is it right? (Quality) |
| Recall | TP+FNTP​ | Of all the actual Spam out there, how much did we catch? (Quantity) |
| F1-Score | $2⋅Prec+RecPrec⋅Rec$​ | The balanced middle ground (Harmonic Mean). |
---

#### Macro vs. Micro Averaging

When we move beyond binary (Yes/No) classification to Multi-Class classification, we calculate Precision, Recall, and F1 for each individual class. To get a single score for the whole model, we have to aggregate those results.

#### Macro-Average (The "Class-Centric" Approach)
Macro-averaging treats every class as equally important, regardless of how many samples it contains.

You calculate the F1 for each class separately and then take the simple arithmetic mean.

If you have 3 classes (A, B, and C), the formula is $\frac{F1_A + F1_B + F1_C}{3}$

You use this when you want to ensure the model performs well on small, rare classes. If your model is great at the common classes but fails on the rare ones, your Macro-F1 will be very low. It punishes the model for neglecting the "underdogs."

#### Micro-Average (The "Sample-Centric" Approach)

Micro-averaging treats every individual sample as equally important.

You aggregate the TPs, FPs, and FNs from all classes together first, and then calculate a single F1 score from those totals.

This is essentially weighted by class size. If Class A has 900 samples and Class B has 10 samples, Class A will dominate the Micro-average result.

When you care about the overall success rate across the entire dataset and aren't specifically worried about whether the model is struggling with a tiny subset of the data.

When we calculate the Micro-average for a multi-class problem (where each instance has exactly one ground-truth label and one predicted label), it turns out that Micro-Precision, Micro-Recall, and Micro-F1 all become mathematically identical to Accuracy.

In a single-label multi-class system, every mistake is a "double-edged sword":
* The False Positive: If the model wrongly predicts "Dog" for a picture that is actually a "Cat," it creates a False Positive for the "Dog" class.
* The False Negative: At the exact same time, it creates a False Negative for the "Cat" class (because it missed a real cat).

Because every single error is simultaneously a False Positive for one class and a False Negative for another, the total sum of FPs across the whole dataset will always equal the total sum of FNs. When $FPs = FNs$ in the micro-level math, the distinction between Precision and Recall vanishes.

Because Micro-F1 just collapses into Accuracy, it inherits all of Accuracy's weaknesses:
* It hides minority failure: If your model is 99% accurate because it correctly identifies the massive "Standard" class but gets 0% correct on the "Danger" class, the Micro-F1 will still be 0.99.
* It creates a false sense of security: It makes the model look high-performing even if it hasn't learned the "hard" parts of the data.

The only reason we keep it around is to check for global system robustness. If you are running a massive commercial system (like a spam filter for millions of users), you might care more about the total number of people affected by errors than the specific performance on a rare sub-type of spam.

However, for scientific research and model development, the Macro-average is considered the "true" test. It forces the model to be a "specialist" in every category, not just a "generalist" that wins by sheer volume.

---

Analogy: Imagine a school with a Math class of 100 students and an Art class of 5 students. A Macro-average gives the Math teacher and the Art teacher the same "weight" in the school's performance rating. A Micro-average says the Math class is 20 times more important because it contains more students.

---

## Traditional Representation: Bag-of-Words (BoW)
The classical baseline for sequence classification is the Bag-of-Words. It represents a document by the frequency of the words it contains, entirely discarding word order.
* Benefits: It is simple, fast, and highly effective for topic classification where the presence of certain keywords is enough to determine the class.
* Limitations: By losing order, it loses sentiment and nuance. It cannot distinguish between "The film was not good, it was bad" and "The film was not bad, it was good," as both contain the same counts. It also fails to capture semantic relationships (e.g., "sofa" and "couch" are treated as completely unrelated).

--- 

## The Bayesian Strategy: Naive Bayes
The traditional machine learning approach uses the Naive Bayes classifier. It is "Naive" because it assumes that every word in a document is independent of every other word.

Using Bayes' Theorem, we find the most likely class $C$ for a sequence of words $w$:

$$P(C|w) = \frac{P(w|C)P(C)}{P(w)}$$

In practice, we ignore the denominator ($P(w)$) because it is constant for all classes, and we maximize:

$$P(C) \prod_{i=1}^{n} P(w_i|C)$$

#### Generative Language Modeling
We can extend this by building a separate Language Model for each class. We calculate the probability of the entire sequence given the class-specific model, $P(\text{seq} | \text{class})$. While $n$-gram models can do this, they have largely been superseded by embedding-based approaches.

## The Embedding Approach: Principle of Compositionality
Following the Distributional Hypothesis, we use word embeddings (Word2Vec/GloVe) to represent meaning. To move from word-level to sequence-level representations, we rely on Compositionality.

#### Additive Composition (Pooling)
The most common "quick" rule is to add or average the vectors of the words in a sequence to find the Centroid.

Mechanism: You take your word embeddings, pass them through a "Pooling" layer (Mean or Sum), and feed the resulting sequence vector into a standard classifier (Logistic Regression or SVM).

Drawback: These are uncontextualized. The vector for "head" is the same whether it means "body part" or "leader." Furthermore, word order is still ignored because vector addition is commutative.

## Modern Neural Approach: Bi-directional Sequence Modeling
To truly capture context and order, we use a Bi-directional RNN or LSTM. This creates a full, "order-aware" representation of the sequence.

1. Forward Pass ($f_y$): Reads the sequence from left to right, building a state based on the history of what came before.
2. Backward Pass ($b_y$): Reads from right to left, building a state based on the "future" context.
3. Concatenation: We take the final hidden states from both directions and concatenate them.

This resulting vector is a fixed-length representation that contains the entire "story" of the sequence from both perspectives. This final representation is then fed into a prediction network for classification.

---

| Method | Order Sensitive? | Semantic Aware? | Complexity |
| :--- | :--- | :--- | :--- | 
| BoW | No | No | Very Low | 
| Embedding Pooling | No | Yes (Word2Vec) | Low |
| Bi-directional LSTM | Yes | Yes (Contextual) | High | 

---

## Part 2: Sequence Labelling

In contrast to sequence classification, where we assign one label to an entire document, Sequence Labelling requires us to assign a label to every individual element (or token) within that sequence.

The input is typically a sequence of words, but depending on the task, it could also be a sequence of characters or sub-word units. The goal is to produce an output sequence of labels that is exactly the same length as the input sequence.

Traditionally, sequence labelling has been the engine behind two fundamental NLP tasks:
* Part-of-Speech (PoS) Tagging: Identifying the grammatical category of each word, such as whether it is a noun, verb, or adjective.
* Named Entity Recognition (NER): Identifying and categorizing "entities" within text, such as people, organizations, or locations.

These tasks are rarely performed in isolation; in complex pipelines, they are often layered on top of each other, where the output of a PoS tagger might be used as a feature to improve the accuracy of a Named Entity Recognizer.

---

## IOB Encoding: Identifying Spans as Sequences

A major challenge in sequence labelling is that entities often span multiple words (e.g., "New York City" or "Elon Musk"). Since our model predicts one label per token, we need a way to tell the computer that these individual words belong together as a single unit. We solve this using IOB Encoding (Inside, Outside, Beginning).

Instead of simply labelling a word as a "Person" or "Location," we add a prefix to the tag to indicate its position within a span:
* B- (Beginning): Indicates the first token of a named entity.
* I- (Inside): Indicates any subsequent tokens that are part of the same entity.
* O (Outside): Indicates that the token is not part of any named entity.

By using IOB encoding, we turn a span identification problem (finding the start and end of a phrase) into a simple sequence labelling problem (assigning one tag per token). This allows us to use standard classification architectures without needing complex "layering" or multi-token logic. The model simply learns that an I- tag must logically follow a B- tag of the same type, which helps it maintain the structural integrity of the entity spans.

---

## IOB - Evaluation

Evaluating sequence labelling is more demanding than simple classification because we aren't just checking if we got a word's category right; we are checking if we identified the entire span correctly.

In Named Entity Recognition (NER) using IOB encoding, we typically use strict evaluation. For an entity to be counted as a "True Positive," the model must correctly identify:
1. The boundary (the exact start and end tokens).
2. The label (e.g., PER vs. LOC).

If the model predicts "New York" as a location but misses "City," it is often counted as both a False Negative (for the correct span "New York City") and a False Positive (for the incorrect span "New York").

* Precision: Of all the entity spans the model predicted, how many were exactly right?
* Recall: Of all the actual entity spans in the text, how many did the model successfully find?
* F1-Score: The harmonic mean used to balance the trade-off between missing entities and hallucinating incorrect ones.

While sequence labelling looks like a series of individual classifications (word by word), we treat it as a Global Task. We want to find the most likely sequence of labels given the entire sequence of tokens.

This is a critical distinction: we don't just want the best tag for word #5; we want the best path of tags from word #1 to word #10. This requirement is why simple classifiers like Naive Bayes or Logistic Regression are often replaced by models that can handle dependencies between tags, such as HMMs or CRFs.

#### Approaches to Sequence Labelling
* Rule-based: Using dictionaries and regular expressions (still common for specific domains like medical IDs).
* Bayesian Models (HMMs): Treating labels as hidden states that "generate" words.
* Discriminative Models (CRFs): Modeling the dependencies between labels directly.
* Neural Models (Bi-LSTMs): Using deep learning to extract features without manual engineering.

---

## Rule-Based Sequence Labelling
Before the dominance of machine learning, sequence labelling relied entirely on human-defined logic. Despite the rise of neural networks, rule-based systems remain very common in practice because they are transparent, "cheap" to build for specific domains, and require zero training data.

In modern industry, these are often used as "baselines" or combined with supervised ML in hybrid systems to catch "easy" entities while the model handles the complex ones.

---

## Bayesian Models: Hidden Markov Models (HMMs)
Moving into probabilistic territory, we encounter Hidden Markov Models (HMMs). This approach treats labels as hidden states that "generate" the observed words.

An HMM assumes that there is an underlying sequence of tags (the truth) that you cannot see, and this sequence follows a Markov Chain. The fundamental assumption is that the current tag depends only on the previous tag.

To solve a sequence with an HMM, we need to learn three things from our training data:
* Transition Probabilities: How likely are we to move from one tag to another? (e.g., how likely is I-PER to follow B-PER?)
* Emission Probabilities: How likely is a specific state to "emit" a specific word? (e.g., how likely is the state B-LOC to produce the word "London"?)
* Initial State Probabilities: How likely is a sentence to start with a specific tag?

We typically use Maximum Likelihood Estimation (MLE) to count these frequencies in a labeled corpus to "train" the model. During inference (testing), we use the Viterbi Algorithm—a dynamic programming tool—to find the single most likely path of hidden tags that could have produced the observed sequence of words.

While we use frequentist counts (MLE) to train, the inference is purely Bayesian. We are constantly updating our "belief" about which hidden state we are in as each new word in the sentence is observed.

#### Drawbacks of HMMs
The power of HMMs is limited by two major simplifying assumptions:
* Limited History (Markov Assumption): Because it only looks at the one previous tag, it has a very short memory.
* Feature Independence: It assumes the only thing that matters for a word is the current tag, ignoring the rich interaction between surrounding words and other linguistic features.

---

## Discriminative Models: MEMMs and CRFs
This section marks the shift from Generative models (like HMMs), which try to model how words are "born" from tags, to Discriminative models, which focus purely on the best way to choose a tag given the words.

Discriminative models don't care about the probability of the words themselves; they only care about the boundary between classes. This allows them to "leverage interdependence," meaning they can look at many features at once—capitalization, word endings, neighboring words—without worrying about how those features relate to each other.

---

## Maximum Entropy Markov Models (MEMMs)
The MEMM was an attempt to make HMMs more powerful by switching the direction of the probability:
* HMM Logic: $P(\text{Observation} | \text{Tag})$ — "Given the tag 'Person', how likely is the word 'Elon'?"
* MEMM Logic: $P(\text{Tag} | \text{Observation}, \text{Prev\_Tag})$ — "Given the word 'Elon' and the previous tag, how likely is this to be 'Person'?"

MEMMs have a fatal flaw called Label Bias. Because a MEMM makes a "hard" decision at every state based only on the current local evidence, it can get "stuck." If a state has very few outgoing transitions, the model is effectively forced into those transitions regardless of what the future words say. It can't "reach back" and change a past decision even if later information proves it was wrong.

---

## Conditional Random Fields (CRFs)
CRFs were designed to solve the Label Bias problem by moving from "local" decisions to a Global decision.
* The Global Approach: Instead of having a separate probability model for every state (like MEMMs), a CRF uses a single exponential model for the entire sequence.
* The Graph: A Linear Chain CRF is an undirected graphical model. While HMMs have arrows (indicating a "direction" of generation), CRFs have simple lines (indicating a "relationship" or correlation).
* The Benefit: It calculates a "score" for the entire path of tags. This means it can use information from the very end of a sentence to help decide the very first tag. It optimizes the whole output sequence given the whole input sequence.

In modern NLP, we rarely use "pure" CRFs, but we frequently use CRF Layers at the top of Neural Networks (like Bi-LSTMs).
* The Neural Network acts as the "Feature Extractor" (understanding the words).
* The CRF acts as the "Interpreter" (ensuring the sequence of tags makes sense, e.g., preventing an I-PER from following an O tag).

The evolution from HMM to CRF represents a move toward global context. While HMMs are limited by strict independence assumptions and MEMMs suffer from the Label Bias problem due to their per-state local decisions, CRFs provide a superior solution by modeling the conditional probability of the entire label sequence at once. By treating the sequence as an undirected graph, CRFs allow every part of the sentence to influence the labeling of every other part, ensuring that the final output is the most statistically likely "path" for the whole input.

---

## Neural Models for Sequence Labelling
The major advantage of neural approaches is that they are end-to-end. In traditional models (like CRFs), humans had to manually engineer "features" (e.g., "is the word capitalized?", "does it end in -ing?"). Neural networks, however, learn these features automatically from the raw sequence of words or characters.

While vanilla RNNs and GRUs were used, the Bi-directional LSTM (Bi-LSTM) became the most popular non-transformer choice because it can maintain long-range dependencies from both the past and the future context simultaneously.

## The Ma and Hovy (2016) Architecture
This model is famous for its "sandwich" design: CNN + Bi-LSTM + CRF. It processes information at three different levels:

#### Level 1: Character-level Representations (CNN)
For every word, the model looks at its individual characters.
* A CNN slides over character embeddings to capture morphological patterns (prefixes, suffixes).
* The Benefit: This solves the "Out-of-Vocabulary" (OOV) problem. Even if the model hasn't seen a specific rare word before, it can recognize that it looks like a name because of its structure (e.g., capitalization or specific endings).

#### Level 2: Word-level Context (Glove + Bi-LSTM)
The character representation is concatenated with a pre-trained GloVe embedding.
* GloVe provides the "global" semantic meaning (unpacked from billions of co-occurrences).
* This combined vector is fed into a Bi-LSTM. The forward and backward hidden states are concatenated to create a context-aware representation of each word in the specific sentence.

#### Level 3: Sequence Decoding (CRF Layer)
Instead of using a simple Softmax to predict a tag for each word independently, the model uses a CRF as the final layer.
* The Logic: A Softmax might accidentally predict I-PER immediately after an O tag, which is grammatically impossible in IOB encoding.
* The Benefit: The CRF layer considers the entire sequence of labels. It ensures the "path" of tags is logically consistent, optimizing for the best global sequence rather than just the best local token.

## Advantages of the Neural Approach
* No Feature Engineering: You don't need to write rules for grammar or capitalization; the CNN and LSTM learn them.
* Robustness: By combining character and word embeddings, the model is equally good at handling high-frequency common words (via GloVe) and low-frequency/unseen words (via the CNN).
* Flexibility: You can easily swap out components (e.g., using a GRU instead of an LSTM) or tune hyperparameters to fit different languages or domains.

The Ma and Hovy (2016) architecture represents the pinnacle of pre-transformer sequence labelling by effectively combining local morphological cues with global contextual logic. By using a CNN to extract sub-word features from characters, a Bi-LSTM to capture bi-directional word context, and a CRF layer to ensure a grammatically valid output sequence, the model provides an end-to-end solution that requires no manual feature engineering. This hybrid approach remains a fundamental baseline in NLP, as it addresses the core challenges of word ambiguity, out-of-vocabulary terms, and label dependency in a single, unified framework.

---

<br>
<br>
<br>
<br>
<br>
<br>

## Week 5: Seminar

## Sequence Classification Labelling

### Week 5 Overview

This week is just classification and labelling. Next week will be transduction and generation. Then we will look into the basic/traditional approaches to these, this we can later in the module substitute in more advanced, transformer models. 

## Part 1 Questions: Sequence Classification

#### 1. Give examples of balanced and unbalanced class distributions. Why does class balance matter when developing and evaluating sequence classification models?

A balanced distribution occurs when each class has roughly the same number of samples (e.g., 50% Spam, 50% Ham), whereas an unbalanced distribution sees one class dominating (e.g., 99% Negative, 1% Positive). Class balance is critical because high accuracy can be misleading; a model could achieve 99% accuracy by simply guessing the majority class every time. In single-label tasks, Micro-average F1 is equivalent to Accuracy because every misclassification is simultaneously a False Positive for one class and a False Negative for another, causing Precision and Recall to equalize. Therefore, Macro-averaging is more informative as it treats all classes equally, forcing the model to perform well on the minority "underdogs" to achieve a high score.

#### 2. Describe 3 different ways in which language models might be used in sequence classification

Language models can be integrated into classification via three primary strategies. The Bayesian Approach (such as Naive Bayes) treats the probability of a class as a "degree of belief" that is updated by the elements of a sequence, essentially calculating which class-specific model is most likely to have generated the observed text. The Word Embedding Approach utilizes compositionality to create a sequence-level representation by calculating the sum or centroid of individual word vectors, which is then passed to a standard classifier. Finally, the End-to-End Neural Approach uses a bi-directional RNN or LSTM to process word-level representations sequentially; by concatenating the forward and backward hidden states, the model builds a rich, order-aware representation of the entire sequence for prediction.

---

#### 3. Different methods might be used to compose word embeddings? What are the advtanges and disadvantage?

Common methods for composing embeddings include additive, multiplicative, and pooling (Max/Mean) operations to reduce a sequence of vectors into a single document vector. While finding the centroid (averaging) is mathematically identical to addition in terms of cosine similarity (direction), these methods are fundamentally limited by their inability to capture word order or contextual nuance. Because vector addition is commutative, the resulting "context vector" cannot distinguish between different syntactic arrangements of the same words, and if the underlying embeddings were constructed using static methods like GloVe or Word2Vec, the final representation remains "uncontextualized" and blind to polysemy.

## Part 2: Sequence Labelling

#### 1. Give an example sentence and show how it might be annotated using an IOB encoding for Named Entity Recognition (e.g. PER, ORG, LOC etc)

To identify named entities within a span of text, we use IOB encoding to turn span identification into a sequence labelling task. For the sentence "Apple Inc. is based in Cupertino", the annotation would be: Apple (B-ORG), Inc. (I-ORG), is (O), based (O), in (O), Cupertino (B-LOC). This prefix system allows the model to clearly define the beginning and interior of multi-word entities using only one tag per token.

---

#### 2. What do understand by each of the following; HMM, MEMM, CRF. 

A Hidden Markov Model (HMM) is a generative Bayesian approach that models transition and emission probabilities to find the most likely "hidden" tag sequence that produced the observed words. However, because HMMs are limited by local independence assumptions, Maximum Entropy Markov Models (MEMMs) were introduced to model the probability of a tag based on the current observation and previous state; yet, MEMMs suffer from "Label Bias" where mistakes early in the sequence cannot be corrected. Conditional Random Fields (CRFs) solve this by modeling the entire sequence directly with a single global model, allowing later context to influence earlier predictions and ensuring the most likely global "path" of tags is chosen.

---

#### 3. Describe the typical components in a neural model for sequence labelling. 

A modern neural model for sequence labelling, such as the Ma and Hovy (2016) architecture, typically consists of three layers. First, it combines word embeddings (like GloVe) for semantic context with character-level representations (often using a CNN) to capture morphological structure and handle low-frequency or unseen words. Second, these inputs are fed into a Bi-directional LSTM to build a context-aware representation of each token from both directions of the sequence. Finally, a CRF sequence predictor is used as the output layer to ensure the predicted labels follow valid structural rules (e.g., an "Inside" tag must follow a "Beginning" tag), optimizing the entire sequence output rather than individual tokens.

---

## Week 5: Paper

SemEval-2020 Task 11: Detection of Propaganda Techniques in News Articles

Da San Martino et al. (2020) introduce a competition to detect and classify propaganda techniques in text. When reading this paper, do not be overly concerned with the different systems which took part in the competition. You will learn about the best-performing methods (transformer-based approaches including BERT) in a few weeks time. For now, we will focus on the overall idea of propaganda detection, the two tasks introduced in this paper (span identification and technique classification), the dataset and the evaluation metrics. Once you have read the paper, consider the following questions.

#### Paper Summary

The paper addresses the growing concern over online misinformation by proposing a computational framework to detect propaganda—communication used to influence an audience and further an agenda by using logical fallacies and emotional appeals.

Unlike previous work that classified entire articles as "propaganda or not," this paper focuses on a fine-grained analysis. It argues that propaganda is often embedded within otherwise factual text. Therefore, the goal is to identify the specific spans (text fragments) where propaganda occurs and then categorize which of the 14 specific techniques (e.g., Slogans, Name Calling, Fear) are being used.

#### The Two Subtasks
* SI (Span Identification): A sequence labelling task. Given a plain-text article, identify the start and end offsets of all propagandistic fragments.
* TC (Technique Classification): A sequence classification task. Given a specific span of text already identified as propaganda, classify it into one of 14 categories.

#### The Dataset (PTC-SemEval20)
The authors curated a corpus of news articles from various sources. The annotation process was rigorous, involving professional annotators and a specialized agreement metric ($\gamma$) to handle the difficulty of identifying overlapping and subjective text spans.

---

#### 1. What do you understand by the term propaganda and why might it be important to develop systems which can automatically detect propaganda in text?

Propaganda is a form of communication that aims to influence the attitude of a community toward some cause or position. It often relies on "loaded" language, emotional manipulation, and logical fallacies rather than rational discourse. Developing automated detection systems is vital to combat the spread of disinformation, prevent the manipulation of public opinion on a massive scale (especially in politics), and help users critically evaluate the information they consume online.

---

#### 2. Why is automatic propaganda detection difficult?
It is difficult because propaganda is often highly contextual and subtle. Unlike sentiment analysis, which might rely on specific "angry" or "happy" words, propaganda can use factual statements arranged in a manipulative way. Furthermore, there is significant subjectivity; what one person considers a "strong argument," another might label as "loaded language." Finally, the class imbalance is extreme—most text in a news article is non-propagandistic, making the spans hard to find.

---

#### 3. Give examples of 3 different propaganda techniques being used in text. Explain why this is propaganda.
1. Name Calling / Labeling: Labeling an opponent with a derogatory term (e.g., "The radical socialist candidate"). It simplifies a complex person into a negative label.
2. Appeal to Fear: Warning that a disaster will occur if a certain action isn't taken (e.g., "If we don't pass this law, our streets will be filled with crime"). It bypasses logic by triggering a survival instinct.
3. Slogans: Using brief, striking phrases that act as emotional triggers (e.g., "Make America Great Again" or "Forward"). They discourage critical thought by providing a pre-packaged conclusion.

---

#### 4. What textual features might be useful to help a system detect propaganda?
To detect these, a system might look for:
* Lexical Features: Loaded words, superlatives, and intensifiers.
* Sentiment/Emotion: High levels of negative or polarizing sentiment.
* Punctuation/Style: Excessive use of exclamation marks or "scare quotes."
* Structural Cues: Use of rhetorical questions or repetition.
* Word Embeddings: Capturing the "flavor" or context in which certain political terms appear.

---

#### 5. Describe the pipeline proposed by the paper for propaganda identification. Can you think of any alternatives? What advantages / disadvantages are there of each?
The paper proposes a sequential pipeline: first identify the spans (SI), then classify those spans (TC).
* Alternative: A Joint Model that performs both tasks simultaneously (e.g., a Bi-LSTM that outputs IOB tags with the technique name integrated, like B-Slogan).
* Pros/Cons: The sequential approach is simpler to train but suffers from "error propagation" (if the span is wrong, the classification will be too). The joint approach is more complex but allows the model to use the "technique type" to help find the boundaries.


---

#### 6. How was the PTC-SemEval20 corpus collected and annotated? What do you understand by “the γ agreement on the annotated articles is on average 0.6”?
The corpus was collected from news websites known for biased content and annotated by experts. The $\gamma$ (gamma) agreement is a metric specifically designed for tasks where annotators choose the length of a span. A score of 0.6 indicates "moderate to substantial" agreement. In the messy world of propaganda, where people disagree on exactly where a manipulative phrase starts and ends, 0.6 is considered quite high.

---

#### 7. How do the authors evaluate systems on the span identification task?
SI is evaluated using a partial match F1-score. Instead of requiring the model to find the exact character-level match, the authors use a formula that gives partial credit for overlaps between the predicted span and the "gold" (human-annotated) span. This accounts for the subjective nature of where a propagandistic phrase begins.


---

#### 8. Micro-average F1 is used to evaluate systems on the technique classification task. The authors state that for a single-label task, this is equivalent to accuracy. Explain
In the TC task, each propaganda span is assigned exactly one label. Because it is a single-label, multi-class task, every mistake counts as one False Positive for the guessed class and one False Negative for the correct class. Mathematically, this causes Precision, Recall, and F1 to converge to the same value: the total number of correct predictions divided by the total number of samples (Accuracy).

---

#### 9. Outline one method which could be used to carry out span identification.
A common method is Sequence Labelling using BIO encoding. Every word in an article is passed through a Bi-LSTM or CRF layer to be tagged as B-Prop (Beginning of propaganda), I-Prop (Inside), or O (Outside). This transforms the span-finding problem into a token-level classification task.

---

#### 10. Outline one method which could be used to carry out techniques classification.
Once a span is identified, it can be treated as a Sequence Classification task. The words in the span are converted into a single vector (via additive composition of embeddings or the hidden state of an RNN), which is then passed to a Softmax classifier to choose one of the 14 techniques.


---

#### 11. Systems were evaluated for span identification on both the development set and the test set. Why do you think the results are not the same on both?
Results often differ because of overfitting. A model might perform better on the Development set because researchers used that set to tune their hyperparameters (essentially "learning" the quirks of that specific data). The Test set is "blind" and often contains slightly different topics or writing styles, leading to a more realistic (and usually lower) performance score.


---

#### 12. What is the predominant propaganda technique found in the corpus? If a system labelled every propaganda snippet with this label, how would it do? What do you think of the system results for techniques classification (Table 6)?
If a system labeled every snippet with the predominant technique, Loaded Language, it would achieve a surprisingly high Micro-F1 score (approx. 0.40) simply due to the class imbalance. This score would be misleading, as it represents a total failure to identify the other 13 techniques. This is why researchers look at the results in Table 6 with skepticism; a high Micro-average often masks a model's inability to handle the "Long Tail" of rare but dangerous propaganda techniques like Causal Oversimplification or Straw Men.

In contrast, the Macro-average F1 for such a system would be extremely low (approaching 0.02). Because the Macro-average calculates the F1 score for each of the 14 classes independently before averaging them, the 13 classes that were never predicted would each receive a score of zero, heavily penalizing the final result. In the context of propaganda detection, the Macro score is a superior metric because it prevents a model from "gaming" the evaluation by only learning the most frequent technique (Loaded Language). It forces the system to demonstrate competence across the entire spectrum of propaganda, ensuring that rare but high-stakes techniques—like Appeal to Fear or Red Herrings—are not ignored in favor of the majority class.

In Micro-averaging, you don't calculate scores for each class individually. Instead, you pool all the True Positives (TP), False Positives (FP), and False Negatives (FN) from every class into one big pile and calculate a single F1 score from those totals. This allows the dominant class to take over and muddy score if left unchecked. 

In Macro-averaging, you treat each class as a separate entity, regardless of its size. You calculate the F1 score for Class A, Class B, and Class C independently. Then, you take the simple average: $\frac{F1_A + F1_B + F1_C}{3}$. Every class has a 33.3% weight in the final score. If your model fails completely on a tiny minority class, that "0" is averaged in with the others, dragging the final score down significantly. In the papers example, there are 13 other classes outside of Loaded Language which would provide an equal zero weight. 

---

## Week 5: Additional Reading

* [Jurafsky and Martin Chapter 4: Logistic Regresssion and Text Classificaton.](https://web.stanford.edu/~jurafsky/slp3/4.pdf)

* [Jurafsky and Martin Chapter 17: Sequence Labelling for Parts of Speech and Named Entities.](https://web.stanford.edu/~jurafsky/slp3/17.pdf)

---

<br>
<br>
<br>
<br>
<br>
<br>

# [Week 6 - Machine Translation](https://canvas.sussex.ac.uk/courses/36171/pages/week-slash-topic-6-machine-translation)

This week we will be looking at the application of Machine Translation (MT).  This can be seen as an example of a sequence generation or sequence transduction problem, where the input is a sequence in the source language and the output is a sequence in the target language.

In particular we will look at:
* what makes MT hard?
* Evaluation of MT
* Classical MT (pre-1990s)
* Statistical MT (1990-2015)
    * word-based models
    * phrase-based models
* Neural MT (2016 - )
    * Encoder-decoder models

#### Week 6: Contents

1. [Lecture](#week-6-lecture)
2. [Seminar](#week-6-seminar)
3. [Lab](#week-6-lab-content)
4. [Additional Readings](#week-6-additional-reading)

## Week 6: Lecture

This week, we explore Machine Translation (MT), a cornerstone of natural language processing that serves as the primary gateway into the complex world of sequence-to-sequence (seq2seq) transduction. Translation is fundamentally difficult because it requires more than a simple word-for-word swap; it demands that a system navigate deep lexical ambiguities, morphological differences, and varying syntactic structures across languages. We will trace the technological evolution of the field, moving from the early, rule-based Classical MT to the probabilistic Statistical MT (SMT) era, where the "Noisy Channel" model first introduced the balance between fluency and faithfulness. Finally, we will arrive at Neural Machine Translation (NMT), examining how the Encoder-Decoder architecture—boosted by Attention mechanisms and subword tokenization—has overcome the information bottlenecks and rare-word problems that plagued previous generations. By the end of this week, you will understand not just how models translate, but how we mathematically evaluate their "human-likeness" using metrics like BLEU and chrF.

* Classical MT (Pre 1990s); only talk about briefly
* Statistical MT (1990-2015); Word-based models, Phrase-based models.
* Neural MT (2015 - ); Encoder-decoder models

---

## Part 1: Machine Translation.

## Why is MT hard?

Machine Translation is fundamentally difficult because it requires more than a simple word-for-word swap; it involves navigating the complex, often incompatible systems of different languages. This challenge is rooted in **Linguistic Typology**, the study of how languages systematically differ in their "blueprints." These differences manifest as **Lexical Divergences**, where words have multiple meanings (polysemy) or lack direct equivalents, and **Structural Differences**, which include how words are built **(Morphology)** and how sentences are ordered **(Syntax)**. Because one language might express an entire concept in a single word while another requires a complex sentence, a translation system must do more than match definitions—it must reconstruct meaning across entirely different logical frameworks.

---

## Lexical Divergences

Lexical divergence occurs when languages categorize reality differently, creating a "one-to-many" mapping problem for translation models. This is often driven by **homonymy and polysemy**, where a single word in the source language—like "know"—must be split into distinct concepts in the target language, such as the French distinction between **savoir** (knowing a fact) and **connaître** (knowing a person). Languages also vary in their level of **granularity**; for instance, where English uses the broad term "brother," Chinese necessitates a choice between specific terms for "older" or "younger" brother. Furthermore, models must contend with **gender markings** in Romance languages, which require grammatical agreement not present in English, and **lexical gaps**, where a concept exists in one culture but has no direct equivalent in another, often resulting in loanwords. These divergences mean that a system cannot rely on a static dictionary; it must use context to "disambiguate" which specific version of a concept is being invoked.

---

## Morphological Differences

Morphology describes how languages construct words from morphemes (the smallest units of meaning). The challenge for MT lies in the "morpheme-to-word ratio," which varies wildly across a spectrum from Isolating to Polysynthetic languages.

**Isolating Languages:** Languages like Chinese or Vietnamese have a low ratio; words typically consist of a single morpheme, and grammatical relationships are shown through word order rather than word endings. English sits relatively low on this scale, leaning toward the isolating side.

**Synthetic Languages:** These use more morphemes per word and are subdivided into two categories:
* Agglutinative: In languages like Finnish or Turkish, morphemes are "glued" together in a clear, linear fashion. Each morpheme usually has one distinct meaning, making them easier for models to segment.
* Fusional: In languages like Russian or Latin, morphemes "fuse" together. A single suffix might simultaneously indicate gender, number, and case, making it much harder for a system to disentangle the individual bits of information.

**Polysynthetic Languages:** At the extreme end, languages like Inuktitut (Eskimo-Inuit) have an incredibly high morpheme-to-word ratio. A single word can contain enough morphological information to translate into an entire complex sentence in English.

For MT systems, this diversity creates a vocabulary problem: a system trained on English (isolating) might struggle to process the nearly infinite number of word forms possible in an agglutinative or polysynthetic language without breaking them down into sub-word units.
---

## Syntactic Differences

Syntactic divergence refers to the different rules languages use to arrange words into sentences, primarily defined by the order of the Subject (S), Verb (V), and Object (O). While English is a classic SVO language ("The cat [S] ate [V] the fish [O]"), others like Japanese are SOV, and languages like Arabic or Irish often follow a VSO pattern. Beyond basic word order, syntax also dictates where modifiers go—such as whether an adjective comes before the noun (English: "green apple") or after it (French: "pomme verte"). For Machine Translation, these differences mean the system cannot simply translate word-for-word in a linear string; it must "reorder" the entire structure to ensure the output is grammatically natural in the target language.

---

## Evaluation
Evaluation is the process of measuring how well a machine translation system performs, a task that is notoriously difficult because there is rarely a single "correct" answer. Historically, this has been divided into Human Evaluation, which is highly accurate but slow and expensive, and Automatic Evaluation, which is fast and scalable but less nuanced.

#### Human Evaluation
Human raters assess translation quality based on three primary pillars:

**Fluency:** Does the output sound like a native speaker of the target language? This is often measured on a scale of 1–5 or through a **"Cloze" task**, where words are deleted from the translation to see if a human can correctly guess them based on the surrounding context.

**Fidelity (Adequacy):** Does the translation convey the same information as the source text? This ensures no information was lost, distorted, or hallucinated during the process.

**Post-edit Cost:** A practical metric that measures the time and effort required for a professional human translator to fix the machine's output. If the "edit distance" is too high, the system may not be useful in a professional setting.

#### Automatic Evaluation
Because human evaluation cannot be performed every time a model is updated, the industry relies on algorithmic metrics. The most famous is **BLEU** (Bilingual Evaluation Understudy), introduced in 2001, which compares the machine's "hypothesis" to one or more human "references" based on word overlaps. More recently, researchers have shifted toward **chrF** (Character n-gram F-score), which operates at the character level to better handle languages with complex morphology or different tokenization standards.

---

## Understanding BLEU (Bilingual Evaluation Understudy)
The **BLEU** metric remains the most influential automatic evaluation tool for Machine Translation. It works by comparing a machine-generated **hypothesis** against one or more human-generated **references.** The core idea is that the closer a machine translation is to a professional human translation, the better it is.

#### 1. Precision vs. Recall Refresh
To understand why BLEU is built the way it is, we first need to refresh the fundamental definitions of Precision and Recall:

**Precision:** "Of all the words the model predicted, how many are actually correct?" It measures **quality** and accuracy.
* Formula: $Precision = \frac{TP}{TP + FP}$

**Recall:** "Of all the words that should have been there, how many did the model find?" It measures **completeness.**
* Formula: $Recall = \frac{TP}{TP + FN}$

#### 2. Why BLEU Favors Precision
In Machine Translation, **Recall is problematic.** Because there are dozens of valid ways to translate a single sentence, a machine might produce a perfect translation that uses entirely different synonyms than the human reference. If we penalized the model for not using the exact words in the reference (Recall), we would be punishing valid creativity.

**BLEU's philosophy** is that we don't necessarily need the model to find every possible word used by humans, but we must ensure that every word it does produce is justified by at least one human reference.

#### 3. Modified N-gram Precision
A "naive" precision count is easily "gamed." If a model outputs "the the the the the," and the word "the" appears in the reference, the model would get a perfect $5/5$ precision. BLEU fixes this with **Modified Precision:**
1. For each word in the hypothesis, count its maximum frequency in any single reference ($m_{max}$).
2. Clip the hypothesis count so it does not exceed $m_{max}$.
If "the" appears twice in the reference, the hypothesis "the the the the the" is clipped to $2/5$ precision.

#### 4. The Combined Score: N-grams and Brevity
BLEU doesn't just look at single words (unigrams); it looks at sequences of 2, 3, and 4 words **(bi-grams, tri-grams, and quad-grams)** to ensure the translation is fluent and captures the correct order.

The final BLEU score is calculated by taking the **geometric mean** of these modified precisions. However, precision has one more weakness: it favors short sentences. If a model only outputs the one word it is most sure about (e.g., "The."), its precision will be $100\%$. To prevent this, BLEU introduces a **Brevity Penalty (BP).**

$$BLEU = BP \cdot \exp\left(\sum_{n=1}^{N} w_n \ln p_n\right)$$
* $p_n$: Modified n-gram precision.
* $w_n$: Weights (typically $1/4$ for each n-gram up to $N=4$).
* $BP$: Penalizes the score if the hypothesis is shorter than the reference.

#### 5. Strengths and Weaknesses

**Strengths:** It is fast, inexpensive, and correlates well with human judgments when comparing similar systems. It effectively tracks incremental improvements during model development.

**Weaknesses:** It does not capture meaning (semantics) well. A model could use a synonym and get a lower score despite being "correct." It also struggles with languages that don't use spaces (like Chinese) or have very complex morphology.

---

## chrF: Character n-gram F-score
While BLEU has been the industry standard for decades, chrF (introduced by Maja Popović in 2015) has gained significant traction, especially for languages with complex morphology (like Finnish or Turkish). Instead of looking at whole words, chrF operates at the character level, making it much more robust against different tokenization standards and spelling variations.

#### 1. Why Character n-grams?
**Tokenization Independence:** Some languages don't use spaces (Chinese), and different systems might split words differently (e.g., "don't" vs "do n't"). By looking at characters, chrF bypasses these inconsistencies.

**Morphological Awareness:** In highly synthetic languages, a "word" can have dozens of forms. BLEU would treat "run" and "running" as totally different entities (0% overlap), but chrF sees the shared "r-u-n" characters and gives credit for the similarity.

#### 2. Bringing Back Recall
As you noted, BLEU avoids Recall because it’s hard to perfectly match a human's specific vocabulary choice. However, chrF argues that if we are comparing multiple systems against the same human reference, any "low recall bias" is normalized across all systems. If the human reference is "different," it’s different for everyone. By including Recall, chrF gets a better sense of whether the model translated enough of the content, not just whether the snippets it produced were accurate.

#### 3. The Math and the $\beta$ Parameter
The chrF score is calculated by finding the character n-gram Precision (chrP) and character n-gram Recall (chrR) and combining them into an F-score.

$$chrF_\beta = (1 + \beta^2) \cdot \frac{chrP \cdot chrR}{(\beta^2 \cdot chrP) + chrR}$$

#### Why does a high $\beta$ weight Recall more?
This is a common point of confusion. In the General F-score formula, $\beta$ is a coefficient that determines "how many times more important Recall is than Precision."
* If $\beta = 1$: Precision and Recall are equally weighted (F1).
* If $\beta = 2$: Recall is considered twice as important as Precision.
* The "Why": Look at the denominator: $(\beta^2 \cdot chrP) + chrR$. When $\beta$ is large, the $chrP$ term is multiplied by a much larger number, making the whole denominator very sensitive to changes in $chrP$. To keep the score high, the $chrR$ in the numerator must "work harder." Effectively, $\beta$ acts as a "magnifier" for the importance of Recall. In MT research, $\beta=2$ (chrF2) is the most common setting.

#### chrF Summary
chrF provides a more granular evaluation than BLEU by shifting the focus from words to character n-grams. By including both Precision and Recall, it offers a more balanced view of translation quality, particularly for "morphologically rich" languages where word-level matching is too strict. The use of the $\beta$ parameter (usually set to 2) allows the metric to prioritize Recall, ensuring the system doesn't just produce accurate fragments but actually captures the full breadth of the source information.

---

## PART 2: Approaches to Machine Translation

The evolution of machine translation can be visualized as a journey from rigid, human-defined logic to flexible, data-driven probability. Historically, this began with Classical MT, dominated by the Vauquois Triangle, which relied on complex rules and linguistic "transfer" to bridge languages. By the 1990s, the field underwent a paradigm shift toward Statistical Machine Translation (SMT). This approach abandoned manual rules in favor of the Noisy Channel Model, treating translation as a mathematical problem of maximizing faithfulness and fluency using massive parallel corpora. Within SMT, the technology moved from basic Word-Based Models to more sophisticated Phrase-Based Models, which treat groups of words as single atomic units to better capture context and idioms. Understanding these foundations is essential, as the concepts of decoding, alignment, and beam search established during this era remain the backbone of modern neural systems.

---

## Classical MT: Vauquios Triangle

Before the 1990s, machine translation relied on human-engineered rules rather than data. The Vauquois Triangle illustrates the various levels of linguistic "depth" these systems used: Direct Translation performed a simple word-for-word swap with minor reordering; Transfer-based systems mapped the grammatical structure (syntax) of one language onto another; and Interlingua attempted the most ambitious path by converting source text into a language-neutral "universal" meaning before translating it into any target language. While conceptually elegant, these systems were ultimately too rigid and brittle to handle the infinite nuances and exceptions found in real-world human speech.

---

## Statistical Machine Translation

Statistical Machine Translation shifted the focus of the field from the linguistic process (the "how" of grammar rules) to the mathematical results (the "what" of data patterns). Rather than teaching a computer the rules of a language, SMT uses parallel corpora—huge datasets of human-translated sentence pairs—to learn the statistical likelihood that a specific word or phrase in one language corresponds to another. At its core, SMT defines a "good" translation through two competing goals: **faithfulness**, ensuring the output contains the exact same information as the source, and **fluency**, ensuring the output sounds natural to a native speaker. By treating translation as a search for the most probable target sentence given a source input, SMT replaced hand-coded rules with a supervised learning framework that could scale across any language pair with enough available data.

---

## The Bayesian Noisy Channel Model
The **Noisy Channel** is a classic concept in information theory applied to SMT. It works on a counter-intuitive premise: imagine that a person originally thought of a sentence in English ($E$), but as it passed through a "noisy channel" (a translator's brain), it was corrupted into French ($F$). To translate it back, we want to find the original English sentence that was most likely to have "generated" that French output.

We formalize this using Bayes' Theorem to find $\hat{E}$ (the best English hypothesis):

$$\hat{E} = \arg\max_{E} P(F|E) \cdot P(E)$$

This formula allows us to split the translation problem into two distinct specialized models:

#### 1. The Language Model $P(E)$: Fluency
The Language Model is responsible for **Fluency.** It ignores the source language entirely and asks: "How likely is this string of English words to be a valid, natural sentence?" **Data:** It is trained on vast **monolingual** corpora (just English text).

**Logic:** It uses n-grams to assign higher probabilities to grammatically correct sequences (e.g., "the cat sat") and low probabilities to nonsense (e.g., "sat cat the").

#### 2. The Translation Model $P(F|E)$: Faithfulness
The Translation Model is responsible for **Faithfulness.** It asks: "Given the English sentence E, how likely is it that the French sentence F is its translation?"

**Word Alignment:** Early models used simple word-to-word mappings. While they often started with a "1-to-1" assumption (one English word = one French word), they eventually evolved to handle "1-to-many" or "many-to-1" alignments.

**Note:** While $P(F|E)$ looks "backward" (mapping English to French to solve a French-to-English problem), it ensures that the core information remains intact.

#### Estimating Probabilities with EM
To train these models, we use **Sentence Aligned Data** from parallel corpora. However, even if we know two sentences are translations of each other, we don't know exactly which words align to each other. This is solved using the **Expectation-Maximization (EM)** algorithm:
1. **E-step (Expectation):** Use the current model to calculate the most likely alignments between words in the parallel sentences.
2. **M-step (Maximization):** Use those alignments to update the translation probabilities (e.g., how often "chat" corresponds to "cat").
3. **Iterate:** Repeat until the model converges on the most statistically sound alignments.

---

## From Word-Based to Phrase-Based Models
The transition from word-based to **Phrase-Based Machine Translation** (PBMT) was a major breakthrough in SMT. Word-based models were limited by the assumption that the fundamental unit of translation is a single word, which made it nearly impossible to handle **non-compositional phrases.**

>#### What is Compositionality?
>In linguistics, a phrase is compositional if its meaning is simply the sum of its parts (e.g., "white house" = an object that is white + a house). A non-compositional phrase is an idiom or fixed expression where the individual words don't add up to the literal meaning (e.g., "kick the bucket" means "to die," not an action involving a foot and a pail).

Phrase-based models solve this by treating sequences of words as atomic units. This allows for many-to-many mappings, capturing context and local reordering much more effectively than word-for-word translation.

---

## Phrase Alignment and Translation
To build a phrase-based system, we must first learn which phrases correspond to each other. This is done through a process of symmetrization:
1. **Alignment in Both Directions:** We run a word-alignment algorithm from source-to-target (one-to-many) and then from target-to-source (many-to-one).
2. **Symmetrization:** We combine these two sets of results. Often, we start with the intersection (only the alignments both directions agree on) and grow it toward the union (all alignments found in either direction) using specific heuristics. This creates a "grid" or "matrix" of alignments that reveals multi-word blocks.
3. **Phrase Translation Table:** Once aligned, we extract these blocks and store them in a table. For every phrase pair $(f, e)$, we calculate the Maximum Likelihood Estimate (MLE) probability: $$P(f|e) = \frac{\text{count}(f, e)}{\sum_{f'} \text{count}(f', e)}$$ This tells us, "Given the English phrase $e$, how likely is it that the French translation is $f$?" During translation (decoding), the model looks up this table to find all possible "translation options" for each segment of the sentence.

---

## Standard Model of Phrase-Based Machine Translation (PBMT)
As SMT matured, it moved away from the strict "Noisy Channel" Bayesian math and toward a more flexible Log-Linear Model. Instead of just two probabilities ($P(E)$ and $P(F|E)$), the model combines multiple "feature functions" ($h_i$) weighted by importance ($\lambda_i$).

The formula for finding the best translation $\hat{e}$ is: $$\hat{e} = \arg\max_{e} \sum_{i=1}^{n} \lambda_i h_i(e, f)$$

---

## Generative vs. Discriminative Models
You asked about the fundamental shift here:

**Generative (Bayesian):** Like the Noisy Channel, this tries to model the actual process of how data is created. It’s "strict"—every component must fit into the rules of probability ($P(A|B)$).

**Discriminative (Log-Linear):** This doesn't care about the "birth" of the sentence. It simply takes the input $f$ and looks for the $e$ that "scores" the highest based on a list of arbitrary features.The Advantage: It’s much easier to add non-probabilistic features, like a word penalty (to prevent the model from being too "chatty" or too brief) or a reordering model (to handle SVO vs. SOV differences).

---

## Inference and Training
**Training:** In PBMT, we learn the weights ($\lambda_i$) for each feature. We usually use a small set of parallel data (a "tuning set") and adjust the weights until the system produces the highest BLEU score.

**Inference:** This is the Decoding process—taking a new French sentence and using the learned weights to find the best English translation.

---

## Decoding: The Search Problem
Because there are an astronomical number of ways to combine phrases, **exhaustive search** (checking every possible English sentence) is mathematically impossible. This is why we treat decoding as a **Heuristic Search.**

**"Large Space" meaning:** Even with a phrase table, a 20-word sentence could have billions of potential permutations and phrase combinations. The "space" refers to the total number of paths the model could take from the first word to the period at the end.

**Best-First Search & Beam Search:** The decoder builds a translation from left to right. It stores partial translations (hypotheses) in a "stack" or priority queue. **"Pruning" and the Beam:** To keep the search from exploding, we use Beam Search. We only keep the $k$ most promising partial sentences (the "Beam"). Any hypothesis with a "high cost" (a very low probability) is **pruned**—literally deleted from the queue—so the computer doesn't waste time following a path that is likely to be a bad translation.

---

## Shortcomings of PBMT
Despite being the "Gold Standard" from 2006 to 2016 (powering early Google Translate), PBMT had two major "battles":
1. **Memory Bloat:** The phrase translation tables became gargantuan (millions of rows), making them difficult to store and query on standard hardware.
2. **Lack of Generalization:** Phrases are treated as **atomic strings.** In PBMT, the phrase "blue house" and "green house" share zero statistical connection. The model doesn't know "blue" and "green" are both colors; it has to learn the translation for every possible adjective-noun combination from scratch. This "sparsity" is what eventually led to the Neural revolution.

---

## Part 3: Neural Machine Translation (NMT)

Neural Machine Translation revolutionized the field by moving away from counting phrase frequencies in tables to using continuous vector representations. This allowed models to "generalize"—understanding that "blue" and "green" are related concepts—and to handle long-range context much more effectively.

---

## The Encoder-Decoder Architecture
The basic NMT architecture is a **Sequence-to-Sequence (seq2seq)** model. It acts as a two-part system:

**The Encoder (RNN1):** Reads the source sentence one word at a time, updating its hidden state. The final hidden state ($h$) acts as a "thought vector"—a mathematical summary of the entire input sentence.

**The Decoder (RNN2):** Takes that summary vector and begins generating the target language word by word. Each word generated ($y_i$) becomes an input for generating the next word ($y_{i+1}$).

---

## From RNNs to LSTMs

While vanilla RNNs were a start, they suffered from the **Vanishing Gradient problem**, meaning they "forgot" the beginning of a sentence by the time they reached the end.

**LSTMs (Long Short-Term Memory):** These were the workhorse of NMT until 2017. They use a complex "gate" system (input, forget, and output gates) to decide which information to keep and which to discard, allowing the model to link words far apart in a sentence (e.g., matching a subject at the start with a verb at the end).

---

## Encoder-Decoder Details

In most classic "Sequence-to-Sequence" tasks (like Translation or Speech-to-Text), no, you never discard the encoder. You need it for every single sentence you process.

Think of it like a Translator (Encoder) and a Writer (Decoder) working together in a room.

There is one specific scenario where the Encoder is "set aside," and that is Generative Pre-training (like GPT).

GPT-style models are Decoder-only. They don't have an Encoder at all! They are trained to just "continue" a sequence.

BERT-style models are Encoder-only. They are great at "understanding" text, but they are terrible at writing long sentences.

---

## Potential Weaknesses of NMT

Despite its revolutionary success, the early "Sequence-to-Sequence" Neural Machine Translation (NMT) models faced several significant hurdles. Structurally, the reliance on recurrent architectures like LSTMs led to slow training and inference speeds, as words must be processed one at a time rather than in parallel. Mathematically, these models struggled with rare words; because they relied on a fixed vocabulary, any word outside the top 30k–80k most frequent terms was often replaced with a generic "unknown" (UNK) token. Furthermore, the information bottleneck created by squashing a whole sentence into a single vector often resulted in "forgetting" details from the beginning of long sentences or failing to translate every word in the input. This led to issues with adequacy, where a translation might sound fluent but actually leave out crucial parts of the original message.

---

## Rare Words

- Due to computational constraints, NMT systems usually limited to top 30K-80K of most frequent words in each language
- Unknown/rare words can be translated using a dictionary or exact copy provided it is known which source word generated UNK token in target.
- Problem when sentence contains multiple rare words
- Luong et al. first use a word alignment of parallel corpora and annotate unknown words with positional information (e.g., UNK1); not common anymore
- Output from NMT can then be post-processed

---

## Solving the Rare Word Problem: Subword Tokenization
NMT systems have a limited vocabulary (usually 30k–80k words) because every extra word makes the model slower and more memory-intensive. This created a crisis with rare words or names (the UNK problem).

**The Solution: Subword Tokenization (like BPE - Byte Pair Encoding).**

Instead of looking at whole words, the model breaks rare words into common chunks. For example, "unhappy" might be split into un + happy. 

The model can translate words it has never seen before by assembling them from known sub-units, much like a human can figure out the meaning of an unfamiliar word by its prefix or suffix.

Common algorithms include: BytePiece Encoding (BPE);Wordpiece algorithm (next week); Unigram / SentencePiece algorithm. 

---

## Overcoming the Bottleneck: Attention

The biggest weakness of early seq2seq models was the **Bottleneck**. Forcing a 50-word sentence into a single fixed-size vector $h$ caused a massive loss of detail. 

Attention changed the game. Instead of the Decoder looking only at the last hidden state of the Encoder, it is allowed to "look back" at all the Encoder's hidden states for every word it generates.

The Mechanism: For each output word, the model calculates a weighted sum of the input states. The "Attention Weights" ($a_{ij}$) tell the model which specific source words to "attend to" right now. If it's translating the word "cat," the weights will spike on the original French word "chat."

---

### The GNMT Peak (2016)

Google's Neural Machine Translation (GNMT) represented the peak of the Recurrent era. It used deep LSTMs (8 layers), residual connections to keep the data flow healthy, and a refined version of Attention. It also introduced specialized hardware (TPUs) to make the math faster. While Transformers (which we will cover in the coming weeks) have since replaced LSTMs because they are easier to parallelize, the fundamental concepts of Attention and Subword Tokenization remain the core pillars of modern MT and Large Language Models (LLMs).

---

<br>
<br>
<br>

## Week 6: Seminar

#### 1. What makes Machine Translation a hard problem?

Machine Translation is a "hard" problem primarily due to **Linguistic Typology**, which highlights the systematic differences between languages. These include **Lexical Divergences**, where words have multiple meanings (polysemy) or no direct equivalent (lexical gaps), and **Structural Divergences** involving **Morphology** (how words are built) and Syntax (word order like SVO vs. SOV). Because one language may use a single complex word (polysynthetic) while another uses an entire sentence (isolating), a system must do more than swap words; it must resolve deep ambiguity and restructure the entire logic of the sentence to remain natural in the target language.

#### 2. What aspect of MT can be evaluated by monolingual raters and what aspect requires bilingual raters?

In human evaluation, **monolingual raters** (who only speak the target language) are typically used to assess **Fluency**. They can judge if the translated text sounds natural, grammatical, and "native," often using scales or **Cloze tasks**. However, they cannot verify if the meaning is correct. **Bilingual raters** are required to assess **Fidelity (Adequacy)**. Because they understand both the source and the target, they can determine if the information was transferred accurately or if any crucial details were lost, distorted, or ignored during the translation process.

#### 3. What do BLEU and chrF have in common? How are they different?

Both BLEU and chrF are automatic, string-based metrics that evaluate a machine "hypothesis" against a human "reference" by looking for overlaps (n-gram precision). The key difference lies in the unit of measurement: BLEU operates at the word level, while chrF operates at the character level. This makes chrF superior for morphologically rich languages where word endings change frequently. Furthermore, while BLEU famously focuses almost exclusively on Precision (to avoid penalizing valid stylistic choices), chrF incorporates Recall and uses a $\beta$ parameter (usually $\beta=2$) to give more weight to capturing all the content from the reference.

#### 4. What are some of the key components / choices in setting up a statistical MT system?

Setting up a traditional SMT system involves several critical components centered around the Noisy Channel Model. The system requires a Parallel Corpus for the Translation Model ($P(F|E)$) to learn faithfulness/word alignment, and a large Monolingual Corpus for the Language Model ($P(E)$) to ensure fluency. Key design choices include deciding between a word-based or phrase-based approach (handling non-compositional idioms), choosing a symmetrization method for word alignments, and configuring a Decoder with an appropriate Beam Search width to manage the massive search space during inference.

#### 5. Why should neural MT work better?

NMT is theoretically superior because it replaces discrete, atomic phrase tables with continuous Vector Representations (embeddings). This allows the model to generalize; it understands that "blue" and "green" are related concepts and can share statistical strength between them. By using an Encoder-Decoder architecture with Attention, NMT can look at the entire source sentence contextually rather than in isolated chunks. This eliminates the "independence assumptions" of SMT, allowing for more fluent translations, better handling of long-range dependencies, and—through subword tokenization—a more robust way to handle rare or unseen words.

---

## Week 6: Lab Content

I won't be publishing solutions this week as this lab forms the basis of the assignment.  Please do talk to the TAs in the lab if you have any questions about what to do or what you have done.

## Week 6: Additional Reading

* [Jurafsky and Martin (2026), Chapter 12 Machine Translation](https://web.stanford.edu/~jurafsky/slp3/12.pdf) **READ THIS CHAPTER**
* [Examining Large Pre-Trained Language Models for Machine Translation: What You Don't Know About It](https://arxiv.org/abs/2209.07417)
* [Improving Transformer based Neural Machine Translation with Source-side Morpho-linguistic Features](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=9355969&tag=1)

---

<br>
<br>
<br>
<br>
<br>
<br>

# [Week 7 - Pre-trained Large Language Models](https://canvas.sussex.ac.uk/courses/36171/pages/week-slash-topic-7-pre-trained-large-language-models?module_item_id=1602174)

* [Part 1](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=b96e8892-d9f8-4cea-b882-b40400d5565b&start=147.986053)
* [Part 2](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=59c201de-b7eb-40a6-9857-b40400dc767e&start=7.674165)
* [Part 3](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=92b62899-8491-499e-826b-b40400e48bda&start=0)

This week we will start looking at pre-trained large language models:
* paraphrase identification and semantic matching
* contextualised word embeddings
* transformer architecture
* Bidirectional Encoder Representations from Transformers (BERT)
* pre-training large language models

#### Week 7: Contents

1. [Lecture](#week-7-lecture)
2. [Seminar](#week-7-seminar)
3. [Lab](#week-7-paper)
4. [Additional Readings](#week-7-additional-reading)

## Week 7: Lecture
This week moves from Static Embeddings (Word2Vec/GloVe), which give a word the same vector regardless of context, to Contextualized Embeddings, where the vector for "bank" changes depending on whether you are talking about money or a river. We are leaving behind Recurrence (LSTMs), which process words one-by-one, for Parallelism (Transformers), which look at the whole sentence simultaneously using Self-Attention. This is the era of Pre-training and Fine-tuning. Instead of training a model from scratch for one task, we train a massive model (like BERT) to "understand language" generally, then tweak it for specific tasks.

#### Overview 
* Paraphrase and semantic matching
    * Applications
    * Composition of distributional representations of meaning
* Contextualised word embeddings
    * ELMo
* Large language models
    * Transformers
    * BERT
    * Pre-training

---

## Semantic Matching and Paraphrase Identification
At the sequence level, we move beyond classifying individual words to understanding the relationship between entire strings of text. Paraphrase Identification is the task of determining if two sequences mean exactly the same thing. Semantic Matching is a broader category that measures the degree of similarity in meaning between two sequences.

---

#### Core Applications
Understanding semantic similarity is vital for several high-stakes NLP tasks:
* **Question Answering (QA):** Identifying that "Who is the head of the UK government?" and "Who is the British PM?" require the same answer.
* **Text Simplification & Summarization:** Ensuring that a shorter or simpler version of a text retains the original meaning without "hallucinating" new information.
* **Automated Marking:** Checking if a student's open-ended answer matches the semantic intent of a marking scheme.
* **Information Retrieval & Recommendation:** Clustering documents or suggesting content based on topical and conceptual similarity rather than just keyword matches.

See: [Yang et al. (2020)](https://arxiv.org/pdf/2004.12297.pdf) for a discussion of 4 different categories of semantic matching problems in NLP 

---

#### The Evolution of Text Matching
To determine if two sentences match, we have moved from "shallow" surface statistics to "deep" semantic representations.

#### 1. Surface-Level Matching (Lexical Overlap)
The simplest way to match text is to look for shared words.
* **Jaccard’s Coefficient:** A simple measure of the intersection of words divided by the union of words in two sets.
* **TF-IDF (Term Frequency-Inverse Document Frequency):** A weighting scheme that prioritizes "important" words. It gives high weight to words that appear often in a specific document but rarely across the whole collection (e.g., "Prime Minister" gets more weight than "the").
* **Vector Space Models:** Representing documents as Bag-of-Words vectors and calculating the Cosine Similarity between them.

#### 2. The Disadvantages of Simple Matching
While fast, surface-level matching is easily "blinded" by the following:
* **Lack of Synonymy:** Two sentences can share zero words but be identical in meaning. In your example:
    * "Who became the **head of the UK government** in 1951?"
    * "Who was elected as **British prime minister** in 1951?"

    A TF-IDF or Jaccard model would see very little overlap here because the key entities ("head of UK gov" vs "PM") use entirely different tokens.
* **Word Order Ignorance:** Bag-of-words models cannot distinguish between "The dog bit the man" and "The man bit the dog."
* **Polysemy:** Simple matching treats every instance of "bank" the same, whether it refers to a river or a financial institution.

--- 

## The Principle of Compositionality
To solve the failures of simple matching, we rely on the Principle of Compositionality (attributed to Gottlob Frege). It states that the meaning of a complex expression is determined by:
1. The meanings of its constituent expressions (the individual words/embeddings).
2. The rules used to combine them (the syntax/structure).
The goal of modern NLP is to find a mathematical way to "compose" individual word embeddings into a single sequence-level representation that captures both the definitions of the words and the logic of their arrangement.

---

#### Composition for Meaning Representations
Constituent expressions are words; could also extend to phrases where appropriate. Words can be represented by distributional representations / embeddings (e.g., Word2Vec or GloVe). So, to get a representation of a sequence we need to compose the embeddings of the constituent words

How? What are the rules for composition?

---

#### Additive Composition (Centroid Models)
A simple approach to sequence representation is Additive Composition, where we combine individual word embeddings to create a single vector for the entire phrase or sentence.
* **The Method:** We calculate the sum or the average (the centroid) of the word vectors in the sequence.
* **Vector Geometry:** Because we typically use Cosine Similarity to measure how close two sequences are, the magnitude (length) of the vector matters less than its direction. Mathematically, adding vectors and averaging vectors results in the same directional orientation, meaning they are functionally identical for similarity tasks.
* **The Goal:** In an ideal semantic matching system, the sum of "head" + "of" + "UK" + "government" should result in a vector that is spatially very close to the sum of "British" + "leader".

---

#### Why Adding Word Embeddings Fails
While additive composition is computationally "cheap," it is a "lossy" process that fails to capture true linguistic meaning for three critical reasons:

#### 1. Uncontextualized "Senses" (The Polysemy Problem)
Static word embeddings (like Word2Vec or GloVe) are uncontextualized. They represent a word as a single point that collapses all its possible meanings into one "average" vector.

Example: The word "head" has multiple senses (part of the body vs. leader of a country). In a static embedding, the vector for "head" is a mixture of both. When you add it to a sentence, the model cannot "discard" the body-part meaning, leading to a noisy and inaccurate representation.

#### 2. Loss of Syntax and Word Order
Addition is commutative ($A + B = B + A$). This means an additive model is functionally "blind" to the order of words, which is often where the meaning resides.

Example: "Glass house" and "house glass" result in the exact same vector, despite referring to two completely different objects. The syntax (the rules of combination) is completely erased.

#### 3. The "Noise" of Function Words
Additive models struggle with function words (e.g., of, in, on, the, not).

In the phrase "head of UK government," the word "of" performs a specific logical function. However, in a global vector space, "of" is such a common and generic word that its vector is often "diluted" or acts as mathematical noise, contributing nothing to the specific semantics of the leadership role.

---

## From Sequence Representations to Contextualized Embeddings
To move beyond the limitations of simple addition, we must look at how words interact within a sentence. This shift relies on **Language Modeling**, where the meaning of a sequence is derived from the way words predict one another. In a Recurrent Neural Network (RNN) framework, we process a sentence in two directions: a **Forward RNN** reads from left to right, while a **Backward RNN** reads from right to left. By concatenating the final hidden states of both—the last state of the forward pass and the first state of the backward pass—we create a **Sequence Representation**. This single vector acts as a summary of the entire sentence, "remembering" the history of word transitions from both ends.

The leap from a "sequence summary" to **Contextualized Word Embeddings** happens when we shift our focus from the end of the sentence to each individual time step. Instead of one vector for the whole sentence, we produce a unique vector for every word in the sentence by concatenating the forward and backward hidden states at that specific position ($t$). While the input to the RNN is still a static, uncontextualized embedding (like Word2Vec), the RNN’s internal "memory" infuses that word with the influence of its neighbors.

The intuition here is that the word "head" at time step $t$ is no longer just a generic point in space; it is now a vector informed by the words that came before it (e.g., "British") and the words that follow it (e.g., "government"). This process effectively "disambiguates" the word in real-time. Once we have these rich, contextualized embeddings, we can compose them—through averaging or more complex layers—to create a sequence representation that is far more accurate than one built from static, "context-blind" vectors.

---

## ELMo: Embeddings from Language Models
ELMo (Peters et al., 2018) marked a major milestone in NLP by formalizing the shift from static to contextualized word embeddings. Unlike Word2Vec, which gives "bank" the same vector every time, ELMo produces word representations that are dynamic functions of the entire input sentence.

---

#### The Deep Bi-LSTM Architecture
ELMo is built on a stack of Bidirectional LSTMs (Bi-LSTMs). In this deep model, the representation of a word isn't just a single output; it is a linear combination of all the internal layers of the network. This "stacked" approach allows the model to capture a hierarchy of linguistic information:
* **Lower Layers:** Tend to capture syntactic information (e.g., part-of-speech tags or grammatical structure).
* **Higher Layers:** Capture more semantic, context-dependent meaning (e.g., word sense disambiguation).
As you move up the stack—from the first Bi-LSTM layer to the second or third—the "receptive field" of each word grows. The second layer is contextualized by the immediate neighbors, while higher layers can resolve long-range dependencies across the entire sentence.

---

#### How ELMo Embeddings are Formed
Rather than just using the top layer of the network, ELMo creates a final embedding by collapsing all internal layer representations into one.
1. Layer-Specific Vectors: For every token, each layer (the character-convolution input and the multiple Bi-LSTM layers) produces its own vector.
2. Weighted Sum: These layers are combined using a weighted sum. During the "fine-tuning" phase for a specific task (like sentiment analysis), the model learns which layers are most important for that task.
3. Task-Specific Scaling: A scalar parameter is applied to the final result, allowing the model to scale the ELMo representation to fit the needs of the subsequent neural model.

---

#### Semi-Supervised Learning Paradigm
The brilliance of ELMo lies in its two-step training process. First, the Bi-LSTMs are pre-trained at a massive scale on unlabeled text using a language modeling objective (predicting the next word). Then, these "frozen" pre-trained weights are used to generate rich embeddings that can be plugged into a smaller, task-specific model. This allowed researchers to achieve state-of-the-art results on various benchmarks with significantly less labeled data.

---

## The Transformer Revolution: Beyond Recurrence
The introduction of the Transformer (Vaswani et al., 2017) represents the next logical evolution from ELMo and LSTMs. While ELMo improved word representations by using bidirectional LSTMs, it was still hampered by the fundamental nature of recurrence. In an RNN or LSTM, words must be processed sequentially; the model cannot understand word 10 until it has processed words 1 through 9. This creates a computational bottleneck and makes it difficult to capture relationships between words that are far apart in a long sentence.

The Transformer breaks this mold by abandoning recurrence entirely in favor of Global Self-Attention. This allows the model to look at every word in a sentence simultaneously, regardless of their distance.

#### Key Innovations
* **Parallelization:** Because there is no "waiting" for the previous time step, Transformers can be trained much faster on modern hardware (GPUs). This efficiency allowed researchers to train much larger models on significantly more data.
* **Sequence Transduction:** At its core, a Transformer is a sequence **transduction model** — a system designed to "transform" one sequence (like a French sentence) into another (like an English sentence). It does this through an **Encoder-Decoder** framework where the encoder builds a map of the input and the decoder uses that map to generate the output.
* **Stacked Self-Attention:** Instead of using layers of LSTMs, the Transformer uses "stacks" of **Self-Attention** layers. Each layer allows every word in the sequence to "attend" to every other word, gradually building up a deep, multi-layered understanding of the sentence's structure and meaning.

---

## Encoder-Decoder Architecture in Transformers
The Transformer architecture follows a classic Sequence-to-Sequence (Seq2Seq) framework, but it replaces the traditional recurrent units (LSTMs/RNNs) with attention-based blocks. The primary goal is Sequence Transduction: taking an input sequence (like a sentence in French) and "transducing" it into an output sequence (like the English translation).

#### The Encoder's Role: Building the Latent Space
The Encoder is responsible for "understanding" the input. It takes the raw sequence and processes it through a series of layers to produce a high-dimensional representation in a latent space. Unlike older RNNs that produced a single "summary vector" at the very end, the Transformer Encoder produces a set of encodings that capture the relationship between every word in the sentence simultaneously. This result is often called the Encoder Vector or Context, which serves as the "map" for the decoder to follow.

#### The Decoder's Role: Generating the Output
The Decoder is the "writer" of the system. It takes the latent representations from the encoder and generates the output sequence one token at a time. It is auto-regressive, meaning it uses the words it has already generated as part of the input for the next word. It has a unique "Cross-Attention" mechanism that allows it to look back at the Encoder's map to ensure it is staying faithful to the original input.

---

#### Stacked Networks: Depth and Complexity
In the standard "Vanilla" Transformer (Vaswani et al., 2017), the model is not just one encoder and one decoder, but a **stack** of them—typically **six layers deep** for each.
* **N=6 Layers:** By stacking six identical layers, the model can learn increasingly abstract features. The first layer might focus on simple grammar (syntax), while the sixth layer understands complex relationships and intent (semantics).
* **Inter-connectivity:** Every decoder in the stack has access to the output of the final encoder. This ensures that no matter how deep the decoding process goes, the model never "loses sight" of the original source text.
* **Dimensionality:** In the original paper, all layers and sub-layers produce outputs of 512 **dimensions**. This consistent size allows the data to flow through the "stack" without needing to be resized, maintaining a stable representation across the entire network.

---

## The Transformer Architecture: Detailed Components
The Transformer is a sophisticated "sandwich" of identical layers designed to process sequences in parallel. Unlike RNNs, which pass a hidden state from one word to the next, the Transformer uses its entire stack to build a multi-dimensional "map" of the input all at once.

---

#### The Encoder Stack
The Encoder consists of a stack of $N=6$ **identical layers**. Each layer acts as a filter that refines the representation of the input.

**Dimensionality:** Every layer and sub-layer maintains a constant size of 512 dimensions. This uniformity allows information to flow through the stack without needing to be resized.

**The Two Sub-layers:** Each encoder layer is split into two parts:
1. **Multi-Head Self-Attention:** This allows the word at a specific position to "look" at all other words in the input to gather context.
2. **Position-wise Feed-Forward Network:** A fully connected network applied to each position separately and identically.

The **"Safety" Mechanism:** To ensure that the signal doesn't degrade as it goes deeper, each sub-layer uses a **Residual Connection** followed by **Layer Normalization**. The formula is effectively: $\text{LayerNorm}(x + \text{Sublayer}(x))$. This helps the model stay stable during training and prevents "vanishing gradients."

---

#### The Decoder Stack
The Decoder is more complex because it has two jobs: it must understand the output it has already generated and it must refer back to the information provided by the Encoder. Like the Encoder, it also consists of a stack of $N=6$ identical layers.

The Three Sub-layers: Each decoder layer has an extra component compared to the encoder:
1. Masked Multi-Head Self-Attention: This looks at the words the decoder has already written. It is "masked" so that the model cannot "cheat" by looking at future words during training.
2. Encoder-Decoder Attention: This is the bridge. It allows the decoder to "attend" to the final output of the encoder stack, ensuring the translation stays accurate to the source.
3. Position-wise Feed-Forward Network: Similar to the encoder, this refines the final representation for that specific time step.

---

#### Summary of the Flow
The process starts with Positional Encodings being added to the input embeddings to give the model a sense of word order. The data then flows through the Encoder Stack, resulting in a set of vectors (the encoder output). This output is then fed into every layer of the Decoder Stack, which generates the final sequence one token at a time by balancing its own internal history with the information from the encoder.

---

## The Self-Attention Mechanism
Self-attention is the "engine" of the Transformer. It allows the model to look at an entire sentence and decide which other words are most relevant to the word currently being processed. For example, in the sentence "The animal didn't cross the street because it was too tired," self-attention allows the model to link the word "it" specifically to "animal" rather than "street."

---

#### The Q, K, V "Fuzzy Lookup" (Step 1)
For every word in the input sequence, the model creates three distinct vectors by multiplying the word's input embedding by three trained weight matrices. These are:
* **Query ($Q$):** "What am I looking for?" (The current word's search criteria).
* **Key ($K$):** "What do I contain?" (The label or index of a word to be searched against).
* **Value ($V$):** "What information do I offer?" (The actual content that will be passed forward).

In the standard Transformer, the input embedding is 512 dimensions, while these three vectors are reduced to 64 dimensions.

---

#### Calculating the Attention Score (Steps 2–4)
To determine the relationship between words, the model follows a specific mathematical pipeline:
1. **The Dot Product:** To see how much word $i$ ("it") should attend to word $j$ ("animal"), we calculate the dot product: $Score = Q_i \cdot K_j$. A higher score indicates that the Query of $i$ is a strong match for the Key of $j$. Note: This is **asymmetric.** The score for "it" attending to "animal" is calculated using $Q_{it} \cdot K_{animal}$, while the reverse uses $Q_{animal} \cdot K_{it}$.
2. **Scaling (Normalizing):** The scores are divided by the square root of the dimension of the key vectors ($\sqrt{d_k}$). Since $d_k = 64$, we divide by 8. This prevents the dot products from growing too large, which would result in extremely small gradients during training.
3. **Softmax:** We apply a **Softmax function** to the scaled scores. This turns the scores into a set of probabilities that sum to 1. This value represents the "percentage of attention" word $i$ should give to word $j$.

--- 

#### Producing the Output Embedding (Steps 5–6)
The final step is to use those attention percentages to extract information:
1. **Weighting the Values:** We multiply each word's **Value vector ($V_j$)** by its softmax score relative to the current word $i$. This ensures that irrelevant words are "muted" (multiplied by a number close to 0) while important words are preserved.
2. **Summing:** We sum these weighted value vectors together. The result is $Z_i$, the new contextualized embedding for word $i$.

$$Z_i = \sum_{j} \text{softmax}\left(\frac{Q_i \cdot K_j}{\sqrt{d_k}}\right) V_j$$

---

#### Summary: Why this works
By the end of this process, the embedding for "it" is no longer just a generic pronoun vector. Because the attention score for "animal" was high, the final $Z_{it}$ vector is now heavily composed of the Value vector for "animal." The model has effectively "re-written" the word based on its context within that specific sentence.

---

## Multi-Head Attention
While single-head self-attention allows a word to "attend" to another, it is limited because it can only focus on one type of relationship at a time. Multi-Head Attention solves this by running multiple self-attention mechanisms in parallel, allowing the model to capture different types of linguistic relationships simultaneously.

#### Multiple "Representation Subspaces"
Think of each "head" as a different perspective. One head might focus on syntax (matching a verb to its subject), while another focuses on semantics (linking a pronoun to its noun), and a third might focus on local context (looking at the immediate neighboring words).

The Setup: Instead of one set of Q, K, and V matrices, a typical Transformer uses 8 attention heads.

Parameters: This means we have 8 independent sets of Query, Key, and Value weight matrices. Each set is randomly initialized, allowing them to learn different features during training.
* To be clear: we don’t initialize 8 heads "per word"; rather, we initialize 8 sets of Weight Matrices ($W^Q, W^K, W^V$) for the entire layer.
* Think of these matrices as the "Global Knowledge" of that specific layer. When a sentence passes through, every word in that sentence is multiplied by those same 8 sets of matrices.
* Global Weights: At the start of training, the layer creates 8 different "viewpoints" (Heads). Each head has its own $W^Q_n, W^K_n, W^V_n$ matrices.
* The word "cat" is multiplied by Head 1's weights, then Head 2's weights... all the way to Head 8. The word "sat" is also multiplied by those exact same 8 sets of weights.
* Result: For every single word ($x_i$), you end up with 8 different $Z$ vectors ($Z_0 \dots Z_7$).
* Think of the Weight Matrices ($W^Q, W^K, W^V$) as the "Filters" or "Lenses" that the model has learned during its training. The words themselves are just data (vectors) passing through those filters.

Dimensionality: To keep the total computational cost similar to single-head attention, the dimensions are split. If the total input is 512, each of the 8 heads works on a 64-dimensional subspace ($512 / 8 = 64$).

#### Combining the Heads 
Once each head has performed its self-attention calculation, the model needs to "stitch" those different perspectives back together into a single vector that can be passed to the next layer of the Transformer.

1. Concatenation: The 8 individual output vectors ($Z_0, Z_1, \dots, Z_7$) are concatenated side-by-side into one long vector.
2. Final Linear Transformation: This long concatenated vector is multiplied by an additional weight matrix ($W^O$). This "condenses" the information from all 8 heads back into the standard 512-dimensional space.
3. Feed-Forward Ready: This final, unified vector now contains a rich, multi-layered understanding of the word's role in the sentence, ready to be processed by the position-wise feed-forward layer.

---

## Positional Encoding: Giving the Model a Sense of Order
Unlike RNNs, which process words sequentially (Step 1, then Step 2), Transformers process every word in a sentence simultaneously. While this is great for speed, it means the model is "position-blind"—it can't naturally tell the difference between "The dog bit the man" and "The man bit the dog." To solve this, we use Positional Encoding. We create a unique vector that represents a word's specific position in the sequence and add it to the word's input embedding. This ensures that the same word (e.g., "dog") has a slightly different mathematical representation depending on whether it appears at the start or the end of a sentence.

---

#### The Sine and Cosine Method (Static Encoding)
The original Transformer used a fixed mathematical function to generate these position vectors. The intuition is to use waves of different frequencies so that each dimension of the encoding follows a unique pattern.

* Even dimensions ($2i$): Use the Sine function.
* Odd dimensions ($2i+1$): Use the Cosine function.

$$PE_{(pos, 2i)} = \sin(pos / 10000^{2i/d_{model}})$$
$$PE_{(pos, 2i+1)} = \cos(pos / 10000^{2i/d_{model}})$$

**Why this works:** These trigonometric functions allow the model to easily learn **relative positions.** Because of the mathematical properties of sine and cosine, the position at $pos+k$ can be expressed as a linear function of the position at $pos$. This helps the model determine not just where a word is, but how far apart words are from each other.

--- 

#### Positional Encoding Alternatives
While the sine/cosine method is "static" (it never changes), modern models often use other approaches:
* **Learned Absolute Position Embeddings:** Instead of using a fixed formula, the model starts with a set of randomly initialized "position vectors" (e.g., a vector for "Position 1," a vector for "Position 2"). These are updated during training just like word embeddings. The model literally learns what "third place in a sentence" looks like.
* **Relative Position Embeddings:** Instead of assigning an absolute coordinate to a word, the model focuses on the distance between words during the attention step. It learns that "the word 3 places to my left" has a specific type of relationship to the current word.

---

#### Summary for Notes:
* Transformers are inherently "bag-of-words" models without a sense of order.
* We solve this by injecting a "timestamp" vector into the word embedding.
* Now the model can distinguish word order and measure the distance between tokens, which is essential for understanding syntax and grammar.

---

## BERT: Bidirectional Encoder Representations from Transformers
BERT (Devlin et al., 2019) is a landmark model that shifted the NLP paradigm from task-specific architectures to a "Pre-train then Fine-tune" workflow. By using only the Encoder portion of the Transformer, BERT focuses entirely on language "understanding" rather than generation.

#### The Power of Bidirectionality
Traditional Language Models (like LSTMs or GPT) are unidirectional; they process text from left-to-right to predict the next word. While this is great for writing, it limits understanding because a word’s meaning often depends on what comes after it.

**Unidirectional (Auto-regressive):** Builds context incrementally (e.g., "The cat sat on the...").

**Bidirectional (BERT):** Uses the "whole of the sentence" at once. Words can "see themselves" in the context of both their left and right neighbors simultaneously.

---

#### Input Representation: The Embedding "Sum"
BERT doesn't just take a word and turn it into a vector; it constructs a highly structured input by summing three distinct types of embeddings:
1. **Token Embeddings:** Uses a WordPiece vocabulary (30k tokens). Words are broken into subwords (e.g., "playing" → "play" + "##ing") to handle rare words and morphology effectively.
2. **Segment Embeddings:** When processing two sentences at once (Sentence A and Sentence B), these tell the model which tokens belong to which sentence (e.g., Sentence 1 vs. Sentence 2).
3. **Positional Embeddings:** Learns the absolute position of each token in the sequence (up to 512 tokens).

---

#### Special Tokens:
* **[CLS]:** Added to the very beginning of every sequence. Its final hidden state is used as the aggregate representation for classification tasks.
* **[SEP]:** A separator token used to mark the boundary between two sentences.

--- 

#### Pre-training Task: Masked Language Model (MLM)
Since a bidirectional model could "see" the answer if it just tried to predict the next word, BERT uses the **Masked Language Model** objective—often called the "Cloze" task.

* **The Process:** Randomly mask out 15% of the input tokens (replacing them with a [MASK] token).
* **The Goal:** The model must use the surrounding context (from both directions) to predict what the hidden word was.
* **The Balance:** Google found that 15% is the "sweet spot." If $k$ is too small, training is too expensive (not enough learning per sentence); if $k$ is too large, there isn’t enough context left to make a good guess.

Example: "The animal didn’t cross the **[MASK]** because it was **[MASK]** tired."

--- 

#### The Result: A Universal Encoder
By training on massive datasets (Wikipedia and BookCorpus), BERT learns a deep, hierarchical representation of language.
* **Multi-headed self-attention** models the complex relationships between words.
* **Feed-forward layers** extract non-linear features.
* **Layer norm and residuals** keep the deep network (12 or 24 layers) stable and "healthy" during training.

The result is a pre-trained "brain" that can be downloaded from places like HuggingFace and **fine-tuned** on specific tasks (like sentiment analysis or Q&A) with very little additional data.

---

## Next Sentence Prediction (NSP)
While the Masked Language Model (MLM) teaches BERT how words relate to their immediate neighbors, Next Sentence Prediction (NSP) is designed to teach the model how entire sentences relate to one another. This is crucial for higher-level tasks like Question Answering (QA) and Natural Language Inference (NLI), where understanding the logical flow between two pieces of text is essential.

#### How it Works
During pre-training, BERT is fed pairs of sentences ($A$ and $B$). The model must perform a binary classification task to determine if Sentence $B$ logically follows Sentence $A$.

**Positive Examples (50%)**: Sentence $B$ is the actual consecutive sentence from the original corpus (labeled as IsNext).

**Negative Examples (50%):** Sentence $B$ is a random sentence pulled from a completely different document (labeled as NotNext).

Example: 
**Sentence A:** "The man went to the store."
**Sentence B:** "He bought a gallon of milk."
Label: IsNextSentence (Logical connection: "He" refers to "man", "bought" relates to "store").

**Sentence A:** "The man went to the store."
**Sentence B:** "Penguins are flightless."
Label: NotNextSentence (No topical or logical connection).

#### The Role of the [CLS] Token
o make this prediction, the model looks at the final hidden state of the [CLS] token (the "Classification" token at the very start of the sequence). Because of the self-attention mechanism, the [CLS] token's vector has "attended" to every single word in both Sentence $A$ and Sentence $B$. This makes it a perfect mathematical summary of the relationship between the two sentences, which is then fed into a simple classifier to produce the IsNext or NotNext result.

---

## Pre-Trained Model Details: Scale and Hardware
The original BERT models were trained on a massive scale that was unprecedented at the time (2018–2019). This required specialized hardware and enormous datasets to ensure the model captured a "universal" understanding of language.

The Data: BERT was trained on a combined 3.3 billion words:
* Wikipedia: 2.5 billion words (excellent for factual knowledge).
* BookCorpus: 800 million words (excellent for narrative flow and long-range context).

The Hardware: Google used their proprietary TPUs (Tensor Processing Units). Training the "Large" version of BERT took 4 days on 64 TPU chips.

Model Variants:
    * BERT-Base: 12 layers, 768 hidden units, 12 attention heads (110M parameters).
    * BERT-Large: 24 layers, 1024 hidden units, 16 attention heads (340M parameters).

Optimization: Used AdamW with a linear learning rate decay. Interestingly, they used a massive batch size (up to 128,000 words per update) to stabilize the learning of such a complex network.

---

## Is BERT supervised training?
This is a great point of clarification—the terminology in NLP often gets blurred. The short answer is: BERT's pre-training is self-supervised, but it still relies on a mathematical "ground truth" to calculate error and update weights.

To clear this up, let’s distinguish between the labels and the data:

#### 1. The Pre-training Phase: Self-Supervised
BERT is trained on raw, unlabelled text (like Wikipedia). It doesn't need a human to go through and label sentences as "Subject" or "Object." Instead, it creates its own labels from the structure of the data itself.

The Ground Truth: In the Masked Language Model (MLM) task, the "ground truth" is simply the original word that was hidden. If the original sentence was "The cat sat on the mat" and the model sees "The [MASK] sat on the mat," the ground truth is "cat."

The Loss: The model makes a guess (a probability distribution over 30,000 words). If it guesses "dog," the mathematical difference between "dog" and "cat" is the Loss, which is then backpropagated to update the weights.

Key Intuition: It is "self-supervised" because the "supervision" comes from the data itself, not a human-annotated label.

#### 2. The Fine-tuning Phase: Supervised
Once BERT is pre-trained, it is essentially a "language expert" that doesn't know how to do a specific job yet. To make it useful for a task (like Sentiment Analysis), we move into Supervised Learning. 

The Data: Now we need a labelled dataset (e.g., 10,000 movie reviews, each marked as "Positive" or "Negative" by a human).

The Process: We put a small classification layer on top of BERT’s [CLS] token. The model predicts a label, compares it to the human "ground truth" (the label), and updates its weights accordingly.

--- 

## Week 7 Summary
This was a foundational week that officially moved us from "Old School" NLP (counting words and fixed vectors) to the "Modern Era" of Deep Learning. To recap, here is the logical progression of how we got to BERT:

#### 1. The Core Problem: Static vs. Context
We started by realizing that simple Additive Composition (adding Word2Vec vectors together) is a "bag-of-words" approach. It fails because it doesn't understand that "bank" means something different in a "river" context than in a "money" context. It also ignores word order, treating "dog bites man" and "man bites dog" as identical.


---

#### 2. The First Solution: ELMo (Bi-LSTMs)
ELMo introduced the idea of Contextualized Word Embeddings. By stacking Bi-LSTMs, ELMo looked at the words to the left and right of a target word to create a dynamic vector.

Key Insight: Lower layers in the stack handle syntax (grammar), while higher layers handle semantics (meaning)


---

#### 3. The Architecture Shift: Transformers
We then moved away from RNNs/LSTMs entirely. RNNs are slow because they process words one-by-one (sequential). The Transformer replaced recurrence with Self-Attention, allowing the model to process every word in a sentence simultaneously (parallel).

Self-Attention: Uses Query, Key, and Value vectors to perform a "fuzzy lookup," letting each word decide which other words in the sentence are most important to its meaning.

Multi-Head Attention: Allows the model to track multiple relationships at once (e.g., one head for grammar, one for pronouns).

Positional Encoding: Since Transformers process everything at once, we "inject" sine and cosine waves to tell the model the order of the words.

---

#### 4. The Powerhouse: BERT
Finally, we looked at BERT, which is essentially the Encoder half of a Transformer trained on a massive scale.

Bidirectionality: Unlike previous models that only read left-to-right, BERT sees the whole sentence at once.


Self-Supervised Pre-training: It learns from raw text (Wikipedia) by playing two games: Masked Language Modeling (predicting hidden words) and Next Sentence Prediction (determining if two sentences follow each other).

--- 

| Feature | Word2Vec / GloVe | ELMo | BERT | 
| :--- | :--- | :--- | :--- |
| Context | Static (Same vector everywhere) | Contextual (Changes per sentence) | Deeply Contextual (Bidirectional) |
| Architecture | Lookup Table | Bi-LSTM (Recurrent) | Transformer (Attention) | 
| Input Unit | Whole Words | Characters / Words | Subwords (WordPiece) | 
| Training | Shallow (Window-based) | Deep (Language Modeling) | Deep (MLM + NSP) | 

---

## Week 7: Seminar

#### 1. Imagine you have a 100M word corpus of news articles with a vocabulary of size 50K. Explain the difference between static word embeddings and contextualized word embeddings derived from this corpus.

In a 100M word corpus, static word embeddings (like Word2Vec or GloVe) assign a single, fixed-dimensional vector to each of the 50K words in the vocabulary. This vector represents the "average" meaning of a word across the entire dataset, meaning the word "bank" would have the same mathematical representation whether the news article was about a river or a financial institution. In contrast, contextualized word embeddings (like those from BERT or ELMo) do not use a fixed lookup table; instead, they generate a unique vector for a word based on the specific sentence it appears in. By looking at the surrounding 100M words during pre-training, these models learn to "compute" a representation that changes according to the neighboring tokens, effectively resolving polysemy and capturing specific nuances of meaning that static vectors ignore.

ELMo and BERT do not have a single, fixed vector for the word "bank." In a static model (like Word2Vec), there is a literal "lookup table" (like a dictionary) where the word "bank" always equals [0.1, -0.5, 0.8]. In contrast, ELMo and BERT are functions, not just tables. When the word "bank" enters the model, the self-attention (in BERT) or the Bi-LSTM (in ELMo) looks at the surrounding words and mathematically computes a vector on the fly.

If you pass 100 different sentences containing the word "bank" through BERT, you will get 100 different vectors for that word. Each vector will be slightly shifted in high-dimensional space to reflect whether the "bank" in that specific sentence is a financial institution, a river edge, or even a verb (to "bank" a shot in basketball). This is why we say the embeddings are "functions of the entire input sequence" rather than a static entry in a vocabulary list.

---

#### 2. Why are transformers now generally preferred to LSTMs in the NLP community?

Transformers are now generally preferred to LSTMs because they solve the two biggest bottlenecks of recurrent architectures: **sequential processing** and **long-range dependencies**. LSTMs must process words one by one, meaning the model cannot calculate the vector for the 10th word until it has finished the 9th; this makes them impossible to parallelize and slow to train on large datasets. In contrast, Transformers use **Self-Attention** to see every word in a sentence simultaneously, allowing for massive parallelization on GPUs and significantly faster training speeds. Furthermore, while LSTMs often "forget" information from the beginning of a long sentence due to the vanishing gradient problem, Transformers maintain a direct mathematical connection between all words regardless of their distance, allowing them to capture much more complex, global context.

---

#### 3. In the sentence, “A few faint stars glimmered in the sky.”, what words might need to pay attention to other words in the sentence, in order for a good contextualized word representation to be derived?

In the sentence, "A few faint stars glimmered in the sky," specific words must "attend" to others to build a high-quality contextual representation:

The word "stars" is the semantic anchor of the sentence; it would need to pay heavy attention to its modifiers, "few" and "faint," to understand the specific visual context (quantity and brightness). Simultaneously, "stars" must attend to the verb "glimmered" to capture the action being performed and to "sky" to establish its spatial location. Conversely, the verb "glimmered" must pay attention back to "stars" to identify the subject performing the action, as the "glimmering" quality is physically tied to the light of the stars. Even a word like "in" relies on attention to "sky" to resolve its prepositional role. By allowing every word to "vote" on the relevance of every other word, the Transformer ensures that the final vector for "stars" isn't just a generic celestial body, but specifically a small group of dimly lit objects located in a nighttime firmament.

---

#### 4. Explain how the output of an attention head is derived (for one of the words in the sentence above).

To explain how the output of an attention head is derived for a word like "stars", we follow a specific mathematical "lookup" process using three vectors: Query (Q), Key (K), and Value (V).

First, the input embedding for "stars" is multiplied by three learned weight matrices to create its specific $Q$, $K$, and $V$ vectors. To determine how much "stars" should "pay attention" to another word like "glimmered," the model calculates a Score by taking the dot product of the Query for "stars" ($Q_{stars}$) and the Key for "glimmered" ($K_{glimmered}$). This score is then scaled (divided by $\sqrt{d_k}$) and passed through a Softmax function to turn it into a probability, such as 0.4, which represents the "weight" of that relationship.

Finally, the model multiplies this probability (0.4) by the Value vector of "glimmered" ($V_{glimmered}$). This process is repeated for every other word in the sentence (including "stars" attending to itself). All these weighted Value vectors are then summed together to produce the final output vector ($Z_{stars}$). This resulting vector is no longer just a static representation of a celestial body; it is a contextualized embedding that has literally "absorbed" the relevant information from "faint," "glimmered," and "sky.

---

#### Follow Up question, when do we compute the words matrices?
In a single pass of the model, we compute the Query ($Q$), Key ($K$), and Value ($V$) vectors for every word in the sentence simultaneously.

When the sentence "A few faint stars glimmered..." enters the Transformer, the model doesn't wait until it is processing "stars" to figure out what "glimmered" means. Instead, it performs a massive matrix multiplication where the entire sequence of input embeddings is multiplied by the three weight matrices ($W^Q, W^K, W^V$).

This creates a "pool" of $Q$, $K$, and $V$ vectors for every single word in the sentence. When we specifically calculate the representation for "stars", the model simply "looks up" the pre-computed $Q_{stars}$ and compares it (via dot product) against the pre-computed $K$ vectors of all the other words—including $K_{glimmered}$, $K_{faint}$, and $K_{sky}$. This is the secret to the Transformer's speed: because all these vectors are calculated at once rather than one-by-one (like an LSTM), the model can leverage the full power of a GPU to handle the entire sentence in one "heartbeat."

---

#### FOLLOW UP: What is that comes out of a transformer? 
The short answer is: The Weight Matrices ($W^Q, W^K, W^V$) are the "Brain" of the model, but they are not the "Output" of a single run. 

When Google or OpenAI "trains" a model, they are trying to find the perfect values for $W^Q, W^K,$ and $W^V$.At the start of training, these matrices are just random numbers.As the model reads billions of sentences, it uses backpropagation to tweak those numbers.By the end, the matrices have "learned" linguistic rules (e.g., "If I am a Query for a pronoun, I should look for a Key that is a noun").

When you actually use the model (Inference), the Weight Matrices are frozen. They are the static "tools" you use to process new data.You feed in a new sentence: "The cat sat."You multiply those words by the pre-trained $W^Q, W^K,$ and $W^V$ matrices.The Result: You get a Contextualized Embedding ($Z$).

At the end of Training: You come out with the Weight Matrices. This is the "Knowledge" you can use elsewhere or share with the world.

At the end of a single Model Run (Inference): You come out with Contextualized Word Embeddings. These are the vectors you use for your specific task, like deciding if a movie review is positive or negative.

Analogy: The Weight Matrices are like a recipe book (the knowledge of how to cook). The Contextualized Embeddings are the actual meal you produced today using that book and a specific set of ingredients (your input sentence).

---

#### FOLLOW UP: What to do with the outputs of a transformer (the Contextualized Embedding ($Z$))
That is exactly the point where the "modular" nature of modern NLP shines. Once you have those Contextualized Embeddings ($Z$), you have several options depending on whether you are still inside the Transformer "stack" or if you are ready to solve a specific task.

#### 1. Moving to the Next Layer (Inside the Transformer)
If you are in the 1st layer of a 12-layer BERT model, those $Z$ vectors aren't the "final" result yet. 
* They are passed through a Position-wise Feed-Forward Network (a small MLP that works on each word individually).
* The output of that MLP then becomes the input for the 2nd Transformer layer.
* This repeats 12 times. Each layer uses the context from the previous layer to build an even deeper, more abstract understanding.

The word embeddings of the each word in a sentence are getting "better" with each stack. 

#### 2. Using them for a Task (The "Head")
Once the data has passed through the final Transformer layer, you have the "ultimate" contextualized embeddings. Now, you can plug them into whatever you want:
* Sequence Classification (e.g., Sentiment Analysis): You take the embedding of the [CLS] token and pass it into a simple MLP (Multi-Layer Perceptron). The MLP then outputs a probability for "Positive" or "Negative."
* Token Classification (e.g., Named Entity Recognition): You take the embedding for every word and pass each one into an MLP to decide if that word is a "Person," "Location," or "Organization."
* Question Answering: You pass the embeddings into a linear layer to predict which word in the text is the "Start" of the answer and which is the "End."

---

#### 5. Will the encoder of a transformer produce the same representation of the sentences, “The dog bit the boy.” and the “The boy bit the dog.” Why/ why not?

No, the encoder will produce different representations for these two sentences, primarily due to the inclusion of Positional Encodings.

In a pure self-attention mechanism, the model is "permutation invariant," meaning it would treat both sentences as an identical "bag of words" ({The, dog, bit, boy}). However, the Transformer architecture prevents this by adding a unique positional vector to each word embedding before it enters the first encoder layer.

In the first sentence, "dog" is at Position 2 and "boy" is at Position 5; in the second sentence, those positions are swapped. Because these positional "time-stamps" are added to the word's data, the Query, Key, and Value vectors for "dog" at Position 2 will look mathematically different than those for "dog" at Position 5.

When the self-attention layer runs, it uses these position-aware vectors to calculate the relationships. In "The dog bit the boy," the verb "bit" will attend most strongly to "dog" as the subject (the one doing the biting). In "The boy bit the dog," that same verb will attend to "boy" as the subject. Consequently, the final contextualized embeddings for every word—and the overall sequence representation—will accurately reflect the distinct meanings of the two sentences.

---

#### FOLLOW UP: Do transformers just produce representations of words or also of whole sequences?
By default, a Transformer is a "sequence-to-sequence" or "token-to-token" engine. If you put in 5 tokens, the final layer spits out 5 contextualized word embeddings. It does not inherently collapse them into a single "sentence vector" the way a simple RNN might produce one final hidden state.

However, in practice, we derive a sequence representation from those embeddings in two main ways:

#### The "Special Token" Shortcut (The BERT approach)
As we discussed with the [CLS] token, we insert a dummy token at the start. Because of self-attention, the embedding for [CLS] at the final layer has "attended" to every other word. We treat the final vector of this single token as the representation of the entire sentence. It is a proxy for the whole sequence.

#### Pooling (The Composition approach)
Alternatively, we can mathematically "compose" the individual word embeddings ourselves. Common methods include: 
* Mean Pooling: Taking the average of all the word embeddings in the sentence.
* Max Pooling: Taking the maximum value across each dimension of the word embeddings.
* Summation: Adding them all together.

These "pooled" vectors are what we actually use as a Sequence Representation when we want to compare the similarity of two different sentences (like in Paraphrase Detection).

Summary:
Strictly speaking: The Transformer Encoder produces a set of contextualized word embeddings ($Z_1, Z_2, \dots, Z_n$).

In practice: we create a Sequence Representation by either using a dedicated summary token ([CLS]) or by pooling (averaging/summing) the individual word embeddings together.

#### Random Final BERT Notes 
* **Does BERT encode words or sentences?** BERT is unique because it actually encodes both, but in very different ways. To understand BERT, it helps to think of it as a "context machine" that processes individual pieces to understand the whole.
* **It encodes Words (as Contextual Embeddings)** BERT produces a unique vector for every single word in a sentence. Unlike older models like Word2Vec where the word "bank" always had the same vector, BERT changes the vector based on the surrounding words.
* **It encodes Sentences (via the [CLS] Token)** it also creates a single "summary" vector for the entire input. It does this by inserting a special token called [CLS] (short for "Classification") at the very beginning of every sentence. Because of BERT's Self-Attention mechanism, the [CLS] token "looks" at every other word in the sentence and absorbs their collective meaning. By the time the data reaches the final layer, the vector for [CLS] acts as a representative "fingerprint" for the entire sentence.
* When you feed BERT a sentence, it breaks it down into three layers of information to create those encodings: Token Embeddings, Segment Embeddings, Position Embeddings
* Use Word Encodings if you are doing tasks like Named Entity Recognition (NER) where you need to label specific words (e.g., "Is this word a person or a place?").
* Use Sentence Encodings (the [CLS] token) if you are doing Sentiment Analysis or Topic Classification (e.g., "Is this whole review positive or negative?").
* When we talk about BERT "encoding" or "producing a vector," we are typically referring to the Inference Phase (or the forward pass during training).
* When you feed a sentence into a trained BERT model: Raw text is tokenized (e.g., "The bank is open"). The model passes these tokens through its layers of self-attention. You get a fixed-size vector (usually 768 dimensions for BERT-base) for every single token, including the [CLS] token. You then grab the [CLS] vector to represent the whole sentence or the specific word vectors for token-level tasks.
* The training/pre-training phases for BERT are the Masked Language Model (MLM) and Next Sentence Prediction (NSP)
* In MLM hides 15% of the words and tries to predict them. This forces it to create deep word-level encodings based on context.
* Next Sentence Prediction (NSP): BERT is given two sentences and must guess if Sentence B logically follows Sentence A. This is what trains the [CLS] token to act as a "sentence-level summary."
* The [CLS] token is a permanent part of the input architecture, but it is primarily "trained" by Next Sentence Prediction (NSP), not MLM.
* MLM doesn't really care about the [CLS] token; it cares about the tokens labeled [MASK]. This forces BERT to create high-quality word/token-level encodings.
* During the pre-training phase, BERT does both of these tasks together. Though some modern approaches such as RoBERTa may not do the NSP task. 
* THe [CLS] token is always a part of BERT architecture. Because of the Self-Attention mechanism, it naturally attends to every other word in the sentence, making it a "summary" by default.
* It’s worth noting that after the original 2018 paper, researchers found that NSP (the [CLS] training task) wasn't actually that helpful. Models like RoBERTa (a "Robustly Optimized" BERT) actually removed the Next Sentence Prediction task entirely and just trained on MLM for longer. Even without the specific NSP training, the [CLS] token still works as a sentence representation because it sees every other word through the attention layers.

---

## Week 7: Paper
> Sentence-BERT: Sentence Embeddings using Siamese BERT-Networks (Reimers and Gurevych, 2019)

Reimers and Gurevych (2019) present Sentence-BERT (SBERT), a modification of the BERT netowrk using siamese and triplet networks that they claim is able to derive semantically meaningful sentence embeddings. Once you have read the paper, consider the following questions.

#### Paper Introduction
The provided sources introduce Sentence-BERT (SBERT), a modification of the BERT network designed to create efficient and semantically meaningful sentence embeddings. While standard BERT models achieve high accuracy on sentence-pair tasks, they are computationally too slow for large-scale applications like clustering or semantic search due to their need for pairwise comparisons. SBERT addresses this by utilizing siamese and triplet network structures, allowing sentences to be processed into fixed-sized vectors that can be compared instantly using cosine similarity. Extensive evaluations show that SBERT significantly outperforms previous embedding methods on Semantic Textual Similarity (STS) tasks and transfer learning benchmarks like SentEval. Beyond its improved performance, the model is highly computationally efficient, reducing the time required to find similar sentences in large datasets from hours to mere seconds. Ultimately, these documents detail the architecture, training strategies, and superiority of SBERT in making transformer-based models practical for real-world information retrieval.

---

#### 1. For a pair regression task, the standard BERT set-up requires pairs of sentences to be presented as input to the encoder network. Why is this set-up unfeasible if you want to find the most similar sentences in a collection?

Standard BERT uses a cross-encoder setup that requires both sentences to be fed into the network simultaneously, creating massive computational overhead. For example, finding the most similar pair in a collection of 10,000 sentences requires roughly 50 million inference computations, taking approximately 65 hours on a modern GPU.

If you have a collection of $n = 10,000$ sentences and you want to find the "most similar pair," you have to compare every sentence against every other sentence.In combinatorics, the number of ways to choose 2 items from a set of $n$ is calculated using the formula:$$\frac{n \times (n - 1)}{2}$$For 10,000 sentences:$$\frac{10,000 \times 9,999}{2} = 49,995,000$$

That is where the ~50 million comes from. Each one of those pairs requires a full forward pass (inference) through the BERT network.

---

During it's initial birth pre-training, Google feed two seteneces at a time for 50% of its training data. This was for the Next Sentence Prediction (NSP) task. Sentence A: "The man went to the store." [SEP] Token: (A divider). Sentence B: "He bought a gallon of milk." 

The model's job was to look at both and output a "True" or "False" through the [CLS] token. This is why the BERT input limit is usually 512 tokens—it was built to have enough "room" to fit two sentences comfortably.

You can train/fine-tune BERT with just one single sentence. Thi requires a labelled tasked. Sentiment Analysis: "This movie was great!" $\rightarrow$ [Positive]. Token Classification: "Barack Obama was born in Hawaii." $\rightarrow$ [Person, Person, O, O, Location]. In these cases, you just leave the "Sentence B" part empty. The model handles it perfectly fine.

--- 

The 50 million computation problem refers to when you use BERT for Sentence Similarity, aka cross-encoder. 

Even though BERT can take one sentence, it wasn't designed to produce a "meaningful" vector in a vacuum. If you feed Sentence A into BERT alone and Sentence B into BERT alone, and then compare their outputs, the results are actually pretty bad.

To get high accuracy for similarity, you are forced to use the Cross-Encoder setup: You feed `[Sentence A] [SEP] [Sentence B]` into the model together. The Self-Attention mechanism allows the words in A to "talk" to the words in B. This "interaction" is what makes BERT so accurate at comparing them, but it’s also what makes it so slow—because you have to re-run the whole model for every new pair.

The [CLS] token always sits at the very first position (index 0) of the entire input sequence. [CLS] + Sentence A + SEP + Sentence B + SEP. If you put the [CLS] token at the end, it would still work (technically), but putting it at Index 0 is a standardized convention. It makes it incredibly easy for developers to extract the "sentence meaning" after inference.

This important to recognise because it it is the reason why standard BERT is Cross Encodeer and why it is so comp expensive. The `[CLS]` token is a representation of the relationship between the entire input sequence. If you feed it two sentences, that vector is "contaminated" (in a good way for accuracy, but a bad way for speed) by the interaction between them.

Because BERT uses Self-Attention, every single token in the input "looks at" every other token.When the [CLS] token is being processed in Layer 1, it sees words from Sentence A.In Layer 2, it sees words from Sentence B.By Layer 12, the [CLS] vector is a mathematical soup of $A + B$.

If the [CLS] token was a "pure" representation of a sentence in isolation, you could just: Feed "Sentence A" into BERT $\rightarrow$ Save the [CLS] vector.Feed "Sentence B" into BERT $\rightarrow$ Save the [CLS] vector. Compare the two vectors.But standard BERT doesn't work well that way. If you feed them separately, the [CLS] token only has Sentence A to look at. The "features" it extracts are different than if it had Sentence B there to provide context. To get the highest accuracy, BERT needs to see them both at the same time so the attention mechanism can compare them word-for-word.

This is the fundamental difference that led to the creation of Sentence-BERT (S-BERT):

| Setup | How [CLS] works | Speed | Accuracy |
| :--- | :--- | :--- | :--- |
| Cross-Encoder (Standard) | "Interactive: [CLS] represents the pair (A,B)." | Slow: Must re-run for every pair. | Very High: Can see nuances between words. |
| Bi-Encoder (S-BERT) | Independent: [CLS] represents Sentence A only. | "Fast: Embed once |  compare millions of times." | High: Good enough for most search/retrieval. |

#### So, is [CLS] ever a "Sentence" representation?
Only if you only feed it one sentence.

If your input is [CLS] The cat sat on the mat [SEP], then yes, the [CLS] token is a representation of that single sentence. But the moment you add a second sentence, it becomes a representation of the joint context of both.

You would assume that a model as powerful as BERT would naturally "organize" sentences into a logical space and could compare single sentences using cosine similarity, but "out-of-the-box" BERT is actually quite messy for this specific task.


#### The "Anisotropy" Problem (The Narrow Cone)
Research has shown that BERT’s internal vector space is anisotropic. This is a fancy way of saying that BERT’s vectors are not spread out evenly. Instead, they all cluster together in a very narrow, high-dimensional cone. If you take two completely unrelated sentences (e.g., "I like turtles" and "The stock market is down"), their BERT vectors will still have a cosine similarity of 0.9 or higher. Because they are all pointing in almost the same direction within that narrow cone. This makes it nearly impossible to use cosine similarity to distinguish between "very similar" and "completely different."

#### Lack of "Semantic" Training for Embeddings
BERT was trained on two tasks: Masked Language Modeling (MLM) and Next Sentence Prediction (NSP). MLM teaches BERT about word relationships. NSP teaches BERT how Sentence A relates to Sentence B.  
Notice what is missing: BERT was never trained to make the distance between two separate vectors represent their semantic similarity. During pre-training, BERT only cares about how words interact within the input. It doesn't care if the final [CLS] vector of "The cat is happy" is close to the [CLS] vector of "A cheerful feline."

#### Word Bias (The "Non-Semantic" Dimensions)
Standard BERT vectors are heavily influenced by word frequency and punctuation. If two sentences both happen to use the word "the" many times or have a period at the end, their vectors will look very similar to BERT, even if the actual "meaning" is different. Without specific fine-tuning (like what SBERT does), the model doesn't know it should ignore the "functional" words and focus only on the "meaning" words when building that final vector.


SBERT (Sentence-BERT) took the original BERT and "forced" it to create a useful vector space by using a Siamese Network structure during training:
1. It takes Sentence A and Sentence B.
2. It creates a standalone vector for each.
3. It calculates the distance between them.
4. Crucially: It uses a loss function (like Triplet Loss) to physically push unrelated sentences apart and pull related sentences together in the vector space.


#### Summary: Cross-Encoder vs. Bi-Encoder
**Standard BERT (Cross-Encoder):** "I will look at both sentences together and tell you if they match." (Highly Accurate, Very Slow)

**SBERT (Bi-Encoder):** "I will give each sentence a 'coordinate' in a logical map so you can compare them yourself later." (Fast, requires special training)


---

#### 2. What have other researchers done to overcome this problem with using BERT?

Since BERT’s release, researchers have developed three main "generations" of architectures to solve the trade-off between the high accuracy of a **Cross-Encoder** and the high speed of a **Bi-Encoder**.

#### The Bi-Encoder (Sentence-BERT / SBERT)
As discuessed, the first breakthrough was Sentence-BERT (2019). Researchers modified the training process using a Siamese Network structure. Instead of feeding two sentences at once, they fed them into two identical "towers" (shared-weight BERTs) separately. They used Triplet Loss or Contrastive Loss to force the model to map "similar" sentences to nearby coordinates in a vector space. This allowed for pre-computation. You can encode 1 million sentences, store them in a database (like Pinecone or Milvus), and find the best match in milliseconds using simple math (Cosine Similarity).

#### The Poly-Encoder (The Middle Ground)
Developed by Facebook AI Research (2020), the Poly-Encoder was designed to get Cross-Encoder accuracy without the massive time penalty. Bi-Encoders are fast but "dumb" (they compress the whole sentence into one vector, losing detail). Cross-Encoders are "smart" but slow (they compare every word to every word). The Poly-Encoder represents a sentence as multiple vectors (e.g., 16 or 64 "code vectors") instead of just one. When a query comes in, the model only does attention over those few vectors. It is significantly more accurate than a Bi-Encoder because it allows for some "interaction" between sentences, but it’s still fast enough for real-time applications.

#### ColBERT (Late Interaction)
ColBERT (Contextualized Late Interaction over BERT) is currently one of the most popular research solutions for search engines. It doesn't squash a sentence into one vector. Instead, it keeps a vector for every single word in the sentence. To compare two sentences, it looks at each word in Sentence A and finds its "best friend" (most similar word) in Sentence B. It then sums up those "best friend" scores. Because the "interaction" happens at the very last step (the math step) rather than deep inside the 12 layers of BERT, it is extremely fast while maintaining almost the same precision as a full Cross-Encoder.

---

#### 3. What is the SBERT strategy?

#### "Semantic" Distillation
A simple re-mapping (like PCA or a linear shift) would move all vectors but keep their relative relationships mostly the same. SBERT, however, uses a Siamese Network structure during training. This forces the model to ignore "syntactic" similarities (like sentences having the same length or using the same stop words) and focus on "semantic" similarities

Standard BERT: Sees "The man bit the dog" and "The dog bit the man" as almost identical because the word overlap is 100%.

SBERT: Is trained to recognize that these two sentences might belong in different parts of the vector space because the meaning has shifted, even if the "cone" of words is the same.

#### The Pooling Layer (The "Collapsing" Step)
Standard BERT provides 768-dimensional vectors for every single token. To get a sentence-level vector, SBERT adds a Pooling Layer (usually Mean Pooling) on top of the transformer outputs. It calculates the average of all contextualized word embeddings. This "averages out" the noise of individual word frequencies and creates a single, dense representation that is specifically optimized to be compared via Cosine Similarity.

Pooling is a very common and valid approach for vanilla BERT, but it comes with a major "proceed with caution" warning depending on what you are trying to achieve. In the industry, it is often debated whether to use the [CLS] token or a Mean Pooling layer.
* The default method is to use CLS because BERT was pre-training using Next Sentence Prediciton. However, for a vanilla BERT that hasn't been fine-tuned for your specific data, the [CLS] token can be quite noisy or biased toward the pre-training data.
* Mean Pooling (Robust): This involves taking the average of all token vectors in the final layer (usually excluding padding).
* Why it's often better: Research (including the original SBERT paper) found that for vanilla BERT, Mean Pooling almost always outperforms the [CLS] token for calculating sentence similarity. By averaging every word, you capture a more "democratic" view of the sentence's meaning rather than relying on a single representative token.

However, the ability to use pooling depends on the task. If you are **Feature Extracting** then Mean Pooling is better, it produces more stable vectors for clustering than the CLS token alone. If you are **Fine-Tuning** either workds fine the CLS is much simpler but you can use them together using the pooling as a final layer to smooth to the signal. If you don't want to train and just compared vectors then you need to use mean pooling of the word vectors becuase the cone latent space of the CLS does not allow for good comparison. 

> Feature extraction, on the other hand, is the "application" phase where you take that already-finished "brain" and put it to work on your specific project. In this stage, you are no longer training the big model; in fact, you "freeze" its weights so they can't change. When you feed your specific data (like medical X-rays or legal documents) into the pre-trained model, you are simply asking it to "describe" what it sees using the sophisticated vocabulary it learned during pre-trained school. You "extract" those descriptions—the feature vectors—and then use them to power a separate, much smaller model that handles your specific task. Feature Extraction is literally just running Inference on a pre-trained model and stopping before the very last step. 

> If you implement the pre-trained model as a layer and unfreeze it, you are performing Fine-Tuning. This allows the "feature extractor" to slightly shift its understanding to better fit your specific data.

#### The Objective Function (The "Pull and Push")
The most important nuance is the Loss Function used during SBERT's fine-tuning (usually on the SNLI or Multi-NLI datasets).
* Inference/Pre-training BERT: Only cares if a word is missing or if sentence B follows A.
* SBERT Training: Explicitly tells the model: "These two sentences are 'Entailments' (mean the same thing), so force their vectors to be 0.99 similar. These two are 'Contradictions,' so force them to be 0.1 similar."
This physically warps the latent space. It breaks the "narrow cone" (anisotropy) by stretching the space out, ensuring that the dimensions actually correlate to human-perceived meaning rather than just "probability of appearing together in a book."

#### BERT Strategy Summary
The SBERT strategy transforms BERT from a word-level model into a powerful sentence encoder by physically warping its internal vector space to prioritize human meaning over raw word overlap. It achieves this using a Siamese Network structure and a "pull and push" objective function (like triplet or contrastive loss), which forces the model to map semantically similar sentences close together and dissimilar ones far apart. To create a single representation for an entire sentence, SBERT adds a Mean Pooling layer that averages all contextualized word embeddings; this provides a more "democratic" and stable summary than the standard [CLS] token, which is often too noisy for direct comparison. Ultimately, this process fixes BERT’s "narrow cone" problem (anisotropy), resulting in a spread-out, logical latent space where simple math—like cosine similarity—can finally be used to accurately and instantly compare millions of different sentences.

#### BERT "cone" (anisotropy): Words vs Seqeuences
Why can we use rely on BERTs cone vector spaces for the element parts (words) but not the sequences?

The reason for this distinction lies in how we use the vectors versus what the vectors represent. The "cone" (anisotropy) exists for both individual word tokens and the [CLS] token, but it only becomes a "problem" when you try to use Cosine Similarity to compare two standalone sequences.

When BERT processes words, it doesn't just look at a word's position in the cone; it looks at how that word relates to other words in the same sentence. Within the 12 layers of BERT, the model isn't using Cosine Similarity to "understand" words. It uses Dot-Product Attention. Even if all word vectors are crowded into a narrow cone, the model’s internal weights are trained to find the tiny, high-dimensional nuances that distinguish "bank" (river) from "bank" (money). The "cone" doesn't matter to the model because it has 768 dimensions of "resolution" to tell them apart during the math of the forward pass.

The problem arises when you take the [CLS] vector out of the model to compare it to a different [CLS] vector from a different sentence. In the narrow cone, all vectors share a very strong common mean. If you imagine a 3D plot, they are all pointing in almost the exact same direction, clustered like a tight bouquet of flowers. Cosine similarity measures the angle between two vectors. If all vectors are in a 5° cone, the angle between "I love cats" and "The moon is made of cheese" might be 1°, while the angle between "I love cats" and "I like felines" is 0.5°. To a computer, a similarity of 0.95 vs 0.98 is nearly indistinguishable. It makes the "search" results incredibly noisy because the "background noise" of the cone is louder than the "signal" of the meaning.

The [CLS] token is often even more anisotropic than the word tokens. Because the [CLS] token is forced to attend to every word (including common stop words like "the," "is," and "of"), it tends to absorb a lot of generic "English-language noise."

By the time it reaches the final layer, the [CLS] vector is heavily biased toward the "average" of the entire pre-training corpus. This is why Mean Pooling is often better: it averages out some of that specific [CLS] bias, even though it's still stuck in the cone.

If you want to compare words using BERT, here is the "Pro Tip": Don't use just the last layer. The very last layer of BERT is often too specialized for the pre-training task (Masked Language Modeling). Researchers have found that averaging the last 4 layers or using the second-to-last layer provides a much more "semantic" vector for word-to-word comparisons.

---

#### 4. What do you understand by the term Siamese network structure?
A Siamese network (also known as a twin neural network) is a specific architecture where two or more identical sub-networks are used to process different inputs separately, but in tandem. The term "Siamese" comes from the fact that these networks are joined at the "head" (the output) and, most importantly, they share the exact same weights and parameters.

#### "Identifcal Twin" Rule 
In a standard model, you can one input and one output. In a Siamese structure you have two inputs ($A$ and $B$), each go into a different networks. Network 1 and Network 2 are not just similar—they are the same model. If the weights in Network 1 change during training, the weights in Network 2 change identically.

#### The Goal: Learning "Similarity"
The purpose of a Siamese network isn't to classify an image as a "cat" or a "dog." Instead, its goal is to learn a distance metric. It asks: "How similar are these two things?"
1. Each twin network produces a vector (an embedding) for its respective input.
2. The model then calculates the distance between these two vectors (usually using Cosine Similarity or Euclidean Distance).
3. During training, if the two inputs are "the same" (e.g., two different photos of the same person), the model is penalized if the vectors are far apart. If they are different, it is penalized if they are too close.

#### Why is this used in SBERT?
As we discussed earlier, standard BERT is a Cross-Encoder (it puts both sentences into one "mouth"). SBERT turns BERT into a Siamese Network to make it a Bi-Encoder.
* The Problem: Standard BERT can't compare sentences quickly because it has to see them together.
* The Siamese Solution: By using two identical BERT "twins," SBERT learns to map sentences into a standalone vector space. Because the weights are shared, a sentence will result in the same vector regardless of whether it is processed as "Sentence A" or "Sentence B."

Siamese networks are often trained using Triplet Loss, where the model looks at three things at once: an Anchor (the reference), a Positive (something similar), and a Negative (something different). It learns to "pull" the positive closer to the anchor and "push" the negative away.

#### Doesn't this mean that SBERT still has to look at things in pairs? 
During the training phase, SBERT still has to look at pairs. The "50 million inferences" problem found in BERT is strictly an Inference (Deployment) problem, and SBERT solves it by changing how the model stores what it has learned.

In standard BERT (the Cross-Encoder), the model's "understanding" of Sentence A is dependent on Sentence B. If you want to compare "The cat sat" to 10,000 other sentences, you have to feed "The cat sat" into the GPU 10,000 separate times, once for every pair. The model has no "standalone" memory of what "The cat sat" means. It only knows how it interacts with the specific sentence it is currently looking at.

During the Siamese training phase, SBERT is forced to do the hard work of pairing. It looks at millions of pairs and learns a "Map" (a Vector Space). The goal of SBERT training is to make sure that any sentence, when passed through the model alone, ends up at a specific "GPS coordinate" (the 768-dimensional vector). Because it is a Siamese Network (shared weights), the model learns that "The cat sat" should always land at Coordinate X, and "A feline rested" should always land at Coordinate Y, which is very close to X.

Once SBERT is trained, the "pairing" happens in the math, not in the Neural Network. With SBERT, you only need to run the 10k sentences through the model during inference. You can then take that "spreadsheet" of 10k vectors can run linear algbrea expressions (Cosine Similarity) over the top. A modern CPU can do the "50 million comparisons" of these pre-calculated vectors in a fraction of a second.

##### The "Trade-off"
The only reason we don't use SBERT for everything is that it is slightly less accurate. By forcing a sentence into a single standalone vector, you lose the "word-to-word" nuance that a Cross-Encoder gets by looking at both sentences simultaneously.

---

#### Is SBERT a Siamese Architecture at Inference? 
No. At inference, you don't need the Siamese "twin" structure anymore. You only need one of those networks.

Remember that in a Siamese network, the two networks are identical. They share the exact same weights. This means that "Model A" and "Model B" are actually just two copies of the same file.

During Training you need both "twins" because you are teaching the model how to calculate the distance between two different things. You feed Sentence A into Twin 1 and Sentence B into Twin 2 simultaneously to calculate the error (loss) and update the weights.

At Inference, since both twins are identical, having two of them is redundant. You just take one of those trained BERT models, load it into memory, and use it as a standalone "Encoder."

Even though you only use one model at inference, we call it a Bi-Encoder (or Siamese) because of how it was "raised."
* Cross-Encoder: The model is a "Bilingual Dictionary." You can't use it unless you have both languages in front of you at the same time.
* Bi-Encoder (SBERT): The model is a "Translator." It takes one sentence and turns it into a universal "Coordinate" (the vector). Once you have the coordinates, you don't need the translator anymore to see which points on the map are close to each other.

---

#### 5. What are the different pooling strategies that the authors experiment with? What works best?
The SBERT authors (Reimers and Gurevych) experimented with three primary pooling strategies to collapse the token-level embeddings into a single sentence vector.

##### MEAN Strategy (Default)
This calculates the element-wise average of all contextualized word embeddings in the sentence. It is the most "democratic" approach, as it ensures every word contributes to the final vector.

##### MAX Strategy
This takes the maximum value over each dimension across all token embeddings. It is designed to capture the most "salient" or prominent features (like specific keywords) rather than a general summary.

##### CLS-Token Strategy
This simply uses the output vector of the special [CLS] token. While this was the intended "summary" token during BERT's original pre-training, SBERT uses it as an alternative baseline.

#### What Works Best?
In their ablation studies across multiple Semantic Textual Similarity (STS) benchmarks, the authors found a clear winner: **Mean Pooling (MEAN-strategy)** consistently performed the best.

According to the SBERT paper, using the raw [CLS] token or simply averaging BERT’s outputs without SBERT’s Siamese training actually resulted in embeddings that were worse than basic GloVe vectors. However, once the Siamese fine-tuning was applied, Mean Pooling emerged as the most robust method for capturing semantic meaning.

The authors found that MAX pooling significantly underperformed (for example, scoring roughly 69.9 on the STS-benchmark compared to Mean's 87.4). This is likely because Max pooling focuses too much on individual "extreme" values, which works for some classification tasks but fails to capture the subtle relational meaning needed for sentence similarity.

Mean pooling, by contrast, smooths out the noise and captures the collective context of the entire sequence, making it the most stable representation for the cosine similarity math that SBERT relies on.


---

#### 6. Outline the 4 evaluation tasks used for semantic textual similarity.

To measure how well SBERT actually "understands" meaning compared to standard BERT, the authors evaluated it on four distinct types of Semantic Textual Similarity (STS) tasks. These tasks range from simple sentence pairs to complex image captions.

##### Semantic Textual Similarity (STS) 2012–2016
This is the "gold standard" benchmark for sentence embeddings. It consists of thousands of sentence pairs from various sources (news, image captions, forums) that have been manually labeled by humans on a scale of **0 (completely different)** to **5 (exactly the same meaning).**
* **The Goal:** SBERT must calculate the cosine similarity between the two sentence vectors.
* **Evaluation:** The model’s score is compared to the human score using **Spearman’s rank correlation**. If the humans say two sentences are a "5" and SBERT gives them a high similarity, the model wins points.

> Evaluation (Testing): Uses a Metric. This is for the humans. It doesn't have to be differentiable or smooth; it just has to represent how "good" the model is at the real-world task. Spearman’s Rank is perfect here because it tells us: "If a human ranked these 100 pairs from most-similar to least-similar, did the AI put them in the same order?"

##### SentEval: Argument Facet Similarity (AFS)
This task is significantly harder than standard STS because it involves social media style debates. It uses the "Argument Facet Similarity" dataset, where people are arguing about controversial topics like gun control or the death penalty.
* The Challenge: Two sentences might use the exact same words but take opposite stances, or use different words to make the same point.
* Why it matters: This tests if SBERT can handle "noisy" text and deep logical meaning rather than just simple surface-level word matching.

##### Wikipedia Sections Mapping
The authors created a task to see if SBERT could understand the structure of a document. They took sentences from different sections of Wikipedia (e.g., the "History" section vs. the "Geography" section of a page about a city).
* The Task: A "Triple" is created: an Anchor sentence, a Positive sentence (from the same section), and a Negative sentence (from a different section).
* The Goal: SBERT must place the Anchor vector closer to the Positive vector than the Negative one. This proves the model understands topical context.

##### SICK-R (Sentences Involving Compositional Knowledge)
This dataset focuses specifically on compositional logic and negation. It contains pairs that are very similar in structure but different in meaning.
* Example: "A man is biting a dog" vs. "A dog is biting a man."
* The Challenge: Standard BERT often fails here because the word overlap is 100%. SBERT is evaluated on its ability to recognize that these two sentences should have a lower similarity score despite having identical words.

#### Summary of Results
In all four tasks, the authors found that SBERT outperformed both vanilla BERT and RoBERTa by massive margins. For example, on the STS benchmarks, SBERT improved the score from a mediocre ~54.0 (standard BERT) to a state-of-the-art ~85.0+.

---

#### 7. Why would Spearman’s rank correlation coefficient be better than Pearson’s product-moment correlation coefficient when comparing ratings of semantic textual similarity?
Spearman’s rank correlation is preferred over Pearson’s for Evaluating Semantic Textual Similarity because human-assigned scores (0–5) are ordinal rather than strictly linear; the perceived "distance" between a 1 and a 2 may not be mathematically identical to the distance between a 4 and a 5. While Pearson’s coefficient is highly sensitive to outliers and requires a straight-line relationship to show success, Spearman’s coefficient only cares about the relative rank order of the pairs. This makes it a more robust and accurate reflection of human logic, as it rewards the model for correctly identifying that Sentence A is "more similar" than Sentence B, even if the model's raw numerical output follows a curved or non-linear distribution.

---

#### 8. What are the different objective functions that the authors experiment with? When is each used?
The SBERT authors experimented with three main objective functions, each designed for a different type of training data. Because BERT doesn't naturally produce "comparable" vectors, these functions are the "tools" used to physically reshape the vector space.

##### Classification Objective Function
This is used when you have labeled categories for sentence pairs, most commonly the Natural Language Inference (NLI) dataset (which labels pairs as Entailment, Neutral, or Contradiction). 
* The Math: It takes the two sentence embeddings $u$ and $v$ and concatenates them with their absolute difference: $(u, v, |u - v|)$. This is then multiplied by a trainable weight matrix $W_t \in \mathbb{R}^{3n \times k}$ (where $n$ is the embedding dimension and $k$ is the number of labels) and passed through a Softmax classifier.
* The Goal: To optimize the Cross-Entropy Loss. By forcing the model to categorize the relationship between $u$ and $v$, the model learns to place "Entailing" sentences close together in the vector space.

##### Regression Objective Function
This is used when you have a specific numerical score for how similar two sentences are, such as the STS (Semantic Textual Similarity) benchmark where pairs are rated from 0 to 5.
* The Math: The model calculates the Cosine Similarity between the two embeddings $u$ and $v$.
* The Goal: To minimize the Mean Squared Error (MSE) between the model's predicted similarity and the actual human-labeled score. This is the most direct way to teach the model that "similarity" should equal "small distance" in the vector space.

##### Triplet Objective Function
This is used when you have a "reference" sentence and want to distinguish between a "good" match and a "bad" match. It requires three inputs: an Anchor ($a$), a Positive ($p$), and a Negative ($n$).
* The Math: The loss function is defined as :$$\max(||s_a - s_p|| - ||s_a - s_n|| + \epsilon, 0)$$ (where $|| \cdot ||$ is a distance metric like Euclidean distance and $\epsilon$ is a margin).
* The Goal: To ensure that the distance between the Anchor and the Positive sentence is smaller than the distance between the Anchor and the Negative sentence by at least a margin of $\epsilon$. This is often used for training models on Wikipedia sections or triplets where "closeness" is relative.

---

#### 9. How is the SentEval evaluation different to the previous evaluation experiments?
While the STS (Semantic Textual Similarity) tasks we discussed earlier focus on a single, specific metric—how "similar" two sentences are—SentEval is a much broader and more rigorous "stress test" for sentence embeddings. If STS is a specialized 100-meter dash, SentEval is a Decathlon.

#### Extrinsic vs. Intrinsic Evaluation
The previous STS experiments were Intrinsic: they measured the quality of the vector space itself (the distances/angles). SentEval focuses on Extrinsic evaluation: it asks, "How useful are these vectors when we actually plug them into a real-world machine learning model? Instead of just calculating a cosine similarity score, SentEval takes the SBERT vectors and uses them as features to train a simple linear classifier for various "downstream" tasks.

#### The Multi-Task "Transfer" Battery
SentEval doesn't just look at similarity; it tests Transfer Learning across 7 distinct types of classification tasks.

This proves that the model hasn't just memorized "similarity" but has actually learned a "general-purpose" understanding of language. The tasks include:
* Sentiment Analysis: (e.g., MR, SST) Is this movie review positive or negative?
* Product Reviews: (CR) Categorizing customer feedback.
* Subjectivity: (SUBJ) Is this sentence a fact or an opinion?
* Opinion Polarity: (MPQA) Determining the tone of a statement.
* Paraphrase Detection: (MRPC) Are these two sentences identical in meaning?

#### Testing "Linguistic Properties" (Probing)
SentEval includes "Probing Tasks" that specifically check if the embeddings capture basic linguistic "facts." It asks the model:
* Length Prediction: Does the vector "know" how many words are in the sentence?
* Word Content: Can we tell if a specific word is present just by looking at the vector?
* Bigram Shift: Can the model tell if two words in the sentence were swapped (which changes the meaning)?

| Feature | STS Experiments | SentEval Experiments | 
| :--- | :--- | :--- | 
| Primary Goal | Measure "Distance" vs "Meaning" | Measure "Utility" for real apps | 
| Method | Cosine Similarity (No training) | Linear Classifier (Trained on features) |
| Scope | One specific task (Similarity) | "7+ diverse tasks (Sentiment, Logic, etc.)" | 
| Conclusion | The vector space is organized. | The vectors are smart enough for any job. |

The authors used SentEval to prove that by fixing the "similarity" problem, they didn't break BERT's ability to do other things. They showed that SBERT vectors are superior to vanilla BERT vectors for almost every downstream task, effectively making SBERT the "Swiss Army Knife" of NLP models at the time.

---

#### 10. What are the main conclusions of the paper? Are you convinced?

#### Main Conclusions
**The Efficiency Revolution:** They proved that by using a **Bi-Encoder** (Siamese) structure, they could reduce the time to find the most similar sentence in a collection of 10,000 from **65 hours** (standard BERT) to **5 seconds.**

**The Quality Fix:** They demonstrated that vanilla BERT’s hidden states and [CLS] tokens are "terrible" out-of-the-box sentence embeddings. By using **Mean Pooling** and fine-tuning on **NLI (Natural Language Inference)** data, they achieved a massive jump in accuracy (from ~54 to ~85 on STS benchmarks).

**The Transferability Power:** Through the **SentEval** experiments, they showed that SBERT isn't a "one-trick pony." The embeddings it creates are high-quality enough to be used as fixed features for sentiment analysis, parity detection, and other linguistic tasks without needing to re-train the whole model.

#### Limitations
1. **The "Information Bottleneck":** The biggest limitation is the loss of granular interaction. 
    * Standard BERT (Cross-Encoder): Can compare every word in Sentence A to every word in Sentence B ($N \times M$ interactions). It can see that the word "not" in one sentence completely flips the meaning of "happy" in the other.
    * SBERT (Bi-Encoder): Must compress the entire sentence into one vector (e.g., 768 dimensions). This is an "Information Bottleneck." If a sentence is 50 words long, trying to squeeze all that nuance into a single point in space inevitably leads to the loss of subtle details, like negation or specific entity relationships.
2. **Sensitivity to Sentence Length:** Because SBERT uses Mean Pooling to create its final vector, it can struggle with very long documents.
    * As a sentence gets longer, the "average" vector starts to become "diluted" by less important words (stop words, filler phrases).
    * his makes SBERT excellent for short-to-medium sentences but often poor for comparing entire paragraphs or pages of text, where a single keyword might be the most important feature.
3. **The "Out-of-Distribution" Fragility:** SBERT is heavily dependent on the data it was fine-tuned on (usually NLI or STS datasets).
    * If you take a standard SBERT model trained on Wikipedia and social media and try to use it for Legal Contracts or Medical Research, its performance often drops significantly.
    * Because it has "learned" a specific way to warp its vector space based on general English, it might not recognize that two highly technical medical terms are synonyms unless it was specifically trained on a medical "twin" network.
4. **Limited "Logic" and Negation**: Despite the triplet loss training, Bi-Encoders still struggle with complex logical structures compared to Cross-Encoders.
    * The Problem: Two sentences like "The medicine is safe for children" and "The medicine is NOT safe for children" have extremely high word overlap.
    * Because SBERT's vector space is built on "global" meaning, the "averaging" process of Mean Pooling can sometimes "wash out" the impact of a single word like "NOT," leading the model to think these two opposites are highly similar.

#### The Modern Solution: "The Re-Ranking Pipeline"
Because of these limitations, almost no professional system uses only SBERT. Instead, they use a **Two-Stage Pipeline**:
1. **Stage 1 (Recall):** Use **SBERT** to quickly find the top 100 most similar documents from millions of options (takes milliseconds).
2. **Stage 2 (Precision):** Use a **Cross-Encoder** to carefully re-rank those 100 documents to find the absolute best match (takes a few seconds).

---

## Week 7: Lab Content

---

## Week 7: Additional Reading
* [Jurafsky and Martin Chapter 8: Transformers](https://web.stanford.edu/~jurafsky/slp3/8.pdf)
* [Jurafksy and Martin Chapter 10: Masked Language Models](https://web.stanford.edu/~jurafsky/slp3/10.pdf)
* [(Jurafksy and Martin Chapter 7: Large Language Models)](https://web.stanford.edu/~jurafsky/slp3/7.pdf)

* Devlin et al. (2019): Pre-training of Deep Bidirectional Transformers for Language Understanding in NAACL 2019, https://www.aclweb.org/anthology/N19-1423/
* Peters et al. (2018): Deep contextualised word representations in Proceedings of NAACL 2018 https://arxiv.org/pdf/1802.05365.pdf
* Peters et al. (2018): Dissecting Contextual Word Embeddings: Architecture and Representation in Proceedings of EMNLP 2018 https://www.aclweb.org/anthology/D18-1179.pdf
* Reimers et al. (2019):
* Vashwani et al. (2017): Attention is all you need in Proceedings of NIPS 2017
* Yang et al. (2020) : (https://arxiv.org/pdf/2004.12297.pdf)

---

<br>
<br>
<br>
<br>
<br>
<br>

# [Week 8 - Transfer Learning with Pretrained Large Language Models](https://canvas.sussex.ac.uk/courses/36171/pages/week-slash-topic-8-transfer-learning-with-pretrained-large-language-models?module_item_id=1602175)
Week 7 was the "Discovery" phase (how Transformers work and how BERT is pre-trained). Week 8 is the "Application" phase. We are moving from high-level theory to the engineering reality of Transfer Learning.


This week we will be looking at how to use pre-trained large language models such as BERT.
* transfer learning through fine-tuning
* sequence classification with BERT
* sequence labelling with BERT
* the BERT family
* Alternatives including
* GPT
* In-context learning / prompting
* T5

> Okay, so let's start by just recapping what we've done so far in the module. We've talked quite a lot about language models, including neural language models. We've talked about distributional representations of meaning that might be extracted from those language models and how we might once we've got representations for words/tokens, we might compose them to make, um, representations of larger units of meaning. We also started talking last week about contextualized word embeddings how we might update the representation of a word or token based on the other tokens around it. And we talked about Elmo and then we also introduced the transformer architecture as well as BERT, which, if you remember, stands for bidirectional encoder representations from Transformers. In the last part of um, the lecture last week, we were talking about techniques of pre-training large language models including and masked language modeling. So that's sort of quick kind of recap.

#### Week 8: Contents

1. [Lecture](#week-8-lecture)
2. [Seminar](#week-8-seminar)
3. [Paper](#week-8-paper)
4. [Additional Readings](#week-8-additional-reading)

## Week 8: Lecture

* [Recording Part 1](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=2a5425eb-8d27-4bd6-a1dd-b40b00d35504&start=0)
* [Recording Part 2](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=ef3eb639-4686-4604-88b4-b40b00dcb15e&start=0)

## The Distributional Hypothesis: for words 
The Distributional Hypothesis serves as the theoretical foundation for modern vector-based language models, famously summarized by J.R. Firth’s idea that "a word is characterized by the company it keeps." It proposes that words appearing in similar linguistic contexts tend to share similar semantic meanings. In practice, this allows us to represent words as real-valued vectors where the dimensions represent the contexts in which the word occurs. For example, "beef" and "chicken" would share high values in dimensions representing "food" or "cooking," but would diverge in dimensions related to "living animals," as "beef" specifically refers to the meat rather than the creature itself.

---

## Contextualised Word Embeddings 
Building on the distributional hypothesis, Contextualized Word Embeddings (introduced by models like ELMo and BERT) move beyond static look-up tables by ensuring a word's representation is a function of its specific surroundings. Instead of assigning one fixed vector to a word like "bank," these models use bi-directional architectures to "read" the entire sentence, allowing them to capture deep semantic nuances and resolve polysemy. By accounting for the words to both the left and right of a target token, the resulting embedding becomes a dynamic reflection of that word's meaning in a specific instance rather than a generic average.

---

## Beyond words 
We have a model for words, how does this scale up to: 
* phrases
* sentences
* utterances
* documents
* discourse

If we've got a representation for "noisy" and a representation of "chicken", how do we get a representation for "noisy chicken".

---

## Principle of compositionality 
The Principle of Compositionality (attributed to thinkers like Frege and Boole) asserts that the meaning of a complex expression is a direct function of the meanings of its individual parts and the structural rules used to combine them. In the context of NLP, this allows us to move "Beyond Words" by asking how we can mathematically combine distributional word vectors to represent larger units like phrases ("noisy chicken") or entire documents. While humans use syntax and logic for this, models typically use Composition Methods—ranging from simple algebraic operations like Mean Pooling (averaging vectors) to more complex neural architectures—to ensure that a sentence-level representation remains grounded in the specific meanings of its constituent tokens.

---

## The distributional hypothesis: for sentences? 
Applying the Distributional Hypothesis to sentences shifts the focus from word-level neighbors to Sentential Contexts. Just as a word is defined by the words around it, the meaning of a sentence can be inferred from the sentences that precede and follow it in a discourse. Under this intuition, two different sentences are considered semantically similar if they are interchangeable within the same larger narrative or document structure. While most models approximate this by mathematically composing word vectors (e.g., mean pooling), the goal remains the same: to create a unique "spatial" representation where sentences with similar communicative intents sit closer together in a high-dimensional vector space.

---

## Sentential contexts 
The leap is made from words to Sentential Contexts, where a sentence’s meaning is defined by the other sentences surrounding it in a discourse. However, since the possible contexts for a sentence are infinite, most models rely on Composition Methods rather than direct lookup. Instead of treating a sentence as a single unit, we assume its meaning is a function of its constituent words. In practice, this usually involves a pooling operation, such as mean pooling (averaging) or addition (Mitchell and Lapata, 2010), to collapse individual word embeddings into a single vector that represents the entire phrase or document.

---

## SBert (Reimers and Gurevych 2019) 
SBERT (Sentence-BERT) optimizes standard BERT by using a siamese network architecture to produce semantically meaningful sentence embeddings. While standard BERT requires passing sentence pairs together (which is computationally expensive), SBERT processes each sentence through identical BERT structures, applies a pooling operation (like mean pooling) to get fixed-sized vectors ($u$ and $v$), and then calculates their cosine similarity. By training on objectives like classification or regression, SBERT "tunes" the vector space so that sentences with similar meanings are mathematically closer together. This allows for massive scaling, as individual sentence embeddings can be computed once, stored, and compared instantly.

---

## Today 
* Transfer learning
* Fine-tuning BERT-based models for
    * text classification
    * sequence labelling
* The BERT family
* More distant relatives; such as GPT (more for week 9)
* Schick and Schütze (2021)

---

## Transfer Learning through Fine-tuning 
Transfer learning is the process of acquiring knowledge from one source task or domain and applying it to solve a new, specific task. In the world of Large Language Models (LLMs), this is a two-stage process. First, the model undergoes pre-training on massive, unannotated corpora. Using self-supervised objectives like Masked Language Modeling (MLM) and Next Sentence Prediction (NSP), the model teaches itself the fundamental rules, grammar, and nuances of language without requiring expensive human-tagged data. During this phase, the model is essentially a "generalist" that understands how words and sentences relate to one another.

Fine-tuning is the second stage, where this general linguistic knowledge is transferred to a specific application, such as sentiment analysis, translation, or summarization. This involves taking the pre-trained model and training it further on a smaller, labeled dataset tailored to the final goal. While the model's "brain" is already built, fine-tuning acts as a specialized training program that teaches the model how to use its existing knowledge to solve the specific problem at hand.

A key shift occurs in the role of specific tokens during this transition. In a raw, pre-trained BERT model, the [CLS] token is primarily trained to handle the NSP task, acting as a binary switch to determine if two sentences belong in the same story. However, once the model is fine-tuned for a task like sentiment analysis, the [CLS] token transforms into a global aggregator. It "sponges up" a summary of the entire input sequence, providing a single, dense vector that a classifier head (like an MLP) can use to make a final decision, such as whether a review is "Happy" or "Sad."
---

## Fine-tuning 
In the Fine-tuning phase, we move from general language modeling to task-specific application by adding and training application-specific parameters. The most common approach is to attach a simple "head"—such as a single-layer neural network (MLP)—directly on top of the pre-trained BERT architecture. This head is then trained using a labeled dataset (e.g., movie reviews labeled as "positive" or "negative") to map BERT's complex internal representations to the specific classes required by the task.

During this process, we have a critical architectural choice regarding the model's weights: Freezing vs. Unfreezing.
* Freezing: We can "lock" the pre-trained BERT parameters so they remain unchanged, training only the new classification head. This is computationally faster and prevents "catastrophic forgetting," where a model loses its general linguistic knowledge by over-specializing on a small dataset.
* Full Fine-tuning: Alternatively, we can allow updates to be made to some or all of the original BERT layers. While more resource-intensive, this allows the "base" of the model to adapt its understanding of language to better suit the nuances of a specific domain, such as medical or legal text.

---

## Text classification with BERT 
Text classification, also known as sequence classification, is the process of assigning a category to an entire string of text, such as determining if a movie review is positive or negative. To perform this with BERT, the input sequence must be prepended with the special [CLS] (Classification) token. Because this token is part of BERT's original vocabulary and was used during pre-training to aggregate sequence-level information, it must be present during fine-tuning to act as a mathematical proxy for the entire sentence.

During the forward pass, the input text moves through the Transformer layers to produce a contextualized vector for each token. For classification, we focus solely on the final output vector of the [CLS] token ($y_{CLS}$). This vector is fed into a classifier head—typically a linear layer with a learned set of weights ($W_C$)—which maps the high-dimensional embedding to a set of raw scores for each possible class. These scores are then passed through a Softmax function to produce a probability distribution across the target categories (e.g., 90% Positive, 10% Negative).

The training process is driven by Supervised Learning, requiring a dataset of sequences paired with their correct labels. By calculating the Cross-Entropy Loss between the Softmax output and the ground-truth label, the model uses backpropagation to update its parameters. Depending on the strategy, the optimizer might only update the weights of the classifier head ($W_C$) while keeping the BERT model frozen, or it may perform "full fine-tuning" where both the head and the underlying language model weights are updated simultaneously.


---

## In practice ... with Huggingface transformers library 
In practice, the Hugging Face transformers library simplifies the fine-tuning process by providing specialized classes like `BertForSequenceClassification`. This class wraps a standard pre-trained BERT model with a task-specific "head"—usually a linear layer sitting on top of the pooled output (the [CLS] token representation). By inheriting from PreTrainedModel, it allows users to easily load weights (like bert-base-uncased), initialize a tokenizer that matches the model's expected vocabulary, and move the entire architecture to a GPU (CUDA) for efficient training. This high-level API handles the architectural complexity, leaving the user to focus on defining the number of labels and providing the data.
* `transformers.BertForSequenceClassification`

```
from transformers import BertTokenizerFast, BertForSequenceClassification
from transformers import Trainer, TrainingArguments

# check text classification models here: https://huggingface.co/models?filter=text-classification
model_name = "bert-base-uncased" [cite: 141]

# load the tokenizer
tokenizer = BertTokenizerFast.from_pretrained(model_name, do_lower_case=True) [cite: 142, 143]

# load the model and pass to CUDA
model = BertForSequenceClassification.from_pretrained(model_name, num_labels=len(target_names)).to("cuda") [cite: 144, 145]
```

---

## Training the Sequence Classification Model 
To make the training process clearer, we can think of the Hugging Face Trainer API as the "engine" that automates the standard machine learning loop. Instead of writing manual code for backpropagation, validation, and saving models, you provide the Trainer with four key components:
1. **The Model:** A pre-trained architecture with a classification head (e.g., `BertForSequenceClassification`).
2. **Training Arguments:** A configuration object (`TrainingArguments`) that defines the "hyperparameters"—the rules of the race. This includes the **learning rate** (how fast to update weights), **batch size** (how many sentences to process at once), and the number of **epochs** (how many times to look at the entire dataset).
3. **The Datasets:** Your tokenized and encoded training and validation sets.
4. **Evaluation Metrics:** A function that tells the model how to measure its success (e.g., Accuracy or F1-score).

Once these are set, calling trainer.train() initiates the fine-tuning process. The Trainer automatically handles the distribution of data to the GPU, calculates the Cross-Entropy Loss, updates the weights via the optimizer, and evaluates the model against the validation set at the end of each epoch to ensure it isn't just "memorizing" the training data.

See https://www.thepythoncode.com/article/finetuning-bert-using-huggingface-transformers-python 

```
trainer = Trainer(
    model=model,                         # the instantiated Transformers model to be trained
    args=training_args,                  # training arguments, defined above
    train_dataset=train_dataset,         # training dataset
    eval_dataset=valid_dataset,          # evaluation dataset
    compute_metrics=compute_metrics,     # the callback that computes metrics of interest
)

# train the model
trainer.train()
```

---

## Training arguments 
The TrainingArguments object is essentially the "instruction manual" for the HuggingFace Trainer. It defines the specific hyperparameters and strategies that dictate how the model learns during fine-tuning. Instead of manually writing loops for backpropagation or validation, you pass this configuration to the Trainer to automate the heavy lifting.

Key parameters in this configuration include:
* **Strategy** (`evaluation_strategy` & `save_strategy`): Determines how often the model is tested against validation data and saved (e.g., at the end of every "epoch" or full pass through the data).
* **Learning Rate (`learning_rate`):** Controls the size of the steps the model takes when updating its weights. For BERT fine-tuning, this is typically very small (e.g., $2 \times 10^{-5}$) to avoid over-writing the pre-trained knowledge.
* **Batch Size:** Defines how many samples are processed simultaneously. This is often limited by the available memory (VRAM) on your GPU.
* **Weight Decay:** A regularization technique that prevents the model weights from becoming too large, which helps reduce **overfitting**.
* **Model Selection (`load_best_model_at_end`):** Ensures that the final model saved is the one that performed best on your chosen `metric_name` (like Accuracy or F1), rather than just the model from the very last training step.

When selecting a metric_name, we typically align it with the specific goals of the GLUE benchmark tasks to ensure our evaluation is standardized and comparable to other state-of-the-art models.

```
args = TrainingArguments(
    f"{model_name}-finetuned-{task}",
    evaluation_strategy = "epoch",
    save_strategy = "epoch",
    learning_rate=2e-5,
    per_device_train_batch_size=batch_size,
    per_device_eval_batch_size=batch_size,
    num_train_epochs=5,
    weight_decay=0.01,
    load_best_model_at_end=True,
    metric_for_best_model=metric_name,
    push_to_hub=True,
)
```

---

## The GLUE Benchmark tasks 
The GLUE (General Language Understanding Evaluation) Benchmark is a standardized suite of nine distinct classification and regression tasks designed to evaluate how well a model understands the complexities of human language. Rather than testing a model on a single specific job, GLUE requires it to perform well across a variety of linguistic challenges, from grammar and sentiment to logical inference and paraphrasing.

To make these easier to reference for your notes, I’ve categorized the nine tasks by their linguistic "goal":

#### 1. Linguistic Acceptability & Sentiment (Single Sentence)
* **CoLA (Corpus of Linguistic Acceptability):** Determines if a sentence is grammatically correct or "acceptable."
* **SST-2 (Stanford Sentiment Treebank):** A classic binary sentiment task (Positive/Negative).

#### 2. Similarity & Paraphrasing (Sentence Pairs)
* **MRPC (Microsoft Research Paraphrase Corpus):** Determines if two sentences from news sources are semantically equivalent.
* **QQP (Quora Question Pairs):** Identifies if two questions asked on Quora are asking the same thing.
* **STS-B (Semantic Textual Similarity Benchmark):** Assigns a similarity score from 1 to 5 to a pair of sentences.

#### 3. Natural Language Inference / Entailment (Logic Pairs)
* **MNLI (Multi-Genre NLI):** Given a premise and a hypothesis, the model predicts if the hypothesis is true (entailment), false (contradiction), or neutral. It includes "Matched" and "Mismatched" (out-of-domain) test sets.
* **QNLI (Question-answering NLI):** Based on SQuAD, the model must determine if the second sentence contains the answer to the question in the first sentence.
* **RTE (Recognizing Textual Entailment):** A smaller entailment dataset similar to MNLI but with only two classes (Entailment vs. Not-Entailment).
* **WNLI (Winograd NLI):** A challenging task involving pronoun resolution; it determines if a sentence with a replaced pronoun logically follows from the original.

See https://colab.research.google.com/github/huggingface/notebooks/blob/main/examples/text_classification.ipynb

---

## Compute metrics 
The compute_metrics function is the bridge between the raw numerical outputs of your model and the human-readable performance scores (like Accuracy or F1) defined by benchmarks like GLUE. During evaluation, the model provides "logits" (raw scores), but we need to compare these against the "references" (true labels) to see how well the model is actually performing.

In the Hugging Face ecosystem, this is typically handled using the datasets library to load a specific metric script that matches the task at hand. The process involves three main steps:
1. **Loading the Metric:** You use load_metric("glue", "task_name") to fetch the specific evaluation logic for your data (e.g., sst-2 for sentiment).
2. **Processing Predictions:** The eval_pred object contains the model's raw predictions and the true labels. Because the predictions are usually raw logits, you often need to apply np.argmax to select the index of the highest score as the predicted class.
3. **Computing the Score:** These processed predictions and labels are passed into metric.compute(), which returns a dictionary of results (e.g., {'accuracy': 0.92}).
 

```
import numpy as np
from datasets import load_metric
metric = load_metric("glue", "sst-2")

fake_preds=np.random.randint(0,2,size=(64,))
fake_labels=np.random.randint(0,2,size=(64,))
metric.compute(predictions=fake_preds, references=fake_labels)

def compute_metrics(eval_pred):
    predictions, labels=eval_pred
    # more code here if needed to pre-process predictions /labels into lists e.g., select appropriate column
    return metric.compute(predictions=predictions, references=labels)
```

By providing this function to the Trainer, the model will automatically report its progress in terms of "Accuracy" or "F1" at the end of every epoch, rather than just showing the decreasing "Loss" value.

---

## Using the Sequence Classification Model 
After fine-tuning is complete, the final step is Inference: using the trained model to make predictions on new, unseen data. Since the model expects specific numerical inputs, this process requires a coordinated pipeline between the **Tokenizer** and the **Model**.

The inference process generally follows these four steps:
1. **Preprocessing:** The raw input string must be passed through the same `tokenizer` used during training. This ensures the text is split into the correct WordPiece tokens, prepended with `[CLS]`, and converted into `input_ids` and `attention_masks`.
2. **Forward Pass:** These tensors are fed into the model. By calling `model(**inputs)`, the data passes through the Transformer layers and the classification head.
3. **Probabilistic Output:** The model returns "logits" (raw scores). To turn these into human-readable confidence levels, we apply a **Softmax** function, which scales the scores so they sum to 100%.
4. **Label Selection:** Finally, we use `argmax` to find the index of the highest probability and map that index back to the original class name (e.g., index `1` $\rightarrow$ "Positive").

```
def get_prediction(text):
    # prepare our text into tokenized sequence
    inputs = tokenizer(text, padding=True, truncation=True, max_length=max_length, return_tensors="pt").to("cuda")
    # perform inference to our model
    outputs = model(**inputs)
    # get output probabilities by doing softmax
    probs = outputs[0].softmax(1)
    # executing argmax function to get the candidate label
    return target_names[probs.argmax()]

print(get_prediction(text))
```

---

## Drawbacks 
While the Hugging Face BertForSequenceClassification class is incredibly convenient for rapid prototyping, it can be somewhat opaque for students or researchers who want full control over their architecture.

The primary drawback is that it functions as a "Black Box." When you load this pre-built model, the classification head—the layers sitting on top of BERT that actually make the decision—is hidden. To see the specific weights or the exact mathematical operations (like whether it uses a single linear layer or multiple dense layers), you often have to dig deep into the library's source code.

Furthermore, the documentation frequently refers to a "pooled output" as the input for the classifier. While we know this is derived from the [CLS] token, the library’s internal pooling method (which involves a linear layer and a Tanh activation function) might not be the specific strategy you want. For example, you might prefer Mean Pooling (averaging all token vectors) or Max Pooling, but changing these defaults within the pre-built class is non-trivial.

Finally, there is a practical "overhead" to the ecosystem. To use some of the more advanced automated features, you are often encouraged to sign up for the Hugging Face Hub. For those who prefer a "from scratch" approach or need to understand every tensor operation for a custom research project, this abstraction can feel like a burden. This is precisely why building a Custom BertClassifier (as seen in your lab notes) is so valuable—it strips away the mystery and shows exactly how the [CLS] vector is transformed into a prediction.

---

#### High-Level Steps Towards Being Your Own Classifying Head
1. **Initialize the "Base" Model:** You load the standard `BertModel` (without the classification head). This gives you the 768-dimensional hidden states for every token.
2. **Define your Architecture in __init__:**
    * **The Base:** Set `self.bert = BertModel.from_pretrained('bert-base-uncased')`.
    * **The Layers:** Add any PyTorch layers you want. Usually, this includes a Dropout layer (to prevent overfitting) and a Linear layer that maps 768 dimensions down to your number of classes (e.g., 2 for positive/negative).
3. **Define the Logic in `forward`:**
    * Pass your `input_ids` through BERT.
    * **Select the Input:** Decide which part of BERT's output to use. Most people use the `pooled_output` (the vector representing the `[CLS]` token).
    * **The Transformation:** Pass that `[CLS] `vector through your Dropout and Linear layers.
4. `The Loss Function:` Since you aren't using the built-in `Trainer` logic for the head, you manually define `nn.CrossEntropyLoss()` during your training loop to compare your model's "logits" to the actual labels.

---

#### Is Pre-training always better via Hugging Face?
Yes, almost always. "Pre-training" (the stage where BERT learns English from Wikipedia) is incredibly expensive, requiring thousands of dollars in compute and weeks of time. It is always more practical to download the pre-trained weights from Hugging Face.

The only time you would "pre-train" yourself is if you are doing Intermediate Pre-training (also called Domain Adaptation). This is when you take a pre-trained BERT and train it a little bit longer on a very specific type of text (like legal documents or medical records) using the Masked Language Model task before you ever add a classification head. This helps the model learn a "specialized vocabulary" before it starts its specific job.

---

## Code for BERTclassifier (from lab) 

This some code from the lab that we will use to build our own classifer head. Relies on `pytorch`. The `forward` part puts the inputs through the BERT, then takes the pooled output which is the CLS token and feeds it into a linear model which has been set up in the class init. 

```
#now we need to put a simple classification layer on top of BERT
from torch import nn
from transformers import BertModel

class BertClassifier(nn.Module):
    def __init__(self, dropout=0.5, num_classes=2):
        super(BertClassifier, self).__init__()
        self.bert=BertModel.from_pretrained('bert-base-uncased')
        self.dropout=nn.Dropout(dropout)
        self.linear=nn.Linear(768, num_classes)
        self.relu=nn.ReLU()

    def forward(self, input_id, mask):
        last_hidden_layer, pooled_output = self.bert(input_ids=input_id, attention_mask=mask, return_dict=False)
        dropout_output=self.dropout(pooled_output)
        linear_output=self.linear(dropout_output)
        final_layer=self.relu(linear_output)
        return final_layer
```

---


## Freezing layers
Freezing layers is a strategic choice during fine-tuning that determines which parts of the model’s "brain" are allowed to change. When we freeze the BERT layers, we set their parameters to be non-trainable (requires_grad_(False)), meaning the gradients from our loss function only update the weights of our newly added classification head.

This approach offers several practical advantages:
* **Computational Efficiency:** Training only the final linear layer is significantly faster and requires less memory (VRAM) than updating all 110 million parameters of BERT-base.
* **Preventing "Catastrophic Forgetting":** If our specific dataset is very small, full fine-tuning might cause the model to "overfit," essentially erasing the general linguistic knowledge it gained during pre-training to satisfy the patterns of a tiny sample. Freezing ensures the "Generalist" knowledge remains intact.
* **Feature Extraction:** By freezing BERT, we are treating it as a fixed **feature extractor**. We trust that the vectors it produces are already "good enough" to represent language, and we only need to teach our custom head how to interpret those fixed vectors for our specific labels.

In practice, researchers often start by freezing BERT to train the head, and then "unfreeze" the top few layers of BERT for a few final epochs of training to subtly align the model's internal representations with the specific nuances of the target task.

```
model=BERTClassifier(num_classes=len(labels.keys()))

#this will freeze the pre-trained BERT model and just make the classification head trainable
#can speed things up and avoid "catastrophic forgetting" / overfitting on task-specific data
model.bert.requires_grad_(False)
```

---

## Pairwise Sequence Classification 
Pairwise classification is the task of determining the relationship between two distinct sentences. The two primary ways to handle this represent a trade-off between accuracy and speed.

**The Cross-Encoder Approach (Standard BERT):** You concatenate Sentence A and Sentence B, separated by a `[SEP]` token: `[CLS] A [SEP] B [SEP]`.
* **Advantage:** Higher accuracy. The model performs cross-attention between every word in Sentence A and every word in Sentence B simultaneously.
* **Disadvantage:** Extremely slow for large-scale search. To find the most similar sentence in a collection of 10,000, you have to run the model 10,000 times for a single query.

**The Bi-Encoder Approach (SBERT):** You pass Sentence A and Sentence B through the model separately to get two fixed vectors ($u$ and $v$).
* **Advantage:** Massive speed. You can pre-calculate and store vectors for millions of sentences and compare them instantly using **Cosine Similarity**.
* **Disadvantage:** Slight drop in accuracy because the model cannot "cross-reference" specific words between the sentences during the encoding process.

---

## Sequence Labelling with BERT 
In sequence labeling, we assign a tag to every token in the input. While the simplest method is to attach a classifier head to every output token, this ignores the interdependencies between tags (e.g., in Named Entity Recognition, an "Inside-Person" tag should never follow an "Outside" tag).

Simplest approach is to pass each output of each of the input tokens from BERT to a simple classifier

**The CRF (Conditional Random Field) Solution:** A CRF acts as a "sanity check" layer on top of BERT. It learns a transition matrix that understands which tags are likely to follow one another.
* Why use it? While BERT provides strong contextual features, the CRF ensures the final sequence of tags makes global sense, correcting "impossible" transitions.

**The Subword Complication:** BERT uses WordPiece tokenization (e.g., "playing" $\rightarrow$ "play", "##ing").
* Strategy: Usually, we only label the first subword of a word and provide a "dummy" or "ignored" label to the subsequent subwords during training to avoid biasing the model toward long words.

---

## Sequence Labelling ... with Huggingface Transformers 
Simplest way to do SL is to use HF transformers library

token classification pipeline 

dont need to do things like pooling for Sequence Labelling so less incentive to build your own

https://huggingface.co/docs/transformers/tasks/token_classification 

Code Snippet:
```
from transformers import AutoModelForTokenClassification, TrainingArguments, Trainer

model = AutoModelForTokenClassification.from_pretrained("distilbert-base-uncased", num_labels=2)
```

---

## BERT Family 
| Model | Primary Innovation | Key Takeaway |
| :--- | :--- | :--- |
| **RoBERTa** | Better Pre-training | Ditches NSP; uses larger batches and more data to prove BERT was "under-trained." |
| **ALBERT** | Parameter Reduction | Uses factorized embedding layers and cross-layer parameter sharing to be 18x smaller. |
| **DistilBERT** | Knowledge Distillation | A "Student" model mimics a "Teacher" model to retain 97% performance at 60% higher speed. |
| **SciBERT** | Domain Adaptation | Pre-trained on scientific papers; essential for specialized medical/research NLP. |
| **mBERT** | Multilingualism | Trained on 104 languages; allows for "Zero-shot cross-lingual transfer." |

---

## ROBERTa 
* Alternative to BERT from Facebook (Liu et al (2019)): a robustly optimized BERT pretraining approach
* Pre-trained on even larger corpus
* Ditches next sentence prediction and just uses MLM for pretraining
    * dynamic masking (different masks each time sentence is used)
    * Full-sentences without NSP loss
    * large mini-batches (8K sequences)
    * larger byte-level BPE (50K subword units, 15M-20M additional parameters)

--- 

## AlBERT 
A Lite BERT for Self-supervised learning of language
representations (Lan et al. 2019)

Incorporates 2 parameter reduction techniques with a view to
making pre-trained models more scalable
* factorization of the vocabulary embedding matrix
* cross-layer parameter sharing

Performance also improved with sentence order prediction
task

18x fewer parameters than BERT and trained about 1.7x faster

---

## DistilBERT 
In the context of machine learning and models like DistilBERT, "distilled" refers to a technique called Knowledge Distillation. This is a compression process where a large, complex model—known as the Teacher—is used to train a much smaller, more efficient model—known as the Student. Instead of just training the Student on the "hard" correct answers (0 or 1 labels), the Student is trained to mimic the Teacher’s "soft" output probabilities. For example, if a large BERT model thinks a sentence is 90% likely to be "Positive" and 10% likely to be "Neutral," the distilled Student model tries to match that entire distribution. This "soft" information contains "dark knowledge" about how the Teacher perceives the relationships between different concepts, allowing the smaller Student to capture roughly 97% of the Teacher's performance while being 40% smaller and 60% faster.

* a distilled version of BERT: smaller, faster, cheaper and lighter (Sanh et al. 2019)
* knowledge distillation during pre-training
* a compact model (the student) is trained to reproduce the behaviour of a larger model (the teacher) or ensemble of models
    * reduces size by 50%
    * retains 97% of language understanding
    * 60% faster

---

## SciBERT 
* SciBERT: a pretrained language model for scientific text
(Beltagy et al. 2019)
* basically BERT pre-trained on large multi-domain corpus of
scientific publications
* Improved in-domain results

---

## MBert 
Multilingual BERT, model released by Devlin et al. at the same
time as BERT

See Pires et al (2019): How multilingual is Multilingual BERT

trained on text from 104 languages

does not contain any explicit translation information

Intuition is that embeddings for words in different languages
will be embedded in the same space due to commonalities in
the vocabularies for the languages (e.g., names, numbers and
other shared vocab)

---

## More Distant Relatives of BERT 
Other Pretrained Large Language Models, generally still
based on transformers e.g.,
* GPT,
* Turing-NLG,
* T5,
* XLNet,
* Electra

Will talk about these in later weeks

---

## GPT-3: Prompting & In-Context Learning
Brown et al. 2020: Language Models are Few Shot Learners

GPT-3 marked a paradigm shift from Fine-tuning (updating weights) to Prompting (using the model as-is).

Autoregressive Nature: Unlike BERT (Bi-directional), GPT is Uni-directional (Left-to-Right). It predicts the next token, which makes it a natural "writer."

#### The Prompting Paradigm:
* Zero-shot: "Translate to French: Hello $\rightarrow$"
* One-shot: "Apple $\rightarrow$ Pomme. Hello $\rightarrow$"
* Few-shot: Providing 3–5 examples in the prompt to "prime" the model's logic.

In-context learning does not update the model's weights. The "learning" happens entirely within the model's temporary attention span (context window). Once the session ends, the "knowledge" of those examples is gone.


---

## Text-to-Text Transfer Transformer (T5) 
Raffel et al. 2020: Exploring the Limits of Transfer Learning with a Unified Text to-Text Transformer

T5 (Text-to-Text Transfer Transformer) unified NLP by treating every problem—whether regression, classification, or translation—as a string-to-string task.

Task Prefixes: Instead of changing the model's architecture, you simply change the input text (e.g., "summarize: ..."). The model uses these prefixes as a conditioning signal to shift its internal attention weights toward a specific task.

Span Denoising: T5's unique pre-training replaces entire chunks of text with "sentinel tokens" (<X>, <Y>). This teaches the model to predict both the content and the length of missing information, making it more robust than BERT's single-word masking.


Figure 1: A diagram of our text-to-text framework. Every task we consider—including translation, question answering, and classification—is cast as feeding our model text as input and training it to generate some target text. This allows us to use the same model, loss function, hyperparameters, etc. across our diverse set of tasks. It also provides a standard testbed for the methods included in our empirical survey. “T5” refers to our model, which we dub the “Text-to-Text Transfer Transformer”.

| Task Category | Input String (Task Prefix + Context) | Output String (Target Text) |
| :--- | :--- | :--- |
| **Translation** | "translate English to German: That is good." | "Das ist gut." |
| **Linguistic Acceptability (CoLA)** | "cola sentence: The course is jumping well." | "not acceptable" |
| **Semantic Similarity (STS-B)** | "stsb sentence1: The rhino grazed on the grass. sentence2: A rhino is grazing in a field." | "3.8" |
| **Summarization** | "summarize: state authorities dispatched emergency crews tuesday to survey the damage after an onslaught of severe weather in mississippi..." | "six people hospitalized after a storm in attala county." |

The key takeaway here is that T5 treats everything as a string-to-string problem. Unlike BERT, which needs a custom "Classification Head" to turn vectors into labels, T5 literally "writes out" the answer. It uses the same decoder architecture to produce a sentiment label ("not acceptable") as it does to produce a translation or a summary. T5 represents a shift from the "Encoder-only" world of BERT to an Encoder-Decoder framework (where everything is a sequence-to-sequence problem)

This diagram represents a major departure from the BERT-style fine-tuning we discussed earlier. While BERT requires you to build a custom "Classification Head" to turn vectors into labels, T5 (Text-to-Text Transfer Transformer) uses a Unified Framework:
* **No Custom Heads:** T5 uses the exact same Encoder-Decoder architecture for every task. It doesn't output a class index; it literally generates the text of the answer.
* **Task Prefixes:** The model knows what to do based on the Prefix (e.g., "summarize:" or "translate:"). This allows one single model to handle dozens of different linguistic jobs without changing its internal structure.
* **Regression as Text:** Note the STS-B example—T5 treats a similarity score (3.8) as a string of characters rather than a raw numerical value.

---

#### Are the Task Prefixes rule-based?
No, the prompt is the input to the encoder and the prefix, i.e. "summarise", is handled by the weights of the model directly. There is no hard-coded rule or "switch" inside the model that says, "If you see 'summarize', go to the summarization department." 

Instead, the task prefix is treated as just another sequence of tokens. Because T5 was trained on a massive mixture of different tasks simultaneously, it learned through Gradient Descent that when the input starts with certain patterns (like translate English to German:), the output should follow a specific "style" or "logic" (like producing German words).

When you input "summarize: [Text]", the tokenizer breaks "summarize" and ":" into their own token IDs. These IDs are then converted into Vectors (Embeddings). To the model's first layer, the word "summarize" is just a specific point in a 768-dimensional space.

Because T5 is a Transformer, it uses Self-Attention. The encoder looks at every token in the sequence. When the model "reads" the main body of your text, the attention mechanism is constantly looking back at those first few tokens (the prefix).
* The weights in the attention heads have been trained to "attend" heavily to the prefix to decide how to process the rest of the sentence
* If the prefix is `"cola sentence:"`, the attention weights shift the model’s internal state to focus on syntax and grammar.
* If the prefix is `"sentiment:"`, the weights focus on emotive adjectives.

The prefix acts as a Conditioning Signal. Think of it like a "mood" for the entire neural network. The prefix doesn't trigger a separate part of the model; rather, it changes how the entire set of weights responds to the input text.

---

### T5 also uses MLM 
Pre-training involves unsupervised objectives which are similar to the MLM of BERT and “word dropout” regularization technique (Bowman et al. 2015)

Figure 2: Schematic of the objective we use in our baseline model. In this example, we process the sentence “Thank you for inviting me to your party last week.” The words “for”, “inviting” and “last” (marked with an x) are randomly chosen for corruption. Each consecutive span of corrupted tokens is replaced by a sentinel token (shown as <X> and <Y>) that is unique over the example. Since “for” and “inviting” occur consecutively, they are replaced by a single sentinel <X>. The output sequence then consists of the dropped-out spans, delimited by the sentinel tokens used to replace them in the input plus a final sentinel token <Z>.

This process is known as Span-denoising, which is T5’s version of BERT's Masked Language Modeling. Instead of masking single words, it masks whole "spans" (chunks) of text.

| Stage | Text Content | 
| :--- | :--- | 
| Original Text | Thank you for inviting me to your party last week. | 
| Inputs (Corrupted) | Thank you <X> me to your party <Y> week. | 
| Targets (Predicted) | <X> for inviting <Y> last <Z> | 

#### Key Mechanics of this Objective:
- **Sentinels:** Unlike BERT which uses a generic `[MASK]` token, T5 uses unique sentinel tokens (`<X>`, `<Y>`, `<Z>`) to act as placeholders for specific missing chunks.
- **Span Collapse:** Notice that "for" and "inviting" are two words, but they are collapsed into a single `<X>`. This teaches the model to predict how many words might be missing, not just which ones.
- **Efficient Decoding:** The model doesn't try to reconstruct the entire original sentence. It only generates the "missing pieces," which makes the training objective computationally efficient.

---

### T5 Fine-Tuning 
T5 (Text-to-Text Transfer Transformer) achieves its "unified" nature through a unique approach to fine-tuning. Unlike BERT, which requires swapping out architectural "heads" for different tasks, T5 is fine-tuned by feeding it a variety of supervised tasks simultaneously using the exact same objective: generating the correct target string. Because every task—from translation to regression—shares the same global parameters, the model can leverage cross-task transfer, where learning the structural nuances of one task (like linguistic acceptability) can actually improve its performance on another (like summarization).

To successfully use a fine-tuned T5 model, you must adhere to the Prompt Format it was trained on. This is because the model relies on Task Prefixes to "trigger" the correct internal logic. If you want a summary, you cannot simply provide the text; you must prepend the specific string the model expects (e.g., "summarize: "). These prefixes act as a conditioning signal, shifting the Transformer's attention weights to focus on the specific linguistic features required for that output style.

---

### Still to come (weeks 9 and 10) 
¡ ChatGPT and open-source alternatives
¡ Retrieval Augmented Generation (RAG)
¡ Prompt engineering
¡ Reasoning with LLMs
¡ Trustworthy and responsible LLMs / AI
¡ Environmental impact of LLMs / AI

---

## Week 8: Seminar
No Questions


## Week 8: Paper
Schick and Schütze (2021): Exploiting Cloze Questions for Few Shot Text Classification and Natural Language Inference

Schick and Sch¨utze (2021) introduce Pattern-Exploiting Training (PET), a semi-supervised training procedure that reformulates input examples as cloze-style phrases to help language models understand a given task. Once you have read the paper, consider the following questions.

1. What do you understand by the term few-shot learning? Why is it important /challenging in NLP?
2. What is a Cloze question or Cloze-style phrase?
3. What is pattern-verbalizer pair (PVP)? Give some examples of your own that might be used for different tasks e.g., sentiment classification and paraphrasing
4. How are the PVPs used in training and inference?
5. What is catastrophic forgetting and how is it avoided?
6. How are di↵erent PVPs used to create a final model?
7. What is iPET?
8. What experiments did the authors carry out to demonstrate the e↵ectiveness of their approach? What do you think of the results?
9. What does the analysis in section 5 tell us?
10. What are the main conclusions? Are you convinced? Would you use this approach?


## Week 8: Lab
Lab 9b; Bonus lab!

Have a go at fine-tuning BERT for Named Entity Recognition

---

## Week 8: Additional Reading
* [Jurafsky and Martin 2026, Chapter 7: Large Language Models](https://web.stanford.edu/~jurafsky/slp3/7.pdf)
* [Jurasfsky and Martin 2026, Chapter 9: Post-training: Instruction Tuning, Alignment, and Test-Time Compute](https://web.stanford.edu/~jurafsky/slp3/9.pdf)

---

### Suggested reading 
* [Brown et al. (OpenAI) (2020). Language Learners are Few Shot Learners](https://arxiv.org/abs/2005.14165)
* [Devlin, J., Chang, M.-W., Lee, K., & Toutanova, K. (2019). BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding.](https://aclanthology.org/N19-1423/)
* [Liu et al. (Facebook) (2019). RoBERTa: A Robustly Optimized BERT Pretraining Approach.](https://arxiv.org/abs/1907.11692)
* [Mitchell, J. and Lapata, M. (2010). Composition in distributional models of semantics.]()
* [Pires et al. (2019). How Multilingual is Multilingual BERT?](https://aclanthology.org/P19-1493.pdf)
* [Raffel et al. (Google) (2020). Exploring the Limits of Transfer Learning with a Unified Text-to-Text Transformer.](https://arxiv.org/pdf/1910.10683)

---

#### Further reading
* [Beltagy et al. (2019). SciBERT: A Pretrained Language Model for Scientific Text.](https://aclanthology.org/D19-1371/)
* [Bowman et al. (2015). A large Unannotated Corpus for Learning Natural Language Inference. ](https://aclanthology.org/D15-1075/)
* [Lan et al. (Google) (2019). ALBERT: A Lite BERT for Self-supervised Learning of Language Representations.](https://arxiv.org/abs/1909.11942)
* [Peters, M. E., Neumann, M., Iyyer, M., Gardner, M., Clark, C., Lee, K., & Zettlemoyer, L. (2018). Deep contextualized word representations]()
* [Sanh et al. (Huggingface) (2019). DistilBERT, a distilled version of BERT: smaller, faster, cheaper and lighter.](https://arxiv.org/abs/1910.01108)
* [Vaswani et al. (Google) (2017). Attention is All You Need.](https://arxiv.org/abs/1706.03762)

---














# [Week N - TITLE]()

#### Week N: Contents

1. [Lecture]()
2. [Seminar]()
3. [Lab]()
4. [Additional Readings]()

## Week N: Lecture

## Week N: Seminar

## Week N: Lab Content

## Week N: Additional Reading