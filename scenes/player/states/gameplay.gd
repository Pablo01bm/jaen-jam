extends GameState

func _enter(_previous_state_path: String, _init_data := {}):
	
	var gameplay = preload("res://scenes/gameplay/Gameplay.tscn").instantiate()
	game.add_child(gameplay)


func _update(_delta):
	if Input.is_action_just_pressed("debug_1"):
		finished.emit(GAME_OVER)
	if Input.is_action_just_pressed("debug_2"):
		finished.emit(GAME_COMPLETED)


func _exit():
	game.get_node("Gameplay").queue_free()
