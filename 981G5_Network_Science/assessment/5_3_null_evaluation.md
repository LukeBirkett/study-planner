# 5.3 Evaluation Protocols: 

- Clustering
- Average Path Length
- Centrality


This is a very basic and rudimentary comment but I get the impression that the key to evaluating football networks may some from less traditional network properties. 

The basis will be to preserve the exists of nodes and edges and structurally preserve node degrees. Though I think add some level of variable/noise into the degrees will be valid. 

The "rewriring" proccess (whatever this may be) will need to therefore generate network properties that follow suit of football. 

In terms of network properties like clusters, we can compute an empirical range which it should fall in, but more metrics are the point of interest, we want to see how certain metrics fluctuate. 

Therefore, the key will be to evaluate null models against footballing principles encoded into networks. 

This may entail evaluting the goalkeepers role and freq of passes

In may be looking into cross field passes and therefore unlikely relatioships in the network. 

However, we need to be care nots to bound the eval too deeply. Strikers are seldom hubs, but they could be in a unique system or talents player. We don't want to discard nulls which produces striker hubs but there should be a range of prevelance. 

We have a ful lseasons data, something like 400 games with 2 team per game. For all metrics, both traditional and domain specific, we can produces a full suite of empirical summary statistics to evaluate our nulls against. 

If we produce 1000 nulls how does the summary compare

---

## Modeling Out-Degrees to Generate In-Degrees:
In football, a coach/player chooses when and where to pass (out-degree behavior). Who receives the ball (in-degree) is an emergent property of spatial positioning and opponent pressure.

Evaluating whether your generated in-degree distributions match empirical validation sets gives you an immediate goodness-of-fit metric for your null model.

---














# TOOD: I think this goes into 4. NULL

> It explains why we need nulls. However, it also cleaning follows the evaluation logic. Perhaps if this is already explained in 4. then the evaluation section can just refer to it. 

This leads into the question, if we have this much data, why can't we just compare any findings to empirical baselines. 

This is leads into the topic of data sparisty and specificty. 

The empirical baselines are a true average of all the teams, systems and results in a season. If we find something interesting it is largely invalid or misleading to compare it to the league. 

This is ecapsulated by Buldu 2019 who demonstate that FCB have higher network properties because they make more passes. 

We use the Null Models to generate a baseline which coordinates against number of passes and as well as things like formation

Again, the question prevails, why cant we just filter the empirical data. 

This is where the question of sparsity comes in. As you begin to filter you loose signficant data. There is a huge range of passes that teams make per game, even if you try and discrete bucket these it is sparse. Then as you try to add more complexity, i.e. player positions, formation, the data reduces dramatically. 

Given the uniqueness of teams appraochs, given the number of options and variabels in a complex ysstem like football, you invariabe end up filtering the (large) baseline dataset to the team you are trying to analysis, meaning you are baselinng them against themselves. 

By modelling a generative process with learning the probabilsitic nature of football and its physical/spatial constraints, you can generate a baseline(s) which is team-agnostic and follows the rules of the league you are analysis but is explicity the "average".

For example, if you produce a generate rewire process which retains degrees but models passes on the spatial trends of the league, then its will rewiring to a baseline possible network. If the team, or player, you are looking at is truely unique, it will sit at the outer limit, or even beyond, what a suite of 1000 nulls models can produce randomly. Only then will you be able to infer if your finding is specifal or just a likely produce of the topolicial, spatial and domain constraints of the game. 

Null Baselines are much more robustx