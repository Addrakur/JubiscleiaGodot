extends Node

@export var level: Node2D
@onready var camera_limits: Array[int] = level.camera_limits
@onready var player: CharacterBody2D = level.player

func _ready() -> void:
	
	player.camera.change_limit(camera_limits[0], camera_limits[1], camera_limits[2], camera_limits[3])
	pass

func _input(event):
	if event.is_action_pressed("pause"):
		var current_value: bool = get_tree().paused
		get_tree().paused = !current_value
