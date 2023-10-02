extends Node2D

@onready var player: CharacterBody2D = $player
@export var camera_bound: Array

func _ready() -> void:
	player.camera.limit_top = camera_bound[0]
	player.camera.limit_left = camera_bound[1]
	player.camera.limit_right = camera_bound[2]
	player.camera.limit_bottom = camera_bound[3]
