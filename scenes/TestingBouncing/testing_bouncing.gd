extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = preload("res://scenes/TestingAlien/TestingAlien.tscn")
	var instance = scene.instantiate()
	instance.position = Vector2(300, 300)
	
	add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
