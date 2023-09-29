extends Node2D

@onready var camera_bound: Polygon2D = $CameraBounds
@onready var player: CharacterBody2D = $player

func _ready() -> void:
	player.camera_bounds = camera_bound
