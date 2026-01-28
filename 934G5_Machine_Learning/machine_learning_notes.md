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

What is Machine Learning [[Video](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=1515091f-1947-45ba-ba34-b31e00f85cfe), [Slides]()]


A Simple ML Model [[Video](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=6067ee21-c700-437b-96d3-b31e01278a97), [Slides]()]


## Week 1: Lecture Content

**<u>Resources:</u>** [Lecture Slides]() | [Lecture Recording]() | [Discussion Slides]() | [Discussion Padlet]()

**Week 1 discussion questions:**
* What is the value of machine learning? 
* What could be the expressions of weak learning by a linear regression model?
* What could be expressions of memorizing by a linear regression model? 
* How could the basic linear model be adapted for categorical labels?



**Rough Lecture Notes:**

[MODULE LEARNING OUTCOMES]

[syllabus]

discussion section:

recap of mini videos

learning outcomes, 2 questions to focus on during the discussion

How could the basic linear model be adapted for categorical labels

What could be expressions of weak learning or memorizing in a lin reg model? and in what ways could memorzing be prevented?


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

Binary Cross-Entropy (BCE)

$$J(\theta) = -\frac{1}{m} \sum_{i=1}^{m} \left[ y^{(i)} \log(h_\theta(x^{(i)})) + (1 - y^{(i)}) \log(1 - h_\theta(x^{(i)})) \right]$$

* $J(\theta)$: The total cost (average error).
* $m$: The number of training examples.
* $h_\theta(x^{(i)})$: The model's prediction (probability) for the $i^{th}$ example.
* $y^{(i)}$: The actual ground truth label (either 0 or 1) for the $i^{th}$ example.
* $\sum_{i=1}^{m}$: The summation symbol, indicating we are adding up the loss for every single data point before averaging.

1. The "Switch" MechanismIn binary classification, $y$ can only be 0 or 1. Because of this, the equation is designed so that only one half is ever "active" at a time:
* If $y = 1$: The right side $(1-1) \cdot \log(\dots)$ becomes zero. You are left with: $- \log(h_\theta(x))$.
* If $y = 0$: The left side $-0 \cdot \log(\dots)$ becomes zero. You are left with: $- \log(1 - h_\theta(x))$.

2. Why the Logarithm? 

The log function is used to punish confidence when it's wrong. Since $h_\theta(x)$ (our prediction) is always a probability between 0 and 1:

Case A: The actual label is $y = 1$If the model predicts $h_\theta(x) = 1$ (Correct!), the cost is $-\log(1) = 0$. No penalty.If the model predicts $h_\theta(x) = 0.1$ (Confident but wrong), the cost is $-\log(0.1)$, which is a high positive value.As the prediction approaches 0, the cost approaches infinity.

Case B: The actual label is $y = 0$If the model predicts $h_\theta(x) = 0$ (Correct!), the cost is $-\log(1-0) = 0$.If the model predicts $h_\theta(x) = 0.9$ (Confident but wrong), the cost is $-\log(1-0.9)$, which is a high penalty.

3. The Intuition Summary
We use this specific shape because we want a convex cost function.

In simple terms: if the model is slightly wrong, we give it a small nudge. If it is "confident" in its wrongness (e.g., predicting 99% probability for "Yes" when the answer is "No"), we hit it with a massive penalty. This forces the model to move its parameters much faster to fix that error.

4. Minus 

You'll notice the negative sign at the very front. This is because $\log(p)$ for any probability $p$ between 0 and 1 is always negative. Without that leading negative sign, our "cost" would be a negative number. By flipping it, we ensure that a better model has a cost closer to 0, and a worse model has a cost that grows toward infinity.

--- 

Not MSE, why not? because lin reg creates a local minima (explain this better)

While it technically could work, it's a terrible choice for two main reasons: Optimization (The Shape) and Learning Speed (The Gradient).

In Linear Regression, the prediction is a straight line $h_\theta(x) = \theta^T x$. When you square the error of a line, you get a nice, bowl-shaped "convex" function.

However, in Logistic Regression, we wrap that line in the Sigmoid function:

$$h_\theta(x) = \sigma(\theta^T x) = \frac{1}{1 + e^{-\theta^T x}}$$

If you plug this S-curve into the MSE formula $(h_\theta(x) - y)^2$, the math gets messy. The resulting cost function surface is non-convex. It looks less like a smooth bowl and more like a mountain range with many "false bottoms" (local minima). [INCLUDE SOME VISUAL INT OF THIS]

If you start Gradient Descent on a non-convex surface, your model might get "stuck" in a local valley that isn't the absolute lowest point. You’ll end up with a model that performs poorly, and you won't know if it's the best the model can do.

2. The "Saturated" Neuron (Vanishing Gradients)This is the more subtle, "physical" reason MSE fails.The Sigmoid function $(\sigma)$ is very flat at the ends (near 0 and 1). When the model is very wrong—for example, predicting $0.99$ when the actual value is $0$—the slope (gradient) of the Sigmoid curve at that point is almost zero.

* With MSE: The math causes the gradient to be multiplied by the slope of the Sigmoid. If the slope is nearly zero, the gradient becomes nearly zero. The model "stops learning" because the steps it takes are too tiny to matter.
* With Log Loss: The math of the logarithm specifically cancels out the flat part of the Sigmoid.

---

### gradient extra

The Result: A "Self-Correcting" SlopeWhen you combine these three, you get a beautiful convex shape. No matter where your model starts—even if its initial guesses are completely random or wildly wrong—the "Switch, Log, and Minus" creates a clear, downward path toward the best possible version of your model.Wait, check this out:The coolest part is that when you take the derivative of this whole mess to actually update your weights (using Gradient Descent), the "Log" and the "Sigmoid" math actually cancel each other out almost perfectly.The final update rule ends up being incredibly simple:$$\text{Update} \propto (h_\theta(x) - y) \cdot x$$It basically says: "Move the weights by the size of the error." It’s poetic that such a complex-looking function simplifies into something so intuitive.

---

### summary intuition 

1. The Switch (y and 1-y)This is the logic gate. Since $y$ is always a $0$ or a $1$, it acts like an "on/off" toggle.It ensures the model is only judged against the correct target.It prevents the two cases (predicting a 0 vs. predicting a 1) from interfering with each other mathematically.

2. The Log (The Penalty Scale)This is the intensity. Linear error (like in MSE) is too "nice" to big mistakes.If you are 90% sure of the wrong answer, the log function doesn't just say "you're wrong"; it blows up the cost exponentially.This creates a steep "slope" that pulls the model's weights toward the correct answer much faster than a simple subtraction would.

3. The Minus (The Direction)This is the orientation.Logarithms of fractions (probabilities) are always negative.Since we want to minimize "cost," we need the cost to be a positive number where 0 is the perfect score. The minus sign flips the graph so that a perfect prediction equals zero cost.The Result: A "Self-Correcting" SlopeWhen you combine these three, you get a beautiful convex shape. No matter where your model starts—even if its initial guesses are completely random or wildly wrong—the "Switch, Log, and Minus" creates a clear, downward path toward the best possible version of your model.



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



## Week 1: Lab Content

**<u>Resources:</u>** [Notebook 1]() | [Notebook 1 Solutions]()

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
