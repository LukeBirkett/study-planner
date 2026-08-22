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


# -----------------------------------------------------------------------------
# 4. NETWORK & GRAPH ANALYSIS
# -----------------------------------------------------------------------------



# -----------------------------------------------------------------------------
# 5. PLOTTING & VISUALIZATION UTILITIES
# -----------------------------------------------------------------------------
