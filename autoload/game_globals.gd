extends Node
 
## Orden en el que se juegan los niveles.
const LEVELS := [
	"res://scenes/Level/LevelA/LevelA.tscn",
	"res://scenes/Level/LevelB/LevelB.tscn",
	"res://scenes/Level/LevelC/LevelC.tscn",
]
 
const GAME_COMPLETED_SCENE := ""
const GAME_OVER_SCENE := ""
 
var current_level_index: int = 0
var score: int = 0
 
 
func reset() -> void:
	current_level_index = 0
	score = 0
