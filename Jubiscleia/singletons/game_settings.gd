extends Node

@onready var player: CharacterBody2D

var default_gravity: float

func _ready():
	Engine.max_fps = 60

func _input(event):
	if event.is_action_pressed("pause") or not PlayerVariables.player_alive:
		var current_value: bool = get_tree().paused
		get_tree().paused = !current_value

func change_scene(scene_name:String):
	get_tree().set_pause(false)
	get_tree().change_scene_to_file(scene_name)
