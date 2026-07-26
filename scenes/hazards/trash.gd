extends Hazard


var types = ["bag", "boot", "can", "wheel"]
var radious = [58.14, 38.01, 42.05, 42.05]

var rot = 0.0

func _ready() -> void:
	var index = randi_range(0, 3)
	$AnimatedSprite2D.play(types.get(index))
	$CollisionShape2D.shape.radius = radious.get(index)
	
	rot = randf_range(-1, 1)


func _process(delta: float) -> void:
	rotate(delta * rot)
