**Potential title:** Beyond Descriptive Networks: "Using Spatially-Constrained Null Models to Identify Statistically Significant Tactical Hubs in Football."

## 1. Introduction
This section establishes the landscape, the research gap, and your specific objective.

---

### 1.1 Context & Motivation
*[Data Applied to Football], [Network Science Introduction], [Why Apply Network Science to Football]*

The surge of data analytics in sports and the introduction of graph theory as a lens for spatial-temporal games.

---

Football as seen a data revolution in the past 10 years. At the forefront of this movement has been a metric called xG which attempts to apply a measure of quality to each shot taken. Today, this metric can be seen during the half-time analysis of every televised football match. 

This metric is computed using probabilistic machine leanring methods meaning the measure of quality interpretted as a percentage. The input training data is know as "events data". This paradigm of data is essentially a transcribe of what we see occuring during a match into data form. Commonly used fields include things like shot location, defender location, ball height. 

The metric itself is based on a single shot but it can be aggegated over a given time period be used a metric of player or team performance. The most common time period is an entire match, though smaller increments such as an 10 minutes period or larger increments such as an entire season each have their own interpretations and use cases. The goal of football is to win the match which you do by scoring goals which result from "shots", therefore, the assumption made, is that the aggregation of the quality of shots taken provides an insight to the performance of a team or player. 

However, football is a game of mutli-faceted interactions taking places amongst ~24 players within in a spatially constrained domain. Logically, it sense that any truly comprehensive method of analysis should evaluate based on these inputs, not isolated events. 

This is where networks come in
- What is a network
- What is network science
- What is SNA and why do so many football research papers refer to it instead of network science

The motivation to apply Network Science to football, or any team sport, stems from the ability to establish a holistic view of a match. 

A matches interactions capture the interconnected nature of the onfield actions. A pass from one player to another isn't just a event to count and add to a tally, it encapsulates a spatially and tactically moviated action which directly exectured by the 2 players involves but facilitated by the wider system of all 11 teammates, and/or enabled by the counterfactual of the 11 opposing teammates. 

Additionally, the usage of Networks allows use to capture not only the spatial aspect of a match but also the temporal. The interactions from a entire game can be represented in a network, or sub-periods of a match can be converted into network. Eitherway, we can see more than just a snapshot, instead we see the cumulative efforts of a team resulting from the managers tactical intent. 

Teams approaches and tactics reflect the composition of the resulting networks. A highly structured, organsied team may be result in a more homogenous, predictable network. A choatic and direct team may result in a fragmented network with key hubs with high betweenness centrality which force the ball up the fields. 

Becuase Networks allow for a temporal persepctive, we can assess temporical dynamics OF and ON the network. The network will evolve and change during different phases of the match, often in response to the matches phase state, such as the score or prevailing momentum. 

> there needs to be a clear and defined reasons for why network science should be applied to football. there are plenty of motivation references and mostly split into prediction and tactical. 

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