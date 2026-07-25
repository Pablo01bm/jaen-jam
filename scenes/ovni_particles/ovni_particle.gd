extends Node2D

func _ready() -> void:
	$BodyCenter.restart()
	$BodyRight.restart()
	$BodyLeft.restart()
	$CristalBig.restart()
	$CristalLeft.restart()
	$CristalRight.restart()

func _on_body_center_finished() -> void:
	queue_free()
