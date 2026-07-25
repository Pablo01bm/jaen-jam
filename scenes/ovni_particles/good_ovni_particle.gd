extends CharacterBody2D

@export var acceleration = 300

var direction = Vector2.UP

func _ready() -> void:
	direction = direction.rotated(randf_range(-25, 25))
	velocity.y = -200

func _physics_process(delta: float) -> void:
	
	velocity.y += delta * acceleration
	velocity.x = min(velocity.x + delta * acceleration , 100)
	
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$CPUParticles2D.emitting = false
	$CPUParticles2D2.emitting = false
	$Timer.start()


func _on_timer_timeout() -> void:
	queue_free()
