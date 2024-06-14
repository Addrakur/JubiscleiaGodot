extends Area2D

@export var camera: PhantomCamera2D
@export var old_cameras: Array[PhantomCamera2D]

func _on_body_entered(body):
	if body == GameSettings.player:
		camera.set_priority(10)
		for cameras in old_cameras:
			camera.set_priority(0)
