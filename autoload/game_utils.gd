extends Node

func gamepadRumble(strength:float,duration:float):
	if strength >1.0: strength=1.0
	if strength <0.0: strength=0.0
	Input.start_joy_vibration(0,strength,strength,duration)
