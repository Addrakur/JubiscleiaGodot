extends Camera2D

@export var player: CharacterBody2D
@export var camera_offset_x: float
@export var camera_offset_y: float

func _process(_delta):
	if player.is_on_floor():
		pass

func change_limit(top_limit: int, left_limit: int, right_limit: int, bottom_limit: int) -> void:
	limit_top = top_limit
	limit_left = left_limit
	limit_right = right_limit
	limit_bottom = bottom_limit
