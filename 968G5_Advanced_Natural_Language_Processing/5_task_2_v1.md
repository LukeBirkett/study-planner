# 5. Methodology: Task 2 (Span Identification)
*The methodology for Task 2 focuses on Sequence Labeling—assigning a tag to every token in a sentence to identify both the boundaries (the span) and the specific technique used. To explore this, I implement two variations based on the seminal Ma and Hovy (2016) architecture, evolving from a traditional recurrent approach to a modern transformer-based encoder.*

*Task 2 expands the problem space from classification to Sequence Labeling, requiring the joint identification of both the exact token boundaries (the span) and the propaganda technique used. To execute this, I adapted the foundational Ma and Hovy architecture into a modern BERT-CRF model. By replacing the traditional Bi-LSTM with a Transformer encoder, the model leverages Self-Attention for sequence encoding, while relying on a Conditional Random Field (CRF) to enforce structural logic over the predicted BIO (Beginning, Inside, Outside) tags.*

> 

## 5.1 The Foundational Architecture: Ma and Hovy (CNN-BiLSTM-CRF)
The primary variation is based on the "Ma and Hovy" architecture, designed for end-to-end sequence labeling. This model traditionally consists of three distinct layers:
1. **Character-level CNN:** Extracts morphological features (like prefixes, suffixes, or capitalization patterns), which are vital for identifying the "off-kilter" or irregular language hypothesized in H2.
2. **Bi-directional LSTM (Bi-LSTM):** Processes the sequence in both forward and backward directions, capturing the "flow" of the sentence and the "abstract pairings" that define propaganda.
3. **CRF Layer:** A Conditional Random Field (CRF) acts as the "decoder," using Global Normalization and the Viterbi algorithm to ensure the predicted BIO sequence is structurally valid (e.g., preventing an I-tag from following an O-tag).

This architecture is uniquely suited to our "soft boundary" problem. The Bi-LSTM identifies high-confidence signals in the "heart" of a propaganda snippet, while the CRF layer uses its learned Transition Matrix to "knit" those signals back to the ambiguous start and end points of the span.
> need to highlight that this is the basis of the Label Bias problem 

## 5.2 The Evolution: BERT-CRF Adaptation
To modernize this approach, I propose a second variation that replaces the Bi-LSTM with a Transformer encoder (BERT/DeBERTa) and simplifies the input pipeline by removing the character-level CNN.

Encoder Replacement: The Bi-LSTM is replaced by a pre-trained Transformer. Instead of recurrently passing hidden states, the model utilizes Self-Attention to allow every token to attend to every other token simultaneously, capturing long-range dependencies that a Bi-LSTM might "forget" in longer sentences.
> need to use the terms used in the lecture. i think it was something to do with vanishing or forgetting
> 
> mention that there are efficency gains also 

**Subword Synchronization:** Transformers use WordPiece or BPE tokenization, which often breaks a single word into multiple subword units. To maintain the word-level labeling required for BIO tagging, I only assign the propaganda label to the first subword of each original word, masking the subsequent subword units during the calculation of the loss.
> CNN would be overkill for this task as the text comes from News Sources meaning there is unlikely to be spellking mistkes
> 
> Spelling and word variations may still exist in terms of propagandists making up words (examples?), however, wordpeirce probably actually workds better for this because these made up words use componetns of existing and wordpiece will allow us to extract the underlying meaning
> 
> That being said, I was not away of this masking appraoch. Whilst it makes sense I am concered about loosing the endings of words in evaluation. It seems like in propaganda this might be important to uncovered linguistic irregularities. 

## 5.3 The Design Change Justifcation
> ma and hovy pre-dates transformers (2017)

While the Bi-LSTM-CRF is a robust baseline, the transition to a Transformer-CRF provides three significant advantages for propaganda detection:

1. **Global vs. Sequential Context:** Bi-LSTMs process text linearly, which can lead to a "fading signal" for long-distance relationships. Because propaganda often relies on an "abstract pairing" between a subject at the start of a sentence and a manipulative predicate at the end, the Self-Attention mechanism provides a more consistent signal across the entire span.

2. **Pre-trained Semantic Depth:** Unlike the Bi-LSTM, which must learn linguistic patterns from our limited 2.5k row dataset, the Transformer comes pre-equipped with a massive "worldview" from its pre-training on news and literature. This allows it to recognize the rhetorical texture of propaganda even when the specific vocabulary is sparse in our training set.

3. **Handling "Off-Kilter" Syntax:** Transformers are notoriously better at handling non-standard syntax. By disentangling content from position (as in DeBERTa), the model is better suited to identify the Structural Irregularities (H2)—the "lossy" or shorthand grammar—that characterizes political slogans and manipulative fragments.

## 5.4 Variation Methodologies

To systematically evaluate the interaction between boundary detection and technique classification, I designed two variations of this architecture representing the "Pipeline vs. Joint Learning" debate.

> In NLP research, this is often framed as the Pipeline vs. Joint Learning debate. By comparing these two, you aren't just building a model; you are conducting a structural experiment on how a model "perceives" propaganda. 
> 
> if there a reference for this naming convention

## 5.1 Variation 1: The Pipeline (Binary BIO + Classifier)
The first variation treats the task as a decoupled, two-step process.

**Step 1 (Span Detection):** The BERT-CRF is trained strictly as a binary boundary detector using a minimal 3-tag set (B-Propaganda, I-Propaganda, O). At this stage, the model is entirely "colorblind" to the specific rhetoric being used; its sole objective is to identify manipulative deviations from standard text.

**Step 2 (Classification):** Once the span is extracted, it is passed to the best-performing classification head from Task 1 (e.g., the DeBERTa model) to assign the specific technique label.

**Justification:** This approach benefits from high data density. Because all 8 propaganda techniques are collapsed into a single B or I class, the span detector has ample examples to learn general "off-kilter" linguistic patterns. However, it is fundamentally vulnerable to Error Propagation; if the binary detector misses the soft boundaries of a span, the classifier never receives the correct text to evaluate.

## 5.2 Variation 2: Integrated Multi-class BIO-CRF (Joint Model)
The second variation tests the hypothesis that knowing what the propaganda is helps the model determine where it is. This is achieved by expanding the tagset to an 18-class space (9 techniques $\times$ {B, I} + 1 'O' tag) (e.g., B-Loaded_Language, I-Loaded_Language).

Justification: By predicting the boundary and the technique simultaneously, the model utilizes Mutual Information. The specific linguistic "texture" of a technique (e.g., the stuttering nature of Repetition vs. the adjective-heavy nature of Loaded Language) acts as a unique signature that reinforces the boundary detection. While this risks data sparsity for rare classes, it prevents the generic "colorblind" predictions of the pipeline.

> the breadcrumb effect and the sub label bias problem solution should be spoken about here because it is unique to var 2

## 5.3 Theoretical Justification: CRFs, Viterbi, and Soft Boundaries
The superiority of the Integrated Approach (Variation 2) relies heavily on the mechanics of the CRF layer. 

A standard Transformer classification head utilizes Local Normalization (Softmax), making isolated decisions for each token. This leads to the Label Bias Problem, where a model might illegally predict an I-Loaded tag immediately following an O tag simply because the individual word looked highly propagandistic.

> while the neural network (Bi-LSTM or Transformer) gives the "raw signal" for each word, it is the CRF — and specifically the Viterbi Algorithm — that turns those individual guesses into a mathematically coherent span.
> 
> Note, the values coming out of the transformer model are the emissions scores ""Based on the text, I think word #3 is 80% likely to be 'I-Loaded_Language'."

The CRF resolves this through Global Normalization. Rather than scoring individual tokens, it calculates the probability of the entire tag sequence at once. It achieves this by combining the Emission Scores (the raw signal from the BERT encoder) with a learned Transition Matrix (the "rule-book" dictating that B-Loaded $\to$ I-Loaded is highly probable, but B-Loaded $\to$ I-Repetition is mathematically impossible). During inference, the Viterbi Algorithm navigates this matrix as a trellis to find the globally optimal, structurally coherent path.

> Instead of predicting if a word is propaganda in isolation, a CRF looks at the entire sequence of labels. It calculates the probability of the entire tag sequence at once. Propaganda spans are continuous. A CRF "knows" that a "Propaganda-Inside" tag cannot follow a "Not-Propaganda" tag without a "Propaganda-Beginning" tag first.

**The "Breadcrumb" Effect:** Manipulative language often "fades in," meaning the true signal lies in the middle of the snippet. In Variation 2, the BERT encoder might assign a low probability to the ambiguous start of a phrase, but a 90% probability to a highly charged word in the middle (e.g., an I-Loaded tag).

> var 1 can do this such a nuance way, it is forced to distribute its "breadcrumbs" across just 3 categories. if it is not sure then this coulbe as extreme as 33% for each tag making the job really difficult for the crf
> 
> If the Bi-LSTM is 99% sure the middle of a sentence is I-Loaded_Language, the Global Normalization training forces the model to find a way to "get into" and "get out of" that state legally. It effectively teaches the model to look for the Beginning (B-) and End of the "vibe" of the propaganda, rather than just identifying "bad words."

**The "Knit":** Because the Integrated model's transition matrix contains highly specific constraints for all 18 classes, the CRF acts as a backward-flowing magnet. It uses the Viterbi algorithm to mathematically "pull up" the probability of the ambiguous starting words, forcing them into the correct B-Loaded state because it is the only legal pathway to reach the high-confidence I-Loaded core.

> The CRF layer adds a Transition Matrix. This matrix learns that: B-Loaded $\rightarrow$ I-Loaded is very likely. O $\rightarrow$ I-Loaded is impossible ($P=0$). B-Loaded $\rightarrow$ B-NameCalling is impossible.
> 
> CRF is meant to learn the exaxct rules but the user can also specify zeros in the matrix for inpossible transitions
> 
> 2. The CRF layer has a matrix that says, "Regardless of the text, it is 0% likely that 'B-Doubt' follows 'B-Loaded_Language'.

In contrast, the Pipeline model lacks this dense probability distribution; predicting simple B and I tags leaves fewer specific "breadcrumbs" for the CRF to knit together, leaving it vulnerable to truncating the soft edges of complex rhetorical spans.

> I beleive the data enrichment based on pos and ner tags is a huge boost for crf and should discussed whereever the main crf justicivaiton is
> 
> **Feature Enrichment: POS and NER Tagging:** Propaganda spans often align with syntactic boundaries (like Noun Phrases). Adding POS tags to your Bi-LSTM-CRF helps the model learn that a span is likely to end after a noun or a punctuation mark, providing the "structural discipline" your notes mention.



> **Viterbi vs. Training:** It’s important to distinguish the Training Phase from the Prediction Phase: 
> - **Training:** We use the Forward Algorithm to calculate the probability of the entire correct sequence relative to all others. We update the weights so the correct sequence is the "winner."
> - **Prediction (Inference):** We use the Viterbi Algorithm to actually find that winner.


> **Why this supports your "Soft Boundaries" Hypothesis** Propaganda often "fades in." A sentence might start normally and slowly become manipulative. The Bi-LSTM (the "bottom" of your model) might struggle with these fading edges. The CRF (the "top" of your model) uses the "Breadcrumbs" left by the Integrated tags to say: "I know the heart of this is definitely 'Appeal to Fear,' so mathematically, the 'fade-in' words must be the beginning of that specific fear-span."

---