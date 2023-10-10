extends Control

var prototype_level: String = "res://levels/prototype_level.tscn"

func on_play_pressed():
	get_tree().change_scene_to_file(prototype_level)
