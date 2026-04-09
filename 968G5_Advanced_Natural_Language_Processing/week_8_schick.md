topic: fine-tuning pipeline, cls, token, freeze

the paper we are studying, bridges all 3 have learnt RE. bert with prompt driven future which will continue to be to the topic of study for the next week(s).

---

transfer learning generally implies there is a pelthora of data to learn from. But what happens when we are lacking in data?

few-shot learning means trying to get a model to generalize to unseen data using small amount of labeled examples. i.e. 10 examples, maybe 50. 

In standard supervised fine-tuning you take a pre-trained bert model which outputs a 768-dimension vector for `<CLS>` token and bolt on a randomly initalized linear layer. 

The issue here is that the random init is just noise. We need to update and **fine-tine** via gradient descent and backprop to update the weights to something meaningful. However, if you only have 10 examples, this is a tough task to get the weights of the linear layer trained - the signal is too weight. 

The paper gives a great example on restaurant reviews. Imagine the trainining dataset only had 2 sentences. 

T1: This was the best pizza I’ve ever had: +1
T2: You can get better sushi for half the price: -1

Plus an unseen sentence for evaluation 

T3: Pizza was average. Not worth the price.

A nn would be lost. It would be lost because it lacks a fundemental task description. 

The first two sentences have multiple interpretations of the task. 

Is the task quality? is the task price sentiment?

The model can get confused on T2 and T3 and the gradients pull the senteces in opposite directions. The hypothesis space is too large. 

If we could just explicitly tell the model what the specific task is then the classification would be trivial.

How to we give the model instructions without changing the architecture or bolting something on. 

This is where the paper introduces its core mechanism, the "cloze" question. Or in NLP terms, masked language modelling. 

"The captial of france is <blank>"

BERT is optimized for filling in blanks.

The authors of the paper asked a simple questions: "instead of forcing the model to learn a new mathematical mapping to an arbitary label space from scratch, why don't we just reformat our classification task to look exactly like the pre-training task"

If we reformulate the task into a fill in the blank question then we bypass the need for a new classification head. we don't have to allign random weights. The model just relies on the intricate, mutli-dimensional geometric space it already built during pre-training. 

Translate tasks into fill in the blank tasks

But how do we write the code to do that? How to translate a dataframe of raw text. the implementation.

Pattern verbaliser pair. key point of methodology. PVP.

takes raw input text $X$ and transforms it into cloze task with exactly 1 masked token. it provides the syntatical scaffolding. 

i.e. input is restaraunt review and the abstract labels in the dataset are 1-5 (ratings)

we difine a pattern function. "it was blank" 

how to we map whatever the model guesses back into out 1-5 class ratings

that is the job of the section function the verbaliser V

the verbliser is defined as an injective function that maps each abstract label to a specific real word that already exists in the pre-trained language models vocab. 

injective function: means one-to-one-mapping. map word to classes. two classes/labels (ratings) cannot map to the same word. 

Yelp example: ... results in classifying a review without a classification head

examples of pvps:

note, masks can go anywhere in the sequence

"i felt blank about this"

pos and neg labels

map pos to vocab word great, map neg to vocab word terrible

example of vastly more complicated task

usually requires dual encoding architectures

given two distinct sentences and need to determin if they mean the same thing or not

T1:T2

for the pattern we need to present both and ask for a comparison

"t1, t2, do these mean the same thing? <blank>"

the abstract label for this task is generally "yes" for entailment or "no" for condradiction

the verbaliser function for the entailment label to the vocab label yes and the contradiction label to no

taking high dim comparitive task and asking the mdoel to boil it down to a label task purely using its learn reading comprehension

how does the math work during trianing? you have the input text with the mask, you feed it into roberta then what? 

pass the patternised into into the pre-trained model. model process sequence through its transofrmers layers. when we get to the final output layer, we look only only at the specific token related to the position of the mask. we throw away/ignore the output vectors for all over words in the sentence. 

take the single hidden state vector the masked tokens and projects it accross the entire vocab. we get a massive vector of unormalised logits for every word the model knows. i.e. vector of 50k vocab = 50k logits. 

however, we don't care about all the words, we just care about the verbaliser words. 

verbaliser definition slices the massive vector. we looks up the specific target word indices and example only these logits, i.e. terrible, bad, good, great

apply softmax accorss those specific unnormalized scores. 

started masked language modelling applies the softmax across the whole vocab. however we calc the exponents of the softmax denonominator using only the chosen target words. 

this creates a highly restricted localised probability distribution. we force the model to distribute 100% of the probabiliy mass exclusively among the label words. 

When we are fine-tuning across our 10 example sentences, how do we calculate the loss? we use standard cross ent loss. we know the true,  label of the training example, i.e. 1* review. our verbliser tells us the true target word is terrible. so out true target distribution, the Q in the cross ent formula, is essentially a one hot vector, i.e. 1 for the terrible slot and 0 for the others. We compute the cross ent loss between this label (true distribution) and the models softmax distribution output. 

negative log likelihood. we take the log of the modles assign probabliliy for terrible, mutliply it by 1, and since the true probs for the other distributions are 0, the calculation essentially drops them out of the calculation. 

we then backprop that single loss value back down the transformer layers to update the weights. 

this is the fundemental mechanism of pattern exploiting training

until you hit the brick wall of catastrophic forgetting

roberta, 350 millon weights, try to update via backprop using only 10 examples. 

this is definining vulnerable of llm's: catastrophic forgetting

why this happens? generalist model to specalist update with few examples, the gradient updates are too concetrarted. 

the model forget and overwrites the vast knowledge it learnt during the training phrases and wildly overfits to the training examples and their synatic qwerks

the careful balance of the mutlidimensional latent space, the very thing that made the model a good general reasoner is destroyed. 

To prevent this, the authors didn't just rely on early stopping or extreme dropout, they implemented a highly structural solution: auxiliary language modelling.

this is where we need to look at the combined loss function they use, it isn;t just the stardard cross ent. they add second term. llm is the language model loss. 

they leverage the realtiy of the data env

in practice, you tend to have only few labelled examples but a huge repo of unballed data. i.e. millions of raw yelp reviews without ratings. 

so whilst they are fine-tuning the model on the small amount of examples to learn the specific task, they simeltan pass the model massive batches of the unlablled data. 

on the lableled, they ask the model to do standard masked training. rand mask tokens and ask model to predict acess whole vocab, exactly the same as the orginal pre-training. they calc the loss of this standard task and add it the cross ent. this is the llm_loss term which tye add to the pattern_loss. 

isnt this diluteing the specalist fine-tuning? it pulls the graidnets in opposite directions to the specalist but this is fine. it acts as an anchor to regularize the updates. it creates friction against the fine-tuning gradients. fritcion prevents the model from warping its latent space in overfitting the few-shot examples. 

Forces the model to maintain its general language competantcies while slowly adpating to the specalised task. 







