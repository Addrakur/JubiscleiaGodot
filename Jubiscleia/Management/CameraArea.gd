extends Area2D

@export var horizontal: bool
@export var camera: PhantomCamera2D
@export var old_cameras: Array[PhantomCamera2D]

func _ready():
	camera.follow_damping = true
	if horizontal:
		camera.follow_damping_value.x = 0.2
	else:
		camera.follow_damping_value.x = 0.25

func _on_body_entered(body):
	if body == GameSettings.player:
		camera.set_priority(10)
		for cameras in old_cameras:
			camera.set_priority(0)
