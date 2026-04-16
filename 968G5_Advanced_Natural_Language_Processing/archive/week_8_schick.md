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

until you hit the brick wall of **catastrophic forgetting**

roberta, 350 millon weights, try to update via gradient descent/backprop using only 10 examples. 

this is definining vulnerable of llm's: the problem of catastrophic forgetting

why this happens? generalist model adapts to highly specalist task updated using a dataset with few examples, the gradient updates are too concentrated. 

the model forget and overwrites the vast knowledge it learned during the **expensive** training phrases and wildly overfits to the training examples and their synatic qwerks

the careful balance of the mutli-dimensional latent space, the very thing that made the model a good general reasoner is destroyed. 

To prevent this, the authors didn't just rely on early stopping or extreme dropout, they implemented a highly structural solution: auxiliary language modelling.

this is where we need to look at the combined loss function they use, it isn't just the stardard cross ent. they add second term. llm is the language model loss. 

[INCLUDE FORMULA AND A BREAKDOWN OF ITS PARTS]

The approach here is to leverage the realtiy of the data environment

in practice, you tend to have only few labelled examples but a huge repo of unballed data from the same domain. i.e. millions of raw yelp reviews without ratings. 

so whilst they are fine-tuning the model on the small amount of examples to learn the specific task, they simeltan pass the model massive batches of the unlablled data. 

on the lableled, they ask the model to do standard masked training. rand mask tokens and ask model to predict acess whole vocab, exactly the same as the orginal pre-training. they calc the loss of this standard task and add it the cross ent. this is the llm_loss term which tye add to the pattern_loss. 

but, if the task is to hyper-specalise the models weights, to become really good at predicit sentiment based on the given cloze pattern. 

isnt this diluteing the specalist fine-tuning but forcing it to predict random words like "the" or "restruant"? it pulls the graidnets in opposite directions to the specalist but this is fine. it acts as an anchor to regularize the updates. the auxilary task is a regularization term. it creates friction against the fine-tuning gradients. friction prevents the model from warping its latent space in overfitting the few-shot examples. 

This is managed through an alpha term. If alpha = 1 we are just doing pre-training, if alpha = 0 we will suffer catastrophic forgetting.  

The paper used a tiny number 10^-4

This is still able to impact the gradients because of the way the LLM loss is compute, i.e. against a massive vocab. The magnitude of the language model loss. Numerically much larger than the cross ent loss of the labelled pattern task. 

The small alpha is used to balance the scales between the two losses.

Keeps the models general language abilties "warm" by anchoring the weights but still allows rapid adaptation to the task. 






How to we pass in the unlabelled? do we also pattern mask it? or are we just passing in raw text?

It is patterned but the model is never asked to predict the mask. Instead other random works in the sequence are masked and the model is asked to predict those. 

The model is still being exposed to the structural syntax of the sequence which reinforce the template but it is practising it's general language skills on the surround context.

This provides us with a mathmatically sounds safe way to train a model using a single (i.e. doesn't need to be updated to handle the unlablled data) pattern verbisler pair without destroying the model (cat forgetting)

What to do about a validation set if you only have 10 examples? We can supplement our learning with unlaballed data but what about validation? you don't, you use the power of ensembles and knowledge distilation. the paper has a 3 step methodology to handle this. 

#### Step 1
Because we don't know which PVP is the best. create mutli distinct patterns. take tiny training examples. train model for each pattern. Note, this means the entire model, i.e. a whole roberta. This doesn't need to be expensive, which fine-tuning is not meant to be, because the scale of the few-shot data is small so fine-tuning shouldn't be to intensive. 

have an ensemble of 4 models, each uniquely tuned to a different perspective of the task. 

#### Step 2
Take the ensemble and unleash on massive unlabeled dataset. 

Everything ensemble will look at every instance and make a prediction. 

The combine predictions by averaging the normalized scores

This creates "soft labels" for the previously unlabelled data

What conceptually is a soft label? To start a hard label is a one-hot vector, its is not ambiguous it is X. A soft label is a continious probability distribution. the ensemble averages the diserve outputs of the pattern models meanign the output looks somehting like 80% A, 10% B, 10% C. 







Paper utilised something called tempurature to flatten the probablitiy distirbution. Temp is borrow directly from Jeff Hintons 2015 landmark paper on Knowledge Distillation. 

An example is the think about the standard softmax formula. You take the exponential of each logit, e^z, and divide by the sum of the exponential of all. if one logit is signif higher than the rest then the expo function massive exaggurates this. the output becomes highly peaked. This allows the model to become hyper confident

With tempurate, we divide every logit by t before applying the expoential function: e^z/t

by dividing the logits by t, we shrink the absolute differences between them 

we pass the compressed logits throught the softmax the reusltinf distirubiton is much smoother. where the split before may have been 99% vs 1 it may now be something like 85 vs 15

why would be want this? wouldnt this be intentiolaly making the labels less accurate? we want confiendece by we are in the process of transfering knowledge. those low level probabilties, i.e. the 1% or 0.0001%, are what Hinton refer to as Dark Knowledge. Now that the ensemble now thinks that the text has a 15% chance of being X carries specific naunces informaiton about the structural vocabiliariy and semantics bounardary of the sentence. it math demonstates that the two (or more) categories carry latent features. 

a hard label destroy naunces, a soft label preserves it

remeber, the way that we got these different labels was by producing langauge models from the same sentences using different maskes. the orgiinal texts are producing these labels meaning they are related in some way and shouldn't be discarded which is what a prob of 0.00001 would essentially do. 

we want to capture dark knowledge in the newly soft labelled dataset

we are cpaturing the ensembles collective uncertaintly as a feature, not a bug. 


steps recap: 
1. train an ensemble of individual pattern models
2. use the ensemble to generate tempruate scaled softed labels to a massive pile of unlabeled data. giving us a large synethic dataset. 

#### Step 3
take the synethic dataset and use it to training a standard language classififer. i.e. sequence classification with a head bolted onto a CLS token. 

Drop Cloze Patterns, throw away PVPs, we just feed raw input into a roberta model with a classification head and training it to minize the cross ent against generate soft labels.

the previous steps were just extraction methods for the classifier

prompt based knowledge extraction: data effiency of prompting

standard supervised fine-tuning: inference speed and simplicity of a standard classifer 





But there is a glaring vunerablilty which emerges in step 2 which the paper authors recognised. When we average the ensemble outputs, which happens if half of the human patterns (?) were just garbage? if you have 5 patterns but 3 are misaligned with the models latent space, they will make terrible widely inaccurate predictions. when you average the emseble predictions will dragt he average down and pollute the soft labels. this means the classification in step 3 will be learning from bad data. 

How to fix the bad pattern problem? the author introduce iPete(?), Iterative Pete. Doesn't filter out the bad patterns, it rehabilites them. IP introduces generational learning. Instead of jumpingg from the initial ensemble to final classifer, train models is descrete expanding generations allowing the weaker models to learn from the highly confident stronger peers. 

Generation 0: train ensemble of seperate pattern models indep on the tiny dataset. instead of having this ensemble label the entire unlabeled dataset we randomly subset. Paper used 25%. Take this random subset and then look at a new set of examples from the unlabelled. But we don't just blindly accept all the predictions, if they are still weak models they will pollute the pool. We only accept the examples where the subset agrees with extreme confidence. If the ensemble models overwhelmingly aggress on the label for an unlabeled sentence we trust the prediction. We take the newly confidently labelled examples and add them to the original training pool. This is dynamically expanding the dataset. The paper used a mutlipler constant D set to 5 meaning the training dataset gets x5, 10 to 50. 

After this we instantiate Generation 1. Init a whole new ensemble of pattern models but this time they are trained on 50 exmaples, not 10. Here, even the models with awkward patterns start to perform drastically better. The extra data overcomes the poor systax of the PVP. Learn to map the awkward patter better. Then take another random subset of the generation 1 models (so the 25% is of the models not the data?????) and have them confidently label more data which quintuples (?) the data. i.e. 50 to 250. 

We then train generation 2. this process of repeated, growing the dataset, until we have 1000s of quality labelled exmaples. 

only then do we perform the final soft label distilation and train the final classifer. 


it an elegant way to mitigate the risk of human error in pattern design

ipet is robust it can perform in a zero-shot environemnt. this means you start with 0 labelled exmaples. gen 0 has no training data. take pretrain model, apply human written cloze patterns to the unlabelled data. is the output just random noise? not entirely, because the pretrained model semantically udnerstand language, a small subsection of the prections will happen to be correct and highly confident, purely by chance and latnet linguistic alignment. use these predictions to create the first batch of labelled data and then it proceeds the same as the few-shot example. 

bootstap a specalised classifier from nothing but the underlying generalized





---
---

# Podcast Conclusion Points

The main conclusion for this paper was paradigm shifting for the era that it was published in

It proves math and emp that providing explicit task descriptions via cloze questions allows us to seemlessly combine the inate generalized pre-trained knowledge of lang models with the regiour of standard supervised training.

it bridges chasm between pure zero shot prompt with traditional supervised fine-tuning

this papaper does not live in acedemic vacum, instead it lives with the messy engineering reality

does assume huge budget

solves catastropic forgetting elegently with the alpha weight aux loss

utilise cheap unlablled data and conceeds that we rarely have huge labelled datasets in the real world

would you use this in a nlp project today? pet metholodgy, definetly, esp if you had a massive database of raw unlabelled data, i..e unread customer serviced tickets but you only have the budget to go through and label 50 of them. define 3 intuative pvps, run the ipet loop, and bootstrap and highly accurate classifier in as little as an afternoon. 

it maximise the return on human annotation more than almost any other technique in its class

practical lightweight weapon

we spent the week looking at the encode only bert models that structurally require custom classifcation heads to output decisions

next week we are looking towards the genreative era where everything is a text prompt

this paper is very important for this transition. 

This paper took a bert style model which is an arch style purlyh for internal representation and by using cloze questions they forced it to act like a generative prompt drive model 

they proved that the arch boundary between understadning text like bert and generating text from a prompt like gpt is incred blurry or even illusary

by formatting the input they simulated the format for future gen prompt by using the rigid architecture of the past

is pet can extract this much highly specific complex task origentated reasoning out of a nn just by clever formmating the input as a simple fill in the balck question: are we every really teaching these models a new task during fine tuning, or are we just finding better psycological tests to unlock the latent hidden knowledge by already readingt the entire internet

---
