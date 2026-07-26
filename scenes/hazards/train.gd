extends Hazard

var moving = false

@export var speed = 400

func _ready() -> void:
	GameGlobals.is_closed.connect(func():
		moving = true)

func _process(delta: float) -> void:
	if moving:
		global_position.x += scale.x * delta * speed
