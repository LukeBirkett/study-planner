"""
helpers.py
==========
Utility functions for data processing, network analysis, and viz.

"""

# -----------------------------------------------------------------------------
# FILE STRUCTURE
# 1. IMPORTS
# 2. CONSTANTS & CONFIGURATION
# 3. STATSBOMB CALLS
# 4. DATA PROCESSING & TRANSFORMATIONS
# 5. NETWORK & GRAPH ANALYSIS
# 6. PLOTTING & VISUALIZATION UTILITIES
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# 1. IMPORTS
# -----------------------------------------------------------------------------
# Standard library imports
import copy
import itertools
import warnings
from typing import Callable, Dict, List, Optional, Tuple, Any

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
FIG_SIZE = (6.5, 9.0)

POSITION_MAP_11 = {
    # Center Backs
    "Center Back": "CB",
    "Left Center Back": "CB",
    "Right Center Back": "CB",
    # Goalkeeper
    "Goalkeeper": "GK",
    # Fullbacks/Wingbacks (Left)
    "Left Back": "LB",
    "Left Wing Back": "LB",
    # Fullbacks/Wingbacks (Right)
    "Right Back": "RB",
    "Right Wing Back": "RB",
    # Defensive/Central Midfielders
    "Left Defensive Midfield": "DM",
    "Center Defensive Midfield": "DM",
    "Right Defensive Midfield": "DM",
    # Central Midfielders
    "Left Center Midfield": "CM",
    "Right Center Midfield": "CM",
    # Attacking Midfielders
    "Center Attacking Midfield": "CAM",
    "Right Attacking Midfield": "CAM",
    "Left Attacking Midfield": "CAM",
    # Strikers/Forwards
    "Center Forward": "ST",
    "Left Center Forward": "ST",
    "Right Center Forward": "ST",
    # Wide Left
    "Left Wing": "LM",
    "Left Midfield": "LM",
    # Wide Right
    "Right Wing": "RM",
    "Right Midfield": "RM",
}




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
# 4. DATA PROCESSING & TRANSFORMATIONS
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


def bin_coordinates(coord_tuple, grid_size=(10, 10)):
    """
    Normalizes coordinates and bin.
    """
    x,y=coord_tuple[0],coord_tuple[1]
    n_rows, n_cols = grid_size

    # Normalize StatsBomb coordinates to 0-100 scale
    x_norm = (np.asarray(x) / 120.0) * 100.0
    y_norm = (np.asarray(y) / 80.0) * 100.0

    # Calculate bin sizes
    bin_size_x = 100.0 / n_cols
    bin_size_y = 100.0 / n_rows

    # Map to matrix row (y-axis) and column (x-axis)
    x_rows = np.clip((x_norm // bin_size_x).astype(int), 0, n_cols - 1)
    y_cols = np.clip((y_norm // bin_size_y).astype(int), 0, n_rows - 1)

    if np.isscalar(x) and np.isscalar(y):
        return int(x_rows), int(y_cols)

    return list(zip(x_rows, y_cols))


def extract_first_position(positions: Any) -> str | None:
    """Extracts the first recorded position from a StatsBomb positions list."""
    if isinstance(positions, list) and len(positions) > 0:
        return positions[0].get('position')
    return None


def extract_match_lineup_positions(match_id: int) -> List[Dict[str, Any]]:
    """Fetches lineup data for a single match and returns recipient position mappings."""
    match_lineups = sb.lineups(match_id=match_id)
    records = []

    for _, lineup_df in match_lineups.items():
        for _, player in lineup_df.iterrows():
            first_pos = extract_first_position(player.get('positions', []))
            if first_pos:
                records.append({
                    'match_id': match_id,
                    'pass_recipient_id': player['player_id'],
                    'recipient_position': first_pos
                })
    return records

def build_lineup_lookup(match_ids: List[int]) -> pd.DataFrame:
    """Creates a deduplicated positional lookup table for a list of match IDs."""
    all_positions = [
        pos 
        for match_id in match_ids 
        for pos in extract_match_lineup_positions(match_id)
    ]
    
    if not all_positions:
        return pd.DataFrame(columns=['match_id', 'pass_recipient_id', 'recipient_position'])

    return (
        pd.DataFrame(all_positions)
        .drop_duplicates(subset=['match_id', 'pass_recipient_id'], keep='first')
    )


def filter_successful_passes(events_df: pd.DataFrame) -> pd.DataFrame:
    """Filters events DataFrame for successful pass events only."""
    is_pass = events_df['type'] == 'Pass'
    is_successful = events_df['pass_outcome'].isna()
    return events_df[is_pass & is_successful].copy()


def select_available_columns(df: pd.DataFrame, required_cols: List[str]) -> pd.DataFrame:
    """Selects only the columns from required_cols that exist in the DataFrame."""
    available_cols = [col for col in required_cols if col in df.columns]
    return df[available_cols]


def enrich_passes_with_positions(passes_df: pd.DataFrame, lookup_df: pd.DataFrame) -> pd.DataFrame:
    """Merges passes with position lookup, validating many-to-one constraints."""
    return passes_df.merge(
        lookup_df,
        on=['match_id', 'pass_recipient_id'],
        how='left',
        validate='many_to_one'
    )


def map_position(position_name):
    """Maps a single StatsBomb position string to its 11-class taxonomy equivalent.

    Returns None if the position is unrecognized or NaN.
    """
    return POSITION_MAP_11.get(position_name, None)


def condense_recipient_positions(passes_df: pd.DataFrame) -> pd.DataFrame:
    """Maps granular position strings to broader positional groupings."""
    return passes_df.assign(
        recipient_position_11=passes_df['recipient_position'].map(POSITION_MAP_11)
    )


def extract_passes_with_recipient_position(events_df: pd.DataFrame) -> pd.DataFrame:
    """
    Main pipeline function orchestrating the transformation sequence using Method Chaining/Piping.
    """
    REQUIRED_COLUMNS = [
        'id', 'match_id', 'type', 'location', 'possession_team',
        'player', 'position', 'possession_team_id', 'pass_end_location',
        'pass_recipient', 'pass_recipient_id', 'pass_length'
    ]

    # Build lookup table from unique matches in events
    unique_matches = events_df['match_id'].unique().tolist()
    lineup_lookup = build_lineup_lookup(unique_matches)

    # Execute functional data pipeline via pandas .pipe()
    processed_passes = (
        events_df
        .pipe(filter_successful_passes)
        .pipe(select_available_columns, required_cols=REQUIRED_COLUMNS)
        .pipe(enrich_passes_with_positions, lookup_df=lineup_lookup)
        .pipe(condense_recipient_positions)
    )

    # Apply row-by-row using .apply()
    processed_passes['pass_start_bin'] = processed_passes['location'].apply(bin_coordinates)
    processed_passes['pass_end_bin'] = processed_passes['pass_end_location'].apply(bin_coordinates)

    return processed_passes


















# -----------------------------------------------------------------------------
# 5. NETWORK & GRAPH ANALYSIS
# -----------------------------------------------------------------------------

def build_passmap_network(match_record: dict, events_df: Optional[pd.DataFrame] = None) -> nx.DiGraph:
    """Constructs a weighted, directed NetworkX graph (nx.DiGraph) for a team passmap.
    
    Parameters
    ----------
    match_record : dict
        A team-match dictionary containing 'match_id', 'team', and 'top_11_players'.
    events_df : pd.DataFrame, optional
        Pre-loaded events DataFrame for the match. If None, fetches directly via API.
            
    Returns
    -------
    nx.DiGraph
        Directed passmap graph.
    """
    # Compile the Match-Team records
    m_id = match_record["match_id"]
    team_name = match_record["team"]
    top_11_players = match_record["top_11_players"]
    top_11_ids = {p['Player ID'] for p in top_11_players}
    player_id_to_name = {p['Player ID']: p['Player Name'] for p in top_11_players}
    
    # API Fallback
    if events_df is None:
        events_df = sb.events(match_id=m_id)

    # Extract raw pass (Edges) and Position (Node) information
    passes_df = extract_top11_pass_events(events_df, team_name, top_11_ids)
    avg_locations = compute_player_average_positions(passes_df)
    
    G = nx.DiGraph(
    team_name=team_name,
    total_passes=match_record["total_passes"]
    )

    # Construct the network nodes from the 11 players
    for p in top_11_players:
        p_id, p_name, p_pos = p['Player ID'], p['Player Name'], p['Position']
        loc = avg_locations.get(p_id, {'x': 50.0, 'y': 50.0})
        
        G.add_node(
            p_name,
            player_id=p_id,
            position=p_pos,
            pos=(loc['x'], loc['y']),
            x=loc['x'],
            y=loc['y']
        )
        
    edges = aggregate_pass_edges(passes_df, player_id_to_name)
    for passer, recipient, weight in edges:
        G.add_edge(passer, recipient, weight=weight)

    G.graph["true_total_passes"] = sum(d.get('weight', 0) for _, _, d in G.edges(data=True))
        
    return G


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
    # PLAYER-LEVEL DEGREE & STRENGTH METRICS
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
    # HUB DETECTION (Rank-Ordered by Pass Volume)
    # -------------------------------------------------------------------------
    mean_s_tot = metrics_df["Total Volume (s_tot)"].mean()
    
    hubs_df = metrics_df.reset_index()[
        ["Player", "Position", "Total Volume (s_tot)", "k_in (In-Degree)", "k_out (Out-Degree)"]
    ].head(top_n_hubs).copy()
    
    hubs_df.insert(0, "Rank", range(1, len(hubs_df) + 1))
    hubs_df["Relative Volume (s_i / <s_tot>)"] = (hubs_df["Total Volume (s_tot)"] / mean_s_tot).round(2) if mean_s_tot > 0 else 0
    
    return metrics_df, macro_metrics, hubs_df

import numpy as np
import pandas as pd
import networkx as nx


def calculate_average_shortest_path(G):
    """
    Computes the inverted distance matrix, all-pairs shortest path matrix, 
    and global average shortest path length (d) using Dijkstra's algorithm.
    
    Parameters:
        G (nx.DiGraph): Directed NetworkX graph with 'weight' edge attributes.
        
    Returns:
        d_global (float): Team-wide average shortest path length.
        distance_matrix_df (pd.DataFrame): N x N matrix of shortest topological distances (p_ij).
        player_path_df (pd.DataFrame): Player-level mean outgoing and incoming path lengths.
    """
    # 1. Create a copy to avoid mutating the original graph
    G_dist = G.copy()
    
    # 2. Add inverted weight transformation: l_ij = 1 / w_ij
    for u, v, data in G_dist.edges(data=True):
        weight = data.get('weight', 1)
        if weight > 0:
            data['distance'] = 1.0 / weight
        else:
            data['distance'] = np.inf

    # 3. Compute All-Pairs Shortest Paths via Dijkstra's Algorithm
    # dict of dicts: path_lengths[source][target] = distance
    path_lengths = dict(nx.all_pairs_dijkstra_path_length(G_dist, weight='distance'))
    
    # Convert path lengths into an N x N DataFrame (p_ij matrix)
    nodes = list(G_dist.nodes())
    distance_matrix_df = pd.DataFrame(index=nodes, columns=nodes, dtype=float)
    
    for src in nodes:
        for tgt in nodes:
            if src == tgt:
                distance_matrix_df.loc[src, tgt] = 0.0
            else:
                # If path exists, store length; otherwise np.nan (unreachable)
                distance_matrix_df.loc[src, tgt] = path_lengths.get(src, {}).get(tgt, np.nan)
                
    # 4. Compute Global Average Shortest Path Length (d)
    # Exclude diagonal (i == j)
    off_diagonal_mask = ~np.eye(len(nodes), dtype=bool)
    valid_distances = distance_matrix_df.values[off_diagonal_mask]
    
    # Filter out any unobserved/infinite paths (if graph is not strongly connected)
    valid_distances = valid_distances[~np.isnan(valid_distances)]
    
    d_global = np.mean(valid_distances)
    
    # 5. Extract Player-Level Path Averages (Outward reachability vs. Inward accessibility)
    # Mean Outgoing Path: How efficiently player_i can reach all other teammates
    # Mean Incoming Path: How efficiently all other teammates can reach player_i
    player_paths = []
    for player in nodes:
        # Exclude self-distance (0.0)
        out_paths = [distance_matrix_df.loc[player, tgt] for tgt in nodes if tgt != player]
        in_paths = [distance_matrix_df.loc[src, player] for src in nodes if src != player]
        
        player_paths.append({
            "Player": player,
            "Position": G.nodes[player].get("position", "N/A"),
            "Mean Outward Path Length (d_out)": np.mean(out_paths),
            "Mean Inward Path Length (d_in)": np.mean(in_paths)
        })
        
    player_path_df = pd.DataFrame(player_paths).set_index("Player")
    player_path_df = player_path_df.sort_values(by="Mean Outward Path Length (d_out)")
    
    return d_global, distance_matrix_df, player_path_df


import numpy as np
import pandas as pd
import networkx as nx




def calculate_betweenness_centrality(G, distance_matrix_df=None):
    """
    Computes weighted shortest-path betweenness centrality for a directed passing network.
    
    Parameters:
        G (nx.DiGraph): Directed NetworkX graph with 'weight' edge attributes.
        distance_matrix_df (pd.DataFrame, optional): Pre-computed distance matrix from Part 1.
        
    Returns:
        betweenness_df (pd.DataFrame): Player-level betweenness centrality scores.
    """
    G_dist = G.copy()

    # normalize/scale weights
    for u, v, data in G_dist.edges(data=True):
        weight = data.get('weight', 1)
        if weight > 0:
            data['distance'] = 1.0 / weight
        else:
            data['distance'] = np.inf

    # 2. Calculate Weighted Betweenness Centrality using shortest paths (normalized=True by default)
    # NetworkX automatically accounts for directed edges and path weights.
    betweenness_dict = nx.betweenness_centrality(G_dist, weight='distance', normalized=True)
    
    # 3. Compile into a DataFrame
    nodes = list(G_dist.nodes())
    betweenness_data = []
    
    for node in nodes:
        betweenness_data.append({
            "Player": node,
            "Position": G.nodes[node].get("position", "N/A"),
            "Betweenness Centrality g(i)": betweenness_dict.get(node, 0.0)
        })
        
    betweenness_df = pd.DataFrame(betweenness_data).set_index("Player")
    
    # Sort by betweenness score descending (highest bridge/control value first)
    betweenness_df = betweenness_df.sort_values(by="Betweenness Centrality g(i)", ascending=False)
    
    return betweenness_df, betweenness_dict





def calculate_transitive_triad_intensity(G):
    """
    Computes Pure Transitive Triad Intensity (I_transitive) for a weighted passing network.
    Exclusively evaluates progressive wall-passes and multi-option forward combinations:
    (a -> b, b -> c, a -> c), weighted by minimum channel throughput min(w_ab, w_bc, w_ac).
    
    Returns:
        global_I_team (float): Average team-wide transitive triad intensity.
        triad_df (pd.DataFrame): Player-level Transitive Triad Intensity scores.
        active_triads (list): List of detected transitive triads with players, capacities, and permutations.
    """
    nodes = list(G.nodes())
    player_triad_scores = {node: 0.0 for node in nodes}
    active_triads = []
    
    # Extract weighted adjacency matrix (NumPy)
    W = nx.to_numpy_array(G, nodelist=nodes, weight='weight')
    node_to_idx = {node: idx for idx, node in enumerate(nodes)}
    idx_to_node = {idx: node for node, idx in node_to_idx.items()}
    
    # Iterate over all unique 3-player combinations (i, j, k)
    for triplet in itertools.combinations(nodes, 3):
        i, j, k = triplet
        idx_i, idx_j, idx_k = node_to_idx[i], node_to_idx[j], node_to_idx[k]
        
        triplet_capacity_sum = 0.0
        triplet_permutations = []
        perms = list(itertools.permutations([idx_i, idx_j, idx_k]))
        
        # Loop through cominations of a,b,c
        for p in perms:
            a, b, c = p
            w_ab = W[a, b]
            w_bc = W[b, c]
            w_ac = W[a, c]
            
            # EXCLUSIVELY TRANSITIVE: a -> b, b -> c, a -> c
            # atleast one pass in each relationship forms a cluster
            if w_ab > 0 and w_bc > 0 and w_ac > 0:
                cap = min(w_ab, w_bc, w_ac) 
                triplet_capacity_sum += cap # cluster is weighted by lowest pair
                triplet_permutations.append({
                    "origin": idx_to_node[a],
                    "intermediate": idx_to_node[b],
                    "target": idx_to_node[c],
                    "capacity": cap
                })
                
        # If valid transitive structures exist for this 3-player set
        if triplet_capacity_sum > 0:
            player_triad_scores[i] += triplet_capacity_sum
            player_triad_scores[j] += triplet_capacity_sum
            player_triad_scores[k] += triplet_capacity_sum
            
            active_triads.append({
                "players": (i, j, k),
                "total_capacity": triplet_capacity_sum,
                "permutations": triplet_permutations
            })

    # Compute Team-Wide Global Average
    global_I_team = float(np.mean(list(player_triad_scores.values())))

    # Min-Max Normalization Calculations
    scores = np.array(list(player_triad_scores.values()))
    min_score, max_score = scores.min(), scores.max()

    score_range = max_score - min_score

    # Calculate normalized team score
    global_I_team_norm = (
        float((global_I_team - min_score) / score_range)
        if score_range > 0
        else 0.0
    )
    
    # Format into Player DataFrame
    triad_data = []
    for node in nodes:
        raw_score = player_triad_scores[node]

        # 0.0 - 1.0 Min-Max scaling across squad
        norm_score = (
            (raw_score - min_score) / score_range if score_range > 0 else 0.0
        )

        # % of highest individual involvement
        rel_score = (raw_score / max_score) if max_score > 0 else 0.0

        triad_data.append({
            "Player": node,
            "Position": G.nodes[node].get("position", "N/A"),
            "Raw Intensity": round(raw_score, 2),
            "Normalized (0-1)": round(norm_score, 3),
            "Relative to Max": round(rel_score, 3),
        })

    player_triad_df = pd.DataFrame(triad_data).set_index("Player")
    player_triad_df = player_triad_df.sort_values(
        by="Raw Intensity", ascending=False
    )

    # Sort active triads by highest bottleneck capacity
    active_triads = sorted(active_triads, key=lambda x: x["total_capacity"], reverse=True)
    
    return global_I_team, global_I_team_norm, player_triad_df, active_triads


def compute_league_global_shortest_paths(match_records):
    """Computes global average shortest path (d) and pass counts for all team-match pairs in the empirical dataset.

    Parameters:
        integrated_match_records (list): List of match records, where each entry
          contains: [match_index, match_id, team_name, total_passes,
          player_list, top_11_players]

    Returns:
        league_df (pd.DataFrame): Empirical dataset of (Match_ID, Team,
        Total_Passes, d_global)
    """
    results = []

    for record in match_records:
        m_id = record['match_id']
        team_name = record['team']
        total_passes = record['total_passes']
        formation = record['formation']

        # Build the network for this specific team and match
        G = build_passmap_network(record)
        d_global, _, _ = calculate_average_shortest_path(G)

        results.append({
            "Match_ID": m_id,
            "Team": team_name,
            "Total_Passes": G.graph.get('true_total_passes', 'Team'),
            "d_global": d_global,
            "Formation": formation
        })

    league_df = pd.DataFrame(results)
    return league_df

def evaluate_global_d(G, league_df, d_attr="d_global"):
    """Compares a network's global value directly against a league distribution."""

    # Compute Network Metric
    network_global, _, _ = calculate_average_shortest_path(G)
    
    # Benchmark rank, percentile
    series = league_df[d_attr]
    sorted_series = series.sort_values(ascending=True).reset_index(drop=True)
    rank = np.searchsorted(sorted_series, network_global) + 1
    percentile = stats.percentileofscore(series, network_global, kind="strict")
    z_score = (network_global - series.mean()) / series.std()

    print(f"{' EMPIRICAL POSITION REPORT ':=^50}")
    print(
        f"Case Study d_global:  {network_global:.4f}\n"
        f"League Range:         [{series.min():.4f} to {series.max():.4f}]\n"
        f"League Mean ± Std:    {series.mean():.4f} ± {series.std():.4f}\n"
        f"{'-'*50}\n"
        f"Absolute Rank:        {rank} / {len(series)}\n"
        f"Percentile Score:     {percentile:.2f}%\n"
        f"{'-'*50}\n"
    )

    return rank, percentile, (
        series.min(), series.max(), series.mean(), series.std())


def generate_erdos_renyi_null_incremental(G_empirical: nx.DiGraph, seed: Optional[int] = None) -> nx.DiGraph:
    """Generates a G(N, p) Erdős–Rényi directed null network preserving node attributes

    and total pass volume via uniform incremental pass distribution.
    """
    if seed is not None: np.random.seed(seed)

    # Construct null and attributes
    G_null = nx.DiGraph(
        team_name=f"{G_empirical.graph.get('team_name', 'Team')} (ER Null)",
        total_passes=G_empirical.graph.get("total_passes", 0),
        true_total_passes=G_empirical.graph.get("true_total_passes", 0)
    )

    # Copy the nodes from the input network
    G_null.add_nodes_from(G_empirical.nodes(data=True))
    
    nodes = list(G_null.nodes())
    N = len(nodes)
    if N < 2:
        return G_null

    # Compute Erdős–Rényi connection probability p
    total_volume = G_empirical.graph.get("true_total_passes", 0)
    num_edges = G_empirical.number_of_edges()
    max_edges = N * (N - 1)
    p = num_edges / max_edges if max_edges > 0 else 0.0

    # Vectorized Bernoulli trials to sample active directed pairs G(N, p)
    all_pairs = [(u, v) for u in nodes for v in nodes if u != v]
    active_mask = np.random.binomial(1, p, size=len(all_pairs)).astype(bool)
    active_edges = [pair for pair, active in zip(all_pairs, active_mask) if active]

    # Fallback safeguard: guarantee at least 1 channel if trials yield 0
    if not active_edges and all_pairs:
        active_edges = [all_pairs[np.random.choice(len(all_pairs))]]

    # Allocate pass volume uniformly across active channels
    chosen_indices = np.random.choice(len(active_edges), size=total_volume)
    unique_pairs, counts = np.unique(chosen_indices, return_counts=True)

    # Populate null network edges
    for idx, count in zip(unique_pairs, counts):
        u, v = active_edges[idx]
        G_null.add_edge(u, v, weight=int(count))

    return G_null


def generate_whole_edge_rewired_null(
    G_empirical, n_swaps_factor=10, max_attempts=100000, seed=None
):
    """Generates a Directed Whole-Edge Degree-Preserving Rewired Null Model

    (Configuration Model).
    """
    import random 

    if seed is not None: random.seed(seed)

    G_null = nx.DiGraph()
    G_null.add_nodes_from(G_empirical.nodes(data=True))

    edges = list(G_empirical.edges(data=True))
    if len(edges) < 2: return G_empirical.copy()

    # Format: [(u1, v1, weight1), ...]
    edge_list = [(u, v, d.get("weight", 1)) for u, v, d in edges]
    num_edges = len(edge_list)
    target_swaps = num_edges * n_swaps_factor

    adj_set = set((u, v) for u, v, _ in edge_list)

    successful_swaps = 0
    attempts = 0


    while successful_swaps < target_swaps and attempts < max_attempts:
        attempts += 1

        # Fast native selection of two distinct edge indices
        idx1, idx2 = random.sample(range(num_edges), 2)
        u1, v1, w1 = edge_list[idx1]
        u2, v2, w2 = edge_list[idx2]

        # Ensure all 4 involved nodes are distinct to avoid self-loops and redundant swaps
        if len({u1, v1, u2, v2}) < 4:
            continue

        new_edge1 = (u1, v2)
        new_edge2 = (u2, v1)

        # Check if proposed directed edges exist in current graph state
        if (new_edge1 not in adj_set) and (new_edge2 not in adj_set):
            # Update lookup set
            adj_set.remove((u1, v1))
            adj_set.remove((u2, v2))
            adj_set.add(new_edge1)
            adj_set.add(new_edge2)

            # Update edge list while keeping original edge weight vectors intact
            edge_list[idx1] = (u1, v2, w1)
            edge_list[idx2] = (u2, v1, w2)

            successful_swaps += 1

    print(f"total rewiring attempts: {attempts}")
    print(f"successful rewires: {successful_swaps}")

    for u, v, weight in edge_list:
        G_null.add_edge(u, v, weight=weight)

    return G_null


def compute_adjacency_correlation(G_orig: nx.DiGraph, G_null: nx.DiGraph) -> float:
    """Computes Pearson's correlation coefficient (r) between the flattened adjacency

    matrices of the empirical network and rewired null network.
    """
    # 1. Align node orders
    nodes = list(G_orig.nodes())

    # 2. Extract weighted adjacency matrices as 1D vectors
    adj_orig = nx.to_numpy_array(G_orig, nodelist=nodes, weight="weight").ravel()
    adj_null = nx.to_numpy_array(G_null, nodelist=nodes, weight="weight").ravel()

    # 3. Pearson correlation coefficient matrix -> extract r (off-diagonal element)
    corr_matrix = np.corrcoef(adj_orig, adj_null)

    return float(corr_matrix[0, 1])


def compute_top_k_edge_retention(
    G_orig: nx.DiGraph, G_null: nx.DiGraph, top_percent: float = 0.25
) -> float:
    """Calculates the proportion of the top-k% highest-weighted edges from the empirical

    network that persist as active edges in the rewired null network.
    """
    # 1. Extract and rank empirical edges by weight
    orig_edges = [
        (u, v, data.get("weight", 1)) for u, v, data in G_orig.edges(data=True)
    ]
    orig_edges.sort(key=lambda x: x[2], reverse=True)

    # 2. Isolate top k% strongest edge pairs
    k = max(1, int(np.ceil(len(orig_edges) * top_percent)))
    top_k_pairs = {(u, v) for u, v, _ in orig_edges[:k]}

    # 3. Check persistence in the rewired network
    retained_count = sum(1 for u, v in top_k_pairs if G_null.has_edge(u, v))

    return float(retained_count / k)



# -----------------------------------------------------------------------------
# 6. PLOTTING & VISUALIZATION UTILITIES
# -----------------------------------------------------------------------------

def draw_vertical_pitch(ax=None, pitch_color='#f4f6f4', line_color='#708090', zorder=0):
    """Draws a vertical football pitch on a 100x100 relative coordinate grid.
    
    Coordinates:
    - X (0 to 100): Horizontal Axis (Width - Touchline to Touchline)
    - Y (0 to 100): Vertical Axis (Length - Defending Goal at Y=0 to Attacking Goal at Y=100)
    """
    if ax is None:
        fig, ax = plt.subplots(figsize=FIG_SIZE)
        
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
        fig, ax = plt.subplots(figsize=FIG_SIZE)
    
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
    if ax is None: fig, ax = plt.subplots(figsize=FIG_SIZE, facecolor='#ffffff')
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
    team_name = G.graph["team_name"]
    total_passes = G.graph["total_passes"]
    true_total_passes = G.graph["true_total_passes"]

    title_text = f"PassMap Network: {team_name}\n {total_passes} ({true_total_passes}) Total Passes"
    if metric_name is not None and global_metric is not None:
        title_text += f"\n{metric_name}: {global_metric}"
    
    ax.set_title(title_text, fontsize=12, fontweight='bold', color='black', pad=1)
    
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
        fig, ax = plt.subplots(figsize=FIG_SIZE, facecolor='#ffffff')

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


def plot_path_length_scatterplot(player_path_df, d_global, team_name="Arsenal WFC"):
    """
    Plots a quadrant scatter plot comparing Mean Outward Path Length (d_out) 
    vs. Mean Inward Path Length (d_in) for each player.
    """
    fig, ax = plt.subplots(figsize=(9,6.5), facecolor="#ffffff")
    
    # Seaborn Scatter Plot
    sns.scatterplot(
        data=player_path_df,
        x="Mean Inward Path Length (d_in)",
        y="Mean Outward Path Length (d_out)",
        s=120,
        color="crimson",
        edgecolor="black",
        linewidth=1.2,
        zorder=5,
        ax=ax
    )
    
    # Add Mean Reference Lines (Quadrant Dividers)
    mean_in = player_path_df["Mean Inward Path Length (d_in)"].mean()
    mean_out = player_path_df["Mean Outward Path Length (d_out)"].mean()
    
    ax.axvline(mean_in, color="#808080", linestyle="--", alpha=0.7, label=f"Mean $d_{{in}}$ ({mean_in:.3f})")
    ax.axhline(mean_out, color="#808080", linestyle=":", alpha=0.7, label=f"Mean $d_{{out}}$ ({mean_out:.3f})")
    
    # Annotate Player Names
    for player, row in player_path_df.iterrows():
        short_name = player.split()[-1]  # Extract surname for clean plotting
        ax.text(
            row["Mean Inward Path Length (d_in)"] + 0.002,
            row["Mean Outward Path Length (d_out)"] + 0.002,
            short_name,
            fontsize=6,
            fontweight="bold",
            color="#222222"
        )
        
    # 4. Add Quadrant Tactical Labels
    xlim = ax.get_xlim()
    ylim = ax.get_ylim()

    # High d_in, High d_out (Bottom Right quadrant of plot area)
    ax.text(xlim[1] - (xlim[1]-xlim[0])*0.30, ylim[1] - (ylim[1]-ylim[0])*0.08, 
            "⚠ Peripheral Outlets\n(High $d_{in}$, High $d_{out}$)", 
            fontsize=9, fontweight="bold", color="darkred", alpha=0.8)
    
    # 5. Styling & Labels
    ax.set_title(
        f"Inward vs. Outward Path Accessibility — {team_name}\nGlobal Team Mean ($d_{{global}}$): {d_global:.3f}",
        fontsize=8,
        fontweight="bold",
        pad=12
    )
    ax.set_xlabel("Mean Inward Path Length ($d_{in}$) — How easily teammates find player", fontsize=10, fontweight="bold")
    ax.set_ylabel("Mean Outward Path Length ($d_{out}$) — How easily player reaches teammates", fontsize=10, fontweight="bold")
    
    ax.grid(True, linestyle="--", alpha=0.4)
    ax.legend(loc="upper left")
    sns.despine(ax=ax)
    
    plt.tight_layout()
    plt.show()


def plot_transitive_triads_updated( 
    G,
    triads, 
    top_n=4, 
    palette=["#00E676", "#FFD600", "#00E5FF", "#FF6D00", "#E040FB", "#7C4DFF"],
    ax=None
):
    """
    Plots active transitive triads as layered polygon patches, edge networks,
    and node overlays on a pitch axis.
    """
    if ax is None: 
            fig, ax = plt.subplots(figsize=FIG_SIZE, facecolor='#ffffff')
    

    node_positions = {node: (data['y'], data['x']) for node, data in G.nodes(data=True)}

    # Filter down to triads that have valid coordinates for all 3 players
    valid_triads = triads[:top_n]
    print(valid_triads[0])
    print(valid_triads[1])
    print(valid_triads[2])
    print(valid_triads[3])

    # Find max capacity to scale transparency dynamically
    max_capacity = max(t.get("total_capacity", 1.0) for t in valid_triads) or 1.0

    # Render Polygons and Edges
    for idx, triad in enumerate(valid_triads):
        p1, p2, p3 = triad["players"]
        color = palette[idx % len(palette)]
        coords = [node_positions[p] for p in (p1, p2, p3)]
        
        # Calculate dynamic transparency (between 0.15 and 0.45)
        capacity = triad.get("total_capacity", max_capacity)
        alpha_val = 0.15 + 0.30 * (capacity / max_capacity)

        # Polygon fill
        poly = Polygon(
            coords,
            closed=True,
            facecolor=color,
            edgecolor="none",
            alpha=alpha_val,
            zorder=3,
        )
        ax.add_patch(poly)

        # Crisp polygon border
        poly_border = Polygon(
            coords,
            closed=True,
            facecolor="none",
            edgecolor=color,
            linewidth=1.8,
            linestyle="-",
            alpha=0.8,
            zorder=4,
        )
        ax.add_patch(poly_border)


def plot_league_pass_distribution(league, G):
    """Plots the empirical distribution of total pass volumes across all team-matches in the dataset."""
    sns.set_theme(style="whitegrid")
    fig, ax = plt.subplots(figsize=(8, 5), facecolor="#ffffff")

    team_name = G.graph.get('team_name', 'Team')
    team_passes = G.graph.get('true_total_passes', 0)
    league_mean = league["Total_Passes"].mean()

    # #  Histogram w/ Bins
    sns.histplot(
        data=league,
        x="Total_Passes",
        kde=True,
        color="#2b5c8f",
        bins=range(0, 1001, 100),
        ax=ax,
    )

    # Add Reference Lines
    league_mean = league["Total_Passes"].mean()

    ax.axvline(
        team_passes,
        color="crimson",
        linestyle="--",
        linewidth=2,
        label=f"{team_name} Case Study ({team_passes} Passes)",
    )

    ax.axvline(
        league_mean,
        color="black",
        linestyle=":",
        linewidth=1.5,
        label=f"League Mean ({league_mean:.1f} Passes)",
    )

    # Formatting
    ax.set_title(
        f"Empirical League Distribution of Team Pass Volumes (N={len(league)})",
        fontsize=12,
        fontweight="bold",
        pad=12,
    )

    ax.set_xlabel("Total Team Passes in Match", fontsize=10, fontweight="bold")
    ax.set_ylabel("Match Frequency", fontsize=10, fontweight="bold")
    ax.set_xlim(0, 1000)
    ax.legend(loc="upper right")
    sns.despine(ax=ax)

    plt.tight_layout()
    plt.show()


def draw_pitch_with_grid(
    original_pitch_func,
    ax=None,
    grid_size=(10, 10),
    grid_color="#888888",
    grid_linestyle="--",
    grid_alpha=0.5,
    show_bin_labels=False,
    **kwargs,
):
    """Wraps any original pitch-drawing function and overlays a spatial grid

    without modifying the original function.
    """
    ax = original_pitch_func(ax=ax, **kwargs)
    if ax is None: return ax

    n_rows, n_cols = grid_size
    x_step = 100.0 / n_cols
    y_step = 100.0 / n_rows

    # Statsbomb X = length of pitch, row/horiztonal lines
    # Statbomb Y  = width of pitch, col/vertical lines

    # Draw Vertical Grid Lines: "Y"
    for c in range(1, n_cols):
        x = c * x_step
        ax.plot(
            [x, x],
            [0, 100],
            color=grid_color,
            linestyle=grid_linestyle,
            alpha=grid_alpha,
            lw=1,
            zorder=1,
        )

    # Draw Horizontal Grid Lines: "X"
    for r in range(1, n_rows):
        y = r * y_step
        ax.plot(
            [0, 100],
            [y, y],
            color=grid_color,
            linestyle=grid_linestyle,
            alpha=grid_alpha,
            lw=1,
            zorder=1,
        )

    # Label matrix (row, col) indices
    if show_bin_labels:
        for r in range(n_rows):
            for c in range(n_cols):
                center_x = (c + 0.5) * x_step
                center_y = (r + 0.5) * y_step
                ax.text(
                    center_x,
                    center_y,
                    f"({r},{c})",
                    color=grid_color,
                    fontsize=7,
                    ha="center",
                    va="center",
                    alpha=0.7,
                    zorder=2,
                )

    return ax