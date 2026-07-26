extends Node2D
class_name Curtain

func curtain_up():
	$AnimationPlayer.play("up")


func curtain_down():
	$AnimationPlayer.play("down")
