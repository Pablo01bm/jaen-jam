extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = str(GameGlobals.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  Input.is_action_just_pressed("shoot"):
		GameManager._go_main_menu()
