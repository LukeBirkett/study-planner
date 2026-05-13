

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