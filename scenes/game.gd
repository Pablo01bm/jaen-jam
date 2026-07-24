extends Node2D
class_name Game

func remove_current_scene():
	for scene in get_children():
		scene.queue_free()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("rumble"):
		GameUtils.gamepadRumble(1.0, 1)
