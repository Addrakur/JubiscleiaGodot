extends Node2D

@export var player: CharacterBody2D
@export var camera_polygon: Polygon2D

func _ready():
	GameSettings.player = player
	GameSettings.default_gravity = player.fall_gravity
	PlayerVariables.hit_amount = 0
	PlayerVariables.corruption_level = 0
	player.camera.change_limit_polygon(camera_polygon)
