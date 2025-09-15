extends StaticBody2D

@export var top_size_y: float
@export var bot_size_y: float
@export var left_size_x: float
@export var right_size_x: float

func _ready() -> void:
	if rotation_degrees == 0 or rotation_degrees > 359:
		top_size_y = -6
		bot_size_y = 0
		left_size_x = 0
		right_size_x = 32
	elif rotation_degrees > 89 and rotation_degrees < 91:
		top_size_y = 0
		bot_size_y = 32
		left_size_x = 0
		right_size_x = 6
	elif rotation_degrees > 179 and rotation_degrees < 181:
		top_size_y = 0
		bot_size_y = 6
		left_size_x = -32
		right_size_x = 0
	else:
		top_size_y = -32
		bot_size_y = 0
		left_size_x = -6
		right_size_x = 0
