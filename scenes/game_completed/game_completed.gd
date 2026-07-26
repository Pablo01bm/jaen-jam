extends Node2D

var is_record = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GameGlobals.score = snapped(GameGlobals.score, 0.1)
	$Score.text = str(GameGlobals.score) + "s"
	$HighScore.text = str(GameGlobals.high_score) + "s"
	$Curtain.curtain_up()
	$Player._prepare_mouse()
	$Player._enable_shooting()
	is_record = GameGlobals.score < GameGlobals.high_score
	if is_record:
		$Timer.start()
		$AlienFace.visible = true
		$NewRecord.visible = true
		$ClickToSave.visible = true
	var face = GameGlobals.get_high_score_face()
	if !face.is_empty():
		$AlienFace2.update_face(face)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  Input.is_action_just_pressed("shoot") and is_record:
		GameGlobals.save_record($AlienFace)
		$Timer.stop()
		$YourFace.visible = true
		$ClickToSave.visible = false
		$Timer2.start()
		$HighScore.text = str(GameGlobals.score) + "s"
		$AlienFace2.update_face($AlienFace.attributes)


func _on_timer_timeout() -> void:
	$AlienFace.randomize_face()


func _on_timer_2_timeout() -> void:
	GameManager._go_main_menu()
