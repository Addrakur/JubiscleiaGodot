class_name SlowTimer
extends Timer

var parent: Node2D

func _ready() -> void:
	parent = get_parent()

func _on_timeout() -> void:
	parent.speed = 1
