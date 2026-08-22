"""
helpers.py
==========
Utility functions for data processing, network analysis, and viz.

"""

# -----------------------------------------------------------------------------
# 1. IMPORTS
# -----------------------------------------------------------------------------
# Standard library imports
import copy
import itertools
import warnings
from typing import Callable, Dict, List, Optional, Tuple

import matplotlib.pyplot as plt
from matplotlib.patches import Arc, Circle, Polygon, Rectangle
import networkx as nx
import numpy as np
import pandas as pd
import seaborn as sns
from scipy import stats
from statsbombpy import sb
from statsbombpy.api_client import NoAuthWarning


# -----------------------------------------------------------------------------
# 2. CONSTANTS & CONFIGURATION
# -----------------------------------------------------------------------------
PITCH_LENGTH = 120.0
PITCH_WIDTH = 80.0


# -----------------------------------------------------------------------------
# 3. STATSBOMB CALLS
# -----------------------------------------------------------------------------
# helpers.py

def parse_player_minutes(player_entry: dict, max_minute: int) -> Optional[dict]:
    """Parses individual player minutes, start status, and position from StatsBomb lineup payload.
    
    Parameters
    ----------
    player_entry : dict
        A single player dict from the StatsBomb lineup list.
    max_minute : int
        The total duration (max minute) of the match.
        
    Returns
    -------
    dict or None
        Structured dictionary with player stats, or None if unplayed.
    """
    positions = player_entry.get('positions', [])
    if not positions:
        return None  # Unused substitute

    start_info = positions[0]
    end_info = positions[-1]
    pos = start_info.get('position')

    # Started Match
    if start_info.get('start_reason') == 'Starting XI':
        _from = 0
        if start_info.get('end_reason') == 'Final Whistle' or end_info.get('end_reason') == 'Final Whistle':
            to = max_minute
        else:
            to = parse_minute(end_info.get('to'), default_val=max_minute)
    # Came on as substitute
    else:
        _from = parse_minute(start_info.get('from'), default_val=max_minute)
        if end_info.get('to'):
            to = parse_minute(end_info.get('to'), default_val=max_minute)
        else:
            to = max_minute

    return {
        "Player Name": player_entry.get('player_name'),
        "Player ID": player_entry.get('player_id'),
        "Position": pos,
        "Starting Minute": _from,
        "Ending Minute": to,
        "Minutes Played": max(0, to - _from),
    }


def extract_team_roster(lineup_df: pd.DataFrame, max_minute: int) -> list[dict]:
    """Extracts played player metadata for a single team's lineup DataFrame."""
    team_players = []
    # Iterate through lineup records
    for _, player in lineup_df.iterrows():
        p_dict = parse_player_minutes(player.to_dict(), max_minute)
        if p_dict:
            team_players.append(p_dict)
    return team_players


def fetch_match_details(match_id: int) -> tuple[pd.DataFrame, dict, int]:
    """Fetches event stream and team lineups for a given match ID.
    
    Returns
    -------
    tuple
        (events, lineups_dict, max_minute)
    """
    events = sb.events(match_id=match_id)
    match_length = int(events['minute'].max()) if 'minute' in events.columns else 90
    lineups = sb.lineups(match_id=match_id)
    return events, lineups, match_length


def extract_team_formation(events_df: pd.DataFrame, team_name: str) -> str:
    """Extracts the starting tactical formation code for a team from events data."""
    starting_xi = events_df[
        (events_df["team"] == team_name) & (events_df["type"] == "Starting XI")
    ]
    if starting_xi.empty:
        return "Unknown"

    if "tactics_formation" in starting_xi.columns:
        formation = starting_xi["tactics_formation"].iloc[0]
        return str(int(formation)) if pd.notna(formation) else "Unknown"

    # Fallback if tactics is stored as a dictionary payload
    tactics_dict = starting_xi["tactics"].iloc[0]
    if isinstance(tactics_dict, dict):
        return str(tactics_dict.get("formation", "Unknown"))

    return "Unknown"


def extract_successful_passes(events_df: pd.DataFrame, team_name: str) -> pd.DataFrame:
    """Filters events to return only successful completed passes for a team."""
    return events_df[
        (events_df["team"] == team_name)
        & (events_df["type"] == "Pass")
        & (events_df["pass_outcome"].isna())
    ]



# -----------------------------------------------------------------------------
# 3. DATA PROCESSING & TRANSFORMATIONS
# -----------------------------------------------------------------------------

def scale_coord(val, axis='x'):
    """
    Scales StatsBomb pitch coordinates (120x80) to a standard percentage scale (0-100).
    """
    if val is None or pd.isna(val):
        return val
        
    axis = str(axis).lower()
    if axis == 'x':
        return (val / PITCH_LENGTH) * 100.0
    elif axis == 'y':
        return (val / PITCH_WIDTH) * 100.0
    else:
        raise ValueError("Axis must be 'x' or 'y'.")


def parse_minute(val, default_val=0):
    """Safely extracts the minute integer from a StatsBomb 'from' or 'to' timestamp."""
    if val is None:
        return default_val
    if isinstance(val, (int, float)):
        return int(val)
    if isinstance(val, str) and ':' in val:
        return int(val.split(':')[0])  # Take 'MM' from 'MM:SS'
    try:
        return int(val)
    except ValueError:
        return default_val

def extract_11_players(player_list):
    """Used to turn a teams match roster into an 11 player list"""
    sorted_players = sorted(player_list, key=lambda x: x['Minutes Played'], reverse=True)
    top_11_players = sorted_players[:11]
    return top_11_players

def calculate_league_summary_stats(match_records: List[dict]) -> dict:
    """Computes league/season-level aggregate summary statistics from match records.
    
    Parameters
    ----------
    match_records : list of dict
        Extracted match records containing 'full_roster' and 'total_passes'.
        
    Returns
    -------
    dict
        Aggregated statistics including match counts, average pass volume, 
        and player usage metrics.
    """
    if not match_records:
        return {}

    total_team_games = len(match_records)
    total_matches = int(total_team_games / 2)

    # Active player metrics per team-game
    players_used_per_game = [len(m["full_roster"]) for m in match_records]
    
    # Pass volume metrics per team-game
    passes_per_team_game = [m["total_passes"] for m in match_records]
    total_passes = sum(passes_per_team_game)

    return {
        "total_matches": total_matches,
        "total_team_games": total_team_games,
        "total_passes": total_passes,
        "mean_passes": np.mean(passes_per_team_game),
        "min_passes": np.min(passes_per_team_game),
        "max_passes": np.max(passes_per_team_game),
        "mean_players_used": np.mean(players_used_per_game),
        "min_players_used": np.min(players_used_per_game),
        "max_players_used": np.max(players_used_per_game),
    }


def extract_top11_pass_events(events_df: pd.DataFrame, team_name: str, top_11_ids: set) -> pd.DataFrame:
    """Filters events for completed passes strictly involving a team's top 11 players."""
    passes_df = events_df[
        (events_df['team'] == team_name) & 
        (events_df['type'] == 'Pass') & 
        (events_df['pass_outcome'].isna()) &
        (events_df['player_id'].isin(top_11_ids)) & 
        (events_df['pass_recipient_id'].isin(top_11_ids))
    ].copy()
    
    # Scale spatial coordinates using standard pitch dimensions
    passes_df['x'] = passes_df['location'].apply(lambda loc: scale_coord(loc[0], axis='x') if isinstance(loc, list) else None)
    passes_df['y'] = passes_df['location'].apply(lambda loc: scale_coord(loc[1], axis='y') if isinstance(loc, list) else None)
    
    return passes_df




# -----------------------------------------------------------------------------
# 4. NETWORK & GRAPH ANALYSIS
# -----------------------------------------------------------------------------

def compute_player_average_positions(passes_df: pd.DataFrame) -> dict:
    """Calculates the average (x, y) pitch location for each player based on pass locations."""
    if passes_df.empty:
        return {}
    return passes_df.groupby('player_id')[['x', 'y']].mean().to_dict('index')


def aggregate_pass_edges(passes_df: pd.DataFrame, player_id_to_name: dict) -> list[tuple[str, str, int]]:
    """Aggregates completed pass counts between player pairs into graph edge tuples."""
    pass_counts = passes_df.groupby(['player_id', 'pass_recipient_id']).size().reset_index(name='weight')
    
    edges = []
    for _, row in pass_counts.iterrows():
        passer = player_id_to_name[row['player_id']]
        recipient = player_id_to_name[row['pass_recipient_id']]
        weight = int(row['weight'])
        edges.append((passer, recipient, weight))
        
    return edges

def filter_graph_edges(G, min_weight=5):
    """
    Returns a copy of a NetworkX DiGraph with edges below min_weight removed.
    Preserves all graph-level, node, and edge attributes.
    """
    # Create a copy to keep the original G intact
    G_sub = G.copy()
    
    # Prune edges
    weak_edges = [
        (u, v) for u, v, data in G_sub.edges(data=True) 
        if data.get('weight', 0) < min_weight
    ]
    G_sub.remove_edges_from(weak_edges)
    
    # Update graph title metadata if desired
    G_sub.graph['min_weight_threshold'] = min_weight
    
    return G_sub


def analyze_degree_and_heterogeneity(G, top_n_hubs=5):
    """
    Computes player-level degree/strength metrics, team-level Freeman Centralization,
    macro network heterogeneity statistics, and top hub rankings for a passing network.
    
    Parameters:
        G (nx.DiGraph): Directed NetworkX graph with 'weight' edge attributes.
        top_n_hubs (int): Number of top hubs to extract.
        
    Returns:
        metrics_df (pd.DataFrame): Player-level metric calculations.
        macro_metrics (dict): Team-level centralization and heterogeneity stats.
        hubs_df (pd.DataFrame): Rank-ordered table of top hub players.
    """
    nodes = list(G.nodes())
    N = len(nodes)
    
    # -------------------------------------------------------------------------
    # 1. PLAYER-LEVEL DEGREE & STRENGTH METRICS
    # -------------------------------------------------------------------------
    in_degree = dict(G.in_degree())
    out_degree = dict(G.out_degree())
    in_strength = dict(G.in_degree(weight='weight'))
    out_strength = dict(G.out_degree(weight='weight'))
    total_degree = dict(G.degree())
    
    player_metrics = []
    
    for node in nodes:
        k_in = in_degree[node]
        k_out = out_degree[node]
        s_in = in_strength[node]
        s_out = out_strength[node]
        s_tot = s_in + s_out
        
        # Directional Asymmetry
        net_flow = s_out - s_in
        pass_ratio = s_out / s_in if s_in > 0 else np.nan
            
        player_metrics.append({
            "Player": node,
            "Position": G.nodes[node].get("position", "N/A"),
            "k_in (In-Degree)": k_in,
            "k_out (Out-Degree)": k_out,
            "s_in (Passes Rec.)": s_in,
            "s_out (Passes Comp.)": s_out,
            "Total Volume (s_tot)": s_tot,
            "Net Flow (Δs_i)": net_flow,
            "Pass Ratio (s_out / s_in)": round(pass_ratio, 2)
        })
        
    metrics_df = pd.DataFrame(player_metrics).set_index("Player")
    metrics_df = metrics_df.sort_values(by="Total Volume (s_tot)", ascending=False)

    # -------------------------------------------------------------------------
    # NETWORK HETEROGENEITY METRICS
    # -------------------------------------------------------------------------
    degrees = np.array(list(total_degree.values()))
    mean_k = np.mean(degrees) if N > 0 else 0
    var_k = np.var(degrees) if N > 0 else 0
    std_k = np.std(degrees) if N > 0 else 0
    second_moment = np.mean(degrees**2) if N > 0 else 0
    
    cv_k = std_k / mean_k if mean_k > 0 else 0
    norm_second_moment = second_moment / mean_k if mean_k > 0 else 0
    
    macro_metrics = {
        # Centralization Stats
        "Team Node Volume Variance Var(s_tot)": float(np.var(metrics_df["Total Volume (s_tot)"])),
        # Heterogeneity Stats
        "Mean Unweighted Degree <k>": float(mean_k),
        "Degree Variance Var(k)": float(var_k),
        "Degree Std Dev σ_k": float(std_k),
        "Second Moment <k^2>": float(second_moment),
        "Coefficient of Variation (CV_k)": float(cv_k),
        "Normalized Second Moment (<k^2> / <k>)": float(norm_second_moment)
    }
    
    # -------------------------------------------------------------------------
    # 4. HUB DETECTION (Rank-Ordered by Pass Volume)
    # -------------------------------------------------------------------------
    mean_s_tot = metrics_df["Total Volume (s_tot)"].mean()
    
    hubs_df = metrics_df.reset_index()[
        ["Player", "Position", "Total Volume (s_tot)", "k_in (In-Degree)", "k_out (Out-Degree)"]
    ].head(top_n_hubs).copy()
    
    hubs_df.insert(0, "Rank", range(1, len(hubs_df) + 1))
    hubs_df["Relative Volume (s_i / <s_tot>)"] = (hubs_df["Total Volume (s_tot)"] / mean_s_tot).round(2) if mean_s_tot > 0 else 0
    
    return metrics_df, macro_metrics, hubs_df




# -----------------------------------------------------------------------------
# 5. PLOTTING & VISUALIZATION UTILITIES
# -----------------------------------------------------------------------------

def draw_vertical_pitch(ax=None, pitch_color='#f4f6f4', line_color='#708090', zorder=0):
    """Draws a vertical football pitch on a 100x100 relative coordinate grid.
    
    Coordinates:
    - X (0 to 100): Horizontal Axis (Width - Touchline to Touchline)
    - Y (0 to 100): Vertical Axis (Length - Defending Goal at Y=0 to Attacking Goal at Y=100)
    """
    if ax is None:
        fig, ax = plt.subplots(figsize=(8, 11))
        
    ax.set_facecolor(pitch_color)
    
    line_kwargs = dict(color=line_color, lw=1.5, zorder=zorder)
    rect_kwargs = dict(fill=False, edgecolor=line_color, lw=1.5, zorder=zorder)
    
    # 1. Outer Boundary & Halfway Line
    ax.add_patch(Rectangle((0, 0), 100, 100, fill=False, edgecolor=line_color, lw=2, zorder=zorder))
    ax.plot([0, 100], [50, 50], **line_kwargs)
    
    # Center circle & spot
    ax.add_patch(Circle((50, 50), 12, **rect_kwargs))
    ax.add_patch(Circle((50, 50), 0.8, fill=True, color=line_color, zorder=zorder))

    # 2. Defensive End (Bottom / GK Area: Y = 0 to 18)
    ax.add_patch(Rectangle((20, 0), 60, 18, **rect_kwargs))
    ax.add_patch(Rectangle((36, 0), 28, 6, **rect_kwargs))
    ax.add_patch(Circle((50, 12), 0.8, fill=True, color=line_color, zorder=zorder))
    ax.add_patch(Arc((50, 18), width=20, height=20, angle=0, theta1=0, theta2=180, **line_kwargs))

    # 3. Attacking End (Top / GK Area: Y = 82 to 100)
    ax.add_patch(Rectangle((20, 82), 60, 18, **rect_kwargs))
    ax.add_patch(Rectangle((36, 94), 28, 6, **rect_kwargs))
    ax.add_patch(Circle((50, 88), 0.8, fill=True, color=line_color, zorder=zorder))
    ax.add_patch(Arc((50, 82), width=20, height=20, angle=0, theta1=180, theta2=360, **line_kwargs))

    # 4. Corner Arcs
    ax.add_patch(Arc((0, 0), width=6, height=6, angle=0, theta1=0, theta2=90, **line_kwargs))
    ax.add_patch(Arc((100, 0), width=6, height=6, angle=0, theta1=90, theta2=180, **line_kwargs))
    ax.add_patch(Arc((0, 100), width=6, height=6, angle=0, theta1=270, theta2=360, **line_kwargs))
    ax.add_patch(Arc((100, 100), width=6, height=6, angle=0, theta1=180, theta2=270, **line_kwargs))

    # 5. Axis Limits & Formatting
    ax.set_xlim(-5, 105)
    ax.set_ylim(-5, 105)
    ax.set_aspect('equal')
    ax.axis('off')
    
    return ax


def plot_player_raw_passes(events_df: pd.DataFrame, team_name: str, player_name=None, ax=None) -> plt.Axes:
    """Plots all successful completed passes for an individual player on a pitch underlay."""
    if ax is None:
        fig, ax = plt.subplots(figsize=(3, 6))
    
    # Draw pitch background
    draw_vertical_pitch(ax)

    # Extract raw passes
    mask = (
        events_df['team'] == team_name) & (
            events_df['type'] == 'Pass') & (
                events_df['pass_outcome'].isna()
        )
    
    if player_name is not None: mask &= (events_df['player'] == player_name)

    passes = events_df[mask]
    if passes.empty: return ax

    # Scale coordinates directly into vectors
    x_start = passes['location'].apply(lambda loc: scale_coord(loc[1], 'y'))
    y_start = passes['location'].apply(lambda loc: scale_coord(loc[0], 'x'))
    x_end = passes['pass_end_location'].apply(lambda loc: scale_coord(loc[1], 'y'))
    y_end = passes['pass_end_location'].apply(lambda loc: scale_coord(loc[0], 'x'))

    # Vectorized arrow plot
    ax.quiver(x_start, y_start, x_end - x_start, y_end - y_start, 
        angles='xy', scale_units='xy', scale=1, width=0.005, zorder=3
    )
    ax.scatter(x_start, y_start, s=20, zorder=4)

    if player_name is None:
        ax.set_title(f"{team_name} Pass Map", fontsize=10)
    else:
        ax.set_title(f"{player_name} Pass Map", fontsize=10)

    return ax


def plot_passmap_on_pitch(
    G,  
    metric_name=None, 
    global_metric=None, 
    node_scores=None, 
    min_size=200, 
    max_size=1200,
    ax=None
):
    """
    Overlays a NetworkX passmap graph onto a custom vertical pitch.
    """
    if ax is None: fig, ax = plt.subplots(figsize=(8, 11), facecolor='#ffffff')
    draw_vertical_pitch(ax=ax)
    

    # Map Coordinates: (y, x) -> (width, length)
    pos_vertical = {node: (data['y'], data['x']) for node, data in G.nodes(data=True)}
    

    # Create offset position for text labels (y-offset prevents vertical overlap)
    label_pos = {node: (coords[0], coords[1] - 3.5) for node, coords in pos_vertical.items()}


    # Node Labels: Last Name Only
    initials_labels = {
        node: f"{node.split()[0][0]}.{node.split()[-1][0]}."
        for node in G.nodes()
    }
    

    # Scale edge weights dynamically for arrow width
    edges = G.edges()
    raw_weights = [G[u][v].get('weight', 1.0) for u, v in edges]
    max_weight = max(raw_weights) if raw_weights else 1.0
    # Scales line width smoothly between 1.0 and 6.0
    weights = [1.0 + (w / max_weight) * 5.0 for w in raw_weights]


    # Node Sizing Logic
    if node_scores:
        valid_scores = [v for v in node_scores.values() if v is not None]
        max_score = max(valid_scores) if valid_scores else 1.0
        
        node_sizes = [
            min_size + (node_scores.get(node, 0.0) / (max_score if max_score > 0 else 1.0)) * (max_size - min_size)
            for node in G.nodes()
        ]
    else:
        node_sizes = 400 

    font_size = 6
    arrowsize = 10

    # Draw Edges with Curvature
    nx.draw_networkx_edges(
        G, pos_vertical, 
        ax=ax,
        edge_color="#5c5c5c",
        alpha=0.6,
        width=weights,
        arrowstyle='->',             
        arrowsize=10,                   
        connectionstyle="arc3,rad=0.08"  
    )
    
    # Draw Player Nodes
    nx.draw_networkx_nodes(
        G, pos_vertical, 
        ax=ax,
        node_size=node_sizes, 
        node_color='crimson',
        edgecolors='white',
        linewidths=2
    )
    
    # 8Draw Player Name Labels
    nx.draw_networkx_labels(
        G, pos_vertical, 
        labels=initials_labels,
        ax=ax,
        font_size=font_size, 
        font_color='white', 
        font_weight='bold'
    )
    
    # Title Formatting
    title_text = f"PassMap Network Topology\n{G.graph["team_name"]} ({G.graph["total_passes"]} Total Passes)"
    if metric_name is not None and global_metric is not None:
        title_text += f"\n{metric_name}: {global_metric}"
    
    ax.set_title(title_text, fontsize=14, fontweight='bold', color='black', pad=15)
    
    return ax


def plot_passmap_frameless(
    G, 
    metric_name=None, 
    global_metric=None, 
    node_scores=None, 
    min_size=400, 
    max_size=1500,
    ax=None
):
    """
    Plots a PassMap NetworkX graph off the pitch, maximizing its size to fill
    the figure frame while preserving relative spatial player layout.
    """
    if ax is None: 
        fig, ax = plt.subplots(figsize=(8, 10), facecolor='#ffffff')

    # Extract spatial coordinates from graph nodes
    raw_x = [data['x'] for _, data in G.nodes(data=True)]
    raw_y = [data['y'] for _, data in G.nodes(data=True)]

    
    # Get bounding box of the player positions
    min_x, max_x = min(raw_x), max(raw_x)
    min_y, max_y = min(raw_y), max(raw_y)

    
    # Range safeguards against division by zero
    range_x = (max_x - min_x) if (max_x - min_x) > 0 else 1.0
    range_y = (max_y - min_y) if (max_y - min_y) > 0 else 1.0

    
    # Normalize coordinates (y -> horizontal width, x -> vertical length) to range [0.05, 0.95]
    # Leaving 0.05 margin ensures node circles/labels don't get clipped at the borders
    pos_frameless = {}
    for node, data in G.nodes(data=True):
        norm_y = 0.05 + 0.90 * ((data['y'] - min_y) / range_y)
        norm_x = 0.05 + 0.90 * ((data['x'] - min_x) / range_x)
        pos_frameless[node] = (norm_y, norm_x)


    # Generate Centered Initials for Nodes ("Emily Ann Fox" -> "E.F.")
    initials_labels = {
        node: f"{node.split()[0][0]}.{node.split()[-1][0]}."
        for node in G.nodes()
    }


    # Scale Edge Weights for Line Width
    edges = G.edges()
    raw_weights = [G[u][v].get('weight', 1.0) for u, v in edges]
    max_weight = max(raw_weights) if raw_weights else 1.0
    weights = [1.5 + (w / max_weight) * 6.0 for w in raw_weights]


    # Dynamic Node Sizing
    if node_scores:
        valid_scores = [v for v in node_scores.values() if v is not None]
        max_score = max(valid_scores) if valid_scores else 1.0
        node_sizes = [
            min_size + (node_scores.get(node, 0.0) / (max_score if max_score > 0 else 1.0)) * (max_size - min_size)
            for node in G.nodes()
        ]
    else:
        node_sizes = 800


    # Draw Edges with Curvature
    nx.draw_networkx_edges(
        G, pos_frameless, 
        ax=ax,
        edge_color='#5c5c5c',
        alpha=0.6,
        width=weights,
        arrowsize=16,
        connectionstyle="arc3,rad=0.15"
    )


    # Draw Player Nodes
    nx.draw_networkx_nodes(
        G, pos_frameless, 
        ax=ax,
        node_size=node_sizes, 
        node_color='crimson',
        edgecolors='white',
        linewidths=2
    )


    # Draw Player Initials Centered inside Nodes
    nx.draw_networkx_labels(
        G, pos_frameless, 
        labels=initials_labels,
        ax=ax,
        font_size=9, 
        font_color='white', 
        font_weight='bold'
    )


    # Frame Maximization: Allow flexible aspect ratio and remove white space
    ax.set_aspect('auto')
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis('off')  # Hide pitch lines and box borders

    # Title Formatting using Graph Attributes
    team_name = G.graph.get('team_name', 'Team')
    total_passes = G.graph.get('total_passes', 0)
    
    title_text = f"PassMap Network Topology\n{team_name} ({total_passes} Total Passes)"
    if metric_name is not None and global_metric is not None:
        title_text += f"\n{metric_name}: {global_metric}"
        
    ax.set_title(title_text, fontsize=13, fontweight='bold', color='black', pad=10)

    return ax