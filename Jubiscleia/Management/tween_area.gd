extends Area2D

@export var player: CharacterBody2D
@export var offset: float
@export var tween_timer: float
@export var direction: String

func on_body_entered(body):
	if body.is_in_group("player"):
		match direction:
			"up":
				player.camera.tween_up_and_down(offset,tween_timer)
			"down":
				player.camera.tween_up_and_down(offset,tween_timer)
			"left":
				player.camera.tween_left_and_right(offset,tween_timer)
			"right":
				player.camera.tween_left_and_right(offset,tween_timer)
		

func on_body_exited(body):
	if body.is_in_group("player"):
		match direction:
			"up":
				player.camera.tween_up_and_down(0,tween_timer)
			"down":
				player.camera.tween_up_and_down(0,tween_timer)
			"left":
				player.camera.tween_left_and_right(0,tween_timer)
			"right":
				player.camera.tween_left_and_right(0,tween_timer)
