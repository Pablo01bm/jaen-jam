extends Node2D

var is_shooting = false
var shoot_ready = false
var failed_shot = false
var innocent_killed = false

func _ready():
	GameGlobals.is_opened.connect(_prepare_mouse)
	GameGlobals.is_closed.connect(_enable_shooting)

func _process(delta: float) -> void:
	
	if failed_shot || innocent_killed:
		_process_cooldown()
		var mouse_position = get_global_mouse_position()
		$HeircrossFail.global_position = mouse_position
		_rotate_heircross(delta, $HeircrossFail)
	
	if (is_shooting == true):
		var mouse_position = get_global_mouse_position()
		$Heircross.global_position = mouse_position
		
		_rotate_heircross(delta,$Heircross )
		if Input.is_action_just_pressed("shoot"):
			_shoot()
	else:
		var mouse_position = get_global_mouse_position()
		$Pointer.global_position = mouse_position

func _rotate_heircross(delta, heircross) -> void:
	if $AfterShoot.time_left == 0:
		heircross.rotate(delta)
	else:
		heircross.rotate(delta * $AfterShoot.time_left * 18)

func debug_draw_explosion():
	var explosion = preload("res://scenes/ovni_particles/OvniParticle.tscn").instantiate()
	explosion.global_position = $Heircross.global_position
	get_parent().add_child(explosion)


func _shoot() -> void:
	if shoot_ready:
		$AfterShoot.start()
		var aux = -1;
		var aux_body
		if $Heircross.get_overlapping_bodies().size() > 0:
			
			for body in $Heircross.get_overlapping_bodies():
				if body is Alien:
					if aux < body.z_index:
						aux = body.z_index
						aux_body = body
						if !body.is_hijoputa:
							## YOU KILLED AN INNOCENT ALIEN WITTH A LOVING FAMILY AND A COSMIC DOG.....
							_innocent_killed_process()
			if aux_body != null:
				aux_body.receive_hit()
				
			GameGlobals.shake_camera.emit()
		else:
			## FAILED SHOT
			_shoot_failed_process()

func _prepare_mouse() -> void:
	is_shooting = true
	$Heircross.visible = true
	$Pointer.visible = false

func _enable_shooting() -> void:
	shoot_ready = true

func _process_cooldown() -> void:
	if failed_shot:
		if $Failed.time_left == 0.0:
			failed_shot = false;
			$HeircrossFail.visible = false
			shoot_ready = true
		
	elif innocent_killed:
		if $InnocentKilled.time_left == 0.0:
			innocent_killed = false
			$HeircrossFail.visible = false
			shoot_ready = true

func _shoot_failed_process() -> void:
	failed_shot = true
	$Failed.start()
	$HeircrossFail.visible = true
	$HeircrossFail.rotation = $Heircross.rotation
	shoot_ready = false

func _innocent_killed_process() -> void:
	innocent_killed = true
	$InnocentKilled.start()
	$HeircrossFail.visible = true
	$HeircrossFail.rotation = $Heircross.rotation
	shoot_ready = false
