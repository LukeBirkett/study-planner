[Auto-generated transcript. Edits may have been applied for clarity.]
Hi and welcome to part one of the um week eight lecture on transfer learning with pre-trained, uh, large language models.

Okay, so let's start by just recapping, uh, what we've done so far in the module,

we've talked, um, quite a lot about language models, including new language models.

We've talked about distributional representations of meaning, um, that might be extracted,

um, from those language models and how we might once we've got representations,

um, for words or tokens, we might compose them to make, um, representations of larger units of meaning.

We also, um, started talking last week about contextualized word embeddings,

how we might update the representation of a word or token, um, based on the, uh, other, uh, tokens around it.

And we talked about Elmo. Um, and then we also introduced the transformer architecture.

And, uh, but, um, which, if you remember, stands for bidirectional encoder representations from Transformers.

Um, in the last part of um, the lecture last week, we were talking about, um,

techniques of pre-training large language models, um, including and masked language modeling.

Okay. So that's, uh, sort of quick kind of recap. Let's think about some of these things which are going to be kind of.

Important, um, to to remember as we go into the the content for today.

---

So first of all, the distribution of hypothesis for words.

That's kind of where we start in terms of how we think about, um, word meanings.

Words that occur in the same contexts tend to have similar meanings.

And this means that we can represent words using real valued vectors where dimensions explicitly or implicitly,

in the case of our embeddings from neural networks, um, represent context in which the word occurs.

And here I've got a kind of some toy vectors, um, for two words chicken and beef, where we would expect that they have,

um, a very similar in some contexts, because we might see that they both get eaten and we might see,

um, the very different in other, um, dimensions, which might represent context, such as the fact that,

um, chicken um is also an animal, whereas we don't refer to the, um, cow as the beef.

So we might see a chicken running around, but we're never going to see a beef running around.

So maybe that's what this, uh, high number here, um, represents the fact that chickens could do things such as run around, whereas beef can't.

Uh, so that's, that's, uh, uh, representations of word meanings which come from, um, their distribution, um, in text.

---

But we talked quite a lot last week about this, this idea of contextualized word embeddings.

And do you want to come back to that um, today? Um, we, um, sort from work both, uh, by, um, Peterson how 2019 on Elmo and um,

definitely that at I was working sort of 20 1819 on Bert how we can combine word embeddings

and bi directional language models to provide these deep contextualized word embeddings.

And the idea here is that if we've got maybe a sequence such as the noisy chicken woke, um,

having put it through our bidirectional language model, the representation here of chicken would have been contextualized by the words around it.

So he's incorporated some of the meaning or representation of these other words, such as noisy and woke, um, into the representation for chicken,

which means that we would now intuitively, uh, more likely associate this word chicken with,

um, other animals, because other animals can be noisy and other animals can can wake you up.

Um, and so therefore one might expect it to be further away from, uh, beef, um, and closer to maybe cow at this point.

---

So that's the idea, the intuition of our, um, contextualized, um, word embeddings going beyond words.

Um, we need to think about how these scales up to phrases.

So if we've got a representation noisy in a representation of chicken, how do we get a representation for noisy chicken.

How do we get a representation for a whole sentence such as the noisy chicken woke me up?

Or utterances documents. Discourse. So here we've got a a, um.

Discourse um, on um or discussion, uh, a set of us says who wouldn't be up?

It was the noisy chicken. So how do we represent that?

---

We introduce the principle of compositionality, the idea that if we've got a complex expression,

we can determine its meaning or its representation, um, using the meaning of the constituent parts, the rules used to combine them.

So we would like to be able to take distribution of word representations, um, be the embeddings of new language models or um, old,

uh, kind of more conventional distributional word representations, um, that were computed via kind of discounting the context.

We want to take these representations, combine them to make um representations for phrases, sentences, documents, discourses, etc.

---

If you want to apply the distributional hypothesis for sentences, we potentially should think about what that means.

We know the distributional hypothesis tells us that words that occur in the same contexts tend to have similar meanings.

If we kind of extend this, we would be saying that phrases that occur in the same context tend to have similar meanings,

and sentences that occur in the same contexts tend to have similar means.

That would be applying the distributional hypothesis directly to phrases and sentences.

---

So what are the contexts of other sentences? We said, you know, words occur in same contexts, sentences that occur in the same contexts.

And really the context of another sentence is the other sentences around it.

Um, but most of our.

Compositional um methods assume that the possible context of a sentence is some function of the possible context of all the constituent words.

That's kind of applying the principle of compositionality here.

And therefore, in practice, um, word representations are often simply added or averaged to get er composed sentential representations.

And we've seen this um, um, in much the, the uh, what we've it so far in the fact that if we want to get the representation of a sentence,

uh, what we would typically do is apply, um, some pooling operation, um, such as mean pooling, um, to it.

---

Um, in particular, last week we were looking at, um, expert, um, which, um,

goes a little bit further than just pooling the, uh, representations together,

essentially it pooling the representations together, but then trains, um, a, uh, classifier or a, um, a regression, um, objective function.

Uh, these are the sort of the two alternatives from, from expert or two of the three alternatives that, um, in order to, to make in this case, um,

the representations better for doing classification, um, or in this case, um,

to train the representations that we get from Bert, um, to make them, um.

More likely to kind of correlate with cosine similarity scores.

The idea here is that XI encode each of your sentences, uh, using.

But you make, um, a pooled representations of each one of them, which we call u and v, um,

and then we calculate the cosine similarity between you and V, which is on a scale, uh, between -1 and 1.

And at training time, what we, uh, do here is that we have pairs of sentences which we know the cosine similarity, what it should be for.

And so we use that to train, um, this um, network, um, which has um.

Is essentially two Bert networks, which are tied together so that when we update and we make updates into the weights,

um, here in Bert, uh, they are also, uh,

made here in this side of the network as well,

so that it doesn't matter which side of the network we put a particular sentence in, its, uh, representation will be the same.

Um, and that's essentially, um, gives us quite a powerful technique for being able to, um.

Compute sentence representations um via pooling, but also have them tuned towards the,

um, kind of similarity that we, uh, are looking for between, um, our pairs of sentences.

---

Okay. So that was uh, uh, recap. What are we doing today?

Well, today, what we're going to be looking at, um, is transfer learning.

Um, and in particular, we're going to be looking at fine tuning, uh, Bert base models for um text or um sequence classification.

Um, and also um, sequence labeling. Um, we can look at the kind of worried about family, including more, um, distant relatives such as GPT.

They briefly will talk more about GPT um next week after the teaching break.

Um, and uh, we're also, um, going to be looking at, um, the pet model from, um, she can she's 20, 21, um, in the seminar.

---

Um, okay. So, um, what do we mean when we talk about transfer learning, in particular transfer learning through fine tuning?

What is transfer learning? So transfer learning is acquiring knowledge for one task or domain and then applying

it that's transferring it to solve a new task or applying it in a new domain.

So it's trying to learn something somewhere that we can then apply somewhere else.

We're transferring our learning from from one task or domain to another task or domain.

Um, when we're talking about it in relation to um, uh, large language models, what we're typically um, doing is where we're thinking about how,

um, I, Bert based model or other pre-trained large language model acquires knowledge about language through pre-training.

Um, so that's the the kind of original learning, um, is, is the pre-training.

And if you remember, that's, uh, for Bert, that's masked language model prediction.

Um. And next sentence prediction. Uh, so that pre-training is done a large and a and uh, annotated corpora.

Um, does it need to be annotated so we can use lots of it.

Um, okay. So we can think of this as kind of a, um, self-supervised, um, task.

We don't need to provide, um, annotation because it's essentially annotated, uh,

already in terms of, um, what um, the, the, the words in the sentences are.

So that's the pre-training. That's the first step. But then the second step is the fine tuning.

And that's the process of transferring this knowledge to a specific task is the how are we going to actually use that in a task that we want to do.

We don't. Well, traditionally we don't want to do things like predict.

Um, what what is, um, missing in a sentence.

Although we can and we will start to see how that in itself can be used to solve,

um, quite a lot of, um, uh, challenges and, um, uh, tasks in the world.

But typically we have, um, specific tasks that we want to do, such as sentiment analysis or summarization or translation,

um, and um, therefore, we want to fine tune our model to be able to do those specific tasks.

---

Okay. So we're, we're fine tuning, um, we're going to be using labeled data, um,

from the application, from the task to train additional application specific parameters.

Um, those application specific specific parameters vary in terms of how you do this.

But this kind of simplest way of thinking about that is thinking of them as a single layer neural network on top of the Bert architecture.

We talk about putting a classification head, um, on top of Bert.

And then, um. The fine tuning, um will proceed to train those application specific parameters using that labeled data.

Um, and there's sort of two ways that it tends to, uh, proceed.

We could either freeze the pre-trained language model parameters.

So we're only training the application specific parameters, or we can, um, not freeze, um,

the pre-trained language model and allow updates to, to be made to all of the, uh, pre-trained language model parameters as well.

And actually, we could do something, uh, sort of compromise where we freeze some of the layers,

um, in the pre-trained language model and keep other ones are frozen.

And that's, that's quite common as well to, to freeze the lower layers and just unfreeze the top.

Um, we're talking a little bit about the advantages, uh, massive advantages and disadvantages of those approach.

Um, over the kind of in a few slides time.

But let's have a little bit of a look first at what that means.

---

If we're doing text classification or sequence classification, we've been referring to it in our earlier, uh, lectures, um, with Bert.

So an example of a sequence classification or a text classification.

Um, problem would be uh, something like an um example, um,

where we want to determine whether a particular review is, um, positive or negative in sentiment.

Um, so we might have a sequence, um, of tokens, um, to which we pre-print the prepended the CLS token.

Um, and this is assuming that this um, is the word piece tokenization.

We'll talk about that a little bit more um, as well.

Um. Actually, no, we talked about that last week, didn't we?

So we don't need to talk about that. And this week and we've already talked about that.

Um, and here, um, it looks as though all of our, um, uh, words in sequence have been recognized as tokens in the vocabulary.

It should be a CEP, um, or the end here as well.

But we're not going to worry about that because the, the key thing here is that we have this CLS token.

Um, and then we have the, um. Representations, the embeddings of all of the other tokens as well.

That goes into the Bert model. Um, and then um, this CLS taking the representation CLS token, um,

after it's been through the Bert model is input to a classifier head, which could be logistic regression.

Uh, or it could be another neural network, uh, which makes the relevant, um, decision about the class, um, of the text.

Uh. Let's think about that a bit more.

What are we doing? So that's classification. Uh, head.

Here. What we're doing is we're learning a set of weights which maps the outputs, um,

vector for the class to a set of scores for the possible sentiment classes, scores or probabilities.

Um, as we've got a, uh, softmax, um, here.

So. What we do in practice is parser input text through the pre-trained language model.

So it's going through the language here to generate uh y CLS.

We multiply that by the um, uh, WC weights and then pass that, um, through the softmax.

And that's, uh, what we see. I mean, this equation here is essentially our prediction is, um,

the result of applying softmax to the, um, weights multiplied by the, uh, why, um, CLS token.

To fine tune this. That requires us to have input sense sequences which have been labeled with the appropriate class.

And so what we can then do is use cross-entropy loss between the softmax output and the correct answer,

because we know what the correct answer should be. We look at the loss, um, to see how good our prediction is, our prediction.

And that's going to then drive backpropagation. And as I've already said, um.

We could freeze bird and just update MWC.

Um, or, uh, backpropagation could backpropagate into the, um, pre-trained language model, um, as well, and update um, weights here,

either in the that just the top layers or in all of the layers even we can backpropagate down to the original embeddings of the words as well,

and then see how, um, our particular classification task actually affects the, um, static or global, um, word embeddings, um, for, uh, um, tokens.

---

Okay if we want to do this in practice, um, there's a number of different ways we could do it.

And we're going to be exploring, um, at least one of those, um, in the lab, um, next week.

Uh, and given that we've got the teaching break coming up, I do encourage you to sort of have a look at the lab,

um, during the used to teaching break in a little bit ahead. It'll help, uh, with the assignments.

Um, so, um, but just to sort of, kind of points out a few things, um, about that now,

especially if you are looking at the, uh, the lab over the teaching break, um, the way that.

One of the ways we can do this is using the Huggingface Transformers library,

which is a really useful, um, library for carrying out natural language processing, um, task.

And what we can do is, um, use the but for sequence classification, um, class from the Transformers library.

Um, and this is a Bert transformer, uh, model with a sequence classification.

Slash regression head. Um. On top. Um, is essentially a linear layer on top of the pulled output actually inherits from, um, the pre-trained model.

Uh, which is what we can see here, is that we're taking, uh, uh, but based on cased model, that kind of pre-trained model.

Um, and then we, uh, have a tokenizer, um, which is based, uh, on pre-trained.

Uh, because the tokenization stays the same.

And then what we have is a, um, one of these, Bert, for sequence classification models, uh, which inherits from the pre-trained,

um, but is uh, and is based, um, all the kind of base model is, uh, in this case, Bert, based on case.

And then we give it the number of labels that we have.

And this bit here saying to key to is essentially, uh, passing it to key to say, uh, we would use a GPU, uh, where appropriate.

How we would then proceed if we're using this approach.

Uh, but I do encourage you to to have a look at this article.

If this is the approach you're going to take.

Um, you need to be able to kind of passively load, tokenize and encode your inputs for the training and the validation sets of before you can train,

you need to, to have done, uh, these two inputs and you need to set up some training arguments and metrics for evaluation.

Um, these are going to be used during validation. So what's your training.

You do still need to think about the evaluation. What evaluation is appropriate.

Um, for the model that you are um, building.

Uh, and you typically use this training class which defines the model training arguments,

the training data set, the validation data set, um, and the metrics that you use, um, to, um, for evaluation.

And then once you've defined all of those things, then you can just train the model, uh, by calling the train method on the trainer object.

A little bit more about some of those training arguments, one in particular, which, um.

Is it sort of sometimes tricky to kind of get set up?

Um, is the metric for the best model?

Um, and but essentially training arguments includes things like the name that it's going to have, uh, once it's been trained,

what kind of evaluation strategy you're using and um, saving specialty learning rates,

batch size, uh, weight decay and all of those kind of, um, things go in there.

Um, and the metric for the best model could be something like Pearson or Accuracy F1 um, or uh, Spearman.

There's a kind of tendency with these models, um, to use, um, particular kind of evaluation metrics,

which are defined, um, for something called the glue benchmarks,

benchmark tasks, which we have, I think we refer to in one of the previous lectures, we haven't looked at, um, in very much detail.

So just to say this is a group of nine classification tasks on sentences of pairs of sentences.

Glue stands for general language Understanding evaluation.

So the point of clue with this is that, uh,

to be a suite of tasks that you would evaluate your model on to see if and if it was good at general language understanding,

it should do well at all of these tasks. They include things like determining whether a sentence is grammatically correct or not.

Uh, being able to determine if the answer to a question is in the second sentence or not.

Um, determining um in the s t um task, if the sentence has a positive or negative sentiment or not.

So whole suite of tasks, um, that have been developed over the years as things that we expect, um,

a good language model, um, to be able to, um, do, um, if it's got good general language understanding.

And I mention this now because, um, typically, um.

The, uh, metrics that we tend to get used with this, um, hugging face.

Um, can't remember the name of it now.

The, um, but for sequence classification, uh, model, um, is, um, to load a metric that is associated with one of the glue tasks here.

Um, from data sets, we're using the load metric, um, function, which allows us to load a particular, uh, metric.

So this would be the one for, um, sentiment analysis, binary sentiment analysis task in glue.

And what we can do once we've loaded it is this is just demonstrating, um, it uh,

with some fake predictions and fake labels are just randomly generated here and showing how you would learn,

um, the particular metric that we've load, um, all those, uh, predictions and labels,

uh, and again, where we can then, um, define that, um, in a, a compute metrics, um, function here, uh, where we, um,

take our predictions and labels and um, computes the particular metric, which I think we see, um, here, um, here, the compute metrics is just, um.

Defined as being compute metrics, which is this function here, which is just calling,

um, a kind of loaded metric, which seems potentially a little bit clunky, um, to me.

Um, but can I come back to that in a moment? Um.

What? You trained your model. Um, if you use the, um.

But the sequence classification, uh, model from huggingface, you can then evaluate it, um, using the Chinese evaluate method.

You can save it and the tokenizer you use. And then once you've done that, you can start to make predictions on new unseen data on your test data.

So this might be how we would do that. This is a, uh, a potential Get prediction, um, on a text, um, function here where we would, uh,

pass that text to our tokenizer, giving it a set, an options that as the fact that it's going to, um.

Pad it to the required length, it's going to truncate it if it's too long.

It sets the max length in terms of if it's longer than that, when it's going to get truncated.

Um, it's sort of tensest to be done.

And here we are also, um, sending it, um, to Cuda for the GPU.

Um, then once we've, um, done our kind of tokenization of the inputs, we would then apply,

um, the model to those inputs or pass those inputs to the model, um, to get some outputs.

Um, we then um, use softmax to get um, to those outputs into probabilities.

Um, and then um, we can return the um for the target name.

So this is the list of classes, um, the um.

One that has the highest probability. So this would just give it to us in terms of the numbers of the classes.

And this is just turning it back into two names. And then we can use that function to get a prediction for a particular a piece of text.

I think there are some drawbacks of using this, uh, particular, um, class.

It's very popular. Uh, Huggingface is a very good library, and I strongly recommend you, um.

Exploration. You, um. Have a look at the birth sequence classification model.

Um, but it is quite opaque. And by that, I mean that it's quite difficult to necessarily work out exactly what's going on.

Um, in the model, um, you have to dig through lots of code just to find out what the architecture of the classification head is.

There's references to the pulled output, but how is that pulled together in?

If you dig through the documentation, uh, and actually, I'm not even sure it's very clear in the documentation.

I never used to be. They may have improved it. Um, but, um, if you dig through the code and actually apply it, you kind of, um.

We'll come to hopefully understand or see that the pulled out but that's being used is the CLS representation, which is what we've said.

But there are other possibilities, such as, um, doing, uh, mean pooling over all of the, the tokens, uh, representations.

And you might want to use that. And it's very difficult, uh, with Bert for sequence classification, um,

to kind of realize how you can change those things or whether those things can even be changed.

Um, a two other potential drawbacks are that to use all of the functionality with,

uh, mentioned, such as the load metric to get the the evaluation metrics from,

um, some glue, you need to, um, be registered with and signed up to Huggingface hub, um, which is not.

That much of a kind of hurdle, but it does increase the burden on getting started, getting started.

So. So as an alternative, and what we're going to do in the lab is to to build our own classification head on top of the pre-trained model.

Um, and this even if you end up using the Bert for sequence classification model in your own work,

um, later on, uh, this will help you, um, to understand, um, how sequence classification works.

Um, with Bert, um, uh, potentially gives you more flexibility in terms of how you do certain things if you want to,

um, experiment, as I said, with kind of different pruning strategies.

Um, then it's going to be, um, it's like a lot easier to do that, um, if you build your own classification head rather than if you use this one.

Um, and this we are going to be kind of, um, you're going to be looking at this, um, in the lab.

Uh, but this is the code, um, for, um, our simple, um, classification head that we're going to put on top of Bert, uh, that we use in the lab.

Uh, so essentially what we are doing here is we're defining this Bert classifier,

um, uh, class, um, as, uh, essentially a simple neural network module.

Um, and, um, what it does is it has these, um, four components, the, uh, Bert layer,

dropout layer, um, a linear, um, you know, a network layer and, uh, the value activation.

And then what happens, um, in the, the forward pass is that, um, the first layer is applied to the inputs.

Um, and actually here we are, we ignore the last hidden layer part of the, the output and just take the pooled output,

because that is where the, um, if you have the last week, uh, that is the CLS token, uh, which is typically used, um, in um, classification.

But it doesn't have to be. Um, we then, uh, apply dropout to the output.

We then, um, give that as input to our linear layer, which has, um, 768 neurons, um, in it, um, as the inputs.

And then that's kind of going to the, to the number of classes. Um.

Yes. So after the drop out, as I was saying, we've got the, um, linear layer.

Um, so this is our number of inputs.

This is the number of dimensions that are coming in, um, essentially, um, from a Bert, because that's the, um.

Embedding dimension, um, for um, a token in Bert.

That's how many dimensions the CLS um token has.

Um, and then the, the um number neurons is the number of classes, because that's the number of outputs of that we want,

um, from our Bert classifier, we want it to, um, essentially, um, classify things into two classes.

So we will have um, to use here.

Um, each with 768 inputs. Um, and then we're, um, after we've passed through our linear layer.

Um, then the linear output needs to get past the, um, here.

It's a ReLU activation function. And that's what we're going to return.

Um, are those, um, outputs that have gone through the, um, the value activation?

Okay, so you just a tiny bit more to say before we kind of finish this um, section is part, um, talks a little bit about um.

Freezing layers and the way we do that in the code.

Um, is that when we have instantiated, um, Abbott classifier model.

Um, if we want to, um, freeze, um, some of the layers or all of the, the Bert part of the layers,

what we need to do is, um, turn off essentially of the requires gradient, um, attribute of the Bert model.

Uh, we can do that just by, um, saying model dot.

Bert, uh, requires grad making that force.

Um. Okay, let's take a quick break.

