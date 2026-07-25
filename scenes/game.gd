extends Node2D
class_name Game

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func remove_current_scene():
	for scene in get_children():
		scene.queue_free()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("rumble"):
		print("LLEGO")
		GameUtils.gamepadRumble(1.0, 1)
