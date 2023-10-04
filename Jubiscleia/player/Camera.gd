extends Camera2D

@export var player: CharacterBody2D

func _ready() -> void:
	pass

func change_limit(top_limit: int, left_limit: int, right_limit: int, bottom_limit: int) -> void:
	limit_top = top_limit
	limit_left = left_limit
	limit_right = right_limit
	limit_bottom = bottom_limit

func tween_up_and_down(camera_offset: float, tween_timer: float) -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "offset", Vector2(offset.x,camera_offset), tween_timer)

func tween_left_and_right(camera_offset: float, tween_timer: float) -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "offset", Vector2(camera_offset,offset.y), tween_timer)
	
