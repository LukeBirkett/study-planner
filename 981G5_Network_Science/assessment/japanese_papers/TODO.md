# Papers

1. [Statistical properties of position-dependent ball-passing networks in football games (Narizuka et al., 2014)](#1-statistical-properties-of-position-dependent-ball-passing-networks-in-football-games-narizuka-et-al-2014)
---
2. [Preferential model for the evolution of pass networks in ball sports (Yamamoto and Narizuka, 2021)](#2-preferential-model-for-the-evolution-of-pass-networks-in-ball-sports-yamamoto-and-narizuka-2021)
---
3. [Degree distribution of position-dependent ball-passing networks in football games (Narizuka et al., 2015)](#3-degree-distribution-of-position-dependent-ball-passing-networks-in-football-games-narizuka-et-al-2015)
---
4. [Pólya urn model for analysis of football passes (Yamamoto, 2025)](#4-pólya-urn-model-for-analysis-of-football-passes-yamamoto-2025)
---
5. [Common and unique network dynamics in football games, (Yamamoto and Yokoyama, 2011)](#5-common-and-unique-network-dynamics-in-football-games-yamamoto-and-yokoyama-2011)
---
6. [Scale-free Property of the Passing Behavior (Y. Yamamoto, 2010)](#6-scale-free-property-of-the-passing-behavior-y-yamamoto-2010)
---
7. [Examination of Markov-chain approximation in football games based on time evolution of ball-passing networks (Yamamoto and Narizuka, 2018)](#7-examination-of-markov-chain-approximation-in-football-games-based-on-time-evolution-of-ball-passing-networks-yamamoto-and-narizuka-2018)
---

<br>
<br>

## 1. [Statistical properties of position-dependent ball-passing networks in football games (Narizuka et al., 2014)](./narizuka_yamamoto_k_2014_properties_pos_dep_passmaps.md)

TODO: revisit notes and clean up
TODO: extract all relevant references
TODO: extract assessment notes/ideas
TODO: create concise summary of paper
TODO: create summary based only on notes taken

> Narizuka, T., Yamamoto, K. and Yamazaki, Y., 2014. Statistical properties of position-dependent ball-passing networks in football games. Physica A: Statistical Mechanics and its Applications, 412, pp.157-168.

---

<br>
<br>

## 2. [Preferential model for the evolution of pass networks in ball sports (Yamamoto and Narizuka, 2021)](./yamamoto_k_narizuka_2021_preferential_model_evolution_pass_net.md)

TODO: read and take notes

> Yamamoto, K. and Narizuka, T., 2021. Preferential model for the evolution of pass networks in ball sports. Physical Review E, 103(3), p.032302.


---

<br>
<br>

## 3. Degree distribution of position-dependent ball-passing networks in football games (Narizuka et al., 2015)

TODO: read and take notes

> Narizuka, T., Yamamoto, K. and Yamazaki, Y., 2015. Degree distribution of position-dependent ball-passing networks in football games. journal of the physical society of japan, 84(8), p.084003.

---

<br>
<br>

## 4. [Pólya urn model for analysis of football passes (Yamamoto, 2025)](./yamamoto_K_2025_polya_urn_football_passes.md)

TODO: finish notes
TODO: add concise summary here
TODO: create summary based only on notes taken

> Yamamoto, K., 2025. Pólya urn model for analysis of football passes. Physical Review E, 112(6), p.L062303.

---

<br>
<br>

## 5. Common and unique network dynamics in football games, (Yamamoto and Yokoyama, 2011)

*Common and unique network dynamics in football games (Yamamoto and Yokoyama, 2011)* as comes up in *Linking network structures and stochastic flow properties: An exploratory Markov-spectral case study in professional football (Gama et al., 2026)*: "This observation aligns with findings that football passing networks often exhibit scale-free properties with emergent key players acting as hubs. [50]"

> Y. Yamamoto, K. Yokoyama, Common and unique network dynamics in football games, PloS ONE 6 (2011) e29638.

---

<br>
<br>

## 6. Scale-free Property of the Passing Behavior (Y. Yamamoto, 2010)

From Statistical properties of position-dependent ball-passing networks in football games (Narizuka et al., 2014): 

> Y. Yamamoto, Scale-free Property of the Passing Behavior, International Journal of Sport and Health Science 7 (2010) 86–95.

---

<br>
<br>

## 7. Examination of Markov-chain approximation in football games based on time evolution of ball-passing networks (Yamamoto and Narizuka, 2018)

Also from Gama et al. (2026), "prior research has successfully established the Markov-chain model as a valid approximation for the **growth of passing networks over time** [16] and to model state transitions between field zones [17]"
- [16] Yamamoto, K. and Narizuka, T., 2018. Examination of Markov-chain approximation in football games based on time evolution of ball-passing networks. Physical Review E, 98(5), p.052314.
- [17] Liu T, Zhou C, Shuai X, et al. Influence of different playing styles among the top three teams on action zones in the World Cup in 2018 using a Markov state transition
matrix. 

[16] looks particular interesting. Need to converse with Gemini to understand if it is a "Dynamic of a Network" and therefore a Null Model, or just another "Dynamics on a Network paper". the disctinction I am unclear on is the evolution part. 

While prior research has successfully established the Markov-chain model as a valid approximation for the growth of passing networks over time, [16] (Gama et al., 2026)

> *Yamamoto & Narizuka (Descriptive): Their primary research goal was to answer a fundamental mathematical question: Is a Markov chain a valid way to represent a football passing network? They examined the time evolution of the networks to prove that the Markovian approximation closely matches real-world network growth. In scientific terms, this is a "descriptive" or "validating" study. They described the mechanism and proved the math fits the reality.* Their output is focused on the topology and growth of the network. They look at how nodes (players) and edges (passes) accumulate over time and whether the Markov model accurately predicts that accumulation. **Yamamoto and Narizuka is not a Null Model paper. Even though they focus on topology and growth, their explicit goal is replication, not randomization.**
> 
> To build their Markov chain, Yamamoto and Narizuka calculate the transition probabilities using the actual empirical data of how the teams played. They use the real frequencies of passes between specific players to see if the math can accurately recreate the physical growth of the network. If they were writing a Null Model paper, they would have had to intentionally destroy that empirical data to create a baseline of chance.
> 
> They kept the real tactics embedded in the math to prove that the Markov chain is a highly accurate mirror of reality. Because they didn't strip out the tactical intent to create a baseline of randomness, it is a generative model, not a null model.
> They used the empirical data to build the mathematical engine, ran the engine, and then checked if the engine’s output matched the empirical data they started with.
> It sounds a bit circular at first glance—using data to build a model just to recreate the same data—but it is a vital scientific step. Yamamoto and Narizuka needed to prove that a Markov chain (which assumes the next pass depends only on who currently has the ball, ignoring the previous three passes) is actually sophisticated enough to capture the complex, fluid reality of a football match.
> By showing that the generated network matched the real network over time, they validated that the "Markov assumption" holds true for football.
> This is exactly why Gama et al. (2026) noted that a null model is a limitation of their own paper. Gama et al. took the validated engine from Yamamoto & Narizuka and used it to calculate complex metrics (like entropy and spectral gaps). But Gama et al. realized: "We have these numbers, but we don't know what a 'normal' or 'random' number looks like." To fix that, future researchers will need to take that exact same Markov engine, apply the Null Model workflow (shuffling the data), and create the random baseline.
> 
> *Gama et al. (Analytical): Gama and colleagues take Yamamoto’s conclusion as a starting point. Since Yamamoto proved the Markov model works, Gama et al. ask: What can the mathematical properties of this Markov model tell us about how a team actually plays? They dive into "spectral properties" (like the spectral gap) and "information theory" (like entropy rate) to analyze tactical flexibility, ball circulation speed, and unpredictability.* Their output is focused on the stochastic flow. They use the transition matrix (the probabilities of passes between specific players) to calculate abstract metrics. For example, they use the spectral gap (derived from the eigenvalues of the matrix) to measure how quickly a team can diffuse the ball across the pitch, and entropy to measure how unpredictable their passing sequences are to an opponent.



> Yamamoto, K. and Narizuka, T., 2018. Examination of Markov-chain approximation in football games based on time evolution of ball-passing networks. Physical Review E, 98(5), p.052314.

---