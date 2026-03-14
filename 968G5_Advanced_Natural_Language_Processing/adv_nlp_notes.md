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





## Representing Sequences for Classifcation

classically, doc level is a BoW. no order just counts of words

What are the benefits and limitations of bow? 

Loose context of order and sentimate. 

Same, similar sentences, in terms of comoposition of words will be represeent the same

Limited in knowing semantic relationships between words and effect of order

but it is a simokle approach that allows us to create and analyse something quickly with a good enough result

## Tradityionall Approach

ML classifer, i..e naive bayes, log reg, ff net, svm

Train on train split, test on split. need labelled data

Bayes approach is about finding most likely class based on feature

[quickly insert bayes summary formulas]

* bayes
*ingore denomin
* apply anive

## Using Language Models in Classification

Know we know about language models, distributed reps and embeedding. How to us this for classifc

lang model tells us the prob of a seq, how can this help us classify it into some categories?

* Baysian Approach NB
* WOrd embbed based approach
* Neural Approahc (leads us inot trans later)

## Baysian Approach to classifcation

---

In simple terms, taking a Bayesian approach means treating probability as a "degree of belief" that gets updated as new evidence comes in.

While traditional (Frequentist) statistics focuses on how often an event happens in the long run, Bayesian statistics focuses on how certain we are about a hypothesis right now, given what we already know.

A Bayesian analysis always follows a specific logical flow, often summarized by Bayes' Theorem:

$$P(A|B) = \frac{P(B|A)P(A)}{P(B)}$$

A measure of certainty or belief.

The output is Posterior distributions and Credible Intervals.

Small Sample Sizes: If you don't have much data, your "Prior" knowledge can help steer the analysis so the results aren't wildly skewed by a few outliers.

A Bayesian "95% Credible Interval" actually means there is a 95% chance the value falls in that range—which is how most people wish traditional statistics worked.

It is ideal for machine learning and AI because the model can constantly update its "beliefs" every time a new piece of data arrives, rather than restarting from scratch.

Most standard neural networks are not Bayesian by default, but there is a specific subfield called Bayesian Neural Networks (BNNs).

Strictly speaking, no. Batching (or Mini-batch Stochastic Gradient Descent) is a frequentist optimization tool, not a Bayesian one.

Batching was invented for efficiency. Calculating the gradient (the direction to update weights) for a dataset of 1 million images at once is too slow and memory-intensive. We break it into "batches" of 32 or 64 simply so the computer can handle the math.

Even though batching isn't "Bayesian" by design, it introduces noise. Because each batch is just a random slice of the data, the "direction" the model moves in vibrates slightly.

In Bayesian terms, this noise can be seen as a way of exploring the "probability space" of the weights.

There is a specific technique called Stochastic Gradient Langevin Dynamics (SGLD) that essentially uses batching noise to turn a regular neural network into a Bayesian one.

The math for BNNs is incredibly "expensive." Instead of learning one value for a weight, the computer has to learn the mean and the variance, effectively doubling the parameters and making the calculus much harder.

---

Build a seperat lang model of each class, i.e.  P(seq|class)

[INSERT FORMULAS]

build a model for each class; n-gram, neural 

n-gram model could give us a prob for each work to a class. apply to sequences (i.e. not a BoW) to work out the prob of class

however, this approach has largely been superseeded by word embedding approachs 

## Word Embedding Approach

Distribution hypothesis: words which which eman similar things tend to behave in similar ways

i.e. they co-occur with sim words

i.e. they have simi.ar word embeds

build a occurance matrix 

[insert cooccur matix]

but how can we go from represenations of words to res of seqs or docus

## The princ of compositionality

"The meaning of a complex epression is determined by the meanings of its constitut express and the rules used to combine them"

## composition for meaning repres

constit expressions are words

words are represented by distitubional rep/embeddings, i..e word2vec or glove, taken from nn models

to get rep of seq, we need to compos the embed of the words

how to we do that? rules of composutions? (from the orgin quiote)

## additive composiotion

add the vectors (of the individual words)

OR average the vectors (find the centriod)

the result is often the same as the direction is the similar

remember we are interested in the cosine similariyy so it is the direction that matters

## using word embeedings

whatever rule we decide, sum/contriod/max, for all of the word emdbeds for words in the seq

pass the input to a classifer: log reg, svm, nn


[insert image going to from words to seq using embbed > pool > mean> > classif]

i.e. you have obtained a seq embed that can be used

## disad of adding word embeds

word embeds are uncontextualised

it individual word embedds were just of the raw word (in our example)

they didn't take into account their context or surroundings, just words

head:body, head:leader

the word order was not taken into account (depending on the method). This is def true is adding the vectors, order never matters for adding vectors (i think?)

but it is easy to implelent. 

## Language Model of r Seq Rep

Previously we were taking the word embeddings out of our networks and using them in various ways

Other approach, is a bidirectional rnn or lstm to build a full representation of the sequence. 

put word embeds into a forward and backwards rnn

i.e. represent a seq by what is predicted to the left, or the right of it

the forward rep is telling us what might come next and has knowledge of what came before it 

backward predicts the previous words, gives us a diff view of the seq

note that we want a fixed them rep

and then concatenate the reps b_Y, f_y (back, for), this is the rep of the seq

[insert bi dir image]

[insert bi dir going into prediuction net]

last bi dir layer is the seq rep


---







## Part 2: Sequence Labelling

what do we mean by seeq lab?

have input seq of someomthing, probably words, but culd be chars, parts

seq label we want to label each part of the input seq

[insert image of example]

traddiitonally, the mainapproach for this was Part of Speech tagging

another is named entity recognition

these approaches are often layered on top of each other

## IOB encoding 

i inside, o outside, b begining 

again layered with named enttiy 

B-per 
B-In

first name, last name, 

turn span ident into seq label problem using iob encoding, i.e. we just have 1 tag per token, not layering seq tabs

find the correct span of text that constititie an entity

## evaluation

precision

recall

f1

[include formauls and definitions]

tethered to notion of correct entitiies

## classification 

seq label task is essentially a classsifcation task for each word/token

however, we want to assign the most likely sequence of labels given the observed tokens

NOT the most liekly label for each token given all of the other tokens

we want to predeict a seq, not an individual 

so this might rule out simple classifs like bayes or log reg

## approaches to seq labelling

* rule-based
* baysian (HMMs) updating knowledge as now evidence arises
* discriminative (memm, cpf) (what???)
* rnn, lstm
* LATER: transform/attenion (bert)
* LATER: hynbrid

## rule-based

still v common in pracrice, cheap and easy to implement based on domain knowledge

lists, atlases, varying degreees of supervised ML

not going to talk abou thtis much

## baysian models

mldel join prob dists fgrom trainind data

labels are viewed as latnent of hidden staes which generates observed seq

bayes theorme us used to obtain a conditional probability to label unseeen data

for seq lab probs; we emplore Hidden Markov Models

## Simple HMM 

2 states to consider; per, not

thouhg normally there would be alot more

hmm looks that state transition probability

the probabiliy of trans from PER to NOT, or PER TO PER

there is an indep assumoption that the current state only depends on the previous state

often given as a state transition matrix

the emssion probabilities are P(obs word|state)

the prob of the rpevious word emiiting the next stte

the probability are derived from labell corpora using maximum likelihood estimate

learn the underlying probs from the trainng data

apply the baysian on the sequenceusing the underlying probs

---

In the world of statistics, MLE (Maximum Likelihood Estimation) is the "Frequentist" way of finding the best fit, while MAP (Maximum A Posteriori) is the "Bayesian" version of that same goal.

MLE asks: "Which parameter values make the data I just saw most likely to occur?"The Logic: It assumes you have no prior knowledge. It only cares about the current evidence.The Math: It only maximizes the Likelihood ($P(\text{Data} | \theta)$).The Flaw: If you flip a coin once and it lands on heads, MLE will tell you the coin is 100% rigged to heads. It has no "common sense" to tell it that most coins are fair.

The reason is that Hidden Markov Models (HMMs) are Generative Models, and in the early days of ML, we often mixed Bayesian logic with Frequentist optimization to save on computing power.

An HMM is considered Bayesian (specifically a Bayesian Network) because of its Conditional Dependency: It assumes there is a "Hidden State" (the truth) that you can't see. It assumes the "Observation" (the data) is generated based on that state. When you run the model, you use Bayes’ Rule to "invert" the logic: "Given these observations, what is the most likely hidden state?"

the inference (using the model) is purely Bayesian. You are updating your belief about the hidden state as you see each new observation in the sequence.

To make an HMM work, you need three things: Transition probabilities, Emission probabilities, and Initial state probabilities.

MLE HMMs are fast. You can solve them with dynamic programming (the Viterbi algorithm) in linear time.

The HMM is a Bayesian Architecture usually trained with Frequentist Tools.

---

## More on HMMs

To maximise the probabiltiy of tag sequence give word sequence, Bayes is applied

[INSERT FORMULA]

p(tags|words) = 

us viberti algo to find the tag seqwhich opt the prob (not going into this here)

## Hiddem Markow Model (HMM)

Drawbacks arise from the two simplifiying assumptions

Bi-gram (what whartever order chosen), limits model history [INSRERTT FORMULA]

much prevous tags are not considered

feature independance limits model richness [INSERT FORMULA]. independ assump allows us to product but we know in practise this isnt true

## Discrimitate Model 

Max Ent Mark Model (MEMM)

Conditioan Random Field (CRF)

Get away from indepdn assumptiopn

and leverage interdependance between features

in order to discfrim between different classes

## MEMM

not going into too much details

in HMM model: P(obs|tag)

in MEMM model: P(Tag|Obs)

## label bias problem 

memms use a per-state expon model

couldn't dedice tags intil later in the seqenece

wasnt able to make use of early info (is that right?)

solution was COnditional Random Fields (CRFs)

srps have a single expo model for the joint prob of the entire label seq

more complex model

memm created a model for each state/label

crf just one model for whole seq

## what is a crf

an indurected graph where 

## linear cgain crf

[insert graph showing diff]

## graphical comp among hmm, memm, cpir

no arrows, output depds on whole seq

[insert diagram]

## linear chain crf

details about details for crf, but we arent going to worry about the details on how to train one

We just want to know that they exist

NN can have crf layers

just know that we are modelling the distribution of the entire set of a seqouence output given the entire sequence of input ariables

rather than having a single model per state

or you using the latnest approach from hmm based on prev tag label 

## Neural Models

Bi-dir lstm is most popular non trandformuler for serq label 

vanilla RNN and GRU were also used

NN allow anytihn input (word, char, embedd) to be used

ma and hovy (20216) good based for bi-lstm arch

## ma and hovy

a char rep for each word is generated from a cnn based on char embeddings (similar to kim et al)

char rep is then conccanated (into words?) using glove word embed

gives a rep of a word based on cooccurenaces with other words (other words come from the glove)

char rep from CNN + other words context form glove

char talks issues with low freq words as learn structure of words

glvoe works well for high freq words and context unpacks semantics (is taht the right topic?)

bi-dir lstm is acheived by concatenating left to right and right to left lstm hidden states

cpr is used as output layer (rather than softmax) to decode label seqs

[INSERRT PAPER DIAGRAMS]

char embed > comvo > max pool > char rep

then char and glove reps are collections are the inputs and put into the networks

f lstm, b lstm, both into cpf

cpf means inputs to not optimise on a token basis, but other the whole output seq

this is the basic archiecture to approach this

## adv of neural approach

end-to-end seq label, no feature engingeering

seq of words > seq of labels

test of diff net archs and hypernmater opt

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

Macro average if more informative than Micro average. micro average revert to accuracy (how?)

Good to do both and comment on them both.

> The evaluation measure for subtask TC is micro-average F1. Note that as we have converted this into a **single-label task**, micro-average F1 is equivalent to Accuracy (as well as to Precision and to Recall).

#### 2. Describe 3 different ways in which language models might be used in sequence classification

---

* Bayesian Approach

A Bayesian approach means treating probability as a "degree of belief" that gets updated as new evidence comes in.

Classes + sequence. Update the probability of a global class probability using element (feautre) of a sequence. (is the updating fearture the sequence or the elements of the sequence?)

---

* Word Embeddings Based Approach

Use work embedding as inputs into a model, or to create a sentence embedding to also use as input into a classifying model. 

If constructing a sequence embedding then need to find the sum/centroid/max (composition) of the word. 

Better approach is to use a network, i.e. a bi-directional RNN or LSTM, to build a representation of the sequence using the work level respresentations as input. Concat the forward and backward RNN representations. (Maybe this is the end-to-end neural approach?)

---

* End-to-end Neural Approach

---

#### 3. Different methods might be used to compose word embeddings? What are the advtanges and disadvantage?

Additive, mutliplicative, pooling to create a single context vector. 

Centriod of the two vectors is still termed as additive composition. Direction still the same as additive, so from a cosine similarity perspective still the same thing. (add = average)

Adding, or averaging, word vectors looses the context of the order of the vectors. Additionally, word vector may not have semantics contextualised depending on how the embeddings were constructed, i.e. co-ocurrence word embeds. 

---

## Part 2: Sequence Labelling

#### 1. Give an example sentence and show how it might be annotated using an IOB encoding for Named Entity Recognition (e.g. PER, ORG, LOC etc)

---

#### 2. What do understand by each of the following; HMM, MEMM, CRF. 

**Hidden Markov Model:** Bayesian Approach, State Transition Probs, Emissions, MLE underlying probabilites from training corpus. Prob for each (all) states give the previous `n` states. Can be used to generate tag or word sequence.

**Maximum Entrophy Markov Model:** HMM wasn't that good for named entity tagging. Opposite to HMM, models prob of current tag based on previous state and current obs (word).

**Conditional Random Field:** MK have no ability to backtrack. you have to start making state predictions straight away. if a mistake this bubbled through the model. also later context may update earlier preds. CRF models full sequence directly, using a single logistic regression model. slower, more powerful. maths doesn't matter for this module. Often used as a the end of a neural model. 

---

#### 3. Describe the typical components in a neural model for sequence labelling. 

Embed, RNN/LSTM/iterative/memory-based model, sequence predictor

Word embeddings from glove to provide contextual info

Char reps to learn word structure. this compliemnet where word embeddings are not strong reps (convolutional model)

---

## Week 5: Paper

SemEval-2020 Task 11: Detection of Propaganda Techniques in News Articles

Da San Martino et al. (2020) introduce a competition to detect and classify propaganda techniques in text. When reading this paper, do not be overly concerned with the different systems which took part in the competition. You will learn about the best-performing methods (transformer-based approaches including BERT) in a few weeks time. For now, we will focus on the overall idea of propaganda detection, the two tasks introduced in this paper (span identification and technique classification), the dataset and the evaluation metrics. Once you have read the paper, consider the following questions.

#### 1. What do you understand by the term propaganda and why might it be important to develop systems which can automatically detect propaganda in text?


---

#### 2. Why is automatic propaganda detection difficult?


---

#### 3. Give examples of 3 different propaganda techniques being used in text. Explain why this is propaganda.


---

#### 4. What textual features might be useful to help a system detect propaganda?


---

#### 5. Describe the pipeline proposed by the paper for propaganda identification. Can you think of any alternatives? What advantages / disadvantages are there of each?


---

#### 6. How was the PTC-SemEval20 corpus collected and annotated? What do you understand by “the γ agreement on the annotated articles is on average 0.6”?


---

#### 7. How do the authors evaluate systems on the span identification task?


---

#### 8. Micro-average F1 is used to evaluate systems on the technique classification task. The authors state that for a single-label task, this is equivalent to accuracy. Explain


---

#### 9. Outline one method which could be used to carry out span identification.


---

#### 10. Outline one method which could be used to carry out techniques classification.


---

#### 11. Systems were evaluated for span identification on both the development set and the test set. Why do you think the results are not the same on both?


---

#### 12. What is the predominant propaganda technique found in the corpus? If a system labelled every propaganda snippet with this label, how would it do? What do you think of the system results for techniques classification (Table 6)?

---

## Week 5: Additional Reading

Jurafsky and Martin Chapter 4: Logistic Regresssion and Text Classificaton.

Jurafsky and Martin Chapter 17: Sequence Labelling for Parts of Speech and Named Entities.

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

1. [Lecture]()
2. [Seminar]()
3. [Lab]()
4. [Additional Readings]()

## Week 6: Lecture

Moving into sequence generation tasks such as Machine Translation.

* Classical MT (Pre 1990s); only talk about briefly
* Statistical MT (1990-2015); Word-based models, Phrase-based models.
* Neural MT (2015 - ); Encoder-decoder models

---

## PART 1: Machine Translation.

### Why/is MT hard?

* Lexical Differences 
* Structural differences (morphological differences and syntactic differences)
* Study of systematic cross-linguistic similarities and differences is called linguistic typology

---

### Lexical Divergences

* Homonymy and polysemy (in both languages); ambiguous words in both languages. 
* e.g., “I know that machine translation is hard.”à French savoir, in fact french need this. 
* whereas “I know David Weir.” à French connaître. Person not fact.
* Diff distinctions in diff languages. Chinese distinguished between older and younger brother. In english would just be brother: "I met my brother".
* Could be grammatical difference, i.e. structure of sent in english vs german. 
* Gender making works, common in romance langs
* Lexical gaps, words directly stolen from other language, no word exists in translation

### Morphological Different

Morphology, the way a word is broken down into different parts, or Morphemes. 

Diff language approach this in diff ways

In some, they are clear differentiable, distinguishable, i.e. Finnish. Known as agglutinative

Others are fusion, where the morphemes are not clearly distinguishable. Parts may contain multiple bits of into. Russian is like this. 

Additional some languages don't really have morphological change, these are "isolating" such as chinese

Others have high morpheme to word ratio, this gives it the ability to form words which are equivalent to sentences in other languages, this is known as polysynthetic. (a literal word that contains enough content (morphs) to form the meaning of an entire sentence in a word)

Iso to synthentic

viet, england, turkic, swahili, eskimi-inuit

english is quite low on the scale, it is quite iso

### Syntactic Differences

See Jurafsky and Martin Chapter 13 if interested

SVO vs SOV vs VSO

Subject verb order etc; about sentence order and structure

### Evaluation

* Human raters; decide how good the trans is; 
    1. fluency, rating on scale to 1-5, "cloze" task, delete nth word and ask human reader to guess word, gives us a labels task to eval from; 
    2. fidelity; adequacy/informativeness, does it give same info as original text, was any of the input text lost or ignored;
    3. There is a post-edit cost. how long did the human rated translator take for evaluation purposes. 

* Automatic Evaluation; BLEU, 2001, still used in most evals,; chrF, most recent work moving towards this. 

### BLEU

Has a machine hypo for the translation

example shows two possible human translation

not worrying about what the input sentence was

bleu stats by looking as average unigram precision

=1/2 (3/5+4/5)

clearly flawed but good start

Why are we just thinking about precision

Why not recall (recall and precision)?

**ask gemini to explain this and refresh the definitions**

proposal of bleu, don't think about recall as couldn't expect to get high recall. there are many ways to translate, cant ness expect to get the exact ref translation. but want ot know that the words predicate are correct

flaw only considering unigrams (get to this in a min)

probs with prec, easy to get good prec without getting anything meaningful, gaming the eval metric

i.e machine pred; "the the the the", the always occurs to prec will be maxed out

### Modified Precision 

For each word in the machine translation, take the maximum

number of times it occurs in any human reference
¡ For example, mmax(the) = 2

Restrict the number of times a word can appear in machine
translation to its m_max

would turn "the the the the the" from 5/5 to maybe 1 or 2 / 5

### BLEU (cont)

compute modified prec of uni, bi, tri, quad

check if "the weather" exists etc

combined using geometric mean (?)

penality for trans with are too short

good eval of increment changes to same general architecture; related to Papineni 2002 paper (this week)
* doesn't require human eval, takes time

### chrF

character based F score (popovic 2015)

char based rather than word based

overcomes problems with different tokenization standards; important when trans between languages with different tokenization patterns; diff tokenizers or diff languages

think about why bleu was proposed; didn't use recall as hypo couldn't full match human; but if we concern that human can be diff from hypo, even if hypo if true, then this is true for all hypos, so the issue is normalized; we want to compare diff hypos and systems against human references, the lower recall bias doesn't really matter for comparisons, the actual score won't be fully correct but robust for comparison.

work out char based prec and recall: 

chrp = percentage of char 1-gram, ..., n-gram in the hhypo that occur in the reference, averaged

chrr = percentage of char, 1-gram, ..., n-gram, in the reference that occur in the hypo, averaged

combine to make an f-score

could be f1, but actually use a param beta, allows us to give more weight to one of the P or R

i.e. twice as much weight to precision or recall.

**apparently giving beta to P gives more weight to R, why is this**

[INSERT FORMULA HERE]

---

## PART 2: Approaches to Machine Translation

### Classical MT: Vauquios Triangle

Pre-19990s systems were rule-based; direct translation, transfer-based, interlingua based. 

Generally a word for word translation, sometimes with reordering. Sometimes with analysis, or even transforming into an intermediate interlingua. 

### Statistical Machine Translation

Focus on results not process

What does it mean for a sentence to be a translation of some often sentence

Concept of faithfulness (same info) and fluency (in target lang)

Stat, based on probability derived from parallel corpora.

corpora: sents in ref coupled target language, used for training, supervised. 

### Bayesian Noisy Channel 

source lang F, trans late to target lang E

consider there is a noisy channel that took the target and formed it into the source

almost a backward approach

mostly likely target to have generated the source

e_hat (sequence of target) = argmax P(source|target) * P(target)

P(source|target) = capture model faithfulness (info)

P(target) captures model fluency

allows us to breakdown the problem

### P(E): Fluency

The underlying model assigns probs to sequences

It should learn, or derive, that the uncommon, or irregular, sentences have a lower probability then common ones.

Can be obtained from any monolinguial corpus. Don't need to know anything info about another language

Most systems used an n-gram language model 

### P(F|E): faithfulness

Probability of source give the target

Simplest models are based on word alignment 

mapping between words 

the simplifying assumption was that each source word comes exactly 1 target work

the mapping could be 1 to many, many targets align to source

note, this is just a flavour, not used anymore

### Estimating Translation Probs

parallel corpora -> sentence aligned data

### Expectation Maximise

(not going to go into this much)

How to get probs

init model param, all conns equally likely

assign probs (E-step)

estimate param (M-step)

iterate

not important to understand details (any more)

### From Word-Based Models to Phrase-Based Models

Word-based models assume one-to-many alignment of words

Word-based models cannot (easily) handle non-
compositional phrases **(what is comp??)**

Phrase-based models treat phrases as atomic units

many to many

### Phrase alignment

Generated by running word alignment algorithms in both directions to give
* a one-to-many alignment
* a many-to-one alignment

Classifiers developed to decide how to symmetrize the alignments somewhere between intersection (min) and union (max)

### Phrase translation

Given a phrase alignment, we can store each
pair of aligned phrases in a phrase translation
table together with its MLE translation
probability:

𝑃 𝑓|𝑒 = 𝑐𝑜𝑢𝑛𝑡(𝑓, 𝑒)
∑! 𝑐𝑜𝑢𝑛𝑡(𝑓, 𝑒)

This gives us the ``translation options” for
each phrase at decode time.

### Standard Model of Phrase Based Machine Translation (PBMT)

For translating French (source language) to English (target language), use a log-linear model:

[INSERT FORMULA]

The feature functions hi are typically
* a language model;
* a reordering model;
* a word penalty; and
* various translation models (phrase translation and word translation)

before (word-based) we were framing it as the target generating the source, now we have moved to a discriminative log linear

**What is the difference between a generative Bayesian model and a discriminative log-linear model?**

**What does inference and training look like?**

### Decoding for Phrase-Based Statistical MT

relevant for nn models also 

Finding the sentence which maximises translation
probability is a search problem

we can't possible try every sentence available in X lang to find the best fit

exhaustive search is in impossible

need to make optimisations to avoid searching all combinations

phase-based translation, use tables to limit search space. even then a large space **meaning?**

decoders tend to use best-first search

maintain a priority queue (or stack) with all partial translation hypos and their scores

update in iterations and prune queue using beam search. 

bs; at each iteration only keep the k most promising search states and prune high cost states (**meaning?**)

### Shortcoming of PBMT

battle design choices. 

large phrase trans table become really large

inability to generalise; similar phases don't share statistical weight. they are atomic units, no idea of similar; 


---

## PART 3: Neural Machine Translation

### NMT

### Basic Arch of NMT

Encoder-decoder; seq to seq

comprised of 2 rrns/lstm, one to consume, one to generate

squeezed into vector in the midle to decode

RNN1, the encoder, builds a representation of the source
sentence x = x1 … xn

ℎ = 𝑒𝑛𝑐𝑜𝑑𝑒𝑟(𝑥)

The output from RNN1 (after the complete source
sentence has been read) is input to RNN2, the decoder to
generate target sentence

𝑦_i+1 = 𝑑𝑒𝑐𝑜𝑑𝑒𝑟(ℎ, 𝑦_1 … 𝑦i)

[INCLUDE DIAGRAM]

### RNNs

RNNs are very effective at learning language models i.e., P(E) the probability of a sentence in a given language. During training, the error (i.e., difference between output and next word) is backpropagated to update the weights used to combine Xt and ht-1AND the representations of the words (Xt)


### LTSM

Simple RNNs struggle with long term dependencies e.g.,
“He grew up in Spain. He speaks fluent …”
Spain infleuces word, increase prob, doesn't mandate spanish. lstm should be better than remembering start

LSTMs overcome this problem by having 4 interacting layers in each repeated module.


### Encoder-Decoder Details

In most classic "Sequence-to-Sequence" tasks (like Translation or Speech-to-Text), no, you never discard the encoder. You need it for every single sentence you process.

Think of it like a Translator (Encoder) and a Writer (Decoder) working together in a room.

There is one specific scenario where the Encoder is "set aside," and that is Generative Pre-training (like GPT).

GPT-style models are Decoder-only. They don't have an Encoder at all! They are trained to just "continue" a sequence.

BERT-style models are Encoder-only. They are great at "understanding" text, but they are terrible at writing long sentences.


### Possible Weakness

Slow training and inference speed
¡ Ineffectiveness at dealing with rare words
¡ Output sentences that do not translate all
words of the input sentence
¡ Difficulty in translating long sentences since
the encoder output (or context) needs to
encode the whole sentence
§ Information from start of sentence may be lost


### Rare Words

- Due to computational constraints, NMT systems usually limited to top 30K-80K of most frequent words in each language
- Unknown/rare words can be translated using a dictionary or exact copy provided it is known which source word generated UNK token in target.
- Problem when sentence contains multiple rare words
- Luong et al. first use a word alignment of parallel corpora and annotate unknown words with positional information (e.g., UNK1); not common anymore
- Output from NMT can then be post-processed

### Subword Tokenization

- Modern approach
- Word vocabulary is huge and sparse; problematic, rare words
- Character vocabulary is small and dense, but lacking in semantic meaning; computation good, but chars don't contain semantic meaning.
- Subword tokenization provides a compromise between the wwo
- Frequent words tend to be a token 
- whereas rare words will be broken down into subwords based on character n-grams
- Shared vocabulary for source and target languages – makes it easy to copy tokens like names from source to target; lookup table (?)
- Common algorithms include: BytePiece Encoding (BPE);Wordpiece algorithm (next week); Unigram / SentencePiece algorithm. 

### Long Sentences

Attention (more on this next week) provides a way for the decoder to get information from all of the hidden states of the encoder rather than just the last hidden state. 

The final encoder vector is a bottleneck (by design) but this causes issues

Add attention to RNN. decoder get states from all encoder parts, not just the end. 

### Attention

A sketched of the encoder-decoder network with attention, focusing on the computation of c_i (output vector of the encoder). The context value c_i i sone of the inputs to the computation of h^d_i (element of the deocder).  It is computeted by taking the weighted sum of all the encoder hidden states, each weighted by their dot product with the prior decoder hidden state h^d_i-1

i.e. all previous encoder into c_1, including all of the decoder i-1 previous points

the decoder i-1 mix  (through dot product) with each of the encoder atention weights a_ij, which then go into c_i vector which is passed from encoder to decoder

i.e. wrapping in all information, not relying in the bottle next nector which can loose context (old)

$$\sum a_ij h_^_j = c_i$$

[INSERT DIAGRAM]

int is that at the end the attenion should highlight and keep in frame the most important words

### Google NMT (2016-2020)

Recurrent networks are LSTMs with attention (8 layers - residual connections between layers to encourage gradient flow)

For parallelism, the **attention** from the decoder network connect to top layer of encoder network

Low-precision arithmetic for inference, accelerated using special hardware (Google’s TPU); hardware tricks

Rare words dealt with using **sub-word units** (balancing flexibility of single characters with efficiency of full words)

Beam search techniques includes a length normalization procedure and a coverage penalty to encourage model to translate all of the input.

### Transformers and LLMs in MT

* Transformers generally have higher
performance than LSTMS and GRUs
* Generally replacing seq2seq architectures
* More on this in weeks 7-10; no focus this week, just a bit of info. 

---

<br>
<br>
<br>

## Week 6: Seminar

## Machine Translation Questions

#### 1. What makes Machine Translation a hard problem?
#### 2. What aspect of MT can be evaluated by monolingual raters and what aspect requires bilingual raters?
#### 3. What do BLEU and chrF have in common? How are they different?
#### 4. What are some of the key components / choices in setting up a statistical MT system?
#### 5. Why should neural MT work better?


---

## Week 6: Lab Content

I won't be publishing solutions this week as this lab forms the basis of the assignment.  Please do talk to the TAs in the lab if you have any questions about what to do or what you have done.

## Week 6: Additional Reading

* [Jurafsky and Martin (2026), Chapter 12 Machine Translation](https://web.stanford.edu/~jurafsky/slp3/12.pdf) **READ THIS CHAPTER**
* [Examining Large Pre-Trained Language Models for Machine Translation: What You Don't Know About It](https://arxiv.org/abs/2209.07417)
* [Improving Transformer based Neural Machine Translation with Source-side Morpho-linguistic Features](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=9355969&tag=1)

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