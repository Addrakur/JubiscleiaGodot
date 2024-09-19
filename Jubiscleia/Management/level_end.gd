extends Node2D


func on_area_end_body_entered(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		GameSettings.change_scene(Paths.menu)
