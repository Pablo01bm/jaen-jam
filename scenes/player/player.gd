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
		_shoot()


func _shoot() -> void:
	for body in $Heircross.get_overlapping_bodies():
		if body is Alien:
			body.receive_hit()
