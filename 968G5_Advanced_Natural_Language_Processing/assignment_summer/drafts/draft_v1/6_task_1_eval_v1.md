# 6. Results and Evaluation
To rigorously test the Lexical Trigger (H1) and Structural Irregularity (H2) hypotheses, the evaluation framework moves beyond generic accuracy metrics. It is designed to penalize models that overfit to majority classes and to strictly evaluate the structural boundary logic of the sequence labelers.

> Again we haven't confirm that there are majority classes yet, though there probably is. 

## 6.1 Evaluation Framework and Metrics

**Task 1 (Classification):** As identified in the EDA, the dataset exhibits severe class imbalance. Consequently, Macro-Average F1 is utilized as the primary metric, forcing the model to be evaluated as a "specialist" across all 9 categories rather than allowing the dominant Loaded Language class to inflate the score. While Micro-F1 (mathematically identical to Accuracy in single-label multi-class setups) is reported for context, it provides a false sense of security and is not the primary indicator of model robustness. Furthermore, Confusion Matrices are generated to diagnose inter-class bleeding (e.g., confusing Name Calling with Loaded Language).

> imbalance unknown yet
> 
> F1 as the main metric. need a way to knit together micro or macro
>
> Def need to present in individual class metrics as this can also be carried over into into analysis
>
> No mention of precision vs recall here, why not?

**Task 2 (Detection & Classification):** Span identification is inherently subjective; even human annotators achieve a relatively low $\gamma$ (Gamma) agreement of approximately 0.6 on exact span boundaries. To account for this "soft boundary" nature, I implement a Partial Match F1-Score (Da San Martino et al., 2020).

> shouldnt this just be "detection" not both

**Task 2 Joint Score Logic & Matching:** To evaluate the strict requirement of identifying both the span and the technique, a Joint Metric was implemented. A predicted span ($S_p$) is only compared to a ground truth span ($S_t$) if they have a token overlap greater than zero. If an overlap exists, the technique label acts as a strict on/off switch: if the predicted technique is incorrect, the match score is 0, regardless of boundary precision.

> i dont like this approach
> 
> replace the overlap >0 with a threshold
> 
> and then make the switch just a percentage, i.e. is 0.7% match then 1 * 0.7 if correct and 0 if not. 
> 
> could play around with some function to make the % more exetrme, i.e. sigmoid to push the extreme values. i.e. benefit good and penalize bad. theres probably some functions suited exactly for this. 

**Task 2 Diagnostic Split:** To isolate errors, I also decoupled the evaluation into Span-Only F1 (treating all propaganda as a single binary class to evaluate detection capability) and Label-Only F1 (evaluating classification accuracy only on correctly identified spans).

> this is written weirdly. but whislt the main goal is span and classifcation and therefore a joint metric is good. it is important to look at the results of the two tasks independedntly
> 
> Again F1 is the main score but need to present down on a task level too
> 
> will need to convert the var 2 seq label into a label for this stuff. 

---

## 6.2 Task 1 Results: The Lexical vs. Semantic Battle
> Note: Insert Results Table here comparing BoW, Bi-gram, Word2Vec, and Transforme

*The progression of baseline models provided clear empirical insights into the nature of the dataset.*

*Example Template Evaluations* 

> The Lexical Sieve: The Unigram-BoW baseline performed surprisingly well on specific classes like Loaded Language, confirming the Lexical Trigger Hypothesis (H1) that certain forms of propaganda rely heavily on a static vocabulary of emotionally charged nouns and adjectives.
> 
> Semantic vs. Structural Phrasing: The transition to a Bag-of-Embeddings (Word2Vec) approach tested the Distributional Hypothesis—the idea that semantic similarity could improve recall over sparse lexical matches. However, when comparing Word2Vec to the Bi-gram BoW model, [Insert observation: e.g., the Bi-gram model yielded higher precision]. This suggests that "Local Phrasing" and syntax order hold a stronger rhetorical signal than broad semantic concepts, supporting the Structural Irregularity Hypothesis (H2).
> 
> Contextual Supremacy: The DeBERTa Transformer significantly outperformed all "bag" approaches, confirming that resolving the meaning of a snippet requires deep, bidirectional contextual awareness rather than isolated token features.

---

## 6.3 Task 2 Results: Pipeline vs. Integrated Architectures

> Note: Insert Results Table here showing Span F1, Label F1, and Joint Partial-Match F1 for Variation 1 and Variation 2

Evaluating the two variations of the BERT-CRF architecture highlighted the fundamental differences between pipeline and joint-learning paradigms.

**Template Answers**

> Variation 1 (Binary Pipeline): The decoupled approach proved to be an effective "spotter" but a poor "labeler." By reporting the Span Detection F1 separately, it is evident that the binary BIO-CRF successfully identified irregular textual deviations. However, due to Error Propagation, the downstream classifier frequently failed because the binary detector truncated the necessary sentential context.
> 
> Variation 2 (Integrated Multi-class BIO-CRF): Expanding the tagset to include the specific technique (e.g., B-Loaded_Language) provided the model with a dense, class-specific probability distribution. This approach successfully mitigated the Label Bias Problem associated with local token decisions.
> 
> The "Knit" Effect: The superiority of Variation 2 on the Joint Partial-Match F1 score demonstrates the power of Global Normalization. By predicting the boundary and technique simultaneously, the CRF's transition matrix utilized the specific "breadcrumbs" of a technique's signature (e.g., the high-confidence core of a manipulative phrase) to mathematically "pull" and knit the soft boundaries into place via the Viterbi algorithm. This confirms that knowing what the propaganda is inherently helps the model discover where it begins and ends.

---
