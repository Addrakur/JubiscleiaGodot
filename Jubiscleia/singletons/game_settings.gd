extends Node

@onready var player: CharacterBody2D
var menu: String = "res://Management/menu.tscn"
var tutorial: String = "res://levels/loop_basico.tscn"
var level1: String = "res://levels/prototype_level.tscn"
var level2: String = "res://levels/level_2.tscn"
var level3: String = "res://levels/level_3.tscn"
var arena: String = "res://levels/arena.tscn"

var default_gravity: float

func _ready():
	Engine.max_fps = 165

func _input(event):
	if event.is_action_pressed("pause") or not PlayerVariables.player_alive:
		var current_value: bool = get_tree().paused
		get_tree().paused = !current_value

func change_scene(scene_name:String):
	get_tree().set_pause(false)
	get_tree().change_scene_to_file(scene_name)
