extends CharacterBody2D
class_name Player

@onready var state_machine: StateMachine = (func get_state_machine() -> StateMachine:
	return get_node("StateMachine")
).call()
