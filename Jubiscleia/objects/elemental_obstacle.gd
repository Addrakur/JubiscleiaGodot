class_name ElementObstacle
extends Node2D

@onready var parent: Node2D = get_parent()
@onready var animation: AnimationPlayer = $animation

func _ready() -> void:
	animation.play(parent.get("element"))
