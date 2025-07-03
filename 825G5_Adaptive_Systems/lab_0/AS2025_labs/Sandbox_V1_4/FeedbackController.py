class FeedbackController:
	"""

	"""
	# proportional feedback control - extend to PID??? or make it easier
	# to use with other methods?

	def __init__(self, gain, sensor=None, ref_value=None):
		"""

		"""
		self.sensor = sensor
		self.ref_value = ref_value
		self.control_sig = 0
		self.control_sigs = [self.control_sig]
		self.gain = gain
		self.errors = [0] # 0 IS NOT REALLY RIGHT!!!!!

	def step(self, dt, sensor_sig=None, ref_sig=None):
		"""

		"""
		# a reference signal can be passed in to this method in every
		# simulation step
		# - if a signal is input, then it will override the reference
		#   value set earlier
		# - if not, and a reference value was set in __init__, that will be used
		# - otherwise, there is no reference signal to track, and so this method
		#   will simply return zero
		ref = ref_sig
		if ref is None:
			if self.ref_value is not None:
				ref = self.ref_value
			else:
				return 0

		# the controller can either use its own sensor, set in __init__,
		# or it can have a sensory signal passed in to this method in every
		# simulation step
		# - if a sensor signal is input, then it will override the controller's
		# 	sensor
		# - if not, and a sensor was set in __init__, then that sensor will be used
		# - otherwise, there is no sensor signal to compare to the reference, and
		#   so this method will simply return zero
		if sensor_sig is None:
			if self.sensor is not None:
				sensor_sig = self.sensor.step(dt)
			else:
				return 0

		# calculate error
		error = ref - sensor_sig
		# store record of error
		self.errors.append(error)
		# calculate control output
		self.control = self.gain * error
		# store record of control output
		self.control_sigs.append(self.control)

		# return control output
		return self.control
