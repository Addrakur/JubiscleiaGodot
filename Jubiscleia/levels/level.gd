class_name Level
extends Node2D

@export var player: Player
@export var free_spawn: bool
@export var has_starting_weapon: bool
@export_enum("sword","axe","spear","gauntlet","none") var weapon_1: String
@export_enum("water","fire","air","earth") var element_1: String
@export_enum("sword","axe","spear","gauntlet","none") var weapon_2: String
@export_enum("water","fire","air","earth") var element_2: String

func _ready():
	GameSettings.player = player
	GameSettings.default_gravity = player.fall_gravity
	if not free_spawn:
		spawn_point()
	
	if has_starting_weapon:
		PlayerVariables.skill_1_weapon = weapon_1
		PlayerVariables.skill_1_element = element_1
		PlayerVariables.skill_2_weapon = weapon_2
		PlayerVariables.skill_2_element = element_2

func spawn_point():
	player.position = GameSettings.get(name + "_spawn_point")

func _input(event):
	if event.is_action_pressed("pause"):
		var current_value: bool = get_tree().paused
		get_tree().paused = !current_value
