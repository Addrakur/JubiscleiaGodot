extends Control

var game: String = "res://levels/game.tscn"

func on_play_pressed():
	get_tree().change_scene_to_file(game)
