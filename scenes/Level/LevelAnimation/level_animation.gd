extends Node2D


func _ready() -> void:
	var level = GameGlobals.current_level_index + 1
	
	$Label.text = str(level) + "/5"
