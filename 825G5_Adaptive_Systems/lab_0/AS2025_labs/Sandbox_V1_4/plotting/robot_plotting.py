from . import *
from . import timeColouredPlots as tcp
import matplotlib.pyplot as plt

def plot_all_robots_basic_data(sim_data, show_motors=True, show_sensors=True, show_controllers=False, multiple_plots=True):
    '''

    '''
    all_robots_data, all_ts = get_robots_data(sim_data)

    if show_motors:
        if multiple_plots:
            for ts, robot_data in zip(all_ts, all_robots_data):
                plot_single_robot_motors(ts, robot_data)
        else:
            plot_all_robot_motors(all_ts, all_robots_data)

    if show_controllers:
        if multiple_plots:
            for ts, robot_data in zip(all_ts, all_robots_data):
                plot_single_robot_controller(ts, robot_data)
        else:
            plot_all_robot_controllers(all_ts, all_robots_data)

    if show_sensors:
        if multiple_plots:
            for ts, robot_data in zip(all_ts, all_robots_data):
                plot_single_robot_sensors(ts, robot_data)
        else:
            plot_all_robot_sensors(all_ts, all_robots_data)

def check_noise_data(robot_data):
    '''

    '''
    sensor_noise = False
    controller_noise = False

    sensor_noise_n = 0
    for sensor_data in robot_data["sensors"]:
        # print(sensor_data)
        # print(sensor_data.keys())
        if sensor_data["noises"]:
            sensor_noise_n += 1
            sensor_noise = True

    controller_noise_n = 0
    controller_noise_data = robot_data["controller"]["noises"]
    if controller_noise_data:
        for noise_data in controller_noise_data:
            controller_noise_n += 1
            controller_noise = True

    noise_n = sensor_noise_n + controller_noise_n

    return sensor_noise, controller_noise, sensor_noise_n, controller_noise_n, noise_n

def get_robots_data(sim_data):
    '''

    '''
    all_ts = []
    all_robots_data = []
    for data in sim_data:
        ind = 0
        for agent_data in data["agents"]:
            # check agent is a robot, and not some other type of agent
            if agent_data["classname"] == "Robot":
                agent_data["run_n"] = data["run_n"]
                agent_data["ind"] = ind
                ind += 1
                all_robots_data.append(agent_data)
                all_ts.append(data["ts"])
    return all_robots_data, all_ts

def plot_all_robots_noise(sim_data):
    '''

    '''

    all_robots_data, all_ts = get_robots_data(sim_data)

    sensor_noise, controller_noise, sensor_noise_n, controller_noise_n, noise_n = check_noise_data(all_robots_data[0])

    if noise_n == 0:
        return

    dummy_ax = False
    if noise_n == 1:
        noise_n += 1
        dummy_ax = True

    fig, ax = plt.subplots(noise_n, 1)

    for ts, robot_data in zip(all_ts, all_robots_data):

        ax_ind = 0

        if sensor_noise_n > 0:
            for i, sensor_data in enumerate(robot_data["sensors"]):
                if sensor_data["noises"]:
                    ax[ax_ind].plot(ts, sensor_data["noises"], label='Run ' + str(robot_data["run_n"]) + ' robot ' + str(robot_data["ind"]))
            ax[ax_ind].legend()
            ax[ax_ind].set_title('Sensor noise')
            ax_ind += 1

        if controller_noise_n > 0:
            for i, noise_data in enumerate(robot_data["controller"]["noises"]):
                ax[ax_ind].plot(ts, noise_data, label='Run ' + str(robot_data["run_n"]) + ' robot ' + str(robot_data["ind"]))
                ax[ax_ind].set_title('Controller output ' + str(i) + ' noise')
                ax_ind += 1

    for x in ax:
        x.legend()

    if dummy_ax:
        fig.delaxes(ax[1])

    # fig.suptitle("Run " + str(robot_data["run_n"]) + ", robot " + str(robot_data["ind"]))
    fig.tight_layout()

def plot_single_robot_noise(robot_data, ts):
    '''

    '''
    sensor_noise, controller_noise, sensor_noise_n, controller_noise_n, noise_n = check_noise_data(robot_data)

    if noise_n == 0:
        return

    dummy_ax = False
    if noise_n == 1:
        noise_n += 1
        dummy_ax = True

    fig, ax = plt.subplots(noise_n, 1)

    ax_ind = 0

    if sensor_noise_n > 0:
        for i, sensor_data in enumerate(robot_data["sensors"]):
            if sensor_data["noises"]:
                ax[ax_ind].plot(ts, sensor_data["noises"], label='Sensor ' + str(i) + ' noise')
        ax[ax_ind].legend()
        ax[ax_ind].set_title('Sensor noise')
        ax_ind += 1

    if controller_noise_n > 0:
        for i, noise_data in enumerate(robot_data["controller"]["noises"]):
            ax[ax_ind].plot(ts, noise_data, label='Controller output ' + str(i) + ' noise')
            ax[ax_ind].set_title('Controller output ' + str(i) + ' noise')
            ax_ind += 1

    if dummy_ax:
        fig.delaxes(ax[1])

    fig.suptitle("Run " + str(robot_data["run_n"]) + ", robot " + str(robot_data["ind"]))
    fig.tight_layout()

def plot_single_robot_sensors(ts, robot_data):
    '''

    '''
    n = len(robot_data["sensors"])
    fig, ax = plt.subplots(n, 1)

    for i, sensor_data in enumerate(robot_data["sensors"]):
        ax[i].plot(ts, sensor_data["activations"], label='sensor ' + str(i))

    for i in range(n):
        # ax.legend()
        ax[i].set_xlabel('Time')
        ax[i].set_ylabel('Activation')
        # ax[i].set_title('Sensor ' + str(i))
        ax[i].set_title(sensor_data["name_str"])

    fig.suptitle("Run " + str(robot_data["run_n"]) + ", robot " + str(robot_data["ind"]))
    fig.tight_layout()

# it is assumed that all robots will have the same number of sensors!
def plot_all_robot_sensors(all_ts, all_robots_data):
    '''

    '''
    n = len(all_robots_data[0]["sensors"])
    fig, ax = plt.subplots(n, 1)

    for ts, robot_data in zip(all_ts, all_robots_data):

        for i, sensor_data in enumerate(robot_data["sensors"]):
            ax[i].plot(ts, sensor_data["activations"], label='Run ' + str(robot_data["run_n"]) + ", robot " + str(robot_data["ind"]))
            ax[i].set_title(sensor_data["name_str"])


    for i in range(n):
        ax[i].legend()
        ax[i].set_xlabel('Time')
        ax[i].set_ylabel('Activation')
        # ax[i].set_title('Sensor ' + str(i))

    fig.tight_layout()

def plot_single_robot_controller(ts, robot_data):
    '''

    '''
    fig, ax = plt.subplots(2, 1)

    left_commands = []
    right_commands = []

    for commands in robot_data["controller"]["commands_hist"]:
        left_commands.append(commands[0])
        right_commands.append(commands[1])

    ax[0].plot(ts, left_commands, linewidth='2')
    ax[1].plot(ts, right_commands, linewidth='2')

    ax[0].set_xlabel('Time')
    ax[1].set_xlabel('Time')
    ax[0].set_title('Left motor controller output')
    ax[1].set_title('Right motor controller output')
    fig.suptitle("Run " + str(robot_data["run_n"]) + ", robot " + str(robot_data["ind"]))
    fig.tight_layout()

def plot_all_robot_controllers(all_ts, all_robots_data):
    '''

    '''
    fig, ax = plt.subplots(2, 1)

    for ts, robot_data in zip(all_ts, all_robots_data):

        left_commands = []
        right_commands = []

        for commands in robot_data["controller"]["commands_hist"]:
            left_commands.append(commands[0])
            right_commands.append(commands[1])

        ax[0].plot(ts, left_commands, linewidth='2', label='Run ' + str(robot_data["run_n"]) + ", robot " + str(robot_data["ind"]))
        ax[1].plot(ts, right_commands, linewidth='2', label='Run ' + str(robot_data["run_n"]) + ", robot " + str(robot_data["ind"]))
    ax[0].legend()
    ax[1].legend()
    ax[0].set_xlabel('Time')
    ax[1].set_xlabel('Time')
    ax[0].set_title('Left motor controller output')
    ax[1].set_title('Right motor controller output')
    fig.tight_layout()

# plot a robot's motor commands and actual speeds in vertically arranged subplots
def plot_single_robot_motors(ts, robot_data):
    '''

    '''
    fig, ax = plt.subplots(2, 1)
    ax[0].plot(ts, robot_data["left_motor"]["speeds"], linewidth='2')
    ax[1].plot(ts, robot_data["right_motor"]["speeds"], linewidth='2')

    ax[0].set_xlabel('Time')
    ax[1].set_xlabel('Time')
    ax[0].set_ylabel('Speed')
    ax[1].set_ylabel('Speed')
    ax[0].set_title('Left motor')
    ax[1].set_title('Right motor')
    fig.suptitle("Run " + str(robot_data["run_n"]) + ", robot " + str(robot_data["ind"]))
    fig.tight_layout()

# plot a robot's motor commands and actual speeds in vertically arranged subplots
def plot_all_robot_motors(all_ts, all_robots_data):
    '''

    '''
    fig, ax = plt.subplots(2, 1)

    for ts, robot_data in zip(all_ts, all_robots_data):
        ax[0].plot(ts, robot_data["left_motor"]["speeds"], label='Run ' + str(robot_data["run_n"]) + ", robot " + str(robot_data["ind"]), linewidth='2')
        ax[1].plot(ts, robot_data["right_motor"]["speeds"], label='Run ' + str(robot_data["run_n"]) + ", robot " + str(robot_data["ind"]), linewidth='2')
    ax[0].legend()
    ax[1].legend()
    ax[0].set_xlabel('Time')
    ax[1].set_xlabel('Time')
    ax[0].set_ylabel('Speed')
    ax[1].set_ylabel('Speed')
    ax[0].set_title('Left motor')
    ax[1].set_title('Right motor')
    fig.tight_layout()

def plot_all_sims_trajectories(sim_data, show_cbar=False, cbar_fig=False):
    '''

    '''
    all_ts = []
    all_agents_data = []
    for data in sim_data:
        all_ts.append(data["ts"])
        all_agents_data += data["agents"]

    return plot_all_agents_trajectories(all_ts, all_agents_data, [], show_cbar=show_cbar, cbar_fig=cbar_fig)

def plot_all_agents_trajectories(all_ts, agents_data, light_sources_data, draw_agents=False, show_cbar=False, cbar_fig=False):
    '''

    '''
    fig, ax = plt.subplots(1, 1)

    ax2 = None
    if cbar_fig and show_cbar:
        fig2, ax2 = plt.subplots(1, 1)
        fig2.tight_layout()
        fig2.canvas.draw()

    longest_len = 0
    longest_ind = 0
    for i, ts in enumerate(all_ts):
        l = len(ts)
        if l > longest_len:
            longest_len = l
            longest_ind = i

    x_min = 1E6
    y_min = 1E6
    x_max = -1E6
    y_max = -1E6

    for data in agents_data:
        l = longest_len - len(data["xs"])
        if len(data["xs"]) < longest_len:
            data["xs"] += [data["xs"][-1]] * l
            data["ys"] += [data["ys"][-1]] * l

        agent_min_x = min(data["xs"])
        agent_max_x = max(data["xs"])
        agent_min_y = min(data["ys"])
        agent_max_y = max(data["ys"])
        if agent_min_x < x_min:
            x_min = agent_min_x
        if agent_max_x > x_max:
            x_max = agent_max_x
        if agent_min_y < y_min:
            y_min = agent_min_y
        if agent_max_y > y_max:
            y_max = agent_max_y

    # for all agents, plot trajectories
    for i, data in enumerate(agents_data):
        tcp.doColourVaryingPlot2d(data["xs"], data["ys"], all_ts[longest_ind], fig, ax, map_ind=i, ax2=ax2, barlabel='Time, trace ' + str(i) + ', line style: ', showBar=show_cbar) #, showBar=i==0)  # only draw colorbar once

    # # draw all sources
    # for source in light_sources:
    #     source.draw(ax)
    # # draw all agents
    # for agent in agents:
    #     if draw_agents:
    #         agent.draw(ax)
    #     else:
    #         ax.plot(agent.xs[-1], agent.ys[-1], 'r*')
    #     agent_min_x = min(agent.xs)
    #     agent_max_x = max(agent.xs)
    #     agent_min_y = min(agent.ys)
    #     agent_max_y = max(agent.ys)
    #     if agent_min_x < x_min:
    #         x_min = agent_min_x
    #     if agent_max_x > x_max:
    #         x_max = agent_max_x
    #     if agent_min_y < y_min:
    #         y_min = agent_min_y
    #     if agent_max_y > y_max:
    #         y_max = agent_max_y

    # fix plot axis proportions to equal
    ax.set_aspect('equal')
    # set axis limits based on robots' trajectories - this is sometimes necessary
    # because of a bug in my tcp.doColourVaryingPlot2d code
    ax.set_xlim([x_min-5, x_max+5])
    ax.set_ylim([y_min-5, y_max+5])

    if cbar_fig and show_cbar:
        ax2.remove()

        fig2.tight_layout(h_pad=10)

    return ax
