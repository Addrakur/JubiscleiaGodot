extends Area2D

var current_limit: bool

func on_player_entered(body):
	if body.is_in_group("player"):
		current_limit = true
