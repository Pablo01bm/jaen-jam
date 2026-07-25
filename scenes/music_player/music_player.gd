extends Node

var killing = false

var tween: Tween

func _ready() -> void:
	$Wanted.play()
	$Kill.play()
	GameGlobals.is_closed.connect(kill)
	GameGlobals.level_finished.connect(level_finished)
	print("ready")


func kill():
	if tween != null:
		tween.kill()
	tween = get_tree().create_tween()
	tween.parallel().tween_property($Kill, "volume_db", 0.0, 0.2)
	tween.parallel().tween_property($Wanted, "volume_db", -80.0, 0.5)
	tween.play()
	$Kill.play()

func level_finished():
	if tween != null:
		tween.kill()
	tween = get_tree().create_tween()
	tween.parallel().tween_property($Kill, "pitch_scale", 0.6, 2.0)
	tween.parallel().tween_property($Kill, "volume_db", -80.0, 2.0)
	tween.play()


func _on_wanted_finished() -> void:
	$Wanted.play()


func _on_kill_finished() -> void:
	$Kill.play()
