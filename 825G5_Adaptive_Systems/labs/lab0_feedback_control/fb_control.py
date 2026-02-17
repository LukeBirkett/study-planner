"""
Adapted from the Pymunk constraints demo:
    https://www.pymunk.org/en/latest/examples.html#constraints-py
    https://github.com/viblo/pymunk/blob/master/pymunk/examples/constraints.py
"""

# import packages
import sys
import yaml
import os

# # import Sandbox
# sys.path.insert(1, '../') # relative path to folder which contains the Sandbox module
# from Sandbox_V1_4 import *


# get the absolute path of the directory where this script lives
current_script_dir = os.path.dirname(os.path.abspath(__file__))

# get the 'labs' directory (one level up)
labs_dir = os.path.dirname(current_script_dir)

# add 'labs' to the system path so Python can see the Sandbox folder
if labs_dir not in sys.path:
    sys.path.insert(0, labs_dir) # adds this custom module temporaily for each run of the scipt

# Now this should work perfectly
from Sandbox_V1_4 import *

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
space.gravity = (0.0, -900.0)
draw_options = pymunk.pygame_util.DrawOptions(screen)

# function for adding the pendulum bar
def add_bar(space, pos, box_offset):
    body = pymunk.Body()
    body.position = Vec2d(*pos) + box_offset
    shape = pymunk.Segment(body, (0, -150), (0, 0), 6)
    shape.mass = 2
    shape.friction = 0.7 
    space.add(body, shape)
    return body

def add_pendulum(space, ball_mass):
    # add pendulum bar
    box_offset = 250, 300
    bar = add_bar(space, (150, 100), box_offset)
    # add pendulum pivot
    pj = pymunk.PivotJoint(bar, space.static_body, (150, 100) + Vec2d(*box_offset))
    space.add(pj)
    space.damping = 0.9

    # add ball on pendulum
    mass = ball_mass
    radius = 20
    moment = pymunk.moment_for_circle(mass, 0, radius, (0, 0)) # box_offset + Vec2d(150, 200))
    ball = pymunk.Body(mass, moment)
    ball.position = box_offset + Vec2d(150, -50)
    ball.start_position = Vec2d(*ball.position)
    shape = pymunk.Circle(ball, radius)
    shape.elasticity = 0.9999999
    space.add(ball, shape)

    # add joint to attach ball to bar
    pj3 = pymunk.PivotJoint(bar, ball, (0, -150), (0, 0)) # Vec2d(150, 200))
    pj3.collide_bodies = False
    space.add(pj3)

    return bar, ball

def draw_phase_portrait(screen, angles, d_angles, dt):
    left_edge = 500
    right_edge = left_edge + 280
    centre_x = (right_edge+left_edge)/2
    bottom_edge = 20
    top_edge = bottom_edge + 280
    centre_y = (top_edge+bottom_edge)/2
    origin = (left_edge, bottom_edge)
    right_corner = (right_edge, bottom_edge)
    top_right_corner = (right_edge, top_edge)
    top_left_corner = (left_edge, top_edge)
    # draw boundaries. note that trajectories can cross these lines!
    pygame.draw.line(screen, "black", origin, right_corner, 2)
    pygame.draw.line(screen, "black", right_corner, top_right_corner, 2)
    pygame.draw.line(screen, "black", top_right_corner, top_left_corner, 2)
    pygame.draw.line(screen, "black", top_left_corner, origin, 2)
    x_scale = 200/8
    y_scale = 200/25
    # draw pendulum state
    if len(angles) >= 2:
        ang_phase = (angles[-1]-angles[-2])/dt
        d_angles.append(ang_phase)
        pygame.draw.circle(screen, "red", (centre_x + x_scale*angles[-1], centre_y + y_scale*ang_phase), 3)
    # draw pendulm trajectory through phase space    
    l2 = len(d_angles)
    if l2 > 1:
        its = min(l2-1, 400)
        for i in range(its):
            p1 = (centre_x + x_scale*angles[-(i+1)], centre_y + y_scale*d_angles[-(i+1)])
            p2 = (centre_x + x_scale*angles[-(i+2)], centre_y + y_scale*d_angles[-(i+2)])
            pygame.draw.line(screen, "black", p1, p2, 2)

def render(screen, angles, d_angles, dt):
        # draw simulation, and advance pygame clock
        screen.fill(pygame.Color("white"))
        space.debug_draw(draw_options)

        # define the RGB value for white,
        #  green, blue colour .
        white = (255, 255, 255)
        black = (0, 0, 0)
        green = (0, 255, 0)
        blue = (0, 0, 128)

        # assigning values to X and Y variable
        X = 1270
        Y = 950

        # create a font object.
        # 1st parameter is the font file
        # which is present in pygame.
        # 2nd parameter is size of the font
        font = pygame.font.Font('freesansbold.ttf', 20)

        # create a text surface object,
        # on which text is drawn on it.
        text = font.render('Angle Phase Portrait', True, black, white)

        # create a rectangular object for the
        # text surface object
        textRect = text.get_rect()

        # set the center of the rectangular object.
        textRect.center = (X // 2, Y // 2)


        # animate phase portrait for pendulum angle
        draw_phase_portrait(screen, angles, d_angles, dt)

        # vertically flip the pygame display - PyGame has y=0 at top, but we are used to y=0 being at bottom
        flipped_surface = pygame.transform.flip(screen, False, True)
        # update display
        screen.blit(flipped_surface, (0, 0))

        # copying the text surface object
        # to the display surface object
        # at the center coordinate.
        screen.blit(text, textRect)

        pygame.display.update()
        pygame.time.wait(0) # wait for ms between simulation steps
        # update clock and frames/second display
        clock.tick(1/dt)
        pygame.display.set_caption(f"fps: {clock.get_fps()}")

def main():

    # read simulation parameters from file
    # with open('params1.yaml', 'r') as file:
    #     params_dict = yaml.safe_load(file)

    # Get the directory where fb_control.py is located
    script_dir = os.path.dirname(os.path.abspath(__file__))
    # Join that directory with the filename
    params_path = os.path.join(script_dir, 'params1.yaml')

    with open(params_path, 'r') as file:
        params_dict = yaml.safe_load(file)

    # controller parameters
    proportional_gain = params_dict["proportional_gain"]
    integral_gain = params_dict["integral_gain"]
    derivative_gain = params_dict["derivative_gain"]
    # disturbance and reference signal parameters
    disturbance_strength = params_dict["disturbance_strength"]
    patterned_behaviour = params_dict["pattern"]
    # physical parameters
    ball_mass = params_dict["mass"]
    # plot parameters
    plots = params_dict["main_plot"]

    # set pendulum up 
    bar, ball = add_pendulum(space, ball_mass)

    # add motor to drive pendulum
    motor = pymunk.SimpleMotor(space.static_body, bar, math.pi)
    # set maximum force on motor, so that it is not too easy to control
    motor.max_force = 10000000
    motor.rate = 0
    space.add(motor)

    # set up proportional feedback controller
    controller = FeedbackController(p_gain=proportional_gain, d_gain=derivative_gain, i_gain=integral_gain, ref_value=1 * math.pi/2)

    # set up variables for storing some simulation data
    angles = []
    d_angles = []
    pymunk_angles = []
    noise = 0.
    noises = [0.]
    disturbances = []
    targets = []
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

        # draw simulation on pygame screen
        render(screen, angles, d_angles, dt)

        # convert from pymunk's coordinate system to a more convenient one for the controller
        ang = (3*math.pi/2) - bar.angle
        # shift angle to be in [-pi, pi]
        ang = ang % (2*math.pi)
        if ang > math.pi:
            ang -= (2*math.pi)
        if ang < -math.pi:
            ang += (2*math.pi)

        # keep history of pymunk angle and transformed angle
        angles.append(ang)
        pymunk_angles.append(bar.angle)

        # generate disturbance
        noise += np.random.random() - 0.5  - np.mean(noises) # generate zero-mean "brown" noise
        noises.append(noise) # keep history of noise values
        d_strength = disturbance_strength * 70000 # scale noise
        disturbances.append(d_strength*np.tanh(noise/3)) # "squash" noise through hyperbolic tan function
        # apply disturbance
        ball.apply_force_at_local_point((disturbances[-1], 0), (0, 0))

        # step controller and apply output to motor speed
        target = controller.ref_value # constant reference value
        if patterned_behaviour: # time-varying reference value
            moving_target = np.sin(t) + 0.4*np.cos(2*t + 1) + 0.2*np.cos(0.2*t) + 0.05*np.cos(10*t+0.4)
            target += moving_target 
        # keep history of reference value
        targets.append(target)

        # control pendulum via motor speed. motor torque would be better, but pymunk does not implement that
        motor.rate = controller.step(dt, ang, target)

        # update simulation time variables
        t += dt
        ts.append(t)

    '''
    Set up figure with subplots.
    '''

    print("t:", t)

    if plots:
        fig, axs = plt.subplots(2, 3, layout="constrained")
        doColourVaryingPlot2d(ts, angles[1:], ts, fig, axs[0][0], map_ind=0, showBar=True, barlabel='time', ax2=None)
        axs[0][0].set_xlabel("t")
        axs[0][0].set_ylabel('theta')
        axs[0][0].set_title("Pendulum angle")

        doColourVaryingPlot2d(angles[1:], d_angles, ts, fig, axs[0][1], map_ind=0, showBar=True, barlabel='time', ax2=None)
        axs[0][1].set_xlabel('theta')
        axs[0][1].set_ylabel('dtheta/dt')
        axs[0][1].set_title("Angle phase portrait")

        doColourVaryingPlot2d(controller.errors[1:], controller.d_errors[1:], ts, fig, axs[0][2], map_ind=0, showBar=True, barlabel='time', ax2=None)
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

        doColourVaryingPlot2d(ts, controller.errors, ts, fig, axs[1][2], map_ind=0, showBar=True, barlabel='time', ax2=None)
        axs[1][2].set_xlabel('t')
        axs[1][2].set_ylabel('error')
        axs[1][2].set_title("Error")

        # using this did not work as well as usual - too much space between figures
        # fig.tight_layout()

    '''
    We can use the plots below if we want to take a closer look at the variables.
    Simply uncomment the ones you need to.
    '''

    # fig, ax = plt.subplots()
    # doColourVaryingPlot2d(ts, angles[1:], ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    # ax.set_xlabel("t")
    # ax.set_ylabel('theta')
    # ax.set_title("Pendulum angle")

    # fig, ax = plt.subplots()
    # doColourVaryingPlot2d(angles[1:], d_angles, ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    # ax.set_xlabel('theta')
    # ax.set_ylabel('dtheta/dt')
    # ax.set_title("Angle phase portrait")

    # fig, ax = plt.subplots()
    # doColourVaryingPlot2d(controller.errors[1:], controller.d_errors[1:], ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    # ax.set_xlabel('error')
    # ax.set_ylabel('derror/dt')
    # ax.set_title("Error phase portrait")

    # fig, ax = plt.subplots()
    # doColourVaryingPlot2d(ts, noises, ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    # ax.set_xlabel("t")
    # ax.set_ylabel('noise')
    # ax.set_title("Brown noise")

    # fig, ax = plt.subplots()
    # doColourVaryingPlot2d(ts, disturbances, ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    # ax.set_xlabel('t')
    # ax.set_ylabel('noise')
    # ax.set_title("Disturbance")

    # fig, ax = plt.subplots()
    # doColourVaryingPlot2d(ts, controller.errors, ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    # ax.set_xlabel('t')
    # ax.set_ylabel('error')
    # ax.set_title("Error")

    # fig, ax = plt.subplots()
    # doColourVaryingPlot2d(ts, controller.i_errors, ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    # ax.set_xlabel('t')
    # ax.set_ylabel('error')
    # ax.set_title("Integrated error")

    # fig, ax = plt.subplots()
    # doColourVaryingPlot2d(ts, controller.control_sigs, ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    # ax.set_xlabel('t')
    # ax.set_ylabel('control')
    # ax.set_title("Controller output")

    # fig, ax = plt.subplots()
    # doColourVaryingPlot2d(ts, pymunk_angles[1:], ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    # ax.set_xlabel("t")
    # ax.set_ylabel('theta')
    # ax.set_title("Pendulum angle, Pymunk")

    # fig, ax = plt.subplots()
    # doColourVaryingPlot2d(ts, angles[1:], ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    # ax.set_xlabel("t")
    # ax.set_ylabel('theta')
    # ax.set_title("Pendulum angle input to controller")

    # fig, ax = plt.subplots()
    # doColourVaryingPlot2d(ts, targets[1:], ts, fig, ax, map_ind=0, showBar=True, barlabel='time', ax2=None)
    # ax.set_xlabel("t")
    # ax.set_ylabel('theta')
    # ax.set_title("Reference signal")

    plt.show()

if __name__ == "__main__":
    main()
