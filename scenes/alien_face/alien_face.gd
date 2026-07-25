extends Node2D
class_name AlienFace

@export var attributes = [0, 0, 0, 0, 0, 0]
@export var attr_range = [5, 5, 6, 5, 4, 4]
@onready var features = [$Head, $Eyebrows, $Eyes,
$Nose, $Mouth, $Top]

func _ready() -> void:
	randomize_face()

func randomize_face():
	attributes[0] = randf_range(0, attr_range.get(0))
	attributes[1] = randf_range(0, attr_range.get(1))
	attributes[2] = randf_range(0, attr_range.get(2))
	attributes[3] = randf_range(0, attr_range.get(3))
	attributes[4] = randf_range(0, attr_range.get(4))
	attributes[5] = randf_range(0, attr_range.get(5))
	
	$Head.frame = attributes.get(0)
	$Eyebrows.frame = attributes.get(1)
	$Eyes.frame = attributes.get(2)
	$Nose.frame = attributes.get(3)
	$Mouth.frame = attributes.get(4)
	$Top.frame = attributes.get(5)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("rumble"):
		randomize_face()
