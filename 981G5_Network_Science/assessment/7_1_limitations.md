# 7.1 Methodological Limitations

#### 1. Ignorance of Time Component:

"topology is only one dimension of the analysis of passing networks and at least other two must be included to have a complete picture: space and time" (Buldu, 2018)

"Time is another dimension traditionally overlooked when constructing passing networks." (Buldu, 2018)

"the analysis of passing networks must take into account its continuous evolution in time and space" (Buldu, 2018)

"as shown in Duarte et al. (2012), entropy decreases as the game evolves, which is attributed to the fatigue of the players." (Buldu, 2018)

"In addition, collective behaviors decrease in complexity/irregularity during the time periods, accompanied with an increase of the deviations from the mean tendency." (Buldu, 2018)

"Network’s density, heterogeneity and centralization also show differences between the 1st and 2nd part of a match (Clemente et al., 2015)." (Buldu, 2018)

"However, it is common to average along the whole match (Gonçalves et al., 2017), or even along a competition (López-Peña and Touchette, 2012; Gyarmati et al., 2014), obtaining a network that can be informative about the general behavior of a team but excludes the unavoidable fluctuations during a match." (Buldu, 2018)

"Therefore, the passing network of a team must be analyzed in combination with the network of the opponent (Narizuka et al., 2014)." (Buldu, 2018)

--

"A third issue arises when trying to interpret the results of the averaged passing networks. Since, as we have seen, network organization and, consequently, network parameters, are continuously evolving during the match, considering the sum of all passes may hide interesting information about how different crucial events influence a team’s style of playing, such as a scored/received goal, a substitution or, simply, the fatigue of the players as time goes by. (Buldu, 2019)"
- Buldu breaks things down to 50 passes (time-agnostic). This creates mini networks which can be comparsed directly (to an extent). This is compicated and blurs the easy analysis ebenfit of per-game networks. However, the fact remains that an matched average network is built from and underlying sample (real match) which evolved with the contstaints of a real game. In our generative process, we just sample, there is no dictation of time. Semantically, it remains true that the modelled process should invariably build a probablilty distribution which captures the proportion of passes made under such circumstances. This means a single null model is at the mercy of variance and may bias he contextual passes it generates. However, a full 1000 model suit of networks with a range of statistics may pertain to a more accurate benchmark. 

> In terms of generating new networks, edges or passes, we are essentially evolving a network. Evolution is a time constrained process, as is a football match, by ignoring this aspect we are produce a a network which is drawing from time-agnostic probability distributions. This introduces bias in the sampling process. This is also naturally a flaw of the markovian processes we are adpating with tend to be 1 or even just 2 steps, meaning generated passes have no inferences of what happened before, where as a real match does. 


""Next, we have focused on the temporal nature of football passing networks and calculated the evolution of all network properties along a match, instead of considering their average."

Buldu (2019) worked on modelling the the temporal nature of football passing networks. Instead of calculating a single match network and computing the average networks, they implements a 50 pass windowing, allowing for nommailizing direct comparisons between FCB and the opponents but also allowing for the inconsidering of time context, match evolved network. The contextual parameters will create a network in the 90th minunte, i.e. chasing a win, fatigure, are fundementally different to the 10th minute. A matched average statistic looses this context

> Note, this logic need to be extended to apply to our Null Construct. We are taking match level, averafered methodologies and adapting them to compute match level networks. The underlying mechanisms have no explicity understanding of time. Although the modelled data instrinsitically should. It is unknown whetehr the underlying methods are robust the temporal aspect, i.e. of the generated passes, to we produce the correct amount of late stage passes, or are out methodologies fundementally flaws, i.e. bias to the average. 

---

our results show that (i) passing networks unveil additional information not contained in the average network and, in addition, (ii) temporal analysis highlights some of the particular features of Guardiola’s game. (Buldu, 2019)

---

## Higher Oorder Possesnsion Chains

To keep our modelling parimonious we focus on 1step markovian implemetnations, this also directly follows Gama (2026). Future studies could implement more. This directly follows the temporaral considersations in a slightly different way. We are generating passes with no inferences of match context. High order generations have the previous n-steps context. THis is a temporal consideration but in a slighly different way. Though without true temporary consdierdations, i.e. this is the 90th minute, even the higher order generations would revert back to the average occurances, though it should be more accurate. 