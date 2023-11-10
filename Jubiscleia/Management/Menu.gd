extends Control

func on_level1_pressed():
	GameSettings.change_scene(GameSettings.level1)


func on_level2_pressed():
	GameSettings.change_scene(GameSettings.level2)

func _on_arena_pressed():
	GameSettings.change_scene(GameSettings.arena)

func on_quit_pressed():
	get_tree().quit()
