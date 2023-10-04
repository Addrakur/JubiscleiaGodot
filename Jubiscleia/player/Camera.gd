extends Camera2D

@export var player: CharacterBody2D
@export var camera_offset_x: float
@export var camera_offset_y: float
@export var tween_timer: float

var tween_up: bool
var tween_right: bool
var tween_left: bool
var tween_down: bool

func _process(_delta):
	if tween_up:
		var tween = create_tween().set_parallel(true)
		tween.tween_property(self, "offset", Vector2(offset.x,camera_offset_y), tween_timer)
	else:
		var tween = create_tween().set_parallel(true)
		tween.tween_property(self, "offset", Vector2(offset.x,0), tween_timer)
	
	if tween_down:
		var tween = create_tween().set_parallel(true)
		tween.tween_property(self, "offset", Vector2(offset.x,-camera_offset_y), tween_timer)
	else:
		var tween = create_tween().set_parallel(true)
		tween.tween_property(self, "offset", Vector2(offset.x,0), tween_timer)
		
	if tween_right:
		var tween = create_tween().set_parallel(true)
		tween.tween_property(self, "offset", Vector2(camera_offset_x,offset.y), tween_timer)
	else:
		var tween = create_tween().set_parallel(true)
		tween.tween_property(self, "offset", Vector2(0,offset.y), tween_timer)
	
	if tween_left:
		var tween = create_tween().set_parallel(true)
		tween.tween_property(self, "offset", Vector2(-camera_offset_x,offset.y), tween_timer)
	else:
		var tween = create_tween().set_parallel(true)
		tween.tween_property(self, "offset", Vector2(0,offset.y), tween_timer)
		

func change_limit(top_limit: int, left_limit: int, right_limit: int, bottom_limit: int) -> void:
	limit_top = top_limit
	limit_left = left_limit
	limit_right = right_limit
	limit_bottom = bottom_limit
