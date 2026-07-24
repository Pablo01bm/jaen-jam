extends Node
class_name State

var _parent: Node

signal finished(_new_state_path: String, _init_data: Dictionary)


func _enter(_previous_state_path: String, _init_data := {}):
	pass


func _exit():
	pass


func _update(_delta):
	pass


func _update_physics(_delta):
	pass

func _handle_input(event: InputEvent):
	pass
