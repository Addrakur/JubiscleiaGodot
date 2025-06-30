extends Node2D

@export var level: String

func on_area_end_body_entered(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		GameSettings.set(level + "_cleared", true)
		GameSettings.change_scene(Paths.level_map)
