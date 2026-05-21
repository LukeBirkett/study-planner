The past 10/15 years in football have seen a surge in data based analysis. At the forefront of this data revolution has been a metric called xG which applies a percentage, a measure of quality to each shot. It's promenance is such that it has made it to the half-time and full-time anaylsis of every telivsed football match. This metric is computed using probablistic machine learning methods and takes "event data" as its inputs, including things like shot locations, defender location, ball height. Ultimately, it is a metric that allows us to measure quality of a shot, evaluate a players performance and by aggregating over the course of a match, or season, evaluate the quality of output of a team. 

However, football is a game of mutli-faceted interactions taking places amongst ~24 players in a spatially constrained domain. Therefore, it makes logical sense that a truely valuble method of analysis should evaluate to such a standard. 

This is where networks come in
- What is a network
- What is network science
- What is SNA and why do so many football research papers refer to it instead of network science

This is how we move into the realm of applying networks to the analysis of football. 

In football, nodes represent players, of which there are generally 11 per team and 22 on the pitch into total (excluding sendings offs and injuries). Edges represent some form of interaction between players and/or oppenents.
- List though different by of interactions seen in researach
- Mentioning mutli-layer networks
- Introduce the PassMap framework, Bludu
- Discuss the spatial compoenent
- Conclude that we will be moving forward with a pass based paradigm
- Mention that Alves highlight less dominant areas

Ultimately, the motivation to applying network science stems from the ability to provide a holistic view of a team, match or phases. The interactions, whatever, they may be represent the interconnect nature of a game of football. A pass from one player to another isn't just a mere frequency count, it encapusales a spatially and tactically motivated actions which is actions by the two players involved but facilitated by the wider system of 11 teammates and coutnerfactuals by the opposing system of 11 teammates. Accross an entire game, or sub-period, the cumulative PassMap represents a football print of the execution of the tactical intend of each team. 

This is in contrast to the xG which is a representaiton of cumulative of the output of the team. It can be considered such a representation as the purpose of a team in a match is to score goals, which are the result of shots, therefore, the tactics of a team *could* be evaluated by quality of its outputs. 

Clearly, there is a naivity to this logic and as a game of football is unreliably a story painted by its shots alione. 

Football is a low scoring game (compare to x which is high scoring), which is coupled by its low(er) number of shots exectued too, this is in constract to passed which count into the 100s, distance covered which clocks into the 10kms and defensive actions which accumlated into 10s (100s?). This low number means that the probablity mass of a single game does not usually have the density, or count, to be truely meaninfufl. Additionally, football, and all sports, are inherinetly underpinned by their reliance on chance and luck (think of this as variability on a players outputs, their talent is constast). Attempting to evaluate performance based on the statistic(s) which is low in volumne is dangerous as it can and will paint a missleading pictures. 

Additionally, whilst football is a team game, there is the glaring ommosion that shots are dispropotionatly and intention take primarily by strikers and forward players. The actions and quality of a defensive player undoubtably contribute to the successufl of a team and thus the teams likelihood to produce high quality shooting chance but it would be difficult to justifying evaluating a defiensive player player via an offensive metric. There exists the possibility evaluating defensive players via the offensive metrics of the opposing team but this leads us down a route wherbey we are evaluating a systems defensive tactical output via the capacity of the another system. 





The first part of this paper will work through the various ways a PassMap network can be analysed using Network Science techniques and properties. 

This will be demonstated using real data from statsbomb. 

Statsbomb is a football data company which gives back to the analytics commmunity by releasing community accesible data repositories. This data is known as events data where each row...
- TODO: fill this in later. Datacard info also

As noted in Alves, there is clear overrepresentation in the liturature for mens etc. Therefore, we are using womens data for [comp] and [seasons]
- TODO: scope this out with correct quotes

Networks have also been applied to many other sports. 
- TODO: include references

Demonstate how networks can be applied to football. Nodes are players and edges are some type of iteraction, we will be using passes. Iterative though the various relevant properties. Explain them theoretically. Explain how they are interpretted from a football perspective. Demonstate examples using real data. 
- TODO: make a list of properties to work through. 
- TODO: introduce the PassMap framework, bludu

The goal of this paper will be construct an approprate null model for which baselines can be generative to validate and compare analysis against

Introduce what null models are from a network science theoretical perspective. base

Explain why trad/random null models are not suitable for application to football; straw man; tactical vs spatial/constrains

Explain why simply comparing to league averages as a baseline is not good enough. i.e. barca have more clustering that over teams. they also have more passes. need to normalize against contraints to draw a conclusion like this

Walk through the various approaches and options for null models in football. What needs to be considered. 

Introduce what methods need to be explored for null models to be valid in football

Explain the validation process. how do we know if the null models are suitable

Conduct analysis using null models

--- 