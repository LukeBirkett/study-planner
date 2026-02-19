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

---

### Main Lecture Content

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

### Discussion Lecture Content

**Discussion Learning Outcomes**: 
* How could the basic linear model be adpated for categorical labels?
* What could be expression of weak learning or memorizing in a linear regression model? And in waht ways memorising be prevented?


#### How could the basic linear model be adapted for categorical labels?

A linear model output is continous. In order to be able to use this model for categorical labels need the outputs to be discrete, or at least be interpreted as discrete. The main way of doing this would be to construct a model where the outputs are probabilitic and therefore between 0 and 1. We can then round, or partition, the outputs to determine a label/class. 

We can take the outputs of a linear model and apply a function to get normalized, discretized output:

$$f(x) = \sigma(xw + b) = \hat{y}$$

There are two popular ways to apply activation functions, Sign and Sigmoid. The Sign function is the most basic form of activation. It returns a hard value based on the threshold.

$$f(z) = \begin{cases} 1 & \text{if } z > 0 \\ 0 (or -1) & \text{if } z < 0 \end{cases}$$

This activation function lacks complexity or nuance. It simply cares about the threshold. Instances are treated the same wether they are 1 or 1000 over the threshold. Additionally, the derivative (slope) of the Sign function is zero everywhere except at $z=0$, where it is undefined. A zero slope means you cannot use Gradient Descent. If you try to "nudge" the weights to improve the model, the Sign function won't show you which direction to go. Given the importance of gradient descent in the modern deep learning, the Sign function is rarely used, though it was a ascept of the orginial perceptron model. 

The Sigmoid function on the other hand squashes the input into a smooth S-curve. It provides Probability. Instead of just saying "Yes" or "No," it says "There is an 87% chance of Yes." It has a smooth slope at every point, this means Gradient Descent can see exactly how much a small change in weights will reduce the error.

$$\sigma(z) = \frac{1}{1 + e^{-z}}$$

##### Possible Loss Functions

Sign Loss, or 0-1 loss, is the simpliest, most intuative loss functon for something that


<br>
<br>
<br>


1. turn linear regression into cat/prob

Sign activation function (include formulas)
- sign loss func
- this is for comparing labels, matching or not
- comparing labels isnt normally good as it doesn't tell model enough into on what went wrong 
- Hinge Loss
- take max of 0 and model output
- uses the true sign to conver the output below or over 0
- higne is better than high becuase it measure sin some way how much something was wrong
- 




2. loss funciton 

---




## 2nd Discussion

find lin model such that 
A
B

fail A
fail B

weak leaner - low model compexity, high bias
- model is too simple which means it makes too many assumptions
- bad variables


training data memorization
- high model complexity
- high variances, very senstiive to seen data


generalize in ML is the sweet spot between weak learner and memorization


### 3rd Discuss

Addressing Overfitting

Model weights & Model Complexity

If some weights are zero then this reduces the complexity, i.e. less features

we want to create a way such that the learning will do this and cut out uninformative features 

Encourage Lower Complexity

Regularization

L1 is the one that encourages 0 weights where ness

[include equation] [all in slide]

l1 is a penalty term in the loss function 

=+ reg term * magnitute of the weights

it penalized non-zero weights

l1 because the mag weights is not squared


L2 is another way to encourage lower complex 

l2 because ^2 the mag weights

lasso reg

penalises large weights

encourages very small weights

nots compelxtly remove

this is also a form of reduced complexity


#### Image Section 

take notes of this, relevant for assessment

image dimensions

transofrmations of images to create new features 

time dimension augmentation
- Jittering
- Time Warping
- [Take notes of rest]
- DROPOUT


Data augment is tool to reduce augmentation

Avoids model learning explicitly the training data

focus on informative features


## SUMMARY




## Week 1: Lab Content

**<u>Resources:</u>** [Notebook 1](files/week_1/week_1_lab.ipynb) | [Notebook 1 Solutions](files/week_1/week_1_lab_solutions.ipynb)

<br>

## Week 1: Additional Reading

### [<u> S Rogers, M Girolami. A first course in machine learning. 2017. </u>](https://readinglists.sussex.ac.uk/leganto/public/44SUS_INST/citation/23771559300002461?auth=SAML)

This textbook it generally considered an entry point to the mathematical side of machine learning. It takes a probabilistic perspective, teaching you the "why" behind the "how". It prioritizes intuition and Bayesian logic over raw code-heavy tutorials. 

The recommended reading for this week is Chapter 1 which covered Linear Regression. The chapter goes through the details of Linear Regression as a model but by the end of the chapter is more focused on the notion of paramterizing a problem. Linear Regression is a basic, statistics based model which is unlikely to have much basis for assessment, however, it is still a good tool for spinning up simple test models and demonstrating concepts on. 

*[ONGOING: I have skimmed through this chapter but have not taken any notes as it is fairly basic content which I am familar with both technically and on the intuition.]*

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

### <u> M Deisenroth, A Faisal, CS Ong. Mathematics for Machine Learning. 2021. </u>

[Link]()

[Sections 1.1, 2.1-2.2, 3.1, 5.1, 8.1, 9.1]

<br>

---

### <u> I Goodfellow, Y Bengio, A Courville. Deep Learning. 2016. </u>

[Link]()

[Sections 5.1, 5.2, 5.4]

<br>

---

### <u> S Shalev-Shwartz, S Ben-David. Understanding machine learning: from theory to algorithms. 2014. </u>

[Link]()

[Chapters 1, 2, 5]

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

Start with a feature and define a split (or category)

Two leaf nodes come off of the tree

It is possible that one, or both of the leaves, cleanly splits the data

That is, the subset only has one class in it

If only 1 leaf that one class in it, that does not mean it completely seperates the data for that class. But it means that we do not need to keep splitting that subset of that leaf further

On the leaf(ves) are not determined then we select a feature again and specific another split, or constraint (=)

Once all the leaves result in a cleanly split leaf, we have a tree

Remeber, the point of creating any model is to be able to make inference with it. Inference is the ability to make a prediction on unseen/unlabelled data.

The training part of a DT is contructing the tree and its splits based on the training data. Testing is taking instances and putting them through the tree to find their label. 

#### Anatomy of DT 

split point/internal nodes is where the splitting logic is defined

end of the tree is called leaf nodes


#### DT 

DT works by repeatedly partioning the data space into 2

Each split point is defined by a hyperplane that sperates partitions in the data space

Leaf nodes represent labels for data insstances that share ther same label region

can be used for both classification and regression

We want a model whereby the parameters (splits) are optimized

#### Knowing When to Split

Recall we said that if a lead was completely part of 1 label then we didn't need ot split further

This is an absolute example but things dont have to be 100% to decide to spot splitting

In fact, only splitting at 100% points is an easy way to split to the trainining data

The decision to split further in DT is based on a metric calledf purity. 

Purity is the proportion of instances of the majority label.

3/3 = 1

3/5 = 0.67

Any purity less than 1 can be considered but can set the decider value as a parameter

#### Splitting Methodology
* sort the dataset by a feature
* compute the potential split points between each instance (if different values)
* evalute each split based on split criteron: info gain (related to entropy) or Gini Index. 

Both Info Gain and Gini Index are measures of disorder or uncertainty. If a space as a even mix of labels, then the space is more uncertain. A skewed space is more certain. Outcomes will be less suprising on average

#### Information Gain

How to chose the best split point using Info Gain:
* the uncertainty is measured based on the outcome of both the splits subregions
* info gain is a reduction in uncertainty (entropy) about the label for the patition
* the split point selected is the one with the highest info gain, i.e. the point with the least uncertainty.

$$Gain(m, m_{<s}, m_{>s}) = H_m - H_{m_{<s}/m_{>s}}$$

The weighted average entropy of the resulting child nodes is defined as:
$$H_{m_{<s}/m_{>s}} = \frac{n_{m_{<s}}}{n_m} H_{m_{<s}} + \frac{n_{m_{>s}}}{n_m} H_{m_{>s}}$$

The reason it is weight is because it needs to be normalized against volumne of data in the given split. If one child node contains 95% of the data and the other only 5%, the entropy of the larger group should "count" more toward the final score. $\frac{n_{m_{<s}}}{n_m}$ and $\frac{n_{m_{>s}}}{n_m}$ are the weights. By multiplying the entropy of each split by its relative size, you ensure the Gain reflects the improvement across the entire dataset. 

The entropy $H_m$ for a given node $m$ is calculated as:

$$\text{entropy } H_m = -\sum_{k=1}^{K} p(c_k|m) \log_2 p(c_k|m)$$

$p(c_k|m)$ can be computed form the data as $\frac{n_m_k}{n_m}$

We calculate 3 H (entropy), one for each split and another for the parent. Each entropy calculation use the data instances `k` that belong to that sub-region. 

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

Goal is to obtain some output automatically based on a input

With kNN there is no "model". You use the training data instances to find an output but there is no model or function derived. 

With kNN, you use the class of k nearest neighbours to the data point $x_i$ that you want to run inference on to find an output $\yhat{y_1}$. Use a subset of `k` nearest neigbours.

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


## Week N: Lecture Content

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