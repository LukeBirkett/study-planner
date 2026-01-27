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

































<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
--- 


#### Set New Venv

```
python -m venv [myenv]
source [myenv]/bin/activate
pip install ipykernel
python -m ipykernel install --user --name=[myenv]
pip install notebook
jupyter notebook
```

The Kernel is a Persistent Pointer. This means if you call all envs the same name (myenv) the kernel will always point to the most recently created kernel. This is why is it impact to give envs a unique name

```
pip install numpy
pip install matplotlib
pip install scikit-learn
```
```
jupyter kernelspec list
jupyter kernelspec uninstall myenv
```

```
touch my_script.py
```





[Common Pitfalls in Computer Vision & AI Projects](https://open.spotify.com/episode/3gATEskqys0M3ubtVvRulf?si=lyeP03qDT-KMXpMjiSczBA&nd=1&utm_medium=organic&product=open&%24full_url=https%3A%2F%2Fopen.spotify.com%2Fepisode%2F3gATEskqys0M3ubtVvRulf%3Fsi%3DlyeP03qDT-KMXpMjiSczBA&feature=organic&_branch_match_id=1439916255368734107&_branch_referrer=H4sIAAAAAAAAA72NywrCMBREvybd2WojLoQi9bWRgqiIO0nTmzY2JvEmUerCb7cK%2FoIwi2EOh2m8t26aJM4aL0UXM2tjJXWbzCyaKnCfGQs6IulYBKXOAVXWfBRCc5Ku%2B3xw%2FLO5ufYTWOlMBX2jdX5YufbWuWFBQ%2BmP911QgtC1k4QuVQfbIb0tD4NNcbLFRe75c55%2Fv5hSJePtP%2F5IOtFVT0eRAOYDQmawZlry6IUgAFHq%2BlyieTjAbNGgucIb4bFdyzUBAAA%3D)