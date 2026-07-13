#### 3.4 Full Silver Approach 
> Put this into the appendix or Diseminate into Tables
> Possibly summary paragraph + table + full outline in Appendix

> come back to this once implementation is coded but below is highlight appraoch. 

Start with full training set and remove the `not_propaganda` instances as these are already the majority field and we do not have enough information about how these instances were collects and false snippets decided. The exact model used was the open source `Meta-Llama-3-8B`. It should be noted that many open-source and private LLMs struggle with this task as they have safeguards to not participate in propaganda and offensive language/slurs. However, the hostel version from <model_provider> has less restrictions and the generation was programmed to re-prompt if the model refused to output the correct content. 

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

