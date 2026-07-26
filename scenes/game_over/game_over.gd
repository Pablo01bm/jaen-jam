extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Curtain.curtain_up()
	$Player._prepare_mouse()
	$Player._enable_shooting()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		print("RESTART")
		$Curtain.curtain_down()
		$Timer.start()


func _on_timer_timeout() -> void:
	GameManager._go_main_menu()
