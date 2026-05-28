# Proposed Academic Structure

## 1. Introduction
This section establishes the landscape, the research gap, and your specific objective.

### 1.1 Context & Motivation
*[Data Applied to Football], [Network Science Introduction], [Why Apply Network Science to Football]*

The surge of data analytics in sports and the introduction of graph theory as a lens for spatial-temporal games.

### 1.2 Problem Statement
*[Problem with Current Approach to Data and Football]*

Why traditional "event-counting" metrics (e.g., total passes, xG) fail to capture the structural dependencies and systemic nature of football tactics.

### 1.3 Research Aims & Objectives
*[Research Aims], [State the Goal of This Report]*

Clearly define the core question: How can network science and null modeling expose non-trivial tactical structures?

---

## 2. Literature Review
This positions your work within existing academic research.

## 2.1 Network Science in Sports Analytics
*[Networks Applied to Other Sports], [How Network Science Applied to Football]*

Reviewing how graph theory has been used in basketball, hockey, and previous iterations of football "passing maps".

---

## 3. Methodology & Dataset Documentation
The technical blueprint. This fulfills your "Dataset Card" requirement if you are curating data.

### 3.1 Data Source and Preprocessing
*[Data Source: Statsbomb], [Interactions Types (Edges)]*

Formal description of the StatsBomb event data, coordinate system, and edge definitions (e.g., event filtering criteria).

### 3.2 The PassMap Framework
*[PassMap Framework], [Network Properties and Football Interpretation]*

Define the mathematical formulation of your graph (Directed, Weighted Multigraph $G = (V, E, W)$). Define how standard metrics (Degree, Clustering, Centrality) map onto footballing concepts.

---

## 4. Analytical Framework: Null Models in Football
This is the core "Experimental Phase" of your Master's project. Separating it into its own major section highlights its academic weight.

### 4.1 The Necessity of Null Models in Spatial Games
*[Introduce Null Models], [Define Null Model Value to Football Analysis], [Explain Why Null Models are Needed vs Simple League Averages]*

Establishing why baseline randomizations are required to distinguish deliberate tactical choreography from random spatial proximity.

### 4.2 Limitations of Classical Network Topologies
*[Explain Why Traditional Null Models not Suitable]*

`4.2.1 Erdős–Rényi Baselines`, `4.2.2 Standard Configuration Modeling` (Discussing the issue of self-loops and directed mass-preservation in a closed 11-node space).

### 4.3 Proposed Null Model Architecture & Validation
*[Approaches for Null Models in Football], [Null Model Validation]*

The algorithmic design of your chosen null model (e.g., Directed Weighted Configuration or Weight-Shuffling) and how you validated the permutation distribution.

--- 

## 5. Results, Interpretation & Discussion
Executing the model and analyzing the findings.

### 5.1 Null Model Application & Statistical Signatures
*[Null Model Application/Analysis]*

Presenting your Z-scores. Which players/passing lanes defied the null model? 

"How many standard deviations is my observation away from the average?"

$$Z = \frac{X - \mu}{\sigma}$$

### 5.2 Tactical Insights & Practical Implications
Translating the math back into football. What does a $Z > 3$ mean for a coach trying to stop this team?

### 5.3 Methodological Limitations & Future Work
Reflecting on assumptions (e.g., treating match phases as static rather than dynamic, data limitations).