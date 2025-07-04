"""
Adapted from the Pymunk constraints demo:
    https://www.pymunk.org/en/latest/examples.html#constraints-py
    https://github.com/viblo/pymunk/blob/master/pymunk/examples/constraints.py
"""

# import packages
import sys
import yaml

# Print current sys.path before modification

# import Sandbox
# Add the path to Sandbox_V1_4 regardless of where the script is run from
import os
script_dir = os.path.dirname(os.path.abspath(__file__))
sandbox_path = os.path.join(script_dir, '..', '..')
sys.path.insert(1, sandbox_path)

# Print sys.path after modification
# print("sys.path after modification:", sys.path)

# Try to import
try:
    from Sandbox_V1_4 import *
    print("Successfully imported Sandbox_V1_4")
except ModuleNotFoundError as e:
    print(f"Error: {e}")
    print("Final sys.path when module not found:", sys.path)

import pygame
import pymunk
import pymunk.pygame_util
from pymunk.vec2d import Vec2d

# set up pygame screen and clock
pygame.init()
screen = pygame.display.set_mode((800, 800))
clock = pygame.time.Clock()

# set up pymunk simulation
space = pymunk.Space()
space.gravity = (0.0, 900.0)
draw_options = pymunk.pygame_util.DrawOptions(screen)

# function for adding the pendulum bar
def add_bar(space, pos, box_offset):
    body = pymunk.Body()
    body.position = Vec2d(*pos) + box_offset
    shape = pymunk.Segment(body, (0, 150), (0, 0), 6)
    shape.mass = 2
    shape.friction = 0.7
    space.add(body, shape)
    return body

def main():

    # read parameters from file
    params_file = os.path.join(script_dir, 'params.yaml')
    with open(params_file, 'r') as file:
        params_dict = yaml.safe_load(file)
    controller_gain = params_dict["gain"]
    disturbance_strength = params_dict["disturbance_strength"]
    patterned_behaviour = params_dict["pattern"]
    ball_mass = params_dict["mass"]
    plots = params_dict["main_plot"]

    # add pendulum bar
    box_offset = 250, 300
    b2 = add_bar(space, (150, 100), box_offset)
    # add pendulum pivot
    pj = pymunk.PivotJoint(b2, space.static_body, (150, 100) + Vec2d(*box_offset))
    space.add(pj)

    # add ball on pendulum
    mass = ball_mass
    radius = 20
    moment = pymunk.moment_for_circle(mass, 0, radius, (0, 0)) # box_offset + Vec2d(150, 200))
    body3 = pymunk.Body(mass, moment)
    body3.position = box_offset + Vec2d(150, 200)
    body3.start_position = Vec2d(*body3.position)
    shape = pymunk.Circle(body3, radius)
    shape.elasticity = 0.9999999
    space.add(body3, shape)

    # add joint to attach ball to bar
    pj3 = pymunk.PivotJoint(b2, body3, (0, 150), (0, 0)) # Vec2d(150, 200))
    pj3.collide_bodies = False
    space.add(pj3)

    # add motor to drive pendulum
    motor = pymunk.SimpleMotor(space.static_body, b2, math.pi)
    # set maximum force on motor, so that it is not too easy to control
    motor.max_force = 10000000
    space.add(motor)

    # set up proprtional feedback controller
    controller = FeedbackController(gain=controller_gain, ref_value=math.pi/2)

    # set up variables for storing some simulation data
    angles = []
    noise = 0.
    noises = [0.]
    disturbances = []
    errors = []
    controller_outputs = []
    # simulation time step
    dt = 1.0 / 60.0
    # simulation time variable
    t = 0
    # simulation timestamps, for plotting
    ts = [t]

    # simulation loop
    while True:
        quit = False
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                # exit()
                quit = True
            elif event.type == pygame.KEYDOWN and event.key == pygame.K_ESCAPE:
                # exit()
                quit = True

        if quit:
            break

        # step simulation
        space.step(dt)

        # draw simulation, and advance pygame clock
        screen.fill(pygame.Color("white"))
        space.debug_draw(draw_options)
        pygame.display.flip()
        clock.tick(1/dt)
        pygame.display.set_caption(f"fps: {clock.get_fps()}")

        # convert from pymunk's bloody daft corrdinate system to a conventional one
        ang = (2*math.pi-(b2.angle-3*math.pi/2)) % (2*math.pi)
        # shift angle to be in [-pi, pi]
        ang = ang % (2*math.pi)
        if ang > math.pi:
            ang -= (2*math.pi)

        angles.append(ang)

        # generate disturbance
        noise += np.random.random() - 0.5  - np.mean(noises)
        noises.append(noise)
        d_strength = disturbance_strength * 70000
        disturbances.append(d_strength*np.tanh(noise/3))
        # apply disturbance
        body3.apply_force_at_local_point((disturbances[-1], 0), (0, 0))

        # step controller and apply output to motor speed
        moving_target = np.sin(t) + 0.4*np.cos(2*t + 1)
        if not patterned_behaviour:
            moving_target = 0
        controller_outputs.append(controller.step(dt, ang, controller.ref_value + moving_target))
        motor.rate = controller_outputs[-1]

        # update time variables
        t += dt
        ts.append(t)

    # differentiate error and pendulum angle for phase portraits
    errors = controller.errors
    derrors = np.diff(errors)/dt
    dangles = np.diff(angles)/dt

    '''
    Set up figure with subplots.
    '''

    if plots:
        fig, axs = plt.subplots(2, 3, layout="constrained")
        doColourVaryingPlot2d(ts, angles[1:], ts, fig, axs[0][0], map_ind=0, showBar=True, barlabel='time', ax2=None)
        axs[0][0].set_xlabel("t")
        axs[0][0].set_ylabel('theta')
        axs[0][0].set_title("Pendulum angle")

        doColourVaryingPlot2d(angles[1:], dangles, ts, fig, axs[0][1], map_ind=0, showBar=True, barlabel='time', ax2=None)
        axs[0][1].set_xlabel('theta')
        axs[0][1].set_ylabel('dtheta/dt')
        axs[0][1].set_title("Angle phase portrait")

        doColourVaryingPlot2d(errors[1:], derrors, ts, fig, axs[0][2], map_ind=0, showBar=True, barlabel='time', ax2=None)
        axs[0][2].set_xlabel('error')
        axs[0][2].set_ylabel('derror/dt')
        axs[0][2].set_title("Error phase portrait")

        doColourVaryingPlot2d(ts, noises, ts, fig, axs[1][0], map_ind=0, showBar=True, barlabel='time', ax2=None)
        axs[1][0].set_xlabel("t")
        axs[1][0].set_ylabel('noise')
        axs[1][0].set_title("Zero mean brown noise")

        doColourVaryingPlot2d(ts, disturbances, ts, fig, axs[1][1], map_ind=0, showBar=True, barlabel='time', ax2=None)
        axs[1][1].set_xlabel('t')
        axs[1][1].set_ylabel('noise')
        axs[1][1].set_title("Disturbance")

        doColourVaryingPlot2d(ts, errors, ts, fig, axs[1][2], map_ind=0, showBar=True, barlabel='time', ax2=None)
        axs[1][2].set_xlabel('t')
        axs[1][2].set_ylabel('error')
        axs[1][2].set_title("Error")

        # this did not work as well as usual - too much space between figures
        # fig.tight_layout()

    '''
    We can use the plots below if we want to take a closer look at the variables.
    Simply uncomment the ones you need to.
    '''

    fig, ax = plt.subplots()
    doColourVaryingPlot2d(ts, angles[1:], ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    ax.set_xlabel("t")
    ax.set_ylabel('theta')
    ax.set_title("Pendulum angle")

    fig, ax = plt.subplots()
    doColourVaryingPlot2d(angles[1:], dangles, ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    ax.set_xlabel('theta')
    ax.set_ylabel('dtheta/dt')
    ax.set_title("Angle phase portrait")

    fig, ax = plt.subplots()
    doColourVaryingPlot2d(errors[1:], derrors, ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    ax.set_xlabel('error')
    ax.set_ylabel('derror/dt')
    ax.set_title("Error phase portrait")

    fig, ax = plt.subplots()
    doColourVaryingPlot2d(ts, noises, ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    ax.set_xlabel("t")
    ax.set_ylabel('noise')
    ax.set_title("Brown noise")

    fig, ax = plt.subplots()
    doColourVaryingPlot2d(ts, disturbances, ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    ax.set_xlabel('t')
    ax.set_ylabel('noise')
    ax.set_title("Disturbance")

    fig, ax = plt.subplots()
    doColourVaryingPlot2d(ts, errors, ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    ax.set_xlabel('t')
    ax.set_ylabel('error')
    ax.set_title("Error")

    fig, ax = plt.subplots()
    doColourVaryingPlot2d(ts, controller_outputs, ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    ax.set_xlabel('t')
    ax.set_ylabel('control')
    ax.set_title("Controller output")

    plt.show()

if __name__ == "__main__":
    main()
