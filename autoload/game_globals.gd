extends Node
 
## Orden en el que se juegan los niveles.
const LEVELS := [
	"res://scenes/Level/LevelA/LevelA.tscn",
	"res://scenes/Level/LevelB/LevelB.tscn",
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
signal is_opened 
signal is_closed
 
func reset() -> void:
	current_level_index = 0
	score = 0
