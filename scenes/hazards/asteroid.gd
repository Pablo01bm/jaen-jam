extends Hazard

var destroyed = false

var shake_direction = Vector2.ZERO
var intensity = 4

func _process(delta: float) -> void:
	if !destroyed:
		$Rotation.rotate(0.1 * delta)
		
	position = shake_direction.rotated(randf_range(0, 360)) * intensity
	shake_direction = shake_direction.move_toward(Vector2.ZERO, delta * 2)
	
	if Input.is_action_just_pressed("rumble"):
		receive_hit()


func receive_hit():
	print("asteroid hit")
	shake_direction = Vector2.DOWN
