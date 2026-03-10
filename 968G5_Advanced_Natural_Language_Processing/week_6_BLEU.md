# BLEU: a Method for Automatic Evaluation of Machine Translation

Kishore Papineni, Salim Roukos, Todd Ward, and Wei-Jing Zhu

# Abstract

**Human evaluations of machine translation are extensive but expensive**

Human evaluations can take months to finish and involve human labor **that can not be reused.**

We propose a method of automatic machine translation evaluation that is quick, inexpensive, and language-independent, that correlates highly with human evaluation, and that has little marginal cost per run.

We present this method as an automated understudy to skilled human judges which substitutes for them when there is need for quick or frequent evaluations.
* The idea here is that you can make tweak to your system or model and see the impacts in real-time. 

# 1. Introduction

## Rationale

Human evaluations of machine translation (MT) weigh many aspects of translation, including adequacy, fidelity , and fluency of the translation (Hovy,
1999; White and O’Connell, 1994). 

A comprehensive catalog of MT evaluation techniques and their rich literature is given by Reeder (2001). For the most part, these various human evaluation approaches are quite expensive (Hovy, 1999).

Moreover, they can take weeks or months to finish. This is a big problem because developers of machine translation systems need to monitor the effect of daily changes to their systems in order to weed out bad ideas from good ideas

## Viewpoint

How does one measure translation performance? **The closer a machine translation is to a professional human translation, the better it is.**

MT evaluation
system requires two ingredients:
1. a numerical “translation closeness” metric
2. a corpus of good quality human reference translations

We fashion our closeness metric after the highly successful word error rate metric used by the speech recognition community, appropriately modified for multiple reference translations and allowing for legitimate differences in word choice and word order.

The main idea is to use a weighted average of variable length phrase matches against the reference translations. 

# 2. The Baseline BLEU Metric

Typically, there are many “perfect” translations of a given source sentence. These translations may vary in word choice or in word order even when they use the same words. And yet humans can clearly distinguish a good translation from a bad one. 

It is clear that a program can rank Candidate 1 higher than Candidate 2 simply by comparing n-gram matches between each candidate translation and the reference translations.

The primary programming task for a BLEU implementor is to compare n-grams of the candidate with the n-grams of the reference translation and count the number of matches. 

These matches are position independent. The more the matches, the better the candidate translation is. 

## 2.1 Modified n-gram precision

The cornerstone of our metric is the familiar precision measure.

To compute precision, one simply counts up the number of candidate translation words (unigrams) which occur in any reference translation and then divides by the total number of words in the candidate translation.

In laymans, total correct predicted words over total predicted words. 

Unfortunately, MT systems can overgenerate “reasonable” words, resulting in improbable, but high-precision, translations
like that of example 2 below.

Candidate: `the the the the the the the.`
Reference 1: `The cat is on the mat.`
Reference 2: `There is a cat on the mat.`
Modified Unigram Precision = `2/7`.
- The unmodified precision would be `7/7`

Intuitively the problem is clear: a reference word should be considered exhausted after a matching candidate word is identified. 

**We formalize this intuition as the modified unigram precision.**

To compute this, one first counts the maximum number of times a word occurs in any single reference translation. Next, one clips the total count of each candidate word by its maximum reference count, adds these clipped counts up, and divides by the total (unclipped) number of candidate words.

$$\frac{\sum_{w \in \text{Candidate}} \text{Count}_{clip}(w)}{\text{Total words in Candidate}}$$

Similarly, the modified unigram precision in Example 2 is 2/7, even though its standard unigram precision is 7/7.

Modified n-gram precision is computed similarly for any `n`: all candidate n-gram counts and their corresponding maximum reference counts are collected. 

The candidate counts are clipped by their corresponding reference maximum value, summed, and divided by the total number of candidate n-grams. 

In Example 2, the (implausible) candidate achieves a modified bigram precision of 0. 

---

**Gemini Notes:**

The reason Example 2 achieves a bigram precision of $0$ is that precision in BLEU is calculated based on n-grams (sequences of $n$ words), not just individual words (unigrams).

Unigram precision (1-gram) measures adequacy (did we get the right words?). In your example, unigram precision would be $> 0$ because "the" is a match.

Bigram/Trigram/4-gram precision measures fluency (do the words follow each other in a way that makes sense?).

In the context of the BLEU score, $n$ typically ranges from 1 to 4.

The final BLEU score isn't just one number; it is the geometric mean of the modified precisions for unigrams ($n=1$), bigrams ($n=2$), trigrams ($n=3$), and 4-grams ($n=4$).

---

This sort of modified n-gram precision scoring captures two aspects of translation: adequacy and fluency. A translation using the same words (1-grams) as in the references tends to satisfy adequacy. The longer n-gram matches account for fluency

## 2.1.1 Modified n-gram precision on blocks of text

How do we compute modified n-gram precision on a multi-sentence test set?

Although one typically evaluates MT systems on a corpus of entire documents, our basic unit of evaluation is the sentence.

A source sentence may translate to many target sentences, in which case we abuse terminology and refer to the corresponding target sentences as a “sentence.”

We first compute the n-gram matches sentence by sentence.

Next, we add the clipped n-gram counts for all the candidate sentences and divide by the number of candidate n-grams in the test corpus to compute a modified precision score, pn, for the entire test corpus.

$$p_n = \frac{\sum_{C \in \{Candidates\}} \sum_{n\text{-}gram \in C} Count_{clip}(n\text{-}gram)}{\sum_{C' \in \{Candidates\}} \sum_{n\text{-}gram' \in C'} Count(n\text{-}gram')}.$$

## 2.1.2 Ranking systems using only modified n-gram precision

The strong signal differentiating human (high precision) from machine (low precision) is striking. The difference becomes stronger as we go from unigram precision to 4-gram precision. It appears that any single n-gram precision score can distinguish between a good translation and a bad translation. 

To be useful, however, the metric must also reliably distinguish between translations that do not differ so greatly in quality

Furthermore, it must distinguish between two human translations of differing quality.

This latter requirement ensures the continued validity of the metric as MT approaches human translation quality.

To this end, we obtained a human translation by someone lacking native proficiency in both the source (Chinese) and the target language (English).

For comparison, we acquired human translations of the same documents by a native English speaker

We also obtained machine translations by three commercial systems. 

These five “systems” — two humans and three machines — are scored against two reference professional human translations.

The average modified n-gram precision results are shown in Figure 2.

Each of these n-gram statistics implies the same ranking: H2 (Human-2) is better than H1 (Human1), and there is a big drop in quality between H1 and S3 (Machine/System-3). S3 appears better than S2 which in turn appears better than S1. Remarkably, this is the same rank order assigned to these “systems” by human judges, as we discuss later.

**While there seems to be ample signal in any single n-gram precision, it is more robust to combine all these signals into a single number metric.**

## 2.1.3 Combining the modified n-gram precisions

How should we combine the modified precisions for the various n-gram sizes?

A weighted linear average of the modified precisions resulted in encouraging results for the 5 systems.

However, as can be seen in Figure 2, the modified n-gram precision decays roughly exponentially with n: the modified unigram precision is much larger than the modified bigram precision which in turn is much bigger than the modified trigram precision. 

A reasonable averaging scheme must take this exponential decay into account; a weighted average of the logarithm of modified precisions satisifies this requirement.
* The precison for unigrams is huge and falls exponentially with each n+1-gram. This means a simple average we be dominated by the unigram. 

BLEU uses the average logarithm with uniform weights, which is equivalent to using the geometric mean of the modified n-gram precisions.

The geometric average is harsh if any of the modified precisions vanish, but this should be an extremely rare event in test corpora of reasonable size (for Nmax ≤ 4).

Experimentally, we obtain the best correlation with monolingual human judgments using a maximum n-gram
order of 4, although 3-grams and 5-grams give comparable results.

Using the geometric average also yields slightly stronger correlation with human judgments than our best results using an arithmetic average.

## 2.2 Sentence length

A candidate translation should be neither too long nor too short, and an evaluation metric should enforce this.
    * **This initution must be an issue when translating between iso and (other?) types of languages**

To some extent, the n-gram precision already accomplishes this. 

N-gram precision penalizes spurious words in the candidate that do not appear in any of the reference translations. 

Additionally, modified precision is penalized if a word occurs more frequently in a candidate translation than
its maximum reference count.

This rewards using a word as many times as warranted and penalizes using a word more times than it occurs in any of the references.

However, modified n-gram precision
alone fails to enforce the proper translation length. 

---

#### Example 3: of the 
Candidate: `of the`

Reference 1: `It is a guide to action that ensures that the military will forever heed Party commands.`

Reference 2: `It is the guiding principle which guarantees the military forces always being under the command of the Party.`

Reference 3:`It is the practical guide forthe army always to heed the directions of the party.`

Because this candidate is so short compared to
the proper length, one expects to find inflated precisions: the modified unigram precision is 2/2, and
the modified bigram precision is 1/1.

---

## 2.2.1 The trouble with recall

Traditionally, precision has been paired with
recall to overcome such length-related problems

However, BLEU considers multiple reference translations, each of which may use a different word
choice to translate the same source word.

Furthermore, a good candidate translation will only use (recall) one of these possible choices, but not all.

Indeed, recalling all choices leads to a bad translation.

---

Example 4:

Candidate 1: `I always invariably perpetually do.`
Candidate 2: `I always do.`
Reference 1: `I always do.`
Reference 2: `I invariably do.`
Reference 3: `I perpetually do.`


The first candidate recalls more words from the
references, but is obviously a poorer translation than
the second candidate.

Thus, na¨ıve recall computed
over the set of all reference words is not a good
measure.
---

## 2.2.2 Sentence brevity penalty

Candidate translations longer than their references are already penalized by the modified n-gram precision measure: there is no need to penalize them again. 

Consequently, we introduce a multiplicative brevity penalty factor

With this brevity penalty in place, a high-scoring candidate translation must now match the reference translations in length (brev penalty), in word choice (unigram), and in word order (n-grams).

Note that neither this brevity penalty nor the modified n-gram precision length effect directly considers the source length; instead, they consider the range of reference translation lengths in the target language.

We wish to make the brevity penalty 1.0 when the
candidate’s length is the same as any reference translation’s length

For example, if there are three references with lengths 12, 15, and 17 words and the candidate translation is a terse 12 words, we want the brevity penalty to be 1. We call the closest reference sentence length the “best match length.”

One consideration remains: if we computed the
brevity penalty sentence by sentence and averaged
the penalties, then length deviations on short sentences would be punished harshly. 

Instead, we compute the brevity penalty over the entire corpus to allow some freedom at the sentence level.

We first compute the test corpus’ effective reference length, r, by summing the best match lengths for each candidate sentence in the corpus. 

We choose the brevity penalty to be a decaying exponential in r/c, where c is the total length of the candidate translation corpus

## 2.3 BLEU details

We take the geometric mean of the test corpus’
modified precision scores and then multiply the result by an exponential brevity penalty factor

We first compute the geometric average of the
modified n-gram precisions, p_n, using n-grams up to
length N and positive weights w_n summing to one.

Next, let c be the length of the candidate translation and r be the effective reference corpus length.
We compute the brevity penalty BP,

$$\text{BP} = \begin{cases} 
1 & \text{if } c > r \\
e^{(1-r/c)} & \text{if } c \leq r 
\end{cases}$$

Then, 

$$\text{BLEU} = \text{BP} \cdot \exp \left( \sum_{n=1}^{N} w_n \log p_n \right)$$

* $c$: The total length of the candidate translation corpus.
* $r$: The effective reference corpus length.
* $N$: Usually 4 (meaning we look at up to 4-grams).
* $w_n$: Weights for each n-gram (usually $1/N$).
* $p_n$: The modified n-gram precision we calculated earlier.

The ranking behavior is more immediately apparent
in the log domain, 

$$\log \text{BLEU} = \min\left(1 - \frac{r}{c}, 0\right) + \sum_{n=1}^{N} w_n \log p_n.$$

In our baseline, we use N = 4 and uniform weights
wn = 1/N.

# The BLEU Evaluation

The BLEU metric ranges from 0 to 1. 

Few translations will attain a score of 1 unless they are identical to a reference translation.
* even a human translator will not necessarily score 1

It is important to note that the more reference translations per sentence there are, the higher the score
is. 
* having more references makes the "test" easier for the machine to pass.
* Recall the Modified n-gram Precision formula, when you have multiple references, you are taking the maximum count of an n-gram across all of them.
* If Reference A has the word "the" once, but Reference B has it twice, the candidate is now allowed to use 8 "the" twice without being penalized.
* the more references you add, the larger the "pool" of valid words and phrases becomes, increasing the mathematical likelihood of a match.
* Or there is the Lexical Variation approach: With one reference, the machine is punished for any stylistic choice that doesn't match that specific human's style. With multiple references, the machine is rewarded for matching any of the valid human styles.

Thus, one must be cautious making even “rough”
comparisons on evaluations with different numbers
of reference translations: on a test corpus of about
500 sentences (40 general news stories), a human
translator scored 0.3468 against four references and
scored 0.2571 against two references.

This outcome suggests that we
may use a big test corpus with a single reference translation, provided that the translations are not all
from the same translator.

## 4 The Human Evaluation

We had two groups of human judges

The first
group, called the monolingual group, consisted of 10
native speakers of English.

The second group, called
the bilingual group, consisted of 10 native speakers
of Chinese who had lived in the United States for
the past several years.

The humans judged
our 5 standard systems on a Chinese sentence subset extracted at random from our 500 sentence test
corpus

We paired each source sentence with each
of its 5 translations, for a total of 250 pairs of Chinese source and English translations. 

They rated
each translation from 1 (very bad) to 5 (very good).

The monolingual group made their judgments based
only on the translations’ readability and fluency.

As must be expected, some judges were more liberal than others. And some sentences were easier
to translate than others. To account for the intrinsic difference between judges and the sentences, we
compared each judge’s rating for a sentence across
systems. We performed four pairwise t-test comparisons between adjacent systems as ordered by their
aggregate average score.

## 4.1 Monolingual group pairwise judgments

## 4.2 Bilingual group pairwise judgments


# BLEU vs The Human Evaluation

Figure 5 shows a linear regression of the monolingual group scores as a function of the BLEU score
over two reference translations for the 5 systems.
The high correlation coefficient of 0.99 indicates
that BLEU tracks human judgment well. Particularly
interesting is how well BLEU distinguishes between
S2 and S3 which are quite close. Figure 6 shows
the comparable regression results for the bilingual
group. The correlation coefficient is 0.96.

# 6 Conclusion

Our belief is reinforced
by a recent statistical analysis of BLEU’s correlation with human judgment for translation into English from four quite different languages (Arabic,
Chinese, French, Spanish) representing 3 different
language families (Papineni et al., 2002)!

BLEU’s
strength is that it correlates highly with human judgments by averaging out individual sentence judgment errors over a test corpus rather than attempting
to divine the exact human judgment for every sentence: quantity leads to quality.