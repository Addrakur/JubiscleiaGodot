extends Node

@onready var player: CharacterBody2D
var menu: String = "res://Management/menu.tscn"
var level1: String = "res://levels/loop_basico.tscn"
var level2: String = "res://levels/prototype_level.tscn"
var arena: String = "res://levels/arena.tscn"

var player_alive: bool

func _input(event):
	if event.is_action_pressed("pause"):
		var current_value: bool = get_tree().paused
		get_tree().paused = !current_value

func change_scene(scene_name:String):
	get_tree().change_scene_to_file(scene_name)
