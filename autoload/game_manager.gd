extends Node


func register_level(level: Level) -> void:
	if not level.level_completed.is_connected(_on_level_completed):
		level.level_completed.connect(_on_level_completed)


func start_game() -> void:
	GameGlobals.reset()
	get_tree().change_scene_to_file(GameGlobals.LEVELS[0])


func _on_level_completed() -> void:
	GameGlobals.current_level_index += 1

	if GameGlobals.current_level_index >= GameGlobals.LEVELS.size():
		get_tree().change_scene_to_file(GameGlobals.GAME_COMPLETED_SCENE)
	else:
		get_tree().change_scene_to_file(GameGlobals.MENUS.get(1))


func game_over() -> void:
	GameGlobals.alien_motherfuckers_names.clear()
	get_tree().change_scene_to_file(GameGlobals.MENUS.get(0))
	

func _next_level() -> void:
	GameGlobals.alien_motherfuckers.clear()
	GameGlobals.alien_motherfuckers_names.clear()
	var next_level_path: String = GameGlobals.LEVELS[GameGlobals.current_level_index]
	get_tree().change_scene_to_file(next_level_path)

func _go_main_menu() ->void:
	GameGlobals.alien_motherfuckers.clear()
	get_tree().change_scene_to_file(GameGlobals.TITLE_SCREEN)
