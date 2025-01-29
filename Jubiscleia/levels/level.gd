class_name Level
extends Node2D

@export var player: Player
@export var free_spawn: bool
@export var weapon_locked: bool
@export_enum("sword","axe","spear","none") var skill_1: String
@export_enum("sword","axe","spear","none") var skill_2: String

func _ready():
	GameSettings.player = player
	GameSettings.default_gravity = player.fall_gravity
	if not free_spawn:
		spawn_point()
	
	if weapon_locked:
		PlayerVariables.skill_1 = skill_1
		PlayerVariables.skill_2 = skill_2

func spawn_point():
	player.position = GameSettings.get(name + "_spawn_point")
