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
3. [Week 3 - Neural Networks and Neural Language Modelling]()
4. [Week 4 - Word Embeddings]()
5. [Week 5 - ]()
6. [Week 6 - ]()
7. [Week 7 - ]()
8. [Week 8 - ]()
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
2. [Lab](#week-1---lab)
3. [Seminar](#week-1---lecture)
4. [Additional Readings](#week-1---additional-readings)

## Week 1 - Lecture 

| [Slides](/Users/lukebirkett/Repos/study-planner/968G5_Advanced_Natural_Language_Processing/files/week_1/week_1_lecture_lexical_distributional_semantics.pdf) | [Lecture Video Part 1](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=c7d2751c-0820-4e87-8b8d-acb400db8436&start=1.23467) | [Lecture Video Part 2](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=15631590-2d19-4dcd-98bf-acb400db95f6&start=0) |



## Week 0 - Lab

The lab exercises are based on the previous weeks lecture and seminar content.  Week 1 fell before any seminar hence there was a self-assement exercise to get warmed out. However, for the following lab session there was also a full notebook for the content.

* [Self-Assessment Brief](files/week_1/lab/week_0_refresher/how_good_is_your_python.pdf)
* [Self-Assessment Notebook](files/week_1/lab/week_0_refresher/week_0_lab.ipynb)
* [Week 1 Notebook - Semantic Similarity](files/week_1/lab/week_1_semantic_similarity/week_1_semantic_similarity.ipynb)

### Week 1 - Seminatic Similarity Lab

1. [Getting Started](#getting-started)
    * `ic-brown` explained
2. [Useful WordNet Functions](#using-wordnet-wn-functions)
    * Write a function to return the path similarity of two nouns
    * Generalise the function to use IC measures

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

### Week 1 - Seminar Reading

The paper to read for this seminar is [Information Content Measures of Semantic Similarity Perform Better Without Sense Tagged Text (2010) by Ted Pedersen](files/week_1/week_1_seminar_paper.pdf). Here is a [link](https://notebooklm.google.com/notebook/b58e8c39-3a30-40a0-86c5-1c6db77ef489) to the NotebookLM which I created to help study this paper. 

As humans we can read a piece of text, understand and assign meaning to it. Given this, we can also determine how similar words and thier meanings are, this is known as **semantic similarity**. This research paper investigates different methods of calculating semantic similarity and how they compare to human intuition - which human intuition being the gold standard metric we want to work towards. 

The author demonstrates that Information Content measures perform significantly better when they are derived from large amounts of unannotated text rather than smaller, manually sense-tagged corpora. This because the raw data is larger in size and therefore has a wider coverage of concepts within the WordNet hierarchy. This allows the system to more accurately quantify how specific for general a term is. The studies findings suggest that the expensive and labor intensive process of hand-labelling data is unnecessary for improving linguistic algorithms. 

The conclusions is that enabling a system with a greater volume of (untagged) data is the primary driver of success in these computational models because it allows more senses/words to be counted leading to a more informed outcomes. The belief prior to this paper was that high-quality semantic analysis requires costly, human-tagged data - this is known as the "expensive assumption" in natural language processing. 

By comparing various information content (IC) measures, the text explains how raw, untagged text—and even a simple "add-one" baseline using no external text at all—can outperform small, manually annotated corpora like SemCor. The core insight is that coverage is king. Humanly tagged data is sparse by definition as is it is costly in both time and resources. 

Ultimately, the reason coverage is so important is due to the structure that the IC measures sit on top of, WordNet. This is itself the true source of semantic signal. The key to unlocking its full potential is to light up as much of the network as possible. This is better acheived by a larger corpora, hence, untagged data tends to prevail over tagged data as it is generally larger. 

WordNet is not just a dictionary but a graph with a distinct mathematical structure. It is a hierachcal family tree for words. It's organized into synsets, whereby a synsets is just a set of synonyms that represent a single distinct concept.

The most rudimentary way to determine similarity using WordNet is to look at distance between two terms wthin the trees. Here, you start at a word, traverse the tree to the first common ancestor and then follow the tree down to the other term. You are counting the nodes/edges passed. This measure is known as "Path Length". 

However, WordNet is not uniform in its branch distribution. Some topics and senses are much more densely populated with terms and others form a nested structured of sub-senses. Merely counting edges means we implement an assumption that all edges are created equal and worth a value of 1. This is false, for example, some areas such as biology have a rich, mutli-layered lexicon. The distances between "tennis player" and "athlete" may just be 1 step, which is fine as they are semanticly similar. But as we traverse the tree to more general terms, entries with a distance of 1 become way more abstract and their simiarlities diverage. At the very top of the tree the distance between "entity" and "object" is also 1 step, but semantically, the difference between entity and object is a massive philosophical leap.  

Counting methods don't account for cluster density, we need a way to weight the nodes and edges. We need to know that object is a generic word that doesn't tell us much and tennis player is a specific word that carries alot of meaning. This is the reason for the Information Content (IC) metric. Instead of measuring distance by steps, we measure the **specificity** of the node itself. Information Content is a measure of specificity. Specifically, it is defined as the inverse of the probability of encountering an instance of a concept in a large corpus. 

$$IC(c) = -\log P(c)$$

<small> *Where $P(c)$ is the probability of concept $c$ appearing in the text. As $P(c)$ approaches 1 (like the word "object"), the $IC$ approaches 0.* </small>

In a hierarchical taxonomy like WordNet, 'object' has a high probability because it subsumes almost everything, resulting in low IC. Conversely, 'tennis player' is a rare occurrence with a low probability, yielding high IC. By quantifying semantic weight this way, we can calculate similarity based on how much information two concepts share—specifically the IC of their Most Informative Common Ancestor (MICA)—ensuring that a match between two niche terms counts for more than a match between two generic ones."

As a refresher for logarithms; they don't necessarily turn every large number into a small one and vice-versa; rather, it maps a vast range of numbers onto a much smaller, more manageable scale. In the context of Information Content, it specifically handles the relationship between probability and surprise. In the formula $IC(c) = -\log P(c)$, the log function performs two specific "magic tricks" for NLP:
* The Scale Squish: Probabilities are always between $0$ and $1$. If a word is extremely rare (e.g., $0.0000001$), the log turns that tiny decimal into a clean, workable number.
* The Inverse Flip: Because we use the negative log, it ensures that as probability ($P$) goes down, Information Content ($IC$) goes up.

If we just used $1/P(c)$, the numbers would explode too fast. If "Object" has a probability of $0.1$ and "Tennis Player" has $0.000001$, the raw inverse would be $10$ vs $1,000,000$. That makes "Tennis Player" seem $100,000$ times more important, which is usually too much weight.

| Probability P(c) | Example / Context | −log10​(P) (IC) | −log2​(P) (Bits) |
| :---- | :---- | :---- | :---- |
| 1.0 (100%) | "The word ""the"" or ""entity""" | 0 | 0 |
| 0.5 (50%) | A very common verb  | 0.30 | 1.00 |
| 0.1 (10%) | "A generic category (e.g., ""Animal"")" | 1.00 | 3.32 |
| 0.01 (1%) | "A specific noun (e.g., ""Dog"")" | 2.00 | 6.64 |
| 0.001 (0.1%) | "A technical term (e.g., ""Poodle"")" | 3.00 | 9.96 |
| 0.0001 | A very specific jargon word | 4.00 | 13.28 |
| 0.000001 | "A ""hapax legomenon"" (appears once)" | 6.00 | 19.93 |

If we take "Pitchfork" as an example which a rare word. The negative log creates a large number meaning it has high information content. It is very specific and when we hear it we know exactly what we are talking about, there is little ambiguity. 

To calcuate IC we need probabilites and probabilities are derived from frequency counts. To get our IC scored for each word (node) we need to count how often it occurs in a big body of text, a corpus. However, there is a big catch, and that is given our hierachical structure, a "count" doesn't just apply to the word, it applies to all parent entries above leading to it. This is **frequency propagation** or the hierarchy rule. 

In WordNet you can't view a concept in isolation. If you see the word pitchfork in a text, you increment the counter for pitchfork, but logically a pitchfork is a tool. So you must also increment the counter for tool. And a tool is an artifact. So artifact gets a point and an artifact is an object. So object gets a point too. So every time you see a specific leaf node, a ripple goes all the way up the tree to the root. Every occurrence of a specific concept implies the existence of the general category. This ensures that the math works. It guarantees the general concepts always have higher counts and therefore higher probability than the specific concepts under them. Since IC is based on the negative log of that probability. This guarantees that general concepts have lower information content scores than their specific children. If you didn't do this, you might end up with pitchfork having a higher probability than object, which just breaks the logical structure of the world. 

Now that we have the metric and its implementation sorted, the research paper evaluates three specific measures. Resnik, Lin, and GM. and Conrath (JCN). These are the seminal papers for semantic similarity. They all use Information Content, but they apply it differently. Also, they all reply on a central concept called Least Common Subsumer (LCS). This is just the most specific ancestor that two concept share. Car and Van share a lot of ancestors. Objects, artifacts, conveyances. But the most specific one they share is vehicle. It is the most specific because it is lowest down in the tree where their branches meet. Their LCS is vehicle. 

Resnik is generally the first measure explained, this is because it is the most rudimentary. The Resnik similarity score for two words is simply the information content of their LCS. The semantic similarity score of car and van is just the IC score of vehicle. In this paper, Peterson calls it "coarse". This is demonstrated through comparing Bicycle and Truck, these also have the same LCS of vehicle but we as humans would say their similarity is vastly different to the similarity of Car and Van. Resnik ignores how far truck or bicycle are from vehicle, there is no concept of distance, it only cares about the root anchor point. However, due to its simplicity there is an upside in that it is very robust. A dataset only need to have an entry for the anchor point, which as a more general term, will rarely come out as zero. Remember zeroes and sparseness are the enemy of NLP. Even if both terms being compared as absent from a corpus, if their anchor is found with as least a 1 count then there is an IC score. Resnik does not break or fail easily (though it still can). Resnik is the reliable blunt instrument. It might not distinguish fine details but it almost always works.

$$IC_{Resnik}(LCS_{c_1}^{c_2}) = -\log P(LCS_{c_1}^{c_2})$$

Lin’s Semantic Similarity Measure, which was proposed by Dekang Lin in 1998, is widely considered one of the most elegant improvements on the Information Content (IC) idea because it doesn't just look at what words share, it looks at that shared info in the context of the words themselves. In short: Lin’s measure is a **normalized version** of similarity. Lin argued that similarity should be measured by the **ratio** between the amount of information shared by two concepts and the total amount of information contained in the concepts themselves. To calculate the Lin score for two words ($c_1$ and $c_2$), you need two things:
* MICA (Most Informative Common Ancestor): The "lowest" common parent in the hierarchy that both words share.
* Individual IC: The specificity of each word. 

$$Sim_{Lin}(c_1, c_2) = \frac{2 \times IC(MICA)}{IC(c_1) + IC(c_2)}$$

The structure of this formula is that of a harmonic mean. A harmonic mean is the reciprocal of the arithmetic (simple) mean. A simple mean sums all values/counts on the denominator, meaning all values are treated equally. This is best used when the values are independent, i.e. heights in a population. But the result means that large, or small, values can skew the outcome. 

On the other hand, the harmonic mean is the reciprocal of the arithmetic mean of the reciprocals. It is designed to penalise extreme values. It is best used where the balance of the score is required and we don't want 1 value dominating the outcome, i.e. f1-score where we want to balance the trade of between precision and specificity. If you have values of 100 and 1, the harmonic mean is roughly 1.98. It stays close to the lowest value rather than meeting in the middle.

$$A = \frac{1}{n} \sum_{i=1}^{n} x_i,H = \frac{n}{\sum_{i=1}^{n} \frac{1}{x_i}}$$

With Lin, this is the harmonic mean of the "ratio of shared information." If you compared a very specific concept (High IC) to a very general one (Low IC), a standard average would make them look moderately similar. The Harmonic Mean structure ensures that if the shared information ($MICA$) is small compared to either concept, the similarity score drops significantly. The more the numbers diverge, the further the Harmonic Mean falls below the Arithmetic Mean. The structure of WordNet means that higher and lower words in the tree diverage in IC score and therefore similarity. 

The reason that we double the MICA score, is because it is derived from both IC values used in the denominators, therefore, to keep the boundary between $0$ and $1$ need to account for the MICA score pulled from both inputs. Without this the normalize around result in bounds betwen $0$ and $0.5$. Take for example a Lin IC where e calc the similarity for an entry against itself. If we didn't double the numerator then the outcome would be $\frac{1}{2}$ when it should be $1$.

$$\frac{IC(c_1)}{IC(c_1) + IC(c_1)} = \frac{1}{2}$$

With the Lin IC score, the harmonic mean of two entries common ancestors IC against their cumulative IC, $0$ means no relationship. Here, the common ancestor would be the root of the tree itself, which as an IC score of $0$. A score of $1$ means they are identitical. 

Recall, that we are using a harmonic mean because we want to find the ratio of the shared information: *"How much of our combined total is shared?"*. If we wanted to construct an artithmetic mean, we average of the individual ratios, treating them as independent things. It asks: "On average, how much of each concept is represented by the shared node?": $\frac{S}{A} + \frac{S}{B}$

Compare to Resnik, which only cares about the ancestor, Lin cares too about the ancestor but also the childen. Infact, the ancestor is "compared" to the children. 

If the terms are more specific, they will have a higher IC as they are lower down in WordNet. Therefore, producing a higher denominator which will scale the Lin IC score to be lower than compared to the Resnik IC Score. 

Let's taken an example of where the two sets of entries that are derived from the same parent "Vehicle" and come from a simlarly located sense. We have `Car vs Van` and `Unicycle vs 3 wheeled truck`. Car and Van are quite common terms, will have a high count, therefore a higher probability and lower IC score. Where as Unicycle and 3-wheeled truck are less common and will have a higher IC score. Even if the ancestor for both pairs is the same, `Car vs Van` will be more similar as they are being scaled against a lower denominator. `Unicycle vs 3 wheeled truck` have too much unique "specialness" to be considered similar, or the same. 

Additionally, the Lin score is designed to dicriminate against assymetry in a more verbose way. If we compare a more general term which is higher up the tree with a lower IC score with a specific term which is lower down the tree with a higher IC score then the harmonic mean will recognise the MICA score as an extreme value. It is an extreme value because it will be much closer to the more general IC entry on the denominator. The result will be a Lin score which is very low, closer to 0, meaning it is not similar. The Lin Measure, requires the similarity of both terms to be a similar level of informativeness. If one term knows too much detail then the formula, the harmonic mean, treats the extra information as a dissimilatity between the two terms.  

Lin looks at how much of the children's specificity is captured by that parent. The Lin score is able to discriminate against the information gap. If the parent (MICA) captures nearly all the information of the children, the score approaches 1, regardless of how large the IC numbers are.

Lin is high precision and is able differenate among an array of relatioships, i.e. within the same/similar sense, or between different grainularity of senses. However, is is as the mercy of sparsness. If either word, or both, is missing the calculation fails. This is a particular consideration if your dataset is smaller and/or you are looking at rare words. Recall, ResNik only needed the MICA score, Lin needs all 3 to be present. 

The final measure covered in the paper is Jiang & Conrath (JCN), often considered the "hybrid" child of the semantic similarity family. Lin and Resnik focus on how much two things have in common, JCN focuses on the distance (the difference) between them. JCN is actually a distance measure that gets converted into similarity. It calculates semantic distance first, which is then inverted to find similarity. JCN measures the "gap" in information between two concepts. If you start at a common ancestor (like "Vehicle") and move down to a specific child ("Scooter"), you are adding a certain amount of information. JCN simply sums up these added pieces of information from both sides.

First it calculates the distance, which is actually just **(Total specificity of both words) minus (The specificity they share)**:

$$D_{jcn}(c_1, c_2) = IC(c_1) + IC(c_2) - 2 \times IC(MICA)$$
 
Then turns distances into similarity. JCN is naturally a distance metric (where 0 means they are identical), NLP libraries like NLTK often invert it to give you a similarity score: 

$$Sim_{jcn}(c_1, c_2) = \frac{1}{D_{jcn}(c_1, c_2)}$$

JCN is measuring the unique information that separates them. In many benchmarks, JCN correlates more closely with human judgment than Lin or Resnik. JCN is very sensitive to where the nodes are in the tree. Two generic words far up the tree will have a different "distance" than two very specific words, even if the "step count" in the tree is the same. Instead of assuming every link in a hierarchy is equal, JCN uses the Information Content to "weight" the edges. A link between two very common words is "short," while a link between two very rare, specific words is "long". However, like Lin, it relies on the individual concept counts. So it's also pretty sensitive to sparse data.

We have 3 measures of quality: Resnik ("The Anchor"), Lynn ("The Ratio"), and JCN ("The Distance"). All of them need information content, which needs probability, which needs frequencies. 

This is point where Petersons Paper essentially begins and attacks the "expensive assumption" that expensive, human tagged data is required. 

The central dilemma faced is how to we count? Words are ambigious and often have several senses. If we see the word bank, do we count the sense of financial bank or river bank? The "expensive assumption" is derived from the solution that to solve this you use a sense tagged corpus. The example used the paper is SemCor, a manually sense–tagged subset of the Brown Corpus. Made up of approximately 676,000 words, of which 226,000 are sense–tagged. When you are calculating information content using simcore, it is precise. You only increment the concept that was actually met.

The issue is that within the world of text, SemCor is a tiny dataset. Morern text applications have billions and trillions of tokens so 200,000 is a rounding error. 

The next optionl, which Peterson is pushing, is to use untagged, raw text. The paper used something called the English GigaWord which contains more than 1.7 billion words of newspaper text from the 1990’s and early 21st century, divided among four different sources: Agence France Press English Service (afe), Associated Press Worldstream English Service (apw), The New York Times Newswire Service (nyt), and The Xinhua News Agency English Service (xie).

The question is how to count if you don't know the sense? Peterson says to use a distributional strategy where you divde the count among known senses. If "tree" comes up then the plant sense, the power sense and diagram sense all get a 0.3 count. Naturally, this means that we are adding noise to the totals. We are appending counts for things that were not observed. However, the key thing to remember is that we are working with a hierarchical structure. When we increment the distrubitonal leaf nodes, we are also incrementing the parent nodes. 

In a massive corpus, like the GigaWord, the true **senses** that are actually being used will appear more often and in different contexts, so the noise, that is the correct incremeneted senses through distribution, will be thinly spread accross many incorrect sense, the but true signal will emerge through volume. The noise gets drowned out. Peterson is betting that the law of large numbers will overpower the noise of incorrect assignment. 

Finally, Peterson introduces 1 more approach here. So far we have option A which is the sense tagged data. Option B is the large untagged data. And now there is Option C, which is going to be the dictionary approach which is treated as the "baseline". Here we use all the words from the dictionary and therefore append them with a count of 1. Essentially, we don't use any external text, just all words/senses in WordNet get a +1 (as will are the hierarchical propagtion counts). You're creating an information content structure based purely on the topology of word net itself. 

It may seem like it shouldn't work. That's just measuring the shape of the graph. It's saying the probability of a concept is determined solely by how many types of subconcepts it has. But Petersons results show that it does. 

To do this, the paper compares the outcomes to human intuitions. In order to do this we need datasets These include the (RG) (Ruben- stein and Goodenough, 1965) collection of 65 noun pairs, the (MC) (Miller and Charles, 1991) collec- tion of 30 noun pairs (a subset of RG), and the (WS) WordSimilarity-353 collection of 353 pairs (Finkel- stein et al., 2002). RG and MC have been scored for similarity, while WS is scored for **relatedness**, which is a more general and less well–defined notion than similarity. 

It should be noted, that IC measures are designed for Similarity. They are derived from heirachical structures and wish to determine how close, similar, two entries are. Theoretically, they should struggle with relatedness and the WS dataset. 

So to recap we have 3 measures ResNick, Lin, JCN. We have SemCore as the tagged corpus and GigaWord as the tagged one. Then we have 3 dataset for judging; RG, MC and WS. 

First comparison: tagged SemCore vs untagged SemCore. This is the same dataset but applied in a different way. Tagged we use the human selected senses, where as untagged we use the split strategy counts. The results show that the untagged performed better on average, the paper calls it SemCoreRAW. It is on average because there are 3 measures and 3 datasets therefore the results vary. Using ResNik on the RG dataset, the untagged acheived a correlation with human intuition of $8.2$, this is compared to the tagged score of $7.2$. Even though by using the untagged data with are removing valuable information, i.e. the labels, we are gaining significantly in coverage. The tagged data is precise but very sparse, it only covers about 24% of the senses in WordNet. This is means 74% of the sense in WordNet had a count of 0, which means 0 probability and therefore an `inf` Information Score, or for Lin and JCN an undefined value because it needs entries for both concepts in the equation. The untagged on the other hand, whilst it introduces a lot of noise and random allocations through the split strategy, it also marks many senses that otherwise would result in a 0 count. The coverage count in untagged dataset wasy 37% compared to 24%. Even through the output is noisey, the fact that there are less 0 counts allows the maths to work better. Peterson suggests that coverage is more important than accuracy. 

Next the paper focuses on the GigaWord dataset. The inputs are incremented and scaled, giving the system more data, starting with a month and increasing. The paper shows that as the coverage increases, so does the correlation with human intution. Additionally, as the volume of data fed in increases, so does the coverage. The results do seem to plataue with data size eventually but this is very high and results with a ResNik score correlating with human intuition at 0.85 on the RG dataset. This is extremely high and close to human level of agreement. 

In terms of the Information Score measures on the WS dataset, they performed OK. With correlations around 0.4 to 0.5. But vector based measures performed a lot better. Vector measures like WordVec use context windows, this means they can see which words occur in the same sentences or near each other in text. For example, headache and paracetomol are not synonymous, but they are related and still occur near one another. Vectors are able to learn from association. Association and relatedness wil often be used to decribe this notion, where as similarity it pertaining to words that mean the same thing to whatever degree. 

If a project requires finding synonyms then use IC and WordNet. If the goal is associations/relatedness, then use vector based methods. 

The final focus of the paper is the `Add1Only` method. This just relying on a repository of words, i.e. a dictionary, rather than any corpus of text. This also acheived a Resnik of 0.85 on the RG dataset, the same as the gigaword. This once against reinforces the point that the main mover in performance is coverage.

However, it also highlights another key point, which is WordNet itself. Its structure, the way humans designed it, the heirarchy, its depth. These are the things that contain the main bulk of semantic signal. The knowledge is in the tree, not just the text. 

In fact, the counts from external text could just be seen a fine-tuning whereby weight is added to what the corpus determines the correct applications to be. If the external text is specialised, lets say Financial in topic, then the word Bank with the sense of financial institution would hold more weight compared to river bank, and in particlar with respects to itself lineages counts through its chain of hyponyms. 

The final theme that Peterson is trying push is that for Information Content measure, which are inexplicity linked to WordNet, sense-tagged data is not only not required but it is determintal because its coverage is not enough. 

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


# Week 2 - Language Modelling with n-grams

This week we will be looking at n-gram language models.  In particular, we will be looking at:
* why build language models?
* how to evaluate language models?
* perplexity
* generation
* generalisation and smoothing

#### Week 2: Contents

1. [Lecture](#week-2---lecture)
2. [Seminar](#week-2---seminar)
3. [Lab](#week-2---lab)
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

# Week 2 - Lab 

# Week 2 - Addtional Readings

* Jurafsky and Martin Chapter 3 [N-gram Language Models]

---

<br>
<br>
<br>
<br>
<br>


# [Week 3 - Neural Language Models]()

* Feed Forward Networks
* Recurrent (RNN)
* Long-Short Term Memory (LSTM)
* Convolutional (CNN)
* Word-based vs Character Based

#### Week N: Contents

1. [Lecture]()
2. [Seminar]()
3. [Lab]()
4. [Additional Readings]()

## Week 3: Lecture

3 parts

* [Part 1](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=d1dda4d7-c0c6-4018-b756-b3e500fb35fb)
* [Part 2](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=9cae7217-e9c9-4e3f-894b-b3e800b7d5cc&start=0)
* [Part 3](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=06ed8e74-ae66-4085-8d4d-b3e800be5350&start=0)


[lecture 1]

archicture looked as high level, details more relevent for other modules

[neural eunit]

y is the output as is each to the activation the unit

z is weighted sum of inputs 

$z - w.x + b$

the vector vector shares the same dimensions as the input vector, which may be 3 i.e. for an rgb image

weights of sum of weight/input vecots

summed value goes into an activation function

ADD IMAGE OF NEURON

[activation function]

introducing non-linearity into the network

without wouldn't be able to stack layer to make networks as they would just simpifly to anothe rlinear function that could have more easily been acheived. 

sigmoid, tahn, relu [GET THE FORMMULAS AND A QUICK SUMMARY]

[feedforward network]

dont just deail with single unit, instead networkds

most simple network is a feedforward networkd with layers

input layers, hidden layers, output layers

each layer has a number of units, i..e nodes

units can vary, no fixed or expected ot numbers

outputs of one layers and the inputs to the next

layers in an ff have no info of eachother, just take and pass, No cycles

fully connencted if each unit takes an inputs from every unit in the previous layer

units are taking the weighted sum of the inputs and applying an activation function $h = o(Wx+b)$

each unit learns a different pattern form the inptus and passes this one

[ADD IMAGE OF FF NET]

output layer tends to use softmax as the act func. against has the weights and units. softmax takes the value at that unit and normalised it against all over units in the output layer. This allows the cumullative sum of the outputs to = 1, wherbey each unit is a %. this allows for probablistic outputs 

$$\sigma(\mathbf{z})_i = \frac{e^{z_i}}{\sum_{j=1}^{K} e^{z_j}}$$

ff is how a network runs once how it has been trained. 

but where to do these weights come from? trianiing

[trinaing neural networds]

hard classification task = only once answer per instance/task

i.e. softmax to select most probable class 

in order to train we need a loss function. this tells us how good the network is 

cross ent or neg log-like loss (simply log prob)

input is the hot one encoded vector from the softmax. inportant as it selected the value to sum, i.e. just one equation

INPUT THE LOSS FORMULA

we want to find the parameters than minimize the loss function

[gradient descent]

randomly init parameters (weights, w)

use ff to compute predictions 

compute the loss function (J), might be done over a batch

computer partital derivs of loss functions with respect to parameters, this tells us how much to adject them by. we want to find the global mimum

back propage, i..e update the parameters

$$W = W - \alpha \frac{dJ}{dW}$$

this is how we update the parameters with the derividate. a is our leanring rate, it is the size of the updates we make

repeat unitil converages and the loss is acceptabel small

[feedword - neural language model]

first proposed by bengio et al 2003

input was some number of previous words representation

window could be any size but they started with 3

wt-3, wt-2, wt-1

predict the next work in seq given the previous 3 words. 

each words need to have a numerical embedding in terms of the whole vocab. could just be a number but modern approaches are vectors.

output is a prob dist over all the possible words

input is the rep of previous words

$$P(w_t = V_{42} | w_{t-3}, w_{t-2}, w_{t-1})$$

42 is the size of the output vector

INSERT IMAGE

[adv vs dis]

ad: generalise over context of similar words (due to embeds), doesnt need smooth, candle longer histories

why no smooth? not predicting based on the words. the words are combined in the weighted hidden layer to create a single unit several times. move into hypth space, should be similarites

dis: very slow to train, atlest compared to n-gram. stil based on markov assumps, prob of word given entire context is approximateed based on n previous. still have fixed window idea

[where dfo embedds come from]

future topic in module. 

could see embedding layers as another hidden layer. 

could be a one hotting layer based on full vocab

could init as a one hot but then learn the true vector embeddings as part of the backprop process. projectection layer

In the context of the language models and neural networks we've been discussing, a projection layer is essentially a specialized fully connected (dense) layer used to change the dimensionality of data—effectively "projecting" it from one vector space to another. In neural language models, this layer is crucial for moving between the vocabulary space and the hidden state space. When you feed a word into a neural network, you start with a "one-hot" vector (a massive vector of zeros with a single 1). The projection layer acts as a lookup table that projects that "one-hot" index into a dense word embedding.


could use pre-trained embeddings that have been learned somewhere else and frozen for inputs into the model (or allow them to be fine tuned)





# Lecture 2 -  RNNs

Prev lecture about ff model as a language model. tries to output a probability distribution over possible next words from an input which is a representation of some number of previous words. 

# Simple Recurrent Network

Hidden layer $h_t$ is based on current instances input but also the recurrent loop whereby the hidden layer takes itself from the previous timestep as an input ht-1

[insert first simeple rrecurrent net image]

[insert alt way to visualise]

# RNN

ADV:

hidden layer from previous timestep provides context and momemry 

now there is no fixed length on amount of pior context. we are not governed by inputting a fixed window, we can put a much longer window, we can also vary our window length

the weights of U determine how the network should use the past hidden context in calcualting the output for the current input


DISAD:

long windows are theoretical, in practice the context held in the hidden tends you become fairly local

difficult to cpature long range semantic depds

to work well hiddel layer need to incorporate long and short range deps

 # Recurrent Neural Network Language Model (Mikolov et al 2013)

 input and output have dims of the vocab

 starts as one hot vector

 output is prob dist over words

 word reps are therefore sound in the matrix U through learning

 this is the distributed rep

 hidden layer is a representation of everything that has happened in previous timesteps (theoretically)

 trainedf same as NN with back prop to max data log-likilihood

 [insert diagram]

 # Computation of hidden and output layers 

INSERT ALL FORMULAS FOR THIS MDOEL 

word embed + resp of pre

output prob dist

softmax

# LSTMs

long short-term memory networks

# Unrolling a simple RNN

visualise each time step as a block [INSERT IMAGE]

includes where activation takes place (tahn)

# Unrolling an LSTM

core idea: hidden layer are going to depend on 3 things:
* current time step inputs
* activation values from the hidden layer at the previous time stamp (short term mem)
* activation values from the **cell state** (long term memory)

cell state thing flow that runs along the top

# gates inside neural units

inside the units we have gates which control info flow

it will allow some info through but other info wont

each gate compoised of a activation function and pointwise mutliplicaiton

the sigmoid is controlling how much info goes though the gate to the pointwise mutli

which dimensions should be allowed to go through

given sigmoud shape, values will often be close to 0 or 1, effectly opening or shutting out info 

# forget gate

first gate

input: current inout $x_t$ and current (prev) hidden state  $h_t-1$

given these two values, which go into an sigmoid activation. they decide how much of the current state is allowed to continue on down its path. 

# input gate

second gate

input: current input $x_t$ and current (prev) hidden state  $h_t-1$ (a concatenation of the two vectore)

what of these inputs needs to be remember, i.e. put into long term memory

controled by a sigmoid again $i_t$ bit is only the source of info going inot the pointwise but instead using a tahn action $C_t$. The pointwise then feeds into the long term memory $C_t$

The pointwise mutliplicate, which is the sigmoid outpu ton the info output, is then ADDED into the control flow (not multiplied)

# output 

this is the 3rd gate

what should the output be

how much of the hidden layer are we going to retain

again a sigmoid of input and current hidden 

a pointwise mutli with a tahn applied to the cell state

output determined the new hidden layer state $h_t$

used to detmeine current output, i.e. a new work

but also remebered as the new hdiden layer, i.e. the short term memeory which will be passed onto the next cell block

# stacked rnns

output (at each time step) from RNN block is fed as an input into annother RNN

stacking leds to deep network (deep learning)

different layers tends to capture diff levels of abstraction 

lower shorter term, higher (deeper) longer term 

# bidirectional rnn

take advantage of right context as well as left context

have two rrns 

one trained left to right 

another trained right to left

trained seperately as the inputs are different

but then you concatent (add) the hidden layers to produce the output at each time step 








# PART 3: Characters and Convolutions

thinking about now: what should out actual input represenation be

Problem for word-based Natural lang models: sparisty

n-gram, victim of sparsity, Neural as a solution to this, shifts focus to context and embeddings

nlm, ff, neural, overcome to certain extend as generalise using similar words. 

doesnt matter if we havent seen exact word or sentence before

we are not making prediction absed on based words or phases 

but we have weigths which act on the inputs which then comobine together in many different ways to create the ouput

howeve,r this relies on embedding being reliable 

embeds are trained within the network

if the network sees a word a lot it will make a lot more reliable embeddding that cpatures it similarities to words better

less good if it only sees it once or twice. may not move much from init value

embeds for low frew, or 0 freq, are going to be unreliable potnetially

could have an unk token vector which created an unknown vector embed

could nn are expensive we tend to restist the vocab anyway, so this is a good approach 

what else can we do instead of an unk token, i.e. we don't know enough about it?

# character based nlp 

move anyway fro musing a word to using the caracters (leters)

straight away sparsity problems will go away because the possible values are constrained to the alphabet

ideaa
is to form represents and make predictions about the language and what char should come next

# cnns

cnns very common in vision 

used to detect feature in an image

features can be anywhere in an image 

but presence determeined by neighbouring pixels

can also be used in text by looking at characters around

# convolution s

convo layers look at groups of inputs or neurons in accorsances to window sizes

these windows slide over text in sequences in text to identify serquential trends

kkernel function A is learn which looks for or filters for a particular patter//feature, e.g. 2 character sequence "un", 3 character seq "ing" 

the network will learn these sequences in their windows, we don't outline them first

# stacking convo layers

staicking allows decection of complex features composed from simplier features

# max pool 

as well as the actual convo layers, there are max pooling layers

takes the max of its inputs

doesnt care where a feature is in its inputs, but if the inputs produce a 1, then the max pool extracts just this (easier to exaplin this concept with images)

# kernel functions 

indiv kernel function detect an individual feature in the input

in pacted need hundred or thousands of kernal functoin s

kernal functioins are just nn weights that are learnt by training on a corpus

kernels are learnt per task

# adv of char aweare nlm

allows morphoglical info to be utilied 

this is good for low freq words as we learn the structure of a word

if ends in ing then we know the tyype of word at least for example

know parts of the word to make predictions


## Week 3: Seminar

### 1.In ML, is a loss function the same as an objective function?

As loss function is a type of objecive function. You minimise a loss function. But you could use a reward function which you wish to maximise. Often used interchangably. 

### 2.Explain how a bigram model of language could be built with a feed-forward neural network?

A network with 2 inputs, the current word and the previous. Each word one hot encoded. 


3.What is the difference between a one-hot encoding of a word and a word embedding?

4.What will a neural language model typically do with OOV words?

5.If a combination of words is seen at test time which has not  been seen before, what will happen?





1.What is an RNN and what advantage(s) does it have over a FF-NN (particularly when applied to language modelling)?
2.What is an LSTM?
3.How might 2 RNNs be used in the same network?
4.What is a CNN?
5.Why might it  be useful to have character based language models rather than word based language models?


Disscusion of Paper: Character aware neural language models (Kim et al. 2016)

1. What problem with using n-gram models is addressed by the use of neural language models? Why is it not completely addressed? How might character-aware models help?

2. Why are LSTMs generally preferred over vanilla RNNs in language modelling?

3. In a character-level CNN, what is the purpose of a filter or kernel? How many filters do they state are typically used in NLP applications? How many do the authors use in each of their small and large architectures?

4. How is the character-level CNN incorporated into the overall architecture of the RNN-LM?

5. How are OOV words handled in these experiments? What potential improvement could the authors have made and why didn’t they do it?

6. Which model(s) performs best in the optimization experiments on the Penn Treebank?

7. Why do the authors expect the performance gains to be more in other languages such as Arabic than in English? Are their expectations met in the experimental results?

8. What advantages does the authors’ model have over the MLBL model of Botha and Blunsom (2014)?

9. What observations can you make of the nearest neighbours of ‘richard’ using each of the word representations?

10. What are the main conclusions of the paper? Are you convinced?


## Week 3: Lab Content

## Week 3: Additional Reading










# [Week 4 - Lexical and Distributional Semantics 2]()

#### Week 4: Contents

1. [Lecture]()
2. [Seminar]()
3. [Lab]()
4. [Additional Readings]()

## Week 4: Lecture

* https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=353c47a5-1230-4ffa-b59c-b3ef010c79b0&start=0
* https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=75f1da88-d5ed-48f5-9451-b3ef0116d27c&start=0 

# PART 1 

return to topic of lexical and distribution semantics from week 1

lex; word sense, sem relationships, sem similarty

dist; bootstrap sems from context, cosine sim of two vectors, post wise info as measure of assoc

assoc is occured together in same context, similar is the interchangbale words

last few weeks has been lang models; n-grams, sparse, smooth methods, moive into neural networks as neext solution 

# challenges for measures of dist sim 

* mixture of sense (lec 1); neighbours of diff sense
* mixture of relationships; syson, hypo, semantically related
* sparsity (didnt look at much last time but will this time, more been topic for lang models)

# lec 4 overvew

p1; sparsity, zips law, smooth, dim red

p2; word embed (potential overcome of sparsity), word2vec, glove, composoition 


# sparsity

what do we mean about parsity?

google news corpus 320m word (tokes) with vocab of 82k (types)

what does this tell use about distribution of types?

mean freq is 3900 for each type, does this mean anything? could we look at occurance coompared to mean freq to build understanding? learn what words are similar to others?

maybe if it was normal dist with small sd

problem is very few words have 3900 occurances

this is because the distribution of wordsis def not normal dist or have a sd of 1

# zipf's law

"the product of the freq of a word and its rank is approx constant"

rank = howw often occur in corpus, i.e. 1st most freq

demonstrates there are few words tht occur alot 

but a big trail of words that occur infreq or even once (hapax legomena)

HL make up approx half of vocab; names, spelling mistakes, techniqal terms, scientific

this is sparisty in action, many rare words

# consequences of zipds law

82k dim coocurance vectors will be very sparse

if word only occurs once, then all other co-occuranes in the vocab will be 0. this is very sparse. 

we don't really know what 0 means. is it impossible or also just rare and we havent seen it

what can we do?

# possible solutions

* smoothing
* dim red
* word embed/fix dim reps (from lang models)

# smoothing intuition

int is that anytihng is possible, even unobserned events

when we have sparse statics, "steal" prob mass from observed inorder to generalise to unobs events

# add one smoothing (laplace)

prentend we saw each word one more time than we did

obs + 1, 0+1, 1+1 etc

# applyinh add-1 smoothing

good method for some methids, i.e. naive bayes, as its prevents 0 prob which breaks the foruklas

but here the number zeroes isn't so huge

classes < sie of eng vocab which is what language models use for their corpus

add1 is rarely used for co-occurance data/lang models

it assungs too much mass to unseen occourences

unseen cooccurances are much more vast than the actual obs co-oc

+ is wouldn't help us wuth dist semantics sparisty problem anyway

**why is add1 unlikely to help the sparse problem of dist semantics**

address later in seminar?

# distributional smoothing

Dagan, Pereira and Lee (1994), define S(w) as the k-most similar words to w according to some distributional simiarity measure

the smoothed occurance probability of two words in then:

INSERT DIST SMOOTH FORUMLA

smoothed prob of w2 occuring given w1 has occured

find all words that in a similarity set of w1

take prob of w2 occuring aginst all of the words in the simiarity set; then sum up these probs

prob of sim words is taken as a weighted average

# smoothing example

prob of snort and aardvark

both rare words. obs cooccured freq is 0

estimate prob of based on cooccurance of snorth with neighbours of aardark

INSERT FORUMLAS

do this both way round? snort|aard and aard|snort

why are we doing it both way rounds?

# distrib msooth in practice

* build sparse rep of all words (In the context of 1994 distributional semantics, a "sparse representation" usually refers to a co-occurrence vector, not a one-hot vector.)

> A vector where only one dimension is $1$ and all others are $0$. This represents an identity, but it contains no semantic information. You cannot find "neighbors" for a one-hot vector because every word is mathematically equidistant from every other word.

> A vector where the dimensions represent context words. For example, the vector for "dog" might have a $5$ in the "bark" column and a $10$ in the "pet" column. It is "sparse" because out of a 50,000-word vocabulary, "dog" only co-occurs with a few hundred words.

> If you use Kullback-Leibler (KL) divergence or Cosine Similarity on these sparse co-occurrence vectors, you can find neighbors. For example:

> Word A (Cat): {meow: 10, food: 5, sleep: 20}
> Word B (Dog): {bark: 8, food: 7, sleep: 15}

> Even if "Cat" never appears with "bark" and "Dog" never appears with "meow," they both appear with "food" and "sleep." k-NN uses these shared dimensions to decide they are neighbors.

* auto generate thesuraus of neighbours (find k nearest neighbours of every word)

* re-estimate co-occurence probabilities of every pair of words using distribitional smoothing formula

* regenerate the thesaurus

# dimensionality reduction

other solution to sparsity

v popular 07-13

build cocurrance matrix, 82k dim, reduce down to managnumber number; 1000, 300, 50

could just ignore features and select the ones you want but there are more technical ways

find axis of the data where there is most variation

transform data so these are the basis of the space

3 main ways;
* PCA princ comp analysis - statistical techniwue
* SVD singular decomp SVD - matrix factorisation technique
* non-neg matrix factorisation (nnmf)

# PCA

int behind; reduce from 2 dims down to 1

2 dims could be ppmi occurance with other words

want to find natural axis of the data

could just loose a dimension and just look at x-axis but we loose alot of info

better to sort of like finding the regression line, best line of fit, the princ component

could be best fit from least squares

this looses the least information as it is built form both axis

# pca (2)

generally have alot more than 2 dimensions 

want to reduce n to k, i.e. k=300

apply pca iteratively to find all k dimensions

find all pricnc comps

subsi pc need to be orthogonal 

dont need to now math or cade, packages do this, just know int

variance in the data is not captured by the pc, byt can be computed by the loss of information 

# latent semantic analysis (lSA)

deerester et al 1990; landauer et al 1998;

rep text as matrix X where each row is a unique word and each column is a document (or other type context that word can be compared to)

the values are transformed freqs (tf-idf, ppmi)

they used tf-idf as they were using documents 

but if the other context was words then ppmi would be better

once you have matric applied SVD to decomose into a product of 3 matrics

INSERTT IMAGE OF DECOMPOSITION

$X = W.S.P$

decompose means we area breaking down the matrix into n matrices which when product togetehr become the original matrix agian

given matrices need to have given sizes to acheive the correct output

[5x3]=[5x2][2x2][2x3]

s is diagonal matrix, the demnision of which define the reduced space. will be alot smaller than orginal input

w is the reduced dim set of word vectors

p is the red dim set of doc/co-occurance vectors

w,s,p is found by using standard matrix tecniques, by fding eigen values and eigen vectors

also known as eigendecompostion


# nnmf

non-neg matric factoriz; variation on svd

svd there are a variation of matric decomps that can be derived to rebuild the orignal matrix size

nnmf have further costraint that all values in the facotrized space are allowed to be non-neg

ptentially leads to nmore interpretable spaces

NMF forces every value in the resulting matrices to be zero or greater.

In SVD, the latent dimensions (components) are allowed to have negative values. Mathematically, this is elegant because it ensures dimensions are orthogonal (independent). However, semantically, it’s a nightmare.SVD creates "Counter-Evidence": To represent a word like apple, SVD might take a "Fruit" component and then subtract a "Tropical" component.The Interpretation Issue: What does "negative tropicality" mean? In human language, we don't usually define a concept by what it isn't in a mathematical vacuum. It’s hard for a human to look at a vector of $+0.5, -0.2, +0.8$ and explain the "meaning" of that $-0.2$

NMF and the "Parts-Based" Representation
NMF functions on the Additive Property. Because you cannot have negative numbers, the only way to reconstruct the original data is by adding components together. Additive Logic: To represent apple, NMF might add a bit of the "Fruit" component, a bit of the "Crunchy" component, and a bit of the "Red" component. The Interpretation Win: This mirrors how humans categorize things. We see objects as a collection of features or parts. Sparsity: Because NMF is trying to reconstruct the data using only additions, it naturally pushes many values toward zero. This results in "cleaner" components where only a few words are highly active, making the "topic" of that dimension immediately obvious to a human reader.

Visualizing the Dimensions
Imagine you are factorizing a dataset of faces: SVD would produce "Eigenfaces"—ghostly, whole-face images that look like blurry versions of the average person. Some features are "subtracted" to reach the final face. NMF would produce recognizable parts: a dimension for "noses," a dimension for "eyes," and a dimension for "mouths." To make a face, the model simply adds those parts together.

In distributional semantics, these "parts" end up being semantic themes (e.g., a "sports" dimension, a "finance" dimension), which is why NMF is a favorite for topic modeling.

# using PCA, SVD, LSA, NNMF

adv; massively reduce dims, theo should captur sims between word in the occurances

dis; comp expensive to obtain to the vectors (vectors are the more efficent part), generally impossible to interpret/interrogate dimensions, too complex



# PART 2

previous part was about challenge the problem of sparsity

# word embeddings

start with the assumption that each word can be represent by a fixed set of dims, i.e. select the number first any number less can vocab

learn best values for each word; optimise of some performance taskl; log-liklieghood of some training corpus

optimise to be the best prob, i..e get the best vector embed

# simple nn 

use a network to learn the embeddings

can represent network as a matrix

each layer is a matrix vector mm on the weights and the inputs

# hot one encoding

inputs to the network

input space with V dims, where V is size of the vocab (huge vector, with just 1 entry in the vector, all other 0)

this esssnetially switches on a matrix column, or an input to the network

slelecting a weght from the column matrixs

this entry disperses into the matric and is passed around so the network lights up

but for entrying, only 1 neuron is entering and firing. 

embedding for word 1 (1,0)

these hot one endodes are the starting representations for our words

but we want them to be better and optimied. 

this is why we create word embeds

the orginal task was to generate the next work in a seq, but people realised that when passing in a word, a valuable respresentation was made in the hidden layers which could then be extracted and used as itis a better respresentation than the hot one

# paper: recurrent neural network langaugge model (mikolov etal NAACL 2013)

input if cyrrebt word (hot one), projected into embed space using weight vector U

RNN, so have a hidden layer state st-1 from previous, passed in using W weight vector

embed space is s(t)

output y(t) is size of vocab and is prob dist over the next word; soft max makes it prob dist

the meaning of words is contained in the weight vectors U

# word2vec mikolov et al 2013

more simple approach specifically for this task 

simpler than rrn as you dont need the recurrance

CBOW or skip-gram models instead; v similar

# word2vec intution

current word in the courpus is ref to the target

use fix length content window either side of the target e.g. +/- word either size

each word has 2 different embeddings (representation; vector, weights)
* one embed when it is a tartget word
* one embed when it is used as a context word

in cbow, context embedddings are used to predict the target. the cont embeed is the 4(2) words either side of the embedding

cbow predicts current word given context

we want the sum of the context vectors to be as close as possible to the target word embedding

skip-gram; hard int; take target embed word and try to predict the context words. optimise the weights to obtain these context words


how to train word to vec? init embeds randomly and then iterate over the text, compus loss function for each instance; compare how close the projects and the output were


The one-hot vector is the input mechanism, not the embedding itself.Imagine you want to predict the word "sat" given the context "The cat ___ on."You take the one-hot vectors for "The", "cat", "on".Multiplying a one-hot vector by the weight matrix $W$ is mathematically equivalent to selecting a specific row from that matrix.That row is the Context Embedding for that word.

Input: You take the random context embeddings of the surrounding words and average them.Prediction: You multiply this average vector by the target embedding matrix ($W'$) to get scores for every word in the vocabulary.Update: You compare the result to the actual one-hot target ("sat"). Using backpropagation, you nudge the random numbers in both matrices so that next time, the vectors for "cat" and "on" result in a higher probability for "sat."

The input is indeed a one-hot vector, but the "target" for the loss function isn't a subtraction of embeddings. Instead, it is a comparison between two probability distributions.

To calculate the loss, the model takes the "average context vector" it just created and multiplies it by the Target Embedding Matrix ($W'$). This produces a vector of raw scores (logits), one for every word in the dictionary.Step A: We apply the Softmax function to these scores. This turns them into probabilities that sum to 100%.Step B: We compare this probability distribution to the One-Hot Target Vector of the actual word that was supposed to be there. We don't subtract the embeddings. We use Cross-Entropy Loss.

Imagine the target word is "sat." The One-Hot Target: [0, 0, 1, 0, 0] (where index 2 is "sat"). The Model's Prediction: [0.1, 0.05, 0.6, 0.1, 0.15]. The loss function looks at the probability the model assigned to the correct index (0.6). The "goal" of the backpropagation is to push that 0.6 as close to 1.0 as possible.


Summary of the Flow
1. Input: One-hot vectors of context words.
2. Projection: Pull out context embeddings and average them.
3. Output: Multiply average by Target Matrix to get scores for all words.
4. Softmax: Convert scores to probabilities.
5. Loss: Compare probabilities to the One-Hot Target using Cross-Entropy.
6. Backprop: Update both the Context and Target embeddings.
iterate training

# gradient descent

* random intit para setting (W)
* comp pred
* comp cost function (J) MIN OR MAX
* comp part deriv of cost function with respect to paramers
* backprop, update params (formaila)
* repeate until conver/cost is accept small

# skip gram int

hard one to understand

what is the obj fubcntion?

is w2 likely to show up near w1?

treat the target word and context words and positive samples

randomly sample other words in lexicon to get negative samples

train class to distinguish those two cases (classes)

* rand init two sets of embeddings - each word in the vocab has a taget embedd t_w and context embed c_w
* iteratively shift target and context embedds to that:
* taget embed of word w is more like the context embed of words that occur nearby, and less like the embd of words that dont occur nearby

INSERT FORMULA

QUITE DIFFICULT TO UNDERSTAND, REVISE AND DO BETTER NOTES

# word2vec params 

has lots of other hyperparameters

number of epochs; learning rate; batch size before updates are made; window size

depends on corpus and goal

# glove (pennington et al 2014)

anotthoer approach to dim red

combined ideas of matrix factors but speed of neural techs (word2vec)

start with matricx and want to decompose

aim: find set of `m` dim focal embedds (F) and m-dim context embed (C) such that X=FC Transpose

m is alot smaller than V (start)

NEED BETTER NOTES AND UNDERSTAND ON THIS

# correlation with human judgement 

baroni (2014) wor2vec embes. better than ahains count based dist reps (ppmi, none matrix factorisation)

dont bother counting just predict cooccurences

# what is so specifical about word2vec and glove

omer and levy 2014 shows that word2vec embed are implicit factorisation of stataard occurence vectors with weights as ppmi

but there are alot more hyper parametes that are tunable. this can make it better? 

INSERRT LIST OF WHY THE HYPERPARAMS MAKE IT BETTER 1-7

# disadvants of low density reps

dimensions are un-interpretable; no way of knowing what dim reps what

non-determinism; random init, diff solution each each, new local minima, cannot find global min even if there was, cannot compare runs between corpus (silverlining; allows use to test of stat sign, if we get same neighbours if diff run then this is important)

# where next with distribution semantics... what about phrases?

sim of nurse to man?

# comosition intersective

INCLUDE FORMULA

male nurse associated with nurse and maleness 

cpatures the intitution that features of the phase must have occured with all of the constituents of the prhase

a fearture is associated with male nurse if its associated with male and nurse

commonly implemented with pointwise mutliplication of vectors

as the wordsin the phase are increaseed, this will tend towards a 0 zero vector due to sparsity. 

# coomposite addtive

INCLUDE FORMULA

more common way to think about composotion

CPATURES THE INTITUATION THAT FEATURES of the phase must have occured with one of the consts of the prhases

feature will be associated with male nurse if it associated with male or nurse

inplemented with additonal of vectors 

can re-normalise to get the constistuents

as more words are compused will tends to the centre of the semantic space

after a while every feature will start to be come hihgly rated with target feature (phrase)

# evaltion of compsition model 

very difficult to get human phrase evaluaiton. rememebr it was hard just for words

the eval is correlation with human simialrtity judgements for phrases

sementatic similarity in context tasks; application based eval;

"do these two senteneces mean the same"

# chanllegnes of comp models 

note all phrases are composoiton

word order is surely important but adding vectors ignores order

negation? how to do we same something is not this




INSSERT IMAGE


**is this possible with sparse representations? seems like something that would need to have embeddings to acheive**




## Week 4: Seminar

In distributional semantics, a composition model is a mathematical framework used to combine the meanings of individual words (represented as vectors) to form a representation for larger linguistic units, such as phrases or whole sentences. While standard distributional models are great at representing isolated words, they face a challenge: human language is infinite and hierarchical. We cannot have a pre-stored vector for every possible sentence ever spoken. Composition models solve this by allowing the system to "build" the meaning of a sentence from its parts.

# Human Synonymy Judgements

game skip

# Q1

# What do you under be prob of sparsity

* words are rare
* co-occuring words are even rarer
* dist model = co-occuring in sentence = context

# possible solutions

smoothing; dim red; embed with fixed dim (lang models)

# distributional smooth

get post estimate by looking at the cooccureances of the target word + its neighbours

requiers a good and robust way to obtain similar instances

# alternative to smoothing

















# paper direct copy notes

In this paper, we examine the vector-space word representations that are implicitly learned by the input-layer weights.

We find that these representations are surprisingly good at capturing syntactic and semantic regularities in language, and that each relationship is characterized by a relation-specific vector offset.

This allows vector-oriented reasoning based on the offsets between words. For example, the male/female relationship is automatically learned, and with the induced vector representations, “King - Man + Woman” results in a vector very close to “Queen.”

We demonstrate that the word vectors capture syntactic regularities by means of syntactic analogy questions (provided with this paper), and are able to correctly answer almost 40% of the questions.

distributed representation achieves a level of generalization that is not possible with classical n-gram language models; whereas a n-gram model works in terms of discrete units that have no inherent relationship to one another, a continuous space model works in terms of word vectors where similar words are likely to have similar vectors.

when the model parameters are adjusted
in response to a particular word or word-sequence,
the improvements will carry over to occurrences of
similar words and sequences

By training a neural network language model, one
obtains not just the model itself, but also the learned
word representations, which may be used for other,
potentially unrelated, tasks.

In this work, we find that the learned word repre-
sentations in fact capture meaningful syntactic and
semantic regularities in a very simple way.

Specif-
ically, the regularities are observed as constant vec-
tor offsets between pairs of words sharing a par-
ticular relationship.

or example, if we denote the
vector for word i as xi, and focus on the singu-
lar/plural relation, we observe that xapple−xapples ≈
xcar −xcars, xf amily −xf amilies ≈xcar −xcars, and
so on.

More recently, neural network language
models have been proposed for the classical lan-
guage modeling task of predicting a probability dis-
tribution over the “next” word, given some preced-
ing words. These models were first studied in the
context of feed-forward networks (Bengio et al.,
2003; Bengio et al., 2006), and later in the con-
text of recurrent neural network models (Mikolov et
al., 2010; Mikolov et al., 2011b)

This early work
demonstrated outstanding performance in terms of
word-prediction, but also the need for more compu-
tationally efficient models. 

The word representations we study are learned by a
recurrent neural network language model (Mikolov
et al., 2010), as illustrated in Figure 1

This architec-
ture consists of an input layer, a hidden layer with re-
current connections, plus the corresponding weight
matrices. 

The input vector w(t) represents input
word at time t encoded using 1-of-N coding, and the
output layer y(t) produces a probability distribution
over words. 

The hidden layer s(t) maintains a rep-
resentation of the sentence history

The input vector
w(t) and the output vector y(t) have dimensional-
ity of the vocabulary. 

he values in the hidden and output layers are computed as follows: 

$$\mathbf{s}(t) = f \left( \mathbf{U}\mathbf{w}(t) + \mathbf{W}\mathbf{s}(t-1) \right) \qquad (1)$$

$$\mathbf{y}(t) = g \left( \mathbf{V}\mathbf{s}(t) \right) , \qquad (2)$$

where

$$f(z) = \frac{1}{1 + e^{-z}} , \quad g(z_m) = \frac{e^{z_m}}{\sum_k e^{z_k}} . \qquad (3)$$

In this framework, the word representations are
found in the columns of U, with each column rep-
resenting a word.

The RNN is trained with back-
propagation to maximize the data log-likelihood un-
der the model. The model itself has no knowledge
of syntax or morphology or semantics. Remark-
ably, training such a purely lexical model to max-
imize likelihood will induce word representations
with striking syntactic and semantic properties.

To understand better the syntactic regularities which
are inherent in the learned representation, we created
a test set of analogy questions of the form “a is to b
as c is to ” testing base/comparative/superlative
forms of adjectives; singular/plural forms of com-
mon nouns; possessive/non-possessive forms of
common nouns; and base, past and 3rd person
present tense forms of verbs.


we
tagged 267M words of newspaper text with Penn Treebank POS tags (Marcus et al., 1993).

We then
selected 100 of the most frequent comparative adjec-
tives (words labeled JJR); 100 of the most frequent
plural nouns (NNS); 100 of the most frequent pos-
sessive nouns (NN POS); and 100 of the most fre-
quent base form verbs (VB). We then systematically
generated analogy questions by randomly matching
each of the 100 words with 5 other words from the
same category, and creating variants as indicated in
Table 1. The total test set size is 8000. The test set
is available online.

n addition to syntactic analogy questions, we used
the SemEval-2012 Task 2, Measuring Relation Sim-
ilarity (Jurgens et al., 2012), to estimate the extent
to which RNNLM word vectors contain semantic
information.

The dataset contains 79 fine-grained
word relations, where 10 are used for training and
69 testing.

As we have seen, both the syntactic and semantic
tasks have been formulated as analogy questions.
We have found that a simple vector offset method
based on cosine distance is remarkably effective in
solving these questions.

In this method, we assume
relationships are present as vector offsets, so that in
the embedding space, all pairs of words sharing a
particular relation are related by the same constant
offset. (Figure 2)

In this model, to answer the analogy question a:b
c:d where d is unknown, we find the embedding
vectors xa, xb, xc (all normalized to unit norm), and
compute y = xb −xa + xc.

Of course, no word might exist at that
exact position, so we then search for the word whose
embedding vector has the greatest cosine similarity
to y and output it


We see that the RNN vectors capture significantly
more syntactic regularity than the LSA vectors, and
do remarkably well in an absolute sense, answering
more than one in three questions correctly

We have presented a generally applicable vector off-
set method for identifying linguistic regularities in
continuous space word representations.

We have
shown that the word representations learned by a
RNNLM do an especially good job in capturing
these regularities.






---

# Gemini chat about the paper:


It is easy to look back at this now and see "basic linear algebra," but in 2013, this paper was a seismic shift in how we viewed the "black box" of neural networks. To understand why this wasn't considered "basic" at the time, we have to look at the prevailing mindset of the early 2010s.

Before this paper, researchers knew that Recurrent Neural Networks (RNNs) were good at predicting the next word in a sequence. However, the hidden layers—represented by the vector $\mathbf{s}(t)$ in the formulas you just saw—were largely viewed as abstract mathematical "junk" that helped the model minimize loss.

People didn't necessarily expect that these hidden states would organize themselves into a perfectly linear, relational map. The discovery wasn't just that the vectors had meaning, but that they had proportional, geometric meaning.

While people knew that "cat" and "dog" would be close together (distance), they didn't realize that the direction and magnitude of the displacement between words would be consistent across the entire space.

The "King - Man + Woman = Queen" insight: This showed that the vector $\vec{v}(king) - \vec{v}(man)$ resulted in a "gender vector" that could be applied to any other noun.

Linearity in a Non-linear System: RNNs use non-linear activation functions (like the $sigmoid$ in your uploaded image). It was surprising that a highly non-linear system would produce a latent space where semantic relationships could be solved with simple vector addition and subtraction.

Remember the Dagan et al. (1994) paper you were reading? That era focused on discrete counts and "smoothing" to handle sparsity. Mikolov’s work proved that you didn't need to manually smooth or find neighbors using complex formulas. The RNN's hidden layer performed a form of automatic, continuous smoothing that was far more powerful than anything seen in the previous 20 years.

In 2013, training these models was computationally expensive. The efficiency of the linear regularities meant we could perform semantic tasks without needing a separate, heavy classifier. Today, we take for granted that "embeddings = meaning." In 2013, the dominant paradigm in NLP was still based on logic-based rules and sparse n-gram models. The idea that you could "calculate" the capital of France by doing Paris - France + Italy felt like magic, not basic math.

The "basic" nature of the math was actually the point. Mikolov showed that we didn't need complex, deep architectures to extract these meanings; they were a natural byproduct of simple objective functions. This paved the way for the Word2Vec revolution (Skip-gram and CBOW) just months later.

You’ve pinpointed the exact tension between theory and scale. People suspected hidden layers were useful, but they lacked the specific proof and the massive data volume required to turn a mathematical curiosity into a world-changing tool.

It wasn't that people thought the layers were "useless," but rather that they didn't realize how structured and universal those representations were until the scale of data and compute changed.

The concept of "distributed representations" (vectors) dates back to Geoffrey Hinton and others in the mid-1980s. They proved that neural networks could learn internal features to solve specific tasks. hese early experiments were done on tiny, toy datasets (like family trees with 24 people). While the "hidden units" showed some logic, nobody knew if this would hold up when trained on the messy, infinite complexity of the real-world internet.

In the 90s and 2000s, "large" datasets were a few million words. To see the "King - Man + Woman = Queen" regularity, the model needs to see those words in thousands of different contexts to "average out" the noise. Without Wikipedia-scale corpora (billions of words), the vector space is too "lumpy" and the linear analogies don't emerge.

Before this paper, people were obsessed with making RNNs deeper and more complex to handle logic. However, complex models are slow. The Mikolov Insight: He realized that if you simplify the architecture (removing the non-linear hidden layers, leading to Word2Vec), you could train on 1,000x more data in the same amount of time. He proved that more data + simpler model > less data + complex model.

C. Lack of Evaluation Frameworks
Believe it or not, before this paper, there wasn't a standardized "Analogy Test." Researchers mostly evaluated RNNs by Perplexity (how well they predicted the next word). If a model had low perplexity, people said "Great, it's a good language model!" They didn't think to stop and ask: "Wait, can I do math with the internal weights?"

3. The "Unsupervised" Revelation
Most prior work used Supervised Learning (labels). If you train a network to classify "Sentiment," the hidden layer will represent "Happy vs. Sad." The shock of the Mikolov paper was that Unsupervised Learning (just predicting the next word) created a hidden layer that understood everything: gender, geography, verb tense, and capital cities. It proved that "meaning" is a statistical byproduct of "prediction."

The finding that word representations inhabit a continuous, linear vector space is the "silver bullet" for the sparsity problem because it replaces exact matches with geometric proximity. In traditional NLP (lexical semantics), if the model hasn't seen the specific sequence "The platypus eats," it has zero information. In the continuous space described by Mikolov et al., the model can "triangulate" meaning even for sequences it has never encountered.

1. From "Discrete Gaps" to "Continuous Maps"
Sparsity is fundamentally the problem of unseen events. In a sparse system (like a one-hot or n-gram model), every word is an island. There is no path from "sofa" to "couch" unless they are explicitly linked. If your training data contains "He sat on the sofa" but your test data contains "He sat on the couch," a sparse model sees "couch" as a completely unknown entity ($0$ probability). Because the RNNLM (Recurrent Neural Network Language Model) learns that sofa and couch have nearly identical vectors, the model's hidden state $\mathbf{s}(t)$ for both sentences will be almost mathematically identical. The model "borrows" the experience of sofa to understand couch.

> So here, it doesn't matter that a network is being passed couch in one of the units. Because the other 3 input units are "He sat on the". This will produce a vector that is in the similar space to "He sat on the sofa". Can these we can use the probability of "He sat on the sofa" as a proxy for "He sat on the couch"
> semantic generalization in a continuous space.
> To refine that intuition: it’s not just that the model uses the probability as a "proxy"—it’s that, mathematically, the model can no longer easily tell the difference between the two scenarios because they map to the same region of "meaning."
> In a sparse model, the "ID" for sofa (Index 402) and couch (Index 8001) are as different as the numbers 1 and 1,000,000. There is no overlap.
> In an RNNLM, after seeing "He sat on the..." thousands of times followed by various pieces of furniture, the backpropagation process pushes the input embeddings ($\mathbf{w}(t)$ in your formula) for sofa and couch to nearly the same coordinates.
> 2. The Hidden State as a "Contextual Summary"Look back at the formula you uploaded:$$\mathbf{s}(t) = f(\mathbf{U}\mathbf{w}(t) + \mathbf{W}\mathbf{s}(t-1))$$$\mathbf{s}(t-1)$ has already captured the "history" of the sentence: He sat on the.When you provide the current word $\mathbf{w}(t)$ (couch), it is multiplied by $\mathbf{U}$.If $V_{couch} \approx V_{sofa}$, then the resulting hidden state $\mathbf{s}(t)$ will be nearly identical for both sentences.
> 

Handling Inflectional SparsitySuppose your dataset is small. You see "walk" and "walked," and you see "run," but you never see the word "ran."In a sparse model: "ran" is a "zero."In the Mikolov space: The model knows the vector relationship $V_{walked} - V_{walk} \approx \text{PAST\_TENSE}$. It can mathematically predict where $V_{ran}$ should be by calculating $V_{run} + \text{PAST\_TENSE}$.

In your previous question about the Softmax function $g(z_m) = \frac{e^{z_m}}{\sum_k e^{z_k}}$, the "sparsity" is tackled because the model assigns a non-zero probability to every word in the vocabulary for every context. Because the vector space is continuous, similar words naturally get similar probability "mass."

4. Why the "Linearity" matters for Sparsity
If the space were "curved" or disorganized, finding a neighbor wouldn't help you predict a relationship. The fact that the space is linear means that the "gaps" in our data (the sparse zeros) can be filled in using simple arithmetic. We can navigate the "empty" parts of the language space because the map is consistent.

We tackle sparsity by moving from a world where we need to see everything to a world where we only need to see enough to build the map. Once the map (the vector space) is built, the "unseen" points are just coordinates we haven't visited yet, but whose locations we can already guess.




This is the ultimate "Aha!" moment in understanding neural NLP. If the network has literally never seen the word "couch" during its entire training phase, we run into a "Cold Start" problem. How the network handles this depends on whether the word is Out-of-Vocabulary (OOV) or simply Rare.

1. Scenario A: The word is "Rare" (Seen once or twice)If "couch" appeared even once in a 1-billion-word corpus, it has a vector. Because it likely appeared in a context like "He sat on the couch," the backpropagation algorithm nudged its vector to look like other things that appear after "He sat on the..." (like sofa or chair).In this case:The weights $\mathbf{U}$ multiply the "couch" vector.The result "percolates" through, and because the vector is already in the "furniture neighborhood," the hidden state $\mathbf{s}(t)$ remains stable.

2. Scenario B: The word is "Unknown" (Truly never seen)
If the word "couch" was never in the training data, the network cannot compute a specific vector for it. In traditional RNNLMs (like the 2013 Mikolov paper), there is no magic "inference" for a brand-new string of characters.

Here is what actually happens: The <UNK> Token. Most models reserve a specific slot in the vocabulary for an "Unknown" token. Any word not in the vocabulary is replaced by the <UNK> symbol. The network has a specific vector for <UNK> that it learned from other rare words during training. The Problem: In this case, "couch" and "glip-glop" would look identical to the model. Sparsity wins here.


The Sub-word Revolution (The Modern Fix)
To solve exactly what you are asking—how does it compute something for a word it hasn't seen?—modern models (and later iterations of Mikolov's work like FastText) don't look at whole words. They look at sub-words or character n-grams. If the model sees "couch" for the first time: It breaks it into co, ou, uch. It might have seen couching or vouch before. It aggregates the vectors of those known pieces to "construct" a vector for the unknown word "couch."


4. Why it doesn't just turn into a 0In the sparse models you read about earlier (like one-hot), an unknown word is a 0. It has no index, so the math breaks.In a continuous model, every input is a dense vector. Even a randomly initialized vector for an unknown word is a collection of numbers (e.g., [0.1, -0.2, 0.5]).It's not a "0"; it's "noise."The "History" ($\mathbf{s}(t-1)$) is often strong enough to "override" the noise of one unknown word. If the model is $90\%$ sure the next part of the sentence involves furniture because of "He sat on the...", a noisy input for "couch" won't totally derail the hidden state. It will just make the prediction slightly "fuzzier."The "Percolation" Summary: If the word is known but rare, its vector has already been "pulled" into the right neighborhood by the context. If it is truly unknown, modern models build its vector from sub-components so the math never hits a "0."

---

# QUESTIONS 

# 1. What are the main findings of this paper? Are you convinced?





# 2. What do the authors claim is the main advantage of using distributed representations of words (aka. embeddings) over classical n-gram language models?

The main advantage is the ability of distributed representations to generalize to unseen word sequences. Words are mapped to a continuous vector space where semantically similar words are close to one another. Classical N-grams: These models rely on exact matches of word sequences. If a specific n-gram (e.g., "the sapphire sky") was not seen in the training data, the model has no information about it, leading to the "sparsity" problem. Because the model represents "sapphire" and "azure" as similar vectors, a model trained on "the sapphire sky" can naturally assign a high probability to "the azure sky," even if that specific phrase never appeared in the training set. 

The authors demonstrate that RNN-based distributed representations capture multi-dimensional semantic and syntactic relationships as constant vector offsets.

Because embeddings "smooth" the language space continuously, they often achieve lower perplexity (a measure of how well a probability distribution predicts a sample) than n-gram models.






# 3. What is meant by a syntactic analogy? Give some examples of your own. Use some examples to explain why word2vec embeddings might be good at capturing syntactic regularities. Do you think the same would apply to other distributional word representations?

In the context of word embeddings, a syntactic analogy refers to a relationship based on the grammatical structure or "form" of words rather than their core meaning. While a semantic analogy relates to concepts (e.g., Paris : France), a syntactic one relates to linguistic rules like verb tense, pluralization, or degrees of comparison. These follow the pattern $A : B :: C : D$ (read as "$A$ is to $B$ as $C$ is to $D$"):

Word2Vec (specifically architectures like CBOW and Skip-gram) captures these because of the Distributional Hypothesis: words that appear in similar contexts have similar meanings. In syntax, "form" dictates context just as much as "meaning" does.

Consider the words "climbing" and "climb":

Shared Semantic Context: Both will appear near words like "mountain," "rope," or "steep."

Unique Syntactic Context: "Climbing" will frequently be preceded by auxiliary verbs like "is," "was," or "are" (e.g., "He is climbing"). "Climb" will follow modals or "to" (e.g., "They want to climb").

The Result: The model learns a specific vector offset for the "-ing" suffix. Because the context shift from "walk" to "walking" is statistically almost identical to the shift from "climb" to "climbing," the vectors for these changes become parallel in the embedding space.

Early distributional models based on large co-occurrence matrices (like Latent Semantic Analysis) are generally weaker at capturing fine-grained syntactic analogies. They tend to capture "topical" similarity (e.g., doctor and hospital). Because they often use large context windows or bag-of-words approaches, the subtle word-order cues required to distinguish "walk" from "walking" often get washed out.

Models like FastText (an evolution of Word2Vec) are actually better at syntactic regularities. FastText represents a word as a sum of its character n-grams (e.g., "climbing" = cl, li, im, mb, bi, in, ng). Even if the model has never seen a specific rare verb, it recognizes the -ing or -ed ending and can mathematically "calculate" its syntactic position based on those sub-parts.


# 4. What is meant by a semantic analogy? Give some examples of your own. Use some examples to explain why word2vec embeddings might be good at capturing semantic regularities. Do you think the same would apply to other distributional word representations?

A semantic analogy refers to a relationship based on the meaning, concepts, or real-world knowledge associated with words, rather than their grammatical form. In a vector space, this is represented by the idea that the "distance" and "direction" between two concepts (like a country and its capital) remain constant across different pairs.

These follow the proportional relationship $A : B :: C : D$:Capital Cities: London : England :: Tokyo : Japan 

Word2Vec (specifically Skip-gram and CBOW) excels here because it treats words as dense vectors learned from their surrounding context. The model relies on the fact that words with similar meanings appear in similar environments.

The specific vector offset—the "jump" you take to get from the country to the city—represents the concept of "being the capital of." Because the model sees the same pattern for Berlin and Germany, the vector $\vec{v}(Berlin) - \vec{v}(Germany)$ ends up pointing in the same direction and having the same length as $\vec{v}(Paris) - \vec{v}(France)$.

Earlier models like Latent Semantic Analysis (LSA) capture thematic similarity (e.g., bee is near honey), but they often struggle with specific relational analogies. Because they use global matrix factorization, the fine-grained directional relationships (the "offset") are often not as precisely preserved as they are in the prediction-based Word2Vec.

Yes, the same applies here, and often even better. GloVe was designed specifically to capture these linear regularities by training on the ratio of co-occurrence probabilities. It explicitly forces the global statistics of the corpus into a model where the differences between word vectors represent meaning.






---

**what is lsa**
LSA is a form of dimensionality reduction. Its goal is to take a massive, sparse matrix (where most values are zero) and transform it into a compact, dense representation that captures the "thematic neighborhood" of words rather than just their exact spelling. LSA relies on a mathematical process called Singular Value Decomposition (SVD): The Matrix: You start with a "term-document matrix" that tracks how often every word appears in every document. The Compression: SVD factorizes this matrix into smaller pieces, effectively "throwing away" the noise and keeping only the most important statistical dimensions. The Result: Words that frequently appear in the same types of documents are pushed together in a multi-dimensional space, even if those words never actually appear in the same sentence.

A major advantage of LSA is its ability to handle synonyms. In a traditional system, "physician" and "doctor" are treated as completely different things because they are spelled differently. In LSA, because "physician" and "doctor" both tend to appear in documents about hospitals and medicine, the model learns that they are nearly identical features.

In our more recent discussions, we compared LSA to neural approaches like Word2Vec:LSA (Global): Analyzes the entire corpus at once to find global themes. It is generally better at capturing "topical" similarity (e.g., bee and honey).Word2Vec (Local): Uses a "sliding window" to look at immediate neighbors. It is often better at capturing specific relational analogies like $King - Man + Woman = Queen$.

Speed & Efficiency: It makes classification models faster and less prone to overfitting by compressing thousands of unique words into a few hundred "concepts".

Thematic Understanding: It allows a computer to understand that a document about "strikeouts" relates to Sports, even if the word "sports" is never mentioned.

While your intuition is correct—LSA definitely learns that "Paris" and "France" "go together"—there is a technical reason why it struggles with relational analogies (like the city:country pair) compared to Word2Vec.

It comes down to the difference between Topical Association and Relational Linearities.

Topical Association vs. Relational Direction
LSA is excellent at Topical Association. If you search for "Paris," LSA will likely return "France," "Eiffel Tower," and "baguette" because they all co-occur in the same documents. In the vector space, these words will form a "cloud" or cluster.

However, a Semantic Analogy requires more than just being in the same cloud; it requires a consistent directional vector.

To solve Paris : France :: Tokyo : Japan, the model needs the "step" from France to Paris to be the same mathematical direction as the "step" from Japan to Tokyo.

LSA vectors are built using Singular Value Decomposition (SVD), which focuses on reconstructing the global variance of the data. This often "squashes" the specific directional relationships into a general "topic" dimension. You know they are related, but the math doesn't necessarily preserve the specific nature of the relationship (e.g., "is the capital of") as a straight line.

The "Bag of Words" Limitation
As we discussed earlier, LSA typically uses a Term-Document Matrix This means it looks at whether words appear in the same document. Because documents are large, the relationship it learns is broad: "These words are about French things". Word2Vec uses a tiny local window (5–10 words). By looking only at immediate neighbors, it captures the specific linguistic "slots" words fill. The precision of these small windows is what allows the linear "offset" (the analogy math) to emerge so clearly.

Global Statistics vs. Local Prediction
LSA (Global): It is great for Document Classification because it knows the "gist" of a text. It knows "Paris" belongs in the "France" topic. Word2Vec (Local): It is better at Linguistic Regularities because it treats word relationships like a map with specific coordinates and directions.

LSA does learn they go together, but it maps them as a cluster (a neighborhood). Word2Vec maps them as a displacement (a specific path).

---










# 5. Explain the vector offset method used to answer an analogy question. In particular, what happens when no word exists at the predicted position?

The vector offset method is a technique used in distributional semantics to solve word analogies by treating semantic relationships as geometric displacements. This method relies on the finding that in a well-trained vector space (like Word2Vec), the relationship between two words is represented by the constant distance and direction between them.

How the Vector Offset Method WorksTo solve an analogy of the form "$A$ is to $B$ as $C$ is to $D$" (e.g., King : Man :: Queen : Woman), the model follows these steps:Calculate the Relationship Vector: The model calculates the difference between the vectors for words $A$ and $B$: $\vec{v}(B) - \vec{v}(A)$. This represents the "relational shift" (like gender or capital city).Apply the Offset: This vector is added to the vector for word $C$. This points the model toward a location in the vector space where $D$ should theoretically reside: $\vec{v}(D) \approx \vec{v}(C) + (\vec{v}(B) - \vec{v}(A))$.Find the Result: The model then looks for the word vector in the dictionary that is closest to this new coordinate.

Because word embeddings inhabit a continuous space, the mathematical result of the calculation ($\vec{v}(C) + \vec{v}(B) - \vec{v}(A)$) will almost certainly point to a precise coordinate where no actual word vector is located. To resolve this, the model uses the following strategies:

Cosine Similarity Search
The model does not look for an exact match. Instead, it performs a nearest-neighbor search using a metric like Cosine Similarity. It scans the entire vocabulary to find the word vector that has the smallest angular distance from the predicted coordinate.

To prevent the model from simply returning one of the words used in the query (which are often very close to the target area), the inputs $A, B,$ and $C$ are typically excluded from the search results. For example, if the model calculates $King - Man + Woman$, it will ignore those three words and find the next closest neighbor, which is usually Queen. 




# 6. What do you think of the results for identifying syntactic regularities? Is answering more than 1 in 3 questions correctly a good result? Are there any obvious trends in the results?



# 7. Do you think the comparisons with other methods are fair? Why do the authors use a different test set when comparing with Collobert & Weston (2008) and Mnih & Hinton (2009)? Does this test set appear to be easier or harder than the original one?


# 8. What do you think of the results for identifying semantic regularities? Why are results given for
Spearman’s Rank and MaxDiff Accuracy rather than Accuracy (as before)?
















---

**Glvoe vs Word2Vec**

The fundamental difference between GloVe (Global Vectors for Word Representation) and RNNs (Recurrent Neural Networks) lies in their mathematical objective: GloVe is a count-based, global matrix factorization model, whereas an RNN is a prediction-based, sequential model.

While both ultimately produce dense word embeddings, they "look" at the data through very different lenses.

1. Global Statistics vs. Local Context
GloVe (Global): GloVe operates on a Global Co-occurrence Matrix. It looks at the entire corpus at once and counts how often every word in the dictionary appears near every other word. It focuses on the ratio of these probabilities to determine word meaning.

RNN (Sequential): An RNN processes text one word at a time in a specific order. It builds a representation by trying to predict the next word in a sequence based on the "hidden state" (memory) of the words that came before it.

Feature,GloVe,RNN (as used by Mikolov et al.)
Input Data,A pre-computed word-word co-occurrence matrix.,Raw sequences of text (sentences).
Goal,To ensure the dot product of two vectors equals the log of their co-occurrence count.,"To minimize ""perplexity""—making the predicted next word as accurate as possible."
Handling Order,"Generally order-insensitive; it knows words are ""near"" each other but doesn't care which came first.",Strictly order-sensitive; the meaning of the hidden state changes based on word sequence.

GloVe produces Static Embeddings. Once training is finished, the word "bank" has one fixed vector regardless of whether you are talking about a river or a vault.

RNNs produce two types of representations. While the "input weights" $(\mathbf{U})$ are static, the Hidden State $(\mathbf{s}(t))$ is a Contextual Summary. It is a unique, composed vector that represents the meaning of the entire sentence up to that point.

4. Which is better for Analogy Tasks?GloVe was specifically engineered to be excellent at the vector offset method ($King - Man + Woman = Queen$). Because it is forced to learn the global ratios of word occurrences, these linear regularities are often very "clean" and consistent across the whole space.RNNs capture these regularities as a byproduct of learning language. While they are very good at it, the primary "finding" of the Mikolov paper was that it was surprising a sequential prediction model would produce such neat linear geometry at all.

If you want to understand global themes and solve analogies quickly, GloVe is the standard tool. If you want to understand sentence structure, word order, and compositional meaning, the RNN approach (or its modern successor, the Transformer) is required.

In a broad sense, yes, the resulting vectors from GloVe and the weights in an RNN represent the same thing—semantic coordinates in a continuous space—but they are constructed using very different mathematical "blueprints."

While they both end up as dense matrices where each row is a word vector, the internal logic of those values differs.

1. Functional Similarity: The Lookup TableIn both models, the "word representations" act as a lookup table.In GloVe: The dense matrix is the result of factorizing a global co-occurrence table.In RNNs: The dense matrix (specifically the input weight matrix $\mathbf{U}$) is trained via backpropagation to help the model predict the next word.The Result: In both cases, if you take the row for "sofa" and the row for "couch," the numbers in those rows will be very similar because both models learned from context.

3. The "Static" vs "Contextual" DistinctionThis is the most critical difference in how these weights behave during use:GloVe Weights: These are static. Once the matrix is trained, the vector for "bank" is fixed. It is essentially a "dead" file you look up.RNN Weights: While the matrix $\mathbf{U}$ is also static, it is just the starting point. The RNN uses these weights to build a dynamic hidden state $\mathbf{s}(t)$.If the RNN sees "River" followed by "bank," the hidden state $\mathbf{s}(t)$ will be a unique vector representing a "water-related bank."If it sees "Investment" followed by "bank," $\mathbf{s}(t)$ becomes a "finance-related bank".

Which one is "Better"?
GloVe is often preferred for Relational Analogies because its global objective forces the "geometry" of the space to be very consistent (e.g., the King - Man + Woman math). RNN Weights (and the resulting hidden states) are better for Syntactic Tasks and Compositionality, as they were trained to understand how words interact sequentially.

In the context of models like GloVe or LSA, factorizing a global co-occurrence table is a mathematical process used to compress a massive, sparse record of language into a compact, dense "map" of meaning.

First, you build a Global Co-occurrence Matrix.

Factorization is a linear algebra technique that breaks one large matrix into two (or more) smaller matrices which, when multiplied together, recreate the original as closely as possible.In distributional semantics, we factor our giant $V \times V$ matrix into two smaller matrices of size $V \times d$ (where $d$ is a small number like 300).Matrix $W$: Represents the "Word" vectors.Matrix $C$: Represents the "Context" vectors.

The magic of factorization is that it forces the model to find latent (hidden) dimensions.
Because the model only has 300 dimensions to explain billions of co-occurrence counts, it has to find the "common denominators" of language.

While an RNN learns these vectors by "reading" sentences one by one and predicting what comes next, Factorization looks at the "big picture" statistics of the whole language at once.

Factorizing a co-occurrence table is essentially mathematical summarization. You take the "raw evidence" (who hangs out with whom) and condense it into "character traits" (the dense vectors).

While both GloVe and SVD (the engine behind Latent Semantic Analysis) are global matrix factorization techniques, they differ fundamentally in what they factorize and how they handle the math. If SVD is a "brute force" mathematical compression, GloVe is a "linguistically motivated" optimization.

1. The Matrix they Factorize
The most significant difference is the "preprocessing" of the data before the math starts:
* SVD (Latent Semantic Analysis): Typically factorizes a Term-Document Matrix. This matrix tracks which words appear in which documents. Because it looks at the document level, it excels at identifying broad topics (e.g., seeing that "stadium" and "referee" both belong to the "Sports" topic).
+1
* GloVe: Factorizes a Word-Word Co-occurrence Matrix. Instead of looking at documents, it looks at a "sliding window" of local context across the entire corpus. It tracks how often "ice" appears near "cold" versus how often "steam" appears near "hot."

2. The Objective: Linear RatiosThe "magic" of GloVe that makes it superior for analogies (like King - Man + Woman = Queen) is its specific mathematical objective.SVD: Aims for Reconstruction. It tries to find a lower-dimensional version of the matrix that has the minimum possible error compared to the original. It treats every "count" with similar importance.GloVe: Aims to model the ratio of co-occurrence probabilities.The Logic: If you want to know the difference between ice and steam, looking at the probability of water appearing near them doesn't help (it's high for both). But the ratio of $P(solid|ice) / P(solid|steam)$ will be very high.GloVe forces the word vectors' dot products to equal the logs of these co-occurrence counts, which preserves these linear ratios much better than SVD.

In GloVe, deciding the size of the learned matrices involves two distinct dimensions: the Vocabulary Size ($V$) and the Embedding Dimension ($d$).

1. The Vocabulary Size ($V$)This determines the number of rows in your word and context matrices.Thresholding: Rather than including every single string of characters found in a crawl (which would include typos and rare gibberish), researchers typically set a minimum frequency count (e.g., a word must appear at least 5 times).Computational Limits: A larger $V$ increases the memory footprint of the co-occurrence matrix exponentially ($V^2$). Most standard models cap $V$ between 50,000 and 400,000 words to balance coverage with hardware constraints.

2. The Embedding Dimension ($d$)This is the number of columns in your matrices (the length of the word vector). Choosing this is a "Goldilocks" problem:Too Small ($d < 50$): The model suffers from underfitting. There aren't enough dimensions to capture the nuance between complex concepts (e.g., the subtle difference between "remorse" and "regret" might be lost).Too Large ($d > 1000$): The model begins to overfit to the noise in the training data. Furthermore, you encounter "diminishing returns" where the marginal gain in accuracy is outweighed by the massive increase in training time and memory.The "Sweet Spot": For most general-purpose NLP tasks, $d$ is set between 100 and 300. The original GloVe researchers found that performance on analogy tasks improves rapidly up to 200 dimensions, but plateaus significantly after 300.

3. Hyperparameter TuningBecause there is no "perfect" number that works for every dataset, researchers use empirical validation:Downstream Task Performance: They train multiple versions (e.g., 50d, 100d, 300d).Evaluation: They test each on a specific task, like the Analogy Test ($King - Man + Woman = ?$) or Sentiment Analysis.Selection: They choose the smallest dimension that achieves the highest required accuracy.

Actually, it’s quite the opposite! While GloVe is based on global statistics, it uses an iterative training process almost identical to modern neural networks.

To be clear: GloVe has a specific loss function and uses Stochastic Gradient Descent (SGD) to minimize it.

Even though GloVe factorizes a matrix, it doesn't use the standard closed-form math of SVD. Instead, it defines a Weighted Least Squares objective function. The goal is to make the dot product of two word vectors plus some "bias" terms equal to the log of their actual co-occurrence count:

$$J = \sum_{i,j=1}^{V} f(X_{ij}) \left( w_i^T \tilde{w}_j + b_i + \tilde{b}_j - \log X_{ij} \right)^2$$

$w_i^T \tilde{w}_j$: The dot product of the word and context vectors (the "predicted" similarity).
$\log X_{ij}$: The "ground truth" (how often they actually appeared together in the corpus).
$f(X_{ij})$: The weighting function (explained below).

2. The Use of Gradient DescentBecause this is a massive optimization problem ($V^2$ possible pairs), you can't solve it in one go.
* Initialization: The matrices (the rows of word vectors) are initialized with random numbers.
* Sampling: The model iterates through all the non-zero entries in the global co-occurrence matrix.
* Error Calculation: It calculates the "loss" (the difference between the dot product and the actual log-count).
* Gradient Descent: It uses Stochastic Gradient Descent (SGD) to nudge the values in those vectors so that the error decreases.

This is what makes GloVe different from a standard matrix factorization. In a normal factorization, every "zero" or "one" in the table has the same weight. In language, that's a disaster because:Rare words are noisy.Common words (like "the") appear so often they would dominate the whole model.GloVe’s loss function uses a weighting curve that caps the influence of very frequent words and ignores pairs that never co-occurred ($X_{ij} = 0$).

People often think that "Global Statistics" means "No Training." However, in this case, the Global Statistics are just the Training Data.

* RNNs: Train on raw text (word by word).
* GloVe: Trains on a summary of the text (the co-occurrence matrix).

Both use Loss Functions and Gradient Descent to turn that data into dense vectors

---

## Week 4: Lab Content

## Week 4: Additional Reading
















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