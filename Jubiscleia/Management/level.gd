extends Node2D

@export var player: CharacterBody2D
@export var camera_limits: Array[int]

func _ready() -> void:
	player.camera.change_limit(camera_limits[0], camera_limits[1], camera_limits[2], camera_limits[3])
	pass

func restart() -> void:
	get_tree().reload_current_scene()
