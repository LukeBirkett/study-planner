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

