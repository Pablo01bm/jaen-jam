extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player._prepare_mouse()
	$Player._enable_shooting()
	$Curtain.curtain_up()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  Input.is_action_just_pressed("shoot"):
		$Timer.start()
		$Curtain.curtain_down()


func _on_timer_timeout() -> void:
	GameManager.start_game()
