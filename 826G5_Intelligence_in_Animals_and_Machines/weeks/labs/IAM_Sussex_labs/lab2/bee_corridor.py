import sys
# relative path to folder which contains Sandbox
sys.path.insert(1, '../..')
from Sandbox import *

import matplotlib.pyplot as plt
from matplotlib import rc
import numpy as np
import math
from tqdm import tqdm

from typing import Tuple

# a controller for a bee which will make it just fly upwards in y-axis,
# or steer slightly to left/right based on balance between optic flow on its
# left and right sides
class OpticFlowController(NewBeeController):

    # initialise controller
    def __init__(self, vel=25, margin=0.00025, window_n=60):
        # call super constructor
        super().__init__(inputs_n=4, step_fun=None)

        # construct correlators for left/right sensor pairs
        self.left_corr = HRCorrelator(hp_fc=0.05, lp_fc=10)
        self.right_corr = HRCorrelator(hp_fc=0.05, lp_fc=10)

        # histories of correlators' outputs
        self.left_hist = [0.]
        self.right_hist = [0.]

        # histories of correlators' outputs moving averages
        self.left_means = [0.]
        self.right_means = [0.]

        # controller parameters
        self.vel = vel
        self.margin = margin
        self.window_n = window_n

    # step controller forwards in time
    def step(self, inputs: List[float], dt: float, theta: float, speed: float, heading: float) -> List[float]:

        # step correlators forwards and store results
        self.left_hist.append(self.left_corr.step(inputs[0], inputs[1], dt))
        self.right_hist.append(self.right_corr.step(inputs[2], inputs[3], dt))

        # default heading is straight up in the y-axis
        desired_heading = (math.pi/2)

        # compute moving averages
        left = np.mean(self.left_hist[-self.window_n:])
        right = np.mean(self.right_hist[-self.window_n:])
        # store moving averages for plotting later
        self.left_means.append(left)
        self.right_means.append(right)

        # angle, in radians, to steer left or right depending on imbalance between correlator moving averages
        d = 0.025
        # if moving averages are close enough to equal (i.e. balanced), then fly straight ahead
        if np.abs(left-right) < self.margin: # this margin parameter is more important than it might look!
            pass                         # - too big, andf the bee won't find the centre - too small, and it will zig-zag too much!
        elif left < right:
            desired_heading += d # steer to the left
        else:
            desired_heading -= d # steer to the right

        # proportional feedback controller
        heading_command = 1 * (desired_heading - heading)

        # return commands for bee's body orientation, linear speed, and flight heading
        return [0, self.vel, heading_command]

# parameters for plots
plt.rcParams["font.weight"] = "bold"
rc('axes', linewidth=2)
font_size = 18

# open axes for plotting
ig, ax = plt.subplots()
fig2, ax2 = plt.subplots()
fig3, ax3 = plt.subplots()

# number of times to run simulation
n = 10
# run simulation n times
for i in tqdm(range(n)):

    # construct wall
    w = 6
    right_wall = Wall(x=w)
    left_wall = Wall(x=-w)
    white_space = 20
    black_space = white_space
    y3 = black_space
    while right_wall.y_top < 1500:
        right_wall.add_patch(y_top=y3+white_space, y_bottom=y3)
        left_wall.add_patch(y_top=y3+white_space, y_bottom=y3)
        y3 += white_space + black_space

    # construct controller
    controller = OpticFlowController(vel=50, margin=0.0075, window_n=200)

    # sensor parameters
    fov = math.pi / 120
    d_angle = math.pi/24
    sensor_offset = math.pi/12

    # use this to turn noise on/off
    use_noise = False

    # no noisemakers by default
    noisemakers = [None, None, None, None]

    # set up noisemakers, if noise is being used
    if use_noise:
        for j in range(len(noisemakers)):
            # noise parameters for the robot's front sensor
            max_white_noise = 0.2
            min_white_noise = -0.
            max_brown_noise_step = 0.01
            spike_noise_prob = 0.03
            pos_spike_size = 0.05
            neg_spike_size = -0.05

            # construct noise source for robot's front sensor
            noisemakers[j] = NoiseMaker(white_noise_params=[max_white_noise, min_white_noise], brown_noise_step=max_brown_noise_step, spike_noise_params=[spike_noise_prob, pos_spike_size, neg_spike_size])

    sensors = [PatchSensor(wall=left_wall, x=0, y=0, theta=0, FOV=fov, noisemaker=noisemakers[0]),
               PatchSensor(wall=left_wall, x=0, y=0, theta=0, FOV=fov, noisemaker=noisemakers[1]),
               PatchSensor(wall=right_wall, x=0, y=0, theta=0, FOV=fov, noisemaker=noisemakers[2]),
               PatchSensor(wall=right_wall, x=0, y=0, theta=0, FOV=fov, noisemaker=noisemakers[3])]

    sensor_angles = [sensor_offset + (math.pi/2) - d_angle,
                     sensor_offset + (math.pi/2) + d_angle,
                     sensor_offset + (-math.pi/2) + d_angle,
                     sensor_offset + (-math.pi/2) - d_angle]


    # construct bee
    bee_x = random_in_interval(minimum=-(w-2), maximum=w-2)
    bee = NewBee(x=bee_x, y=40, theta=math.pi/2, heading=math.pi/2, controller=controller, sensors=sensors, sensor_angles=sensor_angles, max_speed=100)
    # allow bee's heading to change instantaneously
    bee.heading_motor.motor_inertia_coeff = 1

    sensors[0].colour='red'
    sensors[1].colour='green'
    sensors[2].colour='blue'
    sensors[3].colour='yellow'

    # simulation time parameter and variables
    dt = 0.01
    t = 0
    ts = [t]

    # simulate until bee reaches top of corridor, or hits either wall
    while (bee.y < right_wall.y_top) and (bee.x > left_wall.x) and (bee.x  < (right_wall.x-1)):
        bee.step(dt)
        t += dt
        ts.append(t)

    left_wall.draw(ax)
    right_wall.draw(ax)
    ax.plot(bee.xs, bee.ys)
    ax.set_title('Bee trajectories', fontsize=font_size, fontweight='bold')

    # these plots are only produced for the *last* simulation run
    if i == (n-1):
        ax3.plot(ts, bee.controller.left_corr.outputs, label='left')
        ax3.plot(ts, bee.controller.right_corr.outputs, label='right')
        ax3.plot(ts, np.array(bee.controller.right_corr.outputs) - np.array(bee.controller.left_corr.outputs), label='right-left', linewidth=3)
        ax3.plot([ts[0], ts[-1]], [0, 0], 'r--')
        ax3.set_title('Correlators', fontsize=font_size, fontweight='bold')
        ax3.legend()
        ax3.set_xlabel('t', fontsize=font_size, fontweight='bold')
        ax3.set_ylabel('Correlator output', fontsize=font_size, fontweight='bold')


        ax2.plot(ts, bee.headings)
        ax2.plot([ts[0], ts[-1]], [math.pi/2, math.pi/2], 'r--')
        ax2.set_xlabel('t', fontsize=font_size, fontweight='bold')
        ax2.set_ylabel('Bee heading (radians)', fontsize=font_size, fontweight='bold')
        ax2.set_title('Bee heading', fontsize=font_size, fontweight='bold')
        ax2.tick_params(axis='both', which='major', labelsize=font_size)


        plt.figure()
        plt.plot(ts, bee.sensors[0].activations, label='front')
        plt.plot(ts, bee.sensors[1].activations, label='back')
        plt.title('Left sensors')
        plt.xlabel('t', fontsize=font_size, fontweight='bold')
        plt.ylabel('Sensor outputs', fontsize=font_size, fontweight='bold')
        plt.legend()

        plt.figure()
        plt.plot(ts, bee.sensors[2].activations, label='front')
        plt.plot(ts, bee.sensors[3].activations, label='back')
        plt.title('Right sensors')
        plt.xlabel('t', fontsize=font_size, fontweight='bold')
        plt.ylabel('Sensor outputs', fontsize=font_size, fontweight='bold')
        plt.legend()

        plt.figure()
        plt.plot(ts, bee.controller.left_means, label='left')
        plt.plot(ts, bee.controller.right_means, label='right')
        plt.title("Controller correlator moving averages", fontsize=font_size, fontweight='bold')
        plt.xlabel('t', fontsize=font_size, fontweight='bold')
        plt.ylabel('Average outputs', fontsize=font_size, fontweight='bold')
        plt.legend()

plt.show()
