extends GameState

func _enter(_previous_state_path: String, _init_data := {}):
	
	var title_screen = preload("res://scenes/title_screen/TitleScreen.tscn").instantiate()
	game.add_child(title_screen)

func _update(_delta):
	if Input.is_action_just_pressed("debug_1"):
		finished.emit(GAMEPLAY)

func _exit():
	#game.remove_current_scene()
	game.get_node("TitleScreen").queue_free()
