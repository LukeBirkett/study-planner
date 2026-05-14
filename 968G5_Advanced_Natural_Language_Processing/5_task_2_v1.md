# 5. Methodology: Task 2 (Span Identification)
*The methodology for Task 2 focuses on Sequence Labeling—assigning a tag to every token in a sentence to identify both the boundaries (the span) and the specific technique used. To explore this, I implement two variations based on the seminal Ma and Hovy (2016) architecture, evolving from a traditional recurrent approach to a modern transformer-based encoder.*

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

x