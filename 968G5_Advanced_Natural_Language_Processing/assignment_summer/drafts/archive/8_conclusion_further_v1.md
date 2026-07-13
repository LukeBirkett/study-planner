## 8. Conclusion and Further Work
Summarize which hypothesis held the most weight across the experiments.

**Further Work:** Suggest more complex data augmentations (e.g., Back-Translation) or the exploration of POS-only models to further decouple words from syntactic patterns.

## Strategic Tips for High Marks:
**Academic Style:** Ensure all major technical points (like the "Label Bias Problem" or the "Distributional Hypothesis") are backed up with references from your module notes or external literature.

**The "Joint Signal" Argument:** Your plan for Variation 2 in Task 2 is a strong point of "creative thought." Devote space in the analysis to explaining how the model uses the "breadcrumbs" of specific technique tags to knit together ambiguous boundaries.

**Code Appendix:** Ensure your .ipynb or .py files are clearly commented and mirror the methods described in the report.

---

### Custom Soft Bounary Snipper Evaluation Method
An evaluation method that treats the start and end of the spans as "softer" as even humans only agree 60% of the time on exact spans. Perhaps they have less weight on the edges but the middle tokens provide more weight. Might need to be dynamic based on length of snippet as 3 word long snippet are probably all propaganda terms. However, it is likely the case that some, or even many, propaganda examples are heavily weighted towards the start for end. Maybe this will be uncovered by the attention heatmaps and I can add this point as a pointer for "future" research

---

### POS Tag Only Model
Comparing models trained on words vs pos tags. I have a hypothesis/theory that propaganda can be decomposed down into abstract usage of language. Words are a clear signal of this but they are not the true underlying signal. For example, "fight fight fight" invokes emotions and is clearly propaganda. But it is the chaining of 3 verbs that is the true signal. In fact, focusing on the words themselves likely leads to overfitting but it believes that fight and its repetation are the propaganda itself but "conquer conquer conquer" is also the same technqiue. Therefore, we take a classifcation model, or even the sequence labeller, and apply the models on just the pos tags (no words), what sort of result do we get?