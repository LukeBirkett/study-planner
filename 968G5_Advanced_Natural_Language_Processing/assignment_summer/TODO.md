






Task 1: Build and evaluate at least 2 different approaches to classifying the propaganda technique which has been used in a `snippet` or span of text which is known to be propaganda. As input, your system might take a snippet of propaganda `AND` its sentential context. The output should be the propaganda technique used.

- Remove `not_propaganda`
- Data EDA (Short and Snappy)
- Split into train and val for hyperparam tuning (?)
- Vocab Identifer; gold not silver, silver is only to enrich density
- Rare Words (Singletons) to UNK
- Random or Uniform Guess Baseline

- Data Augmentation: Silver Data, Prompt, Open Source Model
- External Data: Fine-tuning, Domain Adapation, Tranfer Learning

- BoW Approach (Baseline); build vocab first and build bow
- Word2Vec Approach: `word2vec-google-news-300`
- Snippets vs Snippets + Context
- BERT Approach: `DEBERTa`
- Standardized MLP Head










Task 2: Build and evaluate either 2 different approaches or at least 2 variations on a single approach to detecting propaganda within a sentence. Your system should identify both the span and the propaganda technique used.






