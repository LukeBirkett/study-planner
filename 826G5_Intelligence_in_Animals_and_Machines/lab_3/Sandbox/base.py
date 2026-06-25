import numpy as np
import math
import time
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import matplotlib.transforms as mtransforms

from typing import Dict, Any, Union, List, Callable, Tuple

pygame = None
try:
    import pygame
except:
    print("WARNING: pygame module not found, visualisations will not be shown. " +
          "You should be able to install pygame with:\n" +
          "     pip install pygame")

####################################################################################
#                           utility functions begin
####################################################################################

# for any two angles, return difference in the interval of [-pi, pi]
def angle_difference(angle1: float, angle2: float) -> float:
    diff = (angle1 - angle2) % (2*math.pi)
    if diff > math.pi:
        diff -= (2*math.pi)
    return diff

# generate random number from uniform interval
# - numpy already has a function for this, but I wrote this and used it in many places before thinking to check that
def random_in_interval(minimum: float=0, maximum: float=1) -> float:
    width = maximum - minimum
    return (width * np.random.random()) + minimum

####################################################################################
#                           utility functions end
####################################################################################
####################################################################################
#                           System class begins
####################################################################################

# Conceptually, all entities in the simulation are systems. For this reason,
# all other classes inherit from this one.
class System:
    # construct System. Many systems have xy-coordinates and orientations (theta),
    # but for some, such as Controllers and Disturbances, it is not normally useful
    # to give them these variables.
    # For those systems, has_position and/or has_orientation are set to False.

    '''
        Every object in a Sandox simulation is an instance of a subclass of the abstract class :class:`System`. In some cases, this is for conceptual reasons rather than practical ones, e.g. in the case of a :class:`DisturbanceSource`, which certainly can be considered a system but which doesn't currently inherit anything from :class:`System` (although this may well change in a future implementation).
    '''
    def __init__(self, x: float=None, y: float=None, theta: float=None):
        """
            __init__(x: float=None, y: float=None, theta: float=None)

            Construct :class:`System`. If either ``x`` or ``y`` are specified in the call to ``init``, then the system will have position and will keep a history of both its x- and y-coordinates over time. If ``theta`` is specified in the call to ``__init__``, then the system has orientation, and will keep a history of its orientation over time.

            :param x: The system's x-coordinate. Defaults to `None`.
            :type x: float

            :param y: The system's y-coordinate. Defaults to `None`.
            :type y: float

            :param theta: The system's angular orientation. Defaults to `None`. In *Sandbox*, orientations are in radians.
            :type theta: float
        """
        self.has_position = (x is not None) or (y is not None)
        if self.has_position:
            self.init_xy(x, y)
        self.has_orientation = theta is not None
        if self.has_orientation:
            self.init_theta(theta)

    # systems with position and/or orientation will *need* to call this method,
    # from their own step method
    def step(self, dt: float) -> None:
        '''
            Step the :class:`System` forwards in time. Subclasses of :class:`System` will generally override this method, to implement class-specific functionality, but they will also need to call this method if they have either position or orientation, as this is where the history of thos variables over time gets updated.

            :param dt: The interval of time to integrate the system over. Currently unused here, but will often be used in subclasses.
            :type dt: float
        '''
        if self.has_position:
            self.xs.append(self.x)
            self.ys.append(self.y)
        if self.has_orientation:
            self.thetas.append(self.theta)

    def get_data(self) -> Dict[str, Union[float, List[float]]]:
        '''
            A function to get the data from a :class:`System`, in the form of a string-keyed dict. If a :class:`System` has position, then its current coordinates plus their histories will be included in the data. If a :class:`System` has orientation, then its current orientation and its orientation history are incuded in the data.

            These data, as and when they are included in the returned dict, can be accessed with the following keys:

            * current x-coordinate: ``data["x"]``
            * history of x-coordinates over time: ``data["xs"]``
            * current y-coordinate: ``data["y"]``
            * history of y-coordinates over time: ``data["ys"]``
            * current orientation: ``data["theta"]``
            * history of orientations over time: ``data["thetas"]``

            :return: The System's data.
            :rtype: dict
        '''
        data: Dict[str, Union[float, List[float]]] = {"x": None, "y": None,
                                                      "theta": None, "xs": None,
                                                      "ys": None, "thetas": None,
                                                      "classname": "System"}
        if self.has_position:
            data["xs"] = self.xs
            data["x"] = self.x
            data["ys"] = self.ys
            data["y"] = self.y
        if self.has_orientation:
            data["thetas"] = self.thetas
            data["theta"] = self.theta

        return data

    def reset(self) -> None:
        '''
            Reset :class:`System` to its original state upon its construction, e.g. so that it can be re-used in another simulation run.
        '''
        if self.has_position:
            self.init_xy(self.xs[0], self.ys[0])
        if self.has_orientation:
            self.init_theta(self.thetas[0])

    def get_data_and_reset(self) -> Dict[str, dict]:
        '''
            Reset :class:`System` to its original state and return its data.
        '''
        data = self.get_data()
        self.reset()
        return data

    def init_xy(self, x: float, y: float) -> None:
        '''
            Set the systems initial x- and y-coordinates to the passed in values.

            :param x: The system's x-coordinate.
            :type x: float

            :param y: The system's y-coordinate.
            :type y: float
        '''
        self.x = x
        self.y = y
        self.xs = [x]
        self.ys = [y]

    def init_theta(self, theta: float) -> None:
        '''
            Set the systems initial orientation to the passed in value.

            :param theta: The system's orientation.
            :type theta: float
        '''
        self.theta = theta
        self.thetas = [theta]

    def perturb(self):
        pass
