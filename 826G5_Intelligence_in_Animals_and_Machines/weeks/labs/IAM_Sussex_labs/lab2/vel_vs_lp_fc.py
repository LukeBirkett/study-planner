import sys
# relative path to folder which contains Sandbox
sys.path.insert(1, '../..')
from Sandbox import *

import matplotlib.pyplot as plt
from matplotlib import rc
import numpy as np
import math
from multiprocessing import Pool
from itertools import product
from tqdm import tqdm
from time import *

# function for running the simulation once, with the given velocity and LPF corner frequency parameters
def run_once(y_vel, lp_fc):

    # construct wall
    right_wall = Wall(x=wall_x)
    white_space = patch_h
    black_space = patch_h
    y3 = black_space
    while right_wall.y_top < 700:
        right_wall.add_patch(y_top=y3+white_space, y_bottom=y3)
        y3 += white_space + black_space

    # construct controller for bee
    controller = ConstantController(y_vel, lp_fc)

    # use this to turn noise on/off
    use_noise = False

    if use_noise:
        # noise parameters for the bee's sensors
        max_white_noise = 0.2
        min_white_noise = -0.
        max_brown_noise_step = 0.01
        spike_noise_prob = 0.03
        pos_spike_size = 0.05
        neg_spike_size = -0.05

        # construct noise source for bee's front sensor
        front_noisemaker = NoiseMaker(white_noise_params=[max_white_noise, min_white_noise], brown_noise_step=max_brown_noise_step, spike_noise_params=[spike_noise_prob, pos_spike_size, neg_spike_size])

        # construct noise source for bee's front sensor
        back_noisemaker = NoiseMaker(white_noise_params=[max_white_noise, min_white_noise], brown_noise_step=max_brown_noise_step, spike_noise_params=[spike_noise_prob, pos_spike_size, neg_spike_size])
    else:
        front_noisemaker = None
        back_noisemaker = None


    # construct bee's sensors
    sensors = [PatchSensor(wall=right_wall, x=0, y=0, theta=0, FOV=fov, noisemaker=front_noisemaker),
               PatchSensor(wall=right_wall, x=0, y=0, theta=0, FOV=fov, noisemaker=back_noisemaker)]

    # set angles of sensors on bee's body
    sensor_angles = [sensor_offset + (-math.pi/2) + d_angle,
                     sensor_offset + (-math.pi/2) - d_angle]

    # construct bee
    bee = NewBee(x=0, y=right_wall.y_bottom, theta=math.pi/2, heading=math.pi/2, controller=controller, sensors=sensors, sensor_angles=sensor_angles, max_speed=2000)

    # simulation time parameter and variables
    dt = 0.01
    t = 0
    ts = [t]

    # simulate bee flying upwards until it reaches the top of the wall
    while bee.y < right_wall.y_top:
        bee.step(dt)
        t += dt
        ts.append(t)

    # return data
    if single_run:
        return ts, controller.right_corr, right_wall, bee
    else:
        return np.mean(bee.controller.right_corr.outputs)

# a controller for a bee which will make it just fly upwards in y-axis
class ConstantController(NewBeeController):

    # initialise controller
    def __init__(self, y_vel, lp_fc):
        # call super constructor
        super().__init__(inputs_n=2, step_fun=None)

        # construct correlator
        self.right_corr = HRCorrelator(hp_fc=hp_fc, lp_fc=lp_fc)

        # bee's linear flight speed
        self.speed = y_vel

    # step controller forwards in time
    def step(self, inputs: List[float], dt: float, theta: float, speed: float, heading: float) -> List[float]:

        # step correlator with inputs from sensors
        self.right_corr.step(inputs[0], inputs[1], dt)

        # return commands for bee's body orientation, linear speed, and flight heading
        return [0, self.speed, 0]

##### correlator parameters #####
# corner frequency of high pass filters
hp_fc = 0.05

##### sensor parameters #####
# sensor field of view angle
fov = math.pi / 120
# half of angle between sensors
d_angle = math.pi/24
# angular offset of sensor pairs from sides
sensor_offset = math.pi/12

##### wall parameters #####
# coordinate of wall
wall_x = 5
# height of black/white patches on wall
patch_h = 20

# number of velocities to sweep over
v_n = 80
# number of corner frequencies to sweep over
l_n = 80
# list of velocities to sweep over
vels = np.linspace(25, 300, v_n)
# list of LPF corner frequencies to sweep over
lp_fcs = np.linspace(1, 100, l_n)

##### parameters for selecting what to run #####
# - if all are false, then a sweep over velocites and corner frequencies will be run
# - if not, then the first option set to True will be selected
# run once
single_run = True
# sweep over velocities with a fixed LPF corner frequency
sweep_vels = False
# sweep over LPF corner frequencies with a fixed velocity
sweep_fcs = False
# run for a few velocities to compare correlator output signals
multi_vels = False

##### parameters for plots #####
plt.rcParams["font.weight"] = "bold"
rc('axes', linewidth=2)
font_size = 18

# NOTE: the multiprocessing code needs to be wrapped in __main__, or aggravating
# errors will ensue
if __name__ == '__main__':

    if single_run:

        # data point to start plotting from
        n1 = 0

        # number of data points to show - it's unlikely you'll want to look at the
        # complete data, but if you do, set this variable to -1
        #
        # if you run the simulation with a very high value for y_vel (e.g. 300), you
        # will have to either make n smaller, or just make it -1, as there will not be
        # 2000 data points to plot
        n2 = 2000
        n2 += n1
        # run smulation once
        ts, corr, wall, bee = run_once(y_vel=20, lp_fc=10)

        # open axes for plots
        fig, ax = plt.subplots()
        fig2, ax2 = plt.subplots()
        fig4, ax4 = plt.subplots()
        fig6, ax6 = plt.subplots()

        ax.plot(ts[n1:n2], corr.outputs[n1:n2])
        ax.plot([ts[n1], ts[n2]], [0, 0], 'r--')
        ax.set_xlabel("t", fontsize=font_size, fontweight='bold')
        ax.set_ylabel("Correlator output", fontsize=font_size, fontweight='bold')
        ax.set_title("Correlator output over time", fontsize=font_size, fontweight='bold')
        ax.tick_params(axis='both', which='major', labelsize=font_size)

        ax2.plot(ts[n1:n2], corr.hpf1.outputs[n1:n2], label='front HPF')
        ax2.plot(ts[n1:n2], corr.hpf2.outputs[n1:n2], label='back HPF')
        ax2.plot([ts[n1], ts[n2]], [0, 0], 'r--')
        ax2.set_xlabel("t", fontsize=font_size, fontweight='bold')
        ax2.set_ylabel("HPF output", fontsize=font_size, fontweight='bold')
        ax2.set_title("HPF outputs over time", fontsize=font_size, fontweight='bold')
        ax2.tick_params(axis='both', which='major', labelsize=font_size)
        ax2.legend()

        ax4.plot(ts[n1:n2], corr.lpf.outputs[n1:n2], label='LPF')
        ax4.plot([ts[n1], ts[n2]], [0, 0], 'r--')
        ax4.plot(ts[n1:n2], corr.hpf2.outputs[n1:n2], label='back HPF')
        ax4.set_xlabel("t", fontsize=font_size, fontweight='bold')
        ax4.set_ylabel("Filter outputs", fontsize=font_size, fontweight='bold')
        ax4.set_title("Inputs to multiplier over time", fontsize=font_size, fontweight='bold')
        ax4.tick_params(axis='both', which='major', labelsize=font_size)
        ax4.legend()

        ax6.plot(ts[n1:n2], bee.sensors[0].activations[n1:n2], label='front sensor')
        ax6.plot(ts[n1:n2], bee.sensors[1].activations[n1:n2], label='back sensor')
        ax6.set_xlabel("t", fontsize=font_size, fontweight='bold')
        ax6.set_ylabel("Sensor outputs", fontsize=font_size, fontweight='bold')
        ax6.set_title("Bee sensor outputs over time", fontsize=font_size, fontweight='bold')
        ax6.tick_params(axis='both', which='major', labelsize=font_size)
        ax6.legend()


        # not particularly worth looking at most of the time, so you may want to
        # comment these lines out
        fig5, ax5 = plt.subplots()
        ax5.plot(bee.xs, bee.ys)
        bee.draw(ax5)
        wall.draw(ax5)

    elif sweep_vels:

        # LPF corner frequency for this sweep
        lp_fc = 10

        # open multiprocessing pool, to run multiple simulations in parallel
        pool = Pool(processes=7)

        # run simulations
        res_row = pool.starmap(run_once, product(vels, [lp_fc]))

        # close multiprocessing pool
        pool.close()

        fig, ax = plt.subplots()
        ax.plot(vels, res_row)
        ax.set_title("Wall patch height {:.2f}".format(patch_h) + ", FOV {:.2f}".format(fov) + ", angle between sensors {:.2f}".format(2 * d_angle) + ", sensor offset {:.2f}".format(sensor_offset) + ", wall x-coord {:.2f}".format(wall_x) + ", LPF fc {:.2f}".format(lp_fc), fontsize=font_size, fontweight='bold')
        ax.set_ylabel("Average correlator output", fontsize=font_size, fontweight='bold')
        ax.set_xlabel("Bee velocity", fontsize=font_size, fontweight='bold')
        ax.tick_params(axis='both', which='major', labelsize=font_size)

    elif sweep_fcs:

        # bee velocity for this sweep
        vel = 20

        # open multiprocessing pool, to run multiple simulations in parallel
        pool = Pool(processes=7)

        # run simulations
        res_row = pool.starmap(run_once, product([vel], lp_fcs))

        # close multiprocessing pool
        pool.close()

        fig, ax = plt.subplots()
        ax.plot(lp_fcs, res_row)
        ax.set_title("Wall patch height {:.2f}".format(patch_h) + ", FOV {:.2f}".format(fov) + ", angle between sensors {:.2f}".format(2 * d_angle) + ", sensor offset {:.2f}".format(sensor_offset) + ", wall x-coord {:.2f}".format(wall_x) + ", bee velocity {:.2f}".format(vel), fontsize=font_size, fontweight='bold')
        ax.set_ylabel("Average correlator output", fontsize=font_size, fontweight='bold')
        ax.set_xlabel("LPF corner frequency", fontsize=font_size, fontweight='bold')
        ax.tick_params(axis='both', which='major', labelsize=font_size)

    elif multi_vels:

        # velocites to look at. you will probably want to keep num small, as it is
        # difficult to see much otherwise
        vels = np.linspace(10, 100, num=3)

        fig, ax = plt.subplots()

        # number of data points to plot. see above, in single_run, for further explanation
        n = 2000
        single_run = True

        title_str = "| "
        # used to set right x coord of dashed red line which shows y=0
        max_t = 0

        # run sim for each velocity
        for vel in vels:
            ts, corr, wall, bee = run_once(y_vel=vel, lp_fc=10)
            ax.plot(ts[:n], corr.outputs[:n], label=str(vel))
            title_str += "v = {:.2f}".format(vel) + ", mean = {:.2f}".format(np.mean(corr.outputs)) + " | "
            if len(ts) < n:
                ind = -1
            else:
                ind = n
            if ts[ind] > max_t:
                max_t = ts[ind]

        ax.plot([0, max_t], [0, 0], 'r--')
        ax.legend()
        ax.set_title(title_str, fontsize=font_size, fontweight='bold')
        ax.set_xlabel("t", fontsize=font_size, fontweight='bold')
        ax.set_ylabel("Correlator output", fontsize=font_size, fontweight='bold')
        ax.tick_params(axis='both', which='major', labelsize=font_size)

    else:

        # used to measure time to run all simulations
        t_start = time()

        # numpy array for storing results
        res = np.zeros((v_n, l_n))

        # open multiprocessing pool, to run multiple simulations in parallel
        pool = Pool(processes=7)

        # run simulations
        for i, vel in enumerate(tqdm(vels)):
            # run row by row
            res_row = pool.starmap(run_once, product([vel], lp_fcs))
            res[i, :] = res_row

        # close multiprocessing pool
        pool.close()

        # time taken to run all simulations
        print('Run time', time() - t_start, 's')

        fig, ax = plt.subplots()
        im = ax.imshow(res, extent=[-1, 1, -1, 1])
        # set up x-axis labels
        min_l = min(lp_fcs)
        max_l = max(lp_fcs)
        mid_l = min_l + (max_l - min_l)/2
        x_label_list = ["{:.2f}".format(min_l), "{:.2f}".format(mid_l), "{:.2f}".format(max_l)]
        ax.set_xticks([-1+1/l_n, 0, 1-1/l_n])
        ax.set_xticklabels(x_label_list)
        ax.tick_params(axis='both', which='major', labelsize=font_size)
        ax.set_xlabel('Low pass corner frequency', fontsize=font_size, fontweight='bold')

        # set up y-axis labels
        min_v = min(vels)
        max_v = max(vels)
        mid_v = min_v + (max_v - min_v)/2
        y_label_list = ["{:.2f}".format(max_v), "{:.2f}".format(mid_v), "{:.2f}".format(min_v)]
        ax.set_yticks([-1+1/v_n, 0, 1-1/v_n])
        ax.set_yticklabels(y_label_list)
        ax.set_ylabel('Velocity', fontsize=font_size, fontweight='bold')
        ax.set_title("Wall patch height {:.2f}".format(patch_h) + ", FOV {:.2f}".format(fov) + ", angle between sensors {:.2f}".format(2 * d_angle) + ", sensor offset {:.2f}".format(sensor_offset) + ", wall x-coord {:.2f}".format(wall_x), fontsize=font_size, fontweight='bold')

        # set up colorbar
        bar = plt.colorbar(im)
        bar.set_label('Mean EMD output', fontsize=font_size, fontweight='bold')
        # make lines and text bold, for full-screen png save to get high resolution
        bar.outline.set_linewidth(3)
        bar.ax.tick_params(direction='out', length=6, width=3)
        for t in bar.ax.get_yticklabels():
            t.set_fontsize(font_size)

plt.show()
