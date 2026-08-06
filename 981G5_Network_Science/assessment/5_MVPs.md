# Experimental Framework: Generative Null Model Construction (MVPs)

There is likely two key appraoches to generative process: 

#### 1. Hard Topological Constraint
You lock in the exact degree sequence from the empirical match (preserving the exact player workload) and use your spatial generative model only to decide where those passes land based on distance $d_{ij}$.
- Fix player pass counts exactly (Out-Degree = 60, In-Degree = 40)
- Sample edge destinations based on spatial distance decay e^(-λd)

#### 2. Soft Generative Constraint (MVP)
You generate both the pass counts and the pass targets from season-level distributions, ensuring the resulting network's degree distribution falls cleanly within the expected statistical range of professional football.
- Sample pass volumes from a Poisson/Negative Binomial distribution
- Preserves the expected spatial/positional degree hierarchy

Remember, there is a nessecity to preserve not only traditional network properties such as degrees but also the tactical realisms and expectations of football, i.e. normal passes and hubs in the correct places. 
