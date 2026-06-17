# 3. Data Characterization and Representation Strategy
The follow section(s) are dedicated to introducing, explaining and exploring the underlying training data set. 
---

## 3.1 Corpus Overview
The dataset supplied for this report appears to be a subset or inspired by the Propaganda Techniques Corpus (PTC) created by Da San Martino et al. (2020) for the SemEval-2020 Task 11. In these original papers, the data was collected from a  "sample of news articles from the period starting in mid-2017 and ending in early 2019."

It contains 2414 rows and 2 columns: `text` and `label`. The `text` field contains the passage of text which is formatted as a string. Within each string there are <BOS> and <EOS> markers which contain the snippet of text which may or may not be evidence of propaganda. The `label` field contains the category for which the snippet has been determined to be. There are 8 labels which are taken directly from the Da San Martino et al. (2020) paper as well as an additional `not_propaganda` label, making 9 in total. The text outside the tags is not itself considered to be a tagged as the snippets given label and is instead just the sentinal context pertaining to the snippet and/or the wider source of the text. 

The table below contains the 9 labels from the dataset, their definition according to Da San Martino et al. (2020) and example taken directly from the training data. 

| Label | Definition | Example |
| :--- | :--- | :--- |
| `flag_waving` |  |  |
| `appeal_to_fear_prejudice` |  |  |
| `causal_simplification` |  |  |
| `doubt` |  |  |
| `exaggeration,minimisation` |  |  |
| `loaded_language` |  |  |
| `name_calling,labeling` |  |  |
| `repetition` |  |  |
| `not_propaganda` |  |  |

Light data cleaning was carried out which focused on removing digital artifacts that do not represent any intended context from the write/speaker themselves. However, all grammar, spelling variations and punctuation were left as this demonstates meaning and intent. 

> Need to mention that the text was generally tokensized and any other preprocessing steps

> SHOULD THERE BE AN EDA SECTION HERE? 
> - (Or possible after tagging) 
> OR POSSIBLY SPREAD THROUGH OUT MEANING NO EXPLICITY EDA SECTION
> i.e. here include information on the rows, lengths of seqs, snippets and context
> in the tag sections provide information, i.e. breakdown of enities and pos in snippets
> maybe some table based data where signifcant parts are references in the text
> I think this is the correct approach as tables don't add the word count

## 3.X Defining the Vocabulary
- Most techqiues reply explicitly on a pre-definied vocabuluary
- Language itself it sparse, hapax lego
- The dataset is small enhancing this 
- Need to redistribute weight across features
- Instances with 1 become unk token
- However, these are first tagged so they become unk is a tuple that still contains their pos and named entity where possible


---

## 3.X Feature Enrichment
In various places throughout the task, the text was enriched by tagging the tokens, specifically with their part-of-speech (POS) and Named Entity. For each entry in the sequence a tuple holds the original token, POS and Named entity tag. 

POS tagging involves assigning each token its grammatical class. We tagged the sequences using <include_tagger> which comprised of <include_number_of_tags>. It was decided as a particuarly important feature to include with respect to H2 and providing additional signal to identify linguistic irregularities that are so prevelant in propaganda. I expected that Task 2 will benefit signicantly from this feature as it may highlight the difference in composition between the propaganda snippet and the context, thus, improving the accuracy of the boundary predictions. 

Named enitity involves, where possible, assigning token's their representative nouns. We tagged the sequences using <include_tagger> which comprised of <include_number_of_tags>. This feature should support both H1 and H2. Propagandists often target People, Places and Known Entities to weight on the emotional cues of their audience. However, our dataset is small which means a lot of noun references will only only come up once. This will lead to either weak signal whereby the model cannot effectively identify this exact reference as a propaganda cue or conversely lead to sevre overfitting where the model believes due a single training point that this word must always be propaganda. This feature should support both H1 and H2 in different ways. For H1 it should help to highlight sparse enities as direct noun references and for H2 it should provide signal that enhances the significance of word pairing surrounding a noun reference. 

Sentinment not included as whilst some propaganda techniques explicity weigh on emotional cues <include_examples> many other techniques, and even these same technqiues, invoken a more nuaunced approach to their manipulation. For more subtle propaganda instances, sentiment features may work to infact muddy the signal in pointing the models towards and given interpretation of the words and missing the underlying message.
- > `emotional cues` or some explcitiy address propgandas sleight of hand
- > i think there will be a reference that mentions approached previous attempted to use or build on Sentinment approaches before decided it was not complex enough for propaganda. 

Our decision to include feature tagging as a component follows successful entries in Da San Martino et al. (2020) SemEval-2020 Task 11 such as Team LTIatCMU(SI:4) (Khosla et al., 2020) who enhanced their BERT BiLSTM model with additional syntactic and semantic features. 

> **POS:** tagged using nltk `averaged_perceptron_tagger` and applied to each sequence in full; snippet + context
> **Named Entity:** tagged using spacy, "en_core_web_sm"

---

## 3.4 Data Augmentation (Silver Data)
Excluding the the `not_propaganda` labels, there are only 1223 instances spread across 8 categories with approx 160 labels in each. This is not a hugely signficant amount of training data and opens up the risk of overfitting to the training and poorly generalising to unseen data. Futhermore, if certain words are over represented in the given training set then we potenitally introduce a structrual flaw that contradicts H1 irrespective of methodology. To combat these risk, the data is augmented and suplemented through the introduction of silver data which has been generated using the original (gold) training data on a one-to-one basis introduce an additional 1223 training instances, bringing the total to 2446. 

This approach follows several methodologies submitted in the Da San Martino et al. (2020) SemEval-2020 Task 11 such as Team UPB(SI:5) (Paraschiv and Cercel, 2020) who used a masked language modeling method to produce synthetic data and Team DoNotDistribute(SI:22) (Kranzlein et al., 2020) who generated an additional 3k new silver training instances resulting in a 5% performance boost. 

However, one really important thing to highlight is that the SemEval-2020 Task 11 paper was released in Dec 2020 meaning it either completely pre-dated or intersected with modern the LLM revolution and the release of the foundational GPT-3 paper which was uploaded to arXiv on May 28, 2020 (Brown et al., 2020). In fact, the training data itself was released in late 2019 with the participants submitting their papers in early 2020. 

Due to this timing, the leading models in NLP benchmars were encoder-only masked language models like BERT and potentially encoder-decoder architectures like T5.

Therefore, a unique route taken in this report that was not demonstated in the SemEval-2020 Task 11 competition is to generate the silver data using zero-shot (reference?), prompting approach using decoder-only LLMs. <need_to_justify_why_this_may_be_better>

The exact methodology used involved taking each training instance and using a mutli-step Chain-of-Thought (CoT) (<need_refernce>) prompt to generative alterntive synthetic data for the snippet only. The CoT approach was specifically leveraged to ensure that the synthetic snippet made logical and gramatical sense with respect to the wider sential context which it belows to. 

#### Full Approach (Appendix or Diseminate into Tables)

Start with full training set and remove the `not_propaganda` instances as these are already the majority field and we do not have enough information about how these instances were collects and false snippets decided. The exact model used was the open source `Meta-Llama-3-8B`. It should be noted that many open-source and private LLMs struggle with this task as they have safeguards to not participate in propaganda and offensive language/slurs. However, the hostel version from <model_provider> has less restrictions and the generation was programmed to re-prompt if the model refused to output the correct content. 

> COME BACK TO THIS ONCE PROCESS IS RE-CODED

- tempurature was set to 0.7 to encourage variabliltiy in generative
- chain of thought helper function to retain prompt context in the context window
- prompts are not kept in the window to reduce risk of prompt confusion in the CoT
- prompt 1: given the snippet and asked to reword 
- job as linguistics expert to reword given text
- told that text is labelled it X but cannot be given label description because it breaks models terms, i.e. engaging in hateful or prop
- "Generate 3 alternatives to the snippet that serve the same purpose as guided by the label definition."
- Use a range of lexical semantics: synonyms for intensity, hypernyms for generalization, or paraphrasing.
- temp 0.7 to help with this and collect a range of ideas. 
- told to explain suitablitiy of each suggestion

- prompt 2: given the left and right context that surrounds the snippet
- asked to review 3 generative options to see if they still make sense given the immediate surrounds
- if they don't to suggest something new
- p2 used to be two seperate prompts by conbined to reduce run time

- prompt 3: based on the reason in the previous 2 context windows, select the best snippet
- told to ensure it is:   
    - 1. Rhetorically powerful ({label})
    - 2. Grammatically perfect within the context.
    - 3. Distinct from the original.
- told to output the snippet in a mask between tags: <final_output> INSERT SNIPPET HERE </final_output>
- STOP: Do not write anything else after the closing tag.

- post proseccing in python is applied to try and extract the generate snipper
- regex looking between the tags <final_output> </final_output>
- a few catches
- if the output snipper is exactly the same as the input snippet then cot is re-run, upto 3 times (2 retry + orig)
- sometimes the model failed on the mask and hallicunates the left/right context within the tags
- regex used to strip this out
    - also strip out over lap of 15 letters or more
- if failure to produce tags or anyting in the tags then run again
- some instances (count) of 1st failure but never more than 1

- output snippet is put into the same format at the gold set: left cont <bos> snippet <eos> right context
- this way anything that happens to the gold can be applied to the silver

- batch processed in 100s with back up
- logged to check failures
- jioned to gold dataset at the end by matching index
- saved as extrnal filex

---

## 3.5 Domain Adaptation
To address the small 2.5k row constraint, a DeBERTa model <need_exact_model> was  fine-tuned on a 10,000-article news corpus from 2017–2019, ensuring the model's base weights are adapted to the specific linguistic era of the Da San Martino dataset.

> COME BACK TO THIS ONCE RE-CODED