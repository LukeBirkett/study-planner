import ExampleUsingRobinsonCode_func as ef
import numpy as np

# Define your symmetrical noise points from your notes
noise_levels = [1, 1.25, 1.5, 1.75, 2, 2.5, 3, 3.5, 4, 5]

print("--- Starting Sensory Noise Sensitivity Analysis ---")

for noise in noise_levels:
    # Run the simulation for the current noise level
    raw_accepts = ef.runIt(noise)

    choices = list(raw_accepts)

    undecided = choices.count(0)
    chose_nest_1 = choices.count(1)
    chose_nest_2 = choices.count(2)

    print(f"\n[Noise Level: {noise}]")
    print(f" -> Selected Mediocre Nest 1: {chose_nest_1} ants")
    print(f" -> Selected Optimal Nest 2: {chose_nest_2} ants")
    print(f" -> Remained Undecided/Hub: {undecided} ants")