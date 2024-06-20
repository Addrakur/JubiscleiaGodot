extends Node2D

@export var player: CharacterBody2D

func _ready():
	
	GameSettings.player = player
	GameSettings.default_gravity = player.fall_gravity
	
