extends GameState

func _enter(_previous_state_path: String, _init_data := {}):
	
	var game_over = preload("res://scenes/game_over/GameOver.tscn").instantiate()
	game.add_child(game_over)


func _update(_delta):
	if Input.is_action_just_pressed("debug_1"):
		finished.emit(GAMEPLAY)
	if Input.is_action_just_pressed("debug_2"):
		finished.emit(TITLE_SCREEN)


func _exit():
	game.get_node("GameOver").queue_free()
