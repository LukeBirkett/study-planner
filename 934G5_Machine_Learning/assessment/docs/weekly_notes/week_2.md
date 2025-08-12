# Week 2 - Supervised Learning I

Contents: 
- Learning outcomes
- Lecture slides structure
- Lecture Notes
- Lab Notes
- Reading Notes

# Learning Outcomes
- Learned the basic theory behind decision tree, ensemble learning algorithms, and k-nearest neighbours.
- Explored these algorithms in practice.

# Slides Structure
- Decision trees
- Ensemble learning
- k-Nearest neighbours

# Lecture Notes
## Decision Trees
Partitions data recursively based on binary tree structure

Each split point is defined hyperplane that separates partitions in the data space

Leaf nodes represent labels for data instances which share the same label region

Can be used for both classification and regression

Decisions on where to make splits is based on a metric called purity to identify the maximally optimal split.

Deciding whether to further split a node is based on a metric called purity. This looks at the distribution of label called in a node. If a node is full or nearly full with just 1 class then the purity will be high (close to 1) and no need for an additional split from the node. 
If splitting, the optimal split point is determined by a split criterion. Typically Information gain or  Gini index

**Entrophy**

Entropy is a measure of disorder or uncertainty.

Split criterion can be based on entropy

Information gain uses entropy

Split with the highest reduction in uncertainty about the label is chosen for the partition region

Gini index is another measure of disorder

Many nodes in a tree can cause overfitting

Pruning is a strategy to reduce overfitting by removing nodes

A criterion is used to decide which nodes to prune

Decision Tree Summary:
- Recursive partitioning of a data region until each single partition has one common label is the decision tree algorithm.
- Partitioning involves determining, based on purity, if further partitioning is needed & if needed, selecting a split point based on a split criterion.
- Decision trees are susceptible to overfitting. This can be addressed with pruning.

## Ensemble learning

A community model made up of many models

**Bagging - Bootstrap Aggregating**

Bootstrap = model trained on only a subset of the data
Aggregate = community of models prediction

Averaging of multiple functions helps to capture complexity

Robust to overfitting as each sub-model does not have access to the full dataset

**Boosting**

Multiple base models are trained. Data with worse performance is weighted higher in the next training iteration. Prediction is a weighting of the community of models

Bagging and boosting is generally used for decision tree models but could be used for anything technically

Ensemble summary:
- Multiple partially optimal models can be aggregated in ensemble learning.
- Two common ensemble learning methods are bagging and boosting.

## k-Nearest neighbours

With kNN, you use the class(es) of k nearest neighbours of 𝒙𝑗 to determine its output

No explicit model is trained or defined

kNN has a few different distance metrics including cosine similarity

The inference time complexity for kNN is 𝑂 𝑁2𝐷

N for the total number of data instances
D for the total number of features

Indexing and tree based methods can be used to minimize time complexity

kNN Summary: 
- Unlike the typical regression or classification algorithm based on the basic linear model, k-nearest neighbours does not involve optimisation of a model.
- The kNN has three main hyperparameters: the number of neighbours k, the distance metric, and the voting strategy.
- Time complexity at inference time is a significant issue with brute force search in kNN.

# Lab Notes

The notebook starts by splitting the dataset into test and train using a seeded random number
Generator

Next the notebook trains a KNN Classifier from the Sklearn package and plots the predictions in
Matplotlib.

The plots show the predicted categories via colours and are plotted against two parameters on
the axis. Incorrect predictions are plotted with an x

For KNNs the hyperparameters are the distance metric and the k number of neighbours. The
notebook explores

The notebook highlights that is is important to experiment with the hyperparameters to fit the
dataset in use and optimize them

Next the notebook trains a decision tree using the BaggingClassifier and experiments with
number of tree, again a hyperparameter

Finally the notebook discusses the train and test split. The notebook ran on a 50:50 split but
80:20 would be better as this gives us more training data.

The split used will be conditional on the amount of data available

# Reading Notes

S Rogers, M Girolami. A first course in machine learning. 2017. [Section 5.3.1]

J Zaki, W Meira. Data Mining and Machine Learning. 2020. [Sections 18.3, 19]

L Breiman. Bagging predictors. Machine learning, 24, pp. 123-140. 1996.

L Breiman. Random forests. Machine learning, 45, pp. 5-32. 2001.

Y Freund, R Schapire. Experiments with a new boosting algorithm. 1996

S Shalev-Shwartz, S Ben-David. Understanding machine learning: from theory to algorithms. 2014. [Chapters 10, 19]

C Bishop. Pattern recognition and machine learning. 2006. [Sections 14.2-14.4]

## S Rogers, M Girolami. A first course in machine learning. 2017

Notes about kNNs

Can handle single and mutliclass problems

No assumptions about parametric form of decision boundary 

KNN has no training phase

Has hyperparameter k = number of neighbours which needs to be determined

Label is based on majority of neighbours 

Has issue of tired voting so odd k numbers are required

Can also weight the neighbours so closer = more significant in decision

The size of K is important

If too small it will create clusters of islands which are independent and will result in overfitting

Upto a point, K has a regularizing impact which helps with generalization. But too far will result in go good fit to the data and underfitting will occur

K-cross validation is the most popular method for choosing K

Metrics used look at the proportion of misclassifications

10 K-cross fold validation, repeated 100 times. Plot the error result for each K, Select the minima

10 fold = train on 9 folds, validate on 1 to count the errors

Repeat by cycling through the hold out segments

## J Zaki, W Meira. Data Mining and Machine Learning. 2020.
### KNN
KNN is a non-parametric approach

This means it does not make any assumptions about the underlying data

A parametric approach assumes the that data follows a specific probability distribution, i.e. normal

These methods try to estimate parameters of that distribution to make a prediction, i.e. mean and standard deviation

Non-parametric does not do this

It uses the data itself to make predictions without trying to fit to a predefined model

KNN prediction works by locating known neigbours in the training data compared to an unseen point

There is no equation or function to describe

If you loose the data, you loose the ability to predict

This is compared to lin regression which can be performed with only the equation

The lack of underlying assumptions allowed KNN to fit to complex data but also opens up the risk of overfitting

Notation can have an application of bayes in the context of classification

Lots of KNN notation given in this chapter

## C Bishop. Pattern recognition and machine learning. 2006.

14.5.3 Mixtures of experts

Poised as an extension of community models and boosting

Has a series of gating functions that lead to certain models which are given as experts of their area
