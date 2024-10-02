class_name Level
extends Node2D

@export var player: Player
@export var free_spawn: bool

func _ready():
	GameSettings.player = player
	GameSettings.default_gravity = player.fall_gravity
	if not free_spawn:
		spawn_point()

func spawn_point():
	player.position = GameSettings.get(name + "_spawn_point")
