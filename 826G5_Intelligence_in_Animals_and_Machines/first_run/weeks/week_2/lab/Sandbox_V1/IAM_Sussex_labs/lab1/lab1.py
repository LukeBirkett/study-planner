import sys
# relative path to folder which contains the Sandbox module
# sys.path.insert(1, '../..')
# from Sandbox import *

from pathlib import Path
current_file_path = Path(__file__).resolve()
root_lab_path = current_file_path.parent.parent.parent.parent
sandbox_v1_path = root_lab_path / "Sandbox_V1"
sys.path.insert(0, str(sandbox_v1_path))
from Sandbox import *

#########################################################################
#                        Controller section                             #
#########################################################################


def aggressor(dt, inputs, params, state=[]) -> List[float]:

    # set left motor speed
    left_speed_command = inputs[0]
     
    # set right motor speed
    right_speed_command = inputs[1]

    print(inputs)
    # return motor speeds to robot's controller
    return [left_speed_command, right_speed_command]

aggressor_controller = BraitenbergController(step_fun=aggressor, gain=0.5)

def coward(dt, inputs, params, state=[]) -> List[float]:

    # set left motor speed
    left_speed_command = math.sin(params[0]) - inputs[0]
    # set right motor speed
    right_speed_command = left_speed_command * params[0]

    # return motor speeds to robot's controller
    return [left_speed_command, right_speed_command]

coward_controller = BraitenbergController(step_fun=coward, gain=0.1)

def lover(dt, inputs, params, state=[]) -> List[float]:

    # set left motor speed
    left_speed_command = inputs[0] * 0.01

    # set right motor speed
    right_speed_command = inputs[1] * 0.01

    # return motor speeds to robot's controller
    return [left_speed_command, right_speed_command]

lover_controller = BraitenbergController(step_fun=lover, gain=2)

def monocular(dt, inputs, params, state=[]) -> List[float]:

    # set left motor speed
    left_speed_command = params[0] - inputs[0]
    # set right motor speed
    right_speed_command = left_speed_command * inputs[1]

    # return motor speeds to robot's controller
    return [left_speed_command, right_speed_command]

monocular_controller = BraitenbergController(step_fun=monocular, gain=0.1)

#########################################################################
#                           Noise section                               #
#########################################################################

# noise parameters for the robot's left motor
max_white_noise = 0. # try 0.1 and -0.1 at first for white noise params
min_white_noise = -0.
max_brown_noise_step = 0.0 # try 0.01 at first
spike_noise_prob = 0. # try 0.05 at first
pos_spike_size = 1 # if the prob param is 0, there are no spikes, so these params have no effect
neg_spike_size = -1

# construct noise source for robot's left motor
left_motor_noisemaker = NoiseMaker(white_noise_params=[max_white_noise, min_white_noise], brown_noise_step=max_brown_noise_step, spike_noise_params=[spike_noise_prob, pos_spike_size, neg_spike_size])

#########################################################################
#                      Simulation parameters                            #
#########################################################################

# select controller to use, from this list: [aggressor_controller, coward_controller, lover_controller, monocular_controller]
controller = lover_controller

# robot sensor parameters
field_of_view = 0.9 * math.pi
left_sensor_angle = np.pi/6
right_sensor_angle = -np.pi/6

# simulation run parameters
screen_width =750 # height and width of animation window, in pixels
duration = 250 # number of simulation time units to simulate for
n_runs = 1 # number of simulations to run
animate = True # whether or not to animate
animation_frame_delay = 0 # the 10s of milliseconds to pause between frames

#########################################################################
#                       Simulation section                              #
#########################################################################

# set up environment
light_sources = [LightSource(0, 0)]

# get robot
robot = light_seeking_Robot(x=0, y=0, theta=0, light_sources=light_sources, controller=controller, left_motor_noisemaker=left_motor_noisemaker, FOV=field_of_view, left_sensor_angle=left_sensor_angle, right_sensor_angle=right_sensor_angle, left_motor_inertia=10, right_motor_inertia=10)

# put robot into list of agents for Simulator
agents=[robot]

# In future labs, this list will not be empty - disturbances are going to be very important
disturbances = []

# get Simulator object - note that agents, environmental systems, and disturbances are all passed to its constructor
sim = Simulator(agents=agents, envs=light_sources, duration=duration, dt=0.1, disturbances=disturbances)

# use SimulationRunner to run Simulation n number of times
sim_data = []
for i in range(n_runs):

    alpha = random_in_interval(minimum=-math.pi, maximum=math.pi)
    rad = 7
    n = random_in_interval(minimum=-math.pi/5, maximum=math.pi/5)
    robot.push(x=rad*math.cos(alpha), y=rad*math.sin(alpha), theta=alpha+math.pi+n)

    # get SimulationRunner object
    sim_runner = SimulationRunner(sim, animate=animate, pause_ani=True, animation_delay=animation_frame_delay, screen_width=screen_width)
    run_data = sim_runner.run_sims(n=1)
    sim_data.append(run_data[0])
    sim.reset()

# plot agents' trajectories
ax = plot_all_sims_trajectories(sim_data, show_cbar=False, cbar_fig=True)
for light in light_sources:
    light.draw(ax)
# plot robots' basic data (plots of robot's various noisemakers are not produced by this function call)
plot_all_robots_basic_data(sim_data, multiple_plots=False, show_motors=True, show_controllers=True, show_sensors=True)
# plot noise
plot_all_robots_noise(sim_data)

plt.show()
