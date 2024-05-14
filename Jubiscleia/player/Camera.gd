extends Camera2D

@export var player: CharacterBody2D

func _ready() -> void:
	pass

func _process(_delta):
	position = position.round()

func change_limit_polygon(polygon: Polygon2D):
	limit_top = int(polygon.polygon[0].y)
	limit_left = int(polygon.polygon[0].x)
	limit_right = int(polygon.polygon[2].x)
	limit_bottom = int(polygon.polygon[1].y)

func tween_up_and_down(camera_offset: float, tween_timer: float) -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "offset", Vector2(offset.x,camera_offset), tween_timer)

func tween_left_and_right(camera_offset: float, tween_timer: float) -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "offset", Vector2(camera_offset,offset.y), tween_timer)
	
