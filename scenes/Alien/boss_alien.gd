extends Alien
class_name BossAlien

var time = 0.0
var life = 3

signal killed

func _ready():
	# We define random movement direction
	SPEED_X = 400.0
	SPEED_Y = 400.0
	velocity.x = SPEED_X
	velocity.y = SPEED_Y
	z_index = 20
	is_hijoputa = true
	GameGlobals.boss_appeared.emit()


func _physics_process(delta):
	
	if $Timer.time_left == 0 and $Starting.time_left == 0:
		time += delta
		velocity = velocity.rotated(sin(time*4)*0.1).normalized() * SPEED_X
	else:
		velocity = velocity.normalized() * SPEED_X * 4
	
	if $Starting.time_left == 0 or $Timer.time_left > 0:
	#move_and_collide()
		var collision = move_and_collide(velocity * delta)
	
		if collision:
			velocity = velocity.bounce(collision.get_normal())
		

func get_info_array():
	return face.attributes

func reroll_features():
	face.randomize_face()

func set_hijoputa(value: bool) -> void:
	is_hijoputa = value

func get_face_signature() -> Array:
	var signature = []
	for value in face.attributes:
		signature.append(int(value))
	return signature

func has_same_face_as(other: Alien) -> bool:
	return get_face_signature() == other.get_face_signature()

# Llamar desde el sistema de disparo cuando el alien recibe un impacto
func receive_hit() -> void:
	print("BOSS HIT")
	life -= 1
	if life <= 0:
		die()
	else:
		$Timer.start()
		$Starting.stop()

func die() -> void:
	killed.emit()
	if is_hijoputa:
		var particle = preload("res://scenes/ovni_particles/OvniParticle.tscn").instantiate()
		particle.global_position = global_position
		particle.z_index = z_index
		get_parent().get_parent().add_child(particle)
	else:
		var particle = preload("res://scenes/ovni_particles/GoodOvniParticle.tscn").instantiate()
		particle.global_position = global_position
		particle.z_index = z_index
		get_parent().get_parent().add_child(particle)
	died.emit(self)
	queue_free()
