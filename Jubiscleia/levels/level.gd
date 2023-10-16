extends Node2D

@export var player: CharacterBody2D
@export var camera_limits: Array[int]

func _ready():
	GameSettings.player = player
	player.camera.change_limit(camera_limits[0], camera_limits[1], camera_limits[2], camera_limits[3])
