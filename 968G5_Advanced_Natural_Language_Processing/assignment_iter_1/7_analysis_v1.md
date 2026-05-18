## 7. Analysis and Discussion

### 7.1 Decoding the "Black Box" (XAI Comparison)
Use the interpretability tools you planned (Captum/LIME) to provide a "Feature Comparison". Use Integrated Gradients (Captum) and Attention Maps (BertViz) to compare what the BoW model "sees" versus the Transformer.
- **1D vs. 2D Importance:** Show a visualization where BoW highlights a single word (e.g., "radical") but the Transformer’s Attention Map highlights the relationship between that word and its target.
- **Validating Abstract Pairings:** Use this to prove the hypothesis that the "off-kilter" grammar of propaganda is what the Transformer is actually picking up on.

### 7.2 Perplexity as Linguistic Proof
Present the Perplexity results here.
- Compare the perplexity of propaganda snippets vs. standard text using a pre-trained model like GPT-2.
- **The Evidence:** Use high perplexity scores as empirical proof that propaganda deviates from "Standard English" norms, justifying your use of the more complex CNN-BiLSTM-CRF or Transformer architectures.

### 7.3 Error Analysis (Failure Modes)
Identify specific techniques (e.g., "Causal Simplification") where models failed and discuss the causes (e.g., data sparsity vs. lack of syntactic context).
- **Confusion Matrix Analysis:** Discuss why "Doubt" might be frequently confused with "Loaded Language".
- **Boundary Errors:** Analyze if the model failed on very short snippets (1-2 words) vs. long, complex spans.



---

---

### Perplexity as proof of hypothesis
At the start we introduced some hypotheses based on word use and structure. It appears that we may be able to Perplexity to justify these. Perplexity evaluates Language Models (NLG), not Classifiers (NLU). But we could use Perplexity as a diagnostic tool to unveil the theory that propaganda has "loss of strictly correct grammar" or "unusual word pairings."

1. Take a pre-trained language model (like GPT-2 or BERT’s masked likelihood).
2. Calculate the perplexity of the Propaganda Spans vs. the Non-Propaganda text. Or even words, bi-grams, tri-grams or sub-snippets. 
3. The Goal: If the hypothesis is correct, the "Standard English" model should have significantly higher perplexity on the propaganda snippets than on the normal sentences.

"To empirically test my hypothesis that propaganda is characterized by linguistic irregularities, I conducted a perplexity analysis using a pre-trained GPT-2 model. I found that the average perplexity for propaganda spans was 42% higher than for non-propaganda text. This higher 'surprise' factor suggests that the language used in these techniques deviates from standard syntactic norms, justifying my use of complex architectures like DeBERTa to capture these non-linear patterns."

---

### Task 1 Feature Comparison Analyis
I am not sure where this piece of work should go, also it may be an extra if I have time rather than a staple of the project. However, between MLP classification heads and transforers attention there exists a way to compare the methods with respect to the hypthothesis. We can use feature attribution and attention maps to identify which words were important. If both methods are light up the same words we know that hypothesis 1 is true to some extent but we may be able to use the attention map from task 2 to demonstrate that it is not enough. 

Since the BoW and Word2Vec models use an MLP Classification Head, we can use **Feature Attribution** to see which words "pushed" the model toward a specific label.

With an MLP, you can use Integrated Gradients (`Captum` library). This will tell is which word vectors in the "bag" contributed most to the final Softmax probability.

I think for this sort of analysis we need to scope down to the individual sentence though I am not 100% sure about this. it may be the case that we can aggregate over the whole corpus. 

`e.g., "The betrayal of our sovereignty is complete"`

The Baseline View (1D Importance):
- **BoW/Word2Vec Output:** Likely see high "heat" on the nouns: betrayal and sovereignty.
- **The Interpretation:** The model says: "I see two 'bad' words, so this is propaganda." It doesn't care that they are linked; it just sees the counts.

The Transformer View (2D Attention): 
- **Transformer Output:** Using an attention map (like BertViz), you can see not just that betrayal is important, but that the Attention Head for `loaded_language` is firing specifically on the relationship between betrayal and sovereignty.
- **The Interpretation:** The model says: "The fact that 'betrayal' is applied to 'sovereignty' is what makes this flag-waving or loaded language."

To get the best grade, use LIME or SHAP as the "bridge." These tools can be applied to any model (BoW, W2V, or Transformer).
1. Explain the BoW: "LIME shows that for the sentence X, the BoW model relies 90% on the single token 'traitor'."
2. Explain the Transformer: "LIME shows the Transformer also values 'traitor', but the Attention Map reveals that the model is actually attending to the lack of a modifier, confirming the 'abstract/lossy grammar' hypothesis."

"While the BoW and Word2Vec baselines successfully identified the 'trigger' tokens (confirming the lexical hypothesis), they were unable to capture the relational context. The Transformer's attention maps demonstrated that the classification was not merely triggered by the word 'American', but by its syntactic proximity to 'displacement' in a non-standard grammatical construct. This confirms that propaganda identification requires the modeling of intra-sequence relationships that 'bag' methods inherently discard."

**For the "Heatmaps":** Captum (for Integrated Gradients on all models).

**For the "Connections":** BertViz (to see the lines connecting words in the Transformer).

**For the "Global Importance":** ELI5 (excellent for showing which words a BoW model likes).

For the assignment, using these interpretability tools on the MLP-based Word2Vec and BoW models allows us to prove that even without "Attention," your simpler models are picking up on the same linguistic triggers as the Transformer.

**Feature Attribution: Integrated Gradients (The Gold Standard):** Integrated Gradients solves this by calculating the "integral of the gradients" along the path from a blank input (baseline) to your actual sentence. It assigns a "contribution score" to each input feature (the Word2Vec dimensions or BoW counts). You can aggregate these scores back to the word level. You get a heatmap that says: "Word X contributed 40% to the model's decision that this was 'Loaded Language'."

"To maintain experimental consistency, I utilized a 2-layer MLP as the classification head for all non-transformer baselines. This allowed me to directly compare the utility of Sparse Discrete features (BoW) against Dense Distributed features (Word2Vec) without the architectural bias of different learning algorithms.

There exists a clear bridge to the BoW Hypothesis through Transformer Interpretability (XAI). Use SHAP (SHapley Additive exPlanations) or LIME to generate "heatmaps" of which words the Transformer is "looking at" when it makes a prediction. You can then compare these heatmaps to your BoW results. If the Transformer's "important words" are the same as your BoW's "high-weight words," you’ve proven that propaganda is largely lexical. If the Transformer is looking at the connections between words (the attention heads), you’ve discovered where BoW fails. "Query, Key combinations for attention" Visualizing these attention scores is a direct application of that theory.

It is much easier to extract Attention Maps from BERT. You can literally print a grid showing how much the word "America" (in your example) is attending to the word "Great." This allows you to scientifically prove or disprove your hypothesis that propaganda is "abstract" or "irregular." Because GPT models are usually significantly larger and use "causal masking," interpreting the internal "logic" of a classification decision is far more mathematically opaque.

In the context of Transformers, "Heatmaps" generally refer to two distinct things: **Feature Attribution** (which words are important?) and **Attention Maps** (which words are talking to each other?). 

**Feature Maps (1D):** This visualizes a "score" for every single word in your propaganda snippet. A high score means that word was a major factor in the model choosing a specific label. **Tool:** Captum (specifically the IntegratedGradients or LayerIntegratedGradients method). Run the same snippet through your BoW (TF-IDF) model and your Transformer. Extract the top-weighted words from your BoW model (e.g., coefficients in Logistic Regression) and overlay them with the heatmap from the Transformer. If both models highlight the exact same "trigger" words (e.g., "radical", "freedom", "betrayal"), you have scientific evidence that your BoW hypothesis was correct: the model is primarily relying on lexical cues (specific words) rather than complex sentence structure.

**Attention Maps (2D Heatmap):** This is a grid that shows how much "attention" the model paid to the relationship between every pair of words. **Tool:** BertViz.Input a propaganda sentence where the grammar is "lossy" or the pairings are abstract (e.g., "America Great" vs "Make America Great Again"). Look for "strong lines" (high attention) between words that shouldn't normally be connected in standard English grammar. This is where you can outperform your BoW/Bi-gram model. While a Bi-gram BoW can only see words right next to each other, a Transformer can see an "unusual pairing" even if the words are at opposite ends of the sentence. If your heatmap shows a massive attention spike between two abstract concepts, you've identified a "propaganda feature" that BoW would be blind to.

TODO: ARE HEATMAPS A CUMULATIVE TOOL, I.E. WHOLE CORPUS, OR JUST PER UNIT BASIS?

Model-Agnostic Explanations: LIME & SHAP
These are "wrapper" methods that don't care how the model works internally. They treat the MLP as a black box but poke it repeatedly to see how it reacts.

LIME (Local Interpretable Model-agnostic Explanations): It takes your propaganda sentence, creates slight variations of it (by removing words), and sees how the MLP’s prediction changes. If removing "betrayal" causes the flag_waving probability to drop from 90% to 10%, LIME identifies "betrayal" as the critical feature.

SHAP (SHapley Additive exPlanations): Based on game theory, it fairly distributes the "credit" for a prediction among all the words in the sentence. It is mathematically very robust and great for academic papers.

Baseline (BoW + MLP): Use LIME to show that the model is "Trigger Happy"—it only looks at the word "soldiers."

Transformer: Use Attention Maps and LIME to show that the model looks at "soldiers" in relation to the verb "get out."

The Conclusion: "While the MLP is often viewed as a black box, feature attribution via LIME reveals that it relies primarily on isolated lexical cues. In contrast, the Transformer’s attention mechanism validates my hypothesis that propaganda is encoded in the syntactic relationship between words, a nuance the MLP-based baselines consistently overlooked."

Captum (Library): The best library for Integrated Gradients in PyTorch.

LIME / SHAP (Libraries): Very easy to use with scikit-learn or Keras models.

ELI5 (Explain Like I'm Five): A library specifically designed to show text importance heatmaps for black-box classifiers.

---

When training your model, keep in mind that the repetition label is often a "global" feature (repetition across texts) that is difficult to detect in a "local" context (a single sentence). If your assignment involves local sequence tagging, you might find that your model struggles with these instances unless you provide broader context or treat them as recurring "slogans." The other techniques like Loaded Language and Name Calling are much more localized and should be easier for a standard NLP model to identify.

---