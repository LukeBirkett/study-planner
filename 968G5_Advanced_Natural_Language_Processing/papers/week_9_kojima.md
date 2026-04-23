# Large Language Models are Zero-Shot Reasoners
*Kojima et al (2022)*

---

The paper **"Large Language Models are Zero-Shot Reasoners"** by Kojima et al. (2022) introduced a simple yet revolutionary discovery in the field of prompt engineering: the **Zero-Shot Chain-of-Thought (Zero-shot-CoT)**.

Prior to this work, it was widely believed that getting a Large Language Model (LLM) to perform complex multi-step reasoning required providing **several manual examples** of "showing your work" **(Few-Shot CoT)**.

Kojima and his team demonstrated that LLMs are actually "latent" reasoners that can be triggered without any examples. By simply appending the magic prompt "Let’s think step by step" to a question, the model's performance on arithmetic, symbolic, and logical reasoning tasks increased significantly — sometimes jumping from near - random accuracy to matching or exceeding sophisticated few-shot methods.

The importance of this paper lies in its revelation of the **"Stochastic Scratchpad"** effect within the model’s generation process. The authors argue that by forcing the model to generate its **reasoning path** before its final answer, the model uses its own output tokens as an external memory or "reasoning bridge." This bridges the gap between the initial question and a complex conclusion that would be mathematically impossible for the model to "calculate" in a single step. This discovery fundamentally shifted the industry's focus toward Instruction Tuning and proved that LLMs possess powerful reasoning capabilities that can be "unlocked" with a single, universal phrase, rather than requiring labor-intensive, human-written examples.

> For clarity, **Zero-shot-CoT** is still a two step process, it is not merely a prompt append/prepend. There is a **Reasoning Extraction** phase which is where the magic phrase is joined `[Question] + "Let's think step by step:`. Here the model should give an answer that generates a sequence of sentences explaining the logic. This is the "Reasoning Path" (the Chain of Thought). Then there is the **Answer Extraction**. The reasoning long-form generally can't be used as the "answer" because it either just explains the logic or the answer is tucked away in the text. To get the final "clean" answer, we perform a second pass: `[Question] + [Reasoning Path from Stage 1] + [Answer Extraction Phrase]`. Typically we use something like "Therefore, the answer (numeric) is". The model, now looking at the original question AND its own reasoning, simply predicts the final tokens 

---

* [Abstract](#abstract)
    * [CoT Tackles System 2](#cot-tackles-system-2)
    * [LLMs From Few-Shot to Zero-Shot](#llms-from-few-shot-to-zero-shot)
    * [Examples of System 2 Evaluation Benchmarks](#examples-of-system-2-evaluation-benchmarks)
    * [Zero Shot is Versatile](#zero-shot-is-versatile)
* [1. Introduction](#1-introduction)
    * [Scaling Size of Language Models](#scaling-size-of-language-models)
    * [In-Context Learning](#in-context-learning)
    * [Prompting](#prompting)
        * [The "Systematizers" (Survey & Theory)](#the-systematizers-survey--theory)
        * [The "Manual Craftsmen" (Hand-Designed Prompts)](#the-manual-craftsmen-hand-designed-prompts)
        * [The "Automators" (Algorithmic Prompt Search)](#the-automators-algorithmic-prompt-search)
    * [Chain of Thought for System 2](#chain-of-thought-for-system-2)
    * [CoT Reasoning Path](#cot-reasoning-path)
    * [Reasoning Scales with Model Size](#reasoning-scales-with-model-size)
    * [The Papers Zero-Shot Reasoning Approach](#the-papers-zero-shot-reasoning-approach)
    * [Zero-Shot CoT vs Zero-Shot Prompt](#zero-shot-cot-vs-zero-shot-prompt)
    * [Reasoning Benchmarks](#reasoning-benchmarks)
    * [Arithmetic Reasoning (Math Word Problems)](#arithmetic-reasoning-math-word-problems)
    * [Logical & Symbolic Reasoning (Tracking & Algorithms)](#logical--symbolic-reasoning-tracking--algorithms)
    * [Few-shot-CoT > Zero-shot-CoT > Zero-Shot Baseline (Prompt)](#few-shot-cot--zero-shot-cot--zero-shot-baseline-prompt)
    * [Zero Shot Scaling Curve](#zero-shot-scaling-curve)
* [2. Background](#2-background)
    * [Large language models and prompting](#large-language-models-and-prompting)
        * [From "Pre-train and Fine-Tune" to "Pre-Train and Prompt" Era](#from-pre-train-and-fine-tune-to-pre-train-and-prompt-era)
        * [Few vs Zero Distinction](#few-vs-zero-distinction)
    * [Chain of Thought Prompting](#chain-of-thought-prompting)
* [3. Zero-shot Chain of Thought](#3-zero-shot-chain-of-thought)
    * [Difference from the Original Chain of Thought Prompting](#difference-from-the-original-chain-of-thought-prompting)
    * [3.1 Two-stage prompting](#31-two-stage-prompting)
        * [Few-Shot is Human Engineering Heavy](#few-shot-is-human-engineering-heavy)
        * [1st prompt: reasoning extraction](#1st-prompt-reasoning-extraction)
        * [2nd prompt: answer extraction](#2nd-prompt-answer-extraction)
* [4. Experiment](#4-experiment)
    * [Tasks and datasets](#tasks-and-datasets)
    * [Models](#models)
    * [Baselines](#baselines)
    * [4.1 Results](#41-results)
        * [Comparison with other baselines](#comparison-with-other-baselines)
        * [Does model size matter for zero-shot reasoning?](#does-model-size-matter-for-zero-shot-reasoning)
        * [Error Analysis](#error-analysis)
        * [How does prompt selection affect Zero-shot-CoT?](#how-does-prompt-selection-affect-zero-shot-cot)
* [5. Discussion and Related Work](#5-discussion-and-related-work)
    * [Reasoning Ability of LLMs](#reasoning-ability-of-llms)
        * [Pre-trained Models are Not Naturally Good at](#pre-trained-models-are-not-naturally-good-at)
        * [Zero-shot Abilities of LLMs](#zero-shot-abilities-of-llms)
        * [From Narrow (task-specific) to Broad (multi-task) Prompting](#from-narrow-task-specific-to-broad-multi-task-prompting)
        * [Training Dataset Details](#training-dataset-details)
* [6. Conclusion](#6-conclusion)

---

# Abstract

### CoT Tackles System 2
Notably, chain of thought (CoT) prompting,a recent technique for eliciting complex multi-step reasoning through step-by- step answer examples, achieved the state-of-the-art performances in arithmetics and symbolic reasoning, difficult *system-2* tasks that do not follow the standard scaling laws for LLMs.

> System 2 tasks refer to problems requiring slow, deliberate, and logical reasoning, as opposed to System 1 tasks, which are solved through fast, instinctive pattern matching. In humans, System 2 is engaged when solving complex math or formal logic; in LLMs, these tasks are difficult because the model's "instinct" is to predict the most statistically likely answer in a single step.

---

### LLMs From Few-Shot to Zero-Shot
While these successes are often attributed to LLMs’ ability for few-shot learning, we show that LLMs are decent zero-shot reasoners by simply adding “Let’s think step by step” before each answer.

---

### Examples of System 2 Evaluation Benchmarks

Experimental results demonstrate that our Zero-shot-CoT, using the same single prompt template, significantly outperforms zero-shot LLM performances on diverse benchmark reasoning tasks including arithmetics (MultiArith, GSM8K, AQUA-RAT, #), symbolic reasoning (Last Letter, Coin Flip), and other logical reasoning tasks (Date Understanding, Tracking Shuffled Objects), without any hand-crafted few-shot
examples

> The benchmarks mentioned—such as GSM8K for arithmetic, Coin Flip for symbolic logic, and Shuffled Objects for spatial tracking — are definitive System 2 evaluation benchmarks. Unlike standard NLP tasks that test vocabulary or fact retrieval, these datasets are designed to measure a model’s ability to execute multi-step "mental programs." They require the model to maintain an internal state and process information sequentially (e.g., tracking a coin through multiple flips or calculating a multi-digit sum). By testing these specific areas, researchers can prove that Zero-shot-CoT is not just improving "fluency," but is actually enabling the model to perform the deliberate, serial computation necessary for logical reasoning.

---

### Zero Shot is Versatile
The versatility of this single prompt across very diverse reasoning tasks hints at untapped and understudied fundamental zero-shot capabilities of LLMs, suggesting high-level, multi-task broad cognitive capabilities may be extracted by simple prompting.

---

<br>
<br>
<br>

# 1. Introduction

## Scaling Size of Language Models
Scaling up the size of language models has been key ingredients of recent revolutions in natural language processing (NLP) [Vaswani et al., 2017, Devlin et al., 2019, Raffel et al., 2020, Brown et al.,2020, Thoppilan et al., 2022, Rae et al., 2021, Chowdhery et al., 2022]. 

> **Vaswani et al., 2017 (The Transformer):** Introduced the Transformer architecture and the self-attention mechanism, which replaced recurrent networks (RNNs) and became the foundation for almost all modern LLMs.
> 
> **Devlin et al., 2019 (BERT):** Established the "pre-train then fine-tune" paradigm using a bi-directional encoder, proving that models could learn deep linguistic representations by predicting masked words.
> 
> **Raffel et al., 2020 (T5):** Introduced the "Text-to-Text Transfer Transformer," which unified all NLP tasks (classification, translation, etc.) into a single text-in/text-out format.
> 
> **Brown et al., 2020 (GPT-3):** Demonstrated that massive scaling (175B parameters) allows models to become "few-shot learners," performing new tasks via prompting without any weight updates.
> 
> **Thoppilan et al., 2022 (LaMDA):** Focused on optimizing Transformers for dialogue, emphasizing "safety" and "groundedness" to ensure conversational AI remains helpful and factually accurate.
> 
> **Rae et al., 2021 (Gopher):** Explored the limits of scale with a 280B parameter model, providing a detailed analysis of which tasks (like reading comprehension) improve with size and which (like math) do not.
> 
> **Chowdhery et al., 2022 (PaLM):** Utilized "Pathways" training to scale to 540B parameters, showing that extreme scale enables "breakthrough" reasoning abilities and superior multilingual performance.

---

## In-Context Learning
The success of large language models (LLMs) is often attributed to (in-context) few-shot or zero-shot learning. It can solve various tasks by simply conditioning the models on a few examples (few-shot) or instructions describing the task (zero-shot). 

> Think of Prompting as the action you take, and In-Context Learning (ICL) as the mechanism occurring inside the model.

---

## Prompting
The method of conditioning the language model is called “prompting” [Liu et al., 2021b], and designing prompts either manually [Schick and Schütze, 2021, Reynolds and McDonell, 2021] or automatically [Gao et al., 2021, Shin et al., 2020] has become a hot topic in NLP.

> The citations in that paragraph identify the researchers who shifted the focus from "fine-tuning" the model's brain to "programming" the model's input. They are generally categorized into **Survey/Theory**, **Manual Design**, and **Automated Search**.
> #### The "Systematizers" (Survey & Theory)
> **Liu et al., 2021b (Pre-train, Prompt, and Predict):** Known for providing the definitive "bible" of prompting; this survey organized the field into a unified mathematical framework and popularized the term "prompt-based learning."
> 
> #### The "Manual Craftsmen" (Hand-Designed Prompts)
> * **Schick and Schütze, 2021 (PET):** Famous for introducing Pattern-Exploiting Training, which showed that framing classification tasks as "fill-in-the-blank" (Cloze) questions allows small models to outperform massive ones.
> * **Reynolds and McDonell, 2021 (Prompt Programming):** Notable for treating prompting as a "programming" task, demonstrating that detailed natural language "meta-prompts" can elicit complex behaviors without any training examples.
> #### The "Automators" (Algorithmic Prompt Search)
> * **Gao et al., 2021 (LM-BFF):** Introduced the "Language Model’s Best Friend Forever" framework, which uses an automated system to generate and select the most effective prompts and examples for few-shot learning.
> **Shin et al., 2020 (AutoPrompt):** Known for creating an automated, gradient-based method to find "trigger tokens" — often nonsensical words — that, when added to a prompt, "unlock" the model's latent knowledge more effectively than human-written text.

---

## Chain of Thought for System 2
In contrast to the excellent performance of LLMs in intuitive and single-step system-1 [Stanovich and West, 2000] tasks with task-specific few-shot or zero-shot prompting [Liu et al., 2021b], even
language models at the scale of 100B or more parameters had struggled on system-2 tasks requiring slow and multi-step reasoning [Rae et al., 2021]. To address this shortcoming, Wei et al. [2022], Wang et al. [2022] have proposed chain of thought prompting (CoT), which feed LLMs with the step-by-step reasoning examples rather than standard question and answer examples (see Fig. 1-a).

> **Wei et al., 2022 (Chain-of-Thought Prompting Elicits Reasoning in Large Language Models):** This is the seminal paper that introduced CoT prompting. It demonstrated that by providing a few examples of "showing your work" (reasoning steps), models with over 100B parameters could bypass standard scaling limitations and solve complex arithmetic and symbolic tasks that were previously impossible.
> 
> **Wang et al., 2022 (Self-Consistency Improves Chain of Thought Reasoning in Language Models):** This paper introduced **Self-Consistency**, a decoding strategy where the model generates multiple different reasoning paths for the same problem. By taking a **majority vote** of the final answers, the authors significantly boosted the reliability and accuracy of CoT, proving that "consensus" reduces individual logical errors.

---

## CoT Reasoning Path
Such chain of thought demonstrations facilitate models to generate a **reasoning path** that decomposes the complex reasoning into multiple easier steps.

---

## Reasoning Scales with Model Size
Notably with CoT, the reasoning performance then satisfies the scaling laws better and jumps up with the size of the language models.

---

## The Papers Zero-Shot Reasoning Approach
While the successes of CoT prompting [Wei et al., 2022], along those of many other task-specific prompting work [Gao et al., 2021, Schick and Schütze, 2021, Liu et al., 2021b], are often attributed to LLMs’ ability for few-shot learning [Brown et al., 2020], we show that LLMs are decent zero-shot reasoners by adding a simple prompt, Let’s think step by step, to facilitate step-by-step thinking before answering each question (see Figure 1).

---

## Zero-Shot CoT vs Zero-Shot Prompt
Despite the simplicity, our Zero-shot-CoT successfully generates a plausible reasoning path in a zero-shot manner and reaches the correct answer in a problem where the standard zero-shot approach fails.

Importantly, our Zero-shot-CoT is versatile and
**task-agnostic**, unlike most prior task-specific prompt engineering in the forms of examples (few-shot) or templates (zero-shot) [Liu et al., 2021b]

--- 

## Reasoning Benchmarks
it can facilitate step-by-step answers across various reasoning tasks, including arithmetic (MultiArith [Roy and Roth, 2015], GSM8K [Cobbe et al., 2021], AQUA-RAT [Ling et al., 2017], and # [Patel et al., 2021]), symbolic reasoning (Last letter and Coin flip), commonsense reasoning (CommonSenseQA [Talmor et al., 2019] and Strategy QA [Geva et al., 2021]), and other logical reasoning tasks (Date understanding and Tracking Shuffled Objects from BIG-bench [Srivastava et al., 2022]) without modifying the prompt per task.

> ## Arithmetic Reasoning (Math Word Problems)
> 
> **Roy and Roth, 2015 (MultiArith):** A collection of multi-step math word problems that require various operations (addition, subtraction, multiplication, division) to solve, often testing the model's ability to ignore "irrelevant" numbers in the text.
> 
> **Cobbe et al., 2021 (GSM8K):** A benchmark of high-quality grade school math word problems that are particularly challenging because they require a sequence of 2 to 8 logical steps to reach a solution.
> 
> **Ling et al., 2017 (AQUA-RAT):** Focuses on algebraic word problems with multiple-choice options, designed to evaluate whether a model can follow the formal "rationales" behind math problems.
> 
> **Patel et al., 2021 (#):** A robust version of math word problems where the text is purposefully varied (e.g., changing word order or adding distracting info) to ensure the model isn't just memorizing patterns.
> 
> ## Commonsense Reasoning (Real-World Logic)
> **Talmor et al., 2019 (CommonsenseQA):** A question-answering dataset that requires "common sense" knowledge beyond what is explicitly stated in the text (e.g., "Where would you find a bird?").
> 
> **Geva et al., 2021 (StrategyQA):** A benchmark where the reasoning steps are "implicit," meaning the model must figure out the strategy to break the question down before it can answer it.
> 
> ## Logical & Symbolic Reasoning (Tracking & Algorithms)
> **Srivastava et al., 2022 (BIG-bench):** A massive, collaborative "Stress Test" for LLMs containing over 200 tasks (including Date Understanding and Tracking Shuffled Objects) designed to probe the absolute limits of current AI intelligence
> 
> **Symbolic Reasoning (Last Letter & Coin Flip):** These are "synthetic" tasks—not from a specific paper but used widely in CoT research—to see if a model can follow a strict algorithm, such as taking the last letters of words or tracking a coin's state through multiple flips.

---

## Few-shot-CoT > Zero-shot-CoT > Zero-Shot Baseline (Prompt)

We empirically evaluate Zero-shot-CoT against **other prompting baselines** in Table 2. While our Zero-shot-CoT underperforms Few-shot-CoT with carefully-crafted and task-specific step-by-step examples, Zero-shot-CoT achieves enormous score gains compared to the zero-shot baseline, e.g. from 17.7% to 78.7% on MultiArith and from 10.4% to 40.7% on GSM8K with large-scale InstructGPT

---

## Zero Shot Scaling Curve
Importantly, with our single fixed prompt, zero-shot LLMs have a significantly better scaling curve comparable to that of the few-shot CoT baseline. 

---

<br>
<br>
<br>

# 2. Background 
We briefly review the two core preliminary concepts that form the basis of this work: the **advent of large language models (LLMs)** and **prompting**, and chain of thought (CoT) prompting **for multi-step reasoning**

---

## Large language models and prompting
A language model (LM), is a model that looks to estimate the probability distribution over text.

---

### From "Pre-train and Fine-Tune" to "Pre-Train and Prompt" Era
Besides the classic “pre-train and fine-tune” paradigm [Liu et al., 2021b], models scaled to 100B+ parameters exhibit properties conducive to few-shot learning [Brown et al., 2020], by way of in context learning, where one can use a text or template known as a prompt to strongly guide the generation to output answers for desired tasks, thus beginning an era of “pre-train and prompt” [Liu et al., 2021a].

---

### Few vs Zero Distinction
In work, we call such prompts with explicit conditioning on few task examples as few-shot prompts, and other template-only prompts as zero-shot prompts.

--- 

## Chain of Thought Prompting 
Multi-step arithmetic and logical reasoning benchmarks have particularly challenged the scaling laws of large language models [Rae et al., 2021]

---

To differentiate it from our method, we call Wei et al. [2022] as Few-shot-CoT in this work.

---

# 3. Zero-shot Chain of Thought
We propose Zero-shot-CoT, a zero-shot template-based prompting for chain of thought reasoning.

---

### Difference from the Original Chain of Thought Prompting

It differs from the original chain of thought prompting [Wei et al., 2022] as it does not require **step-by-step few-shot examples**, and it differs from most of the prior template prompting [Liu et al., 2021b] as it is inherently **task-agnostic** and elicits **multi-hop reasoning** across a wide range of tasks with a **single template**.

---

## 3.1 Two-stage prompting
While **Zero-shot-CoT** is conceptually simple, it uses prompting twice to extract both reasoning and answer.

In contrast, the **zero-shot baseline** already uses prompting in the form of “The answer is”, to extract the answers in correct formats.

**Few-shot prompting**, standard or CoT, avoids needing such answer-extraction prompting by explicitly designing the few-shot example answers to end in such formats.

---

### Few-Shot is Human Engineering Heavy
In summary, Few-shot-CoT [Wei et al., 2022] requires careful human engineering of a few prompt examples with specific answer formats per task, while Zero-shot-CoT requires less engineering but requires prompting LLMs twice.

---

### 1st prompt: reasoning extraction
In this step we first modify the input question `x` into a prompt `x′` using a simple template `“Q: [X]. A: [T]”`, where [X] is an input slot for `x` and [T] is an slot for hand-crafted trigger sentence `t` that would extract chain of though to answer the question `x`.

In this step we first modify the input question `x` into a prompt `x′` using a simple template `“Q: [X]. A: [T]”`, where `[X]` is an input slot for `x` and `[T]` is an slot for hand-crafted trigger sentence `t` that would extract chain of though to answer the question `x`.

Prompted text `x′` is then fed into a language model and generate subsequent sentence `z`

---

### 2nd prompt: answer extraction
In the second step, we use generated sentence `z` along with prompted sentence `x′` to extract the final answer from the language model. 

To be concrete, we simply concatenate three elements as with “[X′] [Z] [A]”: [X′] for 1st prompt x′, [Z] for sentence z generated at the first step, and [A] for a trigger sentence to extract answer.

The prompt for this step is **self-augmented**, since the prompt contains the sentence `z` generated by the same language model

---

# 4. Experiment

## Tasks and datasets
We evaluate our proposal on 12 datasets from four categories of reasoning tasks: arithmetic, commonsense, symbolic, and other logical reasoning tasks

---

## Models 
We experiment with 17 models in total.

Main experiments are conducted with Instruct- GPT3 [Ouyang et al., 2022] (text-ada/babbage/curie/davinci-001 and text-davinci-002)3, original GPT3 [Brown et al., 2020] (ada, babbage, curie, and davinci)4, and PaLM [Chowdhery et al., 2022] (8B, 62B, and 540B). 

In addition, we used GPT-2[Radford et al., 2019], GPT-Neo [Black et al., 2021], GPT-J[Wang and Komatsuzaki, 2021], T0 [Sanh et al., 2022], and OPT [Zhang et al., 2022] for model scaling study.

---

## Baselines
We compare our **Zero-shot-CoT** mainly to standard **Zero-shot prompting** to verify the effectiveness of its chain of thought reasoning.

To better evaluate the zero-shot ability of LLMs on reasoning tasks, we also compare our method to Few-shot and Few-shot-CoT baselines from [Wei et al., 2022], using the same in-context examples.

---

## 4.1 Results

### Zero-shot-CoT vs. Zero-shot
**Zero-shot-CoT** substantially outperforms **four out of six** arithmetic reasoning tasks (MultiArith, GSM8K, AQUA, SVAMP), **all symbolic reasoning**, and **all other logical reasoning** tasks (from BIG-bench [Srivastava et al., 2022]).

Zero-shot-CoT achieves score gains from 17.7% to 78.7% on MultiArith and from 10.4% to 40.7% on GSM8K. 

Our method gives on-par performances for the remaining two arithmetic reasoning tasks (SingleEq and AddSub), which is expected since they do not require multi-step reasoning

In **commonsense reasoning tasks**, Zero-shot-CoT **does not** provide performance gains. It is expected as Wei et al. [2022] also reports that **even Few-shot-CoT does not** provide performance gains on Lambda (135B)

---

### Comparison with other baselines
compares the performances on two arithmetic reasoning benchmarks (MultiArith and GSM8K) across Zero-shot-CoT and baselines. The large gap between standard prompting (1st block) and chain of thought prompting (2nd block) suggests that these tasks are difficult without eliciting multi-step reasoning.

While Zero-shot-CoT **naturally underperforms** Few-shot-CoT, it substantially outperforms standard Few-shot prompting with even 8 examples per task.

---

### Does model size matter for zero-shot reasoning?
ithout chain of thought reasoning, the performance does not increase or increases slowly as the model scale is increased, i.e., the curve is mostly flat

In contrast, the performance drastically increases with chain of thought reasoning, as the model size gets bigger, for Original/Instruct GPT-3 and PaLM. 

When the model size is smaller, chain of thought reasoning is not effective. This result aligns with the few-shot experiment results in Wei et al. [2022]

--- 

### Error Analysis
Zero-shot-CoT often output multiple answer choices when the model find it is difficult to narrow it down to one 

In arithmetic reasoning (MultiArith), Zero-shot-CoT and Few-shot-CoT show substantial differences regarding the error patterns. First, Zero-shot-CoT tends to output unnecessary steps of reasoning after getting the correct prediction, which results in changing the prediction to incorrect one. 

Zero-shot-CoT also sometimes does not start reasoning, just rephrasing the input question. 

In contrast, Few-shot-CoT tend to fail when generated chain of thought include ternary operation, e.g. (3 + 2) ∗4.

---

### How does prompt selection affect Zero-shot-CoT?
summarizes performance using 16 different templates with three
categories.

Specifically, following Webson and Pavlick [2022], the categories include **instructive** (encourage reasoning), **misleading** (discourage reasoning or encouraging reasoning but in a wrong way), and **irrelevant** (nothing to do with reasoning).

The results indicate that the performance is improved if the text is written in a way that **encourages chain of thought reasoning**, i.e., the templates are within **"instructive"** category.

However, the difference in accuracy is significant depending on the sentence

In this experiment, **"Let’s think step by step."** achieves the best results

In contrast, when we use misleading or irrelevant templates, the performance does not improve.

--- 

# 5. Discussion and Related Work

## Reasoning Ability of LLMs

### Pre-trained Models are Not Naturally Good at Reasoning: Step-by-Step, Fine-tune, Prompt
Several studies have shown that pre-trained models usually are **not good at reasoning** [Brown et al., 2020, Smith et al., 2022, Rae et al., 2021], but its **ability can be substantially increased** by making them produce **step-by-step reasoning**, either by **fine-tuning** [Rajani et al., 2019, Cobbe et al., 2021, Zelikman et al., 2022, Nye et al., 2022] or **few-shot prompting** [Wei et al., 2022, Wang et al., 2022, Chowdhery et al., 2022]

Similar to our work, Reynolds and McDonell
[2021] demonstrate a prompt, “Let’s solve this problem by splitting it into steps”, would facilitate the multi-step reasoning in a simple arithmetic problem. However, they treated it as a task-specific example and did not evaluate quantitatively on diverse reasoning tasks against baselines.

Shwartz et al. [2020] propose to decompose a commonsense question into a series of information seeking question, such as “what is the definition of [X]”. It does not require demonstrations but requires substantial manual prompt engineering per each reasoning task.

Our results strongly suggest that LLMs are decent zero-shot reasoners, while prior work [Wei et al., 2022] often emphasize only few-shot learning and task-specific in-context learning, e.g. no zero-shot baselines were reported.

Our method does not require time-consuming fine-tuning or expensive sample engineering, and can be combined with any pre-trained LLM, serving as the strongest zero-shot baseline for all reasoning tasks

---

### Zero-shot Abilities of LLMs
Radford et al. [2019] show that LLMs have excellent zero-shot abilities in many system-1 tasks, including reading comprehension, translation, and summarization.

Sanh et al. [2022], Ouyang et al. [2022] show that such zero-shot abilities of LLMs can be increased by explicitly fine-tuning models to follow instructions. 

Although these work focus on the zero-shot performances of LLMs, we focus on many system-2 tasks beyond system-1 tasks, considered a grand
challenge for LLMs given flat scaling curves.

---

### From Narrow (task-specific) to Broad (multi-task) Prompting
Most prompts are task-specific. While few-shot prompts are naturally so due to task-specific in-context samples [Brown et al., 2020, Wei et al., 2022], majority of zero-shot prompts have also focused on per-task engineering (of templates) [Liu et al., 2021b, Reynolds and McDonell, 2021]

Borrowing terminologies from Chollet
[2019] which builds on hierarchical models of intelligence [McGrew, 2005, Johnson and Bouchard Jr, 2005], these prompts are arguably eliciting “narrow generalization” or task-specific skills from LLMs.

On the other hand, our method is a multi-task prompt and elicits **“broad generalization”** or **broad cognitive abilities in LLMs**, such as logical reasoning or system-2 itself.

---

### Training Dataset Details
A limitation of the work is the lack of public information on the details of training datasets used for LLMs, e.g. 001 vs 002 for GPT models, original GPT3 vs Instruct-GPT [Ouyang et al., 2022], and data for PaLM models [Chowdhery et al., 2022].

However, big performance increases from Zero-shot to Zero-shot-CoT in all recent large models (InstructGPT 001 or 002, Original GPT3, and PaLM) and consistent improvements in both arithmetic and non-arithmetic tasks suggest that the models are unlikely simply memorizing, but instead capturing a task-agnostic multi-step reasoning capability for generic problem solving.

**Prompting is a method** that looks to take advantage of the patterns captured by language models conducive to various tasks, and therefore it has the same shortcomings.

> A major **critique** of Zero-shot-CoT is the lack of transparency regarding the training data of closed-source models. It is highly likely that InstructGPT and PaLM were **fine-tuned on human-annotated reasoning chains**, meaning "Let's think step by step" might simply be a trigger for a learned behavior. However, researchers argue against pure memorization by pointing out that the effect also appears in unaligned base models (GPT-3) and that it generalizes to novel symbolic tasks that do not appear in standard human-annotated datasets.
> 
> It is crucial to distinguish between Base GPT-3 and the version most people use (originally InstructGPT, now GPT-3.5/4).
> 
> **Base GPT-3:** Was indeed trained primarily on the datasets above (self-supervised learning). If you asked it a question, it might respond with another question because it was just predicting the next most likely word on the internet.
> 
> **InstructGPT/ChatGPT:** These models underwent an additional stage of Supervised Fine-Tuning (SFT). In this stage, OpenAI hired thousands of humans to write out "demonstration" data—perfectly formatted answers, step-by-step reasoning, and polite refusals.

---

# 6. Conclusion
We have proposed Zero-shot-CoT, a single zero-shot prompt that elicits chain of thought from large language models across a variety of reasoning tasks, in contrast to the few-shot (in-context) approach in previous work that requires hand-crafting few-shot examples per task

Our simple method not only
is the minimalist and strongest zero-shot baseline for difficult multi-step system-2 reasoning tasks that long evaded the scaling laws of LLMs, but also encourages the community to further discover similar multi-task prompts that elicit broad cognitive abilities instead of narrow task-specific skills.

---