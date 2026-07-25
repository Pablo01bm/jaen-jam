extends Node2D

func _process(delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	$Heircross.global_position = mouse_position
	
	if $AfterShoot.time_left == 0:
		$Heircross.rotate(delta)
	else:
		$Heircross.rotate(delta * $AfterShoot.time_left * 18)

	if Input.is_action_just_pressed("shoot"):
		$AfterShoot.start()


func debug_draw_explosion():
	var explosion = preload("res://scenes/ovni_particles/OvniParticle.tscn").instantiate()
	explosion.global_position = $Heircross.global_position
	get_parent().add_child(explosion)
