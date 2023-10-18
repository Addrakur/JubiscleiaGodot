extends StaticBody2D


func on_area_end_body_entered(body):
	if body.is_in_group("player"):
		GameSettings.change_scene(GameSettings.menu)
