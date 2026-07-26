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
	GameGlobals.score = snapped(GameGlobals.score, 0.1)
	$Time.text = str(GameGlobals.score) + "s"
	$Player._prepare_mouse()
	$Player._enable_shooting()
	$Curtain.curtain_up()


func _fill_soab_aliens_faces() -> void:
	var defeated: Array = GameGlobals.alien_motherfuckers_faces

	for i in range(defeated.size()):
		$Aliens.get_child(i).update_face(defeated[i])
		$Aliens.get_child(i).visible = true
		$Aliens.get_child(i).get_child(7).text = CrimeGenerator.generate_crime(lang, i)
	
	GameGlobals.alien_motherfuckers_faces.clear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		$Timer.start()
		$Curtain.curtain_down()


func _on_results_finished() -> void:
	$Results.play()


func _on_timer_timeout() -> void:
	GameManager._next_level()
