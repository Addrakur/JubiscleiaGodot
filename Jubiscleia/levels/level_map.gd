extends Node2D

@export var max_zoom: Vector2
@export var min_zoom: Vector2
@export var zoom_speed: float
@export var cam_speed: float
@onready var camera: PhantomCamera2D = $camera

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			if camera.zoom < max_zoom:
				zoom_camera(zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			if camera.zoom > min_zoom:
				zoom_camera(-zoom_speed)

func zoom_camera(speed: float):
	camera.zoom += Vector2(speed,speed)
