# Week 1 - Introduction

Contents: 
- Learning outcomes
- Lecture slides structure
- Lecture Notes
- Lab Notes
- Reading Notes

# Learning outcomes
- be familiar with some of the basic terms, concepts, and notations in machine learning; 
- have explored the basic linear model (regression and classification).

# Lecture slides structure 
- Module information
- Machine Learning in our world
- Regression Basics
- Classification Basics

# Lecture Notes
## Regression Basics
Typically two parts to a model: labels/output (y) and features/input (x)

Machine Learning = ML = creation of a mathematical model that can deduce appropriate response (label(s)) to new stimuli (features) from its previous experience

Training – the ‘learning’ process when the ML model gains ‘experience’

Inference – giving a (trained) ML model some input and prompting it to give appropriate output

Supervised learning – Training data includes labels

Unsupervised learning – Training data does not include labels

Semi-supervised learning – Training data includes labels but not those needed at inference time

Self-supervised learning – The ‘labels’ are the features themselves, or some trivial derivative of the features

A tensor is a 𝑑-dimensional element. 𝑑 could be any positive integer, and the tensor would usually be made up of real or integer values.

Training data – Data used to train a model

Unseen data – Data not ‘seen’ by the model during training

A model should be generalizable to unseen data instances

Introduces the linear model as given by 𝑓(𝒙) = ŷ = 𝒙𝒘 + 𝑏

Introduces the way to write it in matrix form

Introduces optimization and the need for loss functions

First demonstrates the L2 error (mean-squared error)

Optimal model parameters (𝒘, 𝑏) minimize the loss

Training is the process of optimizing 𝒘 and 𝑏 i.e. training is the process of minimizing the model loss

The minimum of a function is when its gradient (derivative) is zero

Touches on L1 Error (mean absolute error)

Explains that L2 is more influenced by outliers compared to L1

This is to convey that the selection of the correct loss function for the task is important

Explains that the gradient of the L1 loss is a constant, hence it can’t be solved analytically

An analytical solution means finding a closed-form mathematical expression for the optimal parameters. This usually involves setting the gradient of the loss function to zero and solving for the parameters.

L1 loss models are typically optimized using iterative numerical methods like gradient descent (or its variants), which can handle non-differentiable points by using subgradients or specific optimization algorithms designed for L1 regularization (e.g., coordinate descent).

Introduces generalization errors and the variance bias trade off 

Bias: Bias refers to the error introduced by approximating a real-life problem with a simplified model. A model with high bias makes strong assumptions about the data's underlying patterns, which can lead to underfitting

High bias = low model complexity, fails to capture data relationships

Variance: Variance refers to the error introduced by the model's sensitivity to small fluctuations or noise in the training data. A model with high variance is too complex and learns the training data, including its noise, too well, leading to overfitting.

High variance = model too complex, memorizes training data

The "trade-off" arises because bias and variance are inversely related.

The goal in machine learning is to find the optimal balance between bias and variance, which minimizes the total error on unseen data. This "sweet spot" allows the model to capture the true underlying patterns without being overly influenced by noise.

Strategies to manage the trade-off:
- Regularization: Techniques like L1 (Lasso) and L2 (Ridge) regularization add a penalty term to the loss function to discourage overly complex models, helping to reduce variance.
- Feature selection/engineering: Choosing relevant features and transforming existing ones can help simplify the model and reduce variance.
- Cross-validation: This technique helps estimate how well a model will generalize to unseen data, allowing you to tune hyperparameters and choose a model complexity that strikes a good balance.
- Ensemble methods: Combining multiple models (e.g., Bagging, Boosting) can often reduce variance while maintaining low bias.

Overfitting (at the extreme) = memorization of the training data – the model cannot generalize to unseen data

Key ML challenge – How to get a model to learn (i.e.not underfit) without just memorizing (overfitting)?

A common strategy to address this is regularization i.e. adding an additional penalty term to the loss function

Introduces the L1 (Lasso) Regulatization

L1 encourages 0 weights and 0 weights can be interpreted as reducing model complexity 

Uninformative features are ignored

Next introduces L2 (Ridge) regularization

L2 regularization penalizes large weights

L2 encourages very small weights. Much smaller weights reduce model complexity

Regression Basics Summary:
1. The most basic elements of machine learning are data (features & labels), model (defined by weights).
2. The most basic ML algorithm is linear regression, a linear model that learns real valued labels.
3. Training a ML model involves optimizing the model weights based on a loss function.
4. Achieving the goal of generalizability to unseen data is trading off between bias (underfitting) & variance (overfitting).
5. Overfitting can be addressed with regularization.

## Classification Basics

L0-1 Sign Loss 

L Hinge Loss

An activation function allows the basic linear model to be used for classification.

Classification loss functions are typically different from regression loss functions but differentiability is important for both.

# Lab Notes

A measure of model performance is called ‘loss’ when we are training/optimizing but is called
‘performance metric’ when testing on unseen data.

Most of this lab is a basic insight into generating data, fitting/training a linear model and evaluating it using a chosen metric.

In section 6, the concept of regularization is introduced. Regularization is done to prevent overfitting and improve the model's generalization ability.

The first method introduced is the L2 Regularization, or ridge regression. This term adds a penalty to the sum of the squared magnitudes of the coefficients.

L2 regularization is applied as a single value to the loss function, but this single value is derived from the sum of the squared magnitudes of each individual parameter (excluding the bias/intercept term, which is typically not regularized)

L2 universally has a dampening impact on all parameters, pointing them towards zero as it is
"artificially" inflating the loss function.

But it also disproportionately targets larger parameters though the squaring of the magnitudes. 

This is important because it stops any model becoming too dependent on some larger parameters.

The derivative of the regularization term is 2λβk, hence, larger parameters are impacted more, as well as, contributing to the loss function more in the first place.

By preventing overfitting, L2 regularization helps the model capture the underlying patterns in the data rather than memorizing the training examples, thus improving its ability to make accurate predictions on new data.
The second method introduced is L1 Lasso which is a term to the loss function and is done to avoid overfitting.

L1 regularization adds a penalty based on the sum of the absolute values of the coefficients.

Feature selection (sparsity) is the main aspect of L1.

It drives features of less importance to zero.

This essentially removes parameters from the model making it more sparse. The result is a simpler model which is more efficient due to having less dimensions.

It is not differentiable at zero which is what causes parameters to be driven to 0. As opposed to L2 which whilst it shrinks, may not drive params to exactly zero.

The lab finishes by highlighting the importance of using a random seed to allow for repeatability.

# Reading Notes

S Rogers, M Girolami. A first course in machine learning. 2017. [Chapter 1]

C Bishop. Pattern recognition and machine learning. 2006. [Section 1.1]

M Deisenroth, A Faisal, CS Ong. Mathematics for Machine Learning. 2021. [Sections 1.1, 2.1-2.2, 3.1, 5.1, 8.1, 9.1]

I Goodfellow, Y Bengio, A Courville. Deep Learning. 2016 [Sections 5.1, 5.2, 5.4]

S Shalev-Shwartz, S Ben-David. Understanding machine learning: from theory to algorithms. 2014. [Chapters 1, 2, 5]

## S Rogers, M Girolami. A first course in machine learning. 2017

Introduces concept of turning point with respect to derivatives and optimization

The derivative of a function (or the gradient in higher dimensions) tells us the rate of change of the function.

If the derivative is positive, the function is increasing. If the derivative is negative, the function is decreasing.

A turning point is a critical location where the behavior of a function changes. More precisely, a turning point is a point on the graph of a function where the function changes from increasing to decreasing, or from decreasing to increasing

Point where the gradient is 0. It could is a local minima, local maxima or a saddle point
In machine learning, the goal is to minimize the loss function. This means we are looking for the lowest possible value of the loss, which corresponds to a local minimum (or ideally, a global minimum) on the loss landscape.

Optimization algorithms, like gradient descent, work by iteratively adjusting the model's parameters in the direction opposite to the gradient of the loss function. This allows them to "descend" the loss landscape towards these turning points (local minima).

Important Note: While turning points are often associated with the derivative being zero (these are also called "stationary points"), not all stationary points are turning points. A saddle point is a stationary point where the derivative is zero, but the function doesn't change from increasing to decreasing (or vice versa) in all directions. Instead, it might be a minimum in one direction and a maximum in another. These can pose challenges for optimization algorithms.

Section 1.3 explains that as you add more parameters to a model the number of equations and partial derivatives becomes infeasibly large

The solution is to use matrices and vectors

A vector is generally easier to read as row so the transpose sign is often used when writing out notation X^T

X^T * Xn = matrix notation of linear model

All steps can be written at matrix notation: model, loss, optimization 

## C Bishop. Pattern recognition and machine learning. 2006.

Ability to correctly categorize data not seen in the training data is known as generalization

Regularization penalizes overfitting and overly complicated models 

Bias tends to be ignored by the regularization 

With neural networks, regularization is known as weight decay

The most common form of weight decay is equivalent to L2 regularization when using standard Stochastic Gradient Descent (SGD) optimizers.