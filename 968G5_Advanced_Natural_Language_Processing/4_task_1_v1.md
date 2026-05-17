# 4. Methodology: Task 1 (Classification)
*Task 1 is a multi-class classification problem requiring the identification of one of nine propaganda techniques (including not_propaganda) within a given snippet and its sentential context. To evaluate the relative importance of lexical choice versus linguistic structure, I implement a tiered lineage of models: starting with frequency-based baselines, progressing to semantic concept modeling (Word2Vec), and concluding with contextualized attention mechanisms (Transformers).*

> reword and check labels
> 
> make clear that the two different models travel down opposing philsophyical nlp routes
>
> Word2Vec is vocab and simiarity focused hence pertains to basline 1
>
> Transformers is linguistic structure based hence pertains to baseline 2

---

## 4.1 Baselines: Pure Vocabulary and Local Phrasing
*To establish a "non-intelligent" benchmark, I implement both Random Guessing and Majority Class baselines. These provide a lower-bound metric, ensuring that the primary models are learning meaningful patterns rather than exploiting class imbalances in the training set.*

### Baseline 1: Unigram-BoW (Pure Vocabulary)
*This approach treats the snippet and its context as an unordered collection of words. By using Frequency Counts to represent sparse vectors, this model tests the Lexical Trigger Hypothesis (H1)—that propaganda can be identified simply by the presence of specific emotionally charged words regardless of their arrangement.*

> tests H1 in its strictest form possible. there are otherways to test or prove H1 but this would be most extreme

> pure classical classifcation baseline

> snippet and then snippet + context
 
> Could stagger the baseline as snippet vs snippet and context as well. this might highlist some issues with the approach and sparsity early on. 

---

## 4.2 Approach 1: Bag-of-Embeddings (Word2Vec)
*The first primary approach advances from atomic word units to Distributed Semantics using a Bag-of-Embeddings method. I utilize pre-trained Google News Word2Vec embeddings to leverage general-world knowledge of semantic similarity.*

**Mechanism:** For every word in the propaganda snippet, the corresponding 300-dimensional dense vector is retrieved. These are combined into a single sequence representation using Additive Composition (Mean Pooling) to find the semantic centroid of the snippet.

> The standard approach for Word2Vec is to pick up a pre-trained model such as Google News Word2Vec.
> 
> This is because it takes billions of words to train a model where as our corpus is too small to generate anything meaningful from scratch.

> There is an approach to fine-tuning W2V that could be exploreed. In Python (using the `Gensim` library), this involves loading the model, calling `build_vocab` with `update=True`, and then running the train method on your new data.

**Justification (The "Fair Fight"):** To isolate the impact of the embedding variable, I utilize the exact same MLP architecture (Linear -> ReLU -> Dropout -> Softmax) used in the BoW baselines. By keeping the classification head constant, I can definitively attribute performance gains to the "semantic density" and "lexical flexibility" of the embeddings rather than architectural bias.

> clarify that this is a vocabulary based approach utilising the added power of semanity similarity. 
> 
> it is possible that this could be a negative as the strictest form of H1 says the words are the power and w2v allows similar words to be treated the same way
> 
> There is not understanding of synatic structure. whislt w2v is trained on a window, this is to provide context on the word through its neighbours (include distributional hypotheis)
> 
> word2vec only has one vector per word hence any inference through neighbour based syntax is average out
> 
> because of this a decision was made not to pre-train a word2vec meaning the corpus is essentially only used as a mapping tool for this approach. You treat the model as a static dictionary.
>
> NEED TO ACTUALLY UNDERSTAND THE COMPLETIXITY OF FINE-TUNING WORD2VEC. IF IT CAN BE FINE-TINED ON THE DATA THAT WILL LATER BE USED AS SUPERVISED TRAINING THEN WHY NOT. 
>
> DOESNT MAKE SENSE TO FINETUNE ON THE EXTERNAL DATASET AS THIS IS ALREADY A NEW W2V. ALTHOUGH ALSO PROBABLY NO HARM
> 
> w2c is a dense vector as oppose to the bow sparse vector. need to explain why this is a good thing and justify it as a design choise
> 
> An embedding approach will lower the potential for overfitting compared to BoW which a sprase vector whereby high dimension values are prone to overfitting. Word2Vec creates a dense vector (usually 300) which forces the model to generalize across a smaller, more meaningful feature set, which acts as a form of implicit regularization.
> 
> justify Word2Vec as a way to fix the primary weakness of the "Pure Vocabulary" approach: **Lexical Sparsity**. By using a "Bag-of-Embeddings," you are testing the hypothesis that **Semantic Concepts** are the true signal for propaganda, not specific strings of characters. Word2Vec is "vocabulary-plus"—it’s the same "no-structure" approach but with a built-in thesaurus derived from millions of other documents.

**Hypothesis Goal:** This model tests whether "Semantic Clusters" (concepts) are more predictive than exact character-string matches, potentially improving Recall by recognizing synonyms of known propaganda triggers.

> The Word2Vec should improve the models Recall. This is because a BoW is hypersensitive to key words. If it sees a unseen word or synonym it cannot identify that as the same sentiment. Higher recall means it caputure for of the progaganda that exists. However, it may produce lower Precision if there are examples where a specific word in a specific context is the propaganda itself, meaning a synonymn is incorrect. 
>
> method approachs the vocab path of baseline 1
>
> By comparing two both baselines we can begin peel back the layers of what makes a propaganda classifier work and build up a techical picture
>
>**Comparison 1 (Bi-gram vs. Unigram):** If Bi-grams perform better, you have proven that propaganda isn't just about words, it's about phrasing and structure.
>
> **Comparison 2 (Bi-gram vs. Word2Vec):** This is the most interesting. Bi-grams have order but no semantic flexibility. Word2Vec has semantic flexibility but no order. If **Bi-grams win:** Structure is more important than synonyms for this task. **If Word2Vec wins:** Vocabulary breadth is the dominant signal.
> 
> Word2Vec is a sophisticated extension of the Pure Vocabulary route (BoW). If we see that it beats the uni-gram approach then we know that there is some value in these contexual vectors providing knowledge on similarity. However, if it fails to beat the Bi-gram BoW we know that structure is the more pressing matter. 


"In my Word2Vec baseline, I treat the snippet as a Bag-of-Embeddings. While Word2Vec vectors capture semantic similarity via the distributional hypothesis (the 'window' method used during pre-training), they remain static. This means the model cannot distinguish between different senses of a word or recognize how a specific 'abstract pairing' in a propaganda snippet changes the meaning of its constituent words. This limitation justifies the transition to Contextualized Embeddings (BERT/DeBERTa), which use self-attention to generate token representations that are aware of the unique, often irregular, structure of the input sentence."

---

## 4.3 Approach 2: Transformer Architecture (DeBERTa)
The final approach utilizes a Transformer-based model to resolve the meaning of snippets through Self-Attention. While BERT serves as a bidirectional foundation, I opted for DeBERTa (Decoding-enhanced BERT with disentangled attention) due to its superior ability to separate word content from relative position, which I hypothesize is vital for identifying non-standard rhetorical constructs.

> A transformer based model is the gold standard for sequence classifcation utilizing deep contextualized embeddings and that do account for word order.
> 
> need scope in a explain why attention and self-attention mechanisms are important and the philisophic path from which baseline 2 exteneds
> 
> with propaganda we are looking are normal words (most of the time) used in weird and less conventional ways. by attending to other words, or in some cases simply lacking the standard words to attend toit, the model should be able to indentify divergences from regular use of langauge
>
> Trasformers make use of **transfer learning** and pre-trained model.
> 
> A decision will need to be made on whether to **freeze or fine-tune** the base models weights. 
> Again, a classifcation head will be added to do the predicition this should be a MLP for consistency. 

> > DeBERTa (Decoding-enhanced BERT with disentangled attention). It is a more advanced version of BERT that separates the "content" of a word from its "relative position."
> 
> Need to explain why this is good for progaganda. it probbably related to H2 and the abstract usage of language

*Sequence Representation: Unlike standard BERT which relies on the [CLS] summary token, I implement Snippet-Specific Pooling. I extract the hidden states specifically for tokens located between the <BOS> and <EOS> markers and pass their average to the classification head. This ensures the model focuses on the manipulative text while the attention mechanism maintains awareness of the surrounding sentential context.*

> i dont need the other tokens because the attention has already attended to them and taken them into account.
> 
> also, are the outer tokens less valable? i.e. some do not have left and right context (or as much) as they are near the edge of the snippet. is there a reference to back this up?
> 
> What are the cons of CLS in this particular example?
> 
> What are the benefits of tokens in the parciualr exmaple?

*Encoding vs. Generation: I justify the use of an Encoder (NLU) model over a Decoder (NLG/GPT) because propaganda detection is a "Natural Language Understanding" task. Encoders are specifically designed to create rich, bidirectional mathematical representations of static text, whereas Decoders are optimized for left-to-right token prediction.
*
> need a good way to bring to up. might seem a bit random to bring up something i am not doing. possibly write about transfers and attention and then open up this piece of disccusion. 
> 
> Every token can "attend" to every other token in the sequence simultaneously. Propaganda often relies on contextual framing. A word might seem innocent until you reach the end of the sentence and see the "target" it is attacking, hence, giving BERT the architectural advantage.

- **Baseline (BoW/Bi-grams):** Establish your hypothesis. "I suspect lexical choices are the primary signal."
- **Modern Baseline (Word2Vec/GloVe):** Move from words to "concepts" (Distributional Semantics).
- **High-Tech (Transformer + Interpretability):** Use the big model to see if the "contextual nuance" actually adds anything over the BoW approach.

> There needs to be something mentions about how transformers don't by definition understand order and therefore we need to add the position tokens. Here there will likely be a caveat with respect to the exact bert model chose

## 4.4 Hyper-parameter Configuration
To ensure reproducibility and fair comparison, the following hyper-parameters were established. Settings for the MLP heads were standardized, while the DeBERTa model underwent a grid search for optimal fine-tuning rates.

| Parameter | BoW Baselines | Word2Vec (Approach 1) | DeBERTa (Approach 2) |
| :--- | :--- | :--- | :--- |
| Input Dim | Vocab Size (~5k) | 300 (Dense) | 768 (Hidden State) |
| Hidden Layers | 1 (128 units) | 1 (128 units) | Standard Transformer Head |
| Dropout | 0.2 | 0.2 | 0.1 |
| Learning Rate | 1e-3 (Adam) | 1e-3 (Adam) | 2e-5 (AdamW) |
| Epochs | 20 | 20 | 4 (Fine-tuned) |

Because the MLP is fixed througout for constistency, it seems to outlined here. and why. 

---