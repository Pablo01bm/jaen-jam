extends CharacterBody2D

var SPEED_X = RandomNumberGenerator.new()
var SPEED_Y = RandomNumberGenerator.new()
var RANDOM = RandomNumberGenerator.new()
 
func _ready():
	# We define random movement direction
	SPEED_X = SPEED_X.randf_range(-200.0, 200.0)
	SPEED_Y = SPEED_Y.randf_range(-200.0, 200.0)
	velocity.x = SPEED_X
	velocity.y = SPEED_Y


func _physics_process(delta):
	
	#move_and_collide()
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		print("HOLA")
		velocity = velocity.bounce(collision.get_normal().rotated(RANDOM.randf_range(-10.0, 10.0)))
		
