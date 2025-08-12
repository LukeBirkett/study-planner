# Week 8 - Advanced Neural Networks

Contents: 
- Learning outcomes
- Lecture slides structure
- Lecture Notes
- Lab Notes
- Reading Notes

# Learning Outcomes
- convolutional neural networks (CNN)
- long short-term neural networks (LSTMNN), a type of recurrent neural network (RNN)

# Slides Structure
- Convolutional neural networks
- Recurrent neural networks

# Lecture Notes
## CNN
Input layer = x = instance, i.e. image

Hidden layer each with their own “weights”

The weights are a kernel that maps between layers

Stride is the movement of the kernel across the input

Weights/Kernal must be smaller or equal to the size of the input (max)

Opposed to MLP where it is the product of the input and out sizes
CNNs learn spatial relationships between neighbouring elements/pixels

A kernel/filter needs to match its input dimensions

But it will output a 2d feature map regardless of the number of channels in the input

Padding is used around an image to allow the kernel to fit and capture the edge features

Hyperparams: stride, padding, kernel (size and amount)

Activation functions are applied to layer outputs to capture non-linearities

Pooling layers take place after convolutional layers

Max pool or average pool

Pooling downsizes and allows invariances to minor transformations (overfitting)

2D CNN for images

3D CNN for video (ℎ × 𝑤 × 𝑡 × 𝑐)

1D CNN for audio  (𝑡 × 1)

CNN replaces feature engineering (handcrafted)

Image CNN layers can be visualised

As can weights of time series CNNs

Convo > activation > pooling (stride)

1d time series convolution can be structured with the time element as columns and parameters as channels/depth

Summary:
- Weight sharing is a primary feature of convolutional layers.
- There is an assumption that neighbouring values in the convolution dimension have some relationship.
- The hyperparameters of a convolutional layer are kernel size, stride, padding, and channel size.

## RNN

Designed for sequential data 

If CNN extracts spatial features, RNN extracts temporal features from time series

Connections between layer input units, in particular feed forward, i.e. recurrence

LSTM uses sigmoid and tahn activations

Same recurrence function is used at each time step 

The hidden stage is passed between sequential steps/inputs

Classifications can be many-to-many, many-to-one or one-to-many

Many-to-one could be sentiment classification of a sentence

Backprop with RNNs is called backprop through time

SGD updates with approximate of the gradient using the current data instance

Vanishing Gradient occurs with RNNs as well as Exploding Gradients

If >1 Chain rule results in Exploding 

If <1 Chain rule results in Vanishing

In traditional RNNs, gradients can become so small as they are propagated backward through many time steps that they effectively "vanish," preventing the model from learning long-term dependencies.

LSTM uses (multiple) gates to control flow through time

Forget gate, Input gate, Output gate, Cell update 

LSTMs solve this problem with their unique architecture, which includes a cell state and various gates (input, forget, and output).

The cell state acts as a memory highway that can carry information through the network over long sequences with minimal degradation.

The gates regulate the flow of information into and out of the cell state, allowing the network to selectively remember or forget information.

When backpropagation occurs, the gradient can flow along this cell state pathway.

Instead of being repeatedly multiplied by small weights and activations, the gradients are controlled by the forget gate.

If the forget gate's activation is close to 1, the gradient can pass through without much change, effectively preventing it from vanishing. This allows LSTMs to learn long-term dependencies that simple RNNs cannot.

LSTMs use BPTT to train, but their internal structure makes the process far more effective by preserving the gradient and allowing it to flow across many time steps

Number of LSTM parameters

Summary:
- A recurrent neural network also leverages weight sharing, but across time. 
- Long short-term memory addresses the issue of vanishing gradients with four gates that control feed forward of input and backpropagation of gradients.

# Lab Notes

Lab Objective: To explore the convolutional and long short-term neural networks from Week 8 lecture and apply them for forecast of number of days of ground frost and snow based on other weather variables.

The initial part of this notebook is very important as it is reading in the tabular data and reformatting it into 3D data

Dataset starts as monthly data per coord with a year and month column

The params are split into categories, i.e. groundfrost_x, where x = 24

There are 24 columns per category

The code then collects the column ranges for each category and stores in a variable as an array of numbers

A subset for each category is then created for each with the shape (8502, 23)

Note that the splitting process removed the month, year and coordinates

There are 7 categories in total which are then stacked using numpy.stack()

The function by default gives the shape '(7, 8502, 23)' which is difficult to understand

But is transformed to give the shape '(8502, 23, 7)'

The tabular view of the data retains its original shape at the categories are stacked on the Z axis

Rows are the data instances given by coordinates (place) and a month/year

Columns timesteps (?) going back or forward 23 months (?)

Tensors are the categories of params

2 output columns are extracted from the originally shaped data as raw vectors/arrays: 
- ground_frost_label = data[:, ground_frost_24_col]
- snow_label = data[:, snow_24_col]
Each element of the outputs represents the outcome give a single (23, 7) input

This is an instance with 23 monthly datapoints and 7 params

The notebook used from sklearn.model_selection import train_test_split to split the data into train and test 

It actually split into training and remaining, then further split the remaining into test and validation with a 50/50 split

The method of creating the splitting creates an array of all the possible ids [1 2 3 … N]

Then creates sub arrays of randomised is. These arrays can then be used to split the dataset(s)

Data is then normalized using from sklearn.preprocessing import MinMaxScaler and 0 to 1 range

The data is reshaped and flattened in order to apply the scaling to a shape of (195546, 7)

Data is often shaped back after preprocessing

After the data is scaled is it split using the id arrays created earlier

The notebook then goes on to setup a CNN class using PyTorch

The hidden layers are a succession of Conv1d and MaxPool1d before a final Linear and ReLU

Training and evaluation is very similar to the epochs looping in MLP

Notebook then executes the training class and function which is again very similar to before

The notebook then spends some time working out the output sizes of the convolutions

Note that the dimensions are shrinking on the time component (23 down to 7)

The param dimensions depend on the number of hidden layer filters used in each layer. These can go up or down

Max pool also shrinks the time component but retains the param dimensions

Some time is spent calculating the number params required. This is probably a good thing to repeat in the assessment

Augmentation types to experience with: 
- dropout along the time dimension 
- dropout along the variable dimension 
- random noise along the time dimension

To enable robustness to missing sensors and noisy data, dropout was applied to the variable dimension and random noise added to the data.

When the data is noise, performance is lower with augmentation but the robustness is better

To achieve feature dropout, the code reshapes the data and uses self.dropout(out) to remove features

torch.nn.Dropout(p=...)

Dropping out is setting values to 0

This is a form of feature-level augmentation/regularization

The network is then forced to learn to make predictions even when certain input features are entirely absent for a given sequence. This makes the model more robust and less reliant on any single feature, which reduces overfitting and improves generalization.

Next the notebook goes onto focus on LSTMs

Three questions: 
- Create and train a three-layer LSTMNN model (see https://pytorch.org/docs/stable/generated/torch.nn.LSTM.html for the documentation for the PyTorch LSTM layer) 
- How many weights does the LSTMNN have? 
- How does your model perform in comparison with the CNN in Section 4?

An LSTM (Long Short-Term Memory) is a type of Recurrent Neural Network (RNN) specifically designed to process sequential data. It has internal mechanisms (gates) that allow it to learn long-term dependencies in sequences, overcoming the vanishing/exploding gradient problems of simpler RNNs.

The code set up for LSTM is very short

The package is setup to sequentially parse data of a 3 nature with the rows being taken as instances

There is an inbuilt function to get the params of the model: total_params = sum(w.numel() for w in model_LSTMNN.parameters())
But you could still calculate manual based on knowledge of the structure of a LSTM layer


# Reading Notes

Start with:

A Zhang, ZC Lipton, M Li, AJ Smola. Dive into Deep Learning. 2021. [Chapters 7, 8, 9, 10]

You might also find useful: 

Y LeCun. Generalization and network design strategies. Connectionism in perspective, 19. 1989.

S Hochreiter, J Schmidhuber. Long short-term memory. Neural computation 9, no. 8: 1735-1780. 1997.

FA Gers, J Schmidhuber, F Cummins. Learning to forget: Continual prediction with LSTM. Neural computation 12, no. 10: 2451-2471. 2000.

I Goodfellow, Y Bengio, A Courville. Deep Learning. 2016. [Chapters 9, 10]

C Bishop. Pattern recognition and machine learning. 2006. [Section 5.5.6]

## A Zhang, ZC Lipton, M Li, AJ Smola. Dive into Deep Learning. 2021.

### CNNs

MLPs flatten inputs into vectors which are invariant to the order of pixels

Nearby pixels tend to form relationships

CNNs are more computationally efficient and require fewer params
Convoluations can be parallelized across GPUs

Convoluations have two parameters: kernel and scalar bias

The output of a convolution layer is a called a feature map

Feature map can be regarded as the learn representations in the spatial dimensions

The receptive field is the given elements/pixels that go into creating x pixel in a feature map (many-to-one)

Padding and striding

striding can sometimes be used to reduce dimensions, though this is less common

Padding = retain size
Stride = move kernel
Strided convolutions = reduce dimensions

Kernel/filters match the input dimensions but output 1d/2d

Pooling layers have two functions:
Mitigating the sensitivity of convo layers to a location
Spatially down sampling representations

Pooling layers contain to parameters and are deterministic 

PL can be adjusted using padding and stride to create different output sizes

Pooling layers retain dimensions and do not concat like convo layers

### Modern CNNs

AlexNet (2012) First large scale network to beat conventional CV methods on a large scale

VGG (2014) Make use of repeating blocks of elements

GoogleLeNet (2015) Mutli-Branch convolutions

ResNet (2016) most popular off shelf architectures in CV

ResNext Blocks (2017) for sparser connections

DenseNet (2017) generalization of the residual architecture
LeNet (1995) was only established on small datasets

Historically, NNs were overshadowed over other, more manual computer vision methods. Practitioners would craft features using domain knowledge and pass these an inputs to the models

Feature extraction was seen as the main still in computer vision. Models and algorithms were an after thought

That is to say, representation learning was crafted by hand pre-2012

LeCun, Hinton, Bengio, Andrew Ng, Amari believed features ought to be learned

Alex Net

AlexNet was the first modern CNN to this avail

Main improvement from LeCun was computational power to tackle bigger datasets

AlexNet had 8 layers: 

Input > Conv > Pool > Conv > Pool >  Conv > Conv > Conv > Pool > FC > FC > FC 

In AlexNet, activation functions, specifically the Rectified Linear Unit (ReLU), are applied after every convolutional and fully connected layer, except for the final output layer, which uses a softmax activation for classification.

AlexNet introduced ReLu as the activation instead of sigmoid + softmax for the output
AlexNet utilized dropout as a form of regularization to prevent overfitting, specifically in its two largest fully connected layers.

In AlexNet's architecture, dropout was implemented after the first and second fully connected layers. The model's fully connected layers contained 4096 neurons each, resulting in a large number of parameters that were highly susceptible to overfitting. 

AlexNet's dropout rate was set to 0.5, meaning that during each training iteration, half of the neurons in these layers were randomly deactivated. This prevented the network from becoming too dependent on any specific neurons, forcing it to learn more robust and generalizable features.

AlexNet was the evidence that deep CNNs can achieve good results

** VGG Network Blocks **

Network Using Blocks was the paradigm that provided a general template to guide researches in designing new networks

Researchers first thought in terms of individual neurons, then whole layers, now blocks w/ resting patterns of layers

A super modern approach goes one step further and utilises pre-trained models called foundational models 

Code wise, it is easy to implement repeated code structures using loops and subroutines

Historically, the basic CNN sequence is: conv w/padding, Relu for non-line, Max pool to reduce

Issue here is that the max poolings resolution reducing eventually uses up all dimensions limiting how deep and network can be

Sim & Zisserman (2014) idea was to use mutli convs between pooling. They wanted to know weather deep or wide networks were better. Result was deep and narrow was better

Stacking 3x3 Convs has since been the gold standard

A VGG network can be thought of blocks of convs and pooling sequences followed by FC layers

The convo layers are set up in a way to not reduce dimensions (using padding)

VGG is more computationally expensive that AlexNet

Upto this point, all architectures shared the same structure: extract spatial features via sequences of convos and pool layers, then finish with fully connected layer

These FC layers are a problem as they require a lot of computation

**Network-in-Network**

Network-in-network offers a solution

Using 1x1 conv to add local non-linearities across channels and use a global average pool to integrate across layers

The 1x1 can be considered as a fully connected layer for each pixel 

NiN has no FC layer at the end

This reduces the params but may increase run time

**GoogLeNet**

GoogLeNet introduces Mutli-Branch networks

This is a mix of NiN, VGG blocks and convolutional kernels

It is the first architecture to have a clear distinction between:
- Stem (ingestion)
- Body (Data Process)
- Head (prediction)

Stem has 2-3 convos to learn low level 

Body has convolutional blocks

The head maps obtained features to the task at hand

The key problem at this stage of building architectures was building and selecting the correct kernels 

A solution was derived to create multibranches of different compositions and concatenate the branches into 1 results

Blocks in GoogLeNet are called inception blocks

4 parallel branches each with different spatial sizes

Also used 1x1 conv layers to reduce channels

GoogLeNet is computationally expensive

Large number of relatively arbitrary hyperparameters such as number of branches and numbers of blocks chosen within the channels

Later tools for automatic network designing was created due to this

**Batch Normalization**

Training deep NNs is difficult, specifically the time to converge

Batch norm helps with this

Batch Norm with the addition of residual blocks makes it possible to routinely train networks with over 100 layers
And it also acts as regularization

Generally process data before training. Standardization helps with optimization as it puts params on a similar scale

Batch Norm is applied to individual layers

Normalize the inputs based on the current mini batch (mean and sd)
Apply scale coeff and offset to recover lost degrees of freedom

Normalization + batch statistics  = batch normalization

This make the size of the batch chosen very important 

After standardizing, the resulting minibatch has zero mean and unit variance 

A small constant is added to avoid ever dividing by 0

This noise leads to faster training and less overfitting (regularization)

Batch normal layers are slightly different for MLP vs CNN

Fully connected - before activation and after affine transform

Convolution - after convo but before activation and on a per channel basis

Batch normalization is executed as a layer within a model, which is fundamentally different from preprocessing because it's an in-network operation. It's a dynamic process that happens during the forward pass of training, not a static, one-time transformation of the data before training begins.

Dynamic Calculations: A batch normalization layer calculates the mean and variance for each feature for the specific mini-batch of data passing through it at that moment. This means the normalization is constantly changing from one mini-batch to the next.

Learnable Parameters: Unlike standard normalization (which just sets the mean to 0 and variance to 1), a batch normalization layer has two learnable parameters: a scaling factor (γ) and a shifting factor (β). These parameters are optimized during training via backpropagation, allowing the network to learn the best possible mean and variance for the activations of that layer.

Part of the Graph: The batch normalization layer is an integral part of the neural network's computational graph. This means that when the model backpropagates gradients to update weights, it also backpropagates through the batch normalization layer to update γ and β.

Weights vs. Activations
- Weights: These are the parameters that the model learns during training. They are what the network uses to transform the input data into a new representation. Batch normalization does not directly normalize these.
- Activations: These are the outputs of a layer after applying an activation function (like ReLU). In a neural network, the output of one layer becomes the input for the next. This is the data that the batch normalization layer normalizes.

**Residual Networks: ResNet and ResNext**

Adding more layers should make the network more expressive, not just different 

This only works if larger functions contain the smaller ones

At the heart of ResNet is the idea that every additional layer should easily contain the identify function as one of the elements 

This leads to a residual block 

In normal blocks, f(x) needs to be learns and passed onto an activation functions

In residual blocks, the residual mapping is g(x) = f(x) - x

If the identify mapping is f(x) = x is the desired mapping 

Then the residual map g(X) = x
The first two layers of a ResNet model are the same as googlenet

After ResNet using four models made up of residual blocks 

And a residual block is made up of several residual clocks 

It has 18 layers in total - ResNet-18

But by configuring different numbers of channels and residual blocks you get different ResNet models ResNet-152

ResNet is similar to GoogLeNet but it has a simpler structure and is easier to modify

Conv > Batch Norm > Pool > Residual Blocks x3 > Pool > FC > 

One of the challenges ResNet faces is the trade of between non-linearity and dimensionality within a given block

Could add more non-lin by increasing the number of layers

Inspiration can be taken from resnet which information flowing through the block in separate blocks

Initially the perceived challenge is that no info is shared between channels

Resnext solves this through grouped convolutions

**RNNs**

MLP for tabular data, CNN for vector/matrix data

But many tasks require sequential data

Captions, speech, time series

RNNs capture the dynamics of sequences via recurrent connections

RNNs are unrolled across timestep

Previously examples we assumed that individual inputs were sampled from the underlying distribution independently 

With sequences, we still assumption that the data is sampled independently but cannot assume that data within each time step is independent of eachother

E.g. words at the end of a document are heavily dependant on words at the start

RNNs what to predict the next point using many previous points

But modelling soon becomes infeasible P(xt | xt-1, …, x1-n+1)

Better to use a latent (hidden) variable model

p(xt | ht-1)

H-1 is a hidden state that stores the sequence of info upto step t-1

At any current time step ht is calculated using ht-1 and xt

Hidden states are technically inputs to the current time step

RNNs are NNs with hidden states

Ht = activ(Xt*w + ht-1*w + b)

RNN params:
- Weights of current input
- Weights of hidden state
- Bias of current input

At all time steps of the sequence, RNNs use the same model params

There is not new weights trained for each time step

This allows the sequence fed to be of variable length

Parameter cost does not grow with number of time steps

RNN feeds into a fully connected layer to complete the task

Applying backprop in RNN is known as backprop through time

Exploding gradients come from backprop across long seqs

An unrolled RNN is essentially a feedforward network where same params repeat throughout the network

Long sequences cause 2 issues: 
- Computational memory issue 
- Optimization and numerical instability

## Modern RNNs

Most popular RNNs feature mechanisms to handle the numerical instability faced by RNNs (vanishing/exploding gradients)

*LSTM*

Introduces a memory cell 

Replaces traditional nodes in the hidden layer

Ordinary recurrent nodes are replaced with memory cells

Avoids vanishing gradients by keeping values in each memory cell cascading along a recurrent edge with weights across many time steps

A set of gates help the network to determine what inputs to allow in to the memory state

Memory state = long term 

Gates and cell =  short term 

Memory cell contains an internal state connected along an edge 

THis ensures the gradient can pass many time steps without vanishing or exploding 

Gated Memory Cell

Memory cells are equipped with an internal state and mutliplicative gates 

Input gate = should given input impact internal state

Forget gate = internal state flushed to 0 

Output gate = internal state of neuron should be added to impact cells output

These mechanisms are learned

Learn to retain important early info 

Learn to skip irrelevant info 

Leard to resent the latent state

The data being fed into gates is the current input xt and hidden state of previous time step ht-1

The gates are fully connect layers with sigmoid outputs to give a gate percentage 

Memory cell state is give by Ct and runs along the top of the cell

Ht is the hidden state, it is calculated via the gates and passed onto future cells

Using tahn activations

**Gated Recurrent Units (GRU)**

GRU is a lightweight verison of lstm

Comparable in performance but quicker

Uses just a reset and update gate

Reset get decides how much of the previous state to remember 

Update decided how much of the new state is just a copy of the new

**Deep RNNs**

RNNs inherently seem ddep due to the time depth of sequences 

However, we wish to retain the ability to express complex relationships between the input and output of a given time step 

I.e. we want depth within cells

The method is to stack RNNs on top of each other

The output of one layer is the input to the next

The end (top) output is based on the ht of the nth layer

Hidden layers and units are tunable hyperparameters

**Encoder-Decoder**

If the inputs and outputs are of varying length then the standard design is generally encoder-decoder

Encoders transforms an input sequence of varying length into fixed shape vector 

The context variable is just the hidden state of the encoder RNNs representation after processing the final token of the sequence

Decoder takes the final hidden state of an encoder as its input

