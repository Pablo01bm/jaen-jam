extends Node2D

@onready var tween: Tween
@export var wanted_aliend = []
@onready var aliens = [$Sprite2D/Node2D/AlienFace,
$Sprite2D/Node2D/AlienFace2,
$Sprite2D/Node2D/AlienFace3]

func _ready() -> void:
	for i in range(wanted_aliend.size()):
		aliens.get(i).visible = true

func _process(delta: float) -> void:
	$Mouse.global_position = get_global_mouse_position()


func _on_area_2d_mouse_entered() -> void:
	pass


func _on_area_2d_mouse_exited() -> void:
	pass


func move_up():
	if tween != null:
		tween.stop()
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "position", Vector2(0.0, 4.0), 0.4)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.play()
	

func move_down():
	if tween != null:
		tween.stop()
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "position", Vector2(0.0, 707.0), 0.4)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.play()


func _on_area_2d_area_entered(area: Area2D) -> void:
	move_up()


func _on_area_2d_area_exited(area: Area2D) -> void:
	move_down()
