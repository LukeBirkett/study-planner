# Exploiting Cloze Questions for Few Shot Text Classification and Natural Language Inference
*Schick and Schütze (2021)*

This paper represents a paradigm shift in how we approach the "generalist vs. specialist" tension in NLP. By proving both mathematically and empirically that explicit task descriptions — delivered via **Cloze questions** — can bridge the chasm between zero-shot prompting and traditional supervised fine-tuning, the authors have provided a roadmap for high-performance NLP in data-scarce environments. Schick and Schütze demonstrate that we don't need to choose between the raw reasoning power of a massive pre-trained model and the precision of a task-specific classifier; PET allows us to seamlessly combine the innate, hidden knowledge of the former with the rigour of the latter.

What makes this paper particularly enduring is its grounding in "messy engineering reality." It acknowledges that while deep-pocketed researchers might have millions of labeled examples, the average practitioner is often working with a "shoestring" budget of maybe 50 human-annotated samples. By utilizing abundant, cheap unlabeled data through an elegant **Auxiliary Loss** mechanism, PET solves the problem of **Catastrophic Forgetting** without requiring specialized hardware or massive budgets. In a modern context, if you were faced with thousands of unread customer service tickets and only an afternoon to label a handful, the PET/iPET loop remains a "practical lightweight weapon" to bootstrap a highly accurate classifier by maximizing the return on every single human annotation.

As we move from the era of **Encoder-only models** (like BERT) toward the **Generative era** (like GPT and T5), this paper serves as a vital bridge. Structurally, it takes the rigid, internal-representation architecture of BERT and forces it to behave like a generative, prompt-driven model. It suggests that the boundary between "understanding" text and "generating" text is far more illusory than we previously thought. Ultimately, PET poses a profound philosophical question: when we fine-tune these models, are we actually teaching them anything new, or are we simply designing better "psychological tests" to unlock the latent, hidden knowledge they already acquired by reading the entire internet?

---


1. [The Core Problem: The "Signal-to-Noise" Crisis](#1-the-core-problem-the-signal-to-noise-crisis)
2. [The PET Solution: PVPs (Pattern-Verbalizer Pairs)](#2-the-pet-solution-pvps-pattern-verbalizer-pairs)
3. [The Math: "Restricted Softmax"](#3-the-math-restricted-softmax)
    * [How does the math work during training?](#how-does-the-math-work-during-training)
4. [Solving "Catastrophic Forgetting": The Auxiliary Loss](#4-solving-catastrophic-forgetting-the-auxiliary-loss)
    * [The Vulnerability of Few-Shot Updates](#the-vulnerability-of-few-shot-updates)
    * [The "Anchor" Mechanism](#the-anchor-mechanism)
    * [Balancing the Scales with Alpha ($\alpha$)](#balancing-the-scales-with-alpha-)
5. [iPET: The "Bootstrap" Loop](#5-ipet-the-bootstrap-loop)
    * [How we utilize the Unlabeled Data](#how-we-utilize-the-unlabeled-data)
    * [The 3-Step "Teacher-Student" Methodology](#the-3-step-teacher-student-methodology)
        1. [Step 1: The Teacher Ensemble](#step-1-the-teacher-ensemble)
        2. [Step 2: Confident Labeling (Knowledge Distillation)](#step-2-confident-labeling-knowledge-distillation)
        3. [Step 3: Training the Student Classifier](#step-3-training-the-student-classifier)
    * [Why the Iteration? (The iPET "Generations")](#why-the-iteration-the-ipet-generations)
        * [iPET fixes this through Generational Learning:](#ipet-fixes-this-through-generational-learning)
        * [PET vs. iPET](#pet-vs-ipet)
6. [The "Dark Knowledge" (Temperature)](#6-the-dark-knowledge-temperature)
    * [What is Dark Knowledge?](#what-is-dark-knowledge)
    * [The Role of Temperature ($T$)](#the-role-of-temperature-)
    * [Why this matters for PET:](#why-this-matters-for-pet)

---

## 1. The Core Problem: The "Signal-to-Noise" Crisis
**Transfer Learning** generally implies there is a plethora of data to learn from but what happens when we are faced with a labelled training dataset of say only 10 instances. 

In Few-shot Learning (10–50 examples), standard supervised fine-tuning is inherently flawed. When you bolt a randomly initialized linear layer onto the <CLS> token of a pre-trained model, you create a "stochastic barrier."

> **Few-shot Learning** means trying to get a model to generalize to unseen data using small amount of labeled examples

The issue is that the weights in that new layer start as **random noise**. With only 10 examples, the gradient signal from 10 examples is too weak to tune the random noise of a new classification head. The model spends all its energy trying to understand the new layer rather than the actual task. 

**The Pizza Review Example:** Imagine a 2-sentence training set:
* **T1:** "This was the best pizza I’ve ever had" $\rightarrow$ Positive
* **T2:** "You can get better sushi for half the price" $\rightarrow$ Negative

**The Under-specified Hypothesis Space:** Without a task description, the model is "lost." It doesn't know if the task is about Food Quality or Value for Money. When it encounters T3 ("The pizza was average. Not worth the price"), the gradients from T1 and T2 pull the weights in opposite directions. The model overfits to specific keywords rather than the underlying intent.

---

## 2. The PET Solution: PVPs (Pattern-Verbalizer Pairs)
This is where the paper introduces its core mechanism, the "cloze" question. Or in NLP terms, masked language modelling. 

BERT is optimized for filling in blanks. The authors of the paper asked a simple questions: "instead of forcing the model to learn a new mathematical mapping to an arbitary label space from scratch, why don't we just reformat our classification task to look exactly like the pre-training task"

The paper introduces **PET** which bypasses the "bolt-on" layer by using the Masked Language Model (MLM) head already present in the pre-trained model. This allows us to "tell" the model the task through Linguistic Archeology. Additionally, removing the classifcation head means there are no freshly initalized weights to optimize. 

There are two parts to this approach the **The Pattern ($P$)** and **The Verbalizer ($V$)**.

The Pattern ($P$) is the "Syntactic Scaffolding." It transforms the input into a **Cloze task**, with the input being a sequence/sentence. 

> "The sushi was overpriced." $\rightarrow$ Pattern: "It was [MASK]."

The Verbalizer ($V$) is the mapping function. It maps your abstract labels (0 or 1) to real vocab words (terrible or great). The Verbalizer must be Injective (one-to-one). Each label must have a unique word to avoid ambiguous signals.

> Positive $\rightarrow$ "great"; Negative $\rightarrow$ "terrible"

---

## 3. The Math: "Restricted Softmax"
Standard MLM considers all 50,000+ words in a vocabulary. PET utilizes a Restricted Softmax that "slices" the logit vector to ignore everything except the words defined in the Verbalizer.

By forcing the model to distribute 100% of its probability mass among the task-relevant labels, the loss calculation becomes extremely stable. This effectively "narrows" the model's focus, making it a specialist without needing thousands of examples.

#### How does the math work during training? 
Once the masked input (e.g., "The food was [MASK]." ) is fed into the model, the following mathematical pipeline occurs:

1. **Transformer Processing:** The sequence passes through the standard Transformer layers (Self-Attention and Feed-Forward), resulting in a contextualized hidden state for every token.
2. **Mask Extraction:** We isolate the hidden state vector ($h_{mask}$) specifically for the position of the [MASK]. The vectors for all other words are discarded.
3. **Vocabulary Projection:** The vector $h_{mask}$ is multiplied by the pre-trained MLM weights to project it across the entire vocabulary. This produces a massive vector of unnormalized logits ($z$)—typically 50,000+ values.
4. **Verbalizer Slicing:** Instead of applying Softmax to the whole vector, we perform a lookup for the indices of our Verbalizer words (e.g., the indices for "great" and "terrible"). We "slice" the logit vector to extract only these specific values.
    * The 12 or 24 layers of the Transformer are the Body. Their only job is to take raw text and turn it into a high-dimensional mathematical summary (the hidden state vector $h_{mask}$, which is usually 768 or 1024 dimensions).
    * The MLM Head is a final, single linear layer that sits on top of that body. It consists of a massive matrix of weights that were learned during pre-training.
    * When we say we "project" $h_{mask}$ across the vocabulary, we are doing a single matrix multiplication between the The Hidden Vector and Weight Matrix which produces a 1x50,000 vector of Logits.
5. **Restricted Softmax:** We apply the Softmax function only to these selected logits.
    * **The Math: **$P(v) = \frac{\exp(z_v)}{\sum_{v' \in V} \exp(z_{v'})}$
    * This ensures the model’s "attention" is locked exclusively onto the valid labels ($V$), ignoring the "noise" of the other 49,998 words in the dictionary.
6. **Loss Calculation:** We compare this restricted distribution to the **Ground Truth** (the actual label) using **Cross-Entropy Loss**.
    * If the review was 5-stars, the "target" is a one-hot vector where "great" = 1.0.
    * The model then uses backpropagation to update the weights of the entire Transformer based on how well it guessed "great" within that tiny restricted set.

---

## 4. Solving "Catastrophic Forgetting": The Auxiliary Loss
During the training phase, PET initially utilizes standard Cross-Entropy Loss ($Loss_{Task}$). We compare the model’s restricted softmax distribution against the "ground truth" provided by our 10 labeled examples. Mathematically, this is a Negative Log-Likelihood calculation: we take the log of the probability the model assigned to the correct verbalizer (e.g., "terrible"), multiply it by 1, and backpropagate that error to update the Transformer's weights. While this works for the task at hand, it immediately encounters the "brick wall" of Catastrophic Forgetting.

#### The Vulnerability of Few-Shot Updates
When a generalist model like RoBERTa-Large (350M parameters) is updated using a tiny dataset, the gradient updates become dangerously concentrated. The model effectively "warps" its latent space to satisfy the specific syntactic quirks of those 10 sentences, overwriting the vast, expensive linguistic knowledge it gained during pre-training. To prevent this "shattering" of the model’s internal logic, the authors leverage the reality of the data environment: while labeled data is scarce, unlabeled data from the same domain is usually abundant.

#### The "Anchor" Mechanism
PET introduces an Auxiliary Language Modeling Loss ($L_{MLM}$) which acts as a mathematical anchor to the pre-trained state. The total loss becomes a weighted sum:

$$Loss = Loss_{Task} + (\alpha \cdot Loss_{MLM})$$

While the model learns the specialist task, it is simultaneously forced to perform standard Masked Language Modeling on unlabeled sequences. It might seem that forcing the model to predict generic words like "the" or "restaurant" would dilute the fine-tuning, but this is intentional. The auxiliary task acts as a regularization term, creating "friction" against the specialist gradients. This friction ensures that the model adapts to the new task without destroying the multi-dimensional geometric balance that makes it a good general reasoner.

#### Balancing the Scales with Alpha ($\alpha$)
The relationship between these two losses is managed by the hyperparameter $\alpha$.

* If $\alpha = 1$, the model stays in a pre-training state and never learns the new task.
* If $\alpha = 0$, the model suffers catastrophic forgetting.

The authors found the "sweet spot" at a remarkably small value: $10^{-4}$. Even at this tiny scale, the auxiliary loss significantly impacts the gradients. This is because $L_{MLM}$ is computed across the entire 50,000-word vocabulary, making its raw numerical magnitude much larger than the $Loss_{Task}$, which is restricted to just a few verbalizer words. The small alpha scales the language model loss down so that it doesn't overwhelm the task-specific learning, but remains "heavy" enough to keep the model’s general language abilities "warm."

--- 

## 5. iPET: The "Bootstrap" Loop
The "Iterative" part of PET (iPET) is designed to solve a fundamental human problem: Pattern Uncertainty. When we design a Cloze prompt, we don't know which specific wording will resonate best with the model's internal latent space. Instead of gambling on one "perfect" pattern, iPET uses an ensemble to "rehabilitate" weak patterns through generational learning.

#### How we utilize the Unlabeled Data
A common question is whether we "pattern mask" the unlabeled data used for the auxiliary loss. The answer is yes: the unlabeled sentences are passed through the same PVP templates as the labeled data. However, the model is never asked to predict the label mask in these instances.
* **The Process:** We mask random words in the surrounding context (e.g., "the," "restaurant") and ask the model to predict those.
* **The Goal:** This reinforces the **structural syntax** of the pattern in the model's "mind" without providing it with biased labels. It keeps the model's general language skills sharp within the specific context of the task template.

### The 3-Step "Teacher-Student" Methodology
Since 10 examples are too few for a reliable validation set, the authors use **Knowledge Distillation** to move from an ensemble of "Teachers" to a single, efficient "Student."

#### Step 1: The Teacher Ensemble
We train several distinct models, each using a different PVP (Pattern-Verbalizer Pair). We don't know which pattern is best, so we let each model develop its own "perspective" on the task using the tiny labeled dataset.

#### Step 2: Confident Labeling (Knowledge Distillation)
The ensemble is unleashed on a massive unlabeled dataset. Each model in the ensemble "votes" on the labels for these millions of sentences.
* **Soft Labels:** We average the normalized scores to produce "soft labels" (probability distributions rather than 1/0 counts).
* **The Synthetic Dataset:** This effectively transforms a pile of raw text into a massive, silver-standard training set.

#### Step 3: Training the Student Classifier
Finally, we throw away the Cloze patterns and the PVPs entirely. We train a standard **BERT Sequence Classifier** (with a head bolted onto the `<CLS>` token) on the massive synthetic dataset.

**Why this step?** PET/Prompting is slow at inference because you have to process the extra "scaffolding" tokens. A standard classifier is fast, simple, and takes advantage of the "data efficiency" of prompting while retaining the "inference speed" of traditional supervised models.

### Why the Iteration? (The iPET "Generations")
The danger in Step 2 is **Pollution**. If a human designs 5 patterns and 3 of them are "garbage" (misaligned with the model), those 3 models will produce inaccurate labels, dragging down the average and poisoning the student's training data.

#### iPET fixes this through Generational Learning:
Rather than jumping straight to the final classifier, we expand the training set in discrete stages.

1. **Generation 1:** The initial ensemble labels a random subset of the unlabeled data. However, we only "keep" the examples where the models agree with **extreme confidence**.
2. **Expansion:** These new, high-confidence examples are added to the original 10-sentence pool (often quintupling the size of the training set).
3. **Generation 2:** A new ensemble is trained on this larger pool. Even the "awkward" patterns now have enough data to learn how to map their syntax to the correct labels.
4. **Zero-Shot Bootstrapping:** Remarkably, iPET can start with zero labeled examples. Generation 0 simply uses the pre-trained model's innate logic to find the first few "confident" labels in the unlabeled pool, effectively bootstrapping a specialist classifier from pure general knowledge.

### PET vs. iPET
* **PET:** One-shot distillation. You trust your patterns are good and train the student immediately.
* **iPET:** Multi-stage distillation. You assume your patterns might be bad and use the model's own confidence to "self-correct" and grow the training data before the final distillation.

--- 

## 6. The "Dark Knowledge" (Temperature)
In a standard neural network, the final layer is a **Softmax** that usually produces a very "peaky" distribution. If a model is 99.9% sure a review is "Positive," it will output a 1.0 for that label and effectively `0.0` for all others. This is a **Hard Label**.

#### What is Dark Knowledge?
The term "Dark Knowledge" (Geoffrey Hinton, 2015) refers to the rich information hidden in the **relative probabilities** of the incorrect classes.

**Example:** Imagine a model classifies an image of a Labrador.
* It gives "Labrador" 90%.
* It gives "Golden Retriever" 9%.
* It gives "Car" 1%.

A **Hard Label** (1.0 for Labrador) tells the student model: "This is a dog." 

The **Soft Label** (the 9%) tells the student: "This is a dog, and it looks a lot more like a Golden Retriever than it looks like a Car." This "similarity" between classes is the Dark Knowledge. It reveals the underlying structure of the semantic space that the model has learned.

#### The Role of Temperature ($T$)
During the distillation step in PET, we don't want the ensemble to just give the student model the "right" answer. We want it to share its nuances. We use **Temperature Scaling** to "thaw" the distribution.

In the Softmax formula, we divide the raw scores (logits) by $T$ before exponentiating:

$P_i = \frac{\exp(z_i / T)}{\sum_{j} \exp(z_j / T)}$

* When $T = 1$: You get the standard, confident Softmax.
* When $T > 1$: You "soften" the curve. The absolute differences between the scores shrink.

By setting $T > 1$, the ensemble’s output for a "Great" review might shift from a "Hard" `[0.99, 0.01]` to a "Soft" `[0.80, 0.20]`. That `0.20` is the "Dark Knowledge" being handed to the student. It forces the final classifier to learn not just the correct label, but the **linguistic boundaries** between labels.

> What conceptually is a soft label? To start a hard label is a one-hot vector, its is not ambiguous it is X. A soft label is a continious probability distribution. the ensemble averages the diserve outputs of the pattern models meanign the output looks somehting like 80% A, 10% B, 10% C. a hard label destroy naunces, a soft label preserves it

#### Why this matters for PET:
In the iPET loop, different patterns might focus on different nuances of the text. By averaging these "softened" distributions, the final classifier inherits the collective "wisdom" and uncertainty of all the teacher models, making it far more robust than if it had just been trained on 10 hard-labeled sentences.

---