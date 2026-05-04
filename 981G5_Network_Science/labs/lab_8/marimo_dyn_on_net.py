import marimo

__generated_with = "0.20.4"
app = marimo.App(width="medium")


@app.cell(hide_code=True)
def _():
    import marimo as mo
    mo.md("# Supplementary material: Dynamics on Networks").callout()
    return (mo,)


@app.cell(hide_code=True)
def _(mo):
    import numpy as np
    import networkx as nx
    import matplotlib.pyplot as plt

    # Create sliders for parameters
    k_slider = mo.ui.slider(1, 20, value=5, step=1, label="Average Degree k")
    thresh_slider = mo.ui.slider(0.1, 1.0, value=0.5, step=0.05, label="Threshold")
    p0_slider = mo.ui.slider(0.01, 1.0, value=0.1, step=0.01, label="Proportion of activated at start")
    return k_slider, np, nx, p0_slider, plt, thresh_slider


@app.cell(hide_code=True)
def _(k_slider, mo, p0_slider, thresh_slider):
    mo.md(f"""
    <h2>Fractional threshold model</h2>

    We are going to run a simple fractional threshold model on an ER graph with $N=100$ nodes. Use the sliders below to select the average degree $k$ (default: 5), the threshold "\"\" r"\"\"$\theta$"\"\" f"\"\" (default: 0.5) and the proportion of initial activations $p_0$ (default: 0.1):

    {k_slider}
    {thresh_slider}
    {p0_slider}
    """)
    return


@app.cell(hide_code=True)
def _(k_slider, mo, np, nx, p0_slider, plt, thresh_slider):
    def fractional_threshold_model():
        N = 100  # Number of nodes
        k = k_slider.value  # Average degree
        threshold = thresh_slider.value  # Activation threshold
        p0 = p0_slider.value # Proportion of activated at start

        # Generate an ER network with given average degree
        p = k / (N - 1)  # Connection probability for ER graph
        G = nx.erdos_renyi_graph(N, p)

        # Extract the giant component (in case network is not connected)
        # But note that initial activations are still on the original network
        largest_cc = max(nx.connected_components(G), key=len)
        G_giant = G.subgraph(largest_cc).copy()

        # Assign random initial activations
        initial_activations = np.random.rand(N) < p0 
        num_activated = np.sum(initial_activations)
        activations = initial_activations.copy()

        # Simulate activation spread using the fractional threshold model
        for _ in range(10):  # Run for a few steps
            new_activations = activations.copy()
            for node in G.nodes():
                if not activations[node]:  # If node is not active
                    neighbors = list(G.neighbors(node))
                    if len(neighbors) > 0:
                        active_neighbors = sum(activations[n] for n in neighbors)
                        proportion_active = active_neighbors / len(neighbors)
                        if proportion_active >= threshold:
                            new_activations[node] = True
                            activations = new_activations

        # Plot the network with node activation states
        pos = nx.spring_layout(G)
        plt.figure(figsize=(8, 6))
        nx.draw(G_giant, pos, with_labels=False, node_size=50, 
            node_color=["red" if activations[n] else "blue" for n in G_giant.nodes()])
        plt.title(f"Fractional threshold model on giant component (k={k}, threshold={threshold})")
        plt.show()

        return mo.md(f"""
            **Fractional threshold model on giant component of an ER Network**
            - **Network Size (N)**: 100 nodes
            - **Average Degree (k)**: {k}
            - **Threshold**: {threshold}
            - **Initial activations**: {num_activated}
            - **Red nodes** are activated; **blue nodes** are inactive.
        """)

    return (fractional_threshold_model,)


@app.cell(hide_code=True)
def _(fractional_threshold_model):
    fractional_threshold_model()
    return


@app.cell(hide_code=True)
def _(mo):
    # Create slider for extra parameter
    prob_slider = mo.ui.slider(0.0, 1.0, value=0.5, step=0.05, label="Edge Activation Probability")
    return (prob_slider,)


@app.cell(hide_code=True)
def _(k_slider, mo, p0_slider, prob_slider):
    mo.md(f"""
    <h2>Independent cascade model</h2>

    We are going to run a simple independent cascade model on an ER graph with $N=100$ nodes. Use the sliders below to select the average degree $k$ (default: 5), the threshold "\"\" r"\"\"$\theta$"\"\" f"\"\" (default: 0.5) and the proportion of initial activations $p_0$ (default: 0.1):

    {k_slider}
    {prob_slider}
    {p0_slider}
    """)
    return


@app.cell(hide_code=True)
def _(k_slider, mo, np, nx, p0_slider, plt, prob_slider):
    def independent_cascade_model():
        N = 100  # Number of nodes
        k = k_slider.value  # Average degree
        activation_prob = prob_slider.value  # Probability of activation
        p0 = p0_slider.value # Proportion of activated at start

        # Generate an ER network with given average degree
        p = k / (N - 1)  # Connection probability for ER graph
        G = nx.erdos_renyi_graph(N, p)

        # Extract the giant component
        largest_cc = max(nx.connected_components(G), key=len)
        G_giant = G.subgraph(largest_cc).copy()

        # Assign random initial activations (seed nodes)
        initial_activations = np.random.rand(N) < p0
        num_activated = np.sum(initial_activations)
        activations = {n: initial_activations[n] for n in G.nodes()}

        # Simulate activation spread using the Independent Cascade model
        newly_activated = {n for n in G.nodes() if activations[n]}  # Initial active nodes

        for _ in range(10):  # Run for a few steps
            next_activated = set()
            for node in newly_activated:
                for neighbor in G.neighbors(node):
                    if not activations[neighbor] and np.random.rand() < activation_prob:
                        next_activated.add(neighbor)
            for node in next_activated:
                activations[node] = True
            newly_activated = next_activated
            if not newly_activated:  # Stop if no new activations
                break

        # Plot the giant component with node activation states
        pos = nx.spring_layout(G_giant)
        plt.figure(figsize=(8, 6))
        nx.draw(G_giant, pos, with_labels=False, node_size=50, 
            node_color=["red" if activations[n] else "blue" for n in G_giant.nodes()])
        plt.title(f"Independent cascade model on Giant Component (k={k}, p={activation_prob})")
        plt.show()

        return mo.md(f"""
            **Independent cascade model on the Giant Component of an ER Network**
            - **Network Size (N)**: 100 nodes
            - **Average Degree (k)**: {k}
            - **Edge Activation Probability (p)**: {activation_prob}
            - **Initial activations**: {num_activated}
            - **Red nodes** are activated; **blue nodes** are inactive.
        """)

    return (independent_cascade_model,)


@app.cell
def _(independent_cascade_model):
    independent_cascade_model()
    return


@app.cell(hide_code=True)
def _(mo):
    mo.md(r"""
    <h2>Complex contagion</h2>

    In this section, we will do a couple of experiments with the more interesting complex contagion model. Differently from previous sections, we will use an asynchronous implementation using so-called Gillespie simulations (see explanations at the bottom). If you are interested in how this can be coded, see below. But for the sake of the following, it doesn't matter too much.
    """)
    return


@app.cell(hide_code=True)
def _(mo):
    mo.md("""
 
    """)
    return


@app.cell(hide_code=True)
def _(np):
    import heapq
    import random

    class GillespieComplexContagion:
        def __init__(self, G, seed_set, base_infection_rate):
            """
                Initialize the Gillespie simulation for complex contagion.

                Parameters:
                    - G: networkx.Graph, the underlying network
                    - seed_set: list of initially active nodes
                    - base_infection_rate: float, base probability of contagion per active-inactive edge per unit time
            """
            self.G = G
            self.base_infection_rate = base_infection_rate
            self.time = 0
            self.active_nodes = set(seed_set)
            self.event_queue = []

            # Initialize infection events
            for node in self.G.nodes():
                if node not in self.active_nodes:
                    self.schedule_infection(node)

        def compute_infection_rate(self, node):
            """Compute the infection rate for a given node based on its active neighbours."""
            active_neighbours = sum(1 for neighbour in self.G.neighbors(node) if neighbour in self.active_nodes)
            return self.base_infection_rate * active_neighbours  # Linear dependency

        def schedule_infection(self, node):
            """Schedule an infection event for an inactive node."""
            rate = self.compute_infection_rate(node)
            if rate > 0:
                time_delay = np.random.exponential(1.0 / rate)
                event_time = self.time + time_delay
                heapq.heappush(self.event_queue, (event_time, node))

        def run(self, max_time=1000, max_active_fraction=1.0, max_iterations=1_000_000):
            """Run the Gillespie simulation until max_time, full adoption, or a stopping condition."""
            active_over_time = [(self.time, len(self.active_nodes))]
            iteration = 0

            while self.event_queue and self.time < max_time and iteration < max_iterations:
                event_time, target = heapq.heappop(self.event_queue)

                if event_time > max_time:
                    break  # Stop if time exceeds max_time

                self.time = event_time

                if target not in self.active_nodes:
                    self.active_nodes.add(target)

                # Reschedule infections for all inactive neighbours (rate depends on active neighbours)
                for neighbour in self.G.neighbors(target):
                    if neighbour not in self.active_nodes:
                        self.schedule_infection(neighbour)

                active_over_time.append((self.time, len(self.active_nodes)))

                if len(self.active_nodes) / self.G.number_of_nodes() >= max_active_fraction:
                    break  # Stop if enough nodes are activated

                iteration += 1

            return active_over_time

    return GillespieComplexContagion, random


@app.cell(hide_code=True)
def _(mo):
    mo.md(r"""
    <h3>Complex contagion (with rates linear to the number of active neighbours) on a random (ER) network</h3>
    """)
    return


@app.cell(hide_code=True)
def _(GillespieComplexContagion, nx, plt, random):
    N = 100  # Number of nodes
    wiring_p = 0.05   # ER probability
    num_seeds = 5  # Number of seeds
    base_infection_rate = 0.1   # Base probability per active neighbour per unit time


    # Generate an example network
    G_ER = nx.erdos_renyi_graph(N, wiring_p)  # Random graph with 100 nodes

    # Set parameters
    seed_nodes = random.sample(list(G_ER.nodes()), num_seeds)  # Pick num_seeds random initial adopters

    # Run simulation
    model_ER = GillespieComplexContagion(G_ER, seed_nodes, base_infection_rate)
    results_ER = model_ER.run()

    # Plot results
    times, active_counts = zip(*results_ER)
    plt.plot(times, active_counts, marker="o")
    plt.xlabel("Time")
    plt.ylabel("Number of Active Nodes")
    plt.title("Gillespie Simulation of Complex Contagion on a ER network")
    plt.show()
    return N, base_infection_rate, num_seeds


@app.cell(hide_code=True)
def _(mo):
    mo.md(r"""
    <h3>Complex contagion on a preferential attachment (BA) network</h3>

        Here we will explore two scenarios. One in which the seeds will be intentionally set to be hubs, the other in which the seeds will be intentionally set to be non-hubs
    """)
    return


@app.cell(hide_code=True)
def _(N, nx):
    # Generate a Barabási-Albert network
    m = 3# Number of edges per new node
    G = nx.barabasi_albert_graph(N, m)
    return (G,)


@app.cell(hide_code=True)
def _(G, GillespieComplexContagion, base_infection_rate, num_seeds, plt):
    num_simulations = 100

    # Function to run multiple simulations and store results
    def run_multiple_trajectories(G, seed_selection, base_infection_rate, num_runs=100):
        """Run multiple Gillespie simulations and collect all trajectories."""
        all_results = []

        for _ in range(num_runs):
            # Select seed nodes based on strategy (hub or non-hub)
            if seed_selection == "hub":
                hub_nodes = sorted(G.degree, key=lambda x: x[1], reverse=True)[:num_seeds]
                seeds = [node for node, _ in hub_nodes]
            elif seed_selection == "non-hub":
                non_hub_nodes = sorted(G.degree, key=lambda x: x[1])[:num_seeds]
                seeds = [node for node, _ in non_hub_nodes]

            # Run simulation
            model = GillespieComplexContagion(G, seeds, base_infection_rate)
            results = model.run()

            # Store results
            all_results.append(results)

        return all_results

    # Run 100 simulations for both hub and non-hub seeding strategies
    results_hub = run_multiple_trajectories(G, "hub", base_infection_rate, num_simulations)
    results_non_hub = run_multiple_trajectories(G, "non-hub", base_infection_rate, num_simulations)

    # Plot all trajectories for hubs
    plt.figure(figsize=(8, 5))
    for result in results_hub:
        times_hub, active_counts_hub = zip(*result)
        plt.plot(times_hub, active_counts_hub, color='blue', alpha=0.3)  # Semi-transparent lines

    # Plot all trajectories for non-hubs
    for result in results_non_hub:
        times_nonhub, active_counts_nonhub = zip(*result)
        plt.plot(times_nonhub, active_counts_nonhub, color='red', alpha=0.3)  # Semi-transparent lines

    plt.xlabel("Time")
    plt.ylabel("Number of Active Nodes")
    plt.title("Opinion Diffusion: 100 Simulations (Hubs (blue) vs. Non-Hubs (red))")
    plt.show()
    return


@app.cell(hide_code=True)
def _(mo):
    mo.md(r"""
    <h2>About Gillespie simulations</h2>

    This algorithm makes it possible to simulate a spreading process (information, opinion, epidemics) accurately when randomness (stochasticity) matters, which is the case in small populations or when events happen infrequently.

    <h3>How does it work?</h3>
    Instead of the synchronous updates we have considered so far (which means updates are made a some fixed time intervals (and we don't really care about that interval), we now have a method that 'waits' for something to happen and then updates the system. The possible events depend on the dynamics considered but it could be: a recovery or an infection for an epidemic, or a change of opinion in a debate. So, first, the method determines the event probabilities since some events are more likely than others. For example, if only one person is infected, the chance of spreading the disease is low. If many people are infected, transmission is much more likely. Next, the method decides when the next event happens. Again, it doesn't just do this in a regular fashion. Instead, it randomly jumps forward in time based on how often events occur. If infections are frequent, the next event happens soon. If they’re rare, it takes longer. Once a time of event is decided, the method decides which event happens. If both infection and recovery are possible, the algorithm picks one probabilistically, so that outbreaks don’t always unfold the same way. The method updates the system -- e.g., the newly infected person or recovered individual is recorded --and the cycle repeats.

    <h3>Why should we use this?</h3>
    * This is more realistic for small groups. In a small group, randomness plays a big role.
    * This can captures bursts of activity: Unlike models that update everything at the same speed, Gillespie simulations naturally produce periods of rapid change (e.g., sudden outbreaks) and slow periods.
    * It is flexible: It works for different spreading mechanisms—epidemics, opinions, rumors, even cascading failures in networks.

    <h3>Reference</h3>
    The foundational paper that introduces this method is: Gillespie, D. T. (1977). "Exact stochastic simulation of coupled chemical reactions." Journal of Physical Chemistry, 81(25), 2340-2361.
    """)
    return


@app.cell(hide_code=True)
def _(mo):
    # Create sliders for parameters of the bounded confidence model
    tolerance_slider = mo.ui.slider(0.0, 1.0, value=0.2, step=0.05, label="Tolerance")
    convergence_slider = mo.ui.slider(0.0, 1.0, value=0.1, step=0.05, label="Convergence")
    p_slider = mo.ui.slider(0.0, 1.0, value=0.1, step=0.05, label="Wiring Probability (p)")
    return convergence_slider, p_slider, tolerance_slider


@app.cell(hide_code=True)
def _(convergence_slider, mo, p_slider, tolerance_slider):
    mo.md(f"""
    <h2>Bounded confidence model</h2>

    Here is the basic code needed to run a bounded confidence model on an ER graph with $N=100$ nodes. Use the sliders below to adjust the two key parameters of the model, namely, the tolerence "\"\" r"\"\"$\epsilon$"\"\" f"\"\" (default: 0.2) the convergence "\"\" r"\"\"$\mu$"\"\" f"\"\" (default: 0.1) and the wiring probability the ER graph p (default: 0.1):

    {tolerance_slider}
    {convergence_slider}
    {p_slider}
    """)
    return


@app.cell(hide_code=True)
def _(convergence_slider, mo, np, nx, p_slider, plt, tolerance_slider):
    def bounded_confidence_network():
        N = 100  # Number of agents
        tolerance = tolerance_slider.value  # Tolerance threshold
        convergence = convergence_slider.value  # Convergence rate
        p = p_slider.value  # Wiring probability for ER network

        # Generate an Erdős-Rényi (ER) network
        G = nx.erdos_renyi_graph(N, p)

        # Initialize opinions randomly in [0,1]
        opinions = np.random.rand(N)

        # Simulate the Bounded Confidence Model on the network
        num_iterations = 50
        opinion_history = [opinions.copy()]

        for _ in range(num_iterations):
            new_opinions = opinions.copy()
            for i in G.nodes():
                neighbors = list(G.neighbors(i))
                if neighbors:
                    close_neighbors = [n for n in neighbors if abs(opinions[n] - opinions[i]) < tolerance]
                    if close_neighbors:
                        new_opinions[i] += convergence * (np.mean([opinions[n] for n in close_neighbors]) - opinions[i])
            opinions = new_opinions.copy()
            opinion_history.append(opinions.copy())

        # Plot the evolution of opinions over time
        plt.figure(figsize=(8, 6))
        for i in range(N):
            plt.plot(range(num_iterations + 1), [op[i] for op in opinion_history], alpha=0.5)
        plt.xlabel("Time Step")
        plt.ylabel("Opinion Value")
        plt.title(f"Bounded Confidence Model on ER Network (p={p}, Tolerance={tolerance}, Convergence={convergence})")
        plt.show()

        return mo.md(f"""
        **Bounded Confidence Model on an Erdős-Rényi Network**
        - **Number of Agents (N)**: {N}
        - **Wiring Probability (p)**: {p}
        - **Tolerance (ε)**: {tolerance}
        - **Convergence Rate (μ)**: {convergence}
        - Each line represents an agent's opinion evolution over time.
        """)

    return (bounded_confidence_network,)


@app.cell(hide_code=True)
def _(bounded_confidence_network):
    bounded_confidence_network()
    return


@app.cell(hide_code=True)
def _(mo):
    p_rewire = mo.ui.slider(0.0, 1.0, value=0.6, step=0.05, label="Rewiring Probability")
    p_edge = mo.ui.slider(0.01, 0.5, value=0.1, step=0.01, label="Erdos-Renyi Edge Probability")
    return p_edge, p_rewire


@app.cell(hide_code=True)
def _(mo, p_edge, p_rewire):
    mo.md(f"""
    <h2>Coevolving networks and dynamics</h2>

    Here is the basic code needed to run an example of coevolving network and dynamics as per the lecture slides. Use the sliders below to adjust the key parameter of the model, namely, the rewiring probability p_rewire and the wiring probability of the ER graph:

    {p_rewire}
    {p_edge}
    """)
    return


@app.cell(hide_code=True)
def _(N, nx, p_edge, p_rewire, plt, random):

    def initialize_network(n, edge_probability):
        """Create an ER graph and assign random binary opinions."""
        G = nx.erdos_renyi_graph(n, edge_probability)
        opinions = {node: random.choice([0, 1]) for node in G.nodes()}
        return G, opinions

    def coevolution_step(G, opinions, p_rewire):
        """Perform a single coevolution step."""
        node = random.choice(list(G.nodes()))
        neighbors = list(G.neighbors(node))

        if not neighbors:
            return  # Skip if isolated node

        if random.random() < p_rewire:
            same_opinion_neighbors = [n for n in neighbors if opinions[n] == opinions[node]]
            if same_opinion_neighbors:
                chosen_neighbor = random.choice(same_opinion_neighbors)
                different_opinion_nodes = [n for n in G.nodes() if opinions[n] != opinions[node] and n not in neighbors]
                if different_opinion_nodes:
                    new_target = random.choice(different_opinion_nodes)
                    G.remove_edge(node, chosen_neighbor)
                    G.add_edge(node, new_target)
        else:
            chosen_neighbor = random.choice(neighbors)
            opinions[node] = opinions[chosen_neighbor]

    def simulate_coevolution(n, timesteps, p_rewire, p_edge):
        """Simulates coevolution of network and opinions."""
        G, opinions = initialize_network(n, p_edge)
        opinion_history = []

        for _ in range(timesteps):
            coevolution_step(G, opinions, p_rewire)
            opinion_history.append(sum(opinions.values()) / n)

        return G, opinions, opinion_history

    def plot_opinion_dynamics(opinion_history):
        """Plots the evolution of the fraction of nodes with opinion 1."""
        plt.figure(figsize=(8, 5))
        plt.plot(opinion_history, label='Fraction of Opinion 1')
        plt.xlabel("Time Step")
        plt.ylabel("Fraction of Nodes with Opinion 1")
        plt.title("Opinion Dynamics with Coevolution")
        plt.legend()
        plt.show()

    def plot_network(G, opinions):
        """Plots the network with node colors indicating opinions."""
        plt.figure(figsize=(8, 6))
        color_map = ['red' if opinions[node] == 0 else 'blue' for node in G.nodes()]
        nx.draw(G, with_labels=False, node_color=color_map, node_size=50, edge_color='gray')
        plt.title("Final Network Structure")
        plt.show()


    timesteps = 200

    G_coev, opinions, opinion_history = simulate_coevolution(N, timesteps, p_rewire.value, p_edge.value)
    plot_opinion_dynamics(opinion_history)
    plot_network(G_coev, opinions)
    return


if __name__ == "__main__":
    app.run()
