# Machine Learning Notes (Spring 26)

This is the main file for the Machine Learning module taken in Spring 26. It will act as the location for note taking accross all mediums, i.e. lectures, videos, labs and additional readings, as well as a directory for file locations. It will recorded chronologically with a section for each week. 

TODO: module overview

# Table of Contents
1. [Week 1 - Introduction](#week-1---introduction)
2. [Week 2 - Supervised Learning I]()
3. [Week 3 - Supervised Learning II]()
4. [Week 4 - Supervised Learning III]()
5. [Week 5 - Model Validation I]()
6. [Week 6 - Model Validation II]()
7. [Week 7 - AI Ethics]()
8. [Week 8 - Advanced Neural Networks]()
9. [Week 9 - Beyond Supervised Learning]()
10. [Week 10 - Attention]()
11. [Week 11 - Reinforcement Learning]()

--- 

# [Week 1 - Introduction](https://canvas.sussex.ac.uk/courses/35245/pages/week-1-introduction-2?module_item_id=1546317)

This week is largely a preliminary session which gives insight as to how the module works, its scope and the weekly stuctures, which has changed from last year. At the end it will give a basic insight into machine learning through Linear Regression. 

#### Week 1: Contents

1. [Mini-Videos](#week-1-mini-videos)
2. [Lecture Content](#week-1-lecture-content)
3. [Lab Content](#week-1-lab-content)
4. [Additional Reading](#week-1-additional-reading)

## Week 1: Mini-Videos

The mini-videos hold the pre-recorded lecture content. They form the basis of the weekly content so should be watched before the in-person Wednesday lectures so that you can understand and be involved with the discussion content. 

### <u> What is Machine Learning </u> 
Mini-Lecture Resources: [Video](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=1515091f-1947-45ba-ba34-b31e00f85cfe) | [Slides](files/week_1/week_1_prerecorded_what_is_machine_learning.pdf)

This was a very basic introduction to what Machine Learning is. It touched on input features, dimensionality, generalizability, training data, unseen data. It clarified that ML models are software or mathmematical model that take in some input features and output labels. Training is the learning proccess and inference is giving the trained ML model instances to assign a value to. The slides introduced the types of learning: supervised, unsupervised, semi-supervised and self-supervised learning. 

### A Simple ML Model 
Mini-Lecture Resources: [Video](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=6067ee21-c700-437b-96d3-b31e01278a97) | [Slides](files/week_1/week_1_prerecorded_a_simple_ML_model.pdf)

This video introduced the simplest of ML models, the linear regression model. 

$$f(x) = xw + b = \hat{y}$$

* $x$: features
* $\hat{y}$: predicted outputs/labels
* $w,b$: weights and bias, the model parameters

Linear regression is a form of supervised learning and works on continous data. The formula above is in linear algebra form but it doesn't have to be presented that way. 

Here is some toy data: 

| Temperature (°C) | Relative humidity (%) | Wind speed (km/h) | Rain (mm) | Fire weather index |
| 23 | 21 | 10 | 0 | 0 |
| 40 | 89 | 6 | 1 | 30 |
| 35 | 60 | 23 | 15 | 15 |

Which can easily be presented in matrix form:

$$\begin{bmatrix} \hat{y}_1 \\ \hat{y}_2 \\ \hat{y}_{N=3} \end{bmatrix} = \begin{bmatrix} 23 & 21 & 10 & 0 \\ 40 & 89 & 6 & 1 \\ 35 & 60 & 23 & 15 \end{bmatrix} \times \begin{bmatrix} w_1 \\ w_2 \\ w_3 \\ w_4 \end{bmatrix} + \begin{bmatrix} b \\ b \\ b \end{bmatrix}$$

We can also present this as a System of Linear Equations:

$$\begin{aligned} \hat{y}_1 &= 23w_1 + 21w_2 + 10w_3 + 0w_4 + b \\ \hat{y}_2 &= 40w_1 + 89w_2 + 6w_3 + 1w_4 + b \\ \hat{y}_3 &= 35w_1 + 60w_2 + 23w_3 + 15w_4 + b \end{aligned}$$

**What are the best values of the weights and bias?**

This is learning part of ML. It find the optimal, or good, parameters. The definition of an optimal model would be one that minizes the error between the models predictions and the true label. 

**What to use as the error metric?**

The standard/default for continous labels is the mean square error, or $L_2$ error. 

$$L_2 = \frac{1}{N} \sum_{n=1}^{N} (\widehat{\mathbf{y}}_n - \mathbf{y}_n)^2$$

Recall that $\hat{y}$ is just the model outputs so we can replace this:

$$$$= \frac{1}{N} \sum_{n=1}^{N} (\mathbf{x}_n \mathbf{w} + b - \mathbf{y}_n)^2$$

This equation is what we want to minimise to get the perfect model. 

We know from maths that the minimum of a function is when its gradient (derivative) is zero, so:

$$0 = \frac{dL_2}{d\mathbf{w}}$$

Thus, is we can find the $w$, the weight vector, that corresponds to the minimum point, then we can optimize the model. 

**How to do learning with the basic linear model:**
* Get training data: $(x_n, y_n)$
* Choose error metric/loss function
* Find the optimal parameters, $w$ and $b$
* Use the model for inference

## Week 1: Lecture Content

**<u>Resources:</u>** [Lecture Slides](files/week_1/week_1_lecture_slides.pdf) | [Lecture Recording](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=79a7d91a-7c91-4b83-bf3a-b3e00093f009) | [Discussion Slides](files/week_1/week_1_discussion_slides.pdf) | [Discussion Padlet](https://padlet.com/university_of_sussex/week-1-student-student-post-discussion-notes-cuq7t347imsvmo6g)


1. [Week 1 Lecture Content](#week-1-main-lecture-content)
2. [Week 1 Discussion Content](#week-1-discussion-lecture-content)

---

### Week 1: Main Lecture Content

This a very basic lecture which convered no technical content and just explained the module as a whole. There will be very little notes from this lecture, though the discussion section of the lecture will have a lot of content. 

#### learning outcomes:

1. Understand machine learning terminologies and use them appropriately.
    - Machine Learning also shares a lot of terms with statistics and it can be important to get the definitions correct for the particular context. This point is most important for communication and conveying what you truely mean, and visa versa with listening. 
2. Describe how several traditional and advanced learning methods work.
3. Reason about the data needed to build a machine learning model for a given task. 
4. Prepare and preprocess data appropriately for building a model. 
5. Build and evaluate models using standard software libraries.
    - This module will not focus on doing things from first principal (from scratch)
6. Specify issues and risks that need to be considered and/or addressed.

#### Syllabus (Weekly)

1. Introduction
2. Trees and Neighbours
3. Hyperplanes and Likelihoods
4. Neural Networks
5. Problems & Data: At the centre of Machine Learning
6. How Good is my Model? (Evaluation)
7. AI & Ethics
8. Advanced Neural Networks
9. Feature Learning & Generative Models
10. Refinforment Learning 
11. Coursework Q&A

---

### Week 1: Discussion Lecture Content

**Discussion Learning Outcomes**: 
* How could the basic linear model be adpated for categorical labels?
* What could be expression of weak learning or memorizing in a linear regression model? And in waht ways memorising be prevented?


1. [How could the basic linear model be adapted for categorical labels?](#how-could-the-basic-linear-model-be-adapted-for-categorical-labels)
2. [Sign Loss](#sign-loss)
3. [Hindge Loss](#hinge-loss)
4. [What could be expressions of  weak learning or memorizing in a  linear regression model? And in  what ways could memorizing be  prevented?](#what-could-be-expressions-of--weak-learning-or-memorizing-in-a--linear-regression-model-and-in--what-ways-could-memorizing-be--prevented)
5. [Data Augmentation](#data-augmentation)

---

#### How could the basic linear model be adapted for categorical labels?

A linear model output is continous. In order to be able to use this model for categorical labels need the outputs to be discrete, or at least be interpreted as discrete. The main way of doing this would be to construct a model where the outputs are probabilitic and therefore between 0 and 1. We can then round, or partition, the outputs to determine a label/class. 

We can take the outputs of a linear model and apply a function ($\sigma$) to get normalized, discretized output:

$$f(x) = \sigma(xw + b) = \hat{y}$$

There are two popular ways to apply activation functions, Sign and Sigmoid. 

The Sign function is the most basic form of activation. It returns a hard value based on the threshold.

$$f(z) = \begin{cases} 1 & \text{if } z > 0 \\ 0 (or -1) & \text{if } z < 0 \end{cases}$$

This activation function lacks complexity or nuance. It simply cares about the threshold. Instances are treated the same wether they are 1 or 1000 over the threshold. Additionally, the derivative (slope) of the Sign function is zero everywhere except at $z=0$, where it is undefined. A zero slope means you cannot use Gradient Descent. If you try to "nudge" the weights to improve the model, the Sign function won't show you which direction to go. Given the importance of gradient descent in the modern deep learning, the Sign function is rarely used, though it was a ascept of the orginial perceptron model. 

The Sigmoid function on the other hand squashes the input into a smooth S-curve. It provides Probability. Instead of just saying "Yes" or "No," it says "There is an 87% chance of Yes." It has a smooth slope at every point, this means Gradient Descent can see exactly how much a small change in weights will reduce the error.

$$\sigma(z) = \frac{1}{1 + e^{-z}}$$

---

#### Sign Loss

Sign Loss, or 0-1 loss, is the simpliest, most intuative loss functon for something that. This formula checks if the output of the function $\text{sign}(\mathbf{x}_n \mathbf{w} + b)$ is the same as the true sign of the class. If it is then, add a $1$ to the summation. This approach measures the total 0-1 loss (error rate) over the entire dataset. 

$$L_0 = \frac{1}{N} \sum_{n=1}^{N} I(\text{sign}(\mathbf{x}_n \mathbf{w} + b) \neq y_n)$$

$I(\dots)$: The Indicator Function. It returns 1 if the condition inside the parentheses is true (a misclassification) and 0 if it is false (a correct classification).

Because the indicator function is "stair-stepped" (it jumps from 0 to 1 instantly), this function is notoriously difficult to optimize using standard gradient descent, which is why we usually use "surrogate" losses like Hinge Loss or Cross-Entropy in Deep Learning.

---

#### Hinge Loss

Hinge Loss is the primary loss function used for Support Vector Machines (SVMs). It is designed for maximum-margin classification, meaning it doesn't just care about getting the answer right; it cares about getting it right with a certain level of confidence (the "margin").

Here the prediction isn't categorical but instead continuous. If the model predicts the correct class and is "far enough" away from the boundary (the margin), the loss is 0. If the prediction is wrong, or if it's correct but too close to the boundary, the loss increases linearly. 

By penalizing correct predictions that are too close to the decision boundary, Hinge Loss forces the model to find a boundary that separates the classes as widely as possible.

 Unlike the $L_0$ "Sign Loss" you saw earlier (which is a flat line with a sudden jump), Hinge Loss is continuous, allowing optimization via gradient descent

$$\ell(y) = \max(0, 1 - y \cdot \hat{y})$$

Note that $\hat{y}$ is the same at $(x_n w + b)$, i.e. the prediction.

---

#### What could be expressions of  weak learning or memorizing in a  linear regression model? And in  what ways could memorizing be  prevented?

| Concept | Expression in Linear Regression | Symptom |
| :--- | :--- | :--- |
| Weak Learning (Underfitting) | High bias. The model is too simple to capture the underlying trend. | High training error and high testing error. Both $L_0$​ and Hinge/MSE stay high. |
| Memorizing (Overfitting) | High variance. The model captures the noise and outliers in the training data rather than the general pattern. | Low (or zero) training error but very high testing error. |

Note, a sign of overfitting can often be seen through weight values ($\mathbf{w}$) that have exploded to massive positive or negative magnitudes. This happens because the model tries to oscillate wildly to pass through every specific training point, including noise.

There are 3 main ways to mitigate overfitting:
* Regularization 
* Cross Validation
* Dimension Reduction/Feature Selection

##### Regularization

This is the most common method. We modify the loss function to penalize large weights.
* L2 Regularization (Ridge): Adds $\lambda \sum w_j^2$ to the loss. This forces weights to be small.
* L1 Regularization (Lasso): Adds $\lambda \sum |w_j|$ to the loss. This can force some weights to exactly zero, performing automatic feature selection.

##### Cross-Validation 

Instead of trusting a single training run, you split your data into $K$ "folds." You train on $K-1$ and test on the remaining one, rotating this process. This ensures the model's performance is consistent across different subsets of data.

##### Dimension Reduction/Feature Selection

If you have too many features ($D$) compared to your number of samples ($N$), the model will almost certainly memorize the data. Removing irrelevant or redundant features (using techniques like PCA or simply looking at correlation) forces the model to learn the most important signals.

---

#### Data Augmentation

The dimensions of videos is `t x h x w x c`. This is time, (height, weight, channels[r,g,b]).

**Types of image transformations:**
* Rotation
* Translation (move left or right, off-center)
* Flipping
* Horizontal shear
* Cropping

**Channel Transformations:**
* Colour Transformation
* Adding Noise (randomly)
* Blurring
* Contrast change
* Greyscale

**Transformations in the time dimension:**
* Jittering - adding noise along the time dimension
* Time Warping - Randomly changing the sample rates of random subsegmenets along the time dimension.
* Time reversal - flipping temporal order.
* Jigsaw - Randomly shuffling subsegments along teh time dimension.
* Dropout - Randomly masking time steps in the signal.

The goal of data augmentation is to artificially expand the size and diversity of your training dataset by creating "new" samples that are slightly different from the originals but still represent the same ground truth. This forces the model to learn invariant features rather than "memorizing" specific pixel arrangements or noise patterns.

By increases $N$ the sample size ($N$). A model can't easily "memorize" 10,000 versions of the same photo; it is forced to find the underlying pattern ($H_m$ or Gini purity) that connects them all.

Addtionally, it smooths the Loss Surface. By adding noise and variations, you make it harder for the model to find a "sharp" minimum that only fits the training data perfectly(overfitting).

---


## Week 1: Lab Content

**<u>Resources:</u>** [Notebook 1](files/week_1/week_1_lab.ipynb) | [Notebook 1 Solutions](files/week_1/week_1_lab_solutions.ipynb)

<br>

## Week 1: Additional Reading

### [<u> S Rogers, M Girolami. A first course in machine learning. 2017. </u>](https://readinglists.sussex.ac.uk/leganto/public/44SUS_INST/citation/23771559300002461?auth=SAML)

This textbook it generally considered an entry point to the mathematical side of machine learning. It takes a probabilistic perspective, teaching you the "why" behind the "how". It prioritizes intuition and Bayesian logic over raw code-heavy tutorials. 

The recommended reading for this week is Chapter 1 which covered Linear Regression. The chapter goes through the details of Linear Regression as a model but by the end of the chapter is more focused on the notion of paramterizing a problem. Linear Regression is a basic, statistics based model which is unlikely to have much basis for assessment, however, it is still a good tool for spinning up simple test models and demonstrating concepts on. 

*[I have skimmed through this chapter but have not taken any notes as it is fairly basic content which I am familar with both technically and on the intuition.]*

<br>

---

### [<u> C Bishop. Pattern recognition and machine learning. 2006. </u>](https://www.microsoft.com/en-us/research/wp-content/uploads/2006/01/Bishop-Pattern-Recognition-and-Machine-Learning-2006.pdf)

Christopher Bishop’s "Pattern Recognition and Machine Learning" (PRML) is the "Gold Standard" in the field. If Rogers and Girolami is the friendly introduction, Bishop is the deep, authoritative dive. It is famous for its rigor and its beautiful, detailed diagrams that help visualize high-dimensional probability distributions.

This reading for this is just a single section 1.1 which covers "Polynomial Curve Fitting". Here, Bishop uses Linear Regression, a simple model, to demonstrate the fundamental trade-offs in machine learning. 

The starting point in a goal, fit a polynomial function to the given data, which is Sine wave with some added random noise. The purpose of the function is such that we can give it a input $x$ for which is can predict a value $\hat{y}$

$$y(x, \mathbf{w}) = w_0 + w_1x + w_2x^2 + \dots + w_Mx^M = \sum_{j=0}^{M} w_jx^j$$

Where $M$ is the order of magnitude. This is the number parameter and dicates how "wiggly a line can get"

After instantiating the goal, they introduce the Error Function, which in this case is Sum-of-Squares. The purpose of the error function is the help us find the best weight $w$ values. Ultimately, it measures the different between our function outputs and the true training data. 

$$E(\mathbf{w}) = \frac{1}{2} \sum_{n=1}^{N} \{y(x_n, \mathbf{w}) - t_n\}^2$$

Next, we have the problem of model selection, that is how many $M$ do we use:

* $M = 0$ or $1$: The model is a flat line or a simple slope. It's too simple and misses the trend entirely **(Underfitting)**.
* $M = 3$: The model captures the sine wave shape perfectly.
* $M = 9$: With a small dataset, a 9th-order polynomial will pass through every single data point perfectly ($E(\mathbf{w}) = 0$). However, the curve oscillates wildly between points **(Overfitting)**. It has tuned itself to the noise rather than the signal.

Finally, the notion of Regularization is introduced as a solution to overfitting. This allows us to control the overfitting without having to reduce the complexity of our model, i.e. reduce M. Regularization involves adding a penalty term to the error function to discourage the weights $\mathbf{w}$ from reaching massive, explosive values. $\lambda$ (lambda) controls the "strength" of the penalty. This is often called Ridge Regression or Weight Decay.

$$E_{new}(\mathbf{w}) = \frac{1}{2} \sum_{n=1}^{N} \{y(x_n, \mathbf{w}) - t_n\}^2 + \frac{\lambda}{2} \|\mathbf{w}\|^2$$

The key to this Bishop chapter is to understand that Machine Learning is itself about minimizing the error on the training data, it is **Generalization**. We could fit a perfect function to even the most complex set of given training data which sets the error to 0. Doing so would require a complex model but it's complexity would be enshrined in overfitting. It will have learned the training data but nothing transferable. It must learn that as be increase a models complexity, we must constrain it, or implement Regularization to keep the model's "ambition" in check.

<br>

---

### <u> [M Deisenroth, A Faisal, CS Ong. Mathematics for Machine Learning. 2021](https://mml-book.github.io/book/mml-book.pdf) </u>

* [1.1 Finding Words for Intuitions](https://mml-book.github.io/book/mml-book.pdf#page=18&zoom=100,192,168)
* [2.1 Systems of Linear Equations](https://mml-book.github.io/book/mml-book.pdf#page=25&zoom=100,96,681)
* [2.2 Matrices](https://mml-book.github.io/book/mml-book.pdf#page=28&zoom=100,192,312)
* [3.1 Norms](https://mml-book.github.io/book/mml-book.pdf#page=77&zoom=100,96,320)
* [5.1 Differentiation of Vector Calculus](https://mml-book.github.io/book/mml-book.pdf#page=147&zoom=100,96,536)
* [8.1 Data, Models and Learning](https://mml-book.github.io/book/mml-book.pdf#page=257&zoom=100,96,712)
* [9.1 Problem Formulation](https://mml-book.github.io/book/mml-book.pdf)

<br>

---

### <u> [I Goodfellow, Y Bengio, A Courville. Deep Learning. 2016](https://readinglists.sussex.ac.uk/leganto/public/44SUS_INST/citation/23771559280002461?auth=SAML) </u>

* 5.1 Learning Algorithms
* 5.2 Capacity, Overfitting, Underfitting
* 5.4 Estimators, Bias and Variance

#### Bias 

Bias measures how much the average estimate from a learning algorithm differs from the true value you are trying to predict. In machine learning, this usually happens because your model makes simplistic assumptions that don't match reality (e.g., trying to fit a straight line to data that clearly curves).

$$\text{bias}(\hat{\theta}_m) = \mathbb{E}(\hat{\theta}_m) - \theta$$

$\mathbb{E}(\hat{\theta}_m)$: This is the "Expected Value." If you were to go out and collect 1,000 different datasets and train 1,000 different models, this is the average of all those results. If the bias is 0, the estimator is called unbiased. This means that, on average, your model is perfectly "on target," even if individual predictions are off.

Bias is essentially "underfitting." It stems from two main sources:
* Model Complexity: Your model is too simple for the task (e.g., a linear regression trying to map the stock market).
* Erroneous Assumptions: You assumed the data followed a specific distribution (like a Normal distribution) when it actually followed something else.

---
| Feature | Bias | Variance |
| :--- | :--- | :--- |
| Definition | Error from incorrect assumptions. | Error from sensitivity to small fluctuations. |
| Model State | Underfitting. | Overfitting. |
| Complexity | Model is too simple. | Model is too complex. |
| Fix | Increase features or model depth. | Increase data or add regularization. |
---


#### Evaluation 

Goodfellow et al. show that the total error of your model isn't just one "thing"—it’s actually a sum of different types of errors. If we want to know how well our estimator $\hat{\theta}$ is performing, we calculate the MSE. 

$$\text{MSE} = \text{bias}(\hat{\theta})^2 + \text{Var}(\hat{\theta})$$

As you try to decrease bias (by making your model more complex), your variance almost always goes up. The goal of a machine learning engineer isn't to reach zero bias; it's to find the point where the sum of bias squared and variance is at its lowest. 

In the book, they refer to "Capacity." High-capacity models (like deep neural networks) can have very low bias because they can fit almost any shape, but they are prone to massive variance.

### Control 

In modern deep learning, we actually tend to favor very high-capacity models (which have the potential for low bias) and then use techniques to beat the variance into submission. To reduce Bias we add more layers, use more neurons, or train for more epochs. To reduce Variance we use Dropout, $L^2$ weight decay (regularization), or get more data. 

#### Statistical vs Societal Bias

In the Deep Learning textbook (Chapter 5.4), "Bias" is a statistical term. In the news or ethics discussions, "Bias" is a societal or algorithmic term. 

Statistical bias is purely mathematical, it is about the approximation error. Does the average of my estimates equal the true parameter? Problems to this may arise if the model is too weak to learn the complexity. E.g. Trying to predict house prices using only square footage when location also matters. The model is "biased" toward a simple linear relationship that doesn't exist.

Societal/Algorithmic Bias is about fairness and disparate impact. Does the model treat different groups of people (race, gender, age) equitably? A problem arised if data used to train the model contains human prejudices, or certain groups are underrepresented. E.g. A facial recognition system that works perfectly on light-skinned faces but fails on dark-skinned faces because the training set lacked diversity. 

While they are different concepts, Statistical Bias can actually cause Societal Bias.

If a dataset has 10,000 examples of Group A and only 10 examples of Group B:
* The model's "Expected Value" for Group B will be way off because it hasn't seen enough data to learn the true parameters for that group.
* Mathematically, the estimator for Group B has high statistical bias (it defaults to the patterns of Group A).
* Socially, this results in discrimination, as the model makes poor decisions for Group B.

#### Asymptotic Unbiasedness

In statistics, we have a property called Asymptotic Unbiasedness. An estimator is asymptotically unbiased if the bias vanishes as the number of data points $m$ approaches infinity:

$$\lim_{m \to \infty} \text{bias}(\hat{\theta}_m) = 0$$

A classic example is the Sample Variance. If you calculate variance by dividing by $n$ (the number of samples), your estimate is technically biased—it consistently underestimates the true variance. However, as $n$ gets larger, that error shrinks until it's effectively zero.

#### 3 Types of Bias

| Type of Bias | Source | Does more data fix it? |
| :--- | :--- | :--- |
| Estimation Bias | The specific ""guess"" made from a small sample. | Yes. Usually vanishes as m→∞. |
| Model/Approximation Bias | The model is too simple (e.g., Linear vs. Non-linear). | No. You need a more complex model. |
| Selection Bias | The data itself is a ""tilted"" view of reality. | No. You need better data, not just more of the same. |

The Deep Learning Philosophy: This is why the field moved toward Massive Models + Massive Data. We use models with almost zero "Inherent Bias" (Deep Nets) and feed them enough data to eliminate "Estimation Bias."

Note, that Selection Bias is a form of Statistical Bias, not just societal. In Goodfellow, an estimator $\hat{\theta}$ is a function of the data. If the data itself is "broken" or unrepresentative, the "Expected Value" of your model will never equal the "True" value of the population. Data can causes the Estimator to be bias. 

In statistics, we assume our training data is sampled IID (Independent and Identidically Distributed) from some "true" distribution $p_{data}$. Selection bias occurs when your sampling process is flawed. Mathematically, this means:

$$\mathbb{E}_{S \sim P_{sample}}[\hat{\theta}] \neq \theta_{true}$$

Even if you have an infinite amount of data ($m \to \infty$), if that data was collected via a biased selection process, your model will be consistently wrong. In Goodfellow's terms, the bias of your estimator will not converge to zero. 

That being said, the principal of Goodfellow, at least in Chapter 5, is focused on Model Bias (Capacity). This is because as a researcher, you can control your model's architecture. You often cannot control how the data was originally collected. They want you to understand that even with "perfect" data, a model that is too simple will still have bias because it lacks the capacity to learn the truth.

<br>

---

### <u> S Shalev-Shwartz, S Ben-David. Understanding machine learning: from theory to algorithms. 2014. </u>

[Link]()

* Chapter 1 - Introduction
* Chapter 2 - Gentle Start
* Chapter 5 - The Bias-Complexity Trade-off


#### The Bias-Complexity Trade-off

A specific learning task is defined by an unknown distribution $D$ over $X × Y$, where the goal of the learner is to find a predictor $h : X → Y$, whose risk, $LD(h)$, is small enough.

The question is therefore whether there exist a learning
algorithm $A$ and a training set size $m$, such that for every distribution $D$, if $A$ receives $m$ i.i.d. examples from $D$, there is a high chance it outputs a predictor h that has a low risk, i.e. a superior universal learner. 

The No-Free Lunch theorem states that no such universal learner exists.  To be more precise, the theorem states that for binary classification prediction tasks, for every learner there exists a distribution on which it fails. 

We say that the learner fails if, upon receiving i.i.d. examples from that distribution, its output hypothesis is likely to have a large risk, say, ≥ 0. 3, whereas for the same distribution, there exists another learner that will output a hypothesis with a small risk. In other words, the theorem states that no learner can succeed on all learnable tasks – every learner has tasks on which it fails
while other learners succeed.

#### The No Free Lunch Theorem

Let $A$ be any learning algorithm for the task of binary classification with respect to the $0-1$ loss over a domain $\mathcal{X}$. Let $m$ be any number smaller than $|\mathcal{X}|/2$, representing a training set size. Then, there exists a distribution $\mathcal{D}$ over $\mathcal{X} \times \{0,1\}$ such that:
* There exists a function $f : \mathcal{X} \to \{0,1\}$ with $L_{\mathcal{D}}(f) = 0$.
* With probability of at least $1/7$ over the choice of $S \sim \mathcal{D}^m$ we have that $L_{\mathcal{D}}(A(S)) \ge 1/8$.

This theorem states that for every learner, there exists a task on which it fails, even though that task can be successfully learned by another learner. 

<br>

---

# [Week 2 - Trees and Neighbours](https://canvas.sussex.ac.uk/courses/35245/pages/week-2-trees-and-neighbours?module_item_id=1546318)

Learning Outcomes:
* Be able to describe two other types of machine learning models (decision trees & k nearest neighbours) and build them yourself. 
* See how multiple weak models could be useful when used together. 

#### Week 2: Contents

1. [Mini-Videos](#week-n-mini-videos)
2. [Lecture Content](#week-n-lecture-content)
3. [Lab Content](#week-n-lab-content)
4. [Additional Reading](#week-n-additional-reading)

## Week 2: Mini-Videos

* [A Tree Based Model](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=cce85a25-e931-45ce-b34a-b32300909802)
* [K-nearest Neighbours](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=cce85a25-e931-45ce-b34a-b32300909802)

---

## Tree Based Models

* Part 1: How Decision Trees work
* Part 2: How mutliple weak trees can be more useful than an overfit one (ensemble learning)

### Decsion Tree Creation Example

With Decision Trees, we start with a feature and define a split (or category). From this, two leaf nodes come out of the split which hold two sub-regions of the data as the parent node. 

It is possible that one, or both of the leaves, cleanly splits the data. That is, the subset only has one class in it. If a leaf has only one class in it, that does not mean it completely seperates the data for that class. But it means that we do not need to keep splitting that leafs sub-region futher. 

If the sub-regsion is not determined (1 class), then we select a feature again and specify another split, or constraint (=). Once all the leaves result in a cleanly split leaf, we have a tree that can be used for inference.

Remeber, the point of creating any model is to be able to make inference with it. Inference is the ability to make a prediction on unseen/unlabelled data.

The training part of a DT is contructing the tree and its splits based on the training data. Testing is taking instances and putting them through the tree to find their label. 

#### Decision Trees

DT's work by repeatedly partioning the data space into 2. Each split point is defined by a hyperplane that sperates partitions in the data space. Leaf nodes represent labels for data insstances that share ther same label region. We can use trees for both classification and regression. Ultimately, we want a model whereby the parameters (splits) are optimized.

#### Knowing When to Split

Recall, we said that if a leaf was completely part of 1 label then we didn't need to split further. This is an absolute example but things dont have to be 100% to decide to spot splitting. In fact, only splitting at 100% points is an easy way to overfit to the training data.

We make the decision to split further based on a metric called "purity". Purity is the proportion of instances of the majority label. i.e. $3/3 = 1$, $3/5 = 0.67$. Any purity less than 1 can be considered but we can set the decider value as a parameter

#### Splitting Methodology
* Sort the dataset by a feature, i.e. by height low to high.
* Identify the potential split points between each instance (if different values). For a pre-decided rule. i.e. `100, 150, 200` then construct splits at `125, 175`.
* Evalute each split based on split criteron: Info Gain (related to entropy) or Gini Index. 

Both Info Gain and Gini Index are measures of disorder or uncertainty. If a space as a even mix of labels, then the space is more uncertain. A skewed space is more certain. Outcomes will be less suprising on average

#### Information Gain

How to chose the best split point using Info Gain:
* The uncertainty is measured based on the outcome of both the splits subregions.
* Info gain is a reduction in uncertainty (entropy) about the label for the partition.
* The split point selected is the one with the highest info gain, i.e. the point with the least uncertainty.

$$Gain(m, m_{<s}, m_{>s}) = H_m - H_{m_{<s}/m_{>s}}$$

The weighted average entropy of the resulting child nodes is defined as:
$$H_{m_{<s}/m_{>s}} = \frac{n_{m_{<s}}}{n_m} H_{m_{<s}} + \frac{n_{m_{>s}}}{n_m} H_{m_{>s}}$$

The reason it is weighted is because it needs to be normalized against volumne of data in the given split. If one child node contains 95% of the data and the other only 5%, the entropy of the larger group should "count" more toward the final score. $\frac{n_{m_{<s}}}{n_m}$ and $\frac{n_{m_{>s}}}{n_m}$ are the weights. By multiplying the entropy of each split by its relative size, you ensure the Gain reflects the improvement across the entire dataset. 

The entropy $H_m$ for a given node $m$ is calculated as:

$$\text{entropy } H_m = -\sum_{k=1}^{K} p(c_k|m) \log_2 p(c_k|m)$$

$p(c_k|m)$ can be computed form the data as $\frac{n_{m_k}}{n_m}$

We calculate 3 $H$ (entropy), one for each split and another for the parent. Each entropy calculation use the data instances `k` that belong to that sub-region. 

#### Gini Index

This is an alternative metric for capturing the uncertainty of a data region. For this method, the best split point is the one with the lowest index. Again, this method looks and weights the two sub-regions based on the number of instances it holds. 

$$G_{m_{<s}/m_{>s}} = \frac{n_{m_{<s}}}{n_m} G_{m_{<s}} + \frac{n_{m_{>s}}}{n_m} G_{m_{>s}}$$

The Gini calculation can be represented with probabilities:

$$G_m = 1 - \sum_{k=1}^{K} p(c_k|m)^2$$

Or raw counts:

$$G_m = 1 - \sum_{k=1}^{K} \left( \frac{n_{m_k}}{n_m} \right)^2$$

#### Categorical Features

Before we were looking at continious features where we could evaluate potential splits using Info Gain or Gini Index. Clearly, this can not apply to categorical features. here, you need to evaluate each value as a potential split point. The same evaluation methods can be used for the splits. 

#### Decision Tree Algo: Optimal Model 

You start by initalising the hyperparamters and methods to be used: purity threshold, max number of leaf nodes and initial region, which needs to have the purity computed. The intitial region is just the starting train set. If purity >= threshold then stop splitting. Otherwise, for each feature compute the best split points based on split criterion. Once you split the data, the workflow continues independently for each leaf until the threshold is acheived.

#### Overfitting and Pruning

Overfitting in tree based models is related to the size of the tree and specifically the number of nodes. Pruning is a strategy to reduce overfitting by removing nodes. A pruning criterion $v_T$ is used to determine if a given node should be pruned, this is also known as the Cost-Complexity Pruning. It adds a penalty for every extra leaf node you add to the tree, which mitigates the tree growing too large and overfitting. 

$$v_T = \sum_{\tau=1}^{|T|} \varepsilon_\tau + \alpha |T|$$

* $|T|$: The total number of leaf nodes in the tree $T$. This represents the complexity of the model.
* $\varepsilon_\tau$: The uncertainty measure for a specific leaf node $\tau$. This is usually the Gini Impurity or Entropy that you were looking at earlier. Summing these up gives you the total "error" or "disorder" remaining in the model.
* $\alpha$: The pruning hyperparameter. If $\alpha = 0$, the tree stays as large as possible (no penalty for size). As $\alpha$ increases, the penalty for having many leaves grows, forcing the tree to become smaller and simpler.

#### Ensemble Learning

Creating a community model made up of multiple model. Ensembles can be any types of models but for trees it is a common application. There are two main approaches to ensemble learning are bagging (bootstrap aggregating) and boosting. 

#### Bagging (Bootstrap Aggregating)

Each model is trained on a randomly selected subset of training data and you do this iteratively so there is mutliple rounds. Each round, a subset can be picked up and a model trained. This is the bootstrapping portion of the training. The aggregating part is the community model voting from each constitutes whereby the outcomes are averaged. 

This approach allows mutliple functions to capture a wider degree of complexity in the underyling data. Often the expected error of the community tends to be lower than each constituent, i.e. each trees, in the model. This makes sense as each tree is only trained on a subset of the training data. The individual trees are known as "weak learners". This is important because it means, individually the trees cannot overfit to the training data meaning they are robust to overfitting. 

#### Boosting

Boosting is a cumulative training approach, the tree is trained several times. For this to be possible, there needs to be something different about the training for each iteration. This is acheived through weighting the data. On each run, the model is evaluated and data points which performed worse are weighted. This amplifies them in the next run and forces the model to approach them with more rigour. 
 
---

## K-nearest Neighbours

Learning Outcomes:
* How kNN models work

### kNN

Goal is to obtain some output automatically based on a input. With kNN there is no "model". You use the training data instances to find an output but there is no model or function derived. 

With kNN, you use the class of k nearest neighbours to the data point $x_i$ that you want to run inference on to find an output $\hat{y_1}$. Use a subset of `k` nearest neigbours.

The inference is in the data itself, not any model or function. There is no training. 

### How a kNN inference works

1. For each test instance $x_i$, find its $k$ nearest neighbours based on a distance metric $dist(x_i,x_n) n = 1,2,...,N$
2. Determine the class of $x_i$ from the labels of the $k$ neighbours and implement a voting strategy. 


### Euclidean Distance 

How to find the nearest neighbours? Some common/basic method is Eucidean distance. This could be considered the direct distance

$$dist(x_i, x_n) = \sqrt{\sum_{d=1}^{D} (x_{i_d} - x_{n_d})^2} = \|x_i - x_n\|$$

* The intution is the sum of the squared differents for each dimension. 

What use cases is it best for? Objects in the sky (speed, pos, traj, start point, end point), Euclidean can give us a good measure of distance for this example. Football fans in a pub, find a persons supported team based on the people around them. 

### Manhattan (city block distance)

This measure of distance is the "L" shape. It can only move up/down or left/right. Hence to go diagonal, is must form an "L". This is summing the absolute difference across dimensions. 

$$dist(x_i, x_n) = \sum_{d=1}^{D} |x_{i_d} - x_{n_d}| = |x_i - x_n|$$

Use cases:
* Prices of houses in a region. Street distance. 
* Categories of items in a supermarket.
* Trajector of cars in traffic

### Cosine Similarity

Not strictly a measure of distance but instead the angle between two vectors. In this example, the vector would be a feature vector where each entry is a dimension. 

Below is a measure of Cosine Distance which is derived from cosine similarity. The fraction part of the formula is the Cosine Similarity.Subtracting it from $1$ turns it into a distance metric (where $0$ means the vectors are identical in direction, and $2$ would mean they are pointing in diametrically opposite directions).

$$dist(x_i, x_n) = 1 - \frac{\sum_{d=1}^{D} x_{i_d} \cdot x_{j_d}}{\sqrt{\sum_{d=1}^{D} {x_{i_d}}^2} \cdot \sqrt{\sum_{d=1}^{D} {x_{n_d}}^2}}$$

The deminsions of a vector could be anything, for example, words as per a text document. 

### Voting Strategy

* Majority Voting (for classification)

$$\hat{y}_i = \max_c \left\{ \sum_{j=1}^{k} 1_{y_j=c}, \quad \forall c \in C \right\}$$

* Averaging (for regression)

$$\hat{y}_i = \frac{1}{k} \sum_{j=1}^{k} y_j$$

### Inference Time Complexity for kNN

Because there is not pre-trained model that can be excuted on test instances, all of the calculations associated with "training" are done at the point of inference, every time. This means that there is time complexity associated with inference. 

Time complexity of inference is given as: $N^2*D$
* $N$ for the total number data instances
* $D$ for the total number of features

Note, this complexity is very large and costly (comp + time). 

### Strategy for Minimizing Time Complexity

* Indexing for faster search. This can be considered as pre-processing so that inference can be conducting quicker. An abstract example of this could be thinking about an un-ordered alphabet list and how much long it would take you to find the right letter. Indexing is creating a catalogue system, an type of order.

* kd tree, tree-based indexing of the data. Repeatedly partition the data region, similar to creating a decision tree. Changes time complexity to $N*D*log*N$.

### Other Strategies: Dimensionality Reduction

Given that time complexity is given by $N^2 * D$, an alternative way to reduce complexity is to reduce D. This would be acheived by reducing the number of dimensions (features). Dim Reduction will be a topic of study in Week 6. 


## Week 2: Lecture Content

Discussion Points: 
* Would differing feature scales affect the behaviour of the model?  
* A student-posed question
* What does this AI do?

### Would differing feature scales affect the behaviour of the model?  

Toy example, 5 standard weather features: 

| | Humidity| No. of days of sunshine| Wind speed| Temperature| Rainfall rate |
| :--| :--| :--| :--| :--| :-- |
| Mean| 82.52| 120.345| 4.67| 9.42| 97.68 |
| Standard deviation| 5.16| 63.21| 1.18| 4.51| 68.33 |
| Min| 63.03| 3.49| 2.11| -1.62| 0.28 |
| Max| 95.93| 345.34| 11.82| 20.37| 697.13 |

Question: What do you notice about the scale of the features? Think about how the scale compares across features.

* All metrics are on different scales and units. 
* SD varies wildly.
* Some mins are below 0. 

#### For each of the 3 types of model, would differing scales accross features affect the behaviour of the model? And why or why not? 

Hint: think about how the models are trained. 

Whether or not scaling matters to a model, comes down to whether the model relies on distances or gradient-based optimization versus simple thresholding.

---

With Linear Regression, the scale normally matters. While the underlying math of Ordinary Least Squares (OLS) can theoretically handle different scales, in practice, scaling is crucial for two reasons: 
* Most linear models are trained using optimization algorithms like Gradient Descent. If one feature ranges from 0 to 1 and another from 0 to 1,000,000, the "contour lines" of the loss function become extremely elongated ellipses. This forces the gradient to oscillate and take much longer to reach the minimum.
*  If you use Lasso ($L1$) or Ridge ($L2$) regression, scaling is mandatory. Regularization penalizes the magnitude of coefficients. A feature with a large scale will naturally have a tiny coefficient to compensate, meaning the penalty will ignore it while unfairly punishing features with small scales.

---

With Decision Trees, scale is irrelevant. A tree makes decisions by picking a feature and a threshold. This is a monotonic transformation. The tree looks at features one by one. Whether Income is measured in dollars or thousands of dollars doesn't change the fact that there is a point in the data that best separates the classes. The information gain (or Gini impurity) remains identical regardless of the units. 

--- 

With kNN it is critically important because it is entirely distance-based. KNN usually calculates the Euclidean (or alternative) distance between points. If you have a Age feature (0–100) and an Annual Salary feature (0–200,000), the salary difference will completely overwhelm the age difference. A 1-year age gap is treated as equivalent to a $1 salary gap. Without scaling, KNN effectively ignores any feature with a smaller numerical range. 

---

#### Scaling Approaches

The two most common approaches are Normalization and Standardization.

##### Min-Max Scaling (Normalization)

This method re-scales the data into a fixed range—usually 0 to 1. It is particularly useful when you have a specific bound for your data or when you are using algorithms that don't make assumptions about the distribution (like Neural Networks or KNN). 

$$x_{new} = \frac{x - x_{min}}{x_{max} - x_{min}}$$

* Pros: Preserves the relative distances between values and keeps everything within a tight, predictable window.
* Cons: It is highly sensitive to outliers. If you have one person earning $10,000,000 in a dataset of middle-class earners, everyone else will be squashed into a tiny range near 0.

The reason Min-Max Scaling is the "go-to" when you aren't sure about your data's distribution is that it makes zero structural changes to the data. It simply compresses the existing shape into a new, smaller box.

Min-Max Scaling is a linear transformation. It doesn’t care if your data looks like a bell curve, a flat line, or a giant "U." It preserves the exact relative distances between every single data point. Algorithms like KNN or Recommender Systems calculate the distance between points. If you use Standardization on a non-normal distribution, you might "squash" the distances in the middle of the range differently than at the edges.

Many real-world datasets have "hard floors" or "hard ceilings" that aren't normally distributed: Image Pixels: Always 0 to 255, Test Scores: Always 0 to 100%, Customer Ratings: Always 1 to 5 stars. In these cases, there is no "infinite tail" like a Normal distribution assumes. Min-Max Scaling honors these boundaries, whereas Standardization could result in values like -3.5 or +4.2, which don't make intuitive sense for a bounded feature like "Percentage."

While not a "requirement" in the strictest sense, many activation functions in Neural Networks (like Sigmoid or Tanh) are most sensitive to inputs in a small range around 0 or 1. If you feed a Sigmoid function a value of 20 (which could happen with Standardization), the gradient "saturates" (becomes nearly zero), and the model stops learning. Min-Max ensures your inputs live exactly where the "math is most active."

The only reason not to use Min-Max when you are unsure of the distribution is Outliers. Example: If 99% of your data is between 1 and 10, but you have one error value at 10,000, Min-Max will put that 1% at "1.0" and cram the other 99% of your data into the range "0.0001 to 0.001." In that scenario, your model loses all its "resolution" for the bulk of your data.

##### Standardization (Z-Score Normalization)

Standardization centers the data around a mean of 0 with a standard deviation of 1. Unlike Min-Max, it doesn't "clamp" the data to a specific range; instead, it describes how many standard deviations a point is from the average.

$$z = \frac{x - \mu}{\sigma}$$

* **Pros:** Much more robust to outliers and generally preferred for models that assume a Gaussian (normal) distribution, like Linear or Logistic Regression.
* **Cons:** The resulting range is not fixed (you can have values of -5, 10, etc.), which some specific algorithms might find difficult to process.

##### Robust Scaling

If your data is "messy" and full of extreme outliers that you can't simply delete, a Robust Scaler is your best friend. Instead of using the mean and standard deviation (which outliers heavily influence), it uses the Median and the Interquartile Range (IQR). 

* Logic: It subtracts the median and divides by the distance between the 25th and 75th percentiles.
* Best for: Datasets where outliers are frequent and you don't want them to skew the scaling of the "normal" data points.



| Scenario | Recommended Approach |
| :--- | :--- |
| Outliers are present | Standardization or Robust Scaling |
| "Data must be between 0 and 1 (e.g., Image Pixels)" | Min-Max Scaling |
| Algorithm assumes Normal Distribution | Standardization |
| KNN or Gradient Descent models | Either (but usually Standardization) |

#### Why Does Gradient Descent Prefer Standardization?

To understand why Gradient Descent prefers standardization, you have to look at the "Loss Landscape"—the mathematical mountain range that the algorithm has to navigate to find the lowest point (the optimal solution). Standardization turns a chaotic, steep-walled canyon into a neat, symmetrical bowl.

When features have different scales, the cost function (like Mean Squared Error) looks like a long, skinny elongated ellipse. If Feature A goes from 0 to 1 and Feature B goes from 0 to 1,000,000, a small change in the weight ($w_B$) for Feature B has a massive impact on the error, while a change in $w_A$ barely registers. The gradient (the direction of steepest descent) doesn't point directly toward the center. Instead, it points almost entirely toward the "steep" side. 

Because the gradient in an unscaled landscape points steeply toward the narrow walls of the "canyon" rather than down the path to the minimum. The algorithm "bounces" back and forth between the steep walls. To avoid bouncing too far and diverging, you are forced to use a very small learning rate. This makes the entire training process incredibly slow. 

When you standardize, the loss landscape becomes spherical (circular). In a circle, the gradient at any point points much more directly toward the center (the minimum). This allows the algorithm to take a direct path, using a larger learning rate without "tripping" over its own feet.

In standard Gradient Descent, we use a single learning rate ($\alpha$) for all parameters: $w_{new} = w_{old} - \alpha \cdot \nabla J(w)$. If your features aren't on the same scale, the "ideal" learning rate for Feature A might be 0.1, while the ideal rate for Feature B might be 0.000001. Using a single $\alpha$ for both is a compromise that usually satisfies neither, leading to poor convergence or numerical instability. Standardization ensures that a single learning rate is effective for every weight in your model.




## Week N: Lab Content

## Week N: Additional Reading



















# [Week N - Introduction]()

#### Week N: Contents

1. [Mini-Videos](#week-n-mini-videos)
2. [Lecture Content](#week-n-lecture-content)
3. [Lab Content](#week-n-lab-content)
4. [Additional Reading](#week-n-additional-reading)

## Week N: Mini-Videos

## Week N: Lecture Content

## Week N: Lab Content

## Week N: Additional Reading