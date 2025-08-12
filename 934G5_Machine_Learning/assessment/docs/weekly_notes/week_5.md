# Week 5 - Model Validation I

Contents: 
- Learning outcomes
- Lecture slides structure
- Lecture Notes
- Lab Notes
- Reading Notes

# Learning Outcomes
- things to consider before, for, and in collection of machine learning data;
- typical issues that need to be addressed in preparing input data and labels for machine learning.

# Slides Structure
- Data collection & annotation
- Data preparation & preprocessing
    - Data extraction
    - Input scaling
    - Missing data
    - Data augmentation
    - Label imbalance

# Lecture Notes
## Data collection & annotation
Summary:
- Understanding of the real world problem must come before anything else in ML conceptualization and development. 
- To be able to build a ML model, data collection and annotation is essential.
- It is critical to involve stakeholders all through the ML lifecycle.

## Data preparation & preprocessing
### Data extraction
Skip

###Input scaling
Scale based on the range of values to values between 0 and 1

To ensure that feature dimensions 𝑥𝑑 have similar range (or distribution) of values

Standard Scaling

Min-Max Scaling

### Missing data

Discard instances with missing data
- easiest to implement
- large loss of data if features missing for most data instances

Imputation – predicting likely values for missing data
- could be potential source of noise if performance poor
- impossible if most features are missing for a data instance

Surrogacy – learning to use whichever features available
- can improve robustness even when data is not missing
- performance can depend on importance of missing feature

Discard instances with missing labels
- large loss of data if labels missing for many data instances

Semi/Self-supervised training & transfer learning
- makes good use of all data available – now widely used
- self-supervised learning & transfer learning in Week 9

Unsupervised learning
- e.g. in anomaly detection – where anomaly is not well defined
- e.g. clustering

Another option is the set missing values to -1

Slides included an MMAE process to handle missing data. Maybe revisit this is assessment turns out to have lots of missing data

### Data augmentation

Data augmentation is the application random transformations to training data instances 
- to force a machine learning model to learn informative patterns that allow it to generalize
- rather than for it to simply memorize the training data, i.e. overfitting

With images this might include, rotating, shearing, translation, cropping

Some time augmentations include:

Jittering – adding noise randomly along the time dimension

Time warping – randomly changing the sampling rates of random subsegments along the time dimension

Time reversal – flipping temporal order

Jigsaw – randomly shuffling subsegments along the time dimension

Dropout – randomly masking time steps in the signal

### Label imbalance
Addressing imbalance for classification:

Undersample majority classes
- randomly select only a subset of the majority class rather than all

Oversample minority classes
- duplicate instances of minority classes as many times as needed to match the majority class in number

Oversample minority classes with data augmentation
- duplicate instances of minority classes & augment each instances of minority classes duplicated

Weights in the training loss
- penalize more for misclassification of a minority
- Weighted loss functions

Summary:
- Data is not usually available in a form that is ready to be used as input data. It may need to be extracted.
- Data needs to be scaled (i.e. normalized) before it is input to the model, for both training or testing.
- In the real world, there will be missing data and labels.
- Training data could be augmented to train a model to be robust to noise and variations.
- Label imbalance is inevitable in real world data.

# Lab Notes

No Lab

# Reading Notes

No Reading