extends Node2D

@export var player: CharacterBody2D
@export var camera_polygon: Polygon2D

func _ready():
	GameSettings.player = player
	player.camera.change_limit_polygon(camera_polygon)
