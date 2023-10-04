extends Area2D

@export var player: CharacterBody2D
@export var tween_up: bool
@export var tween_right: bool
@export var tween_left: bool
@export var tween_down: bool

func on_body_entered(body):
	if body.is_in_group("player"):
		if tween_up:
			player.camera.tween_up = true
		elif tween_right:
			player.camera.tween_right = true
		elif tween_left:
			player.camera.tween_left = true
		elif tween_down:
			player.camera.tween_down = true

func on_body_exited(body):
	if body.is_in_group("player"):
		if tween_up:
			player.camera.tween_up = false
		elif tween_right:
			player.camera.tween_right = false
		elif tween_left:
			player.camera.tween_left = false
		else:
			player.camera.tween_down = false
