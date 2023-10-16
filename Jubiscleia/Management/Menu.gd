extends Control

var level1: String = "res://levels/loop_basico.tscn"
var level2: String = "res://levels/prototype_level.tscn"

func on_level1_pressed():
	GameSettings.change_scene(level1)


func on_level2_pressed():
	GameSettings.change_scene(level2)
