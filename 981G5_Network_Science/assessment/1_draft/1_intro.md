**Potential title:** Beyond Descriptive Networks: "Using Spatially-Constrained Null Models to Identify Statistically Significant Tactical Hubs in Football."

## 1. Introduction
This section establishes the landscape, the research gap, and your specific objective.

---

### 1.1 Context & Motivation
*[Data Applied to Football], [Network Science Introduction], [Why Apply Network Science to Football]*

The surge of data analytics in sports and the introduction of graph theory as a lens for spatial-temporal games.

---

The past 10/15 years in football have seen a surge in data based analysis. At the forefront of this data revolution has been a metric called xG which applies a percentage, a measure of quality to each shot. It's promenance is such that it has made it to the half-time and full-time anaylsis of every telivsed football match. This metric is computed using probablistic machine learning methods and takes "event data" as its inputs, including things like shot locations, defender location, ball height. Ultimately, it is a metric that allows us to measure quality of a shot, evaluate a players performance and by aggregating over the course of a match, or season, evaluate the quality of output of a team. 

However, football is a game of mutli-faceted interactions taking places amongst ~24 players in a spatially constrained domain. Therefore, it makes logical sense that a truely valuble method of analysis should evaluate to such a standard. 

This is where networks come in
- What is a network
- What is network science
- What is SNA and why do so many football research papers refer to it instead of network science

Ultimately, the motivation to applying network science stems from the ability to provide a holistic view of a team, match or phases. The interactions, whatever, they may be represent the interconnect nature of a game of football. A pass from one player to another isn't just a mere frequency count, it encapusales a spatially and tactically motivated actions which is actions by the two players involved but facilitated by the wider system of 11 teammates and coutnerfactuals by the opposing system of 11 teammates. Accross an entire game, or sub-period, the cumulative PassMap represents a football print of the execution of the tactical intend of each team. 

Teams approaches and tactics are reflected in their networks, whether that be because they are high structures or perhaps highly chaotic, direct team. 

Networks allow for a temporal persepctive where we can assess temporical dynamics OF and ON the network. The network will evolve and change during different phases of the match. Oftten in response to the phase state, whether that be considered as the score itself, momentum, other teams tactics or literal time of the match. 

> there needs to be a clear and defined reasons for why network science should be applied to football. there are plenty of motivation references and mostly split into prediction and tactical. 

To build an actual Network Science project for football, you have to treat it as a spatially embedded network (Buldú et al., 2018)

To build an actual Network Science project for football, you have to treat it as a spatially embedded network (Buldú et al., 2018). In these systems, nodes have physical coordinates $(x,y)$, and the probability of an edge existing is heavily influenced by the Euclidean distance between those coordinates.

**The Temporal/Dynamic Network (Evolution):** Build networks for each match (or segment) and extract the relevant properties. Track how the metrics develop over time. The way the networks change and therefore the metric change can be analysed and explained from a football/tactical perspective. A common approach is windowing where you compute the average of something, say a team's Clustering Coefficient to see if tactical discipline spikes or dips during a losing streak.

**The "Ensemble" Network:** You could ensemble all matches from a teams seasons into one super network. This essentially creates a probability map of how a team functions - and you could frame this as a managers tactical outputs. From this you could ask "what is the teams backbone?". The supernetwork itself will be an uniterpretable hairball as all players will likely have made a pass to eachother in some way, including all swud players. You use Disparity Filter (Salience Network) to strip away the statistically insignificant edges and reveal the "Multiscale Backbone"—the core passing lanes that persist regardless of the opponent.

---

### 1.2 Problem Statement
*[Problem with Current Approach to Data and Football]*

Why traditional "event-counting" metrics (e.g., total passes, xG) fail to capture the structural dependencies and systemic nature of football tactics.

Afterwhich explain the lack of null/random models used in contemporary research 

---

This is in contrast to the xG which is a representaiton of cumulative of the output of the team. It can be considered such a representation as the purpose of a team in a match is to score goals, which are the result of shots, therefore, the tactics of a team *could* be evaluated by quality of its outputs. 

Clearly, there is a naivity to this logic and as a game of football is unreliably a story painted by its shots alione. 

Football is a low scoring game (compare to x which is high scoring), which is coupled by its low(er) number of shots exectued too, this is in constract to passed which count into the 100s, distance covered which clocks into the 10kms and defensive actions which accumlated into 10s (100s?). This low number means that the probablity mass of a single game does not usually have the density, or count, to be truely meaninfufl. Additionally, football, and all sports, are inherinetly underpinned by their reliance on chance and luck (think of this as variability on a players outputs, their talent is constast). Attempting to evaluate performance based on the statistic(s) which is low in volumne is dangerous as it can and will paint a missleading pictures. 

Additionally, whilst football is a team game, there is the glaring ommosion that shots are dispropotionatly and intention take primarily by strikers and forward players. The actions and quality of a defensive player undoubtably contribute to the successufl of a team and thus the teams likelihood to produce high quality shooting chance but it would be difficult to justifying evaluating a defiensive player player via an offensive metric. There exists the possibility evaluating defensive players via the offensive metrics of the opposing team but this leads us down a route wherbey we are evaluating a systems defensive tactical output via the capacity of the another system. 

---

### 1.3 Research Aims & Objectives
*[Research Aims], [State the Goal of This Report]*

- Apply data, and specifically, network science to understand the tactical find of football
- Demonstate the various network properties that can be analysed and their football perspective interpetation
- Introduce the need for baselines for comparison purposes and tactical inference
- Explaining why empirical data is not sufficent; barca 
- Introduce null models
- Explain why traditional random nodels are not sufficent
- Explain that spatial aspect needs to be taken into account to legitimise tactical underdtanding/analysis/findings
- Mention how this pushes analysis from SNA into Network Science
- Explain why football has a SNA focus traditionally; small, node focused, domain, jounals
- Demonstate validating null methods using game/logic constraints
- Present some analysis using the nulls based on some finding; 
- i.e. team/game demonstated node that does X, does baseline support this being signficant, or likely based on spatial and underlying constraints/conditions


Clearly define the core question: *How can network science and null modeling expose non-trivial tactical structures?*

The goal of this paper will be construct an approprate null model for which baselines can be generative to validate and compare analysis against.

Descriptive simply observes and explains what is, focusing on facts, data, and actual behavior. Prescriptive dictates what ought to be, providing rules, recommendations, and judgment

This [networks] enables us to use networks from temporal/longitude perspective were the way properties and nodes evolve and over time can be taken into account

By comparing random baselines, we will be able to we will be able to determine if certain properties are truely unique, impressive, standout (i.e. based on talent or tactical) or natural result of randomness imposed by the contraints of the game itself (11, pitch) and the probability distribution 

---