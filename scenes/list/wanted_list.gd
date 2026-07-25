extends Node2D

@onready var tween: Tween
@export var wanted_aliens = []
@onready var aliens = [%AlienFace1,
%AlienFace2,
%AlienFace3]

var blur = Vector2(4.0, 4.0)

func _ready() -> void:
	for i in range(wanted_aliens.size()):
		aliens.get(i).visible = true

func _process(delta: float) -> void:
	$Mouse.global_position = get_global_mouse_position()


func _on_area_2d_mouse_entered() -> void:
	pass


func _on_area_2d_mouse_exited() -> void:
	pass


func move_up():
	GameGlobals.is_opened.emit()
	
	if tween != null:
		tween.stop()
		tween.kill()
	tween = get_tree().create_tween()
	tween.parallel().tween_property($Sprite2D, "position", Vector2(0.0, 4.0), 0.4)
	tween.parallel().tween_method(set_shader_value, Vector2.ZERO, blur, 0.2)
	tween.set_ease(Tween.EASE_OUT)
	#tween.set_trans(Tween.TRANS_CUBIC)
	tween.play()
	

func move_down():
	GameGlobals.is_closed.emit()
	if tween != null:
		tween.stop()
		tween.kill()
	tween = get_tree().create_tween()
	tween.parallel().tween_property($Sprite2D, "position", Vector2(0.0, 707.0), 0.4)
	tween.parallel().tween_method(set_shader_value, blur, Vector2.ZERO, 0.2)
	tween.set_ease(Tween.EASE_OUT)
	#tween.set_trans(Tween.TRANS_CUBIC)
	tween.play()


func set_shader_value(value: Vector2):
	# in my case i'm tweening a shader on a texture rect, but you can use anything with a material on it
	$Blur.material.set_shader_parameter("blur_size", value)


func _on_area_2d_area_entered(area: Area2D) -> void:
	move_up()


func _on_area_2d_area_exited(area: Area2D) -> void:
	move_down()

func _update_alien_faces() -> void:
	var i = 0
	print("Updating motherfucker hijueputa otra vez corazon de viejita")
	wanted_aliens = GameGlobals.alien_motherfuckers
	print(wanted_aliens.size())
	if wanted_aliens.size() > 0:
		for bad_alien in wanted_aliens:
			$Sprite2D/BadAliens.get_child(i).visible = true
			$Sprite2D/BadAliens.get_child(i).update_face(bad_alien.get_info_array())
			i += 1
	
