extends Control

func on_play_pressed():
	get_tree().change_scene_to_file("res://levels/prototype_level.tscn")


func on_quit_pressed():
	get_tree().quit()
