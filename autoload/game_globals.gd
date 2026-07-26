extends Node
 
## Orden en el que se juegan los niveles.
const LEVELS := [
	"res://scenes/Level/LevelA/LevelA.tscn",
	"res://scenes/Level/LevelB/LevelB.tscn",
	"res://scenes/Level/LevelC/LevelC.tscn",
	"res://scenes/Level/LevelD/LevelD.tscn",
	"res://scenes/Level/LevelE/LevelE.tscn",
]

const MENUS := [
	"res://scenes/game_over/GameOver.tscn",
	"res://scenes/LevelResults/LevelResults.tscn"
]
 
const GAME_COMPLETED_SCENE := "res://scenes/game_completed/GameCompleted.tscn"
const TITLE_SCREEN := "res://scenes/title_screen/TitleScreen.tscn"
 
var current_level_index: int = 0
var score: float = 0.0

signal shake_camera

var alien_motherfuckers: Array[Alien] = []
var alien_motherfuckers_faces: Array = []
var alien_motherfuckers_names: Array = []


signal is_opened 
signal is_closed

signal level_started
signal level_finished

signal boss_appeared

var high_score: float = 30.0
 
func _ready() -> void:
	var hs: HighScore = ResourceLoader.load("user://high-score.tres", "", ResourceLoader.CACHE_MODE_IGNORE)
	if hs != null:
		print("load record")
		print(hs.score)
		high_score = hs.score


func save_record(face: AlienFace):
	if score < high_score and score > 0.0:
		high_score = score
		var hs = HighScore.new()
		hs.score = score
		hs.face = face.attributes
		ResourceSaver.save(hs, "user://high-score.tres")
		print("score saved")

func get_high_score_face():
	var hs: HighScore = ResourceLoader.load("user://high-score.tres", "", ResourceLoader.CACHE_MODE_IGNORE)
	return hs.face

func reset() -> void:
	current_level_index = 0
	score = 0
