# Linking network structures and stochastic flow properties: An exploratory Markov-spectral case study in professional football (Gama et al., 2026)

> Gama, J., Dias, G., Couceiro, M.S., Mendes, R., Mendes, R.S. and Vaz, V., 2026. Linking network structures and stochastic flow properties: An exploratory Markov-spectral case study in professional football. Proceedings of the Institution of Mechanical Engineers, Part P: Journal of Sports Engineering and Technology, p.17543371261448957.

---

#### Null Model Limitation

This paper was read in full due to a critical entry in its 'Limitations' section: *"Future studies should also employ **null models and random network** comparisons to establish baselines for spectral gap, entropy rate, and other indices, enabling more robust interpretation of observed values"*. 

Given the authors only used a two-game sample, they conceeded that their observed variations in stochastic flow metrics 'cannot be statistically distinguished from random match-to-match variability'. They highlight that null models are required to separate deliberate tactical behavior from mathematical noise.

A random baseline would allow researchers to determine whether network variations 'reflect genuine tactical adaptations... or whether they represent normal stochastic fluctuations inherent to passing sequences in football'. A null model establishes the boundaries of that normal fluctuation, providing the exact justification needed to design generative null frameworks for football analytics."

---

#### Sample Size, Matrix Permutation, Larger Dataset, Empirical Baseline

Gama et al. (2026) observed stochastic flow variation between games but lacked the statistical power ($n=2$) to prove significance. They acknowledged that a **larger dataset** is needed to run resampling methods (matrix permutation) to establish a baseline and therefore determine if observed variations reflect tactical adaptations or normal match-to-match noise.

Just to be clear, the way this works is you would use the large dataset to construct a robust generative process. Using this you would generate 1000s of networks and compute the properties we are interested in. This gives us a distribution/range of expected values from which an individual value can be compared against. 

This important to recognise that football networks naturally possesses a baseline structure just by being a game played on a field with 11 players (i.e. they share the same constraints), meaning metrics might look identical by chance. The goal is to extract the topological/constrained baseline to make meaningful inference on the tactical/performance aspect.

A **matrix permutation test** is an established null model methodology that works by shuffling the rows and columns of a team's passing matrix. In footballing terms, this would mean swapping players attributes and therefore links but retaining the macro-structures like total pass volume. This would create a a naive, topological null model which ignores footballs physical proximity contraints. Gama et al. admit their model ignores "spatial coordinates" meaning a blind shuffle like this would generates physically impossible long-distance interactions. A tactically valid baseline requires spatially constrained null models that weight random pass probabilities based on actual player distance.

Additionally, it might be easy to think that if we have a "large dataset" as the authors call for that we can just use the raw, empirical data appropriate baselines, i.e. league averages and distributions of given properties. However, if our goal to identify explicity tactical and performance/talent based findings, then the baselines need to be normalized to the specific constraints of the matches being analysed. 

For example, high passing patches need to be compare to other high passing matches otherwise the centrality metrics will natural be elevated. If compared to a league average, high pass matches will places teams and players in the upper percentiles. We don't need networks to tell us a team passes alot. However, we can use networks to expose and compare the tactical approaches and player talent within high passing teams. But if we use only the empirical data and filter it down we soon all foe to data sparsity, resulting in use comparing our matches to the same teams or even exact game. When we start combining this filtering appraoch with other granular constraints such as formations, even a large dataset becauses too sparse leading to statistical overfitting in analysis and comparisions. 

My idea is to solve this by leveraging season-wide data to build a conditioned generative null model framework. By learning passing distributions across an entire league, this process synthesizes thousands of customized, spatially-aware null networks. This high-volume baseline successfully isolates deliberate tactical execution from geometric byproducts without diluting the data.

---

