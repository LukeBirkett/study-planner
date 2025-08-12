# Week 6 - Model Validation II

Contents: 
- Learning outcomes
- Lecture slides structure
- Lecture Notes
- Lab Notes
- Reading Notes

# Learning Outcomes
- principal component analysis and its use in dimensionality reduction; 
- evaluation methods and metrics.

# Slides Structure
- Dimensionality reduction
- Evaluation metrics
- Evaluation strategies

# Lecture Notes
## Dimension Reduction
Dimension selection and feature extraction based on domain knowledge i.e. feature engineering (aka hand-crafting of features)

Exhaustive comparison of different combinations of features. Effective for hand-crafted features, but not efficient

Representation/feature learning – Week 9 based on self-supervised learning & transfer learning

Other methods e.g. via principal component analysis (PCA)

Summary: 
- There may be cause to minimize the dimensionality of input data. 
- Feature engineering, feature learning, feature subset selection, and PCA are relevant approaches.

## Evaluation metrics
Accuracy is proportion of correct classifications

Confusion matrix is a matrix representation of classification performance showing confusions that the classifier has in recognizing classes.

Precision, Recall, F1 score

Precision – proportion of a given predicted class that are correctly classified

Recall – proportion of a true class that are correctly classified

Precision & Recall are usually conflicting goals, yet the aim is to optimize both at the same time

F1 score captures the ‘harmonic mean’ (i.e. balance) between them

Receiver operating characteristic (ROC) curve is a plot of TPR versus FPR

Decision boundary for binary classification

Correlation metrics – can be useful for understanding consistency for ordinal classification or for regression, e.g. Intraclass correlation, Spearman’s correlation

Specialist metrics – e.g. Intersection-over-union (used in image segmentation), Perplexity (used in natural language processing)

Common regression metrics – Mean squared error, Mean absolute error

Summary:
- There are a variety of metrics available to evaluate the performance of a model.
- It is important to consider the most appropriate metric(s) to use/report for any given purpose.
- It is hardly ever sufficient to only consider accuracy for classification tasks.

## Evaluation strategies

Training set – Portion of available data used for training your model

Test set – Portion of available data held out (i.e. set aside) for evaluating the performance of the trained model

Hold-out validation
80:20 split for hold-out validation

Issues with splitting = biased split

Alternative: 𝑘-fold cross-validation. Only have a train and test split. Training split doubles up as validation through folds

𝒌 = 𝑵, the total number of data instances available, is the gold standard value for k-fold crossvalidation

This is equivalent to leaving out one data instance in each fold, so it’s called leave-one-out crossvalidation (LOOCV).

Advantage 
- Robust validation strategy 
- Maximises the size of the training set in each fold 

Disadvantage
- O(n) time complexity – often impractical for 𝑁 > 10

Typically 𝑘 = 10 is used

Reporting metrics for cross-validation

Option 1
- Compute the metric per fold
- Then, report the mean and standard deviation across folds (not applicable to confusion matrices)

Option 2
- Combine all the test labels and predictions across folds
- Then, compute the metric once

Training set – Portion of available data used for training your model

Test set – Portion of available data held out (i.e. set aside) for evaluating the performance of the trained model

Validation set – Additional portion of available data held out for optimizing model hyperparameters

𝐶 options to search through for the best, via gridsearch optimization

For each 𝐶:
- train with training set
- evaluate with validation set

Chose the best C 

Evaluate on test set

Early stopping. Test all epochs on validation sets. Record best model. Best model is used on test.

Summary: 
- Evaluation or validation strategies can be either cross-validation or hold-out validation, where the latter is a special case of cross-validation.
- Cross-validation could be k-fold or the split could be based on some grouping variable.
- In each fold of validation, data must be split into three – training, test, and validation sets.


# Lab Notes
No Lab

# Reading Notes
No Reading