# Advanced Natural Language Proccessing Notes (Spring 26)

This is the main file for the Advanced Natural Language Proccessing module taken in Spring 26. It will act as the location for note taking accross all mediums, i.e. lectures, videos, labs and additional readings, as well as a directory for file locations. It will be recorded chronologically with a section for each week. 

**TODO:** introduction to the module

**TODO:** details of main text book

**TODO:** details of virtual env

# Table of Contents
1. [Week 1 - Lexical and Distributional Semantics Revisited](#week-1---lexical-and-distributional-semantics-revisited)
2. [Week 2 - Language Modelling w/ N-grams]()
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

[TODO: Lecture Slides (1 File)]()

[Lecture Part 1](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=c7d2751c-0820-4e87-8b8d-acb400db8436&start=1.23467)

**TODO:** Watch and Notes

[Lecture Part 2](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=15631590-2d19-4dcd-98bf-acb400db95f6&start=0)

**TODO:** Watch and Notes


## Week 1 - Lab

Lab exercises are based on the previous weeks lecture and seminar content.  Week 1 falls before any seminar hence is a self-assessment excercise to work out our starting level using prior knowledge.

* [Self-Assesment PDF](files/week_1/lab/how_good_is_your_python.pdf)
* [Notebook Attempt](968G5_Advanced_Natural_Language_Processing/files/week_1/lab/week_1_lab.ipynb)
* [Lab Solutions](files/week_1/solutions)

This is a self-assessment exercise, designed to help you prepare for the Advanced Natural Language Processingmodule.  If you find any of the questions tricky, then  there are many resources to help you: Python textbooks, online documentation and other resources, the module discussion forum. 
 
1. Write a python program to take a text file and output the number of lines, words  and characters in the file. 
2. What assumptions do you make about the text? 
3. Can you write the program so that it can be run from the command line?  And so that you can give the name of the text file to be processed on the command line? 
4. Can you extend your code so that you can find the average length of a word? 
5. Can you extend your code so that you can find the most frequently occurring letter? 
6. Can you extend your code so that you can display a bar graph showing the frequency  distribution of letters in the text file? 


## Week 1 - Seminar 

* [Seminar Session](#week-1---seminar-session)
* [Seminar Reading](#week-1---seminar-session)

### Week 1 - Seminar Session 

This seminar session was a mix of mild lecturing before breaking out into small groups to discuss questions. After which as a whole class we would put forward answers. In this section I will put down the questions and some notes for the answers. 

[Seminar Questions](files/week_1/week_1_seminar_questions.pdf) **TODO:** break out into this file

[TODO: SEMINAR SLIDES TO COME AFTER SESSION]

[1000 docs, tagged, how to build classifer to assign correct label]
preprocessing
words and sense
naive bayes, freqs, probs, words [slide]
nb featue vector, i.e. all words w/ probs in vector form
(confirm usage of feature vector)
nb is the trad approach, not that modern

[towards more intelligent nlp]
word tokes = atomtic bulding of nlp
but bow or even sequence misses human language underdstanding
senses, meanings = lexical semantics
meaning inferringt through relations with other words and similarity to words

[lecture overview, 2 parts]
lexical semantics
distributional semantics
[TODO: full breakdown]

[1.1 questions]

lexical ambiguity, word w/ different sense [1.1.1]
homonymn; broad distinctions; plant
polysemy; fine-grained book

lexical variation; synonm, same meanings/sense [1.1.2]

wordnet
synset = senses
synset has synonyms in it
hypo and hype connects synsets; parent, child

similarity measure; path length, equation, edge weight 1, IC, probability, frequency

lcs; lowest common

section 1.2 
other questions

Q1 What is distribuitonal hypo; word defined by company around it, context, windows, vectors

Q2, dist sems in other applications, doc class, didnt see document in new application, use dis sem to compar similarities, us simialr docs label, has a good chance of being right, [1.2.2 Better Notes]

Q3, Q4 asso measure, similar measure, difference, related headache and paracet, similar are words that mean the same thing or close

assoc measured using freqs -> PMI, how rare pairs are, info grain by seeing together, common = not much info, PMI eqaution (actually the modern method is to us vectors and LinAlg, slide says can use the assoc measures in cosine sim) (create density vector where each space is a word with a measurement, i.e. PMI) use the vectors to establish similarity between documents

### Week 1 - Seminar Reading

The paper to read for this seminar is [Information Content Measures of Semantic Similarity Perform Better Without Sense Tagged Text (2010) by Ted Pedersen](files/week_1/week_1_seminar_paper.pdf). Here is a [link](https://notebooklm.google.com/notebook/b58e8c39-3a30-40a0-86c5-1c6db77ef489) to the NotebookLM which I created to help study this paper. 

As humans we can read a piece of text, understand and assign meaning to it. Given this, we can also determine how similar words and thier meanings are, this is known as **semantic similarity**. This research paper investigates different methods of calculating semantic similarity and how they compare to human intuition - which human intuition being the gold standard metric we want to work towards. 

The author demonstrates that Information Content measures perform significantly better when they are derived from large amounts of unannotated text rather than smaller, manually sense-tagged corpora. This because the raw data is larger in size and therefore has a wider coverage of concepts within the WordNet hierarchy. This allows the system to more accurately quantify how specific for general a term is. The studies findings suggest that the expensive and labor intensive process of hand-labelling data is unnecessary for improving linguistic algorithms. The conclusions is that enabling a system with a greater volume of (untagged) data is the primary driver of success in these computational models because it allows more senses/words to be counted leading to a more informed outcomes. The belief prior to this paper was that high-quality semantic analysis requires costly, human-tagged data - this is known as the "expensive assumption" in natural language processing. 

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

#### <u> [Chapter 5 of Jurafsky and Martin](files/week_1/week_1_add_read_vector_semantics_chapter_5.pdf) </u>

sections 5.1-5 4 

**TODO:** Read and notes

#### <u> [Lecture 3 of Jurafsky and Martin](files/week_1/week_1_add_read_vector_semantics_lecture_3.pdf) </u>

**TODO:** Read and notes






# Week 2


# Week 2 Lecture

# Lecture 1

Prev; lexical and distribution semantics
* semantic rels
* WordNet
* distrub hypoth; words that mean similar things tend to be used in similar things. This is important for vector representations and spaces as similarly used words with produce similar vectors and therefore there meaning and context can be infered to understand lexical similarity. 
* the importatance/challenge of sparsity and zipds law
* dimenstion reduction 
* word embeddings

This week we are looking at **Probabilitic Language Models**

- n-gram modelling (the start)
- evals and perplexit
- generation 
-generalaiseatiyon

[why do we want to be ablw to assign a prob to a sentence]
starting desire came from machine translation

desire to assign prob to a sentence

translate sequence of tokens from source lange to other lang 

need high prob in target lang but corrent to orginal lang meaning

might be alternative translations for a sentence 

i.e. high winds > large winds

both are semnaticlly correct, but we as english speakers more often use high. prob tells us this

this notion of probs also applies to spelling corrections

given prase with 1 word spelt different. maybe wrong but still a correct word. over enough data probbility would show us that the correct word would have higher instances of usage

P(minute) > P(minute)

This concept is very easy to think about with speec recognition. Computer can parse sounds into words but we have many words, sounds and phrases that sound the same but mean something different. Often merely contructing sounds may prodcue an unintelligible sentence. The probability of a the real worded setnence will show up more way higher from a real corpus of text

P(I saw a van) > P(eyes awe of an)

This was the motivation for early language modelling

[Probability language modelling]

what is a prob language model

has goal of compouting 1 of 2 things:

compute prob of sent of serq of words [include notion]

or comp prob of an upcoming word [include notation]:
prob of x given we have seen seq

either then called lang mod

[chain rule for probs]
UPPACK ALL NOTION ON SLIDES AND ADD REFRESH NOTES

bayes > rearrange to get relationship between sequence and condition prob of subs and prior event > extend to may variables in a chain (seq) > general case notion 

[apply the chain rule to words]
UNPACK NOTATION, left to right, see word and then prob given we saw the previous word

compute and you get a prob for the entire seq/sent

[estimating probs]
where can we give probs from?

can we use whole previous seqs and the prior probs?

i..e is P("hill"|"then we hiovered over the")

the same as 

freq("then he hovered over the hill) / freq("then he hovered over the")

^ this would be the definntion of cond probs, previous over possible new occurance (this is a proportion of times based on what we have already seen)

this whole process is v difficult due to sparsity.

that exactly prev sentence is going ot be tiny even given an entire large courpus. This issue because worse the large the prior sentence and results will be unreliable

many sentences will have never been seen

[markov assumptions]
to fix sparisty, in n-grams we use Markov Assumptions

options

first order MA: assume approx Probs. look as the 1 previous state to proxy the seq: p(hill\then he hovered over the hill) is the same as ~ p(hill|the)

assump is independance

all prev context is held in the

we know this isnt true but is is a simple assump that allow us to calc some sort of prob

second order: 2 prev words (seq) p(hill|over the)

[n-gram lang model]

INCLUDE NOTATION

because assumption uses product of n-words because of indep assumption

each word only considered the prev n-1 words to compute the prob

n-gram; n is the number of orders considered

approx of compents in the product

the approxs can be estimated using Max Likelihod istimation on a training courpus

INCLUDE NOTION

still quire exposed to sparsity

[unigram model]
dont look at any previous words, words and probs are all indept

INCLUDE NOTION

product prob of each words prob

very simplebut gives an estimate

good for a baseline to compare against

[bigrm]
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




# Week 2 Seminar

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
