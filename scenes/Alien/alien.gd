extends CharacterBody2D
class_name Alien

signal died(alien: Alien)

var SPEED_X = RandomNumberGenerator.new()
var SPEED_Y = RandomNumberGenerator.new()
var RANDOM = RandomNumberGenerator.new()
@export var Z_INDEX_VALUE = 0

var is_hijoputa: bool = false

@onready var face = %AlienFace
 
func _ready():
	# We define random movement direction
	SPEED_X = SPEED_X.randf_range(-200.0, 200.0)
	SPEED_Y = SPEED_Y.randf_range(-200.0, 200.0)
	velocity.x = SPEED_X
	velocity.y = SPEED_Y
	z_index = Z_INDEX_VALUE


func _physics_process(delta):
	
	#move_and_collide()
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal().rotated(RANDOM.randf_range(-10.0, 10.0)))
		

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
	die()

func die() -> void:
	died.emit(self)
	queue_free()
