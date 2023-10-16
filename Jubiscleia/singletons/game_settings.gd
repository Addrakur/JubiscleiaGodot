extends Node

@onready var player: CharacterBody2D

func _input(event):
	if event.is_action_pressed("pause"):
		var current_value: bool = get_tree().paused
		get_tree().paused = !current_value

func change_scene(scene_name:String):
	get_tree().change_scene_to_file(scene_name)
