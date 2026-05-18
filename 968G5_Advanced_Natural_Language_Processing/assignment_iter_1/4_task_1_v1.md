# 4. Methodology: Task 1 (Classification)
*Task 1 is a multi-class classification problem requiring the identification of one of 8 propaganda techniques (excluding not_propaganda from the 9) within a given snippet and its sentential context. To evaluate the relative importance of lexical choice versus linguistic structure, I implement a tiered lineage of models: starting with frequency-based baselines, progressing to semantic concept modeling (Word2Vec), and concluding with contextualized attention mechanisms (Transformers).*

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

*“To evaluate the true necessity of surrounding sentence structure, the Bag-of-Words and Word2Vec models are implemented across a staggered text constraint: (1) Snippet-Isolated, where the model evaluates only text inside the target boundaries, and (2) Unified Sequence, where the full sentence string is evaluated. This ablation experiment establishes an explicit empirical baseline for measuring whether contextual framing is structurally mandatory for classification or whether local lexical choices provide sufficient signal.”*

""To manage vocabulary sparsity and mitigate overfitting on low-frequency vocabulary tokens, singletons appearing only once in the training split were mapped to an explicit __UNK__ placeholder token. A distribution diagnostic on the resulting matrices revealed a distinct architectural signature: 82.3% of complete snippet-to-unk collapses occurred within micro-span categories (loaded_language and repetition)."


"While traditionally considered an information-loss penalty in semantic tasks, in the context of rhetorical identification, the __UNK__ feature column acts as an active stylistic pointer. It enables the linear classification head to map the presence of ultra-rare or highly case-specific vocabulary choices directly to localized propaganda categories, capturing an empirical signature of lexical abnormality without expanding feature dimensions."


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
>
> 
> Word2Vec is a sophisticated extension of the Pure Vocabulary route (BoW). If we see that it beats the uni-gram approach then we know that there is some value in these contexual vectors providing knowledge on similarity.


"In my Word2Vec baseline, I treat the snippet as a Bag-of-Embeddings. While Word2Vec vectors capture semantic similarity via the distributional hypothesis (the 'window' method used during pre-training), they remain static. This means the model cannot distinguish between different senses of a word or recognize how a specific 'abstract pairing' in a propaganda snippet changes the meaning of its constituent words. This limitation justifies the transition to Contextualized Embeddings (BERT/DeBERTa), which use self-attention to generate token representations that are aware of the unique, often irregular, structure of the input sentence."

*“While frameworks like Gensim support online vocabulary updates (update=True), a decision was made to freeze the pre-trained Google News Word2Vec weights and treat the model strictly as a static semantic dictionary. Fine-tuning dense embeddings on small specialized datasets with highly asymmetric term frequencies introduces Catastrophic Interference, warping the semantic spatial coordinates of pre-existing vectors and compromising their distributional integrity. Freezing the embeddings preserves a rigid, uncorrupted control variable for testing the Semantic Concept Hypothesis (H1).”*

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

- **Modern Baseline (Word2Vec/GloVe):** Move from words to "concepts" (Distributional Semantics).
- **High-Tech (Transformer + Interpretability):** Use the big model to see if the "contextual nuance" actually adds anything over the BoW approach.

> There needs to be something mentions about how transformers don't by definition understand order and therefore we need to add the position tokens. Here there will likely be a caveat with respect to the exact bert model chose

*“Standard encoder-based classifiers utilize the [CLS] token as a global, unweighted summary of the entire sentence string. For a localized task like span identification, global pooling dilutes the signal of the manipulative device by averaging it across neutral background text. Critically, because Transformer architectures employ all-to-all Self-Attention, the hidden states of the tokens inside the <BOS>/<EOS> boundaries have already attended to and encoded the contextual frame of the surrounding outer sentence. Therefore, Snippet-Specific Pooling extracts a highly concentrated representation of the propaganda device that remains fully context-aware, while completely bypassing the architectural smoothing weaknesses of a standard [CLS] token.”*


---


evolutionary line: Words (BoW) $\rightarrow$ Concepts (Word2Vec) $\rightarrow$ Contextualized Syntax (DeBERTa)

bidirectional encoder architecture over a generative decoder (like GPT). Propaganda detection is fundamentally a Natural Language Understanding (NLU) problem. Encoders compute simultaneous all-to-all self-attention maps across the entire text frame, allowing words at the end of a sentence to instantly contextualize a deceptive framing device at the beginning.

You will justify choosing DeBERTa over standard BERT based on how it models linguistic structure. Propaganda rarely relies on exotic vocabulary; it weaponizes ordinary words arranged in manipulative ways.

Standard BERT sums content and absolute position vectors at the input layer.

DeBERTa utilizes Disentangled Attention, calculating attention matrices by evaluating Content-to-Content, Content-to-Relative Position, and Relative Position-to-Content dependencies independently. This enables the model to identify subtle, non-standard structural shifts where an otherwise innocent word becomes malicious due to its precise placement in a clause.

reject the conventional [CLS] token strategy because it computes an unweighted global average of the entire sequence, severely diluting a highly localized 3-word propaganda trigger with 40 words of neutral background text.

ntroduce Snippet-Specific Pooling. Because every token inside the sequence continuously undergoes bidirectional attention, the hidden states of the tokens situated strictly between the <BOS> and <EOS> markers have already fully encoded the surrounding sentence’s ambient context. Extracting and mean-pooling only these target hidden states provides a concentrated, context-aware representation of the propaganda device itself.

since the Silver data replaces the snippet text while leaving the surrounding context sentences unchanged, could the model overfit to the repeated context? Your report will mathematically counter this concern using the nature of the Transformer: Self-attention tokens do not possess fixed values. Because the inner snippet tokens are dynamically altered by the LLM, the outer context tokens are forced to calculate entirely fresh attention weights and contextualized hidden states. The identical background string behaves like a completely distinct feature vector depending on what sits inside the span boundaries, turning a data limitation into an effective structural regularizer.

If DeBERTa is pre-trained on Wikipedia and Books, its baseline expectation for language is academic or narrative. By running intermediate Domain Adaptation on a news-based dataset, you adjust the model's internal weights to view journalistic writing as the "baseline normal." This makes it significantly easier for the model to spot the subtle, anomalous structural shifts that indicate propaganda later.

For this, I propose we use the Hugging Face datasets library to pull a standard dataset like ag_news (a massive corpus of categorized news articles) or a Fake News/Hyperpartisan News dataset.



---



"Unlike traditional token classification baselines which isolate sequence spans at the input layer, the transformer framework processes all configurations within their full context frames (Snippet + Context). This leverages the architecture's capacity for comprehensive self-attention. Critically, to preserve a clean focus on the target rhetorical device while discarding neutral background noise, a dynamic snippet-pooling layer scans the sequence hidden states on the fly, isolating and mean-pooling exclusively the vectors bounded within the custom tags for delivery to the classification head.

For synthetic data augmentations, the surrounding background context strings are held completely static while the inner span text is swapped for LLM-generated variants. Because the attention head representations are non-static and calculated dynamically based on the full sequence content, this dual layout forces the model to learn how identical environmental syntax responds to different rhetorical triggers, effectively acting as an implicit structural regularizer."

---

self.mlp_head: This is your "Fair Fight" classification head. It takes a 768-dimensional representation, squeezes it down to a dense 128-dimensional hidden layer, applies non-linear activation (ReLU) and regularization (Dropout), and maps it onto the 8 target propaganda classes.



In this step, the entire full-context sequence (left context, snippet, right context) goes through the Transformer encoder. Thanks to Self-Attention, every token dynamically reads every other token in the sentence.

Even though we will soon throw away the contextual tokens outside the bounds, their job is already done.

The tokens inside your propaganda snippet have effectively "absorbed" the grammatical and thematic meaning of the surrounding context sentence.

last_hidden_state is a massive 3D matrix containing a continuous 768-dimensional vector coordinate for every single token across every sequence in the mini-batch.

snippet_states now contains only the contextually enriched hidden vectors of the words inside your targeted propaganda segment.


`mean_centroid = snippet_states.mean(dim=0)` justify or explain that mean was used

Since propaganda snippets vary in length (some are 2 words, some are 15), the classification head requires a uniform input shape. This lines computes an element-wise mathematical average (mean) across the sequence dimension of snippet_states. This creates a single, highly dense 768-dimensional Semantic Centroid that perfectly summarizes the entire propaganda span.

CrossEntropyLoss compares the model's confidence scores against the real propaganda label integers (labels). Backpropagation calculates how much each mathematical weight in the network contributed to any errors made.

Gradient Clipping: When fine-tuning massive architectures like DeBERTa, gradients can sometimes exponentially spike ("exploding gradients") and completely ruin the pre-trained weights. This line clips any runaway mathematical forces to a threshold of 1.0, keeping training highly stable.

optimizer.step(): The AdamW optimizer uses the calculated error vectors to update DeBERTa's weights, making its adjustments based on the weight decay parameter (0.01) and your learning rate (2e-5).

Once the 4 epochs are complete, the model toggles to evaluation mode (model.eval()), which disables regularization elements like dropout so the network behaves deterministically. torch.no_grad() freezes the computational graph, preventing your system from saving gradient memory to dramatically accelerate execution.

Running a model for 4 epochs means that your training loop will make exactly four complete passes through your entire training dataset.

An epoch is not a single training step. Because language models are too large to digest an entire dataset at once, the dataset is broken down into small groups called batches (in your case, a batch size of 8).

1 Step (or Batch): The model processes 8 rows of text, calculates the classification loss, and updates its weights once.

1 Epoch: The model continuously processes these batches step-by-step until every single row of your dataset has been seen by the neural network exactly once.

4 Epochs: The model repeats this entire cycle 4 times.

Epoch 1 (Initial Exposure): The model's custom classification head starts with completely random weights. As it reads the data for the first time, its losses are high (around 2.10). The backpropagation algorithm makes drastic, sweeping adjustments to the weights as it aggressively tries to fix its massive mistakes.

Epoch 2 & 3 (Refinement): The model is seeing the exact same sentences it saw in Epoch 1, but order-shuffled. Because its weights are no longer random, it starts recognizing patterns (e.g., how the background text style shifts right after a <BOS> tag). The adjustments to the weights become smaller and more fine-tuned.

Epoch 4 (Convergence): By the final pass, the training loss should stabilize and flatten out. This indicates convergence—the model has learned as much as it possibly can from this specific data distribution without making further meaningful adjustments.

When fine-tuning large pre-trained transformers like DeBERTa, 4 is the industry-standard "sweet spot" for supervised downstream tasks. Choosing the number of epochs is a balancing act:

Too Few (e.g., 1 Epoch): The model is underfitted. It hasn't had enough exposure to the text patterns to reliably adjust its random classification weights, resulting in poor accuracy.

Too Many (e.g., 20 Epochs): The model becomes overfitted. Because it sees the exact same sentences over and over again, it stops learning the underlying concepts of propaganda and simply memorizes the exact phrasing of your training set. It will score 100% on training data, but fail miserably when tested on your human validation data.

The 4-Epoch Target: It provides just enough repetition for the weights to safely stabilize and generalize well to unseen text, without giving the model enough time to memorize the dataset word-for-word.

Because your weights are unfrozen, you are performing True Fine-Tuning rather than Feature Extraction.

Feature Extraction (Frozen Base)
If you had frozen the base model, DeBERTa would act purely as a static text-to-vector calculator. It would process the sentences using its generic domain-adapted weights, output a fixed mathematical embedding, and your training loop would only update the small mlp_head at the end.

True Fine-Tuning (Unfrozen Base)
Because everything is unfrozen, your model is executing Co-Adaptation. The classification head is learning how to categorize propaganda genres (e.g., Name_Calling vs. Slogans), while the underlying transformer layers are actively adjusting their self-attention matrices.

The base model is dynamically learning to shift its attention focus, deciding which specific context words are most indicative of rhetorical manipulation.



---


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