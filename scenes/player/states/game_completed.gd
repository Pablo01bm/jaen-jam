extends GameState

func _enter(_previous_state_path: String, _init_data := {}):
	
	var game_completed = preload("res://scenes/game_completed/GameCompleted.tscn").instantiate()
	game.add_child(game_completed)
	get_tree().create_timer(3).timeout.connect(func():
		finished.emit(TITLE_SCREEN)
	)

func _exit():
	game.get_node("GameCompleted").queue_free()
