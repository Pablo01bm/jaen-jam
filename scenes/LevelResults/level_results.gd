extends Node2D

const ALIEN_FACE_SCENE := preload("res://scenes/alien_face/AlienFace.tscn")

## Idioma pa las fechorías
@export var lang: String = "es"

# Manin esto está pa evitarme hacer la UI que no sé xd
@export var start_y: float = 150.0
@export var row_height: float = 96.0
@export var face_offset_x: float = 0.0
@export var label_offset_x: float = 120.0


func _ready() -> void:
	_fill_soab_aliens_faces()


func _fill_soab_aliens_faces() -> void:
	var defeated: Array = GameGlobals.alien_motherfuckers_faces

	for i in range(defeated.size()):
		_add_result_row(i, defeated[i])
	
	GameGlobals.alien_motherfuckers_faces.clear()


func _add_result_row(index: int, face_signature: Array) -> void:
	var row_y: float = start_y + index * row_height

	var face: Node2D = ALIEN_FACE_SCENE.instantiate()
	add_child(face)
	face.position = Vector2(face_offset_x, row_y)
	face.update_face(face_signature)

	var label := Label.new()
	add_child(label)
	label.position = Vector2(label_offset_x, row_y)
	label.text = CrimeGenerator.generate_crime(lang)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		GameManager._next_level()
