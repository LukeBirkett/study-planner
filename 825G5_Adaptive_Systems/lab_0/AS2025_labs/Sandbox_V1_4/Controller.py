from .System import *
from .noise import *
import copy as cp

class Controller(System):

    """
        This class represents a controller for an :class:`Agent`.
        There are two routes to customising :class:`Controller` or one of its subclasses:

        #. Using ``step_fun(dt, inputs, params, state)``. ``step_fun`` is a function which can be written anywhere in the code for your experiment and passed to a :class:`Controller` when it is constructed. This will only work for relatively simple controllers.
        #. By creating a subclass of :class:`Controller`, like :class:`RobotController`, where you can add any attributes you need to by writing a new __init__ method (which should call ``super().__init__``, so that attributes from :class:`Controller` are inherited and set up correctly). In some cases, you may also need to override the step method of :class:`Controller` (possibly using ``super().step`` to inherit existing functionality), and to add other methods to the class.

        If you want to create a self-adaptive controller, then you can either create a subclass of :class:`Controller` or - for relatively simple cases - you can implement an ``adapt_fun(dt, inputs_hist, commands_hist, params_hist)`` function and pass it into a :class:`Controller` when it is constructed.
    """

    # construct Controller
    def __init__(self, inputs_n: int,
                       commands_n: int,
                       step_fun: Callable[[float, List[float], List[float], List[float]], List[float]], noisemakers: List[NoiseSource]=None, noisemakers_inds=None,
                       params: List[float]=None,
                       adapt_fun: Callable[[List[float], List[float], List[float]], None]=None,
                       adapt_enabled: bool=True,
                       test_interval: float=0,
                       state_n: int=0,
                       initial_state: List[float]=None):

        """

        __init__(inputs_n: int, commands_n: int, step_fun: Callable[[float, List[float], List[float], List[float]], List[float]], noisemakers: List[NoiseSource]=None, noisemakers_inds=None, params: List[float]=None, adapt_fun: Callable[[List[float], List[float], List[float]], None]=None, adapt_enabled: bool=True, test_interval: float=0)

            :param inputs_n: The number of inputs expected by the controller.
            :type inputs_n: int

            :param commands_n: The number of outputs (commands) that the controller is expected to return from its ``step`` method.
            :type commands_n: int

            :param state_n: The number of state variables that the controller expects to be returned from its ``step_fun`` method.
            :type commands_n: int

            :param initial_state: The controller's initial state vector, if it has one. Defaults to ``None``. Should be a list with ``state_n`` entries.
            :type initial_state: list[float]

            :param step_fun: The function which will be used to generate the controller's outputs, given the inputs to the controller's ``step`` method, the interval of time to integrate over, and any state and parameters the controller makes use of.
            :type step_fun: a function

            :param noisemakers: A list of noise sources which will potentially affect the commands the controller outputs.
            :type noisemakers: List of NoiseSource objects.

            :param noisemaker_inds: A list of indices of commands which will potentially have noise added to them. Any indices which are out of range in either the list of noisemakers or commands will be ignored.
            :type noisemaker_inds: List of integers.

            :param params: A list of parameters used by the controller. These parameters will be used in the controller's ``step_fun`` function, which will be caused from the controller's ``step`` method.
            :type params: list of floats.

            :param adapt_fun: A function wich can be used to adapt a controller, by changing its parameters. It only has access to the same data that the controller does: its histories of inputs, outputs, and parameter values.
            :type adapt_fun: a function

            :param adapt_enabled: When a :class:`Controller` has an ``adapt_fun``, that function will only be used when ``adapt_enabled`` is set to True.
            :type adapt_enabled: bool

            :param test_interval: The period of time to wait between parameter changes, if an adapt_fun is being used.
            :type test_interval: float

        """

        # call System init
        super().__init__()

        # attributes which are assumed not to change
        self.noisemakers = noisemakers
        self.noisemakers_inds = noisemakers_inds
        self.step_fun = step_fun
        self.adapt_fun = adapt_fun

        # attributes which may change have initial values saved so that the
        # controller can  be reset
        self.inputs_hist: List[List[float]] = [[0.] * inputs_n]
        self.initial_inputs_hist = []
        for input in self.inputs_hist:
            self.initial_inputs_hist.append(input)
        self.commands_hist: List[List[float]] = [[0.] * commands_n]
        self.initial_commands_hist = []
        for c in self.commands_hist:
            self.initial_commands_hist.append(c)
        self.params = params
        self.params_hist = None
        if self.params is not None:
            self.params_hist = [self.params]
        # if self.params:
        #     params_n = len(params)
        #     self.params_hist: List[List[float]] = [[0.] * params_n]
        self.initial_params = params
        self.t: float = 0.0
        self.test_interval = test_interval
        self.adapt_enabled = adapt_enabled

        self.state_hist = None
        if state_n > 0:
            self.state = [initial_state]
            if initial_state is None:
                self.state:List[float] = [0.] * state_n
            self.initial_state = cp.copy(self.state)
            self.state_hist:List[List[float]] = [cp.copy(self.initial_state)]
        else:
            self.state = None

    def reset(self) -> None:
        """
            A method to reset the controller to its initial state, so that it can be reused without the data and states from a previous simulation run affecting the next run.

            You will typically want to get the controller's data before resetting it, e.g. so that you can store if for the purposes of analysis. The most convenient way to do this will often be to call the ``get_data_and_reset`` method defined in the :class:`System` class.
        """
        self.t = 0
        self.inputs_hist = self.initial_inputs_hist[:]
        self.commands_hist = self.initial_commands_hist[:]
        self.params = self.initial_params
        self.params_hist = [self.params]
        if self.noisemakers:
            for noisemaker in self.noisemakers:
                noisemaker.reset()

    def get_data(self) -> Dict[str, dict]:
        """
            A method for getting the simulation run data from a :class:`Controller`.

            These data, as and when they are included in the returned dict, can be accessed with the following keys:

            * a list of the data dicts from each of the controller's noisemakers, if it has any: ``data["noises"]``
            * the full history of outputs from the controller: ``data["commands_hist"]``
            * the indices of command outputs which are affected by the controller's noise sources: ``data["noisemakers_inds"]``
            * the full histry of the controller's parameters: ``data["params_hist"]``
            * the full history of the (sensory) inputs to the controller: ``data["inputs_hist"]``
            * the full history of the controller's state: ``data["state_hist"]``

            :return: A dict containing the Controller's parameters and recorded data, including the data of any NoiseSources which are attached to the controller.
            :rtype: dict
        """

        # inputs_hist is not returned, as those data are assumed to be sensor
        # activations which are stored by the sensors
        noises = None
        if self.noisemakers:
            noises = []
            for noisemaker in self.noisemakers:
                noises.append(noisemaker.get_data()["noises"])

        data = {"commands_hist": self.commands_hist,
                "noisemakers_inds": self.noisemakers_inds,
                "noises": noises,
                "params_hist": self.params_hist,
                "inputs_hist": self.inputs_hist,
                "state_hist": self.state_hist}

        return data

    def step(self, dt: float, inputs: List[float]) -> List[float]:
        """
            A method to step a controller forwards in time.

            :param dt: The interval of time to integrate the controller over.
            :type dt: float

            :param inputs: The inputs to the controller.
            :type inputs: list of floats

            :return: List of commands.
            :rtype: list of floats.
        """
        self.t += dt  # increment time variable by simulation step size

        # store new inputs
        self.inputs_hist.append(inputs)

        # adapt params
        if self.adapt_fun and self.adapt_enabled:
            if self.t >= self.test_interval:
                self.t = 0
                self.params = self.adapt_fun(dt, np.array(self.inputs_hist), np.array(self.commands_hist), np.array(self.params_hist))

        params_copy = self.params

        # store new params
        if self.params is not None:
            self.params_hist.append(self.params[:])
            params_copy = self.params[:]

        # get commands
        commands, state = self.step_fun(dt, inputs, params_copy, self.state)

        if self.state is not None:
            self.state = state
            self.state_hist.append(state)

        # add noise to commands
        if self.noisemakers_inds:
            for i, ind in enumerate(self.noisemakers_inds):
                # check that there is a noisemaker and a command at the given index in each list
                if i < len(self.noisemakers) and ind < len(commands):
                    commands[ind] += self.noisemakers[i].step(dt)

        # store new commands
        self.commands_hist.append(commands)

        # return commands
        return commands
