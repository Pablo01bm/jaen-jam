extends Node2D

var is_shooting = false
var shoot_ready = false

func _ready():
	GameGlobals.is_opened.connect(_prepare_mouse)
	GameGlobals.is_closed.connect(_enable_shooting)

func _process(delta: float) -> void:
	
	if (is_shooting == true):
		var mouse_position = get_global_mouse_position()
		$Heircross.global_position = mouse_position
		
		if $AfterShoot.time_left == 0:
			$Heircross.rotate(delta)
		else:
			$Heircross.rotate(delta * $AfterShoot.time_left * 18)

		if Input.is_action_just_pressed("shoot"):
			$AfterShoot.start()
			_shoot()
	else:
		var mouse_position = get_global_mouse_position()
		$Pointer.global_position = mouse_position


func debug_draw_explosion():
	var explosion = preload("res://scenes/ovni_particles/OvniParticle.tscn").instantiate()
	explosion.global_position = $Heircross.global_position
	get_parent().add_child(explosion)


func _shoot() -> void:
	if shoot_ready:
		var aux = -1;
		var aux_body
		for body in $Heircross.get_overlapping_bodies():
			if body is Alien:
				if aux < body.z_index:
					aux = body.z_index
					aux_body = body
		if aux_body != null:
			aux_body.receive_hit()
			
		GameGlobals.shake_camera.emit()

func _prepare_mouse() -> void:
	is_shooting = true
	$Heircross.visible = true
	$Pointer.visible = false

func _enable_shooting() -> void:
	shoot_ready = true
