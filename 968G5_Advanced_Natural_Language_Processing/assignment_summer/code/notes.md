

---

```Task2Evaluator, evaluate_predictions()```

> DO THIS OUTSIDE OF THE CLASSES. USE THE TRAINED MODEL TO RUN AD-HOC ANALYSIS. APPLY TO VAR1 and VAR2

This method takes in lists of the gold and predicted data with the latter in the form `{"span": (start_idx, end_idx), "technique": "doubt"}`. It produces `y_true, y_pred` which are two lists compiled of `TP`, `FP`, `TN`, `FN`. (Not TN as it isn't a part of F1 calc). From this, the lists are plugged into `precision_recall_fscore_support` and `classification_report` to compute the benchmark metrics and a per-class breakdown. This pertains to our terminal metrics and the basis for model seleciton. However, robust analysis requires a more grangular insight. 

Our evaluation method is end-to-end meaning the span prediction is includive of the output metric. F1, Prec or Recall do note have granular insight into the relationship between the router and classifer. For example, if a span failed, it defaults as a `not_propganda` based on the evaulation framework. However, in practice we still computed a technique. It would be good to understand what % of failed spans, that had posible gold label, where still predicted correctly by the model. If the model was still above to comfortably predict using (partially) wrong then we could say the tolerance parameters were wrong and that the H1 is much stronger than we thought. This information is in our error logging system. 

In this paradigm we are looking are subset, i.e. instances that disqualified the router. If using F-1 we would call this condition F-1. However, this can be wildly misleading as the model can introduce bias into the subset. Therefore, accuracy is actually the most honest metric. By definition, the routing mechanism is focusing on propaganda instances and therefore filtering out the dominate not_propaganda class which was skewing the data before, hence, accuracy is a good metric for a balance dataset. 

This becomes a standard 8 class standard 8-way classification problem: Did the model assign the correct technique label out of the 8 choices to this qualified span?

Need to think about what the relevant pieces of analysis are to put into the code. Or at least produce a table from which statistics can be computed. 
- Basic counts for Hallucinated Span, Missed Span, Technique Misclassification and Boundary Localization Failure (+ total errors)
- Percent of instances that passed the boundary; full dataset and broken down by class. 
- Condition accuracy, if they pass what was the accuracy (only prop so acc is fine) and a class breakdown. 
- Predictions for disqualied spans; by class
- Level of wrongness for disqualied spans; by class

Failed the span qualification but got the write label is an interesting one because the true prop spans are dispuited. if the model can get the label with a much smaller span then maybe the original span was too wide. 

There seems to be some trend of the models failing to produce a span then the gold span is just a single word. THis is despite deberta being computed on the whole span.

Starter Function:

```
from collections import Counter

class Task2Evaluator:
    # ... (existing get_tolerance and evaluate_predictions methods) ...

    @staticmethod
    def print_diagnostic_breakdown(eval_results: dict):
        """
        Automates error logging analysis and conditional metrics 
        directly from the output dictionary of evaluate_predictions.
        """
        logs = eval_results.get("Error_Logs", [])
        if not logs:
            print("No error logs found to analyze.")
            return

        total_errors = len(logs)
        error_counts = Counter([log["error"] for log in logs])
        
        # 1. Pipeline Error Distribution
        hallucin = error_counts.get("Hallucinated Span", 0)
        missed = error_counts.get("Missed Span", 0)
        tech_mis = error_counts.get("Technique Misclassification", 0)
        bound_fail = error_counts.get("Boundary Localization Failure", 0)

        # 2. Compute Conditional Metrics
        # Total spans that successfully passed boundary checks (\pm \delta)
        # = (Correct Spans & Techs) + (Correct Spans & Wrong Techs)
        # We can extract correct matches directly from y_true == y_pred where y_true != 'not_propaganda'
        y_true = eval_results.get("y_true", [])
        y_pred = eval_results.get("y_pred", [])
        
        boundary_passed_correct_tech = sum(
            1 for t, p in zip(y_true, y_pred) 
            if t != "not_propaganda" and p != "not_propaganda" and t == p
        )
        total_boundary_passed = boundary_passed_correct_tech + tech_mis
        
        cond_accuracy = (
            (boundary_passed_correct_tech / total_boundary_passed * 100) 
            if total_boundary_passed > 0 else 0.0
        )

        # 3. Automated Terminal Printout
        print("\n" + "="*50)
        print("     AUTOMATED TASK 2 DIAGNOSTIC AUDIT")
        print("="*50)
        print(f" Total Logged System Errors : {total_errors}")
        print("-" * 50)
        print(" ERROR CATEGORY BREAKDOWN:")
        print(f"  * Boundary Failures       : {bound_fail:4d} ({bound_fail/total_errors*100:5.1f}%)")
        print(f"  * Technique Swaps         : {tech_mis:4d} ({tech_mis/total_errors*100:5.1f}%)")
        print(f"  * Neutral Hallucinations  : {hallucin:4d} ({hallucin/total_errors*100:5.1f}%)")
        print(f"  * Completely Missed Spans : {missed:4d} ({missed/total_errors*100:5.1f}%)")
        print("-" * 50)
        print(" CONDITIONAL PIPELINE ACCURACY:")
        print(f"  * Spans Passing Boundary  : {total_boundary_passed}")
        print(f"  * Technique Acc on Spans  : {cond_accuracy:.2f}%")
        print("="*50 + "\n")

# 1. Run Evaluation
metrics, class_breakdown = random_baseline.evaluate(VAL_PATH, dataset_name="VAL SET")

# 2. Automated Diagnostic Breakdown (One Line Call!)
Task2Evaluator.print_diagnostic_breakdown(metrics)
```


---

TODO:
- Print out final crf matrix; inspect crf and fixed rules

