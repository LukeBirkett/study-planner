# Lab 3, 4 & Assignment Prep

In the following sections are the pre-existing content related to lab 3 & 4 which is a precursor to the assessments. The primary focus is the paper by Robinson et al. (2014). This paper was orginally focused on in the Week 5 Seminar before being fed into Labs 3 & 4 in which a coded system of papers model is explored. The content of this file will make up the prelimiary knowledge and understand to build out the final assessment. This assessment does not have to be on Robinson's model, although it can be, but this lab work will likely help establish the building blocks for the paper - likely in conjection with another topic studied on the module.

This is the entire working file for the labs and papers. It contains: 
- File locations and links for all of the relevant and used material. 
- A breakdown and notes of the Robinson papers explored, particularly the main Robinson et al. (2011) paper
- Disemination of the lab briefs and content taken from canvas and put into my own words with any additional information and thoughts that were required to understand the direciton of the labs. 
- It has the results and analysis from the both of the labs including any extra work undertaken. It will also include written explanations of the code and direction on where certain functionalities are found in the code, e.g. what line. 


<br>
<br>

# Table of Contents
1. [Robinson's papers](#robinsons-papers)
    * [Simple Threshold Rule](#a-simple-threshold-rule-is-sufficient-to-explain-sophisticated-collective-decision-making-robinson-et-al-2011)
    * [How Collective Comparisons Emerge](#how-collective-comparisons-emerge-without-individual-comparisons-of-the-options-robinson-et-al-2014)
    * [Do Ants Make Direct Comparisons](#do-ants-make-direct-comparisons)
2. [Canvas Resources](#canvas-resources)
3. [Lab 3: Monte Carlo simulation of collective behaviour](#lab-3-monte-carlo-simulation-of-collective-behaviour)

<br>
<br>

# Robinson's papers:
### [A Simple Threshold Rule Is Sufficient to Explain Sophisticated Collective Decision-Making (Robinson et al. 2011)](weeks/labs/IAM_Sussex_labs/lab_3_robinson/papers/a_simple_threshold_rule.pdf)
---

[Paper's supplementary info](weeks/labs/IAM_Sussex_labs/lab_3_robinson/papers/threshold_supplmentary.pdf)

Notes and resources

---

### [How collective comparisons emerge without individual comparisons of the options (Robinson et al. 2014)](weeks/labs/IAM_Sussex_labs/lab_3_robinson/papers/collective_comparisons_without_individual_comparisons.pdf)

---

### [Do Ants Make Direct Comparisons](weeks/labs/IAM_Sussex_labs/lab_3_robinson/papers/do_ants_make_direct_comparisons.pdf)

Notes and resources

---


<br>
<br>

# Canvas Resources:

#### [Week 5 Seminar Robinson](IAM_week5_seminar.pdf)
This is the 'lecture' slides followed for the original seminar session on the main Robinson paper: "A Simple Threshold Rule". For this session we read the paper before hand, listened to a lecture given by Maxine which followed these slides and broke out in a small group discussions.

#### [Lab 3: Lab Page](https://canvas.sussex.ac.uk/courses/34991/pages/lab-3-monte-carlo-simulation-of-collective-behaviour)

This is the first lab session working with the Robinson model. The goal is of this session was to introduce us to working with scilla setup of a real biological system. We were working with a Monte Carlo style model whereby simulation sample from given distributions. The lab was a chance to play with and test the various parameters and to try to understand how and why the system behaves as it does. We had the ability to look at individual ants behaviour to understand how the aggregate/collective outcomes occur. The link to this page is to the canvas page itself but the brief and information has been diseminated out into `lab_notes.md` under the Lab 3 section. 

#### [Lab 3 Code Slides](IAM_lab_3.pdf)

This is some sort of lab accompaniment. It goes through bits of the code in more detail. I haven't gone through this properly yet. 

#### [Lab 3 Additonal Details](https://canvas.sussex.ac.uk/courses/34991/pages/lab-3-additional-details)

Aimed at helping you to understand how the Python simulation of Robinson et al.'s model corresponds to the model itself.

#### [Canvas Lab 4: Guided Notes](https://canvas.sussex.ac.uk/courses/34991/pages/lab-4-guided-tasks)

TODO: Work through and explain `Lab 4`

#### [Lab Code](weeks/labs/IAM_Sussex_labs/lab_3_robinson)

This is the location of the code repository used for labs 3 and 4.

<br>
<br>

# Lab 3: Monte Carlo simulation of collective behaviour

Lab 3 goes through the code which will be the same code for the assessment. The tasks explored may be used for assignment topics.

[Lab PDF](weeks/labs/IAM_Sussex_labs/lab_3_robinson/files/IAM_lab_3.pdf) |
[Lab Additonal Page](https://canvas.sussex.ac.uk/courses/34991/pages/lab-3-additional-details)

---
1. [Introduction](#lab-introduction)
    * [Code Origins](#origins-of-the-code)
---
2. [Setting Up and Code Outputs](#setting-up-and-outputs)
    * [A Single Ants Route](#a-single-ants-route)
    * [N Ants Summary Graphic](#n-ants-summary-graphic)
    * [Excel Dump](#excel-dump)
---
3. [The Model](#the-model)
    * [Searching Nests](#1-searching-nests)
      * [Model Schematics](#model-schematics)
      * [Model Parameters](#model-parameters)
      * [Assessment Error](#assessment-error)
    * [Moving Around](#2-moving-around)
---
4. [Tasks](#tasks)
    * [1. Running the Model](#1-running-the-model)
    * [2. Changing Parameters](#2-changing-parameters)
    * [3. Ants Sensing](#3-ants-sensing)
    * [4. Changing the Environment](#4-changing-the-environment)
    * [5. Parameter Sweep](#5-parameter-sweep)
---

<br>

# Lab Introduction

The purpose of this lab is to get an introduction into Biological Modelling. We can explore whether an experiements outcomes can be explained using the threshold rule as introduced by Robinson et al. (2011). Another purpose is to gain a technical understanding on how to use Monte-Carlo modelling. We will begin testing models and explore how results varying with respect to changes in different parameters, i.e. parameter sensitivity. This style of modelling can be used in our assignment so extending an investigation from the lab may form the basis of project.

Overall, we want to investigate how a model is implementing. If it meets out expecations and is plausible. We may choose to remove elements or add more capabilities. The idea is probe and stress test the assumptions and investigate results to seem odd and to not follow intuition. The correct methodology to be able to explain why a certain piece of information occurs after a parameter change occurs. The code provides us a tool to look at ant behaviour. It is our job to explain the aggregate behaviours and how many parameter changes relate to such. 

### Origins of the Code

Robinson et al. included MATLAB code for simulating their module in the supplementary information for their paper. The lecturer updated their code for use on this module, making two important additions:

- Added a limit to the number of steps the simulation will run for. This precludes the possibility of the simulation loop continuing to run indefinitely in the case where an ant does not select a nest site.
- For students' convenience, he added code to save simulation data to an Excel file, to make analysis easier.
- Adapted from MATLAB to Python

## Setting Up and Outputs

- Execute the file by running `ExampleUsingRobinsonCode.py`
- This file imports files `RobinsonCode`, `PlotSummaryDataRobinson` and `OutputRobinsonDataExcel`
- `RobinsonCode` contains the main functions for the system
- `ExampleUsingRobinsonCode` sets the parameters for the experiement
- `PlotSummaryDataRobinson` and `OutputRobinsonDataExcel` allow us to capture, present and summarizes the outputs of the experiment.
- `enter` to iterate through steps within a simualtion
- `1` to complete an ants route
- `0` to complete all ants and skip to the summary graphic

There will be 3 outputs. A graphical output of a single ants route. A graphic representation of the cumulative decision of all ants. And an excel dump of raw data as per each ants run. 

### A Single Ants Route

The programme iteratively plays through an ants journey. You can press `enter` to follow it through or `1` to complete the whole route at once. For each single ants run, it is allocated a `threshold` value which remains fixed for the duration of the run. The number of `steps` is recorded for each iteration and well as the cumuliative `time`. 

The chance of leaving the current nest and arriving at another is pre-determined given the `probs` matrix. Additionally, the time it takes to get between the given nests is also pre-determined in the `time_means`.

```
14 # these parameters are for the first experiment
15 #
16 # probabilities of visiting each site from each other
17 probs = np.array([[0.91, 0.15, 0.03], [0.06, 0.8, 0.06], [0.03, 0.05, 0.91]])
```

```
 19 # mean time to get between each nest
 20 time_means = np.array([[1, 36, 143], [36, 1, 116], [143, 116, 1]])
 21 # standard deviation of time to get between each nest
 22 time_stddevs = time_means / 5
```

When the ant does arrive at a new nest, a `Perceived quality` is computed and recorded. It does this by drawing from a distribution (i think this is set as normal). Each nest it pre-assigned a mean quality in `quals` and has a standard deviation assigned to it, which in the default run is `1` for all nests but this can be changed. 

Given the default structure of `probs` an ant generally stays at a nest for several steps. At each step it draws from the distribution meaning it ranks the nest slightly different each time. Even if several assessments have already been under the `threshold`, one sample may be over and the nest will be `SELECTED`

```
 24 # mean quality of each nest. Note home is -infinity so it never gets picked
 25 quals = np.array([-np.inf, 4, 6])
 26 
 27 # standard deviation of quality: essentially this controls
 28 # how variable the ants assessment of each nest is. This is currently set
 29 # as in the 1st experiment where the variability is the same for each nest
 30 qual_stddev = np.array([1, 1, 1])
 31 # However, if you want to change is so nests perceived w different accuracy
 32 # you could do eg qual_stddev = [1, 1, 4]
```

When an ant is not at `site 1` or `site 2` the ant will be at `site 0`, I am not yet clear if this means that the ant has returned to the original site or if it means that the ant is just travelling somewhere in the land. Either way, these `site_0` occurances do not record a quality and just rank as `-INF`

If the `quality` does not exceed the `threshold` then the graphic and programme will record `NOT SELECTED` and/if it does exceed then it will record `SELECTED`

<p align="center">
  <img src="screenshots/single_ant_route.png" alt="Ant Route Image" width="50%" />
</p>

### N Ants Summary Graphic

Pressing `0` when starting a simulation will skip to the summary graphic for the number of ants `n`

```
34 # set the number of ants
35 n = 27
```

The plotting functions from the file `PlotSummaryDataRobinson.py` and are imported into `ExampleUsingRobinsonCode.py`. It captures `current_time, accepts, discovers, visits, Ants` variables which are derived by running the main `rc.RobinsonCode`

The graphic itself has 4 sub-plots:

- Final Site counter. This has number of ants on the y-axis and site number on the x-axis.
- Time till final decision. This also has number of ants on the y-axis but cumaltive time taken till `SELECTED` decision on the x-axis
- Mean Site Discovery time. This has mean time on the y-axis and site number on the x-axis.
- Mean Number of Visits. This has mean counts on the y-axis and site number on the x-axis.

<p align="center">
  <img src="screenshots/summary_ant_routes.png" alt="Summary Image" width="50%"/>
</p>

### Excel Dump

The Excel Dump provides a granular but raw breakdown of each ants (rows) path, sites and times broken down into steps (columns). It has no assesment quality related data but does hold the threshold allocated to each ants simulation. Each row relates to a different ants simulation and the columns are a mix of outcomes, aggregrate metric and at the end a column break down of each step taken and where the ant was. For this final section, the number of columns of variable for each row and depends on the route the ant took. 

<p align="center">
  <img src="screenshots/routes_excel_dump.png" alt="Excel Output" width="100%" />
</p>

<br>

---
| Column Name | Column Description |
| :--- | :--- |
| Ant/Row Number         | Just a row label for the order of simulations |
| Threshold              | The quality threshold assigned to the ant at the start of the simulation |
| Final Site             | This is the final site that the ant selected |
| Selected               | This appears to be a binary marker to say if a nest was selected. All simulation in my default example were `1` implying that a nest was selected but maybe there are some instants where it doesn't select a nest |
| end time               | Looks to be the cumulative time take to find a nest |
| time site 0 discovered | Entry values are all `-1` for the default run, I assume this is because it is the starts here |
| time site 1 discovered | The cumulative time it took to discover `site 1`. It can be zero meaning the site was never visited |
| time site 2 discovered | The cumulative time it took to discover `site 2`. It can be zero meaning the site was never visited  |
| visits to site 0       | Count of visits to `site 0`. It correlates to counting the number of `0` entries in the `Path` array. Again not sure if the mid array `0` means `site 0` or travelling |
| visits to site 1       | Count of visits to `site 1`. |
| visits to site 2       | Count of visits to `site 2`. |
| Path           | This is the final named column but has trailing columns with no header. It represents an array of the route that an ant took. Each column is a time step and the value within the cell is the site that an ant is currently at. In the default run, each array starts at 0 but can also revert back to being 0 after site 1 or 2 have been reached. It's not clear to me whether these subsequent 0 vists mean the ant has returned back to site 0 or it means that the ant is travelling somewhere in the environment. |
---

<br>

## The Model 

### 1. Searching Nests

The premise of Robinson et al is to model how ants find new nests after the old one is damanged. In the model, individual ats do not interact with each other, they are simulated individually. Ant assess the sites they arrive at, derividing a quality metric which they then compare against a pre-determined acceptance threshold. If it exceed then they stay in the nest, otherwise they continue searching. The original nest `0` cannot be settled upon, the mechanism to enforce if to to programme the quality of the nest as `-INF`. 

##### Model Schematics

- Arrive at and assess a nest
- If the assessed quality $(b_i)$ plus some assessment error $(\varepsilon)$ is less than the threshold $a$ then reject the nest: $b_i + \varepsilon \le a$
- If the assessed quality $(b_i)$ plus some assessment error $(\varepsilon)$ is more than the threshold $a$ then reject the nest: $b_i + \varepsilon > a$

#### Model Parameters

The model params are the key tool to affect ants' decisions. In the default example run, the mean of the acceptance threshold is set specificly (hardcoded) as the middle value of the two sites. But this experiement doesn't need to be run this way. All params can be changed. In fact, it may be quite a poor assumption to encode into to the system. It implies that an ants thresholding mechanism has a somewhat accurate grasp of the nests it expects to encounter and is "happy" with something in the middle. I think we would often except biological creatures to rationally wish to maximise their comfort, particularly for their homes, based on some preconceived personal notion of quality - though it would be true that this also would have to be relational to the environment it lives in. Additionally, I would also expect some sort of fall back mechanism that entails something like "the best of a bad bunch" whereby a local, assecible selection is of lower quality than the overall global average quality.

<br>

---
| Parameter Name | Parameter Sign | Values | Line Set |
| :--- | :--- | :--- | :--- |
| Acceptance Threshold | $a$             | Normal Distribution; `mean = 5`, `sd = 1`   | `threshold_mean`=`line 38`, `threshold_stddev`=`line 39` |
| Nest Qualities       | $b$             | `site_0 = -inf`, `site_1 = 4`, `site_2 = 6` | `line 25`, `quals` |
| Assessment Error     | $(\varepsilon)$ | Normal Distribution; `mean = 0`, `sd = 1`   | `line 30`, `qual_stddev`, this can be set different for each nest |
---

<br>

#### Assessment Error

This humans and all other creatures, the ability to assess something is not a perfectly mapped deterministic process. Our decision making processes can be heavily influced by other factors. In this system, this is captured using the assessment error $(\varepsilon)$. Every decision made is impacted by an the assessment error. This error is drawn from a Normal Distribution and the Standard Deviation is set for each site, though the default values are 1 for all. It should be noted that the probability of an ant select a nest is function of two distributions; The distribution to draw the overall acceptance threshold and the distribution to draw each steps assessment error.

<br>

### 2. Moving Around

An environment is set up that resembles a rectangle with dimensions 18cm x 180cm (long and thin). 

<br>

<p align="center">
  <img src="screenshots/rect_env.png" alt="Env Nest" width="100%" />
</p>

<br>

Within this space, subspaces are allocated which respresent nests. A matrix is setup/computed that maps the probabilities of travelling between nests. The columns represent the starting nest and the rows the destination nest. Each column will sum to 1 as it represents all travel options. The highest probability will always be the current nest, no journey, this is because the ants stay in one place for a period and assessment mutliple times. Embedded into the probabilities is the notion that nests further away are less likely to be visited. Though this is an assumpt as IRL obstacles may block nearer nests making the travel time longer. The probabilites are fixed and hardcoded on `line 17`, `probs`

<br>

---
| | Old | A | B |
| :--- | :---: | :---: | :---: |
| Old | 0.91 | 0.15 | 0.03 |
| A | 0.06 | 0.80 | 0.06 |
| B | 0.03 | 0.05 | 0.91 |
---

<br>

In additional to this, there is a mean travel time matrix. This too is a hardcoded matrix set on `line 20`, `time_means`. The difference is that these values represent a mean to be samples from and is actually re-calculated and different for every trip. On `line 22`, `time_stddevs` computes this variability. 

<br>

---
| | Old | A | B |
| :--- | :---: | :---: | :---: |
| Old  | 1   | 36  | 143 |
| A    | 36  | 1   | 116 |
| B    | 143 | 116 | 1   |
---

<br>

# Tasks

### 1. Running the Model

Start by running the model, seeing how it works, and seeing if you can replicate the behaviour seen in the paper

<br>

---

### 2. Changing Parameters

You can then see how the behaviour of the model changes when you change parameters. An obvious starting point is the value of thresholds vs the qualities of the nest: Can you generate ‘odd’ results or even ‘break’ the model? How much can you change parameters until the behaviour changes (sensitivity analysis)?

As noted, the key is to look at both the behaviour of individual ants and the aggregate results so you can explain why the change you made gives rise to the behaviour you see. You can then decide if this is an issue for the model

<br>

---

### 3. Ants Sensing

You could instead investigate the sensing of the ants: For the Robinson paper, a starting point is how variable/uncertain the ants quality judgments are. What if they are more uncertain (noisy) than the original model assumes? How much can you change this factor until the model breaks (sensitivity analysis again)?

<br>

---

### 4. Changing the Environment

A final idea is to see what happens in other experimental situations eg changing the number/arrangement etc of nests. The m-file ExampleUsingRobinsonCode4Nests.m shows how you would set up the 4-nest example they use

<br>

---

### 5. Parameter Sweep

Like the earlier MATLAB implementations, ExampleUsingRobinsonCode.py is a script, which runs the simulation once for a given number of ants. If we want to run a parameter sweep (e.g. for sensitivity analysis), we need a way to automate running the simulation multiple times with different parameters. I have given an example of how to do this in ExampleUsingRobinsonCode_func.py, where the script has been turned into a function, which takes one parameter and returns one of the values which result from running the simulation - more parameters and returns could easily be added to do something more useful. param_sweep_test.py shows how to call the function from ExampleUsingRobinsonCode_func.py to conduct a simple parameter sweep.

<br>

---