# Machine Learning Notes (Spring 26)

This is the main file for the Machine Learning module taken in Spring 26. It will act as the location for note taking accross all mediums, i.e. lectures, videos, labs and additional readings, as well as a directory for file locations. It will recorded chronologically with a section for each week. 

# Table of Contents
1. [Week 1 - Introduction](#week-1---introduction)


<br>
<br>
<br>
<br>
<br>
<br>







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


<br>

### A Simple ML Model 
Mini-Lecture Resources: [Video](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=6067ee21-c700-437b-96d3-b31e01278a97) | [Slides](files/week_1/week_1_prerecorded_a_simple_ML_model.pdf)


<br>

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
