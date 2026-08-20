# %% [markdown]
# #### PIP

# %%
%pip install -q nltk
%pip install -q spacy
%pip install -q gensim

# %% [markdown]
# #### Imports and Downloads

# %%
import nltk

nltk.download('averaged_perceptron_tagger', quiet=True)
nltk.download('universal_tagset', quiet=True)

# %%
!python -m spacy download en_core_web_sm

# %%
import spacy
from spacy.tokens import Doc

# Load the spaCy model globally (en_core_web_sm is lightweight and efficient)
nlp = spacy.load("en_core_web_sm")

# %%
import numpy as np
import gensim.downloader as api

print("Global load: Downloading/Loading Word2Vec model...")
GLOBAL_W2V_MODEL = api.load('word2vec-google-news-300')
print("Global load: Word2Vec model ready.")

# %% [markdown]
# ---

# %% [markdown]
# #### Set Notebook Seed

# %%
SEED=142

# %%
import torch
import random
import numpy as np

def set_seed(seed: int = 142):
    """Locks all random number generators for exact reproducibility."""
    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    
    if torch.cuda.is_available():
        torch.cuda.manual_seed_all(seed)
        torch.backends.cudnn.deterministic = True
        torch.backends.cudnn.benchmark = False
        
    print(f"Global seed set to {seed}")

# %%
set_seed(SEED)

# %% [markdown]
# ## Task 1

# %% [markdown]
# #### PropagandaFeaturePipeline (Class)

# %%
import re
import csv
from collections import Counter
import torch
import spacy
from spacy.tokens import Doc
from nltk.tag.perceptron import PerceptronTagger
from nltk.tag import map_tag

class PropagandaFeaturePipeline:
    """
    Encapsulates state (vocabularies, tagsets) while maintaining a pure 
    functional approach to row-by-row string processing and vectorization.
    """
    def __init__(self, spacy_model="en_core_web_sm", exclude_non_propaganda=True):

        self.LABELS = [
            'name_calling,labeling', 'repetition', 'causal_oversimplification', 
            'doubt', 'loaded_language', 'appeal_to_fear_prejudice', 
            'flag_waving', 'exaggeration,minimisation', 'not_propaganda'
        ]

        # For Task 1
        if exclude_non_propaganda:
            self.LABELS.remove('not_propaganda')
        
        self.UNIVERSAL_TAGSET = ["ADJ","ADP","ADV","CONJ","DET","NOUN","NUM","PRT","PRON","VERB",".","X"]
        
        # Custom (Shortened) NER Tagset
        self.NER_TAG = ['PERSON','ORG','GPE','DATE','NORP','CARDINAL','ORDINAL','TIME','LOC', 'O']
        
        # Top N most frequent words
        self.CUSTOM_STOPWORDS = ["the" , ",", "to", "of", "and", "in", "a", "that"]

        self.word_to_index = {}     # bow vector indicies
        self.word_to_index_silver = {}  # bow vector indicies using synthetic data
        self.hapax_words_list = []
        self.hapax_words_list_silver = []
        
        self.pos_to_index = self._build_tag_index(self.UNIVERSAL_TAGSET)    # POS tagset vector indicies
        self.ner_to_index = self._build_tag_index(["MISC"] + self.NER_TAG)  # NER tagset vector indicies

        self.nlp = spacy.load(spacy_model)  # taggers
        self.tagger = PerceptronTagger()

        self.w2v_model = None

    # ==========================================
    # INTERNAL BUILDER METHODS
    # ==========================================

    def _build_tag_index(self, tagset: list[str]) -> dict[str, int]:
        """Creates a mapping of tags to index positions."""
        return {tag: i for i, tag in enumerate(tagset) if tag not in ["O", "__BOUNDARY__"]}

    
    def build_vocabularies(self, gold_path: str, silver_path: str, full_context: str = True):
        """
        Parses the datasets to populate the class-level vocabulary matrices.
        This replaces the global counter loops from the notebook.
        """
        global_vocab = Counter()
        
        # Build Gold Vocab
        with open(gold_path, mode='r', encoding='utf-8') as file:
            tsv_reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
            for row in tsv_reader:
                label, text = self.process_row(row)
                if label not in self.LABELS: continue   # skip `not_propaganda` 
                tokens = self.tokenize_whole_words(text)

        

                if full_context:
                    global_vocab.update(tokens)
                else:    
                    in_snippet = False
                    for token in tokens:
                        if token == "<BOS>": in_snippet = True; continue
                        if token == "<EOS>": in_snippet = False; continue
                        if in_snippet:
                            global_vocab[token] += 1

        global_vocab_silver = global_vocab.copy()
                
        # Build Silver Vocab
        with open(silver_path, mode='r', encoding='utf-8') as file:
            tsv_reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
            for row in tsv_reader:
                label, text = self.process_row(row)
                if label not in self.LABELS: continue
                tokens = self.tokenize_whole_words(text) 
                
                in_snippet = False  # only draw silver counts from synthetic snippet
                for token in tokens:
                    if token == "<BOS>": in_snippet = True; continue
                    if token == "<EOS>": in_snippet = False; continue
                    if in_snippet and token in global_vocab:
                        global_vocab_silver[token] += 1

        # States
        self.hapax_words_list = [word for word, count in global_vocab.items() if count == 1]
        self.hapax_words_list_silver = [word for word, count in global_vocab_silver.items() if count == 1]
        
        gold_list = ["__UNK__"] + [word for word, count in global_vocab.items() if count > 1]
        silver_list = ["__UNK__"] + [word for word, count in global_vocab_silver.items() if count > 1]
        
        self.word_to_index = {w: i for i, w in enumerate(w for w in gold_list if w not in self.CUSTOM_STOPWORDS + ["<EOS>","<BOS>"])}
        self.word_to_index_silver = {w: i for i, w in enumerate(w for w in silver_list if w not in self.CUSTOM_STOPWORDS + ["<EOS>","<BOS>"])}
        print("Vocabulary State Successfully Initialized.")


    # ==========================================
    # FUNCTIONAL TEXT PROCESSING ZONE
    # ==========================================
    
    def universal_cleaning(self, raw_text: str) -> str:
        """Cleaning directly on raw STRING format"""
        text = raw_text.strip() # clear leading/trailing whitespace
        text = text.replace("\\'", "'").replace('\\"', '"') # strip out python escape backslashes
        text = text.replace("“", '"').replace("”", '"').replace("‘", "'").replace("’", "'") # standardize quotes to flat quotes
        text = re.sub(r"(?<=\w)'(?=\w)|(?<=[sS])'", '', text) # collapse intra-word apostrophes: won't -> wont, lukes' -> lukes
        text = re.sub(r'[\\/\[\]*|@\ \-.:$#+=]', ' ', text) # remove artifacts: \ / [ ] * | @ space - . : $ # + =
        text = text.replace("<BOS>", " <BOS> ").replace("<EOS>", " <EOS> ") # ensure space around bound tags
        return " ".join(text.split())

    def process_row(self, row: dict) -> tuple[str, str]:
        """Process raw row directly from csv"""
        return row['label'], self.universal_cleaning(row['tagged_in_context'])

    def tokenize_whole_words(self, text: str) -> list[str]:
        """Turn string text into whole-word tokens using regex parser"""
        localized_text = re.sub(r'\b\d+(?:,\d+)*\b', 'num', text)
        pattern = r"<BOS>|<EOS>|(?:[a-zA-Z]\.)+|[a-zA-Z0-9]+(?:[-']?[a-zA-Z0-9]+)*|[^\w\s]"
        raw_tokens = re.findall(pattern, localized_text)
        return [t if t in ["<BOS>", "<EOS>"] else t.lower() for t in raw_tokens]

    def tag_pos_pipeline(self, text: str) -> list[str]:
        """Turn string text into pos tokens using NLTK Perceptron"""
        tokens = self.tokenize_whole_words(text)
        raw_tags = self.tagger.tag(tokens) # nltk PerceptronTagger
        return [
            ("__BOUNDARY__") if t == "<BOS>" or t == "<EOS>" else
            ("NUM") if t.lower() == "num" else # capture num rule from string formatting
            (".") if t in ['"', "'", '`'] else # override mapping
            (map_tag('en-ptb', 'universal', tag)) # map from perceptron native pentree to universal tags
            for t, tag in raw_tags
        ]

    def tag_ner_pipeline(self, text: str) -> list[str]:
        """Turn string text into NER tokens using Spacy"""
        
        allowed = set(self.NER_TAG)
        tokens = self.tokenize_whole_words(text)

        doc = Doc(self.nlp.vocab, words=tokens)
        for name, proc in self.nlp.pipeline: doc = proc(doc)
            
        ner_tags = []
        for token in doc:
            if token.text in ["<BOS>", "<EOS>"]: ner_tags.append("__BOUNDARY__")
            elif token.ent_type_:
                # Custom NER list excludes low count tags, route these into MISC category
                ner_tags.append(f"{token.ent_type_}" if token.ent_type_ in allowed else "MISC")
            else: ner_tags.append("O")
        return ner_tags


    # ==========================================
    # VECTORIZATION ZONE
    # ==========================================

    def string_to_word2vec_vector(self, string: str, use_silver: bool = False) -> list[float]:
        """
        Turn text string into a 300D Word2Vec mean-pooled vector.
        Only processes words that exist in our learned vocabularies.
        """
        if self.w2v_model is None:
            self.load_word2vec()

        active_vocab = self.word_to_index_silver if use_silver else self.word_to_index
        tokenized = self.tokenize_whole_words(string)
        
        vectors = []
        unk_count = 0
        for token in tokenized:
            if token in ["<EOS>", "<BOS>"] or token in self.CUSTOM_STOPWORDS: continue  
            if token not in active_vocab: 
                unk_count += 1 
                continue 
                
            if token in self.w2v_model:
                vectors.append(self.w2v_model[token])
            elif token.capitalize() in self.w2v_model: # fallback check cap version
                vectors.append(self.w2v_model[token.capitalize()])
                # will not match names, punct or obsurce words
                
        if len(vectors) > 0:
            mean_vector = np.mean(vectors, axis=0).tolist() # Mean Pooling
        else:
            mean_vector = [0.0] * 300 # no match fallback
            print("empty w2v vector")
        
        unk_count = unk_count / len(tokenized) if len(tokenized) > 0 else 0.0 # normalize
            
        return mean_vector, unk_count


    def string_to_bow_vector(self, string: str, use_silver: bool = False) -> list[int]:
        """Turn text string into a vocab bow python vector"""
        active_vocab = self.word_to_index_silver if use_silver else self.word_to_index
        tokenized = self.tokenize_whole_words(string)
        sequence_vector = [0] * len(active_vocab)

        for token in tokenized:
            # avoiding counting boundaries and stopwords
            if token in ["<EOS>", "<BOS>"] or token in self.CUSTOM_STOPWORDS: continue
            
            # populate sparse vector + unk index
            idx = active_vocab.get(token, active_vocab["__UNK__"])
            sequence_vector[idx] += 1

        return sequence_vector


    def tagset_to_vector(self, string: str, tag_type: str) -> list[int]:
        """Turn text string into a tagset bow python vector"""
        if tag_type == "POS":
            tag_list = self.tag_pos_pipeline(string) 
            active_index = self.pos_to_index
        elif tag_type == "NER":
            tag_list = self.tag_ner_pipeline(string)
            active_index = self.ner_to_index

        sequence_vector = [0] * len(active_index)
        for tag in tag_list:
            if tag in ["__BOUNDARY__", "O"]: continue
            sequence_vector[active_index[tag]] += 1
        return sequence_vector


    def string_to_input_vector(
            self, 
            string_text: str, 
            use_silver: bool = False,
            feature_type: str = "bow"
            ) -> torch.Tensor:
        """
        Routes text string to the correct token vectorization method,
        generates POS/NER vectors, and concatenates them for MLP input.
        """

        # Generate token vectors
        if feature_type == "word2vec":
            text_vector, unk_count = self.string_to_word2vec_vector(string_text, use_silver)
            t_vocab = torch.tensor(text_vector + [unk_count], dtype=torch.float32)
            
        elif feature_type == "bow":
            text_vector = self.string_to_bow_vector(string_text, use_silver)
            t_vocab = torch.tensor(text_vector, dtype=torch.float32)

        # Generate tag vectors
        pos_vector = self.tagset_to_vector(string_text, "POS")
        ner_vector = self.tagset_to_vector(string_text, "NER")

        # pytorch tensor normalisation
        t_pos = torch.tensor(pos_vector, dtype=torch.float32)
        t_ner = torch.tensor(ner_vector, dtype=torch.float32)

        if feature_type == "word2vec":
            # convert tagset counts to distrubution to match w2v magnitutde
            if t_pos.sum() > 0: t_pos = t_pos / t_pos.sum()
            if t_ner.sum() > 0: t_ner = t_ner / t_ner.sum() # converts space into distribtuion

        x_combined = torch.cat([t_vocab, t_pos, t_ner], dim=0)

        return x_combined.unsqueeze(0)
    

    # ==========================================
    # LOADING ZONE
    # ==========================================

    def load_word2vec(self):
        """Pulls the pre-loaded global Word2Vec model."""
        if self.w2v_model is None:
            global GLOBAL_W2V_MODEL
            if 'GLOBAL_W2V_MODEL' in globals() and GLOBAL_W2V_MODEL is not None:
                self.w2v_model = GLOBAL_W2V_MODEL
                print("Word2Vec model successfully linked from global scope.")
            else:
                raise RuntimeError(
                    "GLOBAL_W2V_MODEL is not defined. Please run the global loading cell at the top of the notebook first."
                )

# %% [markdown]
# ---

# %% [markdown]
# ##### Example Run:

# %%
set_seed(SEED)

pipeline = PropagandaFeaturePipeline()

pipeline.build_vocabularies(
    gold_path='../data/propaganda_train_100.tsv', 
    silver_path='../data/silver_train.tsv', 
    full_context=True
)

print(f"List of corpus labels:             {pipeline.LABELS}")
print(f"Universal POS Tagset:              {pipeline.UNIVERSAL_TAGSET}")
print(f"Custom Simplified NER tagset:      {pipeline.NER_TAG}")
print(f"Custom Stopword List:              {pipeline.CUSTOM_STOPWORDS}")
print(f"Dims of baseline gold sparse vec:  {len(pipeline.word_to_index)}")
print(f"Dims of gold + silver sparse vec:  {len(pipeline.word_to_index_silver)}")
print(f"Gold Only Singletons:              {len(pipeline.hapax_words_list)}")
print(f"Silver Enriched Singletons:        {len(pipeline.hapax_words_list_silver)}")
print(f"Dims of POS vector:                {len(pipeline.pos_to_index)}")
print(f"Dimes of NER vector:               {len(pipeline.ner_to_index)}")

print(f"POS Tagger:                        {pipeline.tagger}")
print(f"NER Tagger:                        {pipeline.nlp}")


# %% [markdown]
# #### PropagandaTrainer (Class)

# %%
import csv
import torch
import torch.nn as nn
import random

class PropagandaTrainer:
    """
    Builds the standardized PyTorch MLP architecture,
    configures optimization, 
    and executes the streaming training loop.
    """
    def __init__(
        self, 
        pipeline, 
        hidden_dim: int = 64, 
        dropout_p: float = 0.3,
        lr: float = 0.0005,
        weight_decay: float = 0.05,
        use_silver: bool = False,    # vocab selector
        feature_type: str = "bow"
    ):
        self.pipeline = pipeline
        self.use_silver = use_silver
        self.feature_type = feature_type
        self.label_to_idx = {label: i for i, label in enumerate(pipeline.LABELS)}
        self.best_val_loss = float('inf')
        
        # Dynamically compute total input dimension from pipeline state
        if feature_type == "word2vec":
            self.pipeline.load_word2vec()
            token_dim = 301
        else:
            active_vocab = pipeline.word_to_index_silver if use_silver else pipeline.word_to_index
            token_dim = len(active_vocab)
        
        # token + tagset vectors
        input_dimension = (
            token_dim + 
            len(pipeline.pos_to_index) + 
            len(pipeline.ner_to_index)
        )
        
        # Build classification head
        self.model = self._build_head(
            input_dim=input_dimension,
            hidden_dim=hidden_dim,
            num_classes=len(pipeline.LABELS),
            dropout_p=dropout_p
        )
        
        # 3. Configure head components
        self.criterion = nn.CrossEntropyLoss()
        self.optimizer = torch.optim.AdamW(
            self.model.parameters(), 
            lr=lr, 
            weight_decay=weight_decay
        )

    # ==========================================
    # NETWORK BUILDER
    # ==========================================
    def _build_head(self, input_dim: int, hidden_dim: int, num_classes: int, dropout_p: float) -> nn.Module:
        """
        Constructs the standardized MLP classification head directly.
        Uses LayerNorm instead of BatchNorm1d to ensure stability during batch_size=1 streaming.
        """
        return nn.Sequential(
            nn.Linear(input_dim, hidden_dim),
            nn.ReLU(),
            nn.LayerNorm(hidden_dim),
            nn.Dropout(p=dropout_p),
            nn.Linear(hidden_dim, num_classes)
        )

    # ==========================================
    # STREAMING TRAINING PASS
    # ==========================================
    def run_training_loop(
        self, 
        dataset_path: str, 
        epochs: int = 5, 
        save_path: str = 'propaganda_mlp_weights.pt',
        save_best_only: bool = True
    ) -> list[tuple[int, float, float]]:
        """
        Executes row-by-row streaming training and 10% modulo validation.
        """

        epoch_history = []

        for epoch in range(1, epochs + 1):
            print(f"--- Starting Epoch {epoch} ---")

            running_train_loss, train_samples = 0.0, 0
            running_val_loss, val_samples = 0.0, 0

            with open(dataset_path, mode='r', encoding='utf-8') as file:
                tsv_reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
                
                for row_idx, raw_row in enumerate(tsv_reader, start=1):
                    label, text = self.pipeline.process_row(raw_row)

                    # Formatting guardrail
                    if text.count("<BOS>") != 1 or text.count("<EOS>") != 1 or label not in self.label_to_idx:
                        continue

                    # Feature Extraction
                    x_batched = self.pipeline.string_to_input_vector(text, use_silver=self.use_silver, feature_type=self.feature_type)
                    y_target = torch.tensor([self.label_to_idx[label]], dtype=torch.long)
                    
                    # 10% Modulo Split for internal dev validation
                    if row_idx % 10 == 0:
                        self.model.eval() # testing
                        with torch.no_grad():
                            logits = self.model(x_batched)
                            val_loss = self.criterion(logits, y_target)
                            running_val_loss += val_loss.item()
                            val_samples += 1
                    else:
                        self.model.train() # training
                        self.optimizer.zero_grad()
                        logits = self.model(x_batched)
                        loss = self.criterion(logits, y_target)
                        loss.backward()
                        self.optimizer.step()
                        
                        running_train_loss += loss.item()
                        train_samples += 1

            # Epoch reporting
            epoch_train_loss = running_train_loss / train_samples if train_samples > 0 else 0.0
            epoch_val_loss = running_val_loss / val_samples if val_samples > 0 else 0.0
            
            print(f"Epoch {epoch} Results | Avg Train Loss: {epoch_train_loss:.4f} | Avg Dev Loss: {epoch_val_loss:.4f}")

            epoch_history.append((epoch, round(epoch_train_loss, 4), round(epoch_val_loss, 4)))

            if save_best_only:
                # Early stopping / Best Checkpoint Behavior
                if epoch_val_loss < self.best_val_loss:
                    self.best_val_loss = epoch_val_loss
                    torch.save(self.model.state_dict(), save_path)
                    print(f"--> New best validation loss ({self.best_val_loss:.4f}) achieved! Model saved to {save_path}.\n")
                else:
                    print(f"--> No improvement on validation loss. Skipping save.\n")
            else:
                # Fixed N-Epoch Behavior: Always overwrite state dict at every epoch
                torch.save(self.model.state_dict(), save_path)
                print(f"--> Model state updated at Epoch {epoch} and saved to {save_path}.\n")
            
        return epoch_history

    # ==========================================
    # MODEL EVALUATION / INFERENCE PASS
    # ==========================================
    def evaluate(
        self, 
        dataset_path: str, 
        weights_path: str = None, 
        random_guess: bool = False
    ) -> dict:
        """
        Loads saved weights from disk and streams a test/validation file
        to return predictions, targets, and classification metrics.
        """

        # model type router, inc baseline
        if random_guess:
            random.seed(100)
            mode_name = "RANDOM GUESSING BASELINE"
        else:
            if weights_path is None:
                raise ValueError("weights_path must be provided when random_guess=False")
            mode_name = f"MODEL EVALUATION ({weights_path})"
            self.model.load_state_dict(torch.load(weights_path, weights_only=True))
            self.model.eval()

        all_preds = []
        all_targets = []
        idx_to_label = {i: label for label, i in self.label_to_idx.items()}
        num_classes = len(self.label_to_idx)

        # Stream dataset and gather predictions
        with open(dataset_path, mode='r', encoding='utf-8') as file:
            tsv_reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
            
            for row_idx, raw_row in enumerate(tsv_reader, start=1):
                label, text = self.pipeline.process_row(raw_row)

                if text.count("<BOS>") != 1 or text.count("<EOS>") != 1 or label not in self.label_to_idx:
                    continue
                
                y_target = self.label_to_idx[label]

                if random_guess:
                    predicted_idx = random.randint(0, num_classes - 1)
                else:
                    x_batched = self.pipeline.string_to_input_vector(
                        text, 
                        use_silver=self.use_silver,
                        feature_type=self.feature_type
                    )
                    with torch.no_grad():
                        logits = self.model(x_batched)
                        predicted_idx = torch.argmax(logits, dim=1).item()
                
                all_preds.append(predicted_idx)
                all_targets.append(y_target)
    
        # Calculate Performance Metrics
        from sklearn.metrics import accuracy_score, precision_recall_fscore_support, classification_report

        # Overall Metrics
        acc = accuracy_score(all_targets, all_preds)
        precision, recall, f1, _ = precision_recall_fscore_support(
            all_targets, all_preds, average='macro', zero_division=0
        )

        print("\n" + "="*50)
        print(f" EVALUATION REPORT: {weights_path}")
        print("="*50)
        print(f" Accuracy:  {acc:.4f}")
        print(f" Macro Precision: {precision:.4f}")
        print(f" Macro Recall:    {recall:.4f}")
        print(f" Macro F1 Score:  {f1:.4f}")
        print("="*50 + "\n")

        # Detailed per-class breakdown
        target_names = [idx_to_label[i] for i in sorted(idx_to_label.keys())]
        print(classification_report(all_targets, all_preds, target_names=target_names, zero_division=0))

        return {
            "accuracy": acc,
            "macro_f1": f1,
            "predictions": [idx_to_label[p] for p in all_preds],
            "targets": [idx_to_label[t] for t in all_targets]
        }

# %% [markdown]
# ---

# %% [markdown]
# ##### Example run:

# %%
set_seed(SEED)

# 1. Initialize and build feature pipeline state
test_pipeline = PropagandaFeaturePipeline()
test_pipeline.build_vocabularies(
    gold_path='../data/propaganda_train.tsv', 
    silver_path='../data/silver_train.tsv'
)

# 2. Instantiate trainer
test_trainer = PropagandaTrainer(
    pipeline=test_pipeline,
    hidden_dim=64,
    dropout_p=0.3,
    lr=0.0005,
    weight_decay=0.05,
    use_silver=False,
    feature_type="bow"
)

# 3. Launch dynamic training pass
test_trainer.run_training_loop(
    dataset_path='../data/propaganda_train_100.tsv',
    epochs=3,
    save_path='test_propaganda_mlp_weights.pt'
)

# %% [markdown]
# ---

# %% [markdown]
# ### Evaluation

# %% [markdown]
# 1. [Random Guessing Baseline]()
# ---
# 1. [BoW: Full Context, Gold Only](#bow-baseline-full-context-gold-only)
# 2. [BoW: Full Context, Silver Enriched]()
# 3. [BoW: Snippet, Gold Only]()
# 4. [BoW: Snippet, Silver Enriched]()
# ---
# 1. [W2V: Full Context, Gold Only]()
# 2. [W2V: Full Context, Silver Enriched]()
# 3. [W2V: Snippet, Gold Only]()
# 4. [W2V: Snippet, Silver Enriched]()
# ---

# %% [markdown]
# #### Random Guessing Baseline

# %%
set_seed(SEED)

# Instantiate trainer shell (reuses pipeline setup)
eval_trainer = PropagandaTrainer(pipeline=pipeline)

# 1. Random Guessing Baseline Evaluation
random_results = eval_trainer.evaluate(
    dataset_path='../data/propaganda_val.tsv',
    random_guess=True
)

# %% [markdown]
# #### BoW Experiments

# %% [markdown]
# ##### HyperParameter Sweep: BoW Baseline

# %%
import itertools

set_seed(SEED)

pipeline = PropagandaFeaturePipeline()
pipeline.build_vocabularies(
    gold_path='../data/propaganda_train.tsv', 
    silver_path='../data/silver_train.tsv',
    full_context=True
)

# 2. Parameter Search Ranges
param_grid = {
    'hidden_dim': [64, 128],
    'lr': [0.001, 0.0005, 0.0001],
    'dropout_p': [0.3, 0.5]
}

# 3. Generate Cartesian combinations
keys, values = zip(*param_grid.items())
experiments = [dict(zip(keys, v)) for v in itertools.product(*values)]

# Tracking metrics
global_best_loss = float('inf')
best_config = None
sweep_results = []

USE_SILVER = False

# 4. Execute Hyperparameter Sweep
for run_id, config in enumerate(experiments, start=1):
    print(f"\n==================================================")
    print(f" SWEEP RUN {run_id}/{len(experiments)} | {config}")
    print(f"==================================================")

    set_seed(SEED)
    
    trainer = PropagandaTrainer(
        pipeline=pipeline,
        hidden_dim=config["hidden_dim"],
        dropout_p=config["dropout_p"],
        lr=config["lr"],
        use_silver=USE_SILVER    # vocab
    )

    save_filename = f"./param_sweep/sweep_gold_run_{run_id}.pt"

    epoch_tuples = trainer.run_training_loop(
        dataset_path='../data/propaganda_train.tsv',
        epochs=5,
        save_path=save_filename,
        save_best_only=True
    )

    # Capture overall top-performing configuration
    if trainer.best_val_loss < global_best_loss:
        global_best_loss = trainer.best_val_loss
        best_config = config
        print(f"🔥 NEW BEST MODEL FOUND! Dev Loss: {global_best_loss:.4f}")

    run_row = [
        run_id,
        config["hidden_dim"],
        config["lr"],
        config["dropout_p"],
        USE_SILVER,
        epoch_tuples  # Contains [(1, train_l, dev_l), (2, train_l, dev_l), ...]
    ]

    sweep_results.append(run_row)

print("\n" + "="*50)
print(f"SWEEP COMPLETE!")
print(f"Lowest Validation Loss: {global_best_loss:.4f}")
print(f"Optimal Hyperparameter Set: {best_config}")
print("="*50)

# ========================================================
# Save Sweep Results Directly to CSV File
# ========================================================
csv_filename = "./param_sweep/sweep_results_gold.csv"
with open(csv_filename, mode="w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)
    
    # 1. Construct the header dynamically
    header = ["run_id", "hidden_dim", "lr", "dropout_p", "use_silver"]
    # Add columns for up to 5 epochs
    for i in range(1, 6):
        header.extend([f"train_loss_{i}", f"val_loss_{i}"])
    
    writer.writerow(header)
    
    # 2. Flatten the data for each run
    for row in sweep_results:
        run_id, hidden, lr, dropout, silver, history = row
        
        # Start the flat row with your metadata
        flat_row = [run_id, hidden, lr, dropout, silver]
        
        # Extract losses from each epoch tuple (epoch, train, val)
        for epoch_data in history:
            _, train_loss, val_loss = epoch_data
            flat_row.extend([train_loss, val_loss])
            
        writer.writerow(flat_row)

print(f"\nSweep complete, saved {len(sweep_results)} to '{csv_filename}'.")


# %%
HIDDEN_DIMS = 128
LR = 0.0001
DROPOUT = 0.5
EPOCHS = 3

# %% [markdown]
# ##### BoW Baseline: Full Context, Gold Only

# %%
import os
model_dir = './final_models'
os.makedirs(model_dir, exist_ok=True)

set_seed(SEED)

FULL_CONTEXT = True
USE_SILVER = False

MODEL_SAVE = 'bow_full_gold'

bow_full_gold_pipeline = PropagandaFeaturePipeline()
bow_full_gold_pipeline.build_vocabularies(
    gold_path='../data/propaganda_train.tsv', 
    silver_path='../data/silver_train.tsv',
    full_context=FULL_CONTEXT
)

print(f"Dims of baseline gold sparse vec:  {len(bow_full_gold_pipeline.word_to_index)}")
print(f"Dims of gold + silver sparse vec:  {len(bow_full_gold_pipeline.word_to_index_silver)}")
print(f"Gold Only Singletons:              {len(bow_full_gold_pipeline.hapax_words_list)}")
print(f"Silver Enriched Singletons:        {len(bow_full_gold_pipeline.hapax_words_list_silver)}")
print(f"Dims of POS vector:                {len(bow_full_gold_pipeline.pos_to_index)}")
print(f"Dimes of NER vector:               {len(bow_full_gold_pipeline.ner_to_index)}")

bow_full_gold_eval_trainer = PropagandaTrainer(
    pipeline=bow_full_gold_pipeline,
    hidden_dim=HIDDEN_DIMS,
    dropout_p=DROPOUT,
    lr = LR,
    weight_decay=0.05,
    use_silver=USE_SILVER
)

# training pass
set_seed(SEED)
bow_full_gold_eval_trainer.run_training_loop(
    dataset_path='../data/propaganda_train.tsv',
    epochs=EPOCHS,
    save_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    save_best_only=False    # save final
)

print(f"The results of the {MODEL_SAVE} model on the validation set:")

bow_full_gold_val_results = bow_full_gold_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_val.tsv'
)

print(f"{'==='*10}")
print(f"")

print(f"The results of the {MODEL_SAVE} model on the training set:")

bow_full_gold_train_results = bow_full_gold_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_train.tsv'
)

print(f"{'==='*10}")

# %% [markdown]
# ##### BoW Baseline: Snippet, Gold Only

# %%
import os
model_dir = './final_models'
os.makedirs(model_dir, exist_ok=True)

set_seed(SEED)

FULL_CONTEXT = False     # Snippet-only
USE_SILVER = False

MODEL_SAVE = 'bow_snippet_gold'

bow_snippet_gold_pipeline = PropagandaFeaturePipeline()

bow_snippet_gold_pipeline.build_vocabularies(
    gold_path='../data/propaganda_train.tsv', 
    silver_path='../data/silver_train.tsv',
    full_context=FULL_CONTEXT
)

print(f"Dims of baseline gold sparse vec:  {len(bow_snippet_gold_pipeline.word_to_index)}")
print(f"Dims of gold + silver sparse vec:  {len(bow_snippet_gold_pipeline.word_to_index_silver)}")
print(f"Gold Only Singletons:              {len(bow_snippet_gold_pipeline.hapax_words_list)}")
print(f"Silver Enriched Singletons:        {len(bow_snippet_gold_pipeline.hapax_words_list_silver)}")
print(f"Dims of POS vector:                {len(bow_snippet_gold_pipeline.pos_to_index)}")
print(f"Dimes of NER vector:               {len(bow_snippet_gold_pipeline.ner_to_index)}")

bow_snippet_gold_eval_trainer = PropagandaTrainer(
    pipeline=bow_snippet_gold_pipeline,
    hidden_dim=HIDDEN_DIMS,
    dropout_p=DROPOUT,
    lr = LR,
    weight_decay=0.05,
    use_silver=USE_SILVER
)

# training pass
set_seed(SEED)
bow_snippet_gold_eval_trainer.run_training_loop(
    dataset_path='../data/propaganda_train.tsv',
    epochs=EPOCHS,
    save_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    save_best_only=False    # save final
)

print(f"The results of the {MODEL_SAVE} model on the validation set:")

bow_snippet_gold_val_results = bow_snippet_gold_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_val.tsv'
)

print(f"{'==='*10}")
print(f"")

print(f"The results of the {MODEL_SAVE} model on the training set:")

bow_snippet_gold_train_results = bow_snippet_gold_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_train.tsv'
)

print(f"{'==='*10}")

# %% [markdown]
# ##### BoW Baseline: Full Context, Silver Enriched

# %%
import os
model_dir = './final_models'
os.makedirs(model_dir, exist_ok=True)

set_seed(SEED)

FULL_CONTEXT = True
USE_SILVER = True

MODEL_SAVE = 'bow_full_silver'

bow_full_silver_pipeline = PropagandaFeaturePipeline()

bow_full_silver_pipeline.build_vocabularies(
    gold_path='../data/propaganda_train.tsv', 
    silver_path='../data/silver_train.tsv',
    full_context=FULL_CONTEXT
)

print(f"Dims of baseline gold sparse vec:  {len(bow_full_silver_pipeline.word_to_index)}")
print(f"Dims of gold + silver sparse vec:  {len(bow_full_silver_pipeline.word_to_index_silver)}")
print(f"Gold Only Singletons:              {len(bow_full_silver_pipeline.hapax_words_list)}")
print(f"Silver Enriched Singletons:        {len(bow_full_silver_pipeline.hapax_words_list_silver)}")
print(f"Dims of POS vector:                {len(bow_full_silver_pipeline.pos_to_index)}")
print(f"Dimes of NER vector:               {len(bow_full_silver_pipeline.ner_to_index)}")

bow_full_silver_eval_trainer = PropagandaTrainer(
    pipeline=bow_full_silver_pipeline,
    hidden_dim=HIDDEN_DIMS,
    dropout_p=DROPOUT,
    lr = LR,
    weight_decay=0.05,
    use_silver=USE_SILVER
)

# training pass
set_seed(SEED)
bow_full_silver_eval_trainer.run_training_loop(
    dataset_path='../data/propaganda_train.tsv',
    epochs=EPOCHS,
    save_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    save_best_only=False    # save final
)


print(f"The results of the {MODEL_SAVE} model on the validation set:")

bow_full_silver_val_results = bow_full_silver_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_val.tsv'
)

print(f"{'==='*10}")
print(f"")

print(f"The results of the {MODEL_SAVE} model on the training set:")

bow_full_silver_train_results = bow_full_silver_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_train.tsv'
)

print(f"{'==='*10}")

# %% [markdown]
# ##### BoW Baseline: Snippet, Silver Enriched

# %%
import os
model_dir = './final_models'
os.makedirs(model_dir, exist_ok=True)

set_seed(SEED)

FULL_CONTEXT = False
USE_SILVER = True

MODEL_SAVE = 'bow_snippet_silver'

bow_snippet_silver_pipeline = PropagandaFeaturePipeline()

bow_snippet_silver_pipeline.build_vocabularies(
    gold_path='../data/propaganda_train.tsv', 
    silver_path='../data/silver_train.tsv',
    full_context=FULL_CONTEXT
)

print(f"Dims of baseline gold sparse vec:  {len(bow_snippet_silver_pipeline.word_to_index)}")
print(f"Dims of gold + silver sparse vec:  {len(bow_snippet_silver_pipeline.word_to_index_silver)}")
print(f"Gold Only Singletons:              {len(bow_snippet_silver_pipeline.hapax_words_list)}")
print(f"Silver Enriched Singletons:        {len(bow_snippet_silver_pipeline.hapax_words_list_silver)}")
print(f"Dims of POS vector:                {len(bow_snippet_silver_pipeline.pos_to_index)}")
print(f"Dimes of NER vector:               {len(bow_snippet_silver_pipeline.ner_to_index)}")

bow_snippet_silver_eval_trainer = PropagandaTrainer(
    pipeline=bow_snippet_silver_pipeline,
    hidden_dim=HIDDEN_DIMS,
    dropout_p=DROPOUT,
    lr = LR,
    weight_decay=0.05,
    use_silver=USE_SILVER
)

# training pass
set_seed(SEED)
bow_snippet_silver_eval_trainer.run_training_loop(
    dataset_path='../data/propaganda_train.tsv',
    epochs=EPOCHS,
    save_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    save_best_only=False    # save final
)

print(f"The results of the {MODEL_SAVE} model on the validation set:")

bow_snippet_silver_val_results = bow_snippet_silver_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_val.tsv'
)

print(f"{'==='*10}")
print(f"")

print(f"The results of the {MODEL_SAVE} model on the training set:")

bow_snippet_silver_train_results = bow_snippet_silver_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_train.tsv'
)

print(f"{'==='*10}")

# %% [markdown]
# #### Word2Vec Experiments

# %% [markdown]
# ##### Hyperparameter Sweep: Word2Vec

# %%
import itertools
import csv

# 1. Pipeline Initialization & Vocab Construction
set_seed(SEED)

w2v_sweep_pipeline = PropagandaFeaturePipeline()
w2v_sweep_pipeline.build_vocabularies(
    gold_path='../data/propaganda_train.tsv', 
    silver_path='../data/silver_train.tsv',
    full_context=True
)

# 2. Search Grid Specifically Tailored for Dense Word2Vec Embeddings
param_grid = {
    'hidden_dim': [64, 128],
    'lr': [0.005, 0.001, 0.0005],
    'dropout_p': [0.3, 0.5]
}

# 3. Cartesian Product Combinations
keys, values = zip(*param_grid.items())
experiments = [dict(zip(keys, v)) for v in itertools.product(*values)]

# Track Metrics
global_best_loss = float('inf')
best_config = None
w2v_sweep_results = []

USE_SILVER = False
FEATURE_TYPE = "word2vec"
EPOCHS = 5

# 4. Execute Sweep
for run_id, config in enumerate(experiments, start=1):
    print(f"\n==================================================")
    print(f" WORD2VEC SWEEP RUN {run_id}/{len(experiments)} | {config}")
    print(f"==================================================")

    # Lock seed per run so every network configuration starts with identical weight initialization
    set_seed(SEED)
    
    trainer = PropagandaTrainer(
        pipeline=w2v_sweep_pipeline,
        hidden_dim=config["hidden_dim"],
        dropout_p=config["dropout_p"],
        lr=config["lr"],
        use_silver=USE_SILVER,
        feature_type=FEATURE_TYPE
    )

    save_filename = f"./param_sweep/sweep_w2v_gold_run_{run_id}.pt"

    epoch_tuples = trainer.run_training_loop(
        dataset_path='../data/propaganda_train.tsv',
        epochs=EPOCHS,
        save_path=save_filename,
        save_best_only=True
    )

    # Capture overall top-performing configuration
    if trainer.best_val_loss < global_best_loss:
        global_best_loss = trainer.best_val_loss
        best_config = config
        print(f"🔥 NEW BEST WORD2VEC MODEL FOUND! Dev Loss: {global_best_loss:.4f}")

    run_row = [
        run_id,
        config["hidden_dim"],
        config["lr"],
        config["dropout_p"],
        USE_SILVER,
        epoch_tuples  # [(epoch, train_loss, dev_loss), ...]
    ]

    w2v_sweep_results.append(run_row)

print("\n" + "="*50)
print(f"WORD2VEC SWEEP COMPLETE!")
print(f"Lowest Validation Loss: {global_best_loss:.4f}")
print(f"Optimal Hyperparameter Set: {best_config}")
print("="*50)

# %%
W2W_HIDDEN_DIMS = 64
W2W_LR = 0.0005
W2W_DROPOUT = 0.5
W2W_EPOCHS = 5

# %% [markdown]
# ##### Word2Vec: Full Context, Gold Only

# %%
import os
model_dir = './final_models'
os.makedirs(model_dir, exist_ok=True)

set_seed(SEED)

FULL_CONTEXT = True
USE_SILVER = False
FEATURE_TYPE = "word2vec"
MODEL_SAVE = 'w2v_full_gold'

# 1. Initialize Pipeline & Build Vocabularies
w2v_full_gold_pipeline = PropagandaFeaturePipeline()
w2v_full_gold_pipeline.build_vocabularies(
    gold_path='../data/propaganda_train.tsv', 
    silver_path='../data/silver_train.tsv',
    full_context=FULL_CONTEXT
)

# 2. Instantiate Trainer with Word2Vec feature type
w2v_full_gold_eval_trainer = PropagandaTrainer(
    pipeline=w2v_full_gold_pipeline,
    hidden_dim=W2W_HIDDEN_DIMS,
    dropout_p=W2W_DROPOUT,
    lr=W2W_LR,
    weight_decay=0.05,
    use_silver=USE_SILVER,
    feature_type=FEATURE_TYPE
)

# 3. Training Pass
set_seed(SEED)
w2v_full_gold_eval_trainer.run_training_loop(
    dataset_path='../data/propaganda_train.tsv',
    epochs=W2W_EPOCHS,
    save_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    save_best_only=False
)

# 4. Evaluation
print(f"The results of the {MODEL_SAVE} model on the validation set:")
w2v_full_gold_val_results = w2v_full_gold_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_val.tsv'
)

print(f"{'===='+'===='+'=='}\n")
print(f"The results of the {MODEL_SAVE} model on the training set:")
w2v_full_gold_train_results = w2v_full_gold_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_train.tsv'
)
print(f"{'===='+'===='+'=='}")

# %% [markdown]
# ##### Word2Vec: Snippet, Gold Only

# %%
import os
model_dir = './final_models'
os.makedirs(model_dir, exist_ok=True)

set_seed(SEED)

FULL_CONTEXT = False
USE_SILVER = False
FEATURE_TYPE = "word2vec"
MODEL_SAVE = 'w2v_snippet_gold'

# 1. Initialize Pipeline & Build Vocabularies
w2v_snippet_gold_pipeline = PropagandaFeaturePipeline()
w2v_snippet_gold_pipeline.build_vocabularies(
    gold_path='../data/propaganda_train.tsv', 
    silver_path='../data/silver_train.tsv',
    full_context=FULL_CONTEXT
)

# 2. Instantiate Trainer with Word2Vec feature type
w2v_snippet_gold_eval_trainer = PropagandaTrainer(
    pipeline=w2v_snippet_gold_pipeline,
    hidden_dim=W2W_HIDDEN_DIMS,
    dropout_p=W2W_DROPOUT,
    lr=W2W_LR,
    weight_decay=0.05,
    use_silver=USE_SILVER,
    feature_type=FEATURE_TYPE
)

# 3. Training Pass
set_seed(SEED)
w2v_snippet_gold_eval_trainer.run_training_loop(
    dataset_path='../data/propaganda_train.tsv',
    epochs=W2W_EPOCHS,
    save_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    save_best_only=False
)

# 4. Evaluation
print(f"The results of the {MODEL_SAVE} model on the validation set:")
w2v_snippet_gold_val_results = w2v_snippet_gold_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_val.tsv'
)

print(f"{'===='+'===='+'=='}\n")
print(f"The results of the {MODEL_SAVE} model on the training set:")
w2v_snippet_gold_train_results = w2v_snippet_gold_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_train.tsv'
)
print(f"{'===='+'===='+'=='}")

# %% [markdown]
# ##### Word2Vec: Full Context, Silver Enriched

# %%
import os
model_dir = './final_models'
os.makedirs(model_dir, exist_ok=True)

set_seed(SEED)

FULL_CONTEXT = True
USE_SILVER = True
FEATURE_TYPE = "word2vec"
MODEL_SAVE = 'w2v_full_silver'

# 1. Initialize Pipeline & Build Vocabularies
w2v_full_silver_pipeline = PropagandaFeaturePipeline()
w2v_full_silver_pipeline.build_vocabularies(
    gold_path='../data/propaganda_train.tsv', 
    silver_path='../data/silver_train.tsv',
    full_context=FULL_CONTEXT
)

# 2. Instantiate Trainer with Word2Vec feature type
w2v_full_silver_eval_trainer = PropagandaTrainer(
    pipeline=w2v_full_silver_pipeline,
    hidden_dim=W2W_HIDDEN_DIMS,
    dropout_p=W2W_DROPOUT,
    lr=W2W_LR,
    weight_decay=0.05,
    use_silver=USE_SILVER,
    feature_type=FEATURE_TYPE
)

# 3. Training Pass
set_seed(SEED)
w2v_full_silver_eval_trainer.run_training_loop(
    dataset_path='../data/propaganda_train.tsv',
    epochs=W2W_EPOCHS,
    save_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    save_best_only=False
)

# 4. Evaluation
print(f"The results of the {MODEL_SAVE} model on the validation set:")
w2v_full_silver_val_results = w2v_full_silver_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_val.tsv'
)

print(f"{'===='+'===='+'=='}\n")
print(f"The results of the {MODEL_SAVE} model on the training set:")
w2v_full_silver_train_results = w2v_full_silver_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_train.tsv'
)
print(f"{'===='+'===='+'=='}")

# %% [markdown]
# ##### Word2Vec: Snippet, Silver Enriched

# %%
import os
model_dir = './final_models'
os.makedirs(model_dir, exist_ok=True)

set_seed(SEED)

FULL_CONTEXT = False
USE_SILVER = True
FEATURE_TYPE = "word2vec"
MODEL_SAVE = 'w2v_snippet_silver'

# 1. Initialize Pipeline & Build Vocabularies
w2v_snippet_silver_pipeline = PropagandaFeaturePipeline()
w2v_snippet_silver_pipeline.build_vocabularies(
    gold_path='../data/propaganda_train.tsv', 
    silver_path='../data/silver_train.tsv',
    full_context=FULL_CONTEXT
)

# 2. Instantiate Trainer with Word2Vec feature type
w2v_snippet_silver_eval_trainer = PropagandaTrainer(
    pipeline=w2v_snippet_silver_pipeline,
    hidden_dim=W2W_HIDDEN_DIMS,
    dropout_p=W2W_DROPOUT,
    lr=W2W_LR,
    weight_decay=0.05,
    use_silver=USE_SILVER,
    feature_type=FEATURE_TYPE
)

# 3. Training Pass
set_seed(SEED)
w2v_snippet_silver_eval_trainer.run_training_loop(
    dataset_path='../data/propaganda_train.tsv',
    epochs=W2W_EPOCHS,
    save_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    save_best_only=False
)

# 4. Evaluation
print(f"The results of the {MODEL_SAVE} model on the validation set:")
w2v_snippet_silver_val_results = w2v_snippet_silver_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_val.tsv'
)

print(f"{'===='+'===='+'=='}\n")
print(f"The results of the {MODEL_SAVE} model on the training set:")
w2v_snippet_silver_train_results = w2v_snippet_silver_eval_trainer.evaluate(
    weights_path=f'./final_models/{MODEL_SAVE}_weights.pt',
    dataset_path='../data/propaganda_train.tsv'
)
print(f"{'===='+'===='+'=='}")

# %% [markdown]
# ## Task 2

# %% [markdown]
# 1. [Installations](#installations)
# 2. [Imports & Global Configurations](#imports--global-configuration)
# 3. [Data Processing Class](#data-processing-class)
# 4. [Evaluation Logic Class](#evaluation-logic-class)
# 5. [Architecture Class](#architecture-class)
# 6. [Execuation Class (Train, Eval, Viterbi)](#execution-class-training-eval-viterbi)
# ---
# 7. [Baseline (Class, Results, Analysis)]()
#     - [Baseline Class](#base-class)
#     - [Baseline Results](#base-results)
#     - [Baseline Analysis](#base-analysis)
# ---
# 8. [Variation 2: 17-Class Integrated Joint Tagger]()
#     - [Var2 Hyperparameter Sweep]()
#     - [Var2 Training & Eval]()
# ---
# 9. [Variation 1: Decoupled (Span Detection Model + Technique Classifer Model)]()
#     - [Independent Classifer Head]()
#     - [Span Detector Training (Var2 Hyperparams Carried Over)]()
#     - [Span Detection Hyperparameter Tuning]()
#     - [Span Detection Training]()
#     - [Span Detection Only Evaluation]()
#     - [End-to-End Pipeline Evaluation]()
# ---
# 10. [Analysis]()
# ---

# %% [markdown]
# #### Installations

# %%
# ==========================================
# CELL 1: Installations
# ==========================================
%pip install -q transformers sentencepiece
%pip install -q pytorch-crf
%pip install -q scikit-learn
%pip install -q tiktoken
%pip install protobuf sentencepiece

# %% [markdown]
# #### Imports & Global Configuration

# %%
import os
os.environ["PYTORCH_ENABLE_MPS_FALLBACK"] = "1"

import re
import csv
import torch
import random
import string
import numpy as np
import torch.nn as nn
from transformers import AutoTokenizer, DebertaV2Model
from torchcrf import CRF
from sklearn.metrics import precision_recall_fscore_support, classification_report

# Define global device for M1 GPU acceleration ---
device = torch.device("mps" if torch.backends.mps.is_available() else "cpu")
print(f"Using device: {device}")

def set_seed(seed: int = 142):
    """Seed Logic for Reproducibility"""
    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    if torch.cuda.is_available():
        torch.cuda.manual_seed_all(seed)
        torch.backends.cudnn.deterministic = True
        torch.backends.cudnn.benchmark = False
    print(f"Global seed set to {seed}")

SEED = 142
set_seed(SEED)

# Task 2 Label Schemas
TECHNIQUES = [
    'flag_waving', 'appeal_to_fear_prejudice', 'causal_oversimplification', 
    'doubt', 'loaded_language', 'name_calling,labeling', 
    'repetition', 'exaggeration,minimisation'
]

# Variation 1 Tagset (3-Class Boundary Detection)
BIO_3_CLASS = ['O', 'B-Propaganda', 'I-Propaganda']
V1_TAG_TO_IDX = {tag: i for i, tag in enumerate(BIO_3_CLASS)}
V1_IDX_TO_TAG = {i: tag for tag, i in V1_TAG_TO_IDX.items()}

# Variation 2 Tagset (17-Class Joint Detection)
BIO_17_CLASS = ['O'] + [f"B-{t}" for t in TECHNIQUES] + [f"I-{t}" for t in TECHNIQUES]
V2_TAG_TO_IDX = {tag: i for i, tag in enumerate(BIO_17_CLASS)}
V2_IDX_TO_TAG = {i: tag for tag, i in V2_TAG_TO_IDX.items()}

# Classifier Head Tagset
TECH_TO_IDX = {tech: i for i, tech in enumerate(TECHNIQUES)}
IDX_TO_TECH = {i: tech for tech, i in TECH_TO_IDX.items()}

# %% [markdown]
# #### Data Processing Class

# %%
class Task2DataPipeline:
    """
    Processes raw TSV rows into DeBERTa subword encodings and aligned BIO tags.
    Handles <BOS> and <EOS> markers present across all rows (including not_propaganda).
    """
    def __init__(self, model_checkpoint="microsoft/deberta-v3-xsmall"):
        self.tokenizer = AutoTokenizer.from_pretrained(model_checkpoint)
        
    def universal_cleaning_t2(self, raw_text: str) -> str:
        """Cleans text while preserving case and punctuation for Transformer context."""
        text = raw_text.strip()
        text = text.replace("\\'", "'").replace('\\"', '"') # Escape characters
        text = text.replace("“", '"').replace("”", '"').replace("‘", "'").replace("’", "'")
        text = re.sub(r'[\\/\[\]*|@$#+=]', ' ', text) # Strip digital artifacts
        return " ".join(text.split())

    def parse_span_and_clean(self, raw_text: str, label: str):
        """
        Extracts exact character offsets of the snippet bounded by <BOS>/<EOS>.
        Every row in the dataset contains <BOS>/<EOS> tags.
        is_active_propaganda is True ONLY if the row's label is NOT 'not_propaganda'.
        """
        text = self.universal_cleaning_t2(raw_text)
        
        bos_idx = text.find("<BOS>")
        eos_idx = text.find("<EOS>")
        
        # Where tag boundaries are found, extract the exact character indices
        if bos_idx != -1 and eos_idx != -1:
            pre_bos = text[:bos_idx]
            inside = text[bos_idx+5:eos_idx]    # +5 to skip over '<BOS>' string length
            post_eos = text[eos_idx+5:]         # +5 to skip over '<EOS>' string length
            
            clean_text = pre_bos + inside + post_eos    # no tags
            char_start = len(pre_bos)                   # character index where snippet starts
            char_end = len(pre_bos) + len(inside)       # character index where snippet end
            
            is_active_propaganda = 1.0 if label != 'not_propaganda' else 0.0
        else:
            # Fallback if input data is incorrecct
            print("ERROR: Instance has no tags")
            clean_text = text.replace("<BOS>", "").replace("<EOS>", "")
            char_start, char_end = -1, -1
            is_active_propaganda = 0.0
            
        return clean_text, char_start, char_end, is_active_propaganda

    def align_bio_tags(self, clean_text: str, char_start: int, char_end: int, label: str, mode: str):
        """
        Tokenizes clean_text and aligns subword offset mappings to character spans.
        self.tokenizer = AutoTokenizer
        If label == 'not_propaganda', all tokens are assigned the 'O' tag (ID 0).
        """

        # SentencePeice DeBERTA native subword tokenizer
        encoding = self.tokenizer(
            clean_text, 
            return_offsets_mapping=True,    # char location of tokenz
            truncation=True, 
            max_length=512,
            return_tensors="pt"
        )
        
        # Obtain the token to character indices mappings: [(start,end)]
        offsets = encoding['offset_mapping'][0].tolist()
        
        tag_ids = []
        is_in_span = False
        
        for idx, (o_start, o_end) in enumerate(offsets):
            if o_start == o_end: # zero-length tokens or special boundary: [CLS], [SEP], Padding
                tag_ids.append(0)
                continue
                
            # Assign B-/I- tags ONLY if label is an active propaganda technique
            if (label != 'not_propaganda' and 
                char_start != -1 and    # real token only
                char_start <= o_start   # start of token is within span start
                and o_end <= char_end   # end of token is within span end
                ):

                if not is_in_span:  # First instance of propaganda
                    tag = "B-Propaganda" if mode == "var1" else f"B-{label}"
                    is_in_span = True   # Update tracker
                else:
                    tag = "I-Propaganda" if mode == "var1" else f"I-{label}"
                    is_in_span = True
                
                tag_map = V1_TAG_TO_IDX if mode == "var1" else V2_TAG_TO_IDX
                tag_ids.append(tag_map.get(tag, 0))     # convert tags to numerical ID

                # this tagging process will contine appending I- until `o_end <= char_end` is breached

            else:
                tag_ids.append(0) # 'O' tag for non-propaganda text or outside span
                is_in_span = False

        input_ids = encoding['input_ids']                           # map to SP vocabulary
        attention_mask = encoding['attention_mask']                 # 1's for words, 0 for specials [SEP, CLS, Padding]
        tags_tensor = torch.tensor([tag_ids], dtype=torch.long)     # convert to pytorch format
        
        # Ensure input_ids, attention_mask, and tag_ids match in sequence length
        assert input_ids.shape[1] == attention_mask.shape[1] == tags_tensor.shape[1], (
            f"Dimension mismatch! input_ids: {input_ids.shape[1]}, "
            f"attention_mask: {attention_mask.shape[1]}, tags: {tags_tensor.shape[1]}"
        )
                
        return input_ids, attention_mask, tags_tensor

# %% [markdown]
# #### Evaluation Logic Class

# %%
# ==========================================
# CELL 4: Cascading Window Qualification Router (Evaluation)
# ==========================================

class Task2Evaluator:
    
    @staticmethod
    def get_tolerance(span_length: int) -> int:
        """helper function for span evaluation router with slightly increased tolerance"""
        if span_length <= 5: return 1
        elif span_length <= 10: return 2
        elif span_length <= 15: return 3
        elif span_length <= 50: return 3 + ((span_length - 11) // 5)
        else: return 12

    @staticmethod
    def evaluate_predictions(gold_data: list, pred_data: list):
        """
        input gold_data/pred_data format: [{"span": (start_idx, end_idx), "technique": "doubt"}, ...]
        
        Returns:
            - Tuple: (metrics_dict, classification_report_str)
        """
        y_true = []
        y_pred = []
        error_logs = []  # verbose capture of errors
        
        for gold, pred in zip(gold_data, pred_data):
            
            # ==========================================
            # --- Condition 1: True Negative (TN)    ---
            # ---  * Gold instance is not_propaganda ---
            # ---  * Model did not predict a span    ---
            # ==========================================
            if gold["technique"] == "not_propaganda" and pred["span"] == (-1, -1):
                continue  # True Negative, ignored in Macro-F1
            
            # ==========================================
            # --- Condition 2: False Positive (FP)   ---
            # ---  * Gold instance is not_propaganda ---
            # ---  * Model predicted a span    ---
            # ==========================================
            if gold["technique"] == "not_propaganda" and pred["span"] != (-1, -1):
                y_true.append("not_propaganda")
                y_pred.append(pred["technique"])
                error_logs.append({"error": "Hallucinated Span", "pred": pred})
                continue
            
            # ==========================================
            # --- Condition 3: False Negative (FN)   ---
            # ---  * Gold instance is propaganda     ---
            # ---  * Model did not predict a span    ---
            # ==========================================
            if gold["technique"] != "not_propaganda" and pred["span"] == (-1, -1):
                y_true.append(gold["technique"])
                y_pred.append("not_propaganda")
                error_logs.append({"error": "Missed Span", "gold": gold})
                continue

            # =============================================
            # --- Condition 4: Cascading Window Router  ---
            # --- Potential for True Positive (TP)      ---
            # ---  * Gold instance is propaganda        ---
            # ---  * model predicted an active span     ---
            # =============================================
            g_start, g_end = gold["span"]
            p_start, p_end = pred["span"]
            gold_len = g_end - g_start + 1      # +1 for inclusive bounds
            delta = Task2Evaluator.get_tolerance(gold_len)
            
            # =================================================
            # --- Boundary Qualified                        ---
            # --- True Positive (TP) or False Positive (FP) ---
            # =================================================
            if abs(p_start - g_start) <= delta and abs(p_end - g_end) <= delta:
                y_true.append(gold["technique"])    # Capacity for True Positive (TP)
                y_pred.append(pred["technique"])    # If the prediction is wrong then it appends a False Positive (FP)
                if gold["technique"] != pred["technique"]:  
                    # Capacity for FP/FN despite qualifying: Span correct but wrong technique predicted
                    error_logs.append({"error": "Technique Misclassification", "gold": gold, "pred": pred})

            # ===================================================
            # --- Boundary Disqualified (Double Penalty)      ---
            # --- False Positive (FP) and False Negative (FN) ---
            # ===================================================
            else:
                left_failed = abs(p_start - g_start) > delta
                right_failed = abs(p_end - g_end) > delta
                
                # Logging Subtype Failure: Fail Side
                if left_failed and right_failed:
                    failure_subtype = "Boundary Failure: Both Left and Right"
                elif left_failed:
                    failure_subtype = "Boundary Failure: Left Only (Start Offset)"
                else:
                    failure_subtype = "Boundary Failure: Right Only (End Offset)"

                # ===================================
                # --- Double Counting the Failure --- 
                # ===================================
                y_true.append(gold["technique"])
                y_pred.append("not_propaganda")  # FN for target
                # A failing span is the equivalent to a not_propaganda prediction 
                # As it couldnt find the **correct** span
                # But there was a target which needs which needs a False Negative mark
                # This impacts Recall, as a target was missed.
                
                y_true.append("not_propaganda")
                y_pred.append(pred["technique"])  # FP for prediction
                # A span was predicted at an invalid location
                # An in invalid location must have a label of not_propaganda
                # The model the assigned this invalid location a technique
                # This impacts Precision, as a target was hallucinated
                
                error_logs.append({
                    "error": "Boundary Localization Failure", 
                    "subtype": failure_subtype,
                    "gold": gold, 
                    "pred": pred,
                    "delta_allowed": delta,
                    "left_diff": abs(p_start - g_start),
                    "right_diff": abs(p_end - g_end)
                })

        # Terminal aggregate metrics (Macro-F1 ignoring 'not_propaganda')
        valid_labels = TECHNIQUES
        precision, recall, f1, _ = precision_recall_fscore_support(
            y_true, y_pred, labels=valid_labels, average='macro', zero_division=0
        )
        
        # Per-class metrics via scikit-learn
        class_report = classification_report(
            y_true, y_pred, labels=TECHNIQUES, zero_division=0
        )
        
        metrics_dict = {
            "Macro-F1": f1, 
            "Precision": precision, 
            "Recall": recall, 
            "Error_Logs": error_logs,
            "y_true": y_true,
            "y_pred": y_pred
        }

        return metrics_dict, class_report


    @staticmethod
    def evaluate_stage1_span_detector(model, test_path, executor, pipeline):
        """
        DEDICATED STAGE 1 EVALUATOR:
        Evaluates Stage 1 purely on boundary localization accuracy within 
        the allowed tolerance window delta, ignoring technique labels
        """
        model.eval()
        tp_spans, fp_spans, fn_spans = 0, 0, 0
        
        with open(test_path, mode='r', encoding='utf-8') as file:
            reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
            for row in reader:
                label = row['label']
                clean_text, c_start, c_end, _ = pipeline.parse_span_and_clean(
                    row['tagged_in_context'], label
                )
                
                # 1. Obtain Gold Token Bounds using 17-class alignment
                input_ids, att_mask, tags_17 = pipeline.align_bio_tags(
                    clean_text, c_start, c_end, label, mode="var2"
                )
                g_start, g_end, _ = executor.extract_viterbi_span(tags_17[0].tolist(), mode="var2")
                
                # 2. Obtain Stage 1 Predicted Bounds (3-Class BIO)
                with torch.no_grad():
                    viterbi_path = model(input_ids.to(device), att_mask.to(device))[0]
                p_start, p_end, _ = executor.extract_viterbi_span(viterbi_path, mode="var1")
                
                # --- BOUNDARY LOCALIZATION SCENARIOS ---
                has_gold = (g_start != -1 and g_end != -1)
                has_pred = (p_start != -1 and p_end != -1)
                
                # True Negative
                if not has_gold and not has_pred:
                    continue
                
                # Hallucinated Span
                elif not has_gold and has_pred:
                    fp_spans += 1 
                
                # Missed Span
                elif has_gold and not has_pred:
                    fn_spans += 1  # Missed Span
                    
                elif has_gold and has_pred:
                    gold_len = g_end - g_start + 1
                    delta = Task2Evaluator.get_tolerance(gold_len)
                    
                    # Boundary Qualified Span
                    if abs(p_start - g_start) <= delta and abs(p_end - g_end) <= delta:
                        tp_spans += 1  # Boundary Qualified Span
                    else:
                        fp_spans += 1  # Disqualified boundary counts as FP...
                        fn_spans += 1  # ...and FN for target (Double Penalty)

        precision = tp_spans / max(1, (tp_spans + fp_spans))
        recall = tp_spans / max(1, (tp_spans + fn_spans))
        span_f1 = (2 * precision * recall) / max(1e-9, (precision + recall))
        
        return {
            "span_precision": precision,
            "span_recall": recall,
            "span_f1": span_f1,
            "qualified_spans": tp_spans,
            "missed_spans": fn_spans,
            "hallucinated_spans": fp_spans
        }

# %% [markdown]
# #### Architecture Class

# %%
class DebertaCRFTagger(nn.Module):
    """
    - A torch.nn.Module to define the structural blueprint and math operations
    - Acccess data dynamically when used in training or evaluaiton loops
    - Forward pass accepts input_ids, attention_mask, and optionally tags
    - Tagger class itself only takes num_tags as an arg to route to Variation 1 or 2

    - [DeBERTa Encoder]  -->  [Linear Projection Layer]  -->  [Linear-Chain CRF]
    - (DebertaV2Model)   --> (self.hidden2tag)           --> (self.crf)
    
    - Tagger converts raw text subwords into rich, context-aware vector representations (hidden states)
    - Dense vector of size: 384 (for microsoft/deberta-v3-xsmall)
    - DeBERTa is pre-trained but is fine-tuned via backpropagation as the weights are not frozen. 

    - Linear Projection Layer takes 384 dims -> num_tags emissions via self.hidden2tag
    - Converts continuous semantic vectors into raw category emission scores for each tag at each token position.
    - This is trained via backpropagation

    - Passes emission scores into CRF layer for sequence decoding/loss
    - CRF holds a trainable transition matrix to learn sequence rules across tags.
    - Enforces sequence-level dependencies and transition rules.
    - This is trained via backpropagation to learn which tag transitions are likely and which are impossible
    
    """
    def __init__(self, mode="var2", model_checkpoint="microsoft/deberta-v3-xsmall"):
        super().__init__()
        self.mode = mode

        # Init Base Model
        self.deberta = DebertaV2Model.from_pretrained(model_checkpoint).float() # contextualised vectors
        hidden_size = self.deberta.config.hidden_size  # 384 dims
            
        # Linear Mapping Head; Vectors to BIO tags
        self.num_tags = 3 if mode == "var1" else 17 # tagset router
        self.hidden2tag = nn.Linear(hidden_size, self.num_tags)
            
        # CRF Layer
        self.crf = CRF(self.num_tags, batch_first=True)
        self.apply_bio_constraints()    # CRF Overrides/Constraints

    def apply_bio_constraints(self):
        """Enforces hard BIO transition rules (-10000.0)"""
        tag_map = V1_TAG_TO_IDX if self.mode == "var1" else V2_TAG_TO_IDX
        idx_to_tag = {idx: tag for tag, idx in tag_map.items()}
        
        with torch.no_grad():
            for i in range(self.num_tags):
                for j in range(self.num_tags):
                    from_tag, to_tag = idx_to_tag[i], idx_to_tag[j]
                    # Rule 1: Forbid O -> I-tag (Must enter via a B- tag)
                    if from_tag == "O" and to_tag.startswith("I-"):
                        self.crf.transitions[i, j] = -10000.0
                    # Rule 2 (Var2 Only): Forbid mid-span technique switching
                    if self.mode == "var2" and (from_tag.startswith("B-") or from_tag.startswith("I-")) and to_tag.startswith("I-"):
                        if from_tag.split("-")[1] != to_tag.split("-")[1]:
                            self.crf.transitions[i, j] = -10000.0   
    
    def forward(self, input_ids, attention_mask, tags=None):
        outputs = self.deberta(input_ids=input_ids, attention_mask=attention_mask)
        sequence_output = outputs.last_hidden_state     # 384 dims for each token: (batch_size, sequence_length, hidden_size)
        emissions = self.hidden2tag(sequence_output)

        if tags is not None:
            return -self.crf(emissions, tags, mask=attention_mask.byte(), reduction='mean')
        else:
            return self.crf.decode(emissions, mask=attention_mask.byte())

# %% [markdown]
# #### Execution Class (Training, Eval, Viterbi)

# %%
# ==========================================
# CELL 6: Execution Engine (Updated calls)
# ==========================================

import itertools
from sklearn.metrics import classification_report

class Task2Executor:
    """This is the class that orchestrates the models pipelines:
        - `Task2DataPipeline` prepares raw text
        - `DebertaCRFTagger` defines the architecture
        - `Task2Executor` utilises these components
    """
    def __init__(self, pipeline: Task2DataPipeline):
        self.pipeline = pipeline

    def extract_viterbi_span(self, viterbi_path, mode="var2"):
        """Extracts token span indices and label name from BIO integer paths."""
        start_idx, end_idx, technique = -1, -1, "not_propaganda" # default, overwrite if propaganda
        idx_to_tag = V1_IDX_TO_TAG if mode == "var1" else V2_IDX_TO_TAG
        
        for i, tag_id in enumerate(viterbi_path):
            tag = idx_to_tag[tag_id]
            if tag.startswith("B-"):
                start_idx = i
                end_idx = i
                # Var1 defaults to generic flag; Var2 extracts specific technique name[cite: 1]
                technique = "Propaganda" if mode == "var1" else tag.split("-")[1]
            elif tag.startswith("I-") and start_idx != -1:
                end_idx = i
                
        if start_idx == -1:
            return -1, -1, "not_propaganda"
        return start_idx, end_idx, technique

    
    def train_deberta_tagger(self, train_path, mode="var2", epochs=5, batch_size=16, backbone_lr=1e-5, heads_lr=5e-4, checkpoint_epoch=5, checkpoint_path=None):
        """Trains either Stage 1 (mode='var1', 3-class) or Joint (mode='var2', 17-class)[cite: 1]."""
        print(f"\n--- Training DeBERTa-CRF ({mode.upper()}) [Batch Size: {batch_size}] ---")
        model = DebertaCRFTagger(mode=mode).to(device)
        
        optimizer = torch.optim.AdamW([
            {'params': model.deberta.parameters(), 'lr': backbone_lr},
            {'params': model.hidden2tag.parameters(), 'lr': heads_lr},
            {'params': model.crf.parameters(), 'lr': heads_lr}
        ])
        
        model.train()
        for epoch in range(1, epochs + 1):
            print("EPOCH:", epoch - 1)
            total_loss = 0.0
            optimizer.zero_grad()
            with open(train_path, mode='r', encoding='utf-8') as file:
                reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
                for i, row in enumerate(reader, start=1):
                    
                    # Feature Extraction
                    label = row['label']
                    clean_text, c_start, c_end, _ = self.pipeline.parse_span_and_clean(row['tagged_in_context'], label)
                    input_ids, att_mask, tags = self.pipeline.align_bio_tags(clean_text, c_start, c_end, label, mode=mode)
                    
                    # Backprop
                    loss = model(input_ids.to(device), att_mask.to(device), tags.to(device)) # tags triggers loss mechanism
                    loss = loss / batch_size
                    loss.backward()
                    total_loss += loss.item() * batch_size
                    
                    # Batching
                    if i % batch_size == 0:
                        torch.nn.utils.clip_grad_norm_(model.parameters(), max_norm=1.0)
                        optimizer.step()
                        optimizer.zero_grad()

                    if i % 1000 == 0:
                        print(i)
                        
            print(f"Epoch {epoch+1}/{epochs} | Total CRF NLL Loss: {total_loss:.4f}")

            # --- MID-TRAINING CHECKPOINT HOOK ---
            if epoch == checkpoint_epoch and checkpoint_path:
                os.makedirs(os.path.dirname(checkpoint_path), exist_ok=True)
                torch.save(model.state_dict(), checkpoint_path)
                print(f"--> [Checkpoint] Model weights at Epoch {epoch} saved successfully to '{checkpoint_path}' (Training continues...)")
                
        return model


    def evaluate_tagger(self, integrated_model, test_path, mode="var2"):
        """
        Runs inference over evaluation data and builds evaluation dictionaries

        - Executes model inference and formats predictions for metric calculation
        - Processes raw text: parse_span_and_clean and align_bio_tags
        - Using extract_viterbi_span on the gold data to obtain gold label spans
        - Calls model(input_ids, att_mask) without tags triggering CRF's Viterbi decoder
        - Returns the optimal predicted tag ID sequence (viterbi_path)
        - extract_viterbi_span() again to get predicted spans
        - Formats predictions into gold_data and pred_data lists of dicts
        - delegates evaluation to Task2Evaluator.evaluate_predictions 
        """

        integrated_model.eval()
        gold_data, pred_data = [], []
        
        with open(test_path, mode='r', encoding='utf-8') as file:
            reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
            for row in reader:

                # Gold Data: extract label, clean text, tokenize & BIO tag, capture span indices. 
                label = row['label']
                clean_text, c_start, c_end, _ = self.pipeline.parse_span_and_clean(row['tagged_in_context'], label)
                input_ids, att_mask, tags = self.pipeline.align_bio_tags(clean_text, c_start, c_end, label, mode=mode)
                g_start, g_end, _ = self.extract_viterbi_span(tags[0].tolist(), mode=mode)

                # Move DeBERTa Inputs to M1 GPU
                input_ids = input_ids.to(device)
                att_mask = att_mask.to(device)

                # Prediction Data: Viterbi Path 
                with torch.no_grad():
                    # trained model forward pass, extract most likely BIO sequence (IDs)
                    viterbi_path = integrated_model(input_ids, att_mask)[0]
                
                p_start, p_end, p_tech = self.extract_viterbi_span(viterbi_path, mode=mode)
                
                # Collect data
                gold_data.append({"span": (g_start, g_end), "technique": label})
                pred_data.append({"span": (p_start, p_end), "technique": p_tech})
    
                
        eval_results, class_report = Task2Evaluator.evaluate_predictions(gold_data, pred_data)
        return eval_results, class_report


    def evaluate_cascading_pipeline(self, span_detector_model, classifier_head_model, test_path):
        """
        Variation 1 Cascading Inference:
          1. Stage 1 (span_detector_model) predicts token span boundaries (p_start, p_end) via 3-class CRF.
          2. Stage 2 (classifier_head_model) encodes the full sentence, pools span tokens (p_start to p_end),
             and classifies into 8 propaganda techniques.
        """
        
        span_detector_model.eval()
        classifier_head_model.eval()
        gold_data, pred_data = [], []
        
        with open(test_path, mode='r', encoding='utf-8') as file:
            reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
            for row in reader:
                
                # Gold Data: extract label, clean text, tokenize & BIO tag, capture span indices. 
                label = row['label']
                clean_text, c_start, c_end, _ = self.pipeline.parse_span_and_clean(row['tagged_in_context'], label)
                input_ids, att_mask, tags_17 = self.pipeline.align_bio_tags(clean_text, c_start, c_end, label, mode="var2")
                g_start, g_end, _ = self.extract_viterbi_span(tags_17[0].tolist(), mode="var2")
                # Gold data is extracted on 17-class schema as the evaluator is built to this format
                
                # Span Detector Predictions
                with torch.no_grad():
                    viterbi_path = span_detector_model(input_ids.to(device), att_mask.to(device))[0]
                p_start, p_end, _ = self.extract_viterbi_span(viterbi_path, mode="var1") # VAR1 = 3-TAG BIO
                
                # Span Found
                if p_start != -1 and p_end != -1:
                    # Extract the snippet from the contextualized vectors
                    logits = classifier_head_model.forward_span_pooled(
                            input_ids.to(device), 
                            att_mask.to(device), 
                            p_start, 
                            p_end
                        )
                    p_tech = IDX_TO_TECH[torch.argmax(logits, dim=1).item()]

                else:
                    p_tech = "not_propaganda"
                    
                gold_data.append({"span": (g_start, g_end), "technique": label})
                pred_data.append({"span": (p_start, p_end), "technique": p_tech})
                
        return Task2Evaluator.evaluate_predictions(gold_data, pred_data)


# %% [markdown]
# ### Baseline (Class, Results, Analysis)

# %% [markdown]
# ##### Base Class

# %%
class Task2RandomBaseline:
    """
    Independent stochastic baseline for Task 2.
    Generates non-linguistic uniform random span boundaries and technique predictions
    """
    def __init__(self, pipeline: Task2DataPipeline, executor: Task2Executor):
        self.pipeline = pipeline
        self.executor = executor

    def _stochastic_generation(self, prop_threshold: float, num_tokens: int):
        """Generates random span boundaries and technique predictions."""
        if random.random() < prop_threshold:    
            # Snippet Boundary Random Guess
            if num_tokens > 3:
                p_start = random.randint(1, num_tokens - 2)         # -2 to avoid end SEP token
                p_end = random.randint(p_start, num_tokens - 2)     # limited to first pred onwards
            else:
                p_start, p_end = 1, 1   # fixed as middle guess for really short seqs
                
            # Technique Random Guess
            p_tech = random.choice(TECHNIQUES)  # tech is condictional random guess of 8 techs
        else:
            # Predict neutral sentence
            p_start, p_end = -1, -1
            p_tech = "not_propaganda"

        return p_start, p_end, p_tech

    def evaluate(self, test_path: str, dataset_name: str = "VAL", prop_threshold: float = 0.5):
        """ 
        Evaluator for the random baseline. 
        Largely mimics evaluate_tagger() but without the modelling complexity
        """
        print(f"\n--- Running Stochastic Random-Guessing Baseline ({dataset_name}) ---")
        gold_data, pred_data = [], []
        with open(test_path, mode='r', encoding='utf-8') as file:
            reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
            for row in reader:
                
                # Gold Data: extract label, clean text, tokenize & BIO tag, capture span indices. 
                label = row['label']
                clean_text, c_start, c_end, _ = self.pipeline.parse_span_and_clean(row['tagged_in_context'], label)
                input_ids, att_mask, tags = self.pipeline.align_bio_tags(clean_text, c_start, c_end, label, mode="var1")
                g_start, g_end, _ = self.executor.extract_viterbi_span(tags[0].tolist(), mode="var1")

                # Prediction Data: token length param, randomly generate spans and predictions
                actual_len = int(att_mask.sum().item())
                p_start, p_end, p_tech = self._stochastic_generation(prop_threshold, actual_len)

                # Collect data
                gold_data.append({"span": (g_start, g_end), "technique": label})
                pred_data.append({"span": (p_start, p_end), "technique": p_tech})
        
        # Evaluate results + class breakdown
        eval_results, class_report = Task2Evaluator.evaluate_predictions(gold_data, pred_data)
        
        return eval_results, class_report, gold_data, pred_data

# %%
def _propaganda_ratio(TRAIN_PATH):
    """A function to work out the training not_propaganda split for the random guesser"""
    active_count, total_count = 0, 0
    with open(TRAIN_PATH, mode='r', encoding='utf-8') as file:
        reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
        for row in reader:
            total_count += 1
            if row['label'] != 'not_propaganda':
                active_count += 1

    empirical_ratio = active_count / max(1, total_count)
    return empirical_ratio

# %% [markdown]
# ##### Base Results

# %%
# ==========================================
# CELL 7: Task 2 Baseline Execution
# ==========================================

# 1. Lock seed for exact reproducibility
set_seed(SEED)

TRAIN_PATH = '../data/propaganda_train.tsv'
VAL_PATH = '../data/propaganda_val.tsv'

t2_pipeline = Task2DataPipeline()
executor = Task2Executor(t2_pipeline)
random_baseline = Task2RandomBaseline(t2_pipeline, executor)

# 4. Compute empirical training prior (proportion of active propaganda instances)
empirical_ratio = _propaganda_ratio(TRAIN_PATH)

# 5. Execute stochastic baseline evaluation on Validation/Test split
print("=" * 60)
print("     STARTING TASK 2 BASELINE EVALUATION")
print("=" * 60)

metrics, class_breakdown, baseline_gold_data, baseline_pred_data = random_baseline.evaluate(
    VAL_PATH, 
    dataset_name="TEST/VAL SET", 
    prop_threshold=empirical_ratio
)

print(f"\n==========================================")
print(f" BASELINE EVALUATION REPORT: {TRAIN_PATH}")
print(f"==========================================")
print(f" Macro-F1 Score:  {metrics['Macro-F1']:.4f}")
print(f" Macro Precision: {metrics['Precision']:.4f}")
print(f" Macro Recall:    {metrics['Recall']:.4f}")
print(f"------------------------------------------")
print(class_breakdown)
print(f"==========================================\n")


# %% [markdown]
# ##### Base Analysis

# %%
# ==========================================
# Task 2 Baseline Analytical Diagnostics
# ==========================================

def analyze_random_baseline(gold_data, pred_data):
    total_samples = len(gold_data)
    
    # 1. Routing Breakdown
    routed_not_prop = [p for p in pred_data if p["span"] == (-1, -1)]
    routed_span = [p for p in pred_data if p["span"] != (-1, -1)]
    
    pct_not_prop = (len(routed_not_prop) / total_samples) * 100
    pct_span = (len(routed_span) / total_samples) * 100
    
    # 2. Composition of the `not_propaganda` routed subsample
    # Match indices back to gold labels
    not_prop_indices = [i for i, p in enumerate(pred_data) if p["span"] == (-1, -1)]
    actual_gold_not_prop = sum(1 for i in not_prop_indices if gold_data[i]["technique"] == "not_propaganda")
    actual_gold_is_prop = len(not_prop_indices) - actual_gold_not_prop
    
    pct_actually_not_prop = (actual_gold_not_prop / max(1, len(not_prop_indices))) * 100
    pct_actually_prop_missed = (actual_gold_is_prop / max(1, len(not_prop_indices))) * 100
    
    # 3. Composition of the Span Guess routed subsample
    span_indices = [i for i, p in enumerate(pred_data) if p["span"] != (-1, -1)]
    span_gold_prop = sum(1 for i in span_indices if gold_data[i]["technique"] != "not_propaganda")
    span_gold_not_prop = len(span_indices) - span_gold_prop
    
    pct_span_has_gold_target = (span_gold_prop / max(1, len(span_indices))) * 100
    
    # 4. Successful Boundary Passes (True Positives on Span)
    successful_spans = 0
    for i in span_indices:
        g = gold_data[i]
        p = pred_data[i]
        if g["technique"] != "not_propaganda":
            g_start, g_end = g["span"]
            p_start, p_end = p["span"]
            delta = Task2Evaluator.get_tolerance(g_end - g_start + 1)
            if abs(p_start - g_start) <= delta and abs(p_end - g_end) <= delta:
                successful_spans += 1
                # print(gold_data[i], pred_data[i])
                
    print("=" * 60)
    print("      TASK 2 RANDOM BASELINE DIAGNOSTIC ANALYSIS")
    print("=" * 60)
    print(f"Total Evaluation Instances : {total_samples}")
    print(f"------------------------------------------------------------")
    print(f"1. Routing Distribution:")
    print(f"   - Routed to 'not_propaganda' (-1, -1) : {len(routed_not_prop)} ({pct_not_prop:.2f}%)")
    print(f"   - Routed to Active Span Guess        : {len(routed_span)} ({pct_span:.2f}%)")
    print(f"------------------------------------------------------------")
    print(f"2. Subsample Composition ('not_propaganda' route):")
    print(f"   - Of those guessed as background, actually gold background : {pct_actually_not_prop:.2f}%")
    print(f"   - Of those guessed as background, actually missed targets   : {pct_actually_prop_missed:.2f}%")
    print(f"------------------------------------------------------------")
    print(f"3. Subsample Composition (Active Span route):")
    print(f"   - Of those guessed as spans, held a valid propaganda target : {pct_span_has_gold_target:.2f}%")
    print(f"------------------------------------------------------------")
    print(f"4. Boundary Qualification:")
    print(f"   - Random guesses that successfully met tolerance bounds : {successful_spans}")
    print("=" * 60)

# Run the diagnostic using outputs from your baseline cell
analyze_random_baseline(baseline_gold_data, baseline_pred_data)

# %% [markdown]
# This means that the capcity for correct random classification guess (similar to task 1) was only 11 instances. Of which all, in this seeded run failed

# %% [markdown]
# ### Variation 2: 17-Class Integrated Joint Tagger

# %% [markdown]
# #### Var2 Hyperparameter Sweep

# %%
# ==========================================
# HYPERPARAMETER SWEEP FOR VARIATION 2 (10% MODULO DEV SPLIT)
# ==========================================
# Customer Sweep Script. Doesn't use train_deberta_tagger but adapts the code for sweep accross configs
# Swept at 5 epochs


import os
import csv
import torch

os.makedirs("./param_sweep", exist_ok=True)
set_seed(SEED)

TRAIN_PATH = "../data/propaganda_train.tsv"
SWEEP_EPOCHS = 5

# Minimal Search Space Configurations
sweep_configs = [
    {
        "run_name": "Run_1_Conservative",
        "backbone_lr": 1e-5,
        "heads_lr": 5e-4,
        "batch_size": 16,
    },
    {
        "run_name": "Run_2_Moderate",
        "backbone_lr": 2e-5,
        "heads_lr": 1e-3,
        "batch_size": 16,
    },
    {
        "run_name": "Run_3_Aggressive",
        "backbone_lr": 5e-5,
        "heads_lr": 2e-3,
        "batch_size": 32,
    },
]

pipeline = Task2DataPipeline(model_checkpoint="microsoft/deberta-v3-xsmall")
executor = Task2Executor(pipeline)

global_best_dev_loss = float('inf')
best_run_config = None
sweep_history = []

print("=" * 80)
print(f"       STARTING TASK 2 VARIATION 2 SWEEP ({SWEEP_EPOCHS} EPOCHS | 10% MODULO DEV SPLIT)")
print("=" * 80)

for run_id, config in enumerate(sweep_configs, start=1):
    print(f"\n==================================================")
    print(f" SWEEP RUN {run_id}/{len(sweep_configs)} | {config['run_name']}")
    print(f" Backbone LR: {config['backbone_lr']} | Heads LR: {config['heads_lr']} | Batch Size: {config['batch_size']}")
    print(f"==================================================")
    
    set_seed(SEED)
    model = DebertaCRFTagger(num_tags=17, mode="var2")
    
    optimizer = torch.optim.AdamW([
        {'params': model.deberta.parameters(), 'lr': config['backbone_lr']},
        {'params': model.hidden2tag.parameters(), 'lr': config['heads_lr']},
        {'params': model.crf.parameters(), 'lr': config['heads_lr']}
    ])
    
    accum_steps = config['batch_size']
    epoch_logs = []
    
    # Custom Model Train, does not use train_deberta_tagger
    for epoch in range(1, SWEEP_EPOCHS + 1):
        print("EPOCH:", epoch)
        running_train_loss, train_samples = 0.0, 0
        running_dev_loss, dev_samples = 0.0, 0
        
        with open(TRAIN_PATH, mode='r', encoding='utf-8') as file:
            reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
            optimizer.zero_grad()
            
            for row_idx, row in enumerate(reader, start=1):
                if row_idx % 100 == 0:
                    print(f"Processed {row_idx} instances...")

                label = row['label']
                clean_text, c_start, c_end, _ = pipeline.parse_span_and_clean(row['tagged_in_context'], label)
                input_ids, att_mask, tags = pipeline.align_bio_tags(clean_text, c_start, c_end, label, mode="var2")
                
                # --- 10% MODULO INTERNAL DEV SPLIT ---
                if row_idx % 10 == 0:
                    model.eval()
                    with torch.no_grad():
                        loss = model(input_ids, att_mask, tags)
                        running_dev_loss += loss.item()
                        dev_samples += 1
                else:
                    model.train()
                    loss = model(input_ids, att_mask, tags)
                    scaled_loss = loss / accum_steps
                    scaled_loss.backward()
                    running_train_loss += loss.item()
                    train_samples += 1
                    
                    if row_idx % accum_steps == 0:
                        torch.nn.utils.clip_grad_norm_(model.parameters(), max_norm=1.0)
                        optimizer.step()
                        optimizer.zero_grad()
            
            # Flush final batch gradients
            if train_samples % accum_steps != 0:
                torch.nn.utils.clip_grad_norm_(model.parameters(), max_norm=1.0)
                optimizer.step()
                optimizer.zero_grad()
                
        avg_train_loss = running_train_loss / train_samples if train_samples > 0 else 0.0
        avg_dev_loss = running_dev_loss / dev_samples if dev_samples > 0 else 0.0
        
        print(f"Epoch {epoch}/{SWEEP_EPOCHS} | Avg Train Loss: {avg_train_loss:.4f} | Avg Internal Dev Loss: {avg_dev_loss:.4f}")
        
        epoch_logs.append({
            "epoch": epoch,
            "train_loss": round(avg_train_loss, 4),
            "dev_loss": round(avg_dev_loss, 4)
        })
    
    print("FINISHED EPOCHS")

    # Best dev loss achieved in this run across the 5 epochs
    min_run_dev_loss = min(log["dev_loss"] for log in epoch_logs)
    
    if min_run_dev_loss < global_best_dev_loss:
        global_best_dev_loss = min_run_dev_loss
        best_run_config = config
        print(f"🔥 NEW BEST CONFIGURATION! Internal Dev Loss: {global_best_dev_loss:.4f}")
        
    sweep_history.append({
        "run_id": run_id,
        "config": config,
        "epoch_logs": epoch_logs
    })

print("FINISHED CONFIGS")

print("\n" + "=" * 80)
print(f"SWEEP COMPLETE!")
print(f"Best Configuration   : {best_run_config['run_name']}")
print(f"Lowest Dev NLL Loss  : {global_best_dev_loss:.4f}")
print("=" * 80)

# ==========================================
# EXPORT RESULTS TO CSV
# ==========================================
csv_filename = "./param_sweep/sweep_results_var2.csv"
with open(csv_filename, mode="w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)
    
    header = ["run_id", "run_name", "backbone_lr", "heads_lr", "batch_size"]
    for ep in range(1, SWEEP_EPOCHS + 1):
        header.extend([f"ep_{ep}_train_loss", f"ep_{ep}_dev_loss"])
    writer.writerow(header)
    
    for item in sweep_history:
        r_id = item["run_id"]
        cfg = item["config"]
        logs = item["epoch_logs"]
        
        row = [r_id, cfg["run_name"], cfg["backbone_lr"], cfg["heads_lr"], cfg["batch_size"]]
        for ep_log in logs:
            row.extend([ep_log["train_loss"], ep_log["dev_loss"]])
        writer.writerow(row)

print(f"\nSuccessfully saved sweep details to '{csv_filename}'.")

# %% [markdown]
# 
# **Best Run: Conservative**
# - Backbone LR: 1e-5
# - Heads LR:    5e-4
# - Batch Size:  16
# 
# *Values updates within class structure*

# %% [markdown]
# #### Var2 Training & Eval

# %%
# ==========================================
# CELL 8: Variation 2 (17-Class Joint Tagger)
# ==========================================

set_seed(SEED)

# 1. File Paths & Winning Conservative Hyperparameters
TRAIN_PATH = '../data/propaganda_train.tsv'
VAL_PATH = '../data/propaganda_val.tsv'
VAR2_MODEL_SAVE = './final_models/var2_deberta_crf_joint.pt'

EPOCHS = 10             
BATCH_SIZE = 16          # Simulated batch size via gradient accumulation
BACKBONE_LR = 1e-5       # Conservative Backbone LR (0.00001)
HEADS_LR = 5e-4          # Conservative Heads LR (0.0005)

print("=" * 60)
print("     STARTING TASK 2 VARIATION 2 (CONSERVATIVE RUN)")
print("=" * 60)

t2_pipeline = Task2DataPipeline(model_checkpoint="microsoft/deberta-v3-xsmall")
t2_executor = Task2Executor(pipeline=t2_pipeline)

# 2. Train using the winning parameters explicitly passed from the script
var2_model = t2_executor.train_deberta_tagger(
    train_path=TRAIN_PATH,
    mode="var2",
    epochs=EPOCHS,
    batch_size=BATCH_SIZE,
    backbone_lr=BACKBONE_LR,
    heads_lr=HEADS_LR
)

# 3. Save Model Weights
import os
os.makedirs('./final_models', exist_ok=True)
torch.save(var2_model.state_dict(), VAR2_MODEL_SAVE)
print(f"\n--> Variation 2 Joint Model saved successfully to {VAR2_MODEL_SAVE}\n")

# 4. Evaluate Model on Validation Set
print("=" * 60)
print("     EVALUATING VARIATION 2 ON VALIDATION SET")
print("=" * 60)

var2_metrics, var2_class_report = t2_executor.evaluate_tagger(
    model=var2_model,
    test_path=VAL_PATH,
    mode="var2"
)

# 5. Report Primary Benchmark Metrics
print(f"\n==========================================")
print(f" VARIATION 2 EVALUATION REPORT (VALIDATION)")
print(f"==========================================")
print(f" Macro-F1 Score:  {var2_metrics['Macro-F1']:.4f}")
print(f" Macro Precision: {var2_metrics['Precision']:.4f}")
print(f" Macro Recall:    {var2_metrics['Recall']:.4f}")
print(f"------------------------------------------")
print(var2_class_report)
print(f"==========================================\n")

# %%
# ==========================================
# AD-HOC EVALUATION: VARIATION 2
# ==========================================

set_seed(SEED)

VAL_PATH = '../data/propaganda_val.tsv'
VAR2_MODEL_SAVE = './final_models/var2_deberta_crf_joint.pt'

print("=" * 60)
print("     LOADING & EVALUATING VARIATION 2 AD-HOC")
print("=" * 60)

# 1. Initialize pipeline and executor
t2_pipeline = Task2DataPipeline(model_checkpoint="microsoft/deberta-v3-xsmall")
t2_executor = Task2Executor(pipeline=t2_pipeline)

# 2. Re-instantiate the model architecture for Variation 2 and move to device
loaded_var2_model = DebertaCRFTagger(mode="var2").to(device)

# 3. Load the saved weights from disk
loaded_var2_model.load_state_dict(torch.load(VAR2_MODEL_SAVE, map_location=device, weights_only=True))

# 4. Run evaluation using the executor
var2_metrics, var2_class_report = t2_executor.evaluate_tagger(
    model=loaded_var2_model,
    test_path=VAL_PATH,
    mode="var2"
)

# 5. Report Primary Benchmark Metrics
print(f"\n==========================================")
print(f" VARIATION 2 EVALUATION REPORT (VALIDATION)")
print(f"==========================================")
print(f" Macro-F1 Score:  {var2_metrics['Macro-F1']:.4f}")
print(f" Macro Precision: {var2_metrics['Precision']:.4f}")
print(f" Macro Recall:    {var2_metrics['Recall']:.4f}")
print(f"------------------------------------------")
print(var2_class_report)
print(f"==========================================\n")

# %% [markdown]
# ### Variation 1: Decoupled (Span Detection Model + Technique Classifer Model)

# %% [markdown]
# ##### Independent Classifer Head

# %%
# =====================================================================
# STAGE 2: SPAN-POOLED OFFLINE CLASSIFIER & UPPER EVALUATOR
# =====================================================================

import os
import csv
import torch
import torch.nn as nn
from sklearn.metrics import accuracy_score, precision_recall_fscore_support, classification_report

class DebertaSpanClassifier(nn.Module):
    """
    Stage 2 Contextualized Span Classifier.
    Encodes the FULL sentence with DeBERTa, extracts the specific span token 
    vectors using (start, end) indices, pools them, and classifies into 8 techniques.
    """
    def __init__(self, model_checkpoint="microsoft/deberta-v3-xsmall", num_classes=len(TECHNIQUES)):
        super().__init__()
        self.deberta = DebertaV2Model.from_pretrained(model_checkpoint).float()
        hidden_size = self.deberta.config.hidden_size  # 384 dims
        
        self.classifier = nn.Sequential(
            nn.Linear(hidden_size, 64),
            nn.ReLU(),
            nn.LayerNorm(64),
            nn.Dropout(0.3),
            nn.Linear(64, num_classes)
        )
        
    def forward_span_pooled(self, input_ids, attention_mask, start_idx: int, end_idx: int):
        """
        Processes full sentence sequence, slices predicted/gold span embeddings,
        mean-pools them, and passes through the classification head.
        """
        outputs = self.deberta(input_ids=input_ids, attention_mask=attention_mask)
        sequence_output = outputs.last_hidden_state  # Shape: (1, seq_len, 384)
        
        seq_len = sequence_output.size(1)
        if start_idx != -1 and end_idx != -1 and start_idx < seq_len:
            end_idx_bounded = min(end_idx + 1, seq_len)
            span_vectors = sequence_output[:, start_idx:end_idx_bounded, :]
            pooled_embedding = span_vectors.mean(dim=1)
        else:
            # Fallback mean pooling across entire sequence if span is invalid
            pooled_embedding = sequence_output.mean(dim=1)
            
        return self.classifier(pooled_embedding)


def train_stage2_technique_classifier(
    train_path="../data/propaganda_train.tsv",
    epochs=10,
    batch_size=16,
    lr=1e-3,
    save_path="./final_models/var1_stage2_classifier.pt"
):
    """
    Trains the Stage 2 classifier on FULL contextual sentence embeddings.
    Extracts and pools the span token representations directly using subword offsets.
    """
    print("\n" + "="*70)
    print("   TRAINING STAGE 2: SPAN-POOLED CLASSIFIER (FROZEN BACKBONE)")
    print("="*70)
    
    pipeline = Task2DataPipeline()
    executor = Task2Executor(pipeline)
    model = DebertaSpanClassifier().to(device)
    
    # Freeze DeBERTa Backbone Parameters completely
    for param in model.deberta.parameters():
        param.requires_grad = False
    print("--> DeBERTa backbone frozen. Updating classifier head parameters only.")
    
    optimizer = torch.optim.AdamW(
        model.classifier.parameters(), 
        lr=lr, 
        weight_decay=0.01
    )
    criterion = nn.CrossEntropyLoss()
    
    model.train()
    for epoch in range(1, epochs + 1):
        total_loss, samples = 0.0, 0
        optimizer.zero_grad()
        
        with open(train_path, mode='r', encoding='utf-8') as file:
            reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
            for idx, row in enumerate(reader, start=1):
                
                # Filter out non-propaganda background rows
                label = row['label']
                if label == 'not_propaganda' or label not in TECH_TO_IDX:
                    continue 
                
                # Clean full text and extract character offsets
                clean_text, c_start, c_end, _ = pipeline.parse_span_and_clean(row['tagged_in_context'], label)
                
                #  Tokenize FULL sentence and align subword tags to find exact GOLD token bounds
                input_ids, att_mask, tags = pipeline.align_bio_tags(clean_text, c_start, c_end, label, mode="var2")
                g_start, g_end, _ = executor.extract_viterbi_span(tags[0].tolist(), mode="var2")
                
                if g_start == -1 or g_end == -1: # not_propaganda
                    continue
                
                input_ids = input_ids.to(device)
                att_mask = att_mask.to(device)
                target = torch.tensor([TECH_TO_IDX[label]], dtype=torch.long, device=device)
                
                # Forward pass with context-aware span pooling
                logits = model.forward_span_pooled(input_ids, att_mask, g_start, g_end) # contexualised mean-pooled snippet
                loss = criterion(logits, target) / batch_size
                loss.backward()
                
                total_loss += loss.item() * batch_size
                samples += 1
                
                if samples % batch_size == 0:
                    torch.nn.utils.clip_grad_norm_(model.classifier.parameters(), max_norm=1.0)
                    optimizer.step()
                    optimizer.zero_grad()
                    
        print(f"   Epoch {epoch:02d}/{epochs} | Avg Classification Loss: {total_loss / max(1, samples):.4f}")

    os.makedirs(os.path.dirname(save_path), exist_ok=True)
    torch.save(model.state_dict(), save_path)
    print(f"--> Stage 2 Span-Pooled Classifier saved to {save_path}\n")
    return model


def evaluate_perfect_classifier(
    model, 
    val_path="../data/propaganda_val.tsv",
    weights_path="./final_models/var1_stage2_classifier.pt"
) -> dict:
    """
    BENCHMARK EVALUATOR:
    Evaluates the Stage 2 classifier on FULL sentences using gold subword token spans.
    Establishes the performance ceiling with zero boundary degradation.
    """
    print("="*70)
    print("  BASELINE EVALUATION (FULL SENTENCE CONTEXT + GOLD SPAN POOLING)")
    print("="*70)
    
    pipeline = Task2DataPipeline()
    executor = Task2Executor(pipeline)
    model.eval()
    
    all_preds = []
    all_targets = []
    
    with open(val_path, mode='r', encoding='utf-8') as file:
        reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
        for row in reader:
            label = row['label']
            if label == 'not_propaganda' or label not in TECH_TO_IDX: continue
                
            clean_text, c_start, c_end, _ = pipeline.parse_span_and_clean(row['tagged_in_context'], label)
            input_ids, att_mask, tags = pipeline.align_bio_tags(clean_text, c_start, c_end, label, mode="var2")
            g_start, g_end, _ = executor.extract_viterbi_span(tags[0].tolist(), mode="var2")
            
            if g_start == -1 or g_end == -1: continue # not_propaganda
                
            with torch.no_grad():
                logits = model.forward_span_pooled(input_ids.to(device), att_mask.to(device), g_start, g_end)
                pred_idx = torch.argmax(logits, dim=1).item()
                
            all_preds.append(pred_idx)
            all_targets.append(TECH_TO_IDX[label])
            
    # Calculate Aggregate Benchmark Metrics
    acc = accuracy_score(all_targets, all_preds)
    precision, recall, f1, _ = precision_recall_fscore_support(
        all_targets, all_preds, average='macro', zero_division=0
    )
    
    print(f" Accuracy:        {acc:.4f}")
    print(f" Macro Precision: {precision:.4f}")
    print(f" Macro Recall:    {recall:.4f}")
    print(f" Macro F1 Score:  {f1:.4f}  <-- [THEORETICAL PERFORMANCE CEILING]")
    print("-" * 70)
    
    target_names = [TECHNIQUES[i] for i in range(len(TECHNIQUES))]
    print(classification_report(all_targets, all_preds, target_names=target_names, zero_division=0))
    print("=" * 70 + "\n")
    
    return {
        "accuracy": acc,
        "macro_precision": precision,
        "macro_recall": recall,
        "macro_f1": f1
    }

# %%
# =====================================================================
# STAGE 2: CLASSIFIER HEAD-ONLY TRAINING & ORACLE EVALUATION SCRIPT
# =====================================================================

import os
import csv
import torch
import torch.nn as nn
from sklearn.metrics import accuracy_score, precision_recall_fscore_support, classification_report

set_seed(SEED)

TRAIN_PATH = '../data/propaganda_train.tsv'
VAL_PATH = '../data/propaganda_val.tsv'
MODEL_SAVE_PATH = './final_models/var1_stage2_classifier_head_only.pt'

STAGE2_EPOCHS = 10
BATCH_SIZE = 16
HEAD_LR = 1e-3

# Step 1: Train the classifier head with frozen DeBERTa
trained_classifier_head = train_stage2_technique_classifier(
    train_path=TRAIN_PATH,
    epochs=STAGE2_EPOCHS,
    batch_size=BATCH_SIZE,
    lr=HEAD_LR,
    save_path=MODEL_SAVE_PATH
)

# Step 2: Evaluate on validation gold spans to establish upper benchmark
oracle_f1 = evaluate_perfect_classifier(
    model=trained_classifier_head,
    val_path=VAL_PATH
)

# %% [markdown]
# ##### Span Detector Training (Var2 Hyperparams Carried Over)

# %%
# =====================================================================
# VARIATION 1: TRUE END-TO-END DECOUPLED CASCADING PIPELINE EXECUTION
# =====================================================================
# * Directly carries over hyperparams from VAR2. No Tuning

import os
import torch

set_seed(SEED)

TRAIN_PATH = '../data/propaganda_train.tsv'
VAL_PATH = '../data/propaganda_val.tsv'

STAGE1_SAVE_PATH = './final_models/var1_stage1_span_detector.pt'
STAGE2_SAVE_PATH = './final_models/var1_stage2_classifier_head_only.pt'

t2_pipeline = Task2DataPipeline(model_checkpoint="microsoft/deberta-v3-xsmall")
t2_executor = Task2Executor(pipeline=t2_pipeline)




# =====================================================================
# STEP 1: STAGE 2 TECHNIQUE CLASSIFIER (UPPER BENCHMARK)
# =====================================================================
print("=" * 70)
print("  STEP 1: INITIALIZING STAGE 2 CLASSIFIER & UPPER BENCHMARK")
print("=" * 70)

stage2_classifier = DebertaSpanClassifier().to(device)

# Load existing weights if available, otherwise train from scratch
if os.path.exists(STAGE2_SAVE_PATH):
    print(f"--> Loading existing Stage 2 classifier weights from '{STAGE2_SAVE_PATH}'")
    stage2_classifier.load_state_dict(
        torch.load(STAGE2_SAVE_PATH, map_location=device, weights_only=True)
    )
else:
    print("--> Training Stage 2 classifier head from scratch...")
    stage2_classifier = train_stage2_technique_classifier(
        train_path=TRAIN_PATH,
        epochs=10,
        batch_size=16,
        lr=1e-3,
        save_path=STAGE2_SAVE_PATH
    )

# Run evaluation to establish upper benchmark
upper_results = evaluate_perfect_classifier(
    model=stage2_classifier,
    val_path=VAL_PATH
)
upper_f1 = upper_results["macro_f1"]




# =====================================================================
# STEP 2: STAGE 1 SPAN DETECTOR TRAINING (3-CLASS BIO CRF)
# =====================================================================
print("=" * 70)
print("  STEP 2: TRAINING STAGE 1 SPAN DETECTOR (O, B-Prop, I-Prop)")
print("=" * 70)

stage1_span_detector = t2_executor.train_deberta_tagger(
    train_path=TRAIN_PATH,
    mode="var1",           # Enforces 3-class BIO tagset (num_tags=3)
    epochs=10,
    batch_size=16,
    backbone_lr=1e-5,
    heads_lr=5e-4
)

os.makedirs(os.path.dirname(STAGE1_SAVE_PATH), exist_ok=True)
torch.save(stage1_span_detector.state_dict(), STAGE1_SAVE_PATH)
print(f"--> Stage 1 Span Detector saved successfully to '{STAGE1_SAVE_PATH}'\n")




# =====================================================================
# STEP 3: END-TO-END CASCADING PIPELINE EVALUATION
# =====================================================================
print("=" * 70)
print("  STEP 3: EVALUATING END-TO-END CASCADING PIPELINE (VAR 1)")
print("=" * 70)

var1_metrics, var1_class_report = t2_executor.evaluate_cascading_pipeline(
    span_detector_model=stage1_span_detector,
    classifier_head_model=stage2_classifier,
    test_path=VAL_PATH
)

cascade_f1 = var1_metrics["Macro-F1"]
degradation = upper_f1 - cascade_f1




# =====================================================================
# FINAL SUMMARY REPORT
# =====================================================================
print("\n" + "=" * 70)
print("     VARIATION 1: DECOUPLED CASCADING PIPELINE SUMMARY")
print("=" * 70)
print(f" Stage 2 Upper Ceiling (Perfect Spans) : {upper_f1:.4f}")
print(f" End-to-End Cascading Pipeline F1       : {cascade_f1:.4f}")
print(f" Span Detection Degradation (Delta)     : -{degradation:.4f}")
print("-" * 70)
print(" Detailed Classification Report (End-to-End Cascade):")
print(var1_class_report)
print("=" * 70 + "\n")

# %% [markdown]
# ##### Span Detection Hyperparameter Tuning

# %%
import itertools

set_seed(SEED)

TRAIN_PATH = '../data/propaganda_train.tsv'
VAL_PATH = '../data/propaganda_val.tsv'

FIXED_BATCH_SIZE = 16

# Hyperparameter Grid Search
stage1_grid = {
    'backbone_lr': [5e-6, 1e-5, 3e-5],
    'heads_lr': [3e-4, 5e-4, 1e-3]
}

keys, values = zip(*stage1_grid.items())
experiments = [dict(zip(keys, v)) for v in itertools.product(*values)]

best_s1_score = 0.0
best_s1_config = None

for trial_idx, cfg in enumerate(experiments, start=1):
    print(f"\n--- [TRIAL {trial_idx}/{len(experiments)}] {cfg} ---")
    set_seed(SEED)
    
    # Train 3-Class Tagger
    s1_model = t2_executor.train_deberta_tagger(
        train_path=TRAIN_PATH,
        mode="var1",
        epochs=3,
        batch_size=FIXED_BATCH_SIZE,
        backbone_lr=cfg['backbone_lr'],
        heads_lr=cfg['heads_lr']
    )
    
    # Evaluate Span-Only
    metrics = Task2Evaluator.evaluate_stage1_span_detector(
        model=s1_model,
        test_path=VAL_PATH,
        executor=t2_executor,
        pipeline=t2_pipeline
    )
    
    # Metrics and Diagnostics
    print(f"Trial {trial_idx:02d} | Span F1: {metrics['span_f1']:.4f} | Recall: {metrics['span_recall']:.4f} | Precision: {metrics['span_precision']:.4f}")
    print(f"| Qualified Spans (TP): {metrics['qualified_spans']} | Missed (FN): {metrics['missed_spans']} | Hallucinated Spans {metrics['hallucinated_spans']}  |")

    # Logging Best Performing
    current_span_f1 = metrics['span_f1']
    if current_span_f1 > best_s1_score:
        best_s1_score = current_span_f1
        best_s1_config = cfg
        torch.save(s1_model.state_dict(), "./final_models/var1_stage1_best_sweep.pt")
        print(f" New best Stage 1 Span Detector found! (Span F1: {best_s1_score:.4f})")

# Final Result
print(f"Optimal Config  : {best_s1_config}")
print(f"Best Span F1    : {best_s1_score:.4f}")

# %% [markdown]
# ##### Span Detection Training

# %%
# =====================================================================
# VARIATION 1: TRUE END-TO-END DECOUPLED CASCADING PIPELINE EXECUTION
# =====================================================================
# * Using winning tuned hyperparameters

import os
import torch

set_seed(SEED)

TRAIN_PATH = '../data/propaganda_train.tsv'
VAL_PATH = '../data/propaganda_val.tsv'

EPOCH_5_CHECKPOINT_PATH = './final_models/var1_stage1_span_detector_epoch5.pt'
FINAL_SAVE_PATH = './final_models/var1_stage1_span_detector_epoch10.pt'

t2_pipeline = Task2DataPipeline(model_checkpoint="microsoft/deberta-v3-xsmall")
t2_executor = Task2Executor(pipeline=t2_pipeline)

# Train for 10 epochs, but automatically save a copy at Epoch 5 and carry on
stage1_span_detector = t2_executor.train_deberta_tagger(
    train_path=TRAIN_PATH,
    mode="var1", 
    epochs=10,
    batch_size=16,
    backbone_lr=3e-05,
    heads_lr=0.001,
    checkpoint_epoch=5,
    checkpoint_path=EPOCH_5_CHECKPOINT_PATH
)

# Save the final Epoch 10 model as usual
os.makedirs(os.path.dirname(FINAL_SAVE_PATH), exist_ok=True)
torch.save(stage1_span_detector.state_dict(), FINAL_SAVE_PATH)
print(f"--> Final Epoch 10 Stage 1 Span Detector saved to '{FINAL_SAVE_PATH}'\n")

# %% [markdown]
# ##### End-to-End Pipeline Evaluation

# %%
# =====================================================================
# STANDALONE CASCADING PIPELINE EVALUATION SCRIPT
# =====================================================================
import os
import torch

set_seed(SEED)

VAL_PATH = '../data/propaganda_val.tsv'
STAGE1_SAVE_PATH = './final_models/var1_stage1_span_detector_epoch10.pt'   # Path to saved Stage 1 weights
STAGE2_SAVE_PATH = './final_models/var1_stage2_classifier_head_only.pt'    # Path to saved Stage 2 weights

t2_pipeline = Task2DataPipeline(model_checkpoint="microsoft/deberta-v3-xsmall")
t2_executor = Task2Executor(pipeline=t2_pipeline)

# Load Pre-Trained Stage 1 Span Detector from Disk
stage1_span_detector = DebertaCRFTagger(mode="var1").to(device)
stage1_span_detector.load_state_dict(torch.load(STAGE1_SAVE_PATH, map_location=device, weights_only=True))

# Load Pre-Trained Stage 2 Classifier Head from Disk
stage2_classifier = DebertaSpanClassifier().to(device)
stage2_classifier.load_state_dict(torch.load(STAGE2_SAVE_PATH, map_location=device, weights_only=True))

# Run end-to-end Evaluation (F1, Recall, Precision)
var1_metrics, var1_class_report = t2_executor.evaluate_cascading_pipeline(
    span_detector_model=stage1_span_detector,
    classifier_head_model=stage2_classifier,
    test_path=VAL_PATH
)

cascade_f1 = var1_metrics["Macro-F1"]
upper_f1 = 0.5106   # Classifer Head Performance with Perfect Routing
degradation = upper_f1 - cascade_f1

print("     VARIATION 1: DECOUPLED CASCADING PIPELINE SUMMARY")
print("=" * 70)
print(f" Stage 2 Upper Ceiling (Perfect Spans) : {upper_f1:.4f}")
print(f" End-to-End Cascading Pipeline F1       : {cascade_f1:.4f}")
print(f" Span Detection Degradation (Delta)     : -{degradation:.4f}")
print("-" * 70)
print(" Detailed Classification Report (End-to-End Cascade):")
print(var1_class_report)
print("=" * 70 + "\n")

# %% [markdown]
# ### Analysis

# %%
# =====================================================================
# TASK 2 DIAGNOSTIC ANALYZER: 3-PHASE AUDIT FRAMEWORK
# =====================================================================

import numpy as np
from sklearn.metrics import accuracy_score

class Task2DiagnosticAnalyzer:
    """
    Implements a 3-phase diagnostic audit for Task 2 pipelines:
      - Phase 1: Structural Localization Audit (5 Routing States)
      - Phase 2: 'Near-Miss' Semantic Signal (Disqualified Boundary Accuracy)
      - Phase 3: Semantic Ceiling Comparison (Qualified Subset Accuracy vs. Upper Benchmark)
    """

    @staticmethod
    def audit_routing_states(gold_data: list, pred_data: list) -> dict:
        """
        Phase 1: Categorizes every validation row into one of 5 structural states.
        """
        states = {
            "TN_BACKGROUND_CORRECT": 0,  # Gold: not_propaganda | Pred: (-1, -1)
            "FN_COMPLETE_MISS": 0,       # Gold: active         | Pred: (-1, -1)
            "FP_HALLUCINATED_SPAN": 0,   # Gold: not_propaganda | Pred: active span
            "DISQUALIFIED_BOUNDARY": 0,  # Gold: active         | Pred: active span (Failed delta)
            "QUALIFIED_BOUNDARY": 0      # Gold: active         | Pred: active span (Passed delta)
        }
        
        disqualified_rows, qualified_rows = [], []

        for g, p in zip(gold_data, pred_data):
            is_gold_active = (g["technique"] != "not_propaganda")
            is_pred_active = (p["span"] != (-1, -1))

            if not is_gold_active and not is_pred_active:
                states["TN_BACKGROUND_CORRECT"] += 1
            elif is_gold_active and not is_pred_active:
                states["FN_COMPLETE_MISS"] += 1
            elif not is_gold_active and is_pred_active:
                states["FP_HALLUCINATED_SPAN"] += 1
            elif is_gold_active and is_pred_active:
                g_start, g_end = g["span"]
                p_start, p_end = p["span"]
                delta = Task2Evaluator.get_tolerance(g_end - g_start + 1)

                if abs(p_start - g_start) <= delta and abs(p_end - g_end) <= delta:
                    states["QUALIFIED_BOUNDARY"] += 1
                    qualified_rows.append((g, p))
                else:
                    states["DISQUALIFIED_BOUNDARY"] += 1
                    disqualified_rows.append((g, p))

        total_rows = len(gold_data)
        total_active_targets = sum(1 for g in gold_data if g["technique"] != "not_propaganda")

        return {
            "counts": states,
            "total_rows": total_rows,
            "total_active_targets": total_active_targets,
            "disqualified_rows": disqualified_rows,
            "qualified_rows": qualified_rows
        }

    @staticmethod
    def analyze_subset_accuracy(rows: list) -> float:
        """
        Phases 2 & 3: Evaluates multi-class semantic accuracy on a filtered 
        subset of spans (either Disqualified or Qualified), avoiding F1 skew.
        
        Produces % correct of a given subset
        """
        if not rows:
            return 0.0
        
        y_true = [g["technique"] for g, _ in rows]
        y_pred = [p["technique"] for _, p in rows]
        return accuracy_score(y_true, y_pred)

    @classmethod
    def run_full_diagnostic(cls, gold_data: list, pred_data: list, pipeline_name: str) -> dict:
        """
        Executes all 3 phases for a single pipeline and returns structured metrics.
        """
        audit = cls.audit_routing_states(gold_data, pred_data)
        near_miss_acc = cls.analyze_subset_accuracy(audit["disqualified_rows"])
        qualified_acc = cls.analyze_subset_accuracy(audit["qualified_rows"])

        return {
            "name": pipeline_name,
            "routing": audit["counts"],
            "total_active_targets": audit["total_active_targets"],
            "near_miss_accuracy": near_miss_acc,
            "disqualified_count": len(audit["disqualified_rows"]),
            "qualified_accuracy": qualified_acc,
            "qualified_count": len(audit["qualified_rows"])
        }

    @staticmethod
    def print_comparative_report(diagnostics: list, oracle_acc: float = 0.5178):
        """
        Prints a professional, structured ASCII comparative audit table.
        """
        print("=" * 90)
        print("               TASK 2 COMPARATIVE 3-PHASE DIAGNOSTIC AUDIT")
        print("=" * 90)
        print(f" ORACLE SEMANTIC CEILING (Gold Spans + Stage 2 Classifier) : {oracle_acc:.4f} (100.0%)")
        print("-" * 90)
        
        # Phase 1: Structural Localization Table
        print("\n### PHASE 1: STRUCTURAL LOCALIZATION AUDIT (THE 5 ROUTING STATE")
        print(f"{'Pipeline Variant':<28} | {'TN':<5} | {'Complete FN':<11} | {'Halluc. FP':<10} | {'Disqual.':<8} | {'Qual. TP':<8}")
        print("-" * 90)
        for d in diagnostics:
            r = d["routing"]
            print(f"{d['name']:<28} | {r['TN_BACKGROUND_CORRECT']:<5} | {r['FN_COMPLETE_MISS']:<11} | {r['FP_HALLUCINATED_SPAN']:<10} | {r['DISQUALIFIED_BOUNDARY']:<8} | {r['QUALIFIED_BOUNDARY']:<8}")
        
        # Phase 2: Near-Miss Semantic Signal Table
        print("\n### PHASE 2: 'NEAR-MISS' SEMANTIC SIGNAL (DISQUALIFIED BOUNDARY ACCURACY)")
        print(f"{'Pipeline Variant':<28} | {'Disqualified Spans':<20} | {'Near-Miss Semantic Accuracy':<25}")
        print("-" * 90)
        for d in diagnostics:
            count_str = f"{d['disqualified_count']} spans"
            print(f"{d['name']:<28} | {count_str:<20} | {d['near_miss_accuracy']:.4f}")

        # Phase 3: Semantic Ceiling Comparison Table
        print("\n### PHASE 3: SEMANTIC CEILING COMPARISON (QUALIFIED SPANS vs. ORACLE)")
        print(f"{'Pipeline Variant':<28} | {'Qualified Spans':<18} | {'Qualified Acc':<15} | {'Oracle Gap':<12}")
        print("-" * 90)
        for d in diagnostics:
            count_str = f"{d['qualified_count']} spans"
            gap = d['qualified_accuracy'] - oracle_acc
            gap_str = f"{gap:+.4f}" if d['qualified_count'] > 0 else "N/A"
            print(f"{d['name']:<28} | {count_str:<18} | {d['qualified_accuracy']:<15.4f} | {gap_str:<12}")
        print("=" * 90 + "\n")

# %%
# =====================================================================
# STANDALONE PREDICTION EXTRACTION HELPER
# =====================================================================

def collect_pipeline_predictions(model_or_cascade, test_path, executor, pipeline, mode="var2"):
    """
    This is ad-hoc function that runs inferences and returns raw (gold_data, pred_data) lists without
    called the main classes again. 

    Supports both Var 2 (single model) and Var 1 (tuple of stage1, stage2 models)
    """
    gold_data, pred_data = [], []
    
    # Check if we are executing a decoupled tuple (Stage 1 Span Detector, Stage 2 Head)
    is_cascade = isinstance(model_or_cascade, tuple)
    if is_cascade:
        stage1_model, stage2_model = model_or_cascade
        stage1_model.eval()
        stage2_model.eval()
    else:
        model_or_cascade.eval()

    with open(test_path, mode='r', encoding='utf-8') as file:
        reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
        for row in reader:
            label = row['label']
            clean_text, c_start, c_end, _ = pipeline.parse_span_and_clean(row['tagged_in_context'], label)
            input_ids, att_mask, tags_17 = pipeline.align_bio_tags(clean_text, c_start, c_end, label, mode="var2")
            g_start, g_end, _ = executor.extract_viterbi_span(tags_17[0].tolist(), mode="var2")
            
            input_ids_dev = input_ids.to(device)
            att_mask_dev = att_mask.to(device)

            if is_cascade:
                # --- VARIATION 1: DECOUPLED INFERENCE ---
                with torch.no_grad():
                    viterbi_path = stage1_model(input_ids_dev, att_mask_dev)[0]
                p_start, p_end, _ = executor.extract_viterbi_span(viterbi_path, mode="var1")
                
                if p_start != -1 and p_end != -1:
                    with torch.no_grad():
                        logits = stage2_model.forward_span_pooled(input_ids_dev, att_mask_dev, p_start, p_end)
                        p_tech = IDX_TO_TECH[torch.argmax(logits, dim=1).item()]
                else:
                    p_tech = "not_propaganda"
            else:
                # --- VARIATION 2: JOINT INFERENCE ---
                with torch.no_grad():
                    viterbi_path = model_or_cascade(input_ids_dev, att_mask_dev)[0]
                p_start, p_end, p_tech = executor.extract_viterbi_span(viterbi_path, mode=mode)
                
            gold_data.append({"span": (g_start, g_end), "technique": label})
            pred_data.append({"span": (p_start, p_end), "technique": p_tech})
            
    return gold_data, pred_data

# %%
# =====================================================================
# EXECUTE FULL COMPARATIVE 3-PHASE DIAGNOSTIC AUDIT (STANDALONE LOAD)
# =====================================================================

import os
import torch

set_seed(SEED)

TRAIN_PATH = '../data/propaganda_train.tsv'
VAL_PATH = '../data/propaganda_val.tsv'

# File paths to saved checkpoints
VAR2_MODEL_PATH = './final_models/var2_deberta_crf_joint.pt'
VAR1_STAGE1_PATH = './final_models/var1_stage1_span_detector_epoch10.pt'
VAR1_STAGE2_PATH = './final_models/var1_stage2_classifier_head_only.pt'

# Initialize core pipeline and executor utilities
t2_pipeline = Task2DataPipeline(model_checkpoint="microsoft/deberta-v3-xsmall")
t2_executor = Task2Executor(pipeline=t2_pipeline)

# Instantiate and Load Variation 2 (17-Class Joint Model)
var2_model = DebertaCRFTagger(mode="var2").to(device)
var2_model.load_state_dict(torch.load(VAR2_MODEL_PATH, map_location=device, weights_only=True))

# Instantiate and Load Variation 1 Models
stage1_span_detector = DebertaCRFTagger(mode="var1").to(device)
stage1_span_detector.load_state_dict(torch.load(VAR1_STAGE1_PATH, map_location=device, weights_only=True))

stage2_classifier = DebertaSpanClassifier().to(device)
stage2_classifier.load_state_dict(torch.load(VAR1_STAGE2_PATH, map_location=device, weights_only=True))

# Collect Baseline Predictions
random_baseline = Task2RandomBaseline(t2_pipeline, t2_executor)
empirical_ratio = _propaganda_ratio(TRAIN_PATH)
_, _, base_gold, base_pred = random_baseline.evaluate(VAL_PATH, prop_threshold=empirical_ratio)

# Collect Variation 2 Predictions
var2_gold, var2_pred = collect_pipeline_predictions(
    model_or_cascade=var2_model,
    test_path=VAL_PATH,
    executor=t2_executor,
    pipeline=t2_pipeline,
    mode="var2"
)

# Collect Variation 1 Predictions
var1_gold, var1_pred = collect_pipeline_predictions(
    model_or_cascade=(stage1_span_detector, stage2_classifier),
    test_path=VAL_PATH,
    executor=t2_executor,
    pipeline=t2_pipeline,
    mode="var1"
)

# Execute 3-Phase Audit across all variants
audit_base = Task2DiagnosticAnalyzer.run_full_diagnostic(base_gold, base_pred, "Random Baseline")
audit_var2 = Task2DiagnosticAnalyzer.run_full_diagnostic(var2_gold, var2_pred, "Variation 2 (17-Class Joint)")
audit_var1 = Task2DiagnosticAnalyzer.run_full_diagnostic(var1_gold, var1_pred, "Variation 1 (Decoupled)")

# Print Comparative Diagnostic Report
Task2DiagnosticAnalyzer.print_comparative_report(
    diagnostics=[audit_base, audit_var2, audit_var1],
    oracle_acc=0.5178   # Upper Accuracy from Head Eval
)

# %% [markdown]
# ### Additional Code 1: Subword Max Length

# %% [markdown]
# Ensuring instances do not exceed DeBERTas max length capcity. 

# %%
import numpy as np
from collections import Counter

def analyze_dataset_token_lengths(pipeline, train_path):
    token_counts = []
    
    with open(train_path, mode='r', encoding='utf-8') as file:
        reader = csv.DictReader(file, delimiter='\t', quoting=csv.QUOTE_NONE)
        for row in reader:
            clean_text, _, _, _ = pipeline.parse_span_and_clean(
                row['tagged_in_context'], row['label']
            )
            # Tokenize using your pipeline's DeBERTa tokenizer without truncation
            tokens = pipeline.tokenizer.encode(clean_text, add_special_tokens=True)
            token_counts.append(len(tokens))
            
    token_counts = np.array(token_counts)
    
    print("=" * 50)
    print("      DEBERTA SUBWORD TOKEN LENGTH ANALYSIS      ")
    print("=" * 50)
    print(f"Total Sentences Analyzed : {len(token_counts)}")
    print(f"Min Token Length         : {np.min(token_counts)}")
    print(f"Max Token Length         : {np.max(token_counts)}")
    print(f"Mean Token Length        : {np.mean(token_counts):.2f}")
    print(f"Median Token Length      : {np.median(token_counts):.1f}")
    print(f"95th Percentile          : {np.percentile(token_counts, 95):.1f}")
    print(f"99th Percentile          : {np.percentile(token_counts, 99):.1f}")
    print("-" * 50)
    
    over_256 = np.sum(token_counts > 256)
    over_512 = np.sum(token_counts > 512)
    
    print(f"Sentences > 256 tokens   : {over_256} ({over_256 / len(token_counts) * 100:.2f}%)")
    print(f"Sentences > 512 tokens   : {over_512} ({over_512 / len(token_counts) * 100:.2f}%)")
    print("=" * 50)

test_pipeline = Task2DataPipeline()
analyze_dataset_token_lengths(test_pipeline, '../data/propaganda_train.tsv')

# %% [markdown]
# # Silver Data

# %%
import logging
import sys

# 1. Initialize a named logger (Leave global level at INFO so it captures everything)
logger = logging.getLogger("propaganda_logger")
logger.setLevel(logging.INFO)

# 2. Clear out any existing handlers (prevents duplicate logs when rerunning cells)
if logger.hasHandlers():
    logger.handlers.clear()

# 3. Create a File Handler (Saves EVERYTHING to your text file)
file_handler = logging.FileHandler("propaganda_augmentation.log", mode="a", encoding="utf-8")
file_formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
file_handler.setFormatter(file_formatter)
file_handler.setLevel(logging.INFO) # <--- Force the file to capture every single log trace
logger.addHandler(file_handler)

# 4. Create a Stream Handler (Controls live notebook console printing)
stream_handler = logging.StreamHandler(sys.stdout)
stream_formatter = logging.Formatter('%(message)s') 
stream_handler.setFormatter(stream_formatter)

# --- THE BIG RUN FIX ---
# Raise this to WARNING or ERROR. This tells the screen: 
# "Only interrupt my notebook if a row crashes or an API error occurs. Otherwise, stay quiet."
stream_handler.setLevel(logging.WARNING) 
logger.addHandler(stream_handler)

print("Logging system optimized for Batch Run! Detailed transcripts -> 'propaganda_augmentation.log'")

# %%
from openai import OpenAI

import os
from dotenv import load_dotenv

# 1. This reads the hidden text file and injects the variables into system memory
load_dotenv()

# 2. This pulls the key string safely out of system memory
together_key = os.getenv("TOG_API_KEY")

# 3. Double check it worked (it shouldn't be None)
if together_key:
    print("[SUCCESS] API Key loaded into notebook background environment memory.")
else:
    print("[ERROR] Could not find TOGETHER_API_KEY. Check your .env file location!")



client = OpenAI(
    api_key=together_key,
    base_url="https://api.together.xyz/v1"  # This one line redirects the traffic!
)

def call_llama(messages: list, temperature: float = 0.7) -> str:

    try:
        response = client.chat.completions.create(
            model="meta-llama/Meta-Llama-3-8B-Instruct-Lite", # together naming 
            # model="openai/gpt-oss-20b", 

            messages=messages,
            temperature=temperature,
            # max_tokens=512
        )
        return response.choices[0].message.content.strip()
    except Exception as e:
        print(f"Cloud API Error: {e}")
        return ""

# %%
import re

def extract_final_snippet(llm_output):
    """
    Tiered extraction to find the final snippet, handling LLM hallucinations.
    """
    if not llm_output:
        return ""

    # Tier 1: Strict Tags
    strict_pattern = r"<final_snippet>(.*?)</final_snippet>"
    strict_matches = re.findall(strict_pattern, llm_output, re.DOTALL | re.IGNORECASE)
    if strict_matches:
        return strict_matches[-1].strip()

    # Tier 2: Broken Tags Fallback
    bracket_pattern = r">(.*?)<"
    bracket_matches = re.findall(bracket_pattern, llm_output, re.DOTALL)
    if bracket_matches:
        candidate = bracket_matches[-1].strip()
        if candidate and not candidate.startswith('/'):
            return candidate
        

    ## TODO: MAKE SURE THAT LEFT AND RIGHT CONTEXT ARE NOT IN THE SNIPPET
    ## TODO: IF THEY ARE THEN REMOVE
    ## TODO: AFTER CHECK THAT A SNIPPET STILL REMAINS
    ## TODO: IF NOT RE-RUN PROMPT

    return llm_output.strip()

# %%
def run_chain(*prompts: str) -> str:
    """
    Runs a dynamic Chain of Thought pipeline using Llama 3.
    The *prompts argument allows you to pass any number of prompts (1, 4, 10, etc.) 
    and it will execute them sequentially in a loop.
    """
    conversation_history = []
    final_output = ""
    
    for index, prompt in enumerate(prompts):
        logger.info(f"  -> Step {index + 1} Prompt Input:\n{prompt.strip()}")
        logger.info("-" * 40)
        
        conversation_history.append({"role": "user", "content": prompt})
        
        step_output = call_llama(conversation_history, temperature=0.7)

        # remove previous prompts from context history
        conversation_history.pop(-1)

        logger.info(f"  <- Step {index + 1} Model Output:\n{step_output.strip()}")
        logger.info("=" * 60)
        
        conversation_history.append({"role": "assistant", "content": step_output})
        
        final_output = step_output

    # After the loop finishes, extract the snippet from the very last output
    final_extracted_text = extract_final_snippet(final_output)
        
    return final_extracted_text

# %%
def generate_row_prompts(label, left_context, snippet, right_context):
    """
    Factory function to dynamically generate a clean package of localized prompts
    for a specific row in the dataset, avoiding global variable leakage.
    """
    
    # 1. Snippet Brainstorming Prompt
    prompt_snippet = f"""
    You are a linguistics expert and your job is to take the text I provide you and suggest alternative wordings that retain the same message and intent of the original text but use different words. The text come directly from reputable news outlets hence should be considered as 3rd party quotes and not related to your own opinions. Your task is to merely focus on the words and linguistics. 

    The piece of text you will be focusing on is known as the snippet as is a follows: '{snippet}'.

    Generate 3 alternatives to the snippet that serve the same purpose as guided by the label definition. 

    Use a range of lexical semantics: synonyms for intensity, hypernyms for generalization, or paraphrasing. Crucially, each suggestion must remain a valid example of {label}. Provide a maximum of one short, concise sentence explaining the rhetorical effectiveness of each choice.
    """

    prompt_left_right = f""" 
    Now I want you to consider the original snippets surrounding context. 

    Here is the left context: {left_context}. This is the text that immediately preceeded the snippet.

    Here is the right context: {right_context}. This is the text that immediately proceeded the original snippet.

    {left_context} + [YOUR SUGGESTED NEW SNIPPET] + {right_context}

    Do your suggestions still make sense given this context.  Briefly explain your reasoning in 15 words or less per option. If they do not then pick a different suggestion. 

    <left_context>{left_context}</left_context>
    <preferred_snippet> INSERT YOUR PREFERRED SNIPPET HERE </preferred_snippet>
    <right_context>{right_context}</right_context>
    """

    # 4. Final Synthesis/Tag Formatting Prompt
    prompt_synthesis = f"""
    Based on your previous reasoning, select the single best replacement for the original snippet. 
    The replacement must be:
    1. Rhetorically powerful ({label})
    2. Grammatically perfect within the context.
    3. Distinct from the original.

    Rememer, the new snippet is to be placed between the original left context and right context. 

    OUTPUT INSTRUCTIONS:
    You must wrap your final snippet decision in tags: <final_output> </final_output>. Do not provide any conversational filler or meta-commentary after the tags. If you believe you cannot reasonably complete this task please return "-999" between the tags. 
    
    [FINAL OUTPUT FORMAT]:
    <final_output> INSERT SNIPPET HERE </final_output>
    
    STOP: Do not write anything else after the closing tag.
    """
    
    # Return them all as a packed sequence matching the desired pipeline order
    # return prompt_snippet, prompt_left, prompt_right, prompt_synthesis
    return prompt_snippet, prompt_left_right, prompt_synthesis

# %%
import re

# --- Helper Function: The Context Splitter ---
def split_tagged_context(tagged_text):
    """
    Splits 'No, <BOS> he <EOS> will not be confirmed.' 
    into ('No, ', 'he', ' will not be confirmed.')
    """
    # Matches anything before <BOS>, everything inside <BOS>/<EOS>, and everything after <EOS>
    pattern = r"^(.*?)<BOS>(.*?)<EOS>(.*?)$"
    match = re.search(pattern, str(tagged_text), flags=re.DOTALL)
    
    if match:
        return match.group(1), match.group(2).strip(), match.group(3)
    return None, None, None

# %%
def remove_context_overlap(snippet, left_context, right_context):
    """
    Strips regurgitated left or right context from the generated snippet.
    """
    if not snippet: 
        return ""
        
    s_clean = snippet.strip()
    left = left_context.strip()
    right = right_context.strip()

    # 1. Check for exact full-string prepends/appends first
    if left and s_clean.lower().startswith(left.lower()):
        s_clean = s_clean[len(left):].strip()

    if right and s_clean.lower().endswith(right.lower()):
        s_clean = s_clean[:-len(right)].strip()

    # # 2. Check for partial overlaps (e.g., model copied the last 20 chars of left context)
    # # We require a minimum overlap of 15 characters to prevent false-positive stripping
    # min_overlap = 15

    # # Left partial overlap (suffix of left matches prefix of snippet)
    # if len(left) >= min_overlap:
    #     for i in range(min(len(s_clean), len(left)), min_overlap - 1, -1):
    #         if s_clean.lower().startswith(left[-i:].lower()):
    #             s_clean = s_clean[i:].strip()
    #             break

    # # Right partial overlap (prefix of right matches suffix of snippet)
    # if len(right) >= min_overlap:
    #     for i in range(min(len(s_clean), len(right)), min_overlap - 1, -1):
    #         if s_clean.lower().endswith(right[:i].lower()):
    #             s_clean = s_clean[:-i].strip()
    #             break

    return s_clean

# %%
import time
import pandas as pd
from tqdm import tqdm

def run_propaganda_augmentation(input_df, max_retries=2):
    """
    Executes the Chain-of-Thought data augmentation pipeline over a given dataframe.
     Filters out 'not_propaganda' rows automatically.
    
    Parameters:
    -----------
    input_df : pd.DataFrame
        The baseline propaganda dataset containing 'label' and 'tagged_in_context'.
    sample_size : int, optional
        If provided, randomly samples N rows for spot checking. If None, processes all.
    max_retries : int, default 2
        Number of additional attempts allowed if validation fails.
    random_state : int, default 99
        The seed used for sample reproducibility.
        
    Returns:
    --------
    pd.DataFrame
        A pristine dataframe containing the successfully generated silver rows.
    """

    df_filtered = input_df[input_df['label'] != 'not_propaganda'].copy() # check for prop
    df_working = df_filtered.copy()
        
    silver_rows = []
    
    logger.info(f"--- STARTED NEW AUGMENTATION RUN: Processing {len(df_working)} rows ---")
    print(f"Beginning pipeline execution for {len(df_working)} target rows...")
    
    # 3. Main Data Orchestration Iteration
    for index, row in tqdm(df_working.iterrows(), total=len(df_working)):
        
        # Instance Components Extraction
        left_context, snippet, right_context = split_tagged_context(row['tagged_in_context'])
        label = row['label']

        logger.info(f"Processing Index: {index} | Label: {label}")
        logger.info(f"Original Text: {left_context} <BOS> {snippet} <EOS> {right_context}")
        logger.info(f"Original Snippet: {snippet}")
        
        if snippet is None:
            logger.warning(f"Regex extraction failed at row index {index}. Row skipped.")
            continue

        # Prompt Generation via Factory Function
        # p1, p2, p3, p4 = generate_row_prompts(label, left_context, snippet, right_context)
        p1, p2_3, p4 = generate_row_prompts(label, left_context, snippet, right_context)
        
        final_valid_snippet = None
        
        # --- THE RETRY LOOP ---
        for attempt in range(max_retries + 1):
            attempt_name = "Initial Attempt" if attempt == 0 else f"Retry #{attempt}"
            logger.info(f"\n--> Launching {attempt_name}...") # <--- CHANGED TO .info()
            
            try:
                # Call dynamic LLM chain
                # new_snippet = run_chain(p1, p2, p3, p4)
                new_snippet = run_chain(p1, p2_3, p4)

                # remove overlapping text
                new_snippet = remove_context_overlap(new_snippet, left_context, right_context)
                
                # Condition Check 1: Extraction Failure
                if new_snippet is None or len(new_snippet.strip()) == 0:
                    logger.warning(f"Index {index} - {attempt_name} failed: Empty output.")
                    continue
                    
                # Condition Check 2: Lack of Variation (Duplicated exact text)
                if new_snippet.strip().lower() == snippet.strip().lower():
                    logger.warning(f"Index {index} - {attempt_name} failed: Output matched original text.")
                    continue

                # Condition Check 3: Model outputted raw instruction template instructions
                if new_snippet.strip().lower() == "[INSERT YOUR PREFERRED SNIPPET HERE]".lower(): 
                    logger.warning(f"Index {index} - {attempt_name} failed: Output contained raw tag placeholder template string.")
                    continue
                
                # Success Route: If it passes all validation criteria, lock it in
                logger.info(f"    [SUCCESS] Valid new variation captured on {attempt_name}: '{new_snippet}'")
                final_valid_snippet = new_snippet

                logger.info("===")
                logger.info(f"OLD SNIPPET: {snippet}")
                logger.info(f"NEW SNIPPET: {final_valid_snippet}")
                logger.info("===")
                
                # time.sleep(2.5)  # Free tier safe pacing interval
                break 
                
            except Exception as e:
                if "429" in str(e) or "rate_limit" in str(e).lower():
                    print("    [RATE LIMIT] Hitting Groq limits. Cooling down for 10s...")
                    # time.sleep(10)
                else:
                    print(f"    [ERROR] {str(e)}")
                continue

        # --- POST-RETRY PACKAGING ---
        if final_valid_snippet:
            silver_tagged_text = f"{left_context} <BOS> {final_valid_snippet} <EOS> {right_context}"

            silver_rows.append({
                'original_index': index,
                'label': label,
                'silver_tagged_in_context': silver_tagged_text,
            })

            logger.info(f"Index {index} - Successful Generation: {silver_tagged_text}")
            logger.info("=" * 60 + "\n\n")
        else:
            print(f"\n[ALERT] Row index {index} exhausted all {max_retries + 1} attempts. Skipping row.")
            logger.error(f"Index {index} - CRITICAL: Exhausted all attempts. No silver row created.")
            logger.info("=" * 60 + "\n\n")

    # 4. Compile final data collection
    df_silver_output = pd.DataFrame(silver_rows)
    logger.info(f"--- RUN FINISHED. Successfully generated {len(df_silver_output)} silver rows ---")
    
    return df_silver_output

# %%
import os
import pandas as pd
from tqdm import tqdm

# ==============================================================================
# CONFIGURATION & CHECKPOINT SETTINGS
# ==============================================================================
BATCH_SIZE = 100
SILVER_OUTPUT_FILE = "propaganda_silver_augmented_master.tsv"
JOINED_OUTPUT_FILE = "propaganda_full_joined_final.tsv"

# 1. Filter out non-propaganda rows right away to establish our true work target
df_target = df[df['label'] != 'not_propaganda'].copy()
total_target_rows = len(df_target)

print(f"Total target propaganda rows to process: {total_target_rows}")

# 2. STATE RECOVERY: Check if we have an existing progress backup file
processed_indices = set()
if os.path.exists(SILVER_OUTPUT_FILE):
    try:
        df_existing = pd.read_csv(SILVER_OUTPUT_FILE, sep='\t')
        if 'original_index' in df_existing.columns:
            processed_indices = set(df_existing['original_index'].unique())
            print(f"[RESUMING RUN] Found existing progress. {len(processed_indices)} rows already completed. Skipping them.")
    except Exception as e:
        print(f"[WARNING] Could not read progress file ({e}). Starting fresh.")

# 3. Filter out rows that have already been processed in previous sessions
df_todo = df_target[~df_target.index.isin(processed_indices)].copy()
print(f"Remaining rows left to process in this run: {len(df_todo)}")




# ==============================================================================
# MASTER BATCH ITERATOR
# ==============================================================================
if len(df_todo) > 0:
    # Break the remaining rows into chunks of 100
    for i in range(0, len(df_todo), BATCH_SIZE):
        batch_df = df_todo.iloc[i : i + BATCH_SIZE]
        
        start_idx = i + len(processed_indices)
        end_idx = min(start_idx + BATCH_SIZE, total_target_rows)
        print(f"\n{"="*40}\n[BATCH] Processing rows {start_idx} to {end_idx} (Size: {len(batch_df)})\n{"="*40}")
        
        # Call your existing function to process this localized chunk
        # Note: We pass the chunk directly. Since it filters for propaganda internally, 
        # it will cleanly process all rows in our batch_df.
        df_batch_silver = run_propaganda_augmentation(batch_df, max_retries=2)
        
        # If the batch successfully generated any valid rows, write them out immediately
        if not df_batch_silver.empty:
            # Check if file exists to determine if we need a column header
            file_exists = os.path.exists(SILVER_OUTPUT_FILE)
            
            # Append mode ('a') safely stacks the new rows onto the bottom of the file
            df_batch_silver.to_csv(
                SILVER_OUTPUT_FILE, 
                sep='\t', 
                mode='a', 
                index=False, 
                header=not file_exists
            )
            print(f"[CHECKPOINT] Saved {len(df_batch_silver)} new rows securely to {SILVER_OUTPUT_FILE}")
        else:
            print("[BATCH ALERT] This batch yielded 0 valid generations. Moving forward safely.")

    print(f"\n\n*** SUCCESS: ALL BATCHES COMPLETE! ***\n")
else:
    print("\n[INFO] All target rows are already processed according to your master file!")


# ==============================================================================
# FINAL MASTER ASSEMBLY & JOIN
# ==============================================================================
print("Assembling final unified master tables...")
df_silver_master = pd.read_csv(SILVER_OUTPUT_FILE, sep='\t')

# Convert the master rows collection back to an index-mapped layout
df_silver_master.set_index('original_index', inplace=True)

# Smoothly left-join the entire completed silver column back to your original source dataset
df_final_joined = df.join(
    df_silver_master[['silver_tagged_in_context']], 
    how='left'
)

# Export the master validation spreadsheet
df_final_joined.to_csv(JOINED_OUTPUT_FILE, sep='\t', index=True)
print(f"[EXPORT COMPLETE] Master joined dataset saved safely to: {JOINED_OUTPUT_FILE}")

# Display a final visual preview
print("\n--- FINAL MASTER PREVIEW ---")
with pd.option_context('display.max_colwidth', None):
    display(df_final_joined[df_final_joined['label'] != 'not_propaganda'][['label', 'tagged_in_context', 'silver_tagged_in_context']].head())


