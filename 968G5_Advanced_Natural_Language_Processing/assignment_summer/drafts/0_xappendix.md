# Appendix 

### Appendix A: Propaganda Technique Definitions According to Da San Martino et al. (2020)
| Label | Definition |
| :--- | :--- |
| `flag_waving` | Playing on strong national feeling (or with respect to any group, e.g., race, gender, political preference) to justify or promote an action or idea (Hobbs and Mcgee, 2008). |
| `appeal_to_fear_prejudice` | Seeking to build support for an idea by instilling anxiety and/or panic in the population towards an alternative, possibly based on preconceived judgments. |
| `causal_simplification` | Assuming a single cause or reason when there are multiple causes behind an issue. We include in the definition also scapegoating, e.g., transferring the blame to one person or
group of people without investigating the complexities of an issue |
| `doubt` | Questioning the credibility of someone or something. |
| `exaggeration,minimisation` | Either representing something in an excessive manner: making things larger, better, worse or making something seem less important or smaller than it actually is (Jowett and O’Donnell, 2012). |
| `loaded_language` | Using specific words and phrases with strong emotional implications (either positive or negative) to influence an audience (Weston, 2000, p. 6). |
| `name_calling,labeling` | Labeling the object of the propaganda campaign as either something the target audience fears, hates, finds undesirable or loves, praises (Miller, 1939) |
| `repetition` | Repeating the same message over and over again, so that the audience will eventually accept it (Torok, 2015; Miller, 1939). |
| `not_propaganda` | No propaganda has been identified in the text |

---

##### Appendix B: Universal Text Pre-processing Steps
| Step | Target | Transformation | Rationale |
| :--- | :--- | :--- | :--- |
| **Whitespace Normalization** | Leading/trailing & inline whitespace | `text.strip()`, `.split()` join | Standardizes token boundaries across raw TSV parses. |
| **Escape Syntax Cleanup** | Python string escapes (`\\'`, `\\"`) | Stripped backslashes | Removes file parsing artifacts. |
| **Quote Normalization** | Curved / Smart quotes (`“`, `”`, `‘`, `’`) | Converted to flat quotes (`"`, `'`) | Unifies quote representation for tokenizers. |
| **Intra-word Apostrophes** | Contractions & Possessives | Collapsed (`won't` $\rightarrow$ `wont`) | Prevents regex tokenizer from fragmenting root words. |
| **Character Artifact Filter** | `\ / [ ] * \| @ space - . : $ # + =` | Replaced with single space | Removes markup symbols and publisher artifacts. |
| **Boundary Guard** | `<BOS>`, `<EOS>` | Standardized padding spaces | Ensures target span delimiters remain uncorrupted. |

--- 

### Appendix C: Mapped Universal POS Tagset
| Universal POS Tag | Description | Mapped Penn Treebank Tags (NLTK Perceptron) |
| :---: | :--- | :--- |
| **`ADJ`** | Adjectives | `JJ`, `JJR`, `JJS` |
| **`ADP`** | Adpositions (Prepositions / Postpositions) | `IN`, `TO` |
| **`ADV`** | Adverbs | `RB`, `RBR`, `RBS`, `WRB` |
| **`CONJ`** | Conjunctions | `CC` |
| **`DET`** | Determiners / Articles | `DT`, `PDT`, `WDT` |
| **`NOUN`** | Nouns | `NN`, `NNS`, `NNP`, `NNPS` |
| **`NUM`** | Numerals | `CD` |
| **`PRON`** | Pronouns | `PRP`, `PRP$`, `WP`, `WP$` |
| **`PRT`** | Particles / Functional Markers | `POS`, `RP` |
| **`VERB`** | Verbs | `VB`, `VBD`, `VBG`, `VBN`, `VBP`, `VBZ`, `MD` |
| **`.`** | Punctuation Marks | `.`, `,`, `:`, `(`, `)`, `"`, `'`, ``` ` ``` |
| **`X`** | Unknown / Other / Symbols | `FW`, `SYM`, `LS`, `UH` |

---

### Appendix D: Homogenized Simplified NER Tagset
| Tag | Entity Category | Frequency Strategy | Target Propaganda Signal |
| :---: | :--- | :---: | :--- |
| **`PERSON`** | People, including fictional characters | Preserved | Identifies targets of *Name Calling* & *Ad Hominem*. |
| **`ORG`** | Companies, agencies, institutions | Preserved | Captures organizational targets (*Appeal to Fear*). |
| **`GPE`** | Countries, cities, states | Preserved | High relevance to *Flag Waving* rhetoric. |
| **`NORP`** | Nationalities, religious/political groups | Preserved | Core driver of group-identity manipulation. |
| **`DATE`** / **`TIME`** | Absolute or relative dates/times | Preserved | Identifies temporal framing or urgent calls. |
| **`CARDINAL`** / **`ORDINAL`** | Numbers / Numerals | Preserved | Relates to *Exaggeration / Minimisation* statistics. |
| **`LOC`** | Non-GPE locations (mountain ranges, bodies of water) | Preserved | Geographic framing. |
| **`O`** | Outside any named entity | Preserved | Baseline background token marker. |
| **`MISC`** | `MONEY`, `EVENT`, `PERCENT`, `WORK_OF_ART`, `FAC`, `LAW`, `PRODUCT`, `LANGUAGE`, `QUANTITY` | Homogenized | Aggregates low-frequency entity classes to preserve feature density. |

---

### Appendix E: Custom Stopword List