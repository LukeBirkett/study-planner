# 5. Results, Interpretation & Discussion
Executing the model and analyzing the findings.

---

Conduct analysis using null models

distriution of hub to wider areas. are there any players, or samples that exceed what is randomly expect (theory clustering/hub/degree dist should be centered)

mall wordedness, via path lengths. there is some naunce on how to construct this and it probably needs some thresholding as a single pass from goalkeeper to striker doesn't represent a good path. but a chain through the center 10 times a match does. I also thing this will be the most interesting because it i think that there is a good chance the the constraints of the network and the fact that the network is small might make it small-worldedness by default. Even if this is the case, it means finding matches where a team is not small-world is signficant. there will probably need to be a breakdown of analysis by number of passes as volumne skews (increases) most network metrics. 

something about centrality and clustering but not sure what yet

---

## 5.1 Null Model Application & Statistical Signatures
*[Null Model Application/Analysis]*

Presenting your Z-scores. Which players/passing lanes defied the null model? 

"How many standard deviations is my observation away from the average?"

$$Z = \frac{X - \mu}{\sigma}$$

---

## 5.2 Tactical Insights & Practical Implications
Translating the math back into football. What does a $Z > 3$ mean for a coach trying to stop this team?


---

## 5.3 Methodological Limitations & Future Work
Reflecting on assumptions (e.g., treating match phases as static rather than dynamic, data limitations).



---