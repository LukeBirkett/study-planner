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

#### Document Classification using Naive Bayes

Here, documents are respected as a bag-of-words where the features are the observed words. There is no notion of order meaning the structure of sentances is lost. NB selected a class/label based on the cumulative probabilites of the feature vector that respresents the document. 

$$y = \text{argmax}_y P(y) \prod_{i=1}^{n} P(x_i \mid y)$$

It is important to remember Naive Bayes is a similifiation of Bayes Rule. To simplifiy the model we assume that features, the words, are all indepent, i.e. the use of one word does not increase or decrease the use of a another, this is how we end up with our bag-of-words srtucture. Clearly this is not true but it makes the formula mathematically possible, allowing us to compute at least something. 

#### Towards More Intelligent NLP

This slide highlights that a Naive Bayes approach to NLP is a little too basic. It treats word tokens as atomic building blocks but obscures too much of the characteristics required for human understanding of language: the meaning. Meaning is generally inferred through words relationships with other words and/or their similarity to other words. This notion is the basis for Lexical Semnatics which is the focus of this weeks content. 

#### Seminar 1.1 Questions

**1. Give an example of lexical ambiguity**: These are words that are spelt exactly the same but have different senses. 

**2. Give an example of lexical variation**: These are different words that mean the same thing/sense

**3. What is a WordNet synset?** a WordNet synset (short for "synonym set") is a group of words that mean the same thing in a specific context.

**What does the number of synsets that a word form occurs in tell us?**: This is a measure of its polysemy, i.e. its multiple meanings.

**What does the size of a synset tell us?** The "size" of a synset refers to the number of lemmas (individual word forms) that are grouped together within it. While the number of synsets for a word tells you about ambiguity, the size of a single synset tells you about lexical density and synonymy. If a sense has many different words for it then this may be a culturally important word that is used often, or something that requires different words to represent an emotional context. Additionally, a large sysnet might imply that the word is high-level and broad. A sysnset with only 1 word is monosemous, these words are very specific and can only ever mean 1 thing. 

**How are synsets connected?** Synsets are linked in a semantic network of Hyponymy and Hypernymy. This is hiearchical structure which denotes an "Is-A" relationship. Hypernym (Superordinate): A more general term. (Furniture is a hypernym of Chair). Hyponym (Subordinate): A more specific term. (Oak is a hyponym of Tree)


**4. Describe 2 ways WordNet can be used to calculate the 
similarity of 2 concepts?  Which is the best way and how do you know?** 

The two main ways of using WordNet are PathLength and Information Content. 

PathLength is a distance based metric with traverses edges and counts the shortest route from one term to another. It introduces the concept of a Lowest Common Subsumer (LCS) which is the lowest (first) mutual Hypernymy that two terms share. Shorter paths are assumed to be more similar words. 

The other measure, Information Content is considered to be node based. It assumes that the similarity of two concepts depends on how much "information" they share. It requires the addition of an external corpus to popualiton the statistics. The "Information Content" of a concept is based on its frequency in a large body of text. Rare, specific words (like Pomeranian) have high IC, while common, general words (like Entity) have low IC. There are many different IC metrics each with their own pros and cons. 

The Information Content (IC) measures (specifically Lin or Jiang-Conrath) are generally considered superior to simple Path-Based measures. However, this something with a trade-off which is generally linked to data robustness and specifically data sparisty. Language is naturally sparse and miss values often lead to formulas failing. 


#### Seminar 1.2 Questions

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

## Week 1 - Additional Readings

### <u> Vector Semantics </u>
The additional readings for this week are based on Vector Semantics:

* <u> [Chapter 5 of Jurafsky and Martin](files/week_1/week_1_add_read_vector_semantics_chapter_5.pdf) </u> sections 5.1-5 4 
* <u> [Lecture 3 of Jurafsky and Martin](files/week_1/week_1_add_read_vector_semantics_lecture_3.pdf) </u>

# Week 2 - Language Modelling with n-grams

This week we will be looking at n-gram language models.  In particular, we will be looking at:
* why build language models?
* how to evaluate language models?
* perplexity
* generation
* generalisation and smoothing

#### Week 2: Contents

1. [Lecture](#week-2---lecture)
2. [Lab](#week-2---lab)
3. [Seminar](#week-2---seminar)
4. [Additional Readings](#week-2---additional-readings)

# Week 2 - Lecture

| [Lecture Slides](files/week_2/week_2_lecture_slides.pdf) |

This week we are looking at **Probabilitic Language Models**. This includes: n-gram modelling and their evaluation methods (perplexity), generation and generalisation.

#### Why do we want to be able to assign a prob to a sentence?

The starting desire to acheive this comes form machine translation. If we wish to translate a sequence of tokens from source to other language then we want to select the most probable sequence in the target. 

However, the sentence, or words, chosen need to follow the cultural rules of a language. Semantically, there may be several phrases whereby the choice of words results in a high probability. i.e. high winds and large winds but the former is much more likely in action. If we derive our probabilites from large corpuses then the statistics will tell us that high winds is a much more common phases. 

This desire to assign probabilities to tokens, or sequence of tokens, also applies to spelling corrections. By detailing the probability of sentences, we can work out which spelling/usage of a word if most likely and therefore more probable to be the correct spelling. 

This concept is most easy to think about within the topic of speech recognition. A computer can parse sounds into words but we have many words, sounds and prases that in terms of pure noise, sounds the same but mean completely different things. Merely constructing sounds from the entire lexicon can result in an unintelligence sentence. A real sentence will be distinguished by its probability: `P("I saw a van") > P(eyes awe of an)`.

This was the motivation for early language modelling

#### Probability language modelling

What is a probabilistic language model? It has the goal of computing 1 of 2 things:
* Compute the probability of a sentence as represented by a sequences of words: $P(W) = P(W_1,W_2,...,W_n)$
* Or the related but different task of computing the probability of an upcoming word given an input of a sequence of words: $P(W_5|W_1, W_2, W_3, W_4)$

If a model does either of these tasks, it is a language mnodel (LM).

#### Chain Rule for Probabilties 

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

#### Estimating Probabilities

The issue we run into here is data sparsity. As the sentence continues and the length of the dependant chain grows, the probability that the exact sentence has occured before starts to become extremely unlikely and our results will be unreliable. 

#### Markov Assumptions

To fix sparsity in n-grams we use Markov Assumptions. Here, we simplying the dependency criteria from the entire previous chain to orders. The most common is first-order Markov Chains whereby each newest word depends only on the previous word. This 1 previous state is considered to be a proxt for the entire previous sentence, for the previous state will occur given a specific set of previous states, i.e. the context of the sentence. This is an assumption of independence whereby all previous context is held intrinsically in the state. In practice, we know this isn't true but it is a simple assumption that allows us to calculate some sort of probability. The markov model can be extended in its orders. A second order model allows each words to look at the previous 2. 

#### N-gram Language Model

 Calculating the probability of a word based on every preceding word is computationally difficult, or even impossible, the N-gram model introduces a simplifying assumption:
 * It fixes the history and only considers $n$ words at a time: the current word ($w_i$) and the previous $n-1$ words.
 * Maximum Likelihood Estimation (MLE): The model estimates these probabilities by looking at a training corpus and calculating frequencies. In statistics, Maximum Likelihood Estimation is a method of estimating the parameters of a model that makes the observed data "most probable."

 $$P(w_i \mid w_{i-(n-1)}, \dots, w_{i-1}) = \frac{freq(all\ n\ words\ together)}{freq(the\ previous\ n-1\ words)}$$

 This formula represents the "training" phase of the model. It is the way the computer calculates the probability of a specific word appearing based on the context of the words that came right before it.

In this context, if you see the phrase "the cat sat" 10 times in your data, and 6 of those times the next word is "on," the MLE estimate for $P(on \mid the, cat, sat)$ is $6/10 = 0.6$. This is the "best guess" the model can make based solely on the evidence it has seen in its training text.

#### Unigram Model

This is the most simplistic type of n-gram model whereby `n=1`. It doesn't look at any previous words meaning probabilites are all independent, i.e. words have probabilities which get chained together: `P("he fell over) = P(he) * P(fell) * P(over)`

This approach is very simple but atlest it gives an estimate which can be used as a baseline for further comparison.

$$P(w_1, w_2, w_3, \dots, w_k) = \prod_{i=1}^{k} P(w_i)$$

#### Bigram Model

A bigram model is a first order markov model. 
INCLUDE NOTATION 

first order notion

each word prev word considered

should include token for start of setnence

[trigrams and beyond]
tri, quad, numbers

quad is hard to go beyond due to sparsity resulting in unreliabilty

[product of probs]
general rule is to avoid every mutliplying probs

either tend to vanish or explode

instead use log 

this allows use to product the probs

avoids underflow

compute mre efficent than multi

can convery back to probs if required

very small numbers in computers are inaccurate

log keeps them bigger

[evalaution]

how good is a lang model?

a good vs bad sentence?

does it assign higher probs to real sentences

and lowerr to ungrammatical or implausible

[extrinstic eval]

put models in a task; spelling, translation, speec rec

run rask and get an accurance for each model
- how many words spelling corrected
- how many translations
how many

probs; time consum, other factors affecting the task, lang model is not isolated

[instrinstic eval]
does the model assign higher probs to seen vs unseen?

if so it isn;t generalised

train on train set, test on test set (splits)

[perplexity]

best lang is the one tht best predicts and unseen test set

perp is the inverse prob of the test set, normalised by the number of words 

INCLUDE NOTIONS

this can be rearranged; law of expo and recips

INCLUDE RE NOTION

dont every have to calc actual prob (use log and products)

get perp by doing e to the power of 1

assumes we have calced prob as sum of logs

non-log method will give udnerflow 

GET DEFINITION OF UNDERFLOW!!!!

[min perplexity]

max prob is the same as in min perx as it is an inverse model

perplex shoukd only be use on the train/test split that come from the same corpus. prep tends to be skewed by length of corpus even though it is normalised by length. 



## PART 2

generalisation in n-gram models

[toy bigram]
very small "corpus"

rep probs as table/matrix

bigram so prob of work given prev

length of table is all possible tokens in corp

RECREATE TABLE IN MARKDOWN

can use these probs to chain into sentences/seqs

what happens to table when you update corp wth more sentences

can start to use prob stable to chain sentences that have never occured in the train corp but may be gramatically valid

[generation]

use the shannon-visualation to analyis possible sentences

sents nee to start with <sos>

look at prob dist of words given the start, what is possible and its probs

can pick and word from the dist, usually the highest (this is how we **generate** tokens)

repeate for the nxt token, given possible works based on generate token


... repeate until have to stop (end token)

INCLUDE SHANNON TABLE

dont always need to pick most common word, just prop to probs

[approximating shakespeare]
n=844,647
v = 29,066

tokens, vocab

estimate using different n-grams

INCLUDE N-gram RESULTS TABLE

starts to sound like shakes but there is a prob

4-gram looks like shakes but it exact passage from shakesperee

it doesnt sounds like shakes, it is shakes

there is no generalisation

there is nothing new

with vocab, there are 840 million bigrams 

99.96 of the possible bigrams did not occur in the shakespere corpus, only 300k occured

the way we are constructing the model says that only bigrams that occured in the traning data can be generated

[overfitting]

n-grams only work well for word pred if the test corp looks like the training copurus 

often this ownt be the case

if shakes had wiritten one more play

moddels need ot be robust so they can generalise to unseen data

need to avoid 0 probs ffor data not seen in the train set

[zeros]
demonstates issue with 0s

needto get prob mass to unnseen

[smoothing intuition]

when we have sparse dtates 

steal prob mass from observed events to general to unobserved

smoothing the counts

[add one estimation]

laplace smoothing

add one to all words in vocab

tends not to be used in language models

models are huge

assigns too much mass

makes the model too compelx

[unknown words]
approach for lang models

example; test contains words that train did not

will also be train words not in test

find training words that are least likely to be in test

these will be the lowest frew words

with this fix the vocab, just take n top words. can be based on some rule, i.e. occured atleast twice

create an <unk> token which captures probs of out of vocab words

if not in vocab then unk, including in trainng where we cut the corpus

throwing away stuff in the courpus and treat as unknown word

[unseen bigrams]

unk token allows est prob of seeing an oov in the test

can even est prob of seeing oov words together

does not hel us est prob of two in vocab words that havent been seen together in the train

[absolute discounting]

church and gale (1991)

look at text, divde train and test

average bigram count in train vs average bigram in test

they noticed that there is a relationship where the count in the test corupus is 0.75 lower in test (abvove 2 count)

[abs disc interp]

what they did is take d from each bigram counts

(from train count or test count?????)

d is a param to be set, i..e 0.75

save up diff from unobserved wirds

need to keep track of discount made for each word

take from bigram (notion) and add to dummy token called lambda (notion)

normalise counts to prob dists as normally works. freqs/total freq. probs ests for the bigrams based on corpus

how to use these outputs? 

when we want to estimate a new word (notation)

1. look up observed discounted probs given the previous
2. add the lamdba given the previous (sharing out)

how to share out. obv more share to more freq words. 

make sures non 0 as even if prob is 0 the shared lamb will create some level of output

NOTATION

# Week 2 - Lab 




# Week 2 - Seminar

extrinic =. measure how much it helps us in a specific application; accuracy focused
intrinstic = measure probabilities that the model outputs; train, test split; does it have bias towards training data, i.e. higher probs vs test set


2.2 

1. [pre-init probs, construct shannon vis] issue; would just create the same sequence each time
how to genrate diff likely sequence? sample distribution rather than select most likely

2.

3. 
oov is out of vocab; method is the unk method, only return n top common words, turn less common into the unk token and compute prob based on the freq of the unk token; this is called fixing (freezing) our vocab; add one smooth is bad because the dataset (all words) is just too extreme in size; unk token, oov token; why throw away info? rare info means we don't know much about it, at least in a freq/prob dependent setting; instead we model unk tokens, this allows us to learn how text handles rare works, what sort of words because before and after rare works; rare/oov words can exist in the train but not test but also vv test but not train.

4. 
absolute discounting; subtract a little from seen bigrams to reserve some prob mass which we can allocate to unseen words (unk tokes); trad method take fixed discount from each bigram, take 0.75 from each, means higher counts are loosing less proportionatly; keep track of substracted amount, store in dummy token called lambda; 
[DO CONCRETE NOTES ON THIS CONEPT IN BOTH LECTURE AND SEMIANR INC NOTION]

stupid back off is other type of bigram smoothing in the lecture. [DIDNT TAKE NOTES OF THIS IN THE LECTURE OF SEMINAR, NEED TO REVIEW]
used for web scale lang models; if 4 gram has 3 count, drop to 3 gram and take prob scaled by a fixed param, i.e. 0.4 (lamdba sign); called a "back off";


# Paper

Had questions to follow [havent done this yet]

1. 
basic, regarding first sem question
sem slides have relevant passages from paper

2. 
step 1: seed sents;
step 2: generate alternatives, 30, using a n-gram model, remove extreme (obvious) sentence to retain hard questions
step 3: human grooming, prune 30 down to 4 alts, prune with respect to rules

3. eval, perf measure
attempted in lab next
metruc measure was simply correct word or not; this is an accuracy is an appraoch; baseline measured against 20% random guess

4. 
skipped


5. how does simple 4-gram model work?
paper talks about simple vs smooth 4-gram

simple model; look at bi, tri and quad gram and assign points with word existed in either types; scoring approach in n-gram matches

smooth model; prob of word give previous workds; actual implementation, calculating product of probs; good turning smoothed.

6. 
skipped

7. latent sem analysis
simialr to dist sem methods
but coccured with the document, not another word
looks at target work with all other words in the sentence using lin alg
[TAKE BETTER NOTES OF THIS SLIDE AND PART IN PAPER, GOOD TO UNDERSDTAND FOR FUTURE]
semantic similarity method is jnust the same
other methods were only 4-grams, where as this method essentiall incorps while sent
therefore has more context in decision, thats why it likely had the highest score. 
specifically had later sentence context window

# Week 2 - Addtional Readings